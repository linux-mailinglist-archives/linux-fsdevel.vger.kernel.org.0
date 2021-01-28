Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 613B3307175
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 09:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbhA1I3g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 03:29:36 -0500
Received: from m42-8.mailgun.net ([69.72.42.8]:17868 "EHLO m42-8.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231408AbhA1I3d (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 03:29:33 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611822549; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=MbkdEBTiLbx2Jy1T3KIYQ0dnm89j4PVd4XxznmeHnOs=;
 b=chQ9HA/rUkASdlz4okAe2i9GQfWpdUXh9ewwoq5zITCOLUGrbtPL46ep1pWvi9A8pZttvlWu
 BXTjK2yYtb9Dn9IBpH7/P3y54VVro3AY5y7fIIkYjT8JfOZDSus9w4wPNBpINkva9q5kZGcK
 Yzj7oPh/q6o6FaLIhsSQDd4DyZE=
X-Mailgun-Sending-Ip: 69.72.42.8
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 601275b7e325600642851a42 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 28 Jan 2021 08:28:39
 GMT
Sender: cgoldswo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 76A01C43465; Thu, 28 Jan 2021 08:28:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cgoldswo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3B5AFC433C6;
        Thu, 28 Jan 2021 08:28:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 28 Jan 2021 00:28:37 -0800
From:   Chris Goldsworthy <cgoldswo@codeaurora.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Minchan Kim <minchan@kernel.org>, viro@zeniv.linux.org.uk,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Laura Abbott <lauraa@codeaurora.org>
Subject: Re: [PATCH v4] fs/buffer.c: Revoke LRU when trying to drop buffers
In-Reply-To: <20210127025922.GS308988@casper.infradead.org>
References: <cover.1611642038.git.cgoldswo@codeaurora.org>
 <e8f3e042b902156467a5e978b57c14954213ec59.1611642039.git.cgoldswo@codeaurora.org>
 <YBCexclveGV2KH1G@google.com> <20210127025922.GS308988@casper.infradead.org>
Message-ID: <4d034ea4228be568db62243bfe238e0d@codeaurora.org>
X-Sender: cgoldswo@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021-01-26 18:59, Matthew Wilcox wrote:
> On Tue, Jan 26, 2021 at 02:59:17PM -0800, Minchan Kim wrote:
>> The release buffer_head in LRU is great improvement for migration
>> point of view.
>> 
>> A question:

Hey guys,

>> Can't we invalidate(e.g., invalidate_bh_lrus) bh_lru in migrate_prep 
>> or
>> elsewhere when migration found the failure and is about to retry?
>> 
>> Migration has done such a way for other per-cpu stuffs for a long 
>> time,
>> which would be more consistent with others and might be faster 
>> sometimes
>> with reducing IPI calls for page.
> Should lru_add_drain_all() also handle draining the buffer lru for all
> callers?  A quick survey ...
> 
> invalidate_bdev() already calls invalidate_bh_lrus()
> compact_nodes() would probably benefit from the BH LRU being 
> invalidated
> POSIX_FADV_DONTNEED would benefit if the underlying filesystem uses BHs
> check_and_migrate_cma_pages() would benefit
> khugepaged_do_scan() doesn't need it today
> scan_get_next_rmap_item() looks like it only works on anon pages (?) so
> 	doesn't need it
> mem_cgroup_force_empty() probably needs it
> mem_cgroup_move_charge() ditto
> memfd_wait_for_pins() doesn't need it
> shake_page() might benefit
> offline_pages() would benefit
> alloc_contig_range() would benefit
> 
> Seems like most would benefit and a few won't care.  I think I'd lean
> towards having lru_add_drain_all() call invalidate_bh_lrus(), just to
> simplify things.


Doing this sounds like a good idea.  We would still need a call to
invalidate_bh_lrus() inside of drop_buffers() in the event that we find
busy buffers, since they can be re-added back into the BH LRU - I 
believe
it isn't until this point that a BH can't be added back into the BH LRU,
when we acquire the private_lock for the mapping:

https://elixir.bootlin.com/linux/v5.10.10/source/fs/buffer.c#L3240

Thanks,

Chris.

-- 
The Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project
