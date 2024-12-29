Return-Path: <linux-fsdevel+bounces-38214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F9F9FDDEA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 09:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF8C4188267B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 08:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E465335948;
	Sun, 29 Dec 2024 08:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="F7glhfUh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A077E3214
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Dec 2024 08:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735459794; cv=none; b=KVst+4V5ydpmR+10PH0Cjt0LihjqL4MYwcmssptHsfceD7DUYXb/slIGB8Oe7PZMgqVnlFo52alX2D55YMBjFJ0tcqOzKqZ7kaazbuWTuWDrCAzdHQcEkeBh55iV1DFXAf3RnP8yetjuPBcSQana6vo7ODNByVZ25P2/D4dnQ+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735459794; c=relaxed/simple;
	bh=1MZVGxnxn9Y5BYLfagkyIWVtkWGeNFAe9iqTgK6fNsA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=D64CglhvrU8C4mTYaqYYKKw6NWtN1CBBTIV/Fta5tIc4t8b4QmFC3XRyKrgQIN8DNecYVQ+hrvojIYA+NCrAnxEwdqqh1fj1zLOgzKzGyh13X5xMhOtFSU+Zn5Bb0udnn4gK0P8vr8/axDzLIfMsfwsfGG5uLcYfIQb5omf+bwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=F7glhfUh; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=MOFrPxDDsoF4IQKJgWH2liZxKtz0KrlFaH7SAjOoTNU=; b=F7glhfUh1GrnCpm2uKxf9dLiR0
	uJgHFv9wlTlKHU/HPZPoGSLibpwuVbwpHBfUSSjQZeUwCosEgv1p8YOq6rVOfD7lcmBICWZjFBv81
	lVn+5Nf1SNggsC2cJ8pCVJo8j9d/ueAS9tCnUf7nUSGn8PpAe+nszEGtFWhQSvrso2vCfhCEbJ3qP
	bX3Qgx+W6zHSiW9C7ibICLxwdPq92gLXo6EiWcMVVybuoXKosdjjnjdWQYG9+Fw/jeNfuTPfcedfz
	uhzSzAaQTCn/3v2ThfaR3mEf6JLmgevBuXUkaSZj71QxnjTCathgMRsqmIbtcsAzd/1WEG4h/UXEI
	QFY3jrhQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tRoMu-0000000DObS-1DbN;
	Sun, 29 Dec 2024 08:09:48 +0000
Date: Sun, 29 Dec 2024 08:09:48 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: gregkh@linuxfoundation.org
Subject: [PATCHES][RFC][CFT] debugfs cleanups
Message-ID: <20241229080948.GY1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	Debugfs has several unpleasant problems, all with the same root
cause - use of bare struct inode.  Most of the filesystems embed struct
inode into fs-specific objects used to store whatever extra state is
needed for that filesystem.  struct inode itself has one opaque pointer
(->i_private), and for simple cases that's enough; unfortunately,
debugfs case is not that simple.

	A debugfs file needs to carry at least the following:
* which driver-supplied callbacks should be used by read/write/etc.
* which driver-supplied object should they act upon, if driver has
several objects of the same kind (a very common situation)

	What's more, since driver may remove the underlying object, we
need some exclusion between the methods and removal; that is to say, for
anything opened we need to keep track of the number of threads currently
in driver-supplied callbacks and we need some way for removal to make
sure that no further callbacks will be attempted and to wait for the
one in progress to finish.

	Worse yet, if we have several similar files for access to
different fields of the same driver's object, we need either a separate
set of callbacks for each field, or some way for a callback to tell
which field it's being used for.

	Result is kludges galore.  The pointer to driver's object is
stored in inode->i_private.  The pointer to use-tracking state (struct
debugfs_fsdata) is stored in dentry->d_fsdata...  and we have run out
of opaque fields.

	The pointer to driver-supplied callback table has nowhere to go -
we can't store it in ->i_fop (that points to debugfs wrappers that would
handle use counts and call the real driver-supplied callbacks).  OK, that
can be kludged around - we allocate debugfs_fsdata on the first use,
and we can keep that pointer in it afterwards.	So we have it stashed
into ->d_fsdata until that point and move it over into debugfs_fsdata
afterwards.  Since pointers are aligned, we can use the lowest bit to
tell one from another.

	That has grown even nastier when an option to use a trimmed-down
