Return-Path: <linux-fsdevel+bounces-74186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DB584D339A2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 17:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 710AF3018CA2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 16:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C16396B66;
	Fri, 16 Jan 2026 16:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbRZboU+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872DA2773D4
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 16:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768582639; cv=none; b=fMw7Ti8c4/hbNb4Kw9S6XdCq0bChM+yy9/Eb5EYmP73m0yiIBnp0NFxr+z53MOg9D5tWcLA70MmcgirAbFRJfCe4laZi2P3oGdqqDYJgWIPUURfB9XiIQUMZ+LoWdW45wSTXv/oWuAmXEr2Iau3okiWVH7++W4yi32H1CY9aiWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768582639; c=relaxed/simple;
	bh=f90X0YEJGdShajkzKyST/9mzfQ7ya8Zi4LHnplguOZo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=fXbqVCRlzdz908r2hzibq6uHYdl9EHGN/9aV0j2o3N1XAzw4MmX9/N44d2zRW/1VfyaDe4CfR20xkeALTF3FOWg3w/FQJ+l/eQAspYsDUJ0EkAyhNWrDnl4XAqm2krm4tLiD96xDdh5P3SZDcWpQi39SD5R0nN4x7J6xd2fdk2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbRZboU+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC12C4AF09;
	Fri, 16 Jan 2026 16:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768582639;
	bh=f90X0YEJGdShajkzKyST/9mzfQ7ya8Zi4LHnplguOZo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=gbRZboU+lzUjXokFpRW/aBGNxQycELUaRFFn8MEJe52aBKshW6Sl1lp+cs6VUw5F8
	 qMBOKf1N62NANZMKYkZe4PaFXqW99CqwqL/j/sm2RWuQ1npRS2oeoe9cNu6YUNbY6F
	 gdjGD31DTchEJSlAi9N3L51a2yGYxvoGK8wLSJ2Wua07xPzgY+jJYjHyhDeO/JVSEV
	 qiwLvVznY8xkKPfyhgDiV5Dtv36AKTXtykPQCybNlexCdSAMa5ynDmj1ZQV83xUM4G
	 7ARDeeOEguc9NCzcvKbtRFcYPvyDtEuJ6U6zFF1R+gCO842QXJkXo4qrqR7b7+LcIr
	 LGjk1eYmf234Q==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1C207F40078;
	Fri, 16 Jan 2026 11:57:18 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 16 Jan 2026 11:57:18 -0500
X-ME-Sender: <xms:7m1qaXU7y-e-itHvjcrzWHsPcG2ZmPSfmswrbtBxHpnTuHI8p7-B1A>
    <xme:7m1qaaZCXmpyOpJoKCKbJop_3ScbXlPT4GoWCkj6kQAA0a3QxFpJPFzhD9GJnQLYz
    Eq-SpfPg3kLmn-8-wJQzS0SJjpOj7L53NGrXJwxwNYzmSTyFR9AHgU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdelgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpeejvefhudehleetvdejhfejvefghfelgeejvedvgfduuefffeegtdejuefhiedukeen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheptghhuhgtkhhlvghvvghrodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdduieefgeelleelheelqdefvdelkeeggedvfedqtggvlh
    eppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthho
    peduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvihhlsegsrhhofihnrd
    hnrghmvgdprhgtphhtthhopehrihgtkhdrmhgrtghklhgvmhesghhmrghilhdrtghomhdp
    rhgtphhtthhopegstghougguihhngheshhgrmhhmvghrshhprggtvgdrtghomhdprhgtph
    htthhopegrnhhnrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvggsihhgghgvrhhs
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehtrhhonhgumhihsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthhopehlihhnuh
    igqdgtrhihphhtohesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:7m1qaaeWAkl94YEHo2g1HMzL4DqEQra32Ab5h0FgBW0IC9FeO-g50g>
    <xmx:7m1qaQCamdrOy3oDxkqBRqjcbO2SZZZHnUkGNEie9uU_6iYxnMX4zQ>
    <xmx:7m1qaW7LE9Q9LXgFkZlvJyF6kuJ3rcp12nfsVkYkYGR3svyLEhCgmA>
    <xmx:7m1qaRevSDUYn4anyNhO21uZCVv7p0NEaUKjTP9cUR5GbjdEM29xJQ>
    <xmx:7m1qaUvN_56VDxalx2xQ3jsv-h6TNGXUwk1idpLH3aasj1FAt-gAvGmo>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EA6E8780070; Fri, 16 Jan 2026 11:57:17 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AtsEYAmG-JTZ
