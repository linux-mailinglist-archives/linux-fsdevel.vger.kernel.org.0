Return-Path: <linux-fsdevel+bounces-35887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1ABA9D951E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 11:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 816E9B2A78C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 10:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCC51BDA8D;
	Tue, 26 Nov 2024 10:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUiTCEP5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B141AA1C7;
	Tue, 26 Nov 2024 10:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732615239; cv=none; b=h2xYWIyZ1EA5fywKVrARBHWvwRs1LHVu2apzIBEO3u/4W/MGHf++5yfdTusqr4P9/kBjMmPFBSbALruRLzLU2lsJe1QgNfe5SP3B8HcVzSuYH+yTeBiiIggR4FUZ5gfsTfjNk+nw/a8Fbq/CjsMLkLJXj6KksGKEZB+FRd6DJ/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732615239; c=relaxed/simple;
	bh=zjJxTzYmbA4PD3jtrZYRkLj4BSVO+DgQZ2QluOPMmjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ggb0AVXT6vYwDASD8eGoJhHw9zmyTEw/r7SzMlvUIlQIkCGrNM2P0kcc8LA71nBjQiMoUzKUPDKC6OJwl7szMzmyG4Tew4un/nQ3j/62K+oatIn41+b25N8mvmrDgGdQPsF7risydr1AWemghSv5Q5F1MC/67QYQLnrAMGC4XKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUiTCEP5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F71C4CECF;
	Tue, 26 Nov 2024 10:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732615238;
	bh=zjJxTzYmbA4PD3jtrZYRkLj4BSVO+DgQZ2QluOPMmjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mUiTCEP5TODWV1tB1sNomcw3JzamMoAw8AeZNLO0Rw0YIEhOwlvfG/UD2WA3IAeQ3
	 znjZ2Q1q1nzdpgE194DoHxqDbefC3T4jyJedOlpV8iVVFan6KoLESMlTpbn2SkO4NF
	 I3fXpFVVKW9n2VE0gVpk3nHv/njwmKGts0zNS/qFe+N9luJS8S+5xucz2rtvURIyLV
	 iutJd4BguWtfYhcZfZf7kOvCqqFJUNePFEhVakzBIZLViGbKyAXafym65hROoHJFTW
	 EUA4Y8qrRzk61gPzqYjWWOBiIIgKwLwlKsB1tEVtB7rjWXNBctrl+ImvQOJddX9A16
	 +v1VB6MMjuJtg==
From: Christian Brauner <brauner@kernel.org>
To: Jinliang Zheng <alexjlzheng@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	adobriyan@gmail.com
Subject: Re: [PATCH] fs: fix proc_handler for sysctl_nr_open
Date: Tue, 26 Nov 2024 11:00:24 +0100
Message-ID: <20241126-weitschuss-jawohl-122aa4ed31d3@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241124034636.325337-1-alexjlzheng@tencent.com>
References: <20241124034636.325337-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=975; i=brauner@kernel.org; h=from:subject:message-id; bh=zjJxTzYmbA4PD3jtrZYRkLj4BSVO+DgQZ2QluOPMmjc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS7zrFvseB1rT6XebC1YVteSyPr1cWXSlcqZaz1Nf1re Ci4NX9ORykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESqXzL8MyhR+nJZTKTJ0TO+ p5tpovzR2z+VrY/kTLm6MSawa55kEiPDc5b2qJNznnuWeTrO+/k2Vnuny7X3rx3EL4WHsJ+eLHC SCQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sun, 24 Nov 2024 11:46:36 +0800, Jinliang Zheng wrote:
> Use proc_douintvec_minmax() instead of proc_dointvec_minmax() to handle
> sysctl_nr_open, because its data type is unsigned int, not int.
> 
> 

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

[1/1] fs: fix proc_handler for sysctl_nr_open
      https://git.kernel.org/vfs/vfs/c/d6528c80de02

