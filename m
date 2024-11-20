Return-Path: <linux-fsdevel+bounces-35335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DEC9D4029
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 17:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05D08B36DCF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 15:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF041531D5;
	Wed, 20 Nov 2024 15:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JaYUmmbs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HUqdD94n";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JaYUmmbs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HUqdD94n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4F615099D;
	Wed, 20 Nov 2024 15:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732117994; cv=none; b=a2mL5u+0zeLQrIdNR0yvqd/T1GdL8xUvC7DRNnHKGjRxtOxsdXgd5kE9fJ+eQGF8w0debhbRTTCKF/EiPLf2jYACGkhRmxznwIyvplgeb8T54XPluWpViCfH0AeRvSJ45begFX0AHIZn7BUr4/uIOa8DO1j1wIFm2nUBRSXVAno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732117994; c=relaxed/simple;
	bh=jns1DBFkSE0zzejhAfuA5S6U1x3T1a77sUXWsiftzKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LI+oA+dtlb67rlPCo7PzD0+kjw5C2Lp+sM1waZ/mqhnUxfKwANJyKDXdjdoKT3ctX3VeaEelgu05EiO0kemEgF8oc7luTgbYavaHdJxHsxh16TtWVYRXKQOFlEaTcWHAdBqO3G8dRCk5DrBSvGDk5sNq2ODhdw4AP7P00PG0hF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JaYUmmbs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HUqdD94n; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JaYUmmbs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HUqdD94n; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 25EFF1F79B;
	Wed, 20 Nov 2024 15:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732117990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cUE17i4NjRRS9xF6ZGmKI9ElNGRKRlw1EV2n76eGf94=;
	b=JaYUmmbsLL0KHavUnz/VjTpmfWbyjVAW/QXMu/hR1vnM0JbWB4VO+62bnIWnqlZICJm4cU
	1FyuzvlZ7ViZ3eXCCUQ+tUmHqN0TzRq0Nw2fZ+gRtpwxL6hH+4e6UMITgjjI53AapUzlSW
	TnSoTuIMDAc4LuSThpRdK8mOn8jKCIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732117990;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cUE17i4NjRRS9xF6ZGmKI9ElNGRKRlw1EV2n76eGf94=;
	b=HUqdD94nSoR9gFep6avivM3P0fK/ZSPNLgmEn7aN+plGxU1pWLp8QL39BgB1bFfcvv5n6p
	CBsvZEeTWD7V3nAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JaYUmmbs;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=HUqdD94n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732117990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cUE17i4NjRRS9xF6ZGmKI9ElNGRKRlw1EV2n76eGf94=;
	b=JaYUmmbsLL0KHavUnz/VjTpmfWbyjVAW/QXMu/hR1vnM0JbWB4VO+62bnIWnqlZICJm4cU
	1FyuzvlZ7ViZ3eXCCUQ+tUmHqN0TzRq0Nw2fZ+gRtpwxL6hH+4e6UMITgjjI53AapUzlSW
	TnSoTuIMDAc4LuSThpRdK8mOn8jKCIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732117990;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cUE17i4NjRRS9xF6ZGmKI9ElNGRKRlw1EV2n76eGf94=;
	b=HUqdD94nSoR9gFep6avivM3P0fK/ZSPNLgmEn7aN+plGxU1pWLp8QL39BgB1bFfcvv5n6p
	CBsvZEeTWD7V3nAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 199BC13297;
	Wed, 20 Nov 2024 15:53:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EHc8BuYFPmdgSwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 20 Nov 2024 15:53:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C75C8A08A2; Wed, 20 Nov 2024 16:53:09 +0100 (CET)
Date: Wed, 20 Nov 2024 16:53:09 +0100
From: Jan Kara <jack@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	amir73il@gmail.com, brauner@kernel.org,
	torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v8 02/19] fsnotify: opt-in for permission events at file
 open time
Message-ID: <20241120155309.lecjqqhohgcgyrkf@quack3>
References: <cover.1731684329.git.josef@toxicpanda.com>
 <5ea5f8e283d1edb55aa79c35187bfe344056af14.1731684329.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ea5f8e283d1edb55aa79c35187bfe344056af14.1731684329.git.josef@toxicpanda.com>
