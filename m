Return-Path: <linux-fsdevel+bounces-16429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B114689D639
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 12:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2FE0286E83
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 10:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB84085636;
	Tue,  9 Apr 2024 10:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QpxTIhDt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OCqlZqtL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GPpdPxYJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tIC7IodM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB8D84D0B;
	Tue,  9 Apr 2024 10:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712657089; cv=none; b=Nb841vi2gH2gifKSWasT8qaasodU/VCmzgBDl37H8k0QMYI/X4YlGEvz6mRD0djK1dD5M5xyUWIfId1lXSRV4XOpTLFawmBvYG4Iv5VUKbvS+sX3VrzSHQ45tLVkxff+l7aFVH7BVM7oPOOULzJl8l/YygJUU0RbKkmkm5bozaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712657089; c=relaxed/simple;
	bh=+iPmHtcImvtW6IqXioOMsqfoQt2JXrOdUDQYN63snAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sDtY70NO9F3XkGnzkQC0Eay0QIb1RYRk7zI2lJ4MJtUWndF+MAr3uwk3W6TbafrEXTDc2E9zQ9+SRJbCT31p/o+fySQ6o8A+uhWS0TSB9t8FKZZ0I3pWRycWoaVBjn2ur3v6UMm4FJkuvVCkH1XcWi1O2h5xAMIQmmobxaxZ6N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QpxTIhDt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OCqlZqtL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GPpdPxYJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tIC7IodM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BC46B20908;
	Tue,  9 Apr 2024 10:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712657085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ASpL9uNaUJ10yu+g9vnm6Z94tCIiSq4W9LyW5vTRoyA=;
	b=QpxTIhDt7WGtsOMuQWJly4cmnaxSny0hrcf1pBcyma38lnPustUixrf8ZXFlBF9jTJsnpa
	pEWF6BlNdQBo9kwuTtBt9sc/nmYtEQYhN9JwdwL4dnRfRfgClefGPfKCf0/yENw95YX2it
	SAXB6hzxySUQMl7cPShJ0LQIEIgHdMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712657085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ASpL9uNaUJ10yu+g9vnm6Z94tCIiSq4W9LyW5vTRoyA=;
	b=OCqlZqtLDmihuS5NtUAfIAT43VrVfKw1RL87+GeFd1knEREDFGS++KODPTVS9lvKGimqGD
	V6RLzZs/SebRfeBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712657083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ASpL9uNaUJ10yu+g9vnm6Z94tCIiSq4W9LyW5vTRoyA=;
	b=GPpdPxYJy+AfDkzoWoFbVUVKFGw9K6VsbWSH9wF7iphfGie2/wV0LrHwFh9kgVaRfDrKZY
	nfzB+bqlOiaaxzuEUUK3K7b403S0AiIaFUde4x65M520XDTXp7XfZC9ooec/2QYirJFxUL
	6ga0zIFacusPMVWRAW8LPM7sv+MLMIw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712657083;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ASpL9uNaUJ10yu+g9vnm6Z94tCIiSq4W9LyW5vTRoyA=;
	b=tIC7IodM91hqcE7HWZZgEG2W5sQt7+0DTH9GSPageEcpmaKnbjpd2ZmHts1eGsGBMnlW0R
	O242786Qq5Z96MCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id AF61813253;
	Tue,  9 Apr 2024 10:04:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id o67MKrsSFWb+TQAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 09 Apr 2024 10:04:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 54669A0814; Tue,  9 Apr 2024 12:04:39 +0200 (CEST)
Date: Tue, 9 Apr 2024 12:04:39 +0200
From: Jan Kara <jack@suse.cz>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/9] tools/include: Sync uapi/linux/fs.h with the kernel
 sources
Message-ID: <20240409100439.mal6tpxdvhphoyrp@quack3>
References: <20240408185520.1550865-1-namhyung@kernel.org>
 <20240408185520.1550865-3-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408185520.1550865-3-namhyung@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,linux.org.uk:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Mon 08-04-24 11:55:13, Namhyung Kim wrote:
> To pick up the changes from:
> 
>   41bcbe59c3b3f ("fs: FS_IOC_GETUUID")
>   ae8c511757304 ("fs: add FS_IOC_GETFSSYSFSPATH")
>   73fa7547c70b3 ("vfs: add RWF_NOAPPEND flag for pwritev2")
> 
> This should be used to beautify fs syscall arguments and it addresses
> these tools/perf build warnings:
> 
>   Warning: Kernel ABI header differences:
>     diff -u tools/include/uapi/linux/fs.h include/uapi/linux/fs.h
> 
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Makes sense. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  tools/include/uapi/linux/fs.h | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/include/uapi/linux/fs.h b/tools/include/uapi/linux/fs.h
> index 48ad69f7722e..45e4e64fd664 100644
> --- a/tools/include/uapi/linux/fs.h
> +++ b/tools/include/uapi/linux/fs.h
> @@ -64,6 +64,24 @@ struct fstrim_range {
>  	__u64 minlen;
>  };
>  
> +/*
> + * We include a length field because some filesystems (vfat) have an identifier
> + * that we do want to expose as a UUID, but doesn't have the standard length.
> + *
> + * We use a fixed size buffer beacuse this interface will, by fiat, never
> + * support "UUIDs" longer than 16 bytes; we don't want to force all downstream
> + * users to have to deal with that.
> + */
> +struct fsuuid2 {
> +	__u8	len;
> +	__u8	uuid[16];
> +};
> +
> +struct fs_sysfs_path {
> +	__u8			len;
> +	__u8			name[128];
> +};
> +
>  /* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl definitions */
>  #define FILE_DEDUPE_RANGE_SAME		0
>  #define FILE_DEDUPE_RANGE_DIFFERS	1
> @@ -215,6 +233,13 @@ struct fsxattr {
>  #define FS_IOC_FSSETXATTR		_IOW('X', 32, struct fsxattr)
>  #define FS_IOC_GETFSLABEL		_IOR(0x94, 49, char[FSLABEL_MAX])
>  #define FS_IOC_SETFSLABEL		_IOW(0x94, 50, char[FSLABEL_MAX])
> +/* Returns the external filesystem UUID, the same one blkid returns */
> +#define FS_IOC_GETFSUUID		_IOR(0x15, 0, struct fsuuid2)
> +/*
> + * Returns the path component under /sys/fs/ that refers to this filesystem;
> + * also /sys/kernel/debug/ for filesystems with debugfs exports
> + */
> +#define FS_IOC_GETFSSYSFSPATH		_IOR(0x15, 1, struct fs_sysfs_path)
>  
>  /*
>   * Inode flags (FS_IOC_GETFLAGS / FS_IOC_SETFLAGS)
> @@ -301,9 +326,12 @@ typedef int __bitwise __kernel_rwf_t;
>  /* per-IO O_APPEND */
>  #define RWF_APPEND	((__force __kernel_rwf_t)0x00000010)
>  
> +/* per-IO negation of O_APPEND */
> +#define RWF_NOAPPEND	((__force __kernel_rwf_t)0x00000020)
> +
>  /* mask of flags supported by the kernel */
>  #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
> -			 RWF_APPEND)
> +			 RWF_APPEND | RWF_NOAPPEND)
>  
>  /* Pagemap ioctl */
>  #define PAGEMAP_SCAN	_IOWR('f', 16, struct pm_scan_arg)
> -- 
> 2.44.0.478.gd926399ef9-goog
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

