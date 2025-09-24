Return-Path: <linux-fsdevel+bounces-62600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDE1B9AAB5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 17:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0F6E162D91
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 15:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B8A30BBA1;
	Wed, 24 Sep 2025 15:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="MQEoGKpt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA36A2E413;
	Wed, 24 Sep 2025 15:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758727919; cv=none; b=m2KjeV1GTVEPDNB4JbmWxWuy0F99vC7Qg4r2DgAVLOiccgZU1uhz8HR4sZ33G2JEeMUSILS7SKS81eNAcp7+yrkMiCqgeRa7Qkt9OneL6WpZ0Cq4TAF/7E0+yN2n2eWQLeuVuEFANtPhwrJh+zub0SD4ie1pDiqiLzb6+sRQDDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758727919; c=relaxed/simple;
	bh=RYmApJRpGcmv7ryHg5hMRmwpXEO0gnqWc04aAnNESU4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cmlAAx7YpdEHiTznhs0lLvgeT5ROBOu1Er/PzVlbvEd+OMdNfCHurPKFE/6jsRAh+iGrkcgTEciYGZSKs08kgEcuyCdeMA4mirZk0Nvw2GT2MbFcX3cXhhmuz16Nhb4A3qtSdcB02W40I7mEzoq37/xLeVYc+DitEthOD+xF31Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=MQEoGKpt; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cX16c2WQsz9tV9;
	Wed, 24 Sep 2025 17:31:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1758727912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sISpQHkJ7HtZ7mkRFjNstox+zcEcRrLorQFGn8KcrbE=;
	b=MQEoGKptVRyT1mRDmtne+s1p3wFNQ70AEzHy69bVtPFtGCHw3IrgJjdDJuuDghM1XqU4bS
	U7lHQXkP8QYF4WHbO3Dcnv0fC3iUXuZlwCAyoT4wsYCNRONy7JzPaMane9x2QDw8iF809C
	Y/qOb6xId3kYTp3NwyPHbK5f9FOUhNAB+gUIaRAS8urVdLbzVb5ko92VAqVP9a5QkA1yA+
	OTsP8EWuVqwrs0g4hGvEhuck1niFrOpcrZHj7wU7WhP6XQW3edExs1S3cGaI5e8RJaiQyz
	g1Bmf5HBt840wXP8WNDHfK0Nb9A34W1XN+PSulodKrTM6zbYVl9k+thZU9IfqQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
From: Aleksa Sarai <cyphar@cyphar.com>
Subject: [PATCH v5 0/8] man2: document "new" mount API
Date: Thu, 25 Sep 2025 01:31:22 +1000
Message-Id: <20250925-new-mount-api-v5-0-028fb88023f2@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMoO1GgC/2XMSw6CMBSF4a2Qjq1pbx8UR+7DOCillQ54pCBKC
 Hu3kBgRhuck3z+hzgZvO3RJJhTs4Dvf1HGIU4JMqeuHxb6IGwEBQRQBXNsXrppn3WPdesyZLPJ
 McccZoGjaYJ1/r73bPe7Sd30TxjU/0OX9luSuNFBMsJKpckIaaS25mrEtdTibpkJLaoAtT/ccI
 hdCaUjzGFfmwNmWZ3vOIneSciKMIo7xA+c/ntED55FTkBQI1bmQ8Mfnef4A+bsdHWgBAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11660; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=RYmApJRpGcmv7ryHg5hMRmwpXEO0gnqWc04aAnNESU4=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWRc4bvTP9M97m1g/6UHK61viu1LiHs9SXlrwMlr795Nu
 HGu8mWVW8dEFgYxLgZLMUWWbX6eoZvmL76S/GklG8wcViaQIdIiDQwMDAwsDHy5iXmlRjpGeqba
 hnqGhjpGOkYMXJwCMNWy9YwMh2J/a/3XWLqmY+HNHDnBiXwSPr5G9ezduSdqJL04w6WDGP4pKtl
 Ji+mFr7yzVGq+gYf+0tIKvcB5tvvXmjD5nDI0XcUHAA==
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4cX16c2WQsz9tV9

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
Changes in v5:
- `sed -i s|file descriptor based|file-descriptor-based|`.
  [Alejandro Colomar]
