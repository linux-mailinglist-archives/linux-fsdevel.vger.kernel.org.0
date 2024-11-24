Return-Path: <linux-fsdevel+bounces-35727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3AB9D786C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 22:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 427E516306D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 21:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CC016EB54;
	Sun, 24 Nov 2024 21:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="BiN+W018"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49372500BB;
	Sun, 24 Nov 2024 21:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732485022; cv=none; b=AouTsljwWdK1jFsKIXg7CydYx/t2ydjUFmbESSSFX7gR4vXo6M9cTZPRytZS8vPH1Oj9G+M7nGcXKoI5vVEsKkz5lj5i24dDC0OK5EdH/qiAuyBCgxKXWA6ZSfBKA8Ca4tt/2mz7CtrxHCeidZ616Ybj7hcaGppjZsYDKmvcAOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732485022; c=relaxed/simple;
	bh=4PsSwdKjaWqgOGnVapJ2Ij4QEoYdeIt9LhJImpVYXLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8655DwN/D+XeL1xUiOIxFNx4RxxrIkY1KDHqyFdg03ZJORQOFoOkyBJNYV81Yv2FAC8qxMTDB6oENq2hTQYFlhfJW22F2AjJvirxW9mKSjjEOvWNkdqxPeTBtJ4bbNmkQx2rlHMyQyekhOdIu87pGnR0xsWHGx0/DPBOQ8Aiac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=BiN+W018; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YO38aJuK/ydwVhNfg5QHsSshYIpYb8WewTIAM81CKsc=; b=BiN+W0181VOPJ0d006+/35KbwN
	SvMmADgUFspNVeFnPXTpDFQy/sot1jPII7oPRluhd4Q/jCrffXgvgAUUAIy1hTcuzkQzgbFPxxqZe
	ZwDFZ0HZxcUlp6UYGZnyST/M3TXdcjVouI3a0tEuo3KKuC/IIZKbiQSYJmDpnrLoQqX15xr46mohM
	FLdDuDI1lO/o1V2MyJnfQnqfSJ7dgViSx5Qk9CfWjMyrGlawPvJhOVIW9qNKPb4oUZRfYbUQTUCTd
	9AqBhKu8YkzNof9+0l/KEV1J1YsraV4HfyUQ+OFSgpw/f4PO2Cq7HDh47Vuz/3utaVtwOoDGdyxdo
	IoMqtpqA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tFKUg-00000001K8M-44xf;
	Sun, 24 Nov 2024 21:50:14 +0000
Date: Sun, 24 Nov 2024 21:50:14 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Hao-ran Zheng <zhenghaoran@buaa.edu.cn>, brauner@kernel.org,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
	21371365@buaa.edu.cn,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC] metadata updates vs. fetches (was Re: [PATCH v4] fs: Fix data
 race in inode_set_ctime_to_ts)
Message-ID: <20241124215014.GA3387508@ZenIV>
References: <61292055a11a3f80e3afd2ef6871416e3963b977.camel@kernel.org>
 <20241124094253.565643-1-zhenghaoran@buaa.edu.cn>
 <20241124174435.GB620578@frogsfrogsfrogs>
 <wxwj3mxb7xromjvy3vreqbme7tugvi7gfriyhtcznukiladeoj@o7drq3kvflfa>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wxwj3mxb7xromjvy3vreqbme7tugvi7gfriyhtcznukiladeoj@o7drq3kvflfa>
Sender: Al Viro <viro@ftp.linux.org.uk>

[Linus Cc'd]
On Sun, Nov 24, 2024 at 06:56:57PM +0100, Mateusz Guzik wrote:

> However, since both sec and nsec are updated separately and there is no
> synchro, reading *both* can still result in values from 2 different
> updates which is a bug not addressed by any of the above. To my
> underestanding of the vfs folk take on it this is considered tolerable.

Well...   You have a timestamp changing.  A reader might get the value
before change, the value after change *or* one of those with nanoseconds
from another.  It's really hard to see the scenario where that would
be a problem - theoretically something might get confused seeing something
like
	Jan 14 1995 12:34:49.214 ->
	Jan 14 1995 12:34:49.137 ->
	Nov 23 2024 14:09:17.137
but... what would that something be?

We could add a seqcount, but stat(2) and friends already cost more than
they should, IMO...

Linus, do you see any good reasons to bother with that kind of stuff?
It's not the first time such metadata update vs. read atomicity comes
up, maybe we ought to settle that for good and document the decision
and reasons for it.

This time it's about timestamp (seconds vs. nanoseconds), but there'd
been mode vs. uid vs. gid mentioned in earlier threads.

