Return-Path: <linux-fsdevel+bounces-51453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88759AD7063
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 14:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A3DD3A4164
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 12:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABB5222571;
	Thu, 12 Jun 2025 12:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgyclMcr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3EA21CC71;
	Thu, 12 Jun 2025 12:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749731379; cv=none; b=ikpERcYXCCubzKwhXVrYwaNrkPkSpFhtpcZ5X1UDPKNkdYAe7NThMvxXrNYhT4Rf1qNfgHgHRGA5MqVJprDjMr/LKSgWL0queMNj5GSwjlkVy3ZQjZR94s2Mr/gycLbB4nIxGjNihzeDAR9Jvz18bHkxhH2GnhrrNd+OcOV9K3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749731379; c=relaxed/simple;
	bh=f8q5jMEiRa2BJe0fbGLHTP1NXWrvFc4OA4xnZtpofHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cL/CaCSMFvdeCsTL7BOGurkR0eKk9P1gIChCtT7+dUkbMSsTnMKJkbnIdObcE+h3cufnfve21FJxqdTQQG6p6UqcxBMmhlFvBy8G4u6CuQi85TRQkvLQlBUz4mdK2l2sXNhPl5/wJlVUhU1OOqrpvMgKIZ0Qbxgq2hIDhMVvIOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bgyclMcr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3913CC4CEEA;
	Thu, 12 Jun 2025 12:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749731378;
	bh=f8q5jMEiRa2BJe0fbGLHTP1NXWrvFc4OA4xnZtpofHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bgyclMcrSsdvBueKehvHrUS90TrLARwDtljEDyd425C9aYOaD8jojrC3Cs+vOyacl
	 xP8RKzsbH8JtjpLi1HR16LyIr8lEPwDX2hIg3txLpnJSIsiNeaqrZy+bWCXC0Vgmld
	 kbwuFL943evGLh3kMwBuuXtmJoobRJJhvWk8mT8pxWNhZDuV7KnmdHZAMhlrAh3TjZ
	 6CFWWnnj0ZqwUbmQ5XEe2YVWurHaXVZS84MTgkqCxP8DY49wXK6XRQZAOxiFryyD+A
	 kFpjYj1qJVRGqsIPf6bIvAK/5HOCBQMb6D6GXj79M/gPGj52OyZxlldRlw8HGSF+/J
	 6v5C/KZzi88NA==
From: Christian Brauner <brauner@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: unlock the superblock during iterate_supers_type
Date: Thu, 12 Jun 2025 14:27:51 +0200
Message-ID: <20250612-metaphorisch-komponente-1c128ba41a57@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250611164044.GF6138@frogsfrogsfrogs>
References: <20250611164044.GF6138@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=989; i=brauner@kernel.org; h=from:subject:message-id; bh=f8q5jMEiRa2BJe0fbGLHTP1NXWrvFc4OA4xnZtpofHc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR4ndB5uuHZDzZDnawWoRe2mecutNxIsTboZol5w1Sse a1avKuwo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCK5vIwMJ0PLfB2ZnkZH3Ltl X5JZ+5yNZ5va3+W2c+/zrDgaLX6mk5HhM6vpywl7xf68WDFrgqKC2PqFc+5vc/l2Ttj6BsON7BN svAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 11 Jun 2025 09:40:44 -0700, Darrick J. Wong wrote:
> This function takes super_lock in shared mode, so it should release the
> same lock.
> 
> 

https://youtu.be/m6uvv1aS5_I?si=8e0DYW802X30y2UM&t=224

---

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] fs: unlock the superblock during iterate_supers_type
      https://git.kernel.org/vfs/vfs/c/0b9d62a47149

