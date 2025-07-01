Return-Path: <linux-fsdevel+bounces-53479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEDDAEF6E8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 13:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE7E8174C47
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 11:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E022737EE;
	Tue,  1 Jul 2025 11:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwBRfav/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E286C271476;
	Tue,  1 Jul 2025 11:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751370190; cv=none; b=jGMX5FniEl0f5Z8Eecg893As6VWJzSYYejJHkZrcolUxSWLgUrhcSOtgZ2eemSmdcFkOayq7KbqatnpQf0qUGU6h1sczBW4WkMxRobCHeK9MSuWSOg2/F9623WFUaXxaCgcpPHPrrOHLsK1dP/6WbkSheeyUNTRqr7OkKE/Jvrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751370190; c=relaxed/simple;
	bh=VztepSZjn9XnwkHDE3OcBc8llwcmcqz5id0pDHPNIAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tbKIqkWjVqfgz9/pf7qVxTZOUMS5kNIcKyJt0TGjXy/v7xsudsBasRUOb0R38aXlVM2t6VcsnEBZTpv0sU2o87PU+uQEFX+RwWzXmBWrogNc1NaQoPUlBpxYKGp3251ZylVr2BtM5ohstHyiDATS3rK/6IzyRZyjzfBxlKvJhfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwBRfav/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 603BAC4CEEB;
	Tue,  1 Jul 2025 11:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751370189;
	bh=VztepSZjn9XnwkHDE3OcBc8llwcmcqz5id0pDHPNIAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cwBRfav/EmxY7DnBZz6tIESBgy+RoO/M67X3HYsvfKWf6M5g2AYHf1K/YZLhJtrke
	 LOypgFFcz+f9K62282QY2ahxqv0gT9zYqwhm+NLX5HHBjuN7eiS7ZljMKaiGp/q5Vq
	 6le0EMyl66UP0juF7joX5GuADBod2Jh9qs3XmyVyVcFKtu8tk9CIMMPI9CkleGMsbo
	 1ADQ1Th6qOWZ88vBCgKWLrZP4I/FwZJUELnaa2KxMV8eg+TJbM/KwbgeCKRLsyPXSz
	 xyf5sXv/q86VWNNgRaEKYCXU9g8Q033Q7a8lL7mLntnt/NlVlf5BoyPcJwXIWO32pp
	 z8ni45evhyPcg==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	linux-cifs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steve French <sfrench@samba.org>
Subject: Re: [PATCH] netfs: Fix i_size updating
Date: Tue,  1 Jul 2025 13:42:58 +0200
Message-ID: <20250701-quert-tanzmusik-9be58de64106@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <1576470.1750941177@warthog.procyon.org.uk>
References: <1576470.1750941177@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1255; i=brauner@kernel.org; h=from:subject:message-id; bh=VztepSZjn9XnwkHDE3OcBc8llwcmcqz5id0pDHPNIAs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQknzxhJj/D39VYe3aaxSellqbPL0WCg79WtvxvmLvD6 djUPxLTOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbyt4Lhf02sLoey7cysqeoH TyxZlrWw16fTUzi89vdE2SOrbk77mcbwP/WvTp9z5Iv32jp3Jp5e+cx8sfWXxc+D7KJda9Mcbk+ YwQ0A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 26 Jun 2025 13:32:57 +0100, David Howells wrote:
> Fix the updating of i_size, particularly in regard to the completion of DIO
> writes and especially async DIO writes by using a lock.
> 
> The bug is triggered occasionally by the generic/207 xfstest as it chucks a
> bunch of AIO DIO writes at the filesystem and then checks that fstat()
> returns a reasonable st_size as each completes.
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

[1/1] netfs: Fix i_size updating
      https://git.kernel.org/vfs/vfs/c/9754a8f2d5b5
[1/1] netfs: Merge i_size update functions
      https://git.kernel.org/vfs/vfs/c/871cb1a5a294

