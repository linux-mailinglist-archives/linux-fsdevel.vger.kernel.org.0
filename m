Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 792895D6A6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2019 21:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfGBTKy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Tue, 2 Jul 2019 15:10:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47204 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbfGBTKy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jul 2019 15:10:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CDFDFC049589;
        Tue,  2 Jul 2019 19:10:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-219.rdu2.redhat.com [10.10.120.219])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B31745D6A9;
        Tue,  2 Jul 2019 19:10:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190702181539.GA110306@gmail.com>
References: <20190702181539.GA110306@gmail.com> <156173661696.14042.17822154531324224780.stgit@warthog.procyon.org.uk>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk, raven@themaw.net,
        mszeredi@redhat.com, christian@brauner.io,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: fsinfo(2) manpage
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <32326.1562094642.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Tue, 02 Jul 2019 20:10:42 +0100
Message-ID: <32327.1562094642@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 02 Jul 2019 19:10:53 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Here's a manpage for fsinfo().  It needs a little updating, but I've applied
some review comments that will require this updating anyway.

David
---
'\" t
.\" Copyright (c) 2018 David Howells <dhowells@redhat.com>
.\"
.\" %%%LICENSE_START(VERBATIM)
.\" Permission is granted to make and distribute verbatim copies of this
.\" manual provided the copyright notice and this permission notice are
.\" preserved on all copies.
.\"
.\" Permission is granted to copy and distribute modified versions of this
.\" manual under the conditions for verbatim copying, provided that the
.\" entire resulting derived work is distributed under the terms of a
.\" permission notice identical to this one.
.\"
.\" Since the Linux kernel and libraries are constantly changing, this
.\" manual page may be incorrect or out-of-date.  The author(s) assume no
.\" responsibility for errors or omissions, or for damages resulting from
.\" the use of the information contained herein.  The author(s) may not
.\" have taken the same level of care in the production of this manual,
.\" which is licensed free of charge, as they might when working
.\" professionally.
.\"
.\" Formatted or processed versions of this manual, if unaccompanied by
.\" the source, must acknowledge the copyright and authors of this work.
.\" %%%LICENSE_END
.\"
.TH FSINFO 2 2018-06-06 "Linux" "Linux Programmer's Manual"
.SH NAME
fsinfo \- Get filesystem information
.SH SYNOPSIS
.nf
.B #include <sys/types.h>
.br
.B #include <sys/fsinfo.h>
.br
.B #include <unistd.h>
.br
.BR "#include <fcntl.h>           " "/* Definition of AT_* constants */"
.PP
.BI "int fsinfo(int " dirfd ", const char *" pathname ","
.BI "           struct fsinfo_params *" params ","
.BI "           void *" buffer ", size_t " buf_size );
.fi
.PP
.IR Note :
There is no glibc wrapper for
.BR fsinfo ();
see NOTES.
.SH DESCRIPTION
.PP
fsinfo() retrieves the desired filesystem attribute, as selected by the
parameters pointed to by
.IR params ,
and stores its value in the buffer pointed to by
.IR buffer .
.PP
The parameter structure is optional, defaulting to all the parameters being 0
if the pointer is NULL.  The structure looks like the following:
.PP
.in +4n
.nf
struct fsinfo_params {
    __u32 at_flags;     /* AT_SYMLINK_NOFOLLOW and similar flags */
    __u32 request;      /* Requested attribute */
    __u32 Nth;          /* Instance of attribute */
    __u32 Mth;          /* Subinstance of Nth instance */
    __u32 __reserved[6]; /* Reserved params; all must be 0 */
};
.fi
.in
.PP
The filesystem to be queried is looked up using a combination of
.IR dfd ", " pathname " and " params->at_flags.
This is discussed in more detail below.
.PP
The desired attribute is indicated by
.IR params->request .
If
.I params
is NULL, this will default to
.BR FSINFO_ATTR_STATFS ,
which retrieves some of the information returned by
.BR statfs ().
The available attributes are described below in the "THE ATTRIBUTES" section.
.PP
Some attributes can have multiple values and some can even have multiple
instances with multiple values.  For example, a network filesystem might use
multiple servers.  The names of each of these servers can be retrieved by
using
.I params->Nth
to iterate through all the instances until error
.B ENODATA
occurs, indicating the end of the list.  Further, each server might have
multiple addresses available; these can be enumerated using
.I params->Nth
to iterate the servers and
.I params->Mth
to iterate the addresses of the Nth server.
.PP
The amount of data written into the buffer depends on the attribute selected.
Some attributes return variable-length strings and some return fixed-size
structures.  If either
.IR buffer " is  NULL  or " buf_size " is 0"
then the size of the attribute value will be returned and nothing will be
written into the buffer.
.PP
The
.I params->__reserved
parameters must all be 0.
.\"_______________________________________________________
.SS
Allowance for Future Attribute Expansion
.PP
To allow for the future expansion and addition of fields to any fixed-size
structure attribute,
.BR fsinfo ()
makes the following guarantees:
.RS 4m
.IP (1) 4m
It will always clear any excess space in the buffer.
.IP (2) 4m
It will always return the actual size of the data.
.IP (3) 4m
It will truncate the data to fit it into the buffer rather than giving an
error.
.IP (4) 4m
Any new version of a structure will incorporate all the fields from the old
version at same offsets.
.RE
.PP
So, for example, if the caller is running on an older version of the kernel
with an older, smaller version of the structure than was asked for, the kernel
will write the smaller version into the buffer and will clear the remainder of
the buffer to make sure any additional fields are set to 0.  The function will
return the actual size of the data.
.PP
On the other hand, if the caller is running on a newer version of the kernel
with a newer version of the structure that is larger than the buffer, the write
to the buffer will be truncated to fit as necessary and the actual size of the
data will be returned.
.PP
Note that this doesn't apply to variable-length string attributes.

