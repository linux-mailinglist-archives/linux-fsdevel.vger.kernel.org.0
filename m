Return-Path: <linux-fsdevel+bounces-45663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B22DA7A7FA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 18:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C59DD174563
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 16:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC602512D4;
	Thu,  3 Apr 2025 16:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gAcihRh8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TT6TN0jz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gAcihRh8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TT6TN0jz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAD92512C6
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Apr 2025 16:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743697751; cv=none; b=PUASibf0p7GhmZ2NRsvJ0yf2esgsEZl7NVdZxSMjC17CW5ncVFJ+CYv137UFwaZspo/1mO0MQ+UxFBup3OS6uVmxgqlY09h46kJj1vjbdpMJEm9V2E67MmBycLwk9A45Ykv07GJejg+n99oWdHgaLD7s4RUl5uMMxGgKOCoTVL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743697751; c=relaxed/simple;
	bh=KIY8LnB7WAm/BQ1Q2Vw0vdS9UTmNMU0NZZe7fWuFRgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FszpRYsNQX8Ntnc9CQO7jWzIcsM9eu3i/FBbr+nVkwFpWYHVu6cNuu/pbPq0nJnno9/wP227fMI6ctDf1OruYIcoLJ53YVKE0HUyeJZsSyKxKR2qVFm3MOgox6uRYslz6K439ABsRA7dF2lWJ0+MVz8ZcYvcS1mt50Ud4Y/WWLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gAcihRh8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TT6TN0jz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gAcihRh8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TT6TN0jz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2A069211B3;
	Thu,  3 Apr 2025 16:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743697748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q90m6+jZdvic6rFB3YQnFwqWZDa0z8FHkLLvfPDCnCQ=;
	b=gAcihRh8xwK1dDQiaCzHgGZt0a/CMsKsQnWyyAjItw6FHxocfbECPItjb2l6OCLwjxxBPb
	V9dFc84t9NwYJ3bsZBG7bkXBJB75zMSEXHPf0/LP2Tly33tFbqy0B2PjHOlEyAoPs6KVlq
	5AlqOQrVO0ISbnWIYN2SXoPhrk3yknY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743697748;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q90m6+jZdvic6rFB3YQnFwqWZDa0z8FHkLLvfPDCnCQ=;
	b=TT6TN0jz0ZqPVNpsXtnCr2aRVBAkBJggervUKD9j+NC+xDaPj+ymJ748GOUkFNQfKtvwfu
	JJUP3Fnh0tMATCCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gAcihRh8;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=TT6TN0jz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743697748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q90m6+jZdvic6rFB3YQnFwqWZDa0z8FHkLLvfPDCnCQ=;
	b=gAcihRh8xwK1dDQiaCzHgGZt0a/CMsKsQnWyyAjItw6FHxocfbECPItjb2l6OCLwjxxBPb
	V9dFc84t9NwYJ3bsZBG7bkXBJB75zMSEXHPf0/LP2Tly33tFbqy0B2PjHOlEyAoPs6KVlq
	5AlqOQrVO0ISbnWIYN2SXoPhrk3yknY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743697748;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q90m6+jZdvic6rFB3YQnFwqWZDa0z8FHkLLvfPDCnCQ=;
	b=TT6TN0jz0ZqPVNpsXtnCr2aRVBAkBJggervUKD9j+NC+xDaPj+ymJ748GOUkFNQfKtvwfu
	JJUP3Fnh0tMATCCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E6DDC1392A;
	Thu,  3 Apr 2025 16:29:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SyATOFO37me4fAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 03 Apr 2025 16:29:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5F3AFA07E6; Thu,  3 Apr 2025 18:29:07 +0200 (CEST)
Date: Thu, 3 Apr 2025 18:29:07 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, mcgrof@kernel.org, hch@infradead.org, david@fromorbit.com, 
	rafael@kernel.org, djwong@kernel.org, pavel@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Subject: Re: [PATCH v2 3/4] power: freeze filesystems during suspend/resume
Message-ID: <ezkuxt2rcvvj7ws34gvbkscqzbopwrdybq5sohm6zs3rezch5g@7yeuaa7kh5r7>
References: <20250402-work-freeze-v2-0-6719a97b52ac@kernel.org>
 <20250402-work-freeze-v2-3-6719a97b52ac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402-work-freeze-v2-3-6719a97b52ac@kernel.org>
