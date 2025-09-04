Return-Path: <linux-fsdevel+bounces-60222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AD2B42DCC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 02:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DE731895D17
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 00:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2D8749C;
	Thu,  4 Sep 2025 00:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="z/Nxg2Wz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kIu2jTz+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B748C15D1;
	Thu,  4 Sep 2025 00:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756944310; cv=none; b=HkAezbe6YdpnVJydkimp8/alKVgdzHaSzkcef1xsB3wc57Tj9YQKzXNTilazxX0laOvHphzOmaTNqeOVxuO4x08bz5U5m9Pzw/l4Zl4cOCXiZVrsoseyGzAFFXaPgMOSFENE9e0+myBwMWanBr7gM4+2xpedBOKLvMVFoVXz+6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756944310; c=relaxed/simple;
	bh=ZAJf0nLRcJlZlTx7A2TNbBvgSmi5ZwHN0LK45NTPAaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oTeADb8KaPZ+m4BVwN5C39Y97Fih4PnLGXX6ZzYc59fu/4MwRzhlUXLIIRsP6IrYUnY9ooaW14H+ylyumFVRZndKN7G+NCw6Tc4v3pfSVT58P2Hci8BgcUUBowGtsDjKY9FST2V6Eqcxl23Zrk9Lh9iKuD6XQoY3PE6F5GCq52M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=z/Nxg2Wz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kIu2jTz+; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id EBEDBEC00FD;
	Wed,  3 Sep 2025 20:05:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 03 Sep 2025 20:05:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1756944306; x=1757030706; bh=5h
	I2HFEsKvGreKEA2r0Ojv7MP5qEzL0WZM03hVBdSPg=; b=z/Nxg2Wzrr6RsRcJK7
	k2OocOSYDDtK6c9P2jR1qnHhM5JowjJnqspGq41fmZiaSn/PxR1rtB88B8SwRQPi
	eqd9cannhmK7sdDr87a8xN+TLSBNpyrf6HBsMsl14S/zdTkGqhzoW3JCSs/IxhP3
	YtkQCL3nzOd5QSjNkkd62LOa9WioZx38rfl+82I5aDVNVI1D8P4ldHjvFswto51K
	C9RUAZMF4VnB6AEJOJLvDyThTeQmsz0aA0PYFpNEFO81rJQ2KsEVVqxcxB6Knmvz
	2WGedAYovB1aKCQAa5X/JEjegCjrwJrMsEU1/g+Td05ke/o7ZJZQW3FJY/9Jtzix
	5eTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1756944306; x=1757030706; bh=5hI2HFEsKvGreKEA2r0Ojv7MP5qE
	zL0WZM03hVBdSPg=; b=kIu2jTz+1+OAskk+71P8FzY9ekI0yyO5UmFaBEliocx4
	laA8rvtQtUtJwby8CZe0C5O5MkYqh94Vi0x4ApQ2/BfsygXgYW0s2j6GOcMKGDFw
	cbcqRtN+fSNkNdpNfP2iJLomujOvuK5kAz15YUlQKF6SeI9SLn74pVpkHBwxzg0D
	yHJt21WW0biU54e5Tb6wW9Ta4+8zX8cYMHid0Id3B+RwQfaAOPDjZTNpb7ilOFIH
	nVLOgw/dhojM5gqRFR8wcNlZ+k3panbLJh7vg1Z+n5qrlhO4W8/UdxGso0DyXhh1
	3Zo5hH8U+L+5K/JwMJ0rWpwkcr0YO99RukUd8z8mXw==
X-ME-Sender: <xms:sde4aACxkOPoQ5OpVgcf1aqXBu59DUOGTgdnM3WLcEA3Iqa9C0LS3Q>
    <xme:sde4aOX8Z7xKa5D2kbOLLLjrBhj0smCJ-_mjEZQFQNSHaZzPTTmYjvIzjdb2tXWXb
    U1hKXLUWnyQEnrr_5A>