.\"_______________________________________________________
.SS
Invoking \fBfsinfo\fR():
.PP
To access a file's status, no permissions are required on the file itself, but
in the case of
.BR fsinfo ()
with a path, execute (search) permission is required on all of the directories
in
.I pathname
that lead to the file.
.PP
.BR fsinfo ()
uses
.IR pathname ", " dirfd " and " params->at_flags
to locate the target file in one of a variety of ways:
.TP
[*] By absolute path.
.I pathname
points to an absolute path and
.I dirfd
is ignored.  The file is looked up by name, starting from the root of the
filesystem as seen by the calling process.
.TP
[*] By cwd-relative path.
.I pathname
points to a relative path and
.IR dirfd " is " AT_FDCWD .
The file is looked up by name, starting from the current working directory.
.TP
[*] By dir-relative path.
.I pathname
points to relative path and
.I dirfd
indicates a file descriptor pointing to a directory.  The file is looked up by
name, starting from the directory specified by
.IR dirfd .
.TP
[*] By file descriptor.
.IR pathname " is " NULL " and " dirfd
indicates a file descriptor.  The file attached to the file descriptor is
queried directly.  The file descriptor may point to any type of file, not just
a directory.
.PP
.I flags
can be used to influence a path-based lookup.  A value for
.I flags
is constructed by OR'ing together zero or more of the following constants:
.TP
.BR AT_EMPTY_PATH
.\" commit 65cfc6722361570bfe255698d9cd4dccaf47570d
If
.I pathname
is an empty string, operate on the file referred to by
.IR dirfd
(which may have been obtained using the
.BR open (2)
.B O_PATH
flag).
If
.I dirfd
is
.BR AT_FDCWD ,
the call operates on the current working directory.
In this case,
.I dirfd
can refer to any type of file, not just a directory.
This flag is Linux-specific; define
.B _GNU_SOURCE
.\" Before glibc 2.16, defining _ATFILE_SOURCE sufficed
to obtain its definition.
.TP
.BR AT_NO_AUTOMOUNT
Don't automount the terminal ("basename") component of
.I pathname
if it is a directory that is an automount point.  This allows the caller to
gather attributes of the filesystem holding an automount point (rather than
the filesystem it would mount).  This flag can be used in tools that scan
directories to prevent mass-automounting of a directory of automount points.
The
.B AT_NO_AUTOMOUNT
flag has no effect if the mount point has already been mounted over.
This flag is Linux-specific; define
.B _GNU_SOURCE
.\" Before glibc 2.16, defining _ATFILE_SOURCE sufficed
to obtain its definition.
.TP
.B AT_SYMLINK_NOFOLLOW
If
.I pathname
is a symbolic link, do not dereference it:
instead return information about the link itself, like
.BR lstat ().
.SH THE ATTRIBUTES
.PP
There is a range of attributes that can be selected from.  These are:

