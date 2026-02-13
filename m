Return-Path: <linux-fsdevel+bounces-77119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMsEKeb6jmljGwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 11:20:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4975F134FE7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 11:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2F45304B02E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 10:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E7D33066E;
	Fri, 13 Feb 2026 10:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4EeyVac"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88687335063
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 10:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770978013; cv=none; b=ZyZqA+bfCGFVxn1oYKJ8xOAo590g4ChLYp25swjMLGAivKryStCvVRTxwxUeWaSJ4dCc2BLOnQlej2+GsV1u/LdklnRu3BRmkOVOg7TRTIDsAEKRY6V6JUY/LQaLFP837GwRiicyJTZed8kQwbvuocE1SxoSKQb/2zNT9z9c9NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770978013; c=relaxed/simple;
	bh=Ua7cgJt0am9i20h/oREzwCJsPnd3t8Iy+Fu9BxIBTig=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=WdD66ey3loQhTr/654HytHv/EmjUpqV5ydoy58es6BIlQ0E+mjpepnCYJ2r3VfDxaaLrfPmj3hB3dRiTzXtGSBs0OT4OfHjIvNQNrptsoZVMwNmj5lrbk7qSeB/MoPb4/TdXxNJIsrcC+EMtJwNuG+zckKQZKJGp3JybQbccpv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4EeyVac; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-81df6a302b1so806324b3a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 02:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770978012; x=1771582812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zNTLNOUva/wrs64KIAki8pZHRLxbaL6YVGeBvHIT3Q4=;
        b=O4EeyVacY5cNufng/l0xzVUXh7SDTbGQcqmpWNuOjVbYGjV6N5K+PtldkKqvT6hPY1
         riLGammVNjb4elM9auGs4Gj9Ht9xou7vU2x2j7iZroPL+i79jBXI+d6gZzDLqvQEUmxL
         OOrlH8AZizmTEkd41jlCK/taIRfMNIgV/v8jev73ue7KjXcDDmdL6aU1dk5Vck/D3qr+
         GQvfVDNjTy31jqHUN8QYMBvcGK0PrzoJEEy56syKZsN/TrRoQnB5rmp9Rbu8zEsEdjyy
         gcxE0z0Ep9RYWcAj9hfyoEHpMPQ0mMFThhYQOBLxyWz5Sg3Y+lXwFSOw8KO8GyDNKKHj
         MTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770978012; x=1771582812;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :to:from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zNTLNOUva/wrs64KIAki8pZHRLxbaL6YVGeBvHIT3Q4=;
        b=aq8tLGFeNejRRymdF+oxuoPoGomlWEZszCXz507RrIXaAdkrJoUZjhEBg4sgWSR9JH
         STHAPYoYplpubIAAmfpgNCJFrssvLc/TjVtVyZKg8V5bWkmSyEw0KORv/H0dg62MwFoL
         AnNqTyg1+DPTWnq+Cbnw2qVr7u/CWDDamwjWlCnm4hwBrnHqN34JJG+ZjWELfQaFknFp
         J1GmB7QigrK+BKGc92CfLOx4qAkblWgipltmgh5HFnXzBCnv/fiXlZrkKXrCF2Cw91sl
         vqwZItamtJydJ7mJyg5jBXSm0outFu+r8ju47pgqzeArJvn1Vi7Tv3RYh7aV7ITF8lXU
         U3Cw==
X-Forwarded-Encrypted: i=1; AJvYcCXi6F/KzMCYcxv8R2hmW7uFJQq7ht2JeQbcj7f27qDPwiaQWkY1BEowvaklXh1qMny4la8JFWIiof4cSiiI@vger.kernel.org
X-Gm-Message-State: AOJu0YzfmFu08ECbS2ZkJrqhimWehhRO90go5tkBZSrcXDV8CDs8CTy1
	OsgH8nwa4mQtZS+aND+0+8w1FdL1TG+YmBPulUn/7yZjJup4Z9JgXK8z
X-Gm-Gg: AZuq6aI/ugnvLr3FRM0x8HVz7rH3F+tRhVCOnhEJUpennVoFgxZv79JQ2w61IU1MN8p
	5WDfj+IMvhRBStuK/4xsSC+jdnVc+mYVU6axca+/pzJhDMazLz9gAhFjvT2ur+cEd8N2xIu0AZK
	if1UVHc23an4uTNgk5vNaAbSvuJWdgiQaf2x5HtVyjE+g5qv3zWB43Go9iZV9SLn57aecxz+xtx
	o+Fh8Fv0k3ZDE8MbvazdtnsmgdAtAVSes4HP+esTqf2U7L1+rFE5bIJGechpyhJGKPT+QDWxdpc
	8IJkbxowX202UnxxKa6zbwM4ZyGlnzkI8Lnzz/b20rT2NcnBSS6OI/J24oi7rOBDUlrpMUqGz4e
	+OBidWgwR/BgYx1FSw4vuT7DgrRMhtB0QDkrgAotikQfqBck1zWF5Txe5svaa+xvYzHuCqFugGW
	5Ik8PRE8zwvU+JrRzS+NDBiarIkMc2AMZvKnov1qVySoYRWxtptviMhCO5TaXXXxm2+4/5Z7hqh
	0RsM5ye
