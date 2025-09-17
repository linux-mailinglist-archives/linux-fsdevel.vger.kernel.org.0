Return-Path: <linux-fsdevel+bounces-62023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C280B81DA4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 23:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7BBE4664BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 21:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA78221DAE;
	Wed, 17 Sep 2025 21:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="jm2dPY4E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C8881749;
	Wed, 17 Sep 2025 21:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758142966; cv=none; b=rMj2owNNWW42Em2xCOezy8te4ShSuPTFAqemsD0CSKHcLrYc1wFfjQ5UuZkq8AJiZn9nAVE994fEDUG6hQU3Y2YIBUpM+8PaqA3rJwlTfH2LgIRkIXCm/4LdVq+GU8wD1/7JoPnR3VAqyWbUHGPRyvwZep7QB+Q1ltn7TfbOK84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758142966; c=relaxed/simple;
	bh=LyhvicWtF9CdTY/2mJIMEAR0j94Wdt3is2ANloITX/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nxw01Q7Jjx4mYWlJJNwsfGRkkBHKf2TQEKQecsd9sGKtsBjE9hkBCTCQVmrtJF/wHC5SpICZ46Y6gA+0fBT9QIjtMfvDbup/4NkgFznY1JpGocw66fsgLJxyC+54sqg+/wbuTfi2zqGKXvBJdNcmvK4aPEef7gj7RfSJWd3HsXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=jm2dPY4E; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EVcQN4CUaNeIIDcnRPUab1KqeMqVv+hmGQzK9DEwlHc=; b=jm2dPY4EnEb9IXg4jThEJJVy6o
	skgTybswqe0hqewnJWG88Bf9HuBeVrsAagf8+J0AIHZlE0OyfcIexwPnJUd/404FBDjmsmR+xAl9C
	H7IsXKyXyTJEeVN6EhxLe4LjwjQK4tPgKarf4JVQeQr3Z9KgFTdX90NC2Uq8yU0cmkJn2Qbjdvs/O
	oIeGUqSsZFkHm81TxKPfR5wI+j1hPdvqpItQHY/13FkYD/O9E0sCzbP2pQ8MjNGOuOgbi2QFgE/5t
	cgSE810nP9M7HVEOcEuAqMdrHo/b5G0lxxAFlN/D6YE3/D5rDGuApTV8lyD1JvcJj/lKihahnZhKB
	5un50hrg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyzIX-00000008Qkh-3252;
	Wed, 17 Sep 2025 21:02:41 +0000
Date: Wed, 17 Sep 2025 22:02:41 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Max Kellermann <max.kellermann@ionos.com>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	ceph-devel@vger.kernel.org
Subject: Re: Need advice with iput() deadlock during writeback
Message-ID: <20250917210241.GD39973@ZenIV>
References: <CAKPOu+-QRTC_j15=Cc4YeU3TAcpQCrFWmBZcNxfnw1LndVzASg@mail.gmail.com>
 <4z3imll6zbzwqcyfl225xn3rc4mev6ppjnx5itmvznj2yormug@utk6twdablj3>
 <CAKPOu+--m8eppmF5+fofG=AKAMu5K_meF44UH4XiL8V3_X_rJg@mail.gmail.com>
 <CAGudoHEqNYWMqDiogc9Q_s9QMQHB6Rm_1dUzcC7B0GFBrqS=1g@mail.gmail.com>
 <20250917201408.GX39973@ZenIV>
 <CAGudoHFEE4nS_cWuc3xjmP=OaQSXMCg0eBrKCBHc3tf104er3A@mail.gmail.com>
 <20250917203435.GA39973@ZenIV>
 <CAGudoHGDW9yiROidHio8Ow-yZb8uY7wMBjx94fJ7zTkL+rVAFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHGDW9yiROidHio8Ow-yZb8uY7wMBjx94fJ7zTkL+rVAFg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Sep 17, 2025 at 10:39:22PM +0200, Mateusz Guzik wrote:

> Linux has to have something of the sort for dentries, otherwise the
> current fput stuff would not be safe. I find it surprising to learn
> inodes are treated differently.

If you are looking at vnode counterparts, dentries are closer to that.
Inodes are secondary.

And no, it's not a "wait for references to go away" - every file holds
a _pair_ of references, one to mount and another to dentry.

Additional references to mount => umount() gets -EBUSY, lazy umount()
(with MNT_DETACH) gets the sucker removed from the mount tree, with
shutdown deferred (at least) until the last reference to mount goes away.

Once the mount refcount hits zero and the damn thing gets taken apart,
an active reference to superblock (i.e. to filesystem instance) is
dropped.

If that was not the last one (e.g. it's mounted elsewhere as well), we
are not waiting for anything.  If it *was* the last active ref, we
shut the filesystem instance down; that's _it_ - once you are into
->kill_sb(), it's all over.

Linux VFS is seriously different from Heidemann's-derived ones you'll find in
BSD land these days.  Different taxonomy of objects, among other things...

