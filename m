Return-Path: <linux-fsdevel+bounces-19893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA278CB02E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 16:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFECC284A1A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 14:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CE17FBBE;
	Tue, 21 May 2024 14:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouUbzHOi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E621271B48;
	Tue, 21 May 2024 14:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716300972; cv=none; b=Ob0rv9PASElMpzaOHAWJ6uLmXz4JEFAaEhnLyidTM2BFSbLPUp7u3Fae5xw+mfbWYG5baD/v51kLWd6JOTcByhoK4U7394rjvGX8F9J8KsQ9alnMcmPlNXVgc8XF1erN34Ht9wevBkE1+yi8Ol56yYKkDQfsVSksAG5W8+CNT0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716300972; c=relaxed/simple;
	bh=QzfF+EFnCDCxFr4kbXOmJ2u12v1wZA/7KB6nqUZ27qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ahQtoKfnFW0fu7xaI/56v+CxTX+74hFhe45lu4p325yMyxSRc45fElxdyvGoHIDOwPvSOeXNDxPWeTLh/QSsSvUdxsb++2rFqg8UjeBHDCcclQlIeV6rQUInFkLZLdcrzRcY2tNoMlnNSFA2yqyI5mslnk1h06nV03HT9KMFT68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouUbzHOi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A19CC2BD11;
	Tue, 21 May 2024 14:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716300971;
	bh=QzfF+EFnCDCxFr4kbXOmJ2u12v1wZA/7KB6nqUZ27qc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ouUbzHOiGuwDb7dxQAPrA0+vH+s2nu6ziinxfrQwSpKu/ViJUOJ7AmC1QKr6FlCzS
	 cODYGRQLPduIqIox2nNxLvgLpKcuWHFUIBQNTpBG2ImM0SdxQ2iHWvgNkWdTC2PDTI
	 8iLCRm81GUvbxilTftjxKr86rFugqE5hQqQtWK7AAvqZuUYy5QLfc1CyB7Lp+ruVqi
	 Rf9TvORajynsPXbNAS6bubeL7C4/QPXJg6mHdOEeCbXqitr160MZgZPrDLks6BVt33
	 IP4UhT9Ah/J6yi181U8/scaP3MnVsEPapipX4EkqFA0wppUmYD32e3mttlupgMHzFi
	 GjPXrYD/0nDKQ==
From: Christian Brauner <brauner@kernel.org>
To: Steve French <stfrench@microsoft.com>,
	David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	netfs@lists.linux.dev,
	v9fs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: Fix io_uring based write-through
Date: Tue, 21 May 2024 16:15:59 +0200
Message-ID: <20240521-teigwaren-gehindert-316a25d666fb@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <295086.1716298663@warthog.procyon.org.uk>
References: <295086.1716298663@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1116; i=brauner@kernel.org; h=from:subject:message-id; bh=QzfF+EFnCDCxFr4kbXOmJ2u12v1wZA/7KB6nqUZ27qc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT5rFnE4m8x45/62gSOdNld15xUDxTflL8eOu/uQo9J0 5keLp97tKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiWQ4Mv5jPHN/z8/PNp+9n lJ/faN5zQWrViSXb43a4nuZvWGqi9TKV4Z9uXuCTO+9PdT/K4b4vxXPkQpXOo5THz5254pYn6QV OXcwHAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 21 May 2024 14:37:43 +0100, David Howells wrote:
> This can be triggered by mounting a cifs filesystem with a cache=strict
> mount option and then, using the fsx program from xfstests, doing:
> 
>         ltp/fsx -A -d -N 1000 -S 11463 -P /tmp /cifs-mount/foo \
>           --replay-ops=gen112-fsxops
> 
> Where gen112-fsxops holds:
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

[1/1] netfs: Fix io_uring based write-through
      https://git.kernel.org/vfs/vfs/c/c51124cbc622

