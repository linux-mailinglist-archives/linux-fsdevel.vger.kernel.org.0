Return-Path: <linux-fsdevel+bounces-76473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEgKM4vohGnb6QMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 19:59:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE4EF6A5A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 19:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C3C173004F1F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 18:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAD130BB80;
	Thu,  5 Feb 2026 18:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="nq9fGIh9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7D630B500;
	Thu,  5 Feb 2026 18:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770317961; cv=none; b=CcNbtTee5KVYP9w3CcQk6WGFgYqUmli+R7yTasJPjJdHLMnlBPd4Dap3f+JsfkgrzOgjvqDQb+m3mG7wNbMTLSmBQYzOWHFBTywjq3GluVPtySYkXiNvVO5498BvVcz85z7ccSr0hi43ki5WfXz48wXszY4QSjNOF1Ad8bHsDGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770317961; c=relaxed/simple;
	bh=UfFRVTPXD11iUuz+54SZELk+drb9rvoSzirgUSxZlG4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ukN5GDH4YFxrtBYBmuSuzD8NnW9NF58ZxW8oGqYgeuw9RtOLYGNZj+qir0+JvE0JLxQbGze/6TiapKOD15Ft8bs7togyKUv169XSQrR6l5Hz1ID8lpqRM7R2Oh8gz2H0N/kVCA3rAd58axAd5NAsgB9BeUWXCoesTLaDRi5vOLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=nq9fGIh9; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 615HvhLc1358636;
	Thu, 5 Feb 2026 10:59:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=NSAdsTTskRQr5NjDgUj1AfesrpNCutBTl5jpF9aXAA4=; b=nq9fGIh9j/jR
	uV35bbFTBfmcFWEbRioLehjsh0bSN6AiKHJ2vBK38QOTc5PChTBhkmTtyfbtpCXU
	9gcN1OWR3xB/qkLRrupc7QdXNJG0OImcWBRfWQDbqImm2/561ZCuOIphYKRXgPu0
	4YTLXr5RkZj8Op7RworvX72ptabxGY657BVxBNBBatA1Yb3d28bXNT2t6T1UDGKU
	Z8UrsWc+iiJp7DvKsGSMWU2jdvJBQ/L1Nmnt1bYAhZHDWqMtq0XQQhyTUiUE4DCv
	bQt5kNhfJHYWIV2d/f7moUkPs0H2hk/tWc+CLonAKiRH/a1/EFCCRcOKIl6d1Gv9
	o4ohHPasIg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c4tvqcmfv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 05 Feb 2026 10:59:06 -0800 (PST)
Received: from devbig003.atn7.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 5 Feb 2026 18:59:04 +0000
From: Chris Mason <clm@meta.com>
To: "Darrick J. Wong" <djwong@kernel.org>
CC: <miklos@szeredi.hu>, <joannelkoong@gmail.com>, <bernd@bsbernd.com>,
        <neal@gompa.dev>, <linux-ext4@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 29/31] fuse: disable direct reclaim for any fuse server that uses iomap
Date: Thu, 5 Feb 2026 10:57:15 -0800
Message-ID: <20260205185842.1833542-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <176169810980.1424854.10557015500766654898.stgit@frogsfrogsfrogs>
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs> <176169810980.1424854.10557015500766654898.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: fEqkTIID2uJ7QLR9MH-s2PW73TNm1KqN
X-Proofpoint-ORIG-GUID: fEqkTIID2uJ7QLR9MH-s2PW73TNm1KqN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDE0NCBTYWx0ZWRfX0PX2TCPxLVOi
 pQeHwt/Ubr6xlu7rjXZyjAi9Wb4PIqoRsGYqfxD35SL0G++pkj+pX3StliXQ8LstHtSBH/S42+n
 Fd8gKKWva1cWeM8rekwlOlFc7BTu8BZ3omYBg7RWu6ohp7Al0QouNhDS4B4SVjOBO/VuR7WbqKm
 ZXndP0tkpmW+2oFffiIDMaleSZCrFduRLkTIDOVBotoLoTb2J6OX6Jp1qWUYQoEJPk5QMY2Jkg2
 MHWAMC4GECxMnfST38R32i6OvxIrqx3G3DDJ3pEbta5p0hDN9RkW0/JjruaYicAakn0sCV3scxv
 pGbyHblL4VigM7CMIq+QS9S1j0THulD7xnYUXptC7xWAafCnShl3l3DDZZdGF+k3HLkK2Woc8KU
 XRXytsFzOn0rUcpXbRHiy15sdRGn0sX/f2Lswb5xkrnmCV0tJ0paGcXwevT3Xt+jBlnjDwb67R/
 N5JjNiW66YxOefJrWYQ==
