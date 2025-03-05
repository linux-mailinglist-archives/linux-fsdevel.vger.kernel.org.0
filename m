Return-Path: <linux-fsdevel+bounces-43288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC270A50B07
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 20:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D145217317C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 19:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1948C25484E;
	Wed,  5 Mar 2025 19:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afYinBnW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AFF250BF3;
	Wed,  5 Mar 2025 19:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741201620; cv=none; b=Nx+Hqb2zqq/TFVkxrDPDBuPZLgmQNX2UnI0imyEmeGXK4PqeNmW/G2a13zl/4rvZkFK8rkYq/e48hhehNbQed9DzJA5aaty/DLYB/37syXhawNNe7pAu8RDJlZtUxqEn4RTlSN8HAubutsCilAlcjkKLLKZOHozhQXhAl0P4z1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741201620; c=relaxed/simple;
	bh=2VUddns53Y9I8ZPkyNkm1w6lii5zBA1p4fMWLG0bgHk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=jL6He8GdENw1VWX2osXDZ2Q+CDUVabqZeRA6/9avcbBG7RxFrnVfYKDbmmR+C/y1w+ignmpnO88jcd4i4HgBin7V2J7zt5MsmdZQGltKxzt1brG4X2X2Bo8CRfRRdIDXtNdKrqx36ivboPU35w4x5TilJ+46gvMu8+byUyCOsH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afYinBnW; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2feb91a25bdso9965470a91.1;
        Wed, 05 Mar 2025 11:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741201618; x=1741806418; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=un+IAS02ixxpwXIE2SSLqaV4m1ONfWv8G0yiJ3H43Ak=;
        b=afYinBnWNbE9q6yObiyGMpeQ+TAJXj+omA/8PbYC1lzUa2+NZKL9qD/BCoVmThMxeN
         C4wRuLtpSlJjBndRNTrzppRGxswMmVUYHMlgBBWLulwwEdoAUfJygLTGaJXnfiYsiuCD
         qNKOk/xtmyOEfhDsSsmaVLkhFqsuOy9T/mKjB9qfd26wmiMMHomPkPFGjIIvlzhZlNm2
         cXP+hn082ZrxcoLAMN3Bt7j+/y5IHJhzR24/4NR6ZNNK4l5mfHpC67LVjPibzgPeH2N0
         lbP/WIuJyZTz5ljLGGo6PfIDwqGF9qxC9JcQCa+ky6KPZk36EBrEhBJDytLJzfM+7eO9
         gdCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741201618; x=1741806418;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=un+IAS02ixxpwXIE2SSLqaV4m1ONfWv8G0yiJ3H43Ak=;
        b=JEZPHA7AxcFt4HDQeuudZUROVOKpUFfdIeeHP228ZRigrr0xNnpiqhssDpnTlrdZGT
         HYEVi4gpo6G1pm64yN00yK76b7GU3a6sLaG5PvxUW1V5QKpbo7rVdELLV33f5TtwAXYW
         SS9Bw9w9l4TDVARUJjTqqa6Cs680/ExlEtUeERHMwLVFOPwJ9XgT9X8pcoUfUzX/tTLL
         LN7CGMxng7LF+qNmdN1rFNLxXts7npgQ/rL3GvoiyNTFWeLvTHLSCvjcGiAHRsABKjk7
         L0l1hlTJuJZV7xoOjODvY833POLuXVNDrpVjnQjuNl3Ax9iTAT2ysIcNlQBWmwErqOrM
         6qGg==
X-Forwarded-Encrypted: i=1; AJvYcCU5Y2txsfPqQa5LSma5JZqTXBM1yZ55e03B1qa89X4QOcdr3Q2HmbEqGAIxYzl2kq1HGDG8OECz3FM+vsmm+w==@vger.kernel.org, AJvYcCW3C8CLgCj+QHdImouWZkXtwQnAKdJadQmpcfE/90zCsRDLX5xyCiLQzIo+m4Gt4nktWGkEh6j6q+X/@vger.kernel.org, AJvYcCXZiYni01J2g/QbHhpHg9EkaRYg/eeWc1XccJXzj8noWsHfixiEmxGF2lfIc3kcXy2Gt79+67+gy4oy@vger.kernel.org
X-Gm-Message-State: AOJu0YwsXD9OboZ49s69fTVpgxVwpZ+ivsO5Aa84rk6pzl4SjJtmlcf/
	UM+/X78TVqyIwhyHGeneXkj9Baoa3SvSto/y9KGPKKHc7C/hnkvS
