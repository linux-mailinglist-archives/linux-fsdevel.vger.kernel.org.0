Return-Path: <linux-fsdevel+bounces-59897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 031EEB3ED3D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 19:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50807189D381
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 17:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CA430F558;
	Mon,  1 Sep 2025 17:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jyThNmLZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ejxyh8TL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jyThNmLZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ejxyh8TL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEC32D5959
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 17:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756747032; cv=none; b=B83ziORlfipUgAEN6Ikrbw6u9qa/6pWt0PzP0YxkqpQ7po3m+J1WduwLQa6hXdn78MOqo2ww8uMu6JXxcqbu3vG2sZkAIiKb2SMa3pj91gPPgezRHvdCVHNPvKDlmp1so/qdbwnsZYOMc+s0FHT8lWAQ1pjExmJmCED7bhxC1Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756747032; c=relaxed/simple;
	bh=ClflZ8qOwHB0WqbY7rMQ5dsb6W480a75STYmB+fYEKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LzQ4WnG90k5dcpLupKCaW4W4UawezhmI6iucdwgP7I8lYp8G3eGo+RP4cPaLBLsxzgBIK3uOYyvFB2x/eESS9PK89W9C6hlD4hAhtjVabRbIEWqEidyRC5k5mphEFzMY7sJScvQPASv0w59I9Vmh0jPkmjK7twdgLdER0rJRmTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jyThNmLZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ejxyh8TL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jyThNmLZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ejxyh8TL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8A4561F38C;
	Mon,  1 Sep 2025 17:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756747028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ib5oxFWlTgIvX9BDarLdlOP68gVpRDd8UpFo0VxcSfQ=;
	b=jyThNmLZvne2S8chS/u9vlz7WkJ6+qVGUwN3Sls3HMs2zicDx8rK0nj5qbmglDIyW6vTe7
	dbLRBxDw47vmdcwKysmMHl/Q1n0MPDWrOjSdaVYCIznlFUxI1vB/QAY1xnREg4WxvkgJjA
	0E6i1OLH9xp3Bv4QEswM7fZa3Hc0zQA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756747028;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ib5oxFWlTgIvX9BDarLdlOP68gVpRDd8UpFo0VxcSfQ=;
	b=Ejxyh8TLpQuWtfaAK6UvAo1nBl7HkTcfAkt3hmBHJZWkU3/bSR8fJfUWK0mu4csRY9hFr/
	Wv3bHCLCG2a1NqCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756747028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ib5oxFWlTgIvX9BDarLdlOP68gVpRDd8UpFo0VxcSfQ=;
	b=jyThNmLZvne2S8chS/u9vlz7WkJ6+qVGUwN3Sls3HMs2zicDx8rK0nj5qbmglDIyW6vTe7
	dbLRBxDw47vmdcwKysmMHl/Q1n0MPDWrOjSdaVYCIznlFUxI1vB/QAY1xnREg4WxvkgJjA
	0E6i1OLH9xp3Bv4QEswM7fZa3Hc0zQA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756747028;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ib5oxFWlTgIvX9BDarLdlOP68gVpRDd8UpFo0VxcSfQ=;
	b=Ejxyh8TLpQuWtfaAK6UvAo1nBl7HkTcfAkt3hmBHJZWkU3/bSR8fJfUWK0mu4csRY9hFr/
	Wv3bHCLCG2a1NqCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A6231378C;
	Mon,  1 Sep 2025 17:17:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hzLaHRTVtWhKBQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 01 Sep 2025 17:17:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B9B4AA099B; Mon,  1 Sep 2025 19:17:07 +0200 (CEST)
Date: Mon, 1 Sep 2025 19:17:07 +0200
From: Jan Kara <jack@suse.cz>
To: brauner@kernel.org
Cc: Xing Guo <higuoxing@gmail.com>, amir73il@gmail.com, jack@suse.cz, 
	jhubbard@nvidia.com, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	miklos@szeredi.hu, shuah@kernel.org, kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] selftests/fs/mount-notify: Fix compilation failure.
