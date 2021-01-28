Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 689C5307E66
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 19:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbhA1SrD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 13:47:03 -0500
Received: from a1.mail.mailgun.net ([198.61.254.60]:14726 "EHLO
        a1.mail.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232385AbhA1Sos (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 13:44:48 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611859449; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=qkpi3fbqm5dKFuJEFGa5UUQIdE1jhMbr07jNEhB5lFY=;
 b=ZhVzADZJAhd4TLJ1o0uItG4FNI87B7Wj3S+PBoNbwKWUkPkKnPEUQtCLS4qUw73u4vdm2THc
 n1udF8fnx+fSsAipbrVtl3fx6gjs8z9H+0wDiIJwADjxi6fXR4pGtpstqFIw3zad8lGaVB4X
 W8R+2ScA64fb3DU3yaqFMgGJeG0=
X-Mailgun-Sending-Ip: 198.61.254.60
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 601305dc91b605c2edb584da (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 28 Jan 2021 18:43:40
 GMT
Sender: cgoldswo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 20E79C43463; Thu, 28 Jan 2021 18:43:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cgoldswo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 03A07C433C6;
        Thu, 28 Jan 2021 18:43:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 28 Jan 2021 10:43:38 -0800
From:   Chris Goldsworthy <cgoldswo@codeaurora.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Laura Abbott <lauraa@codeaurora.org>,
        Minchan Kim <minchan.kim@gmail.com>
Subject: Re: [PATCH v4] fs/buffer.c: Revoke LRU when trying to drop buffers
In-Reply-To: <YBLvoBC1iNmZ7eTD@google.com>
References: <cover.1611642038.git.cgoldswo@codeaurora.org>
 <e8f3e042b902156467a5e978b57c14954213ec59.1611642039.git.cgoldswo@codeaurora.org>
 <YBCexclveGV2KH1G@google.com> <20210127025922.GS308988@casper.infradead.org>
 <4d034ea4228be568db62243bfe238e0d@codeaurora.org>
 <YBLvoBC1iNmZ7eTD@google.com>
Message-ID: <7612b6cda0316ed0775b24bb6174a578@codeaurora.org>
X-Sender: cgoldswo@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021-01-28 09:08, Minchan Kim wrote:
> On Thu, Jan 28, 2021 at 12:28:37AM -0800, Chris Goldsworthy wrote:
>> On 2021-01-26 18:59, Matthew Wilcox wrote:
>> > On Tue, Jan 26, 2021 at 02:59:17PM -0800, Minchan Kim wrote:
>> > > The release buffer_head in LRU is great improvement for migration
>> > > point of view.
>> > >
>> > > A question:
>> 
>> Hey guys,
>> 
>> > > Can't we invalidate(e.g., invalidate_bh_lrus) bh_lru in migrate_prep
>> > > or
>> > > elsewhere when migration found the failure and is about to retry?
>> > >
>> > > Migration has done such a way for other per-cpu stuffs for a long
>> > > time,
>> > > which would be more consistent with others and might be faster
>> > > sometimes
>> > > with reducing IPI calls for page.
>> > Should lru_add_drain_all() also handle draining the buffer lru for all
>> > callers?  A quick survey ...
>> >
>> > invalidate_bdev() already calls invalidate_bh_lrus()
>> > compact_nodes() would probably benefit from the BH LRU being invalidated
>> > POSIX_FADV_DONTNEED would benefit if the underlying filesystem uses BHs
>> > check_and_migrate_cma_pages() would benefit
>> > khugepaged_do_scan() doesn't need it today
>> > scan_get_next_rmap_item() looks like it only works on anon pages (?) so
>> > 	doesn't need it
>> > mem_cgroup_force_empty() probably needs it
>> > mem_cgroup_move_charge() ditto
>> > memfd_wait_for_pins() doesn't need it
>> > shake_page() might benefit
>> > offline_pages() would benefit
>> > alloc_contig_range() would benefit
>> >
>> > Seems like most would benefit and a few won't care.  I think I'd lean
>> > towards having lru_add_drain_all() call invalidate_bh_lrus(), just to
>> > simplify things.
>> 
>> 
>> Doing this sounds like a good idea.  We would still need a call to
>> invalidate_bh_lrus() inside of drop_buffers() in the event that we 
>> find
>> busy buffers, since they can be re-added back into the BH LRU - I 
>> believe
>> it isn't until this point that a BH can't be added back into the BH 
>> LRU,
>> when we acquire the private_lock for the mapping:
>> 
>> https://elixir.bootlin.com/linux/v5.10.10/source/fs/buffer.c#L3240
> 
> I am not sure it's good deal considering IPI overhead per page release
> at worst case.
> 
> A idea is to disable bh_lrus in migrate_prep and enable it when
> migration is done(need to introduce "migrate_done".
> It's similar approach with marking pageblock MIGRATE_ISOLATE to
> disable pcp during the migration.

I'll try creating that mechanism then for the BH LRU, and will come
back with a patch that does the invalidate in lru_add_drain_all().

Thanks Matthew and Minchan for the feedback!

-- 
The Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project