.\" __________________ FSINFO_ATTR_STATFS __________________
.TP
.B fsinfo_attr_statfs
This retrieves the "dynamic"
.B statfs
information, such as block and file counts, that are expected to change whilst
a filesystem is being used.  This fills in the following structure:
.PP
.RS
.in +4n
.nf
struct fsinfo_statfs {
    __u64 f_blocks;	/* Total number of blocks in fs */
    __u64 f_bfree;	/* Total number of free blocks */
    __u64 f_bavail;	/* Number of free blocks available to ordinary user */
    __u64 f_files;	/* Total number of file nodes in fs */
    __u64 f_ffree;	/* Number of free file nodes */
    __u64 f_favail;	/* Number of free file nodes available to ordinary user */
    __u32 f_bsize;	/* Optimal block size */
    __u32 f_frsize;	/* Fragment size */
};
.fi
.in
.RE
.IP
The fields correspond to those of the same name returned by
.BR statfs ().

.\" __________________ FSINFO_ATTR_FSINFO __________________
.TP
.B FSINFO_ATTR_FSINFO
This retrieves information about the
.BR fsinfo ()
system call itself.  This fills in the following structure:
.PP
.RS
.in +4n
.nf
struct fsinfo_fsinfo {
    __u32 max_attr;
    __u32 max_cap;
};
.fi
.in
.RE
.IP
The
.I max_attr
value indicates the number of attributes supported by the
.BR fsinfo ()
system call, and
.I max_cap
indicates the number of capability bits supported by the
.B FSINFO_ATTR_CAPABILITIES
attribute.  The first corresponds to
.I fsinfo_attr__nr
and the second to
.I fsinfo_cap__nr
in the header file.

.\" __________________ FSINFO_ATTR_IDS __________________
.TP
.B FSINFO_ATTR_IDS
This retrieves a number of fixed IDs and other static information otherwise
available through
.BR statfs ().
The following structure is filled in:
.PP
.RS
.in +4n
.nf
struct fsinfo_ids {
    char  f_fs_name[15 + 1]; /* Filesystem name */
    __u64 f_flags;	/* Filesystem mount flags (MS_*) */
    __u64 f_fsid;	/* Short 64-bit Filesystem ID */
    __u64 f_sb_id;	/* Internal superblock ID */
    __u32 f_fstype;	/* Filesystem type from linux/magic.h */
    __u32 f_dev_major;	/* As st_dev_* from struct statx */
    __u32 f_dev_minor;
};
.fi
.in
.RE
.IP
Most of these are filled in as for
.BR statfs (),
with the addition of the filesystem's symbolic name in
.I f_fs_name
and an identifier for use in notifications in
.IR f_sb_id .

.\" __________________ FSINFO_ATTR_LIMITS __________________
.TP
.B FSINFO_ATTR_LIMITS
This retrieves information about the limits of what a filesystem can support.
The following structure is filled in:
.PP
.RS
.in +4n
.nf
struct fsinfo_limits {
    __u64 max_file_size;
    __u64 max_uid;
    __u64 max_gid;
    __u64 max_projid;
    __u32 max_dev_major;
    __u32 max_dev_minor;
    __u32 max_hard_links;
    __u32 max_xattr_body_len;
    __u16 max_xattr_name_len;
    __u16 max_filename_len;
    __u16 max_symlink_len;
    __u16 __reserved[1];
};
.fi
.in
.RE
.IP
These indicate the maximum supported sizes for a variety of filesystem objects,
including the file size, the extended attribute name length and body length,
the filename length and the symlink body length.
.IP
It also indicates the maximum representable values for a User ID, a Group ID,
a Project ID, a device major number and a device minor number.
.IP
And finally, it indicates the maximum number of hard links that can be made to
a file.
.IP
Note that some of these values may be zero if the underlying object or concept
is not supported by the filesystem or the medium.

.\" __________________ FSINFO_ATTR_SUPPORTS __________________
.TP
.B FSINFO_ATTR_SUPPORTS
This retrieves information about what bits a filesystem supports in various
masks.  The following structure is filled in:
.PP
.RS
.in +4n
.nf
struct fsinfo_supports {
    __u64 stx_attributes;
    __u32 stx_mask;
    __u32 ioc_flags;
    __u32 win_file_attrs;
    __u32 __reserved[1];
};
.fi
.in
.RE
.IP
The
.IR stx_attributes " and " stx_mask
fields indicate what bits in the struct statx fields of the matching names
are supported by the filesystem.
.IP
The
.I ioc_flags
field indicates what FS_*_FL flag bits as used through the FS_IOC_GET/SETFLAGS
ioctls are supported by the filesystem.
.IP
The
.I win_file_attrs
indicates what DOS/Windows file attributes a filesystem supports, if any.

