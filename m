Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9986A168840
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 21:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbgBUUVi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 15:21:38 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:48276 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726483AbgBUUVi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 15:21:38 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id B8A788EE3D5;
        Fri, 21 Feb 2020 12:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1582316496;
        bh=X9lwNoA40+rafWitx3M+xWbVDsNdql9HImMtv2QjhWQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=MUEts7USA39twCVAZQqCBvLNWZDomXqzMPbZbKIWZih7ENCn3fbWk2hryWh/kMA85
         kduhunZyO/HM6qqQXRIClt90s5Y5JzhLPjZBxe3Y/bMkg2GOU6VFbTIQQhLEr8mHDE
         2ZjXS59RN0P0eHFS+Ckn+QhaR+XVgeGORqlHnncM=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2Y69yOA-ybgd; Fri, 21 Feb 2020 12:21:36 -0800 (PST)
Received: from jarvis.ext.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 9607F8EE180;
        Fri, 21 Feb 2020 12:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1582316496;
        bh=X9lwNoA40+rafWitx3M+xWbVDsNdql9HImMtv2QjhWQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=MUEts7USA39twCVAZQqCBvLNWZDomXqzMPbZbKIWZih7ENCn3fbWk2hryWh/kMA85
         kduhunZyO/HM6qqQXRIClt90s5Y5JzhLPjZBxe3Y/bMkg2GOU6VFbTIQQhLEr8mHDE
         2ZjXS59RN0P0eHFS+Ckn+QhaR+XVgeGORqlHnncM=
