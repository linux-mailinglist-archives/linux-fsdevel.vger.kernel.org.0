Return-Path: <linux-fsdevel+bounces-60357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC292B459A9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 15:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E0115A0316
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 13:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C08135CEDA;
	Fri,  5 Sep 2025 13:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arbQTUjM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DB127AC5A;
	Fri,  5 Sep 2025 13:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757080439; cv=none; b=XHujeg32TJtlxdSF2etjRISJrbiN4PdFz0ZjCbqujIIhXcn0v81Y5ANlL52SjYup6hCDRMHIbtUE5uOv/MUbeHPKgN68ia8hvIdBUCsc43KCgGcFnMcNk20IcNhb8C00UM+W77XhtboGqjjl15NqZADg859Ycgug0dv1TGQDj24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757080439; c=relaxed/simple;
	bh=ReDyM4MB7hT8mA6UGUgIoBFRBaUXNQ62LKi7265f88I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eO2sJD+DeOG7Sglmbc0IZIOZ5ZgmCvI12CqnuS3hNLV9SfrhKPOYXekEAhPVlbhlg828vi4RhmZ2zy1GykdN2dKY0Ow0DHmGRn5ZxoZQdAHStFdt5NbKTrU2w4tHRBD9l95oCZfJUcqO6vSha3I3pUmhaiC3h4t3Uiu/Phdk6No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arbQTUjM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0274C4CEF1;
	Fri,  5 Sep 2025 13:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757080439;
	bh=ReDyM4MB7hT8mA6UGUgIoBFRBaUXNQ62LKi7265f88I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=arbQTUjMzG8MoJMRvIVpfMnM6U5qZawu/1QFEIdjVbUQ1Nylbpc5go6mPHakdZeRl
	 s5//E6iluNHeHmDws00QSBHu0Eh08kc/bOzRJc785v1WHkEt+fHZrHnoMLH/crDP/X
	 BJVZKecmSHdRPB8/u5ksZROzROhbl7MZdvA6JOull7eHVDTJScY7NXKb3ahyz6PoSP
	 UGd9CCQx3ioIJw2pNtUv3g6Y8chetjCrqNPs0zLhWZnHOrgM9foRe60ayjXrJZYCa2
	 vdvMjc8i4dZpPfwKVdsv48+RN0vgXqVWwZW4DhxQ5p3fdt3uIELLYSHZcE8lmeCAo2
	 HqQLMDKjR7B5Q==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] afs: Add support for RENAME_NOREPLACE and RENAME_EXCHANGE
Date: Fri,  5 Sep 2025 15:53:53 +0200
Message-ID: <20250905-hausordnung-unfassbar-14afe9d699b7@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <829770.1756898956@warthog.procyon.org.uk>
References: <829770.1756898956@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1182; i=brauner@kernel.org; h=from:subject:message-id; bh=ReDyM4MB7hT8mA6UGUgIoBFRBaUXNQ62LKi7265f88I=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTsel3ke5X7lciVsBaxN8esr714U2S/fT37CdsDbP+vv MpY9ry+taOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiPQsYGXZN+VEn+3incvaM rbN5C9MOFEj5n3Di39tce6XbPey1yAuG/ym16797uanJlwWGLO3eOoUz5FSby585aR3XO3i8itf xswIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 03 Sep 2025 12:29:16 +0100, David Howells wrote:
> 
> Add support for RENAME_NOREPLACE and RENAME_EXCHANGE, if the server
> supports them.
> 
> The default is translated to YFS.Rename_Replace, falling back to
> YFS.Rename; RENAME_NOREPLACE is translated to YFS.Rename_NoReplace and
> RENAME_EXCHANGE to YFS.Rename_Exchange, both of which fall back to
> reporting EINVAL.
> 
> [...]

Applied to the vfs-6.18.afs branch of the vfs/vfs.git tree.
Patches in the vfs-6.18.afs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.18.afs

[1/1] afs: Add support for RENAME_NOREPLACE and RENAME_EXCHANGE
      https://git.kernel.org/vfs/vfs/c/09c69289a273

