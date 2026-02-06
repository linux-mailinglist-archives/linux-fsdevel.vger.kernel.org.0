Return-Path: <linux-fsdevel+bounces-76520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LOoIDhbhWnNAQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 04:08:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F08DBF990A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 04:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6197D305D2A6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 03:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2212B2F1FDB;
	Fri,  6 Feb 2026 03:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="LB8cB+2G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EADA244692;
	Fri,  6 Feb 2026 03:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770347154; cv=none; b=n2vuZTvNQC5PGIekKjoA5OuFPd/A+jMXZbb2599EhhdFFNSaYkvO8dbELQskKV40rTqYtb3Uo3uQkHv1YwlSAN8dFQEdjTy7ergp1etK16FWd6H073zwXSmSaEe+8LhqZZ9CJO372KM8ZRyrLO65qznvFoCvM6caNfdIV3+hZ58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770347154; c=relaxed/simple;
	bh=CY9Kv9GJarmK3bvhoFDjW6CPCrn0G5WIA3KR1uW3xAE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=th3Ye922DIcgzMwH8Eqmnt5jwaueAHe0nyv1KAtjUv2EyUISWwmywnAltQ0ATggNhXZC++cdJHFp6vZWA4XXlplsM5cV5U1GAIIiQwjooFZ33ABu0vb+GOvjswV33bDHLp8k2md0INHPzdoU1vzU2W21CglKfx2DEuu89UEVCFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=LB8cB+2G; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6160VsIJ4121925;
	Thu, 5 Feb 2026 19:05:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=YzpQxNSfABSpsRLuyFgi7FBTpgot1zzgWPUDF/SFIzE=; b=LB8cB+2GqiQj
	cK11HiRAZKwyylOBsvBH4KOo/q/HbwPJL02V+wRHR9YGf0/3mGrcLw9R2glZl/Ln
	PzpnBdxKPVqmYv2sPDycCuuihLQJXOEb1HTNvdANj5gKWmA1fk/Sawv8QWMenZUx
	+sb4u/GJ8BW5tKLmjDR1x5e5po1XomliKaeaCVIiW4uhbtdfEgn0sbqeFBBp+J+g
	mDxArVD7eBfrLGPTLuPy2kEjjBdHBKIGlR1E7cUnXRRaw8PXTeLLPjVmk/4fT8Oq
	Op1WPKhNHan9Ez/bX+M5usq3zEdUy9wn5sSPGd7P8ZAxQDspAv0ALZj36BdDmoZT
	sr1ZP/xgww==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c55ud15yf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 05 Feb 2026 19:05:48 -0800 (PST)
Received: from devbig003.atn7.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Fri, 6 Feb 2026 03:05:47 +0000
From: Chris Mason <clm@meta.com>
To: "Darrick J. Wong" <djwong@kernel.org>
CC: <cem@kernel.org>, <hch@lst.de>, <linux-xfs@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v6.1 11/11] xfs: add media verification ioctl
Date: Thu, 5 Feb 2026 19:01:32 -0800
Message-ID: <20260206030527.2506821-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260120041226.GJ15551@frogsfrogsfrogs>
References: <176852588473.2137143.1604994842772101197.stgit@frogsfrogsfrogs> <176852588776.2137143.7103003682733018282.stgit@frogsfrogsfrogs> <20260120041226.GJ15551@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: dJ4r7jhJ9AcUmxcP1aueW9i2zL2X-9lO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDAxOSBTYWx0ZWRfX0SGgwv/gzY3N
 3zBmkb3BO7lBWBD3ySfc1RbMiiNYCa1xdb2uUu94apcPl0q209iTuIOQ4QfynFbJFdFSYvEsZti
 R25L6PnA8u9VgPZSLZTAIBf3vHx9sNH5kORE5sG2hHR8k14tD+C/6iOSD0Jz0Ft75bBof7d5m4V
 qh1N8LlR03zjcw3hBPZC2f8lGOFJV7dgHbXykWT0Om6iVgQ3Jrwhgsgxpyv1pn7oiYovzADag4t
 J6RtL3FY+v5J7RY/2h8g/1AICyUjeiBKhxKuSrQVsCRK9YYyjq9UXqEilKgPRmvISroCsTYNqTt
 lvVVndIwySGxj2fI2OoEhbKQYaKV7l9HfbURvn1zzPYEP71h/1jAK8B0uSapmgAicxp5UQ1XSmz
 PGLeFZVVw/ZYa1Pg1Ws30xbTikzAAKxSwLzgyR478be4C0OkvieuqxQvcyaNkI03uaHAhPx6luy
 H9s/A9DLjXjWz2/I0PA==
