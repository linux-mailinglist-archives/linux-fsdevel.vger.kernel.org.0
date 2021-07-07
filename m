Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519B33BE6A7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 12:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbhGGKyD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jul 2021 06:54:03 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49308 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbhGGKyD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jul 2021 06:54:03 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5396D2254C;
        Wed,  7 Jul 2021 10:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625655082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=maXdKleP7ggLLf4xPqbd0Jt6mHBylI9hk0czqeagS6Y=;
        b=QVCJkPfF/pVVYGpNrec+nx7VGlLpuLrmC0wPfAEWuyPxWyBAs8dlIT0QXYFhK4OAf0CZXm
        kYgfzPGsE2AtEVsLeugk0XXT43Gc2EX2VkWEwQ7mouQ2P/XV5OIvDs9bDyA6wF2yqntizu
        nX9I/Yo2UqWa1rWd+cyywoRQDHSCcmw=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 1252213966;
        Wed,  7 Jul 2021 10:51:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id ORupASqH5WDJWgAAGKfGzw
        (envelope-from <nborisov@suse.com>); Wed, 07 Jul 2021 10:51:22 +0000
Subject: Re: [PATCH v2 1/8] btrfs: enable a tracepoint when we fail tickets
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, linux-fsdevel@vger.kernel.org
References: <cover.1624974951.git.josef@toxicpanda.com>
 <196e7895350732ab509b4003427c95fce89b0d9c.1624974951.git.josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <a19d404e-a6e0-5f16-6bb0-7780f230a605@suse.com>
Date:   Wed, 7 Jul 2021 13:51:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <196e7895350732ab509b4003427c95fce89b0d9c.1624974951.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 29.06.21 г. 16:59, Josef Bacik wrote:
> When debugging early enospc problems it was useful to have a tracepoint
> where we failed all tickets so I could check the state of the enospc
> counters at failure time to validate my fixes.  This adds the tracpoint
> so you can easily get that information.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/space-info.c        | 2 ++
>  include/trace/events/btrfs.h | 6 ++++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 392997376a1c..af161eb808a2 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -825,6 +825,8 @@ static bool maybe_fail_all_tickets(struct btrfs_fs_info *fs_info,
>  	struct reserve_ticket *ticket;
>  	u64 tickets_id = space_info->tickets_id;
>  
> +	trace_btrfs_fail_all_tickets(fs_info, space_info);
> +
>  	if (btrfs_test_opt(fs_info, ENOSPC_DEBUG)) {
>  		btrfs_info(fs_info, "cannot satisfy tickets, dumping space info");
>  		__btrfs_dump_space_info(fs_info, space_info);
> diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
> index c7237317a8b9..3d81ba8c37b9 100644
> --- a/include/trace/events/btrfs.h
> +++ b/include/trace/events/btrfs.h
> @@ -2098,6 +2098,12 @@ DEFINE_EVENT(btrfs_dump_space_info, btrfs_done_preemptive_reclaim,
>  	TP_ARGS(fs_info, sinfo)
>  );
>  
> +DEFINE_EVENT(btrfs_dump_space_info, btrfs_fail_all_tickets,
> +	TP_PROTO(const struct btrfs_fs_info *fs_info,
> +		 const struct btrfs_space_info *sinfo),
> +	TP_ARGS(fs_info, sinfo)
> +);

General suggestion for the dump_space_info - it would be good if
ordered_bytes and delalloc_bytes is also dumped in the tracepoint.

> +
>  TRACE_EVENT(btrfs_reserve_ticket,
>  	TP_PROTO(const struct btrfs_fs_info *fs_info, u64 flags, u64 bytes,
>  		 u64 start_ns, int flush, int error),
> 