.\" __________________ FSINFO_ATTR_CAPABILITIES __________________
.TP
.B FSINFO_ATTR_CAPABILITIES
This retrieves information about what features a filesystem supports as a
series of single bit indicators.  The following structure is filled in:
.PP
.RS
.in +4n
.nf
struct fsinfo_capabilities {
    __u8 capabilities[(fsinfo_cap__nr + 7) / 8];
};
.fi
.in
.RE
.IP
where the bit of interest can be found by:
.PP
.RS
.in +4n
.nf
	p->capabilities[bit / 8] & (1 << (bit % 8)))
.fi
.in
.RE
.IP
The bits are listed by
.I enum fsinfo_capability
and
.B fsinfo_cap__nr
is one more than the last capability bit listed in the header file.
.IP
Note that the number of capability bits actually supported by the kernel can be
found using the
.B FSINFO_ATTR_FSINFO
attribute.
.IP
The capability bits and their meanings are listed below in the "THE
CAPABILITIES" section.

.\" __________________ FSINFO_ATTR_TIMESTAMP_INFO __________________
.TP
.B FSINFO_ATTR_TIMESTAMP_INFO
This retrieves information about what timestamp resolution and scope is
supported by a filesystem for each of the file timestamps.  The following
structure is filled in:
.PP
.RS
.in +4n
.nf
struct fsinfo_timestamp_info {
	__s64 minimum_timestamp;
	__s64 maximum_timestamp;
	__u16 atime_gran_mantissa;
	__u16 btime_gran_mantissa;
	__u16 ctime_gran_mantissa;
	__u16 mtime_gran_mantissa;
	__s8  atime_gran_exponent;
	__s8  btime_gran_exponent;
	__s8  ctime_gran_exponent;
	__s8  mtime_gran_exponent;
	__u32 __reserved[1];
};
.fi
.in
.RE
.IP
where
.IR minimum_timestamp " and " maximum_timestamp
are the limits on the timestamps that the filesystem supports and
.IR *time_gran_mantissa " and " *time_gran_exponent
indicate the granularity of each timestamp in terms of seconds, using the
formula:
.PP
.RS
.in +4n
.nf
mantissa * pow(10, exponent) Seconds
.fi
.in
.RE
.IP
where exponent may be negative and the result may be a fraction of a second.
.IP
Four timestamps are detailed: \fBA\fPccess time, \fBB\fPirth/creation time,
\fBC\fPhange time and \fBM\fPodification time.  Capability bits are defined
that specify whether each of these exist in the filesystem or not.
.IP
Note that the timestamp description may be approximated or inaccurate if the
file is actually remote or is the union of multiple objects.

.\" __________________ FSINFO_ATTR_VOLUME_ID __________________
.TP
.B FSINFO_ATTR_VOLUME_ID
This retrieves the system's superblock volume identifier as a variable-length
string.  This does not necessarily represent a value stored in the medium but
might be constructed on the fly.
.IP
For instance, for a block device this is the block device identifier
(eg. "sdb2"); for AFS this would be the numeric volume identifier.

.\" __________________ FSINFO_ATTR_VOLUME_UUID __________________
.TP
.B FSINFO_ATTR_VOLUME_UUID
This retrieves the volume UUID, if there is one, as a little-endian binary
UUID.  This fills in the following structure:
.PP
.RS
.in +4n
.nf
struct fsinfo_volume_uuid {
    __u8 uuid[16];
};
.fi
.in
.RE
.IP

.\" __________________ FSINFO_ATTR_VOLUME_NAME __________________
.TP
.B FSINFO_ATTR_VOLUME_NAME
This retrieves the filesystem's volume name as a variable-length string.  This
is expected to represent a name stored in the medium.
.IP
For a block device, this might be a label stored in the superblock.  For a
network filesystem, this might be a logical volume name of some sort.

.\" __________________ FSINFO_ATTR_CELL/DOMAIN __________________
.PP
.B FSINFO_ATTR_CELL_NAME
.br
.B FSINFO_ATTR_DOMAIN_NAME
.br
.IP
These two attributes are variable-length string attributes that may be used to
obtain information about network filesystems.  An AFS volume, for instance,
belongs to a named cell.  CIFS shares may belong to a domain.

.\" __________________ FSINFO_ATTR_REALM_NAME __________________
.TP
.B FSINFO_ATTR_REALM_NAME
This attribute is variable-length string that indicates the Kerberos realm that
a filesystem's authentication tokens should come from.

