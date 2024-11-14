Return-Path: <linux-fsdevel+bounces-34752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D1D9C8668
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 10:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 089872834B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 09:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D369C1F583E;
	Thu, 14 Nov 2024 09:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZ2Bv9Ur"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C43B163;
	Thu, 14 Nov 2024 09:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731577587; cv=none; b=sX9dvHRoy8f23EHg/KGC1Ar/eypedzzijqHsiUjDTsogK0cUYSLBj1Nx0Q3Yc2ov891jIXvwsfe6Lz/4r69DP/wv468H0xt1yLNo84e5IwMDhfUV2IM6jv87moipZIBo8KT65xECh7EOKc1z5W/kFS+eXwn38oCBYFYeEc3AnG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731577587; c=relaxed/simple;
	bh=50oQVA5ikuSoK20UPk7UW8LHxZukxHHpBkqkAa7tyYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YXfnekV+17h+KeZdG4lnZOmGZllRgxE8H+Xm2wBFFxcNuw1X47Erm87cO+NN9YU+EuSQIOjWg18b79OlHdnK+24rhz7YxNnPDBK4KleN33Uem7NGRCk2fjvpWigoO4QavTWfpOcl9GevWZHL69jUm9uaRbqdvm6uPc1+zb+9sMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZ2Bv9Ur; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0222C4CECD;
	Thu, 14 Nov 2024 09:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731577587;
	bh=50oQVA5ikuSoK20UPk7UW8LHxZukxHHpBkqkAa7tyYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LZ2Bv9Ur2/OeMa2dsSTqRXBrqLdrtITXIsVh2w5FjmoJnrAOCHKragVFXixkXgOL3
	 +79P03j9Okm7j7PmWvJO0Cn+E2ukFhC0bG+vbEqPhFdPjqn4IM+2Jvyz9/7Lg+u+UY
	 6jGS8OyB0yuohQ3fN6Z+q4oUx+TXCAn/zcPAaWSum4dB1+YA8Z5MaXMe3XnRkBziKM
	 fOPDI4JnFJsd6PBkHforT2xYxFcQU262+SbshffsQhyNpbLDaAxqKBXse9QOPGJvrt
	 RN65c3fdJKEZcWikzdTxzHBvNLzRVGjyR7qV3kdARRS4RcKNK7TPT+Iq6Zox2VMJkR
	 Q02gPOk4Cxi6Q==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH RFC] fs: reduce pointer chasing in is_mgtime() test
Date: Thu, 14 Nov 2024 10:46:07 +0100
Message-ID: <20241114-unten-stilisieren-a3bf89905d19@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241113-mgtime-v1-1-84e256980e11@kernel.org>
References: <20241113-mgtime-v1-1-84e256980e11@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1150; i=brauner@kernel.org; h=from:subject:message-id; bh=50oQVA5ikuSoK20UPk7UW8LHxZukxHHpBkqkAa7tyYI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSbHntdkvjDcirbjkWzZ5yemfBW6V7/Ko/17vohLmu9I +6d+7F6W0cJC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBE9oUz/K/o8p3pbrPkxMNH DDpbdlcfn7RUW/n/xEnua9p6mh7s3HOD4cfBOM0Ojt+6vvy7JjrJFQTdLAwLNVkeUVP/VI1H5Jc OCwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 13 Nov 2024 09:17:51 -0500, Jeff Layton wrote:
> The is_mgtime test checks whether the FS_MGTIME flag is set in the
> fstype. To get there from the inode though, we have to dereference 3
> pointers.
> 
> Add a new IOP_MGTIME flag, and have inode_init_always() set that flag
> when the fstype flag is set. Then, make is_mgtime test for IOP_MGTIME
> instead.
> 
> [...]

Applied to the vfs.mgtime branch of the vfs/vfs.git tree.
Patches in the vfs.mgtime branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.mgtime

[1/1] fs: reduce pointer chasing in is_mgtime() test
      https://git.kernel.org/vfs/vfs/c/9fed2c0f2f07

