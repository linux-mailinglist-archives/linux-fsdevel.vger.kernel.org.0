Return-Path: <linux-fsdevel+bounces-13397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC7186F69B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Mar 2024 19:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 715462814F5
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Mar 2024 18:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BB1768E1;
	Sun,  3 Mar 2024 18:54:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.stoffel.org (mail.stoffel.org [172.104.24.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8935A4C4;
	Sun,  3 Mar 2024 18:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.104.24.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709492070; cv=none; b=iV5JYbg5D+Sh52n5APlE80eyBxJs/k5aHqm2jYiiqkHxE2ZRKQEv17xOTPG9YEJqrXfwaB5IWMr0YVX5vDZjObTse2YVyPpGWe3PXjSwYU1rFZqG0T4+XBYnfx6ZQBEoZitLtDdKWbWoFOLEufsuHpwsSCISMCoajSBWNe+50tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709492070; c=relaxed/simple;
	bh=2UqK2j6vVOoliTUmf+W/IeA2W13MoqKCKlNIsi7Ey9k=;
	h=MIME-Version:Content-Type:Message-ID:Date:From:To:Cc:Subject:
	 In-Reply-To:References; b=kXgUcnU9Q1DXvyz27x9PI5TFYAQVdbVy5iBrjTShcZNMi563VaHrGm5NhK4AaacW1cfH7a/95kh9G+FyFYEiofs4aNXggBnoKxflNWVpqIPYCwSksgsSIvJeCTWOssGkm1XMNAZPIg9RFLFNyQUi/fUC/ZiU/uyGcmFzTFxpAUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stoffel.org; spf=pass smtp.mailfrom=stoffel.org; arc=none smtp.client-ip=172.104.24.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stoffel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stoffel.org
Received: from quad.stoffel.org (097-095-183-072.res.spectrum.com [97.95.183.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mail.stoffel.org (Postfix) with ESMTPSA id BE1FC1E12B;
	Sun,  3 Mar 2024 13:49:00 -0500 (EST)
Received: by quad.stoffel.org (Postfix, from userid 1000)
	id 6FA90A0255; Sun,  3 Mar 2024 13:49:00 -0500 (EST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <26084.50716.415474.905903@quad.stoffel.home>
Date: Sun, 3 Mar 2024 13:49:00 -0500
From: "John Stoffel" <john@stoffel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org,
    linux-fsdevel@vger.kernel.org
Subject: Re: [WIP] bcachefs fs usage update
In-Reply-To: <gajhq3iyluwmr44ee2fzacfpgpxmr2jurwqg6aeiab4lfila3p@b3l7bywr3yed>
References: <gajhq3iyluwmr44ee2fzacfpgpxmr2jurwqg6aeiab4lfila3p@b3l7bywr3yed>
X-Mailer: VM 8.2.0b under 28.2 (x86_64-pc-linux-gnu)

>>>>> "Kent" == Kent Overstreet <kent.overstreet@linux.dev> writes:

> I'm currently updating the 'bcachefs fs usage' command for the disk
> accounting rewrite, and looking for suggestions on any improements we
> could make - ways to present the output that would be clearer and more
> useful, possibly ideas on on new things to count...

I've been meaning to play with bcachefs but haven't found the
time... but as a long time IT admin with a concentration in storage
and such, I've got some opinions to share... :-)

> I think a shorter form of the per-device section is in order, a
> table with data type on the x axis and the device on the y axis; we
> also want percentages.

So how can we make it so that the output is all on one line per-volume
(or sub-volume) so that we can more easily parse the results for our
own use?  

Can there be a way to export the data in CSV or (shudder) JSON format?
Or to change the output format ourselves to only show the columns
we're interested in using "-o <format>" type of specifications?

> The big thing I'm trying to figure out is how to present the snapshots
> counters in a useful way.

Think of it in terms of what the end user cares about, which is how
much space is taken up (and would be free'd if the snapshot was
deleted).  And how that space relates to the overall volume.

I realize this is hard to do when you have dedupe, compression, etc
all in play.  But so many people like to run close to the limits, and
when they have to delete a snapshot to make space on the main volume,
giving them an indication of how much space they will save is good.

Now I realize that if you have five snapshots from oldest to newest:

    a.        400mb
    b.        10mb
    c.        1g
    d.        10g
    e.        1g

deleting snapshot d will not free space because snapshot e depends on
it.  So it might be enough to note this in the docs and the help of
the commands.  But if I delete snapshot e (the most recent one) I
should get back 1g pretty quickly, right? 

> Snapshot IDs form trees, where subvolumes correspond to leaf nodes
> in snapshot trees and interior nodes represent data shared between
> multiple subvolumes.

Ugh... so this is a surprise in some ways, but probably only shows my
ignorance of bcachefs.  If I have a sub-volume, and it's created after
snapshot "c" given above and mounted.  Does it now go into the
space used for snapshots "d" and "e"?  So if so, then there needs to
be a way to show this.  

> That means it's straightforward to print how much data each
> subvolumme is using directly - look up the subvolume for a given
> snapshot ID, look up the filesystem path of that subvolume - but I
> haven't come up with a good way of presenting how data is shared;
> these trees can be arbitrarily large.

Well, be default I'd show the data in human readable format (ideally
with a way to sort by snapshot size!) where each volume lists it's
snapshots and sub-volumes (can there be sub-sub-...-volumes?)
intermixed by age, so you can see how much is used.

> Thoughts?

I'd love to see some example outputs, but I could also get off my ass
and actually setup my own test volumes and play around and make
comments.

but my core arguement stands, which is to make the output be concise.
The examples below are kinda way too verbose and way too long.  If I'm
in a terminal window, trying to keep it to as few lines as possible if
nice.  

> Filesystem: 77d3a40d-58b6-46c9-a4d2-e59c8681e152
> Size:                       11.0 GiB
> Used:                       4.96 GiB
> Online reserved:                 0 B
> Inodes:                            4

Why can't this be:

      Filesystem        Size        Used        Reserved        Inodes
      xxxxx             11.0 Gib    4.96 Gib    0 B             4

> Persistent reservations:
> 2x                          5.00 MiB

What does this mean to the end user?  

> Data type       Required/total  Durability    Devices
> btree:          1/2             2             [vdb vdc]           14.0 MiB
> btree:          1/2             2             [vdb vdd]           17.8 MiB
> btree:          1/2             2             [vdc vdd]           14.3 MiB
> user:           1/2             2             [vdb vdc]           1.64 GiB
> user:           1/2             2             [vdb vdd]           1.63 GiB
> user:           1/2             2             [vdc vdd]           1.64 GiB

How is this usedful?  What does it tell me?  Why do I care about
durability?  Especially in a summary output?  

> Compression:      compressed    uncompressed     average extent size
> lz4                 4.63 GiB        6.57 GiB                 112 KiB
> incompressible       328 MiB         328 MiB                 113 KiB

These are useful, but maybe only the comp/uncomp values.  

> Snapshots:
> 4294967295          4.91 GiB

There should be a count of the number of snapshots this space is used
in. 

> Btrees:
> extents             12.0 MiB
> inodes               256 KiB
> dirents              256 KiB
> alloc               10.8 MiB
> subvolumes           256 KiB
> snapshots            256 KiB
> lru                  256 KiB
> freespace            256 KiB
> need_discard         256 KiB
> backpointers        20.5 MiB
> bucket_gens          256 KiB
> snapshot_trees       256 KiB
> logged_ops           256 KiB
> accounting           256 KiB

Again, how does this help the end user?  What can they do to even
change these values?  They're great for debugging and info on the
filesystem, but for an end user that's just so much garbage and don't
tell you what you need to know.

> (no label) (device 0):           vdb              rw
>                                 data         buckets    fragmented
>   free:                     2.27 GiB           18627
>   sb:                       3.00 MiB              25       124 KiB
>   journal:                  32.0 MiB             256
>   btree:                    15.9 MiB             127
>   user:                     1.64 GiB           13733      41.1 MiB
>   cached:                        0 B               0
>   parity:                        0 B               0
>   stripe:                        0 B               0
>   need_gc_gens:                  0 B               0
>   need_discard:                  0 B               0
>   capacity:                 4.00 GiB           32768

Again, just the first line might be usedful, but why would I care?
And it's a total pain to parse as well.  

> (no label) (device 1):           vdc              rw
>                                 data         buckets    fragmented
>   free:                     2.28 GiB           18652
>   sb:                       3.00 MiB              25       124 KiB
>   journal:                  32.0 MiB             256
>   btree:                    14.1 MiB             113
>   user:                     1.64 GiB           13722      38.5 MiB
>   cached:                        0 B               0
>   parity:                        0 B               0
>   stripe:                        0 B               0
>   need_gc_gens:                  0 B               0
>   need_discard:                  0 B               0
>   capacity:                 4.00 GiB           32768

> (no label) (device 2):           vdd              rw
>                                 data         buckets    fragmented
>   free:                     2.28 GiB           18640
>   sb:                       3.00 MiB              25       124 KiB
>   journal:                  32.0 MiB             256
>   btree:                    16.0 MiB             128
>   user:                     1.64 GiB           13719      38.6 MiB
>   cached:                        0 B               0
>   parity:                        0 B               0
>   stripe:                        0 B               0
>   need_gc_gens:                  0 B               0
>   need_discard:                  0 B               0
>   capacity:                 4.00 GiB           32768


How can you shrink this down to be much more terse and useful?
Something like:

        device  label      free      user       capacity
        vda     (none)     x         y          Z               
        vdb     "foo bar"  x1        y1         Z1
        vdb     "foo"      x2        y2         Z2

