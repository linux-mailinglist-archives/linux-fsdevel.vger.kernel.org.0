Return-Path: <linux-fsdevel+bounces-1971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 121A17E0FC7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Nov 2023 15:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D2DD281DA4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Nov 2023 14:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF301A58F;
	Sat,  4 Nov 2023 14:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fvndulxi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CEE3D6C
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Nov 2023 14:00:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B9FC433C8;
	Sat,  4 Nov 2023 14:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699106432;
	bh=0Gf7bBJoh0XOjHaD8JAvE8qNXrz5KO5PpGEoAy93VdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FvndulxiNFvNYeUzmFBPXT6PVJjdFWGEFYBBPp82d82FF7ERvn+I3VxLtXx9jOoKT
	 d+Ah9RPJixVwI1kgoqx67liiRbtgEjxg1JtsCT9YAL5G1BWIEkdGO3HxvTy/kPkIUM
	 +yv1JbJlVlHsbKOkcgcKSVv9MItnYQu4WaW94QXxQvfaPMVvMCbf3oIYOjGcb+jwFc
	 vkBKhBnEa670g7RBFFNcAoSSDpSJBfXkmTaMXTGwzbgm1VlidJ+eB5fdaCxVdMV6PX
	 uKyVq0uasNqN8kBzk/1ntp+HVEvCySkTTeauSuBtiu9zQ5xiACdqNPNcfAN18qNQuz
	 AIkF4j4eZxoIw==
From: Christian Brauner <brauner@kernel.org>
To: Dave Chinner <dchinner@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Chandan Babu R <chandanbabu@kernel.org>
Subject: [PATCH v2 0/2] Handle multi device freezing
Date: Sat,  4 Nov 2023 15:00:11 +0100
Message-Id: <20231104-vfs-multi-device-freeze-v2-0-5b5b69626eac@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <87bkccnwxc.fsf@debian-BULLSEYE-live-builder-AMD64>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13-dev-26615
X-Developer-Signature: v=1; a=openpgp-sha256; l=645; i=brauner@kernel.org; h=from:subject:message-id; bh=0Gf7bBJoh0XOjHaD8JAvE8qNXrz5KO5PpGEoAy93VdU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS6+aV+m19sfWTDnRIO/3fnnEQKXsy7xqB9nJun5PL7KsWW 6d7NHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNR+sPwVzZodn5QA+ue7IMTjzrKek 9hXDdr96yWSz9c1z1/tI63pYqR4RbXz716Eyc/8VxfUfbqZ0ob40Uvv8gAPrZPIrE/Gj5f5gcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey everyone,

Now that we can find the owning filesystem of any device if the
superblock and fs_holder_ops are used we need to handle multi-device
filesystem freezes. This series does that. Details in the main commit.

Thanks!
Christian

---
Christian Brauner (2):
      fs: remove dead check
      fs: handle freezing from multiple devices

 fs/super.c         | 140 +++++++++++++++++++++++++++++++++++++++++------------
 include/linux/fs.h |  17 ++++++-
 2 files changed, 124 insertions(+), 33 deletions(-)
---
base-commit: c6a4738de282fc95752e1f1c5573ab7b4020b55e
change-id: 20231103-vfs-multi-device-freeze-506e2c010473