.\" __________________ FSINFO_ATTR_SERVER_NAME __________________
.TP
.B FSINFO_ATTR_SERVER_NAME
This attribute is a multiple-value attribute that lists the names of the
servers that are backing a network filesystem.  Each value is a variable-length
string.  The values are enumerated by calling
.BR fsinfo ()
multiple times, incrementing
.I params->Nth
each time until an ENODATA error occurs, thereby indicating the end of the
list.

.\" __________________ FSINFO_ATTR_SERVER_ADDRESS __________________
.TP
.B FSINFO_ATTR_SERVER_ADDRESS
This attribute is a multiple-instance, multiple-value attribute that lists the
addresses of the servers that are backing a network filesystem.  Each value is
a structure of the following type:
.PP
.RS
.in +4n
.nf
struct fsinfo_server_address {
    struct __kernel_sockaddr_storage address;
};
.fi
.in
.RE
.IP
Where the address may be AF_INET, AF_INET6, AF_RXRPC or any other type as
appropriate to the filesystem.
.IP
The values are enumerated by calling
.IR fsinfo ()
multiple times, incrementing
.I params->Nth
to step through the servers and
.I params->Mth
to step through the addresses of the Nth server each time until ENODATA errors
occur, thereby indicating either the end of a server's address list or the end
of the server list.
.IP
Barring the server list changing whilst being accessed, it is expected that the
.I params->Nth
will correspond to
.I params->Nth
for
.BR FSINFO_ATTR_SERVER_NAME .

.\" __________________ FSINFO_ATTR_PARAMETER __________________
.TP
.B FSINFO_ATTR_PARAMETER
This attribute is a 2D multiple-value attribute that lists the values of the
mount parameters for a filesystem as variable-length strings.
.IP
The parameters are enumerated by calling
.BR fsinfo ()
multiple times, incrementing
.IR params->Nth and params->Mth
to step through them until error ENODATA is given.
.IP
Parameter strings are presented in a form akin to the way they're passed to the
context created by the
.BR fsopen ()
system call.  For example, straight text parameters will be rendered as
something like:
.PP
.RS
.in +4n
.nf
"source=/dev/sda1"
"data=journal"
"noquota"
.fi
.in
.RE
.IP
where the first parameters correspond on a 1-to-1 basis by
.I params->Nth
with the parameters defined by
.IR FSINFO_ATTR_PARAM_SPECIFICATION .
Additional parameters may also be presented.  Further, any particular parameter
may have multiple values (multiple sources for example).  These can be
enumerated with params->Mth.

.\" __________________ FSINFO_ATTR_NAME_ENCODING __________________
.TP
.B FSINFO_ATTR_NAME_ENCODING
This attribute is variable-length string that indicates the filename encoding
used by the filesystem.  The default is "utf8".  Note that this may indicate a
non-8-bit encoding if that's what the underlying filesystem actually supports.

.\" __________________ FSINFO_ATTR_NAME_CODEPAGE __________________
.TP
.B FSINFO_ATTR_NAME_CODEPAGE
This attribute is variable-length string that indicates the codepage used to
translate filenames from the filesystem to the system if this is applicable to
the filesystem.

.\" __________________ FSINFO_ATTR_IO_SIZE __________________
.TP
.B FSINFO_ATTR_IO_SIZE
This retrieves information about the I/O sizes supported by the filesystem.
The following structure is filled in:
.PP
.RS
.in +4n
.nf
struct fsinfo_io_size {
    __u32 dio_size_gran;
    __u32 dio_mem_align;
};
.fi
.in
.RE
.IP
Where
.I dio_size_gran
indicate the fundamental I/O block size that the size of O_DIRECT read/write
calls must be a multiple of and
.I dio_mem_align
indicates the memory alignment requirements of the data buffer in any O_DIRECT
read/write call.
.IP
Note that any of these may be zero if inapplicable or indeterminable.

.\" __________________ FSINFO_ATTR_PARAM_DESCRIPTION __________________
.TP
.B FSINFO_ATTR_PARAM_DESCRIPTION
This retrieves basic information about the superblock configuration parameters
used by the filesystem.  The value returned is of the following type:
.PP
.RS
.in +4n
.nf
struct fsinfo_param_description {
    __u32 nr_params;		/* Number of individual parameters */
    __u32 nr_names;		/* Number of parameter names */
    __u32 nr_enum_names;		/* Number of enum names  */
};
.fi
.in
.RE
.IP
Where
.I nr_params indicates the number of described parameters (it's possible for
the configuration to take more than this - cgroup-v1 for example);
.I nr_names
indicates the number of parameter names that there are defined (nr_names can be
more than nr_params if there are synonyms); and
.I nr_enum_names
indicates the number of enum value names that there are defined.

