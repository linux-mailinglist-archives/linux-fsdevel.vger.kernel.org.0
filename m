Return-Path: <linux-fsdevel+bounces-40725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE293A27033
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 12:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 363591652FA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 11:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CD420C02C;
	Tue,  4 Feb 2025 11:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jP/mkXC7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5E1206F1B
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Feb 2025 11:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738668534; cv=none; b=XL/p7+O+1fXlR0C2SSEZF+S0ThuYF3cUGlbfNcBQl6KQfsZ0vzj9E1i96BZ5sTwsdGlQhZX6oR6VgeiQDlkPBAetnd6phPlHP/eZmNHrRV8M6+taynuTaGjvjsqa5MtdALe8Ejy6k9fWwCuRc20QEaX9GLUOFcHDKclTzBvT0VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738668534; c=relaxed/simple;
	bh=xkHkkJnMEQc5PL5bXpAoqoQePstddOLJAQCZevn8JKY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fegFm1qg05/7NAAG0xt8jb9fW+YT1xTU6WdIcN7Jz1A39Ic3LBAbeCMlHGfm2NrdpEl0Ziaq0kt/LwXdMyiqCZGQRmYQXvPmFvSGBfyR5OQvJlB0A3Uq5cwlxVFhncT/31BWQDoB8/ig22CiAkUC+vel0ZaF8kAJUkFV8AF0JvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jP/mkXC7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8669C4CEDF;
	Tue,  4 Feb 2025 11:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738668532;
	bh=xkHkkJnMEQc5PL5bXpAoqoQePstddOLJAQCZevn8JKY=;
	h=From:Subject:Date:To:Cc:From;
	b=jP/mkXC7GSWVhfssbG1yYahI4hZU27TSBqQmWk7qhCV6BnzGkE54rHE9TkM2K2Qu/
	 dF/wL0faHXrRUPL7FBOweOw/TnlWUFRXeFADGs0HrwVr48XLKJPN+c1AKRzE0Gc8j1
	 8KP5jOvZAidneR2P45A21tyFwfZANIcZ/tV3LedBH4GYgirm25DQoJVS1mdt1v6fo5
	 J9HjTJYV5otMr8h8NxXhUthePS22XrWeA66n7FJSuuePsN0RZ29vkYdGyuDz+zaAp8
	 Z/eDsjmQubn3lGXre0xLGjbxht2R33p2v9rnsnDUYFzyvueiEgnNJ0VpS2rb4F6P/A
	 9td/KQv8XHT3A==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 0/4] statmount: allow to retrieve idmappings
Date: Tue, 04 Feb 2025 12:28:45 +0100
Message-Id: <20250204-work-mnt_idmap-statmount-v2-0-0ef9b19b27c3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO35oWcC/3WOwQ6CMBAFf4X07JK2gqAn/8MQU8oCDbYl24oaw
 r8LxKvHOcybN7OAZDCwSzIzwskE490K8pAw3SvXIZhmZSa5zLmQZ3h5GsC6eDeNVSOEqKL1Txc
 B86KVedliWyJb9ZGwNe99+latXKuAUJNyut8GrQoRKZ1OqciAtNiU3oTo6bOfmcQm/rpH/r87C
 eDQZBqbvCwyFNl1QHL4SD11rFqW5QvEp54Z5AAAAA==
X-Change-ID: 20250129-work-mnt_idmap-statmount-e57f258fef8e
To: linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Seth Forshee <sforshee@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-d23a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=4228; i=brauner@kernel.org;
 h=from:subject:message-id; bh=xkHkkJnMEQc5PL5bXpAoqoQePstddOLJAQCZevn8JKY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQv/PnJ6c/2yYLf1i2ZczVEcUXH71OBf67vCrgzZef/E
 4G/mCbyRnWUsjCIcTHIiimyOLSbhMst56nYbJSpATOHlQlkCAMXpwBMRO0rwy8mKVEt+Y9rQtVf
 OV5b/vXM5RcK+sdEvPP9Fm07s+z7myv9jAxfdLW7m2cxKXqlsLAY7BW5xHnCPbgp7pB7Xp78ztA
 9RzgB
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

