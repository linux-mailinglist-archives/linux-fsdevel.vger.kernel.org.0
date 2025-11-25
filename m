Return-Path: <linux-fsdevel+bounces-69749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC41C84443
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 10:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F9073AE574
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 09:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D93D2E9759;
	Tue, 25 Nov 2025 09:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OucKf52F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCDB2EA723;
	Tue, 25 Nov 2025 09:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764063699; cv=none; b=N0n9QMsgrjq88zjtFg+N8YOgGeQwvl7yfTrPjwr6RponUBn9gjctEm/TqpWP5ZeAOtrrUKbvlg52xYB0RzCNrOy1RhC6gNeScQiCvo5aP+DjcqdEhN1MBHZLf4D7A1sNSPaz9CVAuRh3SEjztvL0mjlDpi818G1g8uf2FWTDviI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764063699; c=relaxed/simple;
	bh=EZH3ZoT/h3jE1nB+7BQmZudu4IYvLpK+tSAMnJS8t8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ioVMNMo/7KX9Q5MvQ3g18SZKDOjZAzT2rvqEvNsTi4o275iDNl1906w2JQ6/md3/zZWgBTQLZHNZdFbw7SIlx58X8iSO3I7eGJ4ZiVWhgV4umI5vgeEW0G84yJc7L3XqGdNZNAIQwBKp8jAbSm1mHXcfuJK9dfCxoHjw7dwdWPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OucKf52F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45365C4CEF1;
	Tue, 25 Nov 2025 09:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764063699;
	bh=EZH3ZoT/h3jE1nB+7BQmZudu4IYvLpK+tSAMnJS8t8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OucKf52FhPtINc8o+rDHlyQuoWdOZ23WYUkamnBRMbBwq8b5wBELAg9Wd4kLteX2w
	 E+PAenq6asoXSS9vtZfQWPPpg6If+O+uAodJW14BlxwNCLQF4RpeB5cfBTdj8cjh3n
	 0BBXe3bLULjAUcCpRrHsZgNtXNnr8fY6XCeUcrIYnYYRX9FBJ+O3fV1Z9pGprv4+cJ
	 4Wvez7nmvM61jSRX41bjw5l7VD/xKEz5kFV73RMTkjEH6eI9Amo/G4vrAVkS/sSqRq
	 o5e/7wM1zV8+V7UAaPa8Me70HeCcc5/tm5lkmztgHFGTNCC2hI1FYzCXScOhdPU68K
	 MQS/vhLTkkWmw==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Askar Safin <safinaskar@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Julian Stecklina <julian.stecklina@cyberus-technology.de>,
	Art Nikpal <email2tema@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>,
	Rob Landley <rob@landley.net>,
	Lennart Poettering <mzxreary@0pointer.de>,
	linux-arch@vger.kernel.org,
	linux-block@vger.kernel.org,
	initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Heiko Carstens <hca@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dave Young <dyoung@redhat.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Jessica Clarke <jrtc27@jrtc27.com>,
	Nicolas Schichan <nschichan@freebox.fr>,
	David Disseldorp <ddiss@suse.de>,
	patches@lists.linux.dev,
	Gao Xiang <xiang@kernel.org>
Subject: Re: [PATCH v4 0/3] initrd: remove half of classic initrd support
Date: Tue, 25 Nov 2025 10:41:24 +0100
Message-ID: <20251125-kotzen-achtzehn-551ae5a8ed70@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251119222407.3333257-1-safinaskar@gmail.com>
References: <20251119222407.3333257-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1683; i=brauner@kernel.org; h=from:subject:message-id; bh=EZH3ZoT/h3jE1nB+7BQmZudu4IYvLpK+tSAMnJS8t8Y=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSqVp5wOpontKfZfe/70xWPbcu9vFrnFNWIXimcunPlm p2ugXNWd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzk6muGP/yNHN382vYp2+2N JS/4VSsWM669Ezy51uzfzqJrEp8/hzL8DzfNbzv7aL5v4O+0RcyWehO4XT7wWjL+P/xW/uVfZ1t pTgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 19 Nov 2025 22:24:04 +0000, Askar Safin wrote:
> This patchset will not affect anyone, who showed up in these lists.
> See [5] for details.
> 
> Intro
> ====
> This patchset removes half of classic initrd (initial RAM disk) support,
> i. e. linuxrc code path, which was deprecated in 2020.
> Initramfs still stays, RAM disk itself (brd) still stays.
> And other half of initrd stays, too.
> init/do_mounts* are listed in VFS entry in
> MAINTAINERS, so I think this patchset should go through VFS tree.
> I tested the patchset on 8 (!!!) archs in Qemu (see details below).
> If you still use initrd, see below for workaround.
> 
> [...]

Applied to the vfs-6.20.inird branch of the vfs/vfs.git tree.
Patches in the vfs-6.20.inird branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.20.inird

[1/3] init: remove deprecated "load_ramdisk" and "prompt_ramdisk" command line parameters
      https://git.kernel.org/vfs/vfs/c/9c598c04183e
[2/3] initrd: remove deprecated code path (linuxrc)
      https://git.kernel.org/vfs/vfs/c/445b357b72aa
[3/3] init: remove /proc/sys/kernel/real-root-dev
      https://git.kernel.org/vfs/vfs/c/f84d950a0ef1

