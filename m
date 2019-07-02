Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8175D5FC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2019 20:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfGBSPo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jul 2019 14:15:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:46410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbfGBSPn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jul 2019 14:15:43 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC7FA20989;
        Tue,  2 Jul 2019 18:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562091342;
        bh=edidt6q3V/8wPli7YYyCa1ugOfMbWrYdtWTACKbLcPE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ngon/H5/9TjNBudpX/AhFNJ1EQWzCtYwqMLG2y1leW+Zi0QlMhmoMqsfmi2Orxe/y
         O+UbAwpp+8j3h78ctsOyE4nQO7H2zvr0FJXdo1f1ZEN2DlqXTIPPMkU1WEoFET0aoG
         H2jIcem6v3SjnDg4nJpZWjNxxvDwq1Sut1uP6OUU=
Date:   Tue, 2 Jul 2019 11:15:40 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] VFS: Introduce filesystem information query
 syscall [ver #15]
Message-ID: <20190702181539.GA110306@gmail.com>
References: <156173661696.14042.17822154531324224780.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156173661696.14042.17822154531324224780.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 28, 2019 at 04:43:37PM +0100, David Howells wrote:
> 
> Here are a set of patches that adds a syscall, fsinfo(), that allows
> attributes of a filesystem/superblock to be queried.  Attribute values are
> of four basic types:
> 
>  (1) Version dependent-length structure (size defined by type).
> 
>  (2) Variable-length string (up to 4096, no NUL).
> 
>  (3) Array of fixed-length structures (up to INT_MAX size).
> 
>  (4) Opaque blob (up to INT_MAX size).
> 
> Attributes can have multiple values either as a sequence of values or a
> sequence-of-sequences of values and all the values of a particular
> attribute must be of the same type.
> 
> Note that the values of an attribute *are* allowed to vary between dentries
> within a single superblock, depending on the specific dentry that you're
> looking at.
> 
> I've tried to make the interface as light as possible, so integer/enum
> attribute selector rather than string and the core does all the allocation
> and extensibility support work rather than leaving that to the filesystems.
> That means that for the first two attribute types, sb->s_op->fsinfo() may
> assume that the provided buffer is always present and always big enough.
> 
> Further, this removes the possibility of the filesystem gaining access to the
> userspace buffer.
> 
> 
> fsinfo() allows a variety of information to be retrieved about a filesystem
> and the mount topology:
> 
>  (1) General superblock attributes:
> 
>       - The amount of space/free space in a filesystem (as statfs()).
>       - Filesystem identifiers (UUID, volume label, device numbers, ...)
>       - The limits on a filesystem's capabilities
>       - Information on supported statx fields and attributes and IOC flags.
>       - A variety single-bit flags indicating supported capabilities.
>       - Timestamp resolution and range.
>       - Sources (as per mount(2), but fsconfig() allows multiple sources).
>       - In-filesystem filename format information.
>       - Filesystem parameters ("mount -o xxx"-type things).
>       - LSM parameters (again "mount -o xxx"-type things).
> 
>  (2) Filesystem-specific superblock attributes:
> 
>       - Server names and addresses.
>       - Cell name.
> 
>  (3) Filesystem configuration metadata attributes:
> 
>       - Filesystem parameter type descriptions.
>       - Name -> parameter mappings.
>       - Simple enumeration name -> value mappings.
> 
>  (4) Information about what the fsinfo() syscall itself supports, including
>      the number of attibutes supported and the number of capability bits
>      supported.
> 
>  (5) Future patches will include information about the mount topology.
> 
> The system is extensible:
> 
>  (1) New attributes can be added.  There is no requirement that a
>      filesystem implement every attribute.  Note that the core VFS keeps a
>      table of types and sizes so it can handle future extensibility rather
>      than delegating this to the filesystems.
> 
>  (2) Version length-dependent structure attributes can be made larger and
>      have additional information tacked on the end, provided it keeps the
>      layout of the existing fields.  If an older process asks for a shorter
>      structure, it will only be given the bits it asks for.  If a newer
>      process asks for a longer structure on an older kernel, the extra
>      space will be set to 0.  In all cases, the size of the data actually
>      available is returned.
> 
>      In essence, the size of a structure is that structure's version: a
>      smaller size is an earlier version and a later version includes
>      everything that the earlier version did.
> 
>  (3) New single-bit capability flags can be added.  This is a structure-typed
>      attribute and, as such, (2) applies.  Any bits you wanted but the kernel
>      doesn't support are automatically set to 0.
> 
> If a filesystem-specific attribute is added, it should just take up the next
> number in the enumeration.  Currently, I do not intend that the number space
> should be subdivided between interested parties.
> 
> 
> fsinfo() may be called like the following, for example:
> 
> 	struct fsinfo_params params = {
> 		.at_flags	= AT_SYMLINK_NOFOLLOW,
> 		.request	= FSINFO_ATTR_SERVER_ADDRESS;
> 		.Nth		= 2;
> 		.Mth		= 1;
> 	};
> 	struct fsinfo_server_address address;
> 
> 	len = fsinfo(AT_FDCWD, "/afs/grand.central.org/doc", &params,
> 		     &address, sizeof(address));
> 
> The above example would query a network filesystem, such as AFS or NFS, and
> ask what the 2nd address (Mth) of the 3rd server (Nth) that the superblock is
> using is.  Whereas:
> 
> 	struct fsinfo_params params = {
> 		.at_flags	= AT_SYMLINK_NOFOLLOW,
> 		.request	= FSINFO_ATTR_AFS_CELL_NAME;
> 	};
> 	char cell_name[256];
> 
> 	len = fsinfo(AT_FDCWD, "/afs/grand.central.org/doc", &params,
> 		     &cell_name, sizeof(cell_name));
> 
> would retrieve the name of an AFS cell as a string.
> 
> fsinfo() can also be used to query a context from fsopen() or fspick():
> 
> 	fd = fsopen("ext4", 0);
> 	struct fsinfo_params params = {
> 		.request	= FSINFO_ATTR_PARAM_DESCRIPTION;
> 	};
> 	struct fsinfo_param_description desc;
> 	fsinfo(fd, NULL, &params, &desc, sizeof(desc));
> 
> even if that context doesn't currently have a superblock attached (though if
> there's no superblock attached, only filesystem-specific things like parameter
> descriptions can be accessed).
> 
> The patches can be found here also:
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
> 
> on branch:
> 
> 	fsinfo-core
> 
> 

Where are the tests and man page for this system call?  "Tests" meaning actual
automated tests in a commonly used test suite (e.g. LTP, kselftests, or
xfstests), not just a sample program.

- Eric
