Return-Path: <linux-fsdevel+bounces-8049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C3582ED48
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 12:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDA88B23540
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 11:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5AA1A713;
	Tue, 16 Jan 2024 11:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njZImTaL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25601A5B7;
	Tue, 16 Jan 2024 11:00:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31BB1C433F1;
	Tue, 16 Jan 2024 11:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705402830;
	bh=ka4ginUjS5CjHM0V8b8SOVIgogjHzG2IgkhfNwVc7Mk=;
	h=From:To:Cc:Subject:Date:From;
	b=njZImTaLdGb3i9JS73leCK9eh65efGnlVfx/VydMfLkNv5haxpeZsJz542IqxYsAd
	 bk0gnJZretKX1VoQYIliU5Z9a8SVRDJyb0fPuSXtVPAUuXQlmkrfW208s9DtVHKaqu
	 oBs0HJCLs2LSHkpCGwpvXoKhbJSHLJ1k/+L+Tyo1s0G2fqEMt4wimAIFk1kKQfsAiF
	 /t2suYFIZybiRQR0l0UALkir0ZAjgfbJaIrRjP42+hAQUdVHv05DZCdAwzV2+GySso
	 hk0R/R31qg4CLn2XgwnQSj0W1Mys3DF3+LDZ49i3v4/Ue+LpznmxXib7T/rYR93IGP
	 UWVPaWNx7TRKA==
From: Christian Brauner <brauner@kernel.org>
To: lsf-pc@lists.linux-foundation.org
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-btrfs@vger.kernel.org,
	linux-block@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@infradead.org>
Subject: [LSF/MM/BPF TOPIC] Dropping page cache of individual fs
Date: Tue, 16 Jan 2024 11:50:32 +0100
Message-ID: <20240116-tagelang-zugnummer-349edd1b5792@brauner>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4352; i=brauner@kernel.org; h=from:subject:message-id; bh=EZGa/THoxMnhCwXco+IB49hkRcRBCokvtP+wu+ae8TI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQui6/iW+TkW1bY+nLiIYdrzh8e7+7m1EpZM4GVceKZa 8sXfT/9u6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi6S0Mf4X/PtP+YNM6IYvH 8eqNoOLTTVszb3D5fp7MoH4wqqaO7SLD/yrh1jc7bf/qtzIvCHPh+Xq6gf/7hrsrVj+ZLmHxpcV jBwcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey,

I'm not sure this even needs a full LSFMM discussion but since I
currently don't have time to work on the patch I may as well submit it.

Gnome recently got awared 1M Euro by the Sovereign Tech Fund (STF). The
STF was created by the German government to fund public infrastructure:

"The Sovereign Tech Fund supports the development, improvement and
 maintenance of open digital infrastructure. Our goal is to sustainably
 strengthen the open source ecosystem. We focus on security, resilience,
 technological diversity, and the people behind the code." (cf. [1])

Gnome has proposed various specific projects including integrating
systemd-homed with Gnome. Systemd-homed provides various features and if
you're interested in details then you might find it useful to read [2].
It makes use of various new VFS and fs specific developments over the
last years.

One feature is encrypting the home directory via LUKS. An approriate
image or device must contain a GPT partition table. Currently there's
only one partition which is a LUKS2 volume. Inside that LUKS2 volume is
a Linux filesystem. Currently supported are btrfs (see [4] though),
ext4, and xfs.

The following issue isn't specific to systemd-homed. Gnome wants to be
able to support locking encrypted home directories. For example, when
the laptop is suspended. To do this the luksSuspend command can be used.

The luksSuspend call is nothing else than a device mapper ioctl to
suspend the block device and it's owning superblock/filesystem. Which in
turn is nothing but a freeze initiated from the block layer:

dm_suspend()
-> __dm_suspend()
   -> lock_fs()
      -> bdev_freeze()

So when we say luksSuspend we really mean block layer initiated freeze.
The overall goal or expectation of userspace is that after a luksSuspend
call all sensitive material has been evicted from relevant caches to
harden against various attacks. And luksSuspend does wipe the encryption
key and suspend the block device. However, the encryption key can still
be available clear-text in the page cache. To illustrate this problem
more simply:

truncate -s 500M /tmp/img
echo password | cryptsetup luksFormat /tmp/img --force-password
echo password | cryptsetup open /tmp/img test
mkfs.xfs /dev/mapper/test
mount /dev/mapper/test /mnt
echo "secrets" > /mnt/data
cryptsetup luksSuspend test
cat /mnt/data

This will still happily print the contents of /mnt/data even though the
block device and the owning filesystem are frozen because the data is
still in the page cache.

To my knowledge, the only current way to get the contents of /mnt/data
or the encryption key out of the page cache is via
/proc/sys/vm/drop_caches which is a big hammer.

My initial reaction is to give userspace an API to drop the page cache
of a specific filesystem which may have additional uses. I initially had
started drafting an ioctl() and then got swayed towards a
posix_fadvise() flag. I found out that this was already proposed a few
years ago but got rejected as it was suspected this might just be
someone toying around without a real world use-case. I think this here
might qualify as a real-world use-case.

This may at least help securing users with a regular dm-crypt setup
where dm-crypt is the top layer. Users that stack additional layers on
top of dm-crypt may still leak plaintext of course if they introduce
additional caching. But that's on them.

Of course other ideas welcome.

[1]: https://www.sovereigntechfund.de/en
[2]: https://systemd.io/HOME_DIRECTORY
[3]: https://lore.kernel.org/linux-btrfs/20230908-merklich-bebauen-11914a630db4@brauner/
[4]: A bdev_freeze() call ideally does the following:

     (1) Freeze the block device @bdev
     (2) Find the owning superblock of the block device @bdev and freeze the
         filesystem as well.

     Especially (2) wasn't true for a long time. Filesystems would only be
     able to freeze the filesystems on the main block device. For example, an
     xfs filesystem using an external log device would not be able to be
     frozen if the block layer request came via the external log device. This
     is fixed since v6.8 for all filesystems using appropriate holder
     operations.

     Except for btrfs where block device initiated freezes don't work at all;
     not even for the main block device. I've pointed this out months ago in [3].

     Which is why we currently can't use btrfs with LUKS2 encryption as as
     luksSuspend call will leave the filesystem unfrozen.
[5]: https://gitlab.com/cryptsetup/cryptsetup/-/issues/855
     https://gitlab.gnome.org/Teams/STF/homed/-/issues/23

