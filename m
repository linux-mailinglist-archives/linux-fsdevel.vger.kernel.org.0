Return-Path: <linux-fsdevel+bounces-29002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F7E972BF8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 10:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98AEA1C21315
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 08:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F42391885BD;
	Tue, 10 Sep 2024 08:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWAtWqFf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAEF188A09
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2024 08:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725956221; cv=none; b=ore7ZKdiyf/cXgO7pwk2QirJVaaJn7BLmTVSfzfNspvaHnbvKWkOHkVlfy6Yltmg5Onr4gxnWg0u682dDT/yfulJ9hqQwsx2PIrr97+2eT5Wu/DBUD7Q+ym/O6+j2XRVBRBT0cOM3fWSpODm+lm+SYI4Tfne7OGejL7QgOWs92w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725956221; c=relaxed/simple;
	bh=Ax3FSu+eM0ahQykVWyAhQcTth5KtTKnVJoZ9VhIeyc4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sm1zr5M3H+IIvj8z6m5Lc7ffVBm77uYO+de4z7NbOH57hTkEugaQYUE336ISghtmJf2zPh+028MFMlUUUJ3dXVrm/hEm0cqw8HSNWYaeKorc7ogvSbH6m0ZywlB2fzTuPJxd6ISc8CnC6fsS49lgIctWHO58U2IT0KXesUOJ0iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWAtWqFf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39FF5C4CEC3;
	Tue, 10 Sep 2024 08:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725956220;
	bh=Ax3FSu+eM0ahQykVWyAhQcTth5KtTKnVJoZ9VhIeyc4=;
	h=From:Date:Subject:To:Cc:From;
	b=fWAtWqFfJpjO0xUjlZR2mN/yVyF5D3Jzw7+GlNV/U5uP4u6KccNiilrYjaf12Hg3V
	 wjdKkZlK/kQSgadogshvOVHPmWZaCkrj360sd7bseTV0B8dvwN+JEzxt01qRDnuHTB
	 774M9mdAygWo8brHhBT18lvecToTOgAkT10OndRfw0HnZd03sxiF1/khWYt4eAt4WT
	 fIYTJw7vbm8VRC3HhRMMwK5/Q0HyZVQCyA3024P+PjdaaDaSUucb5Mz5eQdaohO21n
	 qmoT2VvyEH7zM/D5arz30WFTAzwolvEIhpJhhogshwfpgKK3NCXV/K83807B3Lk0X7
	 Ao4yNzPEb3E9Q==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 10 Sep 2024 10:16:39 +0200
Subject: [PATCH] uidgid: make sure we fit into one cacheline
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-work-uid_gid_map-v1-1-e6bc761363ed@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGYA4GYC/x3MQQqDQAyF4atI1p0yI2Jpr1JKycSooThKgrYg3
 r1pF2/xLd6/g7EKG9yqHZQ3MZmLI50qoBHLwEE6N9SxbuI1xfCe9RVW6Z6Db8IlEHHTInPKlxb
 8tij38vkn7w93RuOQFQuNv9DW23kSIziOL6nO2859AAAA
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
 Amir Goldstein <amir73il@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=4133; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Ax3FSu+eM0ahQykVWyAhQcTth5KtTKnVJoZ9VhIeyc4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ9YKha/nMpR9TRuj+2ghbl2mnMH6ZfecX2fKLGVi0Gw
 TRJtmetHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABM5Zszw36fkzdvjZ/YUS/Yd
 nna6Xybsoqn31XlPK3U9kq1iDtxzmszIMFvm/ZHJ23cE3HgYt3VRmT0316y9ilyXTxVFb1wxZdU
 5TS4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

When I expanded uidgid mappings I intended for a struct uid_gid_map to
fit into a single cacheline on x86 as they tend to be pretty
performance sensitive (idmapped mounts etc). But a 4 byte hole was added
that brought it over 64 bytes. Fix that by adding the static extent
array and the extent counter into a substruct. C's type punning for
unions guarantees that we can access ->nr_extents even if the last
written to member wasn't within the same object. This is also what we
rely on in struct_group() and friends. This of course relies on
non-strict aliasing which we don't do.

99) If the member used to read the contents of a union object is not the
    same as the member last used to store a value in the object, the
    appropriate part of the object representation of the value is
    reinterpreted as an object representation in the new type as
    described in 6.2.6 (a process sometimes called "type punning").

Link: https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2310.pdf
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Before:

struct uid_gid_map {
        u32                        nr_extents;           /*     0     4 */

        /* XXX 4 bytes hole, try to pack */

        union {
                struct uid_gid_extent extent[5];         /*     8    60 */
                struct {
                        struct uid_gid_extent * forward; /*     8     8 */
                        struct uid_gid_extent * reverse; /*    16     8 */
                };                                       /*     8    16 */
        };                                               /*     8    64 */

        /* size: 72, cachelines: 2, members: 2 */
        /* sum members: 68, holes: 1, sum holes: 4 */
        /* last cacheline: 8 bytes */
};

After:

struct uid_gid_map {
        union {
                struct {
                        struct uid_gid_extent extent[5]; /*     0    60 */
                        u32        nr_extents;           /*    60     4 */
                };                                       /*     0    64 */
                struct {
                        struct uid_gid_extent * forward; /*     0     8 */
                        struct uid_gid_extent * reverse; /*     8     8 */
                };                                       /*     0    16 */
        };                                               /*     0    64 */

        /* size: 64, cachelines: 1, members: 1 */
};
---
 include/linux/user_namespace.h | 6 ++++--
 kernel/user.c                  | 6 +++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 6030a8235617..3625096d5f85 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -21,9 +21,11 @@ struct uid_gid_extent {
 };
 
 struct uid_gid_map { /* 64 bytes -- 1 cache line */
-	u32 nr_extents;
 	union {
-		struct uid_gid_extent extent[UID_GID_MAP_MAX_BASE_EXTENTS];
+		struct {
+			struct uid_gid_extent extent[UID_GID_MAP_MAX_BASE_EXTENTS];
+			u32 nr_extents;
+		};
 		struct {
 			struct uid_gid_extent *forward;
 			struct uid_gid_extent *reverse;
diff --git a/kernel/user.c b/kernel/user.c
index aa1162deafe4..f46b1d41163b 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -36,33 +36,33 @@ EXPORT_SYMBOL_GPL(init_binfmt_misc);
  */
 struct user_namespace init_user_ns = {
 	.uid_map = {
-		.nr_extents = 1,
 		{
 			.extent[0] = {
 				.first = 0,
 				.lower_first = 0,
 				.count = 4294967295U,
 			},
+			.nr_extents = 1,
 		},
 	},
 	.gid_map = {
-		.nr_extents = 1,
 		{
 			.extent[0] = {
 				.first = 0,
 				.lower_first = 0,
 				.count = 4294967295U,
 			},
+			.nr_extents = 1,
 		},
 	},
 	.projid_map = {
-		.nr_extents = 1,
 		{
 			.extent[0] = {
 				.first = 0,
 				.lower_first = 0,
 				.count = 4294967295U,
 			},
+			.nr_extents = 1,
 		},
 	},
 	.ns.count = REFCOUNT_INIT(3),

---
base-commit: 698e7d1680544ef114203b0cf656faa0c1216ebc
change-id: 20240910-work-uid_gid_map-cce46aee1b76


