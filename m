Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C145277470
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Sep 2020 16:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgIXO5F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 10:57:05 -0400
Received: from z5.mailgun.us ([104.130.96.5]:52709 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728126AbgIXO5E (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 10:57:04 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600959424; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=5QLYvTsk6aqt+yagLxXD4/QTJAabt3W+YKZyiH4jDqg=;
 b=WyzcmxCdDBqW5MzVQhYhNVkp0X9qmDRKIwTaehVKscKX4DmYFIGkVi+8d3kkTHbRDwJMi94+
 /2jryd0phZpvAfjRmRMEYWAL2UmTjb+MMpzjFjo/7uHysOVrk+8g/Pf1Xd9t0pQ28LUgkb2Y
 UeTly4xEUboWDheeO0Jsh1OeGXw=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5f6cb3951dcd99b9f2c414b2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 24 Sep 2020 14:56:21
 GMT
Sender: ppvk=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A7A65C433F1; Thu, 24 Sep 2020 14:56:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ppvk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3B106C433CB;
        Thu, 24 Sep 2020 14:56:21 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 24 Sep 2020 20:26:21 +0530
From:   ppvk@codeaurora.org
To:     Matthew Wilcox <willy@infradead.org>
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        stummala@codeaurora.org, sayalil@codeaurora.org
Subject: Re: [PATCH V3] fuse: Remove __GFP_FS flag to avoid allocator
 recursing
In-Reply-To: <20200923124914.GO32101@casper.infradead.org>
References: <1600840675-43691-1-git-send-email-ppvk@codeaurora.org>
 <20200923124914.GO32101@casper.infradead.org>
Message-ID: <077d4fc0e56db4f4433542e9fe971190@codeaurora.org>
X-Sender: ppvk@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-09-23 18:19, Matthew Wilcox wrote:
> On Wed, Sep 23, 2020 at 11:27:55AM +0530, Pradeep P V K wrote:
>> Changes since V2:
>> - updated memalloc_nofs_save() to allocation paths that potentially
>>   can cause deadlock.
> 
> That's the exact opposite of what I said to do.  Again, the *THREAD*
> is the thing which must not block, not the *ALLOCATION*.  So you
> set this flag *ON THE THREAD*, not *WHEN IT DOES AN ALLOCATION*.
> If that's not clear, please ask again.

The fuse threads are created and started in external libfuse userspace
library functions but not in Kernel. The lowest entry point for these 
threads
to enter in kernel is fuse_dev_read()/fuse_dev_splice_read().

So, can we suppose to use memalloc_nofs_save() from
external userspace library functions ?

Even if we used, can you confirm, if the context of memalloc_nofs_save()
can be persist in kernel ?  (when the thread enters into kernel space).

Also, i didn't see memalloc_nofs_save() been used/called from any
external userspace library functions.


Thanks and Regards,
Pradeep
