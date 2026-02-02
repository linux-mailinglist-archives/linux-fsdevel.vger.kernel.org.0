Return-Path: <linux-fsdevel+bounces-76114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBj6JMIogWkwEgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 23:44:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF521D262F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 23:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15D36315BEB4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 22:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCA038E111;
	Mon,  2 Feb 2026 22:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwDrIUW2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F0238E107;
	Mon,  2 Feb 2026 22:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770071818; cv=none; b=PBbZtLJj5aP7urlSkcOY6pS91iZWxdSTC+TFdPMVw4zbuM84fPUcp3wyjH90AOmAy85xdHsQj/jqH6ehoIrlzYPgm4vjb/m1xS1l1//0NhcSTQHXSn1mnD9r3sEwjNpwslSQZ9UesYeML0OT0sUwTKS0TNMBrvyIKf2r+ockUic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770071818; c=relaxed/simple;
	bh=5MJVPCVbmtzuCZwL83PoTDuizJyOCLSnPH7N+xyLpvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=re3o5xFiJs7PMgc/oIl+26uZ6O3PGDFv96u83WmwTAfjZRgqDHNjO18wp+XEmguj23lCjePP6LlfAVC2v9XXznV13BHmHiUtllWffD6iinHsUmKkwVPSBN6tmQB+K8plULc4r3xqhCPB7N/S2zucknZn9tpiXhg09CIfx3xKT4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UwDrIUW2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E431C116C6;
	Mon,  2 Feb 2026 22:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770071818;
	bh=5MJVPCVbmtzuCZwL83PoTDuizJyOCLSnPH7N+xyLpvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UwDrIUW2iWb+B3Povsgz/e7h+6zhA+KK7tSRBVKQwki/OOCcSr/BirLZ5e6W/zpYc
	 6YYiBVW9Rf8j4FauTtnE/rgg90x9TN7b/7xoDFt4ODEM2Igf6zVnhzakCv+4+vU9Tj
	 xuwbO9WIYbNKrgfdfSZUAB5RcDoYtEKfH8cFlCpERawUbUcTqWMc76rMVu980wxKNO
	 fPwYP8ruAXsAeXo1jtA3Kgzuu8YsRUw9CHCP7IqwHa7iLeTyulKb2AGzgH9UpVSniC
	 xvd+xWME6doh0vOUbSpd2fUEKq2HCPBYRGImpwS+XUlTJYup1HyZXt98bZCOmJcGtT
	 vxFN5/0TRLTmA==
Date: Mon, 2 Feb 2026 14:36:57 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@lst.de, tytso@mit.edu,
	willy@infradead.org, jack@suse.cz, josef@toxicpanda.com,
	sandeen@sandeen.net, rgoldwyn@suse.com, xiang@kernel.org,
	dsterba@suse.com, pali@kernel.org, ebiggers@kernel.org,
	neil@brown.name, amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, iamjoonsoo.kim@lge.com,
	cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Subject: Re: [PATCH v6 03/16] fs: add generic FS_IOC_SHUTDOWN definitions
Message-ID: <20260202223657.GB1535390@frogsfrogsfrogs>
References: <20260202220202.10907-1-linkinjeon@kernel.org>
 <20260202220202.10907-4-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202220202.10907-4-linkinjeon@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76114-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,lst.de,mit.edu,infradead.org,suse.cz,toxicpanda.com,sandeen.net,suse.com,brown.name,gmail.com,vger.kernel.org,lge.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EF521D262F
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 07:01:49AM +0900, Namjae Jeon wrote:
> Currently, several filesystems (e.g., xfs, ext4, btrfs) implement
> a "shutdown" or "going down" ioctl to simulate filesystem force a shutdown.
> While they often use the same underlying numeric value, the definition is
> duplicated across filesystem headers or private definitions.
> 
> This patch adds generic definitions for FS_IOC_SHUTDOWN in uapi/linux/fs.h.
> This allows new filesystems (like ntfs) to implement this feature using
> a standard VFS definition and paves the way for existing filesystems
> to unify their definitions later.
> 
> The flag names are standardized as FS_SHUTDOWN_* to be consistent with
> the ioctl name, replacing the historical GOING_DOWN naming convention.
> 
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> ---
>  include/uapi/linux/fs.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index 66ca526cf786..32e24778c9e5 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -656,4 +656,16 @@ struct procmap_query {
>  	__u64 build_id_addr;		/* in */
>  };
>  
> +/*
> + * Shutdown the filesystem.
> + */
> +#define FS_IOC_SHUTDOWN _IOR('X', 125, __u32)
> +
> +/*
> + * Flags for FS_IOC_SHUTDOWN
> + */
> +#define FS_SHUTDOWN_FLAGS_DEFAULT	0x0
> +#define FS_SHUTDOWN_FLAGS_LOGFLUSH	0x1	/* flush log but not data*/
> +#define FS_SHUTDOWN_FLAGS_NOLOGFLUSH	0x2	/* don't flush log nor data */

Hoisting this to reduce the copy-pasting already going on in filesystems
sounds like a good idea to me:

$ git grep '_IOR.*X.*125'
fs/ntfs3/file.c:26:#define NTFS3_IOC_SHUTDOWN _IOR('X', 125, __u32)
fs/smb/client/cifs_ioctl.h:117:#define CIFS_IOC_SHUTDOWN _IOR('X', 125, __u32)
fs/xfs/libxfs/xfs_fs.h:1266:#define XFS_IOC_GOINGDOWN        _IOR ('X', 125, uint32_t)
include/uapi/linux/btrfs.h:1230:#define BTRFS_IOC_SHUTDOWN      _IOR('X', 125, __u32)
include/uapi/linux/exfat.h:15:#define EXFAT_IOC_SHUTDOWN _IOR('X', 125, __u32)
include/uapi/linux/ext4.h:39:#define EXT4_IOC_SHUTDOWN _IOR('X', 125, __u32)
include/uapi/linux/f2fs.h:53:#define F2FS_IOC_SHUTDOWN  _IOR('X', 125, __u32)   /* Shutdown */

Christian: any chance we could get this api cleanup queued for 7.0 even
though we're past -rc8?

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> +
>  #endif /* _UAPI_LINUX_FS_H */
> -- 
> 2.25.1
> 

