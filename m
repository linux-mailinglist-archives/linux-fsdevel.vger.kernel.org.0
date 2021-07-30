Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB523DBA04
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 16:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239097AbhG3OGL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 10:06:11 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44634 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239013AbhG3OGK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:06:10 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E50312243D;
        Fri, 30 Jul 2021 14:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627653962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k7WY6osdL3kzI8WtGYidMekSaPQZMy3NpPkiI7bG8dY=;
        b=DvPL+4qdhYPN3m8/xO29owC86+WH1MZxRIdjXnDau8Tx+VsKzchVkk0XFggymADiyXn9Vj
        IbD970moLckZVqjMloQoWC2IT0N3kuJ5Z/nYu75gAEt7Bstu0ABkRCzGiLRxVX37OU/5Ro
        /bH7SECXmn3TXdStTj6KWOomhCfLDkY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627653962;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k7WY6osdL3kzI8WtGYidMekSaPQZMy3NpPkiI7bG8dY=;
        b=8dUpkk4qTOr4/g8jHJS9wDAN9YuEpx+IOce2e55yDsmmcYZDEpJcSIpBxzDR52dpLqrGcV
        W25TcRYwCgCL+PDA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id A8F2F13806;
        Fri, 30 Jul 2021 14:06:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 3smNKEoHBGEocgAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Fri, 30 Jul 2021 14:06:02 +0000
Subject: Re: [PATCH V5] mm: compaction: support triggering of proactive
 compaction by user
To:     Charan Teja Reddy <charante@codeaurora.org>,
        akpm@linux-foundation.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com,
        dave.hansen@linux.intel.com, mgorman@techsingularity.net,
        nigupta@nvidia.com, corbet@lwn.net, rppt@kernel.org,
        khalid.aziz@oracle.com, rientjes@google.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        vinmenon@codeaurora.org
References: <1627653207-12317-1-git-send-email-charante@codeaurora.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <8fe4ba65-28e1-02d8-cf4d-74aaa76fe9df@suse.cz>
Date:   Fri, 30 Jul 2021 16:06:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1627653207-12317-1-git-send-email-charante@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/30/21 3:53 PM, Charan Teja Reddy wrote:
> The proactive compaction[1] gets triggered for every 500msec and run
> compaction on the node for COMPACTION_HPAGE_ORDER (usually order-9)
> pages based on the value set to sysctl.compaction_proactiveness.
> Triggering the compaction for every 500msec in search of
> COMPACTION_HPAGE_ORDER pages is not needed for all applications,
> especially on the embedded system usecases which may have few MB's of
> RAM. Enabling the proactive compaction in its state will endup in
> running almost always on such systems.
> 
> Other side, proactive compaction can still be very much useful for
> getting a set of higher order pages in some controllable
> manner(controlled by using the sysctl.compaction_proactiveness). So, on
> systems where enabling the proactive compaction always may proove not
> required, can trigger the same from user space on write to its sysctl
> interface. As an example, say app launcher decide to launch the memory
> heavy application which can be launched fast if it gets more higher
> order pages thus launcher can prepare the system in advance by
> triggering the proactive compaction from userspace.
> 
> This triggering of proactive compaction is done on a write to
> sysctl.compaction_proactiveness by user.
> 
> [1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=facdaa917c4d5a376d09d25865f5a863f906234a
> 
> Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> @@ -2895,9 +2920,16 @@ static int kcompactd(void *p)
>  	while (!kthread_should_stop()) {
>  		unsigned long pflags;
>  
> +		/*
> +		 * Avoid the unnecessary wakeup for proactive compaction
> +		 * when it is disabled.
> +		 */
> +		if (!sysctl_compaction_proactiveness)
> +			timeout = MAX_SCHEDULE_TIMEOUT;

Does this part actually logically belong more to your previous patch that
optimized the deferred timeouts?

>  		trace_mm_compaction_kcompactd_sleep(pgdat->node_id);
>  		if (wait_event_freezable_timeout(pgdat->kcompactd_wait,
> -			kcompactd_work_requested(pgdat), timeout)) {
> +			kcompactd_work_requested(pgdat), timeout) &&
> +			!pgdat->proactive_compact_trigger) {
>  
>  			psi_memstall_enter(&pflags);
>  			kcompactd_do_work(pgdat);
> @@ -2932,6 +2964,8 @@ static int kcompactd(void *p)
>  				timeout =
>  				   default_timeout << COMPACT_MAX_DEFER_SHIFT;
>  		}
> +		if (unlikely(pgdat->proactive_compact_trigger))
> +			pgdat->proactive_compact_trigger = false;
>  	}
>  
>  	return 0;
> 