X-Gm-Gg: ASbGncuSuQiYFZ26e8I8im+OSAMJzWTlUJquxZE6wJNrooQNq/bE7AW8ONywgv6575C
	3lOsm6zIe+dQPIJqUpGuIYoLxEY3P7em4+NCotempZ26IdRUrdNVS8EYWn0nHofzOhZE3deUVW/
	gTA5uTiLYkP2bLpiENP+sdTvfYOvF1aMECS5X4bE9IFYP77ihddECX8wR6tH+X73nE0ZzEcmM/y
	UV7Zbp/vITjjh6P6XYzpjRyAk//dTwB3s/q/m8ju8f9BuutuVRnc9RuB1MMB2fQs/9PagL1aUu6
	0KqU3FAV3QOhc1EGUgSoTMbJdUeqNdyCA3iVdQ==
X-Google-Smtp-Source: AGHT+IE0lOwbLcM/sRe+Wp8/vRxTqU0g/OxfOlfpBbGme5jQ3uq8a9CA8y0qtaFZljqTPZ0e84KiMw==
X-Received: by 2002:a17:90a:d648:b0:2fe:85f0:e115 with SMTP id 98e67ed59e1d1-2ff4979d0ebmr6421659a91.26.1741201617599;
        Wed, 05 Mar 2025 11:06:57 -0800 (PST)