.\" __________________ FSINFO_ATTR_PARAM_SPECIFICATION __________________
.TP
.B FSINFO_ATTR_PARAM_SPECIFICATION
This retrieves information about the Nth superblock configuration parameter
available in the filesystem.  This is enumerated by incrementing
.I params->Nth
each time.  Each value is a structure of the following type:
.PP
.RS
.in +4n
.nf
struct fsinfo_param_specification {
	__u32		type;
	__u32		flags;
};
.fi
.in
.RE
.IP
Where
.I type
indicates the type of value by way of one of the following constants:
.PP
.RS
.in +4n
.nf
  FSINFO_PARAM_SPEC_NOT_DEFINED
  FSINFO_PARAM_SPEC_TAKES_NO_VALUE
  FSINFO_PARAM_SPEC_IS_BOOL
  FSINFO_PARAM_SPEC_IS_U32
  FSINFO_PARAM_SPEC_IS_U32_OCTAL
  FSINFO_PARAM_SPEC_IS_U32_HEX
  FSINFO_PARAM_SPEC_IS_S32
  FSINFO_PARAM_SPEC_IS_ENUM
  FSINFO_PARAM_SPEC_IS_STRING
  FSINFO_PARAM_SPEC_IS_BLOB
  FSINFO_PARAM_SPEC_IS_BLOCKDEV
  FSINFO_PARAM_SPEC_IS_PATH
  FSINFO_PARAM_SPEC_IS_FD
.fi
.in
.RE
.IP
depending on whether the kernel (incorrectly) didn't define the type, the
parameter takes no value, or takes a bool, one of a number of integers, a named
enum value, a string, a binary blob, a blockdev, an arbitrary path or a file
descriptor.
.PP
.I flags
qualifies the form of the value accepted:
.PP
.RS
.in +4n
.nf
  FSINFO_PARAM_SPEC_VALUE_IS_OPTIONAL
  FSINFO_PARAM_SPEC_PREFIX_NO_IS_NEG
  FSINFO_PARAM_SPEC_EMPTY_STRING_IS_NEG
  FSINFO_PARAM_SPEC_DEPRECATED
.fi
.in
.RE
.IP
These indicate whether the value is optional, the parameter can be made
negative by prefixing with 'no' or giving it an empty value or whether the
parameter is deprecated and a warning issued if it used.

.\" __________________ FSINFO_ATTR_PARAM_NAME __________________
.TP
.B FSINFO_ATTR_PARAM_NAME
This retrieves information about the Nth superblock configuration parameter
available in the filesystem.  This is enumerated by incrementing
.I params->Nth
each time.  Each value is a structure of the following type:
.PP
.RS
.in +4n
.nf
struct fsinfo_param_name {
	__u32		param_index;
	char		name[252];
};
.fi
.in
.RE
.IP
Where
.I param_index
is refers to the Nth parameter returned by FSINFO_ATTR_PARAM_SPECIFICATION and
.I name
is a name string that maps to the specified parameter.

.\" __________________ FSINFO_ATTR_PARAM_ENUMs __________________
.TP
.B FSINFO_ATTR_PARAM_ENUM
This can be used to list all the enum value symbols available for all the
configuration parameters available in the filesystem.  This is enumerated by
incrementing
.I params->Nth
each time.  Each value is a structure of the following type:
.PP
.RS
.in +4n
.nf
struct fsinfo_param_enum {
	__u32		param_index;	/* Index of the relevant parameter specification */
	char		name[252];	/* Name of the enum value */
};
.fi
.in
.RE
.IP
Where
.I param_index
indicates the enumeration-type parameter to which this value corresponds and
.I name
is the symbolic name.  Note that all the enum values from all the enum
parameters are in one list together


.SH THE CAPABILITIES
.PP
There are number of capability bits in a bit array that can be retrieved using
.BR fsinfo_attr_capabilities .
These give information about features of the filesystem driver and the specific
filesystem.

.\" __________________ FSINFO_CAP_IS_*_FS __________________
.PP
.B FSINFO_CAP_IS_KERNEL_FS
.br
.B FSINFO_CAP_IS_BLOCK_FS
.br
.B FSINFO_CAP_IS_FLASH_FS
.br
.B FSINFO_CAP_IS_NETWORK_FS
.br
.B FSINFO_CAP_IS_AUTOMOUNTER_FS
.IP
These indicate the primary type of the filesystem.
.B kernel
filesystems are special communication interfaces that substitute files for
system calls; examples include procfs and sysfs.
.B block
filesystems require a block device on which to operate; examples include ext4
and XFS.
.B flash
filesystems require an MTD device on which to operate; examples include JFFS2.
.B network
filesystems require access to the network and contact one or more servers;
examples include NFS and AFS.
.B automounter
filesystems are kernel special filesystems that host automount points and
triggers to dynamically create automount points.  Examples include autofs and
AFS's dynamic root.

