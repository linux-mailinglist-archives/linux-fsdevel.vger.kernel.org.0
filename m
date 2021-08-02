Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7343DCF30
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Aug 2021 06:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbhHBESq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Aug 2021 00:18:46 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45136 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhHBESq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Aug 2021 00:18:46 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AFCE91FF24;
        Mon,  2 Aug 2021 04:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627877915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oCxfnDIQHo7zeHdIihSV072lb1GzrTxq9yJB4Mf+O8E=;
        b=tG9f93fBuVgpVrn/aw2zo+rtxGc+IO6UoZuVfSzBrejHuz6s6vNVMySwT6a4VSlvQPeYNY
        zOh0SS6/bwCLqF8xem+3GElgwi1tY4XZfNsynVwBGsYu5JD96KwaGrw8J2h3bcFn6PLs8/
        sdsU4C0MPlrtC05jwTxjP8tzfuEHRVI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627877915;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oCxfnDIQHo7zeHdIihSV072lb1GzrTxq9yJB4Mf+O8E=;
        b=oaGsnA8vKrjArsboWH11XwYKNZAB4/ptlgHYBQUbGFXYXV5Qd49pTQqIKmjM9KkJ6wzfmh
        WFvRCeit5Vwzy+CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8410E1345F;
        Mon,  2 Aug 2021 04:18:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1W6pEBhyB2EXaQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 02 Aug 2021 04:18:32 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Miklos Szeredi" <miklos@szeredi.hu>
Cc:     "Al Viro" <viro@zeniv.linux.org.uk>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Josef Bacik" <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "Chuck Lever" <chuck.lever@oracle.com>, "Chris Mason" <clm@fb.com>,
        "David Sterba" <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        "Linux NFS list" <linux-nfs@vger.kernel.org>,
        "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Subject: A Third perspective on BTRFS nfsd subvol dev/inode number issues.
In-reply-to: <CAJfpegub4oBZCBXFQqc8J-zUiSW+KaYZLjZaeVm_cGzNVpxj+A@mail.gmail.com>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>,
 <162742546548.32498.10889023150565429936.stgit@noble.brown>,
 <YQNG+ivSssWNmY9O@zeniv-ca.linux.org.uk>,
 <162762290067.21659.4783063641244045179@noble.neil.brown.name>,
 <CAJfpegsR1qvWAKNmdjLfOewUeQy-b6YBK4pcHf7JBExAqqUvvg@mail.gmail.com>,
 <162762562934.21659.18227858730706293633@noble.neil.brown.name>,
 <CAJfpegtu3NKW9m2jepRrXe4UTuD6_3k0Y6TcCBLSQH7SSC90BA@mail.gmail.com>,
 <162763043341.21659.15645923585962859662@noble.neil.brown.name>,
 <CAJfpegub4oBZCBXFQqc8J-zUiSW+KaYZLjZaeVm_cGzNVpxj+A@mail.gmail.com>
Date:   Mon, 02 Aug 2021 14:18:29 +1000
Message-id: <162787790940.32159.14588617595952736785@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 30 Jul 2021, Miklos Szeredi wrote:
> On Fri, 30 Jul 2021 at 09:34, NeilBrown <neilb@suse.de> wrote:
> 
> > But I'm curious about your reference to "some sort of subvolume
> > structure that the VFS knows about".  Do you have any references, or can
> > you suggest a search term I could try?
> 
> Found this:
> https://lore.kernel.org/linux-fsdevel/20180508180436.716-1-mfasheh@suse.de/
> 

Excellent, thanks.  Very useful.

OK.  Time for a third perspective.

With its current framing the problem is unsolvable.  So it needs to be
reframed.

By "current framing", I mean that we are trying to get btrfs to behave
in a way that meets current user-space expectations.  Specially, the
expectation that each object in any filesystem can be uniquely
identified by a 64bit inode number.  btrfs provides functionality which
needs more than 64bits.  So it simple does not fit.  btrfs currently
fudges with device numbers to hide the problem.  This is at best an
incomplete solution, and is already being shown to be insufficient.

Therefore we need to change user-space expectations.  This has been done
before multiple times - often by breaking things and leaving it up to
user-space to fix it.  My favourite example is that NFSv2 broke the
creation of lock files with O_CREAT|O_EXCL.  USER-space starting using
hard-links to achieve the same result.  When NFSv3 added reliable
O_CREAT|O_EXCL support, it hardly mattered.... but I digress.

It think we need to bite-the-bullet and decide that 64bits is not
enough, and in fact no number of bits will ever be enough.  overlayfs
makes this clear.  overlayfs merges multiple filesystems, and so needs
strictly more bits to uniquely identify all inodes than any of the
filesystems use.  Currently it over-loads the high bits and hopes the
filesystem doesn't use them.

The "obvious" choice for a replacement is the file handle provided by
name_to_handle_at() (falling back to st_ino if name_to_handle_at isn't
supported by the filesystem).  This returns an extensible opaque
byte-array.  It is *already* more reliable than st_ino.  Comparing
st_ino is only a reliable way to check if two files are the same if you
have both of them open.  If you don't, then one of the files might have
been deleted and the inode number reused for the other.  A filehandle
contains a generation number which protects against this.

