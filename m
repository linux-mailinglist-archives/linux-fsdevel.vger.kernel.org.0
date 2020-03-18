Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD5E189F3F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Mar 2020 16:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbgCRPJq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Mar 2020 11:09:46 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:48428 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727485AbgCRPJp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Mar 2020 11:09:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584544183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cHjdaPY3CTdvavpLf9eqPojLgzmU79twa6/z0m8u+Vs=;
        b=ff/dVONzTOgLRgDPApu+Q4a9KHNffLwH6mFbLuOaTGFXXeJGSRFrrO4txvbtSyxkO9T6l+
        N2+sQeuGsW+82KNaUl2VAXqL1kPY9UNr1aHZGdmCkNfTrMhl01bceTX2U1K1emTSVkcpXl
        iDRC4mwUO5GYgLWAgBK+KEshv0j7Kaw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-C01kmDnDOueCztahsWBFxQ-1; Wed, 18 Mar 2020 11:09:42 -0400
X-MC-Unique: C01kmDnDOueCztahsWBFxQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04F4B1857BE1;
        Wed, 18 Mar 2020 15:09:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-126.rdu2.redhat.com [10.10.113.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5502460C63;
        Wed, 18 Mar 2020 15:09:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 10/13] fsinfo: Add API documentation [ver #19]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, jannh@google.com, darrick.wong@oracle.com,
        kzak@redhat.com, jlayton@redhat.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 18 Mar 2020 15:09:36 +0000
Message-ID: <158454417657.2864823.15374180881348424478.stgit@warthog.procyon.org.uk>
In-Reply-To: <158454408854.2864823.5910520544515668590.stgit@warthog.procyon.org.uk>
References: <158454408854.2864823.5910520544515668590.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add API documentation for fsinfo.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 Documentation/filesystems/fsinfo.rst |  574 ++++++++++++++++++++++++++++=
++++++
 1 file changed, 574 insertions(+)
 create mode 100644 Documentation/filesystems/fsinfo.rst

diff --git a/Documentation/filesystems/fsinfo.rst b/Documentation/filesys=
tems/fsinfo.rst
new file mode 100644
index 000000000000..65d88e5a36bc
--- /dev/null
+++ b/Documentation/filesystems/fsinfo.rst
@@ -0,0 +1,574 @@
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
+Filesystem Information Query
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
+
+The fsinfo() system call allows the querying of filesystem and filesyste=
m
+security information beyond what stat(), statx() and statfs() can obtain=
.  It
+does not require a file to be opened as does ioctl().
+
+fsinfo() may be called with a path, with open file descriptor or a with =
a mount
+object identifier.
+
+The fsinfo() system call needs to be configured on by enabling:
+
+	"File systems"/"Enable the fsinfo() system call" (CONFIG_FSINFO)
+
+This document has the following sections:
+
+.. contents:: :local:
+
+
+Overview
+=3D=3D=3D=3D=3D=3D=3D=3D
+
+The fsinfo() system call retrieves one of a number of attributes, the ID=
s of
+which can be found in include/uapi/linux/fsinfo.h::
+
+	FSINFO_ATTR_STATFS	- statfs()-style state
+	FSINFO_ATTR_IDS		- Filesystem IDs
+	FSINFO_ATTR_LIMITS	- Filesystem limits
+	...
+	FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO - Information about an attribute
+	FSINFO_ATTR_FSINFO_ATTRIBUTES - List of available attributes
+	...
+	FSINFO_ATTR_MOUNT_INFO	- Information about the mount topology
+	...
+
+Each attribute can have zero or more values, which can be of one of the
+following types:
+
+ * ``FSINFO_TYPE_VSTRUCT``.  This is a structure with a version-dependen=
t
+   length.  New versions of the kernel may append more fields, though th=
ey are
+   not permitted to remove or replace old ones.
+
+   Older applications, expecting an older version of the field, can ask =
for a
+   shorter struct and will only get the fields they requested; newer
+   applications running on an older kernel will get the extra fields the=
y
+   requested filled with zeros.  Either way, the system call returns the=
 size
+   of the internal struct, regardless of how much data it returned.
+
+   This allows for struct-type fields to be extended in future.
+
+ * ``FSINFO_TYPE_STRING``.  This is a variable-length string of up to IN=
T_MAX
+   characters (no NUL character is included).  The returned string will =
be
+   truncated if the output buffer is too small.  The total size of the s=
tring
+   is returned, regardless of any truncation.
+
+ * ``FSINFO_TYPE_OPAQUE``.  This is a variable-length blob of indetermin=
ate
+   structure.  It may be up to INT_MAX bytes in size.
+
+ * ``FSINFO_TYPE_LIST``.  This is a variable-length list of fixed-size
+   structures.  The element size may not vary over time, so the element =
format
+   must be designed with care.  The maximum length is INT_MAX bytes, tho=
ugh
+   this depends on the kernel being able to allocate an internal buffer =
large
+   enough.
+
+Value type is an inherent propery of an attribute and all the values of =
an
+attribute must be of that type.  Each attribute can have a single value,=
 a
+sequence of values or a sequence-of-sequences of values.
+
+
+Filesystem API
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+If the filesystem wishes to override the generic queryable attributes or
+provide queryable attributes of its own, it should define a handler func=
tion
+and point the appropriate superblock op to it::
+
+	int (*fsinfo)(struct path *path, struct fsinfo_context *ctx);
+
+The core calls this function to see if it wants to handle the attribute.=
  For
+each table of attibutes it has (and it can have more than one), it shoul=
d
+call::
+
+	int fsinfo_get_attribute(struct path *path, struct fsinfo_context *ctx,
+				 const struct fsinfo_attribute *attrs);
+
+to scan the table to see if the requested one is in there.  This functio=
n also
+handles determining the size of struct attributes, enumerating attribute=
s for
+the FSINFO_ATTR_FSINFO_ATTRIBUTES and querying information about an attr=
ibute
+for FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO.
+
+If it doesn't want to handle the function, -EOPNOTSUPP should be returne=
d.  The
+core will then examine the generic attribute table.
+
+
+Attribute Table
+---------------
+
+An attribute table is a sequence of ``struct fsinfo_attribute`` terminat=
ed with
+a blank entry.  Entries can be created with a set of helper macros::
+
+	FSINFO_VSTRUCT(A,G)
+	FSINFO_VSTRUCT_N(A,G)
+	FSINFO_VSTRUCT_NM(A,G)
+	FSINFO_STRING(A,G)
+	FSINFO_STRING_N(A,G)
+	FSINFO_STRING_NM(A,G)
+	FSINFO_OPAQUE(A,G)
+	FSINFO_LIST(A,G)
+	FSINFO_LIST_N(A,G)
+
+The names of the macro are a combination of type (vstruct, string, opaqu=
e and
+list) and an optional qualifier, if the attribute has N values or N lots=
 of M
+values.  ``A`` is the name of the attribute and ``G`` is a function to g=
et a
+value for that attribute.
+
+For vstruct- and list-type attributes, it is expected that there is a ma=
cro
+defined with the name ``A##__STRUCT`` that indicates the structure type.
+
+The get function needs to match the following type::
+
+	int (*get)(struct path *path, struct fsinfo_context *ctx);
+
+where "path" indicates the object to be queried and ctx is a context des=
cribing
+the parameters and the output buffer.  The function should return the to=
tal
+size of the data it would like to produce or an error.
+
+
+Context Structure
+-----------------
+
+The context struct looks like::
+
+	struct fsinfo_context {
+		__u32		requested_attr;
+		__u32		Nth;
+		__u32		Mth;
+		bool		want_size_only;
+		unsigned int	skip;
+		unsigned int	usage;
+		unsigned int	buf_size;
+		void		*buffer;
+		...
+	};
+
+The fields relevant to the filesystem are as follows:
+
+ * ``requested_attr``
+
+   Which attribute is being requested.  EOPNOTSUPP should be returned if=
 the
+   attribute is not supported by the filesystem or the LSM.
+
+ * ``Nth`` and ``Mth``
+
+   Which value of an attribute is being requested.
+
+   For a single-value attribute Nth and Mth will both be 0.
+
+   For a "1D" attribute, Nth will indicate which value and Mth will alwa=
ys
+   be 0.  Take, for example, FSINFO_ATTR_SERVER_NAME - for a network
+   filesystem, the superblock will be backed by a number of servers.  Th=
is will
+   return the name of the Nth server.  ENODATA will be returned if Nth g=
oes
+   beyond the end of the array.
+
+   For a "2D" attribute, Mth will indicate the index in the Nth set of v=
alues.
+   Take, for example, an attribute for a network filesystems that return=
s
+   server addresses - each server may have one or more addresses.  This =
could
+   return the Mth address of the Nth server.  ENODATA should be returned=
 if the
+   Nth set doesn't exist or the Mth element of the Nth set doesn't exist=
.
+
+ * ``want_size_only``
+
+   Is set to true if the caller only wants the size of the value so that=
 the
+   get function doesn't have to make expensive calculations or calls to
+   retrieve the value.
+
+ * ``skip``
+
+   This indicates how far into the buffer the data to be returned starts=
.  This
+   can be used to trim the front off the buffer or to handle backward-fi=
lling.
+
+ * ``usage``
+
+   This indicates how much of the buffer has been used so far for an lis=
t or
+   opaque type attribute.  This is updated by the fsinfo_note_param*()
+   functions.
+
+ * ``buf_size``
+
+   This indicates the current size of the buffer.  For the list type and=
 the
+   opaque type this will be increased if the current buffer won't hold t=
he
+   value and the filesystem will be called again.
+
+ * ``buffer``
+
+   This points to the output buffer.  It will be buf_size in size and wi=
ll be
+   resized if the returned size is larger than this.
+
+To simplify filesystem code, there will always be at least a minimal buf=
fer
+available if a ->get() method gets called.
+
+
+Helper Functions
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The API includes a number of helper functions:
+
+ * ``int fsinfo_string(const char *s, struct fsinfo_context *ctx);``
+
+   This places the specified string into the buffer set in the context. =
 If the
+   string is NULL, the buffer will be left empty.
+
+ * ``int fsinfo_generic_timestamp_info(struct path *, struct fsinfo_cont=
ext *);``
+ * ``int fsinfo_generic_supports(struct path *, struct fsinfo_context *)=
;``
+ * ``int fsinfo_generic_limits(struct path *, struct fsinfo_context *);`=
`
+
+   These set the generic information for timestamp resolution and range
+   information, supported features and number limits and are called for =
the
+   corresponding attributes if the filesystem doesn't override them.
+
+   If the filesystem does override them, it can call the above functions=
 and
+   then amend the results.
+
+ * ``void fsinfo_set_feature(struct fsinfo_features *ft,
+			     enum fsinfo_feature feature);``
+
+   This function sets a feature flag.
+
+ * ``void fsinfo_clear_feature(struct fsinfo_features *ft,
+			       enum fsinfo_feature feature);``
+
+   This function clears a feature flag.
+
+ * ``void fsinfo_set_unix_features(struct fsinfo_features *ft);``
+
+   Set feature flags appropriate to the features of a standard UNIX file=
system,
+   such as having numeric UIDS and GIDS; allowing the creation of direct=
ories,
+   symbolic links, hard links, device files, FIFO and socket files; perm=
itting
+   sparse files; and having access, change and modification times.
+
+
+Attribute Summary
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+To summarise the attributes that are defined::
+
+  Symbolic name				Type
+  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
+  FSINFO_ATTR_STATFS			vstruct
+  FSINFO_ATTR_IDS			vstruct
+  FSINFO_ATTR_LIMITS			vstruct
+  FSINFO_ATTR_SUPPORTS			vstruct
+  FSINFO_ATTR_TIMESTAMP_INFO		vstruct
+  FSINFO_ATTR_VOLUME_ID			string
+  FSINFO_ATTR_VOLUME_UUID		vstruct
+  FSINFO_ATTR_VOLUME_NAME		string
+  FSINFO_ATTR_FEATURES			vstruct
+  FSINFO_ATTR_SOURCE			string
+  FSINFO_ATTR_CONFIGURATION		string
+  FSINFO_ATTR_FS_STATISTICS		string
+  FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO	N =C3=97 vstruct
+  FSINFO_ATTR_FSINFO_ATTRIBUTES		list
+  FSINFO_ATTR_MOUNT_INFO		vstruct
+  FSINFO_ATTR_MOUNT_PATH		string
+  FSINFO_ATTR_MOUNT_POINT		string
+  FSINFO_ATTR_MOUNT_CHILDREN		list
+  FSINFO_ATTR_AFS_CELL_NAME		string
+  FSINFO_ATTR_AFS_SERVER_NAME		N =C3=97 string
+  FSINFO_ATTR_AFS_SERVER_ADDRESSES	N =C3=97 list
+
+
+Attribute Catalogue
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+A number of the attributes convey information about a filesystem superbl=
ock:
+
+ *  ``FSINFO_ATTR_STATFS``
+
+    This struct-type attribute gives most of the equivalent data to stat=
fs(),
+    but with all the fields as unconditional 64-bit or 128-bit integers.=
  Note
+    that static data like IDs that don't change are retrieved with
+    FSINFO_ATTR_IDS instead.
+
+    Further, superblock flags (such as MS_RDONLY) are not exposed by thi=
s
+    attribute; rather the parameters must be listed and the attributes p=
icked
+    out from that.
+
+ *  ``FSINFO_ATTR_IDS``
+
+    This struct-type attribute conveys various identifiers used by the t=
arget
+    filesystem.  This includes the filesystem name, the NFS filesystem I=
D, the
+    superblock ID used in notifications, the filesystem magic type numbe=
r and
+    the primary device ID.
+
+ *  ``FSINFO_ATTR_LIMITS``
+
+    This struct-type attribute conveys the limits on various aspects of =
a
+    filesystem, such as maximum file, symlink and xattr sizes, maxiumm f=
ilename
+    and xattr name length, maximum number of symlinks, maximum device ma=
jor and
+    minor numbers and maximum UID, GID and project ID numbers.
+
+ *  ``FSINFO_ATTR_SUPPORTS``
+
+    This struct-type attribute conveys information about the support the
+    filesystem has for various UAPI features of a filesystem.  This incl=
udes
+    information about which bits are supported in various masks employed=
 by the
+    statx system call, what FS_IOC_* flags are supported by ioctls and w=
hat
+    DOS/Windows file attribute flags are supported.
+
+ *  ``FSINFO_ATTR_TIMESTAMP_INFO``
+
+    This struct-type attribute conveys information about the resolution =
and
+    range of the timestamps available in a filesystem.  The resolutions =
are
+    given as a mantissa and exponent (resolution =3D mantissa * 10^expon=
ent
+    seconds), where the exponent can be negative to indicate a sub-secon=
d
+    resolution (-9 being nanoseconds, for example).
+
+ *  ``FSINFO_ATTR_VOLUME_ID``
+
+    This is a string-type attribute that conveys the superblock identifi=
er for
+    the volume.  By default it will be filled in from the contents of s_=
id from
+    the superblock.  For a block-based filesystem, for example, this mig=
ht be
+    the name of the primary block device.
+
+ *  ``FSINFO_ATTR_VOLUME_UUID``
+
+    This is a struct-type attribute that conveys the UUID identifier for=
 the
+    volume.  By default it will be filled in from the contents of s_uuid=
 from
+    the superblock.  If this doesn't exist, it will be an entirely zeros=
.
+
+ *  ``FSINFO_ATTR_VOLUME_NAME``
+
+    This is a string-type attribute that conveys the name of the volume.=
  By
+    default it will return EOPNOTSUPP.  For a disk-based filesystem, it =
might
+    convey the partition label; for a network-based filesystem, it might=
 convey
+    the name of the remote volume.
+
+ *  ``FSINFO_ATTR_FEATURES``
+
+    This is a special attribute, being a set of single-bit feature flags=
,
+    formatted as struct-type attribute.  The meanings of the feature bit=
s are
+    listed below - see the "Feature Bit Catalogue" section.  The feature=
 bits
+    are grouped numerically into bytes, such that features 0-7 are in by=
te 0,
+    8-15 are in byte 1, 16-23 in byte 2 and so on.
+
+    Any feature bit that's not supported by the kernel will be set to fa=
lse if
+    asked for.  The highest supported feature is set at the beginning of=
 the
+    structure.
+
+ *  ``FSINFO_ATTR_SOURCE``
+ *  ``FSINFO_ATTR_CONFIGURATION``
+ *  ``FSINFO_ATTR_FS_STATISTICS``
+
+    These attributes return the mountpoint device name (as processed by =
the
+    filesystem), the superblock configuration (mount) options and the
+    superblock statistics in string form, as presented through a variety
+    of /proc files.
+
+
+Some attributes give information about fsinfo itself:
+
+ *  ``FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO``
+
+    This struct-type attribute gives metadata about the attribute with t=
he ID
+    specified by the Nth parameter, including its type, default size and
+    element size.
+
+ *  ``FSINFO_ATTR_FSINFO_ATTRIBUTES``
+
+    This list-type attribute gives a list of the attribute IDs available=
 at the
+    point of reference.  FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO can then be u=
sed to
+    query each attribute.
+
+
+Some attributes give information about mount objects:
+
+ *  ``FSINFO_ATTR_MOUNT_INFO``
+
+    This gives information about a particular mount object, including it=
s IDs,
+    its attributes and its event counters.
+
+ *  ``FSINFO_ATTR_MOUNT_TOPOLOGY``
+
+    This gives information about a mount object's topological relationsh=
ips and
+    propagation attributes.  This is more expensive inside the kernel th=
an
+    MOUNT_INFO due to the locking requirements, but the mount object's t=
opology
+    change counter can be used to work out if it has changed.
+
+    This does not give a list of the children; use FSINFO_ATTR_MOUNT_CHI=
LDREN
+    for that.
+
+ *  ``FSINFO_ATTR_MOUNT_PATH``
+
+    This gives information about the path set by binding a mount, though=
 it may
+    be overridden by the filesystem.
+
+ *  ``FSINFO_ATTR_MOUNT_POINT``
+ *  ``FSINFO_ATTR_MOUNT_POINT_FULL``
+
+    These give the path to the mount point for a mount object, in the fo=
rmer
+    relative to its parent mount's mount point (limited to chroot) and i=
n the
+    latter as a full path from the chroot.
+
+ *  ``FSINFO_ATTR_MOUNT_CHILDREN``
+
+    This gives a list of all the child mounts of the queried mount.  Thi=
s is
+    presented as tuples of { mount ID, mount uniquifier, event counter s=
um }
+    and includes at the end a tuple representing the queried mount.
+
+
+Finally there are filesystem-specific attributes, e.g.:
+
+ *  ``FSINFO_ATTR_AFS_CELL_NAME``
+
+    This is a string-type attribute that retrieves the AFS cell name of =
the
+    target object.
+
+ *  ``FSINFO_ATTR_AFS_SERVER_NAME``
+
+    This is a string-type attribute that conveys the name of the Nth ser=
ver
+    backing a network-filesystem superblock.
+
+ *  ``FSINFO_ATTR_AFS_SERVER_ADDRESSES``
+
+    This is a list-type attribute that conveys the addresses of the Nth =
server,
+    corresponding to the Nth server returned by FSINFO_ATTR_SERVER_NAME.
+
+
+Feature Bit Catalogue
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The feature bits convey single true/false assertions about a specific in=
stance
+of a filesystem (ie. a specific superblock).  They are accessed using th=
e
+"FSINFO_ATTR_FEATURE" attribute:
+
+ *  ``FSINFO_FEAT_IS_KERNEL_FS``
+ *  ``FSINFO_FEAT_IS_BLOCK_FS``
+ *  ``FSINFO_FEAT_IS_FLASH_FS``
+ *  ``FSINFO_FEAT_IS_NETWORK_FS``
+ *  ``FSINFO_FEAT_IS_AUTOMOUNTER_FS``
+ *  ``FSINFO_FEAT_IS_MEMORY_FS``
+
+    These indicate what kind of filesystem the target is: kernel API (pr=
oc),
+    block-based (ext4), flash/nvm-based (jffs2), remote over the network=
 (NFS),
+    local quasi-filesystem that acts as a tray of mountpoints (autofs), =
plain
+    in-memory filesystem (shmem).
+
+ *  ``FSINFO_FEAT_AUTOMOUNTS``
+
+    This indicate if a filesystem may have objects that are automount po=
ints.
+
+ *  ``FSINFO_FEAT_ADV_LOCKS``
+ *  ``FSINFO_FEAT_MAND_LOCKS``
+ *  ``FSINFO_FEAT_LEASES``
+
+    These indicate if a filesystem supports advisory locks, mandatory lo=
cks or
+    leases.
+
+ *  ``FSINFO_FEAT_UIDS``
+ *  ``FSINFO_FEAT_GIDS``
+ *  ``FSINFO_FEAT_PROJIDS``
+
+    These indicate if a filesystem supports/stores/transports numeric us=
er IDs,
+    group IDs or project IDs.  The "FSINFO_ATTR_LIMITS" attribute can be=
 used
+    to find out the upper limits on the IDs values.
+
+ *  ``FSINFO_FEAT_STRING_USER_IDS``
+
+    This indicates if a filesystem supports/stores/transports string use=
r
+    identifiers.
+
+ *  ``FSINFO_FEAT_GUID_USER_IDS``
+
+    This indicates if a filesystem supports/stores/transports Windows GU=
IDs as
+    user identifiers (eg. ntfs).
+
+ *  ``FSINFO_FEAT_WINDOWS_ATTRS``
+
+    This indicates if a filesystem supports Windows FILE_* attribute bit=
s
+    (eg. cifs, jfs).  The "FSINFO_ATTR_SUPPORTS" attribute can be used t=
o find
+    out which windows file attributes are supported by the filesystem.
+
+ *  ``FSINFO_FEAT_USER_QUOTAS``
+ *  ``FSINFO_FEAT_GROUP_QUOTAS``
+ *  ``FSINFO_FEAT_PROJECT_QUOTAS``
+
+    These indicate if a filesystem supports quotas for users, groups or
+    projects.
+
+ *  ``FSINFO_FEAT_XATTRS``
+
+    These indicate if a filesystem supports extended attributes.  The
+    "FSINFO_ATTR_LIMITS" attribute can be used to find out the upper lim=
its on
+    the supported name and body lengths.
+
+ *  ``FSINFO_FEAT_JOURNAL``
+ *  ``FSINFO_FEAT_DATA_IS_JOURNALLED``
+
+    These indicate whether the filesystem has a journal and whether data
+    changes are logged to it.
+
+ *  ``FSINFO_FEAT_O_SYNC``
+ *  ``FSINFO_FEAT_O_DIRECT``
+
+    These indicate whether the filesystem supports the O_SYNC and O_DIRE=
CT
+    flags.
+
+ *  ``FSINFO_FEAT_VOLUME_ID``
+ *  ``FSINFO_FEAT_VOLUME_UUID``
+ *  ``FSINFO_FEAT_VOLUME_NAME``
+ *  ``FSINFO_FEAT_VOLUME_FSID``
+
+    These indicate whether ID, UUID, name and FSID identifiers actually =
exist
+    in the filesystem and thus might be considered persistent.
+
+ *  ``FSINFO_FEAT_IVER_ALL_CHANGE``
+ *  ``FSINFO_FEAT_IVER_DATA_CHANGE``
+ *  ``FSINFO_FEAT_IVER_MONO_INCR``
+
+    These indicate whether i_version in the inode is supported and, if s=
o, what
+    mode it operates in.  The first two indicate if it's changed for any=
 data
+    or metadata change, or whether it's only changed for any data change=
s; the
+    last indicates whether or not it's monotonically increasing for each=
 such
+    change.
+
+ *  ``FSINFO_FEAT_HARD_LINKS``
+ *  ``FSINFO_FEAT_HARD_LINKS_1DIR``
+
+    These indicate whether the filesystem can have hard links made in it=
, and
+    whether they can be made between directory or only within the same
+    directory.
+
+ *  ``FSINFO_FEAT_DIRECTORIES``
+ *  ``FSINFO_FEAT_SYMLINKS``
+ *  ``FSINFO_FEAT_DEVICE_FILES``
+ *  ``FSINFO_FEAT_UNIX_SPECIALS``
+
+    These indicate whether directories; symbolic links; device files; or=
 pipes
+    and sockets can be made within the filesystem.
+
+ *  ``FSINFO_FEAT_RESOURCE_FORKS``
+
+    This indicates if the filesystem supports resource forks.
+
+ *  ``FSINFO_FEAT_NAME_CASE_INDEP``
+ *  ``FSINFO_FEAT_NAME_NON_UTF8``
+ *  ``FSINFO_FEAT_NAME_HAS_CODEPAGE``
+
+    These indicate if the filesystem supports case-independent file name=
s,
+    whether the filenames are non-utf8 (see the "FSINFO_ATTR_NAME_ENCODI=
NG"
+    attribute) and whether a codepage is in use to transliterate them (s=
ee
+    the "FSINFO_ATTR_NAME_CODEPAGE" attribute).
+
+ *  ``FSINFO_FEAT_SPARSE``
+
+    This indicates if a filesystem supports sparse files.
+
+ *  ``FSINFO_FEAT_NOT_PERSISTENT``
+
+    This indicates if a filesystem is not persistent.
+
+ *  ``FSINFO_FEAT_NO_UNIX_MODE``
+
+    This indicates if a filesystem doesn't support UNIX mode bits (thoug=
h they
+    may be manufactured from other bits, such as Windows file attribute =
flags).
+
+ *  ``FSINFO_FEAT_HAS_ATIME``
+ *  ``FSINFO_FEAT_HAS_BTIME``
+ *  ``FSINFO_FEAT_HAS_CTIME``
+ *  ``FSINFO_FEAT_HAS_MTIME``
+
+    These indicate which timestamps a filesystem supports (access, birth=
,
+    change, modify).  The range and resolutions can be queried with the
+    "FSINFO_ATTR_TIMESTAMPS" attribute).


