Return-Path: <linux-fsdevel+bounces-42719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5EFA46AC8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 20:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58AB27A3743
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 19:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3230523906A;
	Wed, 26 Feb 2025 19:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3JXSo/F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E9A16F288;
	Wed, 26 Feb 2025 19:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740597530; cv=none; b=Z1b6goK+YoQsc4z6lKxqDLfKfnjGeW/sugExNWzyO4pIjEm60ubplKpixx4hTVKvBXOaFdhY6vYc9Vru6OX2LVQ8LbYxtZrv1Xx3DFDBUxEZCEkBaAz2tM0+D8ZR6YGih+6mZ8zJJrB2+mBBCl0RRBIZQmTA14HLeazhLvljF5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740597530; c=relaxed/simple;
	bh=QgPAVRTgYUBrEUPMdXppizcxpUf4EXczI2jYn99np3o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CkczQBpjSKGmU9+69v3pdq8av2Z8sfFIf24wbpUg3WnqK2B/AjnxYfGATWSvWwMKgVnuls2G9+4iU2C/ZzzVagIg9jxXSzXFMZH97rgeeJxoNxghef41ReUNV5xAl6+LpIkfet7PTplJbJA47JIsiU78juAsYYFCaVMAp/NFRPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3JXSo/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF823C4CED6;
	Wed, 26 Feb 2025 19:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740597530;
	bh=QgPAVRTgYUBrEUPMdXppizcxpUf4EXczI2jYn99np3o=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=c3JXSo/FWC+bMJ7hxDavbNlwTbRX59iihfEaqXnAuB1OVNq0Y4nc5+Kg4pFwPryeu
	 mpy8CH0bIbsUQm/r0tCnsELIBt5EU6pSs6qo4k2V5wYh+iTHMh/IDYWpx1/qVDUE5w
	 bcMBNRd5IqqnD6B9rLwP64uo3oyZqwowryOWfLOERZhszxWFzdxpHWHXJJV3z1CIB8
	 PlENqY0rCdC+PpSBa4XAPLtfa2gexJmbXGjEjgZ9/u/jg2+cD3LDltoE6YpB9DCru6
	 AJe6JtmVTqisfm9PuYt4fsSWqqqms1VujLJUG22t+QeG2hMv+/AAaDyLzcNz0OiA3I
	 R3G6MIX7Pi7ZQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 86BFACE04E3; Wed, 26 Feb 2025 11:18:49 -0800 (PST)
Date: Wed, 26 Feb 2025 11:18:49 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	sfr@canb.auug.org.au, linux-next@vger.kernel.org
Subject: [PATCH RFC namespace] Fix uninitialized uflags in
 SYSCALL_DEFINE5(move_mount)
Message-ID: <e85f9977-0719-4de8-952e-8ecdd741a9d4@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The next-20250226 release gets an uninitialized-variable warning from the
move_mount syscall in builds with clang 19.1.5.  This variable is in fact
assigned only if the MOVE_MOUNT_F_EMPTY_PATH flag is set, but is then
unconditionally passed to getname_maybe_null(), which unconditionally
references it.

This patch simply sets uflags to zero in the same manner as is done
for lflags, which makes rcutorture happy, but might or might not be a
proper patch.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: <linux-fsdevel@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
---
 namespace.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index 663bacefddfa6..80505d533cd23 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4617,6 +4617,7 @@ SYSCALL_DEFINE5(move_mount,
 	if (flags & MOVE_MOUNT_BENEATH)		mflags |= MNT_TREE_BENEATH;
 
 	lflags = 0;
+	uflags = 0;
 	if (flags & MOVE_MOUNT_F_SYMLINKS)	lflags |= LOOKUP_FOLLOW;
 	if (flags & MOVE_MOUNT_F_AUTOMOUNTS)	lflags |= LOOKUP_AUTOMOUNT;
 	if (flags & MOVE_MOUNT_F_EMPTY_PATH)	uflags = AT_EMPTY_PATH;
@@ -4625,6 +4626,7 @@ SYSCALL_DEFINE5(move_mount,
 		return PTR_ERR(from_name);
 
 	lflags = 0;
+	uflags = 0;
 	if (flags & MOVE_MOUNT_T_SYMLINKS)	lflags |= LOOKUP_FOLLOW;
 	if (flags & MOVE_MOUNT_T_AUTOMOUNTS)	lflags |= LOOKUP_AUTOMOUNT;
 	if (flags & MOVE_MOUNT_T_EMPTY_PATH)	uflags = AT_EMPTY_PATH;

