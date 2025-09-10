Return-Path: <linux-fsdevel+bounces-60835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98105B52041
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 20:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06E12563BDD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 18:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244652BCF41;
	Wed, 10 Sep 2025 18:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="o1VY6vrX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1427212FA0;
	Wed, 10 Sep 2025 18:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757528923; cv=none; b=KrHP5aTOKMRM8dKl8nVPXegTc2DeUU2qA14cSSxb4YCAMvaigBjomY9OdxmewMQZBg2TUaYyVi5sKc4j7S5LAr58sP2sp8LfRe3F1plDIRbPsQGYfUyZ3myAQtRU9H1/S6V1QjsbaYw4e6+KW5dqNIdTQAVdkUqBIdnAF0mtsMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757528923; c=relaxed/simple;
	bh=VfV9VPzAzrywFyTuOYkFfwxQlGkDk08CnE9fCnPOWso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHDO4Zr+FXkcTD2h+DAqyDqjc0fZrn+TVFyzUtwuZlIz40jJTwU8IFJRg8axfyAkC5FO4QMBm86sJUsxsXGIw6KWOUtaf6TYm+z/kr+nW1Slgll7s4f7Ct0jOvMZ1zwRUTuHHQ4HpQF22cCUk9zlEiHrj9xhU7c6GEzu9G+aG04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=o1VY6vrX; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8ZneQusufplOGVqyxjibUJ37cpo088vXQhTKjItRjqE=; b=o1VY6vrXNqcETLLO9CbUeyjEPC
	qrVDNH2OmFKihzqvTEO0yqxYFmNVzTot11uymfQRlQWLrd9SVpPZ8QA4OSezHbb6v0Yqyi85pD7yQ
	Ww9HGUTil4aIkoRzDIRo20WcnyhkPINvw8WxHh47qj4KQng2coh0shtYOaLTDtTRB1JxgLbPjEl22
	9W2m1m6RdW4se11WjQHfbUAjKntm9H3FgGm3yQ46ooqL3nEuEw8GFPRpRh1EpC2E5MSZT1caj9Kky
	3pMZvylswxKa3IdC20dGujmqgp5nrS5QIDtOegJGus0TldxUiWTnQ9RacVVE9TtqPVMh+TRh5oY9D
	XvXifRMg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwPYb-00000005wsb-2nO7;
	Wed, 10 Sep 2025 18:28:37 +0000
Date: Wed, 10 Sep 2025 19:28:37 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>, Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 7/7] Use simple_start_creating() in various places.
Message-ID: <20250910182837.GT31600@ZenIV>
References: <>
 <f402ec5ce57c872f436d1b6a5e9c3633ba237a26.camel@kernel.org>
 <175750382935.2850467.264144428541875879@noble.neil.brown.name>
 <889f488eb1b27c91f445d4fa22dd4ff425b49454.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <889f488eb1b27c91f445d4fa22dd4ff425b49454.camel@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Sep 10, 2025 at 07:54:25AM -0400, Jeff Layton wrote:

> I'm having a hard time finding where that is defined in the POSIX
> specs. The link count for normal files is fairly well-defined. The link
> count for directories has always been more nebulous.

Try UNIX textbooks...  <pulls some out> in Stevens that would be 4.14
and I'm pretty sure that it's covered in other standard ones.

History of that thing: on traditional filesystem "." and ".." are real
directory entries, "." refering to the inode of directory itself and
".." to that of parent (if it's not a root directory) or to directory
itself (if it is root).  Link count is literally the number of directory
entries pointing to given inode.  For directories that boils down to 2
if empty ("." + reference in parent or ".." for non-root and root resp.),
then each subdirectory adds 1 (".." in it points back to ours).

That goes for any local UNIX filesystem, and there hadn't been anything
else until RFS and NFS, both keeping the same rules (both coming from
the underlying filesystem layout).  Try mkdir and ln -s on NFS, watch
what's happening to stat of parent.

The things got murkier for FAT, when its support got added - on-disk
layout has nothing like a link count.  It has only one directory entry
for any non-directory *and* directory entries have object type of the
thing they are pointing to, so one can match the behaviour of normal UNIX
filesystem by going through the directory contents when reading an inode;
the cost is not particularly high, so that's what everyone did.

For original isofs (i.e. no rockridge extensions, no ownership, etc.)
that was considerably harder; I don't remember what SunOS hsfs had done
there (thankfully), our implementation started with "just slap 2 for
directories if RR is not there", but that switched to "we don't know the
exact answer, so use 1 to indicate that" pretty early <checks> 1.1.40 -
Aug '94; original isofs implementation went into the tree in Dec '92.

More complications came when... odd people came complaining about the
overflows when they got 65534 subdirectories in the same directory.
That had two sides to it - on-disk inode layout and userland ABI.
For the latter the long-term solution was to make st_nlink 32bit
(in newer variant of stat(2) if needed) and fail with EOVERFLOW if the
value doesn't fit into the ABI you are trying to use.  For the latter...
some weird kludges followed, with the things eventually settling down
on "if you can't manage the expected value, at least report something
that couldn't be confused for it".  Since 1 is normally impossible for
a directory, that turned into "can't tell you how many links are there".
That covered both "we don't have enough bits in the on-disk field" and
"we don't have that field on disk at all and can't be bothered calculating
it" (as in iso9660 case above).

Of course, for e.g. NFS the value we report is whatever the server
tells us; nobody is going to have client to readdirplus the entire
directory and count subdirectories in it just to check if server lies
and is inconsistent at that.  But that's not really different from the
situation with local filesystem - we assume that the count in on-disk
inode matches the number of directory entries pointing to it.

The find(1) (well, tree-walkers in general, really) thing Neil has
mentioned is that on filesystems where readdir(3) gives you no reliable
dirent->d_type you need to stat every entry in order to decide whether
it's a subdirectory you would need to walk into.  Being able to tell
"this directory has no subdirectories" allows to skip those stat(2) calls
when going through it.  Same for "I've already seen 5 subdirectories,
stat on our directory has reported st_nlink being 7, so we'd already
seen all subdirectories here; no need to stat(2) further entries", for
that matter...  On a sane filesystem you'd just look for entries with
->dt_type == DT_DIR and skip all those stat(2).

IOW, the real rules are
	* st_nlink >= 2: st_nlink - 2 subdirectories
	* st_nlink = 1: refused to report the number of subdirectories
	* st_nlink = 0: fstat on something that had been removed
In case of corrupted filesystem,  bullshitting server, etc. result might
have no relationship to reality, of course.

I don't know of any case where creation of symlinks in a directory would
affected the parent's link count.  Frankly, I thought that was just
an accidental cut'n'paste from __nfsd_mkdir()...  As long as nothing
in the userland is playing odd games with that st_nlink value, I'd say
we should remove the temptation to start doing that and return to the
usual semantics.