Date: Fri, 16 Jan 2026 11:56:15 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Benjamin Coddington" <bcodding@hammerspace.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Eric Biggers" <ebiggers@kernel.org>,
 "Rick Macklem" <rick.macklem@gmail.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-crypto@vger.kernel.org
Message-Id: <f8e2d466-7280-4a21-ad71-21bf1e546300@app.fastmail.com>
In-Reply-To: <cover.1768573690.git.bcodding@hammerspace.com>
References: <cover.1768573690.git.bcodding@hammerspace.com>
Subject: Re: [PATCH v1 0/4] kNFSD Signed Filehandles
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, Jan 16, 2026, at 9:32 AM, Benjamin Coddington wrote:
> The following series enables the linux NFS server to add a Message
> Authentication Code (MAC) to the filehandles it gives to clients.  This
> provides additional protection to the exported filesystem against filehandle
> guessing attacks.
>
> Filesystems generate their own filehandles through the export_operation
> "encode_fh" and a filehandle provides sufficient access to open a file
> without needing to perform a lookup.  An NFS client holding a valid
> filehandle can remotely open and read the contents of the file referred to
> by the filehandle.

"open, read, or modify the contents of the file"

Btw, referring to "open" here is a little confusing, since NFSv3 does
not have an on-the-wire OPEN operation. I'm not sure how to clarify.


> In order to acquire a filehandle, you must perform lookup operations on the
> parent directory(ies), and the permissions on those directories may
> prohibit you from walking into them to find the files within.  This would
> normally be considered sufficient protection on a local filesystem to
> prohibit users from accessing those files, however when the filesystem is
> exported via NFS those files can still be accessed by guessing the correct,
> valid filehandles.

Instead: "an exported file can be accessed whenever the NFS server is
presented with the correct filehandle, which can be guessed or acquired
by means other than LOOKUP."


> Filehandles are easy to guess because they are well-formed.  The
> open_by_handle_at(2) man page contains an example C program
> (t_name_to_handle_at.c) that can display a filehandle given a path.  Here's
> an example filehandle from a fairly modern XFS:
>
> # ./t_name_to_handle_at /exports/foo 
> 57
> 12 129    99 00 00 00 00 00 00 00 b4 10 0b 8c
>
>           ^---------  filehandle  ----------^
>           ^------- inode -------^ ^-- gen --^
>
> This filehandle consists of a 64-bit inode number and 32-bit generation
> number.  Because the handle is well-formed, its easy to fabricate
> filehandles that match other files within the same filesystem.  You can
> simply insert inode numbers and iterate on the generation number.
> Eventually you'll be able to access the file using open_by_handle_at(2).
> For a local system, open_by_handle_at(2) requires CAP_DAC_READ_SEARCH, which
> protects against guessing attacks by unprivileged users.
>
> In contrast to a local user using open_by_handle(2), the NFS server must
> permissively allow remote clients to open by filehandle without being able
> to check or trust the remote caller's access. Therefore additional
> protection against this attack is needed for NFS case.  We propose to sign
> filehandles by appending an 8-byte MAC which is the siphash of the
> filehandle from a key set from the nfs-utilities.  NFS server can then
> ensure that guessing a valid filehandle+MAC is practically impossible
> without knowledge of the MAC's key.  The NFS server performs optional
> signing by possessing a key set from userspace and having the "sign_fh"
> export option.

