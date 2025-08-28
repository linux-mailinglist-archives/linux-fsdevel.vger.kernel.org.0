Return-Path: <linux-fsdevel+bounces-59583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCEEB3AE3B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D8785E2321
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1302FF167;
	Thu, 28 Aug 2025 23:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="VtwfWQhU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D512F2913
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422499; cv=none; b=Dqeh5AJwVYA8sn3hSLcDj83jQlpFAst3VMlaPRfClGFNNJz1AELm5Hg9CkjWYvygPpJsYUX8vSL4bw3Y1faVdz5eOWWDMS5Ti0dMmAg/4t6Lcc6OrDjDTDlCoUJ7cmlj2pAKtg57Ixwp9sDsytHG4dn4Kqj0NPAN/wyTqE6tknc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422499; c=relaxed/simple;
	bh=HkkuZdnzxamJstoAjSUjt9XAqCjOYBJaOGGN3gI4ZEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VEh182GFla3I14RNBTatmK8JsWsvi+G9FVTG2QhumAUmmEVVwdzRgkUqb1DYvPhb5GXP97U2ROw/BkuD+jgOPDJXfGYwfjbZu0s5E4EefYIh0OPj3Xts/shFTpZkyuOs969PywD4x81ejVRrgC7F9pKIc3jXt7j6SUTLI2gFsko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=VtwfWQhU; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Pm8H9/UsKEMBBtZrPmRb6OVWKPmYm7uMFFMEurqfnyA=; b=VtwfWQhUGREKYuAdIuHdxwva+k
	vy9xtE0STdjdhVe0vCFV8CnYDrkkBZhFzDxtaBccAWzUVSHBfIs13ICnfxs5Cx5TUjzAZ7NS/meE5
	Ey/Ud/Pa8EonQa3AVuQqMFLt3V6bBewXEZIflYMlLJ+EX38LRbpdRcxGXpmSwrf4rqKR+XyXRVWJo
	3rnkpM1nYF+4jjZ4s9sXNyYRL0DLr3J2go5LwMU8aarH5R2RD9MfHKDSy4lmFaVkcYWhPBqrInaBi
	tiBuXII/qKmIDHZPGM8LufQLv8bKyKW3LngcDBZaiuEgoZfRoi0K9ve4u9Nm1Xwh9Vlu+T1lOtNGA
	tBfimQ8A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urlj3-0000000F291-3eAs;
	Thu, 28 Aug 2025 23:08:13 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 48/63] constify can_move_mount_beneath() arguments
Date: Fri, 29 Aug 2025 00:07:51 +0100
Message-ID: <20250828230806.3582485-48-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index a14cb2cabc1a..daca5e3bec38 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3472,8 +3472,8 @@ static bool mount_is_ancestor(const struct mount *p1, const struct mount *p2)
  * Context: This function expects namespace_lock() to be held.
  * Return: On success 0, and on error a negative error code is returned.
  */
-static int can_move_mount_beneath(struct mount *mnt_from,
-				  struct mount *mnt_to,
+static int can_move_mount_beneath(const struct mount *mnt_from,
+				  const struct mount *mnt_to,
 				  const struct mountpoint *mp)
 {
 	struct mount *parent_mnt_to = mnt_to->mnt_parent;
-- 
2.47.2