.\" __________________ FSINFO_CAP_AUTOMOUNTS __________________
.TP
.B FSINFO_CAP_AUTOMOUNTS
The filesystem may have automount points that can be triggered by pathwalk.

.\" __________________ FSINFO_CAP_ADV_LOCKS __________________
.TP
.B FSINFO_CAP_ADV_LOCKS
The filesystem supports advisory file locks.  For a network filesystem, this
indicates that the advisory file locks are cross-client (and also between
server and its local filesystem on something like NFS).

.\" __________________ FSINFO_CAP_MAND_LOCKS __________________
.TP
.B FSINFO_CAP_MAND_LOCKS
The filesystem supports mandatory file locks.  For a network filesystem, this
indicates that the mandatory file locks are cross-client (and also between
server and its local filesystem on something like NFS).

.\" __________________ FSINFO_CAP_LEASES __________________
.TP
.B FSINFO_CAP_LEASES
The filesystem supports leases.  For a network filesystem, this means that the
server will tell the client to clean up its state on a file before passing the
lease to another client.

.\" __________________ FSINFO_CAP_*IDS __________________
.PP
.B FSINFO_CAP_UIDS
.br
.B FSINFO_CAP_GIDS
.br
.B FSINFO_CAP_PROJIDS
.IP
These indicate that the filesystem supports numeric user IDs, group IDs and
project IDs respectively.

.\" __________________ FSINFO_CAP_ID_* __________________
.PP
.B FSINFO_CAP_ID_NAMES
.br
.B FSINFO_CAP_ID_GUIDS
.IP
These indicate that the filesystem employs textual names and/or GUIDs as
identifiers.

.\" __________________ FSINFO_CAP_WINDOWS_ATTRS __________________
.TP
.B FSINFO_CAP_WINDOWS_ATTRS
Indicates that the filesystem supports some Windows FILE_* attributes.

.\" __________________ FSINFO_CAP_*_QUOTAS __________________
.PP
.B FSINFO_CAP_USER_QUOTAS
.br
.B FSINFO_CAP_GROUP_QUOTAS
.br
.B FSINFO_CAP_PROJECT_QUOTAS
.IP
These indicate that the filesystem supports quotas for users, groups and
projects respectively.

.\" __________________ FSINFO_CAP_XATTRS/FILETYPES __________________
.PP
.B FSINFO_CAP_XATTRS
.br
.B FSINFO_CAP_SYMLINKS
.br
.B FSINFO_CAP_HARD_LINKS
.br
.B FSINFO_CAP_HARD_LINKS_1DIR
.br
.B FSINFO_CAP_DEVICE_FILES
.br
.B FSINFO_CAP_UNIX_SPECIALS
.IP
These indicate that the filesystem supports respectively extended attributes;
symbolic links; hard links spanning direcories; hard links, but only within a
directory; block and character device files; and UNIX special files, such as
FIFO and socket.

.\" __________________ FSINFO_CAP_*JOURNAL* __________________
.PP
.B FSINFO_CAP_JOURNAL
.br
.B FSINFO_CAP_DATA_IS_JOURNALLED
.IP
The first of these indicates that the filesystem has a journal and the second
that the file data changes are being journalled.

.\" __________________ FSINFO_CAP_O_* __________________
.PP
.B FSINFO_CAP_O_SYNC
.br
.B FSINFO_CAP_O_DIRECT
.IP
These indicate that O_SYNC and O_DIRECT are supported respectively.

.\" __________________ FSINFO_CAP_* for names __________________
.PP
.B FSINFO_CAP_VOLUME_ID
.br
.B FSINFO_CAP_VOLUME_UUID
.br
.B FSINFO_CAP_VOLUME_NAME
.br
.B FSINFO_CAP_VOLUME_FSID
.br
.B FSINFO_CAP_CELL_NAME
.br
.B FSINFO_CAP_DOMAIN_NAME
.br
.B FSINFO_CAP_REALM_NAME
.IP
These indicate if various attributes are supported by the filesystem, where
.B FSINFO_CAP_X
here corresponds to
.BR fsinfo_attr_X .

