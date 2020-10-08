Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC629286E64
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 08:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgJHGE2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 02:04:28 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:18723 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbgJHGE1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 02:04:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602137067; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=q0WJO/0dJ8BgShdei2F0Ls8cHIZgFMJNnmLdHmZqEgE=;
 b=I//eiam6y2rv6M+oTW+UCIq3wzYntQr/B1wcHYeGMH5ttMghkJ+c+WKfxvP7liv2oxV1HJPy
 Kx1qtCLuwQj/EVvvY8eqXTjmbeQ1qvbC4f6HLqqfV8MYwKO5o+B8X7hLq5ezR9xALwAAcFpH
 1z6/LycLZ4+qtpj+ASC1KtdtKMQ=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5f7eabb5856d9308b5b5ca54 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 08 Oct 2020 06:03:33
 GMT
Sender: ppvk=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D1524C433FF; Thu,  8 Oct 2020 06:03:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ppvk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 251F1C433CB;
        Thu,  8 Oct 2020 06:03:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 08 Oct 2020 11:33:33 +0530
From:   ppvk@codeaurora.org
To:     Matthew Wilcox <willy@infradead.org>
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        stummala@codeaurora.org, sayalil@codeaurora.org
Subject: Re: [PATCH V3] fuse: Remove __GFP_FS flag to avoid allocator
 recursing
In-Reply-To: <077d4fc0e56db4f4433542e9fe971190@codeaurora.org>
References: <1600840675-43691-1-git-send-email-ppvk@codeaurora.org>
 <20200923124914.GO32101@casper.infradead.org>
 <077d4fc0e56db4f4433542e9fe971190@codeaurora.org>
Message-ID: <f5bb26f0b727d78e3fb685b975163d9f@codeaurora.org>
X-Sender: ppvk@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-09-24 20:26, ppvk@codeaurora.org wrote:
> On 2020-09-23 18:19, Matthew Wilcox wrote:
>> On Wed, Sep 23, 2020 at 11:27:55AM +0530, Pradeep P V K wrote:
>>> Changes since V2:
>>> - updated memalloc_nofs_save() to allocation paths that potentially
>>>   can cause deadlock.
>> 
>> That's the exact opposite of what I said to do.  Again, the *THREAD*
>> is the thing which must not block, not the *ALLOCATION*.  So you
>> set this flag *ON THE THREAD*, not *WHEN IT DOES AN ALLOCATION*.
>> If that's not clear, please ask again.
> 
> The fuse threads are created and started in external libfuse userspace
> library functions but not in Kernel. The lowest entry point for these 
> threads
> to enter in kernel is fuse_dev_read()/fuse_dev_splice_read().
> 
> So, can we suppose to use memalloc_nofs_save() from
> external userspace library functions ?
> 
> Even if we used, can you confirm, if the context of 
> memalloc_nofs_save()
> can be persist in kernel ?  (when the thread enters into kernel space).
> 
> Also, i didn't see memalloc_nofs_save() been used/called from any
> external userspace library functions.
> 
> 
> Thanks and Regards,
> Pradeep

Friendly Reminder !!
