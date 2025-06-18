Return-Path: <linux-fsdevel+bounces-52127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 301EAADF81F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 22:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1FC717D89E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 20:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F72621D3E9;
	Wed, 18 Jun 2025 20:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6lMwuWa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF00B21CFF4
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 20:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750280054; cv=none; b=VfHlSYjLOxCiU94MaiHCc9aj5HKXCys00/fnBQ+Mzztt8OpH112u16FVwZIcYKEKpuAG4Eazek65rijEDjYXnXQbs0GVjXzdHQYqDA5D+ikLPRqQQ9c+f/Ky1/nWe+T94AwSKmH8iVsbd0mHYSxJtOv1PJh/meilPmLzeaMSXWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750280054; c=relaxed/simple;
	bh=tSueqbIo5XZ1ClXzI2K64feHlZw606X2skUm4LCPNuc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d7OgglXDZZ8d/F1v51KEuleSY7n3S9yOdqM9Ilne6+M00Ukmx+F3Pg5OZBvvW401eJ2EruY46n8yWvXe9fV3Oxuze2zIaANhQ7X3v7wLvxc9u+9qa4lWSwyEjtOxaw3jzL3h9Lnkp+yeizfl2xcz1auNyozmy2SlkbQhP8au9vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6lMwuWa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B6BC4CEE7;
	Wed, 18 Jun 2025 20:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750280054;
	bh=tSueqbIo5XZ1ClXzI2K64feHlZw606X2skUm4LCPNuc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=D6lMwuWa2i2uaEvh7sh1ZMLwH6TDQkeIZM+NzqT9EK/HYcMdd17zEJKYKpfRsB6fO
	 i78D3dY7sL3r7+O1YRewFx4ttKaDziYRXEGHs2BlyUheFVNfFs6IDYCDaVOwhlcn6i
	 7rYxcieKYi4SuvstaUI5SvpLH2xxvqPMQVpMkYhjZu+Z0+8cHoXd2HyRaJy9C8+G4w
	 OOYqQgRLptjePAvh1jr8Y8BKs9E2iURQj6NriiD7QH24cmdGcbVz7OweqZxXccCldn
	 gOXaDCT8IwOMIyFj17hqmkQW3EA+jDd2K2JW2AP3BJCqftGRKxTIz+q8QfrVltoQSy
	 +l3xWNzs33WZg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 18 Jun 2025 22:53:44 +0200
Subject: [PATCH v2 10/16] libfs: prepare to allow for non-immutable pidfd
 inodes
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-work-pidfs-persistent-v2-10-98f3456fd552@kernel.org>
References: <20250618-work-pidfs-persistent-v2-0-98f3456fd552@kernel.org>
In-Reply-To: <20250618-work-pidfs-persistent-v2-0-98f3456fd552@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-262a7
X-Developer-Signature: v=1; a=openpgp-sha256; l=577; i=brauner@kernel.org;
 h=from:subject:message-id; bh=tSueqbIo5XZ1ClXzI2K64feHlZw606X2skUm4LCPNuc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQEq0cu5WuPuyOyJK6561bLb6Ho0/fF2PX/K6/N2VTEe
 8sjtVG1o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCJiFQz/NJ0UNB05Lv3sjrKa
 V3H9TOi9v/ZHeBV+dkZG73H2WzY/l+GvtKQES/iC/fOm/UutupM4fd8vw8QbSq0XXk59s1nsVut
 fFgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Allow for S_IMMUTABLE to be stripped so that we can support xattrs.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/libfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 997d3a363ce6..c5b520df9032 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -2162,7 +2162,6 @@ static struct dentry *prepare_anon_dentry(struct dentry **stashed,
 
 	/* Notice when this is changed. */
 	WARN_ON_ONCE(!S_ISREG(inode->i_mode));
-	WARN_ON_ONCE(!IS_IMMUTABLE(inode));
 
 	dentry = d_alloc_anon(sb);
 	if (!dentry) {

-- 
2.47.2