X-ME-Received: <xmr:sde4aKCP_3lKeRcIEOS1AUtyMAlCIYKX9sJdD7yMXrRCOaqnpVY-9VMfJ-SOxZgJ6qDYbZyPonu5nEoqAGePsNQLEVYaRp2b_UKT604R14UbY7ths44XVbNyGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpefvihhnghhmrghoucgh
    rghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepveffgfevhf
    evheeuffetteduveekgfekudeludfhieegvdeugeeiueeuiedtffehnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghdpmhgrohifthhmrdhorhhgpdhgihhthhhusgdrtghomhdpqh
    gvmhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepmhesmhgrohifthhmrdhorhhgpdhnsggprhgtphhtthhopedugedpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtoheprghsmhgruggvuhhssegtohguvgifrhgvtghkrdho
    rhhgpdhrtghpthhtohepvghrihgtvhhhsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hluhgthhhosehiohhnkhhovhdrnhgvthdprhgtphhtthhopehlihhnuhigpghoshhssegt
    rhhuuggvsgihthgvrdgtohhmpdhrtghpthhtohepmhhitgesughighhikhhougdrnhgvth
    dprhgtphhtthhopehmsehmrghofihtmhdrohhrghdprhgtphhtthhopehvlehfsheslhhi
    shhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehgnhhorggtkhesghhoohhglhgvrd
    gtohhmpdhrtghpthhtoheplhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:sde4aDfshEiDYYxEK1eD0AIl2jhcahRwc5P7Zg9P1hgVzJJusoWMfg>
    <xmx:sde4aJpwMPXIKxL_cnNApcNdpFPydl3E06cC4i72oHRGdgxDZJyreA>
    <xmx:sde4aMS9paUbVMz-ll6gUBY0376FYhthr23H7uzpUOFexxDJ9PWU1A>
    <xmx:sde4aBW0Ua9zwcvtbHsg2719IrL_HVFqIAVQG-CcL-nA_eOMrJ7v9A>
    <xmx:ste4aFz-L7V_pdhRQrZtSHLqyAlyFFIzXmrhxn_SCMOWfcYzoYN9zm7K>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 20:05:03 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: Dominique Martinet <asmadeus@codewreck.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	v9fs@lists.linux.dev,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Matthew Bobrowski <repnop@google.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 0/7] fs/9p: Reuse inode based on path (in addition to qid)
Date: Thu,  4 Sep 2025 01:04:10 +0100
Message-ID: <cover.1756935780.git.m@maowtm.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi!

This is the second version of this series.  The individual commits
contains changelogs (most of them are in the first patch), but overall,
most significantly cached mode (loose or metadata) is now unchanged, there
is no longer a "don't reuse inodes at all" mode, bug fixes, using the
right functions, basic rename handling, and new documentation.

Thanks in advance for the review effort :)

v1: https://lore.kernel.org/all/cover.1743971855.git.m@maowtm.org/

Background
----------

(This section has basically the same content as the v1 cover letter)

Previously [1], I noticed that when using 9pfs filesystems, the Landlock
LSM is blocking access even for files / directories allowed by rules, and
that this has something to do with 9pfs creating new inodes despite
Landlock holding a reference to the existing one.  Because Landlock uses
inodes' in-memory state (i_security) to identify allowed fs
objects/hierarchies, this causes Landlock to partially break on 9pfs, at
least in uncached mode, which is the default:

    # mount -t 9p -o trans=virtio test /mnt
    # env LL_FS_RO=/etc:/usr:/bin:/lib:/mnt/readme LL_FS_RW= /sandboxer bash
    Executing the sandboxed command...
    # cat /mnt/readme
    cat: /mnt/readme: Permission denied

This, however, works if somebody is holding onto the dentry (and it also
works with cache=loose), as in both cases the inode is reused:

    # tail -f /mnt/readme &
    [1] 196
    # env LL_FS_RO=/etc:/usr:/bin:/lib:/mnt/readme LL_FS_RW= /sandboxer bash
    Executing the sandboxed command...
    # cat /mnt/readme
    aa

It also works on directories if one have a shell that cd into the
directory.  Note that this means only certain usage of Landlock are
affected - for example, sandboxing applications that takes a list of files
to allow, landlocks itself, then evecve.  On the other hand, this does not
affect applications that opens a file, then Landlocks itself while keeping
the file it needs open.

While the above is a very simple example, this is problematic in
real-world use cases if Landlock is used to sandox applications on system
that has files mounted via 9pfs, or use 9pfs as the root filesystem.  In
addition, this also affects fanotify / inotify when using inode mark (for
local access):

    root@d8c28a676d72:/# ./fanotify-basic-open /readme & # on virtiofs
    [1] 173
    root@d8c28a676d72:/# cat readme
    aa
    FAN_OPEN: File /readme
    root@d8c28a676d72:/# mount -t 9p -o trans=virtio test /mnt
    root@d8c28a676d72:/# ./fanotify-basic-open /mnt/readme & # on 9pfs
    [2] 176
    root@d8c28a676d72:/# cat /mnt/readme
    aa
    root@d8c28a676d72:/#

Same can be demonstrated with inotifywait.  The source code for
fanotify-basic-open, adopted from the fanotify man page, is available at
https://fileshare.maowtm.org/9pfs-landlock-fix/20250903/fanotify-basic-open.c [2].

