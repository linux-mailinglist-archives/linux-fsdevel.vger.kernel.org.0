Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4886E2FDA94
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 21:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388867AbhATUOZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 15:14:25 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52354 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389741AbhATUOQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 15:14:16 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 5268A1F45797
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tytso@mit.edu, jack@suse.com, viro@zeniv.linux.org.uk,
        amir73il@gmail.com, dhowells@redhat.com, david@fromorbit.com,
        darrick.wong@oracle.com, khazhy@google.com
Cc:     linux-fsdevel@vger.kernel.org, kernel@collabora.com
Subject: [RFC] Filesystem error notifications proposal
Date:   Wed, 20 Jan 2021 17:13:15 -0300
Message-ID: <87lfcne59g.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


My apologies for the long email.

Please let me know your thoughts.

1 Summary
=========

  I'm looking for a filesystem-agnostic mechanism to report filesystem
  errors to a monitoring tool in userspace.  I experimented first with
  the watch_queue API but decided to move to fanotify for a few reasons.


2 Background
============

  I submitted a first set of patches, based on David Howells' original
  superblock notifications patchset, that I expanded into error
  reporting and had an example implementation for ext4.  Upstream review
  has revealed a few design problems:

  - Including the "function:line" tuple in the notification allows the
    uniquely identification of the error origin but it also ties the
    decodification of the error to the source code, i.e. <function:line>
    is expected to change between releases.

  - Useful debug data (inode number, block group) have formats specific
    to the filesystems, and my design wouldn't be expansible to
    filesystems other than ext4.

  - The implementation allowed an error string description (equivalent
    to what would be thrown in dmesg) that is too short, as it needs to
    fit in a single notification.

  - How the user sees the filesystem.  The original patch points to a
    mountpoint but uses the term superblock.  This is to differentiate
    from another mechanism in development to watch mounting operations.

  - Visibility of objects.  A bind mount of a subtree shouldn't receive
    notifications of objects outside of that bind mount.


2.1 Other constraints of the watch_queue API
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  watch_queue is a fairly new framework, which has one upstream user in
  the keyring subsystem.  watch_queue is designed to submit very short
  (max of 128 bytes) atomic notifications to userspace in a fast manner
  through a ring buffer.  There is no current mechanism to link
  notifications that require more than one slot and such mechanism
  wouldn't be trivial to implement, since buffer overruns could
  overwrite the beginning/end of a multi part notification.  In
  addition, watch_queue requires an out-of-band overflow notification
  mechanism, which would need to be implemented aside from the system
  call, in a separate API.


2.2 fanotify vs watch_queue
~~~~~~~~~~~~~~~~~~~~~~~~~~~

  watch_queue is designed for efficiency and fast submission of a large
  number of notifications.  It doesn't require memory allocation in the
  submission path, but with a flexibility cost, such as limited
  notification size.  fanotify is more flexible, allows for larger
  notifications and better filtering, but requires allocations on the
  submission path.

  On the other hand, fanotify already has support for the visibility
  semantics we are looking for. fsnotify allows an inode to notify only
  its subtree, mountpoints, or the entire filesystem, depending on the
  watcher flags, while an equivalent support would need to be written
  from scratch for watch_queue.  fanotify also has in-band overflow
  handling, already implemented.  Finally, since fanotify supports much
  larger notifications, there is no need to link separate notifications,
  preventing buffer overruns from erasing parts of a notification chain.

  fanotify is based on fsnotify, and the infrastructure for the
  visibility semantics is mostly implemented by fsnotify itself.  It
  would be possible to make error notifications a new mechanism on top
  of fsnotify, without modifying fanotify, but that would require
  exposing a very similar interface to userspace, new system calls, and
  that doesn't seem justifiable since we can extend fanotify syscalls
  without ABI breakage.


