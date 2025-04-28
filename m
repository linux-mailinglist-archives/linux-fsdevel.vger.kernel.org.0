Return-Path: <linux-fsdevel+bounces-47498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4923DA9EB3A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 10:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E90503BDE1D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 08:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB2F25EF94;
	Mon, 28 Apr 2025 08:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KivE1Xif"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F17E25EF84
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Apr 2025 08:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745830497; cv=none; b=vBOj1WtggVJfGTwfiD0PMGLnRuoXyIAJQ/bgi/o36jPSl0eI+Ix8F5t+s8gsCjMB/j08WqTd/oIQYXjZsNLC4em5CcoNN7bNviMHXtb2eqsNp7LCjzpSjeplAHl+n3fadeWzTmJ8J/+/K3+JUUF9OIbU5IcqjgVFjz2RkAvk7SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745830497; c=relaxed/simple;
	bh=6fao/iM3sqkoJrnTNjSmmNpWl4z+EJElaQUMtAUHLiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bQHhiM5JYfy/Z4tw8zb/e7Prozad3BR0DkK3tkfZXzOAoJI1JbaVOPelV4yXtEy4J2ultqHxKvLXaDCawr240q6/6/iqwhrelv7gm53f6C4sPy2eljRk4b+kspuYgDLKFg4l7AxVguqCNSbKGArUAEg83v9KYvZR7GqMhvP5IME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KivE1Xif; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 529BBC4CEE4;
	Mon, 28 Apr 2025 08:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745830496;
	bh=6fao/iM3sqkoJrnTNjSmmNpWl4z+EJElaQUMtAUHLiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KivE1XifSJ/NAFn4KlUd47kpg4CuVNn2Xs5D+FMYO04n5+Bs5c4yQo8GRy0jbq0MY
	 rS6jb9CCyhGor0Ozm4HP1tAkwGFiDlSQs0kNiq6ZPpwxwdSMU2sjxNlAc3zX0bFwjL
	 4Q5G84/rr6GfciV7NSwZVBChhCMEdTYuUWr2ShAefzOhScuUBJxtaaetU+WB/OfZ0w
	 lsoOxtdtMhD949Wsh6pHXts9L8JqdX9Y5u5j7uKhanBVShQgL9LyxG9OPCLdd4NLBe
	 6mdxGBiPaCWmHly/hbi0Zvf+PJX+TOUpEPmy8fUTsRd8n10MRCqSo9QVabY8nM0BMv
	 Yyy7Lu6Wf/X8Q==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Pavel Reichl <preichl@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	me@bobcopeland.com,
	sandeen@redhat.com
Subject: Re: [PATCH] omfs: convert to new mount API
Date: Mon, 28 Apr 2025 10:54:51 +0200
Message-ID: <20250428-rundbau-erpicht-0a2986b63454@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250423220001.1535071-1-preichl@redhat.com>
References: <20250423220001.1535071-1-preichl@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=890; i=brauner@kernel.org; h=from:subject:message-id; bh=6fao/iM3sqkoJrnTNjSmmNpWl4z+EJElaQUMtAUHLiE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTwO8Uo5XseWTpbP/fjcyvOX/sf1139Wp2/z/9WkkQVw 6XgAz/rOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZyOIeR4fP14pz58TzrhJZs YbxQtdI2LfMGT5aRiOqSLYvV59uXTmL4H/BjRYrr7sa7RV6vRO7dnr/08R/jX35T5ROKOzWjXc9 KsQIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 24 Apr 2025 00:00:01 +0200, Pavel Reichl wrote:
> Convert the OMFS filesystem to the new mount API.
> 
> 

Applied to the vfs-6.16.mount.api branch of the vfs/vfs.git tree.
Patches in the vfs-6.16.mount.api branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.16.mount.api

[1/1] omfs: convert to new mount API
      https://git.kernel.org/vfs/vfs/c/759cfedc5ee7

