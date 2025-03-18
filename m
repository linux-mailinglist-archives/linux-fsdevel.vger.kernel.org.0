Return-Path: <linux-fsdevel+bounces-44328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A00F6A676C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 15:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F8933B5504
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 14:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D55B20E32D;
	Tue, 18 Mar 2025 14:47:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.stoffel.org (mail.stoffel.org [172.104.24.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7D6207DFD;
	Tue, 18 Mar 2025 14:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.104.24.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742309274; cv=none; b=BzQkInQOLJuaGuNPB3g8SxOom91QR0r5kpfbS7K897jpPu/2zX8yTJykjGfH3xGH+tzA3vvKsyQHUZiP/DLyn9oHaBGBPuwvFjrzxHUmJC+8GUBb6Oq6tgq5ugWJlr9Iekbk2gvqKWmXcRcWxK26VCFod21HBmUgX28ulKWUFdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742309274; c=relaxed/simple;
	bh=HvQIZM+EkifqhBgtCmAJn6RhN+1+XsIWn5ez233abgs=;
	h=MIME-Version:Content-Type:Message-ID:Date:From:To:Cc:Subject:
	 In-Reply-To:References; b=iQgUpkgCwQdBhWvvHN1vRyYmZ5jP/VAtjVP1wzS+v7X7bpz5oyNZVuI794F49oQKsQFw9muZUgsi+vio/MmZbOIbirYh0W369KlOwDK0MoYst1R1pGQBpM6VJ4YSxtr4oOJe1M/bnSBlEpAMf46VXy2MW2c8xPcdRa3vUD50hOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stoffel.org; spf=pass smtp.mailfrom=stoffel.org; arc=none smtp.client-ip=172.104.24.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stoffel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stoffel.org
Received: from quad.stoffel.org (syn-097-095-183-072.res.spectrum.com [97.95.183.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mail.stoffel.org (Postfix) with ESMTPSA id D7A7F1E1D9;
	Tue, 18 Mar 2025 10:47:51 -0400 (EDT)
Received: by quad.stoffel.org (Postfix, from userid 1000)
	id 82458A0E82; Tue, 18 Mar 2025 10:47:51 -0400 (EDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <26585.34711.506258.318405@quad.stoffel.home>
Date: Tue, 18 Mar 2025 10:47:51 -0400
From: "John Stoffel" <john@stoffel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: John Stoffel <john@stoffel.org>,
    linux-bcachefs@vger.kernel.org,
    linux-block@vger.kernel.org,
    Roland Vet <vet.roland@protonmail.com>,
    linux-fsdevel@vger.kernel.org
X-Clacks-Overhead: GNU Terry Pratchett
Subject: Re: [PATCH 00/14] better handling of checksum errors/bitrot
In-Reply-To: <avmzp2nswsowb3hg2tcrb6fv2djgkiw7yl3bgdn4dnccuk4yti@ephd5sxy5b7w>
References: <20250311201518.3573009-1-kent.overstreet@linux.dev>
	<26584.35900.850011.320586@quad.stoffel.home>
	<avmzp2nswsowb3hg2tcrb6fv2djgkiw7yl3bgdn4dnccuk4yti@ephd5sxy5b7w>
X-Mailer: VM 8.3.x under 28.2 (x86_64-pc-linux-gnu)

>>>>> "Kent" == Kent Overstreet <kent.overstreet@linux.dev> writes:

> On Mon, Mar 17, 2025 at 04:55:24PM -0400, John Stoffel wrote:
>> >>>>> "Kent" == Kent Overstreet <kent.overstreet@linux.dev> writes:
>> 
>> > Roland Vet spotted a good one: currently, rebalance/copygc get stuck if
>> > we've got an extent that can't be read, due to checksum error/bitrot.
>> 
>> > This took some doing to fix properly, because
>> 
>> > - We don't want to just delete such data (replace it with
>> >   KEY_TYPE_error); we never want to delete anything except when
>> >   explicitly told to by the user, and while we don't yet have an API for
>> >   "read this file even though there's errors, just give me what you
>> >   have" we definitely will in the future.
>> 
>> So will open() just return an error?  How will this look from
>> userspace?  

> Not the open, the read - the typical case is only a single extent goes
> bad; it's like any other IO error.

Good. But then how would an application know we got a checksum error
for data corruption?  Would I have to update all my code to do another
special call when I get a read/write error to see if it was a
corruption issue?  

>> > - Not being able to move data is a non-option: that would block copygc,
>> >   device removal, etc.
>> 
>> > - And, moving said extent requires giving it a new checksum - strictly
>> >   required if the move has to fragment it, teaching the write/move path
>> >   about extents with bad checksums is unpalateable, and anyways we'd
>> >   like to be able to guard against more bitrot, if we can.
>> 
>> Why does it need a new checksum if there are read errors?  What
>> happens if there are more read errors?   If I have a file on a
>> filesystem which is based in spinning rust and I get a single bit
>> flip, I'm super happy you catch it.  

> The data move paths very strictly verify checksums as they move data
> around so they don't introduce bitrot.

Good.  This is something I really liked as an idea in ZFS, happy to
see it coming to bcachefs as well. 

> I'm not going to add
> 	if (!bitrotted_extent) checksum(); else no_checksum()
> Eww...

LOL!

> Besides being gross, we also would like to guard against introducing
> more bitrot.

>> But now you re-checksum the file, with the read error, and return it?
>> I'm stupid and just a user/IT guy.  I want notifications, but I don't
>> want my application to block so I can't kill it, or unmount the
>> filesystem.  Or continue to use it if I like.  

> The aforementioned poison bit ensures that you still get the error from
> the original checksum error when you read that data - unless you use an
> appropriate "give it to me anyways" API.

So this implies that I need to do extra work to A) know I'm on
bcachefs filesystem, B) that I got a read/write error and I need to do
some more checks to see what the error exactly is.  

And if I want to re-write the file I can either copy it to a new name,
but only when I use the new API to say "give me all the data, even if
you have a checksum error".  

>> > So that means:
>> 
>> > - Extents need a poison bit: "reads return errors, even though it now
>> >   has a good checksum" - this was added in a separate patch queued up
>> >   for 6.15.
>> 
>> Sorry for being dense, but does a file have one or more extents?  Or
>> is this at a level below that?  

> Files have multiple extents.

> An extent is one contiguous range of data, and in bcachefs checksums are
> at the extent level, not block, so checksummed (and compressed) extents
> are limited to, by default, 128k.

>> >   It's an incompat feature because it's a new extent field, and old
>> >   versions can't parse extents with unknown field types, since they
>> >   won't know their sizes - meaning users will have to explicitly do an
>> >   incompat upgrade to make use of this stuff.
>> 
>> > - The read path needs to do additional retries after checksum errors
>> >   before giving up and marking it poisoned, so that we don't
>> >   accidentally convert a transient error to permanent corruption.
>> 
>> When doing these retries, is the filesystem locked up or will the
>> process doing the read() be blocked from being killed?  

> The process doing the read() can't be killed during this, no. If
> requested this could be changed, but keep in mind retries are limited in
> number.

How limited?  And in the worse case, if I have 10 or 100 readers of a
file with checksum errors, now I've blocked all those processes for X
amount of time.  Will this info be logged somewhere so a sysadm could
possibly just do an 'rm' on the file to nuke it, or have some means of
forcing a scrub?  

> Nothing else is "locked up", everything else proceeds as normal.

But is the filesystem able to be unmounted when there's a locked up
process?  I'm just thinking in terms of system shutdowns when you have
failing hardware and want to get things closed as cleanly as possible
since you're going to clone the underlying block device onto new media
ASAP in an offline manner.  

>> > - The read path gets a whole bunch of work to plumb precise modern error
>> >   codes around, so that e.g. the retry path, the data move path, and the
>> >   "mark extent poisoned" path all know exactly what's going on.
>> 
>> > - Read path is responsible for marking extents poisoned after sufficient
>> >   retry attempts (controlled by a new filesystem option)
>> 
>> > - Data move path is allowed to move extents after a read error, if it's
>> >   a checksum error (giving it a new checksum) if it's been poisoned
>> >   (i.e. the extent flags feature is enabled).
>> 
>> So if just a single bit flips, the extent gets moved onto better
>> storage, and the file gets re-checksummed.  But what about if more
>> bits go bad afterwards?  

> The new checksum means they're detected, and if you have replication
> enabled they'll be corrected automatically, like any other IO error.

Nice!

