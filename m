Return-Path: <linux-fsdevel+bounces-40549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEACA24ECE
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Feb 2025 16:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 756997A1F8E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Feb 2025 15:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F090B1FAC4A;
	Sun,  2 Feb 2025 15:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="DExWEd4E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932D62111
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Feb 2025 15:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738510029; cv=none; b=OVlyMpxO6/sB86Hi5ns8IhkB87osDYVwzIx70GlovIznjmwvz6VHkvu5vxPjsg5jrDmflKAJ3cYXk1Dowl/5Ij/NdzAvQUk8foR0fNYrrNmJfhMljOnfjC1eAIHWi8XK+A0UqvDoGdXhu63ZcOsBCZNIpTSyKCKJ86/jwcpPVgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738510029; c=relaxed/simple;
	bh=obeS34KniWi/wmRUTIL9apthidjUZMP/WLj9wi3uci8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fVCyItnzAWf5gTJ8j0had2rXmu7qvLmwtJRfgAipf/ddQ5dCwUofp7QpLqDG6oSxZVxz9G8XLi1Yt2fPrc3n1qfBNioKW/w+IyB3mqDO8BZo66vA86egCGV6XNdW4Wm/peG/mTmZqCR8pMZT0KDO1kIdAV8dwJtsJkrX9WzoaK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=DExWEd4E; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-91.bstnma.fios.verizon.net [173.48.82.91])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 512FQTM7019900
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 2 Feb 2025 10:26:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1738509995; bh=JUMulcP2dijOkUxApYb72vlPwMEgWNqNfp3FATtYrzU=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=DExWEd4E8PgJNcFxMyCg8JMJ2QqErG69nscSEJOq0qJHPYDdy2e/BT81EVZEpy3c5
	 zCXi5Ctbq/AulZ5P8i0moDau7YSUkHpTH2yJjeV3OrSSg6f40Htm3Si5rocLVZ0/XM
	 /eDGUrBYPo6BX0EID9k+nMfCRRcyRXRPgw2JGMN5ZWCfuDaPUyN39TqqJCfFvnUt34
	 0D+ocFMdqvWZbECA2bBJBuM8XUQksHGXoWJV0vWjLUmM6cwlRNnrovOX4mcGedf7dg
	 imxTovsB7awDDAdZjsXsgzFbKbIrhcwnj4x2ZSSCd2HrwfJfAeZzizai+U5/6Rpseq
	 I+HJ0krux1spw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id EC98B15C013F; Sun, 02 Feb 2025 10:26:28 -0500 (EST)
Date: Sun, 2 Feb 2025 10:26:28 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Zorro Lang <zlang@redhat.com>
Cc: Amir Goldstein <amir73il@gmail.com>, "Day, Timothy" <timday@amazon.com>,
        Andreas Dilger <adilger@ddn.com>,
        Christoph Hellwig <hch@infradead.org>,
        "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "jsimmons@infradead.org" <jsimmons@infradead.org>,
        "neilb@suse.de" <neilb@suse.de>, fstests <fstests@vger.kernel.org>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Lustre filesystem upstreaming
Message-ID: <20250202152045.GA12129@macsyma-2.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250201135911.tglbjox4dx7htrco@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Sat, Feb 01, 2025 at 09:59:11PM +0800, Zorro Lang wrote:
> Thanks Amir, I think fstests has nothing to lose to support one more testing :)

Well, in the past I attempted to land a "local" file system type that
could be used for file systems that were available via docker (and so
there was no block device to mount and unmount).  This was useful for
testing gVisor[1] and could also be used for testing Windows Subsystem
for Linux v1.  As I recall, either Dave or Cristoph objected, even
though the diffstat was +73, -4 lines in common/rc.

[1] https://gvisor.dev/

So if it is really simple, it's also not hard to keep it in an
out-of-tree patch.  I've been maintaining [2] in my personal xfstests
branch, and kept it rebased on top of next, for years.  I figured it
was easier to keep it out of tree than to try to fight through Dave or
Cristoph's objects to get it upstream....

[2] https://github.com/tytso/xfstests/commit/7f8047273c8c963fdb9c3d441fe6d0f2a50cd4a3

So even if we can't get Lustre support upstream, I'm happy to maintain
it at my xfstests tree on github, much like I have with the "local"
file system type, for the past 8+ years.

Cheers,

						- Ted


