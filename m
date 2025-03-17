Return-Path: <linux-fsdevel+bounces-44222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FFBA6601F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 22:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CD1E3BBC4C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 21:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E05202C48;
	Mon, 17 Mar 2025 21:04:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.stoffel.org (mail.stoffel.org [172.104.24.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83CE200120;
	Mon, 17 Mar 2025 21:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.104.24.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742245450; cv=none; b=DinyHuz2pn3eiOZEdON9mYL0muJN102STWkyuOvCEsc24N29XQZBSS5iYND4vae0bRZh6agQOQwdGIb3Dp7g/9TTnmO47Fdf6q/cirm1gdGaNyggcdKp4cuxcbTM1CtIQyzz0HIZZQqFFNucHpnm2GSODDFIcLB+gkmXQC1z4EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742245450; c=relaxed/simple;
	bh=B/H5hBc8DjuP28tLDUztk9nbB9QenvgNHoqRvHBoDN8=;
	h=MIME-Version:Content-Type:Message-ID:Date:From:To:Cc:Subject:
	 In-Reply-To:References; b=uBDK5p++wDnlo00gr/0bwmFSdrF1cpKCGuZlxCwgZByPpBC01vUU9vzNhbiqenSc2NWPauiFB6FGfn99AUcLUlKBmHABBk0f5d/OPYophKMJUIwIIz/jlM0hetJNKWS+/JTCSwF8ahj7e7B4cE+6UU52QOtFdP7GNfwc+wqkEQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stoffel.org; spf=pass smtp.mailfrom=stoffel.org; arc=none smtp.client-ip=172.104.24.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stoffel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stoffel.org
Received: from quad.stoffel.org (syn-097-095-183-072.res.spectrum.com [97.95.183.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.stoffel.org (Postfix) with ESMTPSA id 514B91E4AB;
	Mon, 17 Mar 2025 16:55:25 -0400 (EDT)
Received: by quad.stoffel.org (Postfix, from userid 1000)
	id D6D99A0E76; Mon, 17 Mar 2025 16:55:24 -0400 (EDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <26584.35900.850011.320586@quad.stoffel.home>
Date: Mon, 17 Mar 2025 16:55:24 -0400
From: "John Stoffel" <john@stoffel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org,
    linux-block@vger.kernel.org,
    Roland Vet <vet.roland@protonmail.com>,
    linux-fsdevel@vger.kernel.org
X-Clacks-Overhead: GNU Terry Pratchett
Subject: Re: [PATCH 00/14] better handling of checksum errors/bitrot
In-Reply-To: <20250311201518.3573009-1-kent.overstreet@linux.dev>
References: <20250311201518.3573009-1-kent.overstreet@linux.dev>
X-Mailer: VM 8.3.x under 28.2 (x86_64-pc-linux-gnu)

>>>>> "Kent" == Kent Overstreet <kent.overstreet@linux.dev> writes:

> Roland Vet spotted a good one: currently, rebalance/copygc get stuck if
> we've got an extent that can't be read, due to checksum error/bitrot.

> This took some doing to fix properly, because

> - We don't want to just delete such data (replace it with
>   KEY_TYPE_error); we never want to delete anything except when
>   explicitly told to by the user, and while we don't yet have an API for
>   "read this file even though there's errors, just give me what you
>   have" we definitely will in the future.

So will open() just return an error?  How will this look from
userspace?  

> - Not being able to move data is a non-option: that would block copygc,
>   device removal, etc.

> - And, moving said extent requires giving it a new checksum - strictly
>   required if the move has to fragment it, teaching the write/move path
>   about extents with bad checksums is unpalateable, and anyways we'd
>   like to be able to guard against more bitrot, if we can.

Why does it need a new checksum if there are read errors?  What
happens if there are more read errors?   If I have a file on a
filesystem which is based in spinning rust and I get a single bit
flip, I'm super happy you catch it.  

But now you re-checksum the file, with the read error, and return it?
I'm stupid and just a user/IT guy.  I want notifications, but I don't
want my application to block so I can't kill it, or unmount the
filesystem.  Or continue to use it if I like.  

> So that means:

> - Extents need a poison bit: "reads return errors, even though it now
>   has a good checksum" - this was added in a separate patch queued up
>   for 6.15.

Sorry for being dense, but does a file have one or more extents?  Or
is this at a level below that?  

>   It's an incompat feature because it's a new extent field, and old
>   versions can't parse extents with unknown field types, since they
>   won't know their sizes - meaning users will have to explicitly do an
>   incompat upgrade to make use of this stuff.

> - The read path needs to do additional retries after checksum errors
>   before giving up and marking it poisoned, so that we don't
>   accidentally convert a transient error to permanent corruption.

When doing these retries, is the filesystem locked up or will the
process doing the read() be blocked from being killed?  

> - The read path gets a whole bunch of work to plumb precise modern error
>   codes around, so that e.g. the retry path, the data move path, and the
>   "mark extent poisoned" path all know exactly what's going on.

> - Read path is responsible for marking extents poisoned after sufficient
>   retry attempts (controlled by a new filesystem option)

> - Data move path is allowed to move extents after a read error, if it's
>   a checksum error (giving it a new checksum) if it's been poisoned
>   (i.e. the extent flags feature is enabled).

So if just a single bit flips, the extent gets moved onto better
storage, and the file gets re-checksummed.  But what about if more
bits go bad afterwards?  

> Code should be more or less finalized - still have more tests for corner
> cases to write, but "write corrupt data and then tell rebalance to move
> it to another device" works as expected.

> TODO:

> - NVME has a "read recovery level" attribute that controlls how hard the
>   erasure coding algorithms work - we want that plumbed.

>   Before we give up and move data that we know is bad, we need to try
>   _as hard as possible_ to get a successful read.

What does this mean exactly in terms of end user and SysAdmin point of
view?  Locking up the system (no new writes to the now problematic
storage) that I can't kill would be annoyingly painful.  


Don't get me wrong, I'm happy to see data integrity stuff get added,
I'm just trying to understand how it interacts with userspace.  

John