X-Rspamd-Queue-Id: 25EFF1F79B
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,vger.kernel.org,suse.cz,gmail.com,kernel.org,linux-foundation.org,zeniv.linux.org.uk,kvack.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 15-11-24 10:30:15, Josef Bacik wrote:
> From: Amir Goldstein <amir73il@gmail.com>
> 
> Legacy inotify/fanotify listeners can add watches for events on inode,
> parent or mount and expect to get events (e.g. FS_MODIFY) on files that
> were already open at the time of setting up the watches.
> 
> fanotify permission events are typically used by Anti-malware sofware,
> that is watching the entire mount and it is not common to have more that
> one Anti-malware engine installed on a system.
> 
> To reduce the overhead of the fsnotify_file_perm() hooks on every file
> access, relax the semantics of the legacy FAN_ACCESS_PERM event to generate
> events only if there were *any* permission event listeners on the
> filesystem at the time that the file was opened.
> 
> The new semantic is implemented by extending the FMODE_NONOTIFY bit into
> two FMODE_NONOTIFY_* bits, that are used to store a mode for which of the
> events types to report.
> 
> This is going to apply to the new fanotify pre-content events in order
> to reduce the cost of the new pre-content event vfs hooks.
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Link: https://lore.kernel.org/linux-fsdevel/CAHk-=wj8L=mtcRTi=NECHMGfZQgXOp_uix1YVh04fEmrKaMnXA@mail.gmail.com/
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

FWIW I've ended up somewhat massaging this patch (see below).

> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 23bd058576b1..8e5c783013d2 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -173,13 +173,14 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
>  
>  #define	FMODE_NOREUSE		((__force fmode_t)(1 << 23))
>  
> -/* FMODE_* bit 24 */
> -
>  /* File is embedded in backing_file object */
> -#define FMODE_BACKING		((__force fmode_t)(1 << 25))
> +#define FMODE_BACKING		((__force fmode_t)(1 << 24))
>  
> -/* File was opened by fanotify and shouldn't generate fanotify events */
> -#define FMODE_NONOTIFY		((__force fmode_t)(1 << 26))
> +/* File shouldn't generate fanotify pre-content events */
> +#define FMODE_NONOTIFY_HSM	((__force fmode_t)(1 << 25))
> +
> +/* File shouldn't generate fanotify permission events */
> +#define FMODE_NONOTIFY_PERM	((__force fmode_t)(1 << 26))

Firstly, I've kept FMODE_NONOTIFY to stay a single bit instead of two bit
constant. I've seen too many bugs caused by people expecting the constant
has a single bit set when it actually had more in my life. So I've ended up
with:

+/*
+ * Together with FMODE_NONOTIFY_PERM defines which fsnotify events shouldn't be
+ * generated (see below)
+ */
+#define FMODE_NONOTIFY         ((__force fmode_t)(1 << 25))
+ 
+/*
+ * Together with FMODE_NONOTIFY defines which fsnotify events shouldn't be
+ * generated (see below)
+ */
+#define FMODE_NONOTIFY_PERM    ((__force fmode_t)(1 << 26))

and

+/*
+ * The two FMODE_NONOTIFY* define which fsnotify events should not be generated
+ * for a file. These are the possible values of (f->f_mode &
+ * FMODE_FSNOTIFY_MASK) and their meaning:
+ *
+ * FMODE_NONOTIFY - suppress all (incl. non-permission) events.
+ * FMODE_NONOTIFY_PERM - suppress permission (incl. pre-content) events.
+ * FMODE_NONOTIFY | FMODE_NONOTIFY_PERM - suppress only pre-content events.
+ */
+#define FMODE_FSNOTIFY_MASK \
+       (FMODE_NONOTIFY | FMODE_NONOTIFY_PERM)
+
+#define FMODE_FSNOTIFY_NONE(mode) \
+       ((mode & FMODE_FSNOTIFY_MASK) == FMODE_NONOTIFY)
+#define FMODE_FSNOTIFY_PERM(mode) \
+       (!(mode & FMODE_NONOTIFY_PERM))
+#define FMODE_FSNOTIFY_HSM(mode) \
+       ((mode & FMODE_FSNOTIFY_MASK) == 0)

Also I've moved file_set_fsnotify_mode() out of line into fsnotify.c. The
function gets quite big and the call is not IMO so expensive to warrant
inlining. Furthermore it saves exporting some fsnotify internals to modules
(in later patches).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

