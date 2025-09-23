Return-Path: <linux-fsdevel+bounces-62493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E701BB9577D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 12:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0368D188DE2A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 10:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31C33191B4;
	Tue, 23 Sep 2025 10:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVi10lyk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3D4275AE8
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Sep 2025 10:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758624194; cv=none; b=Qn1UEv/x6qwOqUFIam/bfUPFBYD6KDZkvCkhxEZ6alVU4Vndnc3hZsW0DwSYZMkEflWRHzsfpdI81m2gnFF9N9CJDlZsjvTMubDylKx7JXDWu9d+MzsmAQ0KCfYVo+2csU2Zm4fxdEf1v6ucSV7Tkz877vRhlp7/ISBCPXpZ2ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758624194; c=relaxed/simple;
	bh=BBVa/kpPSr/orK3jsIFEXoIs5LUHBIlq3AiFHJfQGeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IXjemeE44ZXaXzZlZX6ZM+l+PiWa/O1P3Xa79vpXbJ73EIJx81ktC3tO4yYPORFcgXEG+d2C0yQukxWXg5HL8q9znEMo2AQYkKje8kegEZqUgeVuYUT2LnXWIELeHJP6W9zdWYFMiFal35kLPYcuKXNGFwPKg84x0cnMrckTdeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVi10lyk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC7AC4CEF5;
	Tue, 23 Sep 2025 10:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758624193;
	bh=BBVa/kpPSr/orK3jsIFEXoIs5LUHBIlq3AiFHJfQGeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FVi10lyk9zFH0vosb+ff1b2XLi2bvvu3Q38PjAtBOhK3IUgwhns3SdnWDx3ilZFaO
	 8Ld6kZuJ/k0ztyTXkS6gTtf8xuV9pTBiP1EO2IO19HLXKfZxqrm/QZUKZZ4S/tRNRB
	 eIQgu2Pmtk4V681/nhryzqZ3zaQ0fB8gRR7vgzFVPK4yZGsMGt6C038AsnPqw6Sx0/
	 r7oQlMZx7AeCsqgMR3/s8h9IkyuBNS16KlGsrVlrfTCPnp7HApLW6+ulgVnZmvNfuk
	 bn8hl0EHzzEHg7/8jW6gdOf70IaX7VvmAEl2QvV348Br5myXO18Y0FqN7O4+DE8GYg
	 xcc6N9MdbZixw==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Kanchan Joshi <joshi.k@samsung.com>
Cc: Christian Brauner <brauner@kernel.org>,
	jack@suse.cz
Subject: Re: [PATCH] fcntl: trim arguments
Date: Tue, 23 Sep 2025 12:43:08 +0200
Message-ID: <20250923-malheur-wohlstand-006fd52d8077@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250922113046.1037921-1-joshi.k@samsung.com>
References: <20250922113046.1037921-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=900; i=brauner@kernel.org; h=from:subject:message-id; bh=BBVa/kpPSr/orK3jsIFEXoIs5LUHBIlq3AiFHJfQGeM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRcqty7U+rcuZSLKusmNSo1h/GzSa2aX37oeNQae8vfn 34VlB3+2lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRdmdGhiVuub+tnU9t3MoY cXKS0xLF5wUTPvk+L7n5lHXfg9fXdn1h+M3uPGfCjy8ZwcUPBFlTt83gvKrk9IBJ8Izso4KTLQx JfGwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 22 Sep 2025 17:00:46 +0530, Kanchan Joshi wrote:
> Remove superfluous argument from fcntl_{get/set}_rw_hint.
> No functional change.
> 
> 

Applied to the vfs-6.18.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.18.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.18.misc

[1/1] fcntl: trim arguments
      https://git.kernel.org/vfs/vfs/c/e6524dd4c068

