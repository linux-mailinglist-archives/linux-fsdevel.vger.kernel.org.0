Return-Path: <linux-fsdevel+bounces-42559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 455E3A43B36
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 11:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6364116BF1C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 10:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51E6266190;
	Tue, 25 Feb 2025 10:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mi6WMTgg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D1D254858
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Feb 2025 10:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740478602; cv=none; b=iQ+G08ShmYb84RG8uQZVGlwbkV+t0ChMKRKURIvs/8hHtp51SCEAreNkp5gQshkLb/AKp/1014tHuWthE6HXx+EM7ssTLFp9FHwBcYwk8KtF51eILxQO4ZcyGeHoqb7cMIST+PuRQ8a1/nb8hzjgY2ceB781aEiYeIxOTkxE0BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740478602; c=relaxed/simple;
	bh=Epmt+GiEPdBBXcHA8mLkD/JF3FNyxy5Qws8fmtU+2S4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pOXgQ/vPjUz9BW+RrpHza+qgDo2XfjRxQH7FNFDnD+LGHbFTT/VMKE7l/fjHVOiUuiTqOnTUp5evmnVZDEnmURM4iWzo7f7/1/8cWQKS0m+8B8Ed/CS6ZxCNTQX9Yh2x6kefszvIT7voHZ9wDLbcnE7huxx1TAcZwb42EwlZDpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mi6WMTgg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14936C4CEDD;
	Tue, 25 Feb 2025 10:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740478599;
	bh=Epmt+GiEPdBBXcHA8mLkD/JF3FNyxy5Qws8fmtU+2S4=;
	h=From:Subject:Date:To:Cc:From;
	b=Mi6WMTggrZcWn0ZTDphIMitJWWJ3DDaok2zgq8e2jl7Wtd3utEO+/Lo/ArpSQDRuJ
	 qeiEjMG0TvNP4uJXywO5g5gt+peRPsr2ZplAfGVP6pqDg0oo3512vyPtOpS72GFN0O
	 gzD/2nA/4nkmEYwuUcSTHfD/ezTc8dtltAaRwtvo3PVEaCTeLu+5Q0fRjtkUu1Jyip
	 CiiKGCNO+gDVopQy75t7mnNekvP7aYkynyfWxUPwsLZiWdOqxq+7RjMHdl4In+xFZc
	 MRcrKOszIRDRKPe+moOgscAy348bSQb7TFIwg1gLcfNKzgGW2CX0SqBw9ou+S5spTG
	 Z+gThNyp94ChA==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/3] mount: handle mount propagation for detached mount
 trees
Date: Tue, 25 Feb 2025 11:15:45 +0100
Message-Id: <20250225-work-mount-propagation-v1-0-e6e3724500eb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFGYvWcC/0WPQW7CMBBFrxJ53YlsJxPiqEK9R4UqxwzBUNvBT
 tKqiLvXAaou/+I9vX9liaKlxLriyiItNtng8xAvBTNH7QcCu8+bSS6RS4nwFeIZXJj9BGMMox7
 0lBHoe8SNUXKPXLEMj5EO9vsuft/l3etE0EftzXHVLYcETSmwvJtKrx2lURt6opEuc06ZHvx/S
 Vfkjlpw3q6u2VOEMJL/mCIRmErqhlpCValuEasqW5N+kq+PC1yJFlFW5aZGhQ0IcKdh/rHnt8F
 p+1ma4LbsLzgPZ6euWHJrDdEItrvdfgFINWHwNAEAAA==
X-Change-ID: 20250225-work-mount-propagation-bb557c92d509
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Seth Forshee <sforshee@kernel.org>, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1966; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Epmt+GiEPdBBXcHA8mLkD/JF3FNyxy5Qws8fmtU+2S4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTvndH6Qn1nRua352+SJyb9lQjdGLnNIbR6RuNH5zjLW
 T8U3jOEdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwk+zAjw6atNwzcA5a4smq/
 PxEVI5qQwaKWudsvLTzq2dX7t1J+r2H4K7ZwFU/HUv2cyQ4XdA4/6+NbWXz8yKSl4lEfCi8cV85
 X5QUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

In commit ee2e3f50629f ("mount: fix mounting of detached mounts onto
targets that reside on shared mounts") I fixed a bug where propagating
the source mount tree of an anonymous mount namespace into a target
mount tree of a non-anonymous mount namespace could be used to trigger
an integer overflow in the non-anonymous mount namespace causing any new
mounts to fail.

The cause of this was that the propagation algorithm was unable to
recognize mounts from the source mount tree that were already propagated
into the target mount tree and then reappeared as propagation targets
when walking the destination propagation mount tree.

When fixing this I disabled mount propagation into anonymous mount
namespaces. Make it possible for anonymous mount namespace to receive
mount propagation events correctly. This is no also a correctness issue
now that we allow mounting detached mount trees onto detached mount
trees.

Mark the source anonymous mount namespace with MNTNS_PROPAGATING
indicating that all mounts belonging to this mount namespace are
currently in the process of being propagated and make the propagation
algorithm discard those if they appear as propagation targets.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (3):
      mount: handle mount propagation for detached mount trees
      selftests: add test for detached mount tree propagation
      selftests: test subdirectory mounting

 fs/mount.h                                         |   7 +
 fs/namespace.c                                     |  42 ++++--
 fs/pnode.c                                         |  10 +-
 fs/pnode.h                                         |   2 +-
 .../selftests/mount_setattr/mount_setattr_test.c   | 151 +++++++++++++++------
 5 files changed, 146 insertions(+), 66 deletions(-)
---
base-commit: 379487e17ca406b47392e7ab6cf35d1c3bacb371
change-id: 20250225-work-mount-propagation-bb557c92d509


