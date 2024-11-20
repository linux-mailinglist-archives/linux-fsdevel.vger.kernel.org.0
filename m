Return-Path: <linux-fsdevel+bounces-35286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0599D3644
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 10:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 959B0B26DB8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 09:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A05519C56D;
	Wed, 20 Nov 2024 09:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9t1xG2N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6810F19C551
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2024 09:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732093311; cv=none; b=MlBK1HF979RP+FHXhdyvAR+Ur4xZZWb9yRhYf4nRdHhyjjkEvhU13lcYfqHFKYaI7ChxObWUXlbTGfEsXM30X39RC1F91JQhyCfm6HL0KDDBoJhgE5J7AZSL9crklDGv9F4zITEpd68ILjcFIP3wkeb1/aKGIcPjsXy8ENF8b9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732093311; c=relaxed/simple;
	bh=mB971s82172xI/J7xs0mr2omR//1cMIof8yyr6s1idc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QdcCAZJuWEo9a2En+qRJmC6lpNZQeEKhA1F3orEqbUoxcA/V8HIxojWfLXa5ipLVvcFTIc6MNxmZZ/K1twFT4Du/tg+V31Wjc4n0EGDiRjIYQ86hI2d0SJSE7BFHXq6KXvPVagDR/leq2dz4HAoE7Pe7ACk2e31pIsDraU81eaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9t1xG2N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6013C4CED7;
	Wed, 20 Nov 2024 09:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732093311;
	bh=mB971s82172xI/J7xs0mr2omR//1cMIof8yyr6s1idc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h9t1xG2N25NyB1dPJSqyM277tLLcZl6kCsjPVIvwP7IHEw3qs6I0WTYDiWbmP7Mej
	 P+3N3lr2fE0XHVg48CoFObkm5HMZWTwC+PweVmHZOt/hzGYTYeT9mzIrMNu8bWEHi7
	 rie40UNnNKA23XAEH/MYvPceqqiecBlAfam1gcdCN9afcuFjnDapLeDsaM+fae6InB
	 JDruH7644eN1exghTu3MFYlXO6hCAPlv6JYJrBCTNW+MpiSpRMg2gW5zuD5TixOGuB
	 gu9H5ys1DjDhJakMU2SwoGnOuyO+kELWtpPo1a9WvvegedI/srf9xcT/cxluEZFQZq
	 oe0LWFbfkBOlw==
From: Christian Brauner <brauner@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Christian Brauner <brauner@kernel.org>,
	yukuai3@huawei.com,
	yangerkun@huaweicloud.com,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Hugh Dickens <hughd@google.com>
Subject: Re: [RFC PATCH 0/2] Improve simple directory offset wrap behavior
Date: Wed, 20 Nov 2024 10:01:37 +0100
Message-ID: <20241120-jurymitglied-randnotiz-b382d61369dc@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241117213206.1636438-1-cel@kernel.org>
References: <20241117213206.1636438-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1424; i=brauner@kernel.org; h=from:subject:message-id; bh=mB971s82172xI/J7xs0mr2omR//1cMIof8yyr6s1idc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTbLi3f7lKUFfn30wHRqS+FV6bXsN8LNLrL6DpP+OXL/ zyn8qzVOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbSdIDhv7M5a0f3WpGzf9q7 esz/hG3Zei2odbUp49wt/zzqPGe5bWRk2PciKbb6eqVPzYPkqCv9koE3N/w+N/nj4/kbXb2Z9O+ vYgMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sun, 17 Nov 2024 16:32:04 -0500, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> This series attempts to narrow some gaps in the current tmpfs
> directory offset mechanism, based on misbehaviors reported by Yu
> Kuai <yukuai3@huawei.com> and Yang Erkun <yangerkun@huawei.com>.
> 
> It does not fully close the window on bad behavior, as noted in
> the patch description of 2/2. Perhaps discussion and review can
> identify improvements that further clean up the corner cases.
> 
> [...]

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

[1/2] libfs: Return ENOSPC when the directory offset range is exhausted
      https://git.kernel.org/vfs/vfs/c/7f82c425d13b
[2/2] libfs: Improve behavior when directory offset values wrap
      https://git.kernel.org/vfs/vfs/c/3e8dd5a7404a