This adds the STATMOUNT_MNT_UIDMAP and STATMOUNT_MNT_GIDMAP options.
It allows the retrieval of idmappings via statmount().

Currently it isn't possible to figure out what idmappings are applied to
an idmapped mount. This information is often crucial. Before statmount()
the only realistic options for an interface like this would have been to
add it to /proc/<pid>/fdinfo/<nr> or to expose it in
/proc/<pid>/mountinfo. Both solution would have been pretty ugly and
would've shown information that is of strong interest to some
application but not all. statmount() is perfect for this.

The idmappings applied to an idmapped mount are shown relative to the
caller's user namespace. This is the most useful solution that doesn't
risk leaking information or confuse the caller.

For example, an idmapped mount might have been created with the
following idmappings:

    mount --bind -o X-mount.idmap="0:10000:1000 2000:2000:1 3000:3000:1" /srv /opt

Listing the idmappings through statmount() in the same context shows:

    mnt_id:        2147485088
    mnt_parent_id: 2147484816
    fs_type:       btrfs
    mnt_root:      /srv
    mnt_point:     /opt
    mnt_opts:      ssd,discard=async,space_cache=v2,subvolid=5,subvol=/
    mnt_uidmap[0]: 0 10000 1000
    mnt_uidmap[1]: 2000 2000 1
    mnt_uidmap[2]: 3000 3000 1
    mnt_gidmap[0]: 0 10000 1000
    mnt_gidmap[1]: 2000 2000 1
    mnt_gidmap[2]: 3000 3000 1

But the idmappings might not always be resolvable in the caller's user
namespace. For example:

    unshare --user --map-root

In this case statmount() will skip any mappings that fil to resolve in
the caller's idmapping:

    mnt_id:        2147485087
    mnt_parent_id: 2147484016
    fs_type:       btrfs
    mnt_root:      /srv
    mnt_point:     /opt
    mnt_opts:      ssd,discard=async,space_cache=v2,subvolid=5,subvol=/

The caller can differentiate between a mount not being idmapped and a
mount that is idmapped but where all mappings fail to resolve in the
caller's idmapping by check for the STATMOUNT_MNT_{G,U}IDMAP flag being
raised but the number of mappings in ->mnt_{g,u}idmap_num being zero.

Note that statmount() requires that the whole range must be resolvable
in the caller's user namespace. If a subrange fails to map it will still
list the map as not resolvable. This is a practical compromise to avoid
having to find which subranges are resovable and wich aren't.

Idmappings are listed as a string array with each mapping separated by
zero bytes. This allows to retrieve the idmappings and immediately use
them for writing to e.g., /proc/<pid>/{g,u}id_map and it also allow for
simple iteration like:

    if (stmnt->mask & STATMOUNT_MNT_UIDMAP) {
            const char *idmap = stmnt->str + stmnt->mnt_uidmap;

            for (size_t idx = 0; idx < stmnt->mnt_uidmap_nr; idx++) {
                    printf("mnt_uidmap[%lu]: %s\n", idx, idmap);
                    idmap += strlen(idmap) + 1;
            }
    }

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Changes in v2:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v1: https://lore.kernel.org/r/20250130-work-mnt_idmap-statmount-v1-0-d4ced5874e14@kernel.org

---
Christian Brauner (4):
      uidgid: add map_id_range_up()
      statmount: allow to retrieve idmappings
      samples/vfs: check whether flag was raised
      samples/vfs: add STATMOUNT_MNT_{G,U}IDMAP

 fs/internal.h                      |  1 +
 fs/mnt_idmapping.c                 | 51 ++++++++++++++++++++++++++++++++
 fs/namespace.c                     | 59 +++++++++++++++++++++++++++++++++++++-
 include/linux/mnt_idmapping.h      |  5 ++++
 include/linux/uidgid.h             |  6 ++++
 include/uapi/linux/mount.h         |  8 +++++-
 kernel/user_namespace.c            | 26 +++++++++++------
 samples/vfs/samples-vfs.h          | 14 ++++++++-
 samples/vfs/test-list-all-mounts.c | 35 ++++++++++++++++++----
 9 files changed, 187 insertions(+), 18 deletions(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250129-work-mnt_idmap-statmount-e57f258fef8e


