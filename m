Return-Path: <linux-fsdevel+bounces-4174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7E37FD483
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 11:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CBAFB20DBE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 10:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F211B279
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 10:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tm+z5j3Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C667A1804A;
	Wed, 29 Nov 2023 09:53:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D63C433C8;
	Wed, 29 Nov 2023 09:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701251582;
	bh=M/wrwBoAhY/EOGRi2rNjTTgsi/b3VYc9j7tgxbCLpL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tm+z5j3QeKUul/UAWCffXevjUUzFl3znKaxyEIQgOGQYawvbFoSSVU3341cwFrTex
	 3SJy5Lj4mdhvpqjdpWRFFG1v1dFAVI+OkB2MrCZIP4y8ER5mrewszXlYlWcHb3UywU
	 GjsaFDpjUYhAR4gtOjS44Z7mP/+D9ZhJebUAcBVCg8a/GvgDSHU67y4f0u3l84zrCR
	 FqGjFTR92inF5rlwhaInSmMVJBl2W1VlfjGTFo7yY9xOUEpd5Bby7rPZI2yz++Baln
	 5MmmB2v0IcD5sBZTEDPGZz4jWJK9BTutg0yS+9gslDNjeuugBrOZVOIl4oh/Ke9lUA
	 v5BfjZzGawPfQ==
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-api@vger.kernel.org,
	linux-man@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Karel Zak <kzak@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	Ian Kent <raven@themaw.net>,
	David Howells <dhowells@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 0/4] listmount changes
Date: Wed, 29 Nov 2023 10:52:12 +0100
Message-ID: <20231129-rinnen-gekapert-c3875be7c9da@brauner>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128160337.29094-1-mszeredi@redhat.com>
References: <20231128160337.29094-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1660; i=brauner@kernel.org; h=from:subject:message-id; bh=t4fv6b9d28Re5kYhLcaI3zsHZPY8Eee8QVWBDmRIpNg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSmc5456bm3/Jry9Pw3LJNbzHhrJM/O1HBeWLYj+GmKo JO3qPDSjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImo2zL8Ff76QOrOyooJXdM3 Fjb9fJli8tiIZ3dixMumrNfu8WvK1jAy/O/TKIquz3NKl/+VemLR9ptqrnsPv14d/ub93beJvLc vcgMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 28 Nov 2023 17:03:31 +0100, Miklos Szeredi wrote:
> This came out from me thinking about the best libc API.  It contains a few
> changes that simplify and (I think) improve the interface.
> 
> Tree:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git#vfs.mount
> 
> [...]

Afaict, all changes as discussed. Thanks. I folded the fixes into the
main commit. Links to the patches that were folded are in the commit
message and explained in there as well. The final commit is now rather
small and easy to read.

---

Applied to the vfs.mount branch of the vfs/vfs.git tree.
Patches in the vfs.mount branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.mount

[1/4] listmount: rip out flags
      https://git.kernel.org/vfs/vfs/c/735b1c55d14a (folded)
[2/4] listmount: list mounts in ID order
      https://git.kernel.org/vfs/vfs/c/735b1c55d14a (folded)
[3/4] listmount: small changes in semantics
      https://git.kernel.org/vfs/vfs/c/735b1c55d14a (folded)
[4/4] listmount: allow continuing
      https://git.kernel.org/vfs/vfs/c/735b1c55d14a (folded)

