Return-Path: <linux-fsdevel+bounces-43245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF66A4FCC4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 11:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF1C21887391
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 10:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BBE21480E;
	Wed,  5 Mar 2025 10:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pyvpu7jG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B918F20DD51;
	Wed,  5 Mar 2025 10:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741171726; cv=none; b=SEy5Mv2jHDdQoxtatwkGY1ngtZYtovNWIUOyvkAL77IFozfjvaQoOWdrcbFwEfxE+k069mhziXifo/qkaDH8D7/iNn72dvyp8JfGpEhga5dyuaLT0vzKxwer+8PYRa+vRjCK7mgRF/ETSt1WuBwkNooaI0S8WJDqXe5dVeEMHfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741171726; c=relaxed/simple;
	bh=A1ZnhWTwRfkh7dV3YIzlUsS+EeXXuLqFmxZQEEzIq/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jti0W8HCeo37j/8Tc4H2/W3CUO9tAsNbaVdjuElPjGhhSTysEFP0vwUbBfGiP/7CG1/SLvMPMnCaWzEUw+PwENWetO0hQ4oXHy25JfgPyAbLXMeVB/A5eO4bIITm4SN6RpmqpI7kDhWGM6ntTUO4W635bJt4qawuhcAJYCsBexU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pyvpu7jG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA50C4CEE2;
	Wed,  5 Mar 2025 10:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741171726;
	bh=A1ZnhWTwRfkh7dV3YIzlUsS+EeXXuLqFmxZQEEzIq/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pyvpu7jGa/XCQeXZzAyjo3iMNUmXxgxwLQMYsZrNeAE4sjCVTcsyRtSCfs69uqV7R
	 6Ce9G4uX4/NVDp7Y3XwgP0A8HgRStbhbH84cwPPh+IdD5/coX3Bzofo+vZYQ4BO2RM
	 ym8OHjMZ0yuPdAz7GNdUAX4PXlYAsao9BvNYZj4ne6YuKpLLSK5dGsD1nJIjc/UXBU
	 X2aVSwiZEnkZuTozPxdjShs7b5yjh7aEXBgqw4abvj8K3uEn+6xsTMIilklecqVEGL
	 LE7O+vT/PVffEasZE+wnmiQJxvSt5E8aAjGCvoMRPUnU9Q8is2aqWZyBCbpsRNOTMP
	 eSWCVBEhbHPQQ==
From: Christian Brauner <brauner@kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Subject: Re: [PATCH] ceph: Fix error handling in fill_readdir_cache()
Date: Wed,  5 Mar 2025 11:48:39 +0100
Message-ID: <20250305-zeitumstellung-nahkampf-9d6bfa10bdfd@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250304154818.250757-1-willy@infradead.org>
References: <20250304154818.250757-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1094; i=brauner@kernel.org; h=from:subject:message-id; bh=A1ZnhWTwRfkh7dV3YIzlUsS+EeXXuLqFmxZQEEzIq/I=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSf0OE4FP6hXyzpaNSnF3f7L2a88mHU6/1teOu2Wv/6Z 1EchzS6O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbyNI3hf7HQO7WMvwFJ7n/v a13ULDq54hhDRs6B2/fVPsg4tH76EsnIcLm1v/pp+rTdZ+8rrHG4krZY50Gv3YR78dN8/juwL1w QyAEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 04 Mar 2025 15:48:16 +0000, Matthew Wilcox (Oracle) wrote:
> __filemap_get_folio() returns an ERR_PTR, not NULL.  There are extensive
> assumptions that ctl->folio is NULL, not an error pointer, so it seems
> better to fix this one place rather than change all the places which
> check ctl->folio.
> 
> 

Applied to the vfs-6.15.ceph branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.ceph branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.ceph

[1/1] ceph: Fix error handling in fill_readdir_cache()
      https://git.kernel.org/vfs/vfs/c/efbdd92ed9f6

