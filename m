Return-Path: <linux-fsdevel+bounces-62998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 249E3BA8839
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 11:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CD201881558
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 09:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF5527AC3E;
	Mon, 29 Sep 2025 09:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwrBuOol"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1350A1E3DCF;
	Mon, 29 Sep 2025 09:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759136695; cv=none; b=lntd6Qq/GK97s3/oCD/43oOxp4lj5K5BxSU/mDt+JYsxVC/8uo0XmS7bl5VeevBsOxZSXnQp8ubmHLLEHDKr7sxoxw7UfiHNehHE5e6Xl7baNZMj6+WDDo52vzlYG5KrWWc4ytKulYsRCxtqMNmjCLX9+esqIPyGOke8BKMm6sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759136695; c=relaxed/simple;
	bh=4vK0/59OtasxF5+YaSHurOi4G475+R1NyvhlSls9L2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UKEsg3AHV4mutBYKsux4iwBKp685H0VzHsaEQixu5sxQfrYBWxoVbwW643OTTf474cjYUiX2DzSzHDrM4kjljYlSoBGTljsHjRn5aFetpvlpgtyE1ZPaWMji+tv1113SzItxUOJOwdSLBhQ2IHBGyA87TzTjK20snwlKvrmRfNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwrBuOol; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E09C4CEF4;
	Mon, 29 Sep 2025 09:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759136694;
	bh=4vK0/59OtasxF5+YaSHurOi4G475+R1NyvhlSls9L2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZwrBuOoltu+9Re4wEEXG53gYj79TOnDHIymSsxNAE2XpWtwrtoFeIkr93BLq1Gx80
	 xqVE8zfa2Ezx3eBrC1QErpxcv+Rl1KsrFzWBa48DV0nJbc23jsEunnjlMZ5CAY1Xcy
	 jgp4qRpAhDShncyzDlvm9ecuWe3ZHOEse5GiTN8N2hAorGX5vGxqc/G/noE7Spxy6J
	 ACHnUNo2QT4cp710fmoUiuNnVUi8GszjQ6g9APITiqp5VD7jKp9VNIOCfHBgyVAR+y
	 DgawyWoqzYBBduTuDaCaNLhcyaFHJgDHalpDnNauH3ClYDT7e4QOhR2T26QnUsFHOU
	 llVn455SZlHAQ==
From: Christian Brauner <brauner@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] initrd: Replace simple_strtol with kstrtoint to improve ramdisk_start_setup
Date: Mon, 29 Sep 2025 11:04:45 +0200
Message-ID: <20250929-rester-warzen-d3264f947cff@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250918162447.331695-1-thorsten.blum@linux.dev>
References: <20250918162447.331695-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1337; i=brauner@kernel.org; h=from:subject:message-id; bh=4vK0/59OtasxF5+YaSHurOi4G475+R1NyvhlSls9L2w=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTc8t7EeZrB8Mn7JfnPbr5fZ/BzRV5n771L2Xt9j+xMY vtltlhGpKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi++8yMtzQjOCMafPV6v4Z +1xL9Pk265P8M7ymNmiuucW6YqXzuekM/wumf0kOYjl3zb9ftXeesPwkJ+a9AiJnpcXE9bwbLTY vYQEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 18 Sep 2025 18:24:47 +0200, Thorsten Blum wrote:
> Replace simple_strtol() with the recommended kstrtoint() for parsing the
> 'ramdisk_start=' boot parameter. Unlike simple_strtol(), which returns a
> a long, kstrtoint() converts the string directly to an integer and
> avoids implicit casting.
> 
> Check the return value of kstrtoint() and reject invalid values. This
> adds error handling while preserving existing behavior for valid values,
> and removes use of the deprecated simple_strtol() helper.
> 
> [...]

Applied to the vfs-6.19.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.19.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.misc

[1/1] initrd: Replace simple_strtol with kstrtoint to improve ramdisk_start_setup
      https://git.kernel.org/vfs/vfs/c/17230195b76e