Note that this is not a security bug for Landlock since it can only cause
legitimate access to be denied, but might be a problem for fanotify perm
(although I do recognize that using perm on individual inodes is already
perhaps a bit unreliable?)

It seems that there was an attempt at making 9pfs reuse inodes on uncached
mode as well, based on qid.path, however it was reverted [3] due to issues
with servers that present duplicate qids, for example on a QEMU host that
has multiple filesystems mounted under a single 9pfs export without
multidevs=remap, or in the case of other servers that doesn't necessarily
support remapping qids ([4] and more).  I've done some testing on
v6.12-rc4 which has the simplified 9pfs inode code before it was reverted,
and found that Landlock works (however, we of course then have the issue
demonstrated in [3]).

What this series do
-------------------

(Changes since v1: added more reasoning for the ino_path struct)

With the above in mind, I have a proposal for 9pfs to:
1. Reuse inodes even in uncached mode
2. However, reuse them based on qid.path AND the actual pathname, by doing
   the appropriate testing in v9fs_test_inode(_dotl)?

The main problem here is how to store the pathname in a sensible way and
tie it to the inode.  For now I opted with an array of names acquired with
take_dentry_name_snapshot, which reuses the same memory as the dcache to
store the actual strings, but doesn't tie the lifetime of the dentry with
the inode (I thought about holding a reference to the dentry in the
v9fs_inode, but it seemed like a wrong approach and would cause dentries
to not be evicted/released).

Additional discussions
----------------------

(New section)

From some QEMU documentation I read [5] it seems like there is a plan to
resolve these kind of problems in a new version of the protocol, by
expanding the qid to include the filesystem identifier of a file on the
host, so maybe this can be disabled after a successful protocol version
check with the host?  For now, inodeident=path will be the default for
uncached filesystems, which can be set to 'qid' to instead to reuse based
only on server-provided inode numbers.

This patchset currently uses strncmp to compare paths but this might be
able to be optimized into a hash comparison first (not done yet).
Alternatively the path can be stored more compactly in the form of a
single string with `/` in it (like normal paths).  However, we should
normally only need to do this comparison for one pair of filenames, as the
test is only done if qid.path matches in the first place.

This patchset currently does not support enabling path-based inodes in
cached mode.  Additional care needs to be taken to ensure we can refresh
an inode that potentially has data cached, but since Dominique is happy
with cached mode behaving as-is (reusing inodes via qid only), this is not
done.

The current implementation will handle client-side renames of a single
file (or empty directory) correctly, but server side renames, or renaming
a non-empty directory (client or server side), will cause the files being
renamed (or files under the renamed directory) to use new inodes (unless
they are renamed back).  The decision to not update the children of a
client-renamed directory is purely to reduce the complexity of this patch,
but is in principle possible.

Testing and explanations
------------------------

(New section)

    # mount -t 9p -o ... test /mnt
        with the following options:
        - trans=virtio
        - trans=virtio,inodeident=qid
        - trans=virtio,cache=loose
    # env LL_FS_RO=/etc:/usr:/bin:/lib:/mnt/readme LL_FS_RW= /sandboxer bash
    Executing the sandboxed command...
    # cat /mnt/readme
    hi
    ^^ landlock works

    # mount -t 9p -o trans=virtio test /mnt
    # mkdir /mnt/dir
    # mv /mnt/readme /mnt/dir/readme
    # env LL_FS_RO=/etc:/usr:/bin:/lib:/mnt/dir/readme LL_FS_RW= /sandboxer bash
    Executing the sandboxed command...
    # cat /mnt/dir/readme
    hi
    ^^ landlock works

    # # another terminal in guest: mv /mnt/dir/readme /mnt/dir/readme.2
    # cat /mnt/dir/readme.2
    hi
    ^^ ino_path is carried with renames

    # # host: mv 9pfs/dir/readme.2 9pfs/dir/readme
    # cat /mnt/dir/readme.2
    cat: /mnt/dir/readme.2: No such file or directory
    # cat /mnt/dir/readme
    cat: /mnt/dir/readme: Permission denied
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ we can't track renames on the server side
    # # host: mv 9pfs/dir/readme 9pfs/dir/readme.2
    # cat /mnt/dir/readme.2
    hi
    ^^ once the file is back at its original place it works as expected.

    # # another terminal in guest: mv /mnt/dir/readme.2 /mnt/dir/readme
    # cat /mnt/dir/readme
    hi
    ^^ we can track renames of the file directly...
    # # another terminal in guest: mv /mnt/dir /mnt/dir.2
    # cat /mnt/dir.2/readme
    cat: /mnt/dir.2/readme: Permission denied
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ but not renames of the parent directory, even if done client-side

    # # another terminal in guest: mv /mnt/dir.2 /mnt/dir
    # cat /mnt/dir/readme
    hi
    ^^ works once it's back
    # # another terminal in guest: mv /mnt/dir /mnt/dir.2 && mkdir /mnt/dir && echo hi2 > /mnt/dir/readme
    # cat /mnt/dir/readme
    cat: /mnt/dir/readme: Permission denied
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ a different file uses a different inode even if same path

    # # another terminal in guest: mv /mnt/dir.2/readme /mnt/dir/readme
    # cat /mnt/dir/readme
    hi
    # # host: rm 9pfs/dir/readme && echo hi3 > 9pfs/dir/readme
    # cat /mnt/dir/readme
    cat: /mnt/dir/readme: Permission denied
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ a different file (identified by server-side qid changes) uses different inode

