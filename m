Return-Path: <linux-fsdevel+bounces-69082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C15A0C6E356
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 12:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B4B404F0984
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 11:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C834D351FD7;
	Wed, 19 Nov 2025 11:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Br7yU9x5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2410029ACD1
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 11:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763551080; cv=none; b=VPlKQdcQCwMrlQ1KB+8HiiuLHnrLYUQNqfMO9M1Pk6n6EKZ2dYWiB8AUm9Q4ZQVxJ3AKRfyRUeQxuOopXksx1iAP3fwPVB/iqAZNX24/llcSu4reOJuNrq0mrEOyigkrxkWWGM5f987zpOrCLBRUcczodRjOHGLgZKclBYs+Q2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763551080; c=relaxed/simple;
	bh=Eb/Ej9nF4m5GYuH0L23XgxFTqGaWLoscnGbitjwxr4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IrdpUN7eXUf1xV1F57vmtoTxh2WqtiOkmoe+9QvxNxacGZJJsY1vsFJMxxABahygE4KBTQBvi3vH7TR/Fvxz6SoWUXBsDKcJAKd2z9EoyaeLby/B0GEhTi7fTyiAkNbqiPAEc81MpPeziLAs6T1V5gTTgbKy19qSL0X1JhDvtQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Br7yU9x5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDBC4C19425;
	Wed, 19 Nov 2025 11:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763551079;
	bh=Eb/Ej9nF4m5GYuH0L23XgxFTqGaWLoscnGbitjwxr4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Br7yU9x5wk9GZ5lZDgAWIZcKUof921N3KU33UPm38kYZ1rS+mLwEF191Rz0Uu/Nf8
	 uEq4CQJ+mqcXHr0gcZ6LVvrKypr3/Z2u1AbNPlqsac+oXlKL1jdFvQDDDpMLHQrf+V
	 O6BWJ0ZSoQ8JXc3QRcQNPSXL7P28jM+b37ISnf/cbl6J3Wp2U/zBTuO57bkKHx2vCa
	 Ognw/2YT3o4KnvSx7gS+dJoBvzlxYWt3NMHjZXP/uIqGs8LI9/m+RWdQ/4DUwfHgQe
	 SO6DDMBeou2BgiUbmq3RPa6rGZEORDYanIQ0VrYYpry0fdivtTVKHv96ZqZPvgiF6D
	 ekksL6J7JklGQ==
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	aalbersh@redhat.com,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH] fs: remove spurious exports in fs/file_attr.c
Date: Wed, 19 Nov 2025 12:17:47 +0100
Message-ID: <20251119-schob-daheim-1655a217ca0c@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251119101415.2732320-1-hch@lst.de>
References: <20251119101415.2732320-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1025; i=brauner@kernel.org; h=from:subject:message-id; bh=Eb/Ej9nF4m5GYuH0L23XgxFTqGaWLoscnGbitjwxr4U=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKLk/adcJC98r76K6jPtaH/y4o9C7oWZ7kqabXyG4d8 Smsrta3o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCITjzH80w2wlvr2QcU74Xyn kFPzTeZHSvaHGWo4Hr4S/a31JGTWBYa/wk8Dtkim3inLEin4uGDywhevNDKXamfuyvRcI8Mzh38 mPwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 19 Nov 2025 11:14:15 +0100, Christoph Hellwig wrote:
> Commit 2f952c9e8fe1 ("fs: split fileattr related helpers into separate
> file") added various exports without users despite claiming to be a
> simple refactor.  Drop them again.
> 
> 

Applied to the vfs-6.19.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.19.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.misc

[1/1] fs: remove spurious exports in fs/file_attr.c
      https://git.kernel.org/vfs/vfs/c/6d228c181ed2

