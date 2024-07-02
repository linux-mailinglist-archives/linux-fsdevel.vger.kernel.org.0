Return-Path: <linux-fsdevel+bounces-22957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 299EA9242FD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 17:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC13E2835E0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 15:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CED31BD01A;
	Tue,  2 Jul 2024 15:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwVHIaKM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A129E1BB69C;
	Tue,  2 Jul 2024 15:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719935886; cv=none; b=oe9qfJuXDn8Sjpi8tLKZ+Cvcmd64Mo3KTTq0ghjL9TU+N794dwzVxW6gnZvHmuQaEB8AynL0h3+MYDplQBmcZ8rEaKYyHk9lPKTnqfa2HZy+3gdtvP1xQWViyIDLruh4bbu0hRc/TJzHZwp6Bd3LOuPtqTu+8xbjgmf7vURaya0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719935886; c=relaxed/simple;
	bh=yAxpNc/j1H0lyF8Ynd7Qrc3hhJ0EXoOLvIipfqRn/+4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GeKozZROevj4a+h5jPxMqqBlbH0P5kzckf7JeZkDagXYsvDP8tdLkiDy9mkwUv2kuQAjUjbknKbcOl+8LW5Cu4uo/5JeRNsJK8bGNBVgreSUp5Pmvj6oPSvXw1vyszoMTDEapCuu45A1R9h6yUl7tPZkmoRkHL71eVjqWYnXDbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwVHIaKM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24005C116B1;
	Tue,  2 Jul 2024 15:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719935886;
	bh=yAxpNc/j1H0lyF8Ynd7Qrc3hhJ0EXoOLvIipfqRn/+4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=VwVHIaKMM6joL2OslHAIAERB/dK2OuRh+N0Rf+7RMwG7aMwTxfVAG3DGHCTWgLyxD
	 D9QtAFozBzc0dfXK/zUPJkn93gkFxJX6y4A9x4CCxeoKydX1JVfdG4H9JISZZgBxoP
	 u+Tu5bHyJGR070eTHxhXAu/RzX0XoNtClq0VehfB6+i/tQOvIlW8TLOIad+lsIWlF9
	 8Rsucv9SKOiMNOqpzS32EjPT8qjnE+2EZ/7cl3xwlnLCawNDUCcvHg62u28nndcycD
	 VaCvTYyaBg5zquzAKQ3wkGbsjU3mTAY2vaEGX7W5z3cnlk3IU2OSbQ0MmJeXSYlNr2
	 CupBjaiOz8EqA==
Message-ID: <4ec1fbdc6568e16da40f41789081805e764fd83e.camel@kernel.org>
Subject: Re: [PATCH 01/10] fs: turn inode ctime fields into a single ktime_t
From: Jeff Layton <jlayton@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Chandan Babu R <chandan.babu@oracle.com>,
 Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
 <dsterba@suse.com>,  Hugh Dickins <hughd@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, kernel-team@fb.com, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-mm@kvack.org,  linux-nfs@vger.kernel.org
Date: Tue, 02 Jul 2024 11:58:02 -0400
In-Reply-To: <ZoQY4jdTc5dHPGGG@infradead.org>
References: <20240701224941.GE612460@frogsfrogsfrogs>
	 <3042db2f803fbc711575ec4f1c4a273912a50904.camel@kernel.org>
	 <ZoOuSxRlvEQ5rOqn@infradead.org>
	 <d91a29f0e600793917b73ac23175e02dafd56beb.camel@kernel.org>
	 <20240702101902.qcx73xgae2sqoso7@quack3>
	 <958080f6de517cf9d0a1994e3ca500f23599ca33.camel@kernel.org>
	 <ZoPs0TfTEktPaCHo@infradead.org>
	 <09ad82419eb78a2f81dda5dca9caae10663a2a19.camel@kernel.org>
	 <ZoPvR39vGeluD5T2@infradead.org>
	 <a11d84a3085c6a6920d086bf8fae1625ceff5764.camel@kernel.org>
	 <ZoQY4jdTc5dHPGGG@infradead.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-07-02 at 08:12 -0700, Christoph Hellwig wrote:
> On Tue, Jul 02, 2024 at 08:21:42AM -0400, Jeff Layton wrote:
> > Many of the existing callers of inode_ctime_to_ts are in void
> > return
> > functions. They're just copying data from an internal
> > representation to
> > struct inode and assume it always succeeds. For those we'll
> > probably
> > have to catch bad ctime values earlier.
> >=20
> > So, I think I'll probably have to roll bespoke error handling in
> > all of
> > the relevant filesystems if we go this route. There are also
> > differences between filesystems -- does it make sense to refuse to
> > load
> > an inode with a bogus ctime on NFS or AFS? Probably not.
> >=20
> > Hell, it may be simpler to just ditch this patch and reimplement
> > mgtimes using the nanosecond fields like the earlier versions did.
>=20
> Thatdoes for sure sound simpler.=C2=A0 What is the big advantage of the
> ktime_t?=C2=A0 Smaller size?
>=20

Yeah, mostly. We shrink struct inode by 8 bytes with that patch, and we
(probably) get a better cache footprint, since i_version ends up in the
same cacheline as the ctime. That's really a separate issue though, so
I'm not too worked up about dropping that patch.

As a bonus, leaving it split across separate fields means that we can
use unused bits in the nsec field for the flag, so we don't need to
sacrifice any timestamp granularity either.

I've got a draft rework that does this that I'm testing now. Assuming
it works OK, I'll resend in a few days.

Thanks for the feedback!
--=20
Jeff Layton <jlayton@kernel.org>

