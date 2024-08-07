Return-Path: <linux-fsdevel+bounces-25221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3801949F19
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 07:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61B4C1F2005B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 05:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADA8191491;
	Wed,  7 Aug 2024 05:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7R7F53o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4DB2F5A;
	Wed,  7 Aug 2024 05:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723008225; cv=none; b=KK4iM4izaySYtQsUgyxd3cNeOLHXncMdX0qFrltpWqQdGrDOb9KxU1zg7+kXCr6buMnqKzWAuBywn7ZOgOOPDLUJA9c4J0MmLIPW5LIVc/3XT2eQA8Me/6ViXbuD6O7l3ix1yrsNRGyKt2U/vDklilIFDgMUB8fUPCkSbs84CAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723008225; c=relaxed/simple;
	bh=X7jyXLUcRUzTUYRwdQeb+64IY92ftyBRyeBz4apOoJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UfsTiN8xCIvKUvScBnVjlvUeZX2MMTc9A52Tuse2N+uHpOX4fQ6/LdnQBJp825TzH2EgXDJyg5H6cm8IK/cOfql4cSvewxU0AJpgkwiQT6odhLTODVMpaBjbaSfqIzNFU9V+fa4wpfT2Oa0mCZjEhegp551qpuFUf9p/Pe/Pq5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7R7F53o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2005C32782;
	Wed,  7 Aug 2024 05:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723008224;
	bh=X7jyXLUcRUzTUYRwdQeb+64IY92ftyBRyeBz4apOoJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I7R7F53oW94j5HuM1QgVOsgKY0yVWJDUoromLSMD1QjTdhi7XFkvsRWdQ2uRxcyQ/
	 bc5bgIZYEg+AVXMc8F8fHcr5RK9y7TdRgnuL4lQ/6xZ9ApCH/7EHsGnoYIUJHdr1WG
	 u7LWUi+qChdvsXEx9L+wkzcNa6MpIaoI2CWPHlFY0Ffowt+Qd0nTcLjytmNfomMm1W
	 pb1swJQxmqCVkzBu1MUb++vWpnedjaK26ihVUgcVwZk1WLwKGCOrNqTpHgug2k0fBh
	 UyXT9VhCc3yzKOL9CVO21jakqYdKDmcrLlZFg7BKZL4uJvgSegztejXcm1uDigg1AY
	 K0/Xnl4oCYM5w==
From: Kees Cook <kees@kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Brian Mak <makb@juniper.net>
Cc: Kees Cook <kees@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3] binfmt_elf: Dump smaller VMAs first in ELF cores
Date: Tue,  6 Aug 2024 22:21:22 -0700
Message-Id: <172300808013.2419749.16446009147309523545.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <036CD6AE-C560-4FC7-9B02-ADD08E380DC9@juniper.net>
References: <036CD6AE-C560-4FC7-9B02-ADD08E380DC9@juniper.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 06 Aug 2024 18:16:02 +0000, Brian Mak wrote:
> Large cores may be truncated in some scenarios, such as with daemons
> with stop timeouts that are not large enough or lack of disk space. This
> impacts debuggability with large core dumps since critical information
> necessary to form a usable backtrace, such as stacks and shared library
> information, are omitted.
> 
> We attempted to figure out which VMAs are needed to create a useful
> backtrace, and it turned out to be a non-trivial problem. Instead, we
> try simply sorting the VMAs by size, which has the intended effect.
> 
> [...]

While waiting on rr test validation, and since we're at the start of the
dev cycle, I figure let's get this into -next ASAP to see if anything
else pops out. We can drop/revise if there are problems. (And as always,
I will add any Acks/Reviews/etc that show up on the thread.)

Applied to for-next/execve, thanks!

[1/1] binfmt_elf: Dump smaller VMAs first in ELF cores
      https://git.kernel.org/kees/c/9c531dfdc1bc

Take care,

-- 
Kees Cook