X-Authority-Analysis: v=2.4 cv=T6CBjvKQ c=1 sm=1 tr=0 ts=69855a8c cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=ttdpyjjdJhq82aQT230A:9
X-Proofpoint-GUID: dJ4r7jhJ9AcUmxcP1aueW9i2zL2X-9lO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_01,2026-02-05_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76520-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[meta.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[clm@meta.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:mid,meta.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F08DBF990A
X-Rspamd-Action: no action

"Darrick J. Wong" <djwong@kernel.org> wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Add a new privileged ioctl so that xfs_scrub can ask the kernel to
> verify the media of the devices backing an xfs filesystem, and have any
> resulting media errors reported to fsnotify and xfs_healer.

Hi everyone,

I'm trying out my AI review prompts on a few more trees, and I ran it
on the fuse-iomap-cache branch:

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-cache

This was the latest email lore could find, apologies if I grabbed the wrong one.

Hopefully the review below is useful, please let me know if there are places it
has gone wildly wrong.  I kept the header to make it obvious exactly which
commit I'd run through.

(This is another XFS commit that ended up in my rev-list range, low confidence
in the actual review, but I'm curious if AI got this one right)

commit 2e5c40a5b6ca722202bc0e99830b6ecf8755d19c
Author: Darrick J. Wong <djwong@kernel.org>

xfs: add media verification ioctl

[ ... ]

> diff --git a/fs/xfs/xfs_verify_media.c b/fs/xfs/xfs_verify_media.c
> --- /dev/null
> +++ b/fs/xfs/xfs_verify_media.c
> @@ -0,0 +1,445 @@

[ ... ]

> +/* Walk reverse mappings to look for all file data loss */
> +static int
> +xfs_verify_report_losses(
> +	struct xfs_mount	*mp,
> +	enum xfs_group_type	type,
> +	xfs_daddr_t		daddr,
> +	u64			bblen)
> +{
> +	struct xfs_group	*xg = NULL;
> +	struct xfs_trans	*tp;
> +	xfs_fsblock_t		start_bno, end_bno;
> +	uint32_t		start_gno, end_gno;
> +	int			error;
> +
> +	if (type == XG_TYPE_RTG) {
> +		start_bno = xfs_daddr_to_rtb(mp, daddr);
> +		end_bno = xfs_daddr_to_rtb(mp, daddr + bblen - 1);
> +	} else {
> +		start_bno = XFS_DADDR_TO_FSB(mp, daddr);
> +		end_bno = XFS_DADDR_TO_FSB(mp, daddr + bblen - 1);
> +	}
> +
> +	tp = xfs_trans_alloc_empty(mp);
> +	start_gno = xfs_fsb_to_gno(mp, start_bno, type);
> +	end_gno = xfs_fsb_to_gno(mp, end_bno, type);
> +	while ((xg = xfs_group_next_range(mp, xg, start_gno, end_gno, type))) {
> +		struct xfs_buf		*agf_bp = NULL;
> +		struct xfs_rtgroup	*rtg = NULL;
> +		struct xfs_btree_cur	*cur;
> +		struct xfs_rmap_irec	ri_low = { };
> +		struct xfs_rmap_irec	ri_high;
> +		struct xfs_group_data_lost lost;
> +
> +		if (type == XG_TYPE_AG) {
> +			struct xfs_perag	*pag = to_perag(xg);
> +
> +			error = xfs_alloc_read_agf(pag, tp, 0, &agf_bp);
> +			if (error) {
> +				xfs_perag_put(pag);
> +				break;
> +			}
> +
> +			cur = xfs_rmapbt_init_cursor(mp, tp, agf_bp, pag);
> +		} else {
> +			rtg = to_rtg(xg);
> +			xfs_rtgroup_lock(rtg, XFS_RTGLOCK_RMAP);
> +			cur = xfs_rtrmapbt_init_cursor(tp, rtg);
> +		}

Does this code have a reference counting mismatch in the error paths?

The xfs_group returned by xfs_group_next_range() is acquired via
xfs_group_grab() which increments xg_active_ref.

In the error path at line 120, the code uses xfs_perag_put() to release
the reference:

	error = xfs_alloc_read_agf(pag, tp, 0, &agf_bp);
	if (error) {
		xfs_perag_put(pag);
		break;
	}

And later in the loop, line 144 uses xfs_group_put().

Both xfs_perag_put() and xfs_group_put() decrement xg_ref, not
xg_active_ref. Looking at the reference counting implementation:

xfs_group_grab() calls atomic_inc_not_zero(&xg->xg_active_ref)
xfs_group_rele() calls atomic_dec(&xg->xg_active_ref)
xfs_group_put() calls atomic_dec(&xg->xg_ref)

Should these error paths use xfs_group_rele() instead to match the
xfs_group_grab() in xfs_group_next_range()?