Message-ID: <1582316494.3376.45.camel@HansenPartnership.com>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications
 [ver #17]
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk
Cc:     raven@themaw.net, mszeredi@redhat.com, christian@brauner.io,
        jannh@google.com, darrick.wong@oracle.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 21 Feb 2020 12:21:34 -0800
In-Reply-To: <158230810644.2185128.16726948836367716086.stgit@warthog.procyon.org.uk>
References: <158230810644.2185128.16726948836367716086.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2020-02-21 at 18:01 +0000, David Howells wrote:
[...]
> ============================
> FILESYSTEM INFORMATION QUERY
> ============================
> 
> The fsinfo() system call allows information about the filesystem at a
> particular path point to be queried as a set of attributes, some of
> which may have more than one value.
> 
> Attribute values are of four basic types:
> 
>  (1) Version dependent-length structure (size defined by type).
> 
>  (2) Variable-length string (up to 4096, including NUL).
> 
>  (3) List of structures (up to INT_MAX size).
> 
>  (4) Opaque blob (up to INT_MAX size).
> 
> Attributes can have multiple values either as a sequence of values or
> a sequence-of-sequences of values and all the values of a particular
> attribute must be of the same type.
> 
> Note that the values of an attribute *are* allowed to vary between
> dentries within a single superblock, depending on the specific dentry
> that you're looking at, but all the values of an attribute have to be
> of the same type.
> 
> I've tried to make the interface as light as possible, so
> integer/enum attribute selector rather than string and the core does
> all the allocation and extensibility support work rather than leaving
> that to the filesystems. That means that for the first two attribute
> types, the filesystem will always see a sufficiently-sized buffer
> allocated.  Further, this removes the possibility of the filesystem
> gaining access to the userspace buffer.
> 
> 
> fsinfo() allows a variety of information to be retrieved about a
> filesystem and the mount topology:
> 
>  (1) General superblock attributes:
> 
>      - Filesystem identifiers (UUID, volume label, device numbers,
> ...)
>      - The limits on a filesystem's capabilities
>      - Information on supported statx fields and attributes and IOC
> flags.
>      - A variety single-bit flags indicating supported capabilities.
>      - Timestamp resolution and range.
>      - The amount of space/free space in a filesystem (as statfs()).
>      - Superblock notification counter.
> 
>  (2) Filesystem-specific superblock attributes:
> 
>      - Superblock-level timestamps.
>      - Cell name.
>      - Server names and addresses.
>      - Filesystem-specific information.
> 
>  (3) VFS information:
> 
>      - Mount topology information.
>      - Mount attributes.
>      - Mount notification counter.
> 
>  (4) Information about what the fsinfo() syscall itself supports,
> including
>      the type and struct/element size of attributes.
> 
> The system is extensible:
> 
>  (1) New attributes can be added.  There is no requirement that a
>      filesystem implement every attribute.  Note that the core VFS
> keeps a
>      table of types and sizes so it can handle future extensibility
> rather
>      than delegating this to the filesystems.
> 
>  (2) Version length-dependent structure attributes can be made larger
> and
>      have additional information tacked on the end, provided it keeps
> the
>      layout of the existing fields.  If an older process asks for a
> shorter
>      structure, it will only be given the bits it asks for.  If a
> newer
>      process asks for a longer structure on an older kernel, the
> extra
>      space will be set to 0.  In all cases, the size of the data
> actually
>      available is returned.
> 
>      In essence, the size of a structure is that structure's version:
> a
>      smaller size is an earlier version and a later version includes
>      everything that the earlier version did.
> 
>  (3) New single-bit capability flags can be added.  This is a
> structure-typed
>      attribute and, as such, (2) applies.  Any bits you wanted but
> the kernel
>      doesn't support are automatically set to 0.
> 
> fsinfo() may be called like the following, for example:
> 
> 	struct fsinfo_params params = {
> 		.at_flags	= AT_SYMLINK_NOFOLLOW,
> 		.flags		= FSINFO_FLAGS_QUERY_PATH,
> 		.request	= FSINFO_ATTR_AFS_SERVER_ADDRESSES,
> 		.Nth		= 2,
> 	};
> 	struct fsinfo_server_address address;
> 	len = fsinfo(AT_FDCWD, "/afs/grand.central.org/doc", &params,
> 		     &address, sizeof(address));
> 
> The above example would query an AFS filesystem to retrieve the
> address
> list for the 3rd server, and:
> 
> 	struct fsinfo_params params = {
> 		.at_flags	= AT_SYMLINK_NOFOLLOW,
> 		.flags		= FSINFO_FLAGS_QUERY_PATH,
> 		.request	= FSINFO_ATTR_AFS_CELL_NAME;
> 	};
> 	char cell_name[256];
> 	len = fsinfo(AT_FDCWD, "/afs/grand.central.org/doc", &params,
> 		     &cell_name, sizeof(cell_name));
> 
> would retrieve the name of an AFS cell as a string.
> 
> In future, I want to make fsinfo() capable of querying a context
> created by
> fsopen() or fspick(), e.g.:
> 
> 	fd = fsopen("ext4", 0);
> 	struct fsinfo_params params = {
> 		.flags		= FSINFO_FLAGS_QUERY_FSCONTEXT,
> 		.request	= FSINFO_ATTR_PARAMETERS;
> 	};
> 	char buffer[65536];
> 	fsinfo(fd, NULL, &params, &buffer, sizeof(buffer));
> 
> even if that context doesn't currently have a superblock attached.  I
> would prefer this to contain length-prefixed strings so that there's
> no need to insert escaping, especially as any character, including
> '\', can be used as the separator in cifs and so that binary
> parameters can be returned (though that is a lesser issue).

Could I make a suggestion about how this should be done in a way that
doesn't actually require the fsinfo syscall at all: it could just be
done with fsconfig.  The idea is based on something I've wanted to do
for configfd but couldn't because otherwise it wouldn't substitute for
fsconfig, but Christian made me think it was actually essential to the
ability of the seccomp and other verifier tools in the critique of
configfd and I belive the same critique applies here.

Instead of making fsconfig functionally configure ... as in you pass
the attribute name, type and parameters down into the fs specific
handler and the handler does a string match and then verifies the
parameters and then acts on them, make it table configured, so what
each fstype does is register a table of attributes which can be got and
optionally set (with each attribute having a get and optional set
function).  We'd have multiple tables per fstype, so the generic VFS
can register a table of attributes it understands for every fstype
(things like name, uuid and the like) and then each fs type would
register a table of fs specific attributes following the same pattern. 
The system would examine the fs specific table before the generic one,
allowing overrides.  fsconfig would have the ability to both get and
set attributes, permitting retrieval as well as setting (which is how I
get rid of the fsinfo syscall), we'd have a global parameter, which
would retrieve the entire table by name and type so the whole thing is
introspectable because the upper layer knows a-priori all the
attributes which can be set for a given fs type and what type they are
(so we can make more of the parsing generic).  Any attribute which
doesn't have a set routine would be read only and all attributes would
have to have a get routine meaning everything is queryable.

I think I know how to code this up in a way that would be fully
transparent to the existing syscalls.

James

