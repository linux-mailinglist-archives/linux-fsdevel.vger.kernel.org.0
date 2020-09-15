Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA1426A728
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 16:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgIOOet (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 10:34:49 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:64973 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbgIOOee (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:34:34 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600180473; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=0zG5xP8JTssrjjQ1Sdq/gvN+qVLGC5lxvAW1CBJVJqs=;
 b=J92Ws23/SI8hxlEN+pbct1Jl/TmQGbgNiCSFaPPN5KENmSS4f2Me4+T16P8wBT3md8GNBIR1
 5D3NlSqWMHqPJ/hcIbKQ6sf/YaI81NEh2QAfqZ0qi5lpX+wytsqekJEo5XQLwIk4XJk0XksB
 H/dsY91YVp5mdLZW6gX+rv61x/w=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5f60d0e3d3d3df8c393ec8e0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Sep 2020 14:34:11
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6422CC433F1; Tue, 15 Sep 2020 14:34:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ppvk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EAD9FC433CA;
        Tue, 15 Sep 2020 14:34:10 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 15 Sep 2020 20:04:10 +0530
From:   ppvk@codeaurora.org
To:     Matthew Wilcox <willy@infradead.org>
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        stummala@codeaurora.org, sayalil@codeaurora.org
Subject: Re: [PATCH V1] fuse: Remove __GFP_FS flag to avoid allocator
 recursing
In-Reply-To: <20200914140733.GP6583@casper.infradead.org>
References: <1600091775-10639-1-git-send-email-ppvk@codeaurora.org>
 <20200914140733.GP6583@casper.infradead.org>
Message-ID: <9d46a88f68d7e2d0992a513688677bc0@codeaurora.org>
X-Sender: ppvk@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-09-14 19:37, Matthew Wilcox wrote:
> On Mon, Sep 14, 2020 at 07:26:15PM +0530, Pradeep P V K wrote:
>> Process#1(kswapd) held an inode lock and initaited a writeback to free
>> the pages, as the inode superblock is fuse, process#2 forms a fuse
>> request. Process#3 (Fuse daemon threads) while serving process#2 
>> request,
>> it requires memory(pages) and as the system is already running in low
>> memory it ends up in calling try_to_ free_pages(), which might now 
>> call
>> kswapd again, which is already stuck with an inode lock held. Thus 
>> forms
>> a deadlock.
>> 
>> So, remove __GFP_FS flag to avoid allocator recursing into the
>> filesystem that might already held locks.
> 
> This is the wrong way to fix the problem.  The fuse daemon threads 
> should
> have called memalloc_nofs_save() as this prevents them from 
> inadvertently
> tripping over other places where they forgot to use GFP_NOFS (or have
> no way to pass a GFP_NOFS flags argument).

Thanks Matthew for pointing this. I will address this in my next patch 
set.

Thanks and Regards,
Pradeep