Received: from dw-tp ([171.76.80.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e773c7csm1717271a91.15.2025.03.05.11.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 11:06:56 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Dave Chinner <david@fromorbit.com>
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>, lsf-pc@lists.linux-foundation.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, djwong@kernel.org, dchinner@redhat.com, jack@suse.cz, tytso@mit.edu, linux-ext4@vger.kernel.org, nirjhar.roy.lists@gmail.com, zlang@kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] xfstests: Centralizing filesystem configs and device configs
In-Reply-To: <Z8d0Y0yvlgngKsgo@dread.disaster.area>
Date: Wed, 05 Mar 2025 09:13:32 +0530
Message-ID: <87frjs6t23.fsf@gmail.com>
References: <Z55RXUKB5O5l8QjM@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com> <Z6FFlxFEPfJT0h_P@dread.disaster.area> <87ed0erxl3.fsf@gmail.com> <Z6KRJ3lcKZGJE9sX@dread.disaster.area> <87plj0hp7e.fsf@gmail.com> <Z8d0Y0yvlgngKsgo@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Dave Chinner <david@fromorbit.com> writes:

> On Sat, Mar 01, 2025 at 06:39:57PM +0530, Ritesh Harjani wrote:
>> > Why is having hundreds of tiny single-config-only files
>> > better than having all the configs in a single file that is
>> > easily browsed and searched?
>> >
>> > Honestly, I really don't see any advantage to re-implementing config
>> > sections as a "file per config" object farm. Yes, you can store
>> > information that way, but that doesn't make it an improvement over a
>> > single file...
>> >
>> > All that is needed is for the upstream repository to maintain a
>> > config file with all the config sections defined that people need.
>> > We don't need any new infrastructure to implement a "centralised
>> > configs" feature - all we need is an agreement that upstream will
>> > ship an update-to-date default config file instead of the ancient,
>> > stale example.config/localhost.config files....
>> >
>> 
>> If we can create 1 config for every filesystem instead of creating a lot
>> of smaller config files. i.e.  
>> - configs/ext4/config.ext4
>> - configs/xfs/config.xfs
>
> Why are directories that contain a single file needed here?
>

Agreed. Not needed we can have configs/ext4.config, configs/xfs.config
and so on...

>> Each of above can contain sections like (e.g.)
>> 
>> [xfs-b4k]
>> MKFS_OPTIONS="-b size=4k"
>> ddUNT_OPTIdd    d=""dd
>> 
>> [xfs-b64k]
>> MKFS_OPTIONS="-b size=64k"
>> MOUNT_OPTIONS=""
>> 
>> 
>> Then during make we can merge all these configs into a common config file
>> i.e. configs/.all-section-configs. We can update the current check script to
>> look for either local.config file or configs/.all-section-configs file
>> for location the section passed in the command line. 
>
> What does this complexity gain us?
>

Let me try and explain this below.


>> This will help solve all the listed problems:
>> 1. We don't have to add a new parsing logic for configs
>
> We don't need new config files and makefile/build time shenanigans
> to do this.
>

Same here.

>> 2. We don't need to create 1 file per config
>
> Ditto.
>
>> 3. We still can get all sections listed in one place under which check
>> script can parse.
>
> Ditto.
>
>> 4. Calling different filesystem sections from a common config file can work.
>
> Yes, that's the whole point of have config sections: one config file
> that supports lots of different test configurations!
>
>> So as you mentioned calling something like below should work. 
>> 
>> ./check -s xfs_4k -s ext4_4k -g quick
>> 
>> Hopefully this will require minimal changes to work. Does this sound
>> good to you?
>
> You haven't explained why we need new infrastructure to do something
> we can already do with the existing infrastructure. What problem are
> you trying to solve that the current infrastructure does not handle?
>
> i.e. we won't need to change the global config file very often once the
> common configs are defined in it; it'll only get modified when
> filesystems add new features that need specific mkfs or mount option
> support to be added, and that's fairly rare.
>
> Hence I still don't understand what new problem multiple config files
> and new infrastructure to support them is supposed to solve...


I will try and explain our reasoning here: 

1. Why have per-fs config file i.e. configs/ext4.config or 
configs/xfs.config...

Instead of 1 large config file it's easier if we have FS specific
sections in their own .config file. I agree we don't need configs/<fs>
directories for each filesystem. But it's much easier if we have
configs/<fs>.config with the necessary sections defined in it.  That
will be easy to maintain by their respective FS maintainers rather than
maintaining all sections defined in 1 large common config file.

2. Why then add the infrastructure to create a new common
configs/all-fs.config file during make?

This is a combined configs/all-fs.config file which need not be
maintained in git version control. It gets generated for our direct
use. This is also needed to run different cross filesystem tests from a
single ./check script. i.e. 

        ./check -s ext4_4k -s xfs_4k -g quick

(otherwise one cannot run ext4_4k and xfs_4k from a single ./check invocation)

I don't think this is too much burden for "make" to generate this file.
And it's easier than, for people to use configs/all-fs.config to run
cross filesystem tests (as mentioned above).

e.g. 
1. "make" will generate configs/all-fs.config
2. Define your devices.config in configs/devices.config
3. Then run 
   (. configs/devices.config; ./check -s ext4_4k -s xfs_4k -g quick)

Note:
One problem which I can think of with the sections approach as opposed
to multiple small config files (-c configs/ext4/4k.config) approach is
that, in sections approach we iterate over all the sections present in
the provided config file and search for the section passed in the
cmdline. Whereas in the small config files approach we were directly
passing the configuration options via a small config file. But hopefully
that linear search in locating the section is not as time consuming as
opposed to running the test itself.


Here is the sample change snippet which we are thinking of.
Thoughts?


From c227f6335d09c2b482b759ac4df38d87ccedff6d Mon Sep 17 00:00:00 2001
Message-Id: <c227f6335d09c2b482b759ac4df38d87ccedff6d.1741201277.git.ritesh.list@gmail.com>
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Date: Wed, 5 Mar 2025 16:33:52 +0530
Subject: [RFC] configs: Add support for central fs configs using sections

This adds support for central fs configs using sections. This allows
different FS maintainers to maintain per-fs config file with different
sections to test multiple filesystem configurations like 1k, 4k, quota
etc.

During make we combine all configs/<fs>.config file into
configs/all-fs.config which is not tracked by git. check script will by
default use configs/all-fs.config file if local.config or
configs/$(HOST).config file is not present. This patch also adds
configs/devices.config.example which can be used as an example to export
default settings for SCRATCH_MNT, TEST_DIR, TEST_DEV, SCRATCH_DEV etc.

After defining default device settings say in configs/devices.config,
one can use:

(. configs/devices.config; ./check -s xfs_4k tests/selftest/001)

Note: make clean will clean the configs/all-fs.config file.

Co-developed-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 Makefile                       |  3 ++-
 common/config                  |  1 +
 configs/Makefile               | 26 ++++++++++++++++++++++++++
 configs/btrfs.config           |  4 ++++
 configs/devices.config.example |  9 +++++++++
 configs/ext4.config            |  9 +++++++++
 configs/xfs.config             |  9 +++++++++
 7 files changed, 60 insertions(+), 1 deletion(-)
 create mode 100644 configs/Makefile
 create mode 100644 configs/btrfs.config
 create mode 100644 configs/devices.config.example
 create mode 100644 configs/ext4.config
 create mode 100644 configs/xfs.config

diff --git a/Makefile b/Makefile
index f955f0d3..490bb59a 100644
--- a/Makefile
+++ b/Makefile
@@ -41,8 +41,9 @@ endif
 
 LIB_SUBDIRS = include lib
 TOOL_SUBDIRS = ltp src m4 common tools
+CONFIGS_SUBDIRS = configs
 
-SUBDIRS = $(LIB_SUBDIRS) $(TOOL_SUBDIRS) $(TESTS_DIR)
+SUBDIRS = $(LIB_SUBDIRS) $(TOOL_SUBDIRS) $(TESTS_DIR) $(CONFIGS_SUBDIRS)
 
 default: include/builddefs
 ifeq ($(HAVE_BUILDDEFS), no)
diff --git a/common/config b/common/config
index 2afbda14..b4470951 100644
--- a/common/config
+++ b/common/config
@@ -554,6 +554,7 @@ known_hosts()
 {
 	[ "$HOST_CONFIG_DIR" ] || HOST_CONFIG_DIR=`pwd`/configs
 
+	[ -f $HOST_CONFIG_DIR/all-fs.config ] && export HOST_OPTIONS=$HOST_CONFIG_DIR/all-fs.config
 	[ -f /etc/xfsqa.config ]             && export HOST_OPTIONS=/etc/xfsqa.config
 	[ -f $HOST_CONFIG_DIR/$HOST ]        && export HOST_OPTIONS=$HOST_CONFIG_DIR/$HOST
 	[ -f $HOST_CONFIG_DIR/$HOST.config ] && export HOST_OPTIONS=$HOST_CONFIG_DIR/$HOST.config
diff --git a/configs/Makefile b/configs/Makefile
new file mode 100644
index 00000000..e91bcca1
--- /dev/null
+++ b/configs/Makefile
@@ -0,0 +1,26 @@
+TOPDIR = ..
+include $(TOPDIR)/include/builddefs
+
+CONFIGS_DIR = $(TOPDIR)/configs
+ALL_FS_CONFIG = $(CONFIGS_DIR)/all-fs.config
+EXT4_CONFIG = $(CONFIGS_DIR)/ext4.config
+XFS_CONFIG = $(CONFIGS_DIR)/xfs.config
+BTRFS_CONFIG = $(CONFIGS_DIR)/btrfs.config
+
+DIRT = $(ALL_FS_CONFIG)
+default: $(ALL_FS_CONFIG)
+
+include $(BUILDRULES)
+
+# Generate all-fs.config by concatenating required configs/.config files
+$(ALL_FS_CONFIG): $(EXT4_CONFIG) $(XFS_CONFIG) $(BTRFS_CONFIG)
+	@echo "Generating $@"
+	echo "# all-fs sections" > $@
+	echo "[default]" >> $@
+	@echo "" >> $@
+	@cat $(EXT4_CONFIG) >> $@
+	@echo "" >> $@
+	@cat $(XFS_CONFIG) >> $@
+	@echo "" >> $@
+	@cat $(BTRFS_CONFIG) >> $@
+	@echo "" >> $@
diff --git a/configs/btrfs.config b/configs/btrfs.config
new file mode 100644
index 00000000..1d85e13d
--- /dev/null
+++ b/configs/btrfs.config
@@ -0,0 +1,4 @@
+[btrfs]
+ FSTYP=btrfs
+ MKFS_OPTIONS="-f "
+ MOUNT_OPTIONS=""
diff --git a/configs/devices.config.example b/configs/devices.config.example
new file mode 100644
index 00000000..48598a4b
--- /dev/null
+++ b/configs/devices.config.example
@@ -0,0 +1,9 @@
+export TEST_DIR=/mnt1/test
+export SCRATCH_MNT=/mnt1/scratch
+export TEST_DEV=/dev/loop0
+export SCRATCH_DEV=/dev/loop1
+export TEST_LOGDEV=/dev/loop2
+export SCRATCH_LOGDEV=/dev/loop3
+export TEST_RTDEV=/dev/loop4
+export SCRATCH_RTDEV=/dev/loop5
+export LOGWRITES_DEV=/dev/loop6
diff --git a/configs/ext4.config b/configs/ext4.config
new file mode 100644
index 00000000..d5ceba3c
--- /dev/null
+++ b/configs/ext4.config
@@ -0,0 +1,9 @@
+[ext4_1k]
+ FSTYP=ext4
+ MKFS_OPTIONS="-F -b 1024"
+ MOUNT_OPTIONS=""
+
+[ext4_4k]
+ FSTYP=ext4
+ MKFS_OPTIONS="-F -b 4096"
+ MOUNT_OPTIONS=""
diff --git a/configs/xfs.config b/configs/xfs.config
new file mode 100644
index 00000000..516f35f7
--- /dev/null
+++ b/configs/xfs.config
@@ -0,0 +1,9 @@
+[xfs_1k]
+ FSTYP=xfs
+ MKFS_OPTIONS="-f -bsize=1024"
+ MOUNT_OPTIONS=""
+
+[xfs_4k]
+ FSTYP=xfs
+ MKFS_OPTIONS="-f -bsize=4096"
+ MOUNT_OPTIONS=""
-- 
2.39.5


