Return-Path: <linux-fsdevel+bounces-12362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC5E85EA40
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 22:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6A5B1F25055
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 21:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3FA12AADC;
	Wed, 21 Feb 2024 21:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="piyl8rIr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0518045C10;
	Wed, 21 Feb 2024 21:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550706; cv=none; b=GwJOntZ02HQbFIZvNXdO3u+1sovaoa66xOyDEgHt8CF10O3W2KnVS0Q9xvpk/qHAVmWttB9pKXb+wnb/6O9PQ6qEn37fwO7mxLeu2/3Rm/xWPHGhR/eCBWUI5swumfqY6Xzjv+UkBs69gmTFuYVYLsyoYDUNgs92lEdaN4aZKQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550706; c=relaxed/simple;
	bh=pEK3ogWcsMBDjVNEBVGWfKJWNZ+VqsOdUsw3KYnCmp8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XxQM6N+2dFkG6RXETas84vZtt9pE40ZqVRb+zg/aoYdYMH1tf/ldg8e802FSpg6aTlG79wvOKMnNFSgKpFGiZTSWlTR0mtVpI1v9m6A55D7XYVswbgOZMPJq4Sc9147FpTfa1zG+UwUArex4r/VF1WBgAsPgs9bppNsOCbkrHhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=piyl8rIr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97571C433F1;
	Wed, 21 Feb 2024 21:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708550705;
	bh=pEK3ogWcsMBDjVNEBVGWfKJWNZ+VqsOdUsw3KYnCmp8=;
	h=From:Subject:Date:To:Cc:From;
	b=piyl8rIri2UZhWzO6yo1zioRkeNE/JkVgB3rClW62lgtZU6x+atyxbvPRC53LyB9y
	 +rQOfeFuwJDF9rdObfhGRkA4KcAOp2jSPef+XUItB4AB5DhrZRoPmOWoB+4Iylq4O9
	 Zq5+yJ2bSUBg5kaK7cPLvL7av1/eC939h5zuDd24tZIzPDDdTToGX8AKM8GH47rCzL
	 vrOlfV3F25jmB0OTV6awbrPd7u0jIuVLDFrMbHzC0gneDLTln8QSPFNigBHVoDTupU
	 SIR55iv/mcT8wbR4LnxJqC5G5MuMw246MMUT11yPMmVuDTzC7J/C+Y21jUVgvnXy0P
	 bHDlFSvHq7nBA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78138C5478A;
	Wed, 21 Feb 2024 21:25:05 +0000 (UTC)
From: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Subject: [PATCH v2 00/25] fs: use type-safe uid representation for
 filesystem capabilities
Date: Wed, 21 Feb 2024 15:24:31 -0600
Message-Id: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA9q1mUC/22NQQrCMBBFr1JmbSRJSVBX3kO6mKSTNljTkmhQS
 u/u2LWbgfeZx1uhUI5U4NKskKnGEufEoA8N+BHTQCL2zKClbqVRmvGBiwjF880U0D/nLGzrrAo
 osbUBWHVYSLiMyY8sp9c08bjwe3zvrVvHPMbC7mdPV/Vb94pS+vy/UpWQokeD2kpzQuOud8qJp
 uOcB+i2bfsCF+jp6c4AAAA=
