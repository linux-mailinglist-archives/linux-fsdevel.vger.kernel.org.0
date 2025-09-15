Return-Path: <linux-fsdevel+bounces-61384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC7CB57BDB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F4BD3B8D0C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FBC305945;
	Mon, 15 Sep 2025 12:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0qZPT9Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AA62D47F6
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 12:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757940653; cv=none; b=kjhSVvZTeALCTM5eltP9dYBnlPdaU4EF58LCR+uv+Fs2QzbApirrRpsrgOWKSAxzgtG3Xov/YzB/X30ci30E/Li+BKSlnJVqkiCD/RErMeShkxYrOl2i8+Llp7bP57q0uEy2HVD2+FfPrEZxaSO3xFiKPSW/MGIJ1IE2TIrC1tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757940653; c=relaxed/simple;
	bh=jerrVyqkq4DEOmTdUxIidBFVpheiHlGUMHkwc0ppTHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ez3R3jeI5f92oYo189gUgHHOc5zuDQRMqcEZn8xZdBsc0sxonOYfwWy15nfOZ87uirw9aLcrkqelcPNaUwICM+wRu4ZdUA10EPACLdcsXWAc3TDkbyp0cfrfoPj/Ocnyv6QqvgpmkpQg8LWs+pr9ohqaLgKo6+xvrsHpay5Qnrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0qZPT9Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A79C4CEF1;
	Mon, 15 Sep 2025 12:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757940653;
	bh=jerrVyqkq4DEOmTdUxIidBFVpheiHlGUMHkwc0ppTHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J0qZPT9YFIYfoudTrst+iBYELk6QMeENvdr5dKKIB0nKu5vwZ+5sksDg9zdnwA6Tk
	 1h0bbl3OIWK8cRG8+QNc3nLDuVr+D11Zt9B+//B6p17dyGJb1yDkQ7tk6xKXSW71MX
	 R5gcbKiUeHDsjS6wOLe2ABuOLE246n2M2K7U3rskEaceEBUrZCW2vL4Cwhrvcp1gOi
	 S4T7syu6SYmdHwkfaW0Qi5XbYEVh4nehHzaM/7v0okRqdsRniz59auEm/2LqgegXuk
	 012KKA5r9hAm2d3M8elQ9m8C+PQsxCFHBUWZPNwNlr865L4c3sPkKCYGTqv4ikJMZJ
	 Z1y4164Awlv8A==
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 0/4] writeback: Avoid lockups when switching inodes
Date: Mon, 15 Sep 2025 14:50:46 +0200
Message-ID: <20250915-anlegen-biegung-546ecc3b96a5@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250912103522.2935-1-jack@suse.cz>
References: <20250912103522.2935-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1685; i=brauner@kernel.org; h=from:subject:message-id; bh=jerrVyqkq4DEOmTdUxIidBFVpheiHlGUMHkwc0ppTHE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSc4F6xqb8gK/P3YpPdQdF28/b0f+o87/Y1P+e67JIcc bkHnX37OkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZS84Lhf0qlTaRcYaSKvFfD I+tPDV7xky36XvkJVBesOt8Xlr+Uk5Fhp+SqE+UbsraZMd/21hXuu1K649y2hOJD16WYF0hGPTZ lAAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 12 Sep 2025 12:38:34 +0200, Jan Kara wrote:
> This patch series addresses lockups reported by users when systemd unit reading
> lots of files from a filesystem mounted with lazytime mount option exits. See
> patch 3 for more details about the reproducer.
> 
> There are two main issues why switching many inodes between wbs:
> 
> 1) Multiple workers will be spawned to do the switching but they all contend
> on the same wb->list_lock making all the parallelism pointless and just
> wasting time.
> 
> [...]

Applied to the vfs-6.18.writeback branch of the vfs/vfs.git tree.
Patches in the vfs-6.18.writeback branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.18.writeback

[1/4] writeback: Avoid contention on wb->list_lock when switching inodes
      https://git.kernel.org/vfs/vfs/c/67c312b4e9bf
[2/4] writeback: Avoid softlockup when switching many inodes
      https://git.kernel.org/vfs/vfs/c/a29997d9fe7e
[3/4] writeback: Avoid excessively long inode switching times
      https://git.kernel.org/vfs/vfs/c/897113876f46
[4/4] writeback: Add tracepoint to track pending inode switches
      https://git.kernel.org/vfs/vfs/c/dd5f65bc09d4

