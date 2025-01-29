Return-Path: <linux-fsdevel+bounces-40349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E29A226CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 00:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8598188732A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 23:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BA41BC07B;
	Wed, 29 Jan 2025 23:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPKHzj5Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC8242A92
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 23:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738192838; cv=none; b=C1jmdEKNDT6eBUfa14P8Vto2GNepDGaLez1yEcgZEPY1d5Z1FJw+J8gQdwMfw/gWRljbCxZT3ZDXZ1UVcX+LleaVufSDtVlbZQRjJbrt1MbJ9dM6swJD3k2L6OiJGp1wAakYtItld0Bx7xr/TqffEEf9FV9HGV4NtS4yBVZl8Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738192838; c=relaxed/simple;
	bh=wuP5LjyIOfkc63oS+Y0oV55p0qPBr73NP5m13A7196g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LiQf8XbnhFPPnnhQYOLgImRAktOK72FzhfTG1q7kN4s15g6paD6k65J7j2oXVe0Ic9nY8i/urHAxswd6yDZeyoQqPcZE9X//dRFSYl8bieBtSF/JEpm1hrr4QJZcc8KgSEvKxGNSBc5uUmrSm6XTux3jYQ9wls8P06W1RbB34iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPKHzj5Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1791C4CED1;
	Wed, 29 Jan 2025 23:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738192837;
	bh=wuP5LjyIOfkc63oS+Y0oV55p0qPBr73NP5m13A7196g=;
	h=From:Subject:Date:To:Cc:From;
	b=RPKHzj5ZCIgqFOwboNm8dPj+TUDnf4tDFRHSdQsihUox643b76NJHCUVc56LN3sKQ
	 0/1sEc4SNSznLZI9IhM7xQ4k5J8hN1UO7BHGn8EOeZ7DzlQkNkpgrBtjz8eutdxDwg
	 TbB8otrv2HzWe9dGMGpOnUhb69ObsC51eBCtfxBRtr5LxcYqysI3wYzOl35gAez0g4
	 rdHRNW4b8cMOYSsQefDK11g8HmLK8wVTMVk3YkDzbjb1eyCHGBvUhmX1L1WMmpztbv
	 jjwrnEZjRYrdS8aeZUdG4+IWC+ql77MYdAWdwEGhIiB6OZX5vdR4infD/FoyFAa+Qi
	 Zv7cN6klsV79w==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/4] statmount: allow to retrieve idmappings
Date: Thu, 30 Jan 2025 00:19:50 +0100
Message-Id: <20250130-work-mnt_idmap-statmount-v1-0-d4ced5874e14@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJa3mmcC/x3MTQrCMBBA4auUWTuSBoLRq4jItJ3YQZKUTPyB0
 rubuvwW762gXIQVLt0Khd+iklNDf+hgnCk9GGVqBmusM7094yeXJ8ZU7zJFWlAr1ZhfqSK7U7D
 OBw6eoeVL4SDf//p6ax5IGYdCaZz3YSStXI77F02P1sO2/QAJcJP0jgAAAA==
X-Change-ID: 20250129-work-mnt_idmap-statmount-e57f258fef8e
To: linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Seth Forshee <sforshee@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-d23a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=4036; i=brauner@kernel.org;
 h=from:subject:message-id; bh=wuP5LjyIOfkc63oS+Y0oV55p0qPBr73NP5m13A7196g=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTP2n54idHU3Va74/rvlTXI+0kali/aHGCRaWzQ1dK8y
 G5P8Tz+jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkISTL84SyfZlEad/Jp4TbR
 Txaf/fI3/O0p/351+3cz31c9gS9a2RkZVs0+9uCT09TdWy2Xyc3buWmWmkWHk9Pu8wn+WTr312x
 cywUA
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

But the idmappings might not always be resolvablein the caller's user
namespace. For example:

    unshare --user --map-root

In this case statmount() will indicate the failure to resolve the idmappings
in the caller's user namespace by listing 4294967295 aka (uid_t) -1 as
the target of the mapping while still showing the source and range of
the mapping:

    mnt_id:        2147485087
    mnt_parent_id: 2147484016
    fs_type:       btrfs
    mnt_root:      /srv
    mnt_point:     /opt
    mnt_opts:      ssd,discard=async,space_cache=v2,subvolid=5,subvol=/
    mnt_uidmap[0]: 0 4294967295 1000
    mnt_uidmap[1]: 2000 4294967295 1
    mnt_uidmap[2]: 3000 4294967295 1
    mnt_gidmap[0]: 0 4294967295 1000
    mnt_gidmap[1]: 2000 4294967295 1
    mnt_gidmap[2]: 3000 4294967295 1

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
Christian Brauner (4):
      uidgid: add map_id_range_up()
      statmount: allow to retrieve idmappings
      samples/vfs: check whether flag was raised
      samples/vfs: add STATMOUNT_MNT_{G,U}IDMAP

 fs/internal.h                      |  1 +
 fs/mnt_idmapping.c                 | 49 ++++++++++++++++++++++++++++++++++++++
 fs/namespace.c                     | 43 ++++++++++++++++++++++++++++++++-
 include/linux/uidgid.h             |  6 +++++
 include/uapi/linux/mount.h         |  8 ++++++-
 kernel/user_namespace.c            | 26 +++++++++++++-------
 samples/vfs/samples-vfs.h          | 14 ++++++++++-
 samples/vfs/test-list-all-mounts.c | 35 ++++++++++++++++++++++-----
 8 files changed, 164 insertions(+), 18 deletions(-)
---
base-commit: 6d61a53dd6f55405ebcaea6ee38d1ab5a8856c2c
change-id: 20250129-work-mnt_idmap-statmount-e57f258fef8e


