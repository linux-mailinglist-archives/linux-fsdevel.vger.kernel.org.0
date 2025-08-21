Return-Path: <linux-fsdevel+bounces-58438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC86FB2E9C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 02:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82C851CC32A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 00:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9CF1E7C23;
	Thu, 21 Aug 2025 00:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3HcmuW0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9A218991E
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 00:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755737503; cv=none; b=qy5FeJAK6UHk8L2TMarQhdKVl1NP+bw1dzJLBmLnaEy8BSzedF2UNxl/ztHolW0t/1M4PLo2rAEAevhk39H5CVBvxVqF7Ar+NJVg8uxnT9jcCWAUqdr8t9S8Uy1T6d509LOxVkuEm1glTDe5nZ5wCGhddPOWNJY8oQORhIUieH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755737503; c=relaxed/simple;
	bh=PBG9o2bAc/Fbq4+TUo+ZsFaPuOM/gK17C8GHOGq1R+k=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X+cHnlapGOiZl94gitcdq8yAt0i/l1o2sl3leIeEmFJDwJ+IB3RH1y9bBedY/B1xFuYIfVpk9SQx2lodlqMnYRnRx+wc3fB8l0GA4/GHCkyGjx4NQcIzuruEft3LubpTA9lOslCVsbwHWaQpXEBOGcHbd4lsx92LdTPt6yGW39A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3HcmuW0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7528BC4CEE7;
	Thu, 21 Aug 2025 00:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755737503;
	bh=PBG9o2bAc/Fbq4+TUo+ZsFaPuOM/gK17C8GHOGq1R+k=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=B3HcmuW0GcXCM6n5nBIZjtoKu+5WUC3f9h61knt1mzh1iEpmOBR3brqnsucD5iZmV
	 H2tLKf3qyJo16WHCZndypfCooQg+Kf6uswjZoocMX0A+I1VYjrh2sy7hC2YJkRbuXP
	 1QNRe3NN3v/0u8T1I6Mr20miwyszS8+Jr+QeYFhWXODEP11lCnJxUryUqe4n6hckYP
	 ldHfg6lsuWSo8h7kKO5mBspDO99IqBHWQUOhXrMHsWCQ+ewaTZMaVTji5SQCy1Dy/S
	 BSsJ61ynzK7XsFXAO9vcJuSJfRBX1cVplS35otcN6oF1h4kEMpUHmg7bL5kPOo8GFo
	 odPuFGTaKtGHQ==
Date: Wed, 20 Aug 2025 17:51:43 -0700
Subject: [PATCH 4/7] fuse: implement file attributes mask for statx
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <175573708630.15537.1057407663556817922.stgit@frogsfrogsfrogs>
In-Reply-To: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs>
References: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Actually copy the attributes/attributes_mask from userspace.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h |    4 ++++
 fs/fuse/dir.c    |    4 ++++
 fs/fuse/inode.c  |    3 +++
 3 files changed, 11 insertions(+)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 2b5d56e3cb4eaf..bb1fdae0bbc906 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -140,6 +140,10 @@ struct fuse_inode {
 	/** Version of last attribute change */
 	u64 attr_version;
 
+	/** statx file attributes */
+	u64 statx_attributes;
+	u64 statx_attributes_mask;
+
 	union {
 		/* read/write io cache (regular file only) */
 		struct {
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 2d817d7cab2649..2e4d1131ab8cbe 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1278,6 +1278,8 @@ static int fuse_do_statx(struct mnt_idmap *idmap, struct inode *inode,
 		stat->result_mask = sx->mask & (STATX_BASIC_STATS | STATX_BTIME);
 		stat->btime.tv_sec = sx->btime.tv_sec;
 		stat->btime.tv_nsec = min_t(u32, sx->btime.tv_nsec, NSEC_PER_SEC - 1);
+		stat->attributes = sx->attributes;
+		stat->attributes_mask = sx->attributes_mask;
 		fuse_fillattr(idmap, inode, &attr, stat);
 		stat->result_mask |= STATX_TYPE;
 	}
@@ -1381,6 +1383,8 @@ static int fuse_update_get_attr(struct mnt_idmap *idmap, struct inode *inode,
 			stat->btime = fi->i_btime;
 			stat->result_mask |= STATX_BTIME;
 		}
+		stat->attributes = fi->statx_attributes;
+		stat->attributes_mask = fi->statx_attributes_mask;
 	}
 
 	return err;
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index b3b0c0f5598b4a..463879830ecf34 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -287,6 +287,9 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 			fi->i_btime.tv_sec = sx->btime.tv_sec;
 			fi->i_btime.tv_nsec = sx->btime.tv_nsec;
 		}
+
+		fi->statx_attributes = sx->attributes;
+		fi->statx_attributes_mask = sx->attributes_mask;
 	}
 
 	if (attr->blksize != 0)


