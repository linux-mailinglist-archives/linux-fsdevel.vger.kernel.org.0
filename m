Return-Path: <linux-fsdevel+bounces-40469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F301A239C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 08:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5036168CA0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 07:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F61D1586CF;
	Fri, 31 Jan 2025 07:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJvTtALx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56DA156230;
	Fri, 31 Jan 2025 07:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738307403; cv=none; b=GZSyzrS3BDdEw7Piq7R5r6WUdZkdD4F3Esai5DNnRxf6pr6duHb6Yut1KJQQOuDxUD/q7OoX0FFSuyh/bcSARbCJOIuTJLTvQ1CzVcZ+Z2aPF1HbFgeBrLN+ZDArzE51wkWNrHqhmtGrzwENnS6XpPRu+BOKDoDddgGhqyLCeCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738307403; c=relaxed/simple;
	bh=R3PpidaKWGxqBGYWuqffjgvHdLtXCsNZhG/SkPBe8fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IVuWoDiLNxZqJFoNI2XdkoTHV/Q4GqPFJ5WzVuotl0723Xu3UsKYJ9EmTfVyteSvTPisPdOLgqYJy8BG7eKlzplWCsd3Xbm9IKqtSFgUlJ6wNdMlR4t8VphK5xDskYyoE2TBh61z6mDoYAW4hRc7QG0/jBrJZpk5uBXqE49E/tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJvTtALx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB05C4CED1;
	Fri, 31 Jan 2025 07:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738307403;
	bh=R3PpidaKWGxqBGYWuqffjgvHdLtXCsNZhG/SkPBe8fk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eJvTtALxvwdmKAGntpMBQr6vCzQww6hKT1pe+yI9FXCeybf5TfGl5XgDToQfbMlxI
	 vaqZ7FM3vvP+hkqZB4l84Q6+qkrQEd+a00npjOvGMbgaNO/U+Yn8qxoesQCGry+4w9
	 NCl/X5NfvaR1rpH/uudP/nMxuaWH88hX5QD71XNR5BXxufd2r1FX7v7BR9SFax3NUU
	 P9Bt1+yyv8Z8emZwDi79Lz1dyG2uWatPf6HitBSAf12NxHjqHf5oCTvaIKocXb448S
	 UmSBWR4N46md0AicAfgdmozWcY21CGJpb6gYSCqfjdmMSFwpk1jqzLYG4AXJyqm3kV
	 psquYm4e6Vmmw==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Miklos Szeredi <mszeredi@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] fs: fix adding security options to statmount.mnt_opt
Date: Fri, 31 Jan 2025 08:09:54 +0100
Message-ID: <20250131-mythisch-brauhaus-e0b5de2542c2@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250129151253.33241-1-mszeredi@redhat.com>
References: <20250129151253.33241-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=968; i=brauner@kernel.org; h=from:subject:message-id; bh=R3PpidaKWGxqBGYWuqffjgvHdLtXCsNZhG/SkPBe8fk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTPKXe9PSv/mHEf20sjhhPPtn/WfHfM9U3UjJ+98xzlw sWPCP6Z3VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARjduMDNsbJHLy1lzff+LL 2uzjm69ZfGHeMsdXQ0+Y/8DCSzc/bDvPyLCuflNs+AzN5LdTl4g7//PRPFXxISr0aUujQWT2U5v mw3wA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 29 Jan 2025 16:12:53 +0100, Miklos Szeredi wrote:
> Prepending security options was made conditional on sb->s_op->show_options,
> but security options are independent of sb options.
> 
> 

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

[1/1] fs: fix adding security options to statmount.mnt_opt
      https://git.kernel.org/vfs/vfs/c/768d562f8773

