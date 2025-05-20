Return-Path: <linux-fsdevel+bounces-49549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61924ABE7F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 01:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 146064C52D4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 23:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0661253F1B;
	Tue, 20 May 2025 23:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b="ZYqUEjMA";
	dkim=permerror (0-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b="VsFxMocB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sdaoden.eu (sdaoden.eu [217.144.132.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3996BFC0;
	Tue, 20 May 2025 23:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.144.132.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747782987; cv=none; b=q7+XmipXqvu2aPF/Nh8in5tZTS1lCg1wwAEozlolw2E8J8usQOybp2KZdMJkwpAV92y7rnsmnaFJItQbL98S86RSzETWdWqH+diIHvG5VOV0GTYAw+3osmcve2HGT/+fqQNjUKCKVEIAPtCrQILgPtkd5vXf03m8EWwToDAiZBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747782987; c=relaxed/simple;
	bh=MK/VpZWJfqBCuW7H1eVz8cGLKQOA2oawcBTKOaRsW5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References; b=OKAmYRaHELTeHX4VgVZPnSOhLyWUdpas2EXlCZR43/XHr+Y01Dwd8GqRhD4+uRFDSzO654BI0IYEecpkY26zSn/20ZmkrChC7g+wLdnfE0XMWJ/uJQpmuIHlxpZllZ+Ay3qNZnLmsrG/wUDDXKF6WqL5SRgvfkfE3Zecc2Sos5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu; spf=pass smtp.mailfrom=sdaoden.eu; dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b=ZYqUEjMA; dkim=permerror (0-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b=VsFxMocB; arc=none smtp.client-ip=217.144.132.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdaoden.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sdaoden.eu;
 s=citron; t=1747782982; x=1748449648; h=date:author:from:to:cc:subject:
  message-id:in-reply-to:references:mail-followup-to:openpgp:blahblahblah:
  author:from:subject:date:to:cc:resent-author:resent-date:resent-from:
  resent-sender:resent-to:resent-cc:resent-reply-to:resent-message-id:
  in-reply-to:references:mime-version:content-type:
  content-transfer-encoding:content-disposition:content-id:
  content-description:message-id:mail-followup-to:openpgp:blahblahblah;
 bh=UZNlL0lcrAivMwkKPqW6s8kNByEqDFqjggCA6UmPnhE=;
 b=ZYqUEjMAZLD3lEZHKABkG86KxUroPOUNsyLsL7uqPOAsdacKgEbXISL8ipOSdsaHAZS8p14M
  kBrbFbMI+gCum031i84JR3D7y6qzehfLaEVFE1WX6l0FwMZeVMhLjj4cx/NI9RLyx9oCDqW9L9
  UM28C2nHXyUo35nO66ZKjvE91itof4a1IkBtEu1vAnZw40bzJ+cGzTueeCbgD8KOsqPLpHj0H5
  CgcTJA83h8D8lAupfNf7Wz4pKRt4ahZF5JyOKDZhiXZ7PvpGOvMYIR6yGLZTIjZK4sWhdjpIJK
  Pq4taqKP0cicrbZZ+aeUMPC4vmIGvKMXQ42+NUhVL+odsS7A==
DKIM-Signature: v=1; a=adaed25519-sha256; c=relaxed/relaxed; d=sdaoden.eu;
 s=orange; t=1747782982; x=1748449648; h=date:author:from:to:cc:subject:
  message-id:in-reply-to:references:mail-followup-to:openpgp:blahblahblah:
  author:from:subject:date:to:cc:resent-author:resent-date:resent-from:
  resent-sender:resent-to:resent-cc:resent-reply-to:resent-message-id:
  in-reply-to:references:mime-version:content-type:
  content-transfer-encoding:content-disposition:content-id:
  content-description:message-id:mail-followup-to:openpgp:blahblahblah;
 bh=UZNlL0lcrAivMwkKPqW6s8kNByEqDFqjggCA6UmPnhE=;
 b=VsFxMocBzJ8B6ZiIHzPbhYZDBUauv6elnWKGqJWpn5sIrX5W2zHWWPsF9RY6ZV3noOKtnMFN
  W9UWrUTeC8O4DA==
Date: Wed, 21 May 2025 01:16:20 +0200
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From: Steffen Nurpmeso <steffen@sdaoden.eu>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Jan Kara <jack@suse.cz>, Alejandro Colomar <alx@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, linux-man@vger.kernel.org,
 Steffen Nurpmeso <steffen@sdaoden.eu>
Subject: Re: close(2) with EINTR has been changed by POSIX.1-2024
Message-ID: <20250520231620.EN4cjagk@steffen%sdaoden.eu>
In-Reply-To: <20250520133705.GE38098@mit.edu>
References: <fskxqmcszalz6dmoak6de4c7bxt4juvc5zrpboae4dqw4y6aih@lskezjrbnsws>
 <ddqmhjc2rpzk2jjvunbt3l3eukcn4xzkocqzdg3j4msihdhzko@fizekvxndg2d>
 <20250516124147.GB7158@mit.edu> <20250519231919.StJ5Lkhr@steffen%sdaoden.eu>
 <20250520133705.GE38098@mit.edu>
Mail-Followup-To: "Theodore Ts'o" <tytso@mit.edu>,
 Jan Kara <jack@suse.cz>, Alejandro Colomar <alx@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, linux-man@vger.kernel.org,
 Steffen Nurpmeso <steffen@sdaoden.eu>
User-Agent: s-nail v14.9.25-653-gb160e2cb86
OpenPGP: id=EE19E1C1F2F7054F8D3954D8308964B51883A0DD;
 url=https://ftp.sdaoden.eu/steffen.asc; preference=signencrypt
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Theodore Ts'o wrote in
 <20250520133705.GE38098@mit.edu>:
 |On Tue, May 20, 2025 at 01:19:19AM +0200, Steffen Nurpmeso wrote:
 |> They could not do otherwise than talking the status quo, i think.
 |> They have explicitly added posix_close() which overcomes the
 |> problem (for those operating systems which actually act like
 |> that).  There is a long RATIONALE on this, it starts on page 747 :)
 |
 |They could have just added posix_close() which provided well-defined
 |semantics without demanding that existing implementations make
 |non-backwards compatible changes to close(2).  Personally, while they
 |were adding posix_close(2) they could have also fixed the disaster
 |which is the semantics around close(2) [.]

Well it was a lot of trouble, not only in bug 529[1], with
follow-ups like a thread started by Michael Kerrisk, with an
interesting response by Rich Felker of Musl[2].
In [1] Erik Blake of RedHat/libvirt said for example

  The Linux kernel currently always frees the file descriptor (no
  chance for a retry; the filedes can immediately be reused by
  another open()), for both EINTR and EIO. Maybe it is safer to
  state that the fd is _always_ closed, even if failure is
  reported?

etc, but Geoff Clare then (this also was in 2012, where one
possibly could have hoped that more operating systems survive /
continue with money/manpower backing by serious companies; just
in case that mattered) came via

  HP got it right with HP-UX; AIX and Linux do the wrong thing.

and he has quite some reasoning for descriptors like ttys etc,
where close can linger, which resulted in Erik Blake quoting

  Let me make it very, very clear - no matter how many times these
  guys assert HP-UX insane behaviour correct, no "fixes" to Linux
  one are going to be accepted.  Consider it vetoed.  By me, in
  role of Linux VFS maintainer.  And I'm _very_ certain that
  getting Linus to agree will be a matter of minutes.

  [1] https://www.austingroupbugs.net/view.php?id=529
  [2] https://www.mail-archive.com/austin-group-l@opengroup.org/msg00579.html

 |[.] and how advisory locks get
 |released that were held by other file descriptors and add a profound
 |apologies over the insane semantics demanded by POSIX[1].

The new standard added the Linux-style F_OFD_* fcntl(2) locks!
They are yet Linux-only, but NetBSD at least has an issue by
a major contributor (bug 59241):

  NetBSD seems to lack the following:

  3.237 OFD-Owned File Lock
  ...
  https://pubs.opengroup.org/onlinepubs/9799919799/basedefs/V1_chap03.html#tag_03_237
  >How-To-Repeat:
  standards inspection
  >Fix:
  Yes, please!  (That or write down a reason why we eschew it.)

 |[1] "POSIX advisory locks are broken by design."
 |    https://www.sqlite.org/src/artifact/c230a7a24?ln=994-1081
 |
 |     - Ted
 --End of <20250520133705.GE38098@mit.edu>

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)