3 Proposal
==========

  The error notification framework is based on fanotify instead of
  watch_queue.  It is exposed through a new set of marks FAN_ERROR_*,
  exposed through the fanotify_mark(2) API.

  fanotify (fsnotify-based) has the infrastructure in-place to link
  notifications happening at filesystem objects to mountpoints and to
  filesystems, and already exposes an interface with well defined
  semantics of how those are exposed to watchers in different
  mountpoints or different subtrees.

  A new message format is exposed, if the user passed
  FAN_REPORT_DETAILED_ERROR fanotify_init(2) flag.  FAN_ERROR messages
  don't have FID/DFID records.

  A FAN_REPORT_DETAILED_ERROR record has the same struct
  fanotify_event_metadata header, but it is followed by one or more
  additional information record as follows:

  struct fanotify_event_error_hdr {
  	struct fanotify_event_info_header hdr;
  	__u32 error;
        __u64 inode;
        __u64 offset;
  }

  error is a VFS generic error number that can notify generic conditions
  like EFSCORRUPT. If hdr.len is larger than sizeof(struct
  fanotify_event_error_hdr), this structure is followed by an optional
  filesystem specific record that further specifies the error,
  originating object and debug data. This record has a generic header:

  struct fanotify_event_fs_error_hdr {
  	struct fanotify_event_error_hdr hdr;
        __kernel_fsid_t fsid;
        __u32 fs_error;
  }

  fs_error is a filesystem specific error record, potentially more
  detailed than fanotify_event_error.hdr.error . Each type of filesystem
  error has its own record type, that is used to report different
  information useful for each type of error.  For instance, an ext4
  lookup error, caused by an invalid inode type read from disk, produces
  the following record:

  struct fanotify_event_ext4_inode_error {
  	struct fanotify_event_fs_error_hdr hdr;
        __u64 block;
        __u32 inode_type;
  }

  The separation between VFS and filesystem-specific error messages has
  the benefit of always providing some information that an error has
  occurred, regardless of filesystem-specific support, while allowing
  capable filesystems to expose specific internal data to further
  document the issue.  This scheme leaves to the filesystem to expose
  more meaningful information as needed.  For instance, multi-disk
  filesystems can single out the problematic disk, network filesystems
  can expose a network error while accessing the server.


3.1 Visibility semantics
~~~~~~~~~~~~~~~~~~~~~~~~

  Error reporting follows the same semantics of fanotify events.
  Therefore, a watcher can request to watch the entire filesystem, a
  single mountpoint or a subtree.


3.2 security implications
~~~~~~~~~~~~~~~~~~~~~~~~~

  fanotify requires CAP_SYS_ADMIN.  My understanding is this requirement
  suffices for most use cases but, according to fanotify documentation,
  it could be relaxed without issues for the existing fanotify API.  For
  instance, watching a subtree could be a allowed for a user who owns
  that subtree.


3.3 error location
~~~~~~~~~~~~~~~~~~

  While exposing the exact line of code that triggered the notification
  ties that notification to a specific kernel version, it is an
  important information for those who completely control their
  environment and kernel builds, such as cloud providers.  Therefore,
  this proposal includes a mechanism to optionally include in the
  notification the line of code where the error occurred

  A watcher who passes the flag FAN_REPORT_ERROR_LOCATION to
  fanotify_init(2) receives an extra record for FAN_ERROR events:

  struct fanotify_event_fs_error_location {
  	struct fanotify_event_info_header hdr;
        u32 line;
        char function[];
  }

  This record identifies the place where the error occured.  function is
  a VLA whose size extend to the end of the region delimited by hdr.len.
  This VLA text-encodes the function name where the error occurred.

What do you think about his interface?  Would it be acceptable as part
of fanotify, or should it be a new fsnotify mode?

Regarding semantics, I believe fanotify should solve the visibility
problem for a subtree watcher not being able to see other branches
notifications.  Do you think this would suffice?

Thanks,

-- 
Gabriel Krisman Bertazi