fanotify also works, as tested with the program attached at the end.

In addition, I ran xfstests on a uncached 9pfs mount, and while there are
some test failures, it is the same set of failures as on the current
mainline.  Test logs at https://fileshare.maowtm.org/9pfs-landlock-fix/20250903/index.html

Tested also with Mickaël's new v9fs landlock tests [6] (unmerged yet):

    #  RUN           layout3_fs.v9fs.tag_inode_dir_parent ...
    #            OK  layout3_fs.v9fs.tag_inode_dir_parent
    ok 129 layout3_fs.v9fs.tag_inode_dir_parent
    #  RUN           layout3_fs.v9fs.tag_inode_dir_mnt ...
    #            OK  layout3_fs.v9fs.tag_inode_dir_mnt
    ok 130 layout3_fs.v9fs.tag_inode_dir_mnt
    #  RUN           layout3_fs.v9fs.tag_inode_dir_child ...
    #            OK  layout3_fs.v9fs.tag_inode_dir_child
    ok 131 layout3_fs.v9fs.tag_inode_dir_child
    #  RUN           layout3_fs.v9fs.tag_inode_file ...
    #            OK  layout3_fs.v9fs.tag_inode_file
    ok 132 layout3_fs.v9fs.tag_inode_file
    #  RUN           layout3_fs.v9fs.release_inodes ...
    #            OK  layout3_fs.v9fs.release_inodes
    ok 133 layout3_fs.v9fs.release_inodes

This patch series was based on, and mostly tested on v6.17-rc1 + [7]

Kind regards,
Tingmao

[1]: https://github.com/landlock-lsm/linux/issues/45
[2]: https://fileshare.maowtm.org/9pfs-landlock-fix/20250903/fanotify-basic-open.c
[3]: https://lore.kernel.org/all/20241024-revert_iget-v1-4-4cac63d25f72@codewreck.org/
[4]: https://lore.kernel.org/all/20240923100508.GA32066@willie-the-truck/
[5]: https://wiki.qemu.org/Documentation/9p#Protocol_Plans
[6]: https://lore.kernel.org/all/20250704171345.1393451-1-mic@digikod.net/
[7]: https://lore.kernel.org/all/cover.1743956147.git.m@maowtm.org/

Tingmao Wang (7):
  fs/9p: Add ability to identify inode by path for .L in uncached mode
  fs/9p: add option for path-based inodes
  fs/9p: Add ability to identify inode by path for non-.L in uncached
    mode
  fs/9p: .L: Refresh stale inodes on reuse
  fs/9p: non-.L: Refresh stale inodes on reuse
  fs/9p: update the target's ino_path on rename
  docs: fs/9p: Document the "inodeident" option

 Documentation/filesystems/9p.rst |  42 +++++++
 fs/9p/Makefile                   |   3 +-
 fs/9p/ino_path.c                 | 111 ++++++++++++++++++
 fs/9p/v9fs.c                     |  59 +++++++++-
 fs/9p/v9fs.h                     |  87 ++++++++++----
 fs/9p/vfs_inode.c                | 195 ++++++++++++++++++++++++++-----
 fs/9p/vfs_inode_dotl.c           | 171 +++++++++++++++++++++++----
 fs/9p/vfs_super.c                |  13 ++-
 8 files changed, 611 insertions(+), 70 deletions(-)
 create mode 100644 fs/9p/ino_path.c


base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
prerequisite-patch-id: 3dae487a4b3d676de7c20b269553e3e2176b1e36
prerequisite-patch-id: 93ab54c52a41fa44b8d0baf55df949d0ad27e99a
prerequisite-patch-id: 5f558bf969e6eaa3d011c98de0806ca8ad369efe
-- 
2.51.0