X-Rspamd-Queue-Id: 2A069211B3
X-Spam-Score: -2.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[17];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.cz,kernel.org,hansenpartnership.com,infradead.org,fromorbit.com,redhat.com,gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 02-04-25 16:07:33, Christian Brauner wrote:
> Now all the pieces are in place to actually allow the power subsystem
> to freeze/thaw filesystems during suspend/resume. Filesystems are only
> frozen and thawed if the power subsystem does actually own the freeze.
> 
> We could bubble up errors and fail suspend/resume if the error isn't
> EBUSY (aka it's already frozen) but I don't think that this is worth it.
> Filesystem freezing during suspend/resume is best-effort. If the user
> has 500 ext4 filesystems mounted and 4 fail to freeze for whatever
> reason then we simply skip them.
> 
> What we have now is already a big improvement and let's see how we fare
> with it before making our lives even harder (and uglier) than we have
> to.
> 
> We add a new sysctl know /sys/power/freeze_filesystems that will allow
> userspace to freeze filesystems during suspend/hibernate. For now it
> defaults to off. The thaw logic doesn't require checking whether
> freezing is enabled because the power subsystem exclusively owns frozen
> filesystems for the duration of suspend/hibernate and is able to skip
> filesystems it doesn't need to freeze.
> 
> Also it is technically possible that filesystem
> filesystem_freeze_enabled is true and power freezes the filesystems but
> before freezing all processes another process disables
> filesystem_freeze_enabled. If power were to place the filesystems_thaw()
> call under filesystems_freeze_enabled it would fail to thaw the
> fileystems it frozw. The exclusive holder mechanism makes it possible to
> iterate through the list without any concern making sure that no
> filesystems are left frozen.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good modulo the nesting issue I've mentioned in my comments to patch
1. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/super.c               | 14 ++++++++++----
>  kernel/power/hibernate.c | 16 +++++++++++++++-
>  kernel/power/main.c      | 31 +++++++++++++++++++++++++++++++
>  kernel/power/power.h     |  4 ++++
>  kernel/power/suspend.c   |  7 +++++++
>  5 files changed, 67 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 3ddded4360c6..b4bdbc509dba 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1187,6 +1187,8 @@ static inline bool get_active_super(struct super_block *sb)
>  	return active;
>  }
>  
> +static const char *filesystems_freeze_ptr = "filesystems_freeze";
> +
>  static void filesystems_freeze_callback(struct super_block *sb, void *unused)
>  {
>  	if (!sb->s_op->freeze_fs && !sb->s_op->freeze_super)
> @@ -1196,9 +1198,11 @@ static void filesystems_freeze_callback(struct super_block *sb, void *unused)
>  		return;
>  
>  	if (sb->s_op->freeze_super)
> -		sb->s_op->freeze_super(sb, FREEZE_MAY_NEST | FREEZE_HOLDER_KERNEL, NULL);
> +		sb->s_op->freeze_super(sb, FREEZE_EXCL | FREEZE_HOLDER_KERNEL,
> +				       filesystems_freeze_ptr);
>  	else
> -		freeze_super(sb, FREEZE_MAY_NEST | FREEZE_HOLDER_KERNEL, NULL);
> +		freeze_super(sb, FREEZE_EXCL | FREEZE_HOLDER_KERNEL,
> +			     filesystems_freeze_ptr);
>  
>  	deactivate_super(sb);
>  }
> @@ -1218,9 +1222,11 @@ static void filesystems_thaw_callback(struct super_block *sb, void *unused)
>  		return;
>  
>  	if (sb->s_op->thaw_super)
> -		sb->s_op->thaw_super(sb, FREEZE_MAY_NEST | FREEZE_HOLDER_KERNEL, NULL);
> +		sb->s_op->thaw_super(sb, FREEZE_EXCL | FREEZE_HOLDER_KERNEL,
> +				     filesystems_freeze_ptr);
>  	else
> -		thaw_super(sb, FREEZE_MAY_NEST | FREEZE_HOLDER_KERNEL, NULL);
> +		thaw_super(sb, FREEZE_EXCL | FREEZE_HOLDER_KERNEL,
> +			   filesystems_freeze_ptr);
>  
>  	deactivate_super(sb);
>  }
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 50ec26ea696b..37d733945c59 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -777,6 +777,8 @@ int hibernate(void)
>  		goto Restore;
>  
>  	ksys_sync_helper();
> +	if (filesystem_freeze_enabled)
> +		filesystems_freeze();
>  
>  	error = freeze_processes();
>  	if (error)
> @@ -845,6 +847,7 @@ int hibernate(void)
>  	/* Don't bother checking whether freezer_test_done is true */
>  	freezer_test_done = false;
>   Exit:
> +	filesystems_thaw();
>  	pm_notifier_call_chain(PM_POST_HIBERNATION);
>   Restore:
>  	pm_restore_console();
> @@ -881,6 +884,9 @@ int hibernate_quiet_exec(int (*func)(void *data), void *data)
>  	if (error)
>  		goto restore;
>  
> +	if (filesystem_freeze_enabled)
> +		filesystems_freeze();
> +
>  	error = freeze_processes();
>  	if (error)
>  		goto exit;
> @@ -940,6 +946,7 @@ int hibernate_quiet_exec(int (*func)(void *data), void *data)
>  	thaw_processes();
>  
>  exit:
> +	filesystems_thaw();
>  	pm_notifier_call_chain(PM_POST_HIBERNATION);
>  
>  restore:
> @@ -1028,19 +1035,26 @@ static int software_resume(void)
>  	if (error)
>  		goto Restore;
>  
> +	if (filesystem_freeze_enabled)
> +		filesystems_freeze();
> +
>  	pm_pr_dbg("Preparing processes for hibernation restore.\n");
>  	error = freeze_processes();
> -	if (error)
> +	if (error) {
> +		filesystems_thaw();
>  		goto Close_Finish;
> +	}
>  
>  	error = freeze_kernel_threads();
>  	if (error) {
>  		thaw_processes();
> +		filesystems_thaw();
>  		goto Close_Finish;
>  	}
>  
>  	error = load_image_and_restore();
>  	thaw_processes();
> +	filesystems_thaw();
>   Finish:
>  	pm_notifier_call_chain(PM_POST_RESTORE);
>   Restore:
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 6254814d4817..0b0e76324c43 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -962,6 +962,34 @@ power_attr(pm_freeze_timeout);
>  
>  #endif	/* CONFIG_FREEZER*/
>  
> +#if defined(CONFIG_SUSPEND) || defined(CONFIG_HIBERNATION)
> +bool filesystem_freeze_enabled = false;
> +
> +static ssize_t freeze_filesystems_show(struct kobject *kobj,
> +				       struct kobj_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%d\n", filesystem_freeze_enabled);
> +}
> +
> +static ssize_t freeze_filesystems_store(struct kobject *kobj,
> +					struct kobj_attribute *attr,
> +					const char *buf, size_t n)
> +{
> +	unsigned long val;
> +
> +	if (kstrtoul(buf, 10, &val))
> +		return -EINVAL;
> +
> +	if (val > 1)
> +		return -EINVAL;
> +
> +	filesystem_freeze_enabled = !!val;
> +	return n;
> +}
> +
> +power_attr(freeze_filesystems);
> +#endif /* CONFIG_SUSPEND || CONFIG_HIBERNATION */
> +
>  static struct attribute * g[] = {
>  	&state_attr.attr,
>  #ifdef CONFIG_PM_TRACE
> @@ -991,6 +1019,9 @@ static struct attribute * g[] = {
>  #endif
>  #ifdef CONFIG_FREEZER
>  	&pm_freeze_timeout_attr.attr,
> +#endif
> +#if defined(CONFIG_SUSPEND) || defined(CONFIG_HIBERNATION)
> +	&freeze_filesystems_attr.attr,
>  #endif
>  	NULL,
>  };
> diff --git a/kernel/power/power.h b/kernel/power/power.h
> index c352dea2f67b..2eb81662b8fa 100644
> --- a/kernel/power/power.h
> +++ b/kernel/power/power.h
> @@ -18,6 +18,10 @@ struct swsusp_info {
>  	unsigned long		size;
>  } __aligned(PAGE_SIZE);
>  
> +#if defined(CONFIG_SUSPEND) || defined(CONFIG_HIBERNATION)
> +extern bool filesystem_freeze_enabled;
> +#endif
> +
>  #ifdef CONFIG_HIBERNATION
>  /* kernel/power/snapshot.c */
>  extern void __init hibernate_reserved_size_init(void);
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 8eaec4ab121d..76b141b9aac0 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -30,6 +30,7 @@
>  #include <trace/events/power.h>
>  #include <linux/compiler.h>
>  #include <linux/moduleparam.h>
> +#include <linux/fs.h>
>  
>  #include "power.h"
>  
> @@ -374,6 +375,8 @@ static int suspend_prepare(suspend_state_t state)
>  	if (error)
>  		goto Restore;
>  
> +	if (filesystem_freeze_enabled)
> +		filesystems_freeze();
>  	trace_suspend_resume(TPS("freeze_processes"), 0, true);
>  	error = suspend_freeze_processes();
>  	trace_suspend_resume(TPS("freeze_processes"), 0, false);
> @@ -550,6 +553,7 @@ int suspend_devices_and_enter(suspend_state_t state)
>  static void suspend_finish(void)
>  {
>  	suspend_thaw_processes();
> +	filesystems_thaw();
>  	pm_notifier_call_chain(PM_POST_SUSPEND);
>  	pm_restore_console();
>  }
> @@ -588,6 +592,8 @@ static int enter_state(suspend_state_t state)
>  		ksys_sync_helper();
>  		trace_suspend_resume(TPS("sync_filesystems"), 0, false);
>  	}
> +	if (filesystem_freeze_enabled)
> +		filesystems_freeze();
>  
>  	pm_pr_dbg("Preparing system for sleep (%s)\n", mem_sleep_labels[state]);
>  	pm_suspend_clear_flags();
> @@ -609,6 +615,7 @@ static int enter_state(suspend_state_t state)
>  	pm_pr_dbg("Finishing wakeup.\n");
>  	suspend_finish();
>   Unlock:
> +	filesystems_thaw();
>  	mutex_unlock(&system_transition_mutex);
>  	return error;
>  }
> 
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

