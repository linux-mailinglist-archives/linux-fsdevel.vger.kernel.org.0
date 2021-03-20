Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F22F7343032
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Mar 2021 23:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhCTWwG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Mar 2021 18:52:06 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:38645 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229805AbhCTWvp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Mar 2021 18:51:45 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1616280705; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=h/kjQNHZr8syD5KgsFNW5AuVRmt+/DMN0c37FkLXUN4=;
 b=ZBZfP2XDcwHe0Osr4MfazZvTX6izhKaZZtNbyeIHrOyMUCx1d6aJcrfltmTdMYPScXxXqKcD
 ab0tbR3pEpXtRw+3NVoZZbvqgZ1sS/etH2RnvWgQZtHjTCcC+9H8hr2+IGQt5n47nFodz1Bt
 iO/Ls6PkNZN1xKlNUtsfPfR+934=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 60567c7d2b0e10a0ba709b66 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 20 Mar 2021 22:51:41
 GMT
Sender: cgoldswo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3BC6FC43465; Sat, 20 Mar 2021 22:51:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cgoldswo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 61806C433C6;
        Sat, 20 Mar 2021 22:51:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 20 Mar 2021 15:51:40 -0700
From:   Chris Goldsworthy <cgoldswo@codeaurora.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, joaodias@google.com,
        surenb@google.com, mhocko@suse.com, david@redhat.com,
        vbabka@suse.cz, linux-fsdevel@vger.kernel.org,
        oliver.sang@intel.com
Subject: Re: [PATCH v4 3/3] mm: fs: Invalidate BH LRU during page migration
In-Reply-To: <20210320195439.GE3420@casper.infradead.org>
References: <20210319175127.886124-1-minchan@kernel.org>
 <20210319175127.886124-3-minchan@kernel.org>
 <20210320093249.2df740cd139449312211c452@linux-foundation.org>
 <YFYuyS51hpE2gp+f@google.com> <20210320195439.GE3420@casper.infradead.org>
Message-ID: <8a01ba3dc10be8fa9d2cb52687f3f26b@codeaurora.org>
X-Sender: cgoldswo@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021-03-20 12:54, Matthew Wilcox wrote:
> On Sat, Mar 20, 2021 at 10:20:09AM -0700, Minchan Kim wrote:
>> > > Tested-by: Oliver Sang <oliver.sang@intel.com>
>> > > Reported-by: kernel test robot <oliver.sang@intel.com>
>> > > Signed-off-by: Chris Goldsworthy <cgoldswo@codeaurora.org>
>> > > Signed-off-by: Minchan Kim <minchan@kernel.org>
>> >
>> > The signoff chain ordering might mean that Chris was the primary author, but
>> > there is no From:him.  Please clarify?
>> 
>> He tried first version but was diffrent implementation since I
>> changed a lot. That's why I added his SoB even though current
>> implementaion is much different. So, maybe I am primary author?

Hey Minchan, let's have you as the primary author.

> Maybe Chris is Reported-by: ?  And don't forget Laura Abbott as 
> original
> author of the patch Chris submitted.  I think she should be 
> Reported-by:
> as well, since there is no code from either of them in this version of
> the patch.

Yes, let's have a Reported-by: from Laura. We can change my 
Signed-off-by to Reported-by: as well.

-- 
The Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project
