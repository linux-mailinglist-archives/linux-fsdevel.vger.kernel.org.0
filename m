Return-Path: <linux-fsdevel+bounces-12215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA1585D18D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 08:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 372AC286FFB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 07:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C74D3A8FF;
	Wed, 21 Feb 2024 07:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQLv9vS7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE00273F9
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 07:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708501112; cv=none; b=t1QATNfGmsjjGmq3zXj/hfMJtII+LTSUFzjTlFH+r+Z2LMhD+norHowu/7Y8wPpPTDw+2SaI9cmlv7Fnkq3FRGCa5qODMqwtRu5CdYSLKYbDq2P25DMZetFFZ0UsWrPSPNWjUbDb48SHvUMmKPazv6CZgZrt8NJXxYAl3Hz0q1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708501112; c=relaxed/simple;
	bh=HU95oS28JowLBd7WJtl/U0eKy1mDFHLY1kFEXGZpAEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N4TMKF2zmy0eA6kfs6Pu/fC547FL/XATTy5+5qU1XMLqAuFARVUT2HbaaBqQqlHVZ3VEWF5Hz0yBYdsI1+CjdD0OkTV+2nitqRv883h9xV5sB+UM4l3Xtkx2Eb6dzig3+stBrRgIZF0v0xTzlKUde0I1ij1kYRSWlZU9BV+N9ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQLv9vS7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63978C433F1;
	Wed, 21 Feb 2024 07:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708501111;
	bh=HU95oS28JowLBd7WJtl/U0eKy1mDFHLY1kFEXGZpAEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BQLv9vS70XFzK49/MDnE1SR6ayt/pvKes9yqIH3j5RMPhEs1uPIIMxlYiaqEeI9fT
	 n5ofe6Kq3ZdoHSBpxVNkYUERfPR7pjec4J5BxabZzyDH7dLW1CHOMSFEwzpjOnFS3s
	 YhFek7WuoJXGc5HbjDJIyDNbS2obPn/JjFXCyuRkvAMS6aDS/dsSX2yIRJpNwXZxxr
	 9NVlMG50wi6t8zpd1fZZmtExR6psGJAk8QeaMDFi5tFILCCNite7PdqxHX5wHqoMiS
	 BZqKsxVko+r9pRtxEjQDIXclO19vtNoOmoMjdyALkOeBK0VFamDdHi4OhGxmnOw4a2
	 53uB1KDEd35Zg==
From: Christian Brauner <brauner@kernel.org>
To: djwong@kernel.org,
	Kassey Li <quic_yingangl@quicinc.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: Add processed for iomap_iter
Date: Wed, 21 Feb 2024 08:38:03 +0100
Message-ID: <20240221-lageplan-nippen-83030d74e358@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240219021138.3481763-1-quic_yingangl@quicinc.com>
References: <20240219021138.3481763-1-quic_yingangl@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1029; i=brauner@kernel.org; h=from:subject:message-id; bh=HU95oS28JowLBd7WJtl/U0eKy1mDFHLY1kFEXGZpAEY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaReXVF4h7GiT6t+3q11TLLrrF7OU36UbLB1X+Q6i9s1U acv+B3401HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRBWYM/5S/dNmd38YhxSr/ xfB7tODB7Xk+VzPmnOi1af6S3r5uy0lGhl9XWkvvRTYo6JZ+WHi+RP//jwzZm7KThXn28MdJirZ M4wAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 19 Feb 2024 10:11:38 +0800, Kassey Li wrote:
> processed: The number of bytes processed by the body in the
> most recent  iteration, or a negative errno. 0 causes the iteration to
> stop.
> 
> The processed is useful to check when the loop breaks.
> 
> 
> [...]

Applied to the vfs.iomap branch of the vfs/vfs.git tree.
Patches in the vfs.iomap branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.iomap

[1/1] iomap: Add processed for iomap_iter
      https://git.kernel.org/vfs/vfs/c/05cf9db6031d

