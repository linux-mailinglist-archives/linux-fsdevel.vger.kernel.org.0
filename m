Return-Path: <linux-fsdevel+bounces-32580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DBF9A9D9F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 10:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 227F31C20EFD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 08:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF61191F7B;
	Tue, 22 Oct 2024 08:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJx1qx8q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC2E18D640;
	Tue, 22 Oct 2024 08:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729587394; cv=none; b=OH3oNOvubtiOzlJkfTtFA/CnvaKLl0vvholyZblWZGH6vU2eRgdVMVRU4ZNSzQiHEsDnD1Zi2MmkKOJ4YrvVuHaaoYXFrTpUT3hPowtDoF68jTOx2dNxJKNzW6kYPcdIqHQKzkBGm96kqEYt0N2JjsTdD+Vwb2BHpXz0wvkImLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729587394; c=relaxed/simple;
	bh=ZLw6gFMY4Cb5+zhRGaODfl7DZxpfc0P3QjxHnCkbGog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PiU9RXojRmIp0VzOrhq2/s6ll2YBN4FuPMQ/RMOsTfrhZmZWT+Q89iqbRJ+coR+3UfTLnZtOwMIYctOpmkuF64nLXMfiff/ci2PUFDJ+gx8JbYIFPL/d+IUqan2Zoc7wu/JVZkPA6zV09ybRtqtpuoOSrPrTunHHFHhguqOxnNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJx1qx8q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2AA5C4CEC3;
	Tue, 22 Oct 2024 08:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729587393;
	bh=ZLw6gFMY4Cb5+zhRGaODfl7DZxpfc0P3QjxHnCkbGog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hJx1qx8q9qbI2wT3QhNsJuy7pnqYbqI2l6G6BZ5o96XW4mUKeLEr0hbN36HdLrQUi
	 EVja1gB531feRBK88y49PG3ayOYRLh1PlEd7lQGha2bHcWlvVJY5h3ZX75wH1eUfeJ
	 tXPy3oi3/TQgIoBd291lB5pp0MaXpo2NqLYNaqp/xQ+eP5gkAOu8DC3pkNWWg1xyeu
	 VItFX5qHeSr/egEjP+qlBdFq23xgwQAf01CnO1ITrYPYgiSe5ZK0gFzrnRtNGU3Xfh
	 WsVP/FR9TlZV/CdBn3bxizeQdfM7AwszXsnq7pRzP66PdqVzCydOCAEHC1byxkidn6
	 vOQrRP9yvh91w==
From: Christian Brauner <brauner@kernel.org>
To: Antony Antony <antony@phenome.org>,
	David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Sedat Dilek <sedat.dilek@gmail.com>,
	Maximilian Bosch <maximilian@mbosch.me>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] 9p: Don't revert the I/O iterator after reading
Date: Tue, 22 Oct 2024 10:56:24 +0200
Message-ID: <20241022-weinreben-womit-68c97935ae32@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2299159.1729543103@warthog.procyon.org.uk>
References: <ZxFQw4OI9rrc7UYc@Antony2201.local> <D4LHHUNLG79Y.12PI0X6BEHRHW@mbosch.me> <c3eff232-7db4-4e89-af2c-f992f00cd043@leemhuis.info> <D4LNG4ZHZM5X.1STBTSTM9LN6E@mbosch.me> <CA+icZUVkVcKw+wN1p10zLHpO5gqkpzDU6nH46Nna4qaws_Q5iA@mail.gmail.com> <2299159.1729543103@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=971; i=brauner@kernel.org; h=from:subject:message-id; bh=ZLw6gFMY4Cb5+zhRGaODfl7DZxpfc0P3QjxHnCkbGog=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSLZ+y6HXLwh/UDjeR73X5rNvXclNxg23fi+gwfk/22j 9w+fJv2rKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiHzgZ/go4CfPZuk9+d6jt qu6MN/1JAWfXlz6epa/8rG7tcdGTfo2MDJ8lWzYvupin8usF9w2PI4enml7++KL3+iv1vytfOng Vz+YEAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 21 Oct 2024 21:38:23 +0100, David Howells wrote:
> I think I may have a fix already lurking on my netfs-writeback branch for the
> next merge window.  Can you try the attached?
> 
> David
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

[1/1] 9p: Don't revert the I/O iterator after reading
      https://git.kernel.org/vfs/vfs/c/09c729da3283

