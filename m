Return-Path: <linux-fsdevel+bounces-68030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DA5C5161E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 10:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A6E564F5F49
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 09:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D402F28F9;
	Wed, 12 Nov 2025 09:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNv//GMs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A2835CBBE;
	Wed, 12 Nov 2025 09:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762939821; cv=none; b=Qznb3/tIAx/cPjmg4J81VczQJIQ9KSjPG+UH9kAOa/29ozwts8ub+yq0L4gV5XaZk7JRFtnGbok60iOakEfqRV/rI8GpLglsLKmtKCSv4SC2wQxEN87KujzNcixevG845tuh3ipfgR3ENT150mmT3C5SRY01qRsdKLdp2X8jo7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762939821; c=relaxed/simple;
	bh=myZtnclAawPVgzBw7lD6Ax1fgEcvob0QYVCxl9A+ZN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hx7iXj0ByOeiQDpdDGsv32r6uUuxUs5Tk5fkWylyBv8qJIOgWylPP2OlDe7bIaK2/7rJjoBjVyBTqIl4iFFWDpY8XHtJk8Zzj7pVPmzozlkRBT1HcH1c4I+W89LNObKnjCB2u8prTEhF1ZUvBbrKETdE2YEGYcUrgTxPRD7/WKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNv//GMs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AAC8C19421;
	Wed, 12 Nov 2025 09:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762939820;
	bh=myZtnclAawPVgzBw7lD6Ax1fgEcvob0QYVCxl9A+ZN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gNv//GMskcRHIxfvcGAYa3jLxbGJOPeorWMZjF/r8ffpMVN+hC/1/2rJo3hOzvWxu
	 rhK4NfBXR0NWkGa0zWgQQd4bXCXvhIjGNJrW/4J79UbdWOaSJDThzoLOcA3czGhLxp
	 ZJ2E8VkHRXihBY/fhYlWWfQSDqCthTykZRHpAMfXCKQL7d4FMkUh+eUdx7672aZok8
	 lmQyZDWbW3W4LVcXv09jriOKrgezGSIp42MIcVjuDEmseCYmmadHd3zFiOgikLn0iz
	 2KsxG8h6vMT1yMhfchX/3bUedeqtagoswogBxrjd6ONoxGx85qJFlcqMVUlPCAhFwP
	 YDGNjHaIrwoFA==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2] fs: move fd_install() slowpath into a dedicated routine and provide commentary
Date: Wed, 12 Nov 2025 10:30:15 +0100
Message-ID: <20251112-mondfinsternis-rednerpult-f3efbf92cf8a@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251110095634.1433061-1-mjguzik@gmail.com>
References: <20251110095634.1433061-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1070; i=brauner@kernel.org; h=from:subject:message-id; bh=myZtnclAawPVgzBw7lD6Ax1fgEcvob0QYVCxl9A+ZN8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKBC+XzjlQ5VxhalBR9uzaXqWsk7+2Kx5u+mf4Z0P6n DfJs8zPdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExEqIGR4cP0HHZZHSHJH9Wd vRVVm+5nhHG8OpVfIKqaZPLX1+KME8P/8v2pse+7K5+vf5p+l9HspXTa1EUvgyfOemk6Qzg1YcU PDgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 10 Nov 2025 10:56:34 +0100, Mateusz Guzik wrote:
> On stock kernel gcc 14 emits avoidable register spillage:
> 	endbr64
> 	call   ffffffff81374630 <__fentry__>
> 	push   %r13
> 	push   %r12
> 	push   %rbx
> 	sub    $0x8,%rsp
> 	[snip]
> 
> [...]

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

[1/1] fs: move fd_install() slowpath into a dedicated routine and provide commentary
      https://git.kernel.org/vfs/vfs/c/6ecf5292038e