So I think we need to strongly encourage user-space to start using
name_to_handle_at() whenever there is a need to test if two things are
the same.

This frees us to be a little less precise about assuring st_ino is
always unique, but only a little.  We still want to minimize conflicts
and avoid them in common situations.

A filehandle typically has some bytes used to locate the inode -
"location" - and some to validate it - "generation".  In general, st_ino
must now be seen as a hash of the "location".  It could be a generic hash
(xxhash? jhash?) or it could be a careful xor of the bits.

For btrfs, the "location" is root.objectid ++ file.objectid.  I think
the inode should become (file.objectid ^ swab64(root.objectid)).  This
will provide numbers that are unique until you get very large subvols,
and very many subvols.  It also ensures that two inodes in the same
subvol will be guaranteed to have different st_ino.

This will quickly cause problems for overlayfs as it means that if btrfs
is used with overlayfs, the top few bits won't be zero.  Possibly btrfs
could be polite and shift the swab64(root.objectid) down 8 bits to make
room.  Possible overlayfs should handle this case (top N-bits not all
zero), and switch to a generic hash of the inode number (or preferably
the filehandle) to (64-N bits).

If we convince user-space to use filehandles to compare objects, the NFS
problems I initially was trying to address go away.  Even before that,
if btrfs switches to a hashed (i.e. xor) inode number, then the problems
also go away.  but they aren't the only problems here.

Accessing the fhandle isn't always possible.  For example reading
/proc/locks reports major:minor:inode-number for each file (This is the
major:minor from the superblock, so btrfs internal dev numbers aren't
used).  The filehandle is simply not available.  I think the only way
to address this is to create a new file. "/proc/locks2" :-)
Similarly the "lock:" lines in /proc/$PID/fdinfo/$FD need to be duplicated
as "lock2:" lines with filehandle instead of inode number.  Ditto for
'inotify:' lines and possibly others.

Similarly /proc/$PID/maps contains the inode number with no fhandle.
The situation isn't so bad there as there is a path name, and you can
even call name_to_handle_at("/proc/$PID/map_files/$RANGE") to get the
fhandle.  It might be better to provide a new file though.

Next we come to the use of different device numbers in the one btrfs
filesystem.  I'm of the opinion that this was an unfortunately choice
that we need to deprecate.  Tools that use fhandle won't need it to
differentiate inodes, but there is more to the story than just that
need.

As has been mentioned, people depend on "du -x" and "find -mount" (aka
"-xdev") to stay within a "subvol".  We need to provide a clean
alternate before discouraging that usage.

xfs, ext4, fuse, and f2fs each (can) maintain a "project id" for each
inode, which effectively groups inodes into a tree.  This is used for
project quotas.  At one level this is conceptually very similar to the
btrfs subtree.root.objectid.  It is different in that it is only 32 bits
(:-[) and is mapped between user name-spaces like uids and gids.  It is
similar in that it identifies a group of inodes that are accounted
together and are (generally) contiguous in a tree.

If we encouraged "du" to have a "--proj" option (-j) which stays within
a project, and gave a similar option to find, that could be broadly
useful.  Then if btrfs provided the subvol objectid as fsx_projid
(available in FS_IOC_FSGETXATTR ioctl), then "du --proj" on btrfs would
stay in a subvol.  Longer term it might make sense to add a 64bit
project-id to statx.  I don't think it would make sense for btrfs to
have a 'project' concept that is different from the "subvolume".

It would be cool if "df" could have a "--proj" (or similar) flag so that
it would report the usage of a "subtree" (given a path).  Unfortunately
there isn't really an interface for this.  Going through the quota
system might be nice, I don't think it would work.

Another thought about btrfs device numbers is that, providing inode
numbers are (nearly) unique, we don't really need more than 2.  A btrfs
filesystem could allocate 2 anon device numbers.  One would be assigned
to the root, and each subvolume would get whichever device number its
parent doesn't have.  This would stop "du -x" and "find -mount" and
similar from crossing into subvols.  There could be a mount option to
select between "1", "2", and "many" device numbers for a filesystem.

- I note that cephfs place games with st_dev too....  I wonder if we can
  learn anything from that. 
- audit uses sb->s_dev without asking the filesystem.  So it won't
  handle  btrfs correctly.  I wonder if there is room for it to use
  file handles.

I accept that I'm proposing some BIG changes here, and they might break
things.  But btrfs is already broken in various ways.  I think we need a
goal to work towards which will eventually remove all breakage and still
have room for expansion.  I think that must include:

- providing as-unique-as-practical inode numbers across the whole
  filesystem, and deprecating the internal use of different device
  numbers.  Make it possible to mount without them ASAP, and aim to
  make that the default eventually.
- working with user-space tool/library developers to use
  name_to_handle_at() to identify inodes, only using st_ino
  as a fall-back
- adding filehandles to various /proc etc files as needed, either
  duplicating lines or duplicating files.  And helping application which
  use these files to migrate (I would *NOT* change the dev numbers in
  the current file to report the internal btrfs dev numbers the way that
  SUSE does.  I would prefer that current breakage could be used to
  motivate developers towards depending instead on fhandles).
- exporting subtree (aka subvol) id to user-space, possibly paralleling
  proj_id in some way, and extending various tools to understand
  subtrees

Who's with me??

NeilBrown
