Return-Path: <linux-fsdevel+bounces-39682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EAEA16F28
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 16:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E9B31671A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 15:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4344F1E32B7;
	Mon, 20 Jan 2025 15:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fk+S9lYk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A101E32D7
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 15:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737386334; cv=none; b=GOqwNAkWVF5CZA6HWu1gHc2sbo0ZrtWoNcz3+ksafMS/SUwxOOYxalgqiY2ZLnmOkymPwsBpLS7lqcOFGVTYAuZi7Tt653dtFfEx60nLv8Bffe8Q3blSu9wb162WSof6zzdybx9+4Af0EB7neamcfXYPukaI86kvWc3zttNTdNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737386334; c=relaxed/simple;
	bh=yDz9lFFjbilqCy0PnvyHHdu2DLxGENaumV2apw6fJX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uaTi7NVZ3Ra3DE1CJEIL2R1sk6UDNfmnkjW/B0NJp2eurihVISKs//ikTn+JPc9NphL3Qkj74O95eTfgcoMW+Jz+7t9EAezT6+jyHAobIwbBcyGfIXDzlJEyIsE+U5QDfNnNnF+zGX8FivqF//RXIbdMQWSL4LmelfkZmHwgMY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fk+S9lYk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64FEAC4CEDD;
	Mon, 20 Jan 2025 15:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737386334;
	bh=yDz9lFFjbilqCy0PnvyHHdu2DLxGENaumV2apw6fJX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fk+S9lYkxxp4Jg/UiUpOLh7Y0kELeIamksZZRoBfS4trsXm2mh3nDyU2yr8usawDv
	 YPtlaoISiG4rK1qavMnScfOFxGjpO/7A1SpgWCWVmQyU4mHlTG9Rk+WIQt8ZpldokS
	 mJauV9IZEnHkMzA0EdE4nR2aJoc4tW9u+elDoPpv6mJA3yQkHo5QkmNWNxBuJdUOR8
	 lnEdowvhfum6IOMPYxY1eUhXkJv/SLZWDuKwwhpgXV08kvckYJoxb0dqJ3sWmgjzyl
	 6MDxX/nW3Y8RCa/rhYpn/VVwpqhK3uGKLi7FkFDXLnQF52ep1OCJOF2Ho3LMbqdzJX
	 f2H9pHQ8qN6XQ==
From: Christian Brauner <brauner@kernel.org>
To: Yuichiro Tsuji <yuichtsu@amazon.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1 vfs 0/2] Fix the return type of several functions from long to int
Date: Mon, 20 Jan 2025 16:18:41 +0100
Message-ID: <20250120-rennrad-gravierend-a8b4b6292219@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250119090322.2598-1-yuichtsu@amazon.com>
References: <20250119090322.2598-1-yuichtsu@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1245; i=brauner@kernel.org; h=from:subject:message-id; bh=yDz9lFFjbilqCy0PnvyHHdu2DLxGENaumV2apw6fJX0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT3ZYb9MI0+rq7h+iWwb/OMhSfi3/pM50oU84pgn2GQr yK/hKm0o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCKvnRj+F22/vTNByfSJR/JZ jSUeV77fs7x52YBFoLjuv+XsQ/I6MxkZrnns0nzgs8ZcTOTTFXfnmwyno+z5+ayE13Jfua7/JZu XGwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sun, 19 Jan 2025 18:02:47 +0900, Yuichiro Tsuji wrote:
> These patches fix the return type of several functions from long to int to
> match its actual behavior.
> 
> Yuichiro Tsuji (2):
>   open: Fix return type of several functions from long to int
>   ioctl: Fix return type of several functions from long to int
> 
> [...]

Applied to the vfs-6.15.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.misc

[1/2] open: Fix return type of several functions from long to int
      https://git.kernel.org/vfs/vfs/c/70eaede6e05e
[2/2] ioctl: Fix return type of several functions from long to int
      https://git.kernel.org/vfs/vfs/c/ad0c4dc48f4e

