Return-Path: <linux-fsdevel+bounces-58285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABD5B2BE8B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 12:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05FA816EA43
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 10:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFA7321F2C;
	Tue, 19 Aug 2025 10:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWDEn94v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638331E5207;
	Tue, 19 Aug 2025 10:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755598215; cv=none; b=dsEI12RHPe4Wa7WN8335tfMC3+Z/S9xVvFrANKDRWX++StbTnXulMhc+U5HpJDHNxizVyoX0YmNZ/whD4/VdRkqqmmGOwMIDnWmPfZUFV7c6C/kgxg5upnazJpApm6uvJ8URewXBrnlq0KebShrnfVVw9lFoHejjSp7Rkqgkcws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755598215; c=relaxed/simple;
	bh=Fl0SI0iL/x3g7XAYgUPV3q2YJFaf9uqWYJInRzelkcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f04g9SN1s6iVX9JKl/F6dFYp0nC3mpHI/eGesegukd1hBxUwWrqp8fkRuxMTli6FbMglsqVeenFr9QZqFskAWtA+tay9eoTVurTwt5DJkGk0hCu+aXgW1sqHhcVqOyz7NmFIrsul5pshrKryXw0Ez1Uln8DvjSX5aOkIZnuRjy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWDEn94v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E919C4CEF1;
	Tue, 19 Aug 2025 10:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755598214;
	bh=Fl0SI0iL/x3g7XAYgUPV3q2YJFaf9uqWYJInRzelkcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qWDEn94vaaKVggOeZwM2QSuAXcS8TzDp5OGpwkfbComxpu10jXwSrdSNYB55QUE5e
	 sgHFMkpIzu2JxpN9k0QPxR7O9tfkw6LjqGUvathkz+ObfH37ErjhFeKFAZwrtkbMLU
	 3ZacutnHIP5C73pXB2nf6XxPqrOBNDHpXPLY/Hbm1P/cDZxFNuWrRYvBw2xfEErPQ9
	 StOegzuQvfSXQ1r4x1B1I+35TZ5jg+cHEKyLgPLddS2WaVtwcPo7qvR1NrDs5QuqCP
	 Dp7kyTHC7z9Fp2I864ECd8Q22eOsjM/po6bx4Kxwm95A9T6ZXJuqFc8VR3jj0kKSGq
	 QKoj+eghNYcog==
From: Christian Brauner <brauner@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] coredump: Fix return value in coredump_parse()
Date: Tue, 19 Aug 2025 12:10:09 +0200
Message-ID: <20250819-vorweg-scherzen-e5449a0bb785@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <aKRGu14w5vPSZLgv@stanley.mountain>
References: <aKRGu14w5vPSZLgv@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1149; i=brauner@kernel.org; h=from:subject:message-id; bh=Fl0SI0iL/x3g7XAYgUPV3q2YJFaf9uqWYJInRzelkcU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQs8W1Ke5M3PekE84G7Bct5vk698rri7PEHJeynF62e9 2snr82ego5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJTNrFyHB7v96SJR2iJ27M /KC5eEro7l9f2TqXnGSryS6uE7y2640Hw/+8AyuDl562nxjLMaeYqyeilOGNoOlOk4oFpy+U5f8 ++Y0BAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 19 Aug 2025 12:41:15 +0300, Dan Carpenter wrote:
> The coredump_parse() function is bool type.  It should return true on
> success and false on failure.  The cn_printf() returns zero on success
> or negative error codes.  This mismatch means that when "return err;"
> here, it is treated as success instead of failure.  Change it to return
> false instead.
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

[1/1] coredump: Fix return value in coredump_parse()
      https://git.kernel.org/vfs/vfs/c/55f6e0b265d6