OK, I guess this is where I got the idea this would be an export option.

But I'm unconvinced that this provides any real security. There are
other ways of obtaining a filehandle besides guessing, and nothing
here suggests that guessing is the premier attack methodology.

The fundamental issue is there is no authorization check done by NFS
READ or WRITE. And in the case of root_squash with AUTH_SYS, maybe
even an authorization check at I/O time isn't enough. Note this is
the classic NFS AUTH_SYS security model; it assumes we're all best
of friends.


> Because filehandles are long-lived, and there's no method for expiring them,
> the server's key should be set once and not changed.  It also should be
> persisted across restarts.  The methods to set the key allow only setting it
> once, afterward it cannot be changed.  A separate patchset for nfs-utils
> contains the userspace changes required to set the server's key.

There are some problems here.

- The requirement is: File handles must remain stable while the inode
  generation number remains unchanged (Chinner).

- There's nothing in your implementation that prevents user space
  from providing a different key after a system reboot or server
  restart. In fact, destroying the net namespace removes the ability
  for the server to remember (and thus check) the previously set
  fh_key.

- An fh_key change is safe to do once all exported file systems are
  unexported and unmounted. NFS clients generally don't preserve
  filehandles after they unmount file systems. I say this because I
  think rekeying might become important as the time to break a key
  decreases.


> I had a previous attempt to solve this problem by encrypting 
> filehandles,
> which turned out to be a problematic, poor solution.  The discussion on
> that previous attempt is here:
> https://lore.kernel.org/linux-nfs/510E10A4-11BE-412D-93AF-C4CC969954E7@hammerspace.com/T/#t
>
> There are some changes from that version:
> 	- sign filehandles instead of encrypt them (Eric Biggers)
> 	- fix the NFSEXP_ macros, specifically NFSEXP_ALLFLAGS (NeilBrown)
> 	- rebase onto cel/nfsd-next (Chuck Lever)
> 	- condensed/clarified problem explantion (thanks Chuck Lever)
> 	- add nfsctl file "fh_key" for rpc.nfsd to also set the key
>
> I plan on adding additional work to enable the server to check whether the
> 8-byte MAC will overflow maximum filehandle length for the protocol at
> export time.  There could be some filesystems with 40-byte fileid and
> 24-byte fsid which would break NFSv3's 64-byte filehandle maximum with an
> 8-byte MAC appended.  The server should refuse to export those filesystems
> when "sign_fh" is requested.

Noted, and we might require all that to be in place before merging.


> Thanks for any comments and critique.
>
> Benjamin Coddington (4):
>   nfsd: Convert export flags to use BIT() macro
>   nfsd: Add a key for signing filehandles
>   NFSD/export: Add sign_fh export option
>   NFSD: Sign filehandles
>
>  Documentation/netlink/specs/nfsd.yaml | 12 ++++
>  fs/nfsd/export.c                      |  5 +-
>  fs/nfsd/netlink.c                     | 15 +++++
>  fs/nfsd/netlink.h                     |  1 +
>  fs/nfsd/netns.h                       |  2 +
>  fs/nfsd/nfs3xdr.c                     | 20 +++---
>  fs/nfsd/nfs4xdr.c                     | 12 ++--
>  fs/nfsd/nfsctl.c                      | 87 ++++++++++++++++++++++++++-
>  fs/nfsd/nfsfh.c                       | 72 +++++++++++++++++++++-
>  fs/nfsd/nfsfh.h                       | 22 +++++++
>  fs/nfsd/trace.h                       | 19 ++++++
>  include/linux/sunrpc/svc.h            |  1 +
>  include/uapi/linux/nfsd/export.h      | 38 ++++++------
>  include/uapi/linux/nfsd_netlink.h     |  2 +
>  14 files changed, 272 insertions(+), 36 deletions(-)
>
>
> base-commit: bfd453acb5637b5df881cef4b21803344aa9e7ac
> -- 
> 2.50.1

-- 
Chuck Lever

