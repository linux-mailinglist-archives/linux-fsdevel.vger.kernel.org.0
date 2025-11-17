Return-Path: <linux-fsdevel+bounces-68794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 303F7C66651
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 23:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D13A234E164
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 22:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775DB34B68A;
	Mon, 17 Nov 2025 22:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="nBqNNFGf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85D630ACF4;
	Mon, 17 Nov 2025 22:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763417133; cv=none; b=GtQSyRszWf52SjARm0KcKFzqfkvft5VdtVAdlHfeqRNHlDchu7KC6R+tDSlRjf6zW/5yQPxCSSNjGuKK9fKPdjXBQLmY6yRFkK4vxdM1Js/RWnNstW5ImIp9JqytRPpYz44DYbTsyOspm+X8di5/AW9BsNWMvzeZ61U2atvS3MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763417133; c=relaxed/simple;
	bh=d1yWDy9vrByqZZ0nuEPn3Ohn+9q6EnjwvOtc+CIzFq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjfGnPZsw4qkYx9sHI99ykyTdwSjJxVHUb2E21wW5/piIZpETh8WLLJHAIkWvZJQJGaNfPiLs+NaCtYdt6I0c6jQnnngpq/3RAwCkw+XyVZVQFPWLB8aToh51WacWDqisL2MFlg/jIArcU82WKL2EOBru7QWABONtmmwyPcHi7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=nBqNNFGf; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NdoiPvduAJmban0XZT9fHwC8ngtnF/xlF3wyZoQDdKo=; b=nBqNNFGfdqKxxSVEFbkYBH7HCK
	RZfgjjxQt74gHErvaYYpkM2nEVrvPO8Nl+WDX/wqK5bDZXz6a3KmFOoolgEeeFQX8I6N9hEwOstb6
	eKW568HlCJUscl9G3yajgwQxt1BIpLKjeDl4FAnlEgHfYO7xY5nm8CaGpXgaNtawvouTB0dDnq9JP
	Iriyh0hzqdr24etHseBuYN8DJhgCquXEdYC8+yw394UMOgRqpndamrmYqV2cUQZeToveKbWGQ82ht
	jZa05E50eSuXK1dWOd9GvHgd9EgQKMc45jeQKbD3foNOO8qfNDPYv6IxQGLYsKYfSmPxms13r+lI5
	J/l4QRZw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vL7Ll-00000007Lbh-1xvx;
	Mon, 17 Nov 2025 22:05:29 +0000
Date: Mon, 17 Nov 2025 22:05:29 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: bot+bpf-ci@kernel.org, linux-fsdevel@vger.kernel.org,
	torvalds@linux-foundation.org, brauner@kernel.org, jack@suse.cz,
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name,
	a.hindborg@kernel.org, linux-mm@kvack.org,
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev,
	kees@kernel.org, rostedt@goodmis.org, linux-usb@vger.kernel.org,
	paul@paul-moore.com, casey@schaufler-ca.com,
	linuxppc-dev@lists.ozlabs.org, john.johansen@canonical.com,
	selinux@vger.kernel.org, borntraeger@linux.ibm.com,
	bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, ihor.solodrai@linux.dev,
	Chris Mason <clm@meta.com>
Subject: [PATCH 2/4] functionfs: don't bother with ffs->ref in
 ffs_data_{opened,closed}()
Message-ID: <20251117220529.GB1745314@ZenIV>
References: <20251111065520.2847791-37-viro@zeniv.linux.org.uk>
 <20754dba9be498daeda5fe856e7276c9c91c271999320ae32331adb25a47cd4f@mail.kernel.org>
 <20251111092244.GS2441659@ZenIV>
 <e6b90909-fdd7-4c4d-b96e-df27ea9f39c4@meta.com>
 <20251113092636.GX2441659@ZenIV>
 <2025111316-cornfield-sphinx-ba89@gregkh>
 <20251114074614.GY2441659@ZenIV>
 <2025111555-spoon-backslid-8d1f@gregkh>
 <20251117220415.GB2441659@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117220415.GB2441659@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

A reference is held by the superblock (it's dropped in ffs_kill_sb())
and filesystem will not get to ->kill_sb() while there are any opened
files, TYVM...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/usb/gadget/function/f_fs.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 43926aca8a40..0bcff49e1f11 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -2128,7 +2128,6 @@ static void ffs_data_get(struct ffs_data *ffs)
 
 static void ffs_data_opened(struct ffs_data *ffs)
 {
-	refcount_inc(&ffs->ref);
 	if (atomic_add_return(1, &ffs->opened) == 1 &&
 			ffs->state == FFS_DEACTIVATED) {
 		ffs->state = FFS_CLOSING;
@@ -2153,11 +2152,11 @@ static void ffs_data_put(struct ffs_data *ffs)
 
 static void ffs_data_closed(struct ffs_data *ffs)
 {
-	struct ffs_epfile *epfiles;
-	unsigned long flags;
-
 	if (atomic_dec_and_test(&ffs->opened)) {
 		if (ffs->no_disconnect) {
+			struct ffs_epfile *epfiles;
+			unsigned long flags;
+
 			ffs->state = FFS_DEACTIVATED;
 			spin_lock_irqsave(&ffs->eps_lock, flags);
 			epfiles = ffs->epfiles;
@@ -2176,7 +2175,6 @@ static void ffs_data_closed(struct ffs_data *ffs)
 			ffs_data_reset(ffs);
 		}
 	}
-	ffs_data_put(ffs);
 }
 
 static struct ffs_data *ffs_data_new(const char *dev_name)
-- 
2.47.3