X-Authority-Analysis: v=2.4 cv=W4g1lBWk c=1 sm=1 tr=0 ts=6984e87a cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=S1QKfWfzKFdLYBOa6hQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_04,2026-02-05_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76473-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[szeredi.hu,gmail.com,bsbernd.com,gompa.dev,vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[clm@meta.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[meta.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,meta.com:mid,meta.com:dkim]
X-Rspamd-Queue-Id: 7DE4EF6A5A
X-Rspamd-Action: no action

"Darrick J. Wong" <djwong@kernel.org> wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Any fuse server that uses iomap can create a substantial amount of dirty
> pages in the pagecache because we don't write dirty stuff until reclaim
> or fsync.  Therefore, memory reclaim on any fuse iomap server musn't
> ever recurse back into the same filesystem.  We must also never throttle
> the fuse server writes to a bdi because that will just slow down
> metadata operations.

Hi everyone,

I'm trying out my AI review prompts on a few more trees, and I ran it
on the fuse-iomap-cache branch:

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-cache

This was the latest email lore could find, apologies if I grabbed the wrong one.

Hopefully the review below is useful, please let me know if there are places it
has gone wildly wrong.  I kept the header to make it obvious exactly which
commit I'd run through:

commit 3bdd586d6fa00e067dbc3676642ac75e54ec3031
Author: Darrick J. Wong <djwong@kernel.org>

fuse: disable direct reclaim for any fuse server that uses iomap

Any fuse server that uses iomap can create a substantial amount of dirty
pages in the pagecache because we don't write dirty stuff until reclaim
or fsync. Therefore, memory reclaim on any fuse iomap server must avoid
recursing back into the same filesystem and throttling the fuse server.

> diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
> --- a/fs/fuse/fuse_iomap.c
> +++ b/fs/fuse/fuse_iomap.c
> @@ -1019,6 +1019,12 @@ static void fuse_iomap_config_reply(struct fuse_mount *fm,
>  	 */
>  	fc->sync_fs = true;
>
> +	/*
> +	 * We could be on the hook for a substantial amount of writeback, so
> +	 * prohibit reclaim from recursing into fuse or the kernel from
> +	 * throttling any bdis that the fuse server might write to.
> +	 */
> +	current->flags |= PF_MEMALLOC_NOFS | PF_LOCAL_THROTTLE;

Are these process flags being set on the correct process? Looking at the
call chain:

Sync path:
  fuse_fill_super() -> fuse_iomap_mount() -> fuse_iomap_config_reply()

Async path:
  fuse_request_end() -> args->end() -> fuse_iomap_config_reply()

In the sync path, current points to the mount(2) process which exits
after mounting completes. In the async path, current points to whichever
process writes the reply to /dev/fuse (the fuse daemon thread) or a
kernel worker thread for virtio-fs.

The commit message states the goal is to prohibit reclaim from recursing
into the fuse server, but the fuse server is a separate userspace process.
Setting flags on the mount process (which exits) or on a random fuse
daemon thread (only once during init) doesn't protect the fuse server
threads that actually perform I/O operations.

Should the flags be set on the correct process context? Or if they need
to be set here, should they follow the pattern used in fs/nfsd/vfs.c and
fs/nfs/localio.c which save and restore the flags?

Looking at fs/nfsd/vfs.c:1438-1509:

  unsigned long old_flags = current->flags;
  current->flags |= PF_LOCAL_THROTTLE;
  ...
  current_restore_flags(pflags, PF_LOCAL_THROTTLE);

and fs/nfs/localio.c:824-828:

  unsigned long old_flags = current->flags;
  current->flags |= PF_LOCAL_THROTTLE;
  ...
  current_restore_flags(old_flags, PF_LOCAL_THROTTLE);

Without saving and restoring, the flags permanently alter the process
state. For the mount process this is wasted when it exits, and for fuse
daemon threads this causes permanent behavior changes.


