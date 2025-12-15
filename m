Return-Path: <linux-fsdevel+bounces-71337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C50E8CBED70
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 17:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67BCF306338D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 16:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B10620CCDC;
	Mon, 15 Dec 2025 14:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZNmaF/W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA803101D2;
	Mon, 15 Dec 2025 14:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765807408; cv=none; b=FusPHjnTAXiXiI7i3whY1WeGapxOZmAkNCZxE6rcEYgzMyQDy4VfemczX12RKRf1UfM+GZtGvzx3VifKpJyCih6eXimNBrfPQdLQ367nB4F8tRMSs7w/Khto+THbO7l/OZZLyR/gy6Z0LPj2VT+iuc0dZ2HITigcxdEhSoqbrlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765807408; c=relaxed/simple;
	bh=Q0KiLf3SvOmcWQ7rQ4VQ7X5iR/Ozsv51MetJGx1Fva8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DIs1xbSgvGscvlUE8fZi+nMRtyc0CEO2lMH4TQxcrAWYLh1lgYR8BoUaWm6aVLgkgnWhFkaLG/D5yNKzanE+ndpMb7a++qLFf9RKnQluxem03PxhtgC7/R3inbQuHNba24zfrO+UFK9Etg+DMyoT8NWCbq6xFJu7jx8QGP3RSXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZNmaF/W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D497CC4CEF5;
	Mon, 15 Dec 2025 14:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765807408;
	bh=Q0KiLf3SvOmcWQ7rQ4VQ7X5iR/Ozsv51MetJGx1Fva8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UZNmaF/W7yG9t7fjkXHtVNPL9t+lO5zO1cL8BQ/kxxfbje0S0TeVJ1MOiKoM3Kdbq
	 jkIaUw4homc0urfeCjE1vihCOCBb8NlvZr9YAv6xlq3BeT5Ki/LBV5UinM7yQwnfP6
	 BCSbYbHX4eNoDUTdGk1ZHjQ/Cdywqzg+vKqz3wKscGB1UX/l2eTFWkvYL8juIcEiU4
	 ik6i0QwbfoDjjlMk3euFWhBclAh7iyN5XH/tY/E+lq8nvVhTo4/L9HO1ZoID83MURD
	 XDySKAqbqAKc0u3El1JzJFA4q1Wll56IUet8QLTIlTraJ4idcwig50++GzcgNYzIHg
	 Gvqa3/pB+vfQw==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Eric Sandeen <sandeen@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	dhowells@redhat.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH] fs: Remove internal old mount API code
Date: Mon, 15 Dec 2025 15:02:17 +0100
Message-ID: <20251215-brummen-rosen-c4fc9d11009a@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251212174403.2882183-1-sandeen@redhat.com>
References: <20251212174403.2882183-1-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1223; i=brauner@kernel.org; h=from:subject:message-id; bh=Q0KiLf3SvOmcWQ7rQ4VQ7X5iR/Ozsv51MetJGx1Fva8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ6iGp7qL1bs+P/dUlde0X2v3PN97kd5w+VVImcW7SdW TBoq83djlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIncamBkeO+jw67a3bezX6jW gq8uPOf3xU1V194JFD/6fTrR7tCEWkaGppeHFyjM0GE9E8P76+lK9znRMh9e7VD+8V4nvdRmU28 SGwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 12 Dec 2025 11:44:03 -0600, Eric Sandeen wrote:
> Now that the last in-tree filesystem has been converted to the new mount
> API, remove all legacy mount API code designed to handle un-converted
> filesystems, and remove associated documentation as well.
> 
> (The code to handle the legacy mount(2) syscall from userspace is still
> in place, of course.)
> 
> [...]

I love this. Thanks for all the work on this! :)

---

Applied to the vfs-6.20.namespace branch of the vfs/vfs.git tree.
Patches in the vfs-6.20.namespace branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.20.namespace

[1/1] fs: Remove internal old mount API code
      https://git.kernel.org/vfs/vfs/c/51a146e0595c

