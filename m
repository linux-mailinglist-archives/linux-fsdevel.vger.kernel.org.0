Return-Path: <linux-fsdevel+bounces-42568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B370A43C57
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 11:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1A963A48FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 10:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7492676C9;
	Tue, 25 Feb 2025 10:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAz9vGXe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA73266583;
	Tue, 25 Feb 2025 10:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740480946; cv=none; b=f1RV2E2QqHBQ7k1GTQGXBKh/PIS7uDf46pk0RbxgNrFHKLMr0Q50NtHP9oYvs0QM+FDz/OoSNEYmZ4u34e4zPXEv4vL39jG4OSTQtiu4jK/4btMMA1hViAiJDcJfJ97C/eguGTjTVxMrpudU/UKBITIsaw4MTVrYr47Z0t9CxE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740480946; c=relaxed/simple;
	bh=Ox8AP6FK5GpiUVv8lRcB0bP2MxQHPKpj2mjSGZtNk/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C8F8nzNu+LnvKriTp8gl12IO+1o/4s+r9x/y7eklkokU7dWqHs+Y0FBkrEqe7anZASp3NFtsRLEwSAe4CcmT8Z4myssDiq7K+bCHAeLGkEt0OWmpJ9VWrzq9AHynUZdRuRvXcwLXX2drDrL8ZGeaLzmgq+lgIbGOyGwm3uKJqpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAz9vGXe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1DDC4CEDD;
	Tue, 25 Feb 2025 10:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740480946;
	bh=Ox8AP6FK5GpiUVv8lRcB0bP2MxQHPKpj2mjSGZtNk/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NAz9vGXe1jWDUf2U8Do0JNW5ylQYa4qq4CEwOIw0ap7kQtfC8ZLJR1S0GegaOQzGK
	 Y2tiXTWfsYK5B8iTZhAC44tT0OZCsgF2ym6JpvnwBPAkRcu1p387N5wAClNOdaAd3R
	 mC0KGyyE7Q/JmaIDzPDsGEqjEBWFVpXAPvnt4vLnc1Gq874i3hya8J83Svx0MH1Z/r
	 AqRaKIp/9TVeE2e+9mq8XSP32KQGnfHbXtSa9EATlOVAw9rYOOci8pLRyk3ha1abyu
	 +PG3Bqycikq1iIOcO5HRtdSmO2ntjpt/hdgGl8i5QP54rFdNM5nhyuvlcWhDvzmrEz
	 aiwsdlY7Dr/SQ==
From: Christian Brauner <brauner@kernel.org>
To: djwong@kernel.org,
	John Garry <john.g.garry@oracle.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iomap: Minor code simplification in iomap_dio_bio_iter()
Date: Tue, 25 Feb 2025 11:55:39 +0100
Message-ID: <20250225-hiebe-ringen-8f91ca4bf652@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250224154538.548028-1-john.g.garry@oracle.com>
References: <20250224154538.548028-1-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1075; i=brauner@kernel.org; h=from:subject:message-id; bh=Ox8AP6FK5GpiUVv8lRcB0bP2MxQHPKpj2mjSGZtNk/g=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTvXbjWW+Fh083Am7FZ8x7ofmucIbNKahHDjTkHZu+fc iM0YMNLoY5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJGDxl+F91nnNn8Mn9P6cv 43na9ChMTv9+6/lXyq4+KrEp1sL1N+IZ/ic6npfiWCWd/e74fm73J4eT3FpczC/637BlmjO96Y5 oARMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 24 Feb 2025 15:45:38 +0000, John Garry wrote:
> Combine 'else' and 'if' conditional statements onto a single line and drop
> unrequired braces, as is standard coding style.
> 
> The code had been like this since commit c3b0e880bbfa ("iomap: support
> REQ_OP_ZONE_APPEND").
> 
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

[1/1] iomap: Minor code simplification in iomap_dio_bio_iter()
      https://git.kernel.org/vfs/vfs/c/b5799106b44e