.\" __________________ FSINFO_CAP_IVER_* __________________
.PP
.B FSINFO_CAP_IVER_ALL_CHANGE
.br
.B FSINFO_CAP_IVER_DATA_CHANGE
.br
.B FSINFO_CAP_IVER_MONO_INCR
.IP
These indicate if
.I i_version
on an inode in the filesystem is supported and
how it behaves.
.B all_change
indicates that i_version is incremented on metadata changes as well as data
changes.
.B data_change
indicates that i_version is only incremented on data changes, including
truncation.
.B mono_incr
indicates that i_version is incremented by exactly 1 for each change made.

.\" __________________ FSINFO_CAP_RESOURCE_FORKS __________________
.TP
.B FSINFO_CAP_RESOURCE_FORKS
This indicates that the filesystem supports some sort of resource fork or
alternate data stream on a file.  This isn't the same as an extended attribute.

.\" __________________ FSINFO_CAP_NAME_* __________________
.PP
.B FSINFO_CAP_NAME_CASE_INDEP
.br
.B FSINFO_CAP_NAME_NON_UTF8
.br
.B FSINFO_CAP_NAME_HAS_CODEPAGE
.IP
These indicate certain facts about the filenames in a filesystem: whether
they're case-independent; if they're not UTF-8; and if there's a codepage
employed to map the names.

.\" __________________ FSINFO_CAP_SPARSE __________________
.TP
.B FSINFO_CAP_SPARSE
This indicates that the filesystem supports sparse files.

.\" __________________ FSINFO_CAP_NOT_PERSISTENT __________________
.TP
.B FSINFO_CAP_NOT_PERSISTENT
This indicates that the filesystem is not persistent, and that any data stored
here will not be saved in the event that the filesystem is unmounted, the
machine is rebooted or the machine loses power.

.\" __________________ FSINFO_CAP_NO_UNIX_MODE __________________
.TP
.B FSINFO_CAP_NO_UNIX_MODE
This indicates that the filesystem doesn't support the UNIX mode permissions
bits.

.\" __________________ FSINFO_CAP_HAS_*TIME __________________
.PP
.B FSINFO_CAP_HAS_ATIME
.br
.B FSINFO_CAP_HAS_BTIME
.br
.B FSINFO_CAP_HAS_CTIME
.br
.B FSINFO_CAP_HAS_MTIME
.IP
These indicate as to what timestamps a filesystem supports, including: Access
time, Birth/creation time, Change time (metadata and data) and Modification
time (data only).


.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
.SH RETURN VALUE
On success, the size of the value that the kernel has available is returned,
irrespective of whether the buffer is large enough to hold that.  The data
written to the buffer will be truncated if it is not.  On error, \-1 is
returned, and
.I errno
is set appropriately.
.SH ERRORS
.TP
.B EACCES
Search permission is denied for one of the directories
in the path prefix of
.IR pathname .
(See also
.BR path_resolution (7).)
.TP
.B EBADF
.I dirfd
is not a valid open file descriptor.
.TP
.B EFAULT
.I pathname
is NULL or
.IR pathname ", " params " or " buffer
point to a location outside the process's accessible address space.
.TP
.B EINVAL
Reserved flag specified in
.IR params->at_flags " or one of " params->__reserved[]
is not 0.
.TP
.B EOPNOTSUPP
Unsupported attribute requested in
.IR params->request .
This may be beyond the limit of the supported attribute set or may just not be
one that's supported by the filesystem.
.TP
.B ENODATA
Unavailable attribute value requested by
.IR params->Nth " and/or " params->Mth .
.TP
.B ELOOP
Too many symbolic links encountered while traversing the pathname.
.TP
.B ENAMETOOLONG
.I pathname
is too long.
.TP
.B ENOENT
A component of
.I pathname
does not exist, or
.I pathname
is an empty string and
.B AT_EMPTY_PATH
was not specified in
.IR params->at_flags .
.TP
.B ENOMEM
Out of memory (i.e., kernel memory).
.TP
.B ENOTDIR
A component of the path prefix of
.I pathname
is not a directory or
.I pathname
is relative and
.I dirfd
is a file descriptor referring to a file other than a directory.
.SH VERSIONS
.BR fsinfo ()
was added to Linux in kernel 4.18.
.SH CONFORMING TO
.BR fsinfo ()
is Linux-specific.
.SH NOTES
Glibc does not (yet) provide a wrapper for the
.BR fsinfo ()
system call; call it using
.BR syscall (2).
.SH SEE ALSO
.BR ioctl_iflags (2),
.BR statx (2),
.BR statfs (2)
