Return-Path: <linux-fsdevel+bounces-36558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 531D69E5C93
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 18:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E4C428162D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 17:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE42224AFA;
	Thu,  5 Dec 2024 17:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVnS3H+9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386AE218AD3
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Dec 2024 17:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733418571; cv=none; b=stjCne0m/p9rKpdIkewV7fkbuFTd/1j04wUpQTz3pepaEuJzPX24tlyMNj550Xim2HNiqGFmT1J2DgHgiTPNV07xsVumRTJN6LQAjv6QC8Y61WDaGewGd8zRxohZz4FkK8HyxwUO5o/Xd95rNoS6vAjmgmkqaNdTGeQbOt4cFJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733418571; c=relaxed/simple;
	bh=6k3na7oLAV5Og/JdxrFxjaU8fk4uKbSUWSCIUiAAfTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QjXP0l0ecBXuJ4sc7Diw5W6r2zHhpiFkrJQh4eLcGA4FGHQ1zXoqFOg+79bCIE/PpIP5GMkvcIAV8LdB1h8PjlyD+T7CL323KBMpEfrbHdMNtRDe3D7HEVnnTJhNHGg4efltKirHheBCWeEsMdUqeD3bcaoUl/HFQTA3yMnO7Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVnS3H+9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A78D1C4CED1;
	Thu,  5 Dec 2024 17:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733418570;
	bh=6k3na7oLAV5Og/JdxrFxjaU8fk4uKbSUWSCIUiAAfTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BVnS3H+9HKaDF7K9J4x/NJ26PC7I3neX8oXOrsf/LFfnu4wAM2+/xvwAWaR/Q3Odi
	 vT28E4OHwqXZTZ2hIrk9XC4lPQUFWqUe+qfqb0fHSpUYW0DpoMSrehTku6pfaIfcip
	 AjfVR53IYnpDgBQ8nStxxcCeBUVxs9FEkBRLWInLOTirfdi28jjlBsrCFtBPecn+hg
	 S+ESf2pGXE+Dv+bf3PI1iJBD2vHG2ULvQoTEWRK8HOiapc+ekUUdrZ9lVCuRB/wagX
	 jqEZK9epm9zxR4F+RYBHy7QqZ4Is44+2vA0yrQEhMXS7hR4oBP/URwlFrqP0DMTMaN
	 szxRppqkEUl/Q==
From: Christian Brauner <brauner@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	yukuai3@huawei.com,
	yangerkun@huaweicloud.com,
	Hugh Dickens <hughd@google.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v4 0/5] Improve simple directory offset wrap behavior
Date: Thu,  5 Dec 2024 18:09:14 +0100
Message-ID: <20241205-jahre-geloben-8f47154d698e@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241204155257.1110338-1-cel@kernel.org>
References: <20241204155257.1110338-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1762; i=brauner@kernel.org; h=from:subject:message-id; bh=6k3na7oLAV5Og/JdxrFxjaU8fk4uKbSUWSCIUiAAfTc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQH3nMKfex8+3DYOtU9We83RNpp/j+QI7+Dicnm36cH9 gvUUszZOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZy34iRYcH/o5WMp/cfvb+l 7CWfZMelq5s+eKilr5+2u/jwmz8XigoZ/nC80p07ff5PRjaRc1PijKLf/7Pbt6n77S39e+7hMid Kz7EDAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 04 Dec 2024 10:52:51 -0500, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> The purpose of this series is to construct a set of upstream fixes
> that can be backported to v6.6 to address CVE-2024-46701.
> 
> My original plan was to add a cursor dentry. However, I've found a
> solution that does not need one. In fact, most or all of the
> reported issues are gone with 4/5. Thus I'm not sure 5/5 is
> necessary, but it seems like a robust improvement.
> 
> [...]

Applied to the vfs-6.14.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.14.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.14.misc

[1/5] libfs: Return ENOSPC when the directory offset range is exhausted
      https://git.kernel.org/vfs/vfs/c/3569cc5260ac
[2/5] Revert "libfs: Add simple_offset_empty()"
      https://git.kernel.org/vfs/vfs/c/06ed2dfc3234
[3/5] Revert "libfs: fix infinite directory reads for offset dir"
      https://git.kernel.org/vfs/vfs/c/29bc7ff8920d
[4/5] libfs: Replace simple_offset end-of-directory detection
      https://git.kernel.org/vfs/vfs/c/d4849629a4b7
[5/5] libfs: Use d_children list to iterate simple_offset directories
      https://git.kernel.org/vfs/vfs/c/5ba9a91ae23f

