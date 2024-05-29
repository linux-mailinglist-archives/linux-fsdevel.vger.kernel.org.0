Return-Path: <linux-fsdevel+bounces-20403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B3A8D2D4C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 08:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 833A11C22A02
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 06:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6911816132F;
	Wed, 29 May 2024 06:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0/O9HICj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9244115ECD9;
	Wed, 29 May 2024 06:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716964230; cv=none; b=X+wwfn5M3ubmPudPGEperwxNowBFGM9aZ3ZXC7JvdYfndg+nfcoF0M3OtnoqQwqSpfpig6lgT2YScpW4bsZLnpOy/TerSAy4hLnOTjkcS3AVsD3K2esz0jVq4jHFiYV0UsT85hh9dOhKOJi2b35s+uyh41FBdbTfRpcYCzB8jIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716964230; c=relaxed/simple;
	bh=vbOpXjr9ktrBqJmgy29H0fW1gFoPJnwby3srd/a1Ovw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjhY+9PCdwbxsaE6ZYXuF6cDx6LJtEITFR4JGWF7M95jp21OwpGfIE2p0wIWOCHJD+1DggxnKfNdwSCExbMQfzyZ555aScxM/z8bVulnVC7jtO0LFoF+b8IyYMVH7VvYTr2Aer7fTcihedy6sik5/EOZ6GjtzHqNBBwVEcVhdkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0/O9HICj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=swhdXQitouWfbVXir6mhHWJzgMgXKEdt21ahanEqPYc=; b=0/O9HICjMZQG8h/QX2ISQgQO/F
	wl8GRapTie3htc2Zbdq96Y1xYo4fxKcdhycF+nKul+yk89xz2g3RLB3Mj4IXkO5FLq9nIbBI43I9k
	mL34hTZxOqFK5u9WNg3HG4kGGAfAobnDkja0co5/s70Zmzh46HI2dFPYo9EZNyS+hYDPe25XfY19q
	iLpcFArPOrCQ8fdveltf/DybiegRLqBS83s5mbgwFDTuZ3JVTfCKSw1mv+2/Fs2uNBHIhr/YfnFp6
	KDNiLOunrZ4MYQqxEVvMUIXP98Jwht1LjTF0Y10Yc/Elc+YXpN3J84rBPfXAg5uUugGM4md52UWe+
	4C0j3jzQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCCpQ-000000030zs-38CI;
	Wed, 29 May 2024 06:30:28 +0000
Date: Tue, 28 May 2024 23:30:28 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <Anna.Schumaker@netapp.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] nfs: Fix misuses of folio_shift() and folio_order()
Message-ID: <ZlbLhHB4vucmIRgR@infradead.org>
References: <20240527163616.1135968-1-hch@lst.de>
 <20240528210407.2158964-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528210407.2158964-1-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, May 28, 2024 at 10:03:15PM +0100, Matthew Wilcox (Oracle) wrote:
> Page cache indices are in units of PAGE_SIZE, not in units of
> the folio size.  Revert the change in nfs_grow_file(), and
> pass the inode to nfs_folio_length() so it can be reimplemented
> in terms of folio_mkwrite_check_truncate() which handles this
> correctly.

I had to apply the incremental patch below to make the change compile.
With that it causes a new xfstests failure in generic/127 that I haven't
looked into yet.  The mm-level bugs I've seen even with baseline
Linus' tree also happened more often than in my previous tests, but
that might just be coincidence.


diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 1e710654af1173..0a5d5fa9513735 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -938,7 +938,7 @@ TRACE_EVENT(nfs_sillyrename_unlink,
 
 DECLARE_EVENT_CLASS(nfs_folio_event,
 		TP_PROTO(
-			const struct inode *inode,
+			struct inode *inode,
 			struct folio *folio
 		),
 
@@ -954,14 +954,14 @@ DECLARE_EVENT_CLASS(nfs_folio_event,
 		),
 
 		TP_fast_assign(
-			const struct nfs_inode *nfsi = NFS_I(inode);
+			struct nfs_inode *nfsi = NFS_I(inode);
 
 			__entry->dev = inode->i_sb->s_dev;
 			__entry->fileid = nfsi->fileid;
 			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
 			__entry->version = inode_peek_iversion_raw(inode);
 			__entry->offset = folio_file_pos(folio);
-			__entry->count = nfs_folio_length(folio);
+			__entry->count = nfs_folio_length(folio, inode);
 		),
 
 		TP_printk(
@@ -977,14 +977,14 @@ DECLARE_EVENT_CLASS(nfs_folio_event,
 #define DEFINE_NFS_FOLIO_EVENT(name) \
 	DEFINE_EVENT(nfs_folio_event, name, \
 			TP_PROTO( \
-				const struct inode *inode, \
+				struct inode *inode, \
 				struct folio *folio \
 			), \
 			TP_ARGS(inode, folio))
 
 DECLARE_EVENT_CLASS(nfs_folio_event_done,
 		TP_PROTO(
-			const struct inode *inode,
+			struct inode *inode,
 			struct folio *folio,
 			int ret
 		),
@@ -1002,14 +1002,14 @@ DECLARE_EVENT_CLASS(nfs_folio_event_done,
 		),
 
 		TP_fast_assign(
-			const struct nfs_inode *nfsi = NFS_I(inode);
+			struct nfs_inode *nfsi = NFS_I(inode);
 
 			__entry->dev = inode->i_sb->s_dev;
 			__entry->fileid = nfsi->fileid;
 			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
 			__entry->version = inode_peek_iversion_raw(inode);
 			__entry->offset = folio_file_pos(folio);
-			__entry->count = nfs_folio_length(folio);
+			__entry->count = nfs_folio_length(folio, inode);
 			__entry->ret = ret;
 		),
 
@@ -1026,7 +1026,7 @@ DECLARE_EVENT_CLASS(nfs_folio_event_done,
 #define DEFINE_NFS_FOLIO_EVENT_DONE(name) \
 	DEFINE_EVENT(nfs_folio_event_done, name, \
 			TP_PROTO( \
-				const struct inode *inode, \
+				struct inode *inode, \
 				struct folio *folio, \
 				int ret \
 			), \

