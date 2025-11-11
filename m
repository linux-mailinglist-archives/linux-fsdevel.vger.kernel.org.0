Return-Path: <linux-fsdevel+bounces-67915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 789CDC4D8B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 12:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D3A484FE08D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 11:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437C2347BA8;
	Tue, 11 Nov 2025 11:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUuU+Oon"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE00252904;
	Tue, 11 Nov 2025 11:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861589; cv=none; b=dAztAunCCK8SXEjbrRrWGZTDOUbK/DCiqgjdCJPerCzTpzWXqH+HZ5CdJHvEwN1DrNBe9Sl3NwA3JDgQ55I0dzZ8wLFBAqhaoRuUCKKxHvhalDSQfWc22hE4w2Mb3VLct0a1Vn4YQueyAbtumisHmBdfwa+QYkO5IGKII1WKt/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861589; c=relaxed/simple;
	bh=kzGd0t16keZQLp1SKkjVyEBBXkKF8aj2R550ABn6Dqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EtEcUDKgYB8YhTSOTxxEy0Q8CFMdHzV+N/4pJN4DsKtwiOqdFHNWP/Hlww7MVeVkLeLknNEXckHvNf/8jn4a25yEkKK6sryaB+F61hQ6xcfGHYYZn3Lpct3H9lz5xRV86XlWMf/57UFgS6z/AhK+62Myhk6J78ULl9QjYaf3sDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUuU+Oon; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EFEEC4CEF7;
	Tue, 11 Nov 2025 11:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762861589;
	bh=kzGd0t16keZQLp1SKkjVyEBBXkKF8aj2R550ABn6Dqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NUuU+OonWudRKa2CYq8IqDXxenOAqb54+6/1IRp5B3gGdYreV6M+DjYXFJlZj+Ce6
	 JuVgwOZBaOr1cTWKmxLc3StqgKTMKHDGWetcTFuDHBWhl+pHWAj+rfeC0tOfN+fhQm
	 gvwUe3uaR8o+5oKUHM2adcTJOybuG/cD6rJNU2bG+5aMJJycjXIwAsvLtOXJqxGKAs
	 WhNG0Ad4tImKT3gkMYdI7TW+WYZvv7UZS3UddWFws6LmU5YfV6iNvfA4R7TAIlPtce
	 +V/JkBq1w9rk5r51kbXm243A7MInOPh/UrqcFSqO0ExWF/8Ww+Tb1LIzTd/1Eg+WZ0
	 mW8KSQ/wZjuRQ==
From: Christian Brauner <brauner@kernel.org>
To: mic@digikod.net,
	Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	eadavis@qq.com,
	gnoack@google.com,
	jack@suse.cz,
	jannh@google.com,
	max.kellermann@ionos.com,
	m@maowtm.org,
	syzbot+12479ae15958fc3f54ec@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] fs: add iput_not_last()
Date: Tue, 11 Nov 2025 12:46:21 +0100
Message-ID: <20251111-fluss-vokabel-7be060af7f11@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251105212025.807549-1-mjguzik@gmail.com>
References: <20251105212025.807549-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=949; i=brauner@kernel.org; h=from:subject:message-id; bh=kzGd0t16keZQLp1SKkjVyEBBXkKF8aj2R550ABn6Dqc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQKK/FvCJhyV1Y4zHmC/OojRk/FdQQczrYLLUqYkHnpv WzBe4vFHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPJW8/wv9xiibkr51dHu59X TPyzWnQvmD6rd3zrvT3qZdDh5R83XGP47x99/eCNPV/+Ox94lXb+zHaV7c2JJdIcvK87ljDEG6s ycQIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 05 Nov 2025 22:20:24 +0100, Mateusz Guzik wrote:
> 


Applied to the vfs-6.19.inode branch of the vfs/vfs.git tree.
Patches in the vfs-6.19.inode branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.inode

[1/2] fs: add iput_not_last()
      https://git.kernel.org/vfs/vfs/c/a1cece5d8881
[2/2] landlock: fix splats from iput() after it started calling might_sleep()
      https://git.kernel.org/vfs/vfs/c/9638e5c3b673

