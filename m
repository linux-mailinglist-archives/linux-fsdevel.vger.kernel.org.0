Return-Path: <linux-fsdevel+bounces-35967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D62D09DA565
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 11:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41CAC16662D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 10:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23091990C1;
	Wed, 27 Nov 2024 10:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOGTeqzW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC11194C6A
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Nov 2024 10:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732701928; cv=none; b=EWTgeT91gAyZWQvwkJro0QApfCOX1OcokuDWOJ1hSPuhsgCJ/8kdEVkMYLFyfYwpjGsALJhlWLBv0WkvFpj/0K2lYki7kpsf4B+FdrRpuJ5fDKph64z618eyWCc6QP3PPZvhWAkCPYq4e/z7fdCp6ixrV/ie+JHvdldY61fuJGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732701928; c=relaxed/simple;
	bh=1MZ0aEHsvnYXKi6iNhFxQCbuVdQvb0gDH6QhiHTzoR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a43KekcolR8BF/Cx+Z9LmVbgOx06022SNxlijksOJUwv6/O1aY+q9GamK3PNPciOtO40gh+dRPkje3IeCyQ2spRa73QBDwcPgPz1z/544rlcOg+lC+YCjBvZt7TAAfkTUtibMN2xZ76RosUgVL6916BN6Kw2uQRucO637hDhidA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOGTeqzW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FEB6C4CECC;
	Wed, 27 Nov 2024 10:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732701927;
	bh=1MZ0aEHsvnYXKi6iNhFxQCbuVdQvb0gDH6QhiHTzoR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IOGTeqzWF5+Y+2jQN5OxjWBTJU8c5sQZ2OtCvsP1U3OSkDjGhmqVBrRk9ko5EbB+j
	 Y7mTxvg/5PhPkpczz4fTQOnj0QRbNGITv2kMfuqDS71+br/bnW0psleAqo9oLRkTtL
	 kc1g9iaca5JLN2V/T9GgDyZvmuvI6tSB+POPA3aExoCSueg9sDr0Oy4u9A6a0wdhjw
	 ZLz5wrga03oZzie8udrruGnK6x8KvEOxrdVYGY+/V5fX/LxEkuSFyXuoJXyE+S5Bd7
	 hK3tlUBeauRskQjgEbKYp8EsPqy5vDBzE5m/b3PPpUp7COLsnOnf76jWLcftYBKnAJ
	 vIgiM7qlzzSAQ==
From: Christian Brauner <brauner@kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] watch_queue: Use page->private instead of page->index
Date: Wed, 27 Nov 2024 11:05:20 +0100
Message-ID: <20241127-minigolf-erteilen-3c496024bcae@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241125175443.2911738-1-willy@infradead.org>
References: <20241125175443.2911738-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=936; i=brauner@kernel.org; h=from:subject:message-id; bh=1MZ0aEHsvnYXKi6iNhFxQCbuVdQvb0gDH6QhiHTzoR8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS7vXsQHDbnzGP20itsW19V+3DeCNP7KPaCKd1Y7Nzu2 czyTcdyO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYi9ZSR4ZfK/7q2yESFKQFa u97HxK8S6g59dHfHDhZ5v79mVj3tFYwM773j9LJf35G9/ERR0spRskT+8h7nxmqrmlgVpxgP8Zf cAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 25 Nov 2024 17:54:41 +0000, Matthew Wilcox (Oracle) wrote:
> We are attempting to eliminate page->index, so use page->private
> instead.
> 
> 

Applied to the vfs-6.14.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.14.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.14.misc

[1/1] watch_queue: Use page->private instead of page->index
      https://git.kernel.org/vfs/vfs/c/d9939e632f62