variant of method table had been added (for most of those files we only
need read/write/lseek).  Now we have 3 states - ->d_fsdata pointing to
struct debugfs_fsdata, ->d_fsdata used to stash a pointer to full struct
file_operations and ->d_fsdata used to stash a pointer to trimmed-down
variant.  Not to worry - all those pointers are at least 32bit-aligned,
so we can use the lower couple of bits to tell one state from another
(00, 01 and 11 resp.)

	It's still not the end, though - some drivers have fuckloads of
files for each underlying object, and while debugfs has an unsanitary
degree of fondness for templates, apparently there are some limits.
That gets kludged over in two fairly disgusting ways.  For one thing,
we already store a reference to driver-supplied file_operations, so
we can always have several (dozens of) identical copies of that thing
and have callback ask debugfs to give it the pointer.  Voila - we can
tell whether we are trying to read driver_object->plonk or driver_object->puke
by checking which copy does that point to.  Another kludge is to look
at dentry name - compare it with a bunch of strings until we find the
one we want.

	All of that could be avoided if we augmented debugfs inodes with
a couple of pointers - no more stashing crap in ->d_fsdata, etc.
And it's really not hard to do.  The series below attempts to untangle
that mess; it can be found in
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.debugfs

	It's very lightly tested; review and more testing would be
very welcome.

Shortlog:
Al Viro (20):
      debugfs: fix missing mutex_destroy() in short_fops case
      debugfs: separate cache for debugfs inodes
      debugfs: move ->automount into debugfs_inode_info
      debugfs: get rid of dynamically allocation proxy_ops
      debugfs: don't mess with bits in ->d_fsdata
      debugfs: allow to store an additional opaque pointer at file creation
      carl9170: stop embedding file_operations into their objects
      b43: stop embedding struct file_operations into their objects
      b43legacy: make use of debugfs_get_aux()
      netdevsim: don't embed file_operations into your structs
      mediatek: stop messing with ->d_iname
      [not even compile-tested] greybus/camera - stop messing with ->d_iname
      mtu3: don't mess wiht ->d_iname
      xhci: don't mess with ->d_iname
      qat: don't mess with ->d_name
      sof-client-ipc-flood-test: don't mess with ->d_name
      slub: don't mess with ->d_name
      arm_scmi: don't mess with ->d_parent->d_name
      octeontx2: don't mess with ->d_parent or ->d_parent->d_name
      saner replacement for debugfs_rename()

Diffstat:
 Documentation/filesystems/debugfs.rst              |  12 +-
 .../crypto/intel/qat/qat_common/adf_tl_debugfs.c   |  36 +---
 drivers/firmware/arm_scmi/raw_mode.c               |  12 +-
 drivers/net/bonding/bond_debugfs.c                 |   9 +-
 drivers/net/ethernet/amd/xgbe/xgbe-debugfs.c       |  19 +-
 .../ethernet/marvell/octeontx2/af/rvu_debugfs.c    |  76 +++-----
 drivers/net/ethernet/marvell/skge.c                |   5 +-
 drivers/net/ethernet/marvell/sky2.c                |   5 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   6 +-
 drivers/net/netdevsim/hwstats.c                    |  29 ++-
 drivers/net/wireless/ath/carl9170/debug.c          |  28 ++-
 drivers/net/wireless/broadcom/b43/debugfs.c        |  27 ++-
 drivers/net/wireless/broadcom/b43legacy/debugfs.c  |  26 ++-
 drivers/opp/debugfs.c                              |  10 +-
 drivers/phy/mediatek/phy-mtk-tphy.c                |  40 +---
 drivers/staging/greybus/camera.c                   |  17 +-
 drivers/usb/host/xhci-debugfs.c                    |  25 +--
 drivers/usb/mtu3/mtu3_debugfs.c                    |  40 +---
 fs/debugfs/file.c                                  | 167 ++++++++--------
 fs/debugfs/inode.c                                 | 213 ++++++++++-----------
 fs/debugfs/internal.h                              |  55 +++---
 include/linux/debugfs.h                            |  34 +++-
 mm/shrinker_debug.c                                |  16 +-
 mm/slub.c                                          |  13 +-
 net/hsr/hsr_debugfs.c                              |   9 +-
 net/mac80211/debugfs_netdev.c                      |  11 +-
 net/wireless/core.c                                |   5 +-
 sound/soc/sof/sof-client-ipc-flood-test.c          |  39 ++--
 28 files changed, 399 insertions(+), 585 deletions(-)

Patches' overview:

01/20) debugfs: fix missing mutex_destroy() in short_fops case
	-stable fodder, in one place the logics for "what does ->d_fsdata
contain for this one" got confused.

Meat of the series:

