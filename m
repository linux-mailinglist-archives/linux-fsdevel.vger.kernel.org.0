Return-Path: <linux-fsdevel+bounces-44532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B66A6A2DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 10:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AC09463609
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 09:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A458722257D;
	Thu, 20 Mar 2025 09:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3cHjiTz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B63A42A93;
	Thu, 20 Mar 2025 09:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742463740; cv=none; b=VfX0zBqJ3zd8TXrlDnTUV8Px3AxO7qDk/mAvD1AUEjxCV56+E0h02Xb8qsV14Zp3hpOxJud016/6zB39qnnzfvsIp6r34cFqRRX+QAiql6GJB9c36iNnqZ9IP40hN3B5lyKRrYb7auTbcogtFSFJiI0de9HrmstcMWsc1pGYBd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742463740; c=relaxed/simple;
	bh=PZ/7BGHRn6GuUaETo4eTdreWBAY9KxpU7F8noLXZgqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AOqd7wdT6PcBEaVDDFyBPF4KRMkrXetbUazRYW3sk+K2x9TMS5YbHnFeB1zGYtk8dDotWce83hiVWIETtf+A9abZ8d5O3LOoal3PmOQW7H+Fu8gFLh31WrrE6R6Mny2aE8P8JFbsYQmbvtRxcawbSRQicmyIqFdhfLK0B9D/YnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3cHjiTz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C593C4CEE8;
	Thu, 20 Mar 2025 09:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742463739;
	bh=PZ/7BGHRn6GuUaETo4eTdreWBAY9KxpU7F8noLXZgqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a3cHjiTzdma9DeUbw4fIAcpbpVg4JEugo2OB3ED9yotCmugNUYfU9yoiW4j+CZs4p
	 +xTXvpz5M9MoFE0TwNWXHe0ejL6P9TEgzSvqK4kJKdIXokeAhPKgCHNKLrff36CiED
	 0fB6GeRrxH6v7Xps4zwLVW7+R41FfqeyS2esj3nblKuZW17aWLJjaIJw/cQW1hhl3q
	 s6+RiKNAj6ooMjudSGg86X2ixuxbRlkth3Bi3fMbBK7MuRpeSeurdcH1yrz074SJXd
	 4Fx6Y8gENV93SsD3eqj2Hef/L+5Ta6ZErx/JTpdzhT/ll/IcOCNzrCze9sKbqP8w3t
	 jZvTmLK8gFg+g==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: tidy up do_sys_openat2() with likely/unlikely
Date: Thu, 20 Mar 2025 10:42:12 +0100
Message-ID: <20250320-kleeblatt-heimweg-40fad461e8e2@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250320092331.1921700-1-mjguzik@gmail.com>
References: <20250320092331.1921700-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=977; i=brauner@kernel.org; h=from:subject:message-id; bh=PZ/7BGHRn6GuUaETo4eTdreWBAY9KxpU7F8noLXZgqY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTffvRVdGt3X1PTemXR0A1MJ/r3MuwO5mPv9nw3Yc20L 6la/0qDO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYSf4bhr7h16dJlxTJ7nrae MhXO334/aK1tjNYKjX9l23suiQXvkmdkeCJ+m3upVYep2M0Zaq+PXjOTKD0vw7J0fvXXqM6Kw4d T2AE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 20 Mar 2025 10:23:31 +0100, Mateusz Guzik wrote:
> Otherwise gcc 13 generates conditional forward jumps (aka branch
> mispredict by default) for build_open_flags() being succesfull.
> 
> 

Applied to the vfs-6.15.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.misc

[1/1] fs: tidy up do_sys_openat2() with likely/unlikely
      https://git.kernel.org/vfs/vfs/c/d5a05a5a44a9

