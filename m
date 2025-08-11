Return-Path: <linux-fsdevel+bounces-57359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F7EB20B47
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 16:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E378D2A5F6C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 14:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B785C35971;
	Mon, 11 Aug 2025 14:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/qI0wiI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1A41A314B;
	Mon, 11 Aug 2025 14:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754921306; cv=none; b=JM+kykrNHL5Tpji1xMszHGZcf/Wn1xK4FXwnRuoQHi3hUZ4aggEHkboB7NDouTTaibPvdDMncweIVTR2jUVYuTV5SCaHKGp6ufiIqCZGKQ3PFYAFvsl1KmLWr7rKpg7KJZyNIvbeNehzRac3Fgts/MdSUhN6xaGfNaZHWtXGXkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754921306; c=relaxed/simple;
	bh=HGN8ywaENQf9F+hB5Ui43d4vB2fUp6slqVPWEkCXdEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UlYBs3Oe6cW3GNQMov6cNJP/Fe412lUxa0+N52fVLizcee3BGixe4HThrzM0ib5WEhXvmLWrQVgh9xYguF4Ag2Ed3+dbxmY5rC6kah2EMLPhtB9qvmrSwBoWwsbzfKkid6uGrwVKlosKYxsnnOMuzT6pb56iocydJx5CULh68rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/qI0wiI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D79C4CEED;
	Mon, 11 Aug 2025 14:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754921305;
	bh=HGN8ywaENQf9F+hB5Ui43d4vB2fUp6slqVPWEkCXdEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G/qI0wiIkCSD4DJBwkLBvRcUNbMNoRUx1flA9hVC2M7sCTsdWsLe1qn6WicKrxACr
	 VvpD/OynAgGf3BmmDkpzbJnxmqci0ICxbUxv/UWtLqs+rYLeVG3WYqSB8BF+sT0Fks
	 zgr8QgWAi9yoShSjqrDLc/+rEYxKz5MmPg6yYW0HKCnU+wr7THNb4JpqVomW+M3e2Y
	 vcGxsb2B7+BfL5GbtcfF95VZuVDAj7D1yfBE+L1yLo65SS+lZpbPjKDkVgC3OAzWWd
	 xk2P2kUhRPm6ot/KpJ5cbvj0RaLxgVvh5lneqyOctHUUVMcivg1ZfTTV1vQEwx1wCF
	 A0YLR3JZzV4pA==
From: Christian Brauner <brauner@kernel.org>
To: Askar Safin <safinaskar@zohomail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	patches@lists.linux.dev,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] vfs: fs/namespace.c: remove ms_flags argument from do_remount
Date: Mon, 11 Aug 2025 16:08:14 +0200
Message-ID: <20250811-regie-wandlung-afa613e3853f@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250811045444.1813009-1-safinaskar@zohomail.com>
References: <20250811045444.1813009-1-safinaskar@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=881; i=brauner@kernel.org; h=from:subject:message-id; bh=HGN8ywaENQf9F+hB5Ui43d4vB2fUp6slqVPWEkCXdEY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTM/BnKeGW6eEPVt3viaxZPzjNiv+sql/e44+lvng35A Wmlr9MbOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbi0crwv9zBVEKN1TlqhqLM 7+Unb92XOVnU7iK/sUXjXtahOOHsfob/WRU22m7vHl0znzB9pnt89py7unrb3l6+szB7w5nQpZ3 p3AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 11 Aug 2025 04:52:23 +0000, Askar Safin wrote:
> ...because it is not used
> 
> 

Applied to the vfs-6.18.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.18.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.18.misc

[1/1] vfs: fs/namespace.c: remove ms_flags argument from do_remount
      https://git.kernel.org/vfs/vfs/c/59f67bb635a8

