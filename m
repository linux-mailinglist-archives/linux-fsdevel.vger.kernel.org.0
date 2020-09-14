Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972CC268D2A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Sep 2020 16:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgINOQ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Sep 2020 10:16:29 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:53101 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726703AbgINNny (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Sep 2020 09:43:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600091033; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=kvRB7dwvxcbPCJ9NaJff0/whkZVGURVNwXzUtKUEdGI=;
 b=DgzrQ0paj83Vp+oW9mywtS5PLS/3WO6up6kcXB5j0JTIvbJ3rPGM0N6Jk9FuMiMDbCDQXCjQ
 u1xWWrg/AYRPQyA7nIIQkZ8sDWCXxuax+hpjM+SHzbI+iwNNk6HkV52Sb2ziQkgi054H9GN7
 TNx0GNYBDFvtFJgjgx69TfCwQXg=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f5f70fc32925f96e106648e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 14 Sep 2020 13:32:44
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E5D78C433C8; Mon, 14 Sep 2020 13:32:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ppvk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 82941C433CA;
        Mon, 14 Sep 2020 13:32:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 14 Sep 2020 19:02:43 +0530
From:   ppvk@codeaurora.org
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Pradeep P V K <pragalla@qti.qualcomm.com>,
        linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Sahitya Tummala <stummala@codeaurora.org>,
        sayalil@codeaurora.org
Subject: Re: [PATCH V4] fuse: Fix VM_BUG_ON_PAGE issue while accessing zero
 ref count page
In-Reply-To: <CAJfpegtpLoskZDWwZpsEi=L_5jrvr7=xFG9GZJd8dTdJr647ww@mail.gmail.com>
References: <1599553026-11745-1-git-send-email-pragalla@qti.qualcomm.com>
 <CAJfpegunet-5BOG74seeL3Gr=xCSStFznphDnuYPWEisbenPog@mail.gmail.com>
 <0101017478aef256-c8471520-26b1-4b87-a3b8-8266627b704f-000000@us-west-2.amazonses.com>
 <CAJfpegtpLoskZDWwZpsEi=L_5jrvr7=xFG9GZJd8dTdJr647ww@mail.gmail.com>
Message-ID: <a98eb58e0aff49ea0b49db1e90155a2d@codeaurora.org>
X-Sender: ppvk@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-09-14 13:41, Miklos Szeredi wrote:
> On Thu, Sep 10, 2020 at 5:42 PM <ppvk@codeaurora.org> wrote:
>> 
>> On 2020-09-08 16:55, Miklos Szeredi wrote:
>> > On Tue, Sep 8, 2020 at 10:17 AM Pradeep P V K
>> > <pragalla@qti.qualcomm.com> wrote:
>> >>
>> >> From: Pradeep P V K <ppvk@codeaurora.org>
>> >>
>> >> There is a potential race between fuse_abort_conn() and
>> >> fuse_copy_page() as shown below, due to which VM_BUG_ON_PAGE
>> >> crash is observed for accessing a free page.
>> >>
>> >> context#1:                      context#2:
>> >> fuse_dev_do_read()              fuse_abort_conn()
>> >> ->fuse_copy_args()               ->end_requests()
>> >
>> > This shouldn't happen due to FR_LOCKED logic.   Are you seeing this on
>> > an upstream kernel?  Which version?
>> >
>> > Thanks,
>> > Miklos
>> 
>> This is happen just after unlock_request() in fuse_ref_page(). In
>> unlock_request(), it will clear the FR_LOCKED bit.
>> As there is no protection between context#1 & context#2 during
>> unlock_request(), there are chances that it could happen.
> 
> Ah, indeed, I missed that one.
> 
> Similar issue in fuse_try_move_page(), which dereferences oldpage
> after unlock_request().
> 
> Fix for both is to grab a reference to the page from ap->pages[] array
> *before* calling unlock_request().
> 
> Attached untested patch.   Could you please verify that it fixes the 
> bug?
> 
Thanks for the patch. It is an one time issue and bit hard to reproduce 
but still we
will verify the above proposed patch and update the test results here.

Minor comments on the commit text of the proposed patch : This issue was 
originally reported by me and kernel test robot
identified compilation errors on the patch that i submitted.
This confusion might be due to un proper commit text note on "changes 
since v1"

> Thanks,
> Miklos

Thanks and Regards,
Pradeep
