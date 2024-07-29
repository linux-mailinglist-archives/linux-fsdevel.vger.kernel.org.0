Return-Path: <linux-fsdevel+bounces-24404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3A893EE68
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 09:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2584D1F213D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 07:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97244127B62;
	Mon, 29 Jul 2024 07:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AODX9nPl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CCF84FAC;
	Mon, 29 Jul 2024 07:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722238084; cv=none; b=Bto7FY8VLXBwPRGwTfVTyawVsIK+5EWRhUUwLZ8r06Dm4+C76AoU9oFppCjVLVh6xkwhQDWPin9/YxqyEtlIR+TwbvdVN0hfcijLAsxcv+gaqa4P06R7FTWAzbpPBXTOaEQLEHowmkpSHGGxdusckti8Til805ljXMeUJ7cjLy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722238084; c=relaxed/simple;
	bh=Jw9/sbm6Sp3VBKjYh/llRJD6LVFHd8qHP1ksDT/hPPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ON7OCVBA+E4WwnEc9JFJRMmgAh+0kjj/BXljOKzMNA4wEFSj/ZLwvLRSUvd/LU6n19d+x5lxVL3kr4B6lAt5n5K5SMcVaLyyxHXgHTPtDUoq2FKBtCRvBR9/nEsd1enXfKoVRvFdnbmG29NB6KddBj1USwVUR5pIzwDRXIgGJIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AODX9nPl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D3BC32786;
	Mon, 29 Jul 2024 07:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722238083;
	bh=Jw9/sbm6Sp3VBKjYh/llRJD6LVFHd8qHP1ksDT/hPPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AODX9nPlP5O6Z1jUZcyifoQk6rMaPE5ed6J3Imm+LYLDkyxT8L8kcZX2yRV6bj5vt
	 Ib5c0KV2ZA2zOM2mMa+r5uGrzjVO7fY+eQN90+IncRqwWboEaDdXWC6QKry4XgFFd/
	 eieKVuyjtgxHEql7ODWgQm+aKIexriIYUKK8vLB1/9Izk2JQ5fb93pQBdhrkcL1W4n
	 /lp2QvdH6bJdiT8zYkpsDrd0ktpGrJ20JmuALNVhR40OIJ+stqUE7qh6n9zNvWwCV1
	 bxJW1aT+4e0k8p5lfnGYZx5QYHlD6p22C/2I4PDPo2PHUk5nekSNv2DMFrJolNXr78
	 JdcXfzgsK6LRg==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Xu Yang <xu.yang_2@nxp.com>
Subject: Re: [PATCH] netfs: Fault in smaller chunks for non-large folio mappings
Date: Mon, 29 Jul 2024 09:27:49 +0200
Message-ID: <20240729-realisieren-duschen-3d33f97b4ee7@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527201735.1898381-1-willy@infradead.org>
References: <20240527201735.1898381-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1047; i=brauner@kernel.org; h=from:subject:message-id; bh=Jw9/sbm6Sp3VBKjYh/llRJD6LVFHd8qHP1ksDT/hPPI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQtd6na/kjjs4tu6ucrp1k5J93J3lOStSlI6Ynzv6sfX 0050/N9fkcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEjrox/NM4taHdgdt7fx1j Xsrevvcq/Cf4G1nVs7lqt85aunLuvwKGf9YWXEc7XnNrGJ62V9UIFrq4x++K7KSJ911SHmb3ble byAsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 27 May 2024 21:17:32 +0100, Matthew Wilcox (Oracle) wrote:
> As in commit 4e527d5841e2 ("iomap: fault in smaller chunks for non-large
> folio mappings"), we can see a performance loss for filesystems
> which have not yet been converted to large folios.
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

[1/1] netfs: Fault in smaller chunks for non-large folio mappings
      https://git.kernel.org/vfs/vfs/c/9f337b5daac1