Message-ID: <e4aftint6uauii7p5dvnfd2byllwvzu5hjfxwpa3la3pigmae7@ahw76agoljhh>
References: <CAOQ4uxjJHscMEcAahVpbUDcDet7D8xa=X2rLr33femZsCy6t0A@mail.gmail.com>
 <20250813075523.102069-1-higuoxing@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813075523.102069-1-higuoxing@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,nvidia.com,vger.kernel.org,szeredi.hu,kernel.org,intel.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Wed 13-08-25 15:55:23, Xing Guo wrote:
> Commit c6d9775c2066 ("selftests/fs/mount-notify: build with tools include
> dir") introduces the struct __kernel_fsid_t to decouple dependency with
> headers_install.  The commit forgets to define a macro for __kernel_fsid_t
> and it will cause type re-definition issue.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202508110628.65069d92-lkp@intel.com
> Signed-off-by: Xing Guo <higuoxing@gmail.com>
> Acked-by: Amir Goldstein <amir73il@gmail.com>

Christian, quick search didn't find this patch in your tree. Any reason you
didn't pick it up?

								Honza

> ---
>  .../mount-notify/mount-notify_test.c           | 17 ++++++++---------
>  .../mount-notify/mount-notify_test_ns.c        | 18 ++++++++----------
>  2 files changed, 16 insertions(+), 19 deletions(-)
> 
> diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
> index 63ce708d93ed..e4b7c2b457ee 100644
> --- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
> +++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
> @@ -2,6 +2,13 @@
>  // Copyright (c) 2025 Miklos Szeredi <miklos@szeredi.hu>
>  
>  #define _GNU_SOURCE
> +
> +// Needed for linux/fanotify.h
> +typedef struct {
> +	int	val[2];
> +} __kernel_fsid_t;
> +#define __kernel_fsid_t __kernel_fsid_t
> +
>  #include <fcntl.h>
>  #include <sched.h>
>  #include <stdio.h>
> @@ -10,20 +17,12 @@
>  #include <sys/mount.h>
>  #include <unistd.h>
>  #include <sys/syscall.h>
> +#include <sys/fanotify.h>
>  
>  #include "../../kselftest_harness.h"
>  #include "../statmount/statmount.h"
>  #include "../utils.h"
>  
> -// Needed for linux/fanotify.h
> -#ifndef __kernel_fsid_t
> -typedef struct {
> -	int	val[2];
> -} __kernel_fsid_t;
> -#endif
> -
> -#include <sys/fanotify.h>
> -
>  static const char root_mntpoint_templ[] = "/tmp/mount-notify_test_root.XXXXXX";
>  
>  static const int mark_cmds[] = {
> diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
> index 090a5ca65004..9f57ca46e3af 100644
> --- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
> +++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
> @@ -2,6 +2,13 @@
>  // Copyright (c) 2025 Miklos Szeredi <miklos@szeredi.hu>
>  
>  #define _GNU_SOURCE
> +
> +// Needed for linux/fanotify.h
> +typedef struct {
> +	int	val[2];
> +} __kernel_fsid_t;
> +#define __kernel_fsid_t __kernel_fsid_t
> +
>  #include <fcntl.h>
>  #include <sched.h>
>  #include <stdio.h>
> @@ -10,21 +17,12 @@
>  #include <sys/mount.h>
>  #include <unistd.h>
>  #include <sys/syscall.h>
> +#include <sys/fanotify.h>
>  
>  #include "../../kselftest_harness.h"
> -#include "../../pidfd/pidfd.h"
>  #include "../statmount/statmount.h"
>  #include "../utils.h"
>  
> -// Needed for linux/fanotify.h
> -#ifndef __kernel_fsid_t
> -typedef struct {
> -	int	val[2];
> -} __kernel_fsid_t;
> -#endif
> -
> -#include <sys/fanotify.h>
> -
>  static const char root_mntpoint_templ[] = "/tmp/mount-notify_test_root.XXXXXX";
>  
>  static const int mark_types[] = {
> -- 
> 2.50.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

