Return-Path: <linux-fsdevel+bounces-76529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CdIAdhzhWlzBwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 05:53:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C65FA2B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 05:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8E70301BF71
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 04:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E0C337B8C;
	Fri,  6 Feb 2026 04:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1m6wVNc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021862E62C3;
	Fri,  6 Feb 2026 04:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770353613; cv=none; b=IjGQlRG/kJjqqRT7Y1AWIxXqsOhZyiVXta7v4WUEONu9CQ0KuarkQjogFoucOJppo8pLJkkLNW79Ecvq2Ez3G/kVvAeOviNX/PCLvXlnNpD3V7wvyFw7xhgNuCGvOGhEVsDht9PZ15j9MSGvJ6xsTFW+SkPr/MpxImlzzwE2lNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770353613; c=relaxed/simple;
	bh=XM9pzmK6p/zuNzks2AL7EdLS9nP7GMziA1jh2NiPmiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0vpyDIzKF2Bcu1lfopXDHMF4eVnbug841KPWq7bE1xNrsAvwsiYYGxnxJqJbxDwGC31dyN1WbkChMbVwI81lmPYulSf8Aw8ZJK/5/WJLWteVHDbO0YPESGtvYrwyfzoMtMyjmD+G2lDzNNSnlDGGVkBICtcyvyLqx1pEqg9p/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1m6wVNc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB965C116C6;
	Fri,  6 Feb 2026 04:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770353612;
	bh=XM9pzmK6p/zuNzks2AL7EdLS9nP7GMziA1jh2NiPmiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f1m6wVNcftdteUSXfxvrd7BPsvqnw28dovBjsiVLzm5bCffAcmwIzhAQtriipJX+Q
	 vjwomq1DxaCIX2GVA40tGqAfqwQZMRuLEzUzxVfT90oGN0tVCO/PaDSJ7jDloWx5vL
	 TDrh8ysZI+nQwvYHJT3qo9grKBfo1xBNIf3IYXSbyEohIgliz8c956AAvGfwHAAh8X
	 wwQL6c8hJNC4J8mybWZJcRvfqeaIbEpimNQOcADDpZNu/vK5bHlTGMyOdKLjs2bZZP
	 UCFxX05rBbNtO+7hsHpwwUb0LYzNKCFdBmBOXHByGlAqvFSnWwwdUfeHtuk72H/4A3
	 bIGvkm4UssZEQ==
