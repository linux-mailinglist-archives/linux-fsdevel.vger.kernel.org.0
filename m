Return-Path: <linux-fsdevel+bounces-62185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F14B87A5C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 04:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 787701C852F8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 02:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A7E258CCB;
	Fri, 19 Sep 2025 02:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="L56Az5EC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D64233134;
	Fri, 19 Sep 2025 02:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758247208; cv=none; b=qIDFw0ik7hzoum82xnW7OeO2LjDTb2TbTt6QSpbNZBfxKHYxGcM3gZS1u7sYPxuzKBVVAhTDsyxgiCVOfNKwqnbUSLYdUuhiJuKWcl+OiIin12yWk5O+vLpdavKwvFgpopz+0MVkQYO3Py3Jn6HnLlCdJnKRgzVenMcvfGiz5bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758247208; c=relaxed/simple;
	bh=HIIkNaMU5GgG9Rf9V2GoErd/p0SIxRUUuqmYjKXvHzQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YnRy1mdCmYn3T9H6B1NsYWOVXGCK2bMTpqR7m5cG69gV4UtzkEGo4TzsWxL6Nb09Rz5+guZsStejkfMOYeWLpv9ao9ZwFGL8tdJKeOZboIENp9uYjzZojA/3xIwbTVfKQ2gLmjaRzr+ks9FEMB5aw7FqiF6Pz/gD0c+U6Dqt08s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=L56Az5EC; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cSbL90mbyz9tWn;
	Fri, 19 Sep 2025 04:00:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1758247201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=s7gGMBBWiBfnSQZTXHZQICQvhBH60cZ2eVI0nPXiV3M=;
	b=L56Az5ECSPp0hxe8ISlarb1Cu8ys3ubL37m7mAhBSwgy3yhxIzP4BYX+LRa+NmeVuNNIup
	znvnELAsjT6Xo/RO7/JqlDPez/8lWABlwe6ljc+S1/az0tyotHQfcJBLIgTCuzJQe4xLBk
	B9dYHHqXJMLXvkN1+4L0Dnty4iqBKe5coQxQTu5W7EdB5wwLAS4wrYc1ebUdXn2gx5usGJ
	v7fAwQtTVC7M9cgs13j0CmJH5+kochzY1WbqmwP2ZR2KVA0gJFryDVmJ9bvF4JmIpxwzQ4
	szGQ4MOjVozToXLq9Z0WkdOOuyiqs1d0j/LcBDSjtqnZW09T+dWfk6PJmElxww==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
From: Aleksa Sarai <cyphar@cyphar.com>
Subject: [PATCH v4 00/10] man2: document "new" mount API
Date: Fri, 19 Sep 2025 11:59:41 +1000
Message-Id: <20250919-new-mount-api-v4-0-1261201ab562@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA25zGgC/2XM3Q6CIACG4VtxHEdD/sSOuo/WASIkB4IDo5zz3
 kO3NrPD79uedwZRB6sjuBQzCDrZaL3Lg54KoDrpHhraNm+AEWZIIAydfsHeP90I5WAhJbxtakE
 NJRhkMwRt7Hvr3e55dzaOPkxbPpXr+y3xQymVEEHBK2EYV1xrdFXT0MlwVr4HayrhPa+OHGfOm
 JC4anJcqD9O9rw+cpK54SVFTAlkCP3hy7J8AG2f5jwpAQAA
X-Change-ID: 20250802-new-mount-api-436db984f432
To: Alejandro Colomar <alx@kernel.org>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Askar Safin <safinaskar@zohomail.com>, 
 "G. Branden Robinson" <g.branden.robinson@gmail.com>, 
 linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>, 
 Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=10315; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=HIIkNaMU5GgG9Rf9V2GoErd/p0SIxRUUuqmYjKXvHzQ=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWSc2SnqPK/pMSOzg9sFySwma9m3KTlyyetei7QuEHt77
 u2p2d1lHRNZGMS4GCzFFFm2+XmGbpq/+Eryp5VsMHNYmUCGSIs0MDAwMLAw8OUm5pUa6RjpmWob
 6hka6hjpGDFwcQrAVHPYMDKscDte5X71zk3Oc8eNM2y/fDudlRtQGtr+Li6kr+6dco8SI8M+i49
 qrBunSS64k/iWlX+1k6l1Zc2iuaf5Yj/umPMjk48bAA==
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4cSbL90mbyz9tWn

Back in 2019, the new mount API was merged[1]. David Howells then set
about writing man pages for these new APIs, and sent some patches back
in 2020[2].

Unfortunately, these patches were never merged, which meant that these
APIs were practically undocumented for many years -- arguably this has
been a contributing factor to the relatively slow adoption of these new
(far better) APIs. For instance, I have often discovered that many folks
are unaware of the read(2)-based message retrieval interface provided by
filesystem context file descriptors.