X-Received: by 2002:a05:6a00:17a8:b0:823:108c:5bae with SMTP id d2e1a72fcca58-824c946ed92mr1623723b3a.8.1770978011783;
        Fri, 13 Feb 2026 02:20:11 -0800 (PST)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com ([49.207.230.129])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6b6a17fsm2692581b3a.34.2026.02.13.02.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 02:20:11 -0800 (PST)
Message-ID: <af7b989f430a8b464f48a8404b4f60a5fb4a189f.camel@gmail.com>
Subject: Re: [PATCH v2 1/5] iomap, xfs: lift zero range hole mapping flush
 into xfs
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org
Date: Fri, 13 Feb 2026 15:50:07 +0530
In-Reply-To: <20260129155028.141110-2-bfoster@redhat.com>
References: <20260129155028.141110-1-bfoster@redhat.com>
	 <20260129155028.141110-2-bfoster@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77119-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nirjharroylists@gmail.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 4975F134FE7
X-Rspamd-Action: no action

On Thu, 2026-01-29 at 10:50 -0500, Brian Foster wrote:
> iomap zero range has a wart in that it also flushes dirty pagecache
> over hole mappings (rather than only unwritten mappings). This was
> included to accommodate a quirk in XFS where COW fork preallocation
> can exist over a hole in the data fork, and the associated range is
> reported as a hole. This is because the range actually is a hole,
> but XFS also has an optimization where if COW fork blocks exist for
> a range being written to, those blocks are used regardless of
> whether the data fork blocks are shared or not. For zeroing, COW
> fork blocks over a data fork hole are only relevant if the range is
> dirty in pagecache, otherwise the range is already considered
> zeroed.
> 
> The easiest way to deal with this corner case is to flush the
> pagecache to trigger COW remapping into the data fork, and then
> operate on the updated on-disk state. The problem is that ext4
> cannot accommodate a flush from this context due to being a
> transaction deadlock vector.
> 
> Outside of the hole quirk, ext4 can avoid the flush for zero range
> by using the recently introduced folio batch lookup mechanism for
> unwritten mappings. Therefore, take the next logical step and lift
> the hole handling logic into the XFS iomap_begin handler. iomap will
> still flush on unwritten mappings without a folio batch, and XFS
> will flush and retry mapping lookups in the case where it would
> otherwise report a hole with dirty pagecache during a zero range.
> 
> Note that this is intended to be a fairly straightforward lift and
> otherwise not change behavior. Now that the flush exists within XFS,
> follow on patches can further optimize it.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
>  fs/iomap/buffered-io.c |  2 +-
>  fs/xfs/xfs_iomap.c     | 25 ++++++++++++++++++++++---
>  2 files changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 6beb876658c0..807384d72311 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1620,7 +1620,7 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
>  		     srcmap->type == IOMAP_UNWRITTEN)) {
>  			s64 status;
>  
> -			if (range_dirty) {
> +			if (range_dirty && srcmap->type == IOMAP_UNWRITTEN) {
>  				range_dirty = false;
>  				status = iomap_zero_iter_flush_and_stale(&iter);
>  			} else {
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 37a1b33e9045..896d0dd07613 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1790,6 +1790,7 @@ xfs_buffered_write_iomap_begin(
>  	if (error)
>  		return error;
>  
> +restart:
>  	error = xfs_ilock_for_iomap(ip, flags, &lockmode);
>  	if (error)
>  		return error;
> @@ -1817,9 +1818,27 @@ xfs_buffered_write_iomap_begin(
>  	if (eof)
>  		imap.br_startoff = end_fsb; /* fake hole until the end */
>  
> -	/* We never need to allocate blocks for zeroing or unsharing a hole. */
> -	if ((flags & (IOMAP_UNSHARE | IOMAP_ZERO)) &&
> -	    imap.br_startoff > offset_fsb) {
> +	/* We never need to allocate blocks for unsharing a hole. */
> +	if ((flags & IOMAP_UNSHARE) && imap.br_startoff > offset_fsb) {
> +		xfs_hole_to_iomap(ip, iomap, offset_fsb, imap.br_startoff);
> +		goto out_unlock;
> +	}
> +
> +	/*
> +	 * We may need to zero over a hole in the data fork if it's fronted by
> +	 * COW blocks and dirty pagecache. To make sure zeroing occurs, force
> +	 * writeback to remap pending blocks and restart the lookup.
> +	 */
> +	if ((flags & IOMAP_ZERO) && imap.br_startoff > offset_fsb) {
> +		if (filemap_range_needs_writeback(inode->i_mapping, offset,
> +						  offset + count - 1)) {
> +			xfs_iunlock(ip, lockmode);

I am a bit new to this section of the code - so a naive question:
Why do we need to unlock the inode here? Shouldn't the mappings be thread safe while the write/flush
is going on?
--NR
> +			error = filemap_write_and_wait_range(inode->i_mapping,
> +						offset, offset + count - 1);
> +			if (error)
> +				return error;
> +			goto restart;
> +		}
>  		xfs_hole_to_iomap(ip, iomap, offset_fsb, imap.br_startoff);
>  		goto out_unlock;
>  	}


