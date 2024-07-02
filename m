Return-Path: <linux-fsdevel+bounces-22909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F2C91EDE3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 06:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F47F285CEC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 04:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C55B4F1F8;
	Tue,  2 Jul 2024 04:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmThOihg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1183F8E2;
	Tue,  2 Jul 2024 04:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719894437; cv=none; b=uNxepcjEW8w29a23JyVt6p3qvEpY5Tt1selM2Gyk6VqyMcM+54d9fCfCExXrp1jg1g3WPgrYwLesrz/jY1c455Qv+q11M99MNto8zFLPDPrhXksi0yDB4HZPEzNXdUiq3IRwMfzetZ0ItydV43t/NyTd5mVF2rap0TSqPuewDkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719894437; c=relaxed/simple;
	bh=Pv0BfDTulESS3H2hspa9V/qPBcr+GryRdQNP1DxU5JY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BHjo1UmSc5jUdZNWi6C4S2G6AXBMcu3yUgWMIWzCZK5ABww3irvjwLUarizT4STM4xEXdRd0ZiLWOtCz4aVDNWYdCxD1LdiEPXSjBnJ3ZIzpXljIzwON3UbV6JgPxru6xIUYzdZWMFo4CiqwT9DwEfioxfs0+cGHR2TSlRZfxrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmThOihg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B27DDC116B1;
	Tue,  2 Jul 2024 04:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719894437;
	bh=Pv0BfDTulESS3H2hspa9V/qPBcr+GryRdQNP1DxU5JY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QmThOihg9UGFPaNoDYQyvvbRVQdaQkcab25Xy2SgQMsBgmC3a7qBKgUNdrsX6AoTx
	 mJhcmZq7U/oVhTFsfpggxVdwg8WRJXrYHREzkqOw34vvGDGgZX7R90e2xCIGko+vvA
	 qBmWLbhllc4Ea/2SnLbt4k0Kb0R8dMBE1S9D1iXW7Zt27SE0Ya2hVrO11DbQWG+2ri
	 HqbBH6dAx7D01N9uC0MQBTZvFaqmMw13gj3qDjJVI6mwSkBuY2ATeM1/wpABIqaAhH
	 8z+HoC0itipm7i+VVUwgjskOl6FhAVgVuLe2pHxeKVLhhG2BoVo9KTzlu0+oEK8oN3
	 q8sGJHAxqGD8Q==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Eric Sandeen <sandeen@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	autofs@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-efi@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	linux-ext4@vger.kernel.org,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-mm@kvack.org,
	Jan Kara <jack@suse.cz>,
	ntfs3@lists.linux.dev,
	linux-cifs@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Hans Caniullan <hcaniull@redhat.com>
Subject: Re: (subset) [PATCH 0/14] New uid & gid mount option parsing helpers
Date: Tue,  2 Jul 2024 06:25:05 +0200
Message-ID: <20240702-putzig-krater-aea1bf2b652d@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <8dca3c11-99f4-446d-a291-35c50ed2dc14@redhat.com>
References: <8dca3c11-99f4-446d-a291-35c50ed2dc14@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2869; i=brauner@kernel.org; h=from:subject:message-id; bh=Pv0BfDTulESS3H2hspa9V/qPBcr+GryRdQNP1DxU5JY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ1N86epaB8O+RGuUfcyR2t/+MibkifPWzJrzm/ojW// bz+7/jIjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIncDGf4p3JIf1/9yu1MzKr3 pz/12149IctCKa9v5339fMP28/emGDIyXF+35fODGL28nUFvD8xImtm5d1dfRe/hRdfiA9seu4Y HcwIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 27 Jun 2024 19:24:59 -0500, Eric Sandeen wrote:
> Multiple filesystems take uid and gid as options, and the code to
> create the ID from an integer and validate it is standard boilerplate
> that can be moved into common helper functions, so do that for
> consistency and less cut&paste.
> 
> This also helps avoid the buggy pattern noted by Seth Jenkins at
> https://lore.kernel.org/lkml/CALxfFW4BXhEwxR0Q5LSkg-8Vb4r2MONKCcUCVioehXQKr35eHg@mail.gmail.com/
> because uid/gid parsing will fail before any assignment in most
> filesystems.
> 
> [...]

I've snatched everything but the fuse change as we should do that one in
two steps.

---

Applied to the vfs.mount.api branch of the vfs/vfs.git tree.
Patches in the vfs.mount.api branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.mount.api

[01/14] fs_parse: add uid & gid option option parsing helpers
        https://git.kernel.org/vfs/vfs/c/9f111059e725
[02/14] autofs: Convert to new uid/gid option parsing helpers
        https://git.kernel.org/vfs/vfs/c/748cddf13de5
[03/14] debugfs: Convert to new uid/gid option parsing helpers
        https://git.kernel.org/vfs/vfs/c/49abee5991e1
[04/14] efivarfs: Convert to new uid/gid option parsing helpers
        https://git.kernel.org/vfs/vfs/c/dcffad38c767
[05/14] exfat: Convert to new uid/gid option parsing helpers
        https://git.kernel.org/vfs/vfs/c/ffe1b94d7464
[06/14] ext4: Convert to new uid/gid option parsing helpers
        https://git.kernel.org/vfs/vfs/c/6b5732b5ca4f
[08/14] hugetlbfs: Convert to new uid/gid option parsing helpers
        https://git.kernel.org/vfs/vfs/c/eefc13247722
[09/14] isofs: Convert to new uid/gid option parsing helpers
        https://git.kernel.org/vfs/vfs/c/6a265845db28
[10/14] ntfs3: Convert to new uid/gid option parsing helpers
        https://git.kernel.org/vfs/vfs/c/c449cb5d1bce
[11/14] tmpfs: Convert to new uid/gid option parsing helpers
        https://git.kernel.org/vfs/vfs/c/2ec07010b6a9
[12/14] smb: client: Convert to new uid/gid option parsing helpers
        https://git.kernel.org/vfs/vfs/c/3229e3a5a374
[13/14] tracefs: Convert to new uid/gid option parsing helpers
        https://git.kernel.org/vfs/vfs/c/b548291690d1
[14/14] vboxsf: Convert to new uid/gid option parsing helpers
        https://git.kernel.org/vfs/vfs/c/da99d45bd551

