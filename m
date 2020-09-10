Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5455E264F3F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 21:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgIJTjB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 15:39:01 -0400
Received: from a27-18.smtp-out.us-west-2.amazonses.com ([54.240.27.18]:57578
        "EHLO a27-18.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731309AbgIJPmr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 11:42:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599752566;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID;
        bh=a2jST7xM+zr6UtgLcOeuZulnXcNBubpycXzssEyan9s=;
        b=RwJpSGATCUDNLGrQA3JsY2oQ90P8tid1YcynaXT6jc4ji6LmejAArXDcYyHv2GeU
        0/XCyVuH1qeKvapbp4Ln/ZreOlZCnxwadlljI0nqyo7C18vH00RTBMime+IT46R9yhX
        n157RqNxN/ycvOBh1mzPfIuNsrB4iKHT8LRYRHGo=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599752566;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:Feedback-ID;
        bh=a2jST7xM+zr6UtgLcOeuZulnXcNBubpycXzssEyan9s=;
        b=fhZJTG8U7rVCt+OK8aemWLoDBuuyktddDjsy/MoOkJCJ2OKhfxmPIVFvMS4F+X1d
        THI/qJNzXk1tsX2QCkzwQsbbPMHWLkIB3cpakPcJDzrwNVMa66vmWcFX7XlZKVaVXBg
        wWlFxD6XburZr67kzvQnCJ9F6H3h14DH/8EVxiKI=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 10 Sep 2020 15:42:46 +0000
From:   ppvk@codeaurora.org
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Pradeep P V K <pragalla@qti.qualcomm.com>,
        linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Sahitya Tummala <stummala@codeaurora.org>,
        sayalil@codeaurora.org
Subject: Re: [PATCH V4] fuse: Fix VM_BUG_ON_PAGE issue while accessing zero
 ref count page
In-Reply-To: <CAJfpegunet-5BOG74seeL3Gr=xCSStFznphDnuYPWEisbenPog@mail.gmail.com>
References: <1599553026-11745-1-git-send-email-pragalla@qti.qualcomm.com>
 <CAJfpegunet-5BOG74seeL3Gr=xCSStFznphDnuYPWEisbenPog@mail.gmail.com>
Message-ID: <0101017478aef613-5b81c2f0-b17a-425d-bf79-e4ec49b47857-000000@us-west-2.amazonses.com>
X-Sender: ppvk@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
X-SES-Outgoing: 2020.09.10-54.240.27.18
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-09-08 16:55, Miklos Szeredi wrote:
> On Tue, Sep 8, 2020 at 10:17 AM Pradeep P V K 
> <pragalla@qti.qualcomm.com> wrote:
>> 
>> From: Pradeep P V K <ppvk@codeaurora.org>
>> 
>> There is a potential race between fuse_abort_conn() and
>> fuse_copy_page() as shown below, due to which VM_BUG_ON_PAGE
>> crash is observed for accessing a free page.
>> 
>> context#1:                      context#2:
>> fuse_dev_do_read()              fuse_abort_conn()
>> ->fuse_copy_args()               ->end_requests()
> 
> This shouldn't happen due to FR_LOCKED logic.   Are you seeing this on
> an upstream kernel?  Which version?
> 
> Thanks,
> Miklos

This is happen just after unlock_request() in fuse_ref_page(). In 
unlock_request(), it will clear the FR_LOCKED bit.
As there is no protection between context#1 & context#2 during 
unlock_request(), there are chances that it could happen.

The value of request flags under "fuse_req" DS is "1561" and this tells 
FR_PRIVATE bit is set and there by, it adds the request to end_io list 
and free.
This was seen on upstream kernel - v4.19 stable.

Thanks and Regards,
Pradeep
