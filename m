Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7F02CA1B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 17:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbfE1POi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 11:14:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60532 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbfE1POh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 11:14:37 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 139EDC05B00A;
        Tue, 28 May 2019 15:14:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-125-65.rdu2.redhat.com [10.10.125.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 68A1BD7A76;
        Tue, 28 May 2019 15:14:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 25/25] fsinfo: Add API documentation [ver #13]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
Date:   Tue, 28 May 2019 16:14:33 +0100
Message-ID: <155905647369.1662.10806818386998503329.stgit@warthog.procyon.org.uk>
In-Reply-To: <155905626142.1662.18430571708534506785.stgit@warthog.procyon.org.uk>
References: <155905626142.1662.18430571708534506785.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 28 May 2019 15:14:37 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


---

 Documentation/filesystems/fsinfo.rst |  571 ++++++++++++++++++++++++++++++++++
 1 file changed, 571 insertions(+)
 create mode 100644 Documentation/filesystems/fsinfo.rst

diff --git a/Documentation/filesystems/fsinfo.rst b/Documentation/filesystems/fsinfo.rst
new file mode 100644
index 000000000000..3e4d64cc04b1
--- /dev/null
+++ b/Documentation/filesystems/fsinfo.rst
@@ -0,0 +1,571 @@
+================================
+Filesystem Information Retrieval
+================================
+
+The fsinfo() system call allows the retrieval of filesystem and filesystem
+security information beyond what stat(), statx() and statfs() can query.  It
+does not require a file to be opened as does ioctl().
+
+fsinfo() may be called on a path, an open file descriptor, a filesystem-context
+file descriptor as allocated by fsopen() or fspick() or a mount ID (allowing
+for mounts concealed by overmounts to be accessed).
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
+========
+
+The fsinfo() system call retrieves one of a number of attributes, specified by
+the "fsinfo_attribute" enumeration::
+
+	FSINFO_ATTR_STATFS	- statfs()-style state
+	FSINFO_ATTR_FSINFO	- Information about fsinfo() itself
+	FSINFO_ATTR_IDS		- Filesystem IDs
+	FSINFO_ATTR_LIMITS	- Filesystem limits
+	...
+
+Each attribute has one of a number of types and, moreover, may have multiple
+values, accessible as a 1D-array or a 2D array-of-arrays.  The attribute types
+are:
+
+ * ``Struct``.  This is a structure with a version-dependent length.  New
+   versions of the kernel may append more fields, though they are not
+   permitted to remove or replace old ones.
+
+   Older applications, expecting an older version of the field, can ask for a
+   shorter struct and will only get the fields they requested; newer
+   applications running on an older kernel will get the extra fields they
+   requested filled with zeros.  Either way, the kernel returns the actual size
+   of the internal struct, regardless of how much data it returned.
+
+   This allows for struct-type fields to be extended in future.
+
+ * ``String``.  This is a variable-length string of up to 4096 characters (no
+   NUL character is included).  The returned string will be truncated if the
+   output buffer is too small.  The total size of the string is returned,
+   regardless of any truncation.
+
+ * ``Array``.  This is a variable-length array of fixed-size structures.  The
+   element size may not vary over time, so the element format must be designed
+   with care.  The maximum length is INT_MAX bytes, though this depends on the
+   kernel being able to allocate an internal buffer large enough.
+
+ * ``Opaque``.  This is a variable-length blob of indeterminate structure.  It
+   may be up to INT_MAX bytes in size.
+
+
+Filesystem API
+==============
+
+The filesystem is called through a superblock_operations method::
+
+	int (*fsinfo) (struct path *path, struct fsinfo_kparams *params);
+
+where "path" indicates the object to be queried and params indicates the
+parameters and the output buffer description.  The function should return the
+total size of the data it would like to produce or an error.
+
+The parameter struct looks like::
+
+	struct fsinfo_kparams {
+		enum fsinfo_attribute	request;
+		__u32			Nth;
+		__u32			Mth;
+		unsigned int		buf_size;
+		unsigned int		usage;
+		void			*buffer;
+		char			*scratch_buffer;
+		...
+	};
+
+The fields relevant to the filesystem are as follows:
+
+ * ``request``
+
+   Which attribute is being requested.  EOPNOTSUPP should be returned if the
+   attribute is not supported by the filesystem or the LSM.
+
+ * ``Nth`` and ``Mth``
+
+   Which value of an attribute is being requested.
+
+   For a single-value attribute Nth and Mth will both be 0.
+
+   For a "1D" attribute, Nth will indicate which value and Mth will always
+   be 0.  Take, for example, FSINFO_ATTR_SERVER_NAME - for a network
+   filesystem, the superblock will be backed by a number of servers.  This will
+   return the name of the Nth server.  ENODATA will be returned if Nth goes
+   beyond the end of the array.
+
+   For a "2D" attribute, Mth will indicate the index in the Nth set of values.
+   Take, for example, Take, for example, FSINFO_ATTR_SERVER_ADDRESS - each
+   server listed by FSINFO_ATTR_SERVER_NAME may have one or more addresses.
+   This will return the Mth address of the Nth server.  ENODATA will be
+   returned if the Nth set doesn't exist or the Mth element of the Nth set
+   doesn't exist.
+
+ * ``buf_size``
+
+   This indicates the current size of the buffer.  For the array type and the
+   opaque type this will be increased if the current buffer won't hold the
+   value and the filesystem will be called again.
+
+ * ``usage``
+
+   This indicates how much of the buffer has been used so far for an array or
+   opaque type attribute.  This is updated by the fsinfo_note_param*()
+   functions.
+
+ * ``buffer``
+
+   This points to the output buffer.  For struct-type and string-type
+   attributes it will always be big enough; for array- and opaque-type, it will
+   be buf_size in size and will be resized if the returned size is larger than
+   this.
+
+ * ``scratch_buffer``
+
+   For array- and opaque-type attributes, this will point to a 4096-byte
+   scratch buffer.  Sometimes the value needs to be generated by sprintf(),
+   say, to find out how big is going to be, but that might not be possible in
+   the main buffer without risking an overrun.
+
+To simplify filesystem code, there will always be at least a minimal buffer
+available if the ->fsinfo() method gets called - and the filesystem should
+always write what it can into the buffer.  It's possible that the fsinfo()
+system call will then throw the contents away and just return the length.
+
+
+Helper Functions
+================
+
+The API includes a number of helper functions:
+
+ * ``int generic_fsinfo(struct path *path, struct fsinfo_kparams *params);``
+
+   This is the function that does default actions for filling out attribute
+   values from standard data, such as may be found in the file_system_type
+   struct and the super_block struct.  It also generates -EOPNOTSUPP for
+   unsupported attributes.
+
+   This should be called by a filesystem if it doesn't want to handle an
+   attribute.  The filesystem may also call this function and then adjust the
+   information returned, such as changing the listed capability flags.
+
+ * ``void fsinfo_set_cap(struct fsinfo_capabilities *c,
+			 enum fsinfo_capability cap);``
+
+   This function sets a capability flag.
+
+ * ``void fsinfo_clear_cap(struct fsinfo_capabilities *c,
+			   enum fsinfo_capability cap);``
+
+   This function clears a capability flag.
+
+ * ``void fsinfo_set_unix_caps(struct fsinfo_capabilities *caps);``
+
+   Set capability flags appropriate to the features of a standard UNIX
+   filesystem, such as having numeric UIDS and GIDS; allowing the creation of
+   directories, symbolic links, hard links, device files, FIFO and socket
+   files; permitting sparse files; and having access, change and modification
+   times.
+
+ * ``void fsinfo_note_param(struct fsinfo_kparams *params, const char *key,
+			    const char *val);``
+
+   This function writes a pair of strings with prepended lengths into
+   params->buffer, if there's space, and always updates params->usage.  The
+   assumption is that the caller of s->s_op->fsinfo() will resize the buffer if
+   the usage grew too large and call again.
+
+   This is intended for use with FSINFO_ATTR_{,LSM_}PARAMETERS, but is not
+   limited to those.  The format allows binary data, though this API function
+   does not support anything with NUL characters in it.
+
+   Note that this function will not sleep, so is safe to take with locks held.
+
+ * ``void fsinfo_note_paramf(struct fsinfo_kparams *params, const char *key,
+			     const char *val_fmt, ...);``
+
+   This function is a simple wrapper around fsinfo_note_param(), writing the
+   value using vsnprintf() into params->scratch_buffer and then jumping to
+   fsinfo_note_param().
+
+
+Attribute Summary
+=================
+
+To summarise the attributes that are defined::
+
+  Symbolic name				Type
+  =====================================	===============
+  FSINFO_ATTR_STATFS			struct
+  FSINFO_ATTR_FSINFO			struct
+  FSINFO_ATTR_IDS			struct
+  FSINFO_ATTR_LIMITS			struct
+  FSINFO_ATTR_SUPPORTS			struct
+  FSINFO_ATTR_CAPABILITIES		struct
+  FSINFO_ATTR_TIMESTAMP_INFO		struct
+  FSINFO_ATTR_VOLUME_ID			string
+  FSINFO_ATTR_VOLUME_UUID		struct
+  FSINFO_ATTR_VOLUME_NAME		string
+  FSINFO_ATTR_NAME_ENCODING		string
+  FSINFO_ATTR_NAME_CODEPAGE		string
+  FSINFO_ATTR_PARAM_DESCRIPTION		struct
+  FSINFO_ATTR_PARAM_SPECIFICATION	N × struct
+  FSINFO_ATTR_PARAM_ENUM		N × struct
+  FSINFO_ATTR_PARAMETERS		opaque
+  FSINFO_ATTR_LSM_PARAMETERS		opaque
+  FSINFO_ATTR_MOUNT_INFO		struct
+  FSINFO_ATTR_MOUNT_DEVNAME		string
+  FSINFO_ATTR_MOUNT_CHILDREN		array
+  FSINFO_ATTR_MOUNT_SUBMOUNT		N × string
+  FSINFO_ATTR_SERVER_NAME		N × string
+  FSINFO_ATTR_SERVER_ADDRESS		N × M × struct
+  FSINFO_ATTR_CELL_NAME			string
+
+
+Attribute Catalogue
+===================
+
+A number of the attributes convey information about a filesystem superblock:
+
+ *  ``FSINFO_ATTR_STATFS``
+
+    This struct-type attribute gives most of the equivalent data to statfs(),
+    but with all the fields as unconditional 64-bit integers.  Note that static
+    data like IDs that don't change are retrieved with FSINFO_ATTR_IDS instead.
+
+ *  ``FSINFO_ATTR_IDS``
+
+    This struct-type attribute conveys various identifiers used by the target
+    filesystem.  This includes the filesystem name, the NFS filesystem ID, the
+    superblock ID used in notifications, the filesystem magic type number and
+    the primary device ID.
+
+ *  ``FSINFO_ATTR_LIMITS``
+
+    This struct-type attribute conveys the limits on various aspects of a
+    filesystem, such as maximum file, symlink and xattr sizes, maxiumm filename
+    and xattr name length, maximum number of symlinks, maximum device major and
+    minor numbers and maximum UID, GID and project ID numbers.
+
+ *  ``FSINFO_ATTR_SUPPORTS``
+
+    This struct-type attribute conveys information about the support the
+    filesystem has for various UAPI features of a filesystem.  This includes
+    information about which bits are supported in various masks employed by the
+    statx system call, what FS_IOC_* flags are supported by ioctls and what
+    DOS/Windows file attribute flags are supported.
+
+ *  ``FSINFO_ATTR_CAPABILITIES``
+
+    This is a special attribute, being a set of single-bit capability flags,
+    formatted as struct-type attribute.  The meanings of the capability bits
+    are listed below - see the "Capability Bit Catalogue" section.  The
+    capability bits are grouped numerically into bytes, such that capilities
+    0-7 are in byte 0, 8-15 are in byte 1, 16-23 in byte 2 and so on.
+
+    Any capability bit that's not supported by the kernel will be set to false
+    if asked for.  The highest supported capability can be obtained from
+    attribute "FSINFO_ATTR_FSINFO".
+
+ *  ``FSINFO_ATTR_TIMESTAMP_INFO``
+
+    This struct-type attribute conveys information about the resolution and
+    range of the timestamps available in a filesystem.  The resolutions are
+    given as a mantissa and exponent (resolution = mantissa * 10^exponent
+    seconds), where the exponent can be negative to indicate a sub-second
+    resolution (-9 being nanoseconds, for example).
+
+ *  ``FSINFO_ATTR_VOLUME_ID``
+
+    This is a string-type attribute that conveys the superblock identifier for
+    the volume.  By default it will be filled in from the contents of s_id from
+    the superblock.  For a block-based filesystem, for example, this might be
+    the name of the primary block device.
+
+ *  ``FSINFO_ATTR_VOLUME_UUID``
+
+    This is a struct-type attribute that conveys the UUID identifier for the
+    volume.  By default it will be filled in from the contents of s_uuid from
+    the superblock.  If this doesn't exist, it will be an entirely zeros.
+
+ *  ``FSINFO_ATTR_VOLUME_NAME``
+
+    This is a string-type attribute that conveys the name of the volume.  By
+    default it will return EOPNOTSUPP.  For a disk-based filesystem, it might
+    convey the partition label; for a network-based filesystem, it might convey
+    the name of the remote volume.
+
+ *  ``FSINFO_ATTR_NAME_ENCODING``
+
+    This is a string-type attribute that returns the type of encoding used for
+    filenames in the medium.  By default this will be filled in with "utf8".
+    Not all filesystems can support that, however, so this may indicate a
+    restriction on what characters can be used.
+
+ *  ``FSINFO_ATTR_NAME_CODEPAGE``
+
+    This is a string-type attribute that returns the name of the codepage used
+    to transliterate a Linux utf8 filename into whatever the medium supports.
+    By default it returns EOPNOTSUPP.
+
+
+The next attributes give information about the mount parameter parsers and the
+mount parameters values stored in a superblock and its security data.  The
+first few of these can be queried on the file descriptor returned by fsopen()
+before any superblock is attached:
+
+ *  ``FSINFO_ATTR_PARAM_DESCRIPTION``
+
+    This is a struct-type attribute that returns summary information about what
+    mount options are available on a filesystem, including the number of
+    parameters and the number of enum symbols.
+
+ *  ``FSINFO_ATTR_PARAM_SPECIFICATION``
+
+    This is a 1D array of struct-type attributes, indicating the type,
+    qualifiers, name and an option ID for the Nth mount parameter.  Parameters
+    that have the same option ID are presumed to be synonyms.
+
+ *  ``FSINFO_ATTR_PARAM_ENUM``
+
+    This is a 1D array of struct-type attributes, indicating the Nth value
+    symbol for the set of enumeration-type parameters.  All the values are in
+    the same table, so they can be matched to the parameter by option ID, and
+    each option ID may have several entries, each with a different name.
+
+ *  ``FSINFO_ATTR_PARAMETERS``
+ *  ``FSINFO_ATTR_LSM_PARAMETERS``
+
+    These are a pair of opaque blobs that list all the mount parameter values
+    currently set on a superblock.  The first set come from the filesystem and
+    the second is from the LSMs - and, as such, convey security information,
+    such as labelling.
+
+    Inside the filesystem or LSM, the parameter values should be read in one go
+    under lock to avoid races with remount if necessary.
+
+    Each opaque blob is encoded as a series of pairs of elements, where each
+    element begins with a length.  The first element of each pair is the key
+    name and the second is the value (which may contain commas, binary data,
+    NUL chars).
+
+    An element length is encoded as a series of bytes in most->least signifcant
+    order.  Each byte contributes 7 bits to the length.  The MSB in each byte
+    is set if there's another byte of length information following on (ie. all
+    but the last byte in the length have the MSB set).
+
+
+Then there are attributes that convey information about the mount topology:
+
+ *  ``FSINFO_ATTR_MOUNT_INFO``
+
+    This struct-type attribute conveys information about a mount topology node
+    rather than a superblock.  This includes the ID of the superblock mounted
+    there and the ID of the mount node, its parent, group, master and
+    propagation source.  It also contains the attribute flags for the mount and
+    a change notification counter so that it can be quickly determined if that
+    node changed.
+
+ *  ``FSINFO_ATTR_MOUNT_DEVNAME``
+
+    This string-type attribute returns the "device name" that was supplied when
+    the mount object was created.
+
+ *  ``FSINFO_ATTR_MOUNT_CHILDREN``
+
+    This is an array-type attribute that conveys a set of structs, each of
+    which indicates the mount ID of a child and the change counter for that
+    child.  The kernel also tags an extra element on the end that indicates the
+    ID and change counter of the queried object.  This allows a conflicting
+    change to be quickly detected by comparing the before and after counters.
+
+ *  ``FSINFO_ATTR_MOUNT_SUBMOUNT``
+
+    This is a string-type attribute that conveys the pathname of the Nth
+    mountpoint under the target mount, relative to the mount root or the
+    chroot, whichever is closer.  These correspond on a 1:1 basis with the
+    eleemnts in the FSINFO_ATTR_MOUNT_CHROOT list.
+
+Then there are filesystem-specific attributes.
+
+ *  ``FSINFO_ATTR_SERVER_NAME``
+
+    This is a string-type attribute that conveys the name of the Nth server
+    backing a network-filesystem superblock.
+
+ *  ``FSINFO_ATTR_SERVER_ADDRESS``
+
+    This is a struct-type attribute that conveys the Mth address of the Nth
+    server, as returned by FSINFO_ATTR_SERVER_NAME.
+
+ *  ``FSINFO_ATTR_CELL_NAME``
+
+    This is a string-type attribute that retrieves the AFS cell name of the
+    target object.
+
+
+Lastly, one attribute gives information about fsinfo() itself:
+
+ *  ``FSINFO_ATTR_FSINFO``
+
+    This struct-type attribute gives information about the fsinfo() system call
+    itself, including the maximum number of attributes supported and the
+    maximum number of capability bits supported.
+
+
+Capability Bit Catalogue
+========================
+
+The capability bits convey single true/false assertions about a specific
+instance of a filesystem (ie. a specific superblock).  They are accessed using
+the "FSINFO_ATTR_CAPABILITY" attribute:
+
+ *  ``FSINFO_CAP_IS_KERNEL_FS``
+ *  ``FSINFO_CAP_IS_BLOCK_FS``
+ *  ``FSINFO_CAP_IS_FLASH_FS``
+ *  ``FSINFO_CAP_IS_NETWORK_FS``
+ *  ``FSINFO_CAP_IS_AUTOMOUNTER_FS``
+ *  ``FSINFO_CAP_IS_MEMORY_FS``
+
+    These indicate what kind of filesystem the target is: kernel API (proc),
+    block-based (ext4), flash/nvm-based (jffs2), remote over the network (NFS),
+    local quasi-filesystem that acts as a tray of mountpoints (autofs), plain
+    in-memory filesystem (shmem).
+
+ *  ``FSINFO_CAP_AUTOMOUNTS``
+
+    This indicate if a filesystem may have objects that are automount points.
+
+ *  ``FSINFO_CAP_ADV_LOCKS``
+ *  ``FSINFO_CAP_MAND_LOCKS``
+ *  ``FSINFO_CAP_LEASES``
+
+    These indicate if a filesystem supports advisory locks, mandatory locks or
+    leases.
+
+ *  ``FSINFO_CAP_UIDS``
+ *  ``FSINFO_CAP_GIDS``
+ *  ``FSINFO_CAP_PROJIDS``
+
+    These indicate if a filesystem supports/stores/transports numeric user IDs,
+    group IDs or project IDs.  The "FSINFO_ATTR_LIMITS" attribute can be used
+    to find out the upper limits on the IDs values.
+
+ *  ``FSINFO_CAP_STRING_USER_IDS``
+
+    This indicates if a filesystem supports/stores/transports string user
+    identifiers.
+
+ *  ``FSINFO_CAP_GUID_USER_IDS``
+
+    This indicates if a filesystem supports/stores/transports Windows GUIDs as
+    user identifiers (eg. ntfs).
+
+ *  ``FSINFO_CAP_WINDOWS_ATTRS``
+
+    This indicates if a filesystem supports Windows FILE_* attribute bits
+    (eg. cifs, jfs).  The "FSINFO_ATTR_SUPPORTS" attribute can be used to find
+    out which windows file attributes are supported by the filesystem.
+
+ *  ``FSINFO_CAP_USER_QUOTAS``
+ *  ``FSINFO_CAP_GROUP_QUOTAS``
+ *  ``FSINFO_CAP_PROJECT_QUOTAS``
+
+    These indicate if a filesystem supports quotas for users, groups or
+    projects.
+
+ *  ``FSINFO_CAP_XATTRS``
+
+    These indicate if a filesystem supports extended attributes.  The
+    "FSINFO_ATTR_LIMITS" attribute can be used to find out the upper limits on
+    the supported name and body lengths.
+
+ *  ``FSINFO_CAP_JOURNAL``
+ *  ``FSINFO_CAP_DATA_IS_JOURNALLED``
+
+    These indicate whether the filesystem has a journal and whether data
+    changes are logged to it.
+
+ *  ``FSINFO_CAP_O_SYNC``
+ *  ``FSINFO_CAP_O_DIRECT``
+
+    These indicate whether the filesystem supports the O_SYNC and O_DIRECT
+    flags.
+
+ *  ``FSINFO_CAP_VOLUME_ID``
+ *  ``FSINFO_CAP_VOLUME_UUID``
+ *  ``FSINFO_CAP_VOLUME_NAME``
+ *  ``FSINFO_CAP_VOLUME_FSID``
+
+    These indicate whether ID, UUID, name and FSID identifiers actually exist
+    in the filesystem and thus might be considered persistent.
+
+ *  ``FSINFO_CAP_IVER_ALL_CHANGE``
+ *  ``FSINFO_CAP_IVER_DATA_CHANGE``
+ *  ``FSINFO_CAP_IVER_MONO_INCR``
+
+    These indicate whether i_version in the inode is supported and, if so, what
+    mode it operates in.  The first two indicate if it's changed for any data
+    or metadata change, or whether it's only changed for any data changes; the
+    last indicates whether or not it's monotonically increasing for each such
+    change.
+
+ *  ``FSINFO_CAP_HARD_LINKS``
+ *  ``FSINFO_CAP_HARD_LINKS_1DIR``
+
+    These indicate whether the filesystem can have hard links made in it, and
+    whether they can be made between directory or only within the same
+    directory.
+
+ *  ``FSINFO_CAP_DIRECTORIES``
+ *  ``FSINFO_CAP_SYMLINKS``
+ *  ``FSINFO_CAP_DEVICE_FILES``
+ *  ``FSINFO_CAP_UNIX_SPECIALS``
+
+    These indicate whether directories; symbolic links; device files; or pipes
+    and sockets can be made within the filesystem.
+
+ *  ``FSINFO_CAP_RESOURCE_FORKS``
+
+    This indicates if the filesystem supports resource forks.
+
+ *  ``FSINFO_CAP_NAME_CASE_INDEP``
+ *  ``FSINFO_CAP_NAME_NON_UTF8``
+ *  ``FSINFO_CAP_NAME_HAS_CODEPAGE``
+
+    These indicate if the filesystem supports case-independent file names,
+    whether the filenames are non-utf8 (see the "FSINFO_ATTR_NAME_ENCODING"
+    attribute) and whether a codepage is in use to transliterate them (see
+    the "FSINFO_ATTR_NAME_CODEPAGE" attribute).
+
+ *  ``FSINFO_CAP_SPARSE``
+
+    This indicates if a filesystem supports sparse files.
+
+ *  ``FSINFO_CAP_NOT_PERSISTENT``
+
+    This indicates if a filesystem is not persistent.
+
+ *  ``FSINFO_CAP_NO_UNIX_MODE``
+
+    This indicates if a filesystem doesn't support UNIX mode bits (though they
+    may be manufactured from other bits, such as Windows file attribute flags).
+
+ *  ``FSINFO_CAP_HAS_ATIME``
+ *  ``FSINFO_CAP_HAS_BTIME``
+ *  ``FSINFO_CAP_HAS_CTIME``
+ *  ``FSINFO_CAP_HAS_MTIME``
+
+    These indicate which timestamps a filesystem supports (access, birth,
+    change, modify).  The range and resolutions can be queried with the
+    "FSINFO_ATTR_TIMESTAMPS" attribute).

