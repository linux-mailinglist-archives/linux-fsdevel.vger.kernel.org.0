Return-Path: <linux-fsdevel+bounces-77854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BjtMRnNmWlGWwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 16:19:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6940816D262
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 16:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 805FE30054CA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 15:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9DF1FDA92;
	Sat, 21 Feb 2026 15:19:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp02-ext3.udag.de (smtp02-ext3.udag.de [62.146.106.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A338010FD;
	Sat, 21 Feb 2026 15:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771687191; cv=none; b=m52iom3IsWpjrTDwr5333DhHxY7Zu46DbdgoXQftTrDE05Z1NnekohgA9Sb9l2fA38S4oPW8EbYI7yMNYTY6jL9CbLJZYLX0Gvo52wtnRm8mVQTzRNHFXd3kWbyDnHOrt8LDrhiHMBZefgFH1bmyYkdRYX0telL7bTcMex30HyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771687191; c=relaxed/simple;
	bh=u8dL696XVDzEYCd0JVe+OfPkcCDWJzeROsAnPH2aPRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ato/0174ypeh+5QHZfmKRlkOWC2g9x8jAN1A+tMOIG4PX6xi/VAi1BIZbh5tD8yV1D2yviAl87O0pA2xAC3MYctHbUR63jWHAUe+n4I8sWdehxfn/sUWRcZmAFlh5zk2k3/EK4CUp5quqmbUKOOPSFpD/jqr8Z1SQpCttyt29LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (200-143-067-156.ip-addr.inexio.net [156.67.143.200])
	by smtp02-ext3.udag.de (Postfix) with ESMTPA id 68F70E00F1;
	Sat, 21 Feb 2026 16:19:40 +0100 (CET)
Authentication-Results: smtp02-ext3.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Sat, 21 Feb 2026 16:19:39 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Jim Harris <jim.harris@nvidia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mgurtovoy@nvidia.com, ksztyber@nvidia.com
Subject: Re: [PATCH] fuse: skip lookup during atomic_open() when O_CREAT is
 set
Message-ID: <aZnLtrqN3u8N66GU@fedora-2.fritz.box>
References: <20260220204102.21317-1-jiharris@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220204102.21317-1-jiharris@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[birthelmer.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77854-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horst@birthelmer.de,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.933];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email,fedora-2.fritz.box:mid]
X-Rspamd-Queue-Id: 6940816D262
X-Rspamd-Action: no action

Hi Jim,

On Fri, Feb 20, 2026 at 01:41:02PM -0700, Jim Harris wrote:
> From: Jim Harris <jim.harris@nvidia.com>
> 
> When O_CREAT is set, we don't need the lookup. The lookup doesn't
> harm anything, but it's an extra FUSE operation that's not required.
> 
> Signed-off-by: Jim Harris <jim.harris@nvidia.com>
> ---
>  fs/fuse/dir.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index f25ee47822ad..35f65d49ed2a 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -895,7 +895,8 @@ static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
>  		goto out_err;
>  	}
>  	kfree(forget);
> -	d_instantiate(entry, inode);
> +	d_drop(entry);
> +	d_splice_alias(inode, entry);
>  	entry->d_time = epoch;
>  	fuse_change_entry_timeout(entry, &outentry);
>  	fuse_dir_changed(dir);
> @@ -936,14 +937,15 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
>  	if (fuse_is_bad(dir))
>  		return -EIO;
>  
> -	if (d_in_lookup(entry)) {
> -		struct dentry *res = fuse_lookup(dir, entry, 0);
> -		if (res || d_really_is_positive(entry))
> -			return finish_no_open(file, res);
> -	}
> +	if (!(flags & O_CREAT)) {
> +		if (d_in_lookup(entry)) {
> +			struct dentry *res = fuse_lookup(dir, entry, 0);
>  
> -	if (!(flags & O_CREAT))
> +			if (res || d_really_is_positive(entry))
> +				return finish_no_open(file, res);
> +		}
>  		return finish_no_open(file, NULL);
> +	}
>  
>  	/* Only creates */
>  	file->f_mode |= FMODE_CREATED;
> -- 
> 2.43.0
> 
> 

I have been looking at that code lately a lot since I was planning to
replace it with a compound.
I'm not entirely convinced that your proposal is the right direction. 
I would involve O_EXCL as well, since that lookup could actually 
help in that case.

Take a look at what Miklos wrote here:
https://lore.kernel.org/linux-fsdevel/CAJfpegsDxsMsyfP4a_5H1q91xFtwcEdu9-WBnzWKwjUSrPNdmw@mail.gmail.com/

Cheers,
Horst