- fsconfig(2): use bullets instead of ordered list for workflow
  description. [Alejandro Colomar]
- mount_setattr(2): fix minor wording nit in new attribute-parameter
  subsection.
- fsopen(2): remove brackets around "message" for message retrieval
  interface description. [Alejandro Colomar]
- {move_mount,fspick}(2): fix remaining incorrect no-automount text.
  [Askar Safin]
- {fsmount,open_tree}(2): `sed -i s|MOUNT_DETACH|MNT_DETACH|g`.
  [Askar Safin]
- mount_setattr(2): fix copy-paste snafu in attribute-parameter
  subsection. [Askar Safin]
- *: clean `make -R build-catman-troff`. [Alejandro Colomar]
- *: switch to \[em]\c where appropriate.
- open_tree(2): clean up MNT_DETACH-on-close description and make it
  slightly more prominent. [Alejandro Colomar]
- open_tree(2): mention the distinction from open(O_PATH) with regards
  to automounts. Askar suggested it be put in the section about
  ~OPEN_TREE_CLONE, but the change in behaviour also applies to
  OPEN_TREE_CLONE and it looked awkward to include it in the
  dentry_open() case because O_PATH only gets mentioned in the following
  paragraph (where I've put the text now). [Askar Safin]
- {move_mount,open_tree{,_attr}}(2): fix column-width-related "make -R
  check" failures.
- *: fix remaining "make -R lint" failures.
- open_tree_attr(2): add example using MOUNT_ATTR_IDMAP.
- v4: <https://lore.kernel.org/r/20250919-new-mount-api-v4-0-1261201ab562@cyphar.com>

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
- open_tree(2): mention that any mount propagation events while the
  mount object is detached are completely lost -- i.e., they don't get
  replayed once you attach the mount somewhere.
- fsconfig(2): fix minor grammatical / missing joining word issues.
- fsconfig(2): fix final leftover `.IR A " and " B` cases.
- fsconfig(2): explain that failed fsconfig(FSCONFIG_CMD_*) operations
  render the filesystem context invalid.
- fsconfig(2): rework the description of superblock reuse, as the
  previous text was very wrong. (Though there has been discussion about
  changing this behaviour...)
- fsconfig(2): remove misleading wording in FSCONFIG_CMD_CREATE_EXCL
  about how we are requesting a new filesystem instance -- in theory
  filesystems could take this request into account but in practice none
  do (and it seems unlikely any ever will).
- fsconfig(2): mention that key, value, and aux must be 0 or NULL for
  FSCONFIG_CMD_RECONF.
- fsmount(2): fix usage of "filesystem instance" in relation to
  fsmount() and open_tree() comparison. [Askar Safin]
- move_mount(2): "as attached" -> "as a detached" [Askar Safin]
- fspick(2): add note about filesystem parameter list being copied
  rather than reset with FSCONFIG_CMD_RECONFIGURE. [Askar Safin]
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
Aleksa Sarai (8):
      man/man2/fsopen.2: document "new" mount API
      man/man2/fspick.2: document "new" mount API
      man/man2/fsconfig.2: document "new" mount API
      man/man2/fsmount.2: document "new" mount API
      man/man2/move_mount.2: document "new" mount API
      man/man2/open_tree.2: document "new" mount API
      man/man2/open_tree{,_attr}.2: document new open_tree_attr() API
      man/man2/{fsconfig,mount_setattr}.2: add note about attribute-parameter distinction

 man/man2/fsconfig.2       | 741 ++++++++++++++++++++++++++++++++++++++++++++++
 man/man2/fsmount.2        | 231 +++++++++++++++
 man/man2/fsopen.2         | 385 ++++++++++++++++++++++++
 man/man2/fspick.2         | 343 +++++++++++++++++++++
 man/man2/mount_setattr.2  |  39 +++
 man/man2/move_mount.2     | 646 ++++++++++++++++++++++++++++++++++++++++
 man/man2/open_tree.2      | 709 ++++++++++++++++++++++++++++++++++++++++++++
 man/man2/open_tree_attr.2 |   1 +
 8 files changed, 3095 insertions(+)
---
base-commit: f17990c243eafc1891ff692f90b6ce42e6449be8
change-id: 20250802-new-mount-api-436db984f432


Kind regards,
-- 
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/


