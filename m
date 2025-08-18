Return-Path: <linux-fsdevel+bounces-58192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D36B2AE8A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 18:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95F4E5E6F3D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 16:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC61F341AD2;
	Mon, 18 Aug 2025 16:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4giumnp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B182765DF;
	Mon, 18 Aug 2025 16:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755535789; cv=none; b=h3hBIJJUsllpA807c8FTxPy0c6uMxRa0QPoaxKacKrMSr2tTGmsRKoWj0n3WoXin8RoFDtP7d11xhcSuvIDgGlkLOwZN2oTyA2CA7rXNvDPcjxDKxUFFfDlA7gKjqcZkFEdggKUvS30EX78CoDwXp0ErxXRd8eoOtgiBlGBK5e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755535789; c=relaxed/simple;
	bh=VGpm/1hHmniKJ6u6ZsB5IgUFZkxw7tYKazfEW3iawLw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lcFbc+6vlzXM/jn+Z4mAyPHjUTredo10MR4eltrbZYfYgPWDPlK4OerB0wI0G8mBSrBNQgHDzO5w301NChYJxid8yaEbJXlw7bQyQSqx/T96hu10rePEdYYU74SvEf+OjS5exKfxMUQoqM5kjsvOmMiGc1PFqDrw00AZWHbqyz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4giumnp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B75DC4CEEB;
	Mon, 18 Aug 2025 16:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755535788;
	bh=VGpm/1hHmniKJ6u6ZsB5IgUFZkxw7tYKazfEW3iawLw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=H4giumnpH4N75mXAx1pgSv85dH7+XnVe+SJekeagcGqbd4qsZT/L/QPrjnHSfk4VP
	 aKPJtUGS4eighlJVNkA9f28vsee5/CNDON1vezSiM7fWJ6SDyW21CfqiEIE2Y2jGc0
	 7y3QJVTHAFUNzFNPLi0awqIRbEeV9Dc4b+ej84z6hI2cfSs74fm9EY23hOKsByFW96
	 Gc/1MDg93lJvgvSRr3RegV+UI4nqI1i6/ICBpmZ6HylZ80erMJFtNS2Uo9k7KtNOpG
	 3JWIy7p4J+AtQ6iARdrg1f2dNHjMh6vcg0lDAjeGhgukBQhp2esTnXeDURLAsjeDxp
	 +uTqr5UC6ZoJQ==
Message-ID: <c3d5dead2b76161ba96187b85497e55a8a01032a.camel@kernel.org>
Subject: Re: [PATCH v3 2/2] NFS: Enable the RWF_DONTCACHE flag for the NFS
 client
From: Trond Myklebust <trondmy@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>
Date: Mon, 18 Aug 2025 09:49:47 -0700
In-Reply-To: <aKNNkFJ3mt0svnyw@casper.infradead.org>
References: <cover.1755527537.git.trond.myklebust@hammerspace.com>
	 <001e5575d7ddbcdb925626151a7dcc7353445543.1755527537.git.trond.myklebust@hammerspace.com>
	 <aKNE9UnyBoaE_UzJ@casper.infradead.org>
	 <88e2e70a827618b5301d92b094ef07efacba0577.camel@kernel.org>
	 <aKNNkFJ3mt0svnyw@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-08-18 at 16:58 +0100, Matthew Wilcox wrote:
> On Mon, Aug 18, 2025 at 08:56:31AM -0700, Trond Myklebust wrote:
> > On Mon, 2025-08-18 at 16:21 +0100, Matthew Wilcox wrote:
> > > I don't think this technique is "safe".=C2=A0 By clearing the flag
> > > early,
> > > the page cache can't see that a folio that was created by
> > > dropbehind
> > > has now been reused and should have its dropbehind flag cleared.=C2=
=A0
> > > So
> > > we
> > > might see pages dropped from the cache that really should not be.
> >=20
> > The only alternative would be to add back in a helper in
> > mm/filemap.c
> > that does the normal folio_end_writeback() routine, but ignores the
> > dropbehind flag. (folio_end_writeback_ignore_dropbehind()?)
>=20
> Can you remind me why we clear the writeback flag as soon as the
> WRITE
> completes instead of leaving it set until the COMMIT completes?

It's about reducing latency.

An unstable WRITE is typically a quick operation because it only
requires the server to cache the data.

COMMIT requires persistence, and so it is typically slower.
Furthermore, the intention of COMMIT is to also allow the batching of
writeback on the server, so that disk wakeup and seeks are minimised.
While that is probably much less of a concern with modern SSDs vs older
hard drives, the NFS client design has to cater to both.

So by clearing the writeback flag after the WRITE, we allow operations
that want to further modify a specific folio to proceed without having
to wait for persistence of the entire batch.

More importantly, it also speeds up stat() calls, since we can retrieve
the updated mtime+ctime values from the server as soon as the WRITEs
are complete, without having to wait for COMMIT.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

