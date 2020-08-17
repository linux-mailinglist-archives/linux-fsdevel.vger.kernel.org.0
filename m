Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F7624649F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Aug 2020 12:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgHQKha (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 06:37:30 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:57705 "EHLO
        lizzy.crudebyte.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgHQKh3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 06:37:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=RRKBQezm/MbhgyHsL1drY/P+xKShAnC8u+emp2kCtOw=; b=Z3X/iKPS3raeGGi0CktvOi5TC6
        WE1FY48edFSmV2w6aYyU0i77B91FXHoW5wWuixq2+kwVUjMpipNxOPPgiZPp4Mg3PEPcIPPPhAcI6
        hy2FOpwzQqBSBPbutUk0ACcxNh1miZ/gw/YXuEAWjGiSt8kNP1HEq1muZRdjHS8K7x9Jf2KBjnBPz
        qQnccmyQK/LkQDCF/D6dgZaYdY1utBSfEbVsoiKK2Hb6BhXzICcY3J2SqZZh8uKNBwNJVMig36sph
        uK2o/4oOyVdB4Z3MhR/Ygp584Gji30BhmYeRaj3aAQ9GRNXvS/mo8C4He4nf4b+XUMnPGVa2aPEYA
        XRlydmNQ==;
From:   Christian Schoenebeck <qemu_oss@crudebyte.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Greg Kurz <groug@kaod.org>, linux-fsdevel@vger.kernel.org,
        stefanha@redhat.com, mszeredi@redhat.com, vgoyal@redhat.com,
        gscrivan@redhat.com, dwalsh@redhat.com, chirantan@chromium.org
Subject: file forks vs. xattr (was: xattr names for unprivileged stacking?)
Date:   Mon, 17 Aug 2020 12:37:17 +0200
Message-ID: <2859814.QYyEAd97eH@silver>
In-Reply-To: <20200817002930.GB28218@dread.disaster.area>
References: <20200728105503.GE2699@work-vm> <20200816230908.GI17456@casper.infradead.org> <20200817002930.GB28218@dread.disaster.area>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Montag, 17. August 2020 00:56:20 CEST Dave Chinner wrote:
> > That's yet another question: should xattrs and forks share the same data-
> > and namespace, or rather be orthogonal to each other.
> 
> Completely orthogonal. Alternate data streams are not xattrs, and
> xattrs are not ADS....

Agreed. Their key features (atomic small data vs. non-atomic large data) and 
their typical uses cases are probably too different for trying to stitch them 
somehow in an erroneous way into a shared space. Plus it would actually be 
beneficial if forks had their own xattrs.

On Montag, 17. August 2020 02:29:30 CEST Dave Chinner wrote:
> I'd stop calling these "forks" already, too. The user wants
> "alternate data streams", while a "resource fork" is an internal
> filesystem implementation detail used to provide ADS
> functionality...

The common terminology can certainly still be argued. I understand that from 
fs implementation perspective "fork" is probably ambiguous. But from public 
API (i.e. user space side) perspective the term "fork" does make sense, and so 
far I have not seen a better general term for this. Plus the ambiguous aspects 
on fs side are not exposed to the public side.

The term "alternate data stream" suggests that this is just about the raw data 
stream, but that's probably not what this feature will end up being limited 
to. E.g. I think they will have their own permissions on the long term (see 
below). Plus the term ADS is ATM somewhat sticky to the Microsoft universe.

> IOWs, with a filesystem inode fork implementation like this for ADS,
> all we really need is for the VFS to pass a magic command to
> ->lookup() to tell us to use the ADS namespace attached to the inode
> rather than use the primary inode type/state to perform the
> operation.

IMO starting with a minimalistic approach, in a way Solaris developers 
originally introduced forks, would IMO make sense for Linux as well:

- Adding a new option O_FORK to fcntl.h (Solaris uses O_XATTR, not a good
  idea for Linux though for reasons discussed).

- (Mis)using existing APIs for accessing forks (i.e. *at() functions):

	/* open fork 'foo' of file 'sheet.pdf' */

	int fdfile = open("sheet.pdf", O_PATH);
	int fdfork = openat(fdfile, "foo", O_FORK);
	/* continue with regular file I/O on fdfork now ... */

	and

	/* list all forks of file 'sheet.pdf' */

	int fdfile = open("sheet.pdf", O_PATH);
	int fdlist = openat(fdfile, ".", O_RDONLY|O_FORK);
	DIR* dir = fdopendir(fdlist);
	struct dirent* dent;
	while ((dent = readdir(dir)) {
		...
	}

- Permissions and ownership: Same as the file for simplicity as starting 
  point for the first version (see below).

- No subforks as starting point, and hence path separator '/' inside fork 
  names would be prohibited initially to avoid future clashes.

> Hence all the ADS support infrastructure is essentially dentry cache
> infrastructure allowing a dentry to be both a file and directory,
> and providing the pathname resolution that recognises an ADS
> redirection. Name that however you want - we've got to do an on-disk
> format change to support ADS, so we can tell the VFS we support ADS
> or not. And we have no cares about existing names in the filesystem
> conflicting with the ADS pathname identifier because it's a mkfs
> time decision. Given that special flags are needed for the openat()
> call to resolve an ADS (e.g. O_ALT), we know if we should parse the
> ADS identifier as an ADS the moment it is seen...

So you think there should be a built-in full qualified path name resolution to 
forks right from the start? E.g. like on Windows "C:\some\where\sheet.pdf:foo" 
-> fork "foo" of file "sheet.pdf"?

> > I don't understand why a fork would be permitted to have its own
> > permissions.  That makes no sense.  Silly Solaris.
> 
> I can't think of a reason why, either, but the above implementation
> for XFS would support it if the presentation layer allows it... :)

I would definitely not add this right from the start of course, but on the 
long term it actually does make senses for them having their own permissions, 
simply because there are already applications for that:

E.g. on some systems forks are used to tag files for security relevant issues, 
for instance where the file originated from (a trusted vs. untrusted source). 
If it was a untrusted source, the user is made aware about this circumstance 
by the system when attempting to open the file. In this use case the fork 
would probably have more restrictive permissions than the actual file.

OTOH forks are used to extend existing files in non-obtrusive way. Say you 
have some sort of (e.g. huge) master file, and a team works on that file. Then 
the individual people would attach their changes solely as forks to the master 
file with their ownership, probably even with complex ACLs, to prevent certain 
users from touching (or even reading) other ones changes. In this use case the 
master file might be readonly for most people, while the individual forks 
being anywhere between more permissive or more restrictive.

Best regards,
Christian Schoenebeck