Date: Thu, 5 Feb 2026 20:53:32 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Chris Mason <clm@meta.com>
Cc: cem@kernel.org, hch@lst.de, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6.1 11/11] xfs: add media verification ioctl
Message-ID: <20260206045332.GU7712@frogsfrogsfrogs>
References: <176852588473.2137143.1604994842772101197.stgit@frogsfrogsfrogs>
 <176852588776.2137143.7103003682733018282.stgit@frogsfrogsfrogs>
 <20260120041226.GJ15551@frogsfrogsfrogs>
 <20260206030527.2506821-1-clm@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206030527.2506821-1-clm@meta.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76529-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 57C65FA2B3
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 07:01:32PM -0800, Chris Mason wrote:
> "Darrick J. Wong" <djwong@kernel.org> wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Add a new privileged ioctl so that xfs_scrub can ask the kernel to
> > verify the media of the devices backing an xfs filesystem, and have any
> > resulting media errors reported to fsnotify and xfs_healer.
> 
> Hi everyone,
> 
> I'm trying out my AI review prompts on a few more trees, and I ran it
> on the fuse-iomap-cache branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-cache
> 
> This was the latest email lore could find, apologies if I grabbed the wrong one.
> 
> Hopefully the review below is useful, please let me know if there are places it
> has gone wildly wrong.  I kept the header to make it obvious exactly which
> commit I'd run through.
> 
> (This is another XFS commit that ended up in my rev-list range, low confidence
> in the actual review, but I'm curious if AI got this one right)
> 
> commit 2e5c40a5b6ca722202bc0e99830b6ecf8755d19c
> Author: Darrick J. Wong <djwong@kernel.org>
> 
> xfs: add media verification ioctl
> 
> [ ... ]
> 
> > diff --git a/fs/xfs/xfs_verify_media.c b/fs/xfs/xfs_verify_media.c
> > --- /dev/null
> > +++ b/fs/xfs/xfs_verify_media.c
> > @@ -0,0 +1,445 @@
> 
> [ ... ]
> 
> > +/* Walk reverse mappings to look for all file data loss */
> > +static int
> > +xfs_verify_report_losses(
> > +	struct xfs_mount	*mp,
> > +	enum xfs_group_type	type,
> > +	xfs_daddr_t		daddr,
> > +	u64			bblen)
> > +{
> > +	struct xfs_group	*xg = NULL;
> > +	struct xfs_trans	*tp;
> > +	xfs_fsblock_t		start_bno, end_bno;
> > +	uint32_t		start_gno, end_gno;
> > +	int			error;
> > +
> > +	if (type == XG_TYPE_RTG) {
> > +		start_bno = xfs_daddr_to_rtb(mp, daddr);
> > +		end_bno = xfs_daddr_to_rtb(mp, daddr + bblen - 1);
> > +	} else {
> > +		start_bno = XFS_DADDR_TO_FSB(mp, daddr);
> > +		end_bno = XFS_DADDR_TO_FSB(mp, daddr + bblen - 1);
> > +	}
> > +
> > +	tp = xfs_trans_alloc_empty(mp);
> > +	start_gno = xfs_fsb_to_gno(mp, start_bno, type);
> > +	end_gno = xfs_fsb_to_gno(mp, end_bno, type);
> > +	while ((xg = xfs_group_next_range(mp, xg, start_gno, end_gno, type))) {
> > +		struct xfs_buf		*agf_bp = NULL;
> > +		struct xfs_rtgroup	*rtg = NULL;
> > +		struct xfs_btree_cur	*cur;
> > +		struct xfs_rmap_irec	ri_low = { };
> > +		struct xfs_rmap_irec	ri_high;
> > +		struct xfs_group_data_lost lost;
> > +
> > +		if (type == XG_TYPE_AG) {
> > +			struct xfs_perag	*pag = to_perag(xg);
> > +
> > +			error = xfs_alloc_read_agf(pag, tp, 0, &agf_bp);
> > +			if (error) {
> > +				xfs_perag_put(pag);
> > +				break;
> > +			}
> > +
> > +			cur = xfs_rmapbt_init_cursor(mp, tp, agf_bp, pag);
> > +		} else {
> > +			rtg = to_rtg(xg);
> > +			xfs_rtgroup_lock(rtg, XFS_RTGLOCK_RMAP);
> > +			cur = xfs_rtrmapbt_init_cursor(tp, rtg);
> > +		}
> 
> Does this code have a reference counting mismatch in the error paths?
> 
> The xfs_group returned by xfs_group_next_range() is acquired via
> xfs_group_grab() which increments xg_active_ref.
> 
> In the error path at line 120, the code uses xfs_perag_put() to release
> the reference:
> 
> 	error = xfs_alloc_read_agf(pag, tp, 0, &agf_bp);
> 	if (error) {
> 		xfs_perag_put(pag);
> 		break;
> 	}
> 
> And later in the loop, line 144 uses xfs_group_put().
> 
> Both xfs_perag_put() and xfs_group_put() decrement xg_ref, not
> xg_active_ref. Looking at the reference counting implementation:
> 
> xfs_group_grab() calls atomic_inc_not_zero(&xg->xg_active_ref)
> xfs_group_rele() calls atomic_dec(&xg->xg_active_ref)
> xfs_group_put() calls atomic_dec(&xg->xg_ref)
> 
> Should these error paths use xfs_group_rele() instead to match the
> xfs_group_grab() in xfs_group_next_range()?

Yep.  Wouldn't it be nice if our type system could keep those things
straight... :/

--D

