Return-Path: <linux-fsdevel+bounces-51351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAF4AD5DE6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 20:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFD301E25B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 18:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A9625E45A;
	Wed, 11 Jun 2025 18:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Ryh/M5FU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CBE244678
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 18:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749665547; cv=none; b=u+HsawnMxL9JppfOmwFhwbBX+jmpgWmMptzz7ZdW1BeFbUI3SEXZEZY2xNDdJt6b5f55kLs+cURXEBWpaybo0I0AmPT5MOYrBxlMg3IcQ2vOmw2fwpL5LBePv9BcwwnChN2PJYAnr/RdrF98d9txJ4SD0aVOvWou7EthaUYga2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749665547; c=relaxed/simple;
	bh=lCwS9QrF25Q9JLPh0ywtqW98a4FmE146jL+aJKMcI+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzzDlVydcvcS1cfWQ8AhjjhI6X7ix4LSwjh3j+I1d77n8aolAZJ5KwJSyWWUWQbxTr3cAxVcoUFXBJhcW4OxMq1tE9pOf3IKG8+bQpOS3af/WG8HK3SJ13cOs2/prP2NqQao4CQMv0mWQ48wc9us1ZuCsjbQpurBIscZAX3Yhl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Ryh/M5FU; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xbURR4rKbBnyfKzhgIus2DNqel4kZr9f5qFLx/D9c00=; b=Ryh/M5FU56GYjGHOeYYoN3i6ix
	yntMGgrVTM6a+CHmC3HQwUA+521zGoN3Y1dlwX/shmfUlDz1QdAcXHdPIm+JIwPJceB0uPnr+xeOI
	RpG+L8ABIrWPKQ0LcLqTSZboDo17tGSkM9nh7aUgPsF6uTk7DxJ6johHS844WGEMq9IQdVHB4vVng
	GmvMLW3CsMW6iQGdW3FmePtgV1QprKSt7ywf1Ws+6niKVswsvYX5opDAH2VCx6enHf1o3JLvipB6q
	2JayGSoKmAP4hgNVovOr2gH19UXnBH3DZ7YgQHWCbnwk8v6x/yid7dwn0ZouEKVpBMNpZEYSYyWyu
	UGpFq/nQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPPvz-00000004ukc-2fWI;
	Wed, 11 Jun 2025 18:12:23 +0000
Date: Wed, 11 Jun 2025 19:12:23 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, ebiederm@xmission.com, jack@suse.cz,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 17/26] attach_recursive_mnt(): unify the
 mnt_change_mountpoint() logics
Message-ID: <20250611181223.GO299672@ZenIV>
References: <20250610081758.GE299672@ZenIV>
 <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
 <20250610082148.1127550-17-viro@zeniv.linux.org.uk>
 <20250611-stottern-chipsatz-779c33c0b88e@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611-stottern-chipsatz-779c33c0b88e@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Jun 11, 2025 at 01:05:52PM +0200, Christian Brauner wrote:
> > -	if (beneath)
> > -		mnt_change_mountpoint(source_mnt, smp, top_mnt);
> > -	commit_tree(source_mnt);
> > +	hlist_add_head(&source_mnt->mnt_hash, &tree_list);
> 
> Please add a comment here. Right now it's easy to understand even with
> your mnt_change_mountpoint() changes. Afterwards the cases are folded
> and imho that leaves readers wondering why that's correct.

Hmm...  Does the incremental below look sane for you?

diff --git a/fs/namespace.c b/fs/namespace.c
index d5a7d7da3932..15b7959b1771 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2675,6 +2675,13 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 	}
 
 	mnt_set_mountpoint(dest_mnt, dest_mp, source_mnt);
+	/*
+	 * Now the original copy is in the same state as the secondaries -
+	 * its root attached to mountpoint, but not hashed and all mounts
+	 * in it are either in our namespace or in no namespace at all.
+	 * Add the original to the list of copies and deal with the
+	 * rest of work for all of them uniformly.
+	 */
 	hlist_add_head(&source_mnt->mnt_hash, &tree_list);
 
 	hlist_for_each_entry_safe(child, n, &tree_list, mnt_hash) {