To: Christian Brauner <brauner@kernel.org>, 
 Seth Forshee <sforshee@kernel.org>, Serge Hallyn <serge@hallyn.com>, 
 Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>, 
 James Morris <jmorris@namei.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Ondrej Mosnacek <omosnace@redhat.com>, 
 Casey Schaufler <casey@schaufler-ca.com>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Jonathan Corbet <corbet@lwn.net>, Miklos Szeredi <miklos@szeredi.hu>, 
 Amir Goldstein <amir73il@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, audit@vger.kernel.org, 
 selinux@vger.kernel.org, linux-integrity@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-unionfs@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=6763; i=sforshee@kernel.org;
 h=from:subject:message-id; bh=pEK3ogWcsMBDjVNEBVGWfKJWNZ+VqsOdUsw3KYnCmp8=; 
 =?utf-8?q?b=3DowEBbQGS/pANAwAKAVMDma7l9DHJAcsmYgBl1moWoa2PeA8gvUi+F8nAKw73u?=
 =?utf-8?q?YewhAhfWqEh/fe7_8SlhL/2JATMEAAEKAB0WIQSQnt+rKAvnETy4Hc9TA5mu5fQxy?=
 =?utf-8?q?QUCZdZqFgAKCRBTA5mu5fQxydf1B/_0S9qlm7Hricn6XNcEnh8kf6deH57UoqT/zH?=
 =?utf-8?q?u3R0D/8Akk4J0UyDpVDieeGAtq3ACBYdyvi4vPsVaSW_SYt2h7VB4KM+MtzGq234o?=
 =?utf-8?q?SynaMZ/DoUgp3MWk/w0YrmGr947zFeiT8CyHfQ+n4lRPEnzlZKLdoEjhI_4ZXVPBa?=
 =?utf-8?q?I390rByk0SGuKf7Cb8WIIReJ36MToptFKtKwN777xdEWc8TDtyvVSzMBGkTo0Dmt9?=
 =?utf-8?q?Yny3w7_UpOW68h853T9SsFtY9z/O0Qwi66H6SWGNNe2LcCKN5y3EiOKQ2CSGI/vNo?=
 =?utf-8?q?OecRjdw3LTvJ364qtzRc?= w+//WGGw9OOVYRUfBHjqDdeElgsYiN
X-Developer-Key: i=sforshee@kernel.org; a=openpgp;
 fpr=2ABCA7498D83E1D32D51D3B5AB4800A62DB9F73A
X-Endpoint-Received:
 by B4 Relay for sforshee@kernel.org/default with auth_id=103

This series converts filesystem capabilities from passing around raw
xattr data to using a kernel-internal representation with type safe
uids, similar to the conversion done previously for posix ACLs.
Currently fscaps representations in the kernel have two different
instances of unclear or confused types:

- fscaps are generally passed around in the raw xattr form, with the
  rootid sometimes containing the user uid value and at other times
  containing the filesystem value.
- The existing kernel-internal representation of fscaps,
  cpu_vfs_cap_data, uses the kuid_t type, but the value stored is
  actually a vfsuid.

This series eliminates this confusion by converting the xattr data to
the kernel representation near the userspace and filesystem boundaries,
using the kernel representation within the vfs and commoncap code. The
internal representation is renamed to vfs_caps to reflect this broader
use, and the rootid is changed to a vfsuid_t to correctly identify the
type of uid which it contains.

New vfs interfaces are added to allow for getting and setting fscaps
using the kernel representation. This requires the addition of new inode
operations to allow overlayfs to handle fscaps properly; all other
filesystems fall back to a generic implementation. The top-level vfs
xattr interfaces will now reject fscaps xattrs, though the lower-level
interfaces continue to accept them for reading and writing the raw xattr
data.

Based on previous feedback, new security hooks are added for fscaps
operations. These are really only needed for EVM, and the selinux and
smack implementations just peform the same operations that the
equivalent xattr hooks would have done. Note too that this has not yet
been updated based on the changes to make EVM into an LSM.

The remainder of the changes are preparatory work, addition of helpers
for converting between the xattr and kernel fscaps representation, and
various updates to use the kernel representation and new interfaces.

I have tested this code with xfstests, ltp, libcap2, and libcap-ng with
no regressions found.

To: Christian Brauner <brauner@kernel.org>
To: Serge Hallyn <serge@hallyn.com>
To: Paul Moore <paul@paul-moore.com>
To: Eric Paris <eparis@redhat.com>
To: James Morris <jmorris@namei.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
To: Amir Goldstein <amir73il@gmail.com>
Cc:  <linux-kernel@vger.kernel.org>
Cc:  <linux-fsdevel@vger.kernel.org>
Cc:  <linux-security-module@vger.kernel.org>
Cc:  <audit@vger.kernel.org>
Cc:  <linux-unionfs@vger.kernel.org>
Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>

--- Changes in v2:
- Documented new inode operations in
  Documentation/filesystems/{vfs,locking}.rst.
- Changed types for sizes in function arguments and return values to
  size_t/ssize_t.
