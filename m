Return-Path: <linux-fsdevel+bounces-46374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF81FA88435
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 16:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6B9C442164
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 14:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F41288CA7;
	Mon, 14 Apr 2025 13:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxLmT5+q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1827F253941
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Apr 2025 13:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637706; cv=none; b=e6QJUhoMXaifbZc2UBeOBfV1TJxH9bmAWAVhikutYW0m12JkScw/UCF8vB0l8/8Ead6ENCMCaq+VNZs/ajLaRrPkJZ8ptMHj7PEadZFRmSczAspGP0ZFclpm6ppSfWhqSosND8Mb3ytUMo9VtTQpKRrj/nkewADoGXjGOAl9H9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637706; c=relaxed/simple;
	bh=Fq0eHMOFh0PKwWKYQvZtaJMwPmz8CIPRnLpdObCVxFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EImlzezIYSRZ7+nKI/eNmjKlpVu5JKKXMK9kKzU7HaWXySLaaCncz1Bi7b4teBjj4QdMcj8hSmN3xwEkNNVCCB6Vel2KmyaP+pNPEuh/o3Zx3hio7oNFIvO4aGsmapFIW2QUnmj11JN/RMU6yKwKo2VHwU58mv1FgWSVzWrSpSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxLmT5+q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC307C4CEE2;
	Mon, 14 Apr 2025 13:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637705;
	bh=Fq0eHMOFh0PKwWKYQvZtaJMwPmz8CIPRnLpdObCVxFQ=;
	h=From:To:Cc:Subject:Date:From;
	b=BxLmT5+qtMHOBvCJzG5viRXG+Yi14pI3PG4LIOeVx6iAd/dt0agfZ8oepJ5qBDplY
	 bkt8BAaH5fgxsfcSHhN5zYJhnqKTVOjwsFcE21dW9ybXvKbKGpiTwXZes/jL/0uEeO
	 SKEdwLDmB/tkV1YgmJDxLGcCAWL8v+izjIoxXzMg90tahEU9v6TR+1aadHeD8Io/Ox
	 P6E74BQP6+BoQ4AQzw2NaYS+QJiAj/pICTYlYsRPgQN1Aw0BZILseTm+cSspqWoCYl
	 pGgDbvAAIKUMqu7WMwPCw6Jxtlh+6KI9coFP6dObgwBZTW0IDzPi99QxwFz6Ka0puL
	 Dyi+EUmGlMkSg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Can we remove the sysfs() system call?
Date: Mon, 14 Apr 2025 15:34:53 +0200
Message-ID: <20250414-gefangen-postkarten-3bb55ab4f76a@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=318; i=brauner@kernel.org; h=from:subject:message-id; bh=Fq0eHMOFh0PKwWKYQvZtaJMwPmz8CIPRnLpdObCVxFQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT/5Wdx8I3W1rUP3vf0snWcQGA15w7x3BN3d9ssef1za 3vPWeH3HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPhvMTw33HPqvUO30rVzSP5 qgyPnJK/uaBSd8uOncmFm7K2Nq2S2MLI8JhZsLrHenLZPwHPTSut7nR4l00TzzMyFO5q3LSsMza EBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

we've been carrying sysfs() around since forever and we marked the
sysfs() system call as deprecated in 2018 iiuc.

Should we try and get rid of this odd system call or at least flip the
config switch to default to N instead of Y?

(Another candidate that comes to mind is uselib().)

Christian

