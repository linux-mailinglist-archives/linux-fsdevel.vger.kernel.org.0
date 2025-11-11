Return-Path: <linux-fsdevel+bounces-67885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0ADC4CC49
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 10:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 277B934F364
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 09:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582D02F39D6;
	Tue, 11 Nov 2025 09:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rTinSDaL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9125328D82A;
	Tue, 11 Nov 2025 09:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762854572; cv=none; b=KYP20Ehwdgj0TLe/0hUDM3mcK4CuaX5QxOSW1gb1/pQx82bttp9mjYgA4ibHVg4PjqDI52lGkI1aErmSVbCMST232R8b2j4A+kN3ZIrRyPEhHc7Sdc3W9mtIxY9DaZedVAmxEvOTdj0Z6psCzAbS0pr14ZILd58xKN+G5ETgzJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762854572; c=relaxed/simple;
	bh=0x31FgwFPk7tbQJ/dNUF5WAD3jIbIn15xU7iThAjjHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p2kPWhVFaFmx2sqBZTDxC5iocov0Fhjrvy57xc77E6xi0A3cWYcb+bmzJF1oy/gBbC7X25uwlv3w3KyB0v0Sf/QWg4ddH7oDE0sLFESiDh2cYT54Qhv0uG3hzH/sUHOnxv28SbovUG1QERG92y8f7XUA07GzeRi5FhuQ/w3gwNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rTinSDaL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B477DC116D0;
	Tue, 11 Nov 2025 09:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762854572;
	bh=0x31FgwFPk7tbQJ/dNUF5WAD3jIbIn15xU7iThAjjHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rTinSDaLC8MIKY3aDvn6MpoxBxnoEP0bd0DTUXK515JNjPujpTZxMGB/5et8wPmqF
	 eJJaNzKSfKyNFE/egfo4LQrE+3eKsMrCKhh1eA16fGVYgqZkGUUfBzGXwrQB/Y5sH7
	 iDa3Ew1PVwCqQ1P43hE3uBCWyIqoA25gfUBxbhHY4rWcAdVlclThtqLdgEEcmSeNsp
	 RIOZhidKtHsOTMA2SJmkBuUuR2TQLFH8ZB51F+fQigqucB/lAuCL3wIuaawDUT9M06
	 Z8qwftbv0qbp3arpipGVINbKQiftOex/pZfddbYfz+WDC4MBYziUDtWTidk4U5zsBF
	 e26ohOs0D78Gg==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: touch predicts in do_dentry_open()
Date: Tue, 11 Nov 2025 10:49:27 +0100
Message-ID: <20251111-geangelt-vorwurf-8460469949e5@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251109125254.1288882-1-mjguzik@gmail.com>
References: <20251109125254.1288882-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=890; i=brauner@kernel.org; h=from:subject:message-id; bh=0x31FgwFPk7tbQJ/dNUF5WAD3jIbIn15xU7iThAjjHs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQKs62YudVmyqLlfBc2ro9fuvB/vkWm/Ip7y67zCjL6T r+vYPU6pqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAihvoM//0+/u/v1zhcvz01 SewVr5+IrILHva1r1t5jFsrmbv5t8Z+R4e83G6t7D+0O5wX6np5481///c71OjWNvztOadwv/FP mwwEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sun, 09 Nov 2025 13:52:54 +0100, Mateusz Guzik wrote:
> Helps out some of the asm, the routine is still a mess.
> 
> 

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

[1/1] fs: touch predicts in do_dentry_open()
      https://git.kernel.org/vfs/vfs/c/3717e71df8ef