In 2024, Christian Brauner adapted David Howell's original man pages
into the easier-to-edit Markdown format and published them on GitHub[3].
These have been maintained since, including updated information on new
features added since David Howells's 2020 draft pages (such as
MOVE_MOUNT_BENEATH).

While this was a welcome improvement to the previous status quo (that
had lasted over 6 years), speaking personally my experience is that not
having access to these man pages from the terminal has been a fairly
common painpoint.

So, this is a modern version of the man pages for these APIs, in the
hopes that we can finally (6 years later) get proper documentation for
these APIs in the man-pages project.

One important thing to note is that most of these were re-written by me,
with very minimal copying from the versions available from Christian[2].
The reasons for this are two-fold:

 * Both Howells's original version and Christian's maintained versions
   contain crucial mistakes that I have been bitten by in the past (the
   most obvious being that all of these APIs were merged in Linux 5.2,
   but the man pages all claim they were merged in different versions.)

 * As the man pages appear to have been written from Howells's
   perspective while implementing them, some of the wording is a little
   too tied to the implementation (or appears to describe features that
   don't really exist in the merged versions of these APIs).

 * The original versions of the man-pages lacked bigger-picture
   explanations of the reasoning behind the API, which would make it
   easier for readers to understand what operations are doing.

I decided that the best way to resolve these issues is to rewrite them
from the perspective of an actual user of these APIs (me), and check
that we do not repeat the mistakes I found in the originals. I have also
done my best to resolve the issues raised by Michael Kerrisk on the
original patchset sent by Howells[1].

In addition, I have also included a man page for open_tree_attr(2) (as a
subsection of the new open_tree(2) man page), which was merged in Linux
6.15.

[1]: https://lore.kernel.org/all/20190507204921.GL23075@ZenIV.linux.org.uk/
[2]: https://lore.kernel.org/linux-man/159680892602.29015.6551860260436544999.stgit@warthog.procyon.org.uk/
[3]: https://github.com/brauner/man-pages-md

Co-authored-by: David Howells <dhowells@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Co-authored-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
Changes in v4:
- `sed -i s|\\% |\\%|g`.
- Remove unneeded quotes in SYNOPSIS. [Alejandro Colomar]
- open_tree(2): fix leftover confusing usages of "attach" when referring
  to file descriptors being associated with mount objects.
- open_tree(2): rename "Anonymous mount namespaces" NOTES subsection to
  the far more informative "Mount propagation" and clean up the wording
  a little.
- open_tree_attr(2): add a code comment about
  <https://lore.kernel.org/all/20250808-open_tree_attr-bugfix-idmap-v1-0-0ec7bc05646c@cyphar.com/>
- {fsconfig,open_tree_attr}(2): use _Nullable.
- {fsmount,open_tree}(2): mention the the unmount-on-close behaviour is
  actually lazy (a-la MNT_DETACH).
- {fsconfig,mount_setattr}(2): improve "mount attributes and filesystem
  parameters" wording to make it clearer that superblock and mount flags
  are sibling properties, not the same thing.
- open_tree(2): mention that any mount propagation events while the mount
  object is detached are completely lost -- i.e., they don't get replayed once
  you attach the mount somewhere.
- fsconfig(2): fix minor grammatical / missing joining word issues.
- fsconfig(2): fix final leftover `.IR A " and " B` cases.
- fsconfig(2): explain that failed fsconfig(FSCONFIG_CMD_*) operations render
  the filesystem context invalid.
- fsconfig(2): rework the description of superblock reuse, as the previous text
  was very wrong. (Though there has been discussion about changing this
  behaviour...)
- fsconfig(2): remove misleading wording in FSCONFIG_CMD_CREATE_EXCL about how
  we are requesting a new filesystem instance -- in theory filesystems could
  take this request into account but in practice none do (and it seems unlikely
  any ever will).
- fsconfig(2): mention that key, value, and aux must be 0 or NULL for
  FSCONFIG_CMD_RECONF.
- fsmount(2): fix usage of "filesystem instance" in relation to fsmount() and
  open_tree() comparison. [Askar Safin]
- move_mount(2): "as attached" -> "as a detached" [Askar Safin]
- fspick(2): add note about filesystem parameter list being copied rather than
  reset with FSCONFIG_CMD_RECONFIGURE. [Askar Safin]
- v3: <https://lore.kernel.org/r/20250809-new-mount-api-v3-0-f61405c80f34@cyphar.com>

Changes in v3:
- `sed -i s|Co-developed-by|Co-authored-by|g`. [Alejandro Colomar]
  - Add Signed-off-by for co-authors. [Christian Brauner]
- `sed -i s|needs-mount|awaiting-mount|g`, to match the kernel parlance.
- Fix VERSIONS/HISTORY mixup in mount_attr(2type) that was copied from
  open_how(2type). [Alejandro Colomar]
- Fix incorrect .BR usage in SYNOPSIS.
- Some more semantic newlines fixes. [Alejandro Colomar]
- Minor fixes suggested by Alejandro. [Alejandro Colomar]
- open_tree_attr(2): heavily reword everything to be better formatted
  and more explicit about its behaviour.
- open_tree(2): write proper explanatory paragraphs for the EXAMPLES.
- mount_setattr(2): fix stray doublequote in SYNOPSIS. [Askar Safin]
- fsopen(2): rework structure of the DESCRIPTION introduction.
- fsopen(2): explicitly say that read(2) errors in the message retrieval
  interface are actual errors, not return 0. [Askar Safin]
- fsopen(2): add BUGS section to describe the unfortunate -ENODATA
  message dropping behaviour that should be fixed by
  <https://lore.kernel.org/r/20250807-fscontext-log-cleanups-v3-0-8d91d6242dc3@cyphar.com/>.
- fsconfig(2): add a NOTES subsection about generic filesystem
  parameters.
- fsconfig(2): add comment about the weirdness surrounding
  FSCONFIG_SET_PATH.
- {fspick,open_tree}(2): Correct AT_NO_AUTOMOUNT description (copied
  from David, who probably copied it from statx(2)) -- AT_NO_AUTOMOUNT
  applies to all path components, not just the final one. [Christian
  Brauner]
- statx(2): fix AT_NO_AUTOMOUNT documentation.
- open_tree(2): swap open(2) reference for openat(2) when saying that
  the result is identical. [Askar Safin]
- fsmount(2): fix DESCRIPTION introduction, and rework attr_flags
  description to better reference mount_setattr(2).
- {fsopen,fspick,fsmount,open_tree}(2): don't use "attach" when talking
  about the file descriptors we return that reference in-kernel objects,
  to avoid confusing readers with mount object attachment status.
- fsconfig(2): remove pidns argument example, as it was kind of unclear
  and referenced kernel features not yet merged.
- fsconfig(2): remove rambling FSCONFIG_SET_PATH_EMPTY text (which
  mostly describes an academic issue that doesn't apply to any existing
  filesystem), and instead add a CAVEATS section which touches on the
  weird type behaviour of fsconfig(2).
- v2: <https://lore.kernel.org/r/20250807-new-mount-api-v2-0-558a27b8068c@cyphar.com>

Changes in v2:
- `make -R lint-man`. [Alejandro Colomar]
- `sed -i s|Glibc|glibc|g`. [Alejandro Colomar]
- `sed -i s|pathname|path|g` [Alejandro Colomar]
- Clean up macro usage, example code, and synopsis. [Alejandro Colomar]
- Try to use semantic newlines. [Alejandro Colomar]
- Make sure the usage of "filesystem context", "filesystem instance",
  and "mount object" are consistent. [Askar Safin]
- Avoid referring to these syscalls without an "at" suffix as "*at()
  syscalls". [Askar Safin]
- Use \% to avoid hyphenation of constants. [Askar Safin, G. Branden Robinson]
- Add a new subsection to mount_setattr(2) to describe the distinction
  between mount attributes and filesystem parameters.
- (Under protest) double-space-after-period formatted commit messages.
- v1: <https://lore.kernel.org/r/20250806-new-mount-api-v1-0-8678f56c6ee0@cyphar.com>

---
Aleksa Sarai (10):
      man/man2/mount_setattr.2: move mount_attr struct to mount_attr(2type)
      man/man2/fsopen.2: document "new" mount API
      man/man2/fspick.2: document "new" mount API
      man/man2/fsconfig.2: document "new" mount API
      man/man2/fsmount.2: document "new" mount API
      man/man2/move_mount.2: document "new" mount API
      man/man2/open_tree.2: document "new" mount API
      man/man2/mount_setattr.2: mirror opening sentence from fsopen(2)
      man/man2/open_tree{,_attr}.2: document new open_tree_attr() API
      man/man2/{fsconfig,mount_setattr}.2: add note about attribute-parameter distinction

 man/man2/fsconfig.2           | 739 ++++++++++++++++++++++++++++++++++++++++++
 man/man2/fsmount.2            | 231 +++++++++++++
 man/man2/fsopen.2             | 384 ++++++++++++++++++++++
 man/man2/fspick.2             | 342 +++++++++++++++++++
 man/man2/mount_setattr.2      |  63 +++-
 man/man2/move_mount.2         | 646 ++++++++++++++++++++++++++++++++++++
 man/man2/open_tree.2          | 638 ++++++++++++++++++++++++++++++++++++
 man/man2/open_tree_attr.2     |   1 +
 man/man2type/mount_attr.2type |  61 ++++
 9 files changed, 3092 insertions(+), 13 deletions(-)
---
base-commit: e86f9fd0c279f593242969a2fbb5ef379272d89d
change-id: 20250802-new-mount-api-436db984f432


Kind regards,
-- 
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/


