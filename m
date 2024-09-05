Return-Path: <linux-fsdevel+bounces-28727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B80796D8F8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 14:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24C3A282625
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 12:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3E119DF70;
	Thu,  5 Sep 2024 12:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gA3kSe1j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FD919DF44;
	Thu,  5 Sep 2024 12:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725540123; cv=none; b=HdkjcnsS7KICi+wP27uSIYWC2O4jzbQ8RwzomxbSkzLoB4/9KB1rilQ7nP7+DJEqCzmxvUOs8Tir0S5zBDjJneorVdE+d89i+1pYw50dpU+VtLPhgL6g2BX37G4d4YDgfK6/jKsskuFhvcEHzhM16X8aLXtW/S0Swrei6kMfIgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725540123; c=relaxed/simple;
	bh=FIK3Y9tz3cbUOr5XRDm+FIEfZDaJjjFX1ey7q2aWYXk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A6a9UdrlKknTRvteA/E6C6PCcHPqVZnJA8vLmcutMaGHwMhkmrVFdd6NS1r/1GCIBmwWYdVfxaKxiexcRxb2M3fRPbaZWPpVR7qWqltVk7/welfhje5O4HRbofwbtkiieUDgGpMdx/dsjNN+G93xFjuFGk0wZdyS6NkL6LfJ5UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gA3kSe1j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35954C4CEC7;
	Thu,  5 Sep 2024 12:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725540122;
	bh=FIK3Y9tz3cbUOr5XRDm+FIEfZDaJjjFX1ey7q2aWYXk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gA3kSe1j0pt31UDYanRbPJzP3ebO8VOevTMt5twagYrKZiklthI4ZDUsqdKnK8zmm
	 3kUE9q2PBzwZZ28yHBgjoWihaIPVXihQHL6gZCB0rxlUnUky9xN2Auz2Aj+APEXbvQ
	 G9tlHk76OQmnkOHrKNWwHX7dFJqZcxiVz181cVdjywvF/agRt68lTolpji4qDc9nwY
	 w5DN0qWuol6bzirNmlvrHAIyUg1pE1nB1NQI7nzNBbXMvUKjBR05Vaa/n1+JS03mMa
	 vpADLlKnRjGCOh4QmMwFVuJYgzKzMZV1bWHoGyxF6+pyJYq5PZHQAN62UyCJjJxPNb
	 nvHnYQt1AI7Eg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 05 Sep 2024 08:41:46 -0400
Subject: [PATCH v4 02/11] nfsd: drop the ncf_cb_bmap field
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240905-delstid-v4-2-d3e5fd34d107@kernel.org>
References: <20240905-delstid-v4-0-d3e5fd34d107@kernel.org>
In-Reply-To: <20240905-delstid-v4-0-d3e5fd34d107@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Tom Haynes <loghyr@gmail.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2063; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=FIK3Y9tz3cbUOr5XRDm+FIEfZDaJjjFX1ey7q2aWYXk=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm2acU5X6KnGyeUbgw3A4LruEEwVtbGTv2j0E4W
 ZigCUmbM/uJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZtmnFAAKCRAADmhBGVaC
 FUYjD/9L4iwJ5Z12YrPWTlFpTaQqyKGu3YB2aeKzk+/R6CRzrbaOx1OToZdCVaS6Ltcm4rd84gR
 b8VpPBLnEJCGlXAJ0m5CwB2rGtodHcC3nulHI6GF5Hci4gGL04taqMqfDiS7dNBjHM09rdJh+ti
 jrNJNAY/FHBfZZHbSXY0dAisBtUrSHoTt6TowXmue8ZdrWosjpKj8+PoS5nJu7Xkj1IBHHMfqBp
 cw6rBt1dxeMkqG2PNYMc5XzQyIGM7SOHjHka1c1NVl6g8g72ljN2rV3FaElNb3DOlfhpic+pKjd
 PrWQDo3JB3MsedlEQChwRNkNfl7ljN/sFYo0L0OdQ5QA2AXMj8XiU5UbXvfYd6mNLR6c4VcgWI/
 mxf+hdh3BknILBWgsT8hoIZdyROLvtRJZp4VHIOEuKW3wsJPd+qdL4twDn8ZFu/IXo6EEGpE/5l
 QUmbs6z7Mv70IIcVuQn9FrY/CUqzxUvMMuXYt72goTWXyk5ew4iAKSCaucq4/o44s3HQUfGPQPt
 LJbFo6NgOqM2pcurSsuEftMa0kwygJYvjyEh2BO7jwXd7XkcFEcfNnCRrIJrM6dhdo3H/4TNBJd
 y3VgHLgWbCTw2JvqM/GXkwD8g/H/mT0NHLAE4+gYBYxH5/kz+juBjt36MuCYMKDpwLVUXVo2nrW
 SbfwRYXpy2+KHEQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This is always the same value, and in a later patch we're going to need
to set bits in WORD2. We can simplify this code and save a little space
in the delegation too. Just hardcode the bitmap in the callback encode
function.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c | 5 ++++-
 fs/nfsd/nfs4state.c    | 1 -
 fs/nfsd/state.h        | 1 -
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index b5b3ab9d719a..0c49e31d4350 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -364,10 +364,13 @@ encode_cb_getattr4args(struct xdr_stream *xdr, struct nfs4_cb_compound_hdr *hdr,
 	struct nfs4_delegation *dp =
 		container_of(fattr, struct nfs4_delegation, dl_cb_fattr);
 	struct knfsd_fh *fh = &dp->dl_stid.sc_file->fi_fhandle;
+	u32 bmap[1];
+
+	bmap[0] = FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE;
 
 	encode_nfs_cb_opnum4(xdr, OP_CB_GETATTR);
 	encode_nfs_fh4(xdr, fh);
-	encode_bitmap4(xdr, fattr->ncf_cb_bmap, ARRAY_SIZE(fattr->ncf_cb_bmap));
+	encode_bitmap4(xdr, bmap, ARRAY_SIZE(bmap));
 	hdr->nops++;
 }
 
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index db90677fc016..63b7d271cc4a 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1183,7 +1183,6 @@ alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
 	nfsd4_init_cb(&dp->dl_cb_fattr.ncf_getattr, dp->dl_stid.sc_client,
 			&nfsd4_cb_getattr_ops, NFSPROC4_CLNT_CB_GETATTR);
 	dp->dl_cb_fattr.ncf_file_modified = false;
-	dp->dl_cb_fattr.ncf_cb_bmap[0] = FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE;
 	get_nfs4_file(fp);
 	dp->dl_stid.sc_file = fp;
 	return dp;
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 79c743c01a47..ac3a29224806 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -138,7 +138,6 @@ struct nfs4_cpntf_state {
 struct nfs4_cb_fattr {
 	struct nfsd4_callback ncf_getattr;
 	u32 ncf_cb_status;
-	u32 ncf_cb_bmap[1];
 
 	/* from CB_GETATTR reply */
 	u64 ncf_cb_change;

-- 
2.46.0


