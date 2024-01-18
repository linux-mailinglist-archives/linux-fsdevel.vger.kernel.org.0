Return-Path: <linux-fsdevel+bounces-8218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2278E83113F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 03:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 338361C208A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 02:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B23853B5;
	Thu, 18 Jan 2024 02:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="UF3PjnOu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63024699
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jan 2024 02:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705543569; cv=none; b=RTXew7/pzXJe8CfjsvI/e7CifsSZIYUgsM8M4H300fpQIn0tBGKOGEucwLUNcugW3mgZQrjPAMVn4lh7nD1SgtsSHyuY5HjyGwRTAEpyo6AbJAZCZGlRYoE/o1/y13sKAJUDy6VeoUz6L2w7UbTClduxmlwQOoa6Uu7+CyLp7is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705543569; c=relaxed/simple;
	bh=sjhulmywinmZPP+TldxnvhakRoNud7Y3niJfj+wgFiM=;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=iGFIgOc5DiCN8oRe1KFQ8Kk1zMGJWDW3sGqeg0DbV/VnneRkcLm/SZHi06qcBp/cSq//dk5IxNDZF8NwWQ35FzsSlUM2K28mu/VBOB1WiIXZATSKgda5bpvrS1bZtsHhYiho9If91N8yzeIF5NAQFGN+lXvLOfAznTrI/IBWMrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=UF3PjnOu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-112-211.bstnma.fios.verizon.net [173.48.112.211])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 40I25s1l032229
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 21:05:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1705543556; bh=2Lit1G0EE/vYdp+cKOok2hgcuM8nLakSQAmk5/HsBQ8=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=UF3PjnOu2LbErSaLgnzkj0NaYpDfLfdAx4C1ZFdf6LugbfRUl78r2HCeQdhHSG7xl
	 QEvGy1l3Rl5qYv7IfqecsrIFAWigmBurVvN8QT8qHr31+WM+po2qndA6gB+6FJmS8f
	 gbqqCdgpaRqt0cqJjnpYSIqOjVIhRniWcQ1atHVromDM6CxRL4QL2KrY5OQUBeqt0s
	 /L3Ht1izCimp3M7z+uPFLsI+teGy3ZR4W8A/ekj2FRotY/hqv6awTp1BKl/+Zc5owJ
	 iwatuvERuiREUxi2ZDMPW4fCyVXqu9auLiYOm6yk5yZtXf6L6PonmzcxR5f5x9YXJ3
	 oZ/Wm7vn1zNHQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 267AE15C0278; Wed, 17 Jan 2024 21:05:54 -0500 (EST)
Date: Wed, 17 Jan 2024 21:05:54 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Gabriel Krisman Bertazi <krisman@suse.de>,
        Al Viro <viro@zeniv.linux.org.uk>, ebiggers@kernel.org,
        linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org
Subject: Re: [PATCH] libfs: Attempt exact-match comparison first during
 casefold lookup
Message-ID: <20240118020554.GA1353741@mit.edu>
References: <20240117222836.11086-1-krisman@suse.de>
 <20240117223857.GN1674809@ZenIV>
 <87edeffr0k.fsf@mailhost.krisman.be>
 <CAHk-=wjd_uD4aHWEVZ735EKRcEU6FjUo8_aMXSxRA7AD8DapZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjd_uD4aHWEVZ735EKRcEU6FjUo8_aMXSxRA7AD8DapZA@mail.gmail.com>

On Wed, Jan 17, 2024 at 04:40:17PM -0800, Linus Torvalds wrote:
> Note that the whole "malformed utf-8 is an error" is actually wrong anyway.
> 
> Yes, if you *output* utf-8, and your output is malformed, then that's
> an error that needs fixing.
> 
> But honestly, "malformed utf-8" on input is almost always just "oh, it
> wasn't utf-8 to begin with, and somebody is still using Latin-1 or
> Shift-JIS or whatever".
> 
> And then treating that as some kind of hard error is actually really
> really wrong and annoying, and may end up meaning that the user cannot
> *fix* it, because they can't access the data at all.

A file system which supports casefolding can support "strict" mode
(not the default) where attempts to create files that have invalid
UTF-8 characters are rejected before a file or hard link is created
(or renamed) with an error.

This is what MacOS does, by the way.  If you try to rsync a file from
a Linux box where the file was created by unpacking a Windows Zip file
created by downloading a directory hierarchy from a Microsoft
Sharepoint, and then you try to scp or rsync it over to MacOS, MacOS
will will refuse to allow the file to be created if it contains
invalid UTF-8 characters, and rsync or scp will report an error.  I
just ran into this earlier today...

So we don't need to worry about the user not being able to fix it,
because they won't have been able to create the file in the first
place.  This is not the default, since we know there are a bunch of
users who might be creating files using the unofficial "Klingon"
characters (for example) that are not officially part of Unicode since
Unicode will only allow characters used by human languages, and
Klingon doesn't qualify.  I believe though that Android has elected to
enable casefolding in strict mode, which is fine as far as I'm concerned.

> I find libraries that just error out on "malformed utf-8" to be
> actively harmful.

I admit that when I discovered that MacOS errored out on illegal utf-8
characters it was mildly annoying, but it wasn't that hard to fix it
on the Linux side and then I retried the rsync.  It also turned out
that if I unpacked the zip file on MacOS, the filename was created
without the illegal utf-8 characters, so there may have been something
funky going on with the zip userspace program on Linux.  I haven't
cared enough to try to debug it...

       		      	     	   	    - Ted

