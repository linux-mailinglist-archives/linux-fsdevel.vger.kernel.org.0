Return-Path: <linux-fsdevel+bounces-28728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF28096D8FC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 14:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFC561C22D40
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 12:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C9219E7D8;
	Thu,  5 Sep 2024 12:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/Tkv9kc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A89C19DF9C;
	Thu,  5 Sep 2024 12:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725540124; cv=none; b=i2cLRMcaZD34aX1WKcrZmqP9h2p23sGcw4ClcYWO2rpKvPhngjgvB5Kp/BM9Qc2PpXOfvd+hsBYOW6YjJwRP8zJh0IcEJ2YSFHyYqShuB8n8dHKF0duAqLgX0agQNvst9L2zjUK7OVg3RGJNJEF4gA1D8IgMg7CEtQexmE1caOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725540124; c=relaxed/simple;
	bh=ja6J3Vp2ddc2U55EFScY1qPB5F48NlxqKvOZsuJ5COo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jd7dox81d22SpKgW7aSVBOutf0JqdR9Ky1iXADtneDSJiF93VBox/N/pN4B1i+KXY2mUBy7ndXKjxuIPZz2uvuyIneLD0AdFGnNJrQ7Zg9npn1GH81qU1qkIcwKkzdXiAB/MqDmcy8/z8pYQuoL/KFbqMVPMazRoxh49w3FSYbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/Tkv9kc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD37C4CECD;
	Thu,  5 Sep 2024 12:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725540123;
	bh=ja6J3Vp2ddc2U55EFScY1qPB5F48NlxqKvOZsuJ5COo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=m/Tkv9kcwtJEZujm2rhrRQiLWllVZGGUraTDPZ/OwMRXLPbt5gPuN2Vv9YNu42xuG
	 fD5d3tQmITk7lpBNP7ewL5Dyfq7F7tIMHwR2c2/fqMF7B9VjxN5u9o0CF2ykFXjWfq
	 UryLX+lGsAZVQlS8mppDhHpmhuDvCV7DW/ocvD9TOkcb0eEpDAHt7lf86H2rRh6uRW
	 enoDNLdA4cNGW4ilbjsaGXN6WoN+9pKRk0ThsM0MVj1kIVbz7cFOXszS4xEwTuKf/J
	 qUIQotcA8V322Kvy2Bry8jCl/qfPc03U2PHPSr7voPfVheB9NdaJjlcrqpHj9YSynI
	 v/+7RieiF314A==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 05 Sep 2024 08:41:47 -0400
Subject: [PATCH v4 03/11] nfsd: don't request change attr in CB_GETATTR
 once file is modified
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240905-delstid-v4-3-d3e5fd34d107@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1238; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ja6J3Vp2ddc2U55EFScY1qPB5F48NlxqKvOZsuJ5COo=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm2acUXKobUDSBcwL+WPraGoU5+tL78vkkaCHuO
 /i5FOT5UQyJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZtmnFAAKCRAADmhBGVaC
 FUi4D/4/jIn9fln3SGA9SKRabVZf9GATgB+hqUjlnPHDHsiAAk+qs0WqWqW2evnnB0ws71IC21/
 VyBrm77gXAtnWZ17kFbmZpDTOfsqyS8gepbHGhAt4JvgJO/cVH/2ODeomL/EamlquVtoOFjwy6d
 OE3PayROPVAtFtJdoJKZQGSPcJatEFoHtwdb0GlgqIp8wYTF/YdIwv9wW/DapjfeLrWa0OERd6r
 9iwgv+6fsSgFUIGhqFAzl7yB1VL+IZx5PHMiFCbgbgEwOSZB0lMFlABR4DLi3peb1Pzih98mIBA
 O7j4gPas7LBCNq8kvERuxYuIIYqNA4loz4YQB2yyQ9+oIqovhwOcLtVEZ7TD/GAPRvpcKlE0+oI
 r1dqpUKs+0PMSb05pz5tyl8Pu8OwVSw7ptTflew7SlbY4dr4qx2iDyReSFPXEIXMY+2areRCwiD
 Gh3LxULEyeKsRVbruh3B53X+4hYl8cxsaZ8guP5aHJbO0F6VuFGgRmzs7hgZHu/iUM9N4LVnAg7
 9sk7rLqjg5/5tDomIuNH6hYJs0793INH/lm1NQzPdfIfISkmSyoNKpBV45aBCJIB20vcsx92HP1
 tSK3l16fSF7fTfHJ/8HSP5Kdb8TVtiKxHvJpSfCAWPfd46xmpMVv3EJqG5/molJcPDbGYJOWdiM
 SD8Oc6vfaUnOiRA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

RFC8881, section 10.4.3 explains that states that once the server
recognizes that the file has been modified on the client, it needn't
request the change attribute.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 0c49e31d4350..f88d4cfe9b38 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -361,13 +361,14 @@ static void
 encode_cb_getattr4args(struct xdr_stream *xdr, struct nfs4_cb_compound_hdr *hdr,
 			struct nfs4_cb_fattr *fattr)
 {
-	struct nfs4_delegation *dp =
-		container_of(fattr, struct nfs4_delegation, dl_cb_fattr);
+	struct nfs4_delegation *dp = container_of(fattr, struct nfs4_delegation, dl_cb_fattr);
 	struct knfsd_fh *fh = &dp->dl_stid.sc_file->fi_fhandle;
+	struct nfs4_cb_fattr *ncf = &dp->dl_cb_fattr;
 	u32 bmap[1];
 
-	bmap[0] = FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE;
-
+	bmap[0] = FATTR4_WORD0_SIZE;
+	if (!ncf->ncf_file_modified)
+		bmap[0] |= FATTR4_WORD0_CHANGE;
 	encode_nfs_cb_opnum4(xdr, OP_CB_GETATTR);
 	encode_nfs_fh4(xdr, fh);
 	encode_bitmap4(xdr, bmap, ARRAY_SIZE(bmap));

-- 
2.46.0


