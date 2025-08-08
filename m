Return-Path: <linux-fsdevel+bounces-57080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D77B1E96E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 15:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 640B6564009
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 13:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6989A35898;
	Fri,  8 Aug 2025 13:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8Mxavto"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC152E36EC;
	Fri,  8 Aug 2025 13:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754660786; cv=none; b=gjwYlgnRb6mU7W/HnPZ0Hm1xRH7H/Tj3DOlb168MkOHM+RxD7juu6Xr85ptAQgcSaKNdmtG+A12UTfPlp31J3dgsFt2v5WiIrGuVNKQ4YPRSqREZco8Fmr0vx2Mvr66YDAqklZhTZapE+swU2l6SHUz+QF1aHaCKILS0fUsIY9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754660786; c=relaxed/simple;
	bh=0NyBks0euPBbl5FE+OFtNWamyzTbrv0aGE1Hvv6fMpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NQPQlu3XewOrFajo2fVA6yl50ZhEKq8IVD5NCOdb+Bhr3iCDtrrn06wfDcyH9pbjTvnOvoxasqeTZzVyfVgqyCKAM6nugkcUmkCfUOMsQOqsWk7YLb5C/T37yJJRzNZ5k0YKyzkIMnHkA5/jRq9UFCTQXtzcKaTzBldSCjLeUEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8Mxavto; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF399C4CEED;
	Fri,  8 Aug 2025 13:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754660786;
	bh=0NyBks0euPBbl5FE+OFtNWamyzTbrv0aGE1Hvv6fMpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A8Mxavtoo51Fl8Y3e9TCdfA7cDIi/PzPhsrchdxYBqhJYLb5JT6myy+gEXP7Hg6rB
	 HMT7r+IWmyovFDjqnhBA9BepdXHZMnAb1UANgDTdlebDBCEiqqfZix0EcER8xHuBN2
	 rC+goxDeuRTDjCtuZo5CT98GgSSRBfpMQUIIM7Ou3urwzu+r5Zan/S7G7vmAFDUHNx
	 G7ttl5nHqJsnV5qksmMScoalfxYvAjO6loJUmW8v5GNGZvgwGopyoyKJDv8VeP7uWO
	 jE5PG8yCHsmemfPURdWRfgKa2kzAcrNjTzXBkLmfP45jEYCYcNU3eg8odUyzpc2VLD
	 KUIB1MN6zhDQA==
From: Christian Brauner <brauner@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	"Seth Forshee (DigitalOcean)" <sforshee@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 0/2] open_tree_attr: do not allow id-mapping changes without OPEN_TREE_CLONE
Date: Fri,  8 Aug 2025 15:46:15 +0200
Message-ID: <20250808-duett-gelenk-03cbce02469e@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250808-open_tree_attr-bugfix-idmap-v1-0-0ec7bc05646c@cyphar.com>
References: <20250808-open_tree_attr-bugfix-idmap-v1-0-0ec7bc05646c@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1547; i=brauner@kernel.org; h=from:subject:message-id; bh=0NyBks0euPBbl5FE+OFtNWamyzTbrv0aGE1Hvv6fMpg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRM/b9m15tH/owP+f7FGX/qL1v+v7Jz7gSel86cBQcYJ DmrGuW7OkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZy7i3DX1GW7Hj2pRYVUfv7 szM/bYn/zbT0z6+4aXp+e6ewxVWazGNkeDktNeb6moysuK6cpB2m66aEsOxLc4vTkP8SrBf+fh0 DKwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 08 Aug 2025 03:55:04 +1000, Aleksa Sarai wrote:
> As described in commit 7a54947e727b ('Merge patch series "fs: allow
> changing idmappings"'), open_tree_attr(2) was necessary in order to
> allow for a detached mount to be created and have its idmappings changed
> without the risk of any racing threads operating on it. For this reason,
> mount_setattr(2) still does not allow for id-mappings to be changed.
> 
> However, there was a bug in commit 2462651ffa76 ("fs: allow changing
> idmappings") which allowed users to bypass this restriction by calling
> open_tree_attr(2) *without* OPEN_TREE_CLONE.
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

[1/2] open_tree_attr: do not allow id-mapping changes without OPEN_TREE_CLONE
      https://git.kernel.org/vfs/vfs/c/75a7ed5ce861
[2/2] selftests/mount_setattr: add smoke tests for open_tree_attr(2) bug
      https://git.kernel.org/vfs/vfs/c/a597ba0a020b

