Return-Path: <linux-fsdevel+bounces-43883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD08A5EE94
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 09:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2330B7AC2CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 08:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72570262D27;
	Thu, 13 Mar 2025 08:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rwsincOu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A88262D35;
	Thu, 13 Mar 2025 08:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856106; cv=none; b=NsMlH1Ob5O1MB/Fmv92/o9paNyIMxSRdUIJZ9KSUkZ7Penuf+xXDyPxdgQDE0HWvix9ZdEiocw9kvZcHMSiJ1kMtLKmLdd72XAASF/r1AeEyq33SidkmKN5mz64J7BpO2l+0gCzbcYG4O3Orx3IhMo0ZIi2zenLSoRsXifR3PGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856106; c=relaxed/simple;
	bh=v/UmHuy4+WdwC6rhInMSg1tPkA5XhywUNIcfydkGDm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Htg0YPTGIrWqfMcxO4AVhePijEL7asQ42NDVytAfA9QLbHgqtITbzgKlMB3gbVnWOAPNPMAEsDs4KIVYb4kutu9mn2XBn9Jw7iONLviqgcgeeekJgXp6KV0ippeXTCw+qNBLXvAiFj3I/T7DLnJT48QU87njXUSUvEYf/1BLHAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rwsincOu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE8DFC4CEDD;
	Thu, 13 Mar 2025 08:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741856105;
	bh=v/UmHuy4+WdwC6rhInMSg1tPkA5XhywUNIcfydkGDm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rwsincOuRDAoSQT7lNAF68R69LNaC03bQM8KuC1oAriCzmL6sVDXq5upuGHB8mOt1
	 CkI37FUnrMb70XF+CdKUrgp9+FFl3p01wwea0lTg1KcxtoHIyaL+75+BEHsNmjQem1
	 IMCg57BCyobor7B9pzVU6Rj5kNhExNThXtlzjem6D7VnfkN194mbTJnOIXjMwJAL2C
	 liZVsUWuMngJ/jQfsC1/tHTXi+H10wyQQ/yPBRRU1/e1C1ixagjBWYS678eeoA97u+
	 HbJ+TMY4g8Uo2MA40KhDAacGDWw15U+zvXtMAxrKnFw0hO1boWr0bLV6/yse0FYVoP
	 ze+ZsrcmkAVIA==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: use debug-only asserts around fd allocation and install
Date: Thu, 13 Mar 2025 09:54:56 +0100
Message-ID: <20250313-einspannen-auktion-2f2b8e212eaf@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250312161941.1261615-1-mjguzik@gmail.com>
References: <20250312161941.1261615-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1079; i=brauner@kernel.org; h=from:subject:message-id; bh=v/UmHuy4+WdwC6rhInMSg1tPkA5XhywUNIcfydkGDm4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRfmpsYdDLWv8wpLJdn4yy5tr9uundmaqkH9165VLQj0 6s/03B3RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESSJjH84f831ffCn59PIy5v elW3j+tjYUTuzslMC3gn1T35ZZyos42RYWrTi3kh63vMe3snqq4J8N+1Zkdv2N/967zVn1Tn/To twA8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 12 Mar 2025 17:19:41 +0100, Mateusz Guzik wrote:
> This also restores the check which got removed in 52732bb9abc9ee5b
> ("fs/file.c: remove sanity_check and add likely/unlikely in alloc_fd()")
> for performance reasons -- they no longer apply with a debug-only
> variant.
> 
> 

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

[1/1] fs: use debug-only asserts around fd allocation and install
      https://git.kernel.org/vfs/vfs/c/dc530c44cd64