02/20) debugfs: separate cache for debugfs inodes
	Embed them into container (struct debugfs_inode_info, with nothing
else in it at the moment), set the cache up, etc.
	Just the infrastructure changes letting us augment debugfs inodes
here; adding stuff will come at the next step.

03/20) debugfs: move ->automount into debugfs_inode_info
	... and don't bother with debugfs_fsdata for those.  Life's
simpler that way...

04/20) debugfs: get rid of dynamically allocation proxy_ops
	All it takes is having full_proxy_open() collect the information
about available methods and store it in debugfs_fsdata.
	Wrappers are called only after full_proxy_open() has succeeded
calling debugfs_get_file(), so they are guaranteed to have ->d_fsdata
already pointing to debugfs_fsdata.
	As the result, they can check if method is absent and bugger off
early, without any atomic operations, etc. - same effect as what we'd
have from NULL method.  Which makes the entire proxy_fops contents
unconditional, making it completely pointless - we can just put those
methods (unconditionally) into debugfs_full_proxy_file_operations and
forget about dynamic allocation, replace_fops, etc.

05/20) debugfs: don't mess with bits in ->d_fsdata
	The reason we need that crap is the dual use ->d_fsdata has there -
it's both holding a debugfs_fsdata reference after the first
debugfs_file_get() (actually, after the call of proxy ->open())
*and* it serves as a place to stash a reference to real file_operations
from object creation to the first open.  Oh, and it's triple use,
actually - that stashed reference might be to debugfs_short_fops.
	Bugger that for a game of solidiers - just put the operations
reference into debugfs-private augmentation of inode.  And split
debugfs_full_file_operations into full and short cases, so that
debugfs_get_file() could tell one from another.
	Voila - ->d_fsdata holds NULL until the first (successful)
debugfs_get_file() and a reference to struct debugfs_fsdata afterwards.

06/20) debugfs: allow to store an additional opaque pointer at file creation
	Set by debugfs_create_file_aux(name, mode, parent, data, aux, fops).
Plain debugfs_create_file() has it set to NULL.
Accessed by debugfs_get_aux(file).
	Convenience macros for numeric opaque data - debugfs_create_file_aux_num
and debugfs_get_aux_num, resp.

Now we can trim the crap from drivers:

A bunch "let's make a bunch of identical copies of struct file_operations
and use debugfs_real_fops() to tell which field are we asked to operate upon":
07/20) carl9170: stop embedding file_operations into their objects
08/20) b43: stop embedding struct file_operations into their objects
09/20) b43legacy: make use of debugfs_get_aux()
10/20) netdevsim: don't embed file_operations into your structs

BTW, that crack about several dozens?  Literal truth - carl9170 has forty
three such identical copies.  Hidden by creative uses of preprocessor...

A bunch of "let's play with dentry name" case:
11/20) mediatek: stop messing with ->d_iname
12/20) [not even compile-tested] greybus/camera - stop messing with ->d_iname
	depends on BROKEN, so...
13/20) mtu3: don't mess wiht ->d_iname
14/20) xhci: don't mess with ->d_iname
15/20) qat: don't mess with ->d_name
16/20) sof-client-ipc-flood-test: don't mess with ->d_name
17/20) slub: don't mess with ->d_name

Even nastier - these look at the name of parent directory instead.
18/20) arm_scmi: don't mess with ->d_parent->d_name
19/20) octeontx2: don't mess with ->d_parent or ->d_parent->d_name

The last commit is pretty much independent from the rest of series:
20/20) saner replacement for debugfs_rename()
Existing primitive has several problems:
	1) calling conventions are clumsy - it returns a dentry reference
that is either identical to its second argument or is an ERR_PTR(-E...);
in both cases no refcount changes happen.  Inconvenient for users and
bug-prone; it would be better to have it return 0 on success and -E... on
failure.
	2) it allows cross-directory moves; however, no such caller have
ever materialized and considering the way debugfs is used, it's unlikely
to happen in the future.  What's more, any such caller would have fun
issues to deal with wrt interplay with recursive removal.  It also makes
the calling conventions clumsier...
	3) tautological rename fails; the callers have no race-free way
to deal with that.
	4) new name must have been formed by the caller; quite a few
callers have it done by sprintf/kasprintf/etc., ending up with considerable
boilerplate.
	Proposed replacement: int debugfs_change_name(dentry, fmt, ...).
All callers convert to that easily, and it's simpler internally.
	IMO debugfs_rename() should go; if we ever get a real-world use
case for cross-directory moves in debugfs, we can always look into
the right way to handle that.