- Renamed flags arguments to setxattr_flags for clarity.
- Removed memory allocation when reading fscaps xattrs.
- Updated get_vfs_caps_from_disk() to use vfs_get_fscaps() and updated
  comments to explain how these functions are different.
- Updates/fixes to kernel-doc comments.
- Remove unnecessary type cast.
- Rename __vfs_{get,remove}_fscaps() to vfs_{get,remove}_fscaps_nosec().
- Add missing fsnotify_xattr() call in vfs_set_fscaps().
- Add fscaps security hooks along with appropriate handlers in selinux,
  smack, and evm.
- Remove remove_fscaps inode op in favor of passing NULL to set_fscaps.
- Added static asserts for compatibility of vfs_cap_data and
  vfs_ns_cap_data.
- ovl: remove unnecessary check around ovl_copy_up(), and add check
  before copyint up fscaps for removal that the fscaps actually exist on
  the lower inode.
- ovl: install fscaps handlers for all inode types
- Add is_fscaps_xattr() helper and use it in place of open-coded strcmps
- Link to v1: https://lore.kernel.org/r/20231129-idmap-fscap-refactor-v1-0-da5a26058a5b@kernel.org

---
Seth Forshee (DigitalOcean) (25):
      mnt_idmapping: split out core vfs[ug]id_t definitions into vfsid.h
      mnt_idmapping: include cred.h
      capability: add static asserts for comapatibility of vfs_cap_data and vfs_ns_cap_data
      capability: rename cpu_vfs_cap_data to vfs_caps
      capability: use vfsuid_t for vfs_caps rootids
      capability: provide helpers for converting between xattrs and vfs_caps
      capability: provide a helper for converting vfs_caps to xattr for userspace
      xattr: add is_fscaps_xattr() helper
      commoncap: use is_fscaps_xattr()
      xattr: use is_fscaps_xattr()
      security: add hooks for set/get/remove of fscaps
      selinux: add hooks for fscaps operations
      smack: add hooks for fscaps operations
      evm: add support for fscaps security hooks
      security: call evm fscaps hooks from generic security hooks
      fs: add inode operations to get/set/remove fscaps
      fs: add vfs_get_fscaps()
      fs: add vfs_set_fscaps()
      fs: add vfs_remove_fscaps()
      ovl: add fscaps handlers
      ovl: use vfs_{get,set}_fscaps() for copy-up
      fs: use vfs interfaces for capabilities xattrs
      commoncap: remove cap_inode_getsecurity()
      commoncap: use vfs fscaps interfaces
      vfs: return -EOPNOTSUPP for fscaps from vfs_*xattr()

 Documentation/filesystems/locking.rst |   4 +
 Documentation/filesystems/vfs.rst     |  17 ++
 MAINTAINERS                           |   1 +
 fs/overlayfs/copy_up.c                |  72 ++---
 fs/overlayfs/dir.c                    |   2 +
 fs/overlayfs/inode.c                  |  72 +++++
 fs/overlayfs/overlayfs.h              |   5 +
 fs/xattr.c                            | 280 +++++++++++++++++-
 include/linux/capability.h            |  23 +-
 include/linux/evm.h                   |  39 +++
 include/linux/fs.h                    |  12 +
 include/linux/lsm_hook_defs.h         |   7 +
 include/linux/mnt_idmapping.h         |  67 +----
 include/linux/security.h              |  38 ++-
 include/linux/vfsid.h                 |  74 +++++
 include/linux/xattr.h                 |   5 +
 include/uapi/linux/capability.h       |  13 +
 kernel/auditsc.c                      |   9 +-
 security/commoncap.c                  | 529 ++++++++++++++++++----------------
 security/integrity/evm/evm_main.c     |  60 ++++
 security/security.c                   |  80 +++++
 security/selinux/hooks.c              |  26 ++
 security/smack/smack_lsm.c            |  71 +++++
 23 files changed, 1144 insertions(+), 362 deletions(-)
---
base-commit: 841c35169323cd833294798e58b9bf63fa4fa1de
change-id: 20230512-idmap-fscap-refactor-63b61fa0a36f

Best regards,
-- 
Seth Forshee (DigitalOcean) <sforshee@kernel.org>


