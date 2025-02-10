Return-Path: <linux-fsdevel+bounces-41362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 255A4A2E38B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 06:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B484D3A2658
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 05:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB661AA1C4;
	Mon, 10 Feb 2025 05:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b="QmkZ41sv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HgcQEauP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B2219CD01;
	Mon, 10 Feb 2025 05:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739164914; cv=none; b=VsvLsoMlPcWETO3qzI1Zo3UZpCODp3U7+vyNyx1kmtlDnZQsviChEO1SZqNXb/QzzqYXuWNhCRxnsp5bxXzruwNEAmTfz+lXH+TCDxyYVX7z9Tug+oGYZYdisHDnkePFI5lst4jCFhs7c2tHK02yi4kckXREFZwKfPUehXrUugU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739164914; c=relaxed/simple;
	bh=S/tKdCIEhEz92qz/0z8zDaDCLc4Vyna20SKNZP41a0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SRLLRbAxypisL5ZDjBGpHHQfNewVLvC8b2VjmRilKDdA45iBi8VkQ55F29kaYiznUfhTnHJHfJDRYPl8TcZOzTPjqn4M01GpvSUZ1+TRsztQHptTS7OQwdrgdqJORritOHDH0w3UW+wx6Mgp3sCpMAkmaI8fT/sWEC2LzTfCUkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com; spf=pass smtp.mailfrom=davidreaver.com; dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b=QmkZ41sv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HgcQEauP; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidreaver.com
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 400DE1380120;
	Mon, 10 Feb 2025 00:21:26 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 10 Feb 2025 00:21:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=davidreaver.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1739164886; x=
	1739251286; bh=K25ByJG8YfmJyPboYWuyf945L6vGr9gR5BxrWq42tFI=; b=Q
	mkZ41sv3KLtSXnXFQSDKdhFtR15jpIhPx8clgMofrvq4N0ZINR2DIeLpHJBbZDX5
	NpaFsjsyldayD20SvE+8sRh3QMAsTa2zNX7lHVfMijdFMmJgkpLt9GYV3Er4D6nf
	Tt+1ulEfkKGJBJpe4ecBQY01qfHujRPG4mtcfsyAVNNdRgHgljOzWid5AX6kKgsd
	XlStgr6fv3NyCVqAl//J7gBiiaYu+peGwrVCVxgph9oKi1izJxpFR4nIKxddbBmR
	STt+/d+0KHoX+opRk3fumsnMZQgLql20cxmH0sBE2Dl9NQBzW2hwB8CTL8WyArfS
	kBZgVMFflAUbr9NtqTGAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1739164886; x=1739251286; bh=K
	25ByJG8YfmJyPboYWuyf945L6vGr9gR5BxrWq42tFI=; b=HgcQEauPF/zZVY0V5
	aAPwkxWNIm19sV3/o9c/tYjuVRWkIaug6Aca8hQxeHK+b81C6Zs25M8m9piekJ5D
	9FtnXsplElpvbTJH1iDZSF8N4oo86AtE6R1c8sJd3I91ls17p5tY+ZdVpG6aq4jg
	oWTn57CJjr5HrUqbVw0t5pgfhP3XywRtbL1PF7hp/FipJf+YHGx125m3XThJCmCT
	TkXuFCAGqSvxYnBKAyV4KJPbDjFpfeili4bbEyD/v8zH+gocA2/FHG2os1ydoPKX
	81OIu+GiAq3gPvzyhecRt0dDR6P1buTNUmBAM1iaFu7PREGsH1ot4tdmggaMymlw
	yKLjA==
X-ME-Sender: <xms:1YypZ-YDjBjWX7UNYzq520QM_-xjA6Qw97XY0CjVTvVWw1mf7b5kLA>
    <xme:1YypZxZpHJMLfd0EBJD5C2QJ9yhrewHw4m-Ot4xI2nFPYXv-OIqa-e3Druc_vGuNx
    Ydvwa5BD7zUIJsfWC4>
X-ME-Received: <xmr:1YypZ4_aKhUE2Y572QlHvwEYAwq1_ArN2qkmoJOgcLQJRRQc2ekrQqzfeTFRPcr-4148VDbwdCqpeYXEqbFkbc4pozgRNprfWEDDTf8qisZCZqE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefjedvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeffrghvihguucftvggrvhgvrhcuoehmvgesuggrvhhiughrvggrvhgvrh
    drtghomheqnecuggftrfgrthhtvghrnhepudevteffveeuuddtkedtvedtteeutdefvdeg
    hffhjeeiveegvdetvdejteejleeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepmhgvsegurghvihgurhgvrghvvghrrdgtohhmpdhnsggprhgt
    phhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhrvghgkhhhse
    hlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepmhgvsegurghvihgurhgvrghvvghrrdgtohhmpdhrtghpthhtoheprhhoshht
    vgguthesghhoohgumhhishdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdr
    uhhkpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegtohgttghisehinhhrihgrrdhfrh
X-ME-Proxy: <xmx:1YypZwr1UkaHtY_W46T6Xhszj5h2DYnU-6eFSeBmgqXbwlOrOSpe5g>
    <xmx:1YypZ5oV9UarEXi2cnJ9IOSlA56X3sXe-8UntfCEsJtFkMvndeXBXQ>
    <xmx:1YypZ-QqoV7LATFxCZ2FYzU76FaY1U_11uKgXxuMkZ4LgF8YhgSbDA>
    <xmx:1YypZ5qs9cvKalzEP1Wp4j3TSW-CyfDIXX01RIcwlK0b-3wiLs7Pwg>
    <xmx:1YypZ2hClAi7pYOa1FAf64ReCR0SLT22Z6mzAeWmQoRP4cNkq-e3Wsuv>
Feedback-ID: i67e946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Feb 2025 00:21:23 -0500 (EST)
From: David Reaver <me@davidreaver.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: David Reaver <me@davidreaver.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	cocci@inria.fr,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/6] debugfs: Automated conversion from dentry to debugfs_node
Date: Sun,  9 Feb 2025 21:20:24 -0800
Message-ID: <20250210052039.144513-5-me@davidreaver.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250210052039.144513-1-me@davidreaver.com>
References: <20250210052039.144513-1-me@davidreaver.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit applies a Coccinelle script (inlined below) to update debugfs
API calls across the kernel tree, replacing dentry with debugfs_node where
applicable. spatch was run file-by-file with a bash script (also inlined
below).

Some cases require manual fixups, which are handled in the next commit.

Coccinelle script
-----------------

  virtual patch

  //
  // Rewrite wrapper functions. These are functions that return a dentry
  // or accept a dentry as an argument and look like they are related to
  // debugfs.
  //
  @wrapper_function_returns depends on !(file in "fs/debugfs") && !(file in "include/linux/debugfs.h")@
  identifier wfr =~ "debugfs|dbgfs";
  type T = { struct dentry *, struct debugfs_node * };
  idexpression T e;
  @@

  e = wfr(...)

  @wrapper_function_args depends on !(file in "fs/debugfs") && !(file in "include/linux/debugfs.h")@
  identifier wfa =~ "debugfs|dbgfs";
  type T = { struct dentry *, struct debugfs_node * };
  T arg;
  @@

  wfa(..., arg, ...)

  // Rewrite rule is separate in case wrapper is not in the same file.
  @rewrite_wrapper_returns depends on !(file in "fs/debugfs") && !(file in "include/linux/debugfs.h")@
  identifier wfr =~ "debugfs|dbgfs";
  @@

  - struct dentry *
  + struct debugfs_node *
  wfr(...) { ... }

  // Rewrite rule is separate in case wrapper is not in the same file.
  @rewrite_wrapper_args depends on !(file in "fs/debugfs") && !(file in "include/linux/debugfs.h")@
  identifier wfa =~ "debugfs|dbgfs";
  identifier arg;
  @@

  wfa(...,
  - struct dentry
  + struct debugfs_node
    *arg
    ,...)
  { ... }

  // Collect all function calls
  @function_calls@
  // This hard-coded list is separate from the wrapper regexes above so we don't
  // go and mutate core debugfs functions on accident. Many of these purposely
  // have dentry types in them.
  identifier hf = {
    // Macros with debugfs_node. Coccinelle can't infer types for these.
    debugfs_create_file,
    debugfs_create_file_aux,
    debugfs_create_file_aux_num,
    debugfs_remove_recursive,

    // Actual functions
    debugfs_change_name,
    debugfs_create_atomic_t,
    debugfs_create_bool,
    debugfs_create_devm_seqfile,
    debugfs_create_dir,
    debugfs_create_file_full,
    debugfs_create_file_short,
    debugfs_create_file_size,
    debugfs_create_file_unsafe,
    debugfs_create_regset32,
    debugfs_create_size,
    debugfs_create_str,
    debugfs_create_symlink,
    debugfs_create_u16,
    debugfs_create_u32,
    debugfs_create_u32_array,
    debugfs_create_u64,
    debugfs_create_u8,
    debugfs_create_ulong,
    debugfs_create_x16,
    debugfs_create_x32,
    debugfs_create_x64,
    debugfs_create_x8,
    debugfs_lookup,
    debugfs_lookup_and_remove,
    debugfs_node_get,
    debugfs_node_path_raw,
    debugfs_node_put,
    debugfs_real_fops,
    debugfs_remove
  };
  identifier wrapper_function_returns.wfr;
  identifier wrapper_function_args.wfa;
  // Exclude functions that might have been fuzzy matched that should
  // "stay" with dentry.
  identifier f != {
    debugfs_create_automount,
    debugfs_file_get,
    debugfs_file_put
  };
  @@

  (
    hf@f(...)
  |
    wfr@f(...)
  |
    wfa@f(...)
  )

  // We need to separate cases for when a variable is in the return
  // position vs a function arg. If we combine them, then we will miss
  // cases where they both happen at the same time, e.g. x = f(y) where x
  // and y are both dentries.
  @find_dentry_return_vars@
  identifier f = { function_calls.f };
  idexpression struct dentry *e;
  identifier var;
  @@

  e@var = f(...)

  @find_dentry_arg_vars@
  identifier f = { function_calls.f };
  idexpression struct dentry *e;
  identifier var;
  @@

  f(..., e@var, ...)

  // find_decls and change_decl_types are separate so we properly handle
  // static declarations as well as multi-declarations (e.g. struct dentry
  // *a, *b, *c;). The "= NULL", "= f(...)", and "= E" cases get thrown
  // off when we combine them into one rule.
  @find_decls@
  identifier var = { find_dentry_return_vars.var, find_dentry_arg_vars.var };
  identifier f = { find_dentry_return_vars.f, find_dentry_arg_vars.f };
  position p;
  idexpression struct debugfs_node *E;
  @@

  (
    struct dentry@p *var;
  |
    struct dentry@p *var = NULL;
  |
    struct dentry@p *var = f(...);
  |
    struct dentry@p *var = E;
  )

  @change_decls type@
  position find_decls.p;
  @@

  -struct dentry@p
  +struct debugfs_node

  @find_function_arg_decls@
  identifier var = { find_dentry_return_vars.var, find_dentry_arg_vars.var };
  identifier f;
  position p;
  @@

  f(..., struct dentry@p *var, ...) {...}

  @change_function_arg_decls type@
  position find_function_arg_decls.p;
  @@

  -struct dentry@p
  +struct debugfs_node

  //
  // Struct fields
  //
  @fields_need_rewrite@
  identifier function_calls.f;
  identifier var;
  expression E;
  @@

  (
    E->var = f(...)
  |
    E.var = f(...)
  |
    f(..., E->var, ...)
  |
    f(..., E.var, ...)
  )

  @rewrite_fields@
  identifier fields_need_rewrite.var;
  identifier struct_name;
  @@

  (
  struct struct_name {
      ...
  -   struct dentry *
  +   struct debugfs_node *
      var;
      ...
  };
  |
  struct {
      ...
  -   struct dentry *
  +   struct debugfs_node *
      var;
      ...
  } struct_name;
  )

  //
  // Rewrite declarations and fields that are dentries with names that
  // very strongly imply they are for debugfs. This is necessary because
  // sometimes Coccinelle doesn't go into all headers/structs.
  //
  @obvious_debugfs_decls depends on !(file in "fs/debugfs") && !(file in "include/linux/debugfs.h")@
  identifier var =~ "debugfs|dbgfs|^debug_dir$|^debug_root$|^dbg_dir$";
  @@

  (
  - struct dentry *
  + struct debugfs_node *
    var;
  |
  - struct dentry *
  + struct debugfs_node *
    var = NULL;
  )

  @obvious_debugfs_fields depends on !(file in "fs/debugfs") && !(file in "include/linux/debugfs.h")@
  identifier var =~ "debugfs|dbgfs|^debug_dir$|^debug_root$|^dbg_dir$";
  identifier struct_name;
  @@

  struct struct_name {
      ...
  -   struct dentry *
  +   struct debugfs_node *
      var;
      ...
  };

  @obvious_debugfs_field_arrays depends on !(file in "fs/debugfs") && !(file in "include/linux/debugfs.h")@
  identifier var =~ "debugfs|dbgfs|^debug_dir$|^debug_root$|^dbg_dir$";
  identifier struct_name;
  @@

  struct struct_name {
      ...
  -   struct dentry *
  +   struct debugfs_node *
      var [...];
      ...
  };

  // Rewrite return types of helper functions that return a debugfs_node
  // now.
  @rewrite_helper_return_exp@
  identifier f;
  idexpression struct debugfs_node *e;
  @@

  -struct dentry *
  +struct debugfs_node *
    f(...) {
      ...
      return e;
      ...
    }

  @rewrite_helper_return_ret@
  identifier fn;
  identifier function_calls.f;
  @@

  struct
  - dentry
  + debugfs_node
   *fn(...)
  {
    ...
    return f(...);
    ...
  }

  //
  // Add #define debugfs_node dentry if debugfs_node is used anywhere.
  // This prevents implicit declarations.
  //
  @define_exists@
  @@

  #define debugfs_node dentry

  @any_debugfs_node_usage type@
  @@

  struct debugfs_node

  @depends on !define_exists and any_debugfs_node_usage@
  @@

  struct dentry;
  +#define debugfs_node dentry

  //
  // Transform various helper functions
  //
  @@
  idexpression struct debugfs_node *e;
  @@

  -d_inode(e)
  +debugfs_node_inode(e)

  @@
  idexpression struct debugfs_node *e;
  @@

  -e->d_inode
  +debugfs_node_inode(e)

  @@
  idexpression struct debugfs_node *e;
  @@

  -dput(e)
  +debugfs_node_put(e)

  @@
  idexpression struct debugfs_node *e;
  @@

  -dget(e)
  +debugfs_node_get(e)

  @@
  idexpression struct debugfs_node *e;
  @@

  - dentry_path_raw
  + debugfs_node_path_raw
    (e, ...);

Bash script to run Coccinelle
-----------------------------

  #!/usr/bin/env bash

  set -euo pipefail

  # Store bash script source directory
  script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

  log_dir=/tmp/cocci-logs
  rm -rf "$log_dir"
  mkdir -p "$log_dir"

  # Use ripgrep to find any files that contain debugfs-looking code. This
  # is a simple heuristic to avoid running spatch on files that don't
  # contain debugfs code.
  files=$(rg --files-with-matches 'debugfs|dentry' -g '*.{c,h}' -g '!fs/debugfs' \
            -g '!include/linux/debugfs.h' -g '!include/linux/fs.h' | sort)

  counter=1
  total_files=$(echo "$files" | wc -l)
  for file in $files; do
      echo "($counter/$total_files) $file"
      counter=$((counter+1))

      time spatch "$script_dir/script.cocci" \
        --all-includes --include-headers --patch . \
        --ignore include/linux/fs.h \
        --ignore include/linux/debugfs.h \
        --ignore fs/debugfs \
        --in-place "$file" 2>&1 \
        | tee "$log_dir/$(echo "$file" | tr '/' '--').log"
  done

  # Undo the changes to some files. Some of these should not be modified,
  # and some are handled in the later manual fixup commit.
  git checkout -- \
    drivers/s390/block/dasd.c \
    fs/bcachefs/xattr.h \
    fs/btrfs/export.h \
    fs/btrfs/ioctl.h \
    fs/btrfs/transaction.h \
    fs/btrfs/tree-log.h \
    fs/debugfs \
    fs/ntfs3/ntfs_fs.h \
    fs/udf/udfdecl.h \
    include/drm/ttm/ttm_resource.h \
    include/linux/capability.h \
    include/linux/debugfs.h \
    include/linux/exportfs.h \
    include/linux/file.h \
    include/linux/fs.h \
    include/linux/fs_context.h \
    include/linux/irqdesc.h \
    include/linux/kernfs.h \
    include/linux/mount.h \
    include/linux/path.h \
    include/linux/security.h \
    include/linux/statfs.h

-----

Signed-off-by: David Reaver <me@davidreaver.com>
---
 arch/arm/mach-omap1/pm.c                      |  2 +-
 arch/arm/mach-omap2/pm-debug.c                |  4 +-
 arch/loongarch/kernel/kdebugfs.c              |  2 +-
 arch/microblaze/include/asm/processor.h       |  2 +-
 arch/microblaze/kernel/setup.c                |  2 +-
 arch/mips/cavium-octeon/oct_ilm.c             |  2 +-
 arch/mips/include/asm/debug.h                 |  2 +-
 arch/mips/kernel/setup.c                      |  2 +-
 arch/mips/math-emu/me-debugfs.c               |  4 +-
 arch/mips/mm/sc-debugfs.c                     |  2 +-
 arch/powerpc/kernel/iommu.c                   |  4 +-
 arch/powerpc/kernel/kdebugfs.c                |  2 +-
 arch/powerpc/kernel/traps.c                   |  2 +-
 arch/powerpc/kvm/book3s_hv.c                  |  6 +-
 arch/powerpc/kvm/book3s_xics.h                |  2 +-
 arch/powerpc/kvm/book3s_xive.h                |  2 +-
 arch/powerpc/kvm/powerpc.c                    |  3 +-
 arch/powerpc/kvm/timing.c                     |  2 +-
 arch/powerpc/kvm/timing.h                     |  4 +-
 arch/powerpc/platforms/powernv/memtrace.c     |  6 +-
 arch/powerpc/platforms/powernv/opal-imc.c     |  4 +-
 arch/powerpc/platforms/powernv/opal-lpc.c     |  4 +-
 arch/powerpc/platforms/powernv/opal-xscom.c   |  7 +-
 arch/powerpc/platforms/powernv/pci.h          |  2 +-
 arch/powerpc/platforms/powernv/vas-debug.c    |  6 +-
 arch/powerpc/platforms/powernv/vas.h          |  2 +-
 arch/powerpc/platforms/pseries/dtl.c          |  2 +-
 arch/powerpc/platforms/pseries/hvCall_inst.c  |  2 +-
 arch/powerpc/platforms/pseries/lpar.c         |  2 +-
 arch/powerpc/sysdev/xive/common.c             |  4 +-
 arch/powerpc/sysdev/xive/native.c             |  2 +-
 arch/s390/hypfs/hypfs.h                       |  2 +-
 arch/s390/hypfs/hypfs_dbfs.c                  |  2 +-
 arch/s390/include/asm/debug.h                 |  4 +-
 arch/s390/include/asm/pci.h                   |  2 +-
 arch/s390/kernel/debug.c                      |  6 +-
 arch/s390/kernel/hiperdispatch.c              |  2 +-
 arch/s390/kernel/kdebugfs.c                   |  2 +-
 arch/s390/kernel/sysinfo.c                    |  2 +-
 arch/s390/kernel/wti.c                        |  2 +-
 arch/s390/pci/pci_debug.c                     |  2 +-
 arch/sh/kernel/kdebugfs.c                     |  2 +-
 arch/x86/kernel/callthunks.c                  |  2 +-
 arch/x86/kernel/cpu/debugfs.c                 |  2 +-
 arch/x86/kernel/cpu/mce/core.c                |  6 +-
 arch/x86/kernel/cpu/mce/inject.c              |  2 +-
 arch/x86/kernel/cpu/mce/internal.h            |  2 +-
 arch/x86/kernel/cpu/mce/severity.c            |  2 +-
 arch/x86/kernel/cpu/resctrl/internal.h        |  4 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c        |  2 +-
 arch/x86/kernel/itmt.c                        |  2 +-
 arch/x86/kernel/kdebugfs.c                    | 12 +--
 arch/x86/kvm/debugfs.c                        |  3 +-
 arch/x86/mm/debug_pagetables.c                |  2 +-
 arch/x86/platform/atom/punit_atom_debug.c     |  2 +-
 arch/x86/platform/intel/iosf_mbi.c            |  2 +-
 arch/x86/xen/debugfs.c                        |  4 +-
 arch/x86/xen/p2m.c                            |  4 +-
 arch/x86/xen/xen-ops.h                        |  2 +-
 block/blk-core.c                              |  4 +-
 block/blk-mq-debugfs.c                        |  6 +-
 block/blk-rq-qos.h                            |  2 +-
 block/blk-timeout.c                           |  2 +-
 block/blk.h                                   |  2 +-
 crypto/jitterentropy-testing.c                |  2 +-
 drivers/accel/drm_accel.c                     |  2 +-
 drivers/accel/habanalabs/common/debugfs.c     |  5 +-
 drivers/accel/ivpu/ivpu_debugfs.c             |  2 +-
 drivers/accel/qaic/qaic_debugfs.c             |  4 +-
 drivers/acpi/acpi_dbg.c                       |  2 +-
 drivers/acpi/apei/apei-base.c                 |  4 +-
 drivers/acpi/apei/apei-internal.h             |  3 +-
 drivers/acpi/apei/einj-core.c                 |  2 +-
 drivers/acpi/debugfs.c                        |  2 +-
 drivers/acpi/ec_sys.c                         |  4 +-
 drivers/acpi/internal.h                       |  2 +-
 drivers/android/binder.c                      |  4 +-
 drivers/android/binder_internal.h             |  2 +-
 drivers/base/component.c                      |  2 +-
 drivers/base/regmap/internal.h                |  2 +-
 drivers/base/regmap/regmap-debugfs.c          |  2 +-
 drivers/block/aoe/aoe.h                       |  2 +-
 drivers/block/aoe/aoeblk.c                    |  2 +-
 drivers/block/brd.c                           |  2 +-
 drivers/block/drbd/drbd_debugfs.c             | 24 +++---
 drivers/block/drbd/drbd_int.h                 | 30 ++++----
 drivers/block/mtip32xx/mtip32xx.c             |  2 +-
 drivers/block/mtip32xx/mtip32xx.h             |  2 +-
 drivers/block/nbd.c                           |  8 +-
 drivers/block/pktcdvd.c                       |  2 +-
 drivers/block/zram/zram_drv.c                 |  2 +-
 drivers/block/zram/zram_drv.h                 |  2 +-
 drivers/bluetooth/btmrvl_debugfs.c            |  4 +-
 drivers/bluetooth/hci_qca.c                   |  2 +-
 drivers/bus/mhi/host/debugfs.c                |  2 +-
 drivers/bus/moxtet.c                          |  2 +-
 drivers/bus/mvebu-mbus.c                      |  6 +-
 drivers/cache/sifive_ccache.c                 |  2 +-
 drivers/cdx/cdx.c                             |  2 +-
 drivers/char/virtio_console.c                 |  4 +-
 drivers/clk/baikal-t1/ccu-div.c               | 12 ++-
 drivers/clk/baikal-t1/ccu-pll.c               |  2 +-
 drivers/clk/bcm/clk-bcm2835.c                 |  8 +-
 drivers/clk/clk-fractional-divider.c          |  2 +-
 drivers/clk/clk.c                             |  9 ++-
 drivers/clk/davinci/pll.c                     |  3 +-
 .../clk/starfive/clk-starfive-jh7110-pll.c    |  3 +-
 drivers/clk/starfive/clk-starfive-jh71x0.c    |  3 +-
 drivers/clk/tegra/clk-dfll.c                  |  4 +-
 drivers/crypto/allwinner/sun4i-ss/sun4i-ss.h  |  4 +-
 .../crypto/allwinner/sun8i-ce/sun8i-ce-core.c |  4 +-
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h  |  4 +-
 .../crypto/allwinner/sun8i-ss/sun8i-ss-core.c |  4 +-
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h  |  4 +-
 drivers/crypto/amlogic/amlogic-gxl-core.c     |  2 +-
 drivers/crypto/amlogic/amlogic-gxl.h          |  2 +-
 drivers/crypto/axis/artpec6_crypto.c          |  2 +-
 drivers/crypto/bcm/cipher.h                   |  4 +-
 drivers/crypto/caam/ctrl.c                    |  2 +-
 drivers/crypto/caam/debugfs.c                 |  2 +-
 drivers/crypto/caam/debugfs.h                 |  6 +-
 drivers/crypto/caam/intern.h                  |  2 +-
 drivers/crypto/cavium/nitrox/nitrox_debugfs.c |  2 +-
 drivers/crypto/cavium/nitrox/nitrox_dev.h     |  2 +-
 drivers/crypto/cavium/zip/zip_main.c          |  2 +-
 drivers/crypto/ccp/ccp-debugfs.c              |  4 +-
 drivers/crypto/ccp/ccp-dev.h                  |  2 +-
 drivers/crypto/ccree/cc_debugfs.c             |  2 +-
 drivers/crypto/ccree/cc_driver.h              |  2 +-
 drivers/crypto/gemini/sl3516-ce-core.c        |  4 +-
 drivers/crypto/gemini/sl3516-ce.h             |  4 +-
 drivers/crypto/hisilicon/debugfs.c            |  5 +-
 drivers/crypto/hisilicon/hpre/hpre_main.c     | 11 +--
 drivers/crypto/hisilicon/sec2/sec_main.c      |  4 +-
 drivers/crypto/hisilicon/zip/zip_main.c       |  6 +-
 drivers/crypto/intel/iaa/iaa_crypto_stats.c   |  2 +-
 .../intel/qat/qat_common/adf_accel_devices.h  |  8 +-
 drivers/crypto/intel/qat/qat_common/adf_cfg.h |  2 +-
 .../qat/qat_common/adf_heartbeat_dbgfs.c      |  2 +-
 .../intel/qat/qat_common/adf_telemetry.h      |  3 +-
 .../intel/qat/qat_common/adf_tl_debugfs.c     |  6 +-
 .../qat/qat_common/adf_transport_debug.c      |  2 +-
 .../qat/qat_common/adf_transport_internal.h   |  8 +-
 drivers/crypto/nx/nx.h                        |  2 +-
 drivers/crypto/nx/nx_debugfs.c                |  2 +-
 drivers/crypto/rockchip/rk3288_crypto.c       |  4 +-
 drivers/crypto/rockchip/rk3288_crypto.h       |  4 +-
 drivers/cxl/core/core.h                       |  2 +-
 drivers/cxl/core/mbox.c                       |  2 +-
 drivers/cxl/core/port.c                       |  6 +-
 drivers/devfreq/devfreq.c                     |  2 +-
 drivers/dma-buf/dma-buf.c                     |  4 +-
 drivers/dma-buf/sync_debug.c                  |  2 +-
 drivers/dma/amd/ptdma/ptdma-debugfs.c         |  2 +-
 drivers/dma/bcm-sba-raid.c                    |  2 +-
 drivers/dma/dmaengine.c                       |  2 +-
 drivers/dma/dmaengine.h                       |  5 +-
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c      | 15 ++--
 drivers/dma/dw-edma/dw-hdma-v0-debugfs.c      | 17 +++--
 drivers/dma/hisi_dma.c                        |  2 +-
 drivers/dma/idxd/debugfs.c                    |  2 +-
 drivers/dma/idxd/idxd.h                       |  4 +-
 drivers/dma/pxa_dma.c                         | 11 +--
 drivers/dma/qcom/hidma.h                      |  2 +-
 drivers/dma/qcom/hidma_dbg.c                  |  2 +-
 drivers/dma/xilinx/xilinx_dpdma.c             |  2 +-
 drivers/edac/altera_edac.h                    |  2 +-
 drivers/edac/armada_xp_edac.c                 |  2 +-
 drivers/edac/debugfs.c                        | 21 +++---
 drivers/edac/edac_module.h                    | 36 +++++----
 drivers/edac/i5100_edac.c                     |  4 +-
 drivers/edac/igen6_edac.c                     |  2 +-
 drivers/edac/npcm_edac.c                      |  2 +-
 drivers/edac/pnd2_edac.c                      |  2 +-
 drivers/edac/skx_common.c                     |  2 +-
 drivers/edac/thunderx_edac.c                  |  8 +-
 drivers/edac/versal_edac.c                    |  2 +-
 drivers/edac/xgene_edac.c                     |  6 +-
 drivers/edac/zynqmp_edac.c                    |  2 +-
 drivers/extcon/extcon-rtk-type-c.c            |  2 +-
 drivers/firmware/arm_scmi/driver.c            | 14 ++--
 drivers/firmware/arm_scmi/raw_mode.c          |  8 +-
 drivers/firmware/cirrus/cs_dsp.c              |  8 +-
 drivers/firmware/efi/efi.c                    |  2 +-
 drivers/firmware/tegra/bpmp-debugfs.c         | 10 +--
 drivers/firmware/ti_sci.c                     |  2 +-
 drivers/firmware/turris-mox-rwtm.c            |  2 +-
 drivers/firmware/xilinx/zynqmp-debug.c        |  2 +-
 drivers/gpio/gpio-mockup.c                    |  4 +-
 drivers/gpio/gpio-sloppy-logic-analyzer.c     |  6 +-
 drivers/gpio/gpio-virtuser.c                  | 17 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c       |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h       |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |  9 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c       |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h       |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c      |  2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  8 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  2 +-
 .../gpu/drm/arm/display/komeda/komeda_dev.h   |  2 +-
 drivers/gpu/drm/bridge/ite-it6505.c           |  2 +-
 drivers/gpu/drm/bridge/panel.c                |  2 +-
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c |  2 +-
 drivers/gpu/drm/bridge/ti-sn65dsi86.c         |  2 +-
 .../gpu/drm/display/drm_bridge_connector.c    |  2 +-
 drivers/gpu/drm/drm_debugfs.c                 | 28 +++----
 drivers/gpu/drm/drm_debugfs_crc.c             |  2 +-
 drivers/gpu/drm/drm_drv.c                     |  2 +-
 drivers/gpu/drm/drm_internal.h                |  5 +-
 drivers/gpu/drm/i915/display/intel_alpm.c     |  2 +-
 .../drm/i915/display/intel_display_debugfs.c  |  4 +-
 .../display/intel_display_debugfs_params.c    | 10 +--
 .../drm/i915/display/intel_dp_link_training.c |  2 +-
 drivers/gpu/drm/i915/display/intel_fbc.c      |  2 +-
 drivers/gpu/drm/i915/display/intel_pps.c      |  2 +-
 drivers/gpu/drm/i915/display/intel_psr.c      |  2 +-
 drivers/gpu/drm/i915/gt/intel_gt_debugfs.c    |  7 +-
 drivers/gpu/drm/i915/gt/intel_gt_debugfs.h    |  2 +-
 .../drm/i915/gt/intel_gt_engines_debugfs.c    |  3 +-
 .../drm/i915/gt/intel_gt_engines_debugfs.h    |  4 +-
 drivers/gpu/drm/i915/gt/intel_gt_pm_debugfs.c |  3 +-
 drivers/gpu/drm/i915/gt/intel_gt_pm_debugfs.h |  4 +-
 drivers/gpu/drm/i915/gt/intel_sseu_debugfs.c  |  3 +-
 drivers/gpu/drm/i915/gt/intel_sseu_debugfs.h  |  4 +-
 .../gpu/drm/i915/gt/uc/intel_gsc_uc_debugfs.c |  3 +-
 .../gpu/drm/i915/gt/uc/intel_gsc_uc_debugfs.h |  4 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc.h        |  2 +-
 .../gpu/drm/i915/gt/uc/intel_guc_debugfs.c    |  3 +-
 .../gpu/drm/i915/gt/uc/intel_guc_debugfs.h    |  4 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc_log.c    |  8 +-
 .../drm/i915/gt/uc/intel_guc_log_debugfs.c    |  2 +-
 .../drm/i915/gt/uc/intel_guc_log_debugfs.h    |  3 +-
 .../gpu/drm/i915/gt/uc/intel_huc_debugfs.c    |  3 +-
 .../gpu/drm/i915/gt/uc/intel_huc_debugfs.h    |  4 +-
 drivers/gpu/drm/i915/gt/uc/intel_uc_debugfs.c |  5 +-
 drivers/gpu/drm/i915/gt/uc/intel_uc_debugfs.h |  4 +-
 drivers/gpu/drm/i915/gvt/gvt.h                |  4 +-
 drivers/gpu/drm/i915/i915_debugfs_params.c    | 16 ++--
 drivers/gpu/drm/i915/i915_debugfs_params.h    |  3 +-
 drivers/gpu/drm/i915/pxp/intel_pxp_debugfs.c  |  2 +-
 drivers/gpu/drm/imagination/pvr_debugfs.c     |  4 +-
 drivers/gpu/drm/imagination/pvr_debugfs.h     |  1 +
 drivers/gpu/drm/imagination/pvr_fw_trace.c    |  3 +-
 drivers/gpu/drm/imagination/pvr_fw_trace.h    |  4 +-
 drivers/gpu/drm/imagination/pvr_params.c      |  2 +-
 drivers/gpu/drm/imagination/pvr_params.h      |  4 +-
 drivers/gpu/drm/loongson/lsdc_output_7a2000.c |  4 +-
 drivers/gpu/drm/loongson/lsdc_ttm.c           |  2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_irq.h  |  2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c |  5 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h |  3 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c   |  3 +-
 .../gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c |  2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c   |  4 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h   |  2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       | 11 +--
 drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c      |  5 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.h      |  3 +-
 drivers/gpu/drm/msm/dp/dp_debug.c             |  2 +-
 drivers/gpu/drm/msm/dp/dp_debug.h             |  2 +-
 drivers/gpu/drm/msm/dp/dp_display.c           |  3 +-
 drivers/gpu/drm/msm/dp/dp_display.h           |  3 +-
 drivers/gpu/drm/msm/dp/dp_drm.c               |  6 +-
 drivers/gpu/drm/msm/msm_debugfs.c             |  2 +-
 drivers/gpu/drm/nouveau/dispnv50/crc.c        |  2 +-
 drivers/gpu/drm/nouveau/nouveau_debugfs.c     |  6 +-
 drivers/gpu/drm/nouveau/nouveau_debugfs.h     |  2 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c         |  2 +-
 .../gpu/drm/nouveau/nvkm/subdev/gsp/r535.c    | 16 ++--
 drivers/gpu/drm/omapdrm/dss/dss.c             |  4 +-
 drivers/gpu/drm/panel/panel-edp.c             |  3 +-
 drivers/gpu/drm/panel/panel-sitronix-st7703.c |  2 +-
 drivers/gpu/drm/radeon/r100.c                 |  6 +-
 drivers/gpu/drm/radeon/r300.c                 |  2 +-
 drivers/gpu/drm/radeon/r420.c                 |  2 +-
 drivers/gpu/drm/radeon/r600.c                 |  2 +-
 drivers/gpu/drm/radeon/radeon_fence.c         |  2 +-
 drivers/gpu/drm/radeon/radeon_gem.c           |  2 +-
 drivers/gpu/drm/radeon/radeon_ib.c            |  2 +-
 drivers/gpu/drm/radeon/radeon_pm.c            |  2 +-
 drivers/gpu/drm/radeon/radeon_ring.c          |  2 +-
 drivers/gpu/drm/radeon/radeon_ttm.c           |  2 +-
 drivers/gpu/drm/radeon/rs400.c                |  2 +-
 drivers/gpu/drm/radeon/rv515.c                |  2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c  |  2 +-
 drivers/gpu/drm/tegra/dc.c                    |  4 +-
 drivers/gpu/drm/tegra/dsi.c                   |  2 +-
 drivers/gpu/drm/tegra/hdmi.c                  |  2 +-
 drivers/gpu/drm/tegra/sor.c                   |  2 +-
 drivers/gpu/drm/ttm/ttm_device.c              |  2 +-
 drivers/gpu/drm/ttm/ttm_module.h              |  3 +-
 drivers/gpu/drm/ttm/ttm_resource.c            |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c           |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_gem.c           |  2 +-
 drivers/gpu/drm/xe/xe_debugfs.c               |  2 +-
 drivers/gpu/drm/xe/xe_gsc_debugfs.c           |  2 +-
 drivers/gpu/drm/xe/xe_gsc_debugfs.h           |  3 +-
 drivers/gpu/drm/xe/xe_gt_debugfs.c            |  4 +-
 drivers/gpu/drm/xe/xe_gt_sriov_pf_debugfs.c   | 28 +++----
 drivers/gpu/drm/xe/xe_gt_sriov_pf_debugfs.h   |  7 +-
 drivers/gpu/drm/xe/xe_gt_sriov_vf_debugfs.c   |  9 ++-
 drivers/gpu/drm/xe/xe_gt_sriov_vf_debugfs.h   |  4 +-
 drivers/gpu/drm/xe/xe_guc_debugfs.c           |  2 +-
 drivers/gpu/drm/xe/xe_guc_debugfs.h           |  3 +-
 drivers/gpu/drm/xe/xe_huc_debugfs.c           |  2 +-
 drivers/gpu/drm/xe/xe_huc_debugfs.h           |  3 +-
 drivers/gpu/drm/xe/xe_uc_debugfs.c            |  4 +-
 drivers/gpu/drm/xe/xe_uc_debugfs.h            |  3 +-
 drivers/gpu/drm/xlnx/zynqmp_dp.c              |  4 +-
 drivers/gpu/host1x/debug.c                    |  2 +-
 drivers/gpu/host1x/dev.h                      |  6 +-
 drivers/gpu/vga/vga_switcheroo.c              |  2 +-
 drivers/greybus/debugfs.c                     |  4 +-
 drivers/greybus/es2.c                         |  4 +-
 drivers/greybus/svc.c                         |  4 +-
 drivers/hid/hid-debug.c                       |  2 +-
 drivers/hid/hid-picolcd.h                     |  6 +-
 drivers/hid/hid-picolcd_debugfs.c             |  2 +-
 drivers/hid/hid-wiimote-debug.c               |  4 +-
 drivers/hsi/controllers/omap_ssi.h            |  4 +-
 drivers/hsi/controllers/omap_ssi_core.c       |  2 +-
 drivers/hsi/controllers/omap_ssi_port.c       |  2 +-
 drivers/hte/hte.c                             |  6 +-
 drivers/hv/hv_debugfs.c                       | 17 +++--
 drivers/hwmon/aquacomputer_d5next.c           |  2 +-
 drivers/hwmon/asus_atk0110.c                  |  2 +-
 drivers/hwmon/corsair-cpro.c                  |  2 +-
 drivers/hwmon/corsair-psu.c                   |  2 +-
 drivers/hwmon/gigabyte_waterforce.c           |  2 +-
 drivers/hwmon/hp-wmi-sensors.c                |  6 +-
 drivers/hwmon/ina3221.c                       |  2 +-
 drivers/hwmon/isl28022.c                      |  4 +-
 drivers/hwmon/ltc4282.c                       |  2 +-
 drivers/hwmon/mr75203.c                       |  2 +-
 drivers/hwmon/nzxt-kraken3.c                  |  2 +-
 drivers/hwmon/pmbus/acbel-fsg032.c            |  2 +-
 drivers/hwmon/pmbus/adm1266.c                 |  4 +-
 drivers/hwmon/pmbus/dps920ab.c                |  4 +-
 drivers/hwmon/pmbus/ibm-cffps.c               |  2 +-
 drivers/hwmon/pmbus/max20730.c                |  4 +-
 drivers/hwmon/pmbus/pmbus.h                   |  2 +-
 drivers/hwmon/pmbus/pmbus_core.c              |  8 +-
 drivers/hwmon/pmbus/q54sj108a2.c              |  4 +-
 drivers/hwmon/pmbus/ucd9000.c                 |  4 +-
 drivers/hwmon/pt5161l.c                       |  4 +-
 drivers/hwmon/sg2042-mcu.c                    |  4 +-
 drivers/hwmon/sht3x.c                         |  4 +-
 drivers/hwmon/tps23861.c                      |  2 +-
 drivers/hwspinlock/sun6i_hwspinlock.c         |  2 +-
 .../hwtracing/coresight/coresight-cpu-debug.c |  2 +-
 drivers/hwtracing/intel_th/debug.c            |  2 +-
 drivers/hwtracing/intel_th/debug.h            |  2 +-
 drivers/i2c/i2c-core-base.c                   |  2 +-
 drivers/iio/adc/ad9467.c                      |  2 +-
 drivers/iio/adc/stm32-adc.c                   |  2 +-
 drivers/iio/gyro/adis16136.c                  |  2 +-
 drivers/iio/imu/adis16400.c                   |  2 +-
 drivers/iio/imu/adis16460.c                   |  2 +-
 drivers/iio/imu/adis16475.c                   |  2 +-
 drivers/iio/imu/adis16480.c                   |  2 +-
 drivers/iio/imu/bno055/bno055.c               |  2 +-
 drivers/iio/industrialio-backend.c            |  4 +-
 drivers/iio/industrialio-core.c               |  4 +-
 drivers/infiniband/hw/bnxt_re/bnxt_re.h       |  4 +-
 drivers/infiniband/hw/bnxt_re/debugfs.c       |  2 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.h      |  2 +-
 drivers/infiniband/hw/cxgb4/device.c          |  2 +-
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h        |  2 +-
 drivers/infiniband/hw/hfi1/debugfs.c          |  4 +-
 drivers/infiniband/hw/hfi1/fault.c            |  4 +-
 drivers/infiniband/hw/hfi1/fault.h            |  2 +-
 drivers/infiniband/hw/hns/hns_roce_debugfs.c  |  7 +-
 drivers/infiniband/hw/mlx5/main.c             |  2 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |  8 +-
 drivers/infiniband/hw/mlx5/mr.c               |  4 +-
 drivers/infiniband/hw/ocrdma/ocrdma_stats.c   |  2 +-
 drivers/infiniband/hw/qib/qib_debugfs.c       |  4 +-
 drivers/infiniband/hw/qib/qib_verbs.h         |  2 +-
 drivers/infiniband/hw/usnic/usnic_debugfs.c   |  4 +-
 drivers/infiniband/hw/usnic/usnic_ib_qp_grp.h |  2 +-
 drivers/infiniband/ulp/ipoib/ipoib.h          |  4 +-
 drivers/infiniband/ulp/ipoib/ipoib_fs.c       |  2 +-
 drivers/input/keyboard/applespi.c             |  2 +-
 drivers/input/touchscreen/edt-ft5x06.c        |  2 +-
 drivers/interconnect/core.c                   |  2 +-
 drivers/interconnect/debugfs-client.c         |  6 +-
 drivers/interconnect/internal.h               |  2 +-
 drivers/iommu/amd/amd_iommu_types.h           |  2 +-
 drivers/iommu/amd/debugfs.c                   |  2 +-
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    |  2 +-
 drivers/iommu/intel/debugfs.c                 |  2 +-
 drivers/iommu/intel/iommu.h                   |  4 +-
 drivers/iommu/iommu-debugfs.c                 |  2 +-
 drivers/iommu/iommufd/selftest.c              |  2 +-
 drivers/iommu/omap-iommu-debug.c              |  4 +-
 drivers/iommu/omap-iommu.h                    |  2 +-
 drivers/iommu/tegra-smmu.c                    |  2 +-
 drivers/mailbox/bcm-flexrm-mailbox.c          |  2 +-
 drivers/mailbox/bcm-pdc-mailbox.c             |  2 +-
 drivers/mailbox/mailbox-test.c                |  2 +-
 drivers/md/bcache/bcache.h                    |  2 +-
 drivers/md/bcache/debug.c                     |  2 +-
 drivers/media/cec/core/cec-core.c             |  2 +-
 drivers/media/common/siano/smsdvb-debugfs.c   |  2 +-
 drivers/media/common/siano/smsdvb.h           |  2 +-
 drivers/media/i2c/adv7511-v4l2.c              |  2 +-
 drivers/media/i2c/adv7604.c                   |  2 +-
 drivers/media/i2c/adv7842.c                   |  2 +-
 drivers/media/i2c/tc358743.c                  |  2 +-
 drivers/media/pci/mgb4/mgb4_core.h            |  2 +-
 drivers/media/pci/mgb4/mgb4_vin.c             |  2 +-
 drivers/media/pci/mgb4/mgb4_vout.c            |  2 +-
 drivers/media/pci/saa7164/saa7164-core.c      |  2 +-
 drivers/media/pci/zoran/zoran.h               |  2 +-
 drivers/media/platform/amphion/vpu.h          |  8 +-
 drivers/media/platform/aspeed/aspeed-video.c  |  2 +-
 .../platform/chips-media/coda/coda-common.c   |  3 +-
 .../media/platform/chips-media/coda/coda.h    |  6 +-
 .../mediatek/vcodec/common/mtk_vcodec_dbgfs.c |  4 +-
 .../mediatek/vcodec/common/mtk_vcodec_dbgfs.h |  2 +-
 drivers/media/platform/mediatek/vpu/mtk_vpu.c |  2 +-
 drivers/media/platform/nxp/dw100/dw100.c      |  2 +-
 drivers/media/platform/nxp/imx-mipi-csis.c    |  2 +-
 .../platform/nxp/imx8-isi/imx8-isi-core.h     |  3 +-
 drivers/media/platform/qcom/venus/core.h      |  2 +-
 .../media/platform/raspberrypi/rp1-cfe/cfe.c  |  2 +-
 .../media/platform/raspberrypi/rp1-cfe/csi2.c |  2 +-
 .../platform/raspberrypi/rp1-cfe/pisp-fe.c    |  2 +-
 .../platform/rockchip/rkisp1/rkisp1-common.h  |  3 +-
 .../platform/rockchip/rkisp1/rkisp1-debug.c   |  2 +-
 .../platform/samsung/exynos4-is/fimc-is.h     |  2 +-
 drivers/media/platform/st/sti/bdisp/bdisp.h   |  2 +-
 drivers/media/platform/st/sti/hva/hva.h       |  4 +-
 drivers/media/radio/radio-si476x.c            |  2 +-
 .../media/test-drivers/visl/visl-debugfs.c    |  2 +-
 drivers/media/test-drivers/visl/visl.h        |  4 +-
 drivers/media/usb/uvc/uvc_debugfs.c           |  2 +-
 drivers/media/usb/uvc/uvcvideo.h              |  2 +-
 drivers/media/v4l2-core/v4l2-async.c          |  2 +-
 drivers/media/v4l2-core/v4l2-dev.c            |  4 +-
 drivers/media/v4l2-core/v4l2-dv-timings.c     |  3 +-
 drivers/memory/emif.c                         |  2 +-
 drivers/mfd/intel-lpss.c                      |  6 +-
 drivers/mfd/tps65010.c                        |  2 +-
 drivers/misc/cxl/cxl.h                        | 26 ++++---
 drivers/misc/cxl/debugfs.c                    | 21 ++++--
 drivers/misc/eeprom/idt_89hpesx.c             |  4 +-
 drivers/misc/genwqe/card_base.c               |  2 +-
 drivers/misc/genwqe/card_base.h               |  4 +-
 drivers/misc/genwqe/card_debugfs.c            |  2 +-
 drivers/misc/lkdtm/core.c                     |  2 +-
 drivers/misc/mei/debugfs.c                    |  2 +-
 drivers/misc/mei/mei_dev.h                    |  2 +-
 drivers/misc/xilinx_tmr_inject.c              |  4 +-
 drivers/mmc/core/block.c                      |  6 +-
 drivers/mmc/core/debugfs.c                    |  4 +-
 drivers/mmc/core/mmc_test.c                   |  4 +-
 drivers/mmc/host/atmel-mci.c                  |  2 +-
 drivers/mmc/host/dw_mmc.c                     |  2 +-
 drivers/mmc/host/sdhci-pci-core.c             |  2 +-
 drivers/mtd/devices/docg3.c                   |  2 +-
 drivers/mtd/mtdcore.c                         |  2 +-
 drivers/mtd/mtdswap.c                         |  2 +-
 drivers/mtd/nand/raw/nandsim.c                |  4 +-
 drivers/mtd/spi-nor/debugfs.c                 |  4 +-
 drivers/mtd/ubi/debug.c                       |  6 +-
 drivers/mtd/ubi/ubi.h                         | 22 +++---
 drivers/net/bonding/bond_debugfs.c            |  2 +-
 drivers/net/caif/caif_serial.c                |  4 +-
 drivers/net/caif/caif_virtio.c                |  2 +-
 drivers/net/ethernet/amd/pds_core/core.h      |  4 +-
 drivers/net/ethernet/amd/pds_core/debugfs.c   |  4 +-
 drivers/net/ethernet/amd/xgbe/xgbe.h          |  2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  2 +-
 .../net/ethernet/broadcom/bnxt/bnxt_debugfs.c |  6 +-
 drivers/net/ethernet/brocade/bna/bnad.h       |  2 +-
 .../net/ethernet/brocade/bna/bnad_debugfs.c   |  2 +-
 drivers/net/ethernet/chelsio/cxgb3/adapter.h  |  2 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h    |  3 +-
 .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   |  2 +-
 .../net/ethernet/chelsio/cxgb4vf/adapter.h    |  2 +-
 .../ethernet/chelsio/cxgb4vf/cxgb4vf_main.c   |  2 +-
 .../freescale/dpaa2/dpaa2-eth-debugfs.c       |  4 +-
 .../freescale/dpaa2/dpaa2-eth-debugfs.h       |  2 +-
 .../ethernet/freescale/enetc/netc_blk_ctrl.c  |  4 +-
 .../ethernet/hisilicon/hibmcge/hbg_debugfs.c  |  4 +-
 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |  2 +-
 .../ethernet/hisilicon/hns3/hns3_debugfs.c    |  6 +-
 .../ethernet/hisilicon/hns3/hns3_debugfs.h    |  2 +-
 .../hisilicon/hns3/hns3pf/hclge_main.h        |  2 +-
 .../net/ethernet/huawei/hinic/hinic_debugfs.c |  9 ++-
 drivers/net/ethernet/huawei/hinic/hinic_dev.h |  8 +-
 drivers/net/ethernet/intel/fm10k/fm10k.h      |  4 +-
 .../net/ethernet/intel/fm10k/fm10k_debugfs.c  |  2 +-
 drivers/net/ethernet/intel/i40e/i40e.h        |  2 +-
 .../net/ethernet/intel/i40e/i40e_debugfs.c    |  2 +-
 drivers/net/ethernet/intel/ice/ice.h          |  4 +-
 drivers/net/ethernet/intel/ice/ice_debugfs.c  |  4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  2 +-
 .../net/ethernet/intel/ixgbe/ixgbe_debugfs.c  |  2 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h    |  2 +-
 .../ethernet/marvell/mvpp2/mvpp2_debugfs.c    | 43 ++++++-----
 .../net/ethernet/marvell/octeontx2/af/rvu.h   | 24 +++---
 drivers/net/ethernet/marvell/skge.c           |  2 +-
 drivers/net/ethernet/marvell/skge.h           |  2 +-
 drivers/net/ethernet/marvell/sky2.c           |  4 +-
 drivers/net/ethernet/marvell/sky2.h           |  2 +-
 .../net/ethernet/mediatek/mtk_ppe_debugfs.c   |  2 +-
 drivers/net/ethernet/mediatek/mtk_wed.h       |  2 +-
 .../net/ethernet/mediatek/mtk_wed_debugfs.c   |  2 +-
 .../net/ethernet/mellanox/mlx5/core/debugfs.c |  9 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  2 +-
 .../ethernet/mellanox/mlx5/core/en/tc_ct.c    |  2 +-
 .../mellanox/mlx5/core/en_accel/ktls.c        |  2 +-
 .../mellanox/mlx5/core/en_accel/ktls_tx.c     |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_fs.c   |  8 +-
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   |  4 +-
 .../ethernet/mellanox/mlx5/core/esw/bridge.h  |  3 +-
 .../mellanox/mlx5/core/esw/bridge_priv.h      |  2 +-
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  3 +-
 .../ethernet/mellanox/mlx5/core/lag/debugfs.c |  4 +-
 .../net/ethernet/mellanox/mlx5/core/lag/lag.h |  2 +-
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  |  2 +-
 .../mellanox/mlx5/core/steering/hws/context.h |  4 +-
 .../mellanox/mlx5/core/steering/sws/dr_dbg.h  |  4 +-
 drivers/net/ethernet/meta/fbnic/fbnic.h       |  2 +-
 .../net/ethernet/meta/fbnic/fbnic_debugfs.c   |  2 +-
 .../ethernet/microchip/lan966x/lan966x_main.h |  2 +-
 .../microchip/lan966x/lan966x_vcap_impl.c     |  2 +-
 .../ethernet/microchip/sparx5/sparx5_main.h   |  2 +-
 .../microchip/sparx5/sparx5_vcap_impl.c       |  2 +-
 .../microchip/vcap/vcap_api_debugfs.c         |  9 ++-
 .../microchip/vcap/vcap_api_debugfs.h         | 14 ++--
 .../net/ethernet/microsoft/mana/gdma_main.c   |  2 +-
 drivers/net/ethernet/netronome/nfp/nfp_main.h |  3 +-
 drivers/net/ethernet/netronome/nfp/nfp_net.h  | 10 +--
 .../ethernet/netronome/nfp/nfp_net_debugfs.c  |  8 +-
 .../ethernet/netronome/nfp/nfp_netvf_main.c   |  2 +-
 drivers/net/ethernet/pensando/ionic/ionic.h   |  2 +-
 .../ethernet/pensando/ionic/ionic_debugfs.c   |  8 +-
 .../net/ethernet/pensando/ionic/ionic_lif.h   |  4 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  2 +-
 drivers/net/ethernet/vertexcom/mse102x.c      |  2 +-
 drivers/net/fjes/fjes.h                       |  2 +-
 drivers/net/fjes/fjes_debugfs.c               |  2 +-
 drivers/net/ieee802154/adf7242.c              |  2 +-
 drivers/net/ieee802154/ca8210.c               |  2 +-
 drivers/net/netdevsim/bpf.c                   |  4 +-
 drivers/net/netdevsim/dev.c                   |  6 +-
 drivers/net/netdevsim/ethtool.c               |  2 +-
 drivers/net/netdevsim/fib.c                   |  2 +-
 drivers/net/netdevsim/netdevsim.h             | 26 +++----
 drivers/net/netdevsim/psample.c               |  2 +-
 drivers/net/phy/sfp.c                         |  2 +-
 drivers/net/wireless/ath/ath10k/core.h        |  2 +-
 drivers/net/wireless/ath/ath10k/debug.h       |  3 +-
 drivers/net/wireless/ath/ath10k/debugfs_sta.c |  3 +-
 drivers/net/wireless/ath/ath10k/spectral.c    |  8 +-
 drivers/net/wireless/ath/ath11k/core.h        |  6 +-
 drivers/net/wireless/ath/ath11k/debugfs.c     |  8 +-
 drivers/net/wireless/ath/ath11k/debugfs.h     |  2 +-
 drivers/net/wireless/ath/ath11k/debugfs_sta.c |  3 +-
 drivers/net/wireless/ath/ath11k/debugfs_sta.h |  3 +-
 drivers/net/wireless/ath/ath11k/spectral.c    |  8 +-
 drivers/net/wireless/ath/ath12k/core.h        |  6 +-
 drivers/net/wireless/ath/ath12k/debugfs.c     |  4 +-
 drivers/net/wireless/ath/ath5k/debug.c        |  2 +-
 drivers/net/wireless/ath/ath6kl/core.h        |  2 +-
 drivers/net/wireless/ath/ath9k/common-debug.c |  8 +-
 .../net/wireless/ath/ath9k/common-spectral.c  | 10 +--
 drivers/net/wireless/ath/ath9k/debug.h        |  2 +-
 drivers/net/wireless/ath/ath9k/debug_sta.c    |  2 +-
 drivers/net/wireless/ath/ath9k/htc.h          |  2 +-
 drivers/net/wireless/ath/carl9170/carl9170.h  |  2 +-
 drivers/net/wireless/ath/wcn36xx/debug.c      |  2 +-
 drivers/net/wireless/ath/wcn36xx/debug.h      |  2 +-
 drivers/net/wireless/ath/wil6210/debugfs.c    | 30 ++++----
 drivers/net/wireless/ath/wil6210/wil6210.h    |  2 +-
 drivers/net/wireless/broadcom/b43/debugfs.c   |  2 +-
 drivers/net/wireless/broadcom/b43/debugfs.h   |  3 +-
 .../net/wireless/broadcom/b43legacy/debugfs.c |  2 +-
 .../net/wireless/broadcom/b43legacy/debugfs.h |  3 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.h    |  2 +-
 .../broadcom/brcm80211/brcmfmac/core.h        |  2 +-
 .../broadcom/brcm80211/brcmfmac/debug.c       |  2 +-
 .../broadcom/brcm80211/brcmfmac/debug.h       |  4 +-
 .../broadcom/brcm80211/brcmfmac/pcie.c        |  2 +-
 .../broadcom/brcm80211/brcmfmac/sdio.c        |  2 +-
 .../broadcom/brcm80211/brcmsmac/debug.c       |  4 +-
 .../broadcom/brcm80211/brcmsmac/pub.h         |  2 +-
 drivers/net/wireless/intel/iwlegacy/3945-rs.c |  2 +-
 drivers/net/wireless/intel/iwlegacy/4965-rs.c |  2 +-
 drivers/net/wireless/intel/iwlegacy/common.h  |  2 +-
 drivers/net/wireless/intel/iwlegacy/debug.c   |  4 +-
 drivers/net/wireless/intel/iwlwifi/dvm/agn.h  |  4 +-
 .../net/wireless/intel/iwlwifi/dvm/debugfs.c  |  6 +-
 drivers/net/wireless/intel/iwlwifi/dvm/dev.h  |  2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/main.c |  2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c   |  2 +-
 .../net/wireless/intel/iwlwifi/fw/debugfs.c   |  2 +-
 .../net/wireless/intel/iwlwifi/fw/debugfs.h   |  4 +-
 drivers/net/wireless/intel/iwlwifi/fw/init.c  |  2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  | 10 +--
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  2 +-
 drivers/net/wireless/intel/iwlwifi/mei/main.c |  2 +-
 .../wireless/intel/iwlwifi/mvm/debugfs-vif.c  | 10 +--
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 10 +--
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c   |  2 +-
 .../net/wireless/marvell/libertas/debugfs.c   |  2 +-
 drivers/net/wireless/marvell/libertas/dev.h   | 10 +--
 .../net/wireless/marvell/mwifiex/debugfs.c    |  2 +-
 drivers/net/wireless/marvell/mwifiex/main.h   |  2 +-
 drivers/net/wireless/mediatek/mt76/debugfs.c  |  4 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |  4 +-
 .../wireless/mediatek/mt76/mt7603/debugfs.c   |  2 +-
 .../wireless/mediatek/mt76/mt7615/debugfs.c   |  2 +-
 .../wireless/mediatek/mt76/mt76x02_debugfs.c  |  2 +-
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 14 ++--
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  5 +-
 .../wireless/mediatek/mt76/mt7921/debugfs.c   |  2 +-
 .../wireless/mediatek/mt76/mt7925/debugfs.c   |  2 +-
 .../wireless/mediatek/mt76/mt7996/debugfs.c   | 14 ++--
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  5 +-
 .../net/wireless/mediatek/mt7601u/debugfs.c   |  2 +-
 drivers/net/wireless/quantenna/qtnfmac/bus.h  |  2 +-
 drivers/net/wireless/quantenna/qtnfmac/core.c |  4 +-
 drivers/net/wireless/quantenna/qtnfmac/core.h |  2 +-
 .../net/wireless/quantenna/qtnfmac/debug.c    |  2 +-
 .../net/wireless/ralink/rt2x00/rt2x00debug.c  |  6 +-
 drivers/net/wireless/realtek/rtlwifi/debug.c  |  2 +-
 drivers/net/wireless/realtek/rtlwifi/wifi.h   |  2 +-
 drivers/net/wireless/realtek/rtw88/debug.c    | 11 ++-
 drivers/net/wireless/realtek/rtw89/debug.c    |  8 +-
 drivers/net/wireless/rsi/rsi_debugfs.h        |  2 +-
 drivers/net/wireless/silabs/wfx/debug.c       |  2 +-
 drivers/net/wireless/st/cw1200/debug.h        |  2 +-
 drivers/net/wireless/ti/wl1251/wl1251.h       |  4 +-
 drivers/net/wireless/ti/wl12xx/debugfs.c      |  4 +-
 drivers/net/wireless/ti/wl12xx/debugfs.h      |  2 +-
 drivers/net/wireless/ti/wl18xx/debugfs.c      |  4 +-
 drivers/net/wireless/ti/wl18xx/debugfs.h      |  2 +-
 drivers/net/wireless/ti/wlcore/debugfs.c      |  6 +-
 drivers/net/wireless/ti/wlcore/hw_ops.h       |  2 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c |  4 +-
 drivers/net/wwan/iosm/iosm_ipc_imem.h         |  4 +-
 drivers/net/wwan/iosm/iosm_ipc_trace.c        |  6 +-
 drivers/net/wwan/iosm/iosm_ipc_trace.h        |  2 +-
 drivers/net/wwan/t7xx/t7xx_pci.h              |  2 +-
 drivers/net/wwan/t7xx/t7xx_port_trace.c       | 12 +--
 drivers/net/wwan/wwan_core.c                  | 10 +--
 drivers/net/wwan/wwan_hwsim.c                 | 10 +--
 drivers/net/xen-netback/common.h              |  4 +-
 drivers/net/xen-netback/xenbus.c              |  2 +-
 drivers/nfc/nfcsim.c                          |  4 +-
 drivers/ntb/hw/amd/ntb_hw_amd.c               |  2 +-
 drivers/ntb/hw/amd/ntb_hw_amd.h               |  4 +-
 drivers/ntb/hw/idt/ntb_hw_idt.c               |  2 +-
 drivers/ntb/hw/idt/ntb_hw_idt.h               |  2 +-
 drivers/ntb/hw/intel/ntb_hw_gen1.c            |  2 +-
 drivers/ntb/hw/intel/ntb_hw_intel.h           |  4 +-
 drivers/ntb/ntb_transport.c                   |  8 +-
 drivers/ntb/test/ntb_msi_test.c               |  6 +-
 drivers/ntb/test/ntb_perf.c                   |  4 +-
 drivers/ntb/test/ntb_pingpong.c               |  4 +-
 drivers/ntb/test/ntb_tool.c                   |  8 +-
 drivers/nvdimm/btt.c                          |  7 +-
 drivers/nvdimm/btt.h                          |  4 +-
 drivers/nvme/host/fault_inject.c              |  2 +-
 drivers/nvme/host/nvme.h                      |  2 +-
 drivers/nvme/target/debugfs.c                 |  6 +-
 drivers/nvme/target/nvmet.h                   |  4 +-
 drivers/opp/debugfs.c                         | 18 ++---
 drivers/opp/opp.h                             |  6 +-
 drivers/pci/controller/dwc/pcie-qcom-ep.c     |  2 +-
 drivers/pci/controller/dwc/pcie-qcom.c        |  2 +-
 drivers/pci/controller/dwc/pcie-tegra194.c    |  2 +-
 drivers/pci/controller/pci-tegra.c            |  2 +-
 drivers/pci/hotplug/cpqphp.h                  |  2 +-
 drivers/pci/hotplug/cpqphp_sysfs.c            |  2 +-
 drivers/perf/arm-cmn.c                        |  4 +-
 drivers/phy/phy-core.c                        |  2 +-
 drivers/phy/realtek/phy-rtk-usb2.c            |  8 +-
 drivers/phy/realtek/phy-rtk-usb3.c            |  8 +-
 drivers/pinctrl/core.c                        |  4 +-
 drivers/pinctrl/core.h                        |  3 +-
 drivers/pinctrl/pinconf.c                     |  4 +-
 drivers/pinctrl/pinconf.h                     |  5 +-
 drivers/pinctrl/pinmux.c                      |  4 +-
 drivers/pinctrl/pinmux.h                      |  5 +-
 drivers/platform/chrome/cros_ec_debugfs.c     |  2 +-
 drivers/platform/chrome/wilco_ec/debugfs.c    |  2 +-
 drivers/platform/olpc/olpc-ec.c               |  8 +-
 drivers/platform/x86/acer-wmi.c               |  2 +-
 drivers/platform/x86/amd/pmc/pmc.h            |  2 +-
 drivers/platform/x86/amd/pmf/pmf.h            |  4 +-
 drivers/platform/x86/amd/pmf/tee-if.c         |  6 +-
 drivers/platform/x86/apple-gmux.c             |  2 +-
 drivers/platform/x86/asus-wmi.c               |  2 +-
 drivers/platform/x86/dell/dell-laptop.c       |  2 +-
 drivers/platform/x86/dell/dell-wmi-ddv.c      |  4 +-
 drivers/platform/x86/huawei-wmi.c             |  2 +-
 drivers/platform/x86/ideapad-laptop.c         |  4 +-
 drivers/platform/x86/intel/bytcrc_pwrsrc.c    |  2 +-
 drivers/platform/x86/intel/plr_tpmi.c         |  4 +-
 drivers/platform/x86/intel/pmc/core.c         |  2 +-
 drivers/platform/x86/intel/pmc/core.h         |  2 +-
 .../platform/x86/intel/telemetry/debugfs.c    |  4 +-
 drivers/platform/x86/intel/vsec_tpmi.c        |  6 +-
 drivers/platform/x86/intel_ips.c              |  2 +-
 drivers/platform/x86/msi-wmi-platform.c       |  9 ++-
 drivers/platform/x86/pmc_atom.c               |  4 +-
 drivers/platform/x86/samsung-laptop.c         |  4 +-
 drivers/pmdomain/core.c                       |  4 +-
 drivers/pmdomain/qcom/cpr.c                   |  2 +-
 drivers/power/sequencing/core.c               |  2 +-
 drivers/power/supply/da9030_battery.c         |  6 +-
 drivers/ptp/ptp_ocp.c                         |  6 +-
 drivers/ptp/ptp_private.h                     |  4 +-
 drivers/ptp/ptp_qoriq_debugfs.c               |  2 +-
 drivers/ras/amd/fmpm.c                        |  6 +-
 drivers/ras/cec.c                             |  2 +-
 drivers/ras/debugfs.c                         |  6 +-
 drivers/ras/debugfs.h                         |  4 +-
 drivers/regulator/core.c                      |  2 +-
 drivers/regulator/internal.h                  |  2 +-
 drivers/remoteproc/remoteproc_debugfs.c       |  6 +-
 drivers/remoteproc/remoteproc_internal.h      |  2 +-
 drivers/s390/block/dasd_int.h                 |  8 +-
 drivers/s390/char/zcore.c                     |  6 +-
 drivers/s390/cio/cio_debug.h                  |  2 +-
 drivers/s390/cio/cio_debugfs.c                |  2 +-
 drivers/s390/cio/qdio.h                       |  2 +-
 drivers/s390/cio/qdio_debug.c                 |  4 +-
 drivers/s390/net/qeth_core.h                  |  2 +-
 drivers/s390/net/qeth_core_main.c             |  2 +-
 drivers/scsi/bfa/bfad_debugfs.c               |  2 +-
 drivers/scsi/bfa/bfad_drv.h                   |  2 +-
 drivers/scsi/csiostor/csio_hw.h               |  2 +-
 drivers/scsi/csiostor/csio_init.c             |  2 +-
 drivers/scsi/elx/efct/efct_driver.h           |  2 +-
 drivers/scsi/elx/efct/efct_xport.c            |  2 +-
 drivers/scsi/fnic/fnic.h                      |  6 +-
 drivers/scsi/fnic/fnic_debugfs.c              | 18 ++---
 drivers/scsi/hisi_sas/hisi_sas.h              | 10 +--
 drivers/scsi/hisi_sas/hisi_sas_main.c         |  2 +-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c        | 14 ++--
 drivers/scsi/lpfc/lpfc.h                      | 74 +++++++++----------
 drivers/scsi/lpfc/lpfc_debugfs.c              |  2 +-
 drivers/scsi/megaraid/megaraid_sas.h          |  4 +-
 drivers/scsi/megaraid/megaraid_sas_base.c     |  2 +-
 drivers/scsi/megaraid/megaraid_sas_debugfs.c  |  2 +-
 drivers/scsi/mpt3sas/mpt3sas_base.h           |  4 +-
 drivers/scsi/mpt3sas/mpt3sas_debugfs.c        |  2 +-
 drivers/scsi/qedf/qedf_dbg.h                  |  2 +-
 drivers/scsi/qedf/qedf_debugfs.c              |  2 +-
 drivers/scsi/qedi/qedi_dbg.h                  |  2 +-
 drivers/scsi/qedi/qedi_debugfs.c              |  2 +-
 drivers/scsi/qla2xxx/qla_def.h                | 18 ++---
 drivers/scsi/qla2xxx/qla_dfs.c                |  2 +-
 drivers/scsi/scsi_debug.c                     |  8 +-
 drivers/scsi/snic/snic.h                      | 10 +--
 drivers/soc/amlogic/meson-clk-measure.c       |  2 +-
 drivers/soc/mediatek/mtk-svs.c                |  2 +-
 drivers/soc/qcom/qcom_aoss.c                  |  4 +-
 drivers/soc/qcom/qcom_stats.c                 |  9 ++-
 drivers/soc/qcom/rpm_master_stats.c           |  4 +-
 drivers/soc/qcom/socinfo.c                    |  4 +-
 drivers/soc/tegra/cbb/tegra-cbb.c             |  2 +-
 drivers/soc/ti/smartreflex.c                  |  4 +-
 drivers/soundwire/cadence_master.c            |  2 +-
 drivers/soundwire/cadence_master.h            |  2 +-
 drivers/soundwire/debugfs.c                   |  6 +-
 drivers/soundwire/intel.c                     |  2 +-
 drivers/soundwire/intel.h                     |  2 +-
 drivers/soundwire/intel_ace2x_debugfs.c       |  2 +-
 drivers/soundwire/qcom.c                      |  2 +-
 drivers/spi/spi-bcm2835.c                     |  4 +-
 drivers/spi/spi-bcm2835aux.c                  |  4 +-
 drivers/spi/spi-dw.h                          |  2 +-
 drivers/spi/spi-hisi-kunpeng.c                |  2 +-
 drivers/staging/greybus/loopback.c            |  4 +-
 .../interface/vchiq_arm/vchiq_debugfs.c       |  6 +-
 .../interface/vchiq_arm/vchiq_debugfs.h       |  2 +-
 drivers/thermal/broadcom/bcm2835_thermal.c    |  2 +-
 drivers/thermal/intel/intel_powerclamp.c      |  2 +-
 drivers/thermal/intel/x86_pkg_temp_thermal.c  |  2 +-
 drivers/thermal/mediatek/lvts_thermal.c       |  4 +-
 drivers/thermal/qcom/tsens.h                  |  4 +-
 drivers/thermal/tegra/soctherm.c              |  4 +-
 drivers/thermal/testing/command.c             |  2 +-
 drivers/thermal/testing/thermal_testing.h     |  2 +-
 drivers/thermal/testing/zone.c                |  2 +-
 drivers/thermal/thermal_debugfs.c             | 11 +--
 drivers/thunderbolt/debugfs.c                 | 22 +++---
 drivers/thunderbolt/dma_test.c                |  2 +-
 drivers/thunderbolt/tb.h                      |  2 +-
 drivers/tty/serial/8250/8250_bcm7271.c        |  4 +-
 drivers/ufs/core/ufs-debugfs.c                |  6 +-
 drivers/ufs/host/ufshcd-pci.c                 |  4 +-
 drivers/usb/chipidea/debug.c                  |  2 +-
 drivers/usb/common/common.c                   |  2 +-
 drivers/usb/common/ulpi.c                     |  4 +-
 drivers/usb/dwc2/core.h                       |  4 +-
 drivers/usb/dwc2/debugfs.c                    |  4 +-
 drivers/usb/dwc3/core.h                       |  2 +-
 drivers/usb/dwc3/debugfs.c                    |  4 +-
 drivers/usb/fotg210/fotg210-hcd.c             |  4 +-
 drivers/usb/gadget/udc/atmel_usba_udc.c       |  4 +-
 drivers/usb/gadget/udc/atmel_usba_udc.h       |  4 +-
 drivers/usb/gadget/udc/bcm63xx_udc.c          |  2 +-
 drivers/usb/gadget/udc/gr_udc.c               |  2 +-
 drivers/usb/gadget/udc/pxa27x_udc.c           |  2 +-
 drivers/usb/gadget/udc/renesas_usb3.c         |  2 +-
 drivers/usb/host/ehci-dbg.c                   |  2 +-
 drivers/usb/host/ehci.h                       |  2 +-
 drivers/usb/host/fhci.h                       |  2 +-
 drivers/usb/host/ohci-dbg.c                   |  4 +-
 drivers/usb/host/ohci.h                       |  2 +-
 drivers/usb/host/uhci-debug.c                 |  2 +-
 drivers/usb/host/xhci-debugfs.c               | 18 ++---
 drivers/usb/host/xhci-debugfs.h               |  4 +-
 drivers/usb/host/xhci.h                       |  4 +-
 drivers/usb/mon/mon_text.c                    |  2 +-
 drivers/usb/mon/usb_mon.h                     |  6 +-
 drivers/usb/mtu3/mtu3.h                       |  2 +-
 drivers/usb/mtu3/mtu3_debugfs.c               | 16 ++--
 drivers/usb/musb/musb_core.h                  |  2 +-
 drivers/usb/musb/musb_debugfs.c               |  2 +-
 drivers/usb/musb/musb_dsps.c                  |  4 +-
 drivers/usb/typec/mux/intel_pmc_mux.c         |  6 +-
 drivers/usb/typec/tcpm/fusb302.c              |  2 +-
 drivers/usb/typec/tcpm/tcpm.c                 |  2 +-
 drivers/usb/typec/ucsi/debugfs.c              |  2 +-
 drivers/usb/typec/ucsi/ucsi.h                 |  3 +-
 drivers/vdpa/mlx5/net/debug.c                 |  2 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.h             | 12 +--
 drivers/vdpa/pds/aux_drv.h                    |  2 +-
 drivers/vdpa/pds/debugfs.c                    |  2 +-
 drivers/vfio/debugfs.c                        |  4 +-
 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    |  4 +-
 drivers/video/fbdev/omap2/omapfb/dss/core.c   |  2 +-
 drivers/virtio/virtio_debug.c                 |  2 +-
 drivers/watchdog/bcm_kona_wdt.c               |  4 +-
 drivers/watchdog/dw_wdt.c                     |  2 +-
 drivers/watchdog/ie6xx_wdt.c                  |  2 +-
 drivers/watchdog/mei_wdt.c                    |  4 +-
 fs/bcachefs/debug.c                           |  4 +-
 fs/ceph/super.h                               | 10 +--
 fs/dlm/debug_fs.c                             |  6 +-
 fs/dlm/dlm_internal.h                         | 12 +--
 fs/f2fs/debug.c                               |  2 +-
 fs/gfs2/glock.c                               |  2 +-
 fs/gfs2/incore.h                              |  2 +-
 fs/ocfs2/blockcheck.c                         |  8 +-
 fs/ocfs2/blockcheck.h                         |  4 +-
 fs/ocfs2/cluster/heartbeat.c                  | 10 +--
 fs/ocfs2/cluster/netdebug.c                   |  2 +-
 fs/ocfs2/dlm/dlmcommon.h                      |  2 +-
 fs/ocfs2/dlm/dlmdebug.c                       |  2 +-
 fs/ocfs2/ocfs2.h                              |  2 +-
 fs/ocfs2/super.c                              |  2 +-
 fs/orangefs/orangefs-debugfs.c                |  4 +-
 fs/pstore/ftrace.c                            |  2 +-
 fs/ubifs/debug.c                              | 14 ++--
 fs/xfs/scrub/stats.c                          |  7 +-
 fs/xfs/xfs_mount.h                            |  2 +-
 fs/xfs/xfs_super.c                            |  8 +-
 include/drm/drm_connector.h                   |  2 +-
 include/drm/drm_crtc.h                        |  2 +-
 include/drm/drm_debugfs.h                     | 13 ++--
 include/drm/drm_device.h                      |  2 +-
 include/drm/drm_drv.h                         |  5 +-
 include/drm/drm_encoder.h                     |  2 +-
 include/drm/drm_file.h                        |  4 +-
 include/drm/drm_panel.h                       |  1 +
 include/kunit/test.h                          |  2 +-
 include/linux/backing-dev-defs.h              |  3 +-
 include/linux/blk-mq.h                        |  4 +-
 include/linux/blkdev.h                        |  6 +-
 include/linux/blktrace_api.h                  |  2 +-
 include/linux/cdx/cdx_bus.h                   |  2 +-
 include/linux/ceph/libceph.h                  |  8 +-
 include/linux/ceph/mon_client.h               |  2 +-
 include/linux/ceph/osd_client.h               |  2 +-
 include/linux/clk-provider.h                  |  1 +
 include/linux/dmaengine.h                     |  2 +-
 include/linux/edac.h                          |  2 +-
 include/linux/fault-inject.h                  |  9 ++-
 include/linux/firmware/cirrus/cs_dsp.h        |  5 +-
 include/linux/fsl/ptp_qoriq.h                 |  2 +-
 include/linux/greybus.h                       |  2 +-
 include/linux/greybus/svc.h                   |  2 +-
 include/linux/hid.h                           |  6 +-
 include/linux/hisi_acc_qm.h                   |  4 +-
 include/linux/hyperv.h                        |  2 +-
 include/linux/i2c.h                           |  4 +-
 include/linux/iio/iio-opaque.h                |  2 +-
 include/linux/iio/iio.h                       |  4 +-
 include/linux/intel_tpmi.h                    |  2 +-
 include/linux/iommu.h                         |  2 +-
 include/linux/kvm_host.h                      |  5 +-
 include/linux/mfd/aat2870.h                   |  2 +-
 include/linux/mhi.h                           |  2 +-
 include/linux/mlx5/driver.h                   | 24 +++---
 include/linux/mmc/card.h                      |  2 +-
 include/linux/mmc/host.h                      |  2 +-
 include/linux/moxtet.h                        |  2 +-
 include/linux/mtd/mtd.h                       |  2 +-
 include/linux/mtd/spi-nor.h                   |  2 +-
 include/linux/phy/phy.h                       |  2 +-
 include/linux/pktcdvd.h                       |  4 +-
 include/linux/power/smartreflex.h             |  2 +-
 include/linux/regulator/driver.h              |  2 +-
 include/linux/remoteproc.h                    |  2 +-
 include/linux/shrinker.h                      |  2 +-
 include/linux/soundwire/sdw.h                 |  5 +-
 include/linux/sunrpc/clnt.h                   |  2 +-
 include/linux/sunrpc/xprt.h                   |  2 +-
 include/linux/swiotlb.h                       |  2 +-
 include/linux/thunderbolt.h                   |  2 +-
 include/linux/usb.h                           |  2 +-
 include/linux/vfio.h                          |  2 +-
 include/linux/virtio.h                        |  2 +-
 include/linux/wkup_m3_ipc.h                   |  2 +-
 include/linux/wwan.h                          |  8 +-
 include/linux/xattr.h                         |  1 +
 include/media/v4l2-dev.h                      |  5 +-
 include/media/v4l2-dv-timings.h               |  8 +-
 include/net/6lowpan.h                         |  2 +-
 include/net/bluetooth/bluetooth.h             |  2 +-
 include/net/bluetooth/hci_core.h              |  4 +-
 include/net/bonding.h                         |  2 +-
 include/net/cfg80211.h                        |  2 +-
 include/net/mac80211.h                        |  2 +-
 include/net/mana/gdma.h                       |  4 +-
 include/net/mana/mana.h                       | 10 +--
 include/soc/tegra/bpmp.h                      |  2 +-
 include/sound/core.h                          |  4 +-
 include/sound/soc-component.h                 |  2 +-
 include/sound/soc-dapm.h                      |  2 +-
 include/sound/soc-dpcm.h                      |  2 +-
 include/sound/soc.h                           |  4 +-
 include/ufs/ufshcd.h                          |  2 +-
 kernel/dma/debug.c                            |  2 +-
 kernel/dma/map_benchmark.c                    |  4 +-
 kernel/dma/pool.c                             |  2 +-
 kernel/fail_function.c                        |  6 +-
 kernel/futex/core.c                           |  2 +-
 kernel/gcov/fs.c                              |  4 +-
 kernel/irq/debugfs.c                          |  4 +-
 kernel/irq/internals.h                        |  4 +-
 kernel/irq/irqdomain.c                        |  4 +-
 kernel/kprobes.c                              |  2 +-
 kernel/locking/lock_events.c                  |  2 +-
 kernel/module/internal.h                      |  2 +-
 kernel/module/main.c                          |  2 +-
 kernel/module/tracking.c                      |  2 +-
 kernel/power/energy_model.c                   |  8 +-
 kernel/printk/index.c                         |  4 +-
 kernel/sched/debug.c                          | 16 ++--
 kernel/trace/blktrace.c                       |  8 +-
 lib/842/842_debugfs.h                         |  2 +-
 lib/debugobjects.c                            |  2 +-
 lib/dynamic_debug.c                           |  2 +-
 lib/error-inject.c                            |  2 +-
 lib/fault-inject-usercopy.c                   |  2 +-
 lib/fault-inject.c                            | 13 ++--
 lib/kunit/debugfs.c                           |  2 +-
 lib/memory-notifier-error-inject.c            |  2 +-
 lib/netdev-notifier-error-inject.c            |  2 +-
 lib/notifier-error-inject.c                   | 18 +++--
 lib/notifier-error-inject.h                   |  4 +-
 lib/of-reconfig-notifier-error-inject.c       |  2 +-
 lib/pm-notifier-error-inject.c                |  2 +-
 lib/stackdepot.c                              |  2 +-
 lib/test_fpu_glue.c                           |  2 +-
 mm/backing-dev.c                              |  2 +-
 mm/cma_debug.c                                |  7 +-
 mm/fail_page_alloc.c                          |  2 +-
 mm/failslab.c                                 |  2 +-
 mm/hwpoison-inject.c                          |  2 +-
 mm/internal.h                                 |  8 +-
 mm/kfence/core.c                              |  2 +-
 mm/memblock.c                                 |  2 +-
 mm/page_owner.c                               |  2 +-
 mm/shrinker.c                                 |  2 +-
 mm/shrinker_debug.c                           | 13 ++--
 mm/slub.c                                     |  4 +-
 mm/vmstat.c                                   |  2 +-
 mm/zsmalloc.c                                 |  4 +-
 mm/zswap.c                                    |  2 +-
 net/6lowpan/debugfs.c                         | 10 +--
 net/bluetooth/6lowpan.c                       |  4 +-
 net/bluetooth/af_bluetooth.c                  |  2 +-
 net/bluetooth/iso.c                           |  2 +-
 net/bluetooth/l2cap_core.c                    |  2 +-
 net/bluetooth/rfcomm/core.c                   |  2 +-
 net/bluetooth/rfcomm/sock.c                   |  2 +-
 net/bluetooth/sco.c                           |  2 +-
 net/caif/caif_socket.c                        |  2 +-
 net/ceph/debugfs.c                            |  2 +-
 net/core/skb_fault_injection.c                |  2 +-
 net/hsr/hsr_debugfs.c                         |  4 +-
 net/hsr/hsr_main.h                            |  2 +-
 net/l2tp/l2tp_debugfs.c                       |  2 +-
 net/mac80211/debugfs.c                        |  4 +-
 net/mac80211/debugfs_netdev.c                 |  4 +-
 net/mac80211/debugfs_sta.c                    |  2 +-
 net/mac80211/driver-ops.h                     |  6 +-
 net/mac80211/ieee80211_i.h                    |  2 +-
 net/mac80211/rate.h                           |  2 +-
 net/mac80211/rc80211_minstrel_ht.c            |  2 +-
 net/mac80211/rc80211_minstrel_ht.h            |  3 +-
 net/mac80211/rc80211_minstrel_ht_debugfs.c    |  3 +-
 net/mac80211/sta_info.h                       |  4 +-
 net/sunrpc/debugfs.c                          |  8 +-
 net/wireless/core.c                           |  2 +-
 net/wireless/debugfs.c                        |  4 +-
 samples/qmi/qmi_sample_client.c               |  8 +-
 sound/core/jack.c                             |  2 +-
 sound/core/sound.c                            |  2 +-
 sound/drivers/pcmtest.c                       |  2 +-
 sound/pci/hda/cs35l56_hda.h                   |  3 +-
 sound/soc/codecs/cs35l56.c                    |  2 +-
 sound/soc/fsl/fsl_ssi.h                       |  2 +-
 sound/soc/fsl/imx-audmux.c                    |  2 +-
 sound/soc/intel/avs/avs.h                     |  2 +-
 sound/soc/mediatek/mt8365/mt8365-afe-common.h |  2 +-
 sound/soc/renesas/rcar/debugfs.c              |  2 +-
 sound/soc/soc-core.c                          |  2 +-
 sound/soc/soc-dapm.c                          |  4 +-
 sound/soc/sof/debug.c                         |  2 +-
 sound/soc/sof/ipc4-mtrace.c                   |  2 +-
 sound/soc/sof/sof-client-ipc-flood-test.c     |  4 +-
 .../soc/sof/sof-client-ipc-kernel-injector.c  |  4 +-
 sound/soc/sof/sof-client-ipc-msg-injector.c   |  4 +-
 sound/soc/sof/sof-client-probes.c             |  2 +-
 sound/soc/sof/sof-client-probes.h             |  4 +-
 sound/soc/sof/sof-client.c                    |  2 +-
 sound/soc/sof/sof-client.h                    |  3 +-
 sound/soc/sof/sof-priv.h                      |  2 +-
 virt/kvm/kvm_main.c                           |  8 +-
 1059 files changed, 2172 insertions(+), 1989 deletions(-)

diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
index 6a5815aa05e6..0f668545bbc2 100644
--- a/arch/arm/mach-omap1/pm.c
+++ b/arch/arm/mach-omap1/pm.c
@@ -490,7 +490,7 @@ DEFINE_SHOW_ATTRIBUTE(omap_pm_debug);
 
 static void omap_pm_init_debugfs(void)
 {
-	struct dentry *d;
+	struct debugfs_node *d;
 
 	d = debugfs_create_dir("pm_debug", NULL);
 	debugfs_create_file("omap_pm", S_IWUSR | S_IRUGO, d, NULL,
diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index b43eab9879d3..e6f29101bb46 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -175,7 +175,7 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *dir)
 {
 	int i;
 	s64 t;
-	struct dentry *d;
+	struct debugfs_node *d;
 
 	t = sched_clock();
 
@@ -221,7 +221,7 @@ DEFINE_SIMPLE_ATTRIBUTE(pm_dbg_option_fops, option_get, option_set, "%llu\n");
 
 static int __init pm_dbg_init(void)
 {
-	struct dentry *d;
+	struct debugfs_node *d;
 
 	if (pm_dbg_init_done)
 		return 0;
diff --git a/arch/loongarch/kernel/kdebugfs.c b/arch/loongarch/kernel/kdebugfs.c
index 80cf64772399..691ddb8c1b35 100644
--- a/arch/loongarch/kernel/kdebugfs.c
+++ b/arch/loongarch/kernel/kdebugfs.c
@@ -5,7 +5,7 @@
 #include <linux/kstrtox.h>
 #include <asm/loongarch.h>
 
-struct dentry *arch_debugfs_dir;
+struct debugfs_node *arch_debugfs_dir;
 EXPORT_SYMBOL(arch_debugfs_dir);
 
 static int sfb_state, tso_state;
diff --git a/arch/microblaze/include/asm/processor.h b/arch/microblaze/include/asm/processor.h
index 4e193c7550df..d4cb57fadc61 100644
--- a/arch/microblaze/include/asm/processor.h
+++ b/arch/microblaze/include/asm/processor.h
@@ -85,7 +85,7 @@ unsigned long __get_wchan(struct task_struct *p);
 #  define STACK_TOP_MAX	STACK_TOP
 
 #ifdef CONFIG_DEBUG_FS
-extern struct dentry *of_debugfs_root;
+extern struct debugfs_node *of_debugfs_root;
 #endif
 
 #  endif /* __ASSEMBLY__ */
diff --git a/arch/microblaze/kernel/setup.c b/arch/microblaze/kernel/setup.c
index f417333eccae..f16b04f7810f 100644
--- a/arch/microblaze/kernel/setup.c
+++ b/arch/microblaze/kernel/setup.c
@@ -181,7 +181,7 @@ void __init time_init(void)
 }
 
 #ifdef CONFIG_DEBUG_FS
-struct dentry *of_debugfs_root;
+struct debugfs_node *of_debugfs_root;
 
 static int microblaze_debugfs_init(void)
 {
diff --git a/arch/mips/cavium-octeon/oct_ilm.c b/arch/mips/cavium-octeon/oct_ilm.c
index dc05262e85ff..a6b82b03e4ab 100644
--- a/arch/mips/cavium-octeon/oct_ilm.c
+++ b/arch/mips/cavium-octeon/oct_ilm.c
@@ -26,7 +26,7 @@ struct latency_info {
 };
 
 static struct latency_info li;
-static struct dentry *dir;
+static struct debugfs_node *dir;
 
 static int oct_ilm_show(struct seq_file *m, void *v)
 {
diff --git a/arch/mips/include/asm/debug.h b/arch/mips/include/asm/debug.h
index e70392429246..b51c659851d6 100644
--- a/arch/mips/include/asm/debug.h
+++ b/arch/mips/include/asm/debug.h
@@ -13,6 +13,6 @@
  * of the DebugFS hierarchy. MIPS-specific DebugFS entries should be
  * placed beneath this directory.
  */
-extern struct dentry *mips_debugfs_dir;
+extern struct debugfs_node *mips_debugfs_dir;
 
 #endif /* __MIPS_ASM_DEBUG_H__ */
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index fbfe0771317e..d64ab3cddac4 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -800,7 +800,7 @@ unsigned long kernelsp[NR_CPUS];
 unsigned long fw_arg0, fw_arg1, fw_arg2, fw_arg3;
 
 #ifdef CONFIG_DEBUG_FS
-struct dentry *mips_debugfs_dir;
+struct debugfs_node *mips_debugfs_dir;
 static int __init debugfs_mips(void)
 {
 	mips_debugfs_dir = debugfs_create_dir("mips", NULL);
diff --git a/arch/mips/math-emu/me-debugfs.c b/arch/mips/math-emu/me-debugfs.c
index d5ad76b2bb67..e70132e8affc 100644
--- a/arch/mips/math-emu/me-debugfs.c
+++ b/arch/mips/math-emu/me-debugfs.c
@@ -187,8 +187,8 @@ DEFINE_SHOW_ATTRIBUTE(fpuemustats_clear);
 
 static int __init debugfs_fpuemu(void)
 {
-	struct dentry *fpuemu_debugfs_base_dir;
-	struct dentry *fpuemu_debugfs_inst_dir;
+	struct debugfs_node *fpuemu_debugfs_base_dir;
+	struct debugfs_node *fpuemu_debugfs_inst_dir;
 	char name[32];
 
 	fpuemu_debugfs_base_dir = debugfs_create_dir("fpuemustats",
diff --git a/arch/mips/mm/sc-debugfs.c b/arch/mips/mm/sc-debugfs.c
index 80ff3947157d..7ccc799ab264 100644
--- a/arch/mips/mm/sc-debugfs.c
+++ b/arch/mips/mm/sc-debugfs.c
@@ -51,7 +51,7 @@ static const struct file_operations sc_prefetch_fops = {
 
 static int __init sc_debugfs_init(void)
 {
-	struct dentry *dir;
+	struct debugfs_node *dir;
 
 	dir = debugfs_create_dir("l2cache", mips_debugfs_dir);
 	debugfs_create_file("prefetch", S_IRUGO | S_IWUSR, dir, NULL,
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 0ebae6e4c19d..7625ed26d380 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -52,7 +52,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(iommu_debugfs_fops_weight, iommu_debugfs_weight_get, NU
 static void iommu_debugfs_add(struct iommu_table *tbl)
 {
 	char name[10];
-	struct dentry *liobn_entry;
+	struct debugfs_node *liobn_entry;
 
 	sprintf(name, "%08lx", tbl->it_index);
 	liobn_entry = debugfs_create_dir(name, iommu_debugfs_dir);
@@ -130,7 +130,7 @@ static bool should_fail_iommu(struct device *dev)
 
 static int __init fail_iommu_debugfs(void)
 {
-	struct dentry *dir = fault_create_debugfs_attr("fail_iommu",
+	struct debugfs_node *dir = fault_create_debugfs_attr("fail_iommu",
 						       NULL, &fail_iommu);
 
 	return PTR_ERR_OR_ZERO(dir);
diff --git a/arch/powerpc/kernel/kdebugfs.c b/arch/powerpc/kernel/kdebugfs.c
index 36d3124d5a8b..58c4c39ddf59 100644
--- a/arch/powerpc/kernel/kdebugfs.c
+++ b/arch/powerpc/kernel/kdebugfs.c
@@ -3,7 +3,7 @@
 #include <linux/export.h>
 #include <linux/init.h>
 
-struct dentry *arch_debugfs_dir;
+struct debugfs_node *arch_debugfs_dir;
 EXPORT_SYMBOL(arch_debugfs_dir);
 
 static int __init arch_kdebugfs_init(void)
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index edf5cabe5dfd..00886ea01453 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -2311,7 +2311,7 @@ void ppc_warn_emulated_print(const char *type)
 
 static int __init ppc_warn_emulated_init(void)
 {
-	struct dentry *dir;
+	struct debugfs_node *dir;
 	unsigned int i;
 	struct ppc_emulated_entry *entries = (void *)&ppc_emulated;
 
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 86bff159c51e..9bef986752b9 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -2943,7 +2943,8 @@ static const struct file_operations debugfs_timings_ops = {
 };
 
 /* Create a debugfs directory for the vcpu */
-static int kvmppc_arch_create_vcpu_debugfs_hv(struct kvm_vcpu *vcpu, struct dentry *debugfs_dentry)
+static int kvmppc_arch_create_vcpu_debugfs_hv(struct kvm_vcpu *vcpu,
+					      struct debugfs_node *debugfs_dentry)
 {
 	if (cpu_has_feature(CPU_FTR_ARCH_300) == IS_ENABLED(CONFIG_KVM_BOOK3S_HV_P9_TIMING))
 		debugfs_create_file("timings", 0444, debugfs_dentry, vcpu,
@@ -2952,7 +2953,8 @@ static int kvmppc_arch_create_vcpu_debugfs_hv(struct kvm_vcpu *vcpu, struct dent
 }
 
 #else /* CONFIG_KVM_BOOK3S_HV_EXIT_TIMING */
-static int kvmppc_arch_create_vcpu_debugfs_hv(struct kvm_vcpu *vcpu, struct dentry *debugfs_dentry)
+static int kvmppc_arch_create_vcpu_debugfs_hv(struct kvm_vcpu *vcpu,
+					      struct debugfs_node *debugfs_dentry)
 {
 	return 0;
 }
diff --git a/arch/powerpc/kvm/book3s_xics.h b/arch/powerpc/kvm/book3s_xics.h
index 08fb0843faf5..40f3e0899af8 100644
--- a/arch/powerpc/kvm/book3s_xics.h
+++ b/arch/powerpc/kvm/book3s_xics.h
@@ -103,7 +103,7 @@ struct kvmppc_ics {
 struct kvmppc_xics {
 	struct kvm *kvm;
 	struct kvm_device *dev;
-	struct dentry *dentry;
+	struct debugfs_node *dentry;
 	u32 max_icsid;
 	bool real_mode;
 	bool real_mode_dbg;
diff --git a/arch/powerpc/kvm/book3s_xive.h b/arch/powerpc/kvm/book3s_xive.h
index 62bf39f53783..de21364398b9 100644
--- a/arch/powerpc/kvm/book3s_xive.h
+++ b/arch/powerpc/kvm/book3s_xive.h
@@ -103,7 +103,7 @@ struct kvmppc_xive_ops {
 struct kvmppc_xive {
 	struct kvm *kvm;
 	struct kvm_device *dev;
-	struct dentry *dentry;
+	struct debugfs_node *dentry;
 
 	/* VP block associated with the VM */
 	u32	vp_base;
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index ce1d91eed231..6f19e2932b36 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -2521,7 +2521,8 @@ EXPORT_SYMBOL_GPL(kvmppc_init_lpid);
 
 EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_ppc_instr);
 
-void kvm_arch_create_vcpu_debugfs(struct kvm_vcpu *vcpu, struct dentry *debugfs_dentry)
+void kvm_arch_create_vcpu_debugfs(struct kvm_vcpu *vcpu,
+				  struct debugfs_node *debugfs_dentry)
 {
 	if (vcpu->kvm->arch.kvm_ops->create_vcpu_debugfs)
 		vcpu->kvm->arch.kvm_ops->create_vcpu_debugfs(vcpu, debugfs_dentry);
diff --git a/arch/powerpc/kvm/timing.c b/arch/powerpc/kvm/timing.c
index 25071331f8c1..e022f4660999 100644
--- a/arch/powerpc/kvm/timing.c
+++ b/arch/powerpc/kvm/timing.c
@@ -205,7 +205,7 @@ static const struct file_operations kvmppc_exit_timing_fops = {
 };
 
 int kvmppc_create_vcpu_debugfs_e500(struct kvm_vcpu *vcpu,
-				    struct dentry *debugfs_dentry)
+				    struct debugfs_node *debugfs_dentry)
 {
 	debugfs_create_file("timing", 0666, debugfs_dentry,
 			    vcpu, &kvmppc_exit_timing_fops);
diff --git a/arch/powerpc/kvm/timing.h b/arch/powerpc/kvm/timing.h
index 45817ab82bb4..106b1e6b51a8 100644
--- a/arch/powerpc/kvm/timing.h
+++ b/arch/powerpc/kvm/timing.h
@@ -15,7 +15,7 @@
 void kvmppc_init_timing_stats(struct kvm_vcpu *vcpu);
 void kvmppc_update_timing_stats(struct kvm_vcpu *vcpu);
 int kvmppc_create_vcpu_debugfs_e500(struct kvm_vcpu *vcpu,
-				    struct dentry *debugfs_dentry);
+				    struct debugfs_node *debugfs_dentry);
 
 static inline void kvmppc_set_exit_type(struct kvm_vcpu *vcpu, int type)
 {
@@ -27,7 +27,7 @@ static inline void kvmppc_set_exit_type(struct kvm_vcpu *vcpu, int type)
 static inline void kvmppc_init_timing_stats(struct kvm_vcpu *vcpu) {}
 static inline void kvmppc_update_timing_stats(struct kvm_vcpu *vcpu) {}
 static inline int kvmppc_create_vcpu_debugfs_e500(struct kvm_vcpu *vcpu,
-						  struct dentry *debugfs_dentry)
+						  struct debugfs_node *debugfs_dentry)
 {
 	return 0;
 }
diff --git a/arch/powerpc/platforms/powernv/memtrace.c b/arch/powerpc/platforms/powernv/memtrace.c
index 4ac9808e55a4..6da069551fd2 100644
--- a/arch/powerpc/platforms/powernv/memtrace.c
+++ b/arch/powerpc/platforms/powernv/memtrace.c
@@ -26,7 +26,7 @@ struct memtrace_entry {
 	u64 start;
 	u64 size;
 	u32 nid;
-	struct dentry *dir;
+	struct debugfs_node *dir;
 	char name[16];
 };
 
@@ -159,7 +159,7 @@ static int memtrace_init_regions_runtime(u64 size)
 	return 0;
 }
 
-static struct dentry *memtrace_debugfs_dir;
+static struct debugfs_node *memtrace_debugfs_dir;
 
 static int memtrace_init_debugfs(void)
 {
@@ -167,7 +167,7 @@ static int memtrace_init_debugfs(void)
 	int i;
 
 	for (i = 0; i < memtrace_array_nr; i++) {
-		struct dentry *dir;
+		struct debugfs_node *dir;
 		struct memtrace_entry *ent = &memtrace_array[i];
 
 		ent->mem = ioremap(ent->start, ent->size);
diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
index 828fc4d88471..598d7932b31c 100644
--- a/arch/powerpc/platforms/powernv/opal-imc.c
+++ b/arch/powerpc/platforms/powernv/opal-imc.c
@@ -18,7 +18,7 @@
 #include <asm/imc-pmu.h>
 #include <asm/cputhreads.h>
 
-static struct dentry *imc_debugfs_parent;
+static struct debugfs_node *imc_debugfs_parent;
 
 /* Helpers to export imc command and mode via debugfs */
 static int imc_mem_get(void *data, u64 *val)
@@ -35,7 +35,7 @@ static int imc_mem_set(void *data, u64 val)
 DEFINE_DEBUGFS_ATTRIBUTE(fops_imc_x64, imc_mem_get, imc_mem_set, "0x%016llx\n");
 
 static void imc_debugfs_create_x64(const char *name, umode_t mode,
-				   struct dentry *parent, u64  *value)
+				   struct debugfs_node *parent, u64  *value)
 {
 	debugfs_create_file_unsafe(name, mode, parent, value, &fops_imc_x64);
 }
diff --git a/arch/powerpc/platforms/powernv/opal-lpc.c b/arch/powerpc/platforms/powernv/opal-lpc.c
index 8a7f39e106bd..86884c8ab39f 100644
--- a/arch/powerpc/platforms/powernv/opal-lpc.c
+++ b/arch/powerpc/platforms/powernv/opal-lpc.c
@@ -350,7 +350,7 @@ static const struct file_operations lpc_fops = {
 	.llseek =	default_llseek,
 };
 
-static int opal_lpc_debugfs_create_type(struct dentry *folder,
+static int opal_lpc_debugfs_create_type(struct debugfs_node *folder,
 					const char *fname,
 					enum OpalLPCAddressType type)
 {
@@ -365,7 +365,7 @@ static int opal_lpc_debugfs_create_type(struct dentry *folder,
 
 static int opal_lpc_init_debugfs(void)
 {
-	struct dentry *root;
+	struct debugfs_node *root;
 	int rc = 0;
 
 	if (opal_lpc_chip_id < 0)
diff --git a/arch/powerpc/platforms/powernv/opal-xscom.c b/arch/powerpc/platforms/powernv/opal-xscom.c
index 748c2b97fa53..daf91de76ed1 100644
--- a/arch/powerpc/platforms/powernv/opal-xscom.c
+++ b/arch/powerpc/platforms/powernv/opal-xscom.c
@@ -152,11 +152,12 @@ static const struct file_operations scom_debug_fops = {
 	.llseek =	default_llseek,
 };
 
-static int scom_debug_init_one(struct dentry *root, struct device_node *dn,
+static int scom_debug_init_one(struct debugfs_node *root,
+			       struct device_node *dn,
 			       int chip)
 {
 	struct scom_debug_entry *ent;
-	struct dentry *dir;
+	struct debugfs_node *dir;
 
 	ent = kzalloc(sizeof(*ent), GFP_KERNEL);
 	if (!ent)
@@ -188,7 +189,7 @@ static int scom_debug_init_one(struct dentry *root, struct device_node *dn,
 static int scom_debug_init(void)
 {
 	struct device_node *dn;
-	struct dentry *root;
+	struct debugfs_node *root;
 	int chip, rc;
 
 	if (!firmware_has_feature(FW_FEATURE_OPAL))
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 93fba1f8661f..8d9e7bb95f5b 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -118,7 +118,7 @@ struct pnv_phb {
 
 #ifdef CONFIG_DEBUG_FS
 	int			has_dbgfs;
-	struct dentry		*dbgfs;
+	struct debugfs_node *dbgfs;
 #endif
 
 	unsigned int		msi_base;
diff --git a/arch/powerpc/platforms/powernv/vas-debug.c b/arch/powerpc/platforms/powernv/vas-debug.c
index 3ce89a4b54be..a6d4b6f38784 100644
--- a/arch/powerpc/platforms/powernv/vas-debug.c
+++ b/arch/powerpc/platforms/powernv/vas-debug.c
@@ -12,7 +12,7 @@
 #include <asm/vas.h>
 #include "vas.h"
 
-static struct dentry *vas_debugfs;
+static struct debugfs_node *vas_debugfs;
 
 static char *cop_to_str(int cop)
 {
@@ -118,7 +118,7 @@ void vas_window_free_dbgdir(struct pnv_vas_window *pnv_win)
 
 void vas_window_init_dbgdir(struct pnv_vas_window *window)
 {
-	struct dentry *d;
+	struct debugfs_node *d;
 
 	if (!window->vinst->dbgdir)
 		return;
@@ -138,7 +138,7 @@ void vas_window_init_dbgdir(struct pnv_vas_window *window)
 
 void vas_instance_init_dbgdir(struct vas_instance *vinst)
 {
-	struct dentry *d;
+	struct debugfs_node *d;
 
 	vas_init_dbgdir();
 
diff --git a/arch/powerpc/platforms/powernv/vas.h b/arch/powerpc/platforms/powernv/vas.h
index 08d9d3d5a22b..8c4f5fe03ba0 100644
--- a/arch/powerpc/platforms/powernv/vas.h
+++ b/arch/powerpc/platforms/powernv/vas.h
@@ -342,7 +342,7 @@ struct vas_instance {
 
 	char *name;
 	char *dbgname;
-	struct dentry *dbgdir;
+	struct debugfs_node *dbgdir;
 };
 
 /*
diff --git a/arch/powerpc/platforms/pseries/dtl.c b/arch/powerpc/platforms/pseries/dtl.c
index f293588b8c7b..571de42d5296 100644
--- a/arch/powerpc/platforms/pseries/dtl.c
+++ b/arch/powerpc/platforms/pseries/dtl.c
@@ -327,7 +327,7 @@ static const struct file_operations dtl_fops = {
 	.read		= dtl_file_read,
 };
 
-static struct dentry *dtl_dir;
+static struct debugfs_node *dtl_dir;
 
 static void dtl_setup_file(struct dtl *dtl)
 {
diff --git a/arch/powerpc/platforms/pseries/hvCall_inst.c b/arch/powerpc/platforms/pseries/hvCall_inst.c
index 3a50612a78db..79588ac331e2 100644
--- a/arch/powerpc/platforms/pseries/hvCall_inst.c
+++ b/arch/powerpc/platforms/pseries/hvCall_inst.c
@@ -111,7 +111,7 @@ static void probe_hcall_exit(void *ignored, unsigned long opcode, long retval,
 
 static int __init hcall_inst_init(void)
 {
-	struct dentry *hcall_root;
+	struct debugfs_node *hcall_root;
 	char cpu_name_buf[CPU_NAME_BUF_SIZE];
 	int cpu;
 
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 6a415febc53b..d732d068b903 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -2012,7 +2012,7 @@ static int __init vpa_debugfs_init(void)
 {
 	char name[16];
 	long i;
-	struct dentry *vpa_dir;
+	struct debugfs_node *vpa_dir;
 
 	if (!firmware_has_feature(FW_FEATURE_SPLPAR))
 		return 0;
diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index a6c388bdf5d0..960a4a15a433 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -1827,8 +1827,8 @@ DEFINE_SHOW_ATTRIBUTE(xive_eq_debug);
 
 static void xive_core_debugfs_create(void)
 {
-	struct dentry *xive_dir;
-	struct dentry *xive_eq_dir;
+	struct debugfs_node *xive_dir;
+	struct debugfs_node *xive_eq_dir;
 	long cpu;
 	char name[16];
 
diff --git a/arch/powerpc/sysdev/xive/native.c b/arch/powerpc/sysdev/xive/native.c
index a0934b516933..9c4379da5939 100644
--- a/arch/powerpc/sysdev/xive/native.c
+++ b/arch/powerpc/sysdev/xive/native.c
@@ -462,7 +462,7 @@ void xive_native_sync_queue(u32 hw_irq)
 EXPORT_SYMBOL_GPL(xive_native_sync_queue);
 
 #ifdef CONFIG_DEBUG_FS
-static int xive_native_debug_create(struct dentry *xive_dir)
+static int xive_native_debug_create(struct debugfs_node *xive_dir)
 {
 	debugfs_create_bool("save-restore", 0600, xive_dir, &xive_has_save_restore);
 	return 0;
diff --git a/arch/s390/hypfs/hypfs.h b/arch/s390/hypfs/hypfs.h
index 83ebf54cca6b..4d60f851aba5 100644
--- a/arch/s390/hypfs/hypfs.h
+++ b/arch/s390/hypfs/hypfs.h
@@ -75,7 +75,7 @@ struct hypfs_dbfs_file {
 
 	/* Private data for hypfs_dbfs.c */
 	struct mutex		lock;
-	struct dentry		*dentry;
+	struct debugfs_node *dentry;
 };
 
 extern void hypfs_dbfs_create_file(struct hypfs_dbfs_file *df);
diff --git a/arch/s390/hypfs/hypfs_dbfs.c b/arch/s390/hypfs/hypfs_dbfs.c
index 5d9effb0867c..8b233443a390 100644
--- a/arch/s390/hypfs/hypfs_dbfs.c
+++ b/arch/s390/hypfs/hypfs_dbfs.c
@@ -9,7 +9,7 @@
 #include <linux/slab.h>
 #include "hypfs.h"
 
-static struct dentry *dbfs_dir;
+static struct debugfs_node *dbfs_dir;
 
 static struct hypfs_dbfs_data *hypfs_dbfs_data_alloc(struct hypfs_dbfs_file *f)
 {
diff --git a/arch/s390/include/asm/debug.h b/arch/s390/include/asm/debug.h
index 6375276d94ea..7da3a162a4aa 100644
--- a/arch/s390/include/asm/debug.h
+++ b/arch/s390/include/asm/debug.h
@@ -55,8 +55,8 @@ typedef struct debug_info {
 	int active_area;
 	int *active_pages;
 	int *active_entries;
-	struct dentry *debugfs_root_entry;
-	struct dentry *debugfs_entries[DEBUG_MAX_VIEWS];
+	struct debugfs_node *debugfs_root_entry;
+	struct debugfs_node *debugfs_entries[DEBUG_MAX_VIEWS];
 	struct debug_view *views[DEBUG_MAX_VIEWS];
 	char name[DEBUG_MAX_NAME_LEN];
 	umode_t mode;
diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 474e1f8d1d3c..5d63837a3185 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -182,7 +182,7 @@ struct zpci_dev {
 	u8		version;
 	enum pci_bus_speed max_bus_speed;
 
-	struct dentry	*debugfs_dev;
+	struct debugfs_node *debugfs_dev;
 
 	/* IOMMU and passthrough */
 	struct iommu_domain *s390_domain; /* attached IOMMU domain */
diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index ce038e9205f7..b59401b28f0d 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -167,7 +167,7 @@ static const struct file_operations debug_file_ops = {
 	.release = debug_close,
 };
 
-static struct dentry *debug_debugfs_root_entry;
+static struct debugfs_node *debug_debugfs_root_entry;
 
 /* functions */
 
@@ -1337,7 +1337,7 @@ EXPORT_SYMBOL(__debug_sprintf_exception);
 int debug_register_view(debug_info_t *id, struct debug_view *view)
 {
 	unsigned long flags;
-	struct dentry *pde;
+	struct debugfs_node *pde;
 	umode_t mode;
 	int rc = 0;
 	int i;
@@ -1386,7 +1386,7 @@ EXPORT_SYMBOL(debug_register_view);
  */
 int debug_unregister_view(debug_info_t *id, struct debug_view *view)
 {
-	struct dentry *dentry = NULL;
+	struct debugfs_node *dentry = NULL;
 	unsigned long flags;
 	int i, rc = 0;
 
diff --git a/arch/s390/kernel/hiperdispatch.c b/arch/s390/kernel/hiperdispatch.c
index 7857a7e8e56c..a8f3631e6060 100644
--- a/arch/s390/kernel/hiperdispatch.c
+++ b/arch/s390/kernel/hiperdispatch.c
@@ -395,7 +395,7 @@ DEFINE_SIMPLE_ATTRIBUTE(hd_adjustments_fops, hd_adjustment_count_get, NULL, "%ll
 
 static void __init hd_create_debugfs_counters(void)
 {
-	struct dentry *dir;
+	struct debugfs_node *dir;
 
 	dir = debugfs_create_dir("hiperdispatch", arch_debugfs_dir);
 	debugfs_create_file("conservative_time_ms", 0400, dir, NULL, &hd_conservative_time_fops);
diff --git a/arch/s390/kernel/kdebugfs.c b/arch/s390/kernel/kdebugfs.c
index 33130c7daf55..43a72fcec375 100644
--- a/arch/s390/kernel/kdebugfs.c
+++ b/arch/s390/kernel/kdebugfs.c
@@ -3,7 +3,7 @@
 #include <linux/export.h>
 #include <linux/init.h>
 
-struct dentry *arch_debugfs_dir;
+struct debugfs_node *arch_debugfs_dir;
 EXPORT_SYMBOL(arch_debugfs_dir);
 
 static int __init arch_kdebugfs_init(void)
diff --git a/arch/s390/kernel/sysinfo.c b/arch/s390/kernel/sysinfo.c
index 88055f58fbda..c44d57eb4f62 100644
--- a/arch/s390/kernel/sysinfo.c
+++ b/arch/s390/kernel/sysinfo.c
@@ -546,7 +546,7 @@ static u8 stsi_0_0_0;
 
 static __init int stsi_init_debugfs(void)
 {
-	struct dentry *stsi_root;
+	struct debugfs_node *stsi_root;
 	struct stsi_file *sf;
 	int lvl, i;
 
diff --git a/arch/s390/kernel/wti.c b/arch/s390/kernel/wti.c
index 949fdbf0e8b6..5328d0920b1c 100644
--- a/arch/s390/kernel/wti.c
+++ b/arch/s390/kernel/wti.c
@@ -165,7 +165,7 @@ static struct smp_hotplug_thread wti_threads = {
 static int __init wti_init(void)
 {
 	struct sched_param wti_sched_param = { .sched_priority = MAX_RT_PRIO - 1 };
-	struct dentry *wti_dir;
+	struct debugfs_node *wti_dir;
 	struct wti_state *st;
 	int cpu, rc;
 
diff --git a/arch/s390/pci/pci_debug.c b/arch/s390/pci/pci_debug.c
index 38014206c16b..efb15dc80a63 100644
--- a/arch/s390/pci/pci_debug.c
+++ b/arch/s390/pci/pci_debug.c
@@ -18,7 +18,7 @@
 
 #include <asm/pci_dma.h>
 
-static struct dentry *debugfs_root;
+static struct debugfs_node *debugfs_root;
 debug_info_t *pci_debug_msg_id;
 EXPORT_SYMBOL_GPL(pci_debug_msg_id);
 debug_info_t *pci_debug_err_id;
diff --git a/arch/sh/kernel/kdebugfs.c b/arch/sh/kernel/kdebugfs.c
index 8b505e1556a5..79b8b5aa9757 100644
--- a/arch/sh/kernel/kdebugfs.c
+++ b/arch/sh/kernel/kdebugfs.c
@@ -3,7 +3,7 @@
 #include <linux/init.h>
 #include <linux/debugfs.h>
 
-struct dentry *arch_debugfs_dir;
+struct debugfs_node *arch_debugfs_dir;
 EXPORT_SYMBOL(arch_debugfs_dir);
 
 static int __init arch_kdebugfs_init(void)
diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index 8418a892d195..07bb994e953e 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -380,7 +380,7 @@ static const struct file_operations dfs_ops = {
 
 static int __init callthunks_debugfs_init(void)
 {
-	struct dentry *dir;
+	struct debugfs_node *dir;
 	unsigned long cpu;
 
 	dir = debugfs_create_dir("callthunks", NULL);
diff --git a/arch/x86/kernel/cpu/debugfs.c b/arch/x86/kernel/cpu/debugfs.c
index cacfd3f6abef..4d49a973466c 100644
--- a/arch/x86/kernel/cpu/debugfs.c
+++ b/arch/x86/kernel/cpu/debugfs.c
@@ -85,7 +85,7 @@ static const struct file_operations dfs_dom_ops = {
 
 static __init int cpu_init_debugfs(void)
 {
-	struct dentry *dir, *base = debugfs_create_dir("topo", arch_debugfs_dir);
+	struct debugfs_node *dir, *base = debugfs_create_dir("topo", arch_debugfs_dir);
 	unsigned long id;
 	char name[24];
 
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 0dc00c9894c7..565b288772da 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2921,9 +2921,9 @@ static int __init mcheck_disable(char *str)
 __setup("nomce", mcheck_disable);
 
 #ifdef CONFIG_DEBUG_FS
-struct dentry *mce_get_debugfs_dir(void)
+struct debugfs_node *mce_get_debugfs_dir(void)
 {
-	static struct dentry *dmce;
+	static struct debugfs_node *dmce;
 
 	if (!dmce)
 		dmce = debugfs_create_dir("mce", NULL);
@@ -2958,7 +2958,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(fake_panic_fops, fake_panic_get, fake_panic_set,
 
 static void __init mcheck_debugfs_init(void)
 {
-	struct dentry *dmce;
+	struct debugfs_node *dmce;
 
 	dmce = mce_get_debugfs_dir();
 	debugfs_create_file_unsafe("fake_panic", 0444, dmce, NULL,
diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 313fe682db33..fdcc73f7fd60 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -39,7 +39,7 @@ static bool hw_injection_possible = true;
  * Collect all the MCi_XXX settings
  */
 static struct mce i_mce;
-static struct dentry *dfs_inj;
+static struct debugfs_node *dfs_inj;
 
 #define MAX_FLAG_OPT_SIZE	4
 #define NBCFG			0x44
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 95a504ece43e..c9f53490a812 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -36,7 +36,7 @@ bool mce_gen_pool_init(void);
 struct llist_node *mce_gen_pool_prepare_records(void);
 
 int mce_severity(struct mce *a, struct pt_regs *regs, char **msg, bool is_excp);
-struct dentry *mce_get_debugfs_dir(void);
+struct debugfs_node *mce_get_debugfs_dir(void);
 
 extern mce_banks_t mce_banks_ce_disabled;
 
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index dac4d64dfb2a..23f263628c8a 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -478,7 +478,7 @@ static const struct file_operations severities_coverage_fops = {
 
 static int __init severities_debugfs_init(void)
 {
-	struct dentry *dmce;
+	struct debugfs_node *dmce;
 
 	dmce = mce_get_debugfs_dir();
 
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 20c898f09b7e..9278a1e0f92f 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -266,7 +266,7 @@ struct pseudo_lock_region {
 	unsigned int		size;
 	void			*kmem;
 	unsigned int		minor;
-	struct dentry		*debugfs_dir;
+	struct debugfs_node *debugfs_dir;
 	struct list_head	pm_reqs;
 };
 
@@ -509,7 +509,7 @@ extern struct mutex rdtgroup_mutex;
 
 extern struct rdt_hw_resource rdt_resources_all[];
 extern struct rdtgroup rdtgroup_default;
-extern struct dentry *debugfs_resctrl;
+extern struct debugfs_node *debugfs_resctrl;
 extern enum resctrl_event_id mba_mbps_default_event;
 
 enum resctrl_res_level {
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 6419e04d8a7b..b8906d2e058b 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -63,7 +63,7 @@ static char last_cmd_status_buf[512];
 static int rdtgroup_setup_root(struct rdt_fs_context *ctx);
 static void rdtgroup_destroy_root(void);
 
-struct dentry *debugfs_resctrl;
+struct debugfs_node *debugfs_resctrl;
 
 /*
  * Memory bandwidth monitoring event to use for the default CTRL_MON group
diff --git a/arch/x86/kernel/itmt.c b/arch/x86/kernel/itmt.c
index 9cea1fc36c18..f764fa175608 100644
--- a/arch/x86/kernel/itmt.c
+++ b/arch/x86/kernel/itmt.c
@@ -66,7 +66,7 @@ static const struct file_operations dfs_sched_itmt_fops = {
 	.llseek =       default_llseek,
 };
 
-static struct dentry *dfs_sched_itmt;
+static struct debugfs_node *dfs_sched_itmt;
 
 /**
  * sched_set_itmt_support() - Indicate platform supports ITMT
diff --git a/arch/x86/kernel/kdebugfs.c b/arch/x86/kernel/kdebugfs.c
index e2e89bebcbc3..66b3670aca36 100644
--- a/arch/x86/kernel/kdebugfs.c
+++ b/arch/x86/kernel/kdebugfs.c
@@ -16,7 +16,7 @@
 
 #include <asm/setup.h>
 
-struct dentry *arch_debugfs_dir;
+struct debugfs_node *arch_debugfs_dir;
 EXPORT_SYMBOL(arch_debugfs_dir);
 
 #ifdef CONFIG_DEBUG_BOOT_PARAMS
@@ -73,10 +73,10 @@ static const struct file_operations fops_setup_data = {
 };
 
 static void __init
-create_setup_data_node(struct dentry *parent, int no,
+create_setup_data_node(struct debugfs_node *parent, int no,
 		       struct setup_data_node *node)
 {
-	struct dentry *d;
+	struct debugfs_node *d;
 	char buf[16];
 
 	sprintf(buf, "%d", no);
@@ -86,13 +86,13 @@ create_setup_data_node(struct dentry *parent, int no,
 	debugfs_create_file("data", S_IRUGO, d, node, &fops_setup_data);
 }
 
-static int __init create_setup_data_nodes(struct dentry *parent)
+static int __init create_setup_data_nodes(struct debugfs_node *parent)
 {
 	struct setup_indirect *indirect;
 	struct setup_data_node *node;
 	struct setup_data *data;
 	u64 pa_data, pa_next;
-	struct dentry *d;
+	struct debugfs_node *d;
 	int error;
 	u32 len;
 	int no = 0;
@@ -164,7 +164,7 @@ static struct debugfs_blob_wrapper boot_params_blob = {
 
 static int __init boot_params_kdebugfs_init(void)
 {
-	struct dentry *dbp;
+	struct debugfs_node *dbp;
 	int error;
 
 	dbp = debugfs_create_dir("boot_params", arch_debugfs_dir);
diff --git a/arch/x86/kvm/debugfs.c b/arch/x86/kvm/debugfs.c
index 999227fc7c66..b7e36e7c4f08 100644
--- a/arch/x86/kvm/debugfs.c
+++ b/arch/x86/kvm/debugfs.c
@@ -56,7 +56,8 @@ static int vcpu_get_tsc_scaling_frac_bits(void *data, u64 *val)
 
 DEFINE_SIMPLE_ATTRIBUTE(vcpu_tsc_scaling_frac_fops, vcpu_get_tsc_scaling_frac_bits, NULL, "%llu\n");
 
-void kvm_arch_create_vcpu_debugfs(struct kvm_vcpu *vcpu, struct dentry *debugfs_dentry)
+void kvm_arch_create_vcpu_debugfs(struct kvm_vcpu *vcpu,
+				  struct debugfs_node *debugfs_dentry)
 {
 	debugfs_create_file("guest_mode", 0444, debugfs_dentry, vcpu,
 			    &vcpu_guest_mode_fops);
diff --git a/arch/x86/mm/debug_pagetables.c b/arch/x86/mm/debug_pagetables.c
index ae5c213a1cb0..0f797bda55f3 100644
--- a/arch/x86/mm/debug_pagetables.c
+++ b/arch/x86/mm/debug_pagetables.c
@@ -44,7 +44,7 @@ static int ptdump_efi_show(struct seq_file *m, void *v)
 DEFINE_SHOW_ATTRIBUTE(ptdump_efi);
 #endif
 
-static struct dentry *dir;
+static struct debugfs_node *dir;
 
 static int __init pt_dump_debug_init(void)
 {
diff --git a/arch/x86/platform/atom/punit_atom_debug.c b/arch/x86/platform/atom/punit_atom_debug.c
index 44c30ce6360a..6b44b5ee316f 100644
--- a/arch/x86/platform/atom/punit_atom_debug.c
+++ b/arch/x86/platform/atom/punit_atom_debug.c
@@ -105,7 +105,7 @@ static int punit_dev_state_show(struct seq_file *seq_file, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(punit_dev_state);
 
-static struct dentry *punit_dbg_file;
+static struct debugfs_node *punit_dbg_file;
 
 static void punit_dbgfs_register(struct punit_device *punit_device)
 {
diff --git a/arch/x86/platform/intel/iosf_mbi.c b/arch/x86/platform/intel/iosf_mbi.c
index c81cea208c2c..1d0468f19fa1 100644
--- a/arch/x86/platform/intel/iosf_mbi.c
+++ b/arch/x86/platform/intel/iosf_mbi.c
@@ -481,7 +481,7 @@ static int mcr_set(void *data, u64 val)
 }
 DEFINE_SIMPLE_ATTRIBUTE(iosf_mcr_fops, mcr_get, mcr_set , "%llx\n");
 
-static struct dentry *iosf_dbg;
+static struct debugfs_node *iosf_dbg;
 
 static void iosf_sideband_debug_init(void)
 {
diff --git a/arch/x86/xen/debugfs.c b/arch/x86/xen/debugfs.c
index b8c9f2a7d9b6..ff42385ab151 100644
--- a/arch/x86/xen/debugfs.c
+++ b/arch/x86/xen/debugfs.c
@@ -5,9 +5,9 @@
 
 #include "xen-ops.h"
 
-static struct dentry *d_xen_debug;
+static struct debugfs_node *d_xen_debug;
 
-struct dentry * __init xen_init_debugfs(void)
+struct debugfs_node * __init xen_init_debugfs(void)
 {
 	if (!d_xen_debug)
 		d_xen_debug = debugfs_create_dir("xen", NULL);
diff --git a/arch/x86/xen/p2m.c b/arch/x86/xen/p2m.c
index 56914e21e303..74204f2c94e8 100644
--- a/arch/x86/xen/p2m.c
+++ b/arch/x86/xen/p2m.c
@@ -915,11 +915,11 @@ static int p2m_dump_show(struct seq_file *m, void *v)
 
 DEFINE_SHOW_ATTRIBUTE(p2m_dump);
 
-static struct dentry *d_mmu_debug;
+static struct debugfs_node *d_mmu_debug;
 
 static int __init xen_p2m_debugfs(void)
 {
-	struct dentry *d_xen = xen_init_debugfs();
+	struct debugfs_node *d_xen = xen_init_debugfs();
 
 	d_mmu_debug = debugfs_create_dir("mmu", d_xen);
 
diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
index 63c13a2ccf55..393ea778be26 100644
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -185,7 +185,7 @@ static inline void xen_hvm_post_suspend(int suspend_cancelled) {}
 
 void xen_add_extra_mem(unsigned long start_pfn, unsigned long n_pfns);
 
-struct dentry * __init xen_init_debugfs(void);
+struct debugfs_node * __init xen_init_debugfs(void);
 
 enum pt_level {
 	PT_PGD,
diff --git a/block/blk-core.c b/block/blk-core.c
index d6c4fa3943b5..c91d56b49d0a 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -51,7 +51,7 @@
 #include "blk-throttle.h"
 #include "blk-ioprio.h"
 
-struct dentry *blk_debugfs_root;
+struct debugfs_node *blk_debugfs_root;
 
 EXPORT_TRACEPOINT_SYMBOL_GPL(block_bio_remap);
 EXPORT_TRACEPOINT_SYMBOL_GPL(block_rq_remap);
@@ -503,7 +503,7 @@ bool should_fail_request(struct block_device *part, unsigned int bytes)
 
 static int __init fail_make_request_debugfs(void)
 {
-	struct dentry *dir = fault_create_debugfs_attr("fail_make_request",
+	struct debugfs_node *dir = fault_create_debugfs_attr("fail_make_request",
 						NULL, &fail_make_request);
 
 	return PTR_ERR_OR_ZERO(dir);
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index adf5f0697b6b..26f82b9b191e 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -603,13 +603,13 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_ctx_attrs[] = {
 	{},
 };
 
-static void debugfs_create_files(struct dentry *parent, void *data,
+static void debugfs_create_files(struct debugfs_node *parent, void *data,
 				 const struct blk_mq_debugfs_attr *attr)
 {
 	if (IS_ERR_OR_NULL(parent))
 		return;
 
-	d_inode(parent)->i_private = data;
+	debugfs_node_inode(parent)->i_private = data;
 
 	for (; attr->name; attr++)
 		debugfs_create_file(attr->name, attr->mode, parent,
@@ -652,7 +652,7 @@ void blk_mq_debugfs_register(struct request_queue *q)
 static void blk_mq_debugfs_register_ctx(struct blk_mq_hw_ctx *hctx,
 					struct blk_mq_ctx *ctx)
 {
-	struct dentry *ctx_dir;
+	struct debugfs_node *ctx_dir;
 	char name[20];
 
 	snprintf(name, sizeof(name), "cpu%u", ctx->cpu);
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 37245c97ee61..83253bc9c5fc 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -30,7 +30,7 @@ struct rq_qos {
 	enum rq_qos_id id;
 	struct rq_qos *next;
 #ifdef CONFIG_BLK_DEBUG_FS
-	struct dentry *debugfs_dir;
+	struct debugfs_node *debugfs_dir;
 #endif
 };
 
diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index 1b8de0417fc1..44871fbabe27 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -28,7 +28,7 @@ EXPORT_SYMBOL_GPL(__blk_should_fake_timeout);
 
 static int __init fail_io_timeout_debugfs(void)
 {
-	struct dentry *dir = fault_create_debugfs_attr("fail_io_timeout",
+	struct debugfs_node *dir = fault_create_debugfs_attr("fail_io_timeout",
 						NULL, &fail_io_timeout);
 
 	return PTR_ERR_OR_ZERO(dir);
diff --git a/block/blk.h b/block/blk.h
index 90fa5f28ccab..7a18703f745e 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -18,7 +18,7 @@ struct elevator_type;
 /* Max future timer expiry for timeouts */
 #define BLK_MAX_TIMEOUT		(5 * HZ)
 
-extern struct dentry *blk_debugfs_root;
+extern struct debugfs_node *blk_debugfs_root;
 
 struct blk_flush_queue {
 	spinlock_t		mq_flush_lock;
diff --git a/crypto/jitterentropy-testing.c b/crypto/jitterentropy-testing.c
index 21c9d7c3269a..c54cfadfd1ad 100644
--- a/crypto/jitterentropy-testing.c
+++ b/crypto/jitterentropy-testing.c
@@ -23,7 +23,7 @@ struct jent_testing {
 	wait_queue_head_t read_wait;
 };
 
-static struct dentry *jent_raw_debugfs_root = NULL;
+static struct debugfs_node *jent_raw_debugfs_root = NULL;
 
 /*************************** Generic Data Handling ****************************/
 
diff --git a/drivers/accel/drm_accel.c b/drivers/accel/drm_accel.c
index aa826033b0ce..cdaec9c88228 100644
--- a/drivers/accel/drm_accel.c
+++ b/drivers/accel/drm_accel.c
@@ -20,7 +20,7 @@
 
 DEFINE_XARRAY_ALLOC(accel_minors_xa);
 
-static struct dentry *accel_debugfs_root;
+static struct debugfs_node *accel_debugfs_root;
 
 static const struct device_type accel_sysfs_device_minor = {
 	.name = "accel_minor"
diff --git a/drivers/accel/habanalabs/common/debugfs.c b/drivers/accel/habanalabs/common/debugfs.c
index ca7677293a55..c918fdcb00af 100644
--- a/drivers/accel/habanalabs/common/debugfs.c
+++ b/drivers/accel/habanalabs/common/debugfs.c
@@ -1555,7 +1555,8 @@ static const struct file_operations hl_debugfs_fops = {
 	.release = single_release,
 };
 
-static void add_secured_nodes(struct hl_dbg_device_entry *dev_entry, struct dentry *root)
+static void add_secured_nodes(struct hl_dbg_device_entry *dev_entry,
+			      struct debugfs_node *root)
 {
 	debugfs_create_u8("i2c_bus",
 				0644,
@@ -1603,7 +1604,7 @@ static void add_secured_nodes(struct hl_dbg_device_entry *dev_entry, struct dent
 }
 
 static void add_files_to_device(struct hl_device *hdev, struct hl_dbg_device_entry *dev_entry,
-				struct dentry *root)
+				struct debugfs_node *root)
 {
 	int count = ARRAY_SIZE(hl_debugfs_list);
 	struct hl_debugfs_entry *entry;
diff --git a/drivers/accel/ivpu/ivpu_debugfs.c b/drivers/accel/ivpu/ivpu_debugfs.c
index 8180b95ed69d..c2349354841f 100644
--- a/drivers/accel/ivpu/ivpu_debugfs.c
+++ b/drivers/accel/ivpu/ivpu_debugfs.c
@@ -399,7 +399,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(ivpu_dct_fops, dct_active_get, dct_active_set, "%llu\n"
 
 void ivpu_debugfs_init(struct ivpu_device *vdev)
 {
-	struct dentry *debugfs_root = vdev->drm.debugfs_root;
+	struct debugfs_node *debugfs_root = vdev->drm.debugfs_root;
 
 	drm_debugfs_add_files(&vdev->drm, vdev_debugfs_list, ARRAY_SIZE(vdev_debugfs_list));
 
diff --git a/drivers/accel/qaic/qaic_debugfs.c b/drivers/accel/qaic/qaic_debugfs.c
index ba0cf2f94732..6146d5dda970 100644
--- a/drivers/accel/qaic/qaic_debugfs.c
+++ b/drivers/accel/qaic/qaic_debugfs.c
@@ -98,8 +98,8 @@ DEFINE_SHOW_ATTRIBUTE(queued);
 void qaic_debugfs_init(struct qaic_drm_device *qddev)
 {
 	struct qaic_device *qdev = qddev->qdev;
-	struct dentry *debugfs_root;
-	struct dentry *debugfs_dir;
+	struct debugfs_node *debugfs_root;
+	struct debugfs_node *debugfs_dir;
 	char name[QAIC_DBC_DIR_NAME];
 	u32 i;
 
diff --git a/drivers/acpi/acpi_dbg.c b/drivers/acpi/acpi_dbg.c
index d50261d05f3a..8d39025cbf0c 100644
--- a/drivers/acpi/acpi_dbg.c
+++ b/drivers/acpi/acpi_dbg.c
@@ -62,7 +62,7 @@ struct acpi_aml_io {
 static struct acpi_aml_io acpi_aml_io;
 static bool acpi_aml_initialized;
 static struct file *acpi_aml_active_reader;
-static struct dentry *acpi_aml_dentry;
+static struct debugfs_node *acpi_aml_dentry;
 
 static inline bool __acpi_aml_running(void)
 {
diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index 9c84f3da7c09..ab96bb1c1b24 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -749,9 +749,9 @@ int apei_exec_collect_resources(struct apei_exec_context *ctx,
 }
 EXPORT_SYMBOL_GPL(apei_exec_collect_resources);
 
-struct dentry *apei_get_debugfs_dir(void)
+struct debugfs_node *apei_get_debugfs_dir(void)
 {
-	static struct dentry *dapei;
+	static struct debugfs_node *dapei;
 
 	if (!dapei)
 		dapei = debugfs_create_dir("apei", NULL);
diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/apei-internal.h
index cd2766c69d78..360bfab92ebb 100644
--- a/drivers/acpi/apei/apei-internal.h
+++ b/drivers/acpi/apei/apei-internal.h
@@ -118,7 +118,8 @@ int apei_exec_collect_resources(struct apei_exec_context *ctx,
 				struct apei_resources *resources);
 
 struct dentry;
-struct dentry *apei_get_debugfs_dir(void);
+#define debugfs_node dentry
+struct debugfs_node *apei_get_debugfs_dir(void);
 
 static inline u32 cper_estatus_len(struct acpi_hest_generic_status *estatus)
 {
diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index 04731a5b01fa..5e977fc19ce6 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -629,7 +629,7 @@ static u64 error_param1;
 static u64 error_param2;
 static u64 error_param3;
 static u64 error_param4;
-static struct dentry *einj_debug_dir;
+static struct debugfs_node *einj_debug_dir;
 static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
 	{ BIT(0), "Processor Correctable" },
 	{ BIT(1), "Processor Uncorrectable non-fatal" },
diff --git a/drivers/acpi/debugfs.c b/drivers/acpi/debugfs.c
index 074eb98d213e..669a1876787b 100644
--- a/drivers/acpi/debugfs.c
+++ b/drivers/acpi/debugfs.c
@@ -10,7 +10,7 @@
 
 #include "internal.h"
 
-struct dentry *acpi_debugfs_dir;
+struct debugfs_node *acpi_debugfs_dir;
 EXPORT_SYMBOL_GPL(acpi_debugfs_dir);
 
 void __init acpi_debugfs_init(void)
diff --git a/drivers/acpi/ec_sys.c b/drivers/acpi/ec_sys.c
index c074a0fae059..3963116ba817 100644
--- a/drivers/acpi/ec_sys.c
+++ b/drivers/acpi/ec_sys.c
@@ -25,7 +25,7 @@ MODULE_PARM_DESC(write_support, "Dangerous, reboot and removal of battery may "
 
 #define EC_SPACE_SIZE 256
 
-static struct dentry *acpi_ec_debugfs_dir;
+static struct debugfs_node *acpi_ec_debugfs_dir;
 
 static ssize_t acpi_ec_read_io(struct file *f, char __user *buf,
 			       size_t count, loff_t *off)
@@ -109,7 +109,7 @@ static const struct file_operations acpi_ec_io_ops = {
 
 static void acpi_ec_add_debugfs(struct acpi_ec *ec, unsigned int ec_device_count)
 {
-	struct dentry *dev_dir;
+	struct debugfs_node *dev_dir;
 	char name[64];
 	umode_t mode = 0400;
 
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 00910ccd7eda..2948a777b77f 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -64,7 +64,7 @@ int acpi_scan_add_handler_with_hotplug(struct acpi_scan_handler *handler,
 void acpi_scan_hotplug_enabled(struct acpi_hotplug_profile *hotplug, bool val);
 
 #ifdef CONFIG_DEBUG_FS
-extern struct dentry *acpi_debugfs_dir;
+extern struct debugfs_node *acpi_debugfs_dir;
 void acpi_debugfs_init(void);
 #else
 static inline void acpi_debugfs_init(void) { return; }
diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 76052006bd87..24766f6e18b0 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -85,8 +85,8 @@ static DEFINE_MUTEX(binder_procs_lock);
 static HLIST_HEAD(binder_dead_nodes);
 static DEFINE_SPINLOCK(binder_dead_nodes_lock);
 
-static struct dentry *binder_debugfs_dir_entry_root;
-static struct dentry *binder_debugfs_dir_entry_proc;
+static struct debugfs_node *binder_debugfs_dir_entry_root;
+static struct debugfs_node *binder_debugfs_dir_entry_proc;
 static atomic_t binder_last_id;
 
 static int proc_show(struct seq_file *m, void *unused);
diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
index e4eb8357989c..13a7e29a9c76 100644
--- a/drivers/android/binder_internal.h
+++ b/drivers/android/binder_internal.h
@@ -445,7 +445,7 @@ struct binder_proc {
 	int requested_threads_started;
 	int tmp_ref;
 	long default_priority;
-	struct dentry *debugfs_entry;
+	struct debugfs_node *debugfs_entry;
 	struct binder_alloc alloc;
 	struct binder_context *context;
 	spinlock_t inner_lock;
diff --git a/drivers/base/component.c b/drivers/base/component.c
index 741497324d78..70b8fba945b6 100644
--- a/drivers/base/component.c
+++ b/drivers/base/component.c
@@ -78,7 +78,7 @@ static LIST_HEAD(aggregate_devices);
 
 #ifdef CONFIG_DEBUG_FS
 
-static struct dentry *component_debugfs_dir;
+static struct debugfs_node *component_debugfs_dir;
 
 static int component_devices_show(struct seq_file *s, void *data)
 {
diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index bdb450436cbc..f92554085841 100644
--- a/drivers/base/regmap/internal.h
+++ b/drivers/base/regmap/internal.h
@@ -82,7 +82,7 @@ struct regmap {
 
 #ifdef CONFIG_DEBUG_FS
 	bool debugfs_disable;
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 	const char *debugfs_name;
 
 	unsigned int debugfs_reg_len;
diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index fb84cda92a75..44d2aa7689d2 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -21,7 +21,7 @@ struct regmap_debugfs_node {
 };
 
 static unsigned int dummy_index;
-static struct dentry *regmap_debugfs_root;
+static struct debugfs_node *regmap_debugfs_root;
 static LIST_HEAD(regmap_debugfs_early_list);
 static DEFINE_MUTEX(regmap_debugfs_early_lock);
 
diff --git a/drivers/block/aoe/aoe.h b/drivers/block/aoe/aoe.h
index 749ae1246f4c..76d25a1be10e 100644
--- a/drivers/block/aoe/aoe.h
+++ b/drivers/block/aoe/aoe.h
@@ -168,7 +168,7 @@ struct aoedev {
 	ulong ref;
 	struct work_struct work;/* disk create work struct */
 	struct gendisk *gd;
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 	struct request_queue *blkq;
 	struct list_head rq_list;
 	struct blk_mq_tag_set tag_set;
diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index 00b74a845328..9d476da2f18e 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -22,7 +22,7 @@
 
 static DEFINE_MUTEX(aoeblk_mutex);
 static struct kmem_cache *buf_pool_cache;
-static struct dentry *aoe_debugfs_dir;
+static struct debugfs_node *aoe_debugfs_dir;
 
 /* random default picked from the historic block max_sectors cap */
 static int aoe_maxsectors = 2560;
diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 292f127cae0a..1e18319d25d1 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -319,7 +319,7 @@ __setup("ramdisk_size=", ramdisk_size);
  */
 static LIST_HEAD(brd_devices);
 static DEFINE_MUTEX(brd_devices_mutex);
-static struct dentry *brd_debugfs_dir;
+static struct debugfs_node *brd_debugfs_dir;
 
 static struct brd_device *brd_find_or_alloc_device(int i)
 {
diff --git a/drivers/block/drbd/drbd_debugfs.c b/drivers/block/drbd/drbd_debugfs.c
index 12460b584bcb..2a52a47b6a9e 100644
--- a/drivers/block/drbd/drbd_debugfs.c
+++ b/drivers/block/drbd/drbd_debugfs.c
@@ -17,10 +17,10 @@
  * Whenever you change the file format, remember to bump the version. *
  **********************************************************************/
 
-static struct dentry *drbd_debugfs_root;
-static struct dentry *drbd_debugfs_version;
-static struct dentry *drbd_debugfs_resources;
-static struct dentry *drbd_debugfs_minors;
+static struct debugfs_node *drbd_debugfs_root;
+static struct debugfs_node *drbd_debugfs_version;
+static struct debugfs_node *drbd_debugfs_resources;
+static struct debugfs_node *drbd_debugfs_minors;
 
 static void seq_print_age_or_dash(struct seq_file *m, bool valid, unsigned long dt)
 {
@@ -464,7 +464,7 @@ static const struct file_operations in_flight_summary_fops = {
 
 void drbd_debugfs_resource_add(struct drbd_resource *resource)
 {
-	struct dentry *dentry;
+	struct debugfs_node *dentry;
 
 	dentry = debugfs_create_dir(resource->name, drbd_debugfs_resources);
 	resource->debugfs_res = dentry;
@@ -619,8 +619,8 @@ static const struct file_operations connection_oldest_requests_fops = {
 
 void drbd_debugfs_connection_add(struct drbd_connection *connection)
 {
-	struct dentry *conns_dir = connection->resource->debugfs_res_connections;
-	struct dentry *dentry;
+	struct debugfs_node *conns_dir = connection->resource->debugfs_res_connections;
+	struct debugfs_node *dentry;
 
 	/* Once we enable mutliple peers,
 	 * these connections will have descriptive names.
@@ -770,12 +770,12 @@ drbd_debugfs_device_attr(ed_gen_id)
 
 void drbd_debugfs_device_add(struct drbd_device *device)
 {
-	struct dentry *vols_dir = device->resource->debugfs_res_volumes;
+	struct debugfs_node *vols_dir = device->resource->debugfs_res_volumes;
 	char minor_buf[8]; /* MINORMASK, MINORBITS == 20; */
 	char vnr_buf[8];   /* volume number vnr is even 16 bit only; */
 	char *slink_name = NULL;
 
-	struct dentry *dentry;
+	struct debugfs_node *dentry;
 	if (!vols_dir || !drbd_debugfs_minors)
 		return;
 
@@ -826,8 +826,8 @@ void drbd_debugfs_device_cleanup(struct drbd_device *device)
 
 void drbd_debugfs_peer_device_add(struct drbd_peer_device *peer_device)
 {
-	struct dentry *conn_dir = peer_device->connection->debugfs_conn;
-	struct dentry *dentry;
+	struct debugfs_node *conn_dir = peer_device->connection->debugfs_conn;
+	struct debugfs_node *dentry;
 	char vnr_buf[8];
 
 	snprintf(vnr_buf, sizeof(vnr_buf), "%u", peer_device->device->vnr);
@@ -875,7 +875,7 @@ void drbd_debugfs_cleanup(void)
 
 void __init drbd_debugfs_init(void)
 {
-	struct dentry *dentry;
+	struct debugfs_node *dentry;
 
 	dentry = debugfs_create_dir("drbd", NULL);
 	drbd_debugfs_root = dentry;
diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index e21492981f7d..3b0a50056106 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -580,10 +580,10 @@ enum which_state { NOW, OLD = NOW, NEW };
 struct drbd_resource {
 	char *name;
 #ifdef CONFIG_DEBUG_FS
-	struct dentry *debugfs_res;
-	struct dentry *debugfs_res_volumes;
-	struct dentry *debugfs_res_connections;
-	struct dentry *debugfs_res_in_flight_summary;
+	struct debugfs_node *debugfs_res;
+	struct debugfs_node *debugfs_res_volumes;
+	struct debugfs_node *debugfs_res_connections;
+	struct debugfs_node *debugfs_res_in_flight_summary;
 #endif
 	struct kref kref;
 	struct idr devices;		/* volume number to device mapping */
@@ -616,9 +616,9 @@ struct drbd_connection {
 	struct list_head connections;
 	struct drbd_resource *resource;
 #ifdef CONFIG_DEBUG_FS
-	struct dentry *debugfs_conn;
-	struct dentry *debugfs_conn_callback_history;
-	struct dentry *debugfs_conn_oldest_requests;
+	struct debugfs_node *debugfs_conn;
+	struct debugfs_node *debugfs_conn_callback_history;
+	struct debugfs_node *debugfs_conn_oldest_requests;
 #endif
 	struct kref kref;
 	struct idr peer_devices;	/* volume number to peer device mapping */
@@ -736,7 +736,7 @@ struct drbd_peer_device {
 	struct drbd_connection *connection;
 	struct work_struct send_acks_work;
 #ifdef CONFIG_DEBUG_FS
-	struct dentry *debugfs_peer_dev;
+	struct debugfs_node *debugfs_peer_dev;
 #endif
 };
 
@@ -747,13 +747,13 @@ struct drbd_device {
 
 	unsigned long flush_jif;
 #ifdef CONFIG_DEBUG_FS
-	struct dentry *debugfs_minor;
-	struct dentry *debugfs_vol;
-	struct dentry *debugfs_vol_oldest_requests;
-	struct dentry *debugfs_vol_act_log_extents;
-	struct dentry *debugfs_vol_resync_extents;
-	struct dentry *debugfs_vol_data_gen_id;
-	struct dentry *debugfs_vol_ed_gen_id;
+	struct debugfs_node *debugfs_minor;
+	struct debugfs_node *debugfs_vol;
+	struct debugfs_node *debugfs_vol_oldest_requests;
+	struct debugfs_node *debugfs_vol_act_log_extents;
+	struct debugfs_node *debugfs_vol_resync_extents;
+	struct debugfs_node *debugfs_vol_data_gen_id;
+	struct debugfs_node *debugfs_vol_ed_gen_id;
 #endif
 
 	unsigned int vnr;	/* volume number within the connection */
diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 95361099a2dc..ac98e34b8aa2 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -99,7 +99,7 @@ static int instance;
  * allocated in mtip_init().
  */
 static int mtip_major;
-static struct dentry *dfs_parent;
+static struct debugfs_node *dfs_parent;
 
 static u32 cpu_use[NR_CPUS];
 
diff --git a/drivers/block/mtip32xx/mtip32xx.h b/drivers/block/mtip32xx/mtip32xx.h
index f7328f19ac5c..d0df015925fe 100644
--- a/drivers/block/mtip32xx/mtip32xx.h
+++ b/drivers/block/mtip32xx/mtip32xx.h
@@ -445,7 +445,7 @@ struct driver_data {
 
 	struct task_struct *mtip_svc_handler; /* task_struct of svc thd */
 
-	struct dentry *dfs_node;
+	struct debugfs_node *dfs_node;
 
 	bool sr;
 
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 7bdc7eb808ea..a41d5dc1599c 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -104,7 +104,7 @@ struct nbd_config {
 	unsigned int blksize_bits;
 	loff_t bytesize;
 #if IS_ENABLED(CONFIG_DEBUG_FS)
-	struct dentry *dbg_dir;
+	struct debugfs_node *dbg_dir;
 #endif
 };
 
@@ -157,7 +157,7 @@ struct nbd_cmd {
 };
 
 #if IS_ENABLED(CONFIG_DEBUG_FS)
-static struct dentry *nbd_dbg_dir;
+static struct debugfs_node *nbd_dbg_dir;
 #endif
 
 #define nbd_name(nbd) ((nbd)->disk->disk_name)
@@ -1798,7 +1798,7 @@ DEFINE_SHOW_ATTRIBUTE(nbd_dbg_flags);
 
 static int nbd_dev_dbg_init(struct nbd_device *nbd)
 {
-	struct dentry *dir;
+	struct debugfs_node *dir;
 	struct nbd_config *config = nbd->config;
 
 	if (!nbd_dbg_dir)
@@ -1828,7 +1828,7 @@ static void nbd_dev_dbg_close(struct nbd_device *nbd)
 
 static int nbd_dbg_init(void)
 {
-	struct dentry *dbg_dir;
+	struct debugfs_node *dbg_dir;
 
 	dbg_dir = debugfs_create_dir("nbd", NULL);
 	if (IS_ERR(dbg_dir))
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 65b96c083b3c..04adbf47f666 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -89,7 +89,7 @@ static struct bio_set pkt_bio_set;
 
 /* /sys/class/pktcdvd */
 static struct class	class_pktcdvd;
-static struct dentry	*pkt_debugfs_root = NULL; /* /sys/kernel/debug/pktcdvd */
+static struct debugfs_node	*pkt_debugfs_root = NULL; /* /sys/kernel/debug/pktcdvd */
 
 /* forward declaration */
 static int pkt_setup_dev(dev_t dev, dev_t* pkt_dev);
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 9f5020b077c5..83960becbd64 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -966,7 +966,7 @@ static void free_block_bdev(struct zram *zram, unsigned long blk_idx) {};
 
 #ifdef CONFIG_ZRAM_MEMORY_TRACKING
 
-static struct dentry *zram_debugfs_root;
+static struct debugfs_node *zram_debugfs_root;
 
 static void zram_debugfs_create(void)
 {
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index db78d7c01b9a..bea2d6f2ac8e 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -134,7 +134,7 @@ struct zram {
 	unsigned long nr_pages;
 #endif
 #ifdef CONFIG_ZRAM_MEMORY_TRACKING
-	struct dentry *debugfs_dir;
+	struct debugfs_node *debugfs_dir;
 #endif
 	atomic_t pp_in_progress;
 };
diff --git a/drivers/bluetooth/btmrvl_debugfs.c b/drivers/bluetooth/btmrvl_debugfs.c
index 32329a2e526f..83f37c3de8a4 100644
--- a/drivers/bluetooth/btmrvl_debugfs.c
+++ b/drivers/bluetooth/btmrvl_debugfs.c
@@ -14,8 +14,8 @@
 #include "btmrvl_drv.h"
 
 struct btmrvl_debugfs_data {
-	struct dentry *config_dir;
-	struct dentry *status_dir;
+	struct debugfs_node *config_dir;
+	struct debugfs_node *status_dir;
 };
 
 static ssize_t btmrvl_hscfgcmd_write(struct file *file,
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 0ac2168f1dc4..8f5398155442 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -655,7 +655,7 @@ static void qca_debugfs_init(struct hci_dev *hdev)
 {
 	struct hci_uart *hu = hci_get_drvdata(hdev);
 	struct qca_data *qca = hu->priv;
-	struct dentry *ibs_dir;
+	struct debugfs_node *ibs_dir;
 	umode_t mode;
 
 	if (!hdev->debugfs)
diff --git a/drivers/bus/mhi/host/debugfs.c b/drivers/bus/mhi/host/debugfs.c
index cfec7811dfbb..2b8b2bd18642 100644
--- a/drivers/bus/mhi/host/debugfs.c
+++ b/drivers/bus/mhi/host/debugfs.c
@@ -372,7 +372,7 @@ static const struct file_operations debugfs_timeout_ms_fops = {
 	.read = seq_read,
 };
 
-static struct dentry *mhi_debugfs_root;
+static struct debugfs_node *mhi_debugfs_root;
 
 void mhi_create_debugfs(struct mhi_controller *mhi_cntrl)
 {
diff --git a/drivers/bus/moxtet.c b/drivers/bus/moxtet.c
index 1e57ebfb7622..7930689c247b 100644
--- a/drivers/bus/moxtet.c
+++ b/drivers/bus/moxtet.c
@@ -552,7 +552,7 @@ static const struct file_operations output_fops = {
 
 static int moxtet_register_debugfs(struct moxtet *moxtet)
 {
-	struct dentry *root, *entry;
+	struct debugfs_node *root, *entry;
 
 	root = debugfs_create_dir("moxtet", NULL);
 
diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index 00cb792bda18..0f709940b98b 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -134,9 +134,9 @@ struct mvebu_mbus_state {
 	void __iomem *sdramwins_base;
 	void __iomem *mbusbridge_base;
 	phys_addr_t sdramwins_phys_base;
-	struct dentry *debugfs_root;
-	struct dentry *debugfs_sdram;
-	struct dentry *debugfs_devs;
+	struct debugfs_node *debugfs_root;
+	struct debugfs_node *debugfs_sdram;
+	struct debugfs_node *debugfs_devs;
 	struct resource pcie_mem_aperture;
 	struct resource pcie_io_aperture;
 	const struct mvebu_mbus_soc_data *soc;
diff --git a/drivers/cache/sifive_ccache.c b/drivers/cache/sifive_ccache.c
index 6874b72ec59d..0c51c71decab 100644
--- a/drivers/cache/sifive_ccache.c
+++ b/drivers/cache/sifive_ccache.c
@@ -71,7 +71,7 @@ enum {
 };
 
 #ifdef CONFIG_DEBUG_FS
-static struct dentry *sifive_test;
+static struct debugfs_node *sifive_test;
 
 static ssize_t ccache_write(struct file *file, const char __user *data,
 			    size_t count, loff_t *ppos)
diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index c573ed2ee71a..0842075a61f8 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -80,7 +80,7 @@ static DEFINE_IDA(cdx_controller_ida);
 /* Lock to protect controller ops */
 static DEFINE_MUTEX(cdx_controller_lock);
 /* Debugfs dir for cdx bus */
-static struct dentry *cdx_debugfs_dir;
+static struct debugfs_node *cdx_debugfs_dir;
 
 static char *compat_node_name = "xlnx,versal-net-cdx";
 
diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 24442485e73e..00c5456ea17c 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -41,7 +41,7 @@
  */
 struct ports_driver_data {
 	/* Used for exporting per-port information to debugfs */
-	struct dentry *debugfs_dir;
+	struct debugfs_node *debugfs_dir;
 
 	/* List of all the devices we're handling */
 	struct list_head portdevs;
@@ -187,7 +187,7 @@ struct port {
 	struct virtqueue *in_vq, *out_vq;
 
 	/* File in the debugfs directory that exposes this port's information */
-	struct dentry *debugfs_file;
+	struct debugfs_node *debugfs_file;
 
 	/*
 	 * Keep count of the bytes sent, received and discarded for
diff --git a/drivers/clk/baikal-t1/ccu-div.c b/drivers/clk/baikal-t1/ccu-div.c
index 8d5fc7158f33..23651828bbaa 100644
--- a/drivers/clk/baikal-t1/ccu-div.c
+++ b/drivers/clk/baikal-t1/ccu-div.c
@@ -432,7 +432,8 @@ static int ccu_div_dbgfs_fixed_clkdiv_get(void *priv, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(ccu_div_dbgfs_fixed_clkdiv_fops,
 	ccu_div_dbgfs_fixed_clkdiv_get, NULL, "%llu\n");
 
-static void ccu_div_var_debug_init(struct clk_hw *hw, struct dentry *dentry)
+static void ccu_div_var_debug_init(struct clk_hw *hw,
+				   struct debugfs_node *dentry)
 {
 	struct ccu_div *div = to_ccu_div(hw);
 	struct ccu_div_dbgfs_bit *bits;
@@ -479,7 +480,8 @@ static void ccu_div_var_debug_init(struct clk_hw *hw, struct dentry *dentry)
 				   div, &ccu_div_dbgfs_var_clkdiv_fops);
 }
 
-static void ccu_div_gate_debug_init(struct clk_hw *hw, struct dentry *dentry)
+static void ccu_div_gate_debug_init(struct clk_hw *hw,
+				    struct debugfs_node *dentry)
 {
 	struct ccu_div *div = to_ccu_div(hw);
 	struct ccu_div_dbgfs_bit *bit;
@@ -497,7 +499,8 @@ static void ccu_div_gate_debug_init(struct clk_hw *hw, struct dentry *dentry)
 				   &ccu_div_dbgfs_fixed_clkdiv_fops);
 }
 
-static void ccu_div_buf_debug_init(struct clk_hw *hw, struct dentry *dentry)
+static void ccu_div_buf_debug_init(struct clk_hw *hw,
+				   struct debugfs_node *dentry)
 {
 	struct ccu_div *div = to_ccu_div(hw);
 	struct ccu_div_dbgfs_bit *bit;
@@ -512,7 +515,8 @@ static void ccu_div_buf_debug_init(struct clk_hw *hw, struct dentry *dentry)
 				   &ccu_div_dbgfs_bit_fops);
 }
 
-static void ccu_div_fixed_debug_init(struct clk_hw *hw, struct dentry *dentry)
+static void ccu_div_fixed_debug_init(struct clk_hw *hw,
+				     struct debugfs_node *dentry)
 {
 	struct ccu_div *div = to_ccu_div(hw);
 
diff --git a/drivers/clk/baikal-t1/ccu-pll.c b/drivers/clk/baikal-t1/ccu-pll.c
index 13ef28001439..f691252bcc5a 100644
--- a/drivers/clk/baikal-t1/ccu-pll.c
+++ b/drivers/clk/baikal-t1/ccu-pll.c
@@ -436,7 +436,7 @@ static int ccu_pll_dbgfs_fld_get(void *priv, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(ccu_pll_dbgfs_fld_fops,
 	ccu_pll_dbgfs_fld_get, ccu_pll_dbgfs_fld_set, "%llu\n");
 
-static void ccu_pll_debug_init(struct clk_hw *hw, struct dentry *dentry)
+static void ccu_pll_debug_init(struct clk_hw *hw, struct debugfs_node *dentry)
 {
 	struct ccu_pll *pll = to_ccu_pll(hw);
 	struct ccu_pll_dbgfs_bit *bits;
diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index fb04734afc80..8e93b6174af1 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -399,7 +399,7 @@ static unsigned long bcm2835_measure_tcnt_mux(struct bcm2835_cprman *cprman,
 
 static void bcm2835_debugfs_regset(struct bcm2835_cprman *cprman, u32 base,
 				   const struct debugfs_reg32 *regs,
-				   size_t nregs, struct dentry *dentry)
+				   size_t nregs, struct debugfs_node *dentry)
 {
 	struct debugfs_regset32 *regset;
 
@@ -748,7 +748,7 @@ static int bcm2835_pll_set_rate(struct clk_hw *hw,
 }
 
 static void bcm2835_pll_debug_init(struct clk_hw *hw,
-				  struct dentry *dentry)
+				  struct debugfs_node *dentry)
 {
 	struct bcm2835_pll *pll = container_of(hw, struct bcm2835_pll, hw);
 	struct bcm2835_cprman *cprman = pll->cprman;
@@ -878,7 +878,7 @@ static int bcm2835_pll_divider_set_rate(struct clk_hw *hw,
 }
 
 static void bcm2835_pll_divider_debug_init(struct clk_hw *hw,
-					   struct dentry *dentry)
+					   struct debugfs_node *dentry)
 {
 	struct bcm2835_pll_divider *divider = bcm2835_pll_divider_from_hw(hw);
 	struct bcm2835_cprman *cprman = divider->cprman;
@@ -1292,7 +1292,7 @@ static const struct debugfs_reg32 bcm2835_debugfs_clock_reg32[] = {
 };
 
 static void bcm2835_clock_debug_init(struct clk_hw *hw,
-				    struct dentry *dentry)
+				    struct debugfs_node *dentry)
 {
 	struct bcm2835_clock *clock = bcm2835_clock_from_hw(hw);
 	struct bcm2835_cprman *cprman = clock->cprman;
diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fractional-divider.c
index da057172cc90..8f74a78ffabe 100644
--- a/drivers/clk/clk-fractional-divider.c
+++ b/drivers/clk/clk-fractional-divider.c
@@ -241,7 +241,7 @@ static int clk_fd_denominator_get(void *hw, u64 *val)
 }
 DEFINE_DEBUGFS_ATTRIBUTE(clk_fd_denominator_fops, clk_fd_denominator_get, NULL, "%llu\n");
 
-static void clk_fd_debug_init(struct clk_hw *hw, struct dentry *dentry)
+static void clk_fd_debug_init(struct clk_hw *hw, struct debugfs_node *dentry)
 {
 	debugfs_create_file("numerator", 0444, dentry, hw, &clk_fd_numerator_fops);
 	debugfs_create_file("denominator", 0444, dentry, hw, &clk_fd_denominator_fops);
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index cf7720b9172f..eba7633e7eba 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -90,7 +90,7 @@ struct clk_core {
 	struct hlist_head	clks;
 	unsigned int		notifier_count;
 #ifdef CONFIG_DEBUG_FS
-	struct dentry		*dentry;
+	struct debugfs_node *dentry;
 	struct hlist_node	debug_node;
 #endif
 	struct kref		ref;
@@ -3278,7 +3278,7 @@ EXPORT_SYMBOL_GPL(clk_is_match);
 #ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
 
-static struct dentry *rootdir;
+static struct debugfs_node *rootdir;
 static int inited = 0;
 static DEFINE_MUTEX(clk_debug_lock);
 static HLIST_HEAD(clk_debug_list);
@@ -3705,9 +3705,10 @@ static int clk_max_rate_show(struct seq_file *s, void *data)
 }
 DEFINE_SHOW_ATTRIBUTE(clk_max_rate);
 
-static void clk_debug_create_one(struct clk_core *core, struct dentry *pdentry)
+static void clk_debug_create_one(struct clk_core *core,
+				 struct debugfs_node *pdentry)
 {
-	struct dentry *root;
+	struct debugfs_node *root;
 
 	if (!core || !pdentry)
 		return;
diff --git a/drivers/clk/davinci/pll.c b/drivers/clk/davinci/pll.c
index 82727b1fc67a..92ca8031e80f 100644
--- a/drivers/clk/davinci/pll.c
+++ b/drivers/clk/davinci/pll.c
@@ -944,7 +944,8 @@ static const struct debugfs_reg32 davinci_pll_regs[] = {
 	DEBUG_REG(PLLDIV9),
 };
 
-static void davinci_pll_debug_init(struct clk_hw *hw, struct dentry *dentry)
+static void davinci_pll_debug_init(struct clk_hw *hw,
+				   struct debugfs_node *dentry)
 {
 	struct davinci_pll_clk *pll = to_davinci_pll_clk(hw);
 	struct debugfs_regset32 *regset;
diff --git a/drivers/clk/starfive/clk-starfive-jh7110-pll.c b/drivers/clk/starfive/clk-starfive-jh7110-pll.c
index 56dc58a04f8a..3a239680f2e1 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-pll.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-pll.c
@@ -424,7 +424,8 @@ static const struct file_operations jh7110_pll_registers_ops = {
 	.llseek = seq_lseek
 };
 
-static void jh7110_pll_debug_init(struct clk_hw *hw, struct dentry *dentry)
+static void jh7110_pll_debug_init(struct clk_hw *hw,
+				  struct debugfs_node *dentry)
 {
 	struct jh7110_pll_data *pll = jh7110_pll_data_from(hw);
 
diff --git a/drivers/clk/starfive/clk-starfive-jh71x0.c b/drivers/clk/starfive/clk-starfive-jh71x0.c
index 80e9157347eb..15a9c20026de 100644
--- a/drivers/clk/starfive/clk-starfive-jh71x0.c
+++ b/drivers/clk/starfive/clk-starfive-jh71x0.c
@@ -199,7 +199,8 @@ static int jh71x0_clk_set_phase(struct clk_hw *hw, int degrees)
 }
 
 #ifdef CONFIG_DEBUG_FS
-static void jh71x0_clk_debug_init(struct clk_hw *hw, struct dentry *dentry)
+static void jh71x0_clk_debug_init(struct clk_hw *hw,
+				  struct debugfs_node *dentry)
 {
 	static const struct debugfs_reg32 jh71x0_clk_reg = {
 		.name = "CTRL",
diff --git a/drivers/clk/tegra/clk-dfll.c b/drivers/clk/tegra/clk-dfll.c
index 58fa5a59e0c7..41381e72255c 100644
--- a/drivers/clk/tegra/clk-dfll.c
+++ b/drivers/clk/tegra/clk-dfll.c
@@ -279,7 +279,7 @@ struct tegra_dfll {
 
 	enum dfll_ctrl_mode		mode;
 	enum dfll_tune_range		tune_range;
-	struct dentry			*debugfs_dir;
+	struct debugfs_node *debugfs_dir;
 	struct clk_hw			dfll_clk_hw;
 	const char			*output_clock_name;
 	struct dfll_rate_req		last_req;
@@ -1362,7 +1362,7 @@ DEFINE_SHOW_ATTRIBUTE(attr_registers);
 
 static void dfll_debug_init(struct tegra_dfll *td)
 {
-	struct dentry *root;
+	struct debugfs_node *root;
 
 	if (!td || (td->mode == DFLL_UNINITIALIZED))
 		return;
diff --git a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss.h b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss.h
index 6c5d4aa6453c..f230843c26f7 100644
--- a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss.h
+++ b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss.h
@@ -154,8 +154,8 @@ struct sun4i_ss_ctx {
 #ifdef CONFIG_CRYPTO_DEV_SUN4I_SS_PRNG
 	u32 seed[SS_SEED_LEN / BITS_PER_LONG];
 #endif
-	struct dentry *dbgfs_dir;
-	struct dentry *dbgfs_stats;
+	struct debugfs_node *dbgfs_dir;
+	struct debugfs_node *dbgfs_stats;
 };
 
 struct sun4i_ss_alg_template {
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
index ec1ffda9ea32..57e20ed25d2e 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
@@ -1064,8 +1064,8 @@ static int sun8i_ce_probe(struct platform_device *pdev)
 	pm_runtime_put_sync(ce->dev);
 
 	if (IS_ENABLED(CONFIG_CRYPTO_DEV_SUN8I_CE_DEBUG)) {
-		struct dentry *dbgfs_dir __maybe_unused;
-		struct dentry *dbgfs_stats __maybe_unused;
+		struct debugfs_node *dbgfs_dir __maybe_unused;
+		struct debugfs_node *dbgfs_stats __maybe_unused;
 
 		/* Ignore error of debugfs */
 		dbgfs_dir = debugfs_create_dir("sun8i-ce", NULL);
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
index 3b5c2af013d0..be8db044c349 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
@@ -230,8 +230,8 @@ struct sun8i_ce_dev {
 	atomic_t flow;
 	const struct ce_variant *variant;
 #ifdef CONFIG_CRYPTO_DEV_SUN8I_CE_DEBUG
-	struct dentry *dbgfs_dir;
-	struct dentry *dbgfs_stats;
+	struct debugfs_node *dbgfs_dir;
+	struct debugfs_node *dbgfs_stats;
 #endif
 #ifdef CONFIG_CRYPTO_DEV_SUN8I_CE_TRNG
 	struct hwrng trng;
diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
index f45685707e0d..4cecf3590384 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
@@ -878,8 +878,8 @@ static int sun8i_ss_probe(struct platform_device *pdev)
 	pm_runtime_put_sync(ss->dev);
 
 	if (IS_ENABLED(CONFIG_CRYPTO_DEV_SUN8I_SS_DEBUG)) {
-		struct dentry *dbgfs_dir __maybe_unused;
-		struct dentry *dbgfs_stats __maybe_unused;
+		struct debugfs_node *dbgfs_dir __maybe_unused;
+		struct debugfs_node *dbgfs_stats __maybe_unused;
 
 		/* Ignore error of debugfs */
 		dbgfs_dir = debugfs_create_dir("sun8i-ss", NULL);
diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
index ae66eb45fb24..f301d1b324e4 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
@@ -164,8 +164,8 @@ struct sun8i_ss_dev {
 	atomic_t flow;
 	const struct ss_variant *variant;
 #ifdef CONFIG_CRYPTO_DEV_SUN8I_SS_DEBUG
-	struct dentry *dbgfs_dir;
-	struct dentry *dbgfs_stats;
+	struct debugfs_node *dbgfs_dir;
+	struct debugfs_node *dbgfs_stats;
 #endif
 };
 
diff --git a/drivers/crypto/amlogic/amlogic-gxl-core.c b/drivers/crypto/amlogic/amlogic-gxl-core.c
index 1c18a5b8470e..ebca52e16226 100644
--- a/drivers/crypto/amlogic/amlogic-gxl-core.c
+++ b/drivers/crypto/amlogic/amlogic-gxl-core.c
@@ -278,7 +278,7 @@ static int meson_crypto_probe(struct platform_device *pdev)
 		goto error_alg;
 
 	if (IS_ENABLED(CONFIG_CRYPTO_DEV_AMLOGIC_GXL_DEBUG)) {
-		struct dentry *dbgfs_dir;
+		struct debugfs_node *dbgfs_dir;
 
 		dbgfs_dir = debugfs_create_dir("gxl-crypto", NULL);
 		debugfs_create_file("stats", 0444, dbgfs_dir, mc, &meson_debugfs_fops);
diff --git a/drivers/crypto/amlogic/amlogic-gxl.h b/drivers/crypto/amlogic/amlogic-gxl.h
index d68094ffb70a..98c968dab97b 100644
--- a/drivers/crypto/amlogic/amlogic-gxl.h
+++ b/drivers/crypto/amlogic/amlogic-gxl.h
@@ -97,7 +97,7 @@ struct meson_dev {
 	atomic_t flow;
 	int irqs[MAXFLOW];
 #ifdef CONFIG_CRYPTO_DEV_AMLOGIC_GXL_DEBUG
-	struct dentry *dbgfs_dir;
+	struct debugfs_node *dbgfs_dir;
 #endif
 };
 
diff --git a/drivers/crypto/axis/artpec6_crypto.c b/drivers/crypto/axis/artpec6_crypto.c
index 1c1f57baef0e..049427ed6432 100644
--- a/drivers/crypto/axis/artpec6_crypto.c
+++ b/drivers/crypto/axis/artpec6_crypto.c
@@ -2811,7 +2811,7 @@ static struct aead_alg aead_algos[] = {
 
 #ifdef CONFIG_DEBUG_FS
 
-static struct dentry *dbgfs_root;
+static struct debugfs_node *dbgfs_root;
 
 static void artpec6_crypto_init_debugfs(void)
 {
diff --git a/drivers/crypto/bcm/cipher.h b/drivers/crypto/bcm/cipher.h
index e36881c983cf..d12d4fcc6d97 100644
--- a/drivers/crypto/bcm/cipher.h
+++ b/drivers/crypto/bcm/cipher.h
@@ -431,8 +431,8 @@ struct bcm_device_private {
 	/* The index of the channel to use for the next crypto request */
 	atomic_t next_chan;
 
-	struct dentry *debugfs_dir;
-	struct dentry *debugfs_stats;
+	struct debugfs_node *debugfs_dir;
+	struct debugfs_node *debugfs_stats;
 
 	/* Number of request bytes processed and result bytes returned */
 	atomic64_t bytes_in;
diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index d4b39184dbdb..6fdf8d2d9078 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -865,7 +865,7 @@ static int caam_probe(struct platform_device *pdev)
 	struct caam_ctrl __iomem *ctrl;
 	struct caam_drv_private *ctrlpriv;
 	struct caam_perfmon __iomem *perfmon;
-	struct dentry *dfs_root;
+	struct debugfs_node *dfs_root;
 	u32 scfgr, comp_params;
 	int pg_size;
 	int BLOCK_OFFSET = 0;
diff --git a/drivers/crypto/caam/debugfs.c b/drivers/crypto/caam/debugfs.c
index 6358d3cabf57..702212ce4fbd 100644
--- a/drivers/crypto/caam/debugfs.c
+++ b/drivers/crypto/caam/debugfs.c
@@ -44,7 +44,7 @@ void caam_debugfs_qi_init(struct caam_drv_private *ctrlpriv)
 
 void caam_debugfs_init(struct caam_drv_private *ctrlpriv,
 		       struct caam_perfmon __force *perfmon,
-		       struct dentry *root)
+		       struct debugfs_node *root)
 {
 	/*
 	 * FIXME: needs better naming distinction, as some amalgamation of
diff --git a/drivers/crypto/caam/debugfs.h b/drivers/crypto/caam/debugfs.h
index 8b5d1acd21a7..b39d45b70903 100644
--- a/drivers/crypto/caam/debugfs.h
+++ b/drivers/crypto/caam/debugfs.h
@@ -5,16 +5,18 @@
 #define CAAM_DEBUGFS_H
 
 struct dentry;
+#define debugfs_node dentry
 struct caam_drv_private;
 struct caam_perfmon;
 
 #ifdef CONFIG_DEBUG_FS
 void caam_debugfs_init(struct caam_drv_private *ctrlpriv,
-		       struct caam_perfmon __force *perfmon, struct dentry *root);
+		       struct caam_perfmon __force *perfmon,
+		       struct debugfs_node *root);
 #else
 static inline void caam_debugfs_init(struct caam_drv_private *ctrlpriv,
 				     struct caam_perfmon __force *perfmon,
-				     struct dentry *root)
+				     struct debugfs_node *root)
 {}
 #endif
 
diff --git a/drivers/crypto/caam/intern.h b/drivers/crypto/caam/intern.h
index e51320150872..9885b14d427d 100644
--- a/drivers/crypto/caam/intern.h
+++ b/drivers/crypto/caam/intern.h
@@ -133,7 +133,7 @@ struct caam_drv_private {
 	 * variables at runtime.
 	 */
 #ifdef CONFIG_DEBUG_FS
-	struct dentry *ctl; /* controller dir */
+	struct debugfs_node *ctl; /* controller dir */
 	struct debugfs_blob_wrapper ctl_kek_wrap, ctl_tkek_wrap, ctl_tdsk_wrap;
 #endif
 
diff --git a/drivers/crypto/cavium/nitrox/nitrox_debugfs.c b/drivers/crypto/cavium/nitrox/nitrox_debugfs.c
index 741572a01995..8ad944f88221 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_debugfs.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_debugfs.c
@@ -59,7 +59,7 @@ void nitrox_debugfs_exit(struct nitrox_device *ndev)
 
 void nitrox_debugfs_init(struct nitrox_device *ndev)
 {
-	struct dentry *dir;
+	struct debugfs_node *dir;
 
 	dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
 
diff --git a/drivers/crypto/cavium/nitrox/nitrox_dev.h b/drivers/crypto/cavium/nitrox/nitrox_dev.h
index c2d0c23fb81b..1512429575a4 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_dev.h
+++ b/drivers/crypto/cavium/nitrox/nitrox_dev.h
@@ -261,7 +261,7 @@ struct nitrox_device {
 	struct nitrox_stats stats;
 	struct nitrox_hw hw;
 #if IS_ENABLED(CONFIG_DEBUG_FS)
-	struct dentry *debugfs_dir;
+	struct debugfs_node *debugfs_dir;
 #endif
 };
 
diff --git a/drivers/crypto/cavium/zip/zip_main.c b/drivers/crypto/cavium/zip/zip_main.c
index dc5b7bf7e1fd..66aaf00c089b 100644
--- a/drivers/crypto/cavium/zip/zip_main.c
+++ b/drivers/crypto/cavium/zip/zip_main.c
@@ -611,7 +611,7 @@ DEFINE_SHOW_ATTRIBUTE(zip_clear);
 DEFINE_SHOW_ATTRIBUTE(zip_regs);
 
 /* Root directory for thunderx_zip debugfs entry */
-static struct dentry *zip_debugfs_root;
+static struct debugfs_node *zip_debugfs_root;
 
 static void zip_debugfs_init(void)
 {
diff --git a/drivers/crypto/ccp/ccp-debugfs.c b/drivers/crypto/ccp/ccp-debugfs.c
index a1055554b47a..94271ee3b660 100644
--- a/drivers/crypto/ccp/ccp-debugfs.c
+++ b/drivers/crypto/ccp/ccp-debugfs.c
@@ -274,7 +274,7 @@ static const struct file_operations ccp_debugfs_stats_ops = {
 	.write = ccp5_debugfs_stats_write,
 };
 
-static struct dentry *ccp_debugfs_dir;
+static struct debugfs_node *ccp_debugfs_dir;
 static DEFINE_MUTEX(ccp_debugfs_lock);
 
 #define	MAX_NAME_LEN	20
@@ -283,7 +283,7 @@ void ccp5_debugfs_setup(struct ccp_device *ccp)
 {
 	struct ccp_cmd_queue *cmd_q;
 	char name[MAX_NAME_LEN + 1];
-	struct dentry *debugfs_q_instance;
+	struct debugfs_node *debugfs_q_instance;
 	int i;
 
 	if (!debugfs_initialized())
diff --git a/drivers/crypto/ccp/ccp-dev.h b/drivers/crypto/ccp/ccp-dev.h
index 83350e2d9821..4c0b4ceb381d 100644
--- a/drivers/crypto/ccp/ccp-dev.h
+++ b/drivers/crypto/ccp/ccp-dev.h
@@ -435,7 +435,7 @@ struct ccp_device {
 	unsigned long total_interrupts;
 
 	/* DebugFS info */
-	struct dentry *debugfs_instance;
+	struct debugfs_node *debugfs_instance;
 };
 
 enum ccp_memtype {
diff --git a/drivers/crypto/ccree/cc_debugfs.c b/drivers/crypto/ccree/cc_debugfs.c
index 8f008f024f8f..f8288e4abda3 100644
--- a/drivers/crypto/ccree/cc_debugfs.c
+++ b/drivers/crypto/ccree/cc_debugfs.c
@@ -19,7 +19,7 @@
  * a specific instance of ccree, hence it is
  * global.
  */
-static struct dentry *cc_debugfs_dir;
+static struct debugfs_node *cc_debugfs_dir;
 
 static struct debugfs_reg32 ver_sig_regs[] = {
 	{ .name = "SIGNATURE" }, /* Must be 0th */
diff --git a/drivers/crypto/ccree/cc_driver.h b/drivers/crypto/ccree/cc_driver.h
index f49579aa1452..b9b62be0679c 100644
--- a/drivers/crypto/ccree/cc_driver.h
+++ b/drivers/crypto/ccree/cc_driver.h
@@ -142,7 +142,7 @@ struct cc_drvdata {
 	void *request_mgr_handle;
 	void *fips_handle;
 	u32 sram_free_offset;	/* offset to non-allocated area in SRAM */
-	struct dentry *dir;	/* for debugfs */
+	struct debugfs_node *dir;	/* for debugfs */
 	struct clk *clk;
 	bool coherent;
 	char *hw_rev_name;
diff --git a/drivers/crypto/gemini/sl3516-ce-core.c b/drivers/crypto/gemini/sl3516-ce-core.c
index f7e0e3fea15c..ea91658285e6 100644
--- a/drivers/crypto/gemini/sl3516-ce-core.c
+++ b/drivers/crypto/gemini/sl3516-ce-core.c
@@ -477,8 +477,8 @@ static int sl3516_ce_probe(struct platform_device *pdev)
 	pm_runtime_put_sync(ce->dev);
 
 	if (IS_ENABLED(CONFIG_CRYPTO_DEV_SL3516_DEBUG)) {
-		struct dentry *dbgfs_dir __maybe_unused;
-		struct dentry *dbgfs_stats __maybe_unused;
+		struct debugfs_node *dbgfs_dir __maybe_unused;
+		struct debugfs_node *dbgfs_stats __maybe_unused;
 
 		/* Ignore error of debugfs */
 		dbgfs_dir = debugfs_create_dir("sl3516", NULL);
diff --git a/drivers/crypto/gemini/sl3516-ce.h b/drivers/crypto/gemini/sl3516-ce.h
index 56b844d0cd9c..b93a9daf26a0 100644
--- a/drivers/crypto/gemini/sl3516-ce.h
+++ b/drivers/crypto/gemini/sl3516-ce.h
@@ -253,8 +253,8 @@ struct sl3516_ce_dev {
 	unsigned long fallback_mod16;
 	unsigned long fallback_align16;
 #ifdef CONFIG_CRYPTO_DEV_SL3516_DEBUG
-	struct dentry *dbgfs_dir;
-	struct dentry *dbgfs_stats;
+	struct debugfs_node *dbgfs_dir;
+	struct debugfs_node *dbgfs_stats;
 #endif
 	void *pctrl;
 	dma_addr_t dctrl;
diff --git a/drivers/crypto/hisilicon/debugfs.c b/drivers/crypto/hisilicon/debugfs.c
index 45e130b901eb..599183289d06 100644
--- a/drivers/crypto/hisilicon/debugfs.c
+++ b/drivers/crypto/hisilicon/debugfs.c
@@ -1093,7 +1093,8 @@ static const struct file_operations qm_status_fops = {
 	.read = qm_status_read,
 };
 
-static void qm_create_debugfs_file(struct hisi_qm *qm, struct dentry *dir,
+static void qm_create_debugfs_file(struct hisi_qm *qm,
+				   struct debugfs_node *dir,
 				   enum qm_debug_file index)
 {
 	struct debugfs_file *file = qm->debug.files + index;
@@ -1137,7 +1138,7 @@ void hisi_qm_debug_init(struct hisi_qm *qm)
 	struct dfx_diff_registers *qm_regs = qm->debug.qm_diff_regs;
 	struct qm_dev_dfx *dev_dfx = &qm->debug.dev_dfx;
 	struct qm_dfx *dfx = &qm->debug.dfx;
-	struct dentry *qm_d;
+	struct debugfs_node *qm_d;
 	void *data;
 	int i;
 
diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index f5b47e5ff48a..c5c8e7028425 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -116,7 +116,7 @@
 #define HPRE_DFX_CORE_LEN		0x43
 
 static const char hpre_name[] = "hisi_hpre";
-static struct dentry *hpre_debugfs_root;
+static struct debugfs_node *hpre_debugfs_root;
 static const struct pci_device_id hpre_dev_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HUAWEI_HPRE_PF) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HUAWEI_HPRE_VF) },
@@ -978,12 +978,13 @@ static int hpre_debugfs_atomic64_set(void *data, u64 val)
 DEFINE_DEBUGFS_ATTRIBUTE(hpre_atomic64_ops, hpre_debugfs_atomic64_get,
 			 hpre_debugfs_atomic64_set, "%llu\n");
 
-static int hpre_create_debugfs_file(struct hisi_qm *qm, struct dentry *dir,
+static int hpre_create_debugfs_file(struct hisi_qm *qm,
+				    struct debugfs_node *dir,
 				    enum hpre_ctrl_dbgfs_file type, int indx)
 {
 	struct hpre *hpre = container_of(qm, struct hpre, qm);
 	struct hpre_debug *dbg = &hpre->debug;
-	struct dentry *file_dir;
+	struct debugfs_node *file_dir;
 
 	if (dir)
 		file_dir = dir;
@@ -1028,7 +1029,7 @@ static int hpre_cluster_debugfs_init(struct hisi_qm *qm)
 	struct device *dev = &qm->pdev->dev;
 	char buf[HPRE_DBGFS_VAL_MAX_LEN];
 	struct debugfs_regset32 *regset;
-	struct dentry *tmp_d;
+	struct debugfs_node *tmp_d;
 	u32 hpre_core_info;
 	u8 clusters_num;
 	int i, ret;
@@ -1103,7 +1104,7 @@ static void hpre_dfx_debug_init(struct hisi_qm *qm)
 	struct dfx_diff_registers *hpre_regs = qm->debug.acc_diff_regs;
 	struct hpre *hpre = container_of(qm, struct hpre, qm);
 	struct hpre_dfx *dfx = hpre->debug.dfx;
-	struct dentry *parent;
+	struct debugfs_node *parent;
 	int i;
 
 	parent = debugfs_create_dir("hpre_dfx", qm->debug.debug_root);
diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index 72cf48d1f3ab..75dfd2b95a52 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -132,7 +132,7 @@ struct sec_dfx_item {
 };
 
 static const char sec_name[] = "hisi_sec2";
-static struct dentry *sec_debugfs_root;
+static struct debugfs_node *sec_debugfs_root;
 
 static struct hisi_qm_list sec_devices = {
 	.register_to_crypto	= sec_register_to_crypto,
@@ -888,7 +888,7 @@ static int sec_core_debug_init(struct hisi_qm *qm)
 	struct device *dev = &qm->pdev->dev;
 	struct sec_dfx *dfx = &sec->debug.dfx;
 	struct debugfs_regset32 *regset;
-	struct dentry *tmp_d;
+	struct debugfs_node *tmp_d;
 	int i;
 
 	tmp_d = debugfs_create_dir("sec_dfx", qm->debug.debug_root);
diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index d8ba23b7cc7d..3f647df0346c 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -117,7 +117,7 @@ enum {
 };
 
 static const char hisi_zip_name[] = "hisi_zip";
-static struct dentry *hzip_debugfs_root;
+static struct debugfs_node *hzip_debugfs_root;
 
 struct hisi_zip_hw_error {
 	u32 int_msk;
@@ -817,7 +817,7 @@ static int hisi_zip_core_debug_init(struct hisi_qm *qm)
 	struct device *dev = &qm->pdev->dev;
 	struct debugfs_regset32 *regset;
 	u32 zip_core_info;
-	struct dentry *tmp_d;
+	struct debugfs_node *tmp_d;
 	char buf[HZIP_BUF_SIZE];
 	int i;
 
@@ -876,7 +876,7 @@ static void hisi_zip_dfx_debug_init(struct hisi_qm *qm)
 	struct dfx_diff_registers *hzip_regs = qm->debug.acc_diff_regs;
 	struct hisi_zip *zip = container_of(qm, struct hisi_zip, qm);
 	struct hisi_zip_dfx *dfx = &zip->dfx;
-	struct dentry *tmp_dir;
+	struct debugfs_node *tmp_dir;
 	void *data;
 	int i;
 
diff --git a/drivers/crypto/intel/iaa/iaa_crypto_stats.c b/drivers/crypto/intel/iaa/iaa_crypto_stats.c
index f5cc3d29ca19..7a5273171990 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_stats.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_stats.c
@@ -26,7 +26,7 @@ static atomic64_t total_completion_einval_errors;
 static atomic64_t total_completion_timeout_errors;
 static atomic64_t total_completion_comp_buf_overflow_errors;
 
-static struct dentry *iaa_crypto_debugfs_root;
+static struct debugfs_node *iaa_crypto_debugfs_root;
 
 void update_total_comp_calls(void)
 {
diff --git a/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h b/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
index 7830ecb1a1f1..5fba261fe709 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
@@ -432,7 +432,7 @@ struct adf_dc_data {
 };
 
 struct adf_pm {
-	struct dentry *debugfs_pm_status;
+	struct debugfs_node *debugfs_pm_status;
 	bool present;
 	int idle_irq_counters;
 	int throttle_irq_counters;
@@ -461,9 +461,9 @@ struct adf_accel_dev {
 	struct list_head compression_list;
 	unsigned long status;
 	atomic_t ref_count;
-	struct dentry *debugfs_dir;
-	struct dentry *fw_cntr_dbgfile;
-	struct dentry *cnv_dbgfile;
+	struct debugfs_node *debugfs_dir;
+	struct debugfs_node *fw_cntr_dbgfile;
+	struct debugfs_node *cnv_dbgfile;
 	struct list_head list;
 	struct module *owner;
 	struct adf_accel_pci accel_pci_dev;
diff --git a/drivers/crypto/intel/qat/qat_common/adf_cfg.h b/drivers/crypto/intel/qat/qat_common/adf_cfg.h
index 2afa6f0d15c5..c107a9d42794 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_cfg.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_cfg.h
@@ -25,7 +25,7 @@ struct adf_cfg_section {
 
 struct adf_cfg_device_data {
 	struct list_head sec_list;
-	struct dentry *debug;
+	struct debugfs_node *debug;
 	struct rw_semaphore lock;
 };
 
diff --git a/drivers/crypto/intel/qat/qat_common/adf_heartbeat_dbgfs.c b/drivers/crypto/intel/qat/qat_common/adf_heartbeat_dbgfs.c
index cccdff24b48d..5599d333fb03 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_heartbeat_dbgfs.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_heartbeat_dbgfs.c
@@ -211,7 +211,7 @@ void adf_heartbeat_dbgfs_add(struct adf_accel_dev *accel_dev)
 					    accel_dev, &adf_hb_cfg_fops);
 
 	if (IS_ENABLED(CONFIG_CRYPTO_DEV_QAT_ERROR_INJECTION)) {
-		struct dentry *inject_error __maybe_unused;
+		struct debugfs_node *inject_error __maybe_unused;
 
 		inject_error = debugfs_create_file("inject_error", 0200,
 						   hb->dbgfs.base_dir, accel_dev,
diff --git a/drivers/crypto/intel/qat/qat_common/adf_telemetry.h b/drivers/crypto/intel/qat/qat_common/adf_telemetry.h
index e54a406cc1b4..078e8be4ee43 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_telemetry.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_telemetry.h
@@ -13,6 +13,7 @@
 struct adf_accel_dev;
 struct adf_tl_dbg_counter;
 struct dentry;
+#define debugfs_node dentry
 
 #define ADF_TL_SL_CNT_COUNT		\
 	(sizeof(struct icp_qat_fw_init_admin_slice_cnt) / sizeof(__u8))
@@ -56,7 +57,7 @@ struct adf_telemetry {
 	 * values of @regs_data
 	 */
 	void **regs_hist_buff;
-	struct dentry *dbg_dir;
+	struct debugfs_node *dbg_dir;
 	u8 *rp_num_indexes;
 	/**
 	 * @regs_hist_lock: protects from race conditions between write and read
diff --git a/drivers/crypto/intel/qat/qat_common/adf_tl_debugfs.c b/drivers/crypto/intel/qat/qat_common/adf_tl_debugfs.c
index f20ae7e35a0d..abbd8dd6d5dc 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_tl_debugfs.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_tl_debugfs.c
@@ -643,10 +643,10 @@ DEFINE_SHOW_STORE_ATTRIBUTE(tl_rp_data);
 void adf_tl_dbgfs_add(struct adf_accel_dev *accel_dev)
 {
 	struct adf_telemetry *telemetry = accel_dev->telemetry;
-	struct dentry *parent = accel_dev->debugfs_dir;
+	struct debugfs_node *parent = accel_dev->debugfs_dir;
 	u8 max_rp = GET_TL_DATA(accel_dev).max_rp;
 	char name[ADF_TL_RP_REGS_FNAME_SIZE];
-	struct dentry *dir;
+	struct debugfs_node *dir;
 	unsigned int i;
 
 	if (!telemetry)
@@ -668,7 +668,7 @@ void adf_tl_dbgfs_add(struct adf_accel_dev *accel_dev)
 void adf_tl_dbgfs_rm(struct adf_accel_dev *accel_dev)
 {
 	struct adf_telemetry *telemetry = accel_dev->telemetry;
-	struct dentry *dbg_dir;
+	struct debugfs_node *dbg_dir;
 
 	if (!telemetry)
 		return;
diff --git a/drivers/crypto/intel/qat/qat_common/adf_transport_debug.c b/drivers/crypto/intel/qat/qat_common/adf_transport_debug.c
index e2dd568b87b5..675828803125 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_transport_debug.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_transport_debug.c
@@ -191,7 +191,7 @@ DEFINE_SEQ_ATTRIBUTE(adf_bank_debug);
 int adf_bank_debugfs_add(struct adf_etr_bank_data *bank)
 {
 	struct adf_accel_dev *accel_dev = bank->accel_dev;
-	struct dentry *parent = accel_dev->transport->debug;
+	struct debugfs_node *parent = accel_dev->transport->debug;
 	char name[16];
 
 	snprintf(name, sizeof(name), "bank_%02d", bank->bank_number);
diff --git a/drivers/crypto/intel/qat/qat_common/adf_transport_internal.h b/drivers/crypto/intel/qat/qat_common/adf_transport_internal.h
index 8b2c92ba7ca1..dbe731044b3f 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_transport_internal.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_transport_internal.h
@@ -9,7 +9,7 @@
 
 struct adf_etr_ring_debug_entry {
 	char ring_name[ADF_CFG_MAX_KEY_LEN_IN_BYTES];
-	struct dentry *debug;
+	struct debugfs_node *debug;
 };
 
 struct adf_etr_ring_data {
@@ -38,13 +38,13 @@ struct adf_etr_bank_data {
 	u16 irq_mask;
 	spinlock_t lock;	/* protects bank data struct */
 	struct adf_accel_dev *accel_dev;
-	struct dentry *bank_debug_dir;
-	struct dentry *bank_debug_cfg;
+	struct debugfs_node *bank_debug_dir;
+	struct debugfs_node *bank_debug_cfg;
 };
 
 struct adf_etr_data {
 	struct adf_etr_bank_data *banks;
-	struct dentry *debug;
+	struct debugfs_node *debug;
 };
 
 void adf_response_handler(uintptr_t bank_addr);
diff --git a/drivers/crypto/nx/nx.h b/drivers/crypto/nx/nx.h
index 2697baebb6a3..0b7585f33728 100644
--- a/drivers/crypto/nx/nx.h
+++ b/drivers/crypto/nx/nx.h
@@ -78,7 +78,7 @@ struct nx_crypto_driver {
 	struct nx_of       of;
 	struct vio_dev    *viodev;
 	struct vio_driver  viodriver;
-	struct dentry     *dfs_root;
+	struct debugfs_node *dfs_root;
 };
 
 #define NX_GCM4106_NONCE_LEN		(4)
diff --git a/drivers/crypto/nx/nx_debugfs.c b/drivers/crypto/nx/nx_debugfs.c
index ee7cd88bb10a..0968c2fc3526 100644
--- a/drivers/crypto/nx/nx_debugfs.c
+++ b/drivers/crypto/nx/nx_debugfs.c
@@ -32,7 +32,7 @@
 
 void nx_debugfs_init(struct nx_crypto_driver *drv)
 {
-	struct dentry *root;
+	struct debugfs_node *root;
 
 	root = debugfs_create_dir(NX_NAME, NULL);
 	drv->dfs_root = root;
diff --git a/drivers/crypto/rockchip/rk3288_crypto.c b/drivers/crypto/rockchip/rk3288_crypto.c
index b77bdce8e7fc..765e365a0576 100644
--- a/drivers/crypto/rockchip/rk3288_crypto.c
+++ b/drivers/crypto/rockchip/rk3288_crypto.c
@@ -235,8 +235,8 @@ DEFINE_SHOW_ATTRIBUTE(rk_crypto_debugfs);
 
 static void register_debugfs(struct rk_crypto_info *crypto_info)
 {
-	struct dentry *dbgfs_dir __maybe_unused;
-	struct dentry *dbgfs_stats __maybe_unused;
+	struct debugfs_node *dbgfs_dir __maybe_unused;
+	struct debugfs_node *dbgfs_stats __maybe_unused;
 
 	/* Ignore error of debugfs */
 	dbgfs_dir = debugfs_create_dir("rk3288_crypto", NULL);
diff --git a/drivers/crypto/rockchip/rk3288_crypto.h b/drivers/crypto/rockchip/rk3288_crypto.h
index 3aa03cbfb6be..cbed457d6332 100644
--- a/drivers/crypto/rockchip/rk3288_crypto.h
+++ b/drivers/crypto/rockchip/rk3288_crypto.h
@@ -197,8 +197,8 @@
 struct rockchip_ip {
 	struct list_head	dev_list;
 	spinlock_t		lock; /* Control access to dev_list */
-	struct dentry		*dbgfs_dir;
-	struct dentry		*dbgfs_stats;
+	struct debugfs_node *dbgfs_dir;
+	struct debugfs_node *dbgfs_stats;
 };
 
 struct rk_clks {
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 800466f96a68..ac0ea34a84dc 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -71,7 +71,7 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s);
 void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 				   resource_size_t length);
 
-struct dentry *cxl_debugfs_create_dir(const char *dir);
+struct debugfs_node *cxl_debugfs_create_dir(const char *dir);
 int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
 		     enum cxl_decoder_mode mode);
 int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size);
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 548564c770c0..8bcebdba15b5 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1459,7 +1459,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_memdev_state_create, "CXL");
 
 void __init cxl_mbox_init(void)
 {
-	struct dentry *mbox_debugfs;
+	struct debugfs_node *mbox_debugfs;
 
 	mbox_debugfs = cxl_debugfs_create_dir("mbox");
 	debugfs_create_bool("raw_allow_all", 0600, mbox_debugfs,
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 78a5c2c25982..cf7034e5c7f7 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -810,7 +810,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(cxl_einj_inject_fops, NULL, cxl_einj_inject,
 
 static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
 {
-	struct dentry *dir;
+	struct debugfs_node *dir;
 
 	if (!einj_cxl_is_initialized())
 		return;
@@ -2301,9 +2301,9 @@ struct bus_type cxl_bus_type = {
 };
 EXPORT_SYMBOL_NS_GPL(cxl_bus_type, "CXL");
 
-static struct dentry *cxl_debugfs;
+static struct debugfs_node *cxl_debugfs;
 
-struct dentry *cxl_debugfs_create_dir(const char *dir)
+struct debugfs_node *cxl_debugfs_create_dir(const char *dir)
 {
 	return debugfs_create_dir(dir, cxl_debugfs);
 }
diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 98657d3b9435..517f15dca7f0 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -37,7 +37,7 @@
 #define IS_SUPPORTED_ATTR(f, name) ((f & DEVFREQ_GOV_ATTR_##name) ? true : false)
 
 static struct class *devfreq_class;
-static struct dentry *devfreq_debugfs;
+static struct debugfs_node *devfreq_debugfs;
 
 /*
  * devfreq core provides delayed work based load monitoring helper
diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 5baa83b85515..1592ff587b81 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -1686,11 +1686,11 @@ static int dma_buf_debug_show(struct seq_file *s, void *unused)
 
 DEFINE_SHOW_ATTRIBUTE(dma_buf_debug);
 
-static struct dentry *dma_buf_debugfs_dir;
+static struct debugfs_node *dma_buf_debugfs_dir;
 
 static int dma_buf_init_debugfs(void)
 {
-	struct dentry *d;
+	struct debugfs_node *d;
 	int err = 0;
 
 	d = debugfs_create_dir("dma_buf", NULL);
diff --git a/drivers/dma-buf/sync_debug.c b/drivers/dma-buf/sync_debug.c
index 237bce21d1e7..92e55640ab8e 100644
--- a/drivers/dma-buf/sync_debug.c
+++ b/drivers/dma-buf/sync_debug.c
@@ -8,7 +8,7 @@
 #include <linux/debugfs.h>
 #include "sync_debug.h"
 
-static struct dentry *dbgfs;
+static struct debugfs_node *dbgfs;
 
 static LIST_HEAD(sync_timeline_list_head);
 static DEFINE_SPINLOCK(sync_timeline_list_lock);
diff --git a/drivers/dma/amd/ptdma/ptdma-debugfs.c b/drivers/dma/amd/ptdma/ptdma-debugfs.c
index c7c90bbf6fd8..a97fc9ba26b3 100644
--- a/drivers/dma/amd/ptdma/ptdma-debugfs.c
+++ b/drivers/dma/amd/ptdma/ptdma-debugfs.c
@@ -100,7 +100,7 @@ DEFINE_SHOW_ATTRIBUTE(pt_debugfs_stats);
 
 void ptdma_debugfs_setup(struct pt_device *pt)
 {
-	struct dentry *debugfs_q_instance;
+	struct debugfs_node *debugfs_q_instance;
 	struct ae4_cmd_queue *ae4cmd_q;
 	struct pt_cmd_queue *cmd_q;
 	struct ae4_device *ae4;
diff --git a/drivers/dma/bcm-sba-raid.c b/drivers/dma/bcm-sba-raid.c
index 7f0e76439ce5..2c50172d13f0 100644
--- a/drivers/dma/bcm-sba-raid.c
+++ b/drivers/dma/bcm-sba-raid.c
@@ -155,7 +155,7 @@ struct sba_device {
 	struct list_head reqs_aborted_list;
 	struct list_head reqs_free_list;
 	/* DebugFS directory entries */
-	struct dentry *root;
+	struct debugfs_node *root;
 };
 
 /* ====== Command helper routines ===== */
diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index c1357d7f3dc6..04115654b4e8 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -64,7 +64,7 @@ static long dmaengine_ref_count;
 #ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
 
-static struct dentry *rootdir;
+static struct debugfs_node *rootdir;
 
 static void dmaengine_debug_register(struct dma_device *dma_dev)
 {
diff --git a/drivers/dma/dmaengine.h b/drivers/dma/dmaengine.h
index 53f16d3f0029..f3c4b3747fa7 100644
--- a/drivers/dma/dmaengine.h
+++ b/drivers/dma/dmaengine.h
@@ -185,13 +185,14 @@ struct dma_chan *dma_get_any_slave_channel(struct dma_device *device);
 #ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
 
-static inline struct dentry *
+static inline struct debugfs_node *
 dmaengine_get_debugfs_root(struct dma_device *dma_dev) {
 	return dma_dev->dbg_dev_root;
 }
 #else
 struct dentry;
-static inline struct dentry *
+#define debugfs_node dentry
+static inline struct debugfs_node *
 dmaengine_get_debugfs_root(struct dma_device *dma_dev)
 {
 	return NULL;
diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
index 406f169b09a7..66e8c817d1c2 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
@@ -98,7 +98,8 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_x32, dw_edma_debugfs_u32_get, NULL, "0x%08llx\n");
 
 static void dw_edma_debugfs_create_x32(struct dw_edma *dw,
 				       const struct dw_edma_debugfs_entry ini[],
-				       int nr_entries, struct dentry *dent)
+				       int nr_entries,
+				       struct debugfs_node *dent)
 {
 	struct dw_edma_debugfs_entry *entries;
 	int i;
@@ -117,7 +118,7 @@ static void dw_edma_debugfs_create_x32(struct dw_edma *dw,
 }
 
 static void dw_edma_debugfs_regs_ch(struct dw_edma *dw, enum dw_edma_dir dir,
-				    u16 ch, struct dentry *dent)
+				    u16 ch, struct debugfs_node *dent)
 {
 	struct dw_edma_debugfs_entry debugfs_regs[] = {
 		CTX_REGISTER(dw, ch_control1, dir, ch),
@@ -137,7 +138,7 @@ static void dw_edma_debugfs_regs_ch(struct dw_edma *dw, enum dw_edma_dir dir,
 }
 
 static noinline_for_stack void
-dw_edma_debugfs_regs_wr(struct dw_edma *dw, struct dentry *dent)
+dw_edma_debugfs_regs_wr(struct dw_edma *dw, struct debugfs_node *dent)
 {
 	const struct dw_edma_debugfs_entry debugfs_regs[] = {
 		/* eDMA global registers */
@@ -174,7 +175,7 @@ dw_edma_debugfs_regs_wr(struct dw_edma *dw, struct dentry *dent)
 		WR_REGISTER_UNROLL(dw, ch6_pwr_en),
 		WR_REGISTER_UNROLL(dw, ch7_pwr_en),
 	};
-	struct dentry *regs_dent, *ch_dent;
+	struct debugfs_node *regs_dent, *ch_dent;
 	int nr_entries, i;
 	char name[32];
 
@@ -199,7 +200,7 @@ dw_edma_debugfs_regs_wr(struct dw_edma *dw, struct dentry *dent)
 }
 
 static noinline_for_stack void dw_edma_debugfs_regs_rd(struct dw_edma *dw,
-						       struct dentry *dent)
+						       struct debugfs_node *dent)
 {
 	const struct dw_edma_debugfs_entry debugfs_regs[] = {
 		/* eDMA global registers */
@@ -237,7 +238,7 @@ static noinline_for_stack void dw_edma_debugfs_regs_rd(struct dw_edma *dw,
 		RD_REGISTER_UNROLL(dw, ch6_pwr_en),
 		RD_REGISTER_UNROLL(dw, ch7_pwr_en),
 	};
-	struct dentry *regs_dent, *ch_dent;
+	struct debugfs_node *regs_dent, *ch_dent;
 	int nr_entries, i;
 	char name[32];
 
@@ -267,7 +268,7 @@ static void dw_edma_debugfs_regs(struct dw_edma *dw)
 		REGISTER(dw, ctrl_data_arb_prior),
 		REGISTER(dw, ctrl),
 	};
-	struct dentry *regs_dent;
+	struct debugfs_node *regs_dent;
 	int nr_entries;
 
 	regs_dent = debugfs_create_dir(REGISTERS_STR, dw->dma.dbg_dev_root);
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c b/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
index dcdc57fe976c..d2c76b239e5e 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
@@ -58,7 +58,8 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_x32, dw_hdma_debugfs_u32_get, NULL, "0x%08llx\n");
 
 static void dw_hdma_debugfs_create_x32(struct dw_edma *dw,
 				       const struct dw_hdma_debugfs_entry ini[],
-				       int nr_entries, struct dentry *dent)
+				       int nr_entries,
+				       struct debugfs_node *dent)
 {
 	struct dw_hdma_debugfs_entry *entries;
 	int i;
@@ -77,7 +78,7 @@ static void dw_hdma_debugfs_create_x32(struct dw_edma *dw,
 }
 
 static void dw_hdma_debugfs_regs_ch(struct dw_edma *dw, enum dw_edma_dir dir,
-				    u16 ch, struct dentry *dent)
+				    u16 ch, struct debugfs_node *dent)
 {
 	const struct dw_hdma_debugfs_entry debugfs_regs[] = {
 		CTX_REGISTER(dw, ch_en, dir, ch),
@@ -113,9 +114,10 @@ static void dw_hdma_debugfs_regs_ch(struct dw_edma *dw, enum dw_edma_dir dir,
 	dw_hdma_debugfs_create_x32(dw, debugfs_regs, nr_entries, dent);
 }
 
-static void dw_hdma_debugfs_regs_wr(struct dw_edma *dw, struct dentry *dent)
+static void dw_hdma_debugfs_regs_wr(struct dw_edma *dw,
+				    struct debugfs_node *dent)
 {
-	struct dentry *regs_dent, *ch_dent;
+	struct debugfs_node *regs_dent, *ch_dent;
 	char name[32];
 	int i;
 
@@ -130,9 +132,10 @@ static void dw_hdma_debugfs_regs_wr(struct dw_edma *dw, struct dentry *dent)
 	}
 }
 
-static void dw_hdma_debugfs_regs_rd(struct dw_edma *dw, struct dentry *dent)
+static void dw_hdma_debugfs_regs_rd(struct dw_edma *dw,
+				    struct debugfs_node *dent)
 {
-	struct dentry *regs_dent, *ch_dent;
+	struct debugfs_node *regs_dent, *ch_dent;
 	char name[32];
 	int i;
 
@@ -149,7 +152,7 @@ static void dw_hdma_debugfs_regs_rd(struct dw_edma *dw, struct dentry *dent)
 
 static void dw_hdma_debugfs_regs(struct dw_edma *dw)
 {
-	struct dentry *regs_dent;
+	struct debugfs_node *regs_dent;
 
 	regs_dent = debugfs_create_dir(REGISTERS_STR, dw->dma.dbg_dev_root);
 
diff --git a/drivers/dma/hisi_dma.c b/drivers/dma/hisi_dma.c
index 25a4134be36b..6c1ed239308a 100644
--- a/drivers/dma/hisi_dma.c
+++ b/drivers/dma/hisi_dma.c
@@ -874,7 +874,7 @@ static int hisi_dma_create_chan_dir(struct hisi_dma_dev *hdma_dev)
 	char dir_name[HISI_DMA_MAX_DIR_NAME_LEN];
 	struct debugfs_regset32 *regsets;
 	struct debugfs_reg32 *regs;
-	struct dentry *chan_dir;
+	struct debugfs_node *chan_dir;
 	struct device *dev;
 	u32 regs_sz;
 	int ret;
diff --git a/drivers/dma/idxd/debugfs.c b/drivers/dma/idxd/debugfs.c
index ad4245cb301d..838ea5ac1033 100644
--- a/drivers/dma/idxd/debugfs.c
+++ b/drivers/dma/idxd/debugfs.c
@@ -10,7 +10,7 @@
 #include "idxd.h"
 #include "registers.h"
 
-static struct dentry *idxd_debugfs_dir;
+static struct debugfs_node *idxd_debugfs_dir;
 
 static void dump_event_entry(struct idxd_device *idxd, struct seq_file *s,
 			     u16 index, int *count, bool processed)
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 214b8039439f..7cd4e17b8787 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -370,8 +370,8 @@ struct idxd_device {
 	struct idxd_evl *evl;
 	struct kmem_cache *evl_cache;
 
-	struct dentry *dbgfs_dir;
-	struct dentry *dbgfs_evl_file;
+	struct debugfs_node *dbgfs_dir;
+	struct debugfs_node *dbgfs_evl_file;
 
 	bool user_submission_safe;
 
diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index e50cf3357e5e..a291654a6f89 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -128,7 +128,7 @@ struct pxad_device {
 	struct pxad_phy			*phys;
 	spinlock_t			phy_lock;	/* Phy association */
 #ifdef CONFIG_DEBUG_FS
-	struct dentry			*dbgfs_root;
+	struct debugfs_node *dbgfs_root;
 	struct dentry			**dbgfs_chan;
 #endif
 };
@@ -318,11 +318,12 @@ DEFINE_SHOW_ATTRIBUTE(chan_state);
 DEFINE_SHOW_ATTRIBUTE(descriptors);
 DEFINE_SHOW_ATTRIBUTE(requester_chan);
 
-static struct dentry *pxad_dbg_alloc_chan(struct pxad_device *pdev,
-					     int ch, struct dentry *chandir)
+static struct debugfs_node *pxad_dbg_alloc_chan(struct pxad_device *pdev,
+					     int ch,
+					     struct debugfs_node *chandir)
 {
 	char chan_name[11];
-	struct dentry *chan;
+	struct debugfs_node *chan;
 	void *dt;
 
 	scnprintf(chan_name, sizeof(chan_name), "%d", ch);
@@ -339,7 +340,7 @@ static struct dentry *pxad_dbg_alloc_chan(struct pxad_device *pdev,
 static void pxad_init_debugfs(struct pxad_device *pdev)
 {
 	int i;
-	struct dentry *chandir;
+	struct debugfs_node *chandir;
 
 	pdev->dbgfs_chan =
 		kmalloc_array(pdev->nr_chans, sizeof(struct dentry *),
diff --git a/drivers/dma/qcom/hidma.h b/drivers/dma/qcom/hidma.h
index f212466744f3..338c28dd0b55 100644
--- a/drivers/dma/qcom/hidma.h
+++ b/drivers/dma/qcom/hidma.h
@@ -123,7 +123,7 @@ struct hidma_dev {
 	spinlock_t			lock;
 	struct dma_device		ddev;
 
-	struct dentry			*debugfs;
+	struct debugfs_node *debugfs;
 
 	/* sysfs entry for the channel id */
 	struct device_attribute		*chid_attrs;
diff --git a/drivers/dma/qcom/hidma_dbg.c b/drivers/dma/qcom/hidma_dbg.c
index ce87c7937a0e..f7b0d6b729a2 100644
--- a/drivers/dma/qcom/hidma_dbg.c
+++ b/drivers/dma/qcom/hidma_dbg.c
@@ -142,7 +142,7 @@ void hidma_debug_init(struct hidma_dev *dmadev)
 {
 	int chidx = 0;
 	struct list_head *position = NULL;
-	struct dentry *dir;
+	struct debugfs_node *dir;
 
 	dmadev->debugfs = debugfs_create_dir(dev_name(dmadev->ddev.dev), NULL);
 
diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
index ee5d9fdbfd7f..b8b6a63db321 100644
--- a/drivers/dma/xilinx/xilinx_dpdma.c
+++ b/drivers/dma/xilinx/xilinx_dpdma.c
@@ -451,7 +451,7 @@ static const struct file_operations fops_xilinx_dpdma_dbgfs = {
 
 static void xilinx_dpdma_debugfs_init(struct xilinx_dpdma_device *xdev)
 {
-	struct dentry *dent;
+	struct debugfs_node *dent;
 
 	dpdma_debugfs.testcase = DPDMA_TC_NONE;
 
diff --git a/drivers/edac/altera_edac.h b/drivers/edac/altera_edac.h
index 3727e72c8c2e..54a92adf3684 100644
--- a/drivers/edac/altera_edac.h
+++ b/drivers/edac/altera_edac.h
@@ -376,7 +376,7 @@ struct altr_edac_device_dev {
 	int sb_irq;
 	int db_irq;
 	const struct edac_device_prv_data *data;
-	struct dentry *debugfs_dir;
+	struct debugfs_node *debugfs_dir;
 	char *edac_dev_name;
 	struct altr_arria10_edac *edac;
 	struct edac_device_ctl_info *edac_dev;
diff --git a/drivers/edac/armada_xp_edac.c b/drivers/edac/armada_xp_edac.c
index d64248fcf4c0..9f8db31cf83e 100644
--- a/drivers/edac/armada_xp_edac.c
+++ b/drivers/edac/armada_xp_edac.c
@@ -383,7 +383,7 @@ struct aurora_l2_drvdata {
 	uint32_t inject_mask;
 	uint8_t inject_ctl;
 
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 };
 
 #ifdef CONFIG_EDAC_DEBUG
diff --git a/drivers/edac/debugfs.c b/drivers/edac/debugfs.c
index 4804332d9946..cfa22b72813f 100644
--- a/drivers/edac/debugfs.c
+++ b/drivers/edac/debugfs.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include "edac_module.h"
 
-static struct dentry *edac_debugfs;
+static struct debugfs_node *edac_debugfs;
 
 static ssize_t edac_fake_inject_write(struct file *file,
 				      const char __user *data,
@@ -54,7 +54,7 @@ void edac_debugfs_exit(void)
 
 void edac_create_debugfs_nodes(struct mem_ctl_info *mci)
 {
-	struct dentry *parent;
+	struct debugfs_node *parent;
 	char name[80];
 	int i;
 
@@ -80,7 +80,7 @@ void edac_create_debugfs_nodes(struct mem_ctl_info *mci)
 }
 
 /* Create a toplevel dir under EDAC's debugfs hierarchy */
-struct dentry *edac_debugfs_create_dir(const char *dirname)
+struct debugfs_node *edac_debugfs_create_dir(const char *dirname)
 {
 	if (!edac_debugfs)
 		return NULL;
@@ -90,8 +90,8 @@ struct dentry *edac_debugfs_create_dir(const char *dirname)
 EXPORT_SYMBOL_GPL(edac_debugfs_create_dir);
 
 /* Create a toplevel dir under EDAC's debugfs hierarchy with parent @parent */
-struct dentry *
-edac_debugfs_create_dir_at(const char *dirname, struct dentry *parent)
+struct debugfs_node *
+edac_debugfs_create_dir_at(const char *dirname, struct debugfs_node *parent)
 {
 	return debugfs_create_dir(dirname, parent);
 }
@@ -106,8 +106,9 @@ EXPORT_SYMBOL_GPL(edac_debugfs_create_dir_at);
  * @data: private data of caller
  * @fops: file operations of this file
  */
-struct dentry *
-edac_debugfs_create_file(const char *name, umode_t mode, struct dentry *parent,
+struct debugfs_node *
+edac_debugfs_create_file(const char *name, umode_t mode,
+			 struct debugfs_node *parent,
 			 void *data, const struct file_operations *fops)
 {
 	if (!parent)
@@ -119,7 +120,7 @@ EXPORT_SYMBOL_GPL(edac_debugfs_create_file);
 
 /* Wrapper for debugfs_create_x8() */
 void edac_debugfs_create_x8(const char *name, umode_t mode,
-			    struct dentry *parent, u8 *value)
+			    struct debugfs_node *parent, u8 *value)
 {
 	if (!parent)
 		parent = edac_debugfs;
@@ -130,7 +131,7 @@ EXPORT_SYMBOL_GPL(edac_debugfs_create_x8);
 
 /* Wrapper for debugfs_create_x16() */
 void edac_debugfs_create_x16(const char *name, umode_t mode,
-			     struct dentry *parent, u16 *value)
+			     struct debugfs_node *parent, u16 *value)
 {
 	if (!parent)
 		parent = edac_debugfs;
@@ -141,7 +142,7 @@ EXPORT_SYMBOL_GPL(edac_debugfs_create_x16);
 
 /* Wrapper for debugfs_create_x32() */
 void edac_debugfs_create_x32(const char *name, umode_t mode,
-			     struct dentry *parent, u32 *value)
+			     struct debugfs_node *parent, u32 *value)
 {
 	if (!parent)
 		parent = edac_debugfs;
diff --git a/drivers/edac/edac_module.h b/drivers/edac/edac_module.h
index 47593afdc234..82840b324100 100644
--- a/drivers/edac/edac_module.h
+++ b/drivers/edac/edac_module.h
@@ -66,34 +66,38 @@ extern void edac_mc_reset_delay_period(unsigned long value);
 void edac_debugfs_init(void);
 void edac_debugfs_exit(void);
 void edac_create_debugfs_nodes(struct mem_ctl_info *mci);
-struct dentry *edac_debugfs_create_dir(const char *dirname);
-struct dentry *
-edac_debugfs_create_dir_at(const char *dirname, struct dentry *parent);
-struct dentry *
-edac_debugfs_create_file(const char *name, umode_t mode, struct dentry *parent,
+struct debugfs_node *edac_debugfs_create_dir(const char *dirname);
+struct debugfs_node *
+edac_debugfs_create_dir_at(const char *dirname, struct debugfs_node *parent);
+struct debugfs_node *
+edac_debugfs_create_file(const char *name, umode_t mode,
+			 struct debugfs_node *parent,
 			 void *data, const struct file_operations *fops);
 void edac_debugfs_create_x8(const char *name, umode_t mode,
-			    struct dentry *parent, u8 *value);
+			    struct debugfs_node *parent, u8 *value);
 void edac_debugfs_create_x16(const char *name, umode_t mode,
-			     struct dentry *parent, u16 *value);
+			     struct debugfs_node *parent, u16 *value);
 void edac_debugfs_create_x32(const char *name, umode_t mode,
-			     struct dentry *parent, u32 *value);
+			     struct debugfs_node *parent, u32 *value);
 #else
 static inline void edac_debugfs_init(void)					{ }
 static inline void edac_debugfs_exit(void)					{ }
 static inline void edac_create_debugfs_nodes(struct mem_ctl_info *mci)		{ }
-static inline struct dentry *edac_debugfs_create_dir(const char *dirname)	{ return NULL; }
-static inline struct dentry *
-edac_debugfs_create_dir_at(const char *dirname, struct dentry *parent)		{ return NULL; }
-static inline struct dentry *
-edac_debugfs_create_file(const char *name, umode_t mode, struct dentry *parent,
+static inline struct debugfs_node *edac_debugfs_create_dir(const char *dirname)	{ return NULL; }
+static inline struct debugfs_node *
+edac_debugfs_create_dir_at(const char *dirname, struct debugfs_node *parent)		{ return NULL; }
+static inline struct debugfs_node *
+edac_debugfs_create_file(const char *name, umode_t mode,
+			 struct debugfs_node *parent,
 			 void *data, const struct file_operations *fops)	{ return NULL; }
 static inline void edac_debugfs_create_x8(const char *name, umode_t mode,
-					  struct dentry *parent, u8 *value)	{ }
+					  struct debugfs_node *parent,
+					  u8 *value)	{ }
 static inline void edac_debugfs_create_x16(const char *name, umode_t mode,
-					   struct dentry *parent, u16 *value)	{ }
+					   struct debugfs_node *parent,
+					   u16 *value)	{ }
 static inline void edac_debugfs_create_x32(const char *name, umode_t mode,
-		       struct dentry *parent, u32 *value)			{ }
+		       struct debugfs_node *parent, u32 *value)			{ }
 #endif
 
 /*
diff --git a/drivers/edac/i5100_edac.c b/drivers/edac/i5100_edac.c
index d470afe65001..fdf80bb69fe5 100644
--- a/drivers/edac/i5100_edac.c
+++ b/drivers/edac/i5100_edac.c
@@ -347,10 +347,10 @@ struct i5100_priv {
 	u16 inject_eccmask1;
 	u16 inject_eccmask2;
 
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 };
 
-static struct dentry *i5100_debugfs;
+static struct debugfs_node *i5100_debugfs;
 
 /* map a rank/chan to a slot number on the mainboard */
 static int i5100_rank_to_slot(const struct mem_ctl_info *mci,
diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index fdf3a84fe698..d7a28c5c2f7d 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -1079,7 +1079,7 @@ static void igen6_reg_dump(struct igen6_imc *imc)
 	edac_dbg(2, "TOM              : 0x%llx", igen6_tom);
 }
 
-static struct dentry *igen6_test;
+static struct debugfs_node *igen6_test;
 
 static int debugfs_u64_set(void *data, u64 val)
 {
diff --git a/drivers/edac/npcm_edac.c b/drivers/edac/npcm_edac.c
index e60a99eb8cfb..7620021b6325 100644
--- a/drivers/edac/npcm_edac.c
+++ b/drivers/edac/npcm_edac.c
@@ -95,7 +95,7 @@ struct priv_data {
 	const struct npcm_platform_data *pdata;
 
 	/* error injection */
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 	u8 error_type;
 	u8 location;
 	u8 bit;
diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c
index f93f2f2b1cf2..782d18a1e697 100644
--- a/drivers/edac/pnd2_edac.c
+++ b/drivers/edac/pnd2_edac.c
@@ -1418,7 +1418,7 @@ static struct notifier_block pnd2_mce_dec = {
 static u64 pnd2_fake_addr;
 #define PND2_BLOB_SIZE 1024
 static char pnd2_result[PND2_BLOB_SIZE];
-static struct dentry *pnd2_test;
+static struct debugfs_node *pnd2_test;
 static struct debugfs_blob_wrapper pnd2_blob = {
 	.data = pnd2_result,
 	.size = 0
diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index f7bd930e058f..131a1edc291e 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -785,7 +785,7 @@ EXPORT_SYMBOL_GPL(skx_remove);
  * Exercise the address decode logic by writing an address to
  * /sys/kernel/debug/edac/{skx,i10nm}_test/addr.
  */
-static struct dentry *skx_test;
+static struct debugfs_node *skx_test;
 
 static int debugfs_u64_set(void *data, u64 val)
 {
diff --git a/drivers/edac/thunderx_edac.c b/drivers/edac/thunderx_edac.c
index 75c04dfc3962..c46015b91ece 100644
--- a/drivers/edac/thunderx_edac.c
+++ b/drivers/edac/thunderx_edac.c
@@ -457,13 +457,13 @@ static struct debugfs_entry *lmc_dfs_ents[] = {
 	&debugfs_int_w1c,
 };
 
-static int thunderx_create_debugfs_nodes(struct dentry *parent,
+static int thunderx_create_debugfs_nodes(struct debugfs_node *parent,
 					  struct debugfs_entry *attrs[],
 					  void *data,
 					  size_t num)
 {
 	int i;
-	struct dentry *ent;
+	struct debugfs_node *ent;
 
 	if (!IS_ENABLED(CONFIG_EDAC_DEBUG))
 		return 0;
@@ -1049,7 +1049,7 @@ struct thunderx_ocx {
 	struct pci_dev *pdev;
 	struct edac_device_ctl_info *edac_dev;
 
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 	struct msix_entry msix_ent[OCX_INTS];
 
 	struct ocx_com_err_ctx com_err_ctx[RING_ENTRIES];
@@ -1739,7 +1739,7 @@ struct thunderx_l2c {
 	struct pci_dev *pdev;
 	struct edac_device_ctl_info *edac_dev;
 
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 
 	int index;
 
diff --git a/drivers/edac/versal_edac.c b/drivers/edac/versal_edac.c
index 5a43b5d43ca2..cf0b862946f0 100644
--- a/drivers/edac/versal_edac.c
+++ b/drivers/edac/versal_edac.c
@@ -241,7 +241,7 @@ struct edac_priv {
 	u32 ch_bit;
 #ifdef CONFIG_EDAC_DEBUG
 	u64 err_inject_addr;
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 #endif
 };
 
diff --git a/drivers/edac/xgene_edac.c b/drivers/edac/xgene_edac.c
index 699c7d29d80c..3c05a60fac92 100644
--- a/drivers/edac/xgene_edac.c
+++ b/drivers/edac/xgene_edac.c
@@ -51,7 +51,7 @@ struct xgene_edac {
 	struct regmap		*rb_map;
 	void __iomem		*pcp_csr;
 	spinlock_t		lock;
-	struct dentry           *dfs;
+	struct debugfs_node *dfs;
 
 	struct list_head	mcus;
 	struct list_head	pmds;
@@ -861,7 +861,7 @@ static void
 xgene_edac_pmd_create_debugfs_nodes(struct edac_device_ctl_info *edac_dev)
 {
 	struct xgene_edac_pmd_ctx *ctx = edac_dev->pvt_info;
-	struct dentry *dbgfs_dir;
+	struct debugfs_node *dbgfs_dir;
 	char name[10];
 
 	if (!IS_ENABLED(CONFIG_EDAC_DEBUG) || !ctx->edac->dfs)
@@ -1165,7 +1165,7 @@ static void
 xgene_edac_l3_create_debugfs_nodes(struct edac_device_ctl_info *edac_dev)
 {
 	struct xgene_edac_dev_ctx *ctx = edac_dev->pvt_info;
-	struct dentry *dbgfs_dir;
+	struct debugfs_node *dbgfs_dir;
 	char name[10];
 
 	if (!IS_ENABLED(CONFIG_EDAC_DEBUG) || !ctx->edac->dfs)
diff --git a/drivers/edac/zynqmp_edac.c b/drivers/edac/zynqmp_edac.c
index cdffc9e4194d..ae37db7d9916 100644
--- a/drivers/edac/zynqmp_edac.c
+++ b/drivers/edac/zynqmp_edac.c
@@ -114,7 +114,7 @@ struct edac_priv {
 	u32 ce_cnt;
 	u32 ue_cnt;
 #ifdef CONFIG_EDAC_DEBUG
-	struct dentry *debugfs_dir;
+	struct debugfs_node *debugfs_dir;
 	u8 ce_bitpos;
 	u8 ue_bitpos[OCM_NUM_UE_BITPOS];
 	u32 fault_injection_cnt;
diff --git a/drivers/extcon/extcon-rtk-type-c.c b/drivers/extcon/extcon-rtk-type-c.c
index 82b60b927e41..2c7a11fcffcb 100644
--- a/drivers/extcon/extcon-rtk-type-c.c
+++ b/drivers/extcon/extcon-rtk-type-c.c
@@ -96,7 +96,7 @@ struct type_c_data {
 
 	bool rd_en_at_first;
 
-	struct dentry *debug_dir;
+	struct debugfs_node *debug_dir;
 
 	struct typec_port *port;
 };
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 60050da54bf2..b43a86ab3f1f 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -57,7 +57,7 @@ static DEFINE_MUTEX(scmi_list_mutex);
 /* Track the unique id for the transfers for debug & profiling purpose */
 static atomic_t transfer_last_id;
 
-static struct dentry *scmi_top_dentry;
+static struct debugfs_node *scmi_top_dentry;
 
 /**
  * struct scmi_xfers_info - Structure to manage transfer information
@@ -123,7 +123,7 @@ struct scmi_protocol_instance {
  * @counters: An array of atomic_c's used for tracking statistics (if enabled)
  */
 struct scmi_debug_info {
-	struct dentry *top_dentry;
+	struct debugfs_node *top_dentry;
 	const char *name;
 	const char *type;
 	bool is_atomic;
@@ -2926,9 +2926,9 @@ static const struct file_operations fops_reset_counts = {
 };
 
 static void scmi_debugfs_counters_setup(struct scmi_debug_info *dbg,
-					struct dentry *trans)
+					struct debugfs_node *trans)
 {
-	struct dentry *counters;
+	struct debugfs_node *counters;
 	int idx;
 
 	counters = debugfs_create_dir("counters", trans);
@@ -2955,7 +2955,7 @@ static void scmi_debugfs_common_cleanup(void *d)
 static struct scmi_debug_info *scmi_debugfs_common_setup(struct scmi_info *info)
 {
 	char top_dir[16];
-	struct dentry *trans, *top_dentry;
+	struct debugfs_node *trans, *top_dentry;
 	struct scmi_debug_info *dbg;
 	const char *c_ptr = NULL;
 
@@ -3372,9 +3372,9 @@ static struct platform_driver scmi_driver = {
 	.remove = scmi_remove,
 };
 
-static struct dentry *scmi_debugfs_init(void)
+static struct debugfs_node *scmi_debugfs_init(void)
 {
-	struct dentry *d;
+	struct debugfs_node *d;
 
 	d = debugfs_create_dir("scmi", NULL);
 	if (IS_ERR(d)) {
diff --git a/drivers/firmware/arm_scmi/raw_mode.c b/drivers/firmware/arm_scmi/raw_mode.c
index 7cc0d616b8de..bab90ee54e1e 100644
--- a/drivers/firmware/arm_scmi/raw_mode.c
+++ b/drivers/firmware/arm_scmi/raw_mode.c
@@ -185,7 +185,7 @@ struct scmi_raw_mode_info {
 	struct mutex active_mtx;
 	struct work_struct waiters_work;
 	struct workqueue_struct	*wait_wq;
-	struct dentry *dentry;
+	struct debugfs_node *dentry;
 	void *gid;
 };
 
@@ -1161,7 +1161,7 @@ static int scmi_raw_mode_setup(struct scmi_raw_mode_info *raw,
  * Return: An opaque handle to the Raw instance on Success, an ERR_PTR otherwise
  */
 void *scmi_raw_mode_init(const struct scmi_handle *handle,
-			 struct dentry *top_dentry, int instance_id,
+			 struct debugfs_node *top_dentry, int instance_id,
 			 u8 *channels, int num_chans,
 			 const struct scmi_desc *desc, int tx_max_msg)
 {
@@ -1212,13 +1212,13 @@ void *scmi_raw_mode_init(const struct scmi_handle *handle,
 	 */
 	if (num_chans > 1) {
 		int i;
-		struct dentry *top_chans;
+		struct debugfs_node *top_chans;
 
 		top_chans = debugfs_create_dir("channels", raw->dentry);
 
 		for (i = 0; i < num_chans; i++) {
 			char cdir[8];
-			struct dentry *chd;
+			struct debugfs_node *chd;
 
 			snprintf(cdir, 8, "0x%02X", channels[i]);
 			chd = debugfs_create_dir(cdir, top_chans);
diff --git a/drivers/firmware/cirrus/cs_dsp.c b/drivers/firmware/cirrus/cs_dsp.c
index 5365e9a43000..8f647c0e7e82 100644
--- a/drivers/firmware/cirrus/cs_dsp.c
+++ b/drivers/firmware/cirrus/cs_dsp.c
@@ -498,9 +498,10 @@ DEFINE_SHOW_ATTRIBUTE(cs_dsp_debugfs_read_controls);
  * @debugfs_root: pointer to debugfs directory in which to create this DSP
  *                representation
  */
-void cs_dsp_init_debugfs(struct cs_dsp *dsp, struct dentry *debugfs_root)
+void cs_dsp_init_debugfs(struct cs_dsp *dsp,
+			 struct debugfs_node *debugfs_root)
 {
-	struct dentry *root = NULL;
+	struct debugfs_node *root = NULL;
 	int i;
 
 	root = debugfs_create_dir(dsp->name, debugfs_root);
@@ -533,7 +534,8 @@ void cs_dsp_cleanup_debugfs(struct cs_dsp *dsp)
 }
 EXPORT_SYMBOL_NS_GPL(cs_dsp_cleanup_debugfs, "FW_CS_DSP");
 #else
-void cs_dsp_init_debugfs(struct cs_dsp *dsp, struct dentry *debugfs_root)
+void cs_dsp_init_debugfs(struct cs_dsp *dsp,
+			 struct debugfs_node *debugfs_root)
 {
 }
 EXPORT_SYMBOL_NS_GPL(cs_dsp_init_debugfs, "FW_CS_DSP");
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 8296bf985d1d..4c7fe25d6226 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -352,7 +352,7 @@ static struct debugfs_blob_wrapper debugfs_blob[EFI_DEBUGFS_MAX_BLOBS];
 
 static void __init efi_debugfs_init(void)
 {
-	struct dentry *efi_debugfs;
+	struct debugfs_node *efi_debugfs;
 	efi_memory_desc_t *md;
 	char name[32];
 	int type_count[EFI_BOOT_SERVICES_DATA + 1] = {};
diff --git a/drivers/firmware/tegra/bpmp-debugfs.c b/drivers/firmware/tegra/bpmp-debugfs.c
index 4221fed70ad4..0b0e1a49a2b7 100644
--- a/drivers/firmware/tegra/bpmp-debugfs.c
+++ b/drivers/firmware/tegra/bpmp-debugfs.c
@@ -401,12 +401,12 @@ static const struct file_operations bpmp_debug_fops = {
 };
 
 static int bpmp_populate_debugfs_inband(struct tegra_bpmp *bpmp,
-					struct dentry *parent,
+					struct debugfs_node *parent,
 					char *ppath)
 {
 	const size_t pathlen = SZ_256;
 	const size_t bufsize = SZ_16K;
-	struct dentry *dentry;
+	struct debugfs_node *dentry;
 	u32 dsize, attrs = 0;
 	struct seqbuf seqbuf;
 	char *buf, *pathbuf;
@@ -688,12 +688,12 @@ static const struct file_operations debugfs_fops = {
 };
 
 static int bpmp_populate_dir(struct tegra_bpmp *bpmp, struct seqbuf *seqbuf,
-			     struct dentry *parent, u32 depth)
+			     struct debugfs_node *parent, u32 depth)
 {
 	int err;
 	u32 d, t;
 	const char *name;
-	struct dentry *dentry;
+	struct debugfs_node *dentry;
 
 	while (!seqbuf_eof(seqbuf)) {
 		err = seqbuf_read_u32(seqbuf, &d);
@@ -771,7 +771,7 @@ static int bpmp_populate_debugfs_shmem(struct tegra_bpmp *bpmp)
 
 int tegra_bpmp_init_debugfs(struct tegra_bpmp *bpmp)
 {
-	struct dentry *root;
+	struct debugfs_node *root;
 	bool inband;
 	int err;
 
diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 806a975fff22..287c4b223256 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -108,7 +108,7 @@ struct ti_sci_desc {
 struct ti_sci_info {
 	struct device *dev;
 	const struct ti_sci_desc *desc;
-	struct dentry *d;
+	struct debugfs_node *d;
 	void __iomem *debug_region;
 	char *debug_buffer;
 	size_t debug_region_size;
diff --git a/drivers/firmware/turris-mox-rwtm.c b/drivers/firmware/turris-mox-rwtm.c
index 47fe6261f5a3..b24b9c465a75 100644
--- a/drivers/firmware/turris-mox-rwtm.c
+++ b/drivers/firmware/turris-mox-rwtm.c
@@ -414,7 +414,7 @@ static void rwtm_debugfs_release(void *root)
 
 static void rwtm_register_debugfs(struct mox_rwtm *rwtm)
 {
-	struct dentry *root;
+	struct debugfs_node *root;
 
 	root = debugfs_create_dir("turris-mox-rwtm", NULL);
 
diff --git a/drivers/firmware/xilinx/zynqmp-debug.c b/drivers/firmware/xilinx/zynqmp-debug.c
index 22853ae0efdf..54b17e7f0c49 100644
--- a/drivers/firmware/xilinx/zynqmp-debug.c
+++ b/drivers/firmware/xilinx/zynqmp-debug.c
@@ -56,7 +56,7 @@ static struct pm_api_info pm_api_list[] = {
 	PM_API(PM_QUERY_DATA),
 };
 
-static struct dentry *firmware_debugfs_root;
+static struct debugfs_node *firmware_debugfs_root;
 
 /**
  * zynqmp_pm_ioctl - PM IOCTL for device control and configs
diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index d39c6618bade..02e0d013da02 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -54,7 +54,7 @@ struct gpio_mockup_chip {
 	struct gpio_chip gc;
 	struct gpio_mockup_line_status *lines;
 	struct irq_domain *irq_sim_domain;
-	struct dentry *dbg_dir;
+	struct debugfs_node *dbg_dir;
 	struct mutex lock;
 };
 
@@ -71,7 +71,7 @@ static bool gpio_mockup_named_lines;
 module_param_named(gpio_mockup_named_lines,
 		   gpio_mockup_named_lines, bool, 0400);
 
-static struct dentry *gpio_mockup_dbg_dir;
+static struct debugfs_node *gpio_mockup_dbg_dir;
 
 static int gpio_mockup_range_base(unsigned int index)
 {
diff --git a/drivers/gpio/gpio-sloppy-logic-analyzer.c b/drivers/gpio/gpio-sloppy-logic-analyzer.c
index 8cf3b171c599..1c50c0ec14a8 100644
--- a/drivers/gpio/gpio-sloppy-logic-analyzer.c
+++ b/drivers/gpio/gpio-sloppy-logic-analyzer.c
@@ -44,15 +44,15 @@ struct gpio_la_poll_priv {
 	unsigned long delay_ns;
 	unsigned long acq_delay;
 	struct debugfs_blob_wrapper blob;
-	struct dentry *debug_dir;
-	struct dentry *blob_dent;
+	struct debugfs_node *debug_dir;
+	struct debugfs_node *blob_dent;
 	struct debugfs_blob_wrapper meta;
 	struct device *dev;
 	unsigned int trig_len;
 	u8 *trig_data;
 };
 
-static struct dentry *gpio_la_poll_debug_dir;
+static struct debugfs_node *gpio_la_poll_debug_dir;
 
 static __always_inline int gpio_la_get_array(struct gpio_descs *d, unsigned long *sptr)
 {
diff --git a/drivers/gpio/gpio-virtuser.c b/drivers/gpio/gpio-virtuser.c
index e89f299f2140..69eb8f520121 100644
--- a/drivers/gpio/gpio-virtuser.c
+++ b/drivers/gpio/gpio-virtuser.c
@@ -40,14 +40,14 @@
 #define GPIO_VIRTUSER_NAME_BUF_LEN 32
 
 static DEFINE_IDA(gpio_virtuser_ida);
-static struct dentry *gpio_virtuser_dbg_root;
+static struct debugfs_node *gpio_virtuser_dbg_root;
 
 struct gpio_virtuser_attr_data {
 	union {
 		struct gpio_desc *desc;
 		struct gpio_descs *descs;
 	};
-	struct dentry *dbgfs_dir;
+	struct debugfs_node *dbgfs_dir;
 };
 
 struct gpio_virtuser_line_array_data {
@@ -747,9 +747,10 @@ gpio_virtuser_line_dbgfs_attrs[] = {
 
 static int gpio_virtuser_create_debugfs_attrs(
 			const struct gpio_virtuser_dbgfs_attr_descr *attr,
-			size_t num_attrs, struct dentry *parent, void *data)
+			size_t num_attrs, struct debugfs_node *parent,
+			void *data)
 {
-	struct dentry *ret;
+	struct debugfs_node *ret;
 	size_t i;
 
 	for (i = 0; i < num_attrs; i++, attr++) {
@@ -765,7 +766,7 @@ static int gpio_virtuser_create_debugfs_attrs(
 static int gpio_virtuser_dbgfs_init_line_array_attrs(struct device *dev,
 						     struct gpio_descs *descs,
 						     const char *id,
-						     struct dentry *dbgfs_entry)
+						     struct debugfs_node *dbgfs_entry)
 {
 	struct gpio_virtuser_line_array_data *data;
 	char *name;
@@ -794,7 +795,7 @@ static int gpio_virtuser_dbgfs_init_line_attrs(struct device *dev,
 					       struct gpio_desc *desc,
 					       const char *id,
 					       unsigned int index,
-					       struct dentry *dbgfs_entry)
+					       struct debugfs_node *dbgfs_entry)
 {
 	struct gpio_virtuser_line_data *data;
 	char *name;
@@ -829,7 +830,7 @@ static int gpio_virtuser_dbgfs_init_line_attrs(struct device *dev,
 
 static void gpio_virtuser_debugfs_remove(void *data)
 {
-	struct dentry *dbgfs_entry = data;
+	struct debugfs_node *dbgfs_entry = data;
 
 	debugfs_remove_recursive(dbgfs_entry);
 }
@@ -900,7 +901,7 @@ static int gpio_virtuser_get_ids(struct device *dev, const char **ids,
 static int gpio_virtuser_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct dentry *dbgfs_entry;
+	struct debugfs_node *dbgfs_entry;
 	struct gpio_descs *descs;
 	int ret, num_ids = 0, i;
 	const char **ids;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index 9d6345146495..b020cc8c5541 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -902,7 +902,8 @@ static const struct file_operations aca_ue_dump_debug_fops = {
 DEFINE_DEBUGFS_ATTRIBUTE(aca_debug_mode_fops, NULL, amdgpu_aca_smu_debug_mode_set, "%llu\n");
 #endif
 
-void amdgpu_aca_smu_debugfs_init(struct amdgpu_device *adev, struct dentry *root)
+void amdgpu_aca_smu_debugfs_init(struct amdgpu_device *adev,
+				 struct debugfs_node *root)
 {
 #if defined(CONFIG_DEBUG_FS)
 	if (!root)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
index f3289d289913..092e256ddedc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
@@ -210,7 +210,8 @@ int amdgpu_aca_get_error_data(struct amdgpu_device *adev, struct aca_handle *han
 			      enum aca_error_type type, struct ras_err_data *err_data,
 			      struct ras_query_context *qctx);
 int amdgpu_aca_smu_set_debug_mode(struct amdgpu_device *adev, bool en);
-void amdgpu_aca_smu_debugfs_init(struct amdgpu_device *adev, struct dentry *root);
+void amdgpu_aca_smu_debugfs_init(struct amdgpu_device *adev,
+				 struct debugfs_node *root);
 int aca_error_cache_log_bank_error(struct aca_handle *handle, struct aca_bank_info *info,
 				   enum aca_error_type type, u64 count);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 49ca8c814455..70e0c66f7b9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1643,7 +1643,7 @@ static const char * const debugfs_regs_names[] = {
 int amdgpu_debugfs_regs_init(struct amdgpu_device *adev)
 {
 	struct drm_minor *minor = adev_to_drm(adev)->primary;
-	struct dentry *ent, *root = minor->debugfs_root;
+	struct debugfs_node *ent, *root = minor->debugfs_root;
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(debugfs_regs); i++) {
@@ -1651,7 +1651,8 @@ int amdgpu_debugfs_regs_init(struct amdgpu_device *adev)
 					  S_IFREG | 0400, root,
 					  adev, debugfs_regs[i]);
 		if (!i && !IS_ERR_OR_NULL(ent))
-			i_size_write(ent->d_inode, adev->rmmio_size);
+			i_size_write(debugfs_node_inode(ent),
+				     adev->rmmio_size);
 	}
 
 	return 0;
@@ -2028,8 +2029,8 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
 
 int amdgpu_debugfs_init(struct amdgpu_device *adev)
 {
-	struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
-	struct dentry *ent;
+	struct debugfs_node *root = adev_to_drm(adev)->primary->debugfs_root;
+	struct debugfs_node *ent;
 	int r, i;
 
 	if (!debugfs_initialized())
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 2f24a6aa13bf..150226de7972 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -991,7 +991,7 @@ void amdgpu_debugfs_fence_init(struct amdgpu_device *adev)
 {
 #if defined(CONFIG_DEBUG_FS)
 	struct drm_minor *minor = adev_to_drm(adev)->primary;
-	struct dentry *root = minor->debugfs_root;
+	struct debugfs_node *root = minor->debugfs_root;
 
 	debugfs_create_file("amdgpu_fence_info", 0444, root, adev,
 			    &amdgpu_debugfs_fence_info_fops);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 69429df09477..e5ce247990f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -1034,7 +1034,7 @@ void amdgpu_debugfs_gem_init(struct amdgpu_device *adev)
 {
 #if defined(CONFIG_DEBUG_FS)
 	struct drm_minor *minor = adev_to_drm(adev)->primary;
-	struct dentry *root = minor->debugfs_root;
+	struct debugfs_node *root = minor->debugfs_root;
 
 	debugfs_create_file("amdgpu_gem_info", 0444, root, adev,
 			    &amdgpu_debugfs_gem_info_fops);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 784b03abb3a4..ca85263a7f4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2177,7 +2177,7 @@ void amdgpu_debugfs_gfx_sched_mask_init(struct amdgpu_device *adev)
 {
 #if defined(CONFIG_DEBUG_FS)
 	struct drm_minor *minor = adev_to_drm(adev)->primary;
-	struct dentry *root = minor->debugfs_root;
+	struct debugfs_node *root = minor->debugfs_root;
 	char name[32];
 
 	if (!(adev->gfx.num_gfx_rings > 1))
@@ -2248,7 +2248,7 @@ void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev)
 {
 #if defined(CONFIG_DEBUG_FS)
 	struct drm_minor *minor = adev_to_drm(adev)->primary;
-	struct dentry *root = minor->debugfs_root;
+	struct debugfs_node *root = minor->debugfs_root;
 	char name[32];
 
 	if (!(adev->gfx.num_compute_rings > 1))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 2ea98ec60220..0c6b184b31eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -476,7 +476,7 @@ void amdgpu_debugfs_sa_init(struct amdgpu_device *adev)
 {
 #if defined(CONFIG_DEBUG_FS)
 	struct drm_minor *minor = adev_to_drm(adev)->primary;
-	struct dentry *root = minor->debugfs_root;
+	struct debugfs_node *root = minor->debugfs_root;
 
 	debugfs_create_file("amdgpu_sa_info", 0444, root, adev,
 			    &amdgpu_debugfs_sa_info_fops);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index b6d2eb049f54..14ea3f86e405 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -405,7 +405,7 @@ void amdgpu_debugfs_jpeg_sched_mask_init(struct amdgpu_device *adev)
 {
 #if defined(CONFIG_DEBUG_FS)
 	struct drm_minor *minor = adev_to_drm(adev)->primary;
-	struct dentry *root = minor->debugfs_root;
+	struct debugfs_node *root = minor->debugfs_root;
 	char name[32];
 
 	if (!(adev->jpeg.num_jpeg_inst > 1) && !(adev->jpeg.num_jpeg_rings > 1))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 98528ee94c15..0d26782656ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1850,7 +1850,7 @@ void amdgpu_debugfs_firmware_init(struct amdgpu_device *adev)
 {
 #if defined(CONFIG_DEBUG_FS)
 	struct drm_minor *minor = adev_to_drm(adev)->primary;
-	struct dentry *root = minor->debugfs_root;
+	struct debugfs_node *root = minor->debugfs_root;
 
 	debugfs_create_file("amdgpu_firmware_info", 0444, root,
 			    adev, &amdgpu_debugfs_firmware_info_fops);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
index 3ca03b5e0f91..94f4048d5ee0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -616,7 +616,8 @@ static const struct file_operations mca_ue_dump_debug_fops = {
 DEFINE_DEBUGFS_ATTRIBUTE(mca_debug_mode_fops, NULL, amdgpu_mca_smu_debug_mode_set, "%llu\n");
 #endif
 
-void amdgpu_mca_smu_debugfs_init(struct amdgpu_device *adev, struct dentry *root)
+void amdgpu_mca_smu_debugfs_init(struct amdgpu_device *adev,
+				 struct debugfs_node *root)
 {
 #if defined(CONFIG_DEBUG_FS)
 	if (!root)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
index e80323ff90c1..ea50b165b511 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
@@ -162,7 +162,8 @@ int amdgpu_mca_reset(struct amdgpu_device *adev);
 int amdgpu_mca_smu_set_debug_mode(struct amdgpu_device *adev, bool enable);
 int amdgpu_mca_smu_get_mca_set_error_count(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
 					   enum amdgpu_mca_error_type type, uint32_t *total);
-void amdgpu_mca_smu_debugfs_init(struct amdgpu_device *adev, struct dentry *root);
+void amdgpu_mca_smu_debugfs_init(struct amdgpu_device *adev,
+				 struct debugfs_node *root);
 int amdgpu_mca_smu_log_ras_error(struct amdgpu_device *adev, enum amdgpu_ras_block blk, enum amdgpu_mca_error_type type,
 				 struct ras_err_data *err_data, struct ras_query_context *qctx);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 32b27a1658e7..eea1a069cc5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1725,7 +1725,7 @@ void amdgpu_debugfs_mes_event_log_init(struct amdgpu_device *adev)
 
 #if defined(CONFIG_DEBUG_FS)
 	struct drm_minor *minor = adev_to_drm(adev)->primary;
-	struct dentry *root = minor->debugfs_root;
+	struct debugfs_node *root = minor->debugfs_root;
 	if (adev->enable_mes && amdgpu_mes_log_enable)
 		debugfs_create_file("amdgpu_mes_event_log", 0444, root,
 				    adev, &amdgpu_debugfs_mes_event_log_fops);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
index 38face981c3e..fbb0899219f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
@@ -380,7 +380,7 @@ void amdgpu_ta_if_debugfs_init(struct amdgpu_device *adev)
 {
 	struct drm_minor *minor = adev_to_drm(adev)->primary;
 
-	struct dentry *dir = debugfs_create_dir("ta_if", minor->debugfs_root);
+	struct debugfs_node *dir = debugfs_create_dir("ta_if", minor->debugfs_root);
 
 	debugfs_create_file("ta_load", 0200, dir, adev,
 				     &ta_load_debugfs_fops);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index f0924aa3f4e4..a143b2cf08e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1948,12 +1948,12 @@ static int amdgpu_ras_sysfs_remove_all(struct amdgpu_device *adev)
  *
  */
 /* debugfs begin */
-static struct dentry *amdgpu_ras_debugfs_create_ctrl_node(struct amdgpu_device *adev)
+static struct debugfs_node *amdgpu_ras_debugfs_create_ctrl_node(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct amdgpu_ras_eeprom_control *eeprom = &con->eeprom_control;
 	struct drm_minor  *minor = adev_to_drm(adev)->primary;
-	struct dentry     *dir;
+	struct debugfs_node     *dir;
 
 	dir = debugfs_create_dir(RAS_FS_NAME, minor->debugfs_root);
 	debugfs_create_file("ras_ctrl", S_IWUGO | S_IRUGO, dir, adev,
@@ -1993,7 +1993,7 @@ static struct dentry *amdgpu_ras_debugfs_create_ctrl_node(struct amdgpu_device *
 
 static void amdgpu_ras_debugfs_create(struct amdgpu_device *adev,
 				      struct ras_fs_if *head,
-				      struct dentry *dir)
+				      struct debugfs_node *dir)
 {
 	struct ras_manager *obj = amdgpu_ras_find_obj(adev, &head->head);
 
@@ -2031,7 +2031,7 @@ static bool amdgpu_ras_aca_is_supported(struct amdgpu_device *adev)
 void amdgpu_ras_debugfs_create_all(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-	struct dentry *dir;
+	struct debugfs_node *dir;
 	struct ras_manager *obj;
 	struct ras_fs_if fs_info;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 82db986c36a0..7f7d0a8e80f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -507,7 +507,7 @@ struct amdgpu_ras {
 	struct device_attribute schema_attr;
 	struct device_attribute event_state_attr;
 	struct bin_attribute badpages_attr;
-	struct dentry *de_ras_eeprom_table;
+	struct debugfs_node *de_ras_eeprom_table;
 	/* block array */
 	struct ras_manager *objs;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index a6e28fe3f8d6..299d3b52d66b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -622,7 +622,7 @@ void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
 {
 #if defined(CONFIG_DEBUG_FS)
 	struct drm_minor *minor = adev_to_drm(adev)->primary;
-	struct dentry *root = minor->debugfs_root;
+	struct debugfs_node *root = minor->debugfs_root;
 	char name[32];
 
 	sprintf(name, "amdgpu_ring_%s", ring->name);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 174badca27e7..8bc221531589 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -407,7 +407,7 @@ void amdgpu_debugfs_sdma_sched_mask_init(struct amdgpu_device *adev)
 {
 #if defined(CONFIG_DEBUG_FS)
 	struct drm_minor *minor = adev_to_drm(adev)->primary;
-	struct dentry *root = minor->debugfs_root;
+	struct debugfs_node *root = minor->debugfs_root;
 	char name[32];
 
 	if (!(adev->sdma.num_instances > 1))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 01ae2f88dec8..ff028552543e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2619,7 +2619,7 @@ void amdgpu_ttm_debugfs_init(struct amdgpu_device *adev)
 {
 #if defined(CONFIG_DEBUG_FS)
 	struct drm_minor *minor = adev_to_drm(adev)->primary;
-	struct dentry *root = minor->debugfs_root;
+	struct debugfs_node *root = minor->debugfs_root;
 
 	debugfs_create_file_size("amdgpu_vram", 0444, root, adev,
 				 &amdgpu_ttm_vram_fops, adev->gmc.mc_vram_size);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
index dde15c6a96e1..6de6ad7db409 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
@@ -974,7 +974,7 @@ void amdgpu_debugfs_umsch_fwlog_init(struct amdgpu_device *adev,
 {
 #if defined(CONFIG_DEBUG_FS)
 	struct drm_minor *minor = adev_to_drm(adev)->primary;
-	struct dentry *root = minor->debugfs_root;
+	struct debugfs_node *root = minor->debugfs_root;
 	char name[32];
 
 	sprintf(name, "amdgpu_umsch_fwlog");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 83faf6e6788a..4e3de1f43b1e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1167,7 +1167,7 @@ void amdgpu_debugfs_vcn_fwlog_init(struct amdgpu_device *adev, uint8_t i,
 {
 #if defined(CONFIG_DEBUG_FS)
 	struct drm_minor *minor = adev_to_drm(adev)->primary;
-	struct dentry *root = minor->debugfs_root;
+	struct debugfs_node *root = minor->debugfs_root;
 	char name[32];
 
 	sprintf(name, "amdgpu_vcn_%d_fwlog", i);
@@ -1387,7 +1387,7 @@ void amdgpu_debugfs_vcn_sched_mask_init(struct amdgpu_device *adev)
 {
 #if defined(CONFIG_DEBUG_FS)
 	struct drm_minor *minor = adev_to_drm(adev)->primary;
-	struct dentry *root = minor->debugfs_root;
+	struct debugfs_node *root = minor->debugfs_root;
 	char name[32];
 
 	if (adev->vcn.num_vcn_inst <= 1 || !adev->vcn.using_unified_queue)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
index 4a5a0a4e00f2..9f7911f3203c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
@@ -26,7 +26,7 @@
 
 #include "kfd_priv.h"
 
-static struct dentry *debugfs_root;
+static struct debugfs_node *debugfs_root;
 
 static int kfd_debugfs_open(struct inode *inode, struct file *file)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 049046c60462..2e49b5e93a23 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -3488,7 +3488,7 @@ static const struct file_operations edp_ilr_debugfs_fops = {
 void connector_debugfs_init(struct amdgpu_dm_connector *connector)
 {
 	int i;
-	struct dentry *dir = connector->base.debugfs_entry;
+	struct debugfs_node *dir = connector->base.debugfs_entry;
 
 	if (connector->base.connector_type == DRM_MODE_CONNECTOR_DisplayPort ||
 	    connector->base.connector_type == DRM_MODE_CONNECTOR_eDP) {
@@ -3724,7 +3724,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(crc_win_update_fops, crc_win_update_get,
 void crtc_debugfs_init(struct drm_crtc *crtc)
 {
 #ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
-	struct dentry *dir = debugfs_lookup("crc", crtc->debugfs_entry);
+	struct debugfs_node *dir = debugfs_lookup("crc", crtc->debugfs_entry);
 
 	if (!dir)
 		return;
@@ -3739,7 +3739,7 @@ void crtc_debugfs_init(struct drm_crtc *crtc)
 				   &crc_win_y_end_fops);
 	debugfs_create_file_unsafe("crc_win_update", 0644, dir, crtc,
 				   &crc_win_update_fops);
-	dput(dir);
+	debugfs_node_put(dir);
 #endif
 	debugfs_create_file("amdgpu_current_bpc", 0644, crtc->debugfs_entry,
 			    crtc, &amdgpu_current_bpc_fops);
@@ -4193,7 +4193,7 @@ void dtn_debugfs_init(struct amdgpu_device *adev)
 	};
 
 	struct drm_minor *minor = adev_to_drm(adev)->primary;
-	struct dentry *root = minor->debugfs_root;
+	struct debugfs_node *root = minor->debugfs_root;
 
 	debugfs_create_file("amdgpu_mst_topology", 0444, root,
 			    adev, &mst_topo_fops);
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index e8ae7681bf0a..1508977170ae 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -4851,7 +4851,7 @@ void amdgpu_debugfs_pm_init(struct amdgpu_device *adev)
 {
 #if defined(CONFIG_DEBUG_FS)
 	struct drm_minor *minor = adev_to_drm(adev)->primary;
-	struct dentry *root = minor->debugfs_root;
+	struct debugfs_node *root = minor->debugfs_root;
 
 	if (!adev->pm.dpm_enabled)
 		return;
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
index 5b536f0cb548..0d00c1dec0dd 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
@@ -198,7 +198,7 @@ struct komeda_dev {
 	struct iommu_domain *iommu;
 
 	/** @debugfs_root: root directory of komeda debugfs */
-	struct dentry *debugfs_root;
+	struct debugfs_node *debugfs_root;
 	/**
 	 * @err_verbosity: bitmask for how much extra info to print on error
 	 *
diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 88ef76a37fe6..75fa99d85741 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -478,7 +478,7 @@ struct it6505 {
 	struct device *codec_dev;
 	struct delayed_work delayed_audio;
 	struct it6505_audio_data audio;
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 
 	/* it6505 driver hold option */
 	bool enable_drv_hold;
diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
index 6e88339dec0f..d94fcdc67a75 100644
--- a/drivers/gpu/drm/bridge/panel.c
+++ b/drivers/gpu/drm/bridge/panel.c
@@ -197,7 +197,7 @@ static int panel_bridge_get_modes(struct drm_bridge *bridge,
 }
 
 static void panel_bridge_debugfs_init(struct drm_bridge *bridge,
-				      struct dentry *root)
+				      struct debugfs_node *root)
 {
 	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
 	struct drm_panel *panel = panel_bridge->panel;
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
index 0fb02e4e7f4e..5b784216cbae 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
@@ -256,7 +256,7 @@ struct dw_mipi_dsi {
 	unsigned long mode_flags;
 
 #ifdef CONFIG_DEBUG_FS
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 	struct debugfs_entries *debugfs_vpg;
 	struct {
 		bool vpg;
diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index e4d9006b59f1..47407de88295 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -435,7 +435,7 @@ static void ti_sn65dsi86_debugfs_remove(void *data)
 static void ti_sn65dsi86_debugfs_init(struct ti_sn65dsi86 *pdata)
 {
 	struct device *dev = pdata->dev;
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 	int ret;
 
 	debugfs = debugfs_create_dir(dev_name(dev), NULL);
diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 56f977bbe62d..e08401c1202b 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -220,7 +220,7 @@ static void drm_bridge_connector_force(struct drm_connector *connector)
 }
 
 static void drm_bridge_connector_debugfs_init(struct drm_connector *connector,
-					      struct dentry *root)
+					      struct debugfs_node *root)
 {
 	struct drm_bridge_connector *bridge_connector =
 		to_drm_bridge_connector(connector);
diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
index 536409a35df4..a5ee622f90d7 100644
--- a/drivers/gpu/drm/drm_debugfs.c
+++ b/drivers/gpu/drm/drm_debugfs.c
@@ -242,7 +242,8 @@ EXPORT_SYMBOL(drm_debugfs_gpuva_info);
  * automatically on drm_debugfs_dev_fini().
  */
 void drm_debugfs_create_files(const struct drm_info_list *files, int count,
-			      struct dentry *root, struct drm_minor *minor)
+			      struct debugfs_node *root,
+			      struct drm_minor *minor)
 {
 	struct drm_device *dev = minor->dev;
 	struct drm_info_node *tmp;
@@ -268,17 +269,18 @@ void drm_debugfs_create_files(const struct drm_info_list *files, int count,
 EXPORT_SYMBOL(drm_debugfs_create_files);
 
 int drm_debugfs_remove_files(const struct drm_info_list *files, int count,
-			     struct dentry *root, struct drm_minor *minor)
+			     struct debugfs_node *root,
+			     struct drm_minor *minor)
 {
 	int i;
 
 	for (i = 0; i < count; i++) {
-		struct dentry *dent = debugfs_lookup(files[i].name, root);
+		struct debugfs_node *dent = debugfs_lookup(files[i].name, root);
 
 		if (!dent)
 			continue;
 
-		drmm_kfree(minor->dev, d_inode(dent)->i_private);
+		drmm_kfree(minor->dev, debugfs_node_inode(dent)->i_private);
 		debugfs_remove(dent);
 	}
 	return 0;
@@ -292,7 +294,7 @@ EXPORT_SYMBOL(drm_debugfs_remove_files);
  *
  * Creates the debugfs directory for the device under the given root directory.
  */
-void drm_debugfs_dev_init(struct drm_device *dev, struct dentry *root)
+void drm_debugfs_dev_init(struct drm_device *dev, struct debugfs_node *root)
 {
 	dev->debugfs_root = debugfs_create_dir(dev->unique, root);
 }
@@ -322,7 +324,7 @@ void drm_debugfs_dev_register(struct drm_device *dev)
 }
 
 int drm_debugfs_register(struct drm_minor *minor, int minor_id,
-			 struct dentry *root)
+			 struct debugfs_node *root)
 {
 	struct drm_device *dev = minor->dev;
 	char name[64];
@@ -560,9 +562,9 @@ static const struct file_operations audio_infoframe_fops = {
 };
 
 static int create_hdmi_audio_infoframe_file(struct drm_connector *connector,
-					    struct dentry *parent)
+					    struct debugfs_node *parent)
 {
-	struct dentry *file;
+	struct debugfs_node *file;
 
 	file = debugfs_create_file("audio", 0400, parent, connector, &audio_infoframe_fops);
 	if (IS_ERR(file))
@@ -631,7 +633,7 @@ DEFINE_INFOFRAME_FILE(hdr_drm);
 DEFINE_INFOFRAME_FILE(spd);
 
 static int create_hdmi_infoframe_files(struct drm_connector *connector,
-				       struct dentry *parent)
+				       struct debugfs_node *parent)
 {
 	int ret;
 
@@ -660,7 +662,7 @@ static int create_hdmi_infoframe_files(struct drm_connector *connector,
 
 static void hdmi_debugfs_add(struct drm_connector *connector)
 {
-	struct dentry *dir;
+	struct debugfs_node *dir;
 
 	if (!(connector->connector_type == DRM_MODE_CONNECTOR_HDMIA ||
 	      connector->connector_type == DRM_MODE_CONNECTOR_HDMIB))
@@ -676,7 +678,7 @@ static void hdmi_debugfs_add(struct drm_connector *connector)
 void drm_debugfs_connector_add(struct drm_connector *connector)
 {
 	struct drm_device *dev = connector->dev;
-	struct dentry *root;
+	struct debugfs_node *root;
 
 	if (!dev->debugfs_root)
 		return;
@@ -719,7 +721,7 @@ void drm_debugfs_connector_remove(struct drm_connector *connector)
 void drm_debugfs_crtc_add(struct drm_crtc *crtc)
 {
 	struct drm_device *dev = crtc->dev;
-	struct dentry *root;
+	struct debugfs_node *root;
 	char *name;
 
 	name = kasprintf(GFP_KERNEL, "crtc-%d", crtc->index);
@@ -777,7 +779,7 @@ DEFINE_SHOW_ATTRIBUTE(bridges);
 void drm_debugfs_encoder_add(struct drm_encoder *encoder)
 {
 	struct drm_minor *minor = encoder->dev->primary;
-	struct dentry *root;
+	struct debugfs_node *root;
 	char *name;
 
 	name = kasprintf(GFP_KERNEL, "encoder-%d", encoder->index);
diff --git a/drivers/gpu/drm/drm_debugfs_crc.c b/drivers/gpu/drm/drm_debugfs_crc.c
index bbc3bc4ba844..d754a12d2fbf 100644
--- a/drivers/gpu/drm/drm_debugfs_crc.c
+++ b/drivers/gpu/drm/drm_debugfs_crc.c
@@ -367,7 +367,7 @@ static const struct file_operations drm_crtc_crc_data_fops = {
 
 void drm_debugfs_crtc_crc_add(struct drm_crtc *crtc)
 {
-	struct dentry *crc_ent;
+	struct debugfs_node *crc_ent;
 
 	if (!crtc->funcs->set_crc_source || !crtc->funcs->verify_crc_source)
 		return;
diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 3cf440eee8a2..91400d84fadb 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -67,7 +67,7 @@ DEFINE_XARRAY_ALLOC(drm_minors_xa);
  */
 static bool drm_core_init_complete;
 
-static struct dentry *drm_debugfs_root;
+static struct debugfs_node *drm_debugfs_root;
 
 DEFINE_STATIC_SRCU(drm_unplug_srcu);
 
diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_internal.h
index b2b6a8e49dda..087950b52596 100644
--- a/drivers/gpu/drm/drm_internal.h
+++ b/drivers/gpu/drm/drm_internal.h
@@ -36,6 +36,7 @@
 #define DRM_IF_VERSION(maj, min) (maj << 16 | min)
 
 struct dentry;
+#define debugfs_node dentry
 struct dma_buf;
 struct iosys_map;
 struct drm_connector;
@@ -187,7 +188,7 @@ void drm_gem_vunmap(struct drm_gem_object *obj, struct iosys_map *map);
 void drm_debugfs_dev_fini(struct drm_device *dev);
 void drm_debugfs_dev_register(struct drm_device *dev);
 int drm_debugfs_register(struct drm_minor *minor, int minor_id,
-			 struct dentry *root);
+			 struct debugfs_node *root);
 void drm_debugfs_unregister(struct drm_minor *minor);
 void drm_debugfs_connector_add(struct drm_connector *connector);
 void drm_debugfs_connector_remove(struct drm_connector *connector);
@@ -206,7 +207,7 @@ static inline void drm_debugfs_dev_register(struct drm_device *dev)
 }
 
 static inline int drm_debugfs_register(struct drm_minor *minor, int minor_id,
-				       struct dentry *root)
+				       struct debugfs_node *root)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/i915/display/intel_alpm.c
index 55f3ae1e68c9..734e3fa4aa93 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.c
+++ b/drivers/gpu/drm/i915/display/intel_alpm.c
@@ -406,7 +406,7 @@ DEFINE_SHOW_ATTRIBUTE(i915_edp_lobf_info);
 void intel_alpm_lobf_debugfs_add(struct intel_connector *connector)
 {
 	struct intel_display *display = to_intel_display(connector);
-	struct dentry *root = connector->base.debugfs_entry;
+	struct debugfs_node *root = connector->base.debugfs_entry;
 
 	if (DISPLAY_VER(display) < 20 ||
 	    connector->base.connector_type != DRM_MODE_CONNECTOR_eDP)
diff --git a/drivers/gpu/drm/i915/display/intel_display_debugfs.c b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
index f1d76484025a..f7bdc3a64f3f 100644
--- a/drivers/gpu/drm/i915/display/intel_display_debugfs.c
+++ b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
@@ -1393,7 +1393,7 @@ static const struct file_operations i915_joiner_fops = {
 void intel_connector_debugfs_add(struct intel_connector *connector)
 {
 	struct drm_i915_private *i915 = to_i915(connector->base.dev);
-	struct dentry *root = connector->base.debugfs_entry;
+	struct debugfs_node *root = connector->base.debugfs_entry;
 	int connector_type = connector->base.connector_type;
 
 	/* The connector must have been registered beforehands. */
@@ -1453,7 +1453,7 @@ void intel_connector_debugfs_add(struct intel_connector *connector)
  */
 void intel_crtc_debugfs_add(struct intel_crtc *crtc)
 {
-	struct dentry *root = crtc->base.debugfs_entry;
+	struct debugfs_node *root = crtc->base.debugfs_entry;
 
 	if (!root)
 		return;
diff --git a/drivers/gpu/drm/i915/display/intel_display_debugfs_params.c b/drivers/gpu/drm/i915/display/intel_display_debugfs_params.c
index 88914a1f3f62..2d65d5a85836 100644
--- a/drivers/gpu/drm/i915/display/intel_display_debugfs_params.c
+++ b/drivers/gpu/drm/i915/display/intel_display_debugfs_params.c
@@ -121,18 +121,18 @@ static const struct file_operations intel_display_param_uint_fops_ro = {
 
 #define RO(mode) (((mode) & 0222) == 0)
 
-__maybe_unused static struct dentry *
+__maybe_unused static struct debugfs_node *
 intel_display_debugfs_create_int(const char *name, umode_t mode,
-			struct dentry *parent, int *value)
+			struct debugfs_node *parent, int *value)
 {
 	return debugfs_create_file_unsafe(name, mode, parent, value,
 					  RO(mode) ? &intel_display_param_int_fops_ro :
 					  &intel_display_param_int_fops);
 }
 
-__maybe_unused static struct dentry *
+__maybe_unused static struct debugfs_node *
 intel_display_debugfs_create_uint(const char *name, umode_t mode,
-			 struct dentry *parent, unsigned int *value)
+			 struct debugfs_node *parent, unsigned int *value)
 {
 	return debugfs_create_file_unsafe(name, mode, parent, value,
 					  RO(mode) ? &intel_display_param_uint_fops_ro :
@@ -155,7 +155,7 @@ intel_display_debugfs_create_uint(const char *name, umode_t mode,
 void intel_display_debugfs_params(struct intel_display *display)
 {
 	struct drm_minor *minor = display->drm->primary;
-	struct dentry *dir;
+	struct debugfs_node *dir;
 	char dirname[16];
 
 	snprintf(dirname, sizeof(dirname), "%s_params", display->drm->driver->name);
diff --git a/drivers/gpu/drm/i915/display/intel_dp_link_training.c b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
index 8b1977cfec50..69150e9d5357 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_link_training.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
@@ -2021,7 +2021,7 @@ DEFINE_SHOW_ATTRIBUTE(i915_dp_link_retrain_disabled);
 
 void intel_dp_link_training_debugfs_add(struct intel_connector *connector)
 {
-	struct dentry *root = connector->base.debugfs_entry;
+	struct debugfs_node *root = connector->base.debugfs_entry;
 
 	if (connector->base.connector_type != DRM_MODE_CONNECTOR_DisplayPort &&
 	    connector->base.connector_type != DRM_MODE_CONNECTOR_eDP)
diff --git a/drivers/gpu/drm/i915/display/intel_fbc.c b/drivers/gpu/drm/i915/display/intel_fbc.c
index df05904bac8a..bce41f39cade 100644
--- a/drivers/gpu/drm/i915/display/intel_fbc.c
+++ b/drivers/gpu/drm/i915/display/intel_fbc.c
@@ -2059,7 +2059,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(intel_fbc_debugfs_false_color_fops,
 			 "%llu\n");
 
 static void intel_fbc_debugfs_add(struct intel_fbc *fbc,
-				  struct dentry *parent)
+				  struct debugfs_node *parent)
 {
 	debugfs_create_file("i915_fbc_status", 0444, parent,
 			    fbc, &intel_fbc_debugfs_status_fops);
diff --git a/drivers/gpu/drm/i915/display/intel_pps.c b/drivers/gpu/drm/i915/display/intel_pps.c
index eb35f0249f2b..07c016a5365a 100644
--- a/drivers/gpu/drm/i915/display/intel_pps.c
+++ b/drivers/gpu/drm/i915/display/intel_pps.c
@@ -1833,7 +1833,7 @@ DEFINE_SHOW_ATTRIBUTE(intel_pps);
 
 void intel_pps_connector_debugfs_add(struct intel_connector *connector)
 {
-	struct dentry *root = connector->base.debugfs_entry;
+	struct debugfs_node *root = connector->base.debugfs_entry;
 	int connector_type = connector->base.connector_type;
 
 	if (connector_type == DRM_MODE_CONNECTOR_eDP)
diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 0b021acb330f..77bca029d467 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -3971,7 +3971,7 @@ DEFINE_SHOW_ATTRIBUTE(i915_psr_status);
 void intel_psr_connector_debugfs_add(struct intel_connector *connector)
 {
 	struct intel_display *display = to_intel_display(connector);
-	struct dentry *root = connector->base.debugfs_entry;
+	struct debugfs_node *root = connector->base.debugfs_entry;
 
 	if (connector->base.connector_type != DRM_MODE_CONNECTOR_eDP &&
 	    connector->base.connector_type != DRM_MODE_CONNECTOR_DisplayPort)
diff --git a/drivers/gpu/drm/i915/gt/intel_gt_debugfs.c b/drivers/gpu/drm/i915/gt/intel_gt_debugfs.c
index 4dc23b8d3aa2..245a63568a8a 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_debugfs.c
+++ b/drivers/gpu/drm/i915/gt/intel_gt_debugfs.c
@@ -70,7 +70,8 @@ static int steering_show(struct seq_file *m, void *data)
 }
 DEFINE_INTEL_GT_DEBUGFS_ATTRIBUTE(steering);
 
-static void gt_debugfs_register(struct intel_gt *gt, struct dentry *root)
+static void gt_debugfs_register(struct intel_gt *gt,
+				struct debugfs_node *root)
 {
 	static const struct intel_gt_debugfs_file files[] = {
 		{ "reset", &reset_fops, NULL },
@@ -82,7 +83,7 @@ static void gt_debugfs_register(struct intel_gt *gt, struct dentry *root)
 
 void intel_gt_debugfs_register(struct intel_gt *gt)
 {
-	struct dentry *root;
+	struct debugfs_node *root;
 	char gtname[4];
 
 	if (!gt->i915->drm.primary->debugfs_root)
@@ -102,7 +103,7 @@ void intel_gt_debugfs_register(struct intel_gt *gt)
 	intel_uc_debugfs_register(&gt->uc, root);
 }
 
-void intel_gt_debugfs_register_files(struct dentry *root,
+void intel_gt_debugfs_register_files(struct debugfs_node *root,
 				     const struct intel_gt_debugfs_file *files,
 				     unsigned long count, void *data)
 {
diff --git a/drivers/gpu/drm/i915/gt/intel_gt_debugfs.h b/drivers/gpu/drm/i915/gt/intel_gt_debugfs.h
index e4110eebf093..82475823a7e4 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_debugfs.h
+++ b/drivers/gpu/drm/i915/gt/intel_gt_debugfs.h
@@ -42,7 +42,7 @@ struct intel_gt_debugfs_file {
 	bool (*eval)(void *data);
 };
 
-void intel_gt_debugfs_register_files(struct dentry *root,
+void intel_gt_debugfs_register_files(struct debugfs_node *root,
 				     const struct intel_gt_debugfs_file *files,
 				     unsigned long count, void *data);
 
diff --git a/drivers/gpu/drm/i915/gt/intel_gt_engines_debugfs.c b/drivers/gpu/drm/i915/gt/intel_gt_engines_debugfs.c
index 3aa1d014c14d..b9a1bba36342 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_engines_debugfs.c
+++ b/drivers/gpu/drm/i915/gt/intel_gt_engines_debugfs.c
@@ -26,7 +26,8 @@ static int engines_show(struct seq_file *m, void *data)
 }
 DEFINE_INTEL_GT_DEBUGFS_ATTRIBUTE(engines);
 
-void intel_gt_engines_debugfs_register(struct intel_gt *gt, struct dentry *root)
+void intel_gt_engines_debugfs_register(struct intel_gt *gt,
+				       struct debugfs_node *root)
 {
 	static const struct intel_gt_debugfs_file files[] = {
 		{ "engines", &engines_fops },
diff --git a/drivers/gpu/drm/i915/gt/intel_gt_engines_debugfs.h b/drivers/gpu/drm/i915/gt/intel_gt_engines_debugfs.h
index dda113452da9..1347d896d7a3 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_engines_debugfs.h
+++ b/drivers/gpu/drm/i915/gt/intel_gt_engines_debugfs.h
@@ -8,7 +8,9 @@
 
 struct intel_gt;
 struct dentry;
+#define debugfs_node dentry
 
-void intel_gt_engines_debugfs_register(struct intel_gt *gt, struct dentry *root);
+void intel_gt_engines_debugfs_register(struct intel_gt *gt,
+				       struct debugfs_node *root);
 
 #endif /* INTEL_GT_ENGINES_DEBUGFS_H */
diff --git a/drivers/gpu/drm/i915/gt/intel_gt_pm_debugfs.c b/drivers/gpu/drm/i915/gt/intel_gt_pm_debugfs.c
index b635aa2820d9..33a9734c7ab3 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_pm_debugfs.c
+++ b/drivers/gpu/drm/i915/gt/intel_gt_pm_debugfs.c
@@ -583,7 +583,8 @@ static bool perf_limit_reasons_eval(void *data)
 DEFINE_SIMPLE_ATTRIBUTE(perf_limit_reasons_fops, perf_limit_reasons_get,
 			perf_limit_reasons_clear, "0x%llx\n");
 
-void intel_gt_pm_debugfs_register(struct intel_gt *gt, struct dentry *root)
+void intel_gt_pm_debugfs_register(struct intel_gt *gt,
+				  struct debugfs_node *root)
 {
 	static const struct intel_gt_debugfs_file files[] = {
 		{ "drpc", &drpc_fops, NULL },
diff --git a/drivers/gpu/drm/i915/gt/intel_gt_pm_debugfs.h b/drivers/gpu/drm/i915/gt/intel_gt_pm_debugfs.h
index 0ace8c2da0ac..c34d595bba56 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_pm_debugfs.h
+++ b/drivers/gpu/drm/i915/gt/intel_gt_pm_debugfs.h
@@ -8,9 +8,11 @@
 
 struct intel_gt;
 struct dentry;
+#define debugfs_node dentry
 struct drm_printer;
 
-void intel_gt_pm_debugfs_register(struct intel_gt *gt, struct dentry *root);
+void intel_gt_pm_debugfs_register(struct intel_gt *gt,
+				  struct debugfs_node *root);
 void intel_gt_pm_frequency_dump(struct intel_gt *gt, struct drm_printer *m);
 
 /* functions that need to be accessed by the upper level non-gt interfaces */
diff --git a/drivers/gpu/drm/i915/gt/intel_sseu_debugfs.c b/drivers/gpu/drm/i915/gt/intel_sseu_debugfs.c
index c2ee5e1826b5..15cdc42365b9 100644
--- a/drivers/gpu/drm/i915/gt/intel_sseu_debugfs.c
+++ b/drivers/gpu/drm/i915/gt/intel_sseu_debugfs.c
@@ -288,7 +288,8 @@ static int sseu_topology_show(struct seq_file *m, void *unused)
 }
 DEFINE_INTEL_GT_DEBUGFS_ATTRIBUTE(sseu_topology);
 
-void intel_sseu_debugfs_register(struct intel_gt *gt, struct dentry *root)
+void intel_sseu_debugfs_register(struct intel_gt *gt,
+				 struct debugfs_node *root)
 {
 	static const struct intel_gt_debugfs_file files[] = {
 		{ "sseu_status", &sseu_status_fops, NULL },
diff --git a/drivers/gpu/drm/i915/gt/intel_sseu_debugfs.h b/drivers/gpu/drm/i915/gt/intel_sseu_debugfs.h
index 73f001589e90..8eb79cb148b3 100644
--- a/drivers/gpu/drm/i915/gt/intel_sseu_debugfs.h
+++ b/drivers/gpu/drm/i915/gt/intel_sseu_debugfs.h
@@ -9,9 +9,11 @@
 
 struct intel_gt;
 struct dentry;
+#define debugfs_node dentry
 struct seq_file;
 
 int intel_sseu_status(struct seq_file *m, struct intel_gt *gt);
-void intel_sseu_debugfs_register(struct intel_gt *gt, struct dentry *root);
+void intel_sseu_debugfs_register(struct intel_gt *gt,
+				 struct debugfs_node *root);
 
 #endif /* INTEL_SSEU_DEBUGFS_H */
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_gsc_uc_debugfs.c b/drivers/gpu/drm/i915/gt/uc/intel_gsc_uc_debugfs.c
index 5baacd822a1c..c3f0b1f5cd8a 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_gsc_uc_debugfs.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_gsc_uc_debugfs.c
@@ -26,7 +26,8 @@ static int gsc_info_show(struct seq_file *m, void *data)
 }
 DEFINE_INTEL_GT_DEBUGFS_ATTRIBUTE(gsc_info);
 
-void intel_gsc_uc_debugfs_register(struct intel_gsc_uc *gsc_uc, struct dentry *root)
+void intel_gsc_uc_debugfs_register(struct intel_gsc_uc *gsc_uc,
+				   struct debugfs_node *root)
 {
 	static const struct intel_gt_debugfs_file files[] = {
 		{ "gsc_info", &gsc_info_fops, NULL },
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_gsc_uc_debugfs.h b/drivers/gpu/drm/i915/gt/uc/intel_gsc_uc_debugfs.h
index 3415ad39aabb..f5678acf77c3 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_gsc_uc_debugfs.h
+++ b/drivers/gpu/drm/i915/gt/uc/intel_gsc_uc_debugfs.h
@@ -8,7 +8,9 @@
 
 struct intel_gsc_uc;
 struct dentry;
+#define debugfs_node dentry
 
-void intel_gsc_uc_debugfs_register(struct intel_gsc_uc *gsc, struct dentry *root);
+void intel_gsc_uc_debugfs_register(struct intel_gsc_uc *gsc,
+				   struct debugfs_node *root);
 
 #endif /* DEBUGFS_GSC_UC_H */
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc.h b/drivers/gpu/drm/i915/gt/uc/intel_guc.h
index 57b903132776..9dd41356a344 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc.h
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc.h
@@ -43,7 +43,7 @@ struct intel_guc {
 	struct intel_guc_state_capture *capture;
 
 	/** @dbgfs_node: debugfs node */
-	struct dentry *dbgfs_node;
+	struct debugfs_node *dbgfs_node;
 
 	/** @sched_engine: Global engine used to submit requests to GuC */
 	struct i915_sched_engine *sched_engine;
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_debugfs.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_debugfs.c
index 7269eb0bbedf..3858a48755e3 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc_debugfs.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_debugfs.c
@@ -129,7 +129,8 @@ DEFINE_SIMPLE_ATTRIBUTE(guc_sched_disable_gucid_threshold_fops,
 			guc_sched_disable_gucid_threshold_get,
 			guc_sched_disable_gucid_threshold_set, "%lld\n");
 
-void intel_guc_debugfs_register(struct intel_guc *guc, struct dentry *root)
+void intel_guc_debugfs_register(struct intel_guc *guc,
+				struct debugfs_node *root)
 {
 	static const struct intel_gt_debugfs_file files[] = {
 		{ "guc_info", &guc_info_fops, NULL },
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_debugfs.h b/drivers/gpu/drm/i915/gt/uc/intel_guc_debugfs.h
index 424c26665cf1..c9a5ea91a43b 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc_debugfs.h
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_debugfs.h
@@ -8,7 +8,9 @@
 
 struct intel_guc;
 struct dentry;
+#define debugfs_node dentry
 
-void intel_guc_debugfs_register(struct intel_guc *guc, struct dentry *root);
+void intel_guc_debugfs_register(struct intel_guc *guc,
+				struct debugfs_node *root);
 
 #endif /* DEBUGFS_GUC_H */
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_log.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_log.c
index e8a04e476c57..84f8f4b3a14c 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc_log.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_log.c
@@ -242,13 +242,13 @@ static int subbuf_start_callback(struct rchan_buf *buf,
 /*
  * file_create() callback. Creates relay file in debugfs.
  */
-static struct dentry *create_buf_file_callback(const char *filename,
-					       struct dentry *parent,
+static struct debugfs_node *create_buf_file_callback(const char *filename,
+					       struct debugfs_node *parent,
 					       umode_t mode,
 					       struct rchan_buf *buf,
 					       int *is_global)
 {
-	struct dentry *buf_file;
+	struct debugfs_node *buf_file;
 
 	/*
 	 * This to enable the use of a single buffer for the relay channel and
@@ -272,7 +272,7 @@ static struct dentry *create_buf_file_callback(const char *filename,
 /*
  * file_remove() default callback. Removes relay file in debugfs.
  */
-static int remove_buf_file_callback(struct dentry *dentry)
+static int remove_buf_file_callback(struct debugfs_node *dentry)
 {
 	debugfs_remove(dentry);
 	return 0;
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_log_debugfs.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_log_debugfs.c
index ddfbe334689f..1d50ac53b965 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc_log_debugfs.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_log_debugfs.c
@@ -159,7 +159,7 @@ static const struct file_operations guc_log_relay_fops = {
 };
 
 void intel_guc_log_debugfs_register(struct intel_guc_log *log,
-				    struct dentry *root)
+				    struct debugfs_node *root)
 {
 	static const struct intel_gt_debugfs_file files[] = {
 		{ "guc_log_dump", &guc_log_dump_fops, NULL },
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_log_debugfs.h b/drivers/gpu/drm/i915/gt/uc/intel_guc_log_debugfs.h
index e8900e3d74ea..44c81d40e692 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc_log_debugfs.h
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_log_debugfs.h
@@ -8,8 +8,9 @@
 
 struct intel_guc_log;
 struct dentry;
+#define debugfs_node dentry
 
 void intel_guc_log_debugfs_register(struct intel_guc_log *log,
-				    struct dentry *root);
+				    struct debugfs_node *root);
 
 #endif /* DEBUGFS_GUC_LOG_H */
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_huc_debugfs.c b/drivers/gpu/drm/i915/gt/uc/intel_huc_debugfs.c
index 15998963b863..0fab388b3b75 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_huc_debugfs.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_huc_debugfs.c
@@ -23,7 +23,8 @@ static int huc_info_show(struct seq_file *m, void *data)
 }
 DEFINE_INTEL_GT_DEBUGFS_ATTRIBUTE(huc_info);
 
-void intel_huc_debugfs_register(struct intel_huc *huc, struct dentry *root)
+void intel_huc_debugfs_register(struct intel_huc *huc,
+				struct debugfs_node *root)
 {
 	static const struct intel_gt_debugfs_file files[] = {
 		{ "huc_info", &huc_info_fops, NULL },
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_huc_debugfs.h b/drivers/gpu/drm/i915/gt/uc/intel_huc_debugfs.h
index be79e992f976..3120bc60e1aa 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_huc_debugfs.h
+++ b/drivers/gpu/drm/i915/gt/uc/intel_huc_debugfs.h
@@ -8,7 +8,9 @@
 
 struct intel_huc;
 struct dentry;
+#define debugfs_node dentry
 
-void intel_huc_debugfs_register(struct intel_huc *huc, struct dentry *root);
+void intel_huc_debugfs_register(struct intel_huc *huc,
+				struct debugfs_node *root);
 
 #endif /* DEBUGFS_HUC_H */
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_uc_debugfs.c b/drivers/gpu/drm/i915/gt/uc/intel_uc_debugfs.c
index 6d541c866edb..1ab1e56c519c 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_uc_debugfs.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_uc_debugfs.c
@@ -37,12 +37,13 @@ static int uc_usage_show(struct seq_file *m, void *data)
 }
 DEFINE_INTEL_GT_DEBUGFS_ATTRIBUTE(uc_usage);
 
-void intel_uc_debugfs_register(struct intel_uc *uc, struct dentry *gt_root)
+void intel_uc_debugfs_register(struct intel_uc *uc,
+			       struct debugfs_node *gt_root)
 {
 	static const struct intel_gt_debugfs_file files[] = {
 		{ "usage", &uc_usage_fops, NULL },
 	};
-	struct dentry *root;
+	struct debugfs_node *root;
 
 	if (!gt_root)
 		return;
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_uc_debugfs.h b/drivers/gpu/drm/i915/gt/uc/intel_uc_debugfs.h
index 010ce250d223..b6d56a1d1b77 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_uc_debugfs.h
+++ b/drivers/gpu/drm/i915/gt/uc/intel_uc_debugfs.h
@@ -8,7 +8,9 @@
 
 struct intel_uc;
 struct dentry;
+#define debugfs_node dentry
 
-void intel_uc_debugfs_register(struct intel_uc *uc, struct dentry *gt_root);
+void intel_uc_debugfs_register(struct intel_uc *uc,
+			       struct debugfs_node *gt_root);
 
 #endif /* DEBUGFS_UC_H */
diff --git a/drivers/gpu/drm/i915/gvt/gvt.h b/drivers/gpu/drm/i915/gvt/gvt.h
index 2c95aeef4e41..81481a55faf0 100644
--- a/drivers/gpu/drm/i915/gvt/gvt.h
+++ b/drivers/gpu/drm/i915/gvt/gvt.h
@@ -210,7 +210,7 @@ struct intel_vgpu {
 	/* Set on PCI_D3, reset on DMLR, not reflecting the actual PM state */
 	bool d3_entered;
 
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 
 	struct list_head dmabuf_obj_list_head;
 	struct mutex dmabuf_lock;
@@ -363,7 +363,7 @@ struct intel_gvt {
 	} engine_mmio_list;
 	bool is_reg_whitelist_updated;
 
-	struct dentry *debugfs_root;
+	struct debugfs_node *debugfs_root;
 };
 
 enum {
diff --git a/drivers/gpu/drm/i915/i915_debugfs_params.c b/drivers/gpu/drm/i915/i915_debugfs_params.c
index 33d2dcb0de65..e71d3917bdd0 100644
--- a/drivers/gpu/drm/i915/i915_debugfs_params.c
+++ b/drivers/gpu/drm/i915/i915_debugfs_params.c
@@ -207,27 +207,27 @@ static const struct file_operations i915_param_charp_fops_ro = {
 
 #define RO(mode) (((mode) & 0222) == 0)
 
-static struct dentry *
+static struct debugfs_node *
 i915_debugfs_create_int(const char *name, umode_t mode,
-			struct dentry *parent, int *value)
+			struct debugfs_node *parent, int *value)
 {
 	return debugfs_create_file_unsafe(name, mode, parent, value,
 					  RO(mode) ? &i915_param_int_fops_ro :
 					  &i915_param_int_fops);
 }
 
-static struct dentry *
+static struct debugfs_node *
 i915_debugfs_create_uint(const char *name, umode_t mode,
-			 struct dentry *parent, unsigned int *value)
+			 struct debugfs_node *parent, unsigned int *value)
 {
 	return debugfs_create_file_unsafe(name, mode, parent, value,
 					  RO(mode) ? &i915_param_uint_fops_ro :
 					  &i915_param_uint_fops);
 }
 
-static struct dentry *
+static struct debugfs_node *
 i915_debugfs_create_charp(const char *name, umode_t mode,
-			  struct dentry *parent, char **value)
+			  struct debugfs_node *parent, char **value)
 {
 	return debugfs_create_file(name, mode, parent, value,
 				   RO(mode) ? &i915_param_charp_fops_ro :
@@ -246,11 +246,11 @@ i915_debugfs_create_charp(const char *name, umode_t mode,
 	} while(0)
 
 /* add a subdirectory with files for each i915 param */
-struct dentry *i915_debugfs_params(struct drm_i915_private *i915)
+struct debugfs_node *i915_debugfs_params(struct drm_i915_private *i915)
 {
 	struct drm_minor *minor = i915->drm.primary;
 	struct i915_params *params = &i915->params;
-	struct dentry *dir;
+	struct debugfs_node *dir;
 
 	dir = debugfs_create_dir("i915_params", minor->debugfs_root);
 	if (IS_ERR(dir))
diff --git a/drivers/gpu/drm/i915/i915_debugfs_params.h b/drivers/gpu/drm/i915/i915_debugfs_params.h
index 66567076546b..a64cf27ece5d 100644
--- a/drivers/gpu/drm/i915/i915_debugfs_params.h
+++ b/drivers/gpu/drm/i915/i915_debugfs_params.h
@@ -7,8 +7,9 @@
 #define __I915_DEBUGFS_PARAMS__
 
 struct dentry;
+#define debugfs_node dentry
 struct drm_i915_private;
 
-struct dentry *i915_debugfs_params(struct drm_i915_private *i915);
+struct debugfs_node *i915_debugfs_params(struct drm_i915_private *i915);
 
 #endif /* __I915_DEBUGFS_PARAMS__ */
diff --git a/drivers/gpu/drm/i915/pxp/intel_pxp_debugfs.c b/drivers/gpu/drm/i915/pxp/intel_pxp_debugfs.c
index e07c5b380789..b2dcdc4061dd 100644
--- a/drivers/gpu/drm/i915/pxp/intel_pxp_debugfs.c
+++ b/drivers/gpu/drm/i915/pxp/intel_pxp_debugfs.c
@@ -70,7 +70,7 @@ DEFINE_SIMPLE_ATTRIBUTE(pxp_terminate_fops, pxp_terminate_get, pxp_terminate_set
 void intel_pxp_debugfs_register(struct intel_pxp *pxp)
 {
 	struct drm_minor *minor;
-	struct dentry *pxproot;
+	struct debugfs_node *pxproot;
 
 	if (!intel_pxp_is_supported(pxp))
 		return;
diff --git a/drivers/gpu/drm/imagination/pvr_debugfs.c b/drivers/gpu/drm/imagination/pvr_debugfs.c
index 6b77c9b4bde8..31719e932278 100644
--- a/drivers/gpu/drm/imagination/pvr_debugfs.c
+++ b/drivers/gpu/drm/imagination/pvr_debugfs.c
@@ -27,12 +27,12 @@ pvr_debugfs_init(struct drm_minor *minor)
 {
 	struct drm_device *drm_dev = minor->dev;
 	struct pvr_device *pvr_dev = to_pvr_device(drm_dev);
-	struct dentry *root = minor->debugfs_root;
+	struct debugfs_node *root = minor->debugfs_root;
 	size_t i;
 
 	for (i = 0; i < ARRAY_SIZE(pvr_debugfs_entries); ++i) {
 		const struct pvr_debugfs_entry *entry = &pvr_debugfs_entries[i];
-		struct dentry *dir;
+		struct debugfs_node *dir;
 
 		dir = debugfs_create_dir(entry->name, root);
 		if (IS_ERR(dir)) {
diff --git a/drivers/gpu/drm/imagination/pvr_debugfs.h b/drivers/gpu/drm/imagination/pvr_debugfs.h
index ebacbd13b84a..dab4b40bd0ea 100644
--- a/drivers/gpu/drm/imagination/pvr_debugfs.h
+++ b/drivers/gpu/drm/imagination/pvr_debugfs.h
@@ -13,6 +13,7 @@ struct pvr_device;
 
 /* Forward declaration from <linux/dcache.h>. */
 struct dentry;
+#define debugfs_node dentry
 
 struct pvr_debugfs_entry {
 	const char *name;
diff --git a/drivers/gpu/drm/imagination/pvr_fw_trace.c b/drivers/gpu/drm/imagination/pvr_fw_trace.c
index 73707daa4e52..f70215421012 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_trace.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_trace.c
@@ -452,7 +452,8 @@ pvr_fw_trace_mask_update(struct pvr_device *pvr_dev, u32 old_mask, u32 new_mask)
 }
 
 void
-pvr_fw_trace_debugfs_init(struct pvr_device *pvr_dev, struct dentry *dir)
+pvr_fw_trace_debugfs_init(struct pvr_device *pvr_dev,
+			  struct debugfs_node *dir)
 {
 	struct pvr_fw_trace *fw_trace = &pvr_dev->fw_dev.fw_trace;
 	u32 thread_nr;
diff --git a/drivers/gpu/drm/imagination/pvr_fw_trace.h b/drivers/gpu/drm/imagination/pvr_fw_trace.h
index 0074d2b18da0..0f088f7d4715 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_trace.h
+++ b/drivers/gpu/drm/imagination/pvr_fw_trace.h
@@ -68,11 +68,13 @@ void pvr_fw_trace_fini(struct pvr_device *pvr_dev);
 #if defined(CONFIG_DEBUG_FS)
 /* Forward declaration from <linux/dcache.h>. */
 struct dentry;
+#define debugfs_node dentry
 
 void pvr_fw_trace_mask_update(struct pvr_device *pvr_dev, u32 old_mask,
 			      u32 new_mask);
 
-void pvr_fw_trace_debugfs_init(struct pvr_device *pvr_dev, struct dentry *dir);
+void pvr_fw_trace_debugfs_init(struct pvr_device *pvr_dev,
+			       struct debugfs_node *dir);
 #endif /* defined(CONFIG_DEBUG_FS) */
 
 #endif /* PVR_FW_TRACE_H */
diff --git a/drivers/gpu/drm/imagination/pvr_params.c b/drivers/gpu/drm/imagination/pvr_params.c
index b91759f362c5..24bcac11a4af 100644
--- a/drivers/gpu/drm/imagination/pvr_params.c
+++ b/drivers/gpu/drm/imagination/pvr_params.c
@@ -128,7 +128,7 @@ static struct {
 };
 
 void
-pvr_params_debugfs_init(struct pvr_device *pvr_dev, struct dentry *dir)
+pvr_params_debugfs_init(struct pvr_device *pvr_dev, struct debugfs_node *dir)
 {
 #define X_MODE(mode_) X_MODE_##mode_
 #define X_MODE_RO 0400
diff --git a/drivers/gpu/drm/imagination/pvr_params.h b/drivers/gpu/drm/imagination/pvr_params.h
index 5807915b456b..a186e5da0849 100644
--- a/drivers/gpu/drm/imagination/pvr_params.h
+++ b/drivers/gpu/drm/imagination/pvr_params.h
@@ -65,8 +65,10 @@ struct pvr_device;
 
 /* Forward declaration from <linux/dcache.h>. */
 struct dentry;
+#define debugfs_node dentry
 
-void pvr_params_debugfs_init(struct pvr_device *pvr_dev, struct dentry *dir);
+void pvr_params_debugfs_init(struct pvr_device *pvr_dev,
+			     struct debugfs_node *dir);
 #endif /* defined(CONFIG_DEBUG_FS) */
 
 #endif /* PVR_PARAMS_H */
diff --git a/drivers/gpu/drm/loongson/lsdc_output_7a2000.c b/drivers/gpu/drm/loongson/lsdc_output_7a2000.c
index 2bd797a9b9ff..b77c0508e14c 100644
--- a/drivers/gpu/drm/loongson/lsdc_output_7a2000.c
+++ b/drivers/gpu/drm/loongson/lsdc_output_7a2000.c
@@ -138,7 +138,7 @@ static const struct drm_info_list ls7a2000_hdmi1_debugfs_files[] = {
 };
 
 static void ls7a2000_hdmi0_late_register(struct drm_connector *connector,
-					 struct dentry *root)
+					 struct debugfs_node *root)
 {
 	struct drm_device *ddev = connector->dev;
 	struct drm_minor *minor = ddev->primary;
@@ -149,7 +149,7 @@ static void ls7a2000_hdmi0_late_register(struct drm_connector *connector,
 }
 
 static void ls7a2000_hdmi1_late_register(struct drm_connector *connector,
-					 struct dentry *root)
+					 struct debugfs_node *root)
 {
 	struct drm_device *ddev = connector->dev;
 	struct drm_minor *minor = ddev->primary;
diff --git a/drivers/gpu/drm/loongson/lsdc_ttm.c b/drivers/gpu/drm/loongson/lsdc_ttm.c
index 2e42c6970c9f..64f130c2dfec 100644
--- a/drivers/gpu/drm/loongson/lsdc_ttm.c
+++ b/drivers/gpu/drm/loongson/lsdc_ttm.c
@@ -575,7 +575,7 @@ void lsdc_ttm_debugfs_init(struct lsdc_device *ldev)
 	struct ttm_device *bdev = &ldev->bdev;
 	struct drm_device *ddev = &ldev->base;
 	struct drm_minor *minor = ddev->primary;
-	struct dentry *root = minor->debugfs_root;
+	struct debugfs_node *root = minor->debugfs_root;
 	struct ttm_resource_manager *vram_man;
 	struct ttm_resource_manager *gtt_man;
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_irq.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_irq.h
index e7183cf05776..9f8b269a1cc4 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_irq.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_irq.h
@@ -29,6 +29,6 @@ int dpu_core_irq_unregister_callback(
 		unsigned int irq_idx);
 
 void dpu_debugfs_core_irq_init(struct dpu_kms *dpu_kms,
-		struct dentry *parent);
+		struct debugfs_node *parent);
 
 #endif /* __DPU_CORE_IRQ_H__ */
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
index 6f0a37f954fe..28ad55f1f0e3 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
@@ -463,10 +463,11 @@ static const struct file_operations dpu_core_perf_mode_fops = {
  * @dpu_kms: Pointer to the dpu_kms struct
  * @parent: Pointer to parent debugfs
  */
-int dpu_core_perf_debugfs_init(struct dpu_kms *dpu_kms, struct dentry *parent)
+int dpu_core_perf_debugfs_init(struct dpu_kms *dpu_kms,
+			       struct debugfs_node *parent)
 {
 	struct dpu_core_perf *perf = &dpu_kms->perf;
-	struct dentry *entry;
+	struct debugfs_node *entry;
 
 	entry = debugfs_create_dir("core_perf", parent);
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h
index 451bf8021114..2f9f9e0ef0bd 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h
@@ -68,6 +68,7 @@ int dpu_core_perf_init(struct dpu_core_perf *perf,
 
 struct dpu_kms;
 
-int dpu_core_perf_debugfs_init(struct dpu_kms *dpu_kms, struct dentry *parent);
+int dpu_core_perf_debugfs_init(struct dpu_kms *dpu_kms,
+			       struct debugfs_node *parent);
 
 #endif /* _DPU_CORE_PERF_H_ */
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 5172ab4dea99..e4ac67b7ca8c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -2435,7 +2435,8 @@ static int _dpu_encoder_status_show(struct seq_file *s, void *data)
 
 DEFINE_SHOW_ATTRIBUTE(_dpu_encoder_status);
 
-static void dpu_encoder_debugfs_init(struct drm_encoder *drm_enc, struct dentry *root)
+static void dpu_encoder_debugfs_init(struct drm_encoder *drm_enc,
+				     struct debugfs_node *root)
 {
 	/* don't error check these */
 	debugfs_create_file("status", 0600,
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
index 49bd77a755aa..6671dfa65998 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
@@ -671,7 +671,7 @@ DEFINE_SHOW_ATTRIBUTE(dpu_debugfs_core_irq);
  * @parent: debugfs directory root
  */
 void dpu_debugfs_core_irq_init(struct dpu_kms *dpu_kms,
-		struct dentry *parent)
+		struct debugfs_node *parent)
 {
 	debugfs_create_file("core_irq", 0600, parent, dpu_kms,
 		&dpu_debugfs_core_irq_fops);
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
index 32c7c8084553..464d5dfc8f92 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
@@ -620,11 +620,11 @@ static void _setup_layer_ops(struct dpu_hw_sspp *c,
 
 #ifdef CONFIG_DEBUG_FS
 int _dpu_hw_sspp_init_debugfs(struct dpu_hw_sspp *hw_pipe, struct dpu_kms *kms,
-			      struct dentry *entry)
+			      struct debugfs_node *entry)
 {
 	const struct dpu_sspp_cfg *cfg = hw_pipe->cap;
 	const struct dpu_sspp_sub_blks *sblk = cfg->sblk;
-	struct dentry *debugfs_root;
+	struct debugfs_node *debugfs_root;
 	char sspp_name[32];
 
 	snprintf(sspp_name, sizeof(sspp_name), "%d", hw_pipe->idx);
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h
index 56a0edf2a57c..753847c4afb4 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h
@@ -327,7 +327,7 @@ struct dpu_hw_sspp *dpu_hw_sspp_init(struct drm_device *dev,
 				     const struct dpu_mdss_version *mdss_rev);
 
 int _dpu_hw_sspp_init_debugfs(struct dpu_hw_sspp *hw_pipe, struct dpu_kms *kms,
-			      struct dentry *entry);
+			      struct debugfs_node *entry);
 
 #endif /*_DPU_HW_SSPP_H */
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 97e9cb8c2b09..d7e05c7f7546 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -176,9 +176,9 @@ static const struct file_operations dpu_plane_danger_enable = {
 };
 
 static void dpu_debugfs_danger_init(struct dpu_kms *dpu_kms,
-		struct dentry *parent)
+		struct debugfs_node *parent)
 {
-	struct dentry *entry = debugfs_create_dir("danger", parent);
+	struct debugfs_node *entry = debugfs_create_dir("danger", parent);
 
 	debugfs_create_file("danger_status", 0600, entry,
 			dpu_kms, &dpu_debugfs_danger_stats_fops);
@@ -269,9 +269,10 @@ void dpu_debugfs_create_regset32(const char *name, umode_t mode,
 	debugfs_create_file(name, mode, parent, regset, &dpu_regset32_fops);
 }
 
-static void dpu_debugfs_sspp_init(struct dpu_kms *dpu_kms, struct dentry *debugfs_root)
+static void dpu_debugfs_sspp_init(struct dpu_kms *dpu_kms,
+				  struct debugfs_node *debugfs_root)
 {
-	struct dentry *entry = debugfs_create_dir("sspp", debugfs_root);
+	struct debugfs_node *entry = debugfs_create_dir("sspp", debugfs_root);
 	int i;
 
 	if (IS_ERR(entry))
@@ -291,7 +292,7 @@ static int dpu_kms_debugfs_init(struct msm_kms *kms, struct drm_minor *minor)
 {
 	struct dpu_kms *dpu_kms = to_dpu_kms(kms);
 	void *p = dpu_hw_util_get_log_mask_ptr();
-	struct dentry *entry;
+	struct debugfs_node *entry;
 
 	if (!p)
 		return -EINVAL;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c
index 2a551e455aa3..4984138f6daf 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c
@@ -292,10 +292,11 @@ void dpu_vbif_init_memtypes(struct dpu_kms *dpu_kms)
 
 #ifdef CONFIG_DEBUG_FS
 
-void dpu_debugfs_vbif_init(struct dpu_kms *dpu_kms, struct dentry *debugfs_root)
+void dpu_debugfs_vbif_init(struct dpu_kms *dpu_kms,
+			   struct debugfs_node *debugfs_root)
 {
 	char vbif_name[32];
-	struct dentry *entry, *debugfs_vbif;
+	struct debugfs_node *entry, *debugfs_vbif;
 	int i, j;
 
 	entry = debugfs_create_dir("vbif", debugfs_root);
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.h
index 62e47ae1e3ee..e77e1cd0da7e 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.h
@@ -48,6 +48,7 @@ void dpu_vbif_clear_errors(struct dpu_kms *dpu_kms);
 
 void dpu_vbif_init_memtypes(struct dpu_kms *dpu_kms);
 
-void dpu_debugfs_vbif_init(struct dpu_kms *dpu_kms, struct dentry *debugfs_root);
+void dpu_debugfs_vbif_init(struct dpu_kms *dpu_kms,
+			   struct debugfs_node *debugfs_root);
 
 #endif /* __DPU_VBIF_H__ */
diff --git a/drivers/gpu/drm/msm/dp/dp_debug.c b/drivers/gpu/drm/msm/dp/dp_debug.c
index 22fd946ee201..c99cb567b312 100644
--- a/drivers/gpu/drm/msm/dp/dp_debug.c
+++ b/drivers/gpu/drm/msm/dp/dp_debug.c
@@ -200,7 +200,7 @@ static const struct file_operations test_active_fops = {
 int msm_dp_debug_init(struct device *dev, struct msm_dp_panel *panel,
 		  struct msm_dp_link *link,
 		  struct drm_connector *connector,
-		  struct dentry *root, bool is_edp)
+		  struct debugfs_node *root, bool is_edp)
 {
 	struct msm_dp_debug_private *debug;
 
diff --git a/drivers/gpu/drm/msm/dp/dp_debug.h b/drivers/gpu/drm/msm/dp/dp_debug.h
index 6dc0ff4f0f65..8a69b3891d5e 100644
--- a/drivers/gpu/drm/msm/dp/dp_debug.h
+++ b/drivers/gpu/drm/msm/dp/dp_debug.h
@@ -37,7 +37,7 @@ static inline
 int msm_dp_debug_init(struct device *dev, struct msm_dp_panel *panel,
 		  struct msm_dp_link *link,
 		  struct drm_connector *connector,
-		  struct dentry *root,
+		  struct debugfs_node *root,
 		  bool is_edp)
 {
 	return -EINVAL;
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 24dd37f1682b..e8ef4b08e30a 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1445,7 +1445,8 @@ bool msm_dp_wide_bus_available(const struct msm_dp *msm_dp_display)
 	return dp->wide_bus_supported;
 }
 
-void msm_dp_display_debugfs_init(struct msm_dp *msm_dp_display, struct dentry *root, bool is_edp)
+void msm_dp_display_debugfs_init(struct msm_dp *msm_dp_display,
+				 struct debugfs_node *root, bool is_edp)
 {
 	struct msm_dp_display_private *dp;
 	struct device *dev;
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index ecbc2d92f546..ab434c367df1 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -39,6 +39,7 @@ int msm_dp_display_get_test_bpp(struct msm_dp *msm_dp_display);
 void msm_dp_display_signal_audio_start(struct msm_dp *msm_dp_display);
 void msm_dp_display_signal_audio_complete(struct msm_dp *msm_dp_display);
 void msm_dp_display_set_psr(struct msm_dp *dp, bool enter);
-void msm_dp_display_debugfs_init(struct msm_dp *msm_dp_display, struct dentry *dentry, bool is_edp);
+void msm_dp_display_debugfs_init(struct msm_dp *msm_dp_display,
+				 struct debugfs_node *dentry, bool is_edp);
 
 #endif /* _DP_DISPLAY_H_ */
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
index d3e241ea6941..b5ae7597a426 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_drm.c
@@ -90,7 +90,8 @@ static int msm_dp_bridge_get_modes(struct drm_bridge *bridge, struct drm_connect
 	return rc;
 }
 
-static void msm_dp_bridge_debugfs_init(struct drm_bridge *bridge, struct dentry *root)
+static void msm_dp_bridge_debugfs_init(struct drm_bridge *bridge,
+				       struct debugfs_node *root)
 {
 	struct msm_dp *dp = to_dp_bridge(bridge)->msm_dp_display;
 
@@ -268,7 +269,8 @@ static enum drm_mode_status msm_edp_bridge_mode_valid(struct drm_bridge *bridge,
 	return MODE_OK;
 }
 
-static void msm_edp_bridge_debugfs_init(struct drm_bridge *bridge, struct dentry *root)
+static void msm_edp_bridge_debugfs_init(struct drm_bridge *bridge,
+					struct debugfs_node *root)
 {
 	struct msm_dp *dp = to_dp_bridge(bridge)->msm_dp_display;
 
diff --git a/drivers/gpu/drm/msm/msm_debugfs.c b/drivers/gpu/drm/msm/msm_debugfs.c
index 7ab607252d18..37a228340ad4 100644
--- a/drivers/gpu/drm/msm/msm_debugfs.c
+++ b/drivers/gpu/drm/msm/msm_debugfs.c
@@ -308,7 +308,7 @@ static void msm_debugfs_gpu_init(struct drm_minor *minor)
 {
 	struct drm_device *dev = minor->dev;
 	struct msm_drm_private *priv = dev->dev_private;
-	struct dentry *gpu_devfreq;
+	struct debugfs_node *gpu_devfreq;
 
 	debugfs_create_file("gpu", S_IRUSR, minor->debugfs_root,
 		dev, &msm_gpu_fops);
diff --git a/drivers/gpu/drm/nouveau/dispnv50/crc.c b/drivers/gpu/drm/nouveau/dispnv50/crc.c
index 5936b6b3b15d..0fb91a81dbc1 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/crc.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/crc.c
@@ -709,7 +709,7 @@ int nv50_head_crc_late_register(struct nv50_head *head)
 	struct drm_crtc *crtc = &head->base.base;
 	const struct nv50_crc_func *func =
 		nv50_disp(crtc->dev)->core->func->crc;
-	struct dentry *root;
+	struct debugfs_node *root;
 
 	if (!func || !crtc->debugfs_entry)
 		return 0;
diff --git a/drivers/gpu/drm/nouveau/nouveau_debugfs.c b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
index 200e65a7cefc..02c1465cb5bb 100644
--- a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
+++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
@@ -267,7 +267,7 @@ void
 nouveau_drm_debugfs_init(struct drm_minor *minor)
 {
 	struct nouveau_drm *drm = nouveau_drm(minor->dev);
-	struct dentry *dentry;
+	struct debugfs_node *dentry;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(nouveau_debugfs_files); i++) {
@@ -288,8 +288,8 @@ nouveau_drm_debugfs_init(struct drm_minor *minor)
 	if (!dentry)
 		return;
 
-	d_inode(dentry)->i_size = drm->vbios.length;
-	dput(dentry);
+	debugfs_node_inode(dentry)->i_size = drm->vbios.length;
+	debugfs_node_put(dentry);
 }
 
 int
diff --git a/drivers/gpu/drm/nouveau/nouveau_debugfs.h b/drivers/gpu/drm/nouveau/nouveau_debugfs.h
index b7617b344ee2..9af997297e1a 100644
--- a/drivers/gpu/drm/nouveau/nouveau_debugfs.h
+++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.h
@@ -22,7 +22,7 @@ extern void  nouveau_drm_debugfs_init(struct drm_minor *);
 extern int  nouveau_debugfs_init(struct nouveau_drm *);
 extern void nouveau_debugfs_fini(struct nouveau_drm *);
 
-extern struct dentry *nouveau_debugfs_root;
+extern struct debugfs_node *nouveau_debugfs_root;
 
 int  nouveau_module_debugfs_init(void);
 void nouveau_module_debugfs_fini(void);
diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 5664c4c71faf..1bb972d3a101 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -116,7 +116,7 @@ static struct drm_driver driver_pci;
 static struct drm_driver driver_platform;
 
 #ifdef CONFIG_DEBUG_FS
-struct dentry *nouveau_debugfs_root;
+struct debugfs_node *nouveau_debugfs_root;
 
 /**
  * gsp_logs - list of nvif_log GSP-RM logging buffers
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
index 58502102926b..9155c5d25c64 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
@@ -58,7 +58,7 @@
 #include <linux/ctype.h>
 #include <linux/parser.h>
 
-extern struct dentry *nouveau_debugfs_root;
+extern struct debugfs_node *nouveau_debugfs_root;
 
 #define GSP_MSG_MIN_SIZE GSP_PAGE_SIZE
 #define GSP_MSG_MAX_SIZE GSP_PAGE_MIN_SIZE * 16
@@ -2169,10 +2169,10 @@ r535_gsp_msg_libos_print(void *priv, u32 fn, void *repv, u32 repc)
  *
  * Creates a debugfs entry for a logging buffer with the name 'name'.
  */
-static struct dentry *create_debugfs(struct nvkm_gsp *gsp, const char *name,
+static struct debugfs_node *create_debugfs(struct nvkm_gsp *gsp, const char *name,
 				     struct debugfs_blob_wrapper *blob)
 {
-	struct dentry *dent;
+	struct debugfs_node *dent;
 
 	dent = debugfs_create_blob(name, 0444, gsp->debugfs.parent, blob);
 	if (IS_ERR(dent)) {
@@ -2187,7 +2187,7 @@ static struct dentry *create_debugfs(struct nvkm_gsp *gsp, const char *name,
 	 *
 	 * [1] https://lore.kernel.org/r/linux-fsdevel/20240207200619.3354549-1-ttabi@nvidia.com/
 	 */
-	i_size_write(d_inode(dent), blob->size);
+	i_size_write(debugfs_node_inode(dent), blob->size);
 
 	return dent;
 }
@@ -2737,7 +2737,7 @@ struct r535_gsp_log {
 	 * Logging buffers in debugfs. The wrapper objects need to remain
 	 * in memory until the dentry is deleted.
 	 */
-	struct dentry *debugfs_logging_dir;
+	struct debugfs_node *debugfs_logging_dir;
 	struct debugfs_blob_wrapper blob_init;
 	struct debugfs_blob_wrapper blob_intr;
 	struct debugfs_blob_wrapper blob_rm;
@@ -2793,12 +2793,12 @@ static bool is_empty(const struct debugfs_blob_wrapper *b)
  * To preserve the logging buffers, the buffers need to be copied, but only
  * if they actually have data.
  */
-static int r535_gsp_copy_log(struct dentry *parent,
+static int r535_gsp_copy_log(struct debugfs_node *parent,
 			     const char *name,
 			     const struct debugfs_blob_wrapper *s,
 			     struct debugfs_blob_wrapper *t)
 {
-	struct dentry *dent;
+	struct debugfs_node *dent;
 	void *p;
 
 	if (is_empty(s))
@@ -2819,7 +2819,7 @@ static int r535_gsp_copy_log(struct dentry *parent,
 		return PTR_ERR(dent);
 	}
 
-	i_size_write(d_inode(dent), t->size);
+	i_size_write(debugfs_node_inode(dent), t->size);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/omapdrm/dss/dss.c b/drivers/gpu/drm/omapdrm/dss/dss.c
index 7b2df3185de4..af58cb2c7517 100644
--- a/drivers/gpu/drm/omapdrm/dss/dss.c
+++ b/drivers/gpu/drm/omapdrm/dss/dss.c
@@ -885,7 +885,7 @@ struct dss_device *dss_get_device(struct device *dev)
 #if defined(CONFIG_OMAP2_DSS_DEBUGFS)
 static int dss_initialize_debugfs(struct dss_device *dss)
 {
-	struct dentry *dir;
+	struct debugfs_node *dir;
 
 	dir = debugfs_create_dir("omapdss", NULL);
 	if (IS_ERR(dir))
@@ -902,7 +902,7 @@ static void dss_uninitialize_debugfs(struct dss_device *dss)
 }
 
 struct dss_debugfs_entry {
-	struct dentry *dentry;
+	struct debugfs_node *dentry;
 	int (*show_fn)(struct seq_file *s, void *data);
 	void *data;
 };
diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index f8511fe5fb0d..d84dfcc9f51b 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -672,7 +672,8 @@ static int detected_panel_show(struct seq_file *s, void *data)
 
 DEFINE_SHOW_ATTRIBUTE(detected_panel);
 
-static void panel_edp_debugfs_init(struct drm_panel *panel, struct dentry *root)
+static void panel_edp_debugfs_init(struct drm_panel *panel,
+				   struct debugfs_node *root)
 {
 	debugfs_create_file("detected_panel", 0600, root, panel, &detected_panel_fops);
 }
diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7703.c b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
index 67e8e45498cb..fe66406abf0e 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7703.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
@@ -59,7 +59,7 @@ struct st7703 {
 	struct regulator *vcc;
 	struct regulator *iovcc;
 
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 	const struct st7703_panel_desc *desc;
 	enum drm_panel_orientation orientation;
 };
diff --git a/drivers/gpu/drm/radeon/r100.c b/drivers/gpu/drm/radeon/r100.c
index 80703417d8a1..38f90a9d765a 100644
--- a/drivers/gpu/drm/radeon/r100.c
+++ b/drivers/gpu/drm/radeon/r100.c
@@ -3079,7 +3079,7 @@ DEFINE_SHOW_ATTRIBUTE(r100_debugfs_mc_info);
 void  r100_debugfs_rbbm_init(struct radeon_device *rdev)
 {
 #if defined(CONFIG_DEBUG_FS)
-	struct dentry *root = rdev_to_drm(rdev)->primary->debugfs_root;
+	struct debugfs_node *root = rdev_to_drm(rdev)->primary->debugfs_root;
 
 	debugfs_create_file("r100_rbbm_info", 0444, root, rdev,
 			    &r100_debugfs_rbbm_info_fops);
@@ -3089,7 +3089,7 @@ void  r100_debugfs_rbbm_init(struct radeon_device *rdev)
 void r100_debugfs_cp_init(struct radeon_device *rdev)
 {
 #if defined(CONFIG_DEBUG_FS)
-	struct dentry *root = rdev_to_drm(rdev)->primary->debugfs_root;
+	struct debugfs_node *root = rdev_to_drm(rdev)->primary->debugfs_root;
 
 	debugfs_create_file("r100_cp_ring_info", 0444, root, rdev,
 			    &r100_debugfs_cp_ring_info_fops);
@@ -3101,7 +3101,7 @@ void r100_debugfs_cp_init(struct radeon_device *rdev)
 void  r100_debugfs_mc_info_init(struct radeon_device *rdev)
 {
 #if defined(CONFIG_DEBUG_FS)
-	struct dentry *root = rdev_to_drm(rdev)->primary->debugfs_root;
+	struct debugfs_node *root = rdev_to_drm(rdev)->primary->debugfs_root;
 
 	debugfs_create_file("r100_mc_info", 0444, root, rdev,
 			    &r100_debugfs_mc_info_fops);
diff --git a/drivers/gpu/drm/radeon/r300.c b/drivers/gpu/drm/radeon/r300.c
index 05c13102a8cb..228650a96bfb 100644
--- a/drivers/gpu/drm/radeon/r300.c
+++ b/drivers/gpu/drm/radeon/r300.c
@@ -616,7 +616,7 @@ DEFINE_SHOW_ATTRIBUTE(rv370_debugfs_pcie_gart_info);
 static void rv370_debugfs_pcie_gart_info_init(struct radeon_device *rdev)
 {
 #if defined(CONFIG_DEBUG_FS)
-	struct dentry *root = rdev_to_drm(rdev)->primary->debugfs_root;
+	struct debugfs_node *root = rdev_to_drm(rdev)->primary->debugfs_root;
 
 	debugfs_create_file("rv370_pcie_gart_info", 0444, root, rdev,
 			    &rv370_debugfs_pcie_gart_info_fops);
diff --git a/drivers/gpu/drm/radeon/r420.c b/drivers/gpu/drm/radeon/r420.c
index 9a31cdec6415..7234f59a64c4 100644
--- a/drivers/gpu/drm/radeon/r420.c
+++ b/drivers/gpu/drm/radeon/r420.c
@@ -493,7 +493,7 @@ DEFINE_SHOW_ATTRIBUTE(r420_debugfs_pipes_info);
 void r420_debugfs_pipes_info_init(struct radeon_device *rdev)
 {
 #if defined(CONFIG_DEBUG_FS)
-	struct dentry *root = rdev_to_drm(rdev)->primary->debugfs_root;
+	struct debugfs_node *root = rdev_to_drm(rdev)->primary->debugfs_root;
 
 	debugfs_create_file("r420_pipes_info", 0444, root, rdev,
 			    &r420_debugfs_pipes_info_fops);
diff --git a/drivers/gpu/drm/radeon/r600.c b/drivers/gpu/drm/radeon/r600.c
index 8b62f7faa5b9..734008ad6de8 100644
--- a/drivers/gpu/drm/radeon/r600.c
+++ b/drivers/gpu/drm/radeon/r600.c
@@ -4358,7 +4358,7 @@ DEFINE_SHOW_ATTRIBUTE(r600_debugfs_mc_info);
 static void r600_debugfs_mc_info_init(struct radeon_device *rdev)
 {
 #if defined(CONFIG_DEBUG_FS)
-	struct dentry *root = rdev_to_drm(rdev)->primary->debugfs_root;
+	struct debugfs_node *root = rdev_to_drm(rdev)->primary->debugfs_root;
 
 	debugfs_create_file("r600_mc_info", 0444, root, rdev,
 			    &r600_debugfs_mc_info_fops);
diff --git a/drivers/gpu/drm/radeon/radeon_fence.c b/drivers/gpu/drm/radeon/radeon_fence.c
index daff61586be5..3f443c9a52cb 100644
--- a/drivers/gpu/drm/radeon/radeon_fence.c
+++ b/drivers/gpu/drm/radeon/radeon_fence.c
@@ -995,7 +995,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(radeon_debugfs_gpu_reset_fops,
 void radeon_debugfs_fence_init(struct radeon_device *rdev)
 {
 #if defined(CONFIG_DEBUG_FS)
-	struct dentry *root = rdev_to_drm(rdev)->primary->debugfs_root;
+	struct debugfs_node *root = rdev_to_drm(rdev)->primary->debugfs_root;
 
 	debugfs_create_file("radeon_gpu_reset", 0444, root, rdev,
 			    &radeon_debugfs_gpu_reset_fops);
diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/radeon_gem.c
index f86773f3db20..5c158b55672d 100644
--- a/drivers/gpu/drm/radeon/radeon_gem.c
+++ b/drivers/gpu/drm/radeon/radeon_gem.c
@@ -901,7 +901,7 @@ DEFINE_SHOW_ATTRIBUTE(radeon_debugfs_gem_info);
 void radeon_gem_debugfs_init(struct radeon_device *rdev)
 {
 #if defined(CONFIG_DEBUG_FS)
-	struct dentry *root = rdev_to_drm(rdev)->primary->debugfs_root;
+	struct debugfs_node *root = rdev_to_drm(rdev)->primary->debugfs_root;
 
 	debugfs_create_file("radeon_gem_info", 0444, root, rdev,
 			    &radeon_debugfs_gem_info_fops);
diff --git a/drivers/gpu/drm/radeon/radeon_ib.c b/drivers/gpu/drm/radeon/radeon_ib.c
index 1aa41cc3f991..40d280fa664d 100644
--- a/drivers/gpu/drm/radeon/radeon_ib.c
+++ b/drivers/gpu/drm/radeon/radeon_ib.c
@@ -309,7 +309,7 @@ DEFINE_SHOW_ATTRIBUTE(radeon_debugfs_sa_info);
 static void radeon_debugfs_sa_init(struct radeon_device *rdev)
 {
 #if defined(CONFIG_DEBUG_FS)
-	struct dentry *root = rdev_to_drm(rdev)->primary->debugfs_root;
+	struct debugfs_node *root = rdev_to_drm(rdev)->primary->debugfs_root;
 
 	debugfs_create_file("radeon_sa_info", 0444, root, rdev,
 			    &radeon_debugfs_sa_info_fops);
diff --git a/drivers/gpu/drm/radeon/radeon_pm.c b/drivers/gpu/drm/radeon/radeon_pm.c
index b4fb7e70320b..1cceded2141d 100644
--- a/drivers/gpu/drm/radeon/radeon_pm.c
+++ b/drivers/gpu/drm/radeon/radeon_pm.c
@@ -1955,7 +1955,7 @@ DEFINE_SHOW_ATTRIBUTE(radeon_debugfs_pm_info);
 static void radeon_debugfs_pm_init(struct radeon_device *rdev)
 {
 #if defined(CONFIG_DEBUG_FS)
-	struct dentry *root = rdev_to_drm(rdev)->primary->debugfs_root;
+	struct debugfs_node *root = rdev_to_drm(rdev)->primary->debugfs_root;
 
 	debugfs_create_file("radeon_pm_info", 0444, root, rdev,
 			    &radeon_debugfs_pm_info_fops);
diff --git a/drivers/gpu/drm/radeon/radeon_ring.c b/drivers/gpu/drm/radeon/radeon_ring.c
index 581ae20c46e4..d23ca7d712ec 100644
--- a/drivers/gpu/drm/radeon/radeon_ring.c
+++ b/drivers/gpu/drm/radeon/radeon_ring.c
@@ -550,7 +550,7 @@ static void radeon_debugfs_ring_init(struct radeon_device *rdev, struct radeon_r
 {
 #if defined(CONFIG_DEBUG_FS)
 	const char *ring_name = radeon_debugfs_ring_idx_to_name(ring->idx);
-	struct dentry *root = rdev_to_drm(rdev)->primary->debugfs_root;
+	struct debugfs_node *root = rdev_to_drm(rdev)->primary->debugfs_root;
 
 	if (ring_name)
 		debugfs_create_file(ring_name, 0444, root, ring,
diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index 616d25c8c2de..e8a2788728f2 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -890,7 +890,7 @@ static void radeon_ttm_debugfs_init(struct radeon_device *rdev)
 {
 #if defined(CONFIG_DEBUG_FS)
 	struct drm_minor *minor = rdev_to_drm(rdev)->primary;
-	struct dentry *root = minor->debugfs_root;
+	struct debugfs_node *root = minor->debugfs_root;
 
 	debugfs_create_file("radeon_vram", 0444, root, rdev,
 			    &radeon_ttm_vram_fops);
diff --git a/drivers/gpu/drm/radeon/rs400.c b/drivers/gpu/drm/radeon/rs400.c
index d6c18fd740ec..191ee1d39cfc 100644
--- a/drivers/gpu/drm/radeon/rs400.c
+++ b/drivers/gpu/drm/radeon/rs400.c
@@ -379,7 +379,7 @@ DEFINE_SHOW_ATTRIBUTE(rs400_debugfs_gart_info);
 static void rs400_debugfs_pcie_gart_info_init(struct radeon_device *rdev)
 {
 #if defined(CONFIG_DEBUG_FS)
-	struct dentry *root = rdev_to_drm(rdev)->primary->debugfs_root;
+	struct debugfs_node *root = rdev_to_drm(rdev)->primary->debugfs_root;
 
 	debugfs_create_file("rs400_gart_info", 0444, root, rdev,
 			    &rs400_debugfs_gart_info_fops);
diff --git a/drivers/gpu/drm/radeon/rv515.c b/drivers/gpu/drm/radeon/rv515.c
index 1b4dfb645585..d9e29f8002a0 100644
--- a/drivers/gpu/drm/radeon/rv515.c
+++ b/drivers/gpu/drm/radeon/rv515.c
@@ -255,7 +255,7 @@ DEFINE_SHOW_ATTRIBUTE(rv515_debugfs_ga_info);
 void rv515_debugfs(struct radeon_device *rdev)
 {
 #if defined(CONFIG_DEBUG_FS)
-	struct dentry *root = rdev_to_drm(rdev)->primary->debugfs_root;
+	struct debugfs_node *root = rdev_to_drm(rdev)->primary->debugfs_root;
 
 	debugfs_create_file("rv515_pipes_info", 0444, root, rdev,
 			    &rv515_debugfs_pipes_info_fops);
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 17a98845fd31..def6e120a874 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -3005,7 +3005,7 @@ static struct drm_info_list vop2_debugfs_list[] = {
 
 static void vop2_debugfs_init(struct vop2 *vop2, struct drm_minor *minor)
 {
-	struct dentry *root;
+	struct debugfs_node *root;
 	unsigned int i;
 
 	root = debugfs_create_dir("vop2", minor->debugfs_root);
diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index 430b2eededb2..3240466d868c 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -1719,7 +1719,7 @@ static int tegra_dc_late_register(struct drm_crtc *crtc)
 {
 	unsigned int i, count = ARRAY_SIZE(debugfs_files);
 	struct drm_minor *minor = crtc->dev->primary;
-	struct dentry *root;
+	struct debugfs_node *root;
 	struct tegra_dc *dc = to_tegra_dc(crtc);
 
 #ifdef CONFIG_DEBUG_FS
@@ -1746,7 +1746,7 @@ static void tegra_dc_early_unregister(struct drm_crtc *crtc)
 	unsigned int count = ARRAY_SIZE(debugfs_files);
 	struct drm_minor *minor = crtc->dev->primary;
 	struct tegra_dc *dc = to_tegra_dc(crtc);
-	struct dentry *root;
+	struct debugfs_node *root;
 
 #ifdef CONFIG_DEBUG_FS
 	root = crtc->debugfs_entry;
diff --git a/drivers/gpu/drm/tegra/dsi.c b/drivers/gpu/drm/tegra/dsi.c
index 4a8cd9ed0a94..2988b9ae1cf5 100644
--- a/drivers/gpu/drm/tegra/dsi.c
+++ b/drivers/gpu/drm/tegra/dsi.c
@@ -233,7 +233,7 @@ static int tegra_dsi_late_register(struct drm_connector *connector)
 	struct tegra_output *output = connector_to_output(connector);
 	unsigned int i, count = ARRAY_SIZE(debugfs_files);
 	struct drm_minor *minor = connector->dev->primary;
-	struct dentry *root = connector->debugfs_entry;
+	struct debugfs_node *root = connector->debugfs_entry;
 	struct tegra_dsi *dsi = to_dsi(output);
 
 	dsi->debugfs_files = kmemdup(debugfs_files, sizeof(debugfs_files),
diff --git a/drivers/gpu/drm/tegra/hdmi.c b/drivers/gpu/drm/tegra/hdmi.c
index e705f8590c13..4a7245f741a4 100644
--- a/drivers/gpu/drm/tegra/hdmi.c
+++ b/drivers/gpu/drm/tegra/hdmi.c
@@ -1095,7 +1095,7 @@ static int tegra_hdmi_late_register(struct drm_connector *connector)
 	struct tegra_output *output = connector_to_output(connector);
 	unsigned int i, count = ARRAY_SIZE(debugfs_files);
 	struct drm_minor *minor = connector->dev->primary;
-	struct dentry *root = connector->debugfs_entry;
+	struct debugfs_node *root = connector->debugfs_entry;
 	struct tegra_hdmi *hdmi = to_hdmi(output);
 
 	hdmi->debugfs_files = kmemdup(debugfs_files, sizeof(debugfs_files),
diff --git a/drivers/gpu/drm/tegra/sor.c b/drivers/gpu/drm/tegra/sor.c
index 802d2db7007a..8a3c21eff322 100644
--- a/drivers/gpu/drm/tegra/sor.c
+++ b/drivers/gpu/drm/tegra/sor.c
@@ -1687,7 +1687,7 @@ static int tegra_sor_late_register(struct drm_connector *connector)
 	struct tegra_output *output = connector_to_output(connector);
 	unsigned int i, count = ARRAY_SIZE(debugfs_files);
 	struct drm_minor *minor = connector->dev->primary;
-	struct dentry *root = connector->debugfs_entry;
+	struct debugfs_node *root = connector->debugfs_entry;
 	struct tegra_sor *sor = to_sor(output);
 
 	sor->debugfs_files = kmemdup(debugfs_files, sizeof(debugfs_files),
diff --git a/drivers/gpu/drm/ttm/ttm_device.c b/drivers/gpu/drm/ttm/ttm_device.c
index 02e797fd1891..7ca046ee41a2 100644
--- a/drivers/gpu/drm/ttm/ttm_device.c
+++ b/drivers/gpu/drm/ttm/ttm_device.c
@@ -45,7 +45,7 @@ static unsigned ttm_glob_use_count;
 struct ttm_global ttm_glob;
 EXPORT_SYMBOL(ttm_glob);
 
-struct dentry *ttm_debugfs_root;
+struct debugfs_node *ttm_debugfs_root;
 
 static void ttm_global_release(void)
 {
diff --git a/drivers/gpu/drm/ttm/ttm_module.h b/drivers/gpu/drm/ttm/ttm_module.h
index 767fe22aed48..a33f48f7bc29 100644
--- a/drivers/gpu/drm/ttm/ttm_module.h
+++ b/drivers/gpu/drm/ttm/ttm_module.h
@@ -34,9 +34,10 @@
 #define TTM_PFX "[TTM] "
 
 struct dentry;
+#define debugfs_node dentry
 struct ttm_device;
 
-extern struct dentry *ttm_debugfs_root;
+extern struct debugfs_node *ttm_debugfs_root;
 
 void ttm_sys_man_init(struct ttm_device *bdev);
 
diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_resource.c
index cc29bbf3eabb..d3be4d51f396 100644
--- a/drivers/gpu/drm/ttm/ttm_resource.c
+++ b/drivers/gpu/drm/ttm/ttm_resource.c
@@ -903,7 +903,7 @@ DEFINE_SHOW_ATTRIBUTE(ttm_resource_manager);
  * at debug statistics of the specified ttm_resource_manager.
  */
 void ttm_resource_manager_create_debugfs(struct ttm_resource_manager *man,
-					 struct dentry * parent,
+					 struct debugfs_node * parent,
 					 const char *name)
 {
 #if defined(CONFIG_DEBUG_FS)
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index 0f32471c8533..b296296f566d 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -1434,7 +1434,7 @@ static void vmw_remove(struct pci_dev *pdev)
 static void vmw_debugfs_resource_managers_init(struct vmw_private *vmw)
 {
 	struct drm_minor *minor = vmw->drm.primary;
-	struct dentry *root = minor->debugfs_root;
+	struct debugfs_node *root = minor->debugfs_root;
 
 	ttm_resource_manager_create_debugfs(ttm_manager_type(&vmw->bdev, TTM_PL_SYSTEM),
 					    root, "system_ttm");
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c b/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
index ed5015ced392..c8c3230ee7a3 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
@@ -357,7 +357,7 @@ void vmw_debugfs_gem_init(struct vmw_private *vdev)
 {
 #if defined(CONFIG_DEBUG_FS)
 	struct drm_minor *minor = vdev->drm.primary;
-	struct dentry *root = minor->debugfs_root;
+	struct debugfs_node *root = minor->debugfs_root;
 
 	debugfs_create_file("vmwgfx_gem_info", 0444, root, vdev,
 			    &vmw_debugfs_gem_info_fops);
diff --git a/drivers/gpu/drm/xe/xe_debugfs.c b/drivers/gpu/drm/xe/xe_debugfs.c
index 492b4877433f..0d0af6272f2c 100644
--- a/drivers/gpu/drm/xe/xe_debugfs.c
+++ b/drivers/gpu/drm/xe/xe_debugfs.c
@@ -193,7 +193,7 @@ void xe_debugfs_register(struct xe_device *xe)
 {
 	struct ttm_device *bdev = &xe->ttm;
 	struct drm_minor *minor = xe->drm.primary;
-	struct dentry *root = minor->debugfs_root;
+	struct debugfs_node *root = minor->debugfs_root;
 	struct ttm_resource_manager *man;
 	struct xe_gt *gt;
 	u32 mem_type;
diff --git a/drivers/gpu/drm/xe/xe_gsc_debugfs.c b/drivers/gpu/drm/xe/xe_gsc_debugfs.c
index 461d7e99c2b3..ba9cc3aaa15a 100644
--- a/drivers/gpu/drm/xe/xe_gsc_debugfs.c
+++ b/drivers/gpu/drm/xe/xe_gsc_debugfs.c
@@ -48,7 +48,7 @@ static const struct drm_info_list debugfs_list[] = {
 	{"gsc_info", gsc_info, 0},
 };
 
-void xe_gsc_debugfs_register(struct xe_gsc *gsc, struct dentry *parent)
+void xe_gsc_debugfs_register(struct xe_gsc *gsc, struct debugfs_node *parent)
 {
 	struct drm_minor *minor = gsc_to_xe(gsc)->drm.primary;
 	struct drm_info_list *local;
diff --git a/drivers/gpu/drm/xe/xe_gsc_debugfs.h b/drivers/gpu/drm/xe/xe_gsc_debugfs.h
index c2e2645dc705..02f14eca14b8 100644
--- a/drivers/gpu/drm/xe/xe_gsc_debugfs.h
+++ b/drivers/gpu/drm/xe/xe_gsc_debugfs.h
@@ -7,8 +7,9 @@
 #define _XE_GSC_DEBUGFS_H_
 
 struct dentry;
+#define debugfs_node dentry
 struct xe_gsc;
 
-void xe_gsc_debugfs_register(struct xe_gsc *gsc, struct dentry *parent);
+void xe_gsc_debugfs_register(struct xe_gsc *gsc, struct debugfs_node *parent);
 
 #endif
diff --git a/drivers/gpu/drm/xe/xe_gt_debugfs.c b/drivers/gpu/drm/xe/xe_gt_debugfs.c
index e7792858b1e4..6e5cbb23d5c9 100644
--- a/drivers/gpu/drm/xe/xe_gt_debugfs.c
+++ b/drivers/gpu/drm/xe/xe_gt_debugfs.c
@@ -315,7 +315,7 @@ void xe_gt_debugfs_register(struct xe_gt *gt)
 {
 	struct xe_device *xe = gt_to_xe(gt);
 	struct drm_minor *minor = gt_to_xe(gt)->drm.primary;
-	struct dentry *root;
+	struct debugfs_node *root;
 	char name[8];
 
 	xe_gt_assert(gt, minor->debugfs_root);
@@ -332,7 +332,7 @@ void xe_gt_debugfs_register(struct xe_gt *gt)
 	 * so other GT specific attributes under that directory may refer to
 	 * it by looking at its parent node private data.
 	 */
-	root->d_inode->i_private = gt;
+	debugfs_node_inode(root)->i_private = gt;
 
 	drm_debugfs_create_files(debugfs_list,
 				 ARRAY_SIZE(debugfs_list),
diff --git a/drivers/gpu/drm/xe/xe_gt_sriov_pf_debugfs.c b/drivers/gpu/drm/xe/xe_gt_sriov_pf_debugfs.c
index b2521dd6ec42..b0a32211d892 100644
--- a/drivers/gpu/drm/xe/xe_gt_sriov_pf_debugfs.c
+++ b/drivers/gpu/drm/xe/xe_gt_sriov_pf_debugfs.c
@@ -144,7 +144,7 @@ DEFINE_SRIOV_GT_POLICY_DEBUGFS_ATTRIBUTE(reset_engine, bool, "%llu\n");
 DEFINE_SRIOV_GT_POLICY_DEBUGFS_ATTRIBUTE(sched_if_idle, bool, "%llu\n");
 DEFINE_SRIOV_GT_POLICY_DEBUGFS_ATTRIBUTE(sample_period, u32, "%llu\n");
 
-static void pf_add_policy_attrs(struct xe_gt *gt, struct dentry *parent)
+static void pf_add_policy_attrs(struct xe_gt *gt, struct debugfs_node *parent)
 {
 	xe_gt_assert(gt, gt == extract_gt(parent));
 	xe_gt_assert(gt, PFID == extract_vfid(parent));
@@ -278,7 +278,8 @@ DEFINE_DEBUGFS_ATTRIBUTE(THRESHOLD##_fops, THRESHOLD##_get, THRESHOLD##_set, "%l
 MAKE_XE_GUC_KLV_THRESHOLDS_SET(define_threshold_attribute)
 #undef define_threshold_attribute
 
-static void pf_add_config_attrs(struct xe_gt *gt, struct dentry *parent, unsigned int vfid)
+static void pf_add_config_attrs(struct xe_gt *gt, struct debugfs_node *parent,
+				unsigned int vfid)
 {
 	xe_gt_assert(gt, gt == extract_gt(parent));
 	xe_gt_assert(gt, vfid == extract_vfid(parent));
@@ -331,7 +332,7 @@ static const struct {
 static ssize_t control_write(struct file *file, const char __user *buf, size_t count, loff_t *pos)
 {
 	struct dentry *dent = file_dentry(file);
-	struct dentry *parent = dent->d_parent;
+	struct debugfs_node *parent = dent->d_parent;
 	struct xe_gt *gt = extract_gt(parent);
 	struct xe_device *xe = gt_to_xe(gt);
 	unsigned int vfid = extract_vfid(parent);
@@ -399,7 +400,7 @@ static ssize_t guc_state_read(struct file *file, char __user *buf,
 			      size_t count, loff_t *pos)
 {
 	struct dentry *dent = file_dentry(file);
-	struct dentry *parent = dent->d_parent;
+	struct debugfs_node *parent = dent->d_parent;
 	struct xe_gt *gt = extract_gt(parent);
 	unsigned int vfid = extract_vfid(parent);
 
@@ -410,7 +411,7 @@ static ssize_t guc_state_write(struct file *file, const char __user *buf,
 			       size_t count, loff_t *pos)
 {
 	struct dentry *dent = file_dentry(file);
-	struct dentry *parent = dent->d_parent;
+	struct debugfs_node *parent = dent->d_parent;
 	struct xe_gt *gt = extract_gt(parent);
 	unsigned int vfid = extract_vfid(parent);
 
@@ -437,7 +438,7 @@ static ssize_t config_blob_read(struct file *file, char __user *buf,
 				size_t count, loff_t *pos)
 {
 	struct dentry *dent = file_dentry(file);
-	struct dentry *parent = dent->d_parent;
+	struct debugfs_node *parent = dent->d_parent;
 	struct xe_gt *gt = extract_gt(parent);
 	unsigned int vfid = extract_vfid(parent);
 	ssize_t ret;
@@ -465,7 +466,7 @@ static ssize_t config_blob_write(struct file *file, const char __user *buf,
 				 size_t count, loff_t *pos)
 {
 	struct dentry *dent = file_dentry(file);
-	struct dentry *parent = dent->d_parent;
+	struct debugfs_node *parent = dent->d_parent;
 	struct xe_gt *gt = extract_gt(parent);
 	unsigned int vfid = extract_vfid(parent);
 	ssize_t ret;
@@ -509,17 +510,18 @@ static const struct file_operations config_blob_ops = {
  *
  * Register SR-IOV PF entries that are GT related and must be shown under GT debugfs.
  */
-void xe_gt_sriov_pf_debugfs_register(struct xe_gt *gt, struct dentry *root)
+void xe_gt_sriov_pf_debugfs_register(struct xe_gt *gt,
+				     struct debugfs_node *root)
 {
 	struct xe_device *xe = gt_to_xe(gt);
 	struct drm_minor *minor = xe->drm.primary;
 	int n, totalvfs = xe_sriov_pf_get_totalvfs(xe);
-	struct dentry *pfdentry;
-	struct dentry *vfdentry;
+	struct debugfs_node *pfdentry;
+	struct debugfs_node *vfdentry;
 	char buf[14]; /* should be enough up to "vf%u\0" for 2^32 - 1 */
 
 	xe_gt_assert(gt, IS_SRIOV_PF(xe));
-	xe_gt_assert(gt, root->d_inode->i_private == gt);
+	xe_gt_assert(gt, debugfs_node_inode(root)->i_private == gt);
 
 	/*
 	 *      /sys/kernel/debug/dri/0/
@@ -529,7 +531,7 @@ void xe_gt_sriov_pf_debugfs_register(struct xe_gt *gt, struct dentry *root)
 	pfdentry = debugfs_create_dir("pf", root);
 	if (IS_ERR(pfdentry))
 		return;
-	pfdentry->d_inode->i_private = gt;
+	debugfs_node_inode(pfdentry)->i_private = gt;
 
 	drm_debugfs_create_files(pf_info, ARRAY_SIZE(pf_info), pfdentry, minor);
 	pf_add_policy_attrs(gt, pfdentry);
@@ -546,7 +548,7 @@ void xe_gt_sriov_pf_debugfs_register(struct xe_gt *gt, struct dentry *root)
 		vfdentry = debugfs_create_dir(buf, root);
 		if (IS_ERR(vfdentry))
 			break;
-		vfdentry->d_inode->i_private = (void *)(uintptr_t)n;
+		debugfs_node_inode(vfdentry)->i_private = (void *)(uintptr_t)n;
 
 		pf_add_config_attrs(gt, vfdentry, VFID(n));
 		debugfs_create_file("control", 0600, vfdentry, NULL, &control_ops);
diff --git a/drivers/gpu/drm/xe/xe_gt_sriov_pf_debugfs.h b/drivers/gpu/drm/xe/xe_gt_sriov_pf_debugfs.h
index 038cc8ddc244..3f8be90e1494 100644
--- a/drivers/gpu/drm/xe/xe_gt_sriov_pf_debugfs.h
+++ b/drivers/gpu/drm/xe/xe_gt_sriov_pf_debugfs.h
@@ -8,11 +8,14 @@
 
 struct xe_gt;
 struct dentry;
+#define debugfs_node dentry
 
 #ifdef CONFIG_PCI_IOV
-void xe_gt_sriov_pf_debugfs_register(struct xe_gt *gt, struct dentry *root);
+void xe_gt_sriov_pf_debugfs_register(struct xe_gt *gt,
+				     struct debugfs_node *root);
 #else
-static inline void xe_gt_sriov_pf_debugfs_register(struct xe_gt *gt, struct dentry *root) { }
+static inline void xe_gt_sriov_pf_debugfs_register(struct xe_gt *gt,
+						   struct debugfs_node *root) { }
 #endif
 
 #endif
diff --git a/drivers/gpu/drm/xe/xe_gt_sriov_vf_debugfs.c b/drivers/gpu/drm/xe/xe_gt_sriov_vf_debugfs.c
index 2ed5b6780d30..a91525a6c8c0 100644
--- a/drivers/gpu/drm/xe/xe_gt_sriov_vf_debugfs.c
+++ b/drivers/gpu/drm/xe/xe_gt_sriov_vf_debugfs.c
@@ -49,14 +49,15 @@ static const struct drm_info_list vf_info[] = {
  *
  * Register SR-IOV VF entries that are GT related and must be shown under GT debugfs.
  */
-void xe_gt_sriov_vf_debugfs_register(struct xe_gt *gt, struct dentry *root)
+void xe_gt_sriov_vf_debugfs_register(struct xe_gt *gt,
+				     struct debugfs_node *root)
 {
 	struct xe_device *xe = gt_to_xe(gt);
 	struct drm_minor *minor = xe->drm.primary;
-	struct dentry *vfdentry;
+	struct debugfs_node *vfdentry;
 
 	xe_assert(xe, IS_SRIOV_VF(xe));
-	xe_assert(xe, root->d_inode->i_private == gt);
+	xe_assert(xe, debugfs_node_inode(root)->i_private == gt);
 
 	/*
 	 *      /sys/kernel/debug/dri/0/
@@ -66,7 +67,7 @@ void xe_gt_sriov_vf_debugfs_register(struct xe_gt *gt, struct dentry *root)
 	vfdentry = debugfs_create_dir("vf", root);
 	if (IS_ERR(vfdentry))
 		return;
-	vfdentry->d_inode->i_private = gt;
+	debugfs_node_inode(vfdentry)->i_private = gt;
 
 	drm_debugfs_create_files(vf_info, ARRAY_SIZE(vf_info), vfdentry, minor);
 }
diff --git a/drivers/gpu/drm/xe/xe_gt_sriov_vf_debugfs.h b/drivers/gpu/drm/xe/xe_gt_sriov_vf_debugfs.h
index b2cff7ef5c78..f772717cb19f 100644
--- a/drivers/gpu/drm/xe/xe_gt_sriov_vf_debugfs.h
+++ b/drivers/gpu/drm/xe/xe_gt_sriov_vf_debugfs.h
@@ -8,7 +8,9 @@
 
 struct xe_gt;
 struct dentry;
+#define debugfs_node dentry
 
-void xe_gt_sriov_vf_debugfs_register(struct xe_gt *gt, struct dentry *root);
+void xe_gt_sriov_vf_debugfs_register(struct xe_gt *gt,
+				     struct debugfs_node *root);
 
 #endif
diff --git a/drivers/gpu/drm/xe/xe_guc_debugfs.c b/drivers/gpu/drm/xe/xe_guc_debugfs.c
index 995b306aced7..9f86eb6848df 100644
--- a/drivers/gpu/drm/xe/xe_guc_debugfs.c
+++ b/drivers/gpu/drm/xe/xe_guc_debugfs.c
@@ -66,7 +66,7 @@ static const struct drm_info_list debugfs_list[] = {
 	{"guc_ctb", guc_ctb, 0},
 };
 
-void xe_guc_debugfs_register(struct xe_guc *guc, struct dentry *parent)
+void xe_guc_debugfs_register(struct xe_guc *guc, struct debugfs_node *parent)
 {
 	struct drm_minor *minor = guc_to_xe(guc)->drm.primary;
 	struct drm_info_list *local;
diff --git a/drivers/gpu/drm/xe/xe_guc_debugfs.h b/drivers/gpu/drm/xe/xe_guc_debugfs.h
index 4756dff26fca..89b0ad43bdbd 100644
--- a/drivers/gpu/drm/xe/xe_guc_debugfs.h
+++ b/drivers/gpu/drm/xe/xe_guc_debugfs.h
@@ -7,8 +7,9 @@
 #define _XE_GUC_DEBUGFS_H_
 
 struct dentry;
+#define debugfs_node dentry
 struct xe_guc;
 
-void xe_guc_debugfs_register(struct xe_guc *guc, struct dentry *parent);
+void xe_guc_debugfs_register(struct xe_guc *guc, struct debugfs_node *parent);
 
 #endif
diff --git a/drivers/gpu/drm/xe/xe_huc_debugfs.c b/drivers/gpu/drm/xe/xe_huc_debugfs.c
index 3a888a40188b..5329c72ef3f7 100644
--- a/drivers/gpu/drm/xe/xe_huc_debugfs.c
+++ b/drivers/gpu/drm/xe/xe_huc_debugfs.c
@@ -48,7 +48,7 @@ static const struct drm_info_list debugfs_list[] = {
 	{"huc_info", huc_info, 0},
 };
 
-void xe_huc_debugfs_register(struct xe_huc *huc, struct dentry *parent)
+void xe_huc_debugfs_register(struct xe_huc *huc, struct debugfs_node *parent)
 {
 	struct drm_minor *minor = huc_to_xe(huc)->drm.primary;
 	struct drm_info_list *local;
diff --git a/drivers/gpu/drm/xe/xe_huc_debugfs.h b/drivers/gpu/drm/xe/xe_huc_debugfs.h
index ec58f1818804..7fc23627c305 100644
--- a/drivers/gpu/drm/xe/xe_huc_debugfs.h
+++ b/drivers/gpu/drm/xe/xe_huc_debugfs.h
@@ -7,8 +7,9 @@
 #define _XE_HUC_DEBUGFS_H_
 
 struct dentry;
+#define debugfs_node dentry
 struct xe_huc;
 
-void xe_huc_debugfs_register(struct xe_huc *huc, struct dentry *parent);
+void xe_huc_debugfs_register(struct xe_huc *huc, struct debugfs_node *parent);
 
 #endif
diff --git a/drivers/gpu/drm/xe/xe_uc_debugfs.c b/drivers/gpu/drm/xe/xe_uc_debugfs.c
index 24a4209051ee..4d25127c3da5 100644
--- a/drivers/gpu/drm/xe/xe_uc_debugfs.c
+++ b/drivers/gpu/drm/xe/xe_uc_debugfs.c
@@ -14,9 +14,9 @@
 #include "xe_macros.h"
 #include "xe_uc_debugfs.h"
 
-void xe_uc_debugfs_register(struct xe_uc *uc, struct dentry *parent)
+void xe_uc_debugfs_register(struct xe_uc *uc, struct debugfs_node *parent)
 {
-	struct dentry *root;
+	struct debugfs_node *root;
 
 	root = debugfs_create_dir("uc", parent);
 	if (IS_ERR(root)) {
diff --git a/drivers/gpu/drm/xe/xe_uc_debugfs.h b/drivers/gpu/drm/xe/xe_uc_debugfs.h
index a13382df2bd7..7373c5c97774 100644
--- a/drivers/gpu/drm/xe/xe_uc_debugfs.h
+++ b/drivers/gpu/drm/xe/xe_uc_debugfs.h
@@ -7,8 +7,9 @@
 #define _XE_UC_DEBUGFS_H_
 
 struct dentry;
+#define debugfs_node dentry
 struct xe_uc;
 
-void xe_uc_debugfs_register(struct xe_uc *uc, struct dentry *parent);
+void xe_uc_debugfs_register(struct xe_uc *uc, struct debugfs_node *parent);
 
 #endif
diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
index 979f6d3239ba..9f7bb664cce5 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
@@ -2303,10 +2303,10 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_zynqmp_dp_ignore_hpd, zynqmp_dp_ignore_hpd_get,
 			 zynqmp_dp_ignore_hpd_set, "%llu\n");
 
 static void zynqmp_dp_bridge_debugfs_init(struct drm_bridge *bridge,
-					  struct dentry *root)
+					  struct debugfs_node *root)
 {
 	struct zynqmp_dp *dp = bridge_to_dp(bridge);
-	struct dentry *test;
+	struct debugfs_node *test;
 	int i;
 
 	dp->test.bw_code = DP_LINK_BW_5_4;
diff --git a/drivers/gpu/host1x/debug.c b/drivers/gpu/host1x/debug.c
index a18cc8d8caf5..e9171bde1bc7 100644
--- a/drivers/gpu/host1x/debug.c
+++ b/drivers/gpu/host1x/debug.c
@@ -169,7 +169,7 @@ DEFINE_SHOW_ATTRIBUTE(host1x_debug);
 
 static void host1x_debugfs_init(struct host1x *host1x)
 {
-	struct dentry *de = debugfs_create_dir("tegra-host1x", NULL);
+	struct debugfs_node *de = debugfs_create_dir("tegra-host1x", NULL);
 
 	/* Store the created entry */
 	host1x->debugfs = de;
diff --git a/drivers/gpu/host1x/dev.h b/drivers/gpu/host1x/dev.h
index d3855a1c6b47..afd56f7ec84c 100644
--- a/drivers/gpu/host1x/dev.h
+++ b/drivers/gpu/host1x/dev.h
@@ -28,6 +28,7 @@ struct host1x_job;
 struct push_buffer;
 struct output;
 struct dentry;
+#define debugfs_node dentry
 
 struct host1x_channel_ops {
 	int (*init)(struct host1x_channel *channel, struct host1x *host,
@@ -162,7 +163,7 @@ struct host1x {
 	struct host1x_channel_list channel_list;
 	struct host1x_memory_context_list context_list;
 
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 
 	struct mutex devices_lock;
 	struct list_head devices;
@@ -329,7 +330,8 @@ static inline void host1x_hw_pushbuffer_init(struct host1x *host,
 	host->cdma_pb_op->init(pb);
 }
 
-static inline void host1x_hw_debug_init(struct host1x *host, struct dentry *de)
+static inline void host1x_hw_debug_init(struct host1x *host,
+				        struct debugfs_node *de)
 {
 	if (host->debug_op && host->debug_op->debug_init)
 		host->debug_op->debug_init(de);
diff --git a/drivers/gpu/vga/vga_switcheroo.c b/drivers/gpu/vga/vga_switcheroo.c
index 18f2c92beff8..766d8399699f 100644
--- a/drivers/gpu/vga/vga_switcheroo.c
+++ b/drivers/gpu/vga/vga_switcheroo.c
@@ -151,7 +151,7 @@ struct vgasr_priv {
 	bool delayed_switch_active;
 	enum vga_switcheroo_client_id delayed_client_id;
 
-	struct dentry *debugfs_root;
+	struct debugfs_node *debugfs_root;
 
 	int registered_clients;
 	struct list_head clients;
diff --git a/drivers/greybus/debugfs.c b/drivers/greybus/debugfs.c
index e102d7badb9d..f2a03b731ef5 100644
--- a/drivers/greybus/debugfs.c
+++ b/drivers/greybus/debugfs.c
@@ -9,7 +9,7 @@
 #include <linux/debugfs.h>
 #include <linux/greybus.h>
 
-static struct dentry *gb_debug_root;
+static struct debugfs_node *gb_debug_root;
 
 void __init gb_debugfs_init(void)
 {
@@ -22,7 +22,7 @@ void gb_debugfs_cleanup(void)
 	gb_debug_root = NULL;
 }
 
-struct dentry *gb_debugfs_get(void)
+struct debugfs_node *gb_debugfs_get(void)
 {
 	return gb_debug_root;
 }
diff --git a/drivers/greybus/es2.c b/drivers/greybus/es2.c
index 7630a36ecf81..27d775d2b93b 100644
--- a/drivers/greybus/es2.c
+++ b/drivers/greybus/es2.c
@@ -112,8 +112,8 @@ struct es2_ap_dev {
 	bool cdsi1_in_use;
 
 	struct task_struct *apb_log_task;
-	struct dentry *apb_log_dentry;
-	struct dentry *apb_log_enable_dentry;
+	struct debugfs_node *apb_log_dentry;
+	struct debugfs_node *apb_log_enable_dentry;
 	DECLARE_KFIFO(apb_log_fifo, char, APB1_LOG_SIZE);
 
 	__u8 arpc_endpoint_in;
diff --git a/drivers/greybus/svc.c b/drivers/greybus/svc.c
index 4256467fcd35..51c71dcc2342 100644
--- a/drivers/greybus/svc.c
+++ b/drivers/greybus/svc.c
@@ -760,7 +760,7 @@ static void gb_svc_pwrmon_debugfs_init(struct gb_svc *svc)
 {
 	int i;
 	size_t bufsize;
-	struct dentry *dent;
+	struct debugfs_node *dent;
 	struct gb_svc_pwrmon_rail_names_get_response *rail_names;
 	u8 rail_count;
 
@@ -790,7 +790,7 @@ static void gb_svc_pwrmon_debugfs_init(struct gb_svc *svc)
 		goto err_pwrmon_debugfs_free;
 
 	for (i = 0; i < rail_count; i++) {
-		struct dentry *dir;
+		struct debugfs_node *dir;
 		struct svc_debugfs_pwrmon_rail *rail = &svc->pwrmon_rails[i];
 		char fname[GB_SVC_PWRMON_RAIL_NAME_BUFSIZE];
 
diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index 541d682af15a..cbac764cc1e7 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -28,7 +28,7 @@
 #include <linux/hid.h>
 #include <linux/hid-debug.h>
 
-static struct dentry *hid_debug_root;
+static struct debugfs_node *hid_debug_root;
 
 struct hid_usage_entry {
 	unsigned  page;
diff --git a/drivers/hid/hid-picolcd.h b/drivers/hid/hid-picolcd.h
index 57c9d0a6757c..588a295c4b29 100644
--- a/drivers/hid/hid-picolcd.h
+++ b/drivers/hid/hid-picolcd.h
@@ -64,9 +64,9 @@ struct picolcd_pending {
 struct picolcd_data {
 	struct hid_device *hdev;
 #ifdef CONFIG_DEBUG_FS
-	struct dentry *debug_reset;
-	struct dentry *debug_eeprom;
-	struct dentry *debug_flash;
+	struct debugfs_node *debug_reset;
+	struct debugfs_node *debug_eeprom;
+	struct debugfs_node *debug_flash;
 	struct mutex mutex_flash;
 	int addr_sz;
 #endif
diff --git a/drivers/hid/hid-picolcd_debugfs.c b/drivers/hid/hid-picolcd_debugfs.c
index d01176da8896..6bbc0adbe65b 100644
--- a/drivers/hid/hid-picolcd_debugfs.c
+++ b/drivers/hid/hid-picolcd_debugfs.c
@@ -869,7 +869,7 @@ void picolcd_init_devfs(struct picolcd_data *data,
 
 void picolcd_exit_devfs(struct picolcd_data *data)
 {
-	struct dentry *dent;
+	struct debugfs_node *dent;
 
 	dent = data->debug_reset;
 	data->debug_reset = NULL;
diff --git a/drivers/hid/hid-wiimote-debug.c b/drivers/hid/hid-wiimote-debug.c
index 00f9be55f148..fbc036e6eae7 100644
--- a/drivers/hid/hid-wiimote-debug.c
+++ b/drivers/hid/hid-wiimote-debug.c
@@ -16,8 +16,8 @@
 
 struct wiimote_debug {
 	struct wiimote_data *wdata;
-	struct dentry *eeprom;
-	struct dentry *drm;
+	struct debugfs_node *eeprom;
+	struct debugfs_node *drm;
 };
 
 static ssize_t wiidebug_eeprom_read(struct file *f, char __user *u, size_t s,
diff --git a/drivers/hsi/controllers/omap_ssi.h b/drivers/hsi/controllers/omap_ssi.h
index c72f74b5bb42..02600c655f19 100644
--- a/drivers/hsi/controllers/omap_ssi.h
+++ b/drivers/hsi/controllers/omap_ssi.h
@@ -101,7 +101,7 @@ struct omap_ssi_port {
 	u32			loss_count;
 	u32			port_id;
 #ifdef CONFIG_DEBUG_FS
-	struct dentry *dir;
+	struct debugfs_node *dir;
 #endif
 };
 
@@ -152,7 +152,7 @@ struct omap_ssi_controller {
 	int			(*get_loss)(struct device *dev);
 	struct omap_ssi_port	**port;
 #ifdef CONFIG_DEBUG_FS
-	struct dentry *dir;
+	struct debugfs_node *dir;
 #endif
 };
 
diff --git a/drivers/hsi/controllers/omap_ssi_core.c b/drivers/hsi/controllers/omap_ssi_core.c
index eeacc427fd65..f16f1dc4c6a2 100644
--- a/drivers/hsi/controllers/omap_ssi_core.c
+++ b/drivers/hsi/controllers/omap_ssi_core.c
@@ -112,7 +112,7 @@ DEFINE_SHOW_ATTRIBUTE(ssi_gdd_regs);
 static int ssi_debug_add_ctrl(struct hsi_controller *ssi)
 {
 	struct omap_ssi_controller *omap_ssi = hsi_controller_drvdata(ssi);
-	struct dentry *dir;
+	struct debugfs_node *dir;
 
 	/* SSI controller */
 	omap_ssi->dir = debugfs_create_dir(dev_name(&ssi->device), NULL);
diff --git a/drivers/hsi/controllers/omap_ssi_port.c b/drivers/hsi/controllers/omap_ssi_port.c
index aeb92b803a17..c6bd4903a872 100644
--- a/drivers/hsi/controllers/omap_ssi_port.c
+++ b/drivers/hsi/controllers/omap_ssi_port.c
@@ -152,7 +152,7 @@ static int ssi_div_set(void *data, u64 val)
 DEFINE_DEBUGFS_ATTRIBUTE(ssi_sst_div_fops, ssi_div_get, ssi_div_set, "%llu\n");
 
 static void ssi_debug_add_port(struct omap_ssi_port *omap_port,
-				     struct dentry *dir)
+				     struct debugfs_node *dir)
 {
 	struct hsi_port *port = to_hsi_port(omap_port->dev);
 
diff --git a/drivers/hte/hte.c b/drivers/hte/hte.c
index 23a6eeb8c506..b77844390d7f 100644
--- a/drivers/hte/hte.c
+++ b/drivers/hte/hte.c
@@ -62,7 +62,7 @@ struct hte_ts_info {
 	spinlock_t slock;
 	struct work_struct cb_work;
 	struct mutex req_mlock;
-	struct dentry *ts_dbg_root;
+	struct debugfs_node *ts_dbg_root;
 	struct hte_device *gdev;
 	void *cl_data;
 };
@@ -82,7 +82,7 @@ struct hte_device {
 	u32 nlines;
 	atomic_t ts_req;
 	struct device *sdev;
-	struct dentry *dbg_root;
+	struct debugfs_node *dbg_root;
 	struct list_head list;
 	struct hte_chip *chip;
 	struct module *owner;
@@ -91,7 +91,7 @@ struct hte_device {
 
 #ifdef CONFIG_DEBUG_FS
 
-static struct dentry *hte_root;
+static struct debugfs_node *hte_root;
 
 static int __init hte_subsys_dbgfs_init(void)
 {
diff --git a/drivers/hv/hv_debugfs.c b/drivers/hv/hv_debugfs.c
index ccf752b6659a..c9a1f4ffb980 100644
--- a/drivers/hv/hv_debugfs.c
+++ b/drivers/hv/hv_debugfs.c
@@ -11,7 +11,7 @@
 
 #include "hyperv_vmbus.h"
 
-static struct dentry *hv_debug_root;
+static struct debugfs_node *hv_debug_root;
 
 static int hv_debugfs_delay_get(void *data, u64 *val)
 {
@@ -51,14 +51,15 @@ DEFINE_DEBUGFS_ATTRIBUTE(hv_debugfs_state_fops, hv_debugfs_state_get,
 			 hv_debugfs_state_set, "%llu\n");
 
 /* Setup delay files to store test values */
-static int hv_debug_delay_files(struct hv_device *dev, struct dentry *root)
+static int hv_debug_delay_files(struct hv_device *dev,
+				struct debugfs_node *root)
 {
 	struct vmbus_channel *channel = dev->channel;
 	char *buffer = "fuzz_test_buffer_interrupt_delay";
 	char *message = "fuzz_test_message_delay";
 	int *buffer_val = &channel->fuzz_testing_interrupt_delay;
 	int *message_val = &channel->fuzz_testing_message_delay;
-	struct dentry *buffer_file, *message_file;
+	struct debugfs_node *buffer_file, *message_file;
 
 	buffer_file = debugfs_create_file(buffer, 0644, root,
 					  buffer_val,
@@ -80,12 +81,13 @@ static int hv_debug_delay_files(struct hv_device *dev, struct dentry *root)
 }
 
 /* Setup test state value for vmbus device */
-static int hv_debug_set_test_state(struct hv_device *dev, struct dentry *root)
+static int hv_debug_set_test_state(struct hv_device *dev,
+				   struct debugfs_node *root)
 {
 	struct vmbus_channel *channel = dev->channel;
 	bool *state = &channel->fuzz_testing_state;
 	char *status = "fuzz_test_state";
-	struct dentry *test_state;
+	struct debugfs_node *test_state;
 
 	test_state = debugfs_create_file(status, 0644, root,
 					 state,
@@ -99,7 +101,8 @@ static int hv_debug_set_test_state(struct hv_device *dev, struct dentry *root)
 }
 
 /* Bind hv device to a dentry for debugfs */
-static void hv_debug_set_dir_dentry(struct hv_device *dev, struct dentry *root)
+static void hv_debug_set_dir_dentry(struct hv_device *dev,
+				    struct debugfs_node *root)
 {
 	if (hv_debug_root)
 		dev->debug_dir = root;
@@ -110,7 +113,7 @@ int hv_debug_add_dev_dir(struct hv_device *dev)
 {
 	const char *device = dev_name(&dev->device);
 	char *delay_name = "delay";
-	struct dentry *delay, *dev_root;
+	struct debugfs_node *delay, *dev_root;
 	int ret;
 
 	if (!IS_ERR(hv_debug_root)) {
diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index 0dcb8a3a691d..b0940fe17b1f 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -550,7 +550,7 @@ static struct aqc_fan_structure_offsets aqc_general_fan_structure = {
 struct aqc_data {
 	struct hid_device *hdev;
 	struct device *hwmon_dev;
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 	struct mutex mutex;	/* Used for locking access when reading and writing PWM values */
 	enum kinds kind;
 	const char *name;
diff --git a/drivers/hwmon/asus_atk0110.c b/drivers/hwmon/asus_atk0110.c
index c80350e499e9..f1862b8c37c8 100644
--- a/drivers/hwmon/asus_atk0110.c
+++ b/drivers/hwmon/asus_atk0110.c
@@ -788,7 +788,7 @@ static const struct file_operations atk_debugfs_ggrp_fops = {
 
 static void atk_debugfs_init(struct atk_data *data)
 {
-	struct dentry *d;
+	struct debugfs_node *d;
 
 	data->debugfs.id = 0;
 
diff --git a/drivers/hwmon/corsair-cpro.c b/drivers/hwmon/corsair-cpro.c
index e1a7f7aa7f80..a039107c2d4c 100644
--- a/drivers/hwmon/corsair-cpro.c
+++ b/drivers/hwmon/corsair-cpro.c
@@ -82,7 +82,7 @@
 struct ccp_device {
 	struct hid_device *hdev;
 	struct device *hwmon_dev;
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 	/* For reinitializing the completion below */
 	spinlock_t wait_input_report_lock;
 	struct completion wait_input_report;
diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
index f8f22b8a67cd..f54958c3c276 100644
--- a/drivers/hwmon/corsair-psu.c
+++ b/drivers/hwmon/corsair-psu.c
@@ -122,7 +122,7 @@ static const char *const label_amps[] = {
 struct corsairpsu_data {
 	struct hid_device *hdev;
 	struct device *hwmon_dev;
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 	struct completion wait_completion;
 	struct mutex lock; /* for locking access to cmd_buffer */
 	u8 *cmd_buffer;
diff --git a/drivers/hwmon/gigabyte_waterforce.c b/drivers/hwmon/gigabyte_waterforce.c
index 27487e215bdd..f4b2e2eff338 100644
--- a/drivers/hwmon/gigabyte_waterforce.c
+++ b/drivers/hwmon/gigabyte_waterforce.c
@@ -50,7 +50,7 @@ static const char *const waterforce_speed_label[] = {
 struct waterforce_data {
 	struct hid_device *hdev;
 	struct device *hwmon_dev;
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 	/* For locking access to buffer */
 	struct mutex buffer_lock;
 	/* For queueing multiple readers */
diff --git a/drivers/hwmon/hp-wmi-sensors.c b/drivers/hwmon/hp-wmi-sensors.c
index d6bdad26feb1..68200786ac25 100644
--- a/drivers/hwmon/hp-wmi-sensors.c
+++ b/drivers/hwmon/hp-wmi-sensors.c
@@ -1317,9 +1317,9 @@ static void hp_wmi_debugfs_init(struct device *dev, struct hp_wmi_info *info,
 {
 	struct hp_wmi_numeric_sensor *nsensor;
 	char buf[HP_WMI_MAX_STR_SIZE];
-	struct dentry *debugfs;
-	struct dentry *entries;
-	struct dentry *dir;
+	struct debugfs_node *debugfs;
+	struct debugfs_node *entries;
+	struct debugfs_node *dir;
 	int err;
 	u8 i;
 
diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index 1bf479a0f793..a05f512f945f 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -128,7 +128,7 @@ struct ina3221_data {
 	struct regmap_field *fields[F_MAX_FIELDS];
 	struct ina3221_input inputs[INA3221_NUM_CHANNELS];
 	struct mutex lock;
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 	u32 reg_config;
 	int summation_shunt_resistor;
 	u32 summation_channel_control;
diff --git a/drivers/hwmon/isl28022.c b/drivers/hwmon/isl28022.c
index 3f9b4520b53e..efda231f7600 100644
--- a/drivers/hwmon/isl28022.c
+++ b/drivers/hwmon/isl28022.c
@@ -324,7 +324,7 @@ static int shunt_voltage_show(struct seq_file *seqf, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(shunt_voltage);
 
-static struct dentry *isl28022_debugfs_root;
+static struct debugfs_node *isl28022_debugfs_root;
 
 static void isl28022_debugfs_remove(void *res)
 {
@@ -334,7 +334,7 @@ static void isl28022_debugfs_remove(void *res)
 static void isl28022_debugfs_init(struct i2c_client *client, struct isl28022_data *data)
 {
 	char name[16];
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 
 	scnprintf(name, sizeof(name), "%d-%04hx", client->adapter->nr, client->addr);
 
diff --git a/drivers/hwmon/ltc4282.c b/drivers/hwmon/ltc4282.c
index 4f608a3790fb..be8fb2661614 100644
--- a/drivers/hwmon/ltc4282.c
+++ b/drivers/hwmon/ltc4282.c
@@ -1684,7 +1684,7 @@ static void ltc4282_debugfs_init(struct ltc4282_state *st,
 				 const struct device *hwmon)
 {
 	const char *debugfs_name;
-	struct dentry *dentry;
+	struct debugfs_node *dentry;
 	int ret;
 
 	if (!IS_ENABLED(CONFIG_DEBUG_FS))
diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
index 7848198f8996..da4da74252cd 100644
--- a/drivers/hwmon/mr75203.c
+++ b/drivers/hwmon/mr75203.c
@@ -172,7 +172,7 @@ struct pvt_device {
 	struct regmap		*v_map;
 	struct clk		*clk;
 	struct reset_control	*rst;
-	struct dentry		*dbgfs_dir;
+	struct debugfs_node *dbgfs_dir;
 	struct voltage_device	*vd;
 	struct voltage_channels	vm_channels;
 	struct temp_coeff	ts_coeff;
diff --git a/drivers/hwmon/nzxt-kraken3.c b/drivers/hwmon/nzxt-kraken3.c
index d00409bcab93..eb6da87ef265 100644
--- a/drivers/hwmon/nzxt-kraken3.c
+++ b/drivers/hwmon/nzxt-kraken3.c
@@ -93,7 +93,7 @@ struct kraken3_channel_info {
 struct kraken3_data {
 	struct hid_device *hdev;
 	struct device *hwmon_dev;
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 	struct mutex buffer_lock;	/* For locking access to buffer */
 	struct mutex z53_status_request_lock;
 	struct completion fw_version_processed;
diff --git a/drivers/hwmon/pmbus/acbel-fsg032.c b/drivers/hwmon/pmbus/acbel-fsg032.c
index 9f07fb4abaff..6fc29dca847a 100644
--- a/drivers/hwmon/pmbus/acbel-fsg032.c
+++ b/drivers/hwmon/pmbus/acbel-fsg032.c
@@ -40,7 +40,7 @@ static const struct file_operations acbel_debugfs_ops = {
 
 static void acbel_fsg032_init_debugfs(struct i2c_client *client)
 {
-	struct dentry *debugfs = pmbus_get_debugfs_dir(client);
+	struct debugfs_node *debugfs = pmbus_get_debugfs_dir(client);
 
 	if (!debugfs)
 		return;
diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index d90f8f80be8e..46de1d360079 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -54,7 +54,7 @@ struct adm1266_data {
 	struct gpio_chip gc;
 	const char *gpio_names[ADM1266_GPIO_NR + ADM1266_PDIO_NR];
 	struct i2c_client *client;
-	struct dentry *debugfs_dir;
+	struct debugfs_node *debugfs_dir;
 	struct nvmem_config nvmem_config;
 	struct nvmem_device *nvmem;
 	u8 *dev_mem;
@@ -333,7 +333,7 @@ static int adm1266_state_read(struct seq_file *s, void *pdata)
 
 static void adm1266_init_debugfs(struct adm1266_data *data)
 {
-	struct dentry *root;
+	struct debugfs_node *root;
 
 	root = pmbus_get_debugfs_dir(data->client);
 	if (!root)
diff --git a/drivers/hwmon/pmbus/dps920ab.c b/drivers/hwmon/pmbus/dps920ab.c
index 325111a955e6..4669c658a52e 100644
--- a/drivers/hwmon/pmbus/dps920ab.c
+++ b/drivers/hwmon/pmbus/dps920ab.c
@@ -111,8 +111,8 @@ DEFINE_SHOW_ATTRIBUTE(dps920ab_mfr_model);
 
 static void dps920ab_init_debugfs(struct dps920ab_data *data, struct i2c_client *client)
 {
-	struct dentry *debugfs_dir;
-	struct dentry *root;
+	struct debugfs_node *debugfs_dir;
+	struct debugfs_node *root;
 
 	root = pmbus_get_debugfs_dir(client);
 	if (!root)
diff --git a/drivers/hwmon/pmbus/ibm-cffps.c b/drivers/hwmon/pmbus/ibm-cffps.c
index d05ef7a968a9..b47fd2d452c3 100644
--- a/drivers/hwmon/pmbus/ibm-cffps.c
+++ b/drivers/hwmon/pmbus/ibm-cffps.c
@@ -483,7 +483,7 @@ static int ibm_cffps_probe(struct i2c_client *client)
 {
 	int i, rc;
 	enum versions vs = cffps_unknown;
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 	struct ibm_cffps *psu;
 	const void *md = of_device_get_match_data(&client->dev);
 	const struct i2c_device_id *id;
diff --git a/drivers/hwmon/pmbus/max20730.c b/drivers/hwmon/pmbus/max20730.c
index 95869d198ecf..76bab539e14b 100644
--- a/drivers/hwmon/pmbus/max20730.c
+++ b/drivers/hwmon/pmbus/max20730.c
@@ -306,8 +306,8 @@ static int max20730_init_debugfs(struct i2c_client *client,
 				 struct max20730_data *data)
 {
 	int ret, i;
-	struct dentry *debugfs;
-	struct dentry *max20730_dir;
+	struct debugfs_node *debugfs;
+	struct debugfs_node *max20730_dir;
 	struct max20730_debugfs_data *psu;
 
 	ret = i2c_smbus_read_word_data(client, MAX20730_MFR_DEVSET2);
diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index ddb19c9726d6..b18776a6fcb7 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -553,6 +553,6 @@ int pmbus_lock_interruptible(struct i2c_client *client);
 void pmbus_unlock(struct i2c_client *client);
 int pmbus_update_fan(struct i2c_client *client, int page, int id,
 		     u8 config, u8 mask, u16 command);
-struct dentry *pmbus_get_debugfs_dir(struct i2c_client *client);
+struct debugfs_node *pmbus_get_debugfs_dir(struct i2c_client *client);
 
 #endif /* PMBUS_H */
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 787683e83db6..4e8140e15c96 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -100,7 +100,7 @@ struct pmbus_data {
 	int num_attributes;
 	struct attribute_group group;
 	const struct attribute_group **groups;
-	struct dentry *debugfs;		/* debugfs device directory */
+	struct debugfs_node *debugfs;		/* debugfs device directory */
 
 	struct pmbus_sensor *sensors;
 
@@ -3426,7 +3426,7 @@ static int pmbus_irq_setup(struct i2c_client *client, struct pmbus_data *data)
 	return 0;
 }
 
-static struct dentry *pmbus_debugfs_dir;	/* pmbus debugfs directory */
+static struct debugfs_node *pmbus_debugfs_dir;	/* pmbus debugfs directory */
 
 #if IS_ENABLED(CONFIG_DEBUG_FS)
 static int pmbus_debugfs_get(void *data, u64 *val)
@@ -3506,7 +3506,7 @@ static const struct file_operations pmbus_debugfs_ops_mfr = {
 
 static void pmbus_remove_debugfs(void *data)
 {
-	struct dentry *entry = data;
+	struct debugfs_node *entry = data;
 
 	debugfs_remove_recursive(entry);
 }
@@ -3823,7 +3823,7 @@ int pmbus_do_probe(struct i2c_client *client, struct pmbus_driver_info *info)
 }
 EXPORT_SYMBOL_NS_GPL(pmbus_do_probe, "PMBUS");
 
-struct dentry *pmbus_get_debugfs_dir(struct i2c_client *client)
+struct debugfs_node *pmbus_get_debugfs_dir(struct i2c_client *client)
 {
 	struct pmbus_data *data = i2c_get_clientdata(client);
 
diff --git a/drivers/hwmon/pmbus/q54sj108a2.c b/drivers/hwmon/pmbus/q54sj108a2.c
index 4d7086d83aa3..ec545fdea73f 100644
--- a/drivers/hwmon/pmbus/q54sj108a2.c
+++ b/drivers/hwmon/pmbus/q54sj108a2.c
@@ -280,8 +280,8 @@ static int q54sj108a2_probe(struct i2c_client *client)
 	u8 buf[I2C_SMBUS_BLOCK_MAX + 1];
 	enum chips chip_id;
 	int ret, i;
-	struct dentry *debugfs;
-	struct dentry *q54sj108a2_dir;
+	struct debugfs_node *debugfs;
+	struct debugfs_node *q54sj108a2_dir;
 	struct q54sj108a2_data *psu;
 
 	if (!i2c_check_functionality(client->adapter,
diff --git a/drivers/hwmon/pmbus/ucd9000.c b/drivers/hwmon/pmbus/ucd9000.c
index 9b0eadc81a2e..535823626c5d 100644
--- a/drivers/hwmon/pmbus/ucd9000.c
+++ b/drivers/hwmon/pmbus/ucd9000.c
@@ -66,7 +66,7 @@ struct ucd9000_data {
 #ifdef CONFIG_GPIOLIB
 	struct gpio_chip gpio;
 #endif
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 };
 #define to_ucd9000_data(_info) container_of(_info, struct ucd9000_data, info)
 
@@ -444,7 +444,7 @@ static int ucd9000_init_debugfs(struct i2c_client *client,
 				const struct i2c_device_id *mid,
 				struct ucd9000_data *data)
 {
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 	struct ucd9000_debugfs_entry *entries;
 	int i, gpi_count;
 	char name[UCD9000_DEBUGFS_NAME_LEN];
diff --git a/drivers/hwmon/pt5161l.c b/drivers/hwmon/pt5161l.c
index a9f0b23f9e76..912037398644 100644
--- a/drivers/hwmon/pt5161l.c
+++ b/drivers/hwmon/pt5161l.c
@@ -63,7 +63,7 @@ struct pt5161l_fw_ver {
 /* Each client has this additional data */
 struct pt5161l_data {
 	struct i2c_client *client;
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 	struct pt5161l_fw_ver fw_ver;
 	struct mutex lock; /* for atomic I2C transactions */
 	bool init_done;
@@ -72,7 +72,7 @@ struct pt5161l_data {
 	bool mm_wide_reg_access; /* MM assisted wide register access */
 };
 
-static struct dentry *pt5161l_debugfs_dir;
+static struct debugfs_node *pt5161l_debugfs_dir;
 
 /*
  * Write multiple data bytes to Aries over I2C
diff --git a/drivers/hwmon/sg2042-mcu.c b/drivers/hwmon/sg2042-mcu.c
index aa3fb773602c..358ac13bb8ff 100644
--- a/drivers/hwmon/sg2042-mcu.c
+++ b/drivers/hwmon/sg2042-mcu.c
@@ -50,11 +50,11 @@
 
 struct sg2042_mcu_data {
 	struct i2c_client	*client;
-	struct dentry		*debugfs;
+	struct debugfs_node *debugfs;
 	struct mutex		mutex;
 };
 
-static struct dentry *sgmcu_debugfs;
+static struct debugfs_node *sgmcu_debugfs;
 
 static ssize_t reset_count_show(struct device *dev,
 				struct device_attribute *attr,
diff --git a/drivers/hwmon/sht3x.c b/drivers/hwmon/sht3x.c
index 650b0bcc2359..f50b79557458 100644
--- a/drivers/hwmon/sht3x.c
+++ b/drivers/hwmon/sht3x.c
@@ -44,7 +44,7 @@ static const unsigned char sht3x_cmd_read_status_reg[]         = { 0xf3, 0x2d };
 static const unsigned char sht3x_cmd_clear_status_reg[]        = { 0x30, 0x41 };
 static const unsigned char sht3x_cmd_read_serial_number[]      = { 0x37, 0x80 };
 
-static struct dentry *debugfs;
+static struct debugfs_node *debugfs;
 
 /* delays for single-shot mode i2c commands, both in us */
 #define SHT3X_SINGLE_WAIT_TIME_HPM  15000
@@ -167,7 +167,7 @@ struct sht3x_data {
 	enum sht3x_chips chip_id;
 	struct mutex i2c_lock; /* lock for sending i2c commands */
 	struct mutex data_lock; /* lock for updating driver data */
-	struct dentry *sensor_dir;
+	struct debugfs_node *sensor_dir;
 
 	u8 mode;
 	const unsigned char *command;
diff --git a/drivers/hwmon/tps23861.c b/drivers/hwmon/tps23861.c
index 80fb03f30c30..29cf6b5ce596 100644
--- a/drivers/hwmon/tps23861.c
+++ b/drivers/hwmon/tps23861.c
@@ -114,7 +114,7 @@ struct tps23861_data {
 	struct regmap *regmap;
 	u32 shunt_resistor;
 	struct i2c_client *client;
-	struct dentry *debugfs_dir;
+	struct debugfs_node *debugfs_dir;
 };
 
 static const struct regmap_config tps23861_regmap_config = {
diff --git a/drivers/hwspinlock/sun6i_hwspinlock.c b/drivers/hwspinlock/sun6i_hwspinlock.c
index c2d314588046..941a3df174a9 100644
--- a/drivers/hwspinlock/sun6i_hwspinlock.c
+++ b/drivers/hwspinlock/sun6i_hwspinlock.c
@@ -30,7 +30,7 @@ struct sun6i_hwspinlock_data {
 	struct hwspinlock_device *bank;
 	struct reset_control *reset;
 	struct clk *ahb_clk;
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 	int nlocks;
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
index 342c3aaf414d..07a31a53e2ae 100644
--- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
+++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
@@ -106,7 +106,7 @@ struct debug_drvdata {
 static DEFINE_MUTEX(debug_lock);
 static DEFINE_PER_CPU(struct debug_drvdata *, debug_drvdata);
 static int debug_count;
-static struct dentry *debug_debugfs_dir;
+static struct debugfs_node *debug_debugfs_dir;
 
 static bool debug_enable = IS_ENABLED(CONFIG_CORESIGHT_CPU_DEBUG_DEFAULT_ON);
 module_param_named(enable, debug_enable, bool, 0600);
diff --git a/drivers/hwtracing/intel_th/debug.c b/drivers/hwtracing/intel_th/debug.c
index ff79063118a0..b84e9fa94038 100644
--- a/drivers/hwtracing/intel_th/debug.c
+++ b/drivers/hwtracing/intel_th/debug.c
@@ -12,7 +12,7 @@
 #include "intel_th.h"
 #include "debug.h"
 
-struct dentry *intel_th_dbg;
+struct debugfs_node *intel_th_dbg;
 
 void intel_th_debug_init(void)
 {
diff --git a/drivers/hwtracing/intel_th/debug.h b/drivers/hwtracing/intel_th/debug.h
index 78bd7e4bf9ce..dd24a570e42d 100644
--- a/drivers/hwtracing/intel_th/debug.h
+++ b/drivers/hwtracing/intel_th/debug.h
@@ -9,7 +9,7 @@
 #define __INTEL_TH_DEBUG_H__
 
 #ifdef CONFIG_INTEL_TH_DEBUG
-extern struct dentry *intel_th_dbg;
+extern struct debugfs_node *intel_th_dbg;
 
 void intel_th_debug_init(void);
 void intel_th_debug_done(void);
diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 35a221e2c11c..e7ee12a4f790 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -68,7 +68,7 @@ static int i2c_detect(struct i2c_adapter *adapter, struct i2c_driver *driver);
 static DEFINE_STATIC_KEY_FALSE(i2c_trace_msg_key);
 static bool is_registered;
 
-static struct dentry *i2c_debugfs_root;
+static struct debugfs_node *i2c_debugfs_root;
 
 int i2c_transfer_trace_reg(void)
 {
diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index f30119b42ba0..f5e94da71898 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -1144,7 +1144,7 @@ static const struct file_operations ad9467_calib_table_fops = {
 
 static void ad9467_debugfs_init(struct iio_dev *indio_dev)
 {
-	struct dentry *d = iio_get_debugfs_dentry(indio_dev);
+	struct debugfs_node *d = iio_get_debugfs_dentry(indio_dev);
 	struct ad9467_state *st = iio_priv(indio_dev);
 	char attr_name[32];
 	unsigned int chan;
diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 9d3b23efcc06..7c6288471946 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -1883,7 +1883,7 @@ static const struct iio_chan_spec_ext_info stm32_adc_ext_info[] = {
 static void stm32_adc_debugfs_init(struct iio_dev *indio_dev)
 {
 	struct stm32_adc *adc = iio_priv(indio_dev);
-	struct dentry *d = iio_get_debugfs_dentry(indio_dev);
+	struct debugfs_node *d = iio_get_debugfs_dentry(indio_dev);
 	struct stm32_adc_calib *cal = &adc->cal;
 	char buf[16];
 	unsigned int i;
diff --git a/drivers/iio/gyro/adis16136.c b/drivers/iio/gyro/adis16136.c
index 369c7428e1ef..01dd1c4580f9 100644
--- a/drivers/iio/gyro/adis16136.c
+++ b/drivers/iio/gyro/adis16136.c
@@ -143,7 +143,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(adis16136_flash_count_fops,
 static int adis16136_debugfs_init(struct iio_dev *indio_dev)
 {
 	struct adis16136 *adis16136 = iio_priv(indio_dev);
-	struct dentry *d = iio_get_debugfs_dentry(indio_dev);
+	struct debugfs_node *d = iio_get_debugfs_dentry(indio_dev);
 
 	debugfs_create_file_unsafe("serial_number", 0400,
 		d, adis16136, &adis16136_serial_fops);
diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
index 3086dd536203..c373632781ce 100644
--- a/drivers/iio/imu/adis16400.c
+++ b/drivers/iio/imu/adis16400.c
@@ -274,7 +274,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(adis16400_flash_count_fops,
 static void adis16400_debugfs_init(struct iio_dev *indio_dev)
 {
 	struct adis16400_state *st = iio_priv(indio_dev);
-	struct dentry *d = iio_get_debugfs_dentry(indio_dev);
+	struct debugfs_node *d = iio_get_debugfs_dentry(indio_dev);
 
 	if (!IS_ENABLED(CONFIG_DEBUG_FS))
 		return;
diff --git a/drivers/iio/imu/adis16460.c b/drivers/iio/imu/adis16460.c
index ecf74046fde1..d93b903188dc 100644
--- a/drivers/iio/imu/adis16460.c
+++ b/drivers/iio/imu/adis16460.c
@@ -126,7 +126,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(adis16460_flash_count_fops,
 static void adis16460_debugfs_init(struct iio_dev *indio_dev)
 {
 	struct adis16460 *adis16460 = iio_priv(indio_dev);
-	struct dentry *d = iio_get_debugfs_dentry(indio_dev);
+	struct debugfs_node *d = iio_get_debugfs_dentry(indio_dev);
 
 	if (!IS_ENABLED(CONFIG_DEBUG_FS))
 		return;
diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index df8c6cd91169..bc40b761c708 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -276,7 +276,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(adis16475_flash_count_fops,
 static void adis16475_debugfs_init(struct iio_dev *indio_dev)
 {
 	struct adis16475 *st = iio_priv(indio_dev);
-	struct dentry *d = iio_get_debugfs_dentry(indio_dev);
+	struct debugfs_node *d = iio_get_debugfs_dentry(indio_dev);
 
 	if (!IS_ENABLED(CONFIG_DEBUG_FS))
 		return;
diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index 727e0a11eac1..7b57a2d1e161 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -305,7 +305,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(adis16480_flash_count_fops,
 static void adis16480_debugfs_init(struct iio_dev *indio_dev)
 {
 	struct adis16480 *adis16480 = iio_priv(indio_dev);
-	struct dentry *d = iio_get_debugfs_dentry(indio_dev);
+	struct debugfs_node *d = iio_get_debugfs_dentry(indio_dev);
 
 	if (!IS_ENABLED(CONFIG_DEBUG_FS))
 		return;
diff --git a/drivers/iio/imu/bno055/bno055.c b/drivers/iio/imu/bno055/bno055.c
index 597c402b98de..fd1599a36362 100644
--- a/drivers/iio/imu/bno055/bno055.c
+++ b/drivers/iio/imu/bno055/bno055.c
@@ -209,7 +209,7 @@ struct bno055_priv {
 		__le16 chans[BNO055_SCAN_CH_COUNT];
 		aligned_s64 timestamp;
 	} buf;
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 };
 
 static bool bno055_regmap_volatile(struct device *dev, unsigned int reg)
diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 363281272035..9870bdbc8f79 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -207,8 +207,8 @@ static const struct file_operations iio_backend_debugfs_name_fops = {
 void iio_backend_debugfs_add(struct iio_backend *back,
 			     struct iio_dev *indio_dev)
 {
-	struct dentry *d = iio_get_debugfs_dentry(indio_dev);
-	struct dentry *back_d;
+	struct debugfs_node *d = iio_get_debugfs_dentry(indio_dev);
+	struct debugfs_node *back_d;
 	char name[128];
 
 	if (!IS_ENABLED(CONFIG_DEBUG_FS) || !d)
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index a2117ad1337d..f1af67dd2990 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -48,7 +48,7 @@ const struct bus_type iio_bus_type = {
 };
 EXPORT_SYMBOL(iio_bus_type);
 
-static struct dentry *iio_debugfs_dentry;
+static struct debugfs_node *iio_debugfs_dentry;
 
 static const char * const iio_direction[] = {
 	[0] = "in",
@@ -224,7 +224,7 @@ EXPORT_SYMBOL_GPL(iio_buffer_enabled);
  * There's also a CONFIG_DEBUG_FS guard in include/linux/iio/iio.h for
  * iio_get_debugfs_dentry() to make it inline if CONFIG_DEBUG_FS is undefined
  */
-struct dentry *iio_get_debugfs_dentry(struct iio_dev *indio_dev)
+struct debugfs_node *iio_get_debugfs_dentry(struct iio_dev *indio_dev)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 
diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index b91a85a491d0..fd044d99c8ae 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -227,8 +227,8 @@ struct bnxt_re_dev {
 	struct delayed_work dbq_pacing_work;
 	DECLARE_HASHTABLE(cq_hash, MAX_CQ_HASH_BITS);
 	DECLARE_HASHTABLE(srq_hash, MAX_SRQ_HASH_BITS);
-	struct dentry			*dbg_root;
-	struct dentry			*qp_debugfs;
+	struct debugfs_node *dbg_root;
+	struct debugfs_node *qp_debugfs;
 	unsigned long			event_bitmap;
 	struct bnxt_qplib_cc_param	cc_param;
 	struct workqueue_struct		*dcb_wq;
diff --git a/drivers/infiniband/hw/bnxt_re/debugfs.c b/drivers/infiniband/hw/bnxt_re/debugfs.c
index 7c47039044ef..a62dd87e22cf 100644
--- a/drivers/infiniband/hw/bnxt_re/debugfs.c
+++ b/drivers/infiniband/hw/bnxt_re/debugfs.c
@@ -20,7 +20,7 @@
 #include "ib_verbs.h"
 #include "debugfs.h"
 
-static struct dentry *bnxt_re_debugfs_root;
+static struct debugfs_node *bnxt_re_debugfs_root;
 
 static inline const char *bnxt_re_qp_state_str(u8 state)
 {
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index fbb16a411d6a..7bae01e73e11 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -95,7 +95,7 @@ struct bnxt_re_qp {
 	struct ib_ud_header	qp1_hdr;
 	struct bnxt_re_cq	*scq;
 	struct bnxt_re_cq	*rcq;
-	struct dentry		*dentry;
+	struct debugfs_node *dentry;
 };
 
 struct bnxt_re_cq {
diff --git a/drivers/infiniband/hw/cxgb4/device.c b/drivers/infiniband/hw/cxgb4/device.c
index 034b85c42255..a2b2b40f56a1 100644
--- a/drivers/infiniband/hw/cxgb4/device.c
+++ b/drivers/infiniband/hw/cxgb4/device.c
@@ -72,7 +72,7 @@ static struct workqueue_struct *reg_workq;
 #define DB_FC_RESUME_DELAY 1
 #define DB_FC_DRAIN_THRESH 0
 
-static struct dentry *c4iw_debugfs_root;
+static struct debugfs_node *c4iw_debugfs_root;
 
 struct c4iw_debugfs_data {
 	struct c4iw_dev *devp;
diff --git a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
index 5b3007acaa1f..102ae39baeb9 100644
--- a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
+++ b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
@@ -318,7 +318,7 @@ struct c4iw_dev {
 	struct xarray qps;
 	struct xarray mrs;
 	struct mutex db_mutex;
-	struct dentry *debugfs_root;
+	struct debugfs_node *debugfs_root;
 	enum db_state db_state;
 	struct xarray hwtids;
 	struct xarray atids;
diff --git a/drivers/infiniband/hw/hfi1/debugfs.c b/drivers/infiniband/hw/hfi1/debugfs.c
index a1e01b447265..3e9ef6b75dc5 100644
--- a/drivers/infiniband/hw/hfi1/debugfs.c
+++ b/drivers/infiniband/hw/hfi1/debugfs.c
@@ -20,7 +20,7 @@
 #include "sdma.h"
 #include "fault.h"
 
-static struct dentry *hfi1_dbg_root;
+static struct debugfs_node *hfi1_dbg_root;
 
 /* wrappers to enforce srcu in seq file */
 ssize_t hfi1_seq_read(struct file *file, char __user *buf, size_t size,
@@ -1183,7 +1183,7 @@ void hfi1_dbg_ibdev_init(struct hfi1_ibdev *ibd)
 	char link[10];
 	struct hfi1_devdata *dd = dd_from_dev(ibd);
 	struct hfi1_pportdata *ppd;
-	struct dentry *root;
+	struct debugfs_node *root;
 	int unit = dd->unit;
 	int i, j;
 
diff --git a/drivers/infiniband/hw/hfi1/fault.c b/drivers/infiniband/hw/hfi1/fault.c
index ec9ee59fcf0c..7c05b5109d43 100644
--- a/drivers/infiniband/hw/hfi1/fault.c
+++ b/drivers/infiniband/hw/hfi1/fault.c
@@ -215,8 +215,8 @@ void hfi1_fault_exit_debugfs(struct hfi1_ibdev *ibd)
 
 int hfi1_fault_init_debugfs(struct hfi1_ibdev *ibd)
 {
-	struct dentry *parent = ibd->hfi1_ibdev_dbg;
-	struct dentry *fault_dir;
+	struct debugfs_node *parent = ibd->hfi1_ibdev_dbg;
+	struct debugfs_node *fault_dir;
 
 	ibd->fault = kzalloc(sizeof(*ibd->fault), GFP_KERNEL);
 	if (!ibd->fault)
diff --git a/drivers/infiniband/hw/hfi1/fault.h b/drivers/infiniband/hw/hfi1/fault.h
index 51adafe240d7..6235b25df9b7 100644
--- a/drivers/infiniband/hw/hfi1/fault.h
+++ b/drivers/infiniband/hw/hfi1/fault.h
@@ -19,7 +19,7 @@ struct hfi1_ibdev;
 #if defined(CONFIG_FAULT_INJECTION) && defined(CONFIG_FAULT_INJECTION_DEBUG_FS)
 struct fault {
 	struct fault_attr attr;
-	struct dentry *dir;
+	struct debugfs_node *dir;
 	u64 n_rxfaults[(1U << BITS_PER_BYTE)];
 	u64 n_txfaults[(1U << BITS_PER_BYTE)];
 	u64 fault_skip;
diff --git a/drivers/infiniband/hw/hns/hns_roce_debugfs.c b/drivers/infiniband/hw/hns/hns_roce_debugfs.c
index b869cdc54118..bf31ee5e5594 100644
--- a/drivers/infiniband/hw/hns/hns_roce_debugfs.c
+++ b/drivers/infiniband/hw/hns/hns_roce_debugfs.c
@@ -9,7 +9,7 @@
 
 #include "hns_roce_device.h"
 
-static struct dentry *hns_roce_dbgfs_root;
+static struct debugfs_node *hns_roce_dbgfs_root;
 
 static int hns_debugfs_seqfile_open(struct inode *inode, struct file *f)
 {
@@ -27,7 +27,8 @@ static const struct file_operations hns_debugfs_seqfile_fops = {
 };
 
 static void init_debugfs_seqfile(struct hns_debugfs_seqfile *seq,
-				 const char *name, struct dentry *parent,
+				 const char *name,
+				 struct debugfs_node *parent,
 				 int (*read_fn)(struct seq_file *, void *),
 				 void *data)
 {
@@ -72,7 +73,7 @@ static int sw_stat_debugfs_show(struct seq_file *file, void *offset)
 }
 
 static void create_sw_stat_debugfs(struct hns_roce_dev *hr_dev,
-				   struct dentry *parent)
+				   struct debugfs_node *parent)
 {
 	struct hns_sw_stat_debugfs *dbgfs = &hr_dev->dbgfs.sw_stat_root;
 
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 81849eb671a1..af15dc162b5c 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4427,7 +4427,7 @@ static int mlx5_ib_stage_post_ib_reg_umr_init(struct mlx5_ib_dev *dev)
 
 static int mlx5_ib_stage_delay_drop_init(struct mlx5_ib_dev *dev)
 {
-	struct dentry *root;
+	struct debugfs_node *root;
 
 	if (!(dev->ib_dev.attrs.raw_packet_caps & IB_RAW_PACKET_CAP_DELAY_DROP))
 		return 0;
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 974a45c92fbb..7a39aec2b630 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -831,7 +831,7 @@ struct mlx5_mkey_cache {
 	struct workqueue_struct *wq;
 	struct rb_root		rb_root;
 	struct mutex		rb_lock;
-	struct dentry		*fs_root;
+	struct debugfs_node *fs_root;
 	unsigned long		last_add;
 };
 
@@ -919,7 +919,7 @@ struct mlx5_ib_port {
 struct mlx5_ib_dbg_param {
 	int			offset;
 	struct mlx5_ib_dev	*dev;
-	struct dentry		*dentry;
+	struct debugfs_node *dentry;
 	u32			port_num;
 };
 
@@ -950,7 +950,7 @@ enum mlx5_ib_dbg_cc_types {
 };
 
 struct mlx5_ib_dbg_cc_params {
-	struct dentry			*root;
+	struct debugfs_node *root;
 	struct mlx5_ib_dbg_param	params[MLX5_IB_DBG_CC_MAX];
 };
 
@@ -967,7 +967,7 @@ struct mlx5_ib_delay_drop {
 	bool			activate;
 	atomic_t		events_cnt;
 	atomic_t		rqs_cnt;
-	struct dentry		*dir_debugfs;
+	struct debugfs_node *dir_debugfs;
 };
 
 enum mlx5_ib_stages {
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index bb02b6adbf2c..027b6a93064f 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -810,7 +810,7 @@ static void mlx5_mkey_cache_debugfs_add_ent(struct mlx5_ib_dev *dev,
 					    struct mlx5_cache_ent *ent)
 {
 	int order = order_base_2(ent->rb_key.ndescs);
-	struct dentry *dir;
+	struct debugfs_node *dir;
 
 	if (!mlx5_debugfs_root || dev->is_rep)
 		return;
@@ -828,7 +828,7 @@ static void mlx5_mkey_cache_debugfs_add_ent(struct mlx5_ib_dev *dev,
 
 static void mlx5_mkey_cache_debugfs_init(struct mlx5_ib_dev *dev)
 {
-	struct dentry *dbg_root = mlx5_debugfs_get_dev_root(dev->mdev);
+	struct debugfs_node *dbg_root = mlx5_debugfs_get_dev_root(dev->mdev);
 	struct mlx5_mkey_cache *cache = &dev->cache;
 
 	if (!mlx5_debugfs_root || dev->is_rep)
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_stats.c b/drivers/infiniband/hw/ocrdma/ocrdma_stats.c
index 0834416cb3f8..44083990d217 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_stats.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_stats.c
@@ -44,7 +44,7 @@
 #include <rdma/ib_pma.h>
 #include "ocrdma_stats.h"
 
-static struct dentry *ocrdma_dbgfs_dir;
+static struct debugfs_node *ocrdma_dbgfs_dir;
 
 static noinline_for_stack int ocrdma_add_stat(char *start, char *pcur,
 				char *name, u64 count)
diff --git a/drivers/infiniband/hw/qib/qib_debugfs.c b/drivers/infiniband/hw/qib/qib_debugfs.c
index caeb77d07a58..344d75dd68ee 100644
--- a/drivers/infiniband/hw/qib/qib_debugfs.c
+++ b/drivers/infiniband/hw/qib/qib_debugfs.c
@@ -38,7 +38,7 @@
 #include "qib_verbs.h"
 #include "qib_debugfs.h"
 
-static struct dentry *qib_dbg_root;
+static struct debugfs_node *qib_dbg_root;
 
 #define DEBUGFS_FILE(name) \
 static const struct seq_operations _##name##_seq_ops = { \
@@ -240,7 +240,7 @@ DEBUGFS_FILE(qp_stats)
 
 void qib_dbg_ibdev_init(struct qib_ibdev *ibd)
 {
-	struct dentry *root;
+	struct debugfs_node *root;
 	char name[10];
 
 	snprintf(name, sizeof(name), "qib%d", dd_from_dev(ibd)->unit);
diff --git a/drivers/infiniband/hw/qib/qib_verbs.h b/drivers/infiniband/hw/qib/qib_verbs.h
index 408fe1ba74b9..05efbb1c052e 100644
--- a/drivers/infiniband/hw/qib/qib_verbs.h
+++ b/drivers/infiniband/hw/qib/qib_verbs.h
@@ -183,7 +183,7 @@ struct qib_ibdev {
 
 #ifdef CONFIG_DEBUG_FS
 	/* per HCA debugfs */
-	struct dentry *qib_ibdev_dbg;
+	struct debugfs_node *qib_ibdev_dbg;
 #endif
 };
 
diff --git a/drivers/infiniband/hw/usnic/usnic_debugfs.c b/drivers/infiniband/hw/usnic/usnic_debugfs.c
index 10a8cd5ba076..7cc9d7e04879 100644
--- a/drivers/infiniband/hw/usnic/usnic_debugfs.c
+++ b/drivers/infiniband/hw/usnic/usnic_debugfs.c
@@ -39,8 +39,8 @@
 #include "usnic_ib_qp_grp.h"
 #include "usnic_transport.h"
 
-static struct dentry *debugfs_root;
-static struct dentry *flows_dentry;
+static struct debugfs_node *debugfs_root;
+static struct debugfs_node *flows_dentry;
 
 static ssize_t usnic_debugfs_buildinfo_read(struct file *f, char __user *data,
 						size_t count, loff_t *ppos)
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_qp_grp.h b/drivers/infiniband/hw/usnic/usnic_ib_qp_grp.h
index 62e732be6736..648488db10bc 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_qp_grp.h
+++ b/drivers/infiniband/hw/usnic/usnic_ib_qp_grp.h
@@ -80,7 +80,7 @@ struct usnic_ib_qp_grp_flow {
 	struct list_head		link;
 
 	/* Debug FS */
-	struct dentry			*dbgfs_dentry;
+	struct debugfs_node *dbgfs_dentry;
 	char				dentry_name[32];
 };
 
diff --git a/drivers/infiniband/ulp/ipoib/ipoib.h b/drivers/infiniband/ulp/ipoib/ipoib.h
index abe0522b7df4..df9303bae779 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib.h
+++ b/drivers/infiniband/ulp/ipoib/ipoib.h
@@ -409,8 +409,8 @@ struct ipoib_dev_priv {
 
 #ifdef CONFIG_INFINIBAND_IPOIB_DEBUG
 	struct list_head fs_list;
-	struct dentry *mcg_dentry;
-	struct dentry *path_dentry;
+	struct debugfs_node *mcg_dentry;
+	struct debugfs_node *path_dentry;
 #endif
 	u64	hca_caps;
 	u64	kernel_caps;
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_fs.c b/drivers/infiniband/ulp/ipoib/ipoib_fs.c
index 12ba7a0fe0b5..dae028851420 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_fs.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_fs.c
@@ -41,7 +41,7 @@ struct file_operations;
 
 #include "ipoib.h"
 
-static struct dentry *ipoib_root;
+static struct debugfs_node *ipoib_root;
 
 static void format_gid(union ib_gid *gid, char *buf)
 {
diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
index b5ff71cd5a70..b6756d42d558 100644
--- a/drivers/input/keyboard/applespi.c
+++ b/drivers/input/keyboard/applespi.c
@@ -424,7 +424,7 @@ struct applespi_data {
 	struct work_struct		work;
 	struct touchpad_info_protocol	rcvd_tp_info;
 
-	struct dentry			*debugfs_root;
+	struct debugfs_node *debugfs_root;
 	bool				debug_tp_dim;
 	char				tp_dim_val[40];
 	int				tp_dim_min_x;
diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 0d7bf18e2508..40932bb255f9 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -120,7 +120,7 @@ struct edt_ft5x06_ts_data {
 	struct regmap *regmap;
 
 #if defined(CONFIG_DEBUG_FS)
-	struct dentry *debug_dir;
+	struct debugfs_node *debug_dir;
 	u8 *raw_buffer;
 	size_t raw_bufsize;
 #endif
diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 9d5404a07e8a..aee26c87f477 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -29,7 +29,7 @@ static int providers_count;
 static bool synced_state;
 static DEFINE_MUTEX(icc_lock);
 static DEFINE_MUTEX(icc_bw_lock);
-static struct dentry *icc_debugfs_dir;
+static struct debugfs_node *icc_debugfs_dir;
 
 static void icc_summary_show_one(struct seq_file *s, struct icc_node *n)
 {
diff --git a/drivers/interconnect/debugfs-client.c b/drivers/interconnect/debugfs-client.c
index bc3fd8a7b9eb..100d54186276 100644
--- a/drivers/interconnect/debugfs-client.c
+++ b/drivers/interconnect/debugfs-client.c
@@ -131,9 +131,9 @@ static int icc_commit_set(void *data, u64 val)
 
 DEFINE_DEBUGFS_ATTRIBUTE(icc_commit_fops, NULL, icc_commit_set, "%llu\n");
 
-int icc_debugfs_client_init(struct dentry *icc_dir)
+int icc_debugfs_client_init(struct debugfs_node *icc_dir)
 {
-	struct dentry *client_dir;
+	struct debugfs_node *client_dir;
 	int ret;
 
 	pdev = platform_device_alloc("icc-debugfs-client", PLATFORM_DEVID_NONE);
@@ -160,7 +160,7 @@ int icc_debugfs_client_init(struct dentry *icc_dir)
 
 #else
 
-int icc_debugfs_client_init(struct dentry *icc_dir)
+int icc_debugfs_client_init(struct debugfs_node *icc_dir)
 {
 	return 0;
 }
diff --git a/drivers/interconnect/internal.h b/drivers/interconnect/internal.h
index 3b9d50589c01..c262af95909c 100644
--- a/drivers/interconnect/internal.h
+++ b/drivers/interconnect/internal.h
@@ -42,6 +42,6 @@ struct icc_path {
 };
 
 struct icc_path *icc_get(struct device *dev, const char *src, const char *dst);
-int icc_debugfs_client_init(struct dentry *icc_dir);
+int icc_debugfs_client_init(struct debugfs_node *icc_dir);
 
 #endif
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 0bbda60d3cdc..7904749c4069 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -792,7 +792,7 @@ struct amd_iommu {
 
 #ifdef CONFIG_AMD_IOMMU_DEBUGFS
 	/* DebugFS Info */
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 #endif
 
 	/* IOPF support */
diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
index 545372fcc72f..1c42c5a8aef0 100644
--- a/drivers/iommu/amd/debugfs.c
+++ b/drivers/iommu/amd/debugfs.c
@@ -12,7 +12,7 @@
 
 #include "amd_iommu.h"
 
-static struct dentry *amd_iommu_debugfs;
+static struct debugfs_node *amd_iommu_debugfs;
 static DEFINE_MUTEX(amd_iommu_debugfs_lock);
 
 #define	MAX_NAME_LEN	20
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index d525ab43a4ae..46bc6c66a5b2 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -804,7 +804,7 @@ static int tegra241_cmdqv_init_structures(struct arm_smmu_device *smmu)
 }
 
 #ifdef CONFIG_IOMMU_DEBUGFS
-static struct dentry *cmdqv_debugfs_dir;
+static struct debugfs_node *cmdqv_debugfs_dir;
 #endif
 
 static struct arm_smmu_device *
diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index affbf4a1558d..e38ca68fb9d7 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -108,7 +108,7 @@ static const struct iommu_regset iommu_regs_64[] = {
 	IOMMU_REGSET_ENTRY(MTRR_PHYSMASK9),
 };
 
-static struct dentry *intel_iommu_debug;
+static struct debugfs_node *intel_iommu_debug;
 
 static int iommu_regset_show(struct seq_file *m, void *unused)
 {
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 6ea7bbe26b19..c13a7d82a38a 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -781,7 +781,7 @@ struct device_domain_info {
 	/* device tracking node(lookup by PCI RID) */
 	struct rb_node node;
 #ifdef CONFIG_INTEL_IOMMU_DEBUGFS
-	struct dentry *debugfs_dentry; /* pointer to device directory dentry */
+	struct debugfs_node *debugfs_dentry; /* pointer to device directory dentry */
 #endif
 };
 
@@ -790,7 +790,7 @@ struct dev_pasid_info {
 	struct device *dev;
 	ioasid_t pasid;
 #ifdef CONFIG_INTEL_IOMMU_DEBUGFS
-	struct dentry *debugfs_dentry; /* pointer to pasid directory dentry */
+	struct debugfs_node *debugfs_dentry; /* pointer to pasid directory dentry */
 #endif
 };
 
diff --git a/drivers/iommu/iommu-debugfs.c b/drivers/iommu/iommu-debugfs.c
index f03548942096..1c23746b25a3 100644
--- a/drivers/iommu/iommu-debugfs.c
+++ b/drivers/iommu/iommu-debugfs.c
@@ -11,7 +11,7 @@
 #include <linux/iommu.h>
 #include <linux/debugfs.h>
 
-struct dentry *iommu_debugfs_dir;
+struct debugfs_node *iommu_debugfs_dir;
 EXPORT_SYMBOL_GPL(iommu_debugfs_dir);
 
 /**
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index d40deb0a4f06..c570063e1f3e 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -19,7 +19,7 @@
 #include "iommufd_test.h"
 
 static DECLARE_FAULT_ATTR(fail_iommufd);
-static struct dentry *dbgfs_root;
+static struct debugfs_node *dbgfs_root;
 static struct platform_device *selftest_iommu_dev;
 static const struct iommu_ops mock_ops;
 static struct iommu_domain_ops domain_nested_ops;
diff --git a/drivers/iommu/omap-iommu-debug.c b/drivers/iommu/omap-iommu-debug.c
index 259f65291d90..fe90fed5b1b6 100644
--- a/drivers/iommu/omap-iommu-debug.c
+++ b/drivers/iommu/omap-iommu-debug.c
@@ -20,7 +20,7 @@
 
 static DEFINE_MUTEX(iommu_debug_lock);
 
-static struct dentry *iommu_debug_root;
+static struct debugfs_node *iommu_debug_root;
 
 static inline bool is_omap_iommu_detached(struct omap_iommu *obj)
 {
@@ -241,7 +241,7 @@ DEFINE_SHOW_ATTRIBUTE(pagetable);
 
 void omap_iommu_debugfs_add(struct omap_iommu *obj)
 {
-	struct dentry *d;
+	struct debugfs_node *d;
 
 	if (!iommu_debug_root)
 		return;
diff --git a/drivers/iommu/omap-iommu.h b/drivers/iommu/omap-iommu.h
index 27697109ec79..a03dc0459703 100644
--- a/drivers/iommu/omap-iommu.h
+++ b/drivers/iommu/omap-iommu.h
@@ -57,7 +57,7 @@ struct omap_iommu {
 	struct regmap	*syscfg;
 	struct device	*dev;
 	struct iommu_domain *domain;
-	struct dentry	*debug_dir;
+	struct debugfs_node *debug_dir;
 
 	spinlock_t	iommu_lock;	/* global for this whole object */
 
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 7f633bb5efef..2d855b1913bb 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -46,7 +46,7 @@ struct tegra_smmu {
 
 	struct list_head list;
 
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 
 	struct iommu_device iommu;	/* IOMMU Core code handle */
 };
diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-flexrm-mailbox.c
index 41f79e51d9e5..8b6bf055f261 100644
--- a/drivers/mailbox/bcm-flexrm-mailbox.c
+++ b/drivers/mailbox/bcm-flexrm-mailbox.c
@@ -285,7 +285,7 @@ struct flexrm_mbox {
 	struct flexrm_ring *rings;
 	struct dma_pool *bd_pool;
 	struct dma_pool *cmpl_pool;
-	struct dentry *root;
+	struct debugfs_node *root;
 	struct mbox_controller controller;
 };
 
diff --git a/drivers/mailbox/bcm-pdc-mailbox.c b/drivers/mailbox/bcm-pdc-mailbox.c
index 406bc41cba60..6fcdc33c2f3c 100644
--- a/drivers/mailbox/bcm-pdc-mailbox.c
+++ b/drivers/mailbox/bcm-pdc-mailbox.c
@@ -415,7 +415,7 @@ struct pdc_globals {
 static struct pdc_globals pdcg;
 
 /* top level debug FS directory for PDC driver */
-static struct dentry *debugfs_dir;
+static struct debugfs_node *debugfs_dir;
 
 static ssize_t pdc_debugfs_read(struct file *filp, char __user *ubuf,
 				size_t count, loff_t *offp)
diff --git a/drivers/mailbox/mailbox-test.c b/drivers/mailbox/mailbox-test.c
index c9dd8c42c0cd..e60a9a64f7dd 100644
--- a/drivers/mailbox/mailbox-test.c
+++ b/drivers/mailbox/mailbox-test.c
@@ -43,7 +43,7 @@ struct mbox_test_device {
 	struct mutex		mutex;
 	wait_queue_head_t	waitq;
 	struct fasync_struct	*async_queue;
-	struct dentry		*root_debugfs_dir;
+	struct debugfs_node *root_debugfs_dir;
 };
 
 static ssize_t mbox_test_signal_write(struct file *filp,
diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index 785b0d9008fa..cbee6550af5f 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -520,7 +520,7 @@ struct cache_set {
 	struct list_head	list;
 	struct kobject		kobj;
 	struct kobject		internal;
-	struct dentry		*debug;
+	struct debugfs_node *debug;
 	struct cache_accounting accounting;
 
 	unsigned long		flags;
diff --git a/drivers/md/bcache/debug.c b/drivers/md/bcache/debug.c
index 7510d1c983a5..9ec03edfd9a7 100644
--- a/drivers/md/bcache/debug.c
+++ b/drivers/md/bcache/debug.c
@@ -17,7 +17,7 @@
 #include <linux/random.h>
 #include <linux/seq_file.h>
 
-struct dentry *bcache_debug;
+struct debugfs_node *bcache_debug;
 
 #ifdef CONFIG_BCACHE_DEBUG
 
diff --git a/drivers/media/cec/core/cec-core.c b/drivers/media/cec/core/cec-core.c
index e10bd588a586..6403e508f84e 100644
--- a/drivers/media/cec/core/cec-core.c
+++ b/drivers/media/cec/core/cec-core.c
@@ -47,7 +47,7 @@ static dev_t cec_dev_t;
 static DEFINE_MUTEX(cec_devnode_lock);
 static DECLARE_BITMAP(cec_devnode_nums, CEC_NUM_DEVICES);
 
-static struct dentry *top_cec_dir;
+static struct debugfs_node *top_cec_dir;
 
 /* dev to cec_devnode */
 #define to_cec_devnode(cd) container_of(cd, struct cec_devnode, dev)
diff --git a/drivers/media/common/siano/smsdvb-debugfs.c b/drivers/media/common/siano/smsdvb-debugfs.c
index d14ba271db50..683a8a2b1f6d 100644
--- a/drivers/media/common/siano/smsdvb-debugfs.c
+++ b/drivers/media/common/siano/smsdvb-debugfs.c
@@ -18,7 +18,7 @@
 
 #include "smsdvb.h"
 
-static struct dentry *smsdvb_debugfs_usb_root;
+static struct debugfs_node *smsdvb_debugfs_usb_root;
 
 struct smsdvb_debugfs {
 	struct kref		refcount;
diff --git a/drivers/media/common/siano/smsdvb.h b/drivers/media/common/siano/smsdvb.h
index b43cbb5c0dee..9e768cddbb6f 100644
--- a/drivers/media/common/siano/smsdvb.h
+++ b/drivers/media/common/siano/smsdvb.h
@@ -46,7 +46,7 @@ struct smsdvb_client_t {
 	bool			has_tuned;
 
 	/* stats debugfs data */
-	struct dentry		*debugfs;
+	struct debugfs_node *debugfs;
 
 	struct smsdvb_debugfs	*debug_data;
 
diff --git a/drivers/media/i2c/adv7511-v4l2.c b/drivers/media/i2c/adv7511-v4l2.c
index 4036972af3a6..96a3f861b146 100644
--- a/drivers/media/i2c/adv7511-v4l2.c
+++ b/drivers/media/i2c/adv7511-v4l2.c
@@ -117,7 +117,7 @@ struct adv7511_state {
 	struct workqueue_struct *work_queue;
 	struct delayed_work edid_handler; /* work entry */
 
-	struct dentry *debugfs_dir;
+	struct debugfs_node *debugfs_dir;
 	struct v4l2_debugfs_if *infoframes;
 };
 
diff --git a/drivers/media/i2c/adv7604.c b/drivers/media/i2c/adv7604.c
index e271782b7b70..217374103616 100644
--- a/drivers/media/i2c/adv7604.c
+++ b/drivers/media/i2c/adv7604.c
@@ -193,7 +193,7 @@ struct adv76xx_state {
 	struct delayed_work delayed_work_enable_hotplug;
 	bool restart_stdi_once;
 
-	struct dentry *debugfs_dir;
+	struct debugfs_node *debugfs_dir;
 	struct v4l2_debugfs_if *infoframes;
 
 	/* CEC */
diff --git a/drivers/media/i2c/adv7842.c b/drivers/media/i2c/adv7842.c
index 5545cd23e113..1d13903706db 100644
--- a/drivers/media/i2c/adv7842.c
+++ b/drivers/media/i2c/adv7842.c
@@ -114,7 +114,7 @@ struct adv7842_state {
 	bool restart_stdi_once;
 	bool hdmi_port_a;
 
-	struct dentry *debugfs_dir;
+	struct debugfs_node *debugfs_dir;
 	struct v4l2_debugfs_if *infoframes;
 
 	/* i2c clients */
diff --git a/drivers/media/i2c/tc358743.c b/drivers/media/i2c/tc358743.c
index c50d4e85dfd1..4e96d41bd60b 100644
--- a/drivers/media/i2c/tc358743.c
+++ b/drivers/media/i2c/tc358743.c
@@ -88,7 +88,7 @@ struct tc358743_state {
 	struct work_struct work_i2c_poll;
 
 	/* debugfs */
-	struct dentry *debugfs_dir;
+	struct debugfs_node *debugfs_dir;
 	struct v4l2_debugfs_if *infoframes;
 
 	/* edid  */
diff --git a/drivers/media/pci/mgb4/mgb4_core.h b/drivers/media/pci/mgb4/mgb4_core.h
index e86742d7b6c4..a44a93ab2a97 100644
--- a/drivers/media/pci/mgb4/mgb4_core.h
+++ b/drivers/media/pci/mgb4/mgb4_core.h
@@ -65,7 +65,7 @@ struct mgb4_dev {
 	u8 module_version;
 	u32 serial_number;
 
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 };
 
 #endif
diff --git a/drivers/media/pci/mgb4/mgb4_vin.c b/drivers/media/pci/mgb4/mgb4_vin.c
index 434eaf0440e2..61b18dcf876f 100644
--- a/drivers/media/pci/mgb4/mgb4_vin.c
+++ b/drivers/media/pci/mgb4/mgb4_vin.c
@@ -843,7 +843,7 @@ static void create_debugfs(struct mgb4_vin_dev *vindev)
 {
 #ifdef CONFIG_DEBUG_FS
 	struct mgb4_regs *video = &vindev->mgbdev->video;
-	struct dentry *entry;
+	struct debugfs_node *entry;
 
 	if (IS_ERR_OR_NULL(vindev->mgbdev->debugfs))
 		return;
diff --git a/drivers/media/pci/mgb4/mgb4_vout.c b/drivers/media/pci/mgb4/mgb4_vout.c
index 14c5725bd4d8..1096ca42a82c 100644
--- a/drivers/media/pci/mgb4/mgb4_vout.c
+++ b/drivers/media/pci/mgb4/mgb4_vout.c
@@ -676,7 +676,7 @@ static void create_debugfs(struct mgb4_vout_dev *voutdev)
 {
 #ifdef CONFIG_DEBUG_FS
 	struct mgb4_regs *video = &voutdev->mgbdev->video;
-	struct dentry *entry;
+	struct debugfs_node *entry;
 
 	if (IS_ERR_OR_NULL(voutdev->mgbdev->debugfs))
 		return;
diff --git a/drivers/media/pci/saa7164/saa7164-core.c b/drivers/media/pci/saa7164/saa7164-core.c
index a8a004f28ca0..6f85dea92329 100644
--- a/drivers/media/pci/saa7164/saa7164-core.c
+++ b/drivers/media/pci/saa7164/saa7164-core.c
@@ -1146,7 +1146,7 @@ static const struct seq_operations saa7164_sops = {
 
 DEFINE_SEQ_ATTRIBUTE(saa7164);
 
-static struct dentry *saa7614_dentry;
+static struct debugfs_node *saa7614_dentry;
 
 static void __init saa7164_debugfs_create(void)
 {
diff --git a/drivers/media/pci/zoran/zoran.h b/drivers/media/pci/zoran/zoran.h
index 1cd990468d3d..ad730c20f167 100644
--- a/drivers/media/pci/zoran/zoran.h
+++ b/drivers/media/pci/zoran/zoran.h
@@ -290,7 +290,7 @@ struct zoran {
 	struct list_head queued_bufs;
 	spinlock_t queued_bufs_lock; /* Protects queued_bufs */
 	struct zr_buffer *inuse[BUZ_NUM_STAT_COM * 2];
-	struct dentry *dbgfs_dir;
+	struct debugfs_node *dbgfs_dir;
 };
 
 static inline struct zoran *to_zoran(struct v4l2_device *v4l2_dev)
diff --git a/drivers/media/platform/amphion/vpu.h b/drivers/media/platform/amphion/vpu.h
index 22f0da26ccec..203b143be900 100644
--- a/drivers/media/platform/amphion/vpu.h
+++ b/drivers/media/platform/amphion/vpu.h
@@ -80,7 +80,7 @@ struct vpu_dev {
 	atomic_t ref_enc;
 	atomic_t ref_dec;
 
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 };
 
 struct vpu_format {
@@ -167,8 +167,8 @@ struct vpu_core {
 	struct vpu_dev *vpu;
 	void *iface;
 
-	struct dentry *debugfs;
-	struct dentry *debugfs_fwlog;
+	struct debugfs_node *debugfs;
+	struct debugfs_node *debugfs_fwlog;
 };
 
 enum vpu_codec_state {
@@ -276,7 +276,7 @@ struct vpu_inst {
 
 	pid_t pid;
 	pid_t tgid;
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 
 	void *priv;
 };
diff --git a/drivers/media/platform/aspeed/aspeed-video.c b/drivers/media/platform/aspeed/aspeed-video.c
index 54cae0da9aca..8f31df6e42b8 100644
--- a/drivers/media/platform/aspeed/aspeed-video.c
+++ b/drivers/media/platform/aspeed/aspeed-video.c
@@ -1960,7 +1960,7 @@ static int aspeed_video_debugfs_show(struct seq_file *s, void *data)
 }
 DEFINE_SHOW_ATTRIBUTE(aspeed_video_debugfs);
 
-static struct dentry *debugfs_entry;
+static struct debugfs_node *debugfs_entry;
 
 static void aspeed_video_debugfs_remove(struct aspeed_video *video)
 {
diff --git a/drivers/media/platform/chips-media/coda/coda-common.c b/drivers/media/platform/chips-media/coda/coda-common.c
index 289a076c3bcc..2c5eb21ca62c 100644
--- a/drivers/media/platform/chips-media/coda/coda-common.c
+++ b/drivers/media/platform/chips-media/coda/coda-common.c
@@ -1929,7 +1929,8 @@ static void coda_buf_queue(struct vb2_buffer *vb)
 }
 
 int coda_alloc_aux_buf(struct coda_dev *dev, struct coda_aux_buf *buf,
-		       size_t size, const char *name, struct dentry *parent)
+		       size_t size, const char *name,
+		       struct debugfs_node *parent)
 {
 	buf->vaddr = dma_alloc_coherent(dev->dev, size, &buf->paddr,
 					GFP_KERNEL);
diff --git a/drivers/media/platform/chips-media/coda/coda.h b/drivers/media/platform/chips-media/coda/coda.h
index ddfd0a32c653..06b992fa36ea 100644
--- a/drivers/media/platform/chips-media/coda/coda.h
+++ b/drivers/media/platform/chips-media/coda/coda.h
@@ -72,7 +72,7 @@ struct coda_aux_buf {
 	dma_addr_t		paddr;
 	u32			size;
 	struct debugfs_blob_wrapper blob;
-	struct dentry		*dentry;
+	struct debugfs_node *dentry;
 };
 
 struct coda_dev {
@@ -99,7 +99,7 @@ struct coda_dev {
 	struct workqueue_struct	*workqueue;
 	struct v4l2_m2m_dev	*m2m_dev;
 	struct ida		ida;
-	struct dentry		*debugfs_root;
+	struct debugfs_node *debugfs_root;
 	struct ratelimit_state	mb_err_rs;
 };
 
@@ -281,7 +281,7 @@ struct coda_ctx {
 	u32				frame_mem_ctrl;
 	u32				para_change;
 	int				display_idx;
-	struct dentry			*debugfs_entry;
+	struct debugfs_node *debugfs_entry;
 	bool				use_bit;
 	bool				use_vdoa;
 	struct vdoa_ctx			*vdoa;
diff --git a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_dbgfs.c b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_dbgfs.c
index 5ad3797836db..4ce1ef246c9d 100644
--- a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_dbgfs.c
+++ b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_dbgfs.c
@@ -179,7 +179,7 @@ EXPORT_SYMBOL_GPL(mtk_vcodec_dbgfs_remove);
 
 static void mtk_vcodec_dbgfs_vdec_init(struct mtk_vcodec_dec_dev *vcodec_dev)
 {
-	struct dentry *vcodec_root;
+	struct debugfs_node *vcodec_root;
 
 	vcodec_dev->dbgfs.vcodec_root = debugfs_create_dir("vcodec-dec", NULL);
 	if (IS_ERR(vcodec_dev->dbgfs.vcodec_root))
@@ -198,7 +198,7 @@ static void mtk_vcodec_dbgfs_vdec_init(struct mtk_vcodec_dec_dev *vcodec_dev)
 
 static void mtk_vcodec_dbgfs_venc_init(struct mtk_vcodec_enc_dev *vcodec_dev)
 {
-	struct dentry *vcodec_root;
+	struct debugfs_node *vcodec_root;
 
 	vcodec_dev->dbgfs.vcodec_root = debugfs_create_dir("vcodec-enc", NULL);
 	if (IS_ERR(vcodec_dev->dbgfs.vcodec_root))
diff --git a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_dbgfs.h b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_dbgfs.h
index 073d2fedb54a..1ddf68f4b1f6 100644
--- a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_dbgfs.h
+++ b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_dbgfs.h
@@ -42,7 +42,7 @@ struct mtk_vcodec_dbgfs_inst {
  */
 struct mtk_vcodec_dbgfs {
 	struct list_head dbgfs_head;
-	struct dentry *vcodec_root;
+	struct debugfs_node *vcodec_root;
 	struct mutex dbgfs_lock;
 	char dbgfs_buf[1024];
 	int buf_size;
diff --git a/drivers/media/platform/mediatek/vpu/mtk_vpu.c b/drivers/media/platform/mediatek/vpu/mtk_vpu.c
index 8d8319f0cd22..6ace789d2d7a 100644
--- a/drivers/media/platform/mediatek/vpu/mtk_vpu.c
+++ b/drivers/media/platform/mediatek/vpu/mtk_vpu.c
@@ -806,7 +806,7 @@ static irqreturn_t vpu_irq_handler(int irq, void *priv)
 }
 
 #ifdef CONFIG_DEBUG_FS
-static struct dentry *vpu_debugfs;
+static struct debugfs_node *vpu_debugfs;
 #endif
 static int mtk_vpu_probe(struct platform_device *pdev)
 {
diff --git a/drivers/media/platform/nxp/dw100/dw100.c b/drivers/media/platform/nxp/dw100/dw100.c
index 66582e7f92fc..cc28eea8471f 100644
--- a/drivers/media/platform/nxp/dw100/dw100.c
+++ b/drivers/media/platform/nxp/dw100/dw100.c
@@ -73,7 +73,7 @@ struct dw100_device {
 	void __iomem			*mmio;
 	struct clk_bulk_data		*clks;
 	int				num_clks;
-	struct dentry			*debugfs_root;
+	struct debugfs_node *debugfs_root;
 };
 
 struct dw100_q_data {
diff --git a/drivers/media/platform/nxp/imx-mipi-csis.c b/drivers/media/platform/nxp/imx-mipi-csis.c
index 29523bb84d95..2fe970cad753 100644
--- a/drivers/media/platform/nxp/imx-mipi-csis.c
+++ b/drivers/media/platform/nxp/imx-mipi-csis.c
@@ -333,7 +333,7 @@ struct mipi_csis_device {
 
 	spinlock_t slock;	/* Protect events */
 	struct mipi_csis_event events[MIPI_CSIS_NUM_EVENTS];
-	struct dentry *debugfs_root;
+	struct debugfs_node *debugfs_root;
 	struct {
 		bool enable;
 		u32 hs_settle;
diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h
index 9c7fe9e5f941..43b14290e948 100644
--- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h
+++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h
@@ -28,6 +28,7 @@
 
 struct clk_bulk_data;
 struct dentry;
+#define debugfs_node dentry
 struct device;
 struct media_intf_devnode;
 struct regmap;
@@ -293,7 +294,7 @@ struct mxc_isi_dev {
 	struct v4l2_device		v4l2_dev;
 	struct v4l2_async_notifier	notifier;
 
-	struct dentry			*debugfs_root;
+	struct debugfs_node *debugfs_root;
 };
 
 extern const struct mxc_gasket_ops mxc_imx8_gasket_ops;
diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index abeeafa86697..ab49bc90545b 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -227,7 +227,7 @@ struct venus_core {
 	unsigned int codecs_count;
 	unsigned int core0_usage_count;
 	unsigned int core1_usage_count;
-	struct dentry *root;
+	struct debugfs_node *root;
 	struct venus_img_version {
 		u32 major;
 		u32 minor;
diff --git a/drivers/media/platform/raspberrypi/rp1-cfe/cfe.c b/drivers/media/platform/raspberrypi/rp1-cfe/cfe.c
index 12660087b12f..7fc8caa77626 100644
--- a/drivers/media/platform/raspberrypi/rp1-cfe/cfe.c
+++ b/drivers/media/platform/raspberrypi/rp1-cfe/cfe.c
@@ -269,7 +269,7 @@ struct cfe_node {
 };
 
 struct cfe_device {
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 	struct kref kref;
 
 	/* peripheral base address */
diff --git a/drivers/media/platform/raspberrypi/rp1-cfe/csi2.c b/drivers/media/platform/raspberrypi/rp1-cfe/csi2.c
index 35c2ab1e2cd4..0fd2cc5aa6dc 100644
--- a/drivers/media/platform/raspberrypi/rp1-cfe/csi2.c
+++ b/drivers/media/platform/raspberrypi/rp1-cfe/csi2.c
@@ -523,7 +523,7 @@ static const struct v4l2_subdev_internal_ops csi2_internal_ops = {
 	.init_state = csi2_init_state,
 };
 
-int csi2_init(struct csi2_device *csi2, struct dentry *debugfs)
+int csi2_init(struct csi2_device *csi2, struct debugfs_node *debugfs)
 {
 	unsigned int ret;
 
diff --git a/drivers/media/platform/raspberrypi/rp1-cfe/pisp-fe.c b/drivers/media/platform/raspberrypi/rp1-cfe/pisp-fe.c
index 05762b1be2bc..b81468c04890 100644
--- a/drivers/media/platform/raspberrypi/rp1-cfe/pisp-fe.c
+++ b/drivers/media/platform/raspberrypi/rp1-cfe/pisp-fe.c
@@ -541,7 +541,7 @@ static const struct v4l2_subdev_internal_ops pisp_fe_internal_ops = {
 	.init_state = pisp_fe_init_state,
 };
 
-int pisp_fe_init(struct pisp_fe_device *fe, struct dentry *debugfs)
+int pisp_fe_init(struct pisp_fe_device *fe, struct debugfs_node *debugfs)
 {
 	int ret;
 
diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
index ca952fd0829b..97f2c02585d2 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
@@ -24,6 +24,7 @@
 #include "rkisp1-regs.h"
 
 struct dentry;
+#define debugfs_node dentry
 struct regmap;
 
 /*
@@ -461,7 +462,7 @@ struct rkisp1_resizer {
  *				  was not sent to userspace
  */
 struct rkisp1_debug {
-	struct dentry *debugfs_dir;
+	struct debugfs_node *debugfs_dir;
 	unsigned long data_loss;
 	unsigned long outform_size_error;
 	unsigned long img_stabilization_size_error;
diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c
index 79cda589d935..f69a3be2e4e0 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c
@@ -194,7 +194,7 @@ DEFINE_SHOW_ATTRIBUTE(rkisp1_debug_input_status);
 void rkisp1_debug_init(struct rkisp1_device *rkisp1)
 {
 	struct rkisp1_debug *debug = &rkisp1->debug;
-	struct dentry *regs_dir;
+	struct debugfs_node *regs_dir;
 
 	debug->debugfs_dir = debugfs_create_dir(dev_name(rkisp1->dev), NULL);
 
diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-is.h b/drivers/media/platform/samsung/exynos4-is/fimc-is.h
index c126b779aafc..023ec2c497fa 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-is.h
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-is.h
@@ -296,7 +296,7 @@ struct fimc_is {
 	struct is_share_region		*is_shared_region;
 	struct is_af_info		af;
 
-	struct dentry			*debugfs_entry;
+	struct debugfs_node *debugfs_entry;
 };
 
 static inline struct fimc_is *fimc_isp_to_is(struct fimc_isp *isp)
diff --git a/drivers/media/platform/st/sti/bdisp/bdisp.h b/drivers/media/platform/st/sti/bdisp/bdisp.h
index 3fb009d24791..4e2018187b26 100644
--- a/drivers/media/platform/st/sti/bdisp/bdisp.h
+++ b/drivers/media/platform/st/sti/bdisp/bdisp.h
@@ -153,7 +153,7 @@ struct bdisp_m2m_device {
  * @tot_duration:  total HW processing duration in microsecs
  */
 struct bdisp_dbg {
-	struct dentry           *debugfs_entry;
+	struct debugfs_node *debugfs_entry;
 	struct bdisp_node       *copy_node[MAX_NB_NODE];
 	struct bdisp_request    copy_request;
 	ktime_t                 hw_start;
diff --git a/drivers/media/platform/st/sti/hva/hva.h b/drivers/media/platform/st/sti/hva/hva.h
index ba6b893416ec..7aae88466b23 100644
--- a/drivers/media/platform/st/sti/hva/hva.h
+++ b/drivers/media/platform/st/sti/hva/hva.h
@@ -183,7 +183,7 @@ struct hva_stream {
  * @avg_bitrate:        average bitrate in kbps
  */
 struct hva_ctx_dbg {
-	struct dentry	*debugfs_entry;
+	struct debugfs_node *debugfs_entry;
 	bool		is_valid_period;
 	ktime_t		begin;
 	u32		total_duration;
@@ -288,7 +288,7 @@ struct hva_ctx {
  * @last_ctx:      debug information about last running instance context
  */
 struct hva_dev_dbg {
-	struct dentry	*debugfs_entry;
+	struct debugfs_node *debugfs_entry;
 	struct hva_ctx	last_ctx;
 };
 #endif
diff --git a/drivers/media/radio/radio-si476x.c b/drivers/media/radio/radio-si476x.c
index 9980346cb5ea..cb189820f542 100644
--- a/drivers/media/radio/radio-si476x.c
+++ b/drivers/media/radio/radio-si476x.c
@@ -308,7 +308,7 @@ struct si476x_radio {
 	/* This field should not be accesses unless core lock is held */
 	const struct si476x_radio_ops *ops;
 
-	struct dentry	*debugfs;
+	struct debugfs_node *debugfs;
 	u32 audmode;
 };
 
diff --git a/drivers/media/test-drivers/visl/visl-debugfs.c b/drivers/media/test-drivers/visl/visl-debugfs.c
index 45f2a8268014..b332614a1325 100644
--- a/drivers/media/test-drivers/visl/visl-debugfs.c
+++ b/drivers/media/test-drivers/visl/visl-debugfs.c
@@ -42,7 +42,7 @@ void visl_trace_bitstream(struct visl_ctx *ctx, struct visl_run *run)
 	u8 *vaddr = vb2_plane_vaddr(&run->src->vb2_buf, 0);
 	struct visl_blob *blob;
 	size_t data_sz = vb2_get_plane_payload(&run->src->vb2_buf, 0);
-	struct dentry *dentry;
+	struct debugfs_node *dentry;
 	char name[32];
 
 	blob  = kzalloc(sizeof(*blob), GFP_KERNEL);
diff --git a/drivers/media/test-drivers/visl/visl.h b/drivers/media/test-drivers/visl/visl.h
index 434e9efbf9b2..2cdba86e6ca2 100644
--- a/drivers/media/test-drivers/visl/visl.h
+++ b/drivers/media/test-drivers/visl/visl.h
@@ -111,8 +111,8 @@ struct visl_dev {
 	struct v4l2_m2m_dev	*m2m_dev;
 
 #ifdef CONFIG_VISL_DEBUGFS
-	struct dentry		*debugfs_root;
-	struct dentry		*bitstream_debugfs;
+	struct debugfs_node *debugfs_root;
+	struct debugfs_node *bitstream_debugfs;
 	struct list_head	bitstream_blobs;
 
 	/* Protects the "blob" list */
diff --git a/drivers/media/usb/uvc/uvc_debugfs.c b/drivers/media/usb/uvc/uvc_debugfs.c
index 14fa41cb8148..7d8b9b38496c 100644
--- a/drivers/media/usb/uvc/uvc_debugfs.c
+++ b/drivers/media/usb/uvc/uvc_debugfs.c
@@ -67,7 +67,7 @@ static const struct file_operations uvc_debugfs_stats_fops = {
  * Global and stream initialization/cleanup
  */
 
-static struct dentry *uvc_debugfs_root_dir;
+static struct debugfs_node *uvc_debugfs_root_dir;
 
 void uvc_debugfs_init_stream(struct uvc_streaming *stream)
 {
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 5e388f05f3fc..b7d1b0616c70 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -493,7 +493,7 @@ struct uvc_streaming {
 	u8 last_fid;
 
 	/* debugfs */
-	struct dentry *debugfs_dir;
+	struct debugfs_node *debugfs_dir;
 	struct {
 		struct uvc_stats_frame frame;
 		struct uvc_stats_stream stream;
diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
index ee884a8221fb..2464546f8088 100644
--- a/drivers/media/v4l2-core/v4l2-async.c
+++ b/drivers/media/v4l2-core/v4l2-async.c
@@ -949,7 +949,7 @@ static int pending_subdevs_show(struct seq_file *s, void *data)
 }
 DEFINE_SHOW_ATTRIBUTE(pending_subdevs);
 
-static struct dentry *v4l2_async_debugfs_dir;
+static struct debugfs_node *v4l2_async_debugfs_dir;
 
 static int __init v4l2_async_init(void)
 {
diff --git a/drivers/media/v4l2-core/v4l2-dev.c b/drivers/media/v4l2-core/v4l2-dev.c
index 5bcaeeba4d09..69f500a736fe 100644
--- a/drivers/media/v4l2-core/v4l2-dev.c
+++ b/drivers/media/v4l2-core/v4l2-dev.c
@@ -93,7 +93,7 @@ static struct attribute *video_device_attrs[] = {
 };
 ATTRIBUTE_GROUPS(video_device);
 
-static struct dentry *v4l2_debugfs_root_dir;
+static struct debugfs_node *v4l2_debugfs_root_dir;
 
 /*
  *	Active devices
@@ -1121,7 +1121,7 @@ void video_unregister_device(struct video_device *vdev)
 EXPORT_SYMBOL(video_unregister_device);
 
 #ifdef CONFIG_DEBUG_FS
-struct dentry *v4l2_debugfs_root(void)
+struct debugfs_node *v4l2_debugfs_root(void)
 {
 	if (!v4l2_debugfs_root_dir)
 		v4l2_debugfs_root_dir = debugfs_create_dir("v4l2", NULL);
diff --git a/drivers/media/v4l2-core/v4l2-dv-timings.c b/drivers/media/v4l2-core/v4l2-dv-timings.c
index d26edf157e64..a5ab8e2b8b5d 100644
--- a/drivers/media/v4l2-core/v4l2-dv-timings.c
+++ b/drivers/media/v4l2-core/v4l2-dv-timings.c
@@ -1191,7 +1191,8 @@ DEBUGFS_FOPS(audio, V4L2_DEBUGFS_IF_AUDIO);
 DEBUGFS_FOPS(spd, V4L2_DEBUGFS_IF_SPD);
 DEBUGFS_FOPS(hdmi, V4L2_DEBUGFS_IF_HDMI);
 
-struct v4l2_debugfs_if *v4l2_debugfs_if_alloc(struct dentry *root, u32 if_types,
+struct v4l2_debugfs_if *v4l2_debugfs_if_alloc(struct debugfs_node *root,
+					      u32 if_types,
 					      void *priv,
 					      v4l2_debugfs_if_read_t if_read)
 {
diff --git a/drivers/memory/emif.c b/drivers/memory/emif.c
index 2e1ecae9e959..85448b8072cf 100644
--- a/drivers/memory/emif.c
+++ b/drivers/memory/emif.c
@@ -63,7 +63,7 @@ struct emif_data {
 	struct emif_regs		*regs_cache[EMIF_MAX_NUM_FREQUENCIES];
 	struct emif_regs		*curr_regs;
 	struct emif_platform_data	*plat_data;
-	struct dentry			*debugfs_root;
+	struct debugfs_node *debugfs_root;
 	struct device_node		*np_ddr;
 };
 
diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
index 3ba05ebb9035..37397488cc1b 100644
--- a/drivers/mfd/intel-lpss.c
+++ b/drivers/mfd/intel-lpss.c
@@ -90,7 +90,7 @@ struct intel_lpss {
 	u32 caps;
 	u32 active_ltr;
 	u32 idle_ltr;
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 };
 
 static const struct resource intel_lpss_dev_resources[] = {
@@ -134,7 +134,7 @@ static const struct mfd_cell intel_lpss_spi_cell = {
 };
 
 static DEFINE_IDA(intel_lpss_devid_ida);
-static struct dentry *intel_lpss_debugfs;
+static struct debugfs_node *intel_lpss_debugfs;
 
 static void intel_lpss_cache_ltr(struct intel_lpss *lpss)
 {
@@ -144,7 +144,7 @@ static void intel_lpss_cache_ltr(struct intel_lpss *lpss)
 
 static int intel_lpss_debugfs_add(struct intel_lpss *lpss)
 {
-	struct dentry *dir;
+	struct debugfs_node *dir;
 
 	dir = debugfs_create_dir(dev_name(lpss->dev), intel_lpss_debugfs);
 	if (IS_ERR(dir))
diff --git a/drivers/mfd/tps65010.c b/drivers/mfd/tps65010.c
index 710364435b6b..c9c3dd8aace9 100644
--- a/drivers/mfd/tps65010.c
+++ b/drivers/mfd/tps65010.c
@@ -61,7 +61,7 @@ struct tps65010 {
 	struct i2c_client	*client;
 	struct mutex		lock;
 	struct delayed_work	work;
-	struct dentry		*file;
+	struct debugfs_node *file;
 	unsigned		charging:1;
 	unsigned		por:1;
 	unsigned		model:8;
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 6ad0ab892675..d889799046bc 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -490,7 +490,7 @@ struct cxl_afu {
 	struct cdev afu_cdev_s, afu_cdev_m, afu_cdev_d;
 	struct device *chardev_s, *chardev_m, *chardev_d;
 	struct idr contexts_idr;
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 	struct mutex contexts_lock;
 	spinlock_t afu_cntl_lock;
 
@@ -683,7 +683,7 @@ struct cxl {
 	struct device dev;
 	struct dentry *trace;
 	struct dentry *psl_err_chk;
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 	char *irq_name;
 	struct bin_attribute cxl_attr;
 	int adapter_num;
@@ -917,10 +917,14 @@ void cxl_debugfs_adapter_add(struct cxl *adapter);
 void cxl_debugfs_adapter_remove(struct cxl *adapter);
 void cxl_debugfs_afu_add(struct cxl_afu *afu);
 void cxl_debugfs_afu_remove(struct cxl_afu *afu);
-void cxl_debugfs_add_adapter_regs_psl9(struct cxl *adapter, struct dentry *dir);
-void cxl_debugfs_add_adapter_regs_psl8(struct cxl *adapter, struct dentry *dir);
-void cxl_debugfs_add_afu_regs_psl9(struct cxl_afu *afu, struct dentry *dir);
-void cxl_debugfs_add_afu_regs_psl8(struct cxl_afu *afu, struct dentry *dir);
+void cxl_debugfs_add_adapter_regs_psl9(struct cxl *adapter,
+				       struct debugfs_node *dir);
+void cxl_debugfs_add_adapter_regs_psl8(struct cxl *adapter,
+				       struct debugfs_node *dir);
+void cxl_debugfs_add_afu_regs_psl9(struct cxl_afu *afu,
+				   struct debugfs_node *dir);
+void cxl_debugfs_add_afu_regs_psl8(struct cxl_afu *afu,
+				   struct debugfs_node *dir);
 
 #else /* CONFIG_DEBUG_FS */
 
@@ -949,20 +953,22 @@ static inline void cxl_debugfs_afu_remove(struct cxl_afu *afu)
 }
 
 static inline void cxl_debugfs_add_adapter_regs_psl9(struct cxl *adapter,
-						    struct dentry *dir)
+						    struct debugfs_node *dir)
 {
 }
 
 static inline void cxl_debugfs_add_adapter_regs_psl8(struct cxl *adapter,
-						    struct dentry *dir)
+						    struct debugfs_node *dir)
 {
 }
 
-static inline void cxl_debugfs_add_afu_regs_psl9(struct cxl_afu *afu, struct dentry *dir)
+static inline void cxl_debugfs_add_afu_regs_psl9(struct cxl_afu *afu,
+						 struct debugfs_node *dir)
 {
 }
 
-static inline void cxl_debugfs_add_afu_regs_psl8(struct cxl_afu *afu, struct dentry *dir)
+static inline void cxl_debugfs_add_afu_regs_psl8(struct cxl_afu *afu,
+						 struct debugfs_node *dir)
 {
 }
 
diff --git a/drivers/misc/cxl/debugfs.c b/drivers/misc/cxl/debugfs.c
index 7b987bf498b5..29bc38ac580e 100644
--- a/drivers/misc/cxl/debugfs.c
+++ b/drivers/misc/cxl/debugfs.c
@@ -9,7 +9,7 @@
 
 #include "cxl.h"
 
-static struct dentry *cxl_debugfs;
+static struct debugfs_node *cxl_debugfs;
 
 /* Helpers to export CXL mmaped IO registers via debugfs */
 static int debugfs_io_u64_get(void *data, u64 *val)
@@ -27,13 +27,15 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_io_x64, debugfs_io_u64_get, debugfs_io_u64_set,
 			 "0x%016llx\n");
 
 static void debugfs_create_io_x64(const char *name, umode_t mode,
-				  struct dentry *parent, u64 __iomem *value)
+				  struct debugfs_node *parent,
+				  u64 __iomem *value)
 {
 	debugfs_create_file_unsafe(name, mode, parent, (void __force *)value,
 				   &fops_io_x64);
 }
 
-void cxl_debugfs_add_adapter_regs_psl9(struct cxl *adapter, struct dentry *dir)
+void cxl_debugfs_add_adapter_regs_psl9(struct cxl *adapter,
+				       struct debugfs_node *dir)
 {
 	debugfs_create_io_x64("fir1", S_IRUSR, dir, _cxl_p1_addr(adapter, CXL_PSL9_FIR1));
 	debugfs_create_io_x64("fir_mask", 0400, dir,
@@ -46,7 +48,8 @@ void cxl_debugfs_add_adapter_regs_psl9(struct cxl *adapter, struct dentry *dir)
 			      _cxl_p1_addr(adapter, CXL_XSL9_DBG));
 }
 
-void cxl_debugfs_add_adapter_regs_psl8(struct cxl *adapter, struct dentry *dir)
+void cxl_debugfs_add_adapter_regs_psl8(struct cxl *adapter,
+				       struct debugfs_node *dir)
 {
 	debugfs_create_io_x64("fir1", S_IRUSR, dir, _cxl_p1_addr(adapter, CXL_PSL_FIR1));
 	debugfs_create_io_x64("fir2", S_IRUSR, dir, _cxl_p1_addr(adapter, CXL_PSL_FIR2));
@@ -56,7 +59,7 @@ void cxl_debugfs_add_adapter_regs_psl8(struct cxl *adapter, struct dentry *dir)
 
 void cxl_debugfs_adapter_add(struct cxl *adapter)
 {
-	struct dentry *dir;
+	struct debugfs_node *dir;
 	char buf[32];
 
 	if (!cxl_debugfs)
@@ -77,12 +80,14 @@ void cxl_debugfs_adapter_remove(struct cxl *adapter)
 	debugfs_remove_recursive(adapter->debugfs);
 }
 
-void cxl_debugfs_add_afu_regs_psl9(struct cxl_afu *afu, struct dentry *dir)
+void cxl_debugfs_add_afu_regs_psl9(struct cxl_afu *afu,
+				   struct debugfs_node *dir)
 {
 	debugfs_create_io_x64("serr", S_IRUSR, dir, _cxl_p1n_addr(afu, CXL_PSL_SERR_An));
 }
 
-void cxl_debugfs_add_afu_regs_psl8(struct cxl_afu *afu, struct dentry *dir)
+void cxl_debugfs_add_afu_regs_psl8(struct cxl_afu *afu,
+				   struct debugfs_node *dir)
 {
 	debugfs_create_io_x64("sstp0", S_IRUSR, dir, _cxl_p2n_addr(afu, CXL_SSTP0_An));
 	debugfs_create_io_x64("sstp1", S_IRUSR, dir, _cxl_p2n_addr(afu, CXL_SSTP1_An));
@@ -95,7 +100,7 @@ void cxl_debugfs_add_afu_regs_psl8(struct cxl_afu *afu, struct dentry *dir)
 
 void cxl_debugfs_afu_add(struct cxl_afu *afu)
 {
-	struct dentry *dir;
+	struct debugfs_node *dir;
 	char buf[32];
 
 	if (!afu->adapter->debugfs)
diff --git a/drivers/misc/eeprom/idt_89hpesx.c b/drivers/misc/eeprom/idt_89hpesx.c
index 1fc632ebf22f..115ba7bc4e4d 100644
--- a/drivers/misc/eeprom/idt_89hpesx.c
+++ b/drivers/misc/eeprom/idt_89hpesx.c
@@ -63,7 +63,7 @@ MODULE_AUTHOR("T-platforms");
 /*
  * csr_dbgdir - CSR read/write operations Debugfs directory
  */
-static struct dentry *csr_dbgdir;
+static struct debugfs_node *csr_dbgdir;
 
 /*
  * struct idt_89hpesx_dev - IDT 89HPESx device data structure
@@ -104,7 +104,7 @@ struct idt_89hpesx_dev {
 	struct i2c_client *client;
 
 	struct bin_attribute *ee_file;
-	struct dentry *csr_dir;
+	struct debugfs_node *csr_dir;
 };
 
 /*
diff --git a/drivers/misc/genwqe/card_base.c b/drivers/misc/genwqe/card_base.c
index 224a7e97cbea..7c7d363b737d 100644
--- a/drivers/misc/genwqe/card_base.c
+++ b/drivers/misc/genwqe/card_base.c
@@ -43,7 +43,7 @@ MODULE_LICENSE("GPL");
 
 static char genwqe_driver_name[] = GENWQE_DEVNAME;
 
-static struct dentry *debugfs_genwqe;
+static struct debugfs_node *debugfs_genwqe;
 static struct genwqe_dev *genwqe_devices[GENWQE_CARD_NO_MAX];
 
 /* PCI structure for identifying device by PCI vendor and device ID */
diff --git a/drivers/misc/genwqe/card_base.h b/drivers/misc/genwqe/card_base.h
index d700266f2cd0..7a27fc351bdb 100644
--- a/drivers/misc/genwqe/card_base.h
+++ b/drivers/misc/genwqe/card_base.h
@@ -293,8 +293,8 @@ struct genwqe_dev {
 	struct device *dev;		/* for device creation */
 	struct cdev cdev_genwqe;	/* char device for card */
 
-	struct dentry *debugfs_root;	/* debugfs card root directory */
-	struct dentry *debugfs_genwqe;	/* debugfs driver root directory */
+	struct debugfs_node *debugfs_root;	/* debugfs card root directory */
+	struct debugfs_node *debugfs_genwqe;	/* debugfs driver root directory */
 
 	/* pci resources */
 	struct pci_dev *pci_dev;	/* PCI device */
diff --git a/drivers/misc/genwqe/card_debugfs.c b/drivers/misc/genwqe/card_debugfs.c
index 491fb4482da2..3f44d323ab9f 100644
--- a/drivers/misc/genwqe/card_debugfs.c
+++ b/drivers/misc/genwqe/card_debugfs.c
@@ -318,7 +318,7 @@ DEFINE_SHOW_ATTRIBUTE(info);
 
 void genwqe_init_debugfs(struct genwqe_dev *cd)
 {
-	struct dentry *root;
+	struct debugfs_node *root;
 	char card_name[64];
 	char name[64];
 	unsigned int i;
diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index 5732fd59a227..46c035a87ba2 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -388,7 +388,7 @@ int lkdtm_check_bool_cmdline(const char *param)
 }
 #endif
 
-static struct dentry *lkdtm_debugfs_root;
+static struct debugfs_node *lkdtm_debugfs_root;
 
 static int __init lkdtm_module_init(void)
 {
diff --git a/drivers/misc/mei/debugfs.c b/drivers/misc/mei/debugfs.c
index 3b098d4c8e3d..c76616679d90 100644
--- a/drivers/misc/mei/debugfs.c
+++ b/drivers/misc/mei/debugfs.c
@@ -178,7 +178,7 @@ void mei_dbgfs_deregister(struct mei_device *dev)
  */
 void mei_dbgfs_register(struct mei_device *dev, const char *name)
 {
-	struct dentry *dir;
+	struct debugfs_node *dir;
 
 	dir = debugfs_create_dir(name, NULL);
 	dev->dbgfs_dir = dir;
diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
index 37d7fb15cad7..6a6b6c3e92df 100644
--- a/drivers/misc/mei/mei_dev.h
+++ b/drivers/misc/mei/mei_dev.h
@@ -645,7 +645,7 @@ struct mei_device {
 	const char *kind;
 
 #if IS_ENABLED(CONFIG_DEBUG_FS)
-	struct dentry *dbgfs_dir;
+	struct debugfs_node *dbgfs_dir;
 #endif /* CONFIG_DEBUG_FS */
 
 	struct mei_fw_status saved_fw_status;
diff --git a/drivers/misc/xilinx_tmr_inject.c b/drivers/misc/xilinx_tmr_inject.c
index 6284606ffb9f..2e0d35528c22 100644
--- a/drivers/misc/xilinx_tmr_inject.c
+++ b/drivers/misc/xilinx_tmr_inject.c
@@ -44,7 +44,7 @@ static DECLARE_FAULT_ATTR(inject_fault);
 static char *inject_request;
 module_param(inject_request, charp, 0);
 MODULE_PARM_DESC(inject_request, "default fault injection attributes");
-static struct dentry *dbgfs_root;
+static struct debugfs_node *dbgfs_root;
 
 /* IO accessors */
 static inline void xtmr_inject_write(struct xtmr_inject_dev *xtmr_inject,
@@ -71,7 +71,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(xtmr_inject_fops, NULL, xtmr_inject_set, "%llu\n");
 
 static void xtmr_init_debugfs(struct xtmr_inject_dev *xtmr_inject)
 {
-	struct dentry *dir;
+	struct debugfs_node *dir;
 
 	dbgfs_root = debugfs_create_dir("xtmr_inject", NULL);
 	dir = fault_create_debugfs_attr("inject_fault", dbgfs_root,
diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 4830628510e6..2c6ae448cb89 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -181,8 +181,8 @@ struct mmc_blk_data {
 	int	area_type;
 
 	/* debugfs files (only in main mmc_blk_data) */
-	struct dentry *status_dentry;
-	struct dentry *ext_csd_dentry;
+	struct debugfs_node *status_dentry;
+	struct debugfs_node *ext_csd_dentry;
 };
 
 /* Device type for RPMB character devices */
@@ -3228,7 +3228,7 @@ static const struct file_operations mmc_dbg_ext_csd_fops = {
 
 static void mmc_blk_add_debugfs(struct mmc_card *card, struct mmc_blk_data *md)
 {
-	struct dentry *root;
+	struct debugfs_node *root;
 
 	if (!card->debugfs_root)
 		return;
diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index f10a4dcf1f95..716204e6df3f 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -346,7 +346,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(mmc_caps2_fops, mmc_caps_get, mmc_caps2_set,
 
 void mmc_add_host_debugfs(struct mmc_host *host)
 {
-	struct dentry *root;
+	struct debugfs_node *root;
 
 	root = debugfs_create_dir(mmc_hostname(host), NULL);
 	host->debugfs_root = root;
@@ -380,7 +380,7 @@ void mmc_remove_host_debugfs(struct mmc_host *host)
 void mmc_add_card_debugfs(struct mmc_card *card)
 {
 	struct mmc_host	*host = card->host;
-	struct dentry	*root;
+	struct debugfs_node	*root;
 
 	if (!host->debugfs_root)
 		return;
diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
index 4f4286b8e0f2..c8d1f8462d14 100644
--- a/drivers/mmc/core/mmc_test.c
+++ b/drivers/mmc/core/mmc_test.c
@@ -128,7 +128,7 @@ struct mmc_test_general_result {
 struct mmc_test_dbgfs_file {
 	struct list_head link;
 	struct mmc_card *card;
-	struct dentry *file;
+	struct debugfs_node *file;
 };
 
 /**
@@ -3192,7 +3192,7 @@ static void mmc_test_free_dbgfs_file(struct mmc_card *card)
 static int __mmc_test_register_dbgfs_file(struct mmc_card *card,
 	const char *name, umode_t mode, const struct file_operations *fops)
 {
-	struct dentry *file = NULL;
+	struct debugfs_node *file = NULL;
 	struct mmc_test_dbgfs_file *df;
 
 	if (card->debugfs_root)
diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index fc360902729d..e62fd5857b08 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -603,7 +603,7 @@ static void atmci_init_debugfs(struct atmel_mci_slot *slot)
 {
 	struct mmc_host		*mmc = slot->mmc;
 	struct atmel_mci	*host = slot->host;
-	struct dentry		*root;
+	struct debugfs_node		*root;
 
 	root = mmc->debugfs_root;
 	if (!root)
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 3cbda98d08d2..133f4e674c3d 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -169,7 +169,7 @@ static void dw_mci_init_debugfs(struct dw_mci_slot *slot)
 {
 	struct mmc_host	*mmc = slot->mmc;
 	struct dw_mci *host = slot->host;
-	struct dentry *root;
+	struct debugfs_node *root;
 
 	root = mmc->debugfs_root;
 	if (!root)
diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 1f0bd723f011..9d916f05ddba 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -862,7 +862,7 @@ static void byt_add_debugfs(struct sdhci_pci_slot *slot)
 {
 	struct intel_host *intel_host = sdhci_pci_priv(slot);
 	struct mmc_host *mmc = slot->host->mmc;
-	struct dentry *dir = mmc->debugfs_root;
+	struct debugfs_node *dir = mmc->debugfs_root;
 
 	if (!intel_use_ltr(slot->chip))
 		return;
diff --git a/drivers/mtd/devices/docg3.c b/drivers/mtd/devices/docg3.c
index c93769c233d9..242492b36b96 100644
--- a/drivers/mtd/devices/docg3.c
+++ b/drivers/mtd/devices/docg3.c
@@ -1724,7 +1724,7 @@ DEFINE_SHOW_ATTRIBUTE(protection);
 
 static void __init doc_dbg_register(struct mtd_info *floor)
 {
-	struct dentry *root = floor->dbg.dfs_dir;
+	struct debugfs_node *root = floor->dbg.dfs_dir;
 	struct docg3 *docg3 = floor->priv;
 
 	if (IS_ERR_OR_NULL(root)) {
diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 724f917f91ba..401f1b607fd1 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -382,7 +382,7 @@ bool mtd_check_expert_analysis_mode(void)
 EXPORT_SYMBOL_GPL(mtd_check_expert_analysis_mode);
 #endif
 
-static struct dentry *dfs_dir_mtd;
+static struct debugfs_node *dfs_dir_mtd;
 
 static void mtd_debugfs_populate(struct mtd_info *mtd)
 {
diff --git a/drivers/mtd/mtdswap.c b/drivers/mtd/mtdswap.c
index 680366616da2..57b86e80d5f5 100644
--- a/drivers/mtd/mtdswap.c
+++ b/drivers/mtd/mtdswap.c
@@ -1254,7 +1254,7 @@ DEFINE_SHOW_ATTRIBUTE(mtdswap);
 
 static int mtdswap_add_debugfs(struct mtdswap_dev *d)
 {
-	struct dentry *root = d->mtd->dbg.dfs_dir;
+	struct debugfs_node *root = d->mtd->dbg.dfs_dir;
 
 	if (!IS_ENABLED(CONFIG_DEBUG_FS))
 		return 0;
diff --git a/drivers/mtd/nand/raw/nandsim.c b/drivers/mtd/nand/raw/nandsim.c
index df48b7d01d16..f4432b0234c2 100644
--- a/drivers/mtd/nand/raw/nandsim.c
+++ b/drivers/mtd/nand/raw/nandsim.c
@@ -357,7 +357,7 @@ struct nandsim {
 	int held_cnt;
 
 	/* debugfs entry */
-	struct dentry *dent;
+	struct debugfs_node *dent;
 };
 
 /*
@@ -499,7 +499,7 @@ DEFINE_SHOW_ATTRIBUTE(ns);
  */
 static int ns_debugfs_create(struct nandsim *ns)
 {
-	struct dentry *root = nsmtd->dbg.dfs_dir;
+	struct debugfs_node *root = nsmtd->dbg.dfs_dir;
 
 	/*
 	 * Just skip debugfs initialization when the debugfs directory is
diff --git a/drivers/mtd/spi-nor/debugfs.c b/drivers/mtd/spi-nor/debugfs.c
index fa6956144d2e..bd205ec14ee3 100644
--- a/drivers/mtd/spi-nor/debugfs.c
+++ b/drivers/mtd/spi-nor/debugfs.c
@@ -227,11 +227,11 @@ static void spi_nor_debugfs_unregister(void *data)
 	nor->debugfs_root = NULL;
 }
 
-static struct dentry *rootdir;
+static struct debugfs_node *rootdir;
 
 void spi_nor_debugfs_register(struct spi_nor *nor)
 {
-	struct dentry *d;
+	struct debugfs_node *d;
 	int ret;
 
 	if (!rootdir)
diff --git a/drivers/mtd/ubi/debug.c b/drivers/mtd/ubi/debug.c
index d2a53961d8e2..885b311379d4 100644
--- a/drivers/mtd/ubi/debug.c
+++ b/drivers/mtd/ubi/debug.c
@@ -240,12 +240,12 @@ void ubi_dump_mkvol_req(const struct ubi_mkvol_req *req)
  * Root directory for UBI stuff in debugfs. Contains sub-directories which
  * contain the stuff specific to particular UBI devices.
  */
-static struct dentry *dfs_rootdir;
+static struct debugfs_node *dfs_rootdir;
 
 #ifdef CONFIG_MTD_UBI_FAULT_INJECTION
-static void dfs_create_fault_entry(struct dentry *parent)
+static void dfs_create_fault_entry(struct debugfs_node *parent)
 {
-	struct dentry *dir;
+	struct debugfs_node *dir;
 
 	dir = debugfs_create_dir("fault_inject", parent);
 	if (IS_ERR_OR_NULL(dir)) {
diff --git a/drivers/mtd/ubi/ubi.h b/drivers/mtd/ubi/ubi.h
index c792b9bcab9b..aff3c085b394 100644
--- a/drivers/mtd/ubi/ubi.h
+++ b/drivers/mtd/ubi/ubi.h
@@ -421,17 +421,17 @@ struct ubi_debug_info {
 	unsigned int power_cut_max;
 	unsigned int emulate_failures;
 	char dfs_dir_name[UBI_DFS_DIR_LEN];
-	struct dentry *dfs_dir;
-	struct dentry *dfs_chk_gen;
-	struct dentry *dfs_chk_io;
-	struct dentry *dfs_chk_fastmap;
-	struct dentry *dfs_disable_bgt;
-	struct dentry *dfs_emulate_bitflips;
-	struct dentry *dfs_emulate_io_failures;
-	struct dentry *dfs_emulate_power_cut;
-	struct dentry *dfs_power_cut_min;
-	struct dentry *dfs_power_cut_max;
-	struct dentry *dfs_emulate_failures;
+	struct debugfs_node *dfs_dir;
+	struct debugfs_node *dfs_chk_gen;
+	struct debugfs_node *dfs_chk_io;
+	struct debugfs_node *dfs_chk_fastmap;
+	struct debugfs_node *dfs_disable_bgt;
+	struct debugfs_node *dfs_emulate_bitflips;
+	struct debugfs_node *dfs_emulate_io_failures;
+	struct debugfs_node *dfs_emulate_power_cut;
+	struct debugfs_node *dfs_power_cut_min;
+	struct debugfs_node *dfs_power_cut_max;
+	struct debugfs_node *dfs_emulate_failures;
 };
 
 /**
diff --git a/drivers/net/bonding/bond_debugfs.c b/drivers/net/bonding/bond_debugfs.c
index 8adbec7c5084..ae5b80f16234 100644
--- a/drivers/net/bonding/bond_debugfs.c
+++ b/drivers/net/bonding/bond_debugfs.c
@@ -12,7 +12,7 @@
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
 
-static struct dentry *bonding_debug_root;
+static struct debugfs_node *bonding_debug_root;
 
 /* Show RLB hash table */
 static int bond_debug_rlb_hash_show(struct seq_file *m, void *v)
diff --git a/drivers/net/caif/caif_serial.c b/drivers/net/caif/caif_serial.c
index ed3a589def6b..e31268644f88 100644
--- a/drivers/net/caif/caif_serial.c
+++ b/drivers/net/caif/caif_serial.c
@@ -57,7 +57,7 @@ module_param(ser_write_chunk, int, 0444);
 
 MODULE_PARM_DESC(ser_write_chunk, "Maximum size of data written to UART.");
 
-static struct dentry *debugfsdir;
+static struct debugfs_node *debugfsdir;
 
 static int caif_net_open(struct net_device *dev);
 static int caif_net_close(struct net_device *dev);
@@ -71,7 +71,7 @@ struct ser_device {
 	bool tx_started;
 	unsigned long state;
 #ifdef CONFIG_DEBUG_FS
-	struct dentry *debugfs_tty_dir;
+	struct debugfs_node *debugfs_tty_dir;
 	struct debugfs_blob_wrapper tx_blob;
 	struct debugfs_blob_wrapper rx_blob;
 	u8 rx_data[128];
diff --git a/drivers/net/caif/caif_virtio.c b/drivers/net/caif/caif_virtio.c
index 7fea00c7ca8a..ddc1a1788775 100644
--- a/drivers/net/caif/caif_virtio.c
+++ b/drivers/net/caif/caif_virtio.c
@@ -123,7 +123,7 @@ struct cfv_info {
 	unsigned long reserved_mem;
 	size_t reserved_size;
 	struct cfv_stats stats;
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 };
 
 /* struct buf_info - maintains transmit buffer data handle
diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
index 14522d6d5f86..42a0b01a9f9b 100644
--- a/drivers/net/ethernet/amd/pds_core/core.h
+++ b/drivers/net/ethernet/amd/pds_core/core.h
@@ -129,7 +129,7 @@ struct pdsc_qcq {
 	int intx;
 
 	u32 accum_work;
-	struct dentry *dentry;
+	struct debugfs_node *dentry;
 };
 
 struct pdsc_viftype {
@@ -153,7 +153,7 @@ enum pdsc_state_flags {
 
 struct pdsc {
 	struct pci_dev *pdev;
-	struct dentry *dentry;
+	struct debugfs_node *dentry;
 	struct device *dev;
 	struct pdsc_dev_bar bars[PDS_CORE_BARS_MAX];
 	struct pdsc_vf *vfs;
diff --git a/drivers/net/ethernet/amd/pds_core/debugfs.c b/drivers/net/ethernet/amd/pds_core/debugfs.c
index ac37a4e738ae..82754bec6329 100644
--- a/drivers/net/ethernet/amd/pds_core/debugfs.c
+++ b/drivers/net/ethernet/amd/pds_core/debugfs.c
@@ -5,7 +5,7 @@
 
 #include "core.h"
 
-static struct dentry *pdsc_dir;
+static struct debugfs_node *pdsc_dir;
 
 void pdsc_debugfs_create(void)
 {
@@ -106,7 +106,7 @@ static const struct debugfs_reg32 intr_ctrl_regs[] = {
 
 void pdsc_debugfs_add_qcq(struct pdsc *pdsc, struct pdsc_qcq *qcq)
 {
-	struct dentry *qcq_dentry, *q_dentry, *cq_dentry, *intr_dentry;
+	struct debugfs_node *qcq_dentry, *q_dentry, *cq_dentry, *intr_dentry;
 	struct debugfs_regset32 *intr_ctrl_regset;
 	struct pdsc_queue *q = &qcq->q;
 	struct pdsc_cq *cq = &qcq->cq;
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index d85386cac8d1..ccf513936d0f 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -1304,7 +1304,7 @@ struct xgbe_prv_data {
 	struct work_struct i2c_bh_work;
 	struct work_struct an_bh_work;
 
-	struct dentry *xgbe_debugfs;
+	struct debugfs_node *xgbe_debugfs;
 
 	unsigned int debugfs_xgmac_reg;
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 2373f423a523..92cabca03ca0 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2704,7 +2704,7 @@ struct bnxt {
 	u8			dsn[8];
 	struct bnxt_tc_info	*tc_info;
 	struct list_head	tc_indr_block_list;
-	struct dentry		*debugfs_pdev;
+	struct debugfs_node *debugfs_pdev;
 #ifdef CONFIG_BNXT_HWMON
 	struct device		*hwmon_dev;
 	u8			warn_thresh_temp;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_debugfs.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_debugfs.c
index 127b7015f676..47ce1b953b9b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_debugfs.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_debugfs.c
@@ -15,7 +15,7 @@
 #include "bnxt.h"
 #include "bnxt_debugfs.h"
 
-static struct dentry *bnxt_debug_mnt;
+static struct debugfs_node *bnxt_debug_mnt;
 
 static ssize_t debugfs_dim_read(struct file *filep,
 				char __user *buffer,
@@ -62,7 +62,7 @@ static const struct file_operations debugfs_dim_fops = {
 };
 
 static void debugfs_dim_ring_init(struct dim *dim, int ring_idx,
-				  struct dentry *dd)
+				  struct debugfs_node *dd)
 {
 	static char qname[12];
 
@@ -73,7 +73,7 @@ static void debugfs_dim_ring_init(struct dim *dim, int ring_idx,
 void bnxt_debug_dev_init(struct bnxt *bp)
 {
 	const char *pname = pci_name(bp->pdev);
-	struct dentry *dir;
+	struct debugfs_node *dir;
 	int i;
 
 	bp->debugfs_pdev = debugfs_create_dir(pname, bnxt_debug_mnt);
diff --git a/drivers/net/ethernet/brocade/bna/bnad.h b/drivers/net/ethernet/brocade/bna/bnad.h
index 4396997c59d0..da08ae5041a9 100644
--- a/drivers/net/ethernet/brocade/bna/bnad.h
+++ b/drivers/net/ethernet/brocade/bna/bnad.h
@@ -351,7 +351,7 @@ struct bnad {
 	/* debugfs specific data */
 	char	*regdata;
 	u32	reglen;
-	struct dentry *port_debugfs_root;
+	struct debugfs_node *port_debugfs_root;
 };
 
 struct bnad_drvinfo {
diff --git a/drivers/net/ethernet/brocade/bna/bnad_debugfs.c b/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
index 8f0972e6737c..487aefaff171 100644
--- a/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
+++ b/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
@@ -485,7 +485,7 @@ static const struct bnad_debugfs_entry bnad_debugfs_files[] = {
 	{ "drvinfo", S_IFREG | 0444, &bnad_debugfs_op_drvinfo, },
 };
 
-static struct dentry *bna_debugfs_root;
+static struct debugfs_node *bna_debugfs_root;
 static atomic_t bna_debugfs_port_count;
 
 /* Initialize debugfs interface for BNA */
diff --git a/drivers/net/ethernet/chelsio/cxgb3/adapter.h b/drivers/net/ethernet/chelsio/cxgb3/adapter.h
index 9d11e55981a0..c3417b3826bf 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/adapter.h
+++ b/drivers/net/ethernet/chelsio/cxgb3/adapter.h
@@ -258,7 +258,7 @@ struct adapter {
 	struct work_struct db_empty_task;
 	struct work_struct db_drop_task;
 
-	struct dentry *debugfs_root;
+	struct debugfs_node *debugfs_root;
 
 	struct mutex mdio_lock;
 	spinlock_t stats_lock;
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
index c7c2c15a1815..3c656370aed1 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
@@ -698,6 +698,7 @@ struct port_info {
 };
 
 struct dentry;
+#define debugfs_node dentry
 struct work_struct;
 
 enum {                                 /* adapter flags */
@@ -1178,7 +1179,7 @@ struct adapter {
 
 	struct mutex uld_mutex;
 
-	struct dentry *debugfs_root;
+	struct debugfs_node *debugfs_root;
 	bool use_bd;     /* Use SGE Back Door intfc for reading SGE Contexts */
 	bool trace_rss;	/* 1 implies that different RSS flit per filter is
 			 * used per filter else if 0 default RSS flit is
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index 2f0b3e389e62..2f8a1a320de5 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -178,7 +178,7 @@ module_param(select_queue, int, 0644);
 MODULE_PARM_DESC(select_queue,
 		 "Select between kernel provided method of selecting or driver method of selecting TX queue. Default is kernel method.");
 
-static struct dentry *cxgb4_debugfs_root;
+static struct debugfs_node *cxgb4_debugfs_root;
 
 LIST_HEAD(adapter_list);
 DEFINE_MUTEX(uld_mutex);
diff --git a/drivers/net/ethernet/chelsio/cxgb4vf/adapter.h b/drivers/net/ethernet/chelsio/cxgb4vf/adapter.h
index 03cb1410d6fc..a1422deeca94 100644
--- a/drivers/net/ethernet/chelsio/cxgb4vf/adapter.h
+++ b/drivers/net/ethernet/chelsio/cxgb4vf/adapter.h
@@ -389,7 +389,7 @@ struct adapter {
 	unsigned int msg_enable;
 
 	/* debugfs resources */
-	struct dentry *debugfs_root;
+	struct debugfs_node *debugfs_root;
 
 	/* various locks */
 	spinlock_t stats_lock;
diff --git a/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c b/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
index 2fbe0f059a0b..74035705db05 100644
--- a/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
@@ -124,7 +124,7 @@ enum {
  * ====================
  */
 
-static struct dentry *cxgb4vf_debugfs_root;
+static struct debugfs_node *cxgb4vf_debugfs_root;
 
 /*
  * OS "Callback" functions.
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-debugfs.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-debugfs.c
index 1af254caeb0d..952d59ddb2ce 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-debugfs.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-debugfs.c
@@ -9,7 +9,7 @@
 
 #define DPAA2_ETH_DBG_ROOT "dpaa2-eth"
 
-static struct dentry *dpaa2_dbg_root;
+static struct debugfs_node *dpaa2_dbg_root;
 
 static int dpaa2_dbg_cpu_show(struct seq_file *file, void *offset)
 {
@@ -167,7 +167,7 @@ DEFINE_SHOW_ATTRIBUTE(dpaa2_dbg_bp);
 void dpaa2_dbg_add(struct dpaa2_eth_priv *priv)
 {
 	struct fsl_mc_device *dpni_dev;
-	struct dentry *dir;
+	struct debugfs_node *dir;
 	char name[10];
 
 	/* Create a directory for the interface */
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-debugfs.h b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-debugfs.h
index 15598b28f03b..1e61a6a4a01a 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-debugfs.h
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-debugfs.h
@@ -10,7 +10,7 @@
 struct dpaa2_eth_priv;
 
 struct dpaa2_debugfs {
-	struct dentry *dir;
+	struct debugfs_node *dir;
 };
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
index bcb8eefeb93c..df207ce30862 100644
--- a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
+++ b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
@@ -84,7 +84,7 @@ struct netc_blk_ctrl {
 
 	const struct netc_devinfo *devinfo;
 	struct platform_device *pdev;
-	struct dentry *debugfs_root;
+	struct debugfs_node *debugfs_root;
 };
 
 static void netc_reg_write(void __iomem *base, u32 offset, u32 val)
@@ -298,7 +298,7 @@ DEFINE_SHOW_ATTRIBUTE(netc_prb);
 
 static void netc_blk_ctrl_create_debugfs(struct netc_blk_ctrl *priv)
 {
-	struct dentry *root;
+	struct debugfs_node *root;
 
 	root = debugfs_create_dir("netc_blk_ctrl", NULL);
 	if (IS_ERR(root))
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
index 8473c43d171a..3985b465683c 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
@@ -12,7 +12,7 @@
 #include "hbg_irq.h"
 #include "hbg_txrx.h"
 
-static struct dentry *hbg_dbgfs_root;
+static struct debugfs_node *hbg_dbgfs_root;
 
 struct hbg_dbg_info {
 	const char *name;
@@ -135,7 +135,7 @@ void hbg_debugfs_init(struct hbg_priv *priv)
 {
 	const char *name = pci_name(priv->pdev);
 	struct device *dev = &priv->pdev->dev;
-	struct dentry *root;
+	struct debugfs_node *root;
 	u32 i;
 
 	root = debugfs_create_dir(name, hbg_dbgfs_root);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 4e44f28288f9..5dcda6c14e5d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -915,7 +915,7 @@ struct hnae3_handle {
 	enum hnae3_port_base_vlan_state port_base_vlan_state;
 
 	u8 netdev_flags;
-	struct dentry *hnae3_dbgfs;
+	struct debugfs_node *hnae3_dbgfs;
 
 	/* Network interface message level enabled bits */
 	u32 msg_enable;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index 9bbece25552b..96efefacbda0 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -8,7 +8,7 @@
 #include "hns3_debugfs.h"
 #include "hns3_enet.h"
 
-static struct dentry *hns3_dbgfs_root;
+static struct debugfs_node *hns3_dbgfs_root;
 
 static struct hns3_dbg_dentry_info hns3_dbg_dentry[] = {
 	{
@@ -1313,7 +1313,7 @@ static const struct file_operations hns3_dbg_fops = {
 
 static int hns3_dbg_bd_file_init(struct hnae3_handle *handle, u32 cmd)
 {
-	struct dentry *entry_dir;
+	struct debugfs_node *entry_dir;
 	struct hns3_dbg_data *data;
 	u16 max_queue_num;
 	unsigned int i;
@@ -1343,7 +1343,7 @@ static int
 hns3_dbg_common_file_init(struct hnae3_handle *handle, u32 cmd)
 {
 	struct hns3_dbg_data *data;
-	struct dentry *entry_dir;
+	struct debugfs_node *entry_dir;
 
 	data = devm_kzalloc(&handle->pdev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.h b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.h
index 4a5ef8a90a10..8aafa89ba62c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.h
@@ -42,7 +42,7 @@ enum hns3_dbg_dentry_type {
 
 struct hns3_dbg_dentry_info {
 	const char *name;
-	struct dentry *dentry;
+	struct debugfs_node *dentry;
 };
 
 struct hns3_dbg_cmd_info {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index b9fc719880bb..89111c946215 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -933,7 +933,7 @@ struct hclge_dev {
 	struct hclge_comm_tqp *htqp;
 	struct hclge_vport *vport;
 
-	struct dentry *hclge_dbgfs;
+	struct debugfs_node *hclge_dbgfs;
 
 	struct hnae3_client *nic_client;
 	struct hnae3_client *roce_client;
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_debugfs.c b/drivers/net/ethernet/huawei/hinic/hinic_debugfs.c
index 061952c6c21a..404bff70d0fd 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_debugfs.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_debugfs.c
@@ -8,7 +8,7 @@
 
 #include "hinic_debugfs.h"
 
-static struct dentry *hinic_dbgfs_root;
+static struct debugfs_node *hinic_dbgfs_root;
 
 enum sq_dbg_info {
 	GLB_SQ_ID,
@@ -176,7 +176,8 @@ static const struct file_operations hinic_dbg_cmd_fops = {
 };
 
 static int create_dbg_files(struct hinic_dev *dev, enum hinic_dbg_type type, void *data,
-			    struct dentry *root, struct hinic_debug_priv **dbg, char **field,
+			    struct debugfs_node *root,
+			    struct hinic_debug_priv **dbg, char **field,
 			    int nfile)
 {
 	struct hinic_debug_priv *tmp;
@@ -212,7 +213,7 @@ static void rem_dbg_files(struct hinic_debug_priv *dbg)
 int hinic_sq_debug_add(struct hinic_dev *dev, u16 sq_id)
 {
 	struct hinic_sq *sq;
-	struct dentry *root;
+	struct debugfs_node *root;
 	char sub_dir[16];
 
 	sq = dev->txqs[sq_id].sq;
@@ -234,7 +235,7 @@ void hinic_sq_debug_rem(struct hinic_sq *sq)
 int hinic_rq_debug_add(struct hinic_dev *dev, u16 rq_id)
 {
 	struct hinic_rq *rq;
-	struct dentry *root;
+	struct debugfs_node *root;
 	char sub_dir[16];
 
 	rq = dev->rxqs[rq_id].rq;
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_dev.h b/drivers/net/ethernet/huawei/hinic/hinic_dev.h
index 52ea97c818b8..7ce49031c76a 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_dev.h
+++ b/drivers/net/ethernet/huawei/hinic/hinic_dev.h
@@ -113,10 +113,10 @@ struct hinic_dev {
 	int				lb_pkt_len;
 	u8				*lb_test_rx_buf;
 
-	struct dentry			*dbgfs_root;
-	struct dentry			*sq_dbgfs;
-	struct dentry			*rq_dbgfs;
-	struct dentry			*func_tbl_dbgfs;
+	struct debugfs_node *dbgfs_root;
+	struct debugfs_node *sq_dbgfs;
+	struct debugfs_node *rq_dbgfs;
+	struct debugfs_node *func_tbl_dbgfs;
 	struct hinic_debug_priv		*dbg;
 	struct devlink			*devlink;
 	bool				cable_unplugged;
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k.h b/drivers/net/ethernet/intel/fm10k/fm10k.h
index 6119a4108838..fd3106902bff 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k.h
+++ b/drivers/net/ethernet/intel/fm10k/fm10k.h
@@ -193,7 +193,7 @@ struct fm10k_q_vector {
 	char name[IFNAMSIZ + 9];
 
 #ifdef CONFIG_DEBUG_FS
-	struct dentry *dbg_q_vector;
+	struct debugfs_node *dbg_q_vector;
 #endif /* CONFIG_DEBUG_FS */
 	struct rcu_head rcu;	/* to avoid race with update stats on free */
 
@@ -374,7 +374,7 @@ struct fm10k_intfc {
 	spinlock_t macvlan_lock;
 
 #ifdef CONFIG_DEBUG_FS
-	struct dentry *dbg_intfc;
+	struct debugfs_node *dbg_intfc;
 #endif /* CONFIG_DEBUG_FS */
 
 #ifdef CONFIG_DCB
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c b/drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c
index 5c77054d67c6..c05c0e3667f3 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c
@@ -6,7 +6,7 @@
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
 
-static struct dentry *dbg_root;
+static struct debugfs_node *dbg_root;
 
 /* Descriptor Seq Functions */
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index c67963bfe14e..bccab828307e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -565,7 +565,7 @@ struct i40e_pf {
 	u16 main_vsi_seid;
 	u16 mac_seid;
 #ifdef CONFIG_DEBUG_FS
-	struct dentry *i40e_dbg_pf;
+	struct debugfs_node *i40e_dbg_pf;
 #endif /* CONFIG_DEBUG_FS */
 	bool cur_promisc;
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index 6cd9da662ae1..c25b1c68f873 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -9,7 +9,7 @@
 #include "i40e.h"
 #include "i40e_virtchnl_pf.h"
 
-static struct dentry *i40e_dbg_root;
+static struct debugfs_node *i40e_dbg_root;
 
 enum ring_type {
 	RING_TYPE_RX,
diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 71e05d30f0fd..0a1250fbeaa4 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -570,8 +570,8 @@ struct ice_pf {
 	struct ice_vsi_stats **vsi_stats;
 	struct ice_sw *first_sw;	/* first switch created by firmware */
 	u16 eswitch_mode;		/* current mode of eswitch */
-	struct dentry *ice_debugfs_pf;
-	struct dentry *ice_debugfs_pf_fwlog;
+	struct debugfs_node *ice_debugfs_pf;
+	struct debugfs_node *ice_debugfs_pf_fwlog;
 	/* keep track of all the dentrys for FW log modules */
 	struct dentry **ice_debugfs_pf_fwlog_modules;
 	struct ice_vfs vfs;
diff --git a/drivers/net/ethernet/intel/ice/ice_debugfs.c b/drivers/net/ethernet/intel/ice/ice_debugfs.c
index 9fc0fd95a13d..86b3494737c6 100644
--- a/drivers/net/ethernet/intel/ice/ice_debugfs.c
+++ b/drivers/net/ethernet/intel/ice/ice_debugfs.c
@@ -7,7 +7,7 @@
 #include <linux/vmalloc.h>
 #include "ice.h"
 
-static struct dentry *ice_debugfs_root;
+static struct debugfs_node *ice_debugfs_root;
 
 /* create a define that has an extra module that doesn't really exist. this
  * is so we can add a module 'all' to easily enable/disable all the modules
@@ -584,7 +584,7 @@ static const struct file_operations ice_debugfs_data_fops = {
 void ice_debugfs_fwlog_init(struct ice_pf *pf)
 {
 	const char *name = pci_name(pf->pdev);
-	struct dentry *fw_modules_dir;
+	struct debugfs_node *fw_modules_dir;
 	struct dentry **fw_modules;
 	int i;
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index e6a380d4929b..d638f528d40b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -804,7 +804,7 @@ struct ixgbe_adapter {
 	struct hwmon_buff *ixgbe_hwmon_buff;
 #endif /* CONFIG_IXGBE_HWMON */
 #ifdef CONFIG_DEBUG_FS
-	struct dentry *ixgbe_dbg_adapter;
+	struct debugfs_node *ixgbe_dbg_adapter;
 #endif /*CONFIG_DEBUG_FS*/
 
 	u8 default_up;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_debugfs.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_debugfs.c
index 5b1cf49df3d3..c2cdb1c6760f 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_debugfs.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_debugfs.c
@@ -6,7 +6,7 @@
 
 #include "ixgbe.h"
 
-static struct dentry *ixgbe_dbg_root;
+static struct debugfs_node *ixgbe_dbg_root;
 
 static char ixgbe_dbg_reg_ops_buf[256] = "";
 
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
index 44fe9b68d1c2..3640e27b6b12 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
@@ -1097,7 +1097,7 @@ struct mvpp2 {
 	struct workqueue_struct *stats_queue;
 
 	/* Debugfs root entry */
-	struct dentry *dbgfs_dir;
+	struct debugfs_node *dbgfs_dir;
 
 	/* Debugfs entries private data */
 	struct mvpp2_dbgfs_entries *dbgfs_entries;
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
index 0f9bc4f8ec3b..ca227eb28628 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
@@ -444,12 +444,12 @@ static int mvpp2_dbgfs_prs_valid_show(struct seq_file *s, void *unused)
 
 DEFINE_SHOW_ATTRIBUTE(mvpp2_dbgfs_prs_valid);
 
-static int mvpp2_dbgfs_flow_port_init(struct dentry *parent,
+static int mvpp2_dbgfs_flow_port_init(struct debugfs_node *parent,
 				      struct mvpp2_port *port,
 				      struct mvpp2_dbgfs_flow_entry *entry)
 {
 	struct mvpp2_dbgfs_port_flow_entry *port_entry;
-	struct dentry *port_dir;
+	struct debugfs_node *port_dir;
 
 	port_dir = debugfs_create_dir(port->dev->name, parent);
 
@@ -467,11 +467,11 @@ static int mvpp2_dbgfs_flow_port_init(struct dentry *parent,
 	return 0;
 }
 
-static int mvpp2_dbgfs_flow_entry_init(struct dentry *parent,
+static int mvpp2_dbgfs_flow_entry_init(struct debugfs_node *parent,
 				       struct mvpp2 *priv, int flow)
 {
 	struct mvpp2_dbgfs_flow_entry *entry;
-	struct dentry *flow_entry_dir;
+	struct debugfs_node *flow_entry_dir;
 	char flow_entry_name[10];
 	int i, ret;
 
@@ -504,9 +504,10 @@ static int mvpp2_dbgfs_flow_entry_init(struct dentry *parent,
 	return 0;
 }
 
-static int mvpp2_dbgfs_flow_init(struct dentry *parent, struct mvpp2 *priv)
+static int mvpp2_dbgfs_flow_init(struct debugfs_node *parent,
+				 struct mvpp2 *priv)
 {
-	struct dentry *flow_dir;
+	struct debugfs_node *flow_dir;
 	int i, ret;
 
 	flow_dir = debugfs_create_dir("flows", parent);
@@ -520,11 +521,11 @@ static int mvpp2_dbgfs_flow_init(struct dentry *parent, struct mvpp2 *priv)
 	return 0;
 }
 
-static int mvpp2_dbgfs_prs_entry_init(struct dentry *parent,
+static int mvpp2_dbgfs_prs_entry_init(struct debugfs_node *parent,
 				      struct mvpp2 *priv, int tid)
 {
 	struct mvpp2_dbgfs_prs_entry *entry;
-	struct dentry *prs_entry_dir;
+	struct debugfs_node *prs_entry_dir;
 	char prs_entry_name[10];
 
 	if (tid >= MVPP2_PRS_TCAM_SRAM_SIZE)
@@ -564,9 +565,10 @@ static int mvpp2_dbgfs_prs_entry_init(struct dentry *parent,
 	return 0;
 }
 
-static int mvpp2_dbgfs_prs_init(struct dentry *parent, struct mvpp2 *priv)
+static int mvpp2_dbgfs_prs_init(struct debugfs_node *parent,
+				struct mvpp2 *priv)
 {
-	struct dentry *prs_dir;
+	struct debugfs_node *prs_dir;
 	int i, ret;
 
 	prs_dir = debugfs_create_dir("parser", parent);
@@ -580,11 +582,11 @@ static int mvpp2_dbgfs_prs_init(struct dentry *parent, struct mvpp2 *priv)
 	return 0;
 }
 
-static int mvpp2_dbgfs_c2_entry_init(struct dentry *parent,
+static int mvpp2_dbgfs_c2_entry_init(struct debugfs_node *parent,
 				     struct mvpp2 *priv, int id)
 {
 	struct mvpp2_dbgfs_c2_entry *entry;
-	struct dentry *c2_entry_dir;
+	struct debugfs_node *c2_entry_dir;
 	char c2_entry_name[10];
 
 	if (id >= MVPP22_CLS_C2_N_ENTRIES)
@@ -611,11 +613,11 @@ static int mvpp2_dbgfs_c2_entry_init(struct dentry *parent,
 	return 0;
 }
 
-static int mvpp2_dbgfs_flow_tbl_entry_init(struct dentry *parent,
+static int mvpp2_dbgfs_flow_tbl_entry_init(struct debugfs_node *parent,
 					   struct mvpp2 *priv, int id)
 {
 	struct mvpp2_dbgfs_flow_tbl_entry *entry;
-	struct dentry *flow_tbl_entry_dir;
+	struct debugfs_node *flow_tbl_entry_dir;
 	char flow_tbl_entry_name[10];
 
 	if (id >= MVPP2_CLS_FLOWS_TBL_SIZE)
@@ -636,9 +638,10 @@ static int mvpp2_dbgfs_flow_tbl_entry_init(struct dentry *parent,
 	return 0;
 }
 
-static int mvpp2_dbgfs_cls_init(struct dentry *parent, struct mvpp2 *priv)
+static int mvpp2_dbgfs_cls_init(struct debugfs_node *parent,
+				struct mvpp2 *priv)
 {
-	struct dentry *cls_dir, *c2_dir, *flow_tbl_dir;
+	struct debugfs_node *cls_dir, *c2_dir, *flow_tbl_dir;
 	int i, ret;
 
 	cls_dir = debugfs_create_dir("classifier", parent);
@@ -662,10 +665,10 @@ static int mvpp2_dbgfs_cls_init(struct dentry *parent, struct mvpp2 *priv)
 	return 0;
 }
 
-static int mvpp2_dbgfs_port_init(struct dentry *parent,
+static int mvpp2_dbgfs_port_init(struct debugfs_node *parent,
 				 struct mvpp2_port *port)
 {
-	struct dentry *port_dir;
+	struct debugfs_node *port_dir;
 
 	port_dir = debugfs_create_dir(port->dev->name, parent);
 
@@ -681,7 +684,7 @@ static int mvpp2_dbgfs_port_init(struct dentry *parent,
 	return 0;
 }
 
-static struct dentry *mvpp2_root;
+static struct debugfs_node *mvpp2_root;
 
 void mvpp2_dbgfs_exit(void)
 {
@@ -697,7 +700,7 @@ void mvpp2_dbgfs_cleanup(struct mvpp2 *priv)
 
 void mvpp2_dbgfs_init(struct mvpp2 *priv, const char *name)
 {
-	struct dentry *mvpp2_dir;
+	struct debugfs_node *mvpp2_dir;
 	int ret, i;
 
 	if (!mvpp2_root)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index a383b5ef5b2d..53f988c682c9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -59,18 +59,18 @@ struct cpt_ctx {
 };
 
 struct rvu_debugfs {
-	struct dentry *root;
-	struct dentry *cgx_root;
-	struct dentry *cgx;
-	struct dentry *lmac;
-	struct dentry *npa;
-	struct dentry *nix;
-	struct dentry *npc;
-	struct dentry *cpt;
-	struct dentry *mcs_root;
-	struct dentry *mcs;
-	struct dentry *mcs_rx;
-	struct dentry *mcs_tx;
+	struct debugfs_node *root;
+	struct debugfs_node *cgx_root;
+	struct debugfs_node *cgx;
+	struct debugfs_node *lmac;
+	struct debugfs_node *npa;
+	struct debugfs_node *nix;
+	struct debugfs_node *npc;
+	struct debugfs_node *cpt;
+	struct debugfs_node *mcs_root;
+	struct debugfs_node *mcs;
+	struct debugfs_node *mcs_rx;
+	struct debugfs_node *mcs_tx;
 	struct dump_ctx npa_aura_ctx;
 	struct dump_ctx npa_pool_ctx;
 	struct dump_ctx nix_cq_ctx;
diff --git a/drivers/net/ethernet/marvell/skge.c b/drivers/net/ethernet/marvell/skge.c
index a1bada9eaaf6..b6e52a4e02ec 100644
--- a/drivers/net/ethernet/marvell/skge.c
+++ b/drivers/net/ethernet/marvell/skge.c
@@ -3687,7 +3687,7 @@ static int skge_reset(struct skge_hw *hw)
 
 #ifdef CONFIG_SKGE_DEBUG
 
-static struct dentry *skge_debug;
+static struct debugfs_node *skge_debug;
 
 static int skge_debug_show(struct seq_file *seq, void *v)
 {
diff --git a/drivers/net/ethernet/marvell/skge.h b/drivers/net/ethernet/marvell/skge.h
index f72217348eb4..90fc7383b863 100644
--- a/drivers/net/ethernet/marvell/skge.h
+++ b/drivers/net/ethernet/marvell/skge.h
@@ -2467,7 +2467,7 @@ struct skge_port {
 	dma_addr_t	     dma;
 	unsigned long	     mem_size;
 #ifdef CONFIG_SKGE_DEBUG
-	struct dentry	     *debugfs;
+	struct debugfs_node *debugfs;
 #endif
 };
 
diff --git a/drivers/net/ethernet/marvell/sky2.c b/drivers/net/ethernet/marvell/sky2.c
index d7121c836508..f0f61fde8a04 100644
--- a/drivers/net/ethernet/marvell/sky2.c
+++ b/drivers/net/ethernet/marvell/sky2.c
@@ -4381,7 +4381,7 @@ static const struct ethtool_ops sky2_ethtool_ops = {
 
 #ifdef CONFIG_SKY2_DEBUG
 
-static struct dentry *sky2_debug;
+static struct debugfs_node *sky2_debug;
 
 static int sky2_debug_show(struct seq_file *seq, void *v)
 {
@@ -4523,7 +4523,7 @@ static struct notifier_block sky2_notifier = {
 
 static __init void sky2_debug_init(void)
 {
-	struct dentry *ent;
+	struct debugfs_node *ent;
 
 	ent = debugfs_create_dir("sky2", NULL);
 	if (IS_ERR(ent))
diff --git a/drivers/net/ethernet/marvell/sky2.h b/drivers/net/ethernet/marvell/sky2.h
index 8d0bacf4e49c..6d326ea53b19 100644
--- a/drivers/net/ethernet/marvell/sky2.h
+++ b/drivers/net/ethernet/marvell/sky2.h
@@ -2266,7 +2266,7 @@ struct sky2_port {
 	enum flow_control    flow_status;
 
 #ifdef CONFIG_SKY2_DEBUG
-	struct dentry	     *debugfs;
+	struct debugfs_node *debugfs;
 #endif
 };
 
diff --git a/drivers/net/ethernet/mediatek/mtk_ppe_debugfs.c b/drivers/net/ethernet/mediatek/mtk_ppe_debugfs.c
index 570ebf91f693..23abc7cf8ea1 100644
--- a/drivers/net/ethernet/mediatek/mtk_ppe_debugfs.c
+++ b/drivers/net/ethernet/mediatek/mtk_ppe_debugfs.c
@@ -183,7 +183,7 @@ DEFINE_SHOW_ATTRIBUTE(mtk_ppe_debugfs_foe_bind);
 
 int mtk_ppe_debugfs_init(struct mtk_ppe *ppe, int index)
 {
-	struct dentry *root;
+	struct debugfs_node *root;
 
 	snprintf(ppe->dirname, sizeof(ppe->dirname), "ppe%d", index);
 
diff --git a/drivers/net/ethernet/mediatek/mtk_wed.h b/drivers/net/ethernet/mediatek/mtk_wed.h
index c1f0479d7a71..f01523bf4cbb 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed.h
+++ b/drivers/net/ethernet/mediatek/mtk_wed.h
@@ -40,7 +40,7 @@ struct mtk_wed_hw {
 	void __iomem *wdma;
 	phys_addr_t wdma_phy;
 	struct regmap *mirror;
-	struct dentry *debugfs_dir;
+	struct debugfs_node *debugfs_dir;
 	struct mtk_wed_device *wed_dev;
 	struct mtk_wed_wo *wed_wo;
 	struct mtk_wed_amsdu *wed_amsdu;
diff --git a/drivers/net/ethernet/mediatek/mtk_wed_debugfs.c b/drivers/net/ethernet/mediatek/mtk_wed_debugfs.c
index 781c691473e1..940b93833c7b 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed_debugfs.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed_debugfs.c
@@ -613,7 +613,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_regval, mtk_wed_reg_get, mtk_wed_reg_set,
 
 void mtk_wed_hw_add_debugfs(struct mtk_wed_hw *hw)
 {
-	struct dentry *dir;
+	struct debugfs_node *dir;
 
 	snprintf(hw->dirname, sizeof(hw->dirname), "wed%d", hw->index);
 	dir = debugfs_create_dir(hw->dirname, NULL);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/debugfs.c b/drivers/net/ethernet/mellanox/mlx5/core/debugfs.c
index 36806e813c33..92d36a7f03f8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/debugfs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/debugfs.c
@@ -85,7 +85,7 @@ static char *cq_fields[] = {
 	[CQ_LOG_PG_SZ]	= "log_page_size",
 };
 
-struct dentry *mlx5_debugfs_root;
+struct debugfs_node *mlx5_debugfs_root;
 EXPORT_SYMBOL(mlx5_debugfs_root);
 
 void mlx5_register_debugfs(void)
@@ -98,7 +98,7 @@ void mlx5_unregister_debugfs(void)
 	debugfs_remove(mlx5_debugfs_root);
 }
 
-struct dentry *mlx5_debugfs_get_dev_root(struct mlx5_core_dev *dev)
+struct debugfs_node *mlx5_debugfs_get_dev_root(struct mlx5_core_dev *dev)
 {
 	return dev->priv.dbg.dbg_root;
 }
@@ -279,7 +279,7 @@ void mlx5_cq_debugfs_cleanup(struct mlx5_core_dev *dev)
 
 void mlx5_pages_debugfs_init(struct mlx5_core_dev *dev)
 {
-	struct dentry *pages;
+	struct debugfs_node *pages;
 
 	dev->priv.dbg.pages_debugfs = debugfs_create_dir("pages", dev->priv.dbg.dbg_root);
 	pages = dev->priv.dbg.pages_debugfs;
@@ -502,7 +502,8 @@ static const struct file_operations fops = {
 };
 
 static int add_res_tree(struct mlx5_core_dev *dev, enum dbg_rsc_type type,
-			struct dentry *root, struct mlx5_rsc_debug **dbg,
+			struct debugfs_node *root,
+			struct mlx5_rsc_debug **dbg,
 			int rsn, char **field, int nfile, void *data)
 {
 	struct mlx5_rsc_debug *d;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 979fc56205e1..8c39c918eb4c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -936,7 +936,7 @@ struct mlx5e_priv {
 	struct mlx5e_scratchpad    scratchpad;
 	struct mlx5e_htb          *htb;
 	struct mlx5e_mqprio_rl    *mqprio_rl;
-	struct dentry             *dfs_root;
+	struct debugfs_node *dfs_root;
 	struct mlx5_devcom_comp_dev *devcom;
 };
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
index a065e8fafb1d..a7f2f8b057bf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
@@ -55,7 +55,7 @@ struct mlx5_tc_ct_debugfs {
 		atomic_t rx_dropped;
 	} stats;
 
-	struct dentry *root;
+	struct debugfs_node *root;
 };
 
 struct mlx5_tc_ct_priv {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
index e3e57c849436..8a3ac95e2a04 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
@@ -178,7 +178,7 @@ void mlx5e_ktls_cleanup_rx(struct mlx5e_priv *priv)
 }
 
 static void mlx5e_tls_debugfs_init(struct mlx5e_tls *tls,
-				   struct dentry *dfs_root)
+				   struct debugfs_node *dfs_root)
 {
 	if (IS_ERR_OR_NULL(dfs_root))
 		return;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c
index 3db31cc10719..0fac3d924c69 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c
@@ -895,7 +895,7 @@ bool mlx5e_ktls_handle_tx_skb(struct net_device *netdev, struct mlx5e_txqsq *sq,
 }
 
 static void mlx5e_tls_tx_debugfs_init(struct mlx5e_tls *tls,
-				      struct dentry *dfs_root)
+				      struct debugfs_node *dfs_root)
 {
 	if (IS_ERR_OR_NULL(dfs_root))
 		return;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
index 05058710d2c7..a8046c011ea2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
@@ -68,7 +68,7 @@ struct mlx5e_flow_steering {
 	struct mlx5e_fs_udp            *udp;
 	struct mlx5e_fs_any            *any;
 	struct mlx5e_ptp_fs            *ptp_fs;
-	struct dentry                  *dfs_root;
+	struct debugfs_node *dfs_root;
 };
 
 static int mlx5e_add_l2_flow_rule(struct mlx5e_flow_steering *fs,
@@ -106,7 +106,7 @@ static inline int mlx5e_hash_l2(const u8 *addr)
 	return addr[5];
 }
 
-struct dentry *mlx5e_fs_get_debugfs_root(struct mlx5e_flow_steering *fs)
+struct debugfs_node *mlx5e_fs_get_debugfs_root(struct mlx5e_flow_steering *fs)
 {
 	return fs->dfs_root;
 }
@@ -1429,7 +1429,7 @@ static void mlx5e_fs_ethtool_free(struct mlx5e_flow_steering *fs) { }
 #endif
 
 static void mlx5e_fs_debugfs_init(struct mlx5e_flow_steering *fs,
-				  struct dentry *dfs_root)
+				  struct debugfs_node *dfs_root)
 {
 	if (IS_ERR_OR_NULL(dfs_root))
 		return;
@@ -1440,7 +1440,7 @@ static void mlx5e_fs_debugfs_init(struct mlx5e_flow_steering *fs,
 struct mlx5e_flow_steering *mlx5e_fs_init(const struct mlx5e_profile *profile,
 					  struct mlx5_core_dev *mdev,
 					  bool state_destroy,
-					  struct dentry *dfs_root)
+					  struct debugfs_node *dfs_root)
 {
 	struct mlx5e_flow_steering *fs;
 	int err;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 9ba99609999f..615f912b143d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -96,7 +96,7 @@ struct mlx5e_tc_table {
 
 	struct mlx5_tc_ct_priv         *ct;
 	struct mapping_ctx             *mapping;
-	struct dentry                  *dfs_root;
+	struct debugfs_node *dfs_root;
 
 	/* tc action stats */
 	struct mlx5e_tc_act_stats_handle *action_stats_handle;
@@ -1075,7 +1075,7 @@ static int debugfs_hairpin_table_dump_show(struct seq_file *file, void *priv)
 DEFINE_SHOW_ATTRIBUTE(debugfs_hairpin_table_dump);
 
 static void mlx5e_tc_debugfs_init(struct mlx5e_tc_table *tc,
-				  struct dentry *dfs_root)
+				  struct debugfs_node *dfs_root)
 {
 	if (IS_ERR_OR_NULL(dfs_root))
 		return;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.h b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.h
index d6f539161993..b092a94f68b5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.h
@@ -11,6 +11,7 @@
 #include "eswitch.h"
 
 struct dentry;
+#define debugfs_node dentry
 struct mlx5_flow_table;
 struct mlx5_flow_group;
 
@@ -18,7 +19,7 @@ struct mlx5_esw_bridge_offloads {
 	struct mlx5_eswitch *esw;
 	struct list_head bridges;
 	struct xarray ports;
-	struct dentry *debugfs_root;
+	struct debugfs_node *debugfs_root;
 
 	struct notifier_block netdev_nb;
 	struct notifier_block nb_blk;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge_priv.h b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge_priv.h
index 7c251af566c6..814bcfccea51 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge_priv.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge_priv.h
@@ -200,7 +200,7 @@ struct mlx5_esw_bridge {
 	int refcnt;
 	struct list_head list;
 	struct mlx5_esw_bridge_offloads *br_offloads;
-	struct dentry *debugfs_dir;
+	struct debugfs_node *debugfs_dir;
 
 	struct list_head fdb_list;
 	struct rhashtable fdb_ht;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 8573d36785f4..adf2870db071 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -330,6 +330,7 @@ enum {
 };
 
 struct dentry;
+#define debugfs_node dentry
 struct mlx5_qos_domain;
 
 struct mlx5_eswitch {
@@ -340,7 +341,7 @@ struct mlx5_eswitch {
 	struct hlist_head       mc_table[MLX5_L2_ADDR_HASH_SIZE];
 	struct esw_mc_addr mc_promisc;
 	/* end of legacy */
-	struct dentry *debugfs_root;
+	struct debugfs_node *debugfs_root;
 	struct workqueue_struct *work_queue;
 	struct xarray vports;
 	u32 flags;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/debugfs.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/debugfs.c
index 62b6faa4276a..494851196bd6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/debugfs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/debugfs.c
@@ -160,7 +160,7 @@ DEFINE_SHOW_ATTRIBUTE(members);
 
 void mlx5_ldev_add_debugfs(struct mlx5_core_dev *dev)
 {
-	struct dentry *dbg;
+	struct debugfs_node *dbg;
 
 	dbg = debugfs_create_dir("lag", mlx5_debugfs_get_dev_root(dev));
 	dev->priv.dbg.lag_debugfs = dbg;
@@ -173,7 +173,7 @@ void mlx5_ldev_add_debugfs(struct mlx5_core_dev *dev)
 	debugfs_create_file("members", 0444, dbg, dev, &members_fops);
 }
 
-void mlx5_ldev_remove_debugfs(struct dentry *dbg)
+void mlx5_ldev_remove_debugfs(struct debugfs_node *dbg)
 {
 	debugfs_remove_recursive(dbg);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
index 01cf72366947..bbc0cc0faad3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
@@ -107,7 +107,7 @@ void mlx5_infer_tx_enabled(struct lag_tracker *tracker, struct mlx5_lag *ldev,
 			   u8 *ports, int *num_enabled);
 
 void mlx5_ldev_add_debugfs(struct mlx5_core_dev *dev);
-void mlx5_ldev_remove_debugfs(struct dentry *dbg);
+void mlx5_ldev_remove_debugfs(struct debugfs_node *dbg);
 void mlx5_disable_lag(struct mlx5_lag *ldev);
 void mlx5_lag_remove_devices(struct mlx5_lag *ldev);
 int mlx5_deactivate_lag(struct mlx5_lag *ldev);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index eeb0b7ea05f1..d5053c875b2b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
@@ -17,7 +17,7 @@ struct mlx5_sd {
 	u32 group_id;
 	u8 host_buses;
 	struct mlx5_devcom_comp_dev *devcom;
-	struct dentry *dfs;
+	struct debugfs_node *dfs;
 	bool primary;
 	union {
 		struct { /* primary */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.h
index 38c3647444ad..6f56637ff9de 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.h
@@ -24,8 +24,8 @@ struct mlx5hws_context_common_res {
 };
 
 struct mlx5hws_context_debug_info {
-	struct dentry *steering_debugfs;
-	struct dentry *fdb_debugfs;
+	struct debugfs_node *steering_debugfs;
+	struct debugfs_node *fdb_debugfs;
 };
 
 struct mlx5hws_context_vports {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_dbg.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_dbg.h
index 57c6b363b870..e27862b9795a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_dbg.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_dbg.h
@@ -21,8 +21,8 @@ struct mlx5dr_dbg_dump_data {
 
 struct mlx5dr_dbg_dump_info {
 	struct mutex dbg_mutex; /* protect dbg lists */
-	struct dentry *steering_debugfs;
-	struct dentry *fdb_debugfs;
+	struct debugfs_node *steering_debugfs;
+	struct debugfs_node *fdb_debugfs;
 	struct mlx5dr_dbg_dump_data *dump_data;
 	atomic_t state;
 };
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index 14751f16e125..8f4f033eca31 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -23,7 +23,7 @@ struct fbnic_napi_vector;
 struct fbnic_dev {
 	struct device *dev;
 	struct net_device *netdev;
-	struct dentry *dbg_fbd;
+	struct debugfs_node *dbg_fbd;
 	struct device *hwmon;
 
 	u32 __iomem *uc_addr0;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c b/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c
index 59951b5abdb7..7037bcb2942e 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c
@@ -8,7 +8,7 @@
 
 #include "fbnic.h"
 
-static struct dentry *fbnic_dbg_root;
+static struct debugfs_node *fbnic_dbg_root;
 
 static int fbnic_dbg_pcie_stats_show(struct seq_file *s, void *v)
 {
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
index 1efa584e7107..e89908e07bef 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
@@ -335,7 +335,7 @@ struct lan966x {
 	struct vcap_control *vcap_ctrl;
 
 	/* debugfs */
-	struct dentry *debugfs_root;
+	struct debugfs_node *debugfs_root;
 };
 
 struct lan966x_port_config {
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_vcap_impl.c b/drivers/net/ethernet/microchip/lan966x/lan966x_vcap_impl.c
index a1471e38d118..d80892576b84 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_vcap_impl.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_vcap_impl.c
@@ -710,7 +710,7 @@ int lan966x_vcap_init(struct lan966x *lan966x)
 	struct lan966x_vcap_inst *cfg;
 	struct vcap_control *ctrl;
 	struct vcap_admin *admin;
-	struct dentry *dir;
+	struct debugfs_node *dir;
 
 	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
 	if (!ctrl)
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index fe7d8bcc0cd9..38de46a09424 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -432,7 +432,7 @@ struct sparx5 {
 	u8 pgid_map[PGID_TABLE_SIZE];
 	struct list_head mall_entries;
 	/* Common root for debugfs */
-	struct dentry *debugfs_root;
+	struct debugfs_node *debugfs_root;
 	const struct sparx5_match_data *data;
 };
 
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c b/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c
index 25066ddb8d4d..c6b50931917a 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c
@@ -2035,7 +2035,7 @@ int sparx5_vcap_init(struct sparx5 *sparx5)
 	const struct sparx5_vcap_inst *cfg;
 	struct vcap_control *ctrl;
 	struct vcap_admin *admin;
-	struct dentry *dir;
+	struct debugfs_node *dir;
 	int err = 0, idx;
 
 	/* Create a VCAP control instance that owns the platform specific VCAP
diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.c b/drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.c
index 59bfbda29bb3..ff547f575e73 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.c
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.c
@@ -383,7 +383,7 @@ static int vcap_port_debugfs_show(struct seq_file *m, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(vcap_port_debugfs);
 
-void vcap_port_debugfs(struct device *dev, struct dentry *parent,
+void vcap_port_debugfs(struct device *dev, struct debugfs_node *parent,
 		       struct vcap_control *vctrl,
 		       struct net_device *ndev)
 {
@@ -434,12 +434,13 @@ static int vcap_raw_debugfs_show(struct seq_file *m, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(vcap_raw_debugfs);
 
-struct dentry *vcap_debugfs(struct device *dev, struct dentry *parent,
-			    struct vcap_control *vctrl)
+struct debugfs_node *vcap_debugfs(struct device *dev,
+				  struct debugfs_node *parent,
+				  struct vcap_control *vctrl)
 {
 	struct vcap_admin_debugfs_info *info;
 	struct vcap_admin *admin;
-	struct dentry *dir;
+	struct debugfs_node *dir;
 	char name[50];
 
 	dir = debugfs_create_dir("vcaps", parent);
diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.h b/drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.h
index 9f2c59b5f6f5..5aa9b08d95f6 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.h
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.h
@@ -14,24 +14,26 @@
 
 #if defined(CONFIG_DEBUG_FS)
 
-void vcap_port_debugfs(struct device *dev, struct dentry *parent,
+void vcap_port_debugfs(struct device *dev, struct debugfs_node *parent,
 		       struct vcap_control *vctrl,
 		       struct net_device *ndev);
 
 /* Create a debugFS entry for a vcap instance */
-struct dentry *vcap_debugfs(struct device *dev, struct dentry *parent,
-			    struct vcap_control *vctrl);
+struct debugfs_node *vcap_debugfs(struct device *dev,
+				  struct debugfs_node *parent,
+				  struct vcap_control *vctrl);
 
 #else
 
-static inline void vcap_port_debugfs(struct device *dev, struct dentry *parent,
+static inline void vcap_port_debugfs(struct device *dev,
+				     struct debugfs_node *parent,
 				     struct vcap_control *vctrl,
 				     struct net_device *ndev)
 {
 }
 
-static inline struct dentry *vcap_debugfs(struct device *dev,
-					  struct dentry *parent,
+static inline struct debugfs_node *vcap_debugfs(struct device *dev,
+					  struct debugfs_node *parent,
 					  struct vcap_control *vctrl)
 {
 	return NULL;
diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index be95336ce089..ddb676c85f23 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -9,7 +9,7 @@
 
 #include <net/mana/mana.h>
 
-struct dentry *mana_debugfs_root;
+struct debugfs_node *mana_debugfs_root;
 
 static u32 mana_gd_r32(struct gdma_context *g, u64 offset)
 {
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_main.h b/drivers/net/ethernet/netronome/nfp/nfp_main.h
index 14a751bfe1fe..61cbd85bd992 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_main.h
+++ b/drivers/net/ethernet/netronome/nfp/nfp_main.h
@@ -17,6 +17,7 @@
 #include <net/devlink.h>
 
 struct dentry;
+#define debugfs_node dentry
 struct device;
 struct pci_dev;
 
@@ -128,7 +129,7 @@ struct nfp_pf {
 
 	struct device *hwmon_dev;
 
-	struct dentry *ddir;
+	struct debugfs_node *ddir;
 
 	unsigned int max_data_vnics;
 	unsigned int num_vnics;
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net.h b/drivers/net/ethernet/netronome/nfp/nfp_net.h
index 46764aeccb37..19e25380273e 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net.h
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net.h
@@ -714,7 +714,7 @@ struct nfp_net {
 		u16 tag;
 	} mbox_cmsg;
 
-	struct dentry *debugfs_dir;
+	struct debugfs_node *debugfs_dir;
 
 	struct list_head vnic_list;
 
@@ -1026,8 +1026,8 @@ int nfp_net_fs_del_hw(struct nfp_net *nn, struct nfp_fs_entry *entry);
 #ifdef CONFIG_NFP_DEBUG
 void nfp_net_debugfs_create(void);
 void nfp_net_debugfs_destroy(void);
-struct dentry *nfp_net_debugfs_device_add(struct pci_dev *pdev);
-void nfp_net_debugfs_vnic_add(struct nfp_net *nn, struct dentry *ddir);
+struct debugfs_node *nfp_net_debugfs_device_add(struct pci_dev *pdev);
+void nfp_net_debugfs_vnic_add(struct nfp_net *nn, struct debugfs_node *ddir);
 void nfp_net_debugfs_dir_clean(struct dentry **dir);
 #else
 static inline void nfp_net_debugfs_create(void)
@@ -1038,13 +1038,13 @@ static inline void nfp_net_debugfs_destroy(void)
 {
 }
 
-static inline struct dentry *nfp_net_debugfs_device_add(struct pci_dev *pdev)
+static inline struct debugfs_node *nfp_net_debugfs_device_add(struct pci_dev *pdev)
 {
 	return NULL;
 }
 
 static inline void
-nfp_net_debugfs_vnic_add(struct nfp_net *nn, struct dentry *ddir)
+nfp_net_debugfs_vnic_add(struct nfp_net *nn, struct debugfs_node *ddir)
 {
 }
 
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_debugfs.c b/drivers/net/ethernet/netronome/nfp/nfp_net_debugfs.c
index d8b735ccf899..fb7df43f30cf 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_debugfs.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_debugfs.c
@@ -7,7 +7,7 @@
 #include "nfp_net.h"
 #include "nfp_net_dp.h"
 
-static struct dentry *nfp_dir;
+static struct debugfs_node *nfp_dir;
 
 static int nfp_rx_q_show(struct seq_file *file, void *data)
 {
@@ -121,9 +121,9 @@ static int nfp_xdp_q_show(struct seq_file *file, void *data)
 }
 DEFINE_SHOW_ATTRIBUTE(nfp_xdp_q);
 
-void nfp_net_debugfs_vnic_add(struct nfp_net *nn, struct dentry *ddir)
+void nfp_net_debugfs_vnic_add(struct nfp_net *nn, struct debugfs_node *ddir)
 {
-	struct dentry *queues, *tx, *rx, *xdp;
+	struct debugfs_node *queues, *tx, *rx, *xdp;
 	char name[20];
 	int i;
 
@@ -158,7 +158,7 @@ void nfp_net_debugfs_vnic_add(struct nfp_net *nn, struct dentry *ddir)
 	}
 }
 
-struct dentry *nfp_net_debugfs_device_add(struct pci_dev *pdev)
+struct debugfs_node *nfp_net_debugfs_device_add(struct pci_dev *pdev)
 {
 	return debugfs_create_dir(pci_name(pdev), nfp_dir);
 }
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_netvf_main.c b/drivers/net/ethernet/netronome/nfp/nfp_netvf_main.c
index e19bb0150cb5..27ec14aacd62 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_netvf_main.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_netvf_main.c
@@ -32,7 +32,7 @@ struct nfp_net_vf {
 				      NFP_NET_MAX_TX_RINGS];
 	u8 __iomem *q_bar;
 
-	struct dentry *ddir;
+	struct debugfs_node *ddir;
 };
 
 static const char nfp_net_driver_name[] = "nfp_netvf";
diff --git a/drivers/net/ethernet/pensando/ionic/ionic.h b/drivers/net/ethernet/pensando/ionic/ionic.h
index 04f00ea94230..d41f0b7d7171 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic.h
@@ -43,7 +43,7 @@ struct ionic {
 	struct devlink_port dl_port;
 	struct ionic_dev idev;
 	struct mutex dev_cmd_lock;	/* lock for dev_cmd operations */
-	struct dentry *dentry;
+	struct debugfs_node *dentry;
 	struct ionic_dev_bar bars[IONIC_BARS_MAX];
 	unsigned int num_bars;
 	struct ionic_identity ident;
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_debugfs.c b/drivers/net/ethernet/pensando/ionic/ionic_debugfs.c
index c98b4e75e288..6259c9b67b2e 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_debugfs.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_debugfs.c
@@ -11,7 +11,7 @@
 
 #ifdef CONFIG_DEBUG_FS
 
-static struct dentry *ionic_dir;
+static struct debugfs_node *ionic_dir;
 
 void ionic_debugfs_create(void)
 {
@@ -112,9 +112,9 @@ static const struct debugfs_reg32 intr_ctrl_regs[] = {
 
 void ionic_debugfs_add_qcq(struct ionic_lif *lif, struct ionic_qcq *qcq)
 {
-	struct dentry *qcq_dentry, *q_dentry, *cq_dentry;
+	struct debugfs_node *qcq_dentry, *q_dentry, *cq_dentry;
 	struct ionic_dev *idev = &lif->ionic->idev;
-	struct dentry *intr_dentry, *stats_dentry;
+	struct debugfs_node *intr_dentry, *stats_dentry;
 	struct debugfs_regset32 *intr_ctrl_regset;
 	struct ionic_intr_info *intr = &qcq->intr;
 	struct debugfs_blob_wrapper *desc_blob;
@@ -272,7 +272,7 @@ DEFINE_SHOW_ATTRIBUTE(lif_filters);
 
 void ionic_debugfs_add_lif(struct ionic_lif *lif)
 {
-	struct dentry *lif_dentry;
+	struct debugfs_node *lif_dentry;
 
 	lif_dentry = debugfs_create_dir(lif->name, lif->ionic->dentry);
 	if (IS_ERR_OR_NULL(lif_dentry))
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.h b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
index e01756fb7fdd..b65e5da1d7b9 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
@@ -89,7 +89,7 @@ struct ionic_qcq {
 	struct napi_struct napi;
 	struct ionic_intr_info intr;
 	struct work_struct doorbell_napi_work;
-	struct dentry *dentry;
+	struct debugfs_node *dentry;
 };
 
 #define q_to_qcq(q)		container_of(q, struct ionic_qcq, q)
@@ -241,7 +241,7 @@ struct ionic_lif {
 
 	struct ionic_phc *phc;
 
-	struct dentry *dentry;
+	struct debugfs_node *dentry;
 	struct bpf_prog *xdp_prog;
 };
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index f05cae103d83..9d076f8cf902 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -347,7 +347,7 @@ struct stmmac_priv {
 	char int_name_tx_irq[MTL_MAX_TX_QUEUES][IFNAMSIZ + 18];
 
 #ifdef CONFIG_DEBUG_FS
-	struct dentry *dbgfs_dir;
+	struct debugfs_node *dbgfs_dir;
 #endif
 
 	unsigned long state;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b34ebb916b89..8cd7cbcfad90 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6276,7 +6276,7 @@ static int stmmac_set_mac_address(struct net_device *ndev, void *addr)
 }
 
 #ifdef CONFIG_DEBUG_FS
-static struct dentry *stmmac_fs_dir;
+static struct debugfs_node *stmmac_fs_dir;
 
 static void sysfs_display_ring(void *head, int size, int extend_desc,
 			       struct seq_file *seq, dma_addr_t dma_phy_addr)
diff --git a/drivers/net/ethernet/vertexcom/mse102x.c b/drivers/net/ethernet/vertexcom/mse102x.c
index 89dc4c401a8d..a1a113a856e9 100644
--- a/drivers/net/ethernet/vertexcom/mse102x.c
+++ b/drivers/net/ethernet/vertexcom/mse102x.c
@@ -85,7 +85,7 @@ struct mse102x_net_spi {
 	struct spi_transfer	spi_xfer;
 
 #ifdef CONFIG_DEBUG_FS
-	struct dentry		*device_root;
+	struct debugfs_node *device_root;
 #endif
 };
 
diff --git a/drivers/net/fjes/fjes.h b/drivers/net/fjes/fjes.h
index 1e0df1f74c00..f9912a61357c 100644
--- a/drivers/net/fjes/fjes.h
+++ b/drivers/net/fjes/fjes.h
@@ -53,7 +53,7 @@ struct fjes_adapter {
 	struct fjes_hw hw;
 
 #ifdef CONFIG_DEBUG_FS
-	struct dentry *dbg_adapter;
+	struct debugfs_node *dbg_adapter;
 #endif
 };
 
diff --git a/drivers/net/fjes/fjes_debugfs.c b/drivers/net/fjes/fjes_debugfs.c
index 2c2095e7cf1e..ecbe45e9dded 100644
--- a/drivers/net/fjes/fjes_debugfs.c
+++ b/drivers/net/fjes/fjes_debugfs.c
@@ -14,7 +14,7 @@
 
 #include "fjes.h"
 
-static struct dentry *fjes_debug_root;
+static struct debugfs_node *fjes_debug_root;
 
 static const char * const ep_status_string[] = {
 	"unshared",
diff --git a/drivers/net/ieee802154/adf7242.c b/drivers/net/ieee802154/adf7242.c
index cc7ddc40020f..1c381236df54 100644
--- a/drivers/net/ieee802154/adf7242.c
+++ b/drivers/net/ieee802154/adf7242.c
@@ -273,7 +273,7 @@ struct adf7242_local {
 	struct mutex bmux; /* protect SPI messages */
 	struct spi_message stat_msg;
 	struct spi_transfer stat_xfer;
-	struct dentry *debugfs_root;
+	struct debugfs_node *debugfs_root;
 	struct delayed_work work;
 	struct workqueue_struct *wqueue;
 	unsigned long flags;
diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index 753215ebc67c..b4bd68edbe05 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -279,7 +279,7 @@ struct cas_control {
  * This structure stores all the data pertaining to the debug interface
  */
 struct ca8210_test {
-	struct dentry *ca8210_dfs_spi_int;
+	struct debugfs_node *ca8210_dfs_spi_int;
 	struct kfifo up_fifo;
 	wait_queue_head_t readq;
 };
diff --git a/drivers/net/netdevsim/bpf.c b/drivers/net/netdevsim/bpf.c
index 608953d4f98d..010f18e3f0ac 100644
--- a/drivers/net/netdevsim/bpf.c
+++ b/drivers/net/netdevsim/bpf.c
@@ -29,7 +29,7 @@
 struct nsim_bpf_bound_prog {
 	struct nsim_dev *nsim_dev;
 	struct bpf_prog *prog;
-	struct dentry *ddir;
+	struct debugfs_node *ddir;
 	const char *state;
 	bool is_loaded;
 	struct list_head l;
@@ -614,7 +614,7 @@ void nsim_bpf_dev_exit(struct nsim_dev *nsim_dev)
 
 int nsim_bpf_init(struct netdevsim *ns)
 {
-	struct dentry *ddir = ns->nsim_dev_port->ddir;
+	struct debugfs_node *ddir = ns->nsim_dev_port->ddir;
 	int err;
 
 	err = bpf_offload_dev_netdev_register(ns->nsim_dev->bpf_dev,
diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
index 3e0b61202f0c..db68eac3b0bf 100644
--- a/drivers/net/netdevsim/dev.c
+++ b/drivers/net/netdevsim/dev.c
@@ -54,7 +54,7 @@ static inline unsigned int nsim_dev_port_index_to_vf_index(unsigned int port_ind
 	return port_index - NSIM_DEV_VF_PORT_INDEX_BASE;
 }
 
-static struct dentry *nsim_dev_ddir;
+static struct debugfs_node *nsim_dev_ddir;
 
 unsigned int nsim_dev_get_vfs(struct nsim_dev *nsim_dev)
 {
@@ -1205,8 +1205,8 @@ static int nsim_leaf_tx_max_set(struct devlink_rate *devlink_rate, void *priv,
 }
 
 struct nsim_rate_node {
-	struct dentry *ddir;
-	struct dentry *rate_parent;
+	struct debugfs_node *ddir;
+	struct debugfs_node *rate_parent;
 	char *parent_name;
 	u16 tx_share;
 	u16 tx_max;
diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/ethtool.c
index 5c80fbee7913..0e886495b4c7 100644
--- a/drivers/net/netdevsim/ethtool.c
+++ b/drivers/net/netdevsim/ethtool.c
@@ -192,7 +192,7 @@ static void nsim_ethtool_ring_init(struct netdevsim *ns)
 
 void nsim_ethtool_init(struct netdevsim *ns)
 {
-	struct dentry *ethtool, *dir;
+	struct debugfs_node *ethtool, *dir;
 
 	ns->netdev->ethtool_ops = &nsim_ethtool_ops;
 
diff --git a/drivers/net/netdevsim/fib.c b/drivers/net/netdevsim/fib.c
index 16c382c42227..c8d93b9bead7 100644
--- a/drivers/net/netdevsim/fib.c
+++ b/drivers/net/netdevsim/fib.c
@@ -58,7 +58,7 @@ struct nsim_fib_data {
 	struct list_head fib_event_queue;
 	spinlock_t fib_event_queue_lock; /* Protects fib event queue list */
 	struct mutex nh_lock; /* Protects NH HT */
-	struct dentry *ddir;
+	struct debugfs_node *ddir;
 	bool fail_route_offload;
 	bool fail_res_nexthop_group_replace;
 	bool fail_nexthop_bucket_replace;
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index 96d54c08043d..a1b920eb6844 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -51,7 +51,7 @@ struct nsim_sa {
 
 struct nsim_ipsec {
 	struct nsim_sa sa[NSIM_IPSEC_MAX_SA_COUNT];
-	struct dentry *pfile;
+	struct debugfs_node *pfile;
 	u32 count;
 	u32 tx;
 	u32 ok;
@@ -139,8 +139,8 @@ struct netdevsim {
 	} udp_ports;
 
 	struct page *page;
-	struct dentry *pp_dfs;
-	struct dentry *qr_dfs;
+	struct debugfs_node *pp_dfs;
+	struct debugfs_node *qr_dfs;
 
 	struct nsim_ethtool ethtool;
 	struct netdevsim __rcu *peer;
@@ -218,7 +218,7 @@ enum nsim_resource_id {
 struct nsim_dev_health {
 	struct devlink_health_reporter *empty_reporter;
 	struct devlink_health_reporter *dummy_reporter;
-	struct dentry *ddir;
+	struct debugfs_node *ddir;
 	char *recovered_break_msg;
 	u32 binary_len;
 	bool fail_recover;
@@ -236,8 +236,8 @@ struct nsim_dev_hwstats_netdev {
 };
 
 struct nsim_dev_hwstats {
-	struct dentry *ddir;
-	struct dentry *l3_ddir;
+	struct debugfs_node *ddir;
+	struct debugfs_node *l3_ddir;
 
 	struct mutex hwsdev_list_lock; /* protects hwsdev list(s) */
 	struct list_head l3_list;
@@ -276,8 +276,8 @@ struct nsim_dev_port {
 	struct devlink_port devlink_port;
 	unsigned int port_index;
 	enum nsim_dev_port_type port_type;
-	struct dentry *ddir;
-	struct dentry *rate_parent;
+	struct debugfs_node *ddir;
+	struct debugfs_node *rate_parent;
 	char *parent_name;
 	struct netdevsim *ns;
 };
@@ -299,10 +299,10 @@ struct nsim_dev {
 	struct nsim_bus_dev *nsim_bus_dev;
 	struct nsim_fib_data *fib_data;
 	struct nsim_trap_data *trap_data;
-	struct dentry *ddir;
-	struct dentry *ports_ddir;
-	struct dentry *take_snapshot;
-	struct dentry *nodes_ddir;
+	struct debugfs_node *ddir;
+	struct debugfs_node *ports_ddir;
+	struct debugfs_node *take_snapshot;
+	struct debugfs_node *nodes_ddir;
 
 	struct nsim_vf_config *vfconfigs;
 
@@ -310,7 +310,7 @@ struct nsim_dev {
 	bool bpf_bind_accept;
 	bool bpf_bind_verifier_accept;
 	u32 bpf_bind_verifier_delay;
-	struct dentry *ddir_bpf_bound_progs;
+	struct debugfs_node *ddir_bpf_bound_progs;
 	u32 prog_id_gen;
 	struct list_head bpf_bound_progs;
 	struct list_head bpf_bound_maps;
diff --git a/drivers/net/netdevsim/psample.c b/drivers/net/netdevsim/psample.c
index f0c6477dd0ae..b5fad3c03627 100644
--- a/drivers/net/netdevsim/psample.c
+++ b/drivers/net/netdevsim/psample.c
@@ -22,7 +22,7 @@
 
 struct nsim_dev_psample {
 	struct delayed_work psample_dw;
-	struct dentry *ddir;
+	struct debugfs_node *ddir;
 	struct psample_group *group;
 	u32 rate;
 	u32 group_num;
diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 7dbcbf0a4ee2..04137587e1c8 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -294,7 +294,7 @@ struct sfp {
 #endif
 
 #if IS_ENABLED(CONFIG_DEBUG_FS)
-	struct dentry *debugfs_dir;
+	struct debugfs_node *debugfs_dir;
 #endif
 };
 
diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
index 446dca74f06a..d91932d184ef 100644
--- a/drivers/net/wireless/ath/ath10k/core.h
+++ b/drivers/net/wireless/ath/ath10k/core.h
@@ -674,7 +674,7 @@ struct ath10k_fw_crash_data {
 };
 
 struct ath10k_debug {
-	struct dentry *debugfs_phy;
+	struct debugfs_node *debugfs_phy;
 
 	struct ath10k_fw_stats fw_stats;
 	struct completion fw_stats_complete;
diff --git a/drivers/net/wireless/ath/ath10k/debug.h b/drivers/net/wireless/ath/ath10k/debug.h
index 0af787f49b33..24a55b5b2291 100644
--- a/drivers/net/wireless/ath/ath10k/debug.h
+++ b/drivers/net/wireless/ath/ath10k/debug.h
@@ -210,7 +210,8 @@ static inline int ath10k_debug_fw_stats_request(struct ath10k *ar)
 #endif /* CONFIG_ATH10K_DEBUGFS */
 #ifdef CONFIG_MAC80211_DEBUGFS
 void ath10k_sta_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-			    struct ieee80211_sta *sta, struct dentry *dir);
+			    struct ieee80211_sta *sta,
+			    struct debugfs_node *dir);
 void ath10k_sta_update_rx_duration(struct ath10k *ar,
 				   struct ath10k_fw_stats *stats);
 void ath10k_sta_update_rx_tid_stats(struct ath10k *ar, u8 *first_hdr,
diff --git a/drivers/net/wireless/ath/ath10k/debugfs_sta.c b/drivers/net/wireless/ath/ath10k/debugfs_sta.c
index 0f6de862c3a9..a36d6f566dd3 100644
--- a/drivers/net/wireless/ath/ath10k/debugfs_sta.c
+++ b/drivers/net/wireless/ath/ath10k/debugfs_sta.c
@@ -756,7 +756,8 @@ static const struct file_operations fops_tx_stats = {
 };
 
 void ath10k_sta_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-			    struct ieee80211_sta *sta, struct dentry *dir)
+			    struct ieee80211_sta *sta,
+			    struct debugfs_node *dir)
 {
 	struct ath10k *ar = hw->priv;
 
diff --git a/drivers/net/wireless/ath/ath10k/spectral.c b/drivers/net/wireless/ath/ath10k/spectral.c
index 2240994390ed..82e4a530a605 100644
--- a/drivers/net/wireless/ath/ath10k/spectral.c
+++ b/drivers/net/wireless/ath/ath10k/spectral.c
@@ -463,13 +463,13 @@ static const struct file_operations fops_spectral_bins = {
 	.llseek = default_llseek,
 };
 
-static struct dentry *create_buf_file_handler(const char *filename,
-					      struct dentry *parent,
+static struct debugfs_node *create_buf_file_handler(const char *filename,
+					      struct debugfs_node *parent,
 					      umode_t mode,
 					      struct rchan_buf *buf,
 					      int *is_global)
 {
-	struct dentry *buf_file;
+	struct debugfs_node *buf_file;
 
 	buf_file = debugfs_create_file(filename, mode, parent, buf,
 				       &relay_file_operations);
@@ -480,7 +480,7 @@ static struct dentry *create_buf_file_handler(const char *filename,
 	return buf_file;
 }
 
-static int remove_buf_file_handler(struct dentry *dentry)
+static int remove_buf_file_handler(struct debugfs_node *dentry)
 {
 	debugfs_remove(dentry);
 
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index a9dc7fe7765a..46fbe1b02456 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -591,7 +591,7 @@ enum ath11k_state {
 #define ATH11K_INVALID_RSSI_EMPTY -128
 
 struct ath11k_fw_stats {
-	struct dentry *debugfs_fwstats;
+	struct debugfs_node *debugfs_fwstats;
 	u32 pdev_id;
 	u32 stats_id;
 	struct list_head pdevs;
@@ -610,7 +610,7 @@ struct ath11k_dbg_htt_stats {
 #define MAX_MODULE_ID_BITMAP_WORDS	16
 
 struct ath11k_debug {
-	struct dentry *debugfs_pdev;
+	struct debugfs_node *debugfs_pdev;
 	struct ath11k_dbg_htt_stats htt_stats;
 	u32 extd_tx_stats;
 	u32 extd_rx_stats;
@@ -972,7 +972,7 @@ struct ath11k_base {
 	/* Current DFS Regulatory */
 	enum ath11k_dfs_region dfs_region;
 #ifdef CONFIG_ATH11K_DEBUGFS
-	struct dentry *debugfs_soc;
+	struct debugfs_node *debugfs_soc;
 #endif
 	struct ath11k_soc_dp_stats soc_stats;
 
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
index bf192529e3fe..8fac2a1d8d12 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs.c
@@ -998,7 +998,7 @@ void ath11k_debugfs_pdev_destroy(struct ath11k_base *ab)
 
 int ath11k_debugfs_soc_create(struct ath11k_base *ab)
 {
-	struct dentry *root;
+	struct debugfs_node *root;
 	bool dput_needed;
 	char name[64];
 	int ret;
@@ -1028,7 +1028,7 @@ int ath11k_debugfs_soc_create(struct ath11k_base *ab)
 
 out:
 	if (dput_needed)
-		dput(root);
+		debugfs_node_put(root);
 
 	return ret;
 }
@@ -1048,7 +1048,7 @@ EXPORT_SYMBOL(ath11k_debugfs_soc_destroy);
 
 void ath11k_debugfs_fw_stats_init(struct ath11k *ar)
 {
-	struct dentry *fwstats_dir = debugfs_create_dir("fw_stats",
+	struct debugfs_node *fwstats_dir = debugfs_create_dir("fw_stats",
 							ar->debug.debugfs_pdev);
 
 	ar->fw_stats.debugfs_fwstats = fwstats_dir;
@@ -1899,7 +1899,7 @@ void ath11k_debugfs_op_vif_add(struct ieee80211_hw *hw,
 {
 	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
 	struct ath11k_base *ab = arvif->ar->ab;
-	struct dentry *debugfs_twt;
+	struct debugfs_node *debugfs_twt;
 
 	if (arvif->vif->type != NL80211_IFTYPE_AP &&
 	    !(arvif->vif->type == NL80211_IFTYPE_STATION &&
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.h b/drivers/net/wireless/ath/ath11k/debugfs.h
index a39e458637b0..fc9e36221ede 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.h
+++ b/drivers/net/wireless/ath/ath11k/debugfs.h
@@ -74,7 +74,7 @@ struct ath11k_dbg_dbr_data {
 
 struct ath11k_debug_dbr {
 	struct ath11k_dbg_dbr_data dbr_dbg_data;
-	struct dentry *dbr_debugfs;
+	struct debugfs_node *dbr_debugfs;
 	bool dbr_debug_enabled;
 };
 
diff --git a/drivers/net/wireless/ath/ath11k/debugfs_sta.c b/drivers/net/wireless/ath/ath11k/debugfs_sta.c
index f56a24b6c8da..95f52e779945 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs_sta.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs_sta.c
@@ -849,7 +849,8 @@ static const struct file_operations fops_total_ps_duration = {
 };
 
 void ath11k_debugfs_sta_op_add(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-			       struct ieee80211_sta *sta, struct dentry *dir)
+			       struct ieee80211_sta *sta,
+			       struct debugfs_node *dir)
 {
 	struct ath11k *ar = hw->priv;
 
diff --git a/drivers/net/wireless/ath/ath11k/debugfs_sta.h b/drivers/net/wireless/ath/ath11k/debugfs_sta.h
index ace877e19275..e9e21d613a19 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs_sta.h
+++ b/drivers/net/wireless/ath/ath11k/debugfs_sta.h
@@ -15,7 +15,8 @@
 #ifdef CONFIG_ATH11K_DEBUGFS
 
 void ath11k_debugfs_sta_op_add(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-			       struct ieee80211_sta *sta, struct dentry *dir);
+			       struct ieee80211_sta *sta,
+			       struct debugfs_node *dir);
 void ath11k_debugfs_sta_add_tx_stats(struct ath11k_sta *arsta,
 				     struct ath11k_per_peer_tx_stats *peer_stats,
 				     u8 legacy_rate_idx);
diff --git a/drivers/net/wireless/ath/ath11k/spectral.c b/drivers/net/wireless/ath/ath11k/spectral.c
index 79e091134515..91776ee8492e 100644
--- a/drivers/net/wireless/ath/ath11k/spectral.c
+++ b/drivers/net/wireless/ath/ath11k/spectral.c
@@ -127,13 +127,13 @@ struct ath11k_spectral_search_report {
 	u8 rel_pwr_db;
 };
 
-static struct dentry *create_buf_file_handler(const char *filename,
-					      struct dentry *parent,
+static struct debugfs_node *create_buf_file_handler(const char *filename,
+					      struct debugfs_node *parent,
 					      umode_t mode,
 					      struct rchan_buf *buf,
 					      int *is_global)
 {
-	struct dentry *buf_file;
+	struct debugfs_node *buf_file;
 
 	buf_file = debugfs_create_file(filename, mode, parent, buf,
 				       &relay_file_operations);
@@ -141,7 +141,7 @@ static struct dentry *create_buf_file_handler(const char *filename,
 	return buf_file;
 }
 
-static int remove_buf_file_handler(struct dentry *dentry)
+static int remove_buf_file_handler(struct debugfs_node *dentry)
 {
 	debugfs_remove(dentry);
 
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index ee595794a7ae..914154acf547 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -556,8 +556,8 @@ struct ath12k_dbg_htt_stats {
 };
 
 struct ath12k_debug {
-	struct dentry *debugfs_pdev;
-	struct dentry *debugfs_pdev_symlink;
+	struct debugfs_node *debugfs_pdev;
+	struct debugfs_node *debugfs_pdev_symlink;
 	struct ath12k_dbg_htt_stats htt_stats;
 };
 
@@ -966,7 +966,7 @@ struct ath12k_base {
 	enum ath12k_dfs_region dfs_region;
 	struct ath12k_soc_dp_stats soc_stats;
 #ifdef CONFIG_ATH12K_DEBUGFS
-	struct dentry *debugfs_soc;
+	struct debugfs_node *debugfs_soc;
 #endif
 
 	unsigned long dev_flags;
diff --git a/drivers/net/wireless/ath/ath12k/debugfs.c b/drivers/net/wireless/ath/ath12k/debugfs.c
index d4b32d1a431c..910c5bc079ea 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs.c
@@ -35,7 +35,7 @@ void ath12k_debugfs_soc_create(struct ath12k_base *ab)
 {
 	bool dput_needed;
 	char soc_name[64] = { 0 };
-	struct dentry *debugfs_ath12k;
+	struct debugfs_node *debugfs_ath12k;
 
 	debugfs_ath12k = debugfs_lookup("ath12k", NULL);
 	if (debugfs_ath12k) {
@@ -54,7 +54,7 @@ void ath12k_debugfs_soc_create(struct ath12k_base *ab)
 	ab->debugfs_soc = debugfs_create_dir(soc_name, debugfs_ath12k);
 
 	if (dput_needed)
-		dput(debugfs_ath12k);
+		debugfs_node_put(debugfs_ath12k);
 }
 
 void ath12k_debugfs_soc_destroy(struct ath12k_base *ab)
diff --git a/drivers/net/wireless/ath/ath5k/debug.c b/drivers/net/wireless/ath/ath5k/debug.c
index ec130510aeb2..af041fff32d0 100644
--- a/drivers/net/wireless/ath/ath5k/debug.c
+++ b/drivers/net/wireless/ath/ath5k/debug.c
@@ -977,7 +977,7 @@ static const struct file_operations fops_eeprom = {
 void
 ath5k_debug_init_device(struct ath5k_hw *ah)
 {
-	struct dentry *phydir;
+	struct debugfs_node *phydir;
 
 	ah->debug.level = ath5k_debug;
 
diff --git a/drivers/net/wireless/ath/ath6kl/core.h b/drivers/net/wireless/ath/ath6kl/core.h
index 77e052336eb5..b327e9317ac8 100644
--- a/drivers/net/wireless/ath/ath6kl/core.h
+++ b/drivers/net/wireless/ath/ath6kl/core.h
@@ -831,7 +831,7 @@ struct ath6kl {
 
 	struct workqueue_struct *ath6kl_wq;
 
-	struct dentry *debugfs_phy;
+	struct debugfs_node *debugfs_phy;
 
 	bool p2p;
 
diff --git a/drivers/net/wireless/ath/ath9k/common-debug.c b/drivers/net/wireless/ath/ath9k/common-debug.c
index 7aefb79f6bed..4b526b275df7 100644
--- a/drivers/net/wireless/ath/ath9k/common-debug.c
+++ b/drivers/net/wireless/ath/ath9k/common-debug.c
@@ -44,7 +44,7 @@ static const struct file_operations fops_modal_eeprom = {
 };
 
 
-void ath9k_cmn_debug_modal_eeprom(struct dentry *debugfs_phy,
+void ath9k_cmn_debug_modal_eeprom(struct debugfs_node *debugfs_phy,
 				  struct ath_hw *ah)
 {
 	debugfs_create_file("modal_eeprom", 0400, debugfs_phy, ah,
@@ -79,7 +79,7 @@ static const struct file_operations fops_base_eeprom = {
 	.llseek = default_llseek,
 };
 
-void ath9k_cmn_debug_base_eeprom(struct dentry *debugfs_phy,
+void ath9k_cmn_debug_base_eeprom(struct debugfs_node *debugfs_phy,
 				 struct ath_hw *ah)
 {
 	debugfs_create_file("base_eeprom", 0400, debugfs_phy, ah,
@@ -177,7 +177,7 @@ static const struct file_operations fops_recv = {
 	.llseek = default_llseek,
 };
 
-void ath9k_cmn_debug_recv(struct dentry *debugfs_phy,
+void ath9k_cmn_debug_recv(struct debugfs_node *debugfs_phy,
 			  struct ath_rx_stats *rxstats)
 {
 	debugfs_create_file("recv", 0400, debugfs_phy, rxstats, &fops_recv);
@@ -253,7 +253,7 @@ static const struct file_operations fops_phy_err = {
 	.llseek = default_llseek,
 };
 
-void ath9k_cmn_debug_phy_err(struct dentry *debugfs_phy,
+void ath9k_cmn_debug_phy_err(struct debugfs_node *debugfs_phy,
 			     struct ath_rx_stats *rxstats)
 {
 	debugfs_create_file("phy_err", 0400, debugfs_phy, rxstats,
diff --git a/drivers/net/wireless/ath/ath9k/common-spectral.c b/drivers/net/wireless/ath/ath9k/common-spectral.c
index 628eeec4b82f..75d964813869 100644
--- a/drivers/net/wireless/ath/ath9k/common-spectral.c
+++ b/drivers/net/wireless/ath/ath9k/common-spectral.c
@@ -1008,13 +1008,13 @@ static const struct file_operations fops_spectral_fft_period = {
 /* Relay interface */
 /*******************/
 
-static struct dentry *create_buf_file_handler(const char *filename,
-					      struct dentry *parent,
+static struct debugfs_node *create_buf_file_handler(const char *filename,
+					      struct debugfs_node *parent,
 					      umode_t mode,
 					      struct rchan_buf *buf,
 					      int *is_global)
 {
-	struct dentry *buf_file;
+	struct debugfs_node *buf_file;
 
 	buf_file = debugfs_create_file(filename, mode, parent, buf,
 				       &relay_file_operations);
@@ -1025,7 +1025,7 @@ static struct dentry *create_buf_file_handler(const char *filename,
 	return buf_file;
 }
 
-static int remove_buf_file_handler(struct dentry *dentry)
+static int remove_buf_file_handler(struct debugfs_node *dentry)
 {
 	debugfs_remove(dentry);
 
@@ -1051,7 +1051,7 @@ void ath9k_cmn_spectral_deinit_debug(struct ath_spec_scan_priv *spec_priv)
 EXPORT_SYMBOL(ath9k_cmn_spectral_deinit_debug);
 
 void ath9k_cmn_spectral_init_debug(struct ath_spec_scan_priv *spec_priv,
-				   struct dentry *debugfs_phy)
+				   struct debugfs_node *debugfs_phy)
 {
 	spec_priv->rfs_chan_spec_scan = relay_open("spectral_scan",
 					    debugfs_phy,
diff --git a/drivers/net/wireless/ath/ath9k/debug.h b/drivers/net/wireless/ath/ath9k/debug.h
index cb3e75969875..932001c8ec14 100644
--- a/drivers/net/wireless/ath/ath9k/debug.h
+++ b/drivers/net/wireless/ath/ath9k/debug.h
@@ -248,7 +248,7 @@ struct ath_stats {
 };
 
 struct ath9k_debug {
-	struct dentry *debugfs_phy;
+	struct debugfs_node *debugfs_phy;
 	u32 regidx;
 	struct ath_stats stats;
 };
diff --git a/drivers/net/wireless/ath/ath9k/debug_sta.c b/drivers/net/wireless/ath/ath9k/debug_sta.c
index 1e2a30019fb6..843b9682a826 100644
--- a/drivers/net/wireless/ath/ath9k/debug_sta.c
+++ b/drivers/net/wireless/ath/ath9k/debug_sta.c
@@ -245,7 +245,7 @@ static const struct file_operations fops_node_recv = {
 void ath9k_sta_add_debugfs(struct ieee80211_hw *hw,
 			   struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta,
-			   struct dentry *dir)
+			   struct debugfs_node *dir)
 {
 	struct ath_node *an = (struct ath_node *)sta->drv_priv;
 
diff --git a/drivers/net/wireless/ath/ath9k/htc.h b/drivers/net/wireless/ath/ath9k/htc.h
index 6c33e898b300..f42c4d15046b 100644
--- a/drivers/net/wireless/ath/ath9k/htc.h
+++ b/drivers/net/wireless/ath/ath9k/htc.h
@@ -361,7 +361,7 @@ struct ath_skbrx_stats {
 };
 
 struct ath9k_debug {
-	struct dentry *debugfs_phy;
+	struct debugfs_node *debugfs_phy;
 	struct ath_tx_stats tx_stats;
 	struct ath_rx_stats rx_stats;
 	struct ath_skbrx_stats skbrx_stats;
diff --git a/drivers/net/wireless/ath/carl9170/carl9170.h b/drivers/net/wireless/ath/carl9170/carl9170.h
index ba29b4aebe9f..30b6d8544fe1 100644
--- a/drivers/net/wireless/ath/carl9170/carl9170.h
+++ b/drivers/net/wireless/ath/carl9170/carl9170.h
@@ -439,7 +439,7 @@ struct ar9170 {
 
 #ifdef CONFIG_CARL9170_DEBUGFS
 	struct carl9170_debug debug;
-	struct dentry *debug_dir;
+	struct debugfs_node *debug_dir;
 #endif /* CONFIG_CARL9170_DEBUGFS */
 
 	/* PSM */
diff --git a/drivers/net/wireless/ath/wcn36xx/debug.c b/drivers/net/wireless/ath/wcn36xx/debug.c
index 58b3c0501bfd..07520cd4f28e 100644
--- a/drivers/net/wireless/ath/wcn36xx/debug.c
+++ b/drivers/net/wireless/ath/wcn36xx/debug.c
@@ -175,7 +175,7 @@ static const struct file_operations fops_wcn36xx_firmware_feat_caps = {
 
 #define ADD_FILE(name, mode, fop, priv_data)		\
 	do {							\
-		struct dentry *d;				\
+		struct debugfs_node *d;				\
 		d = debugfs_create_file(__stringify(name),	\
 					mode, dfs->rootdir,	\
 					priv_data, fop);	\
diff --git a/drivers/net/wireless/ath/wcn36xx/debug.h b/drivers/net/wireless/ath/wcn36xx/debug.h
index 7116d96e0543..fe3d7f29168a 100644
--- a/drivers/net/wireless/ath/wcn36xx/debug.h
+++ b/drivers/net/wireless/ath/wcn36xx/debug.h
@@ -28,7 +28,7 @@ struct wcn36xx_dfs_file {
 };
 
 struct wcn36xx_dfs_entry {
-	struct dentry *rootdir;
+	struct debugfs_node *rootdir;
 	struct wcn36xx_dfs_file file_bmps_switcher;
 	struct wcn36xx_dfs_file file_dump;
 	struct wcn36xx_dfs_file file_firmware_feat_caps;
diff --git a/drivers/net/wireless/ath/wil6210/debugfs.c b/drivers/net/wireless/ath/wil6210/debugfs.c
index c021ebcddee7..a1730381744a 100644
--- a/drivers/net/wireless/ath/wil6210/debugfs.c
+++ b/drivers/net/wireless/ath/wil6210/debugfs.c
@@ -413,7 +413,8 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_iomem_x32, wil_debugfs_iomem_x32_get,
 			 wil_debugfs_iomem_x32_set, "0x%08llx\n");
 
 static void wil_debugfs_create_iomem_x32(const char *name, umode_t mode,
-					 struct dentry *parent, void *value,
+					 struct debugfs_node *parent,
+					 void *value,
 					 struct wil6210_priv *wil)
 {
 	struct wil_debugfs_iomem_data *data = &wil->dbg_data.data_arr[
@@ -451,7 +452,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(wil_fops_ulong, wil_debugfs_ulong_get,
  * Creates files accordingly to the @tbl.
  */
 static void wil6210_debugfs_init_offset(struct wil6210_priv *wil,
-					struct dentry *dbg, void *base,
+					struct debugfs_node *dbg, void *base,
 					const struct dbg_off * const tbl)
 {
 	int i;
@@ -496,10 +497,11 @@ static const struct dbg_off isr_off[] = {
 };
 
 static void wil6210_debugfs_create_ISR(struct wil6210_priv *wil,
-				       const char *name, struct dentry *parent,
+				       const char *name,
+				       struct debugfs_node *parent,
 				       u32 off)
 {
-	struct dentry *d = debugfs_create_dir(name, parent);
+	struct debugfs_node *d = debugfs_create_dir(name, parent);
 
 	wil6210_debugfs_init_offset(wil, d, (void * __force)wil->csr + off,
 				    isr_off);
@@ -513,9 +515,9 @@ static const struct dbg_off pseudo_isr_off[] = {
 };
 
 static void wil6210_debugfs_create_pseudo_ISR(struct wil6210_priv *wil,
-					      struct dentry *parent)
+					      struct debugfs_node *parent)
 {
-	struct dentry *d = debugfs_create_dir("PSEUDO_ISR", parent);
+	struct debugfs_node *d = debugfs_create_dir("PSEUDO_ISR", parent);
 
 	wil6210_debugfs_init_offset(wil, d, (void * __force)wil->csr,
 				    pseudo_isr_off);
@@ -561,9 +563,9 @@ static const struct dbg_off rx_itr_cnt_off[] = {
 };
 
 static int wil6210_debugfs_create_ITR_CNT(struct wil6210_priv *wil,
-					  struct dentry *parent)
+					  struct debugfs_node *parent)
 {
-	struct dentry *d, *dtx, *drx;
+	struct debugfs_node *d, *dtx, *drx;
 
 	d = debugfs_create_dir("ITR_CNT", parent);
 
@@ -681,9 +683,9 @@ static const struct file_operations fops_ioblob = {
 };
 
 static
-struct dentry *wil_debugfs_create_ioblob(const char *name,
+struct debugfs_node *wil_debugfs_create_ioblob(const char *name,
 					 umode_t mode,
-					 struct dentry *parent,
+					 struct debugfs_node *parent,
 					 struct wil_blob_wrapper *wil_blob)
 {
 	return debugfs_create_file(name, mode, parent, wil_blob, &fops_ioblob);
@@ -2295,7 +2297,7 @@ static const struct file_operations fops_compressed_rx_status = {
 
 /*----------------*/
 static void wil6210_debugfs_init_blobs(struct wil6210_priv *wil,
-				       struct dentry *dbg)
+				       struct debugfs_node *dbg)
 {
 	int i;
 	char name[32];
@@ -2356,7 +2358,7 @@ static const struct {
 };
 
 static void wil6210_debugfs_init_files(struct wil6210_priv *wil,
-				       struct dentry *dbg)
+				       struct debugfs_node *dbg)
 {
 	int i;
 
@@ -2377,7 +2379,7 @@ static const struct {
 };
 
 static void wil6210_debugfs_init_isr(struct wil6210_priv *wil,
-				     struct dentry *dbg)
+				     struct debugfs_node *dbg)
 {
 	int i;
 
@@ -2436,7 +2438,7 @@ static const int dbg_off_count = 4 * (ARRAY_SIZE(isr_off) - 1) +
 
 int wil6210_debugfs_init(struct wil6210_priv *wil)
 {
-	struct dentry *dbg = wil->debug = debugfs_create_dir(WIL_NAME,
+	struct debugfs_node *dbg = wil->debug = debugfs_create_dir(WIL_NAME,
 			wil_to_wiphy(wil)->debugfsdir);
 	if (IS_ERR_OR_NULL(dbg))
 		return -ENODEV;
diff --git a/drivers/net/wireless/ath/wil6210/wil6210.h b/drivers/net/wireless/ath/wil6210/wil6210.h
index 9bd1286d2857..0172cc61b725 100644
--- a/drivers/net/wireless/ath/wil6210/wil6210.h
+++ b/drivers/net/wireless/ath/wil6210/wil6210.h
@@ -1007,7 +1007,7 @@ struct wil6210_priv {
 	/* statistics */
 	atomic_t isr_count_rx, isr_count_tx;
 	/* debugfs */
-	struct dentry *debug;
+	struct debugfs_node *debug;
 	struct wil_blob_wrapper blobs[MAX_FW_MAPPING_TABLE_SIZE];
 	u8 discovery_mode;
 	u8 abft_len;
diff --git a/drivers/net/wireless/broadcom/b43/debugfs.c b/drivers/net/wireless/broadcom/b43/debugfs.c
index 5a49970afc8c..773afddb8010 100644
--- a/drivers/net/wireless/broadcom/b43/debugfs.c
+++ b/drivers/net/wireless/broadcom/b43/debugfs.c
@@ -25,7 +25,7 @@
 
 
 /* The root directory. */
-static struct dentry *rootdir;
+static struct debugfs_node *rootdir;
 
 struct b43_debugfs_fops {
 	ssize_t (*read)(struct b43_wldev *dev, char *buf, size_t bufsize);
diff --git a/drivers/net/wireless/broadcom/b43/debugfs.h b/drivers/net/wireless/broadcom/b43/debugfs.h
index 6f6b500b8881..762cdb114a3d 100644
--- a/drivers/net/wireless/broadcom/b43/debugfs.h
+++ b/drivers/net/wireless/broadcom/b43/debugfs.h
@@ -21,6 +21,7 @@ enum b43_dyndbg {		/* Dynamic debugging features */
 #ifdef CONFIG_B43_DEBUG
 
 struct dentry;
+#define debugfs_node dentry
 
 #define B43_NR_LOGGED_TXSTATUS	100
 
@@ -38,7 +39,7 @@ struct b43_dfs_file {
 
 struct b43_dfsentry {
 	struct b43_wldev *dev;
-	struct dentry *subdir;
+	struct debugfs_node *subdir;
 
 	struct b43_dfs_file file_shm16read;
 	struct b43_dfs_file file_shm16write;
diff --git a/drivers/net/wireless/broadcom/b43legacy/debugfs.c b/drivers/net/wireless/broadcom/b43legacy/debugfs.c
index 5d04bcc216e5..de9754ebaaeb 100644
--- a/drivers/net/wireless/broadcom/b43legacy/debugfs.c
+++ b/drivers/net/wireless/broadcom/b43legacy/debugfs.c
@@ -26,7 +26,7 @@
 
 
 /* The root directory. */
-static struct dentry *rootdir;
+static struct debugfs_node *rootdir;
 
 struct b43legacy_debugfs_fops {
 	ssize_t (*read)(struct b43legacy_wldev *dev, char *buf, size_t bufsize);
diff --git a/drivers/net/wireless/broadcom/b43legacy/debugfs.h b/drivers/net/wireless/broadcom/b43legacy/debugfs.h
index 924130880dfe..350f3b4c40f6 100644
--- a/drivers/net/wireless/broadcom/b43legacy/debugfs.h
+++ b/drivers/net/wireless/broadcom/b43legacy/debugfs.h
@@ -18,6 +18,7 @@ enum b43legacy_dyndbg { /* Dynamic debugging features */
 #ifdef CONFIG_B43LEGACY_DEBUG
 
 struct dentry;
+#define debugfs_node dentry
 
 #define B43legacy_NR_LOGGED_TXSTATUS	100
 
@@ -34,7 +35,7 @@ struct b43legacy_dfs_file {
 
 struct b43legacy_dfsentry {
 	struct b43legacy_wldev *dev;
-	struct dentry *subdir;
+	struct debugfs_node *subdir;
 
 	struct b43legacy_dfs_file file_tsf;
 	struct b43legacy_dfs_file file_ucode_regs;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
index 2abae8894614..0e8e9a2fee71 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
@@ -359,7 +359,7 @@ struct brcmf_cfg80211_info {
 	bool scan_tried;
 	u8 *dcmd_buf;
 	u8 *extra_buf;
-	struct dentry *debugfsdir;
+	struct debugfs_node *debugfsdir;
 	struct escan_info escan_info;
 	struct timer_list escan_timeout;
 	struct work_struct escan_timeout_work;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h
index d53839f855d7..a9cbee03258f 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h
@@ -132,7 +132,7 @@ struct brcmf_pub {
 
 	struct brcmf_rev_info revinfo;
 #ifdef DEBUG
-	struct dentry *dbgfs_dir;
+	struct debugfs_node *dbgfs_dir;
 #endif
 
 	struct notifier_block inetaddr_notifier;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.c
index eecf8a38d94a..0ed071f2ef23 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.c
@@ -42,7 +42,7 @@ int brcmf_debug_create_memdump(struct brcmf_bus *bus, const void *data,
 	return 0;
 }
 
-struct dentry *brcmf_debugfs_get_devdir(struct brcmf_pub *drvr)
+struct debugfs_node *brcmf_debugfs_get_devdir(struct brcmf_pub *drvr)
 {
 	return drvr->wiphy->debugfsdir;
 }
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.h
index 9bb5f709d41a..4b707f1049b3 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.h
@@ -118,13 +118,13 @@ extern int brcmf_msg_level;
 
 struct brcmf_pub;
 #ifdef DEBUG
-struct dentry *brcmf_debugfs_get_devdir(struct brcmf_pub *drvr);
+struct debugfs_node *brcmf_debugfs_get_devdir(struct brcmf_pub *drvr);
 void brcmf_debugfs_add_entry(struct brcmf_pub *drvr, const char *fn,
 			     int (*read_fn)(struct seq_file *seq, void *data));
 int brcmf_debug_create_memdump(struct brcmf_bus *bus, const void *data,
 			       size_t len);
 #else
-static inline struct dentry *brcmf_debugfs_get_devdir(struct brcmf_pub *drvr)
+static inline struct debugfs_node *brcmf_debugfs_get_devdir(struct brcmf_pub *drvr)
 {
 	return ERR_PTR(-ENOENT);
 }
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index e4395b1f8c11..6f266caabf4a 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -2376,7 +2376,7 @@ static void brcmf_pcie_debugfs_create(struct device *dev)
 	struct brcmf_pub *drvr = bus_if->drvr;
 	struct brcmf_pciedev *pcie_bus_dev = bus_if->bus_priv.pcie;
 	struct brcmf_pciedev_info *devinfo = pcie_bus_dev->devinfo;
-	struct dentry *dentry = brcmf_debugfs_get_devdir(drvr);
+	struct debugfs_node *dentry = brcmf_debugfs_get_devdir(drvr);
 
 	if (IS_ERR_OR_NULL(dentry))
 		return;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index b1727f35217b..a5a07be10005 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -3215,7 +3215,7 @@ static void brcmf_sdio_debugfs_create(struct device *dev)
 	struct brcmf_pub *drvr = bus_if->drvr;
 	struct brcmf_sdio_dev *sdiodev = bus_if->bus_priv.sdio;
 	struct brcmf_sdio *bus = sdiodev->bus;
-	struct dentry *dentry = brcmf_debugfs_get_devdir(drvr);
+	struct debugfs_node *dentry = brcmf_debugfs_get_devdir(drvr);
 
 	if (IS_ERR_OR_NULL(dentry))
 		return;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/debug.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/debug.c
index 81df41c7fbb5..d39386ce2c65 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/debug.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/debug.c
@@ -32,7 +32,7 @@
 #include "brcms_trace_events.h"
 #include "phy/phy_int.h"
 
-static struct dentry *root_folder;
+static struct debugfs_node *root_folder;
 
 void brcms_debugfs_init(void)
 {
@@ -186,7 +186,7 @@ brcms_debugfs_add_entry(struct brcms_pub *drvr, const char *fn,
 			int (*read_fn)(struct seq_file *seq, void *data))
 {
 	struct device *dev = &drvr->wlc->hw->d11core->dev;
-	struct dentry *dentry =  drvr->dbgfs_dir;
+	struct debugfs_node *dentry =  drvr->dbgfs_dir;
 	struct brcms_debugfs_entry *entry;
 
 	entry = devm_kzalloc(dev, sizeof(*entry), GFP_KERNEL);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/pub.h b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/pub.h
index bfc63b2f0537..b97bdb3d0fc4 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/pub.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/pub.h
@@ -174,7 +174,7 @@ struct brcms_pub {
 	bool phy_11ncapable;	/* the PHY/HW is capable of 802.11N */
 
 	struct wl_cnt *_cnt;	/* low-level counters in driver */
-	struct dentry *dbgfs_dir;
+	struct debugfs_node *dbgfs_dir;
 };
 
 enum wlc_par_id {
diff --git a/drivers/net/wireless/intel/iwlegacy/3945-rs.c b/drivers/net/wireless/intel/iwlegacy/3945-rs.c
index 0eaad980c85c..8b3b647cd384 100644
--- a/drivers/net/wireless/intel/iwlegacy/3945-rs.c
+++ b/drivers/net/wireless/intel/iwlegacy/3945-rs.c
@@ -839,7 +839,7 @@ static const struct file_operations rs_sta_dbgfs_stats_table_ops = {
 };
 
 static void
-il3945_add_debugfs(void *il, void *il_sta, struct dentry *dir)
+il3945_add_debugfs(void *il, void *il_sta, struct debugfs_node *dir)
 {
 	struct il3945_rs_sta *lq_sta = il_sta;
 
diff --git a/drivers/net/wireless/intel/iwlegacy/4965-rs.c b/drivers/net/wireless/intel/iwlegacy/4965-rs.c
index 718efb1aa1b0..8fd3f3194482 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965-rs.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965-rs.c
@@ -2745,7 +2745,7 @@ static const struct file_operations rs_sta_dbgfs_rate_scale_data_ops = {
 };
 
 static void
-il4965_rs_add_debugfs(void *il, void *il_sta, struct dentry *dir)
+il4965_rs_add_debugfs(void *il, void *il_sta, struct debugfs_node *dir)
 {
 	struct il_lq_sta *lq_sta = il_sta;
 
diff --git a/drivers/net/wireless/intel/iwlegacy/common.h b/drivers/net/wireless/intel/iwlegacy/common.h
index 92285412ab10..7fe36e4b640c 100644
--- a/drivers/net/wireless/intel/iwlegacy/common.h
+++ b/drivers/net/wireless/intel/iwlegacy/common.h
@@ -1414,7 +1414,7 @@ struct il_priv {
 	u16 rx_traffic_idx;
 	u8 *tx_traffic;
 	u8 *rx_traffic;
-	struct dentry *debugfs_dir;
+	struct debugfs_node *debugfs_dir;
 	u32 dbgfs_sram_offset, dbgfs_sram_len;
 	bool disable_ht40;
 #endif				/* CONFIG_IWLEGACY_DEBUGFS */
diff --git a/drivers/net/wireless/intel/iwlegacy/debug.c b/drivers/net/wireless/intel/iwlegacy/debug.c
index d998a3f1b056..ba7f954f3d60 100644
--- a/drivers/net/wireless/intel/iwlegacy/debug.c
+++ b/drivers/net/wireless/intel/iwlegacy/debug.c
@@ -1315,8 +1315,8 @@ DEBUGFS_WRITE_FILE_OPS(wd_timeout);
 void
 il_dbgfs_register(struct il_priv *il, const char *name)
 {
-	struct dentry *phyd = il->hw->wiphy->debugfsdir;
-	struct dentry *dir_drv, *dir_data, *dir_rf, *dir_debug;
+	struct debugfs_node *phyd = il->hw->wiphy->debugfsdir;
+	struct debugfs_node *dir_drv, *dir_data, *dir_rf, *dir_debug;
 
 	dir_drv = debugfs_create_dir(name, phyd);
 	il->debugfs_dir = dir_drv;
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/agn.h b/drivers/net/wireless/intel/iwlwifi/dvm/agn.h
index a13add556a7b..1adfba4bffc8 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/agn.h
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/agn.h
@@ -405,10 +405,10 @@ iwl_parse_eeprom_data(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 int iwl_read_eeprom(struct iwl_trans *trans, u8 **eeprom, size_t *eeprom_size);
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
-void iwl_dbgfs_register(struct iwl_priv *priv, struct dentry *dbgfs_dir);
+void iwl_dbgfs_register(struct iwl_priv *priv, struct debugfs_node *dbgfs_dir);
 #else
 static inline void iwl_dbgfs_register(struct iwl_priv *priv,
-				      struct dentry *dbgfs_dir) { }
+				      struct debugfs_node *dbgfs_dir) { }
 #endif /* CONFIG_IWLWIFI_DEBUGFS */
 
 #ifdef CONFIG_IWLWIFI_DEBUG
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/dvm/debugfs.c
index b246dbd371b3..523d27589024 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/debugfs.c
@@ -2308,9 +2308,9 @@ DEBUGFS_READ_WRITE_FILE_OPS(calib_disabled);
  * Create the debugfs files and directories
  *
  */
-void iwl_dbgfs_register(struct iwl_priv *priv, struct dentry *dbgfs_dir)
+void iwl_dbgfs_register(struct iwl_priv *priv, struct debugfs_node *dbgfs_dir)
 {
-	struct dentry *dir_data, *dir_rf, *dir_debug;
+	struct debugfs_node *dir_data, *dir_rf, *dir_debug;
 
 	priv->debugfs_dir = dbgfs_dir;
 
@@ -2369,7 +2369,7 @@ void iwl_dbgfs_register(struct iwl_priv *priv, struct dentry *dbgfs_dir)
 	 */
 	if (priv->mac80211_registered) {
 		char buf[100];
-		struct dentry *mac80211_dir, *dev_dir;
+		struct debugfs_node *mac80211_dir, *dev_dir;
 
 		dev_dir = dbgfs_dir->d_parent;
 		mac80211_dir = priv->hw->wiphy->debugfsdir;
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/dev.h b/drivers/net/wireless/intel/iwlwifi/dvm/dev.h
index 4ac8b862ad41..8677214573a6 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/dev.h
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/dev.h
@@ -846,7 +846,7 @@ struct iwl_priv {
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	/* debugfs */
-	struct dentry *debugfs_dir;
+	struct debugfs_node *debugfs_dir;
 	u32 dbgfs_sram_offset, dbgfs_sram_len;
 	bool disable_ht40;
 	void *wowlan_sram;
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/main.c b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
index 30789ba06d9d..d48d16af833e 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
@@ -1226,7 +1226,7 @@ static int iwl_nvm_check_version(struct iwl_nvm_data *data,
 static struct iwl_op_mode *iwl_op_mode_dvm_start(struct iwl_trans *trans,
 						 const struct iwl_cfg *cfg,
 						 const struct iwl_fw *fw,
-						 struct dentry *dbgfs_dir)
+						 struct debugfs_node *dbgfs_dir)
 {
 	struct iwl_priv *priv;
 	struct ieee80211_hw *hw;
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/rs.c b/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
index 8879e668ef0d..19600312a62d 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
@@ -3237,7 +3237,7 @@ static const struct file_operations rs_sta_dbgfs_rate_scale_data_ops = {
 };
 
 static void rs_add_debugfs(void *priv, void *priv_sta,
-					struct dentry *dir)
+					struct debugfs_node *dir)
 {
 	struct iwl_lq_sta *lq_sta = priv_sta;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
index f0c813d675f4..7a35553cef52 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
@@ -434,7 +434,7 @@ static const struct file_operations iwl_dbgfs_fw_info_ops = {
 };
 
 void iwl_fwrt_dbgfs_register(struct iwl_fw_runtime *fwrt,
-			    struct dentry *dbgfs_dir)
+			    struct debugfs_node *dbgfs_dir)
 {
 	INIT_DELAYED_WORK(&fwrt->timestamp.wk, iwl_fw_timestamp_marker_wk);
 	FWRT_DEBUGFS_ADD_FILE(timestamp_marker, dbgfs_dir, 0200);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.h b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.h
index 0248d40bc233..e4a2f7a676d4 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.h
@@ -8,10 +8,10 @@
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 void iwl_fwrt_dbgfs_register(struct iwl_fw_runtime *fwrt,
-			    struct dentry *dbgfs_dir);
+			    struct debugfs_node *dbgfs_dir);
 
 #else
 static inline void iwl_fwrt_dbgfs_register(struct iwl_fw_runtime *fwrt,
-					   struct dentry *dbgfs_dir) { }
+					   struct debugfs_node *dbgfs_dir) { }
 
 #endif /* CONFIG_IWLWIFI_DEBUGFS */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/init.c b/drivers/net/wireless/intel/iwlwifi/fw/init.c
index de87e0e3e072..7ce099dec592 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/init.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/init.c
@@ -18,7 +18,7 @@ void iwl_fw_runtime_init(struct iwl_fw_runtime *fwrt, struct iwl_trans *trans,
 			const struct iwl_fw_runtime_ops *ops, void *ops_ctx,
 			const struct iwl_dump_sanitize_ops *sanitize_ops,
 			void *sanitize_ctx,
-			struct dentry *dbgfs_dir)
+			struct debugfs_node *dbgfs_dir)
 {
 	int i;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index d3a65f33097c..d2612e71c3a8 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -35,7 +35,7 @@ MODULE_DESCRIPTION(DRV_DESCRIPTION);
 MODULE_LICENSE("GPL");
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
-static struct dentry *iwl_dbgfs_root;
+static struct debugfs_node *iwl_dbgfs_root;
 #endif
 
 /**
@@ -66,9 +66,9 @@ struct iwl_drv {
 	struct completion request_firmware_complete;
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
-	struct dentry *dbgfs_drv;
-	struct dentry *dbgfs_trans;
-	struct dentry *dbgfs_op_mode;
+	struct debugfs_node *dbgfs_drv;
+	struct debugfs_node *dbgfs_trans;
+	struct debugfs_node *dbgfs_op_mode;
 #endif
 };
 
@@ -1413,7 +1413,7 @@ static struct iwl_op_mode *
 _iwl_op_mode_start(struct iwl_drv *drv, struct iwlwifi_opmode_table *op)
 {
 	const struct iwl_op_mode_ops *ops = op->ops;
-	struct dentry *dbgfs_dir = NULL;
+	struct debugfs_node *dbgfs_dir = NULL;
 	struct iwl_op_mode *op_mode = NULL;
 	int retry, max_retry = !!iwlwifi_mod_params.fw_restart * IWL_MAX_INIT_RETRY;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index f6234065dbdd..3f9940976776 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -938,7 +938,7 @@ struct iwl_trans {
 	struct kmem_cache *dev_cmd_pool;
 	char dev_cmd_pool_name[50];
 
-	struct dentry *dbgfs_dir;
+	struct debugfs_node *dbgfs_dir;
 
 #ifdef CONFIG_LOCKDEP
 	struct lockdep_map sync_cmd_lockdep_map;
diff --git a/drivers/net/wireless/intel/iwlwifi/mei/main.c b/drivers/net/wireless/intel/iwlwifi/mei/main.c
index dce0b7cf7b26..4af1f24ad95a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/mei/main.c
@@ -193,7 +193,7 @@ struct iwl_mei {
 	atomic_t sap_seq_no;
 	atomic_t seq_no;
 
-	struct dentry *dbgfs_dir;
+	struct debugfs_node *dbgfs_dir;
 };
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
index fbe4e4a50852..1b036351c4fb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
@@ -890,7 +890,7 @@ MVM_DEBUGFS_READ_WRITE_FILE_OPS(esr_disable_reason, 32);
 void iwl_mvm_vif_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
-	struct dentry *dbgfs_dir = vif->debugfs_dir;
+	struct debugfs_node *dbgfs_dir = vif->debugfs_dir;
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 
 	mvmvif->dbgfs_dir = debugfs_create_dir("iwlmvm", dbgfs_dir);
@@ -926,7 +926,7 @@ void iwl_mvm_vif_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 
 void iwl_mvm_vif_dbgfs_add_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 {
-	struct dentry *dbgfs_dir = vif->debugfs_dir;
+	struct debugfs_node *dbgfs_dir = vif->debugfs_dir;
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	char buf[3 * 3 + 11 + (NL80211_WIPHY_NAME_MAXLEN + 1) +
 		 (7 + IFNAMSIZ + 1) + 6 + 1];
@@ -970,7 +970,7 @@ void iwl_mvm_vif_dbgfs_rm_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 
 static void iwl_mvm_debugfs_add_link_files(struct ieee80211_vif *vif,
 					   struct ieee80211_bss_conf *link_conf,
-					   struct dentry *mvm_dir)
+					   struct debugfs_node *mvm_dir)
 {
 	/* Add per-link files here*/
 }
@@ -978,13 +978,13 @@ static void iwl_mvm_debugfs_add_link_files(struct ieee80211_vif *vif,
 void iwl_mvm_link_add_debugfs(struct ieee80211_hw *hw,
 			      struct ieee80211_vif *vif,
 			      struct ieee80211_bss_conf *link_conf,
-			      struct dentry *dir)
+			      struct debugfs_node *dir)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm *mvm = mvmvif->mvm;
 	unsigned int link_id = link_conf->link_id;
 	struct iwl_mvm_vif_link_info *link_info = mvmvif->link[link_id];
-	struct dentry *mvm_dir;
+	struct debugfs_node *mvm_dir;
 
 	if (WARN_ON(!link_info) || !dir)
 		return;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 83e3c1160362..fa44ce62eb57 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -2096,7 +2096,7 @@ static const struct file_operations iwl_dbgfs_mem_ops = {
 void iwl_mvm_link_sta_add_debugfs(struct ieee80211_hw *hw,
 				  struct ieee80211_vif *vif,
 				  struct ieee80211_link_sta *link_sta,
-				  struct dentry *dir)
+				  struct debugfs_node *dir)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index ee769da72e68..c455e1869265 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -545,8 +545,8 @@ struct iwl_mvm_vif {
 #endif
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
-	struct dentry *dbgfs_dir;
-	struct dentry *dbgfs_slink;
+	struct debugfs_node *dbgfs_dir;
+	struct debugfs_node *dbgfs_slink;
 	struct iwl_dbgfs_pm dbgfs_pm;
 	struct iwl_dbgfs_bf dbgfs_bf;
 	struct iwl_mac_power_cmd mac_pwr_cmd;
@@ -1137,7 +1137,7 @@ struct iwl_mvm {
 	 * Leave this pointer outside the ifdef below so that it can be
 	 * assigned without ifdef in the source code.
 	 */
-	struct dentry *debugfs_dir;
+	struct debugfs_node *debugfs_dir;
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	u32 dbgfs_sram_offset, dbgfs_sram_len;
 	u32 dbgfs_prph_reg_addr;
@@ -2614,11 +2614,11 @@ void iwl_mvm_get_bios_tables(struct iwl_mvm *mvm);
 void iwl_mvm_link_sta_add_debugfs(struct ieee80211_hw *hw,
 				  struct ieee80211_vif *vif,
 				  struct ieee80211_link_sta *link_sta,
-				  struct dentry *dir);
+				  struct debugfs_node *dir);
 void iwl_mvm_link_add_debugfs(struct ieee80211_hw *hw,
 			      struct ieee80211_vif *vif,
 			      struct ieee80211_bss_conf *link_conf,
-			      struct dentry *dir);
+			      struct debugfs_node *dir);
 #endif
 
 /* new MLD related APIs */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index a8c4e354e2ce..e23138460be4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -4052,7 +4052,7 @@ static ssize_t iwl_dbgfs_ss_force_write(struct iwl_lq_sta *lq_sta, char *buf,
 MVM_DEBUGFS_READ_WRITE_FILE_OPS(ss_force, 32);
 
 static void rs_drv_add_sta_debugfs(void *mvm, void *priv_sta,
-				   struct dentry *dir)
+				   struct debugfs_node *dir)
 {
 	struct iwl_lq_sta *lq_sta = priv_sta;
 	struct iwl_mvm_sta *mvmsta;
diff --git a/drivers/net/wireless/marvell/libertas/debugfs.c b/drivers/net/wireless/marvell/libertas/debugfs.c
index c604613ab506..bbc96423e735 100644
--- a/drivers/net/wireless/marvell/libertas/debugfs.c
+++ b/drivers/net/wireless/marvell/libertas/debugfs.c
@@ -12,7 +12,7 @@
 #include "cmd.h"
 #include "debugfs.h"
 
-static struct dentry *lbs_dir;
+static struct debugfs_node *lbs_dir;
 static char *szStates[] = {
 	"Connected",
 	"Disconnected"
diff --git a/drivers/net/wireless/marvell/libertas/dev.h b/drivers/net/wireless/marvell/libertas/dev.h
index 4b6e05a8e5d5..d5fd3068e128 100644
--- a/drivers/net/wireless/marvell/libertas/dev.h
+++ b/drivers/net/wireless/marvell/libertas/dev.h
@@ -62,13 +62,13 @@ struct lbs_private {
 #endif
 
 	/* Debugfs */
-	struct dentry *debugfs_dir;
-	struct dentry *debugfs_debug;
-	struct dentry *debugfs_files[6];
+	struct debugfs_node *debugfs_dir;
+	struct debugfs_node *debugfs_debug;
+	struct debugfs_node *debugfs_files[6];
 	struct dentry *events_dir;
-	struct dentry *debugfs_events_files[6];
+	struct debugfs_node *debugfs_events_files[6];
 	struct dentry *regs_dir;
-	struct dentry *debugfs_regs_files[6];
+	struct debugfs_node *debugfs_regs_files[6];
 
 	/* Hardware debugging */
 	u32 mac_offset;
diff --git a/drivers/net/wireless/marvell/mwifiex/debugfs.c b/drivers/net/wireless/marvell/mwifiex/debugfs.c
index 9deaf59dcb62..3b93e1d11c35 100644
--- a/drivers/net/wireless/marvell/mwifiex/debugfs.c
+++ b/drivers/net/wireless/marvell/mwifiex/debugfs.c
@@ -11,7 +11,7 @@
 #include "11n.h"
 
 
-static struct dentry *mwifiex_dfs_dir;
+static struct debugfs_node *mwifiex_dfs_dir;
 
 static char *bss_modes[] = {
 	"UNSPECIFIED",
diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index 0674dcf7a537..ce5d705370c5 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -631,7 +631,7 @@ struct mwifiex_private {
 	u32 versionstrsel;
 	char version_str[MWIFIEX_VERSION_STR_LENGTH];
 #ifdef CONFIG_DEBUG_FS
-	struct dentry *dfs_dev_dir;
+	struct debugfs_node *dfs_dev_dir;
 #endif
 	u16 current_key_index;
 	struct mutex async_mutex;
diff --git a/drivers/net/wireless/mediatek/mt76/debugfs.c b/drivers/net/wireless/mediatek/mt76/debugfs.c
index b6a2746c187d..a6f7928adf07 100644
--- a/drivers/net/wireless/mediatek/mt76/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/debugfs.c
@@ -100,13 +100,13 @@ void mt76_seq_puts_array(struct seq_file *file, const char *str,
 }
 EXPORT_SYMBOL_GPL(mt76_seq_puts_array);
 
-struct dentry *
+struct debugfs_node *
 mt76_register_debugfs_fops(struct mt76_phy *phy,
 			   const struct file_operations *ops)
 {
 	const struct file_operations *fops = ops ? ops : &fops_regval;
 	struct mt76_dev *dev = phy->dev;
-	struct dentry *dir;
+	struct debugfs_node *dir;
 
 	dir = debugfs_create_dir("mt76", phy->hw->wiphy->debugfsdir);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 132148f7b107..3af9e4247b31 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1225,9 +1225,9 @@ struct mt76_phy *mt76_alloc_phy(struct mt76_dev *dev, unsigned int size,
 int mt76_register_phy(struct mt76_phy *phy, bool vht,
 		      struct ieee80211_rate *rates, int n_rates);
 
-struct dentry *mt76_register_debugfs_fops(struct mt76_phy *phy,
+struct debugfs_node *mt76_register_debugfs_fops(struct mt76_phy *phy,
 					  const struct file_operations *ops);
-static inline struct dentry *mt76_register_debugfs(struct mt76_dev *dev)
+static inline struct debugfs_node *mt76_register_debugfs(struct mt76_dev *dev)
 {
 	return mt76_register_debugfs_fops(&dev->phy, NULL);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c
index 3967f2f05774..95a1dbb5079c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c
@@ -95,7 +95,7 @@ DEFINE_SHOW_ATTRIBUTE(mt7603_ampdu_stat);
 
 void mt7603_init_debugfs(struct mt7603_dev *dev)
 {
-	struct dentry *dir;
+	struct debugfs_node *dir;
 
 	dir = mt76_register_debugfs(&dev->mt76);
 	if (!dir)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
index 2a6d317db5e0..092de2e3efe5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
@@ -547,7 +547,7 @@ mt7663s_sched_quota_read(struct seq_file *s, void *data)
 
 int mt7615_init_debugfs(struct mt7615_dev *dev)
 {
-	struct dentry *dir;
+	struct debugfs_node *dir;
 
 	dir = mt76_register_debugfs_fops(&dev->mphy, &fops_regval);
 	if (!dir)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c b/drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c
index 8ce4bf44733d..8d73a3765cb5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c
@@ -131,7 +131,7 @@ static int mt76x02_read_rate_txpower(struct seq_file *s, void *data)
 
 void mt76x02_init_debugfs(struct mt76x02_dev *dev)
 {
-	struct dentry *dir;
+	struct debugfs_node *dir;
 
 	dir = mt76_register_debugfs(&dev->mt76);
 	if (!dir)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 578013884e43..11db0d93e419 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -582,11 +582,12 @@ mt7915_fw_debug_wa_get(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(fops_fw_debug_wa, mt7915_fw_debug_wa_get,
 			 mt7915_fw_debug_wa_set, "%lld\n");
 
-static struct dentry *
-create_buf_file_cb(const char *filename, struct dentry *parent, umode_t mode,
+static struct debugfs_node *
+create_buf_file_cb(const char *filename, struct debugfs_node *parent,
+		   umode_t mode,
 		   struct rchan_buf *buf, int *is_global)
 {
-	struct dentry *f;
+	struct debugfs_node *f;
 
 	f = debugfs_create_file("fwlog_data", mode, parent, buf,
 				&relay_file_operations);
@@ -599,7 +600,7 @@ create_buf_file_cb(const char *filename, struct dentry *parent, umode_t mode,
 }
 
 static int
-remove_buf_file_cb(struct dentry *f)
+remove_buf_file_cb(struct debugfs_node *f)
 {
 	debugfs_remove(f);
 
@@ -1208,7 +1209,7 @@ int mt7915_init_debugfs(struct mt7915_phy *phy)
 {
 	struct mt7915_dev *dev = phy->dev;
 	bool ext_phy = phy != &dev->phy;
-	struct dentry *dir;
+	struct debugfs_node *dir;
 
 	dir = mt76_register_debugfs_fops(phy->mt76, NULL);
 	if (!dir)
@@ -1391,7 +1392,8 @@ mt7915_queues_show(struct seq_file *s, void *data)
 DEFINE_SHOW_ATTRIBUTE(mt7915_queues);
 
 void mt7915_sta_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-			    struct ieee80211_sta *sta, struct dentry *dir)
+			    struct ieee80211_sta *sta,
+			    struct debugfs_node *dir)
 {
 	debugfs_create_file("fixed_rate", 0600, dir, sta, &fops_fixed_rate);
 	debugfs_create_file("hw-queues", 0400, dir, sta, &mt7915_queues_fops);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 533939f2b7ed..997cbe60320b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -299,7 +299,7 @@ struct mt7915_dev {
 
 	u8 monitor_mask;
 
-	struct dentry *debugfs_dir;
+	struct debugfs_node *debugfs_dir;
 	struct rchan *relay_fwlog;
 
 	void *cal;
@@ -597,7 +597,8 @@ void mt7915_debugfs_rx_fw_monitor(struct mt7915_dev *dev, const void *data, int
 bool mt7915_debugfs_rx_log(struct mt7915_dev *dev, const void *data, int len);
 #ifdef CONFIG_MAC80211_DEBUGFS
 void mt7915_sta_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-			    struct ieee80211_sta *sta, struct dentry *dir);
+			    struct ieee80211_sta *sta,
+			    struct debugfs_node *dir);
 #endif
 int mt7915_mmio_wed_init(struct mt7915_dev *dev, void *pdev_ptr,
 			 bool pci, int *irq);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
index 616b66a3fde2..30c6aebf76f1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
@@ -263,7 +263,7 @@ mt7921s_sched_quota_read(struct seq_file *s, void *data)
 
 int mt7921_init_debugfs(struct mt792x_dev *dev)
 {
-	struct dentry *dir;
+	struct debugfs_node *dir;
 
 	dir = mt76_register_debugfs_fops(&dev->mphy, &fops_regval);
 	if (!dir)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7925/debugfs.c
index 1e2fc6577e78..c27408181b62 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/debugfs.c
@@ -288,7 +288,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_reset, NULL, mt7925_chip_reset, "%lld\n");
 
 int mt7925_init_debugfs(struct mt792x_dev *dev)
 {
-	struct dentry *dir;
+	struct debugfs_node *dir;
 
 	dir = mt76_register_debugfs_fops(&dev->mphy, &fops_regval);
 	if (!dir)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
index 7b2bb72b407d..e4175914d034 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
@@ -375,11 +375,12 @@ mt7996_fw_debug_wa_get(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(fops_fw_debug_wa, mt7996_fw_debug_wa_get,
 			 mt7996_fw_debug_wa_set, "%lld\n");
 
-static struct dentry *
-create_buf_file_cb(const char *filename, struct dentry *parent, umode_t mode,
+static struct debugfs_node *
+create_buf_file_cb(const char *filename, struct debugfs_node *parent,
+		   umode_t mode,
 		   struct rchan_buf *buf, int *is_global)
 {
-	struct dentry *f;
+	struct debugfs_node *f;
 
 	f = debugfs_create_file("fwlog_data", mode, parent, buf,
 				&relay_file_operations);
@@ -392,7 +393,7 @@ create_buf_file_cb(const char *filename, struct dentry *parent, umode_t mode,
 }
 
 static int
-remove_buf_file_cb(struct dentry *f)
+remove_buf_file_cb(struct debugfs_node *f)
 {
 	debugfs_remove(f);
 
@@ -821,7 +822,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_rf_regval, mt7996_rf_regval_get,
 
 int mt7996_init_debugfs(struct mt7996_dev *dev)
 {
-	struct dentry *dir;
+	struct debugfs_node *dir;
 
 	dir = mt76_register_debugfs_fops(&dev->mphy, NULL);
 	if (!dir)
@@ -998,7 +999,8 @@ mt7996_queues_show(struct seq_file *s, void *data)
 DEFINE_SHOW_ATTRIBUTE(mt7996_queues);
 
 void mt7996_sta_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-			    struct ieee80211_sta *sta, struct dentry *dir)
+			    struct ieee80211_sta *sta,
+			    struct debugfs_node *dir)
 {
 	debugfs_create_file("fixed_rate", 0600, dir, sta, &fops_fixed_rate);
 	debugfs_create_file("hw-queues", 0400, dir, sta, &mt7996_queues_fops);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 29fabb9b04ae..5a73fafbd611 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -371,7 +371,7 @@ struct mt7996_dev {
 	u8 fw_debug_bin;
 	u16 fw_debug_seq;
 
-	struct dentry *debugfs_dir;
+	struct debugfs_node *debugfs_dir;
 	struct rchan *relay_fwlog;
 
 	struct {
@@ -735,7 +735,8 @@ int mt7996_mcu_wtbl_update_hdr_trans(struct mt7996_dev *dev,
 int mt7996_mcu_cp_support(struct mt7996_dev *dev, u8 mode);
 #ifdef CONFIG_MAC80211_DEBUGFS
 void mt7996_sta_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-			    struct ieee80211_sta *sta, struct dentry *dir);
+			    struct ieee80211_sta *sta,
+			    struct debugfs_node *dir);
 #endif
 int mt7996_mmio_wed_init(struct mt7996_dev *dev, void *pdev_ptr,
 			 bool hif2, int *irq);
diff --git a/drivers/net/wireless/mediatek/mt7601u/debugfs.c b/drivers/net/wireless/mediatek/mt7601u/debugfs.c
index dbddf256921b..fd9e3eae6ee4 100644
--- a/drivers/net/wireless/mediatek/mt7601u/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt7601u/debugfs.c
@@ -124,7 +124,7 @@ DEFINE_SHOW_ATTRIBUTE(mt7601u_eeprom_param);
 
 void mt7601u_init_debugfs(struct mt7601u_dev *dev)
 {
-	struct dentry *dir;
+	struct debugfs_node *dir;
 
 	dir = debugfs_create_dir("mt7601u", dev->hw->wiphy->debugfsdir);
 
diff --git a/drivers/net/wireless/quantenna/qtnfmac/bus.h b/drivers/net/wireless/quantenna/qtnfmac/bus.h
index 7f8646e77ee0..e3eb70b1ebb8 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/bus.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/bus.h
@@ -65,7 +65,7 @@ struct qtnf_bus {
 	struct work_struct fw_work;
 	struct work_struct event_work;
 	struct mutex bus_lock; /* lock during command/event processing */
-	struct dentry *dbg_dir;
+	struct debugfs_node *dbg_dir;
 	struct notifier_block netdev_nb;
 	u8 hw_id[ETH_ALEN];
 	/* bus private data */
diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.c b/drivers/net/wireless/quantenna/qtnfmac/core.c
index 825b05dd3271..fdbedc0368b3 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/core.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/core.c
@@ -25,7 +25,7 @@ static bool dfs_offload;
 module_param(dfs_offload, bool, 0644);
 MODULE_PARM_DESC(dfs_offload, "set 1 to enable DFS offload to firmware");
 
-static struct dentry *qtnf_debugfs_dir;
+static struct debugfs_node *qtnf_debugfs_dir;
 
 bool qtnf_slave_radar_get(void)
 {
@@ -903,7 +903,7 @@ void qtnf_wake_all_queues(struct net_device *ndev)
 }
 EXPORT_SYMBOL_GPL(qtnf_wake_all_queues);
 
-struct dentry *qtnf_get_debugfs_dir(void)
+struct debugfs_node *qtnf_get_debugfs_dir(void)
 {
 	return qtnf_debugfs_dir;
 }
diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.h b/drivers/net/wireless/quantenna/qtnfmac/core.h
index a377d85c2451..285e8ebe84f3 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/core.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/core.h
@@ -141,7 +141,7 @@ void qtnf_virtual_intf_cleanup(struct net_device *ndev);
 
 void qtnf_netdev_updown(struct net_device *ndev, bool up);
 void qtnf_scan_done(struct qtnf_wmac *mac, bool aborted);
-struct dentry *qtnf_get_debugfs_dir(void);
+struct debugfs_node *qtnf_get_debugfs_dir(void);
 bool qtnf_netdev_is_qtn(const struct net_device *ndev);
 
 static inline struct qtnf_vif *qtnf_netdev_get_priv(struct net_device *dev)
diff --git a/drivers/net/wireless/quantenna/qtnfmac/debug.c b/drivers/net/wireless/quantenna/qtnfmac/debug.c
index 2d3574c1f10e..4077e656bd82 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/debug.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/debug.c
@@ -5,7 +5,7 @@
 
 void qtnf_debugfs_init(struct qtnf_bus *bus, const char *name)
 {
-	struct dentry *parent = qtnf_get_debugfs_dir();
+	struct debugfs_node *parent = qtnf_get_debugfs_dir();
 
 	bus->dbg_dir = debugfs_create_dir(name, parent);
 }
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00debug.c b/drivers/net/wireless/ralink/rt2x00/rt2x00debug.c
index f2395309ec00..11216fcc59ac 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00debug.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00debug.c
@@ -64,7 +64,7 @@ struct rt2x00debug_intf {
 	 *     - queue stats file
 	 *     - crypto stats file
 	 */
-	struct dentry *driver_folder;
+	struct debugfs_node *driver_folder;
 
 	/*
 	 * The frame dump file only allows a single reader,
@@ -636,8 +636,8 @@ void rt2x00debug_register(struct rt2x00_dev *rt2x00dev)
 {
 	const struct rt2x00debug *debug = rt2x00dev->ops->debugfs;
 	struct rt2x00debug_intf *intf;
-	struct dentry *queue_folder;
-	struct dentry *register_folder;
+	struct debugfs_node *queue_folder;
+	struct debugfs_node *register_folder;
 
 	intf = kzalloc(sizeof(struct rt2x00debug_intf), GFP_KERNEL);
 	if (!intf) {
diff --git a/drivers/net/wireless/realtek/rtlwifi/debug.c b/drivers/net/wireless/realtek/rtlwifi/debug.c
index 9eb26dfe4ca9..0b2286993bf6 100644
--- a/drivers/net/wireless/realtek/rtlwifi/debug.c
+++ b/drivers/net/wireless/realtek/rtlwifi/debug.c
@@ -50,7 +50,7 @@ struct rtl_debugfs_priv {
 	u32 cb_data;
 };
 
-static struct dentry *debugfs_topdir;
+static struct debugfs_node *debugfs_topdir;
 
 static int rtl_debug_get_common(struct seq_file *m, void *v)
 {
diff --git a/drivers/net/wireless/realtek/rtlwifi/wifi.h b/drivers/net/wireless/realtek/rtlwifi/wifi.h
index f1830ddcdd8c..cee57cf09b12 100644
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
+++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -2420,7 +2420,7 @@ struct rtl_works {
 
 struct rtl_debug {
 	/* add for debug */
-	struct dentry *debugfs_dir;
+	struct debugfs_node *debugfs_dir;
 	char debugfs_name[20];
 };
 
diff --git a/drivers/net/wireless/realtek/rtw88/debug.c b/drivers/net/wireless/realtek/rtw88/debug.c
index 364ec0436d0f..b7e5e510deec 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.c
+++ b/drivers/net/wireless/realtek/rtw88/debug.c
@@ -1239,7 +1239,8 @@ static const struct rtw_debugfs rtw_debugfs_templ = {
 	rtw_debugfs_add_core(name, S_IFREG | 0444, single_r, debugfs_topdir)
 
 static
-void rtw_debugfs_add_basic(struct rtw_dev *rtwdev, struct dentry *debugfs_topdir)
+void rtw_debugfs_add_basic(struct rtw_dev *rtwdev,
+			   struct debugfs_node *debugfs_topdir)
 {
 	rtw_debugfs_add_w(write_reg);
 	rtw_debugfs_add_rw(read_reg);
@@ -1261,7 +1262,8 @@ void rtw_debugfs_add_basic(struct rtw_dev *rtwdev, struct dentry *debugfs_topdir
 }
 
 static
-void rtw_debugfs_add_sec0(struct rtw_dev *rtwdev, struct dentry *debugfs_topdir)
+void rtw_debugfs_add_sec0(struct rtw_dev *rtwdev,
+			  struct debugfs_node *debugfs_topdir)
 {
 	rtw_debugfs_add_r(mac_0);
 	rtw_debugfs_add_r(mac_1);
@@ -1282,7 +1284,8 @@ void rtw_debugfs_add_sec0(struct rtw_dev *rtwdev, struct dentry *debugfs_topdir)
 }
 
 static
-void rtw_debugfs_add_sec1(struct rtw_dev *rtwdev, struct dentry *debugfs_topdir)
+void rtw_debugfs_add_sec1(struct rtw_dev *rtwdev,
+			  struct debugfs_node *debugfs_topdir)
 {
 	rtw_debugfs_add_r(mac_10);
 	rtw_debugfs_add_r(mac_11);
@@ -1310,7 +1313,7 @@ void rtw_debugfs_add_sec1(struct rtw_dev *rtwdev, struct dentry *debugfs_topdir)
 
 void rtw_debugfs_init(struct rtw_dev *rtwdev)
 {
-	struct dentry *debugfs_topdir;
+	struct debugfs_node *debugfs_topdir;
 
 	rtwdev->debugfs = kmemdup(&rtw_debugfs_templ, sizeof(rtw_debugfs_templ),
 				  GFP_KERNEL);
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 09fa977a6e6d..81eb0ad651ff 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -4004,7 +4004,8 @@ static const struct rtw89_debugfs rtw89_debugfs_templ = {
 	rtw89_debugfs_add(name, S_IFREG | 0444, single_r, debugfs_topdir)
 
 static
-void rtw89_debugfs_add_sec0(struct rtw89_dev *rtwdev, struct dentry *debugfs_topdir)
+void rtw89_debugfs_add_sec0(struct rtw89_dev *rtwdev,
+			    struct debugfs_node *debugfs_topdir)
 {
 	rtw89_debugfs_add_rw(read_reg);
 	rtw89_debugfs_add_w(write_reg);
@@ -4018,7 +4019,8 @@ void rtw89_debugfs_add_sec0(struct rtw89_dev *rtwdev, struct dentry *debugfs_top
 }
 
 static
-void rtw89_debugfs_add_sec1(struct rtw89_dev *rtwdev, struct dentry *debugfs_topdir)
+void rtw89_debugfs_add_sec1(struct rtw89_dev *rtwdev,
+			    struct debugfs_node *debugfs_topdir)
 {
 	rtw89_debugfs_add_w(send_h2c);
 	rtw89_debugfs_add_rw(early_h2c);
@@ -4033,7 +4035,7 @@ void rtw89_debugfs_add_sec1(struct rtw89_dev *rtwdev, struct dentry *debugfs_top
 
 void rtw89_debugfs_init(struct rtw89_dev *rtwdev)
 {
-	struct dentry *debugfs_topdir;
+	struct debugfs_node *debugfs_topdir;
 
 	rtwdev->debugfs = kmemdup(&rtw89_debugfs_templ,
 				  sizeof(rtw89_debugfs_templ), GFP_KERNEL);
diff --git a/drivers/net/wireless/rsi/rsi_debugfs.h b/drivers/net/wireless/rsi/rsi_debugfs.h
index bbc1200dbb62..e24f0e6a22b0 100644
--- a/drivers/net/wireless/rsi/rsi_debugfs.h
+++ b/drivers/net/wireless/rsi/rsi_debugfs.h
@@ -38,7 +38,7 @@ struct rsi_dbg_files {
 };
 
 struct rsi_debugfs {
-	struct dentry *subdir;
+	struct debugfs_node *subdir;
 	struct dentry *rsi_files[MAX_DEBUGFS_ENTRIES];
 };
 int rsi_init_dbgfs(struct rsi_hw *adapter);
diff --git a/drivers/net/wireless/silabs/wfx/debug.c b/drivers/net/wireless/silabs/wfx/debug.c
index e8265208f9a5..1bc7ef567fa8 100644
--- a/drivers/net/wireless/silabs/wfx/debug.c
+++ b/drivers/net/wireless/silabs/wfx/debug.c
@@ -318,7 +318,7 @@ static const struct file_operations wfx_send_hif_msg_fops = {
 
 int wfx_debug_init(struct wfx_dev *wdev)
 {
-	struct dentry *d;
+	struct debugfs_node *d;
 
 	d = debugfs_create_dir("wfx", wdev->hw->wiphy->debugfsdir);
 	debugfs_create_file("counters", 0444, d, wdev, &wfx_counters_fops);
diff --git a/drivers/net/wireless/st/cw1200/debug.h b/drivers/net/wireless/st/cw1200/debug.h
index 80bc1567533a..a24b015e7c36 100644
--- a/drivers/net/wireless/st/cw1200/debug.h
+++ b/drivers/net/wireless/st/cw1200/debug.h
@@ -10,7 +10,7 @@
 #define CW1200_DEBUG_H_INCLUDED
 
 struct cw1200_debug_priv {
-	struct dentry *debugfs_phy;
+	struct debugfs_node *debugfs_phy;
 	int tx;
 	int tx_agg;
 	int rx;
diff --git a/drivers/net/wireless/ti/wl1251/wl1251.h b/drivers/net/wireless/ti/wl1251/wl1251.h
index 83adbc3c25dc..7f108d6809ea 100644
--- a/drivers/net/wireless/ti/wl1251/wl1251.h
+++ b/drivers/net/wireless/ti/wl1251/wl1251.h
@@ -143,8 +143,8 @@ struct wl1251_stats {
 };
 
 struct wl1251_debugfs {
-	struct dentry *rootdir;
-	struct dentry *fw_statistics;
+	struct debugfs_node *rootdir;
+	struct debugfs_node *fw_statistics;
 
 	struct dentry *tx_internal_desc_overflow;
 
diff --git a/drivers/net/wireless/ti/wl12xx/debugfs.c b/drivers/net/wireless/ti/wl12xx/debugfs.c
index 7847463d4cf9..d20e928b42e3 100644
--- a/drivers/net/wireless/ti/wl12xx/debugfs.c
+++ b/drivers/net/wireless/ti/wl12xx/debugfs.c
@@ -109,9 +109,9 @@ WL12XX_DEBUGFS_FWSTATS_FILE(rxpipe, missed_beacon_host_int_trig_rx_data, "%u");
 WL12XX_DEBUGFS_FWSTATS_FILE(rxpipe, tx_xfr_host_int_trig_rx_data, "%u");
 
 int wl12xx_debugfs_add_files(struct wl1271 *wl,
-			     struct dentry *rootdir)
+			     struct debugfs_node *rootdir)
 {
-	struct dentry *stats, *moddir;
+	struct debugfs_node *stats, *moddir;
 
 	moddir = debugfs_create_dir(KBUILD_MODNAME, rootdir);
 	stats = debugfs_create_dir("fw_stats", moddir);
diff --git a/drivers/net/wireless/ti/wl12xx/debugfs.h b/drivers/net/wireless/ti/wl12xx/debugfs.h
index 9dbdd7ee3114..38bbf34c0edf 100644
--- a/drivers/net/wireless/ti/wl12xx/debugfs.h
+++ b/drivers/net/wireless/ti/wl12xx/debugfs.h
@@ -9,6 +9,6 @@
 #define __WL12XX_DEBUGFS_H__
 
 int wl12xx_debugfs_add_files(struct wl1271 *wl,
-			     struct dentry *rootdir);
+			     struct debugfs_node *rootdir);
 
 #endif /* __WL12XX_DEBUGFS_H__ */
diff --git a/drivers/net/wireless/ti/wl18xx/debugfs.c b/drivers/net/wireless/ti/wl18xx/debugfs.c
index 80fbf740fe6d..17ce2987b8e6 100644
--- a/drivers/net/wireless/ti/wl18xx/debugfs.c
+++ b/drivers/net/wireless/ti/wl18xx/debugfs.c
@@ -400,9 +400,9 @@ static const struct file_operations radar_debug_mode_ops = {
 #endif /* CFG80211_CERTIFICATION_ONUS */
 
 int wl18xx_debugfs_add_files(struct wl1271 *wl,
-			     struct dentry *rootdir)
+			     struct debugfs_node *rootdir)
 {
-	struct dentry *stats, *moddir;
+	struct debugfs_node *stats, *moddir;
 
 	moddir = debugfs_create_dir(KBUILD_MODNAME, rootdir);
 	stats = debugfs_create_dir("fw_stats", moddir);
diff --git a/drivers/net/wireless/ti/wl18xx/debugfs.h b/drivers/net/wireless/ti/wl18xx/debugfs.h
index 0169ff1a130a..2585c9bff7b7 100644
--- a/drivers/net/wireless/ti/wl18xx/debugfs.h
+++ b/drivers/net/wireless/ti/wl18xx/debugfs.h
@@ -9,6 +9,6 @@
 #define __WL18XX_DEBUGFS_H__
 
 int wl18xx_debugfs_add_files(struct wl1271 *wl,
-			     struct dentry *rootdir);
+			     struct debugfs_node *rootdir);
 
 #endif /* __WL18XX_DEBUGFS_H__ */
diff --git a/drivers/net/wireless/ti/wlcore/debugfs.c b/drivers/net/wireless/ti/wlcore/debugfs.c
index eb3d3f0e0b4d..4f8174baffaf 100644
--- a/drivers/net/wireless/ti/wlcore/debugfs.c
+++ b/drivers/net/wireless/ti/wlcore/debugfs.c
@@ -1263,9 +1263,9 @@ static const struct file_operations fw_logger_ops = {
 };
 
 static void wl1271_debugfs_add_files(struct wl1271 *wl,
-				     struct dentry *rootdir)
+				     struct debugfs_node *rootdir)
 {
-	struct dentry *streaming;
+	struct debugfs_node *streaming;
 
 	DEBUGFS_ADD(tx_queue_len, rootdir);
 	DEBUGFS_ADD(retry_count, rootdir);
@@ -1310,7 +1310,7 @@ void wl1271_debugfs_reset(struct wl1271 *wl)
 int wl1271_debugfs_init(struct wl1271 *wl)
 {
 	int ret;
-	struct dentry *rootdir;
+	struct debugfs_node *rootdir;
 
 	rootdir = debugfs_create_dir(KBUILD_MODNAME,
 				     wl->hw->wiphy->debugfsdir);
diff --git a/drivers/net/wireless/ti/wlcore/hw_ops.h b/drivers/net/wireless/ti/wlcore/hw_ops.h
index 0cd872307526..4208b2bfd920 100644
--- a/drivers/net/wireless/ti/wlcore/hw_ops.h
+++ b/drivers/net/wireless/ti/wlcore/hw_ops.h
@@ -149,7 +149,7 @@ wlcore_hw_ap_get_mimo_wide_rate_mask(struct wl1271 *wl,
 }
 
 static inline int
-wlcore_debugfs_init(struct wl1271 *wl, struct dentry *rootdir)
+wlcore_debugfs_init(struct wl1271 *wl, struct debugfs_node *rootdir)
 {
 	if (wl->ops->debugfs_init)
 		return wl->ops->debugfs_init(wl, rootdir);
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index cf6a331d4042..f8cebeed12d7 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -713,7 +713,7 @@ struct mac80211_hwsim_data {
 		PS_DISABLED, PS_ENABLED, PS_AUTO_POLL, PS_MANUAL_POLL
 	} ps;
 	bool ps_poll_pending;
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 
 	atomic_t pending_cookie;
 	struct sk_buff_head pending;	/* packets pending */
@@ -2149,7 +2149,7 @@ static void
 mac80211_hwsim_link_add_debugfs(struct ieee80211_hw *hw,
 				struct ieee80211_vif *vif,
 				struct ieee80211_bss_conf *link_conf,
-				struct dentry *dir)
+				struct debugfs_node *dir)
 {
 	struct hwsim_vif_priv *vp = (void *)vif->drv_priv;
 
diff --git a/drivers/net/wwan/iosm/iosm_ipc_imem.h b/drivers/net/wwan/iosm/iosm_ipc_imem.h
index 5664ac507c90..b3b77dc46fb9 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_imem.h
+++ b/drivers/net/wwan/iosm/iosm_ipc_imem.h
@@ -372,8 +372,8 @@ struct iosm_imem {
 	   reset_det_n:1,
 	   pcie_wake_n:1;
 #ifdef CONFIG_WWAN_DEBUGFS
-	struct dentry *debugfs_wwan_dir;
-	struct dentry *debugfs_dir;
+	struct debugfs_node *debugfs_wwan_dir;
+	struct debugfs_node *debugfs_dir;
 #endif
 };
 
diff --git a/drivers/net/wwan/iosm/iosm_ipc_trace.c b/drivers/net/wwan/iosm/iosm_ipc_trace.c
index eeecfa3d10c5..e9bc05d7e46d 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_trace.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_trace.c
@@ -31,9 +31,9 @@ void ipc_trace_port_rx(struct iosm_imem *ipc_imem, struct sk_buff *skb)
 }
 
 /* Creates relay file in debugfs. */
-static struct dentry *
+static struct debugfs_node *
 ipc_trace_create_buf_file_handler(const char *filename,
-				  struct dentry *parent,
+				  struct debugfs_node *parent,
 				  umode_t mode,
 				  struct rchan_buf *buf,
 				  int *is_global)
@@ -44,7 +44,7 @@ ipc_trace_create_buf_file_handler(const char *filename,
 }
 
 /* Removes relay file from debugfs. */
-static int ipc_trace_remove_buf_file_handler(struct dentry *dentry)
+static int ipc_trace_remove_buf_file_handler(struct debugfs_node *dentry)
 {
 	debugfs_remove(dentry);
 	return 0;
diff --git a/drivers/net/wwan/iosm/iosm_ipc_trace.h b/drivers/net/wwan/iosm/iosm_ipc_trace.h
index 3e7c7f163e1d..55fa52a5d74e 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_trace.h
+++ b/drivers/net/wwan/iosm/iosm_ipc_trace.h
@@ -36,7 +36,7 @@ enum trace_ctrl_mode {
 
 struct iosm_trace {
 	struct rchan *ipc_rchan;
-	struct dentry *ctrl_file;
+	struct debugfs_node *ctrl_file;
 	struct iosm_imem *ipc_imem;
 	struct device *dev;
 	struct ipc_mem_channel *channel;
diff --git a/drivers/net/wwan/t7xx/t7xx_pci.h b/drivers/net/wwan/t7xx/t7xx_pci.h
index b25d867e72d2..14e26d01d768 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.h
+++ b/drivers/net/wwan/t7xx/t7xx_pci.h
@@ -91,7 +91,7 @@ struct t7xx_pci_dev {
 	unsigned int		sleep_disable_count;
 	struct completion	sleep_lock_acquire;
 #ifdef CONFIG_WWAN_DEBUGFS
-	struct dentry		*debugfs_dir;
+	struct debugfs_node *debugfs_dir;
 #endif
 	u32			mode;
 	bool			debug_ports_show;
diff --git a/drivers/net/wwan/t7xx/t7xx_port_trace.c b/drivers/net/wwan/t7xx/t7xx_port_trace.c
index 4ed8b4e29bf1..98cdceeb6048 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_trace.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_trace.c
@@ -15,8 +15,8 @@
 #define T7XX_TRC_SUB_BUFF_SIZE		131072
 #define T7XX_TRC_N_SUB_BUFF		32
 
-static struct dentry *t7xx_trace_create_buf_file_handler(const char *filename,
-							 struct dentry *parent,
+static struct debugfs_node *t7xx_trace_create_buf_file_handler(const char *filename,
+							 struct debugfs_node *parent,
 							 umode_t mode,
 							 struct rchan_buf *buf,
 							 int *is_global)
@@ -26,7 +26,7 @@ static struct dentry *t7xx_trace_create_buf_file_handler(const char *filename,
 				   &relay_file_operations);
 }
 
-static int t7xx_trace_remove_buf_file_handler(struct dentry *dentry)
+static int t7xx_trace_remove_buf_file_handler(struct debugfs_node *dentry)
 {
 	debugfs_remove(dentry);
 	return 0;
@@ -51,7 +51,7 @@ static struct rchan_callbacks relay_callbacks = {
 
 static void t7xx_trace_port_uninit(struct t7xx_port *port)
 {
-	struct dentry *debugfs_dir = port->t7xx_dev->debugfs_dir;
+	struct debugfs_node *debugfs_dir = port->t7xx_dev->debugfs_dir;
 	struct rchan *relaych = port->log.relaych;
 
 	if (!relaych)
@@ -77,8 +77,8 @@ static int t7xx_trace_port_recv_skb(struct t7xx_port *port, struct sk_buff *skb)
 static void t7xx_port_trace_md_state_notify(struct t7xx_port *port, unsigned int state)
 {
 	struct rchan *relaych = port->log.relaych;
-	struct dentry *debugfs_wwan_dir;
-	struct dentry *debugfs_dir;
+	struct debugfs_node *debugfs_wwan_dir;
+	struct debugfs_node *debugfs_dir;
 
 	if (state != MD_STATE_READY || relaych)
 		return;
diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index a51e2755991a..6ac8cd01d3f5 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -30,7 +30,7 @@ static const struct class wwan_class = {
 	.name = "wwan",
 };
 static int wwan_major;
-static struct dentry *wwan_debugfs_dir;
+static struct debugfs_node *wwan_debugfs_dir;
 
 #define to_wwan_dev(d) container_of(d, struct wwan_device, dev)
 #define to_wwan_port(d) container_of(d, struct wwan_port, dev)
@@ -55,7 +55,7 @@ struct wwan_device {
 	const struct wwan_ops *ops;
 	void *ops_ctxt;
 #ifdef CONFIG_WWAN_DEBUGFS
-	struct dentry *debugfs_dir;
+	struct debugfs_node *debugfs_dir;
 #endif
 };
 
@@ -157,7 +157,7 @@ static struct wwan_device *wwan_dev_get_by_name(const char *name)
 }
 
 #ifdef CONFIG_WWAN_DEBUGFS
-struct dentry *wwan_get_debugfs_dir(struct device *parent)
+struct debugfs_node *wwan_get_debugfs_dir(struct device *parent)
 {
 	struct wwan_device *wwandev;
 
@@ -181,7 +181,7 @@ static int wwan_dev_debugfs_match(struct device *dev, const void *dir)
 	return wwandev->debugfs_dir == dir;
 }
 
-static struct wwan_device *wwan_dev_get_by_debugfs(struct dentry *dir)
+static struct wwan_device *wwan_dev_get_by_debugfs(struct debugfs_node *dir)
 {
 	struct device *dev;
 
@@ -192,7 +192,7 @@ static struct wwan_device *wwan_dev_get_by_debugfs(struct dentry *dir)
 	return to_wwan_dev(dev);
 }
 
-void wwan_put_debugfs_dir(struct dentry *dir)
+void wwan_put_debugfs_dir(struct debugfs_node *dir)
 {
 	struct wwan_device *wwandev = wwan_dev_get_by_debugfs(dir);
 
diff --git a/drivers/net/wwan/wwan_hwsim.c b/drivers/net/wwan/wwan_hwsim.c
index b02befd1b6fb..ca19b4b5fc17 100644
--- a/drivers/net/wwan/wwan_hwsim.c
+++ b/drivers/net/wwan/wwan_hwsim.c
@@ -29,8 +29,8 @@ static const struct class wwan_hwsim_class = {
 	.name = "wwan_hwsim",
 };
 
-static struct dentry *wwan_hwsim_debugfs_topdir;
-static struct dentry *wwan_hwsim_debugfs_devcreate;
+static struct debugfs_node *wwan_hwsim_debugfs_topdir;
+static struct debugfs_node *wwan_hwsim_debugfs_devcreate;
 
 static DEFINE_SPINLOCK(wwan_hwsim_devs_lock);
 static LIST_HEAD(wwan_hwsim_devs);
@@ -42,8 +42,8 @@ struct wwan_hwsim_dev {
 	unsigned int id;
 	struct device dev;
 	struct work_struct del_work;
-	struct dentry *debugfs_topdir;
-	struct dentry *debugfs_portcreate;
+	struct debugfs_node *debugfs_topdir;
+	struct debugfs_node *debugfs_portcreate;
 	spinlock_t ports_lock;	/* Serialize ports creation/deletion */
 	unsigned int port_idx;
 	struct list_head ports;
@@ -55,7 +55,7 @@ struct wwan_hwsim_port {
 	struct wwan_hwsim_dev *dev;
 	struct wwan_port *wwan;
 	struct work_struct del_work;
-	struct dentry *debugfs_topdir;
+	struct debugfs_node *debugfs_topdir;
 	enum {			/* AT command parser state */
 		AT_PARSER_WAIT_A,
 		AT_PARSER_WAIT_T,
diff --git a/drivers/net/xen-netback/common.h b/drivers/net/xen-netback/common.h
index 17421da139f2..4cde0f19f9dc 100644
--- a/drivers/net/xen-netback/common.h
+++ b/drivers/net/xen-netback/common.h
@@ -319,7 +319,7 @@ struct xenvif {
 	spinlock_t lock;
 
 #ifdef CONFIG_DEBUG_FS
-	struct dentry *xenvif_dbg_root;
+	struct debugfs_node *xenvif_dbg_root;
 #endif
 
 	struct xen_netif_ctrl_back_ring ctrl;
@@ -410,7 +410,7 @@ extern unsigned int xenvif_max_queues;
 extern unsigned int xenvif_hash_cache_size;
 
 #ifdef CONFIG_DEBUG_FS
-extern struct dentry *xen_netback_dbg_root;
+extern struct debugfs_node *xen_netback_dbg_root;
 #endif
 
 void xenvif_skb_zerocopy_prepare(struct xenvif_queue *queue,
diff --git a/drivers/net/xen-netback/xenbus.c b/drivers/net/xen-netback/xenbus.c
index a78a25b87240..820660bab230 100644
--- a/drivers/net/xen-netback/xenbus.c
+++ b/drivers/net/xen-netback/xenbus.c
@@ -21,7 +21,7 @@ static void set_backend_state(struct backend_info *be,
 			      enum xenbus_state state);
 
 #ifdef CONFIG_DEBUG_FS
-struct dentry *xen_netback_dbg_root = NULL;
+struct debugfs_node *xen_netback_dbg_root = NULL;
 
 static int xenvif_read_io_ring(struct seq_file *m, void *v)
 {
diff --git a/drivers/nfc/nfcsim.c b/drivers/nfc/nfcsim.c
index a55381f80cd6..1f50d305f50f 100644
--- a/drivers/nfc/nfcsim.c
+++ b/drivers/nfc/nfcsim.c
@@ -331,7 +331,7 @@ static const struct nfc_digital_ops nfcsim_digital_ops = {
 	.switch_rf = nfcsim_switch_rf,
 };
 
-static struct dentry *nfcsim_debugfs_root;
+static struct debugfs_node *nfcsim_debugfs_root;
 
 static void nfcsim_debugfs_init(void)
 {
@@ -345,7 +345,7 @@ static void nfcsim_debugfs_remove(void)
 
 static void nfcsim_debugfs_init_dev(struct nfcsim *dev)
 {
-	struct dentry *dev_dir;
+	struct debugfs_node *dev_dir;
 	char devname[5]; /* nfcX\0 */
 	u32 idx;
 	int n;
diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index d687e8c2cc78..4238e2a6d25e 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -71,7 +71,7 @@ MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("AMD Inc.");
 
 static const struct file_operations amd_ntb_debugfs_info;
-static struct dentry *debugfs_dir;
+static struct debugfs_node *debugfs_dir;
 
 static int ndev_mw_to_bar(struct amd_ntb_dev *ndev, int idx)
 {
diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.h b/drivers/ntb/hw/amd/ntb_hw_amd.h
index 5f337b1572a0..e64538da3498 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.h
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.h
@@ -209,8 +209,8 @@ struct amd_ntb_dev {
 
 	struct delayed_work hb_timer;
 
-	struct dentry *debugfs_dir;
-	struct dentry *debugfs_info;
+	struct debugfs_node *debugfs_dir;
+	struct debugfs_node *debugfs_info;
 };
 
 #define ntb_ndev(__ntb) container_of(__ntb, struct amd_ntb_dev, ntb)
diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index 544d8a4d2af5..8be5947afdf1 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -271,7 +271,7 @@ static const struct idt_ntb_part partdata_tbl[IDT_MAX_NR_PARTS] = {
 /*
  * DebugFS directory to place the driver debug file
  */
-static struct dentry *dbgfs_topdir;
+static struct debugfs_node *dbgfs_topdir;
 
 /*=============================================================================
  *                1. IDT PCIe-switch registers IO-functions
diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.h b/drivers/ntb/hw/idt/ntb_hw_idt.h
index 2f1aa121b0cf..bcdaa5bc0ed3 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.h
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.h
@@ -1148,7 +1148,7 @@ struct idt_ntb_dev {
 
 	struct mutex hwmon_mtx;
 
-	struct dentry *dbgfs_info;
+	struct debugfs_node *dbgfs_info;
 };
 #define to_ndev_ntb(__ntb) container_of(__ntb, struct idt_ntb_dev, ntb)
 
diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.c b/drivers/ntb/hw/intel/ntb_hw_gen1.c
index 079b8cd79785..2f932375bf3f 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen1.c
+++ b/drivers/ntb/hw/intel/ntb_hw_gen1.c
@@ -83,7 +83,7 @@ static const struct intel_ntb_xlat_reg xeon_sec_xlat;
 static const struct ntb_dev_ops intel_ntb_ops;
 
 static const struct file_operations intel_ntb_debugfs_info;
-static struct dentry *debugfs_dir;
+static struct debugfs_node *debugfs_dir;
 
 static int b2b_mw_idx = -1;
 module_param(b2b_mw_idx, int, 0644);
diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.h b/drivers/ntb/hw/intel/ntb_hw_intel.h
index da4d5fe55bab..ef8160325ff3 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.h
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.h
@@ -180,8 +180,8 @@ struct intel_ntb_dev {
 	unsigned long			unsafe_flags;
 	unsigned long			unsafe_flags_ignore;
 
-	struct dentry			*debugfs_dir;
-	struct dentry			*debugfs_info;
+	struct debugfs_node *debugfs_dir;
+	struct debugfs_node *debugfs_info;
 
 	/* gen4 entries */
 	int				dev_up;
diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index a22ea4a4b202..a218ce12fb57 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -99,7 +99,7 @@ module_param(use_msi, bool, 0644);
 MODULE_PARM_DESC(use_msi, "Use MSI interrupts instead of doorbells");
 #endif
 
-static struct dentry *nt_debugfs_dir;
+static struct debugfs_node *nt_debugfs_dir;
 
 /* Only two-ports NTB devices are supported */
 #define PIDX		NTB_DEF_PEER_IDX
@@ -176,8 +176,8 @@ struct ntb_transport_qp {
 	struct delayed_work link_work;
 	struct work_struct link_cleanup;
 
-	struct dentry *debugfs_dir;
-	struct dentry *debugfs_stats;
+	struct debugfs_node *debugfs_dir;
+	struct debugfs_node *debugfs_stats;
 
 	/* Stats */
 	u64 rx_bytes;
@@ -240,7 +240,7 @@ struct ntb_transport_ctx {
 	struct delayed_work link_work;
 	struct work_struct link_cleanup;
 
-	struct dentry *debugfs_node_dir;
+	struct debugfs_node *debugfs_node_dir;
 };
 
 enum {
diff --git a/drivers/ntb/test/ntb_msi_test.c b/drivers/ntb/test/ntb_msi_test.c
index 4e18e08776c9..52da29464e14 100644
--- a/drivers/ntb/test/ntb_msi_test.c
+++ b/drivers/ntb/test/ntb_msi_test.c
@@ -18,7 +18,7 @@ MODULE_PARM_DESC(num_irqs, "number of irqs to use");
 
 struct ntb_msit_ctx {
 	struct ntb_dev *ntb;
-	struct dentry *dbgfs_dir;
+	struct debugfs_node *dbgfs_dir;
 	struct work_struct setup_work;
 
 	struct ntb_msit_isr_ctx {
@@ -38,7 +38,7 @@ struct ntb_msit_ctx {
 	} peers[];
 };
 
-static struct dentry *ntb_msit_dbgfs_topdir;
+static struct debugfs_node *ntb_msit_dbgfs_topdir;
 
 static irqreturn_t ntb_msit_isr(int irq, void *dev)
 {
@@ -272,7 +272,7 @@ static void ntb_msit_create_dbgfs(struct ntb_msit_ctx *nm)
 	struct pci_dev *pdev = nm->ntb->pdev;
 	char buf[32];
 	int i;
-	struct dentry *peer_dir;
+	struct debugfs_node *peer_dir;
 
 	nm->dbgfs_dir = debugfs_create_dir(pci_name(pdev),
 					   ntb_msit_dbgfs_topdir);
diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 72bc1d017a46..8fe4ee2ae0c0 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -205,7 +205,7 @@ struct perf_ctx {
 	int (*cmd_recv)(struct perf_ctx *perf, int *pidx, enum perf_cmd *cmd,
 			u64 *data);
 
-	struct dentry *dbgfs_dir;
+	struct debugfs_node *dbgfs_dir;
 };
 
 /*
@@ -235,7 +235,7 @@ struct perf_ctx {
  *==============================================================================
  */
 
-static struct dentry *perf_dbgfs_topdir;
+static struct debugfs_node *perf_dbgfs_topdir;
 
 static struct workqueue_struct *perf_wq __read_mostly;
 
diff --git a/drivers/ntb/test/ntb_pingpong.c b/drivers/ntb/test/ntb_pingpong.c
index 8aeca7914050..8439c5a8ed83 100644
--- a/drivers/ntb/test/ntb_pingpong.c
+++ b/drivers/ntb/test/ntb_pingpong.c
@@ -106,12 +106,12 @@ struct pp_ctx {
 	u64 pmask;
 	atomic_t count;
 	spinlock_t lock;
-	struct dentry *dbgfs_dir;
+	struct debugfs_node *dbgfs_dir;
 };
 #define to_pp_timer(__timer) \
 	container_of(__timer, struct pp_ctx, timer)
 
-static struct dentry *pp_dbgfs_topdir;
+static struct debugfs_node *pp_dbgfs_topdir;
 
 static int pp_find_next_peer(struct pp_ctx *pp)
 {
diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
index 641cb7e05a47..948a3f6a5072 100644
--- a/drivers/ntb/test/ntb_tool.c
+++ b/drivers/ntb/test/ntb_tool.c
@@ -215,7 +215,7 @@ struct tool_mw {
 		u64 tr_base;
 	};
 	resource_size_t size;
-	struct dentry *dbgfs_file;
+	struct debugfs_node *dbgfs_file;
 };
 
 /*
@@ -250,7 +250,7 @@ struct tool_peer {
 	struct tool_msg *outmsgs;
 	int outspad_cnt;
 	struct tool_spad *outspads;
-	struct dentry *dbgfs_dir;
+	struct debugfs_node *dbgfs_dir;
 };
 
 struct tool_ctx {
@@ -266,7 +266,7 @@ struct tool_ctx {
 	struct tool_msg *inmsgs;
 	int inspad_cnt;
 	struct tool_spad *inspads;
-	struct dentry *dbgfs_dir;
+	struct debugfs_node *dbgfs_dir;
 };
 
 #define TOOL_FOPS_RDWR(__name, __read, __write) \
@@ -279,7 +279,7 @@ struct tool_ctx {
 
 #define TOOL_BUF_LEN 32
 
-static struct dentry *tool_dbgfs_topdir;
+static struct debugfs_node *tool_dbgfs_topdir;
 
 /*==============================================================================
  *                               NTB events handlers
diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index 423dcd190906..c1e938f71cca 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -213,13 +213,14 @@ static int btt_log_group_read(struct arena_info *arena, u32 lane,
 			LOG_GRP_SIZE, 0);
 }
 
-static struct dentry *debugfs_root;
+static struct debugfs_node *debugfs_root;
 
-static void arena_debugfs_init(struct arena_info *a, struct dentry *parent,
+static void arena_debugfs_init(struct arena_info *a,
+				struct debugfs_node *parent,
 				int idx)
 {
 	char dirname[32];
-	struct dentry *d;
+	struct debugfs_node *d;
 
 	/* If for some reason, parent bttN was not created, exit */
 	if (!parent)
diff --git a/drivers/nvdimm/btt.h b/drivers/nvdimm/btt.h
index 0c76c0333f6e..b45f0a14359d 100644
--- a/drivers/nvdimm/btt.h
+++ b/drivers/nvdimm/btt.h
@@ -189,7 +189,7 @@ struct arena_info {
 	struct aligned_lock *map_locks;
 	struct nd_btt *nd_btt;
 	struct list_head list;
-	struct dentry *debugfs_dir;
+	struct debugfs_node *debugfs_dir;
 	/* Arena flags */
 	u32 flags;
 	struct mutex err_lock;
@@ -219,7 +219,7 @@ struct badblocks;
 struct btt {
 	struct gendisk *btt_disk;
 	struct list_head arena_list;
-	struct dentry *debugfs_dir;
+	struct debugfs_node *debugfs_dir;
 	struct nd_btt *nd_btt;
 	u64 nlba;
 	unsigned long long rawsize;
diff --git a/drivers/nvme/host/fault_inject.c b/drivers/nvme/host/fault_inject.c
index 105d6cb41c72..428e16543c62 100644
--- a/drivers/nvme/host/fault_inject.c
+++ b/drivers/nvme/host/fault_inject.c
@@ -19,7 +19,7 @@ module_param(fail_request, charp, 0000);
 void nvme_fault_inject_init(struct nvme_fault_inject *fault_inj,
 			    const char *dev_name)
 {
-	struct dentry *dir, *parent;
+	struct debugfs_node *dir, *parent;
 	struct fault_attr *attr = &fault_inj->attr;
 
 	/* set default fault injection attribute */
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 7be92d07430e..f432f0ac5457 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -261,7 +261,7 @@ enum nvme_ctrl_state {
 struct nvme_fault_inject {
 #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
 	struct fault_attr attr;
-	struct dentry *parent;
+	struct debugfs_node *parent;
 	bool dont_retry;	/* DNR, do not retry */
 	u16 status;		/* status code */
 #endif
diff --git a/drivers/nvme/target/debugfs.c b/drivers/nvme/target/debugfs.c
index 220c7391fc19..ce1c8b250c0f 100644
--- a/drivers/nvme/target/debugfs.c
+++ b/drivers/nvme/target/debugfs.c
@@ -13,7 +13,7 @@
 #include "nvmet.h"
 #include "debugfs.h"
 
-static struct dentry *nvmet_debugfs;
+static struct debugfs_node *nvmet_debugfs;
 
 #define NVMET_DEBUGFS_ATTR(field) \
 	static int field##_open(struct inode *inode, struct file *file) \
@@ -135,7 +135,7 @@ NVMET_DEBUGFS_ATTR(nvmet_ctrl_host_traddr);
 int nvmet_debugfs_ctrl_setup(struct nvmet_ctrl *ctrl)
 {
 	char name[32];
-	struct dentry *parent = ctrl->subsys->debugfs_dir;
+	struct debugfs_node *parent = ctrl->subsys->debugfs_dir;
 	int ret;
 
 	if (!parent)
@@ -185,7 +185,7 @@ void nvmet_debugfs_subsys_free(struct nvmet_subsys *subsys)
 
 int __init nvmet_init_debugfs(void)
 {
-	struct dentry *parent;
+	struct debugfs_node *parent;
 
 	parent = debugfs_create_dir("nvmet", NULL);
 	if (IS_ERR(parent)) {
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 4be8d22d2d8d..e9802c4fd575 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -283,7 +283,7 @@ struct nvmet_ctrl {
 	struct device		*p2p_client;
 	struct radix_tree_root	p2p_ns_map;
 #ifdef CONFIG_NVME_TARGET_DEBUGFS
-	struct dentry		*debugfs_dir;
+	struct debugfs_node *debugfs_dir;
 #endif
 	spinlock_t		error_lock;
 	u64			err_counter;
@@ -318,7 +318,7 @@ struct nvmet_subsys {
 	struct list_head	hosts;
 	bool			allow_any_host;
 #ifdef CONFIG_NVME_TARGET_DEBUGFS
-	struct dentry		*debugfs_dir;
+	struct debugfs_node *debugfs_dir;
 #endif
 	u16			max_qid;
 
diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
index 8fc6238b1728..77f8039b590c 100644
--- a/drivers/opp/debugfs.c
+++ b/drivers/opp/debugfs.c
@@ -17,7 +17,7 @@
 
 #include "opp.h"
 
-static struct dentry *rootdir;
+static struct debugfs_node *rootdir;
 
 static void opp_set_dev_name(const struct device *dev, char *name)
 {
@@ -55,9 +55,9 @@ static const struct file_operations bw_name_fops = {
 
 static void opp_debug_create_bw(struct dev_pm_opp *opp,
 				struct opp_table *opp_table,
-				struct dentry *pdentry)
+				struct debugfs_node *pdentry)
 {
-	struct dentry *d;
+	struct debugfs_node *d;
 	char name[] = "icc-path-XXXXXXXXXXX"; /* Integers can take 11 chars max */
 	int i;
 
@@ -78,7 +78,7 @@ static void opp_debug_create_bw(struct dev_pm_opp *opp,
 
 static void opp_debug_create_clks(struct dev_pm_opp *opp,
 				  struct opp_table *opp_table,
-				  struct dentry *pdentry)
+				  struct debugfs_node *pdentry)
 {
 	char name[] = "rate_hz_XXXXXXXXXXX"; /* Integers can take 11 chars max */
 	int i;
@@ -96,9 +96,9 @@ static void opp_debug_create_clks(struct dev_pm_opp *opp,
 
 static void opp_debug_create_supplies(struct dev_pm_opp *opp,
 				      struct opp_table *opp_table,
-				      struct dentry *pdentry)
+				      struct debugfs_node *pdentry)
 {
-	struct dentry *d;
+	struct debugfs_node *d;
 	int i;
 
 	for (i = 0; i < opp_table->regulator_count; i++) {
@@ -128,8 +128,8 @@ static void opp_debug_create_supplies(struct dev_pm_opp *opp,
 
 void opp_debug_create_one(struct dev_pm_opp *opp, struct opp_table *opp_table)
 {
-	struct dentry *pdentry = opp_table->dentry;
-	struct dentry *d;
+	struct debugfs_node *pdentry = opp_table->dentry;
+	struct debugfs_node *d;
 	unsigned long id;
 	char name[25];	/* 20 chars for 64 bit value + 5 (opp:\0) */
 
@@ -172,7 +172,7 @@ static void opp_list_debug_create_dir(struct opp_device *opp_dev,
 				      struct opp_table *opp_table)
 {
 	const struct device *dev = opp_dev->dev;
-	struct dentry *d;
+	struct debugfs_node *d;
 
 	opp_set_dev_name(dev, opp_table->dentry_name);
 
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 5c7c81190e41..fbcb8e683df3 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -128,7 +128,7 @@ struct dev_pm_opp {
 	struct device_node *np;
 
 #ifdef CONFIG_DEBUG_FS
-	struct dentry *dentry;
+	struct debugfs_node *dentry;
 	const char *of_name;
 #endif
 };
@@ -147,7 +147,7 @@ struct opp_device {
 	const struct device *dev;
 
 #ifdef CONFIG_DEBUG_FS
-	struct dentry *dentry;
+	struct debugfs_node *dentry;
 #endif
 };
 
@@ -244,7 +244,7 @@ struct opp_table {
 	bool is_genpd;
 
 #ifdef CONFIG_DEBUG_FS
-	struct dentry *dentry;
+	struct debugfs_node *dentry;
 	char dentry_name[NAME_MAX];
 #endif
 };
diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index c08f64d7a825..053719183cdf 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -207,7 +207,7 @@ struct qcom_pcie_ep {
 	struct gpio_desc *reset;
 	struct gpio_desc *wake;
 	struct phy *phy;
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 
 	struct icc_path *icc_mem;
 
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index e4d3366ead1f..64fa6307c9f8 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -273,7 +273,7 @@ struct qcom_pcie {
 	struct icc_path *icc_mem;
 	struct icc_path *icc_cpu;
 	const struct qcom_pcie_cfg *cfg;
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 	bool suspended;
 	bool use_pm_opp;
 };
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 5103995cd6c7..6afe37737336 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -274,7 +274,7 @@ struct tegra_pcie_dw {
 	unsigned int phy_count;
 	struct phy **phys;
 
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 
 	/* Endpoint mode specific */
 	struct gpio_desc *pex_rst_gpiod;
diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index b3cdbc5927de..700abd327c4f 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -350,7 +350,7 @@ struct tegra_pcie {
 	unsigned int num_supplies;
 
 	const struct tegra_pcie_soc *soc;
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 };
 
 static inline struct tegra_pcie *msi_to_pcie(struct tegra_msi *msi)
diff --git a/drivers/pci/hotplug/cpqphp.h b/drivers/pci/hotplug/cpqphp.h
index 2f7b49ea96e2..79476bd23861 100644
--- a/drivers/pci/hotplug/cpqphp.h
+++ b/drivers/pci/hotplug/cpqphp.h
@@ -306,7 +306,7 @@ struct controller {
 	u16 vendor_id;
 	struct work_struct int_task_event;
 	wait_queue_head_t queue;	/* sleep & wake process */
-	struct dentry *dentry;		/* debugfs dentry */
+	struct debugfs_node *dentry;		/* debugfs dentry */
 };
 
 struct irq_mapping {
diff --git a/drivers/pci/hotplug/cpqphp_sysfs.c b/drivers/pci/hotplug/cpqphp_sysfs.c
index 6143ebf71f21..6674ff73b59c 100644
--- a/drivers/pci/hotplug/cpqphp_sysfs.c
+++ b/drivers/pci/hotplug/cpqphp_sysfs.c
@@ -180,7 +180,7 @@ static const struct file_operations debug_ops = {
 	.release = release,
 };
 
-static struct dentry *root;
+static struct debugfs_node *root;
 
 void cpqhp_initialize_debugfs(void)
 {
diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index ef959e66db7c..b319e4af7e22 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -357,7 +357,7 @@ struct arm_cmn {
 	struct hlist_node cpuhp_node;
 
 	struct pmu pmu;
-	struct dentry *debug;
+	struct debugfs_node *debug;
 };
 
 #define to_cmn(p)	container_of(p, struct arm_cmn, pmu)
@@ -451,7 +451,7 @@ static u32 arm_cmn_device_connect_info(const struct arm_cmn *cmn,
 	return readl_relaxed(xp->pmu_base + offset);
 }
 
-static struct dentry *arm_cmn_debugfs;
+static struct debugfs_node *arm_cmn_debugfs;
 
 #ifdef CONFIG_DEBUG_FS
 static const char *arm_cmn_device_type(u8 type)
diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 8dfdce605a90..59865c202a14 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -26,7 +26,7 @@ static const struct class phy_class = {
 	.dev_release = phy_release,
 };
 
-static struct dentry *phy_debugfs_root;
+static struct debugfs_node *phy_debugfs_root;
 static DEFINE_MUTEX(phy_provider_mutex);
 static LIST_HEAD(phy_provider_list);
 static LIST_HEAD(phys);
diff --git a/drivers/phy/realtek/phy-rtk-usb2.c b/drivers/phy/realtek/phy-rtk-usb2.c
index 248550ef98ca..eff7bf8f8ee1 100644
--- a/drivers/phy/realtek/phy-rtk-usb2.c
+++ b/drivers/phy/realtek/phy-rtk-usb2.c
@@ -119,7 +119,7 @@ struct rtk_phy {
 	int num_phy;
 	struct phy_parameter *phy_parameter;
 
-	struct dentry *debug_dir;
+	struct debugfs_node *debug_dir;
 };
 
 /* mapping 0xE0 to 0 ... 0xE7 to 7, 0xF0 to 8 ,,, 0xF7 to 15 */
@@ -708,9 +708,9 @@ static const struct phy_ops ops = {
 };
 
 #ifdef CONFIG_DEBUG_FS
-static struct dentry *create_phy_debug_root(void)
+static struct debugfs_node *create_phy_debug_root(void)
 {
-	struct dentry *phy_debug_root;
+	struct debugfs_node *phy_debug_root;
 
 	phy_debug_root = debugfs_lookup("phy", usb_debug_root);
 	if (!phy_debug_root)
@@ -845,7 +845,7 @@ DEFINE_SHOW_ATTRIBUTE(rtk_usb2_parameter);
 
 static inline void create_debug_files(struct rtk_phy *rtk_phy)
 {
-	struct dentry *phy_debug_root = NULL;
+	struct debugfs_node *phy_debug_root = NULL;
 
 	phy_debug_root = create_phy_debug_root();
 	if (!phy_debug_root)
diff --git a/drivers/phy/realtek/phy-rtk-usb3.c b/drivers/phy/realtek/phy-rtk-usb3.c
index cce453686db2..d309389b6f42 100644
--- a/drivers/phy/realtek/phy-rtk-usb3.c
+++ b/drivers/phy/realtek/phy-rtk-usb3.c
@@ -89,7 +89,7 @@ struct rtk_phy {
 	int num_phy;
 	struct phy_parameter *phy_parameter;
 
-	struct dentry *debug_dir;
+	struct debugfs_node *debug_dir;
 };
 
 #define PHY_IO_TIMEOUT_USEC		(50000)
@@ -342,9 +342,9 @@ static const struct phy_ops ops = {
 };
 
 #ifdef CONFIG_DEBUG_FS
-static struct dentry *create_phy_debug_root(void)
+static struct debugfs_node *create_phy_debug_root(void)
 {
-	struct dentry *phy_debug_root;
+	struct debugfs_node *phy_debug_root;
 
 	phy_debug_root = debugfs_lookup("phy", usb_debug_root);
 	if (!phy_debug_root)
@@ -408,7 +408,7 @@ DEFINE_SHOW_ATTRIBUTE(rtk_usb3_parameter);
 
 static inline void create_debug_files(struct rtk_phy *rtk_phy)
 {
-	struct dentry *phy_debug_root = NULL;
+	struct debugfs_node *phy_debug_root = NULL;
 
 	phy_debug_root = create_phy_debug_root();
 
diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 4bdbf6bb26e2..2283946acf6c 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -1935,11 +1935,11 @@ static int pinctrl_show(struct seq_file *s, void *what)
 }
 DEFINE_SHOW_ATTRIBUTE(pinctrl);
 
-static struct dentry *debugfs_root;
+static struct debugfs_node *debugfs_root;
 
 static void pinctrl_init_device_debugfs(struct pinctrl_dev *pctldev)
 {
-	struct dentry *device_root;
+	struct debugfs_node *device_root;
 	const char *debugfs_name;
 
 	if (pctldev->desc->name &&
diff --git a/drivers/pinctrl/core.h b/drivers/pinctrl/core.h
index d6c24978e708..718582f840bb 100644
--- a/drivers/pinctrl/core.h
+++ b/drivers/pinctrl/core.h
@@ -17,6 +17,7 @@
 #include <linux/pinctrl/machine.h>
 
 struct dentry;
+#define debugfs_node dentry
 struct device;
 struct device_node;
 struct module;
@@ -70,7 +71,7 @@ struct pinctrl_dev {
 	struct pinctrl_state *hog_sleep;
 	struct mutex mutex;
 #ifdef CONFIG_DEBUG_FS
-	struct dentry *device_root;
+	struct debugfs_node *device_root;
 #endif
 };
 
diff --git a/drivers/pinctrl/pinconf.c b/drivers/pinctrl/pinconf.c
index dca963633b5d..3ed291970ddf 100644
--- a/drivers/pinctrl/pinconf.c
+++ b/drivers/pinctrl/pinconf.c
@@ -369,8 +369,8 @@ static int pinconf_groups_show(struct seq_file *s, void *what)
 DEFINE_SHOW_ATTRIBUTE(pinconf_pins);
 DEFINE_SHOW_ATTRIBUTE(pinconf_groups);
 
-void pinconf_init_device_debugfs(struct dentry *devroot,
-			 struct pinctrl_dev *pctldev)
+void pinconf_init_device_debugfs(struct debugfs_node *devroot,
+				 struct pinctrl_dev *pctldev)
 {
 	debugfs_create_file("pinconf-pins", 0444,
 			    devroot, pctldev, &pinconf_pins_fops);
diff --git a/drivers/pinctrl/pinconf.h b/drivers/pinctrl/pinconf.h
index a14c950bc700..d041365f2b6b 100644
--- a/drivers/pinctrl/pinconf.h
+++ b/drivers/pinctrl/pinconf.h
@@ -13,6 +13,7 @@
 #include <linux/errno.h>
 
 struct dentry;
+#define debugfs_node dentry
 struct device_node;
 struct seq_file;
 
@@ -81,7 +82,7 @@ static inline int pinconf_set_config(struct pinctrl_dev *pctldev, unsigned int p
 void pinconf_show_map(struct seq_file *s, const struct pinctrl_map *map);
 void pinconf_show_setting(struct seq_file *s,
 			  const struct pinctrl_setting *setting);
-void pinconf_init_device_debugfs(struct dentry *devroot,
+void pinconf_init_device_debugfs(struct debugfs_node *devroot,
 				 struct pinctrl_dev *pctldev);
 
 #else
@@ -96,7 +97,7 @@ static inline void pinconf_show_setting(struct seq_file *s,
 {
 }
 
-static inline void pinconf_init_device_debugfs(struct dentry *devroot,
+static inline void pinconf_init_device_debugfs(struct debugfs_node *devroot,
 					       struct pinctrl_dev *pctldev)
 {
 }
diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c
index 0743190da59e..24f2688f0136 100644
--- a/drivers/pinctrl/pinmux.c
+++ b/drivers/pinctrl/pinmux.c
@@ -771,8 +771,8 @@ static ssize_t pinmux_select_write(struct file *file, const char __user *user_bu
 }
 DEFINE_SHOW_STORE_ATTRIBUTE(pinmux_select);
 
-void pinmux_init_device_debugfs(struct dentry *devroot,
-			 struct pinctrl_dev *pctldev)
+void pinmux_init_device_debugfs(struct debugfs_node *devroot,
+				struct pinctrl_dev *pctldev)
 {
 	debugfs_create_file("pinmux-functions", 0444,
 			    devroot, pctldev, &pinmux_functions_fops);
diff --git a/drivers/pinctrl/pinmux.h b/drivers/pinctrl/pinmux.h
index 2965ec20b77f..ceae33f3e637 100644
--- a/drivers/pinctrl/pinmux.h
+++ b/drivers/pinctrl/pinmux.h
@@ -13,6 +13,7 @@
 #include <linux/types.h>
 
 struct dentry;
+#define debugfs_node dentry
 struct seq_file;
 
 struct pinctrl_dev;
@@ -107,7 +108,7 @@ static inline void pinmux_disable_setting(const struct pinctrl_setting *setting)
 void pinmux_show_map(struct seq_file *s, const struct pinctrl_map *map);
 void pinmux_show_setting(struct seq_file *s,
 			 const struct pinctrl_setting *setting);
-void pinmux_init_device_debugfs(struct dentry *devroot,
+void pinmux_init_device_debugfs(struct debugfs_node *devroot,
 				struct pinctrl_dev *pctldev);
 
 #else
@@ -122,7 +123,7 @@ static inline void pinmux_show_setting(struct seq_file *s,
 {
 }
 
-static inline void pinmux_init_device_debugfs(struct dentry *devroot,
+static inline void pinmux_init_device_debugfs(struct debugfs_node *devroot,
 					      struct pinctrl_dev *pctldev)
 {
 }
diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
index 92ac9a2f9c88..3dbf358f8bc4 100644
--- a/drivers/platform/chrome/cros_ec_debugfs.c
+++ b/drivers/platform/chrome/cros_ec_debugfs.c
@@ -48,7 +48,7 @@ static DECLARE_WAIT_QUEUE_HEAD(cros_ec_debugfs_log_wq);
  */
 struct cros_ec_debugfs {
 	struct cros_ec_dev *ec;
-	struct dentry *dir;
+	struct debugfs_node *dir;
 	/* EC log */
 	struct circ_buf log_buffer;
 	struct cros_ec_command *read_msg;
diff --git a/drivers/platform/chrome/wilco_ec/debugfs.c b/drivers/platform/chrome/wilco_ec/debugfs.c
index 0617292b5cd7..70dc23e80ea8 100644
--- a/drivers/platform/chrome/wilco_ec/debugfs.c
+++ b/drivers/platform/chrome/wilco_ec/debugfs.c
@@ -22,7 +22,7 @@
 
 struct wilco_ec_debugfs {
 	struct wilco_ec_device *ec;
-	struct dentry *dir;
+	struct debugfs_node *dir;
 	size_t response_size;
 	u8 raw_data[EC_MAILBOX_DATA_SIZE];
 	u8 formatted_data[FORMATTED_BUFFER_SIZE];
diff --git a/drivers/platform/olpc/olpc-ec.c b/drivers/platform/olpc/olpc-ec.c
index 48e9861bb571..a6a9662736ab 100644
--- a/drivers/platform/olpc/olpc-ec.c
+++ b/drivers/platform/olpc/olpc-ec.c
@@ -43,7 +43,7 @@ struct olpc_ec_priv {
 	struct list_head cmd_q;
 	spinlock_t cmd_q_lock;
 
-	struct dentry *dbgfs_dir;
+	struct debugfs_node *dbgfs_dir;
 
 	/*
 	 * EC event mask to be applied during suspend (defining wakeup
@@ -327,9 +327,9 @@ static const struct file_operations ec_dbgfs_ops = {
 	.read = ec_dbgfs_cmd_read,
 };
 
-static struct dentry *olpc_ec_setup_debugfs(void)
+static struct debugfs_node *olpc_ec_setup_debugfs(void)
 {
-	struct dentry *dbgfs_dir;
+	struct debugfs_node *dbgfs_dir;
 
 	dbgfs_dir = debugfs_create_dir("olpc-ec", NULL);
 	debugfs_create_file("cmd", 0600, dbgfs_dir, NULL, &ec_dbgfs_ops);
@@ -339,7 +339,7 @@ static struct dentry *olpc_ec_setup_debugfs(void)
 
 #else
 
-static struct dentry *olpc_ec_setup_debugfs(void)
+static struct debugfs_node *olpc_ec_setup_debugfs(void)
 {
 	return NULL;
 }
diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 69336bd778ee..c9e36a76a0c1 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -329,7 +329,7 @@ struct acer_data {
 };
 
 struct acer_debug {
-	struct dentry *root;
+	struct debugfs_node *root;
 	u32 wmid_devices;
 };
 
diff --git a/drivers/platform/x86/amd/pmc/pmc.h b/drivers/platform/x86/amd/pmc/pmc.h
index f43f0253b0f5..7063f9bec040 100644
--- a/drivers/platform/x86/amd/pmc/pmc.h
+++ b/drivers/platform/x86/amd/pmc/pmc.h
@@ -58,7 +58,7 @@ struct amd_pmc_dev {
 	struct device *dev;
 	struct pci_dev *rdev;
 	struct mutex lock; /* generic mutex lock */
-	struct dentry *dbgfs_dir;
+	struct debugfs_node *dbgfs_dir;
 	struct quirk_entry *quirks;
 	bool disable_8042_wakeup;
 	struct amd_mp2_dev *mp2;
diff --git a/drivers/platform/x86/amd/pmf/pmf.h b/drivers/platform/x86/amd/pmf/pmf.h
index 41b2b91b8fdc..696c095f3d8a 100644
--- a/drivers/platform/x86/amd/pmf/pmf.h
+++ b/drivers/platform/x86/amd/pmf/pmf.h
@@ -339,7 +339,7 @@ struct amd_pmf_dev {
 	u32 supported_func;
 	enum platform_profile_option current_profile;
 	struct device *ppdev; /* platform profile class device */
-	struct dentry *dbgfs_dir;
+	struct debugfs_node *dbgfs_dir;
 	int hb_interval; /* SBIOS heartbeat interval */
 	struct delayed_work heart_beat;
 	struct smu_pmf_metrics m_table;
@@ -354,7 +354,7 @@ struct amd_pmf_dev {
 	bool cnqf_supported;
 	struct notifier_block pwr_src_notifier;
 	/* Smart PC solution builder */
-	struct dentry *esbin;
+	struct debugfs_node *esbin;
 	unsigned char *policy_buf;
 	resource_size_t policy_sz;
 	struct tee_context *tee_ctx;
diff --git a/drivers/platform/x86/amd/pmf/tee-if.c b/drivers/platform/x86/amd/pmf/tee-if.c
index 8c88769ea1d8..2986efb1c616 100644
--- a/drivers/platform/x86/amd/pmf/tee-if.c
+++ b/drivers/platform/x86/amd/pmf/tee-if.c
@@ -369,7 +369,8 @@ static const struct file_operations pb_fops = {
 	.open = simple_open,
 };
 
-static void amd_pmf_open_pb(struct amd_pmf_dev *dev, struct dentry *debugfs_root)
+static void amd_pmf_open_pb(struct amd_pmf_dev *dev,
+			    struct debugfs_node *debugfs_root)
 {
 	dev->esbin = debugfs_create_dir("pb", debugfs_root);
 	debugfs_create_file("update_policy", 0644, dev->esbin, dev, &pb_fops);
@@ -380,7 +381,8 @@ static void amd_pmf_remove_pb(struct amd_pmf_dev *dev)
 	debugfs_remove_recursive(dev->esbin);
 }
 #else
-static void amd_pmf_open_pb(struct amd_pmf_dev *dev, struct dentry *debugfs_root) {}
+static void amd_pmf_open_pb(struct amd_pmf_dev *dev,
+			    struct debugfs_node *debugfs_root) {}
 static void amd_pmf_remove_pb(struct amd_pmf_dev *dev) {}
 static void amd_pmf_hex_dump_pb(struct amd_pmf_dev *dev) {}
 #endif
diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index 1417e230edbd..fc00e9303bfd 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -77,7 +77,7 @@ struct apple_gmux_data {
 
 	/* debugfs data */
 	u8 selected_port;
-	struct dentry *debug_dentry;
+	struct debugfs_node *debug_dentry;
 };
 
 static struct apple_gmux_data *apple_gmux_data;
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 38ef778e8c19..99a1bcd65208 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -213,7 +213,7 @@ struct agfn_fan_args {
  *   call        - call method_id(dev_id, ctrl_param) and print result
  */
 struct asus_wmi_debug {
-	struct dentry *root;
+	struct debugfs_node *root;
 	u32 method_id;
 	u32 dev_id;
 	u32 ctrl_param;
diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/x86/dell/dell-laptop.c
index 57748c3ea24f..5e3c41066cff 100644
--- a/drivers/platform/x86/dell/dell-laptop.c
+++ b/drivers/platform/x86/dell/dell-laptop.c
@@ -602,7 +602,7 @@ static const struct rfkill_ops dell_rfkill_ops = {
 	.query = dell_rfkill_query,
 };
 
-static struct dentry *dell_laptop_dir;
+static struct debugfs_node *dell_laptop_dir;
 
 static int dell_debugfs_show(struct seq_file *s, void *data)
 {
diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platform/x86/dell/dell-wmi-ddv.c
index e75cd6e1efe6..c600c1c249b2 100644
--- a/drivers/platform/x86/dell/dell-wmi-ddv.c
+++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
@@ -791,14 +791,14 @@ static int dell_wmi_ddv_temp_read(struct seq_file *seq, void *offset)
 
 static void dell_wmi_ddv_debugfs_remove(void *data)
 {
-	struct dentry *entry = data;
+	struct debugfs_node *entry = data;
 
 	debugfs_remove(entry);
 }
 
 static void dell_wmi_ddv_debugfs_init(struct wmi_device *wdev)
 {
-	struct dentry *entry;
+	struct debugfs_node *entry;
 	char name[64];
 
 	scnprintf(name, ARRAY_SIZE(name), "%s-%s", DRIVER_NAME, dev_name(&wdev->dev));
diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index c3772df34679..785125291b82 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -54,7 +54,7 @@ struct quirk_entry {
 static struct quirk_entry *quirks;
 
 struct huawei_wmi_debug {
-	struct dentry *root;
+	struct debugfs_node *root;
 	u64 arg;
 };
 
diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 30bd366d7b58..a78f321dae9d 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -161,7 +161,7 @@ struct ideapad_private {
 	struct input_dev *inputdev;
 	struct backlight_device *blightdev;
 	struct ideapad_dytc_priv *dytc;
-	struct dentry *debug;
+	struct debugfs_node *debug;
 	unsigned long cfg;
 	unsigned long r_touchpad_val;
 	struct {
@@ -531,7 +531,7 @@ DEFINE_SHOW_ATTRIBUTE(debugfs_cfg);
 
 static void ideapad_debugfs_init(struct ideapad_private *priv)
 {
-	struct dentry *dir;
+	struct debugfs_node *dir;
 
 	dir = debugfs_create_dir("ideapad", NULL);
 	priv->debug = dir;
diff --git a/drivers/platform/x86/intel/bytcrc_pwrsrc.c b/drivers/platform/x86/intel/bytcrc_pwrsrc.c
index 68ac040082df..f444826a36e2 100644
--- a/drivers/platform/x86/intel/bytcrc_pwrsrc.c
+++ b/drivers/platform/x86/intel/bytcrc_pwrsrc.c
@@ -30,7 +30,7 @@
 
 struct crc_pwrsrc_data {
 	struct regmap *regmap;
-	struct dentry *debug_dentry;
+	struct debugfs_node *debug_dentry;
 	struct power_supply *psy;
 	unsigned int resetsrc0;
 	unsigned int resetsrc1;
diff --git a/drivers/platform/x86/intel/plr_tpmi.c b/drivers/platform/x86/intel/plr_tpmi.c
index 2b55347a5a93..f2f966b3510a 100644
--- a/drivers/platform/x86/intel/plr_tpmi.c
+++ b/drivers/platform/x86/intel/plr_tpmi.c
@@ -55,7 +55,7 @@ struct tpmi_plr_die {
 };
 
 struct tpmi_plr {
-	struct dentry *dbgfs_dir;
+	struct debugfs_node *dbgfs_dir;
 	struct tpmi_plr_die *die_info;
 	int num_dies;
 	struct auxiliary_device *auxdev;
@@ -257,7 +257,7 @@ DEFINE_SHOW_STORE_ATTRIBUTE(plr_status);
 static int intel_plr_probe(struct auxiliary_device *auxdev, const struct auxiliary_device_id *id)
 {
 	struct intel_tpmi_plat_info *plat_info;
-	struct dentry *dentry;
+	struct debugfs_node *dentry;
 	int i, num_resources;
 	struct resource *res;
 	struct tpmi_plr *plr;
diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 1ee0fb5f8250..dd7ab0dda14b 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1266,7 +1266,7 @@ static void pmc_core_dbgfs_unregister(struct pmc_dev *pmcdev)
 static void pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
 {
 	struct pmc *primary_pmc = pmcdev->pmcs[PMC_IDX_MAIN];
-	struct dentry *dir;
+	struct debugfs_node *dir;
 
 	dir = debugfs_create_dir("pmc_core", NULL);
 	pmcdev->dbgfs_dir = dir;
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index b9d3291d0bf2..1091ad963b9a 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -406,7 +406,7 @@ struct pmc {
  */
 struct pmc_dev {
 	struct pmc *pmcs[MAX_NUM_PMC];
-	struct dentry *dbgfs_dir;
+	struct debugfs_node *dbgfs_dir;
 	struct platform_device *pdev;
 	struct pci_dev *ssram_pcidev;
 	unsigned int crystal_freq;
diff --git a/drivers/platform/x86/intel/telemetry/debugfs.c b/drivers/platform/x86/intel/telemetry/debugfs.c
index 70e5736c44c7..e5791ef360ad 100644
--- a/drivers/platform/x86/intel/telemetry/debugfs.c
+++ b/drivers/platform/x86/intel/telemetry/debugfs.c
@@ -235,7 +235,7 @@ static struct telem_ioss_pg_info telem_apl_ioss_pg_data[] = {
 
 struct telemetry_debugfs_conf {
 	struct telemetry_susp_stats suspend_stats;
-	struct dentry *telemetry_dbg_dir;
+	struct debugfs_node *telemetry_dbg_dir;
 
 	/* Bitmap Data */
 	struct telem_ioss_d0ix_stateinfo *ioss_d0ix_data;
@@ -905,7 +905,7 @@ static int __init telemetry_debugfs_init(void)
 {
 	const struct x86_cpu_id *id;
 	int err;
-	struct dentry *dir;
+	struct debugfs_node *dir;
 
 	/* Only APL supported for now */
 	id = x86_match_cpu(telemetry_debugfs_cpu_ids);
diff --git a/drivers/platform/x86/intel/vsec_tpmi.c b/drivers/platform/x86/intel/vsec_tpmi.c
index 5c383a27bbe8..b44f02f78c88 100644
--- a/drivers/platform/x86/intel/vsec_tpmi.c
+++ b/drivers/platform/x86/intel/vsec_tpmi.c
@@ -118,7 +118,7 @@ struct intel_tpmi_info {
 	u64 pfs_start;
 	struct intel_tpmi_plat_info plat_info;
 	void __iomem *tpmi_control_mem;
-	struct dentry *dbgfs_dir;
+	struct debugfs_node *dbgfs_dir;
 };
 
 /**
@@ -356,7 +356,7 @@ int tpmi_get_feature_status(struct auxiliary_device *auxdev,
 }
 EXPORT_SYMBOL_NS_GPL(tpmi_get_feature_status, "INTEL_TPMI");
 
-struct dentry *tpmi_get_debugfs_dir(struct auxiliary_device *auxdev)
+struct debugfs_node *tpmi_get_debugfs_dir(struct auxiliary_device *auxdev)
 {
 	struct intel_vsec_device *intel_vsec_dev = dev_to_ivdev(auxdev->dev.parent);
 	struct intel_tpmi_info *tpmi_info = auxiliary_get_drvdata(&intel_vsec_dev->auxdev);
@@ -544,7 +544,7 @@ static void tpmi_dbgfs_register(struct intel_tpmi_info *tpmi_info)
 
 	for (i = 0; i < tpmi_info->feature_count; ++i) {
 		struct intel_tpmi_pm_feature *pfs;
-		struct dentry *dir;
+		struct debugfs_node *dir;
 
 		pfs = &tpmi_info->tpmi_features[i];
 		snprintf(name, sizeof(name), "tpmi-id-%02x", pfs->pfs_header.tpmi_id);
diff --git a/drivers/platform/x86/intel_ips.c b/drivers/platform/x86/intel_ips.c
index 79a7b68c7373..3c6f69bf95e8 100644
--- a/drivers/platform/x86/intel_ips.c
+++ b/drivers/platform/x86/intel_ips.c
@@ -285,7 +285,7 @@ struct ips_driver {
 
 	struct task_struct *monitor;
 	struct task_struct *adjust;
-	struct dentry *debug_root;
+	struct debugfs_node *debug_root;
 	struct timer_list timer;
 
 	/* Average CPU core temps (all averages in .01 degrees C for precision) */
diff --git a/drivers/platform/x86/msi-wmi-platform.c b/drivers/platform/x86/msi-wmi-platform.c
index 9b5c7f8c79b0..ef69c873dd9a 100644
--- a/drivers/platform/x86/msi-wmi-platform.c
+++ b/drivers/platform/x86/msi-wmi-platform.c
@@ -272,16 +272,17 @@ static const struct file_operations msi_wmi_platform_debugfs_fops = {
 
 static void msi_wmi_platform_debugfs_remove(void *data)
 {
-	struct dentry *dir = data;
+	struct debugfs_node *dir = data;
 
 	debugfs_remove_recursive(dir);
 }
 
-static void msi_wmi_platform_debugfs_add(struct wmi_device *wdev, struct dentry *dir,
+static void msi_wmi_platform_debugfs_add(struct wmi_device *wdev,
+					 struct debugfs_node *dir,
 					 const char *name, enum msi_wmi_platform_method method)
 {
 	struct msi_wmi_platform_debugfs_data *data;
-	struct dentry *entry;
+	struct debugfs_node *entry;
 
 	data = devm_kzalloc(&wdev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -303,7 +304,7 @@ static void msi_wmi_platform_debugfs_add(struct wmi_device *wdev, struct dentry
 
 static void msi_wmi_platform_debugfs_init(struct wmi_device *wdev)
 {
-	struct dentry *dir;
+	struct debugfs_node *dir;
 	char dir_name[64];
 	int ret, method;
 
diff --git a/drivers/platform/x86/pmc_atom.c b/drivers/platform/x86/pmc_atom.c
index 0aa7076bc9cc..2f6d85b84831 100644
--- a/drivers/platform/x86/pmc_atom.c
+++ b/drivers/platform/x86/pmc_atom.c
@@ -43,7 +43,7 @@ struct pmc_dev {
 	void __iomem *regmap;
 	const struct pmc_reg_map *map;
 #ifdef CONFIG_DEBUG_FS
-	struct dentry *dbgfs_dir;
+	struct debugfs_node *dbgfs_dir;
 #endif /* CONFIG_DEBUG_FS */
 	bool init;
 };
@@ -333,7 +333,7 @@ DEFINE_SHOW_ATTRIBUTE(pmc_sleep_tmr);
 
 static void pmc_dbgfs_register(struct pmc_dev *pmc)
 {
-	struct dentry *dir;
+	struct debugfs_node *dir;
 
 	dir = debugfs_create_dir("pmc_atom", NULL);
 
diff --git a/drivers/platform/x86/samsung-laptop.c b/drivers/platform/x86/samsung-laptop.c
index decde4c9a3d9..6fc06e79d1dc 100644
--- a/drivers/platform/x86/samsung-laptop.c
+++ b/drivers/platform/x86/samsung-laptop.c
@@ -306,7 +306,7 @@ static const struct sabi_config sabi_configs[] = {
  */
 
 struct samsung_laptop_debug {
-	struct dentry *root;
+	struct debugfs_node *root;
 	struct sabi_data data;
 	u16 command;
 
@@ -1264,7 +1264,7 @@ static void samsung_debugfs_exit(struct samsung_laptop *samsung)
 
 static void samsung_debugfs_init(struct samsung_laptop *samsung)
 {
-	struct dentry *root;
+	struct debugfs_node *root;
 
 	root = debugfs_create_dir("samsung-laptop", NULL);
 	samsung->debug.root = root;
diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 6c94137865c9..c6260685b3ca 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -270,7 +270,7 @@ static void genpd_sd_counter_inc(struct generic_pm_domain *genpd)
 }
 
 #ifdef CONFIG_DEBUG_FS
-static struct dentry *genpd_debugfs_dir;
+static struct debugfs_node *genpd_debugfs_dir;
 
 static void genpd_debug_add(struct generic_pm_domain *genpd);
 
@@ -3582,7 +3582,7 @@ DEFINE_SHOW_ATTRIBUTE(perf_state);
 
 static void genpd_debug_add(struct generic_pm_domain *genpd)
 {
-	struct dentry *d;
+	struct debugfs_node *d;
 
 	if (!genpd_debugfs_dir)
 		return;
diff --git a/drivers/pmdomain/qcom/cpr.c b/drivers/pmdomain/qcom/cpr.c
index 3ee8184e4be3..83309a30a5eb 100644
--- a/drivers/pmdomain/qcom/cpr.c
+++ b/drivers/pmdomain/qcom/cpr.c
@@ -246,7 +246,7 @@ struct cpr_drv {
 	const struct acc_desc *acc_desc;
 	const struct cpr_fuse *cpr_fuses;
 
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 };
 
 static bool cpr_is_allowed(struct cpr_drv *drv)
diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing/core.c
index 0ffc259c6bb6..82f67e109e4b 100644
--- a/drivers/power/sequencing/core.c
+++ b/drivers/power/sequencing/core.c
@@ -1068,7 +1068,7 @@ static const struct seq_operations pwrseq_debugfs_sops = {
 };
 DEFINE_SEQ_ATTRIBUTE(pwrseq_debugfs);
 
-static struct dentry *pwrseq_debugfs_dentry;
+static struct debugfs_node *pwrseq_debugfs_dentry;
 
 #endif /* CONFIG_DEBUG_FS */
 
diff --git a/drivers/power/supply/da9030_battery.c b/drivers/power/supply/da9030_battery.c
index ac2e319e9517..a52cdede364b 100644
--- a/drivers/power/supply/da9030_battery.c
+++ b/drivers/power/supply/da9030_battery.c
@@ -116,7 +116,7 @@ struct da9030_charger {
 	void (*battery_low)(void);
 	void (*battery_critical)(void);
 
-	struct dentry *debug_file;
+	struct debugfs_node *debug_file;
 };
 
 static inline int da9030_reg_to_mV(int reg)
@@ -175,7 +175,7 @@ static int bat_debug_show(struct seq_file *s, void *data)
 
 DEFINE_SHOW_ATTRIBUTE(bat_debug);
 
-static struct dentry *da9030_bat_create_debugfs(struct da9030_charger *charger)
+static struct debugfs_node *da9030_bat_create_debugfs(struct da9030_charger *charger)
 {
 	charger->debug_file = debugfs_create_file("charger", 0666, NULL,
 						  charger, &bat_debug_fops);
@@ -187,7 +187,7 @@ static void da9030_bat_remove_debugfs(struct da9030_charger *charger)
 	debugfs_remove(charger->debug_file);
 }
 #else
-static inline struct dentry *da9030_bat_create_debugfs(struct da9030_charger *charger)
+static inline struct debugfs_node *da9030_bat_create_debugfs(struct da9030_charger *charger)
 {
 	return NULL;
 }
diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index b651087f426f..d46dd96ee230 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -360,7 +360,7 @@ struct ptp_ocp {
 	struct timer_list	watchdog;
 	const struct attribute_group **attr_group;
 	const struct ptp_ocp_eeprom_map *eeprom_map;
-	struct dentry		*debug_root;
+	struct debugfs_node *debug_root;
 	bool			sync;
 	time64_t		gnss_lost;
 	struct delayed_work	sync_work;
@@ -4295,12 +4295,12 @@ ptp_ocp_tod_status_show(struct seq_file *s, void *data)
 }
 DEFINE_SHOW_ATTRIBUTE(ptp_ocp_tod_status);
 
-static struct dentry *ptp_ocp_debugfs_root;
+static struct debugfs_node *ptp_ocp_debugfs_root;
 
 static void
 ptp_ocp_debugfs_add_device(struct ptp_ocp *bp)
 {
-	struct dentry *d;
+	struct debugfs_node *d;
 
 	d = debugfs_create_dir(dev_name(&bp->dev), ptp_ocp_debugfs_root);
 	bp->debug_root = d;
diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index 18934e28469e..5aa015c5a509 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -31,7 +31,7 @@ struct timestamp_event_queue {
 	spinlock_t lock;
 	struct list_head qlist;
 	unsigned long *mask;
-	struct dentry *debugfs_instance;
+	struct debugfs_node *debugfs_instance;
 	struct debugfs_u32_array dfs_bitmap;
 };
 
@@ -61,7 +61,7 @@ struct ptp_clock {
 	struct mutex n_vclocks_mux; /* protect concurrent n_vclocks access */
 	bool is_virtual_clock;
 	bool has_cycles;
-	struct dentry *debugfs_root;
+	struct debugfs_node *debugfs_root;
 };
 
 #define info_to_vclock(d) container_of((d), struct ptp_vclock, info)
diff --git a/drivers/ptp/ptp_qoriq_debugfs.c b/drivers/ptp/ptp_qoriq_debugfs.c
index e8dddcedf288..7a050126362f 100644
--- a/drivers/ptp/ptp_qoriq_debugfs.c
+++ b/drivers/ptp/ptp_qoriq_debugfs.c
@@ -69,7 +69,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(ptp_qoriq_fiper2_fops, ptp_qoriq_fiper2_lpbk_get,
 
 void ptp_qoriq_create_debugfs(struct ptp_qoriq *ptp_qoriq)
 {
-	struct dentry *root;
+	struct debugfs_node *root;
 
 	root = debugfs_create_dir(dev_name(ptp_qoriq->dev), NULL);
 	if (IS_ERR(root))
diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
index 90de737fbc90..bf3fc8bf7221 100644
--- a/drivers/ras/amd/fmpm.c
+++ b/drivers/ras/amd/fmpm.c
@@ -118,8 +118,8 @@ static struct fru_rec **fru_records;
 /* system physical addresses array */
 static u64 *spa_entries;
 
-static struct dentry *fmpm_dfs_dir;
-static struct dentry *fmpm_dfs_entries;
+static struct debugfs_node *fmpm_dfs_dir;
+static struct debugfs_node *fmpm_dfs_entries;
 
 #define CPER_CREATOR_FMP						\
 	GUID_INIT(0xcd5c2993, 0xf4b2, 0x41b2, 0xb5, 0xd4, 0xf9, 0xc3,	\
@@ -950,7 +950,7 @@ static const struct file_operations fmpm_fops = {
 
 static void setup_debugfs(void)
 {
-	struct dentry *dfs = ras_get_debugfs_root();
+	struct debugfs_node *dfs = ras_get_debugfs_root();
 
 	if (!dfs)
 		return;
diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index e440b15fbabc..ebd7b4518ede 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -480,7 +480,7 @@ DEFINE_SHOW_ATTRIBUTE(array);
 
 static int __init create_debugfs_nodes(void)
 {
-	struct dentry *d, *pfn, *decay, *count, *array, *dfs;
+	struct debugfs_node *d, *pfn, *decay, *count, *array, *dfs;
 
 	dfs = ras_get_debugfs_root();
 	if (!dfs) {
diff --git a/drivers/ras/debugfs.c b/drivers/ras/debugfs.c
index 42afd3de68b2..cef3cf042cb4 100644
--- a/drivers/ras/debugfs.c
+++ b/drivers/ras/debugfs.c
@@ -3,11 +3,11 @@
 #include <linux/ras.h>
 #include "debugfs.h"
 
-static struct dentry *ras_debugfs_dir;
+static struct debugfs_node *ras_debugfs_dir;
 
 static atomic_t trace_count = ATOMIC_INIT(0);
 
-struct dentry *ras_get_debugfs_root(void)
+struct debugfs_node *ras_get_debugfs_root(void)
 {
 	return ras_debugfs_dir;
 }
@@ -45,7 +45,7 @@ static const struct file_operations trace_fops = {
 
 int __init ras_add_daemon_trace(void)
 {
-	struct dentry *fentry;
+	struct debugfs_node *fentry;
 
 	if (!ras_debugfs_dir)
 		return -ENOENT;
diff --git a/drivers/ras/debugfs.h b/drivers/ras/debugfs.h
index 5a2f48439258..d9b36629e844 100644
--- a/drivers/ras/debugfs.h
+++ b/drivers/ras/debugfs.h
@@ -5,9 +5,9 @@
 #include <linux/debugfs.h>
 
 #if IS_ENABLED(CONFIG_DEBUG_FS)
-struct dentry *ras_get_debugfs_root(void);
+struct debugfs_node *ras_get_debugfs_root(void);
 #else
-static inline struct dentry *ras_get_debugfs_root(void) { return NULL; }
+static inline struct debugfs_node *ras_get_debugfs_root(void) { return NULL; }
 #endif /* DEBUG_FS */
 
 #endif /* __RAS_DEBUGFS_H__ */
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 89578b91c468..d365f2d86e69 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -44,7 +44,7 @@ static LIST_HEAD(regulator_supply_alias_list);
 static LIST_HEAD(regulator_coupler_list);
 static bool has_full_constraints;
 
-static struct dentry *debugfs_root;
+static struct debugfs_node *debugfs_root;
 
 /*
  * struct regulator_map
diff --git a/drivers/regulator/internal.h b/drivers/regulator/internal.h
index b3d48dc38bc4..13ea51270bc4 100644
--- a/drivers/regulator/internal.h
+++ b/drivers/regulator/internal.h
@@ -55,7 +55,7 @@ struct regulator {
 	const char *supply_name;
 	struct device_attribute dev_attr;
 	struct regulator_dev *rdev;
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 };
 
 extern const struct class regulator_class;
diff --git a/drivers/remoteproc/remoteproc_debugfs.c b/drivers/remoteproc/remoteproc_debugfs.c
index b86c1d09c70c..a48b7f3d5380 100644
--- a/drivers/remoteproc/remoteproc_debugfs.c
+++ b/drivers/remoteproc/remoteproc_debugfs.c
@@ -25,7 +25,7 @@
 #include "remoteproc_internal.h"
 
 /* remoteproc debugfs parent dir */
-static struct dentry *rproc_dbg;
+static struct debugfs_node *rproc_dbg;
 
 /*
  * A coredump-configuration-to-string lookup table, for exposing a
@@ -378,12 +378,12 @@ static int rproc_carveouts_show(struct seq_file *seq, void *p)
 
 DEFINE_SHOW_ATTRIBUTE(rproc_carveouts);
 
-void rproc_remove_trace_file(struct dentry *tfile)
+void rproc_remove_trace_file(struct debugfs_node *tfile)
 {
 	debugfs_remove(tfile);
 }
 
-struct dentry *rproc_create_trace_file(const char *name, struct rproc *rproc,
+struct debugfs_node *rproc_create_trace_file(const char *name, struct rproc *rproc,
 				       struct rproc_debug_trace *trace)
 {
 	return debugfs_create_file(name, 0400, rproc->dbg_dir, trace,
diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
index 0cd09e67ac14..ec2b32c65989 100644
--- a/drivers/remoteproc/remoteproc_internal.h
+++ b/drivers/remoteproc/remoteproc_internal.h
@@ -64,7 +64,7 @@ irqreturn_t rproc_vq_interrupt(struct rproc *rproc, int vq_id);
 
 /* from remoteproc_debugfs.c */
 void rproc_remove_trace_file(struct dentry *tfile);
-struct dentry *rproc_create_trace_file(const char *name, struct rproc *rproc,
+struct debugfs_node *rproc_create_trace_file(const char *name, struct rproc *rproc,
 				       struct rproc_debug_trace *trace);
 void rproc_delete_debug_dir(struct rproc *rproc);
 void rproc_create_debug_dir(struct rproc *rproc);
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index 81cfb5c89681..cab0b1b03894 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -533,7 +533,7 @@ struct dasd_profile_info {
 };
 
 struct dasd_profile {
-	struct dentry *dentry;
+	struct debugfs_node *dentry;
 	struct dasd_profile_info *data;
 	spinlock_t lock;
 };
@@ -604,8 +604,8 @@ struct dasd_device {
 	unsigned long path_thrhld;
 	unsigned long path_interval;
 
-	struct dentry *debugfs_dentry;
-	struct dentry *hosts_dentry;
+	struct debugfs_node *debugfs_dentry;
+	struct debugfs_node *hosts_dentry;
 	struct dasd_profile profile;
 	struct dasd_format_entry format_entry;
 	struct kset *paths_info;
@@ -634,7 +634,7 @@ struct dasd_block {
 	struct tasklet_struct tasklet;
 	struct timer_list timer;
 
-	struct dentry *debugfs_dentry;
+	struct debugfs_node *debugfs_dentry;
 	struct dasd_profile profile;
 
 	struct list_head format_list;
diff --git a/drivers/s390/char/zcore.c b/drivers/s390/char/zcore.c
index 33cebb91b933..b60f6dc395c1 100644
--- a/drivers/s390/char/zcore.c
+++ b/drivers/s390/char/zcore.c
@@ -46,9 +46,9 @@ struct ipib_info {
 
 static struct debug_info *zcore_dbf;
 static int hsa_available;
-static struct dentry *zcore_dir;
-static struct dentry *zcore_reipl_file;
-static struct dentry *zcore_hsa_file;
+static struct debugfs_node *zcore_dir;
+static struct debugfs_node *zcore_reipl_file;
+static struct debugfs_node *zcore_hsa_file;
 static struct ipl_parameter_block *zcore_ipl_block;
 static unsigned long os_info_flags;
 
diff --git a/drivers/s390/cio/cio_debug.h b/drivers/s390/cio/cio_debug.h
index e6dcbd1be244..33925101865d 100644
--- a/drivers/s390/cio/cio_debug.h
+++ b/drivers/s390/cio/cio_debug.h
@@ -27,6 +27,6 @@ static inline void CIO_HEX_EVENT(int level, void *data, int length)
 }
 
 /* For the CIO debugfs related features */
-extern struct dentry *cio_debugfs_dir;
+extern struct debugfs_node *cio_debugfs_dir;
 
 #endif
diff --git a/drivers/s390/cio/cio_debugfs.c b/drivers/s390/cio/cio_debugfs.c
index 0a3656fb5ad0..b7f39396aa56 100644
--- a/drivers/s390/cio/cio_debugfs.c
+++ b/drivers/s390/cio/cio_debugfs.c
@@ -9,7 +9,7 @@
 #include <linux/debugfs.h>
 #include "cio_debug.h"
 
-struct dentry *cio_debugfs_dir;
+struct debugfs_node *cio_debugfs_dir;
 
 /* Create the debugfs directory for CIO under the arch_debugfs_dir
  * i.e /sys/kernel/debug/s390/cio
diff --git a/drivers/s390/cio/qdio.h b/drivers/s390/cio/qdio.h
index 4bd4c00c9c0c..c35abab2997b 100644
--- a/drivers/s390/cio/qdio.h
+++ b/drivers/s390/cio/qdio.h
@@ -222,7 +222,7 @@ struct qdio_irq {
 	u32 *dsci;		/* address of device state change indicator */
 	struct ccw_device *cdev;
 	struct list_head entry;		/* list of thinint devices */
-	struct dentry *debugfs_dev;
+	struct debugfs_node *debugfs_dev;
 	u64 last_data_irq_time;
 
 	unsigned long int_parm;
diff --git a/drivers/s390/cio/qdio_debug.c b/drivers/s390/cio/qdio_debug.c
index 1a9714af51e4..36eb0b2e98f9 100644
--- a/drivers/s390/cio/qdio_debug.c
+++ b/drivers/s390/cio/qdio_debug.c
@@ -16,7 +16,7 @@
 debug_info_t *qdio_dbf_setup;
 debug_info_t *qdio_dbf_error;
 
-static struct dentry *debugfs_root;
+static struct debugfs_node *debugfs_root;
 #define QDIO_DEBUGFS_NAME_LEN	10
 #define QDIO_DBF_NAME_LEN	20
 
@@ -281,7 +281,7 @@ static const struct file_operations debugfs_perf_fops = {
 	.release = single_release,
 };
 
-static void setup_debugfs_entry(struct dentry *parent, struct qdio_q *q)
+static void setup_debugfs_entry(struct debugfs_node *parent, struct qdio_q *q)
 {
 	char name[QDIO_DEBUGFS_NAME_LEN];
 
diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 41fe8a043d61..5171a9b08597 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -810,7 +810,7 @@ struct qeth_card {
 	struct qeth_channel data;
 
 	struct net_device *dev;
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 	struct qeth_card_stats stats;
 	struct qeth_card_info info;
 	struct qeth_token token;
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index a3adaec5504e..2e0601ca2a50 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -62,7 +62,7 @@ static struct kmem_cache *qeth_qdio_outbuf_cache;
 static struct kmem_cache *qeth_qaob_cache;
 
 static struct device *qeth_core_root_dev;
-static struct dentry *qeth_debugfs_root;
+static struct debugfs_node *qeth_debugfs_root;
 static struct lock_class_key qdio_out_skb_queue_key;
 
 static void qeth_issue_next_read_cb(struct qeth_card *card,
diff --git a/drivers/scsi/bfa/bfad_debugfs.c b/drivers/scsi/bfa/bfad_debugfs.c
index f6dd077d47c9..7b00742ed30e 100644
--- a/drivers/scsi/bfa/bfad_debugfs.c
+++ b/drivers/scsi/bfa/bfad_debugfs.c
@@ -433,7 +433,7 @@ static const struct bfad_debugfs_entry bfad_debugfs_files[] = {
 	{ "regwr",  S_IFREG|S_IWUSR, &bfad_debugfs_op_regwr,  },
 };
 
-static struct dentry *bfa_debugfs_root;
+static struct debugfs_node *bfa_debugfs_root;
 static atomic_t bfa_debugfs_port_count;
 
 inline void
diff --git a/drivers/scsi/bfa/bfad_drv.h b/drivers/scsi/bfa/bfad_drv.h
index ce2ec5108947..542dcf9663a5 100644
--- a/drivers/scsi/bfa/bfad_drv.h
+++ b/drivers/scsi/bfa/bfad_drv.h
@@ -131,7 +131,7 @@ struct bfad_port_s {
 	enum bfad_port_pvb_type pvb_type;
 	struct bfad_im_port_s *im_port;	/* IM specific data */
 	/* port debugfs specific data */
-	struct dentry *port_debugfs_root;
+	struct debugfs_node *port_debugfs_root;
 };
 
 /*
diff --git a/drivers/scsi/csiostor/csio_hw.h b/drivers/scsi/csiostor/csio_hw.h
index e351af6e7c81..694394078e60 100644
--- a/drivers/scsi/csiostor/csio_hw.h
+++ b/drivers/scsi/csiostor/csio_hw.h
@@ -551,7 +551,7 @@ struct csio_hw {
 	/* MSIX vectors */
 	struct csio_msix_entries msix_entries[CSIO_MAX_MSIX_VECS];
 
-	struct dentry		*debugfs_root;		/* Debug FS */
+	struct debugfs_node *debugfs_root;		/* Debug FS */
 	struct csio_hw_stats	stats;			/* Hw statistics */
 };
 
diff --git a/drivers/scsi/csiostor/csio_init.c b/drivers/scsi/csiostor/csio_init.c
index 9a3f2ed050bd..06194b351e94 100644
--- a/drivers/scsi/csiostor/csio_init.c
+++ b/drivers/scsi/csiostor/csio_init.c
@@ -51,7 +51,7 @@
 
 #define CSIO_MIN_MEMPOOL_SZ	64
 
-static struct dentry *csio_debugfs_root;
+static struct debugfs_node *csio_debugfs_root;
 
 static struct scsi_transport_template *csio_fcoe_transport;
 static struct scsi_transport_template *csio_fcoe_transport_vport;
diff --git a/drivers/scsi/elx/efct/efct_driver.h b/drivers/scsi/elx/efct/efct_driver.h
index 0e3c931db7c2..1404137927f7 100644
--- a/drivers/scsi/elx/efct/efct_driver.h
+++ b/drivers/scsi/elx/efct/efct_driver.h
@@ -91,7 +91,7 @@ struct efct {
 	u32				target_io_timer_sec;
 
 	int				speed;
-	struct dentry			*sess_debugfs_dir;
+	struct debugfs_node *sess_debugfs_dir;
 };
 
 #define FW_WRITE_BUFSIZE		(64 * 1024)
diff --git a/drivers/scsi/elx/efct/efct_xport.c b/drivers/scsi/elx/efct/efct_xport.c
index cf4dced20b8b..f8667246c72e 100644
--- a/drivers/scsi/elx/efct/efct_xport.c
+++ b/drivers/scsi/elx/efct/efct_xport.c
@@ -7,7 +7,7 @@
 #include "efct_driver.h"
 #include "efct_unsol.h"
 
-static struct dentry *efct_debugfs_root;
+static struct debugfs_node *efct_debugfs_root;
 static atomic_t efct_debugfs_count;
 
 static const struct scsi_host_template efct_template = {
diff --git a/drivers/scsi/fnic/fnic.h b/drivers/scsi/fnic/fnic.h
index 6c5f6046b1f5..b436083578e6 100644
--- a/drivers/scsi/fnic/fnic.h
+++ b/drivers/scsi/fnic/fnic.h
@@ -386,9 +386,9 @@ struct fnic {
 	struct mutex sgreset_mutex;
 	spinlock_t sgreset_lock; /* lock for sgreset */
 	struct scsi_cmnd *sgreset_sc;
-	struct dentry *fnic_stats_debugfs_host;
-	struct dentry *fnic_stats_debugfs_file;
-	struct dentry *fnic_reset_debugfs_file;
+	struct debugfs_node *fnic_stats_debugfs_host;
+	struct debugfs_node *fnic_stats_debugfs_file;
+	struct debugfs_node *fnic_reset_debugfs_file;
 	unsigned int reset_stats;
 	atomic64_t io_cmpl_skip;
 	struct fnic_stats fnic_stats;
diff --git a/drivers/scsi/fnic/fnic_debugfs.c b/drivers/scsi/fnic/fnic_debugfs.c
index 5767862ae42f..0976628318bf 100644
--- a/drivers/scsi/fnic/fnic_debugfs.c
+++ b/drivers/scsi/fnic/fnic_debugfs.c
@@ -10,15 +10,15 @@
 extern int fnic_get_debug_info(struct stats_debug_info *debug_buffer,
 							   struct fnic *fnic);
 
-static struct dentry *fnic_trace_debugfs_root;
-static struct dentry *fnic_trace_debugfs_file;
-static struct dentry *fnic_trace_enable;
-static struct dentry *fnic_stats_debugfs_root;
-
-static struct dentry *fnic_fc_trace_debugfs_file;
-static struct dentry *fnic_fc_rdata_trace_debugfs_file;
-static struct dentry *fnic_fc_trace_enable;
-static struct dentry *fnic_fc_trace_clear;
+static struct debugfs_node *fnic_trace_debugfs_root;
+static struct debugfs_node *fnic_trace_debugfs_file;
+static struct debugfs_node *fnic_trace_enable;
+static struct debugfs_node *fnic_stats_debugfs_root;
+
+static struct debugfs_node *fnic_fc_trace_debugfs_file;
+static struct debugfs_node *fnic_fc_rdata_trace_debugfs_file;
+static struct debugfs_node *fnic_fc_trace_enable;
+static struct debugfs_node *fnic_fc_trace_clear;
 
 struct fc_trace_flag_type {
 	u8 fc_row_file;
diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_sas.h
index 2d438d722d0b..04eb1c61490d 100644
--- a/drivers/scsi/hisi_sas/hisi_sas.h
+++ b/drivers/scsi/hisi_sas/hisi_sas.h
@@ -480,10 +480,10 @@ struct hisi_hba {
 
 	u64 debugfs_timestamp[HISI_SAS_MAX_DEBUGFS_DUMP];
 	int debugfs_dump_index;
-	struct dentry *debugfs_dir;
-	struct dentry *debugfs_dump_dentry;
-	struct dentry *debugfs_bist_dentry;
-	struct dentry *debugfs_fifo_dentry;
+	struct debugfs_node *debugfs_dir;
+	struct debugfs_node *debugfs_dump_dentry;
+	struct debugfs_node *debugfs_bist_dentry;
+	struct debugfs_node *debugfs_fifo_dentry;
 
 	int iopoll_q_cnt;
 };
@@ -628,7 +628,7 @@ extern struct scsi_transport_template *hisi_sas_stt;
 
 extern bool hisi_sas_debugfs_enable;
 extern u32 hisi_sas_debugfs_dump_count;
-extern struct dentry *hisi_sas_debugfs_dir;
+extern struct debugfs_node *hisi_sas_debugfs_dir;
 
 extern void hisi_sas_stop_phys(struct hisi_hba *hisi_hba);
 extern int hisi_sas_alloc(struct hisi_hba *hisi_hba);
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index da4a2ed8ee86..0d561d26a1a7 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -2630,7 +2630,7 @@ EXPORT_SYMBOL_GPL(hisi_sas_debugfs_dump_count);
 module_param_named(debugfs_dump_count, hisi_sas_debugfs_dump_count, uint, 0444);
 MODULE_PARM_DESC(hisi_sas_debugfs_dump_count, "Number of debugfs dumps to allow");
 
-struct dentry *hisi_sas_debugfs_dir;
+struct debugfs_node *hisi_sas_debugfs_dir;
 EXPORT_SYMBOL_GPL(hisi_sas_debugfs_dir);
 
 static __init int hisi_sas_init(void)
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 48b95d9a7927..d81d4dab16af 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -3843,8 +3843,8 @@ DEFINE_SHOW_ATTRIBUTE(debugfs_itct_cache_v3_hw);
 static void debugfs_create_files_v3_hw(struct hisi_hba *hisi_hba, int index)
 {
 	u64 *debugfs_timestamp;
-	struct dentry *dump_dentry;
-	struct dentry *dentry;
+	struct debugfs_node *dump_dentry;
+	struct debugfs_node *dentry;
 	char name[256];
 	int p;
 	int c;
@@ -4507,7 +4507,7 @@ static void debugfs_fifo_init_v3_hw(struct hisi_hba *hisi_hba)
 
 	for (phy_no = 0; phy_no < hisi_hba->n_phy; phy_no++) {
 		struct hisi_sas_phy *phy = &hisi_hba->phy[phy_no];
-		struct dentry *port_dentry;
+		struct debugfs_node *port_dentry;
 		char name[256];
 		u32 val;
 
@@ -4739,7 +4739,7 @@ static int debugfs_snapshot_regs_v3_hw(struct hisi_hba *hisi_hba)
 
 static void debugfs_phy_down_cnt_init_v3_hw(struct hisi_hba *hisi_hba)
 {
-	struct dentry *dir = debugfs_create_dir("phy_down_cnt",
+	struct debugfs_node *dir = debugfs_create_dir("phy_down_cnt",
 						hisi_hba->debugfs_dir);
 	char name[16];
 	int phy_no;
@@ -4754,7 +4754,7 @@ static void debugfs_phy_down_cnt_init_v3_hw(struct hisi_hba *hisi_hba)
 
 static void debugfs_bist_init_v3_hw(struct hisi_hba *hisi_hba)
 {
-	struct dentry *ports_dentry;
+	struct debugfs_node *ports_dentry;
 	int phy_no;
 
 	hisi_hba->debugfs_bist_dentry =
@@ -4793,8 +4793,8 @@ static void debugfs_bist_init_v3_hw(struct hisi_hba *hisi_hba)
 	ports_dentry = debugfs_create_dir("port", hisi_hba->debugfs_bist_dentry);
 
 	for (phy_no = 0; phy_no < hisi_hba->n_phy; phy_no++) {
-		struct dentry *port_dentry;
-		struct dentry *ffe_dentry;
+		struct debugfs_node *port_dentry;
+		struct debugfs_node *ffe_dentry;
 		char name[256];
 		int i;
 
diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index e5a9c5a323f8..248a457bef61 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -745,13 +745,13 @@ struct lpfc_vport {
 	struct lpfc_vmid_priority_info vmid_priority;
 
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
-	struct dentry *debug_disc_trc;
-	struct dentry *debug_nodelist;
-	struct dentry *debug_nvmestat;
-	struct dentry *debug_scsistat;
-	struct dentry *debug_ioktime;
-	struct dentry *debug_hdwqstat;
-	struct dentry *vport_debugfs_root;
+	struct debugfs_node *debug_disc_trc;
+	struct debugfs_node *debug_nodelist;
+	struct debugfs_node *debug_nvmestat;
+	struct debugfs_node *debug_scsistat;
+	struct debugfs_node *debug_ioktime;
+	struct debugfs_node *debug_hdwqstat;
+	struct debugfs_node *vport_debugfs_root;
 	struct lpfc_debugfs_trc *disc_trc;
 	atomic_t disc_trc_cnt;
 #endif
@@ -1348,31 +1348,31 @@ struct lpfc_hba {
 	unsigned long last_rsrc_error_time;
 	unsigned long last_ramp_down_time;
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
-	struct dentry *hba_debugfs_root;
+	struct debugfs_node *hba_debugfs_root;
 	atomic_t debugfs_vport_count;
-	struct dentry *debug_multixri_pools;
-	struct dentry *debug_hbqinfo;
-	struct dentry *debug_dumpHostSlim;
-	struct dentry *debug_dumpHBASlim;
-	struct dentry *debug_InjErrLBA;  /* LBA to inject errors at */
-	struct dentry *debug_InjErrNPortID;  /* NPortID to inject errors at */
-	struct dentry *debug_InjErrWWPN;  /* WWPN to inject errors at */
-	struct dentry *debug_writeGuard; /* inject write guard_tag errors */
-	struct dentry *debug_writeApp;   /* inject write app_tag errors */
-	struct dentry *debug_writeRef;   /* inject write ref_tag errors */
-	struct dentry *debug_readGuard;  /* inject read guard_tag errors */
-	struct dentry *debug_readApp;    /* inject read app_tag errors */
-	struct dentry *debug_readRef;    /* inject read ref_tag errors */
-
-	struct dentry *debug_nvmeio_trc;
+	struct debugfs_node *debug_multixri_pools;
+	struct debugfs_node *debug_hbqinfo;
+	struct debugfs_node *debug_dumpHostSlim;
+	struct debugfs_node *debug_dumpHBASlim;
+	struct debugfs_node *debug_InjErrLBA;  /* LBA to inject errors at */
+	struct debugfs_node *debug_InjErrNPortID;  /* NPortID to inject errors at */
+	struct debugfs_node *debug_InjErrWWPN;  /* WWPN to inject errors at */
+	struct debugfs_node *debug_writeGuard; /* inject write guard_tag errors */
+	struct debugfs_node *debug_writeApp;   /* inject write app_tag errors */
+	struct debugfs_node *debug_writeRef;   /* inject write ref_tag errors */
+	struct debugfs_node *debug_readGuard;  /* inject read guard_tag errors */
+	struct debugfs_node *debug_readApp;    /* inject read app_tag errors */
+	struct debugfs_node *debug_readRef;    /* inject read ref_tag errors */
+
+	struct debugfs_node *debug_nvmeio_trc;
 	struct lpfc_debugfs_nvmeio_trc *nvmeio_trc;
 	struct dentry *debug_hdwqinfo;
 #ifdef LPFC_HDWQ_LOCK_STAT
-	struct dentry *debug_lockstat;
+	struct debugfs_node *debug_lockstat;
 #endif
-	struct dentry *debug_cgn_buffer;
-	struct dentry *debug_rx_monitor;
-	struct dentry *debug_ras_log;
+	struct debugfs_node *debug_cgn_buffer;
+	struct debugfs_node *debug_rx_monitor;
+	struct debugfs_node *debug_ras_log;
 	atomic_t nvmeio_trc_cnt;
 	uint32_t nvmeio_trc_size;
 	uint32_t nvmeio_trc_output_idx;
@@ -1389,19 +1389,19 @@ struct lpfc_hba {
 	sector_t lpfc_injerr_lba;
 #define LPFC_INJERR_LBA_OFF	(sector_t)(-1)
 
-	struct dentry *debug_slow_ring_trc;
+	struct debugfs_node *debug_slow_ring_trc;
 	struct lpfc_debugfs_trc *slow_ring_trc;
 	atomic_t slow_ring_trc_cnt;
 	/* iDiag debugfs sub-directory */
-	struct dentry *idiag_root;
-	struct dentry *idiag_pci_cfg;
-	struct dentry *idiag_bar_acc;
-	struct dentry *idiag_que_info;
-	struct dentry *idiag_que_acc;
-	struct dentry *idiag_drb_acc;
-	struct dentry *idiag_ctl_acc;
-	struct dentry *idiag_mbx_acc;
-	struct dentry *idiag_ext_acc;
+	struct debugfs_node *idiag_root;
+	struct debugfs_node *idiag_pci_cfg;
+	struct debugfs_node *idiag_bar_acc;
+	struct debugfs_node *idiag_que_info;
+	struct debugfs_node *idiag_que_acc;
+	struct debugfs_node *idiag_drb_acc;
+	struct debugfs_node *idiag_ctl_acc;
+	struct debugfs_node *idiag_mbx_acc;
+	struct debugfs_node *idiag_ext_acc;
 	uint8_t lpfc_idiag_last_eq;
 #endif
 	uint16_t nvmeio_trc_on;
diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
index 3fd1aa5cc78c..1b28a4bed80c 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.c
+++ b/drivers/scsi/lpfc/lpfc_debugfs.c
@@ -5727,7 +5727,7 @@ static const struct file_operations lpfc_debugfs_op_slow_ring_trc = {
 	.release =      lpfc_debugfs_release,
 };
 
-static struct dentry *lpfc_debugfs_root = NULL;
+static struct debugfs_node *lpfc_debugfs_root = NULL;
 static atomic_t lpfc_debugfs_hba_count;
 
 /*
diff --git a/drivers/scsi/megaraid/megaraid_sas.h b/drivers/scsi/megaraid/megaraid_sas.h
index 088cc40ae866..c7940d826f41 100644
--- a/drivers/scsi/megaraid/megaraid_sas.h
+++ b/drivers/scsi/megaraid/megaraid_sas.h
@@ -2456,8 +2456,8 @@ struct megasas_instance {
 	u8 max_reset_tmo;
 	u8 snapdump_wait_time;
 #ifdef CONFIG_DEBUG_FS
-	struct dentry *debugfs_root;
-	struct dentry *raidmap_dump;
+	struct debugfs_node *debugfs_root;
+	struct debugfs_node *raidmap_dump;
 #endif
 	u8 enable_fw_dev_list;
 	bool atomic_desc_support;
diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index d85f990aec88..0fc773d7a9b7 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -216,7 +216,7 @@ static bool support_pci_lane_margining;
 /* define lock for aen poll */
 static DEFINE_SPINLOCK(poll_aen_lock);
 
-extern struct dentry *megasas_debugfs_root;
+extern struct debugfs_node *megasas_debugfs_root;
 extern int megasas_blk_mq_poll(struct Scsi_Host *shost, unsigned int queue_num);
 
 void
diff --git a/drivers/scsi/megaraid/megaraid_sas_debugfs.c b/drivers/scsi/megaraid/megaraid_sas_debugfs.c
index c69760775efa..787e3e9f89af 100644
--- a/drivers/scsi/megaraid/megaraid_sas_debugfs.c
+++ b/drivers/scsi/megaraid/megaraid_sas_debugfs.c
@@ -42,7 +42,7 @@
 #ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
 
-struct dentry *megasas_debugfs_root;
+struct debugfs_node *megasas_debugfs_root;
 
 static ssize_t
 megasas_debugfs_read(struct file *filp, char __user *ubuf, size_t cnt,
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.h b/drivers/scsi/mpt3sas/mpt3sas_base.h
index d8d1a64b4764..4a14a37ca4d2 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.h
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
@@ -1625,8 +1625,8 @@ struct MPT3SAS_ADAPTER {
 	u16		device_remove_in_progress_sz;
 	u8		is_gen35_ioc;
 	u8		is_aero_ioc;
-	struct dentry	*debugfs_root;
-	struct dentry	*ioc_dump;
+	struct debugfs_node *debugfs_root;
+	struct debugfs_node *ioc_dump;
 	PUT_SMID_IO_FP_HIP put_smid_scsi_io;
 	PUT_SMID_IO_FP_HIP put_smid_fast_path;
 	PUT_SMID_IO_FP_HIP put_smid_hi_priority;
diff --git a/drivers/scsi/mpt3sas/mpt3sas_debugfs.c b/drivers/scsi/mpt3sas/mpt3sas_debugfs.c
index a6ab1db81167..98dc07999b7f 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_debugfs.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_debugfs.c
@@ -26,7 +26,7 @@
 #include "mpt3sas_base.h"
 #include <linux/debugfs.h>
 
-static struct dentry *mpt3sas_debugfs_root;
+static struct debugfs_node *mpt3sas_debugfs_root;
 
 /*
  * _debugfs_iocdump_read - copy ioc dump from debugfs buffer
diff --git a/drivers/scsi/qedf/qedf_dbg.h b/drivers/scsi/qedf/qedf_dbg.h
index eeb6c841dacb..08608cb2ce2e 100644
--- a/drivers/scsi/qedf/qedf_dbg.h
+++ b/drivers/scsi/qedf/qedf_dbg.h
@@ -66,7 +66,7 @@ struct qedf_dbg_ctx {
 	unsigned int host_no;
 	struct pci_dev *pdev;
 #ifdef CONFIG_DEBUG_FS
-	struct dentry *bdf_dentry;
+	struct debugfs_node *bdf_dentry;
 #endif
 };
 
diff --git a/drivers/scsi/qedf/qedf_debugfs.c b/drivers/scsi/qedf/qedf_debugfs.c
index 96174353e389..13249f4e196f 100644
--- a/drivers/scsi/qedf/qedf_debugfs.c
+++ b/drivers/scsi/qedf/qedf_debugfs.c
@@ -13,7 +13,7 @@
 #include "qedf.h"
 #include "qedf_dbg.h"
 
-static struct dentry *qedf_dbg_root;
+static struct debugfs_node *qedf_dbg_root;
 
 /*
  * qedf_dbg_host_init - setup the debugfs file for the pf
diff --git a/drivers/scsi/qedi/qedi_dbg.h b/drivers/scsi/qedi/qedi_dbg.h
index 5a1ec4542183..6ae799e86b6c 100644
--- a/drivers/scsi/qedi/qedi_dbg.h
+++ b/drivers/scsi/qedi/qedi_dbg.h
@@ -64,7 +64,7 @@ struct qedi_dbg_ctx {
 	unsigned int host_no;
 	struct pci_dev *pdev;
 #ifdef CONFIG_DEBUG_FS
-	struct dentry *bdf_dentry;
+	struct debugfs_node *bdf_dentry;
 #endif
 };
 
diff --git a/drivers/scsi/qedi/qedi_debugfs.c b/drivers/scsi/qedi/qedi_debugfs.c
index 37eed6a27816..401e6dcd5968 100644
--- a/drivers/scsi/qedi/qedi_debugfs.c
+++ b/drivers/scsi/qedi/qedi_debugfs.c
@@ -12,7 +12,7 @@
 #include <linux/module.h>
 
 int qedi_do_not_recover;
-static struct dentry *qedi_dbg_root;
+static struct debugfs_node *qedi_dbg_root;
 
 void
 qedi_dbg_host_init(struct qedi_dbg_ctx *qedi,
diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index cb95b7b12051..19feba0ec5ad 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -2678,7 +2678,7 @@ typedef struct fc_port {
 	u16 n2n_link_reset_cnt;
 	u16 n2n_chip_reset;
 
-	struct dentry *dfs_rport_dir;
+	struct debugfs_node *dfs_rport_dir;
 
 	u64 tgt_short_link_down_cnt;
 	u64 tgt_link_down_time;
@@ -4036,9 +4036,9 @@ struct qlt_hw_data {
 
 	uint8_t tgt_node_name[WWN_SIZE];
 
-	struct dentry *dfs_tgt_sess;
-	struct dentry *dfs_tgt_port_database;
-	struct dentry *dfs_naqp;
+	struct debugfs_node *dfs_tgt_sess;
+	struct debugfs_node *dfs_tgt_port_database;
+	struct debugfs_node *dfs_naqp;
 
 	struct list_head q_full_list;
 	uint32_t num_pend_cmds;
@@ -4627,10 +4627,10 @@ struct qla_hw_data {
 	int		mctp_dumped;
 	int		mctp_dump_reading;
 	uint32_t	chain_offset;
-	struct dentry *dfs_dir;
-	struct dentry *dfs_fce;
-	struct dentry *dfs_tgt_counters;
-	struct dentry *dfs_fw_resource_cnt;
+	struct debugfs_node *dfs_dir;
+	struct debugfs_node *dfs_fce;
+	struct debugfs_node *dfs_tgt_counters;
+	struct debugfs_node *dfs_fw_resource_cnt;
 
 	dma_addr_t	fce_dma;
 	void		*fce;
@@ -5095,7 +5095,7 @@ typedef struct scsi_qla_host {
 	uint16_t ql2xexchoffld;
 	uint16_t ql2xiniexchg;
 
-	struct dentry *dfs_rport_root;
+	struct debugfs_node *dfs_rport_root;
 
 	struct purex_list {
 		struct list_head head;
diff --git a/drivers/scsi/qla2xxx/qla_dfs.c b/drivers/scsi/qla2xxx/qla_dfs.c
index 08273520c777..dca467e47873 100644
--- a/drivers/scsi/qla2xxx/qla_dfs.c
+++ b/drivers/scsi/qla2xxx/qla_dfs.c
@@ -8,7 +8,7 @@
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
 
-static struct dentry *qla2x00_dfs_root;
+static struct debugfs_node *qla2x00_dfs_root;
 static atomic_t qla2x00_dfs_root_count;
 
 #define QLA_DFS_RPORT_DEVLOSS_TMO	1
diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 5ceaa4665e5d..fc2dd4a0a2b4 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -363,14 +363,14 @@ struct sdebug_dev_info {
 	ktime_t create_ts;	/* time since bootup that this device was created */
 	struct sdeb_zone_state *zstate;
 
-	struct dentry *debugfs_entry;
+	struct debugfs_node *debugfs_entry;
 	struct spinlock list_lock;
 	struct list_head inject_err_list;
 };
 
 struct sdebug_target_info {
 	bool reset_fail;
-	struct dentry *debugfs_entry;
+	struct debugfs_node *debugfs_entry;
 };
 
 struct sdebug_host_info {
@@ -959,7 +959,7 @@ static const int device_qfull_result =
 
 static const int condition_met_result = SAM_STAT_CONDITION_MET;
 
-static struct dentry *sdebug_debugfs_root;
+static struct debugfs_node *sdebug_debugfs_root;
 static ASYNC_DOMAIN_EXCLUSIVE(sdebug_async_domain);
 
 static void sdebug_err_free(struct rcu_head *head)
@@ -5893,7 +5893,7 @@ static int scsi_debug_sdev_configure(struct scsi_device *sdp,
 {
 	struct sdebug_dev_info *devip =
 			(struct sdebug_dev_info *)sdp->hostdata;
-	struct dentry *dentry;
+	struct debugfs_node *dentry;
 
 	if (sdebug_verbose)
 		pr_info("sdev_configure <%u %u %u %llu>\n",
diff --git a/drivers/scsi/snic/snic.h b/drivers/scsi/snic/snic.h
index 32f5a34b6987..453e3e250a7e 100644
--- a/drivers/scsi/snic/snic.h
+++ b/drivers/scsi/snic/snic.h
@@ -318,9 +318,9 @@ struct snic {
 
 	/* platform specific */
 #ifdef CONFIG_SCSI_SNIC_DEBUG_FS
-	struct dentry *stats_host;	/* Per snic debugfs root */
-	struct dentry *stats_file;	/* Per snic debugfs file */
-	struct dentry *reset_stats_file;/* Per snic reset stats file */
+	struct debugfs_node *stats_host;	/* Per snic debugfs root */
+	struct debugfs_node *stats_file;	/* Per snic debugfs file */
+	struct debugfs_node *reset_stats_file;/* Per snic reset stats file */
 #endif
 
 	/* completion queue cache line section */
@@ -347,8 +347,8 @@ struct snic_global {
 
 #ifdef CONFIG_SCSI_SNIC_DEBUG_FS
 	/* debugfs related global data */
-	struct dentry *trc_root;
-	struct dentry *stats_root;
+	struct debugfs_node *trc_root;
+	struct debugfs_node *stats_root;
 
 	struct snic_trc trc ____cacheline_aligned;
 #endif
diff --git a/drivers/soc/amlogic/meson-clk-measure.c b/drivers/soc/amlogic/meson-clk-measure.c
index a6453ffeb753..91bd26dab4de 100644
--- a/drivers/soc/amlogic/meson-clk-measure.c
+++ b/drivers/soc/amlogic/meson-clk-measure.c
@@ -606,7 +606,7 @@ static int meson_msr_probe(struct platform_device *pdev)
 {
 	const struct meson_msr_id *match_data;
 	struct meson_msr *priv;
-	struct dentry *root, *clks;
+	struct debugfs_node *root, *clks;
 	void __iomem *base;
 	int i;
 
diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index 7c349a94b45c..2990df4fca1e 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -856,7 +856,7 @@ debug_fops_ro(status);
 static int svs_create_debug_cmds(struct svs_platform *svsp)
 {
 	struct svs_bank *svsb;
-	struct dentry *svs_dir, *svsb_dir, *file_entry;
+	struct debugfs_node *svs_dir, *svsb_dir, *file_entry;
 	const char *d = "/sys/kernel/debug/svs";
 	u32 i, idx;
 
diff --git a/drivers/soc/qcom/qcom_aoss.c b/drivers/soc/qcom/qcom_aoss.c
index 0320ad3b9148..c745cd9830f1 100644
--- a/drivers/soc/qcom/qcom_aoss.c
+++ b/drivers/soc/qcom/qcom_aoss.c
@@ -90,8 +90,8 @@ struct qmp {
 
 	struct clk_hw qdss_clk;
 	struct qmp_cooling_device *cooling_devs;
-	struct dentry *debugfs_root;
-	struct dentry *debugfs_files[QMP_DEBUGFS_FILES];
+	struct debugfs_node *debugfs_root;
+	struct debugfs_node *debugfs_files[QMP_DEBUGFS_FILES];
 };
 
 static void qmp_kick(struct qmp *qmp)
diff --git a/drivers/soc/qcom/qcom_stats.c b/drivers/soc/qcom/qcom_stats.c
index 5de99cf59b9f..c78112c5b33d 100644
--- a/drivers/soc/qcom/qcom_stats.c
+++ b/drivers/soc/qcom/qcom_stats.c
@@ -125,7 +125,8 @@ static int qcom_soc_sleep_stats_show(struct seq_file *s, void *unused)
 DEFINE_SHOW_ATTRIBUTE(qcom_soc_sleep_stats);
 DEFINE_SHOW_ATTRIBUTE(qcom_subsystem_sleep_stats);
 
-static void qcom_create_soc_sleep_stat_files(struct dentry *root, void __iomem *reg,
+static void qcom_create_soc_sleep_stat_files(struct debugfs_node *root,
+					     void __iomem *reg,
 					     struct stats_data *d,
 					     const struct stats_config *config)
 {
@@ -171,7 +172,7 @@ static void qcom_create_soc_sleep_stat_files(struct dentry *root, void __iomem *
 	}
 }
 
-static void qcom_create_subsystem_stat_files(struct dentry *root,
+static void qcom_create_subsystem_stat_files(struct debugfs_node *root,
 					     const struct stats_config *config)
 {
 	int i;
@@ -187,7 +188,7 @@ static void qcom_create_subsystem_stat_files(struct dentry *root,
 static int qcom_stats_probe(struct platform_device *pdev)
 {
 	void __iomem *reg;
-	struct dentry *root;
+	struct debugfs_node *root;
 	const struct stats_config *config;
 	struct stats_data *d;
 	int i;
@@ -222,7 +223,7 @@ static int qcom_stats_probe(struct platform_device *pdev)
 
 static void qcom_stats_remove(struct platform_device *pdev)
 {
-	struct dentry *root = platform_get_drvdata(pdev);
+	struct debugfs_node *root = platform_get_drvdata(pdev);
 
 	debugfs_remove_recursive(root);
 }
diff --git a/drivers/soc/qcom/rpm_master_stats.c b/drivers/soc/qcom/rpm_master_stats.c
index 49e4f9457279..9dbab3ac0374 100644
--- a/drivers/soc/qcom/rpm_master_stats.c
+++ b/drivers/soc/qcom/rpm_master_stats.c
@@ -70,7 +70,7 @@ static int master_stats_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct master_stats_data *data;
 	struct device_node *msgram_np;
-	struct dentry *dent, *root;
+	struct debugfs_node *dent, *root;
 	struct resource res;
 	int count, i, ret;
 
@@ -139,7 +139,7 @@ static int master_stats_probe(struct platform_device *pdev)
 
 static void master_stats_remove(struct platform_device *pdev)
 {
-	struct dentry *root = platform_get_drvdata(pdev);
+	struct debugfs_node *root = platform_get_drvdata(pdev);
 
 	debugfs_remove_recursive(root);
 }
diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 18d7f1be9093..fbb477439096 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -167,7 +167,7 @@ struct qcom_socinfo {
 	struct soc_device *soc_dev;
 	struct soc_device_attribute attr;
 #ifdef CONFIG_DEBUG_FS
-	struct dentry *dbg_root;
+	struct debugfs_node *dbg_root;
 	struct socinfo_params info;
 #endif /* CONFIG_DEBUG_FS */
 };
@@ -593,7 +593,7 @@ static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo,
 				 struct socinfo *info, size_t info_size)
 {
 	struct smem_image_version *versions;
-	struct dentry *dentry;
+	struct debugfs_node *dentry;
 	size_t size;
 	int i;
 	unsigned int num_pmics;
diff --git a/drivers/soc/tegra/cbb/tegra-cbb.c b/drivers/soc/tegra/cbb/tegra-cbb.c
index 6215c6a84fbe..bdfba69bc3d0 100644
--- a/drivers/soc/tegra/cbb/tegra-cbb.c
+++ b/drivers/soc/tegra/cbb/tegra-cbb.c
@@ -71,7 +71,7 @@ DEFINE_SHOW_ATTRIBUTE(tegra_cbb_err);
 
 static void tegra_cbb_err_debugfs_init(struct tegra_cbb *cbb)
 {
-	static struct dentry *root;
+	static struct debugfs_node *root;
 
 	if (!root)
 		root = debugfs_create_file("tegra_cbb_err", 0444, NULL, cbb, &tegra_cbb_err_fops);
diff --git a/drivers/soc/ti/smartreflex.c b/drivers/soc/ti/smartreflex.c
index ced3a73929e3..5629ca87e146 100644
--- a/drivers/soc/ti/smartreflex.c
+++ b/drivers/soc/ti/smartreflex.c
@@ -34,7 +34,7 @@
 static LIST_HEAD(sr_list);
 
 static struct omap_sr_class_data *sr_class;
-static struct dentry		*sr_dbg_dir;
+static struct debugfs_node		*sr_dbg_dir;
 
 static inline void sr_write_reg(struct omap_sr *sr, unsigned offset, u32 value)
 {
@@ -815,7 +815,7 @@ static int omap_sr_probe(struct platform_device *pdev)
 {
 	struct omap_sr *sr_info;
 	struct omap_sr_data *pdata = pdev->dev.platform_data;
-	struct dentry *nvalue_dir;
+	struct debugfs_node *nvalue_dir;
 	int i, ret = 0;
 
 	sr_info = devm_kzalloc(&pdev->dev, sizeof(struct omap_sr), GFP_KERNEL);
diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index f367670ea991..fe2a632410dd 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -532,7 +532,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(cdns_pdi_loopback_target_fops, NULL, cdns_set_pdi_loopb
  * @cdns: Cadence instance
  * @root: debugfs root
  */
-void sdw_cdns_debugfs_init(struct sdw_cdns *cdns, struct dentry *root)
+void sdw_cdns_debugfs_init(struct sdw_cdns *cdns, struct debugfs_node *root)
 {
 	debugfs_create_file("cdns-registers", 0400, root, cdns, &cdns_reg_fops);
 
diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index c34fb050fe4f..cc770fa9bc5d 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -180,7 +180,7 @@ int sdw_cdns_clock_stop(struct sdw_cdns *cdns, bool block_wake);
 int sdw_cdns_clock_restart(struct sdw_cdns *cdns, bool bus_reset);
 
 #ifdef CONFIG_DEBUG_FS
-void sdw_cdns_debugfs_init(struct sdw_cdns *cdns, struct dentry *root);
+void sdw_cdns_debugfs_init(struct sdw_cdns *cdns, struct debugfs_node *root);
 #endif
 
 struct sdw_cdns_pdi *sdw_cdns_alloc_pdi(struct sdw_cdns *cdns,
diff --git a/drivers/soundwire/debugfs.c b/drivers/soundwire/debugfs.c
index c30f571934ee..a58a62bb6c5e 100644
--- a/drivers/soundwire/debugfs.c
+++ b/drivers/soundwire/debugfs.c
@@ -12,7 +12,7 @@
 #include <linux/soundwire/sdw_registers.h>
 #include "bus.h"
 
-static struct dentry *sdw_debugfs_root;
+static struct debugfs_node *sdw_debugfs_root;
 
 void sdw_bus_debugfs_init(struct sdw_bus *bus)
 {
@@ -276,8 +276,8 @@ DEFINE_SHOW_ATTRIBUTE(read_buffer);
 
 void sdw_slave_debugfs_init(struct sdw_slave *slave)
 {
-	struct dentry *master;
-	struct dentry *d;
+	struct debugfs_node *master;
+	struct debugfs_node *d;
 	char name[32];
 
 	master = slave->bus->debugfs;
diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 9db78f3d7615..a8bcb9e4c0ea 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -172,7 +172,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(intel_set_s_datamode_fops, NULL,
 
 static void intel_debugfs_init(struct sdw_intel *sdw)
 {
-	struct dentry *root = sdw->cdns.bus.debugfs;
+	struct debugfs_node *root = sdw->cdns.bus.debugfs;
 
 	if (!root)
 		return;
diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
index dddd29381441..c9729efba610 100644
--- a/drivers/soundwire/intel.h
+++ b/drivers/soundwire/intel.h
@@ -54,7 +54,7 @@ struct sdw_intel {
 	struct sdw_intel_link_res *link_res;
 	bool startup_done;
 #ifdef CONFIG_DEBUG_FS
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 #endif
 };
 
diff --git a/drivers/soundwire/intel_ace2x_debugfs.c b/drivers/soundwire/intel_ace2x_debugfs.c
index 206a8d511ebd..7b41ba0501be 100644
--- a/drivers/soundwire/intel_ace2x_debugfs.c
+++ b/drivers/soundwire/intel_ace2x_debugfs.c
@@ -121,7 +121,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(intel_set_s_datamode_fops, NULL,
 
 void intel_ace2x_debugfs_init(struct sdw_intel *sdw)
 {
-	struct dentry *root = sdw->cdns.bus.debugfs;
+	struct debugfs_node *root = sdw->cdns.bus.debugfs;
 
 	if (!root)
 		return;
diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 0f45e3404756..2ea9a7d2692f 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -183,7 +183,7 @@ struct qcom_swrm_ctrl {
 	void __iomem *mmio;
 	struct reset_control *audio_cgcr;
 #ifdef CONFIG_DEBUG_FS
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 #endif
 	struct completion broadcast;
 	struct completion enumeration;
diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 0d1aa6592484..3f4625c080ec 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -133,7 +133,7 @@ struct bcm2835_spi {
 	int rx_prologue;
 	unsigned int tx_spillover;
 
-	struct dentry *debugfs_dir;
+	struct debugfs_node *debugfs_dir;
 	u64 count_transfer_polling;
 	u64 count_transfer_irq;
 	u64 count_transfer_irq_after_polling;
@@ -168,7 +168,7 @@ static void bcm2835_debugfs_create(struct bcm2835_spi *bs,
 				   const char *dname)
 {
 	char name[64];
-	struct dentry *dir;
+	struct debugfs_node *dir;
 
 	/* get full name */
 	snprintf(name, sizeof(name), "spi-bcm2835-%s", dname);
diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index 90698d7d809d..e03a439e5f30 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -98,7 +98,7 @@ struct bcm2835aux_spi {
 	u64 count_transfer_irq;
 	u64 count_transfer_irq_after_poll;
 
-	struct dentry *debugfs_dir;
+	struct debugfs_node *debugfs_dir;
 };
 
 #if defined(CONFIG_DEBUG_FS)
@@ -106,7 +106,7 @@ static void bcm2835aux_debugfs_create(struct bcm2835aux_spi *bs,
 				      const char *dname)
 {
 	char name[64];
-	struct dentry *dir;
+	struct debugfs_node *dir;
 
 	/* get full name */
 	snprintf(name, sizeof(name), "spi-bcm2835aux-%s", dname);
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index fc267c6437ae..01d97ddaa717 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -197,7 +197,7 @@ struct dw_spi {
 	struct completion	dma_completion;
 
 #ifdef CONFIG_DEBUG_FS
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 	struct debugfs_regset32 regset;
 #endif
 };
diff --git a/drivers/spi/spi-hisi-kunpeng.c b/drivers/spi/spi-hisi-kunpeng.c
index dadf558dd9c0..8e0adffbb279 100644
--- a/drivers/spi/spi-hisi-kunpeng.c
+++ b/drivers/spi/spi-hisi-kunpeng.c
@@ -135,7 +135,7 @@ struct hisi_spi {
 	unsigned int		rx_len;
 	u8			n_bytes; /* current is a 1/2/4 bytes op */
 
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 	struct debugfs_regset32 regset;
 };
 
diff --git a/drivers/staging/greybus/loopback.c b/drivers/staging/greybus/loopback.c
index 1f19323b0e1a..2b0d6245c93c 100644
--- a/drivers/staging/greybus/loopback.c
+++ b/drivers/staging/greybus/loopback.c
@@ -38,7 +38,7 @@ struct gb_loopback_stats {
 };
 
 struct gb_loopback_device {
-	struct dentry *root;
+	struct debugfs_node *root;
 	u32 count;
 	size_t size_max;
 
@@ -59,7 +59,7 @@ struct gb_loopback_async_operation {
 struct gb_loopback {
 	struct gb_connection *connection;
 
-	struct dentry *file;
+	struct debugfs_node *file;
 	struct kfifo kfifo_lat;
 	struct mutex mutex;
 	struct task_struct *task;
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
index d5f7f61c5626..d5aeea59039f 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
@@ -14,8 +14,8 @@
 #define DEBUGFS_WRITE_BUF_SIZE 256
 
 /* Global 'vchiq' debugfs and clients entry used by all instances */
-static struct dentry *vchiq_dbg_dir;
-static struct dentry *vchiq_dbg_clients;
+static struct debugfs_node *vchiq_dbg_dir;
+static struct debugfs_node *vchiq_dbg_clients;
 
 static int debugfs_usecount_show(struct seq_file *f, void *offset)
 {
@@ -99,7 +99,7 @@ static const struct file_operations debugfs_trace_fops = {
 void vchiq_debugfs_add_instance(struct vchiq_instance *instance)
 {
 	char pidstr[16];
-	struct dentry *top;
+	struct debugfs_node *top;
 
 	snprintf(pidstr, sizeof(pidstr), "%d",
 		 vchiq_instance_get_pid(instance));
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.h
index b29e6693c949..d7bc43b52b76 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.h
@@ -8,7 +8,7 @@ struct vchiq_state;
 struct vchiq_instance;
 
 struct vchiq_debugfs_node {
-	struct dentry *dentry;
+	struct debugfs_node *dentry;
 };
 
 void vchiq_debugfs_init(struct vchiq_state *state);
diff --git a/drivers/thermal/broadcom/bcm2835_thermal.c b/drivers/thermal/broadcom/bcm2835_thermal.c
index 7fbba2233c4c..5d5c90304ab3 100644
--- a/drivers/thermal/broadcom/bcm2835_thermal.c
+++ b/drivers/thermal/broadcom/bcm2835_thermal.c
@@ -67,7 +67,7 @@ struct bcm2835_thermal_data {
 	struct thermal_zone_device *tz;
 	void __iomem *regs;
 	struct clk *clk;
-	struct dentry *debugfsdir;
+	struct debugfs_node *debugfsdir;
 };
 
 static int bcm2835_thermal_adc2temp(u32 adc, int offset, int slope)
diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
index 96a24df79686..5c1c06fbc7d3 100644
--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -49,7 +49,7 @@
  */
 #define DEFAULT_DURATION_JIFFIES (6)
 
-static struct dentry *debug_dir;
+static struct debugfs_node *debug_dir;
 static bool poll_pkg_cstate_enable;
 
 /* Idle ratio observed using package C-state counters */
diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/thermal/intel/x86_pkg_temp_thermal.c
index 496abf8e55e0..d333a82774d1 100644
--- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@ -73,7 +73,7 @@ static DEFINE_MUTEX(thermal_zone_mutex);
 static enum cpuhp_state pkg_thermal_hp_state __read_mostly;
 
 /* Debug counters to show using debugfs */
-static struct dentry *debugfs;
+static struct debugfs_node *debugfs;
 static unsigned int pkg_interrupt_cnt;
 static unsigned int pkg_work_cnt;
 
diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 07f7f3b7a2fb..8ceeaad8ea35 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -162,7 +162,7 @@ struct lvts_domain {
 	size_t calib_len;
 	u8 *calib;
 #ifdef CONFIG_DEBUG_FS
-	struct dentry *dom_dentry;
+	struct debugfs_node *dom_dentry;
 #endif
 };
 
@@ -217,7 +217,7 @@ static int lvts_debugfs_init(struct device *dev, struct lvts_domain *lvts_td)
 {
 	struct debugfs_regset32 *regset;
 	struct lvts_ctrl *lvts_ctrl;
-	struct dentry *dentry;
+	struct debugfs_node *dentry;
 	char name[64];
 	int i;
 
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 7b36a0318fa6..e2496ee8cdbf 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -582,8 +582,8 @@ struct tsens_priv {
 	const struct reg_field		*fields;
 	const struct tsens_ops		*ops;
 
-	struct dentry			*debug_root;
-	struct dentry			*debug;
+	struct debugfs_node *debug_root;
+	struct debugfs_node *debug;
 
 	struct tsens_sensor		sensor[] __counted_by(num_sensors);
 };
diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 2c5ddf0db40c..cbd3dcec64bf 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -343,7 +343,7 @@ struct tegra_soctherm {
 
 	struct soctherm_throt_cfg throt_cfgs[THROTTLE_SIZE];
 
-	struct dentry *debugfs_dir;
+	struct debugfs_node *debugfs_dir;
 
 	struct mutex thermctl_lock;
 };
@@ -1449,7 +1449,7 @@ DEFINE_SHOW_ATTRIBUTE(regs);
 static void soctherm_debug_init(struct platform_device *pdev)
 {
 	struct tegra_soctherm *tegra = platform_get_drvdata(pdev);
-	struct dentry *root;
+	struct debugfs_node *root;
 
 	root = debugfs_create_dir("soctherm", NULL);
 
diff --git a/drivers/thermal/testing/command.c b/drivers/thermal/testing/command.c
index ba11d70e8021..49313e215e3a 100644
--- a/drivers/thermal/testing/command.c
+++ b/drivers/thermal/testing/command.c
@@ -86,7 +86,7 @@
 
 #include "thermal_testing.h"
 
-struct dentry *d_testing;
+struct debugfs_node *d_testing;
 
 #define TT_COMMAND_SIZE		16
 
diff --git a/drivers/thermal/testing/thermal_testing.h b/drivers/thermal/testing/thermal_testing.h
index c790a32aae4e..2d4d954b3119 100644
--- a/drivers/thermal/testing/thermal_testing.h
+++ b/drivers/thermal/testing/thermal_testing.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
-extern struct dentry *d_testing;
+extern struct debugfs_node *d_testing;
 
 int tt_add_tz(void);
 int tt_del_tz(const char *arg);
diff --git a/drivers/thermal/testing/zone.c b/drivers/thermal/testing/zone.c
index 1f4e450100e2..db5e6a0006b0 100644
--- a/drivers/thermal/testing/zone.c
+++ b/drivers/thermal/testing/zone.c
@@ -40,7 +40,7 @@
 struct tt_thermal_zone {
 	struct list_head list_node;
 	struct list_head trips;
-	struct dentry *d_tt_zone;
+	struct debugfs_node *d_tt_zone;
 	struct thermal_zone_device *tz;
 	struct mutex lock;
 	struct ida ida;
diff --git a/drivers/thermal/thermal_debugfs.c b/drivers/thermal/thermal_debugfs.c
index c800504c3cfe..6691b4aea9c8 100644
--- a/drivers/thermal/thermal_debugfs.c
+++ b/drivers/thermal/thermal_debugfs.c
@@ -15,9 +15,9 @@
 
 #include "thermal_core.h"
 
-static struct dentry *d_root;
-static struct dentry *d_cdev;
-static struct dentry *d_tz;
+static struct debugfs_node *d_root;
+static struct debugfs_node *d_cdev;
+static struct debugfs_node *d_tz;
 
 /*
  * Length of the string containing the thermal zone id or the cooling
@@ -167,7 +167,7 @@ struct tz_debugfs {
  * @tz_dbg: a thermal zone debug structure
  */
 struct thermal_debugfs {
-	struct dentry *d_top;
+	struct debugfs_node *d_top;
 	struct mutex lock;
 	union {
 		struct cdev_debugfs cdev_dbg;
@@ -188,7 +188,8 @@ void thermal_debug_init(void)
 	d_tz = debugfs_create_dir("thermal_zones", d_root);
 }
 
-static struct thermal_debugfs *thermal_debugfs_add_id(struct dentry *d, int id)
+static struct thermal_debugfs *thermal_debugfs_add_id(struct debugfs_node *d,
+						      int id)
 {
 	struct thermal_debugfs *thermal_dbg;
 	char ids[IDSLENGTH];
diff --git a/drivers/thunderbolt/debugfs.c b/drivers/thunderbolt/debugfs.c
index f8328ca7e22e..f0d811a685f0 100644
--- a/drivers/thunderbolt/debugfs.c
+++ b/drivers/thunderbolt/debugfs.c
@@ -121,7 +121,7 @@ static const struct file_operations __space ## _fops = {		\
 #define DEBUGFS_ATTR_RW(__space)					\
 	DEBUGFS_ATTR(__space, __space ## _write)
 
-static struct dentry *tb_debugfs_root;
+static struct debugfs_node *tb_debugfs_root;
 
 static void *validate_and_copy_from_user(const void __user *user_buf,
 					 size_t *count)
@@ -1643,10 +1643,11 @@ DEBUGFS_ATTR_RW(margining_eye);
 static struct tb_margining *margining_alloc(struct tb_port *port,
 					    struct device *dev,
 					    enum usb4_sb_target target,
-					    u8 index, struct dentry *parent)
+					    u8 index,
+					    struct debugfs_node *parent)
 {
 	struct tb_margining *margining;
-	struct dentry *dir;
+	struct debugfs_node *dir;
 	unsigned int val;
 	int ret;
 
@@ -1759,7 +1760,7 @@ static struct tb_margining *margining_alloc(struct tb_port *port,
 
 static void margining_port_init(struct tb_port *port)
 {
-	struct dentry *parent;
+	struct debugfs_node *parent;
 	char dir_name[10];
 
 	if (!port->usb4)
@@ -1774,7 +1775,7 @@ static void margining_port_init(struct tb_port *port)
 
 static void margining_port_remove(struct tb_port *port)
 {
-	struct dentry *parent;
+	struct debugfs_node *parent;
 	char dir_name[10];
 
 	if (!port->usb4)
@@ -1844,7 +1845,8 @@ static void margining_xdomain_remove(struct tb_xdomain *xd)
 	margining_port_remove(downstream);
 }
 
-static void margining_retimer_init(struct tb_retimer *rt, struct dentry *debugfs_dir)
+static void margining_retimer_init(struct tb_retimer *rt,
+				   struct debugfs_node *debugfs_dir)
 {
 	rt->margining = margining_alloc(rt->port, &rt->dev,
 					USB4_SB_TARGET_RETIMER, rt->index,
@@ -1862,7 +1864,7 @@ static inline void margining_switch_remove(struct tb_switch *sw) { }
 static inline void margining_xdomain_init(struct tb_xdomain *xd) { }
 static inline void margining_xdomain_remove(struct tb_xdomain *xd) { }
 static inline void margining_retimer_init(struct tb_retimer *rt,
-					  struct dentry *debugfs_dir) { }
+					  struct debugfs_node *debugfs_dir) { }
 static inline void margining_retimer_remove(struct tb_retimer *rt) { }
 #endif
 
@@ -2406,7 +2408,7 @@ DEBUGFS_ATTR_RW(port_sb_regs);
  */
 void tb_switch_debugfs_init(struct tb_switch *sw)
 {
-	struct dentry *debugfs_dir;
+	struct debugfs_node *debugfs_dir;
 	struct tb_port *port;
 
 	debugfs_dir = debugfs_create_dir(dev_name(&sw->dev), tb_debugfs_root);
@@ -2417,7 +2419,7 @@ void tb_switch_debugfs_init(struct tb_switch *sw)
 		debugfs_create_blob("drom", 0400, debugfs_dir, &sw->drom_blob);
 
 	tb_switch_for_each_port(sw, port) {
-		struct dentry *debugfs_dir;
+		struct debugfs_node *debugfs_dir;
 		char dir_name[10];
 
 		if (port->disabled)
@@ -2521,7 +2523,7 @@ DEBUGFS_ATTR_RW(retimer_sb_regs);
  */
 void tb_retimer_debugfs_init(struct tb_retimer *rt)
 {
-	struct dentry *debugfs_dir;
+	struct debugfs_node *debugfs_dir;
 
 	debugfs_dir = debugfs_create_dir(dev_name(&rt->dev), tb_debugfs_root);
 	debugfs_create_file("sb_regs", DEBUGFS_MODE, debugfs_dir, rt,
diff --git a/drivers/thunderbolt/dma_test.c b/drivers/thunderbolt/dma_test.c
index 9e47a63f28e7..eb9b61c53db2 100644
--- a/drivers/thunderbolt/dma_test.c
+++ b/drivers/thunderbolt/dma_test.c
@@ -108,7 +108,7 @@ struct dma_test {
 	enum dma_test_test_error error_code;
 	struct completion complete;
 	struct mutex lock;
-	struct dentry *debugfs_dir;
+	struct debugfs_node *debugfs_dir;
 };
 
 /* DMA test property directory UUID: 3188cd10-6523-4a5a-a682-fdca07a248d8 */
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index b54147a1ba87..3b5daac2986c 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -199,7 +199,7 @@ struct tb_switch {
 	bool rpm;
 	unsigned int authorized;
 	enum tb_security_level security_level;
-	struct dentry *debugfs_dir;
+	struct debugfs_node *debugfs_dir;
 	u8 *key;
 	u8 connection_id;
 	u8 connection_key;
diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
index d0b18358859e..cb14b1971ea8 100644
--- a/drivers/tty/serial/8250/8250_bcm7271.c
+++ b/drivers/tty/serial/8250/8250_bcm7271.c
@@ -225,7 +225,7 @@ struct brcmuart_priv {
 	size_t		tx_size;
 	bool		tx_running;
 	bool		rx_running;
-	struct dentry	*debugfs_dir;
+	struct debugfs_node *debugfs_dir;
 
 	/* stats exposed through debugfs */
 	u64		dma_rx_partial_buf;
@@ -239,7 +239,7 @@ struct brcmuart_priv {
 	u32		saved_mctrl;
 };
 
-static struct dentry *brcmuart_debugfs_root;
+static struct debugfs_node *brcmuart_debugfs_root;
 
 /*
  * Register access routines
diff --git a/drivers/ufs/core/ufs-debugfs.c b/drivers/ufs/core/ufs-debugfs.c
index e3baed6c70bd..eefa511740be 100644
--- a/drivers/ufs/core/ufs-debugfs.c
+++ b/drivers/ufs/core/ufs-debugfs.c
@@ -7,7 +7,7 @@
 #include <ufs/ufshcd.h>
 #include "ufshcd-priv.h"
 
-static struct dentry *ufs_debugfs_root;
+static struct debugfs_node *ufs_debugfs_root;
 
 struct ufs_debugfs_attr {
 	const char			*name;
@@ -212,7 +212,7 @@ static const struct ufs_debugfs_attr ufs_attrs[] = {
 void ufs_debugfs_hba_init(struct ufs_hba *hba)
 {
 	const struct ufs_debugfs_attr *attr;
-	struct dentry *root;
+	struct debugfs_node *root;
 
 	/* Set default exception event rate limit period to 20ms */
 	hba->debugfs_ee_rate_limit_ms = 20;
@@ -222,7 +222,7 @@ void ufs_debugfs_hba_init(struct ufs_hba *hba)
 	if (IS_ERR_OR_NULL(root))
 		return;
 	hba->debugfs_root = root;
-	d_inode(root)->i_private = hba;
+	debugfs_node_inode(root)->i_private = hba;
 	for (attr = ufs_attrs; attr->name; attr++)
 		debugfs_create_file(attr->name, attr->mode, root, (void *)attr,
 				    attr->fops);
diff --git a/drivers/ufs/host/ufshcd-pci.c b/drivers/ufs/host/ufshcd-pci.c
index 9cfcaad23cf9..cff99cc79b27 100644
--- a/drivers/ufs/host/ufshcd-pci.c
+++ b/drivers/ufs/host/ufshcd-pci.c
@@ -36,7 +36,7 @@ struct intel_host {
 	u32		dsm_fns;
 	u32		active_ltr;
 	u32		idle_ltr;
-	struct dentry	*debugfs_root;
+	struct debugfs_node *debugfs_root;
 	struct gpio_desc *reset_gpio;
 };
 
@@ -291,7 +291,7 @@ static void intel_ltr_hide(struct device *dev)
 
 static void intel_add_debugfs(struct ufs_hba *hba)
 {
-	struct dentry *dir = debugfs_create_dir(dev_name(hba->dev), NULL);
+	struct debugfs_node *dir = debugfs_create_dir(dev_name(hba->dev), NULL);
 	struct intel_host *host = ufshcd_get_variant(hba);
 
 	intel_cache_ltr(hba);
diff --git a/drivers/usb/chipidea/debug.c b/drivers/usb/chipidea/debug.c
index e72c43615d77..d925326068db 100644
--- a/drivers/usb/chipidea/debug.c
+++ b/drivers/usb/chipidea/debug.c
@@ -288,7 +288,7 @@ DEFINE_SHOW_ATTRIBUTE(ci_registers);
  */
 void dbg_create_files(struct ci_hdrc *ci)
 {
-	struct dentry *dir;
+	struct debugfs_node *dir;
 
 	dir = debugfs_create_dir(dev_name(ci->dev), usb_debug_root);
 
diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
index fc0845f681be..b74f0dccd56b 100644
--- a/drivers/usb/common/common.c
+++ b/drivers/usb/common/common.c
@@ -426,7 +426,7 @@ struct device *usb_of_get_companion_dev(struct device *dev)
 EXPORT_SYMBOL_GPL(usb_of_get_companion_dev);
 #endif
 
-struct dentry *usb_debug_root;
+struct debugfs_node *usb_debug_root;
 EXPORT_SYMBOL_GPL(usb_debug_root);
 
 DEFINE_MUTEX(usb_dynids_lock);
diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
index 4a2ee447b213..9c446137ae24 100644
--- a/drivers/usb/common/ulpi.c
+++ b/drivers/usb/common/ulpi.c
@@ -271,12 +271,12 @@ static int ulpi_regs_show(struct seq_file *seq, void *data)
 }
 DEFINE_SHOW_ATTRIBUTE(ulpi_regs);
 
-static struct dentry *ulpi_root;
+static struct debugfs_node *ulpi_root;
 
 static int ulpi_register(struct device *dev, struct ulpi *ulpi)
 {
 	int ret;
-	struct dentry *root;
+	struct debugfs_node *root;
 
 	ulpi->dev.parent = dev; /* needed early for ops */
 	ulpi->dev.bus = &ulpi_bus;
diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index 2bd74f3033ed..15b4a65ba7d0 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -124,7 +124,7 @@ struct dwc2_hsotg_ep {
 	struct list_head        queue;
 	struct dwc2_hsotg       *parent;
 	struct dwc2_hsotg_req    *req;
-	struct dentry           *debugfs;
+	struct debugfs_node *debugfs;
 
 	unsigned long           total_data;
 	unsigned int            size_loaded;
@@ -1099,7 +1099,7 @@ struct dwc2_hsotg {
 	struct dwc2_dregs_backup dr_backup;
 	struct dwc2_hregs_backup hr_backup;
 
-	struct dentry *debug_root;
+	struct debugfs_node *debug_root;
 	struct debugfs_regset32 *regset;
 	bool needs_byte_swap;
 
diff --git a/drivers/usb/dwc2/debugfs.c b/drivers/usb/dwc2/debugfs.c
index 3116ac72747f..eee41ec06fd8 100644
--- a/drivers/usb/dwc2/debugfs.c
+++ b/drivers/usb/dwc2/debugfs.c
@@ -291,7 +291,7 @@ DEFINE_SHOW_ATTRIBUTE(ep);
  */
 static void dwc2_hsotg_create_debug(struct dwc2_hsotg *hsotg)
 {
-	struct dentry *root;
+	struct debugfs_node *root;
 	unsigned int epidx;
 
 	root = hsotg->debug_root;
@@ -775,7 +775,7 @@ DEFINE_SHOW_ATTRIBUTE(dr_mode);
 int dwc2_debugfs_init(struct dwc2_hsotg *hsotg)
 {
 	int			ret;
-	struct dentry		*root;
+	struct debugfs_node		*root;
 
 	root = debugfs_create_dir(dev_name(hsotg->dev), usb_debug_root);
 	hsotg->debug_root = root;
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index ac7c730f81ac..6b11eb106733 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1391,7 +1391,7 @@ struct dwc3 {
 	int			max_cfg_eps;
 	int			last_fifo_depth;
 	int			num_ep_resized;
-	struct dentry		*debug_root;
+	struct debugfs_node *debug_root;
 	u32			gsbuscfg0_reqinfo;
 };
 
diff --git a/drivers/usb/dwc3/debugfs.c b/drivers/usb/dwc3/debugfs.c
index ebf03468fac4..9efa427380a6 100644
--- a/drivers/usb/dwc3/debugfs.c
+++ b/drivers/usb/dwc3/debugfs.c
@@ -988,7 +988,7 @@ static const struct dwc3_ep_file_map dwc3_ep_file_map[] = {
 
 void dwc3_debugfs_create_endpoint_dir(struct dwc3_ep *dep)
 {
-	struct dentry		*dir;
+	struct debugfs_node		*dir;
 	int			i;
 
 	dir = debugfs_create_dir(dep->name, dep->dwc->debug_root);
@@ -1007,7 +1007,7 @@ void dwc3_debugfs_remove_endpoint_dir(struct dwc3_ep *dep)
 
 void dwc3_debugfs_init(struct dwc3 *dwc)
 {
-	struct dentry		*root;
+	struct debugfs_node		*root;
 
 	dwc->regset = kzalloc(sizeof(*dwc->regset), GFP_KERNEL);
 	if (!dwc->regset)
diff --git a/drivers/usb/fotg210/fotg210-hcd.c b/drivers/usb/fotg210/fotg210-hcd.c
index 3d404d19a205..e07d3ab2bc98 100644
--- a/drivers/usb/fotg210/fotg210-hcd.c
+++ b/drivers/usb/fotg210/fotg210-hcd.c
@@ -308,7 +308,7 @@ static const struct file_operations debug_registers_fops = {
 	.llseek		= default_llseek,
 };
 
-static struct dentry *fotg210_debug_root;
+static struct debugfs_node *fotg210_debug_root;
 
 struct debug_buffer {
 	ssize_t (*fill_func)(struct debug_buffer *);	/* fill method */
@@ -839,7 +839,7 @@ static int debug_registers_open(struct inode *inode, struct file *file)
 static inline void create_debug_files(struct fotg210_hcd *fotg210)
 {
 	struct usb_bus *bus = &fotg210_to_hcd(fotg210)->self;
-	struct dentry *root;
+	struct debugfs_node *root;
 
 	root = debugfs_create_dir(bus->bus_name, fotg210_debug_root);
 
diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index 0c6f2ad81d37..4372e5024867 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -202,7 +202,7 @@ static const struct file_operations regs_dbg_fops = {
 static void usba_ep_init_debugfs(struct usba_udc *udc,
 		struct usba_ep *ep)
 {
-	struct dentry *ep_root;
+	struct debugfs_node *ep_root;
 
 	ep_root = debugfs_create_dir(ep->ep.name, udc->debugfs_root);
 	ep->debugfs_dir = ep_root;
@@ -222,7 +222,7 @@ static void usba_ep_cleanup_debugfs(struct usba_ep *ep)
 
 static void usba_init_debugfs(struct usba_udc *udc)
 {
-	struct dentry *root;
+	struct debugfs_node *root;
 	struct resource *regs_resource;
 
 	root = debugfs_create_dir(udc->gadget.name, usb_debug_root);
diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.h b/drivers/usb/gadget/udc/atmel_usba_udc.h
index 620472f218bc..909e5884849c 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.h
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.h
@@ -286,7 +286,7 @@ struct usba_ep {
 	unsigned long				ept_cfg;
 #ifdef CONFIG_USB_GADGET_DEBUG_FS
 	u32					last_dma_status;
-	struct dentry				*debugfs_dir;
+	struct debugfs_node *debugfs_dir;
 #endif
 };
 
@@ -354,7 +354,7 @@ struct usba_udc {
 	u32 int_enb_cache;
 
 #ifdef CONFIG_USB_GADGET_DEBUG_FS
-	struct dentry *debugfs_root;
+	struct debugfs_node *debugfs_root;
 #endif
 
 	struct regmap *pmc;
diff --git a/drivers/usb/gadget/udc/bcm63xx_udc.c b/drivers/usb/gadget/udc/bcm63xx_udc.c
index 502612a5650e..75feb476f0a9 100644
--- a/drivers/usb/gadget/udc/bcm63xx_udc.c
+++ b/drivers/usb/gadget/udc/bcm63xx_udc.c
@@ -2235,7 +2235,7 @@ DEFINE_SHOW_ATTRIBUTE(bcm63xx_iudma_dbg);
  */
 static void bcm63xx_udc_init_debugfs(struct bcm63xx_udc *udc)
 {
-	struct dentry *root;
+	struct debugfs_node *root;
 
 	if (!IS_ENABLED(CONFIG_USB_GADGET_DEBUG_FS))
 		return;
diff --git a/drivers/usb/gadget/udc/gr_udc.c b/drivers/usb/gadget/udc/gr_udc.c
index bf5b3c964c18..e8a63bb6fbba 100644
--- a/drivers/usb/gadget/udc/gr_udc.c
+++ b/drivers/usb/gadget/udc/gr_udc.c
@@ -206,7 +206,7 @@ DEFINE_SHOW_ATTRIBUTE(gr_dfs);
 static void gr_dfs_create(struct gr_udc *dev)
 {
 	const char *name = "gr_udc_state";
-	struct dentry *root;
+	struct debugfs_node *root;
 
 	root = debugfs_create_dir(dev_name(dev->dev), usb_debug_root);
 	debugfs_create_file(name, 0444, root, dev, &gr_dfs_fops);
diff --git a/drivers/usb/gadget/udc/pxa27x_udc.c b/drivers/usb/gadget/udc/pxa27x_udc.c
index 897f53601b5b..1b6f8a0d10b8 100644
--- a/drivers/usb/gadget/udc/pxa27x_udc.c
+++ b/drivers/usb/gadget/udc/pxa27x_udc.c
@@ -205,7 +205,7 @@ DEFINE_SHOW_ATTRIBUTE(eps_dbg);
 
 static void pxa_init_debugfs(struct pxa_udc *udc)
 {
-	struct dentry *root;
+	struct debugfs_node *root;
 
 	root = debugfs_create_dir(udc->gadget.name, usb_debug_root);
 	debugfs_create_file("udcstate", 0400, root, udc, &state_dbg_fops);
diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget/udc/renesas_usb3.c
index fce5c41d9f29..a0748b2e9c83 100644
--- a/drivers/usb/gadget/udc/renesas_usb3.c
+++ b/drivers/usb/gadget/udc/renesas_usb3.c
@@ -343,7 +343,7 @@ struct renesas_usb3 {
 	struct extcon_dev *extcon;
 	struct work_struct extcon_work;
 	struct phy *phy;
-	struct dentry *dentry;
+	struct debugfs_node *dentry;
 
 	struct usb_role_switch *role_sw;
 	struct device *host_dev;
diff --git a/drivers/usb/host/ehci-dbg.c b/drivers/usb/host/ehci-dbg.c
index 435001128221..c796b41324ca 100644
--- a/drivers/usb/host/ehci-dbg.c
+++ b/drivers/usb/host/ehci-dbg.c
@@ -328,7 +328,7 @@ static const struct file_operations debug_registers_fops = {
 	.llseek		= default_llseek,
 };
 
-static struct dentry *ehci_debug_root;
+static struct debugfs_node *ehci_debug_root;
 
 struct debug_buffer {
 	ssize_t (*fill_func)(struct debug_buffer *);	/* fill method */
diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
index d7a3c8d13f6b..314eac255906 100644
--- a/drivers/usb/host/ehci.h
+++ b/drivers/usb/host/ehci.h
@@ -246,7 +246,7 @@ struct ehci_hcd {			/* one per controller */
 
 	/* debug files */
 #ifdef CONFIG_DYNAMIC_DEBUG
-	struct dentry		*debug_dir;
+	struct debugfs_node *debug_dir;
 #endif
 
 	/* bandwidth usage */
diff --git a/drivers/usb/host/fhci.h b/drivers/usb/host/fhci.h
index 1f57b0989485..95184564dc2f 100644
--- a/drivers/usb/host/fhci.h
+++ b/drivers/usb/host/fhci.h
@@ -261,7 +261,7 @@ struct fhci_hcd {
 
 #ifdef CONFIG_FHCI_DEBUG
 	int usb_irq_stat[13];
-	struct dentry *dfs_root;
+	struct debugfs_node *dfs_root;
 #endif
 };
 
diff --git a/drivers/usb/host/ohci-dbg.c b/drivers/usb/host/ohci-dbg.c
index 76bc8d56325d..651e669f4614 100644
--- a/drivers/usb/host/ohci-dbg.c
+++ b/drivers/usb/host/ohci-dbg.c
@@ -386,7 +386,7 @@ static const struct file_operations debug_registers_fops = {
 	.llseek		= default_llseek,
 };
 
-static struct dentry *ohci_debug_root;
+static struct debugfs_node *ohci_debug_root;
 
 struct debug_buffer {
 	ssize_t (*fill_func)(struct debug_buffer *);	/* fill method */
@@ -762,7 +762,7 @@ static int debug_registers_open(struct inode *inode, struct file *file)
 static inline void create_debug_files (struct ohci_hcd *ohci)
 {
 	struct usb_bus *bus = &ohci_to_hcd(ohci)->self;
-	struct dentry *root;
+	struct debugfs_node *root;
 
 	root = debugfs_create_dir(bus->bus_name, ohci_debug_root);
 	ohci->debug_dir = root;
diff --git a/drivers/usb/host/ohci.h b/drivers/usb/host/ohci.h
index 631dda6174b4..c3d99e525266 100644
--- a/drivers/usb/host/ohci.h
+++ b/drivers/usb/host/ohci.h
@@ -432,7 +432,7 @@ struct ohci_hcd {
 
 	struct work_struct	nec_work;	/* Worker for NEC quirk */
 
-	struct dentry		*debug_dir;
+	struct debugfs_node *debug_dir;
 
 	/* platform-specific data -- must come last */
 	unsigned long           priv[] __aligned(sizeof(s64));
diff --git a/drivers/usb/host/uhci-debug.c b/drivers/usb/host/uhci-debug.c
index c4e67c4b51f6..1ebb51b15e1c 100644
--- a/drivers/usb/host/uhci-debug.c
+++ b/drivers/usb/host/uhci-debug.c
@@ -19,7 +19,7 @@
 
 #define EXTRA_SPACE	1024
 
-static struct dentry *uhci_debugfs_root;
+static struct debugfs_node *uhci_debugfs_root;
 
 #ifdef CONFIG_DYNAMIC_DEBUG
 
diff --git a/drivers/usb/host/xhci-debugfs.c b/drivers/usb/host/xhci-debugfs.c
index 1f5ef174abea..ccc59937ffba 100644
--- a/drivers/usb/host/xhci-debugfs.c
+++ b/drivers/usb/host/xhci-debugfs.c
@@ -81,7 +81,7 @@ static const struct debugfs_reg32 xhci_extcap_dbc[] = {
 	dump_register(EXTCAP_DBC_DEVINFO2),
 };
 
-static struct dentry *xhci_debugfs_root;
+static struct debugfs_node *xhci_debugfs_root;
 
 static struct xhci_regset *xhci_debugfs_alloc_regset(struct xhci_hcd *xhci)
 {
@@ -113,7 +113,7 @@ static void xhci_debugfs_free_regset(struct xhci_regset *regset)
 __printf(6, 7)
 static void xhci_debugfs_regset(struct xhci_hcd *xhci, u32 base,
 				const struct debugfs_reg32 *regs,
-				size_t nregs, struct dentry *parent,
+				size_t nregs, struct debugfs_node *parent,
 				const char *fmt, ...)
 {
 	struct xhci_regset	*rgs;
@@ -386,7 +386,7 @@ static const struct file_operations port_fops = {
 static void xhci_debugfs_create_files(struct xhci_hcd *xhci,
 				      struct xhci_file_map *files,
 				      size_t nentries, void *data,
-				      struct dentry *parent,
+				      struct debugfs_node *parent,
 				      const struct file_operations *fops)
 {
 	int			i;
@@ -396,12 +396,12 @@ static void xhci_debugfs_create_files(struct xhci_hcd *xhci,
 					data, &files[i], fops);
 }
 
-static struct dentry *xhci_debugfs_create_ring_dir(struct xhci_hcd *xhci,
+static struct debugfs_node *xhci_debugfs_create_ring_dir(struct xhci_hcd *xhci,
 						   struct xhci_ring **ring,
 						   const char *name,
-						   struct dentry *parent)
+						   struct debugfs_node *parent)
 {
-	struct dentry		*dir;
+	struct debugfs_node		*dir;
 
 	dir = debugfs_create_dir(name, parent);
 	xhci_debugfs_create_files(xhci, ring_files, ARRAY_SIZE(ring_files),
@@ -411,7 +411,7 @@ static struct dentry *xhci_debugfs_create_ring_dir(struct xhci_hcd *xhci,
 }
 
 static void xhci_debugfs_create_context_files(struct xhci_hcd *xhci,
-					      struct dentry *parent,
+					      struct debugfs_node *parent,
 					      int slot_id)
 {
 	struct xhci_virt_device	*dev = xhci->devs[slot_id];
@@ -611,12 +611,12 @@ void xhci_debugfs_remove_slot(struct xhci_hcd *xhci, int slot_id)
 }
 
 static void xhci_debugfs_create_ports(struct xhci_hcd *xhci,
-				      struct dentry *parent)
+				      struct debugfs_node *parent)
 {
 	unsigned int		num_ports;
 	char			port_name[8];
 	struct xhci_port	*port;
-	struct dentry		*dir;
+	struct debugfs_node		*dir;
 
 	num_ports = HCS_MAX_PORTS(xhci->hcs_params1);
 
diff --git a/drivers/usb/host/xhci-debugfs.h b/drivers/usb/host/xhci-debugfs.h
index 7c074b4be819..e4ee647e3ef5 100644
--- a/drivers/usb/host/xhci-debugfs.h
+++ b/drivers/usb/host/xhci-debugfs.h
@@ -90,7 +90,7 @@ struct xhci_file_map {
 
 struct xhci_ep_priv {
 	char			name[DEBUGFS_NAMELEN];
-	struct dentry		*root;
+	struct debugfs_node *root;
 	struct xhci_stream_info *stream_info;
 	struct xhci_ring	*show_ring;
 	unsigned int		stream_id;
@@ -98,7 +98,7 @@ struct xhci_ep_priv {
 
 struct xhci_slot_priv {
 	char			name[DEBUGFS_NAMELEN];
-	struct dentry		*root;
+	struct debugfs_node *root;
 	struct xhci_ep_priv	*eps[31];
 	struct xhci_virt_device	*dev;
 };
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 8c164340a2c3..02aae4ceeba6 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1659,8 +1659,8 @@ struct xhci_hcd {
 /* Compliance Mode Timer Triggered every 2 seconds */
 #define COMP_MODE_RCVRY_MSECS 2000
 
-	struct dentry		*debugfs_root;
-	struct dentry		*debugfs_slots;
+	struct debugfs_node *debugfs_root;
+	struct debugfs_node *debugfs_slots;
 	struct list_head	regset_list;
 
 	void			*dbc;
diff --git a/drivers/usb/mon/mon_text.c b/drivers/usb/mon/mon_text.c
index 68b9b2b41189..5926923f18b1 100644
--- a/drivers/usb/mon/mon_text.c
+++ b/drivers/usb/mon/mon_text.c
@@ -93,7 +93,7 @@ struct mon_reader_text {
 	char slab_name[SLAB_NAME_SZ];
 };
 
-static struct dentry *mon_dir;		/* Usually /sys/kernel/debug/usbmon */
+static struct debugfs_node *mon_dir;		/* Usually /sys/kernel/debug/usbmon */
 
 static void mon_text_ctor(void *);
 
diff --git a/drivers/usb/mon/usb_mon.h b/drivers/usb/mon/usb_mon.h
index aa64efaba366..6fd0b0c46ed7 100644
--- a/drivers/usb/mon/usb_mon.h
+++ b/drivers/usb/mon/usb_mon.h
@@ -22,9 +22,9 @@ struct mon_bus {
 
 	int text_inited;
 	int bin_inited;
-	struct dentry *dent_s;		/* Debugging file */
-	struct dentry *dent_t;		/* Text interface file */
-	struct dentry *dent_u;		/* Second text interface file */
+	struct debugfs_node *dent_s;		/* Debugging file */
+	struct debugfs_node *dent_t;		/* Text interface file */
+	struct debugfs_node *dent_u;		/* Second text interface file */
 	struct device *classdev;	/* Device in usbmon class */
 
 	/* Ref */
diff --git a/drivers/usb/mtu3/mtu3.h b/drivers/usb/mtu3/mtu3.h
index c11840b9a6f1..5fe9763816d7 100644
--- a/drivers/usb/mtu3/mtu3.h
+++ b/drivers/usb/mtu3/mtu3.h
@@ -259,7 +259,7 @@ struct ssusb_mtk {
 	int u3_ports;
 	int u2p_dis_msk;
 	int u3p_dis_msk;
-	struct dentry *dbgfs_root;
+	struct debugfs_node *dbgfs_root;
 	/* usb wakeup for host mode */
 	bool uwk_en;
 	struct regmap *uwk;
diff --git a/drivers/usb/mtu3/mtu3_debugfs.c b/drivers/usb/mtu3/mtu3_debugfs.c
index c003049bafbf..b2fe59a70798 100644
--- a/drivers/usb/mtu3/mtu3_debugfs.c
+++ b/drivers/usb/mtu3/mtu3_debugfs.c
@@ -124,7 +124,7 @@ DEFINE_SHOW_ATTRIBUTE(mtu3_ep_used);
 
 static void mtu3_debugfs_regset(struct mtu3 *mtu, void __iomem *base,
 				const struct debugfs_reg32 *regs, size_t nregs,
-				const char *name, struct dentry *parent)
+				const char *name, struct debugfs_node *parent)
 {
 	struct debugfs_regset32 *regset;
 	struct mtu3_regset *mregs;
@@ -143,7 +143,7 @@ static void mtu3_debugfs_regset(struct mtu3 *mtu, void __iomem *base,
 }
 
 static void mtu3_debugfs_ep_regset(struct mtu3 *mtu, struct mtu3_ep *mep,
-				   struct dentry *parent)
+				   struct debugfs_node *parent)
 {
 	struct debugfs_reg32 *regs;
 	int epnum = mep->epnum;
@@ -326,7 +326,7 @@ static void mtu3_debugfs_create_prb_files(struct mtu3 *mtu)
 {
 	struct ssusb_mtk *ssusb = mtu->ssusb;
 	const struct debugfs_reg32 *regs;
-	struct dentry *dir_prb;
+	struct debugfs_node *dir_prb;
 	int i;
 
 	dir_prb = debugfs_create_dir("probe", ssusb->dbgfs_root);
@@ -342,10 +342,10 @@ static void mtu3_debugfs_create_prb_files(struct mtu3 *mtu)
 }
 
 static void mtu3_debugfs_create_ep_dir(struct mtu3_ep *mep,
-				       struct dentry *parent)
+				       struct debugfs_node *parent)
 {
 	const struct mtu3_file_map *files;
-	struct dentry *dir_ep;
+	struct debugfs_node *dir_ep;
 	int i;
 
 	dir_ep = debugfs_create_dir(mep->name, parent);
@@ -362,7 +362,7 @@ static void mtu3_debugfs_create_ep_dir(struct mtu3_ep *mep,
 static void mtu3_debugfs_create_ep_dirs(struct mtu3 *mtu)
 {
 	struct ssusb_mtk *ssusb = mtu->ssusb;
-	struct dentry *dir_eps;
+	struct debugfs_node *dir_eps;
 	int i;
 
 	dir_eps = debugfs_create_dir("eps", ssusb->dbgfs_root);
@@ -376,7 +376,7 @@ static void mtu3_debugfs_create_ep_dirs(struct mtu3 *mtu)
 void ssusb_dev_debugfs_init(struct ssusb_mtk *ssusb)
 {
 	struct mtu3 *mtu = ssusb->u3d;
-	struct dentry *dir_regs;
+	struct debugfs_node *dir_regs;
 
 	dir_regs = debugfs_create_dir("regs", ssusb->dbgfs_root);
 
@@ -496,7 +496,7 @@ static const struct file_operations ssusb_vbus_fops = {
 
 void ssusb_dr_debugfs_init(struct ssusb_mtk *ssusb)
 {
-	struct dentry *root = ssusb->dbgfs_root;
+	struct debugfs_node *root = ssusb->dbgfs_root;
 
 	debugfs_create_file("mode", 0644, root, ssusb, &ssusb_mode_fops);
 	debugfs_create_file("vbus", 0644, root, ssusb, &ssusb_vbus_fops);
diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index 91b5b6b66f96..aa26d23977d0 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -413,7 +413,7 @@ struct musb {
 
 	int			xceiv_old_state;
 #ifdef CONFIG_DEBUG_FS
-	struct dentry		*debugfs_root;
+	struct debugfs_node *debugfs_root;
 #endif
 };
 
diff --git a/drivers/usb/musb/musb_debugfs.c b/drivers/usb/musb/musb_debugfs.c
index 2d623284edf6..c7a6a5e885c9 100644
--- a/drivers/usb/musb/musb_debugfs.c
+++ b/drivers/usb/musb/musb_debugfs.c
@@ -323,7 +323,7 @@ static const struct file_operations musb_softconnect_fops = {
 
 void musb_init_debugfs(struct musb *musb)
 {
-	struct dentry *root;
+	struct debugfs_node *root;
 
 	root = debugfs_create_dir(dev_name(musb->controller), usb_debug_root);
 	musb->debugfs_root = root;
diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index f877faf5a930..5b3c1495b40b 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -110,7 +110,7 @@ struct dsps_glue {
 
 	struct dsps_context context;
 	struct debugfs_regset32 regset;
-	struct dentry *dbgfs_root;
+	struct debugfs_node *dbgfs_root;
 };
 
 static const struct debugfs_reg32 dsps_musb_regs[] = {
@@ -407,7 +407,7 @@ static irqreturn_t dsps_interrupt(int irq, void *hci)
 
 static int dsps_musb_dbg_init(struct musb *musb, struct dsps_glue *glue)
 {
-	struct dentry *root;
+	struct debugfs_node *root;
 	char buf[128];
 
 	sprintf(buf, "%s.dsps", dev_name(musb->controller));
diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
index 65dda9183e6f..ce213cc6d56b 100644
--- a/drivers/usb/typec/mux/intel_pmc_mux.c
+++ b/drivers/usb/typec/mux/intel_pmc_mux.c
@@ -157,10 +157,10 @@ struct pmc_usb {
 	u32 iom_port_status_offset;
 	u8 iom_port_status_size;
 
-	struct dentry *dentry;
+	struct debugfs_node *dentry;
 };
 
-static struct dentry *pmc_mux_debugfs_root;
+static struct debugfs_node *pmc_mux_debugfs_root;
 
 static void update_port_status(struct pmc_usb_port *port)
 {
@@ -717,7 +717,7 @@ DEFINE_SHOW_ATTRIBUTE(port_iom_status);
 
 static void pmc_mux_port_debugfs_init(struct pmc_usb_port *port)
 {
-	struct dentry *debugfs_dir;
+	struct debugfs_node *debugfs_dir;
 	char name[8];
 
 	snprintf(name, sizeof(name), "port%d", port->usb3_port - 1);
diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
index f15c63d3a8f4..07123c77f263 100644
--- a/drivers/usb/typec/tcpm/fusb302.c
+++ b/drivers/usb/typec/tcpm/fusb302.c
@@ -111,7 +111,7 @@ struct fusb302_chip {
 	u32 snk_pdo[PDO_MAX_OBJECTS];
 
 #ifdef CONFIG_DEBUG_FS
-	struct dentry *dentry;
+	struct debugfs_node *dentry;
 	/* lock for log buffer access */
 	struct mutex logbuffer_lock;
 	int logbuffer_head;
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 47be450d2be3..70625ca082f1 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -581,7 +581,7 @@ struct tcpm_port {
 	/* Indicates maximum (revision, version) supported */
 	struct pd_revision_info pd_rev;
 #ifdef CONFIG_DEBUG_FS
-	struct dentry *dentry;
+	struct debugfs_node *dentry;
 	struct mutex logbuffer_lock;	/* log buffer access lock */
 	int logbuffer_head;
 	int logbuffer_tail;
diff --git a/drivers/usb/typec/ucsi/debugfs.c b/drivers/usb/typec/ucsi/debugfs.c
index 83ff23086d79..09ebe48a867a 100644
--- a/drivers/usb/typec/ucsi/debugfs.c
+++ b/drivers/usb/typec/ucsi/debugfs.c
@@ -17,7 +17,7 @@
 
 #include "ucsi.h"
 
-static struct dentry *ucsi_debugfs_root;
+static struct debugfs_node *ucsi_debugfs_root;
 
 static int ucsi_cmd(void *data, u64 val)
 {
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index 82735eb34f0e..83f5fdf52f96 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -20,6 +20,7 @@ struct ucsi;
 struct ucsi_altmode;
 struct ucsi_connector;
 struct dentry;
+#define debugfs_node dentry
 
 /* UCSI offsets (Bytes) */
 #define UCSI_VERSION			0
@@ -428,7 +429,7 @@ struct ucsi_debugfs_entry {
 		u64 high;
 	} response;
 	u32 status;
-	struct dentry *dentry;
+	struct debugfs_node *dentry;
 };
 
 struct ucsi {
diff --git a/drivers/vdpa/mlx5/net/debug.c b/drivers/vdpa/mlx5/net/debug.c
index 9c85162c19fc..e5ef5f2cd84b 100644
--- a/drivers/vdpa/mlx5/net/debug.c
+++ b/drivers/vdpa/mlx5/net/debug.c
@@ -84,7 +84,7 @@ DEFINE_SHOW_ATTRIBUTE(packets);
 DEFINE_SHOW_ATTRIBUTE(bytes);
 
 static void add_counter_node(struct mlx5_vdpa_counter *counter,
-			     struct dentry *parent)
+			     struct debugfs_node *parent)
 {
 	debugfs_create_file("packets", 0444, parent, counter,
 			    &packets_fops);
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.h b/drivers/vdpa/mlx5/net/mlx5_vnet.h
index 00e79a7d0be8..bd3a2db9f9c0 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.h
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.h
@@ -16,7 +16,7 @@ struct mlx5_vdpa_net_resources {
 	u32 tirn;
 	u32 rqtn;
 	bool valid;
-	struct dentry *tirn_dent;
+	struct debugfs_node *tirn_dent;
 };
 
 #define MLX5V_MACVLAN_SIZE 256
@@ -53,8 +53,8 @@ struct mlx5_vdpa_net {
 	 */
 	struct rw_semaphore reslock;
 	struct mlx5_flow_table *rxft;
-	struct dentry *rx_dent;
-	struct dentry *rx_table_dent;
+	struct debugfs_node *rx_dent;
+	struct debugfs_node *rx_table_dent;
 	bool setup;
 	bool needs_teardown;
 	u32 cur_num_vqs;
@@ -65,7 +65,7 @@ struct mlx5_vdpa_net {
 	struct mlx5_vdpa_wq_ent cvq_ent;
 	struct hlist_head macvlan_hash[MLX5V_MACVLAN_SIZE];
 	struct mlx5_vdpa_irq_pool irqp;
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 
 	u32 umem_1_buffer_param_a;
 	u32 umem_1_buffer_param_b;
@@ -79,7 +79,7 @@ struct mlx5_vdpa_net {
 
 struct mlx5_vdpa_counter {
 	struct mlx5_fc *counter;
-	struct dentry *dent;
+	struct debugfs_node *dent;
 	struct mlx5_core_dev *mdev;
 };
 
@@ -91,7 +91,7 @@ struct macvlan_node {
 	struct mlx5_vdpa_net *ndev;
 	bool tagged;
 #if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
-	struct dentry *dent;
+	struct debugfs_node *dent;
 	struct mlx5_vdpa_counter ucast_counter;
 	struct mlx5_vdpa_counter mcast_counter;
 #endif
diff --git a/drivers/vdpa/pds/aux_drv.h b/drivers/vdpa/pds/aux_drv.h
index 26b75344156e..1dc67c1632a0 100644
--- a/drivers/vdpa/pds/aux_drv.h
+++ b/drivers/vdpa/pds/aux_drv.h
@@ -18,7 +18,7 @@ struct pds_vdpa_aux {
 	struct pds_vdpa_ident ident;
 
 	int vf_id;
-	struct dentry *dentry;
+	struct debugfs_node *dentry;
 	struct virtio_pci_modern_device vd_mdev;
 
 	int nintrs;
diff --git a/drivers/vdpa/pds/debugfs.c b/drivers/vdpa/pds/debugfs.c
index c328e694f6e7..4cedeaceecfd 100644
--- a/drivers/vdpa/pds/debugfs.c
+++ b/drivers/vdpa/pds/debugfs.c
@@ -13,7 +13,7 @@
 #include "vdpa_dev.h"
 #include "debugfs.h"
 
-static struct dentry *dbfs_dir;
+static struct debugfs_node *dbfs_dir;
 
 void pds_vdpa_debugfs_create(void)
 {
diff --git a/drivers/vfio/debugfs.c b/drivers/vfio/debugfs.c
index 298bd866f157..a7e9e91a2b16 100644
--- a/drivers/vfio/debugfs.c
+++ b/drivers/vfio/debugfs.c
@@ -9,7 +9,7 @@
 #include <linux/vfio.h>
 #include "vfio.h"
 
-static struct dentry *vfio_debugfs_root;
+static struct debugfs_node *vfio_debugfs_root;
 
 static int vfio_device_state_read(struct seq_file *seq, void *data)
 {
@@ -66,7 +66,7 @@ void vfio_device_debugfs_init(struct vfio_device *vdev)
 					      vfio_debugfs_root);
 
 	if (vdev->mig_ops) {
-		struct dentry *vfio_dev_migration = NULL;
+		struct debugfs_node *vfio_dev_migration = NULL;
 
 		vfio_dev_migration = debugfs_create_dir("migration",
 							vdev->debug_root);
diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
index 451c639299eb..5a1f5eebbf6f 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
@@ -1536,8 +1536,8 @@ static void hisi_acc_vfio_debug_init(struct hisi_acc_vf_core_device *hisi_acc_vd
 {
 	struct vfio_device *vdev = &hisi_acc_vdev->core_device.vdev;
 	struct hisi_acc_vf_migration_file *migf;
-	struct dentry *vfio_dev_migration;
-	struct dentry *vfio_hisi_acc;
+	struct debugfs_node *vfio_dev_migration;
+	struct debugfs_node *vfio_hisi_acc;
 	struct device *dev = vdev->dev;
 
 	if (!debugfs_initialized() ||
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/core.c b/drivers/video/fbdev/omap2/omapfb/dss/core.c
index 55b640f2f245..9cc011e8596e 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/core.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/core.c
@@ -97,7 +97,7 @@ static int dss_show(struct seq_file *s, void *unused)
 
 DEFINE_SHOW_ATTRIBUTE(dss);
 
-static struct dentry *dss_debugfs_dir;
+static struct debugfs_node *dss_debugfs_dir;
 
 static void dss_initialize_debugfs(void)
 {
diff --git a/drivers/virtio/virtio_debug.c b/drivers/virtio/virtio_debug.c
index 95c8fc7705bb..832e3d4493ed 100644
--- a/drivers/virtio/virtio_debug.c
+++ b/drivers/virtio/virtio_debug.c
@@ -4,7 +4,7 @@
 #include <linux/virtio_config.h>
 #include <linux/debugfs.h>
 
-static struct dentry *virtio_debugfs_dir;
+static struct debugfs_node *virtio_debugfs_dir;
 
 static int virtio_debug_device_features_show(struct seq_file *s, void *data)
 {
diff --git a/drivers/watchdog/bcm_kona_wdt.c b/drivers/watchdog/bcm_kona_wdt.c
index 66bd0324fd68..592a2d04413b 100644
--- a/drivers/watchdog/bcm_kona_wdt.c
+++ b/drivers/watchdog/bcm_kona_wdt.c
@@ -51,7 +51,7 @@ struct bcm_kona_wdt {
 	spinlock_t lock;
 #ifdef CONFIG_BCM_KONA_WDT_DEBUG
 	unsigned long busy_count;
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 #endif
 };
 
@@ -134,7 +134,7 @@ DEFINE_SHOW_ATTRIBUTE(bcm_kona);
 
 static void bcm_kona_wdt_debug_init(struct platform_device *pdev)
 {
-	struct dentry *dir;
+	struct debugfs_node *dir;
 	struct bcm_kona_wdt *wdt = platform_get_drvdata(pdev);
 
 	if (!wdt)
diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index 26efca9ae0e7..4aec22759474 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -93,7 +93,7 @@ struct dw_wdt {
 	u32			timeout;
 
 #ifdef CONFIG_DEBUG_FS
-	struct dentry		*dbgfs_dir;
+	struct debugfs_node *dbgfs_dir;
 #endif
 };
 
diff --git a/drivers/watchdog/ie6xx_wdt.c b/drivers/watchdog/ie6xx_wdt.c
index 5a7bb7e84653..04f146953f29 100644
--- a/drivers/watchdog/ie6xx_wdt.c
+++ b/drivers/watchdog/ie6xx_wdt.c
@@ -68,7 +68,7 @@ static struct {
 	unsigned short sch_wdtba;
 	spinlock_t unlock_sequence;
 #ifdef CONFIG_DEBUG_FS
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 #endif
 } ie6xx_wdt_data;
 
diff --git a/drivers/watchdog/mei_wdt.c b/drivers/watchdog/mei_wdt.c
index c7a7235e6224..2a73ee9d3b8d 100644
--- a/drivers/watchdog/mei_wdt.c
+++ b/drivers/watchdog/mei_wdt.c
@@ -101,7 +101,7 @@ struct mei_wdt {
 	u16 timeout;
 
 #if IS_ENABLED(CONFIG_DEBUG_FS)
-	struct dentry *dbgfs_dir;
+	struct debugfs_node *dbgfs_dir;
 #endif /* CONFIG_DEBUG_FS */
 };
 
@@ -540,7 +540,7 @@ static void dbgfs_unregister(struct mei_wdt *wdt)
 
 static void dbgfs_register(struct mei_wdt *wdt)
 {
-	struct dentry *dir;
+	struct debugfs_node *dir;
 
 	dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
 	wdt->dbgfs_dir = dir;
diff --git a/fs/bcachefs/debug.c b/fs/bcachefs/debug.c
index 55333e82d1fe..143c6789d410 100644
--- a/fs/bcachefs/debug.c
+++ b/fs/bcachefs/debug.c
@@ -29,7 +29,7 @@
 #include <linux/random.h>
 #include <linux/seq_file.h>
 
-static struct dentry *bch_debug;
+static struct debugfs_node *bch_debug;
 
 static bool bch2_btree_verify_replica(struct bch_fs *c, struct btree *b,
 				      struct extent_ptr_decoded pick)
@@ -884,7 +884,7 @@ void bch2_fs_debug_exit(struct bch_fs *c)
 
 static void bch2_fs_debug_btree_init(struct bch_fs *c, struct btree_debug *bd)
 {
-	struct dentry *d;
+	struct debugfs_node *d;
 
 	d = debugfs_create_dir(bch2_btree_id_str(bd->id), c->btree_debug_dir);
 
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 7fa1e7be50e4..5cba6475f1d0 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -147,12 +147,12 @@ struct ceph_fs_client {
 
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_dentry_lru, *debugfs_caps;
-	struct dentry *debugfs_congestion_kb;
-	struct dentry *debugfs_bdi;
+	struct debugfs_node *debugfs_congestion_kb;
+	struct debugfs_node *debugfs_bdi;
 	struct dentry *debugfs_mdsc, *debugfs_mdsmap;
-	struct dentry *debugfs_status;
-	struct dentry *debugfs_mds_sessions;
-	struct dentry *debugfs_metrics_dir;
+	struct debugfs_node *debugfs_status;
+	struct debugfs_node *debugfs_mds_sessions;
+	struct debugfs_node *debugfs_metrics_dir;
 #endif
 
 #ifdef CONFIG_CEPH_FSCACHE
diff --git a/fs/dlm/debug_fs.c b/fs/dlm/debug_fs.c
index 700a0cbb2f14..1750c9a3c98e 100644
--- a/fs/dlm/debug_fs.c
+++ b/fs/dlm/debug_fs.c
@@ -24,8 +24,8 @@
 static char debug_buf[DLM_DEBUG_BUF_LEN];
 static struct mutex debug_buf_lock;
 
-static struct dentry *dlm_root;
-static struct dentry *dlm_comms;
+static struct debugfs_node *dlm_root;
+static struct debugfs_node *dlm_comms;
 
 static char *print_lockmode(int mode)
 {
@@ -737,7 +737,7 @@ static const struct file_operations dlm_rawmsg_fops = {
 
 void *dlm_create_debug_comms_file(int nodeid, void *data)
 {
-	struct dentry *d_node;
+	struct debugfs_node *d_node;
 	char name[256];
 
 	memset(name, 0, sizeof(name));
diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
index d534a4bc162b..e5444cd5ace4 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -608,12 +608,12 @@ struct dlm_ls {
 	struct dlm_lkb		ls_local_lkb;	/* for returning errors */
 	struct dlm_message	ls_local_ms;	/* for faking a reply */
 
-	struct dentry		*ls_debug_rsb_dentry; /* debugfs */
-	struct dentry		*ls_debug_waiters_dentry; /* debugfs */
-	struct dentry		*ls_debug_locks_dentry; /* debugfs */
-	struct dentry		*ls_debug_all_dentry; /* debugfs */
-	struct dentry		*ls_debug_toss_dentry; /* debugfs */
-	struct dentry		*ls_debug_queued_asts_dentry; /* debugfs */
+	struct debugfs_node *ls_debug_rsb_dentry; /* debugfs */
+	struct debugfs_node *ls_debug_waiters_dentry; /* debugfs */
+	struct debugfs_node *ls_debug_locks_dentry; /* debugfs */
+	struct debugfs_node *ls_debug_all_dentry; /* debugfs */
+	struct debugfs_node *ls_debug_toss_dentry; /* debugfs */
+	struct debugfs_node *ls_debug_queued_asts_dentry; /* debugfs */
 
 	wait_queue_head_t	ls_uevent_wait;	/* user part of join/leave */
 	int			ls_uevent_result;
diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 468828288a4a..2e3b80092f67 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -23,7 +23,7 @@
 static LIST_HEAD(f2fs_stat_list);
 static DEFINE_RAW_SPINLOCK(f2fs_stat_lock);
 #ifdef CONFIG_DEBUG_FS
-static struct dentry *f2fs_debugfs_root;
+static struct debugfs_node *f2fs_debugfs_root;
 #endif
 
 /*
diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 65c07aa95718..18376fe104c2 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -64,7 +64,7 @@ static void do_xmote(struct gfs2_glock *gl, struct gfs2_holder *gh, unsigned int
 static void request_demote(struct gfs2_glock *gl, unsigned int state,
 			   unsigned long delay, bool remote);
 
-static struct dentry *gfs2_root;
+static struct debugfs_node *gfs2_root;
 static LIST_HEAD(lru_list);
 static atomic_t lru_count = ATOMIC_INIT(0);
 static DEFINE_SPINLOCK(lru_lock);
diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index 4e19cce3d906..fd0228c77f4e 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -845,7 +845,7 @@ struct gfs2_sbd {
 	/* Debugging crud */
 
 	unsigned long sd_last_warning;
-	struct dentry *debugfs_dir;    /* debugfs directory */
+	struct debugfs_node *debugfs_dir;    /* debugfs directory */
 	unsigned long sd_glock_dqs_held;
 };
 
diff --git a/fs/ocfs2/blockcheck.c b/fs/ocfs2/blockcheck.c
index 863a5316030b..5a9072485e7f 100644
--- a/fs/ocfs2/blockcheck.c
+++ b/fs/ocfs2/blockcheck.c
@@ -238,9 +238,9 @@ static void ocfs2_blockcheck_debug_remove(struct ocfs2_blockcheck_stats *stats)
 }
 
 static void ocfs2_blockcheck_debug_install(struct ocfs2_blockcheck_stats *stats,
-					   struct dentry *parent)
+					   struct debugfs_node *parent)
 {
-	struct dentry *dir;
+	struct debugfs_node *dir;
 
 	dir = debugfs_create_dir("blockcheck", parent);
 	stats->b_debug_dir = dir;
@@ -257,7 +257,7 @@ static void ocfs2_blockcheck_debug_install(struct ocfs2_blockcheck_stats *stats,
 }
 #else
 static inline void ocfs2_blockcheck_debug_install(struct ocfs2_blockcheck_stats *stats,
-						  struct dentry *parent)
+						  struct debugfs_node *parent)
 {
 }
 
@@ -268,7 +268,7 @@ static inline void ocfs2_blockcheck_debug_remove(struct ocfs2_blockcheck_stats *
 
 /* Always-called wrappers for starting and stopping the debugfs files */
 void ocfs2_blockcheck_stats_debugfs_install(struct ocfs2_blockcheck_stats *stats,
-					    struct dentry *parent)
+					    struct debugfs_node *parent)
 {
 	ocfs2_blockcheck_debug_install(stats, parent);
 }
diff --git a/fs/ocfs2/blockcheck.h b/fs/ocfs2/blockcheck.h
index d0578e98ee8d..864257bbb92b 100644
--- a/fs/ocfs2/blockcheck.h
+++ b/fs/ocfs2/blockcheck.h
@@ -22,7 +22,7 @@ struct ocfs2_blockcheck_stats {
 	 * debugfs entries, used if this is passed to
 	 * ocfs2_blockcheck_stats_debugfs_install()
 	 */
-	struct dentry *b_debug_dir;	/* Parent of the debugfs  files */
+	struct debugfs_node *b_debug_dir;	/* Parent of the debugfs  files */
 };
 
 
@@ -52,7 +52,7 @@ int ocfs2_block_check_validate_bhs(struct buffer_head **bhs, int nr,
 
 /* Debug Initialization */
 void ocfs2_blockcheck_stats_debugfs_install(struct ocfs2_blockcheck_stats *stats,
-					    struct dentry *parent);
+					    struct debugfs_node *parent);
 void ocfs2_blockcheck_stats_debugfs_remove(struct ocfs2_blockcheck_stats *stats);
 
 /*
diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index 724350925aff..65799b74ae95 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -90,7 +90,7 @@ static struct o2hb_debug_buf *o2hb_db_failedregions;
 #define O2HB_DEBUG_REGION_ELAPSED_TIME	"elapsed_time_in_ms"
 #define O2HB_DEBUG_REGION_PINNED	"pinned"
 
-static struct dentry *o2hb_debug_dir;
+static struct debugfs_node *o2hb_debug_dir;
 
 static LIST_HEAD(o2hb_all_regions);
 
@@ -221,7 +221,7 @@ struct o2hb_region {
 	unsigned long		hr_live_node_bitmap[BITS_TO_LONGS(O2NM_MAX_NODES)];
 	unsigned int		hr_region_num;
 
-	struct dentry		*hr_debug_dir;
+	struct debugfs_node *hr_debug_dir;
 	struct o2hb_debug_buf	*hr_db_livenodes;
 	struct o2hb_debug_buf	*hr_db_regnum;
 	struct o2hb_debug_buf	*hr_db_elapsed_time;
@@ -1389,7 +1389,7 @@ void o2hb_exit(void)
 	kfree(o2hb_db_failedregions);
 }
 
-static void o2hb_debug_create(const char *name, struct dentry *dir,
+static void o2hb_debug_create(const char *name, struct debugfs_node *dir,
 			      struct o2hb_debug_buf **db, int db_len, int type,
 			      int size, int len, void *data)
 {
@@ -1967,9 +1967,9 @@ static struct o2hb_heartbeat_group *to_o2hb_heartbeat_group(struct config_group
 }
 
 static void o2hb_debug_region_init(struct o2hb_region *reg,
-				   struct dentry *parent)
+				   struct debugfs_node *parent)
 {
-	struct dentry *dir;
+	struct debugfs_node *dir;
 
 	dir = debugfs_create_dir(config_item_name(&reg->hr_item), parent);
 	reg->hr_debug_dir = dir;
diff --git a/fs/ocfs2/cluster/netdebug.c b/fs/ocfs2/cluster/netdebug.c
index bc27301eab6d..65e0d7efee27 100644
--- a/fs/ocfs2/cluster/netdebug.c
+++ b/fs/ocfs2/cluster/netdebug.c
@@ -35,7 +35,7 @@
 #define SHOW_SOCK_CONTAINERS	0
 #define SHOW_SOCK_STATS		1
 
-static struct dentry *o2net_dentry;
+static struct debugfs_node *o2net_dentry;
 
 static DEFINE_SPINLOCK(o2net_debug_lock);
 
diff --git a/fs/ocfs2/dlm/dlmcommon.h b/fs/ocfs2/dlm/dlmcommon.h
index 20f790a47484..30834d0254c8 100644
--- a/fs/ocfs2/dlm/dlmcommon.h
+++ b/fs/ocfs2/dlm/dlmcommon.h
@@ -137,7 +137,7 @@ struct dlm_ctxt
 	atomic_t res_tot_count;
 	atomic_t res_cur_count;
 
-	struct dentry *dlm_debugfs_subroot;
+	struct debugfs_node *dlm_debugfs_subroot;
 
 	/* NOTE: Next three are protected by dlm_domain_lock */
 	struct kref dlm_refs;
diff --git a/fs/ocfs2/dlm/dlmdebug.c b/fs/ocfs2/dlm/dlmdebug.c
index fe4fdd09bae3..9d15e6b7e0bd 100644
--- a/fs/ocfs2/dlm/dlmdebug.c
+++ b/fs/ocfs2/dlm/dlmdebug.c
@@ -269,7 +269,7 @@ void dlm_print_one_mle(struct dlm_master_list_entry *mle)
 
 #ifdef CONFIG_DEBUG_FS
 
-static struct dentry *dlm_debugfs_root;
+static struct debugfs_node *dlm_debugfs_root;
 
 #define DLM_DEBUGFS_DIR				"o2dlm"
 #define DLM_DEBUGFS_DLM_STATE			"dlm_state"
diff --git a/fs/ocfs2/ocfs2.h b/fs/ocfs2/ocfs2.h
index 51c52768132d..95afc6476429 100644
--- a/fs/ocfs2/ocfs2.h
+++ b/fs/ocfs2/ocfs2.h
@@ -424,7 +424,7 @@ struct ocfs2_super
 	struct mutex obs_trim_fs_mutex;
 	struct ocfs2_dlm_debug *osb_dlm_debug;
 
-	struct dentry *osb_debug_root;
+	struct debugfs_node *osb_debug_root;
 
 	wait_queue_head_t recovery_event;
 
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 8bb5022f3082..38db7fa01970 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -64,7 +64,7 @@ static struct kmem_cache *ocfs2_inode_cachep;
 struct kmem_cache *ocfs2_dquot_cachep;
 struct kmem_cache *ocfs2_qf_chunk_cachep;
 
-static struct dentry *ocfs2_debugfs_root;
+static struct debugfs_node *ocfs2_debugfs_root;
 
 MODULE_AUTHOR("Oracle");
 MODULE_LICENSE("GPL");
diff --git a/fs/orangefs/orangefs-debugfs.c b/fs/orangefs/orangefs-debugfs.c
index f52073022fae..ba94ff6ad8ce 100644
--- a/fs/orangefs/orangefs-debugfs.c
+++ b/fs/orangefs/orangefs-debugfs.c
@@ -99,8 +99,8 @@ static char *debug_help_string;
 static char client_debug_string[ORANGEFS_MAX_DEBUG_STRING_LEN];
 static char client_debug_array_string[ORANGEFS_MAX_DEBUG_STRING_LEN];
 
-static struct dentry *client_debug_dentry;
-static struct dentry *debug_dir;
+static struct debugfs_node *client_debug_dentry;
+static struct debugfs_node *debug_dir;
 
 static unsigned int kernel_mask_set_mod_init;
 static int orangefs_debug_disabled = 1;
diff --git a/fs/pstore/ftrace.c b/fs/pstore/ftrace.c
index 776cae20af4e..098c18c8ed39 100644
--- a/fs/pstore/ftrace.c
+++ b/fs/pstore/ftrace.c
@@ -122,7 +122,7 @@ static const struct file_operations pstore_knob_fops = {
 	.write	= pstore_ftrace_knob_write,
 };
 
-static struct dentry *pstore_ftrace_dir;
+static struct debugfs_node *pstore_ftrace_dir;
 
 static bool record_ftrace;
 module_param(record_ftrace, bool, 0400);
diff --git a/fs/ubifs/debug.c b/fs/ubifs/debug.c
index b01f382ce8db..a98784f4425d 100644
--- a/fs/ubifs/debug.c
+++ b/fs/ubifs/debug.c
@@ -2669,7 +2669,7 @@ int dbg_leb_map(struct ubifs_info *c, int lnum)
  * Root directory for UBIFS stuff in debugfs. Contains sub-directories which
  * contain the stuff specific to particular file-system mounts.
  */
-static struct dentry *dfs_rootdir;
+static struct debugfs_node *dfs_rootdir;
 
 static int dfs_file_open(struct inode *inode, struct file *file)
 {
@@ -2891,12 +2891,12 @@ void dbg_debugfs_exit_fs(struct ubifs_info *c)
 
 struct ubifs_global_debug_info ubifs_dbg;
 
-static struct dentry *dfs_chk_gen;
-static struct dentry *dfs_chk_index;
-static struct dentry *dfs_chk_orph;
-static struct dentry *dfs_chk_lprops;
-static struct dentry *dfs_chk_fs;
-static struct dentry *dfs_tst_rcvry;
+static struct debugfs_node *dfs_chk_gen;
+static struct debugfs_node *dfs_chk_index;
+static struct debugfs_node *dfs_chk_orph;
+static struct debugfs_node *dfs_chk_lprops;
+static struct debugfs_node *dfs_chk_fs;
+static struct debugfs_node *dfs_tst_rcvry;
 
 static ssize_t dfs_global_file_read(struct file *file, char __user *u,
 				    size_t count, loff_t *ppos)
diff --git a/fs/xfs/scrub/stats.c b/fs/xfs/scrub/stats.c
index f8a37ea97791..29438aaf772b 100644
--- a/fs/xfs/scrub/stats.c
+++ b/fs/xfs/scrub/stats.c
@@ -45,7 +45,7 @@ struct xchk_scrub_stats {
 };
 
 struct xchk_stats {
-	struct dentry		*cs_debugfs;
+	struct debugfs_node *cs_debugfs;
 	struct xchk_scrub_stats	cs_stats[XFS_SCRUB_TYPE_NR];
 };
 
@@ -327,7 +327,7 @@ xchk_stats_init(
 void
 xchk_stats_register(
 	struct xchk_stats	*cs,
-	struct dentry		*parent)
+	struct debugfs_node		*parent)
 {
 	if (!parent)
 		return;
@@ -360,8 +360,7 @@ xchk_stats_unregister(
 
 /* Initialize global stats and register them */
 int __init
-xchk_global_stats_setup(
-	struct dentry		*parent)
+xchk_global_stats_setup(struct debugfs_node		*parent)
 {
 	int			error;
 
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index fbed172d6770..c4d2682d797c 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -249,7 +249,7 @@ typedef struct xfs_mount {
 	uint64_t		m_resblks_avail;/* available reserved blocks */
 	uint64_t		m_resblks_save;	/* reserved blks @ remount,ro */
 	struct delayed_work	m_reclaim_work;	/* background inode reclaim */
-	struct dentry		*m_debugfs;	/* debugfs parent */
+	struct debugfs_node *m_debugfs;	/* debugfs parent */
 	struct xfs_kobj		m_kobj;
 	struct xfs_kobj		m_error_kobj;
 	struct xfs_kobj		m_error_meta_kobj;
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index d92d7a07ea89..4b88c9b4d135 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -55,7 +55,7 @@
 
 static const struct super_operations xfs_super_operations;
 
-static struct dentry *xfs_debugfs;	/* top-level xfs debugfs dir */
+static struct debugfs_node *xfs_debugfs;	/* top-level xfs debugfs dir */
 static struct kset *xfs_kset;		/* top-level xfs sysfs dir */
 #ifdef DEBUG
 static struct xfs_kobj xfs_dbg_kobj;	/* global debug sysfs attrs */
@@ -1520,12 +1520,12 @@ xfs_fs_validate_params(
 	return 0;
 }
 
-struct dentry *
+struct debugfs_node *
 xfs_debugfs_mkdir(
 	const char	*name,
-	struct dentry	*parent)
+	struct debugfs_node	*parent)
 {
-	struct dentry	*child;
+	struct debugfs_node	*child;
 
 	/* Apparently we're expected to ignore error returns?? */
 	child = debugfs_create_dir(name, parent);
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index f13d597370a3..9f63215edaea 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -2180,7 +2180,7 @@ struct drm_connector {
 	u8 real_edid_checksum;
 
 	/** @debugfs_entry: debugfs directory for this connector */
-	struct dentry *debugfs_entry;
+	struct debugfs_node *debugfs_entry;
 
 	/**
 	 * @state:
diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index 8b48a1974da3..7ad9ff451311 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -1132,7 +1132,7 @@ struct drm_crtc {
 	 *
 	 * Debugfs directory for this CRTC.
 	 */
-	struct dentry *debugfs_entry;
+	struct debugfs_node *debugfs_entry;
 
 	/**
 	 * @crc:
diff --git a/include/drm/drm_debugfs.h b/include/drm/drm_debugfs.h
index cf06cee4343f..e795aa93a132 100644
--- a/include/drm/drm_debugfs.h
+++ b/include/drm/drm_debugfs.h
@@ -92,7 +92,7 @@ struct drm_info_node {
 	const struct drm_info_list *info_ent;
 	/* private: */
 	struct list_head list;
-	struct dentry *dent;
+	struct debugfs_node *dent;
 };
 
 /**
@@ -140,10 +140,11 @@ struct drm_debugfs_entry {
 
 #if defined(CONFIG_DEBUG_FS)
 void drm_debugfs_create_files(const struct drm_info_list *files,
-			      int count, struct dentry *root,
+			      int count, struct debugfs_node *root,
 			      struct drm_minor *minor);
 int drm_debugfs_remove_files(const struct drm_info_list *files, int count,
-			     struct dentry *root, struct drm_minor *minor);
+			     struct debugfs_node *root,
+			     struct drm_minor *minor);
 
 void drm_debugfs_add_file(struct drm_device *dev, const char *name,
 			  int (*show)(struct seq_file*, void*), void *data);
@@ -155,12 +156,14 @@ int drm_debugfs_gpuva_info(struct seq_file *m,
 			   struct drm_gpuvm *gpuvm);
 #else
 static inline void drm_debugfs_create_files(const struct drm_info_list *files,
-					    int count, struct dentry *root,
+					    int count,
+					    struct debugfs_node *root,
 					    struct drm_minor *minor)
 {}
 
 static inline int drm_debugfs_remove_files(const struct drm_info_list *files,
-					   int count, struct dentry *root,
+					   int count,
+					   struct debugfs_node *root,
 					   struct drm_minor *minor)
 {
 	return 0;
diff --git a/include/drm/drm_device.h b/include/drm/drm_device.h
index c91f87b5242d..b36e6e0e7605 100644
--- a/include/drm/drm_device.h
+++ b/include/drm/drm_device.h
@@ -316,7 +316,7 @@ struct drm_device {
 	 *
 	 * Root directory for debugfs files.
 	 */
-	struct dentry *debugfs_root;
+	struct debugfs_node *debugfs_root;
 };
 
 #endif
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index 9952b846c170..7e2d083e8077 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -565,9 +565,10 @@ static inline bool drm_firmware_drivers_only(void)
 }
 
 #if defined(CONFIG_DEBUG_FS)
-void drm_debugfs_dev_init(struct drm_device *dev, struct dentry *root);
+void drm_debugfs_dev_init(struct drm_device *dev, struct debugfs_node *root);
 #else
-static inline void drm_debugfs_dev_init(struct drm_device *dev, struct dentry *root)
+static inline void drm_debugfs_dev_init(struct drm_device *dev,
+					struct debugfs_node *root)
 {
 }
 #endif
diff --git a/include/drm/drm_encoder.h b/include/drm/drm_encoder.h
index 977a9381c8ba..50845e231366 100644
--- a/include/drm/drm_encoder.h
+++ b/include/drm/drm_encoder.h
@@ -197,7 +197,7 @@ struct drm_encoder {
 	 *
 	 * Debugfs directory for this CRTC.
 	 */
-	struct dentry *debugfs_entry;
+	struct debugfs_node *debugfs_entry;
 };
 
 #define obj_to_encoder(x) container_of(x, struct drm_encoder, base)
diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
index ef817926cddd..6cb6144dc9e1 100644
--- a/include/drm/drm_file.h
+++ b/include/drm/drm_file.h
@@ -81,8 +81,8 @@ struct drm_minor {
 	struct device *kdev;		/* Linux device */
 	struct drm_device *dev;
 
-	struct dentry *debugfs_symlink;
-	struct dentry *debugfs_root;
+	struct debugfs_node *debugfs_symlink;
+	struct debugfs_node *debugfs_root;
 };
 
 /**
diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
index 10015891b056..4030eae6ee90 100644
--- a/include/drm/drm_panel.h
+++ b/include/drm/drm_panel.h
@@ -31,6 +31,7 @@
 
 struct backlight_device;
 struct dentry;
+#define debugfs_node dentry
 struct device_node;
 struct drm_connector;
 struct drm_device;
diff --git a/include/kunit/test.h b/include/kunit/test.h
index 58dbab60f853..8688cd1ce8f1 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -251,7 +251,7 @@ struct kunit_suite {
 
 	/* private: internal use only */
 	char status_comment[KUNIT_STATUS_COMMENT_SIZE];
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 	struct string_stream *log;
 	int suite_init_err;
 	bool is_init;
diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index 2ad261082bba..03c80b739a1a 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -17,6 +17,7 @@
 struct page;
 struct device;
 struct dentry;
+#define debugfs_node dentry
 
 /*
  * Bits in bdi_writeback.state
@@ -199,7 +200,7 @@ struct backing_dev_info {
 	struct timer_list laptop_mode_wb_timer;
 
 #ifdef CONFIG_DEBUG_FS
-	struct dentry *debug_dir;
+	struct debugfs_node *debug_dir;
 #endif
 };
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 9ebb53f031cd..c739af74aa75 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -431,9 +431,9 @@ struct blk_mq_hw_ctx {
 	 * @debugfs_dir: debugfs directory for this hardware queue. Named
 	 * as cpu<cpu_number>.
 	 */
-	struct dentry		*debugfs_dir;
+	struct debugfs_node *debugfs_dir;
 	/** @sched_debugfs_dir:	debugfs directory for the scheduler. */
-	struct dentry		*sched_debugfs_dir;
+	struct debugfs_node *sched_debugfs_dir;
 #endif
 
 	/**
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 248416ecd01c..c81a861054d1 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -597,9 +597,9 @@ struct request_queue {
 	struct blk_mq_tag_set	*tag_set;
 	struct list_head	tag_set_list;
 
-	struct dentry		*debugfs_dir;
-	struct dentry		*sched_debugfs_dir;
-	struct dentry		*rqos_debugfs_dir;
+	struct debugfs_node *debugfs_dir;
+	struct debugfs_node *sched_debugfs_dir;
+	struct debugfs_node *rqos_debugfs_dir;
 	/*
 	 * Serializes all debugfs metadata operations using the above dentries.
 	 */
diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
index 122c62e561fc..65a29230e99d 100644
--- a/include/linux/blktrace_api.h
+++ b/include/linux/blktrace_api.h
@@ -23,7 +23,7 @@ struct blk_trace {
 	u64 end_lba;
 	u32 pid;
 	u32 dev;
-	struct dentry *dir;
+	struct debugfs_node *dir;
 	struct list_head running_list;
 	atomic_t dropped;
 };
diff --git a/include/linux/cdx/cdx_bus.h b/include/linux/cdx/cdx_bus.h
index 79bb80e56790..c8008cae0c00 100644
--- a/include/linux/cdx/cdx_bus.h
+++ b/include/linux/cdx/cdx_bus.h
@@ -156,7 +156,7 @@ struct cdx_device {
 	u8 dev_num;
 	struct resource res[MAX_CDX_DEV_RESOURCES];
 	struct bin_attribute *res_attr[MAX_CDX_DEV_RESOURCES];
-	struct dentry *debugfs_dir;
+	struct debugfs_node *debugfs_dir;
 	u8 res_count;
 	u64 dma_mask;
 	u16 flags;
diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
index 733e7f93db66..ff51a7b28452 100644
--- a/include/linux/ceph/libceph.h
+++ b/include/linux/ceph/libceph.h
@@ -134,10 +134,10 @@ struct ceph_client {
 	struct ceph_osd_client osdc;
 
 #ifdef CONFIG_DEBUG_FS
-	struct dentry *debugfs_dir;
-	struct dentry *debugfs_monmap;
-	struct dentry *debugfs_osdmap;
-	struct dentry *debugfs_options;
+	struct debugfs_node *debugfs_dir;
+	struct debugfs_node *debugfs_monmap;
+	struct debugfs_node *debugfs_osdmap;
+	struct debugfs_node *debugfs_options;
 #endif
 };
 
diff --git a/include/linux/ceph/mon_client.h b/include/linux/ceph/mon_client.h
index 7a9a40163c0f..1225b5bae1d1 100644
--- a/include/linux/ceph/mon_client.h
+++ b/include/linux/ceph/mon_client.h
@@ -100,7 +100,7 @@ struct ceph_mon_client {
 	int fs_cluster_id; /* "mdsmap.<id>" sub */
 
 #ifdef CONFIG_DEBUG_FS
-	struct dentry *debugfs_file;
+	struct debugfs_node *debugfs_file;
 #endif
 };
 
diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index d55b30057a45..a867483aaae6 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -424,7 +424,7 @@ struct ceph_osd_client {
 	struct delayed_work    timeout_work;
 	struct delayed_work    osds_timeout_work;
 #ifdef CONFIG_DEBUG_FS
-	struct dentry 	       *debugfs_file;
+	struct debugfs_node *debugfs_file;
 #endif
 
 	mempool_t              *req_mempool;
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 2e6e603b7493..d543a20bc150 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -37,6 +37,7 @@ struct clk;
 struct clk_hw;
 struct clk_core;
 struct dentry;
+#define debugfs_node dentry
 
 /**
  * struct clk_rate_request - Structure encoding the clk constraints that
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 346251bf1026..c1080847e0a6 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -960,7 +960,7 @@ struct dma_device {
 	void (*device_release)(struct dma_device *dev);
 	/* debugfs support */
 	void (*dbg_summary_show)(struct seq_file *s, struct dma_device *dev);
-	struct dentry *dbg_dev_root;
+	struct debugfs_node *dbg_dev_root;
 };
 
 static inline int dmaengine_slave_config(struct dma_chan *chan,
diff --git a/include/linux/edac.h b/include/linux/edac.h
index b4ee8961e623..35b3bec64c6a 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -605,7 +605,7 @@ struct mem_ctl_info {
 	/* the internal state of this controller instance */
 	int op_state;
 
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 	u8 fake_inject_layer[EDAC_MAX_LAYERS];
 	bool fake_inject_ue;
 	u16 fake_inject_count;
diff --git a/include/linux/fault-inject.h b/include/linux/fault-inject.h
index 8c829d28dcf3..cfbffb130c0c 100644
--- a/include/linux/fault-inject.h
+++ b/include/linux/fault-inject.h
@@ -6,6 +6,7 @@
 #include <linux/types.h>
 
 struct dentry;
+#define debugfs_node dentry
 struct kmem_cache;
 
 #ifdef CONFIG_FAULT_INJECTION
@@ -79,13 +80,13 @@ static inline bool should_fail(struct fault_attr *attr, ssize_t size)
 
 #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
 
-struct dentry *fault_create_debugfs_attr(const char *name,
-			struct dentry *parent, struct fault_attr *attr);
+struct debugfs_node *fault_create_debugfs_attr(const char *name,
+			struct debugfs_node *parent, struct fault_attr *attr);
 
 #else /* CONFIG_FAULT_INJECTION_DEBUG_FS */
 
-static inline struct dentry *fault_create_debugfs_attr(const char *name,
-			struct dentry *parent, struct fault_attr *attr)
+static inline struct debugfs_node *fault_create_debugfs_attr(const char *name,
+			struct debugfs_node *parent, struct fault_attr *attr)
 {
 	return ERR_PTR(-ENODEV);
 }
diff --git a/include/linux/firmware/cirrus/cs_dsp.h b/include/linux/firmware/cirrus/cs_dsp.h
index 7cae703b3137..a139491ecef7 100644
--- a/include/linux/firmware/cirrus/cs_dsp.h
+++ b/include/linux/firmware/cirrus/cs_dsp.h
@@ -189,7 +189,7 @@ struct cs_dsp {
 	unsigned int lock_regions;
 
 #ifdef CONFIG_DEBUG_FS
-	struct dentry *debugfs_root;
+	struct debugfs_node *debugfs_root;
 	char *wmfw_file_name;
 	char *bin_file_name;
 #endif
@@ -242,7 +242,8 @@ void cs_dsp_adsp2_bus_error(struct cs_dsp *dsp);
 void cs_dsp_halo_bus_error(struct cs_dsp *dsp);
 void cs_dsp_halo_wdt_expire(struct cs_dsp *dsp);
 
-void cs_dsp_init_debugfs(struct cs_dsp *dsp, struct dentry *debugfs_root);
+void cs_dsp_init_debugfs(struct cs_dsp *dsp,
+			 struct debugfs_node *debugfs_root);
 void cs_dsp_cleanup_debugfs(struct cs_dsp *dsp);
 
 int cs_dsp_coeff_write_acked_control(struct cs_dsp_coeff_ctl *ctl, unsigned int event_id);
diff --git a/include/linux/fsl/ptp_qoriq.h b/include/linux/fsl/ptp_qoriq.h
index b301bf7199d3..f774ff96d704 100644
--- a/include/linux/fsl/ptp_qoriq.h
+++ b/include/linux/fsl/ptp_qoriq.h
@@ -145,7 +145,7 @@ struct ptp_qoriq {
 	struct ptp_clock *clock;
 	struct ptp_clock_info caps;
 	struct resource *rsrc;
-	struct dentry *debugfs_root;
+	struct debugfs_node *debugfs_root;
 	struct device *dev;
 	bool extts_fifo_support;
 	bool fiper3_support;
diff --git a/include/linux/greybus.h b/include/linux/greybus.h
index 4d58e27ceaf6..ff6f875cfafb 100644
--- a/include/linux/greybus.h
+++ b/include/linux/greybus.h
@@ -102,7 +102,7 @@ int greybus_disabled(void);
 
 void gb_debugfs_init(void);
 void gb_debugfs_cleanup(void);
-struct dentry *gb_debugfs_get(void);
+struct debugfs_node *gb_debugfs_get(void);
 
 extern const struct bus_type greybus_bus_type;
 
diff --git a/include/linux/greybus/svc.h b/include/linux/greybus/svc.h
index da547fb9071b..2e4ef728e960 100644
--- a/include/linux/greybus/svc.h
+++ b/include/linux/greybus/svc.h
@@ -54,7 +54,7 @@ struct gb_svc {
 	struct gb_svc_watchdog	*watchdog;
 	enum gb_svc_watchdog_bite action;
 
-	struct dentry *debugfs_dentry;
+	struct debugfs_node *debugfs_dentry;
 	struct svc_debugfs_pwrmon_rail *pwrmon_rails;
 };
 #define to_gb_svc(d) container_of(d, struct gb_svc, dev)
diff --git a/include/linux/hid.h b/include/linux/hid.h
index cdc0dc13c87f..4321ae40c35b 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -678,9 +678,9 @@ struct hid_device {
 
 	/* debugging support via debugfs */
 	unsigned short debug;
-	struct dentry *debug_dir;
-	struct dentry *debug_rdesc;
-	struct dentry *debug_events;
+	struct debugfs_node *debug_dir;
+	struct debugfs_node *debug_rdesc;
+	struct debugfs_node *debug_events;
 	struct list_head debug_list;
 	spinlock_t  debug_list_lock;
 	wait_queue_head_t debug_wait;
diff --git a/include/linux/hisi_acc_qm.h b/include/linux/hisi_acc_qm.h
index 99fcf65d575f..59ccda708923 100644
--- a/include/linux/hisi_acc_qm.h
+++ b/include/linux/hisi_acc_qm.h
@@ -197,8 +197,8 @@ struct qm_debug {
 	u32 sqe_mask_offset;
 	u32 sqe_mask_len;
 	struct qm_dfx dfx;
-	struct dentry *debug_root;
-	struct dentry *qm_d;
+	struct debugfs_node *debug_root;
+	struct debugfs_node *qm_d;
 	struct debugfs_file files[DEBUG_FILE_NUM];
 	struct qm_dev_dfx dev_dfx;
 	unsigned int *qm_last_words;
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 4179add2864b..a67e9b3007d0 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1315,7 +1315,7 @@ struct hv_device {
 	u64 dma_mask;
 
 	/* place holder to keep track of the dir for hv device in debugfs */
-	struct dentry *debug_dir;
+	struct debugfs_node *debug_dir;
 
 };
 
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 2b2af24d2a43..cda945c9a6ca 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -352,7 +352,7 @@ struct i2c_client {
 	i2c_slave_cb_t slave_cb;	/* callback for slave mode	*/
 #endif
 	void *devres_group_id;		/* ID of probe devres group	*/
-	struct dentry *debugfs;		/* per-client debugfs dir	*/
+	struct debugfs_node *debugfs;		/* per-client debugfs dir	*/
 };
 #define to_i2c_client(d) container_of(d, struct i2c_client, dev)
 
@@ -763,7 +763,7 @@ struct i2c_adapter {
 	struct irq_domain *host_notify_domain;
 	struct regulator *bus_regulator;
 
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 
 	/* 7bit address space */
 	DECLARE_BITMAP(addrs_in_instantiation, 1 << 7);
diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
index 4247497f3f8b..7bff1132ee6c 100644
--- a/include/linux/iio/iio-opaque.h
+++ b/include/linux/iio/iio-opaque.h
@@ -69,7 +69,7 @@ struct iio_dev_opaque {
 	unsigned long			flags;
 
 #if defined(CONFIG_DEBUG_FS)
-	struct dentry			*debugfs_dentry;
+	struct debugfs_node *debugfs_dentry;
 	unsigned int			cached_reg_addr;
 	char				read_buf[20];
 	unsigned int			read_buf_len;
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 56161e02f002..a4bfcaef7af1 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -802,9 +802,9 @@ struct iio_trigger *__devm_iio_trigger_alloc(struct device *parent,
  * @indio_dev:		IIO device structure for device
  **/
 #if defined(CONFIG_DEBUG_FS)
-struct dentry *iio_get_debugfs_dentry(struct iio_dev *indio_dev);
+struct debugfs_node *iio_get_debugfs_dentry(struct iio_dev *indio_dev);
 #else
-static inline struct dentry *iio_get_debugfs_dentry(struct iio_dev *indio_dev)
+static inline struct debugfs_node *iio_get_debugfs_dentry(struct iio_dev *indio_dev)
 {
 	return NULL;
 }
diff --git a/include/linux/intel_tpmi.h b/include/linux/intel_tpmi.h
index ff480b47ae64..f764d4f665eb 100644
--- a/include/linux/intel_tpmi.h
+++ b/include/linux/intel_tpmi.h
@@ -54,5 +54,5 @@ struct resource *tpmi_get_resource_at_index(struct auxiliary_device *auxdev, int
 int tpmi_get_resource_count(struct auxiliary_device *auxdev);
 int tpmi_get_feature_status(struct auxiliary_device *auxdev, int feature_id, bool *read_blocked,
 			    bool *write_blocked);
-struct dentry *tpmi_get_debugfs_dir(struct auxiliary_device *auxdev);
+struct debugfs_node *tpmi_get_debugfs_dir(struct auxiliary_device *auxdev);
 #endif
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 38c65e92ecd0..93358fb7bebc 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1496,7 +1496,7 @@ static inline ssize_t iommu_map_sgtable(struct iommu_domain *domain,
 }
 
 #ifdef CONFIG_IOMMU_DEBUGFS
-extern	struct dentry *iommu_debugfs_dir;
+extern	struct debugfs_node *iommu_debugfs_dir;
 void iommu_debugfs_setup(void);
 #else
 static inline void iommu_debugfs_setup(void) {}
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index f34f4cfaa513..86ac3c997be2 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -842,7 +842,7 @@ struct kvm {
 #endif
 	struct list_head devices;
 	u64 manual_dirty_log_protect;
-	struct dentry *debugfs_dentry;
+	struct debugfs_node *debugfs_dentry;
 	struct kvm_stat_data **debugfs_stat_data;
 	struct srcu_struct srcu;
 	struct srcu_struct irq_srcu;
@@ -1586,7 +1586,8 @@ int kvm_arch_pm_notifier(struct kvm *kvm, unsigned long state);
 #endif
 
 #ifdef __KVM_HAVE_ARCH_VCPU_DEBUGFS
-void kvm_arch_create_vcpu_debugfs(struct kvm_vcpu *vcpu, struct dentry *debugfs_dentry);
+void kvm_arch_create_vcpu_debugfs(struct kvm_vcpu *vcpu,
+				  struct debugfs_node *debugfs_dentry);
 #else
 static inline void kvm_create_vcpu_debugfs(struct kvm_vcpu *vcpu) {}
 #endif
diff --git a/include/linux/mfd/aat2870.h b/include/linux/mfd/aat2870.h
index 2445842d482d..e05e4427fdf1 100644
--- a/include/linux/mfd/aat2870.h
+++ b/include/linux/mfd/aat2870.h
@@ -135,7 +135,7 @@ struct aat2870_data {
 	int (*update)(struct aat2870_data *aat2870, u8 addr, u8 mask, u8 val);
 
 	/* for debugfs */
-	struct dentry *dentry_root;
+	struct debugfs_node *dentry_root;
 };
 
 struct aat2870_subdev_info {
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index 059dc94d20bb..2d39ef47d153 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -371,7 +371,7 @@ struct mhi_controller {
 	const char *name;
 	struct device *cntrl_dev;
 	struct mhi_device *mhi_dev;
-	struct dentry *debugfs_dentry;
+	struct debugfs_node *debugfs_dentry;
 	void __iomem *regs;
 	void __iomem *bhi;
 	void __iomem *bhie;
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index af86097641b0..19111ae8b566 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -219,7 +219,7 @@ struct mlx5_rsc_debug {
 	struct mlx5_core_dev   *dev;
 	void		       *object;
 	enum dbg_rsc_type	type;
-	struct dentry	       *root;
+	struct debugfs_node *root;
 	struct mlx5_field_desc	fields[];
 };
 
@@ -253,7 +253,7 @@ struct mlx5_cmd_msg {
 };
 
 struct mlx5_cmd_debug {
-	struct dentry	       *dbg_root;
+	struct debugfs_node *dbg_root;
 	void		       *in_msg;
 	void		       *out_msg;
 	u8			status;
@@ -287,7 +287,7 @@ struct mlx5_cmd_stats {
 	u8		last_failed_mbox_status;
 	/* last command failed syndrome returned by FW */
 	u32		last_failed_syndrome;
-	struct dentry  *root;
+	struct debugfs_node *root;
 	/* protect command average calculations */
 	spinlock_t	lock;
 };
@@ -537,13 +537,13 @@ struct mlx5_adev {
 };
 
 struct mlx5_debugfs_entries {
-	struct dentry *dbg_root;
-	struct dentry *qp_debugfs;
-	struct dentry *eq_debugfs;
-	struct dentry *cq_debugfs;
-	struct dentry *cmdif_debugfs;
-	struct dentry *pages_debugfs;
-	struct dentry *lag_debugfs;
+	struct debugfs_node *dbg_root;
+	struct debugfs_node *qp_debugfs;
+	struct debugfs_node *eq_debugfs;
+	struct debugfs_node *cq_debugfs;
+	struct debugfs_node *cmdif_debugfs;
+	struct debugfs_node *pages_debugfs;
+	struct debugfs_node *lag_debugfs;
 };
 
 enum mlx5_func_type {
@@ -899,7 +899,7 @@ struct mlx5_hca_vport_context {
 	.struct_offset_bytes = offsetof(struct ib_unpacked_ ## header, field),      \
 	.struct_size_bytes   = sizeof((struct ib_unpacked_ ## header *)0)->field
 
-extern struct dentry *mlx5_debugfs_root;
+extern struct debugfs_node *mlx5_debugfs_root;
 
 static inline u16 fw_rev_maj(struct mlx5_core_dev *dev)
 {
@@ -1059,7 +1059,7 @@ int mlx5_comp_eqn_get(struct mlx5_core_dev *dev, u16 vecidx, int *eqn);
 int mlx5_core_attach_mcg(struct mlx5_core_dev *dev, union ib_gid *mgid, u32 qpn);
 int mlx5_core_detach_mcg(struct mlx5_core_dev *dev, union ib_gid *mgid, u32 qpn);
 
-struct dentry *mlx5_debugfs_get_dev_root(struct mlx5_core_dev *dev);
+struct debugfs_node *mlx5_debugfs_get_dev_root(struct mlx5_core_dev *dev);
 void mlx5_qp_debugfs_init(struct mlx5_core_dev *dev);
 void mlx5_qp_debugfs_cleanup(struct mlx5_core_dev *dev);
 int mlx5_access_reg(struct mlx5_core_dev *dev, void *data_in, int size_in,
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 526fce581657..c009f3613fc4 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -372,7 +372,7 @@ struct mmc_card {
 	unsigned int		mmc_avail_type;	/* supported device type by both host and card */
 	unsigned int		drive_strength;	/* for UHS-I, HS200 or HS400 */
 
-	struct dentry		*debugfs_root;
+	struct debugfs_node *debugfs_root;
 	struct mmc_part	part[MMC_NUM_PHY_PARTITION]; /* physical partitions */
 	unsigned int    nr_parts;
 
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 68f09a955a90..a97843201bbc 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -532,7 +532,7 @@ struct mmc_host {
 #endif
 	struct mmc_supply	supply;
 
-	struct dentry		*debugfs_root;
+	struct debugfs_node *debugfs_root;
 
 	/* Ongoing data transfer that allows commands during transfer */
 	struct mmc_request	*ongoing_mrq;
diff --git a/include/linux/moxtet.h b/include/linux/moxtet.h
index dfa4800306ee..27f5af9a7368 100644
--- a/include/linux/moxtet.h
+++ b/include/linux/moxtet.h
@@ -52,7 +52,7 @@ struct moxtet {
 		} position[MOXTET_NIRQS];
 	} irq;
 #ifdef CONFIG_DEBUG_FS
-	struct dentry			*debugfs_root;
+	struct debugfs_node *debugfs_root;
 #endif
 };
 
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index 8d10d9d2e830..292183214c9d 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -194,7 +194,7 @@ struct module;	/* only needed for owner field in mtd_info */
  * @dfs_dir: direntry object of the MTD device debugfs directory
  */
 struct mtd_debug_info {
-	struct dentry *dfs_dir;
+	struct debugfs_node *dfs_dir;
 };
 
 /**
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index cdcfe0fd2e7d..29567aa01669 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -408,7 +408,7 @@ struct spi_nor {
 	u32			flags;
 	enum spi_nor_cmd_ext	cmd_ext_type;
 	struct sfdp		*sfdp;
-	struct dentry		*debugfs_root;
+	struct debugfs_node *debugfs_root;
 
 	const struct spi_nor_controller_ops *controller_ops;
 
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index 03cd5bae92d3..78cd9019bf01 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -164,7 +164,7 @@ struct phy {
 	int			power_count;
 	struct phy_attrs	attrs;
 	struct regulator	*pwr;
-	struct dentry		*debugfs;
+	struct debugfs_node *debugfs;
 };
 
 /**
diff --git a/include/linux/pktcdvd.h b/include/linux/pktcdvd.h
index 2f1b952d596a..24fc921bbb04 100644
--- a/include/linux/pktcdvd.h
+++ b/include/linux/pktcdvd.h
@@ -191,8 +191,8 @@ struct pktcdvd_device
 
 	struct device		*dev;		/* sysfs pktcdvd[0-7] dev */
 
-	struct dentry		*dfs_d_root;	/* debugfs: devname directory */
-	struct dentry		*dfs_f_info;	/* debugfs: info file */
+	struct debugfs_node *dfs_d_root;	/* debugfs: devname directory */
+	struct debugfs_node *dfs_f_info;	/* debugfs: info file */
 };
 
 #endif /* __PKTCDVD_H */
diff --git a/include/linux/power/smartreflex.h b/include/linux/power/smartreflex.h
index 3a2c79dfc1ff..6bf8ba3bee3b 100644
--- a/include/linux/power/smartreflex.h
+++ b/include/linux/power/smartreflex.h
@@ -153,7 +153,7 @@ struct omap_sr {
 	struct platform_device		*pdev;
 	struct omap_sr_nvalue_table	*nvalue_table;
 	struct voltagedomain		*voltdm;
-	struct dentry			*dbg_dir;
+	struct debugfs_node *dbg_dir;
 	unsigned int			irq;
 	struct clk			*fck;
 	int				srid;
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 4a216fdba354..5ba6e400c17d 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -644,7 +644,7 @@ struct regulator_dev {
 
 	void *reg_data;		/* regulator_dev data */
 
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 
 	struct regulator_enable_gpio *ena_pin;
 	unsigned int ena_gpio_state:1;
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index b4795698d8c2..8ec44b500f86 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -558,7 +558,7 @@ struct rproc {
 	unsigned int state;
 	enum rproc_dump_mechanism dump_conf;
 	struct mutex lock;
-	struct dentry *dbg_dir;
+	struct debugfs_node *dbg_dir;
 	struct list_head traces;
 	int num_traces;
 	struct list_head carveouts;
diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 1a00be90d93a..a7298da00fa9 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -111,7 +111,7 @@ struct shrinker {
 #ifdef CONFIG_SHRINKER_DEBUG
 	int debugfs_id;
 	const char *name;
-	struct dentry *debugfs_entry;
+	struct debugfs_node *debugfs_entry;
 #endif
 	/* objs pending delete, per node */
 	atomic_long_t *nr_deferred;
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 2d6c30317792..2da002eb5767 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -17,6 +17,7 @@
 #include <sound/sdca.h>
 
 struct dentry;
+#define debugfs_node dentry
 struct fwnode_handle;
 
 struct sdw_bus;
@@ -664,7 +665,7 @@ struct sdw_slave {
 	struct sdw_bus *bus;
 	struct sdw_slave_prop prop;
 #ifdef CONFIG_DEBUG_FS
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 #endif
 	struct list_head node;
 	struct completion port_ready[SDW_MAX_PORTS];
@@ -1011,7 +1012,7 @@ struct sdw_bus {
 	struct irq_chip irq_chip;
 	struct irq_domain *domain;
 #ifdef CONFIG_DEBUG_FS
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 #endif
 	bool multi_link;
 	unsigned int lane_used_bandwidth[SDW_MAX_LANES];
diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index fec976e58174..e7c939c101f3 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -80,7 +80,7 @@ struct rpc_clnt {
 	const struct rpc_program *cl_program;
 	const char *		cl_principal;	/* use for machine cred */
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
-	struct dentry		*cl_debugfs;	/* debugfs directory */
+	struct debugfs_node *cl_debugfs;	/* debugfs directory */
 #endif
 	struct rpc_sysfs_client *cl_sysfs;	/* sysfs directory */
 	/* cl_work is only needed after cl_xpi is no longer used,
diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
index 81b952649d35..c7fce492d1f1 100644
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -300,7 +300,7 @@ struct rpc_xprt {
 	const char		*servername;
 	const char		*address_strings[RPC_DISPLAY_MAX];
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
-	struct dentry		*debugfs;		/* debugfs directory */
+	struct debugfs_node *debugfs;		/* debugfs directory */
 #endif
 	struct rcu_head		rcu;
 	const struct xprt_class	*xprt_class;
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 3dae0f592063..993cd65f005d 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -108,7 +108,7 @@ struct io_tlb_pool {
 struct io_tlb_mem {
 	struct io_tlb_pool defpool;
 	unsigned long nslabs;
-	struct dentry *debugfs;
+	struct debugfs_node *debugfs;
 	bool force_bounce;
 	bool for_alloc;
 #ifdef CONFIG_SWIOTLB_DYNAMIC
diff --git a/include/linux/thunderbolt.h b/include/linux/thunderbolt.h
index 7d902d8c054b..2ca1c66d20ff 100644
--- a/include/linux/thunderbolt.h
+++ b/include/linux/thunderbolt.h
@@ -401,7 +401,7 @@ struct tb_service {
 	u32 prtcvers;
 	u32 prtcrevs;
 	u32 prtcstns;
-	struct dentry *debugfs_dir;
+	struct debugfs_node *debugfs_dir;
 };
 
 static inline struct tb_service *tb_service_get(struct tb_service *svc)
diff --git a/include/linux/usb.h b/include/linux/usb.h
index cfa8005e24f9..02db73eade37 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -2044,7 +2044,7 @@ extern void usb_register_notify(struct notifier_block *nb);
 extern void usb_unregister_notify(struct notifier_block *nb);
 
 /* debugfs stuff */
-extern struct dentry *usb_debug_root;
+extern struct debugfs_node *usb_debug_root;
 
 /* LED triggers */
 enum usb_led_event {
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 000a6cab2d31..2e2fed34ff1f 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -75,7 +75,7 @@ struct vfio_device {
 	 * debug_root is a static property of the vfio_device
 	 * which must be set prior to registering the vfio_device.
 	 */
-	struct dentry *debug_root;
+	struct debugfs_node *debug_root;
 #endif
 };
 
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 4d16c13d0df5..4282908c23ab 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -162,7 +162,7 @@ struct virtio_device {
 	u64 features;
 	void *priv;
 #ifdef CONFIG_VIRTIO_DEBUG
-	struct dentry *debugfs_dir;
+	struct debugfs_node *debugfs_dir;
 	u64 debugfs_filter_features;
 #endif
 };
diff --git a/include/linux/wkup_m3_ipc.h b/include/linux/wkup_m3_ipc.h
index 5e1b26f988e2..111956068f35 100644
--- a/include/linux/wkup_m3_ipc.h
+++ b/include/linux/wkup_m3_ipc.h
@@ -39,7 +39,7 @@ struct wkup_m3_ipc {
 
 	struct wkup_m3_ipc_ops *ops;
 	int is_rtc_only;
-	struct dentry *dbg_path;
+	struct debugfs_node *dbg_path;
 };
 
 struct wkup_m3_wakeup_src {
diff --git a/include/linux/wwan.h b/include/linux/wwan.h
index a4d6cc0c9f68..b5ac78c37fbc 100644
--- a/include/linux/wwan.h
+++ b/include/linux/wwan.h
@@ -192,14 +192,14 @@ int wwan_register_ops(struct device *parent, const struct wwan_ops *ops,
 void wwan_unregister_ops(struct device *parent);
 
 #ifdef CONFIG_WWAN_DEBUGFS
-struct dentry *wwan_get_debugfs_dir(struct device *parent);
-void wwan_put_debugfs_dir(struct dentry *dir);
+struct debugfs_node *wwan_get_debugfs_dir(struct device *parent);
+void wwan_put_debugfs_dir(struct debugfs_node *dir);
 #else
-static inline struct dentry *wwan_get_debugfs_dir(struct device *parent)
+static inline struct debugfs_node *wwan_get_debugfs_dir(struct device *parent)
 {
 	return ERR_PTR(-ENODEV);
 }
-static inline void wwan_put_debugfs_dir(struct dentry *dir) {}
+static inline void wwan_put_debugfs_dir(struct debugfs_node *dir) {}
 #endif
 
 #endif /* __WWAN_H */
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index 86b0d47984a1..2acfcfa25c44 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -25,6 +25,7 @@
 
 struct inode;
 struct dentry;
+#define debugfs_node dentry
 
 static inline bool is_posix_acl_xattr(const char *name)
 {
diff --git a/include/media/v4l2-dev.h b/include/media/v4l2-dev.h
index 1b6222fab24e..f4a53b8dd96f 100644
--- a/include/media/v4l2-dev.h
+++ b/include/media/v4l2-dev.h
@@ -63,6 +63,7 @@ struct video_device;
 struct v4l2_device;
 struct v4l2_ctrl_handler;
 struct dentry;
+#define debugfs_node dentry
 
 /**
  * enum v4l2_video_device_flags - Flags used by &struct video_device
@@ -546,9 +547,9 @@ static inline int video_is_registered(struct video_device *vdev)
  * If this directory does not yet exist, then it will be created.
  */
 #ifdef CONFIG_DEBUG_FS
-struct dentry *v4l2_debugfs_root(void);
+struct debugfs_node *v4l2_debugfs_root(void);
 #else
-static inline struct dentry *v4l2_debugfs_root(void)
+static inline struct debugfs_node *v4l2_debugfs_root(void)
 {
 	return NULL;
 }
diff --git a/include/media/v4l2-dv-timings.h b/include/media/v4l2-dv-timings.h
index ff07dc6b103c..e08294607e5f 100644
--- a/include/media/v4l2-dv-timings.h
+++ b/include/media/v4l2-dv-timings.h
@@ -280,20 +280,22 @@ typedef ssize_t (*v4l2_debugfs_if_read_t)(u32 type, void *priv,
 					  size_t count, loff_t *ppos);
 
 struct v4l2_debugfs_if {
-	struct dentry *if_dir;
+	struct debugfs_node *if_dir;
 	void *priv;
 
 	v4l2_debugfs_if_read_t if_read;
 };
 
 #ifdef CONFIG_DEBUG_FS
-struct v4l2_debugfs_if *v4l2_debugfs_if_alloc(struct dentry *root, u32 if_types,
+struct v4l2_debugfs_if *v4l2_debugfs_if_alloc(struct debugfs_node *root,
+					      u32 if_types,
 					      void *priv,
 					      v4l2_debugfs_if_read_t if_read);
 void v4l2_debugfs_if_free(struct v4l2_debugfs_if *infoframes);
 #else
 static inline
-struct v4l2_debugfs_if *v4l2_debugfs_if_alloc(struct dentry *root, u32 if_types,
+struct v4l2_debugfs_if *v4l2_debugfs_if_alloc(struct debugfs_node *root,
+					      u32 if_types,
 					      void *priv,
 					      v4l2_debugfs_if_read_t if_read)
 {
diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
index c80539be1542..48c0026d3024 100644
--- a/include/net/6lowpan.h
+++ b/include/net/6lowpan.h
@@ -134,7 +134,7 @@ lowpan_iphc_ctx_is_compression(const struct lowpan_iphc_ctx *ctx)
 
 struct lowpan_dev {
 	enum lowpan_lltypes lltype;
-	struct dentry *iface_debugfs;
+	struct debugfs_node *iface_debugfs;
 	struct lowpan_iphc_ctx_table ctx;
 
 	/* must be last */
diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 435250c72d56..dda52f8d6c99 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -611,7 +611,7 @@ int bt_procfs_init(struct net *net, const char *name,
 		   int (*seq_show)(struct seq_file *, void *));
 void bt_procfs_cleanup(struct net *net, const char *name);
 
-extern struct dentry *bt_debugfs;
+extern struct debugfs_node *bt_debugfs;
 
 int l2cap_init(void);
 void l2cap_exit(void);
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index f756fac95488..8f9a20b009df 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -561,7 +561,7 @@ struct hci_dev {
 
 	const char		*hw_info;
 	const char		*fw_info;
-	struct dentry		*debugfs;
+	struct debugfs_node *debugfs;
 
 	struct hci_devcoredump	dump;
 
@@ -739,7 +739,7 @@ struct hci_conn {
 	struct delayed_work le_conn_timeout;
 
 	struct device	dev;
-	struct dentry	*debugfs;
+	struct debugfs_node *debugfs;
 
 	struct hci_dev	*hdev;
 	void		*l2cap_data;
diff --git a/include/net/bonding.h b/include/net/bonding.h
index 8bb5f016969f..ea26d81db7f1 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -254,7 +254,7 @@ struct bonding {
 	struct   delayed_work slave_arr_work;
 #ifdef CONFIG_DEBUG_FS
 	/* debugging support via debugfs */
-	struct	 dentry *debug_dir;
+	struct debugfs_node *debug_dir;
 #endif /* CONFIG_DEBUG_FS */
 	struct rtnl_link_stats64 bond_stats;
 #ifdef CONFIG_XFRM_OFFLOAD
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 363d7dd2255a..214341216cb9 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5793,7 +5793,7 @@ struct wiphy {
 
 	bool registered;
 
-	struct dentry *debugfsdir;
+	struct debugfs_node *debugfsdir;
 
 	const struct ieee80211_ht_cap *ht_capa_mod_mask;
 	const struct ieee80211_vht_cap *vht_capa_mod_mask;
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index c3ed2fcff8b7..3443ac47384a 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2045,7 +2045,7 @@ struct ieee80211_vif {
 	u32 offload_flags;
 
 #ifdef CONFIG_MAC80211_DEBUGFS
-	struct dentry *debugfs_dir;
+	struct debugfs_node *debugfs_dir;
 #endif
 
 	bool probe_req_reg;
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 90f56656b572..1b845e410ec9 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -268,7 +268,7 @@ struct gdma_queue;
 
 struct mana_eq {
 	struct gdma_queue	*eq;
-	struct dentry		*mana_eq_debugfs;
+	struct debugfs_node *mana_eq_debugfs;
 };
 
 typedef void gdma_eq_callback(void *context, struct gdma_queue *q,
@@ -366,7 +366,7 @@ struct gdma_irq_context {
 
 struct gdma_context {
 	struct device		*dev;
-	struct dentry		*mana_pci_debugfs;
+	struct debugfs_node *mana_pci_debugfs;
 
 	/* Per-vPort max number of queues */
 	unsigned int		max_num_queues;
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 0d00b24eacaf..ceddff29b990 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -350,7 +350,7 @@ struct mana_rxq {
 	int xdp_rc; /* XDP redirect return code */
 
 	struct page_pool *page_pool;
-	struct dentry *mana_rx_debugfs;
+	struct debugfs_node *mana_rx_debugfs;
 
 	/* MUST BE THE LAST MEMBER:
 	 * Each receive buffer has an associated mana_recv_buf_oob.
@@ -365,7 +365,7 @@ struct mana_tx_qp {
 
 	mana_handle_t tx_object;
 
-	struct dentry *mana_tx_debugfs;
+	struct debugfs_node *mana_tx_debugfs;
 };
 
 struct mana_ethtool_stats {
@@ -410,7 +410,7 @@ struct mana_context {
 	u16 num_ports;
 
 	struct mana_eq *eqs;
-	struct dentry *mana_eqs_debugfs;
+	struct debugfs_node *mana_eqs_debugfs;
 
 	struct net_device *ports[MAX_PORTS_IN_MANA_DEV];
 };
@@ -474,7 +474,7 @@ struct mana_port_context {
 	struct mana_ethtool_stats eth_stats;
 
 	/* Debugfs */
-	struct dentry *mana_port_debugfs;
+	struct debugfs_node *mana_port_debugfs;
 };
 
 netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev);
@@ -501,7 +501,7 @@ int mana_pre_alloc_rxbufs(struct mana_port_context *apc, int mtu, int num_queues
 void mana_pre_dealloc_rxbufs(struct mana_port_context *apc);
 
 extern const struct ethtool_ops mana_ethtool_ops;
-extern struct dentry *mana_debugfs_root;
+extern struct debugfs_node *mana_debugfs_root;
 
 /* A CQ can be created not associated with any EQ */
 #define GDMA_CQ_NO_EQ  0xffff
diff --git a/include/soc/tegra/bpmp.h b/include/soc/tegra/bpmp.h
index f5e4ac5b8cce..d00053e657f6 100644
--- a/include/soc/tegra/bpmp.h
+++ b/include/soc/tegra/bpmp.h
@@ -100,7 +100,7 @@ struct tegra_bpmp {
 	struct genpd_onecell_data genpd;
 
 #ifdef CONFIG_DEBUG_FS
-	struct dentry *debugfs_mirror;
+	struct debugfs_node *debugfs_mirror;
 #endif
 
 	bool suspended;
diff --git a/include/sound/core.h b/include/sound/core.h
index 1f3f5dccd736..6e2b3a682bfb 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -131,7 +131,7 @@ struct snd_card {
 	size_t total_pcm_alloc_bytes;	/* total amount of allocated buffers */
 	struct mutex memory_mutex;	/* protection for the above */
 #ifdef CONFIG_SND_DEBUG
-	struct dentry *debugfs_root;    /* debugfs root for card */
+	struct debugfs_node *debugfs_root;    /* debugfs root for card */
 #endif
 
 #ifdef CONFIG_PM
@@ -234,7 +234,7 @@ extern int snd_major;
 extern int snd_ecards_limit;
 extern const struct class sound_class;
 #ifdef CONFIG_SND_DEBUG
-extern struct dentry *sound_debugfs_root;
+extern struct debugfs_node *sound_debugfs_root;
 #endif
 
 void snd_request_card(int card);
diff --git a/include/sound/soc-component.h b/include/sound/soc-component.h
index 61534ac0edd1..9f45be88aea2 100644
--- a/include/sound/soc-component.h
+++ b/include/sound/soc-component.h
@@ -252,7 +252,7 @@ struct snd_soc_component {
 	struct snd_compr_stream  *mark_compr_open;
 	void *mark_pm;
 
-	struct dentry *debugfs_root;
+	struct debugfs_node *debugfs_root;
 	const char *debugfs_prefix;
 };
 
diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 12cd7b5a2202..bb8445b7a384 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -711,7 +711,7 @@ struct snd_soc_dapm_context {
 	struct snd_soc_dapm_widget *wcache_source;
 
 #ifdef CONFIG_DEBUG_FS
-	struct dentry *debugfs_dapm;
+	struct debugfs_node *debugfs_dapm;
 #endif
 };
 
diff --git a/include/sound/soc-dpcm.h b/include/sound/soc-dpcm.h
index c6fb350b4b06..9d6845ad8c1b 100644
--- a/include/sound/soc-dpcm.h
+++ b/include/sound/soc-dpcm.h
@@ -78,7 +78,7 @@ struct snd_soc_dpcm {
 	struct list_head list_fe;
 
 #ifdef CONFIG_DEBUG_FS
-	struct dentry *debugfs_state;
+	struct debugfs_node *debugfs_state;
 #endif
 };
 
diff --git a/include/sound/soc.h b/include/sound/soc.h
index fcdb5adfcd5e..03abd4d3f501 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1118,7 +1118,7 @@ struct snd_soc_card {
 	struct snd_soc_dapm_update *update;
 
 #ifdef CONFIG_DEBUG_FS
-	struct dentry *debugfs_card_root;
+	struct debugfs_node *debugfs_card_root;
 #endif
 #ifdef CONFIG_PM_SLEEP
 	struct work_struct deferred_resume_work;
@@ -1489,7 +1489,7 @@ int snd_soc_fixup_dai_links_platform_name(struct snd_soc_card *card,
 }
 
 #ifdef CONFIG_DEBUG_FS
-extern struct dentry *snd_soc_debugfs_root;
+extern struct debugfs_node *snd_soc_debugfs_root;
 #endif
 
 extern const struct dev_pm_ops snd_soc_pm_ops;
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 8bf31e6ca4e5..bba8fc389e53 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -1105,7 +1105,7 @@ struct ufs_hba {
 	struct blk_crypto_profile crypto_profile;
 #endif
 #ifdef CONFIG_DEBUG_FS
-	struct dentry *debugfs_root;
+	struct debugfs_node *debugfs_root;
 	struct delayed_work debugfs_ee_work;
 	u32 debugfs_ee_rate_limit_ms;
 #endif
diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index e43c6de2bce4..fa702dfabf82 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -804,7 +804,7 @@ static const struct file_operations filter_fops = {
 
 static int __init dma_debug_fs_init(void)
 {
-	struct dentry *dentry = debugfs_create_dir("dma-api", NULL);
+	struct debugfs_node *dentry = debugfs_create_dir("dma-api", NULL);
 
 	debugfs_create_bool("disabled", 0444, dentry, &global_disable);
 	debugfs_create_u32("error_count", 0444, dentry, &error_count);
diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
index cc19a3efea89..cbaed427c074 100644
--- a/kernel/dma/map_benchmark.c
+++ b/kernel/dma/map_benchmark.c
@@ -22,7 +22,7 @@
 struct map_benchmark_data {
 	struct map_benchmark bparam;
 	struct device *dev;
-	struct dentry  *debugfs;
+	struct debugfs_node *debugfs;
 	enum dma_data_direction dir;
 	atomic64_t sum_map_100ns;
 	atomic64_t sum_unmap_100ns;
@@ -300,7 +300,7 @@ static void map_benchmark_remove_debugfs(void *data)
 
 static int __map_benchmark_probe(struct device *dev)
 {
-	struct dentry *entry;
+	struct debugfs_node *entry;
 	struct map_benchmark_data *map;
 	int ret;
 
diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 7b04f7575796..365cb51729b4 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -35,7 +35,7 @@ early_param("coherent_pool", early_coherent_pool);
 
 static void __init dma_atomic_pool_debugfs_init(void)
 {
-	struct dentry *root;
+	struct debugfs_node *root;
 
 	root = debugfs_create_dir("dma_pools", NULL);
 	debugfs_create_ulong("pool_size_dma", 0400, root, &pool_size_dma);
diff --git a/kernel/fail_function.c b/kernel/fail_function.c
index d971a0189319..6ab1f2bafea6 100644
--- a/kernel/fail_function.c
+++ b/kernel/fail_function.c
@@ -31,7 +31,7 @@ struct fei_attr {
 static DEFINE_MUTEX(fei_lock);
 static LIST_HEAD(fei_attr_list);
 static DECLARE_FAULT_ATTR(fei_fault_attr);
-static struct dentry *fei_debugfs_dir;
+static struct debugfs_node *fei_debugfs_dir;
 
 static unsigned long adjust_error_retval(unsigned long addr, unsigned long retv)
 {
@@ -154,7 +154,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(fei_retval_ops, fei_retval_get, fei_retval_set,
 
 static void fei_debugfs_add_attr(struct fei_attr *attr)
 {
-	struct dentry *dir;
+	struct debugfs_node *dir;
 
 	dir = debugfs_create_dir(attr->kp.symbol_name, fei_debugfs_dir);
 
@@ -314,7 +314,7 @@ static const struct file_operations fei_ops = {
 
 static int __init fei_debugfs_init(void)
 {
-	struct dentry *dir;
+	struct debugfs_node *dir;
 
 	dir = fault_create_debugfs_attr("fail_function", NULL,
 					&fei_fault_attr);
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 3db8567f5a44..b74ef2ff988b 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -89,7 +89,7 @@ bool should_fail_futex(bool fshared)
 static int __init fail_futex_debugfs(void)
 {
 	umode_t mode = S_IFREG | S_IRUSR | S_IWUSR;
-	struct dentry *dir;
+	struct debugfs_node *dir;
 
 	dir = fault_create_debugfs_attr("fail_futex", NULL,
 					&fail_futex.attr);
diff --git a/kernel/gcov/fs.c b/kernel/gcov/fs.c
index 01520689b57c..ed65d02010e0 100644
--- a/kernel/gcov/fs.c
+++ b/kernel/gcov/fs.c
@@ -56,7 +56,7 @@ struct gcov_node {
 	struct gcov_node *parent;
 	struct gcov_info **loaded_info;
 	struct gcov_info *unloaded_info;
-	struct dentry *dentry;
+	struct debugfs_node *dentry;
 	struct dentry **links;
 	int num_loaded;
 	char name[];
@@ -473,7 +473,7 @@ static const char *deskew(const char *basename)
  * Create links to additional files (usually .c and .gcno files) which the
  * gcov tool expects to find in the same directory as the gcov data file.
  */
-static void add_links(struct gcov_node *node, struct dentry *parent)
+static void add_links(struct gcov_node *node, struct debugfs_node *parent)
 {
 	const char *basename;
 	char *target;
diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index ca142b9a4db3..b3c1a1cb9999 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -7,7 +7,7 @@
 
 #include "internals.h"
 
-static struct dentry *irq_dir;
+static struct debugfs_node *irq_dir;
 
 void irq_debug_show_bits(struct seq_file *m, int ind, unsigned int state,
 			 const struct irq_bit_descr *sd, int size)
@@ -238,7 +238,7 @@ void irq_add_debugfs_entry(unsigned int irq, struct irq_desc *desc)
 
 static int __init irq_debugfs_init(void)
 {
-	struct dentry *root_dir;
+	struct debugfs_node *root_dir;
 	int irq;
 
 	root_dir = debugfs_create_dir("irq", NULL);
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index a979523640d0..38a9302b6843 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -511,9 +511,9 @@ static inline void irq_remove_debugfs_entry(struct irq_desc *desc)
 }
 void irq_debugfs_copy_devname(int irq, struct device *dev);
 # ifdef CONFIG_IRQ_DOMAIN
-void irq_domain_debugfs_init(struct dentry *root);
+void irq_domain_debugfs_init(struct debugfs_node *root);
 # else
-static inline void irq_domain_debugfs_init(struct dentry *root)
+static inline void irq_domain_debugfs_init(struct debugfs_node *root)
 {
 }
 # endif
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index ec6d8e72d980..eb438eebc125 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -2059,7 +2059,7 @@ static void irq_domain_free_one_irq(struct irq_domain *domain, unsigned int virq
 #ifdef CONFIG_GENERIC_IRQ_DEBUGFS
 #include "internals.h"
 
-static struct dentry *domain_dir;
+static struct debugfs_node *domain_dir;
 
 static const struct irq_bit_descr irqdomain_flags[] = {
 	BIT_MASK_DESCR(IRQ_DOMAIN_FLAG_HIERARCHY),
@@ -2119,7 +2119,7 @@ static void debugfs_remove_domain_dir(struct irq_domain *d)
 	debugfs_lookup_and_remove(d->name, domain_dir);
 }
 
-void __init irq_domain_debugfs_init(struct dentry *root)
+void __init irq_domain_debugfs_init(struct debugfs_node *root)
 {
 	struct irq_domain *d;
 
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 88aeac84e4c0..2e6449890cc9 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2977,7 +2977,7 @@ static const struct file_operations fops_kp = {
 
 static int __init debugfs_kprobe_init(void)
 {
-	struct dentry *dir;
+	struct debugfs_node *dir;
 
 	dir = debugfs_create_dir("kprobes", NULL);
 
diff --git a/kernel/locking/lock_events.c b/kernel/locking/lock_events.c
index e68d82099558..829ecebc834a 100644
--- a/kernel/locking/lock_events.c
+++ b/kernel/locking/lock_events.c
@@ -143,7 +143,7 @@ static inline bool skip_lockevent(const char *name)
  */
 static int __init init_lockevent_counts(void)
 {
-	struct dentry *d_counts = debugfs_create_dir(LOCK_EVENTS_DIR, NULL);
+	struct debugfs_node *d_counts = debugfs_create_dir(LOCK_EVENTS_DIR, NULL);
 	int i;
 
 	if (IS_ERR(d_counts))
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index d09b46ef032f..867ff26bbbfa 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -193,7 +193,7 @@ enum fail_dup_mod_reason {
 };
 
 #ifdef CONFIG_MODULE_DEBUGFS
-extern struct dentry *mod_debugfs_root;
+extern struct debugfs_node *mod_debugfs_root;
 #endif
 
 #ifdef CONFIG_MODULE_STATS
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 1fb9ad289a6f..48b21444fa79 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3852,7 +3852,7 @@ void print_modules(void)
 }
 
 #ifdef CONFIG_MODULE_DEBUGFS
-struct dentry *mod_debugfs_root;
+struct debugfs_node *mod_debugfs_root;
 
 static int module_debugfs_init(void)
 {
diff --git a/kernel/module/tracking.c b/kernel/module/tracking.c
index 16742d1c630c..c3610bd840d4 100644
--- a/kernel/module/tracking.c
+++ b/kernel/module/tracking.c
@@ -15,7 +15,7 @@
 #include "internal.h"
 
 static LIST_HEAD(unloaded_tainted_modules);
-extern struct dentry *mod_debugfs_root;
+extern struct debugfs_node *mod_debugfs_root;
 
 int try_add_tainted_module(struct module *mod)
 {
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 3874f0e97651..4052657cc6ba 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -35,7 +35,7 @@ static bool _is_cpu_device(struct device *dev)
 }
 
 #ifdef CONFIG_DEBUG_FS
-static struct dentry *rootdir;
+static struct debugfs_node *rootdir;
 
 struct em_dbg_info {
 	struct em_perf_domain *pd;
@@ -67,11 +67,11 @@ DEFINE_EM_DBG_SHOW(flags, inefficiency);
 
 static void em_debug_create_ps(struct em_perf_domain *em_pd,
 			       struct em_dbg_info *em_dbg, int i,
-			       struct dentry *pd)
+			       struct debugfs_node *pd)
 {
 	struct em_perf_state *table;
 	unsigned long freq;
-	struct dentry *d;
+	struct debugfs_node *d;
 	char name[24];
 
 	em_dbg[i].pd = em_pd;
@@ -119,7 +119,7 @@ DEFINE_SHOW_ATTRIBUTE(em_debug_flags);
 static void em_debug_create_pd(struct device *dev)
 {
 	struct em_dbg_info *em_dbg;
-	struct dentry *d;
+	struct debugfs_node *d;
 	int i;
 
 	/* Create the directory of the performance domain */
diff --git a/kernel/printk/index.c b/kernel/printk/index.c
index a6b27526baaf..04eee47ab9ff 100644
--- a/kernel/printk/index.c
+++ b/kernel/printk/index.c
@@ -15,7 +15,7 @@ extern struct pi_entry *__start_printk_index[];
 extern struct pi_entry *__stop_printk_index[];
 
 /* The base dir for module formats, typically debugfs/printk/index/ */
-static struct dentry *dfs_index;
+static struct debugfs_node *dfs_index;
 
 static struct pi_entry *pi_get_entry(const struct module *mod, loff_t pos)
 {
@@ -181,7 +181,7 @@ static inline void __init pi_setup_module_notifier(void) { }
 
 static int __init pi_init(void)
 {
-	struct dentry *dfs_root = debugfs_create_dir("printk", NULL);
+	struct debugfs_node *dfs_root = debugfs_create_dir("printk", NULL);
 
 	dfs_index = debugfs_create_dir("index", dfs_root);
 	pi_setup_module_notifier();
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index ef047add7f9e..2d759da7fbf8 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -282,7 +282,7 @@ static const struct file_operations sched_dynamic_fops = {
 __read_mostly bool sched_debug_verbose;
 
 #ifdef CONFIG_SMP
-static struct dentry           *sd_dentry;
+static struct debugfs_node           *sd_dentry;
 
 
 static ssize_t sched_verbose_write(struct file *filp, const char __user *ubuf,
@@ -470,11 +470,11 @@ static const struct file_operations fair_server_period_fops = {
 	.release	= single_release,
 };
 
-static struct dentry *debugfs_sched;
+static struct debugfs_node *debugfs_sched;
 
 static void debugfs_fair_server_init(void)
 {
-	struct dentry *d_fair;
+	struct debugfs_node *d_fair;
 	unsigned long cpu;
 
 	d_fair = debugfs_create_dir("fair_server", debugfs_sched);
@@ -482,7 +482,7 @@ static void debugfs_fair_server_init(void)
 		return;
 
 	for_each_possible_cpu(cpu) {
-		struct dentry *d_cpu;
+		struct debugfs_node *d_cpu;
 		char buf[32];
 
 		snprintf(buf, sizeof(buf), "cpu%lu", cpu);
@@ -495,7 +495,7 @@ static void debugfs_fair_server_init(void)
 
 static __init int sched_init_debug(void)
 {
-	struct dentry __maybe_unused *numa;
+	struct debugfs_node __maybe_unused *numa;
 
 	debugfs_sched = debugfs_create_dir("sched", NULL);
 
@@ -568,7 +568,7 @@ static const struct file_operations sd_flags_fops = {
 	.release	= single_release,
 };
 
-static void register_sd(struct sched_domain *sd, struct dentry *parent)
+static void register_sd(struct sched_domain *sd, struct debugfs_node *parent)
 {
 #define SDM(type, mode, member)	\
 	debugfs_create_##type(#member, mode, parent, &sd->member)
@@ -618,7 +618,7 @@ void update_sched_domain_debugfs(void)
 
 	for_each_cpu(cpu, sd_sysctl_cpus) {
 		struct sched_domain *sd;
-		struct dentry *d_cpu;
+		struct debugfs_node *d_cpu;
 		char buf[32];
 
 		snprintf(buf, sizeof(buf), "cpu%d", cpu);
@@ -627,7 +627,7 @@ void update_sched_domain_debugfs(void)
 
 		i = 0;
 		for_each_domain(cpu, sd) {
-			struct dentry *d_sd;
+			struct debugfs_node *d_sd;
 
 			snprintf(buf, sizeof(buf), "domain%d", i);
 			d_sd = debugfs_create_dir(buf, d_cpu);
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 3679a6d18934..ced765ad646d 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -473,15 +473,15 @@ static int blk_subbuf_start_callback(struct rchan_buf *buf, void *subbuf,
 	return 0;
 }
 
-static int blk_remove_buf_file_callback(struct dentry *dentry)
+static int blk_remove_buf_file_callback(struct debugfs_node *dentry)
 {
 	debugfs_remove(dentry);
 
 	return 0;
 }
 
-static struct dentry *blk_create_buf_file_callback(const char *filename,
-						   struct dentry *parent,
+static struct debugfs_node *blk_create_buf_file_callback(const char *filename,
+						   struct debugfs_node *parent,
 						   umode_t mode,
 						   struct rchan_buf *buf,
 						   int *is_global)
@@ -516,7 +516,7 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 			      struct blk_user_trace_setup *buts)
 {
 	struct blk_trace *bt = NULL;
-	struct dentry *dir = NULL;
+	struct debugfs_node *dir = NULL;
 	int ret;
 
 	lockdep_assert_held(&q->debugfs_mutex);
diff --git a/lib/842/842_debugfs.h b/lib/842/842_debugfs.h
index 4469407c3e0d..3e94d6474d12 100644
--- a/lib/842/842_debugfs.h
+++ b/lib/842/842_debugfs.h
@@ -11,7 +11,7 @@ module_param_named(template_counts, sw842_template_counts, bool, 0444);
 static atomic_t template_count[OPS_MAX], template_repeat_count,
 	template_zeros_count, template_short_data_count, template_end_count;
 
-static struct dentry *sw842_debugfs_root;
+static struct debugfs_node *sw842_debugfs_root;
 
 static int __init sw842_debugfs_create(void)
 {
diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 7f50c4480a4e..f7802d189fdc 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -1167,7 +1167,7 @@ DEFINE_SHOW_ATTRIBUTE(debug_stats);
 
 static int __init debug_objects_init_debugfs(void)
 {
-	struct dentry *dbgdir;
+	struct debugfs_node *dbgdir;
 
 	if (!debug_objects_enabled)
 		return 0;
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 5a007952f7f2..10835204142c 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1384,7 +1384,7 @@ static __initdata int ddebug_init_success;
 static int __init dynamic_debug_init_control(void)
 {
 	struct proc_dir_entry *procfs_dir;
-	struct dentry *debugfs_dir;
+	struct debugfs_node *debugfs_dir;
 
 	if (!ddebug_init_success)
 		return -ENODEV;
diff --git a/lib/error-inject.c b/lib/error-inject.c
index 887acd9a6ea6..e1aab683a12c 100644
--- a/lib/error-inject.c
+++ b/lib/error-inject.c
@@ -214,7 +214,7 @@ DEFINE_SEQ_ATTRIBUTE(ei);
 
 static int __init ei_debugfs_init(void)
 {
-	struct dentry *dir, *file;
+	struct debugfs_node *dir, *file;
 
 	dir = debugfs_create_dir("error_injection", NULL);
 
diff --git a/lib/fault-inject-usercopy.c b/lib/fault-inject-usercopy.c
index 77558b6c29ca..a08cbe70a238 100644
--- a/lib/fault-inject-usercopy.c
+++ b/lib/fault-inject-usercopy.c
@@ -18,7 +18,7 @@ __setup("fail_usercopy=", setup_fail_usercopy);
 
 static int __init fail_usercopy_debugfs(void)
 {
-	struct dentry *dir;
+	struct debugfs_node *dir;
 
 	dir = fault_create_debugfs_attr("fail_usercopy", NULL,
 					&fail_usercopy.attr);
diff --git a/lib/fault-inject.c b/lib/fault-inject.c
index 999053fa133e..5bf0f47725e8 100644
--- a/lib/fault-inject.c
+++ b/lib/fault-inject.c
@@ -202,7 +202,8 @@ static int debugfs_ul_get(void *data, u64 *val)
 DEFINE_SIMPLE_ATTRIBUTE(fops_ul, debugfs_ul_get, debugfs_ul_set, "%llu\n");
 
 static void debugfs_create_ul(const char *name, umode_t mode,
-			      struct dentry *parent, unsigned long *value)
+			      struct debugfs_node *parent,
+			      unsigned long *value)
 {
 	debugfs_create_file(name, mode, parent, value, &fops_ul);
 }
@@ -221,7 +222,7 @@ DEFINE_SIMPLE_ATTRIBUTE(fops_stacktrace_depth, debugfs_ul_get,
 			debugfs_stacktrace_depth_set, "%llu\n");
 
 static void debugfs_create_stacktrace_depth(const char *name, umode_t mode,
-					    struct dentry *parent,
+					    struct debugfs_node *parent,
 					    unsigned long *value)
 {
 	debugfs_create_file(name, mode, parent, value, &fops_stacktrace_depth);
@@ -229,11 +230,11 @@ static void debugfs_create_stacktrace_depth(const char *name, umode_t mode,
 
 #endif /* CONFIG_FAULT_INJECTION_STACKTRACE_FILTER */
 
-struct dentry *fault_create_debugfs_attr(const char *name,
-			struct dentry *parent, struct fault_attr *attr)
+struct debugfs_node *fault_create_debugfs_attr(const char *name,
+			struct debugfs_node *parent, struct fault_attr *attr)
 {
 	umode_t mode = S_IFREG | S_IRUSR | S_IWUSR;
-	struct dentry *dir;
+	struct debugfs_node *dir;
 
 	dir = debugfs_create_dir(name, parent);
 	if (IS_ERR(dir))
@@ -261,7 +262,7 @@ struct dentry *fault_create_debugfs_attr(const char *name,
 	debugfs_create_xul("reject-end", mode, dir, &attr->reject_end);
 #endif /* CONFIG_FAULT_INJECTION_STACKTRACE_FILTER */
 
-	attr->dname = dget(dir);
+	attr->dname = debugfs_node_get(dir);
 	return dir;
 }
 EXPORT_SYMBOL_GPL(fault_create_debugfs_attr);
diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
index 9c326f1837bd..f1b505cc7e25 100644
--- a/lib/kunit/debugfs.c
+++ b/lib/kunit/debugfs.c
@@ -28,7 +28,7 @@
  *
  */
 
-static struct dentry *debugfs_rootdir;
+static struct debugfs_node *debugfs_rootdir;
 
 void kunit_debugfs_cleanup(void)
 {
diff --git a/lib/memory-notifier-error-inject.c b/lib/memory-notifier-error-inject.c
index 2c46dde59644..2e79c84efbfc 100644
--- a/lib/memory-notifier-error-inject.c
+++ b/lib/memory-notifier-error-inject.c
@@ -17,7 +17,7 @@ static struct notifier_err_inject memory_notifier_err_inject = {
 	}
 };
 
-static struct dentry *dir;
+static struct debugfs_node *dir;
 
 static int err_inject_init(void)
 {
diff --git a/lib/netdev-notifier-error-inject.c b/lib/netdev-notifier-error-inject.c
index bb930f279e90..85c47f648701 100644
--- a/lib/netdev-notifier-error-inject.c
+++ b/lib/netdev-notifier-error-inject.c
@@ -24,7 +24,7 @@ static struct notifier_err_inject netdev_notifier_err_inject = {
 	}
 };
 
-static struct dentry *dir;
+static struct debugfs_node *dir;
 
 static int netdev_err_inject_init(void)
 {
diff --git a/lib/notifier-error-inject.c b/lib/notifier-error-inject.c
index 954c3412d22d..683d28c76e14 100644
--- a/lib/notifier-error-inject.c
+++ b/lib/notifier-error-inject.c
@@ -18,8 +18,8 @@ static int debugfs_errno_get(void *data, u64 *val)
 DEFINE_SIMPLE_ATTRIBUTE_SIGNED(fops_errno, debugfs_errno_get, debugfs_errno_set,
 			"%lld\n");
 
-static struct dentry *debugfs_create_errno(const char *name, umode_t mode,
-				struct dentry *parent, int *value)
+static struct debugfs_node *debugfs_create_errno(const char *name, umode_t mode,
+				struct debugfs_node *parent, int *value)
 {
 	return debugfs_create_file(name, mode, parent, value, &fops_errno);
 }
@@ -44,16 +44,18 @@ static int notifier_err_inject_callback(struct notifier_block *nb,
 	return notifier_from_errno(err);
 }
 
-struct dentry *notifier_err_inject_dir;
+struct debugfs_node *notifier_err_inject_dir;
 EXPORT_SYMBOL_GPL(notifier_err_inject_dir);
 
-struct dentry *notifier_err_inject_init(const char *name, struct dentry *parent,
-			struct notifier_err_inject *err_inject, int priority)
+struct debugfs_node *notifier_err_inject_init(const char *name,
+					struct debugfs_node *parent,
+					struct notifier_err_inject *err_inject,
+					int priority)
 {
 	struct notifier_err_inject_action *action;
 	umode_t mode = S_IFREG | S_IRUSR | S_IWUSR;
-	struct dentry *dir;
-	struct dentry *actions_dir;
+	struct debugfs_node *dir;
+	struct debugfs_node *actions_dir;
 
 	err_inject->nb.notifier_call = notifier_err_inject_callback;
 	err_inject->nb.priority = priority;
@@ -63,7 +65,7 @@ struct dentry *notifier_err_inject_init(const char *name, struct dentry *parent,
 	actions_dir = debugfs_create_dir("actions", dir);
 
 	for (action = err_inject->actions; action->name; action++) {
-		struct dentry *action_dir;
+		struct debugfs_node *action_dir;
 
 		action_dir = debugfs_create_dir(action->name, actions_dir);
 
diff --git a/lib/notifier-error-inject.h b/lib/notifier-error-inject.h
index fafff5f2ac45..a08c4d14a26f 100644
--- a/lib/notifier-error-inject.h
+++ b/lib/notifier-error-inject.h
@@ -18,8 +18,8 @@ struct notifier_err_inject {
 	/* The last slot must be terminated with zero sentinel */
 };
 
-extern struct dentry *notifier_err_inject_dir;
+extern struct debugfs_node *notifier_err_inject_dir;
 
-extern struct dentry *notifier_err_inject_init(const char *name,
+extern struct debugfs_node *notifier_err_inject_init(const char *name,
 		struct dentry *parent, struct notifier_err_inject *err_inject,
 		int priority);
diff --git a/lib/of-reconfig-notifier-error-inject.c b/lib/of-reconfig-notifier-error-inject.c
index b26f16402a19..268ed0eba600 100644
--- a/lib/of-reconfig-notifier-error-inject.c
+++ b/lib/of-reconfig-notifier-error-inject.c
@@ -20,7 +20,7 @@ static struct notifier_err_inject reconfig_err_inject = {
 	}
 };
 
-static struct dentry *dir;
+static struct debugfs_node *dir;
 
 static int err_inject_init(void)
 {
diff --git a/lib/pm-notifier-error-inject.c b/lib/pm-notifier-error-inject.c
index 5d89f0d9099a..b18784d7986a 100644
--- a/lib/pm-notifier-error-inject.c
+++ b/lib/pm-notifier-error-inject.c
@@ -18,7 +18,7 @@ static struct notifier_err_inject pm_notifier_err_inject = {
 	}
 };
 
-static struct dentry *dir;
+static struct debugfs_node *dir;
 
 static int err_inject_init(void)
 {
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 245d5b416699..52d8fcdcf5e9 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -805,7 +805,7 @@ DEFINE_SHOW_ATTRIBUTE(stats);
 
 static int depot_debugfs_init(void)
 {
-	struct dentry *dir;
+	struct debugfs_node *dir;
 
 	if (stack_depot_disabled)
 		return 0;
diff --git a/lib/test_fpu_glue.c b/lib/test_fpu_glue.c
index c0596426370a..2325ca0f9965 100644
--- a/lib/test_fpu_glue.c
+++ b/lib/test_fpu_glue.c
@@ -34,7 +34,7 @@ static int test_fpu_get(void *data, u64 *val)
 }
 
 DEFINE_DEBUGFS_ATTRIBUTE(test_fpu_fops, test_fpu_get, NULL, "%lld\n");
-static struct dentry *selftest_dir;
+static struct debugfs_node *selftest_dir;
 
 static int __init test_fpu_init(void)
 {
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index e61bbb1bd622..b1c6b34c5842 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -52,7 +52,7 @@ struct wb_stats {
 	unsigned long wb_thresh;
 };
 
-static struct dentry *bdi_debug_root;
+static struct debugfs_node *bdi_debug_root;
 
 static void bdi_debug_init(void)
 {
diff --git a/mm/cma_debug.c b/mm/cma_debug.c
index 602fff89b15f..fc5b3d3ca921 100644
--- a/mm/cma_debug.c
+++ b/mm/cma_debug.c
@@ -160,9 +160,10 @@ static int cma_alloc_write(void *data, u64 val)
 }
 DEFINE_DEBUGFS_ATTRIBUTE(cma_alloc_fops, NULL, cma_alloc_write, "%llu\n");
 
-static void cma_debugfs_add_one(struct cma *cma, struct dentry *root_dentry)
+static void cma_debugfs_add_one(struct cma *cma,
+				struct debugfs_node *root_dentry)
 {
-	struct dentry *tmp;
+	struct debugfs_node *tmp;
 
 	tmp = debugfs_create_dir(cma->name, root_dentry);
 
@@ -184,7 +185,7 @@ static void cma_debugfs_add_one(struct cma *cma, struct dentry *root_dentry)
 
 static int __init cma_debugfs_init(void)
 {
-	struct dentry *cma_debugfs_root;
+	struct debugfs_node *cma_debugfs_root;
 	int i;
 
 	cma_debugfs_root = debugfs_create_dir("cma", NULL);
diff --git a/mm/fail_page_alloc.c b/mm/fail_page_alloc.c
index 7647096170e9..d504e94c2571 100644
--- a/mm/fail_page_alloc.c
+++ b/mm/fail_page_alloc.c
@@ -50,7 +50,7 @@ ALLOW_ERROR_INJECTION(should_fail_alloc_page, TRUE);
 static int __init fail_page_alloc_debugfs(void)
 {
 	umode_t mode = S_IFREG | 0600;
-	struct dentry *dir;
+	struct debugfs_node *dir;
 
 	dir = fault_create_debugfs_attr("fail_page_alloc", NULL,
 					&fail_page_alloc.attr);
diff --git a/mm/failslab.c b/mm/failslab.c
index c3901b136498..8cf63051fa46 100644
--- a/mm/failslab.c
+++ b/mm/failslab.c
@@ -56,7 +56,7 @@ __setup("failslab=", setup_failslab);
 #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
 static int __init failslab_debugfs_init(void)
 {
-	struct dentry *dir;
+	struct debugfs_node *dir;
 	umode_t mode = S_IFREG | 0600;
 
 	dir = fault_create_debugfs_attr("failslab", NULL, &failslab.attr);
diff --git a/mm/hwpoison-inject.c b/mm/hwpoison-inject.c
index 7ecaa1900137..c65a27e1a875 100644
--- a/mm/hwpoison-inject.c
+++ b/mm/hwpoison-inject.c
@@ -9,7 +9,7 @@
 #include <linux/hugetlb.h>
 #include "internal.h"
 
-static struct dentry *hwpoison_dir;
+static struct debugfs_node *hwpoison_dir;
 
 static int hwpoison_inject(void *data, u64 val)
 {
diff --git a/mm/internal.h b/mm/internal.h
index 109ef30fee11..59e6d8f11db3 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1469,9 +1469,9 @@ static inline void shrinker_debugfs_name_free(struct shrinker *shrinker)
 }
 
 extern int shrinker_debugfs_add(struct shrinker *shrinker);
-extern struct dentry *shrinker_debugfs_detach(struct shrinker *shrinker,
+extern struct debugfs_node *shrinker_debugfs_detach(struct shrinker *shrinker,
 					      int *debugfs_id);
-extern void shrinker_debugfs_remove(struct dentry *debugfs_entry,
+extern void shrinker_debugfs_remove(struct debugfs_node *debugfs_entry,
 				    int debugfs_id);
 #else /* CONFIG_SHRINKER_DEBUG */
 static inline int shrinker_debugfs_add(struct shrinker *shrinker)
@@ -1486,13 +1486,13 @@ static inline int shrinker_debugfs_name_alloc(struct shrinker *shrinker,
 static inline void shrinker_debugfs_name_free(struct shrinker *shrinker)
 {
 }
-static inline struct dentry *shrinker_debugfs_detach(struct shrinker *shrinker,
+static inline struct debugfs_node *shrinker_debugfs_detach(struct shrinker *shrinker,
 						     int *debugfs_id)
 {
 	*debugfs_id = -1;
 	return NULL;
 }
-static inline void shrinker_debugfs_remove(struct dentry *debugfs_entry,
+static inline void shrinker_debugfs_remove(struct debugfs_node *debugfs_entry,
 					   int debugfs_id)
 {
 }
diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 102048821c22..8f0256e84f80 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -775,7 +775,7 @@ DEFINE_SEQ_ATTRIBUTE(objects);
 
 static int kfence_debugfs_init(void)
 {
-	struct dentry *kfence_dir;
+	struct debugfs_node *kfence_dir;
 
 	if (!READ_ONCE(kfence_enabled))
 		return 0;
diff --git a/mm/memblock.c b/mm/memblock.c
index 95af35fd1389..4d1867e052ad 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2437,7 +2437,7 @@ DEFINE_SHOW_ATTRIBUTE(memblock_debug);
 
 static int __init memblock_init_debugfs(void)
 {
-	struct dentry *root = debugfs_create_dir("memblock", NULL);
+	struct debugfs_node *root = debugfs_create_dir("memblock", NULL);
 
 	debugfs_create_file("memory", 0444, root,
 			    &memblock.memory, &memblock_debug_fops);
diff --git a/mm/page_owner.c b/mm/page_owner.c
index 2d6360eaccbb..e5f80bd54354 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -954,7 +954,7 @@ DEFINE_SIMPLE_ATTRIBUTE(proc_page_owner_threshold, &page_owner_threshold_get,
 
 static int __init pageowner_init(void)
 {
-	struct dentry *dir;
+	struct debugfs_node *dir;
 
 	if (!static_branch_unlikely(&page_owner_inited)) {
 		pr_info("page_owner is disabled\n");
diff --git a/mm/shrinker.c b/mm/shrinker.c
index 4a93fd433689..35989087d387 100644
--- a/mm/shrinker.c
+++ b/mm/shrinker.c
@@ -768,7 +768,7 @@ static void shrinker_free_rcu_cb(struct rcu_head *head)
 
 void shrinker_free(struct shrinker *shrinker)
 {
-	struct dentry *debugfs_entry = NULL;
+	struct debugfs_node *debugfs_entry = NULL;
 	int debugfs_id;
 
 	if (!shrinker)
diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
index 794bd433cce0..ade7284e0506 100644
--- a/mm/shrinker_debug.c
+++ b/mm/shrinker_debug.c
@@ -13,7 +13,7 @@ extern struct mutex shrinker_mutex;
 extern struct list_head shrinker_list;
 
 static DEFINE_IDA(shrinker_debugfs_ida);
-static struct dentry *shrinker_debugfs_root;
+static struct debugfs_node *shrinker_debugfs_root;
 
 static unsigned long shrinker_count_objects(struct shrinker *shrinker,
 					    struct mem_cgroup *memcg,
@@ -161,7 +161,7 @@ static const struct file_operations shrinker_debugfs_scan_fops = {
 
 int shrinker_debugfs_add(struct shrinker *shrinker)
 {
-	struct dentry *entry;
+	struct debugfs_node *entry;
 	char buf[128];
 	int id;
 
@@ -222,10 +222,10 @@ int shrinker_debugfs_rename(struct shrinker *shrinker, const char *fmt, ...)
 }
 EXPORT_SYMBOL(shrinker_debugfs_rename);
 
-struct dentry *shrinker_debugfs_detach(struct shrinker *shrinker,
+struct debugfs_node *shrinker_debugfs_detach(struct shrinker *shrinker,
 				       int *debugfs_id)
 {
-	struct dentry *entry = shrinker->debugfs_entry;
+	struct debugfs_node *entry = shrinker->debugfs_entry;
 
 	lockdep_assert_held(&shrinker_mutex);
 
@@ -235,7 +235,8 @@ struct dentry *shrinker_debugfs_detach(struct shrinker *shrinker,
 	return entry;
 }
 
-void shrinker_debugfs_remove(struct dentry *debugfs_entry, int debugfs_id)
+void shrinker_debugfs_remove(struct debugfs_node *debugfs_entry,
+			     int debugfs_id)
 {
 	debugfs_remove_recursive(debugfs_entry);
 	ida_free(&shrinker_debugfs_ida, debugfs_id);
@@ -244,7 +245,7 @@ void shrinker_debugfs_remove(struct dentry *debugfs_entry, int debugfs_id)
 static int __init shrinker_debugfs_init(void)
 {
 	struct shrinker *shrinker;
-	struct dentry *dentry;
+	struct debugfs_node *dentry;
 	int ret = 0;
 
 	dentry = debugfs_create_dir("shrinker", NULL);
diff --git a/mm/slub.c b/mm/slub.c
index 1f50129dcfb3..6148fc434df0 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -6350,7 +6350,7 @@ struct loc_track {
 	loff_t idx;
 };
 
-static struct dentry *slab_debugfs_root;
+static struct debugfs_node *slab_debugfs_root;
 
 static void free_loc_track(struct loc_track *t)
 {
@@ -7558,7 +7558,7 @@ static const struct file_operations slab_debugfs_fops = {
 
 static void debugfs_slab_add(struct kmem_cache *s)
 {
-	struct dentry *slab_cache_dir;
+	struct debugfs_node *slab_cache_dir;
 
 	if (unlikely(!slab_debugfs_root))
 		return;
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 16bfe1c694dd..92f595421fbf 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -2348,7 +2348,7 @@ DEFINE_SEQ_ATTRIBUTE(extfrag);
 
 static int __init extfrag_debug_init(void)
 {
-	struct dentry *extfrag_debug_root;
+	struct debugfs_node *extfrag_debug_root;
 
 	extfrag_debug_root = debugfs_create_dir("extfrag", NULL);
 
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 6d0e47f7ae33..c70978bb6951 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -162,7 +162,7 @@ struct zs_size_stat {
 };
 
 #ifdef CONFIG_ZSMALLOC_STAT
-static struct dentry *zs_stat_root;
+static struct debugfs_node *zs_stat_root;
 #endif
 
 static size_t huge_class_size;
@@ -218,7 +218,7 @@ struct zs_pool {
 	struct shrinker *shrinker;
 
 #ifdef CONFIG_ZSMALLOC_STAT
-	struct dentry *stat_dentry;
+	struct debugfs_node *stat_dentry;
 #endif
 #ifdef CONFIG_COMPACTION
 	struct work_struct free_work;
diff --git a/mm/zswap.c b/mm/zswap.c
index 6504174fbc6a..3e58487c4a4f 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1728,7 +1728,7 @@ void zswap_swapoff(int type)
 #ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
 
-static struct dentry *zswap_debugfs_root;
+static struct debugfs_node *zswap_debugfs_root;
 
 static int debugfs_get_total_size(void *data, u64 *val)
 {
diff --git a/net/6lowpan/debugfs.c b/net/6lowpan/debugfs.c
index 600b9563bfc5..37930d9c58ca 100644
--- a/net/6lowpan/debugfs.c
+++ b/net/6lowpan/debugfs.c
@@ -12,7 +12,7 @@
 
 #define LOWPAN_DEBUGFS_CTX_PFX_NUM_ARGS	8
 
-static struct dentry *lowpan_debugfs;
+static struct debugfs_node *lowpan_debugfs;
 
 static int lowpan_ctx_flag_active_set(void *data, u64 val)
 {
@@ -164,10 +164,10 @@ static const struct file_operations lowpan_ctx_pfx_fops = {
 };
 
 static void lowpan_dev_debugfs_ctx_init(struct net_device *dev,
-					struct dentry *ctx, u8 id)
+					struct debugfs_node *ctx, u8 id)
 {
 	struct lowpan_dev *ldev = lowpan_dev(dev);
-	struct dentry *root;
+	struct debugfs_node *root;
 	char buf[32];
 
 	if (WARN_ON_ONCE(id >= LOWPAN_IPHC_CTX_TABLE_SIZE))
@@ -230,7 +230,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(lowpan_short_addr_fops, lowpan_short_addr_get, NULL,
 static void lowpan_dev_debugfs_802154_init(const struct net_device *dev,
 					  struct lowpan_dev *ldev)
 {
-	struct dentry *root;
+	struct debugfs_node *root;
 
 	if (!lowpan_is_ll(dev, LOWPAN_LLTYPE_IEEE802154))
 		return;
@@ -245,7 +245,7 @@ static void lowpan_dev_debugfs_802154_init(const struct net_device *dev,
 void lowpan_dev_debugfs_init(struct net_device *dev)
 {
 	struct lowpan_dev *ldev = lowpan_dev(dev);
-	struct dentry *contexts;
+	struct debugfs_node *contexts;
 	int i;
 
 	/* creating the root */
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 50cfec8ccac4..eeda094b51e4 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -23,8 +23,8 @@
 
 #define VERSION "0.1"
 
-static struct dentry *lowpan_enable_debugfs;
-static struct dentry *lowpan_control_debugfs;
+static struct debugfs_node *lowpan_enable_debugfs;
+static struct debugfs_node *lowpan_control_debugfs;
 
 #define IFACE_NAME_TEMPLATE "bt%d"
 
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 0b4d0a8bd361..6be7cf64a3bc 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -785,7 +785,7 @@ static const struct net_proto_family bt_sock_family_ops = {
 	.create	= bt_sock_create,
 };
 
-struct dentry *bt_debugfs;
+struct debugfs_node *bt_debugfs;
 EXPORT_SYMBOL_GPL(bt_debugfs);
 
 #define VERSION __stringify(BT_SUBSYS_VERSION) "." \
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 44acddf58a0c..09287322f0f9 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -2396,7 +2396,7 @@ static int iso_debugfs_show(struct seq_file *f, void *p)
 
 DEFINE_SHOW_ATTRIBUTE(iso_debugfs);
 
-static struct dentry *iso_debugfs;
+static struct debugfs_node *iso_debugfs;
 
 static const struct proto_ops iso_sock_ops = {
 	.family		= PF_BLUETOOTH,
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 27b4c4a2ba1f..2c74a2702327 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7598,7 +7598,7 @@ static int l2cap_debugfs_show(struct seq_file *f, void *p)
 
 DEFINE_SHOW_ATTRIBUTE(l2cap_debugfs);
 
-static struct dentry *l2cap_debugfs;
+static struct debugfs_node *l2cap_debugfs;
 
 int __init l2cap_init(void)
 {
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 4c56ca5a216c..18996f369492 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -2213,7 +2213,7 @@ static int rfcomm_dlc_debugfs_show(struct seq_file *f, void *x)
 
 DEFINE_SHOW_ATTRIBUTE(rfcomm_dlc_debugfs);
 
-static struct dentry *rfcomm_dlc_debugfs;
+static struct debugfs_node *rfcomm_dlc_debugfs;
 
 /* ---- Initialization ---- */
 static int __init rfcomm_init(void)
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 913402806fa0..b58694163a78 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -998,7 +998,7 @@ static int rfcomm_sock_debugfs_show(struct seq_file *f, void *p)
 
 DEFINE_SHOW_ATTRIBUTE(rfcomm_sock_debugfs);
 
-static struct dentry *rfcomm_sock_debugfs;
+static struct debugfs_node *rfcomm_sock_debugfs;
 
 static const struct proto_ops rfcomm_sock_ops = {
 	.family		= PF_BLUETOOTH,
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index aa7bfe26cb40..74f280647fed 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -1467,7 +1467,7 @@ static int sco_debugfs_show(struct seq_file *f, void *p)
 
 DEFINE_SHOW_ATTRIBUTE(sco_debugfs);
 
-static struct dentry *sco_debugfs;
+static struct debugfs_node *sco_debugfs;
 
 static const struct proto_ops sco_sock_ops = {
 	.family		= PF_BLUETOOTH,
diff --git a/net/caif/caif_socket.c b/net/caif/caif_socket.c
index 039dfbd367c9..007531c2097a 100644
--- a/net/caif/caif_socket.c
+++ b/net/caif/caif_socket.c
@@ -51,7 +51,7 @@ struct caifsock {
 	unsigned long flow_state;
 	struct caif_connect_request conn_req;
 	struct mutex readlock;
-	struct dentry *debugfs_socket_dir;
+	struct debugfs_node *debugfs_socket_dir;
 	int headroom, tailroom, maxframe;
 };
 
diff --git a/net/ceph/debugfs.c b/net/ceph/debugfs.c
index 2110439f8a24..0bcc5f000c76 100644
--- a/net/ceph/debugfs.c
+++ b/net/ceph/debugfs.c
@@ -29,7 +29,7 @@
  *      .../bdi         - symlink to ../../bdi/something
  */
 
-static struct dentry *ceph_debugfs_dir;
+static struct debugfs_node *ceph_debugfs_dir;
 
 static int monmap_show(struct seq_file *s, void *p)
 {
diff --git a/net/core/skb_fault_injection.c b/net/core/skb_fault_injection.c
index 4235db6bdfad..80a485f27ce8 100644
--- a/net/core/skb_fault_injection.c
+++ b/net/core/skb_fault_injection.c
@@ -91,7 +91,7 @@ static const struct file_operations devname_ops = {
 static int __init fail_skb_realloc_debugfs(void)
 {
 	umode_t mode = S_IFREG | 0600;
-	struct dentry *dir;
+	struct debugfs_node *dir;
 
 	dir = fault_create_debugfs_attr("fail_skb_realloc", NULL,
 					&skb_realloc.attr);
diff --git a/net/hsr/hsr_debugfs.c b/net/hsr/hsr_debugfs.c
index 5b2cfac3b2ba..53da7cd88db5 100644
--- a/net/hsr/hsr_debugfs.c
+++ b/net/hsr/hsr_debugfs.c
@@ -12,7 +12,7 @@
 #include "hsr_main.h"
 #include "hsr_framereg.h"
 
-static struct dentry *hsr_debugfs_root_dir;
+static struct debugfs_node *hsr_debugfs_root_dir;
 
 /* hsr_node_table_show - Formats and prints node_table entries */
 static int
@@ -73,7 +73,7 @@ void hsr_debugfs_rename(struct net_device *dev)
  */
 void hsr_debugfs_init(struct hsr_priv *priv, struct net_device *hsr_dev)
 {
-	struct dentry *de = NULL;
+	struct debugfs_node *de = NULL;
 
 	de = debugfs_create_dir(hsr_dev->name, hsr_debugfs_root_dir);
 	if (IS_ERR(de)) {
diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
index 7561845b8bf6..7225b6864cc5 100644
--- a/net/hsr/hsr_main.h
+++ b/net/hsr/hsr_main.h
@@ -214,7 +214,7 @@ struct hsr_priv {
 				 * in ether_addr_equal
 				 */
 #ifdef	CONFIG_DEBUG_FS
-	struct dentry *node_tbl_root;
+	struct debugfs_node *node_tbl_root;
 #endif
 };
 
diff --git a/net/l2tp/l2tp_debugfs.c b/net/l2tp/l2tp_debugfs.c
index 2d0c8275a3a8..323ffd3a1b67 100644
--- a/net/l2tp/l2tp_debugfs.c
+++ b/net/l2tp/l2tp_debugfs.c
@@ -29,7 +29,7 @@
 
 #include "l2tp_core.h"
 
-static struct dentry *rootdir;
+static struct debugfs_node *rootdir;
 
 struct l2tp_dfs_seq_data {
 	struct net	*net;
diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index bf0a2902d93c..42f2ee9045e7 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -635,8 +635,8 @@ DEBUGFS_DEVSTATS_FILE(dot11RTSSuccessCount);
 
 void debugfs_hw_add(struct ieee80211_local *local)
 {
-	struct dentry *phyd = local->hw.wiphy->debugfsdir;
-	struct dentry *statsd;
+	struct debugfs_node *phyd = local->hw.wiphy->debugfsdir;
+	struct debugfs_node *statsd;
 
 	if (!phyd)
 		return;
diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index 54c479910d05..5bb5792982e3 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -881,7 +881,7 @@ static void add_mesh_files(struct ieee80211_sub_if_data *sdata)
 
 static void add_mesh_stats(struct ieee80211_sub_if_data *sdata)
 {
-	struct dentry *dir = debugfs_create_dir("mesh_stats",
+	struct debugfs_node *dir = debugfs_create_dir("mesh_stats",
 						sdata->vif.debugfs_dir);
 #define MESHSTATS_ADD(name)\
 	debugfs_create_file(#name, 0400, dir, sdata, &name##_ops)
@@ -896,7 +896,7 @@ static void add_mesh_stats(struct ieee80211_sub_if_data *sdata)
 
 static void add_mesh_config(struct ieee80211_sub_if_data *sdata)
 {
-	struct dentry *dir = debugfs_create_dir("mesh_config",
+	struct debugfs_node *dir = debugfs_create_dir("mesh_config",
 						sdata->vif.debugfs_dir);
 
 #define MESHPARAMS_ADD(name) \
diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index a67a9d316008..5e8d90dcd4fc 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -1239,7 +1239,7 @@ void ieee80211_sta_debugfs_add(struct sta_info *sta)
 {
 	struct ieee80211_local *local = sta->local;
 	struct ieee80211_sub_if_data *sdata = sta->sdata;
-	struct dentry *stations_dir = sta->sdata->debugfs.subdir_stations;
+	struct debugfs_node *stations_dir = sta->sdata->debugfs.subdir_stations;
 	u8 mac[3*ETH_ALEN];
 
 	if (!stations_dir)
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index 5acecc7bd4a9..51db4c13c475 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -509,7 +509,7 @@ static inline void drv_vif_add_debugfs(struct ieee80211_local *local,
 static inline void drv_link_add_debugfs(struct ieee80211_local *local,
 					struct ieee80211_sub_if_data *sdata,
 					struct ieee80211_bss_conf *link_conf,
-					struct dentry *dir)
+					struct debugfs_node *dir)
 {
 	might_sleep();
 	lockdep_assert_wiphy(local->hw.wiphy);
@@ -526,7 +526,7 @@ static inline void drv_link_add_debugfs(struct ieee80211_local *local,
 static inline void drv_sta_add_debugfs(struct ieee80211_local *local,
 				       struct ieee80211_sub_if_data *sdata,
 				       struct ieee80211_sta *sta,
-				       struct dentry *dir)
+				       struct debugfs_node *dir)
 {
 	might_sleep();
 	lockdep_assert_wiphy(local->hw.wiphy);
@@ -543,7 +543,7 @@ static inline void drv_sta_add_debugfs(struct ieee80211_local *local,
 static inline void drv_link_sta_add_debugfs(struct ieee80211_local *local,
 					    struct ieee80211_sub_if_data *sdata,
 					    struct ieee80211_link_sta *link_sta,
-					    struct dentry *dir)
+					    struct debugfs_node *dir)
 {
 	might_sleep();
 	lockdep_assert_wiphy(local->hw.wiphy);
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index e7dc3f0cfc9a..25d02130f443 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1093,7 +1093,7 @@ struct ieee80211_link_data {
 	struct ieee80211_bss_conf *conf;
 
 #ifdef CONFIG_MAC80211_DEBUGFS
-	struct dentry *debugfs_dir;
+	struct debugfs_node *debugfs_dir;
 #endif
 };
 
diff --git a/net/mac80211/rate.h b/net/mac80211/rate.h
index 5e4bde598212..f50e1bd74a8f 100644
--- a/net/mac80211/rate.h
+++ b/net/mac80211/rate.h
@@ -67,7 +67,7 @@ extern const struct debugfs_short_fops rcname_ops;
 static inline void rate_control_add_debugfs(struct ieee80211_local *local)
 {
 #ifdef CONFIG_MAC80211_DEBUGFS
-	struct dentry *debugfsdir;
+	struct debugfs_node *debugfsdir;
 
 	if (!local->rate_ctrl)
 		return;
diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_minstrel_ht.c
index 706cbc99f718..687dce795d6a 100644
--- a/net/mac80211/rc80211_minstrel_ht.c
+++ b/net/mac80211/rc80211_minstrel_ht.c
@@ -1968,7 +1968,7 @@ minstrel_ht_alloc(struct ieee80211_hw *hw)
 
 #ifdef CONFIG_MAC80211_DEBUGFS
 static void minstrel_ht_add_debugfs(struct ieee80211_hw *hw, void *priv,
-				    struct dentry *debugfsdir)
+				    struct debugfs_node *debugfsdir)
 {
 	struct minstrel_priv *mp = priv;
 
diff --git a/net/mac80211/rc80211_minstrel_ht.h b/net/mac80211/rc80211_minstrel_ht.h
index 4be0401f7721..aa0f7712055e 100644
--- a/net/mac80211/rc80211_minstrel_ht.h
+++ b/net/mac80211/rc80211_minstrel_ht.h
@@ -195,7 +195,8 @@ struct minstrel_ht_sta {
 	struct minstrel_mcs_group_data groups[MINSTREL_GROUPS_NB];
 };
 
-void minstrel_ht_add_sta_debugfs(void *priv, void *priv_sta, struct dentry *dir);
+void minstrel_ht_add_sta_debugfs(void *priv, void *priv_sta,
+				 struct debugfs_node *dir);
 int minstrel_ht_get_tp_avg(struct minstrel_ht_sta *mi, int group, int rate,
 			   int prob_avg);
 
diff --git a/net/mac80211/rc80211_minstrel_ht_debugfs.c b/net/mac80211/rc80211_minstrel_ht_debugfs.c
index 85149c774505..db7fa225299f 100644
--- a/net/mac80211/rc80211_minstrel_ht_debugfs.c
+++ b/net/mac80211/rc80211_minstrel_ht_debugfs.c
@@ -325,7 +325,8 @@ static const struct file_operations minstrel_ht_stat_csv_fops = {
 };
 
 void
-minstrel_ht_add_sta_debugfs(void *priv, void *priv_sta, struct dentry *dir)
+minstrel_ht_add_sta_debugfs(void *priv, void *priv_sta,
+			    struct debugfs_node *dir)
 {
 	debugfs_create_file("rc_stats", 0444, dir, priv_sta,
 			    &minstrel_ht_stat_fops);
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 07b7ec39a52f..5f07a4cadad8 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -570,7 +570,7 @@ struct link_sta_info {
 					rx_omi_bw_staging;
 
 #ifdef CONFIG_MAC80211_DEBUGFS
-	struct dentry *debugfs_dir;
+	struct debugfs_node *debugfs_dir;
 #endif
 
 	struct ieee80211_link_sta *pub;
@@ -714,7 +714,7 @@ struct sta_info {
 	struct sta_ampdu_mlme ampdu_mlme;
 
 #ifdef CONFIG_MAC80211_DEBUGFS
-	struct dentry *debugfs_dir;
+	struct debugfs_node *debugfs_dir;
 #endif
 
 	struct codel_params cparams;
diff --git a/net/sunrpc/debugfs.c b/net/sunrpc/debugfs.c
index 32417db340de..aa82b2ca499d 100644
--- a/net/sunrpc/debugfs.c
+++ b/net/sunrpc/debugfs.c
@@ -12,9 +12,9 @@
 #include "netns.h"
 #include "fail.h"
 
-static struct dentry *topdir;
-static struct dentry *rpc_clnt_dir;
-static struct dentry *rpc_xprt_dir;
+static struct debugfs_node *topdir;
+static struct debugfs_node *rpc_clnt_dir;
+static struct debugfs_node *rpc_xprt_dir;
 
 static int
 tasks_show(struct seq_file *f, void *v)
@@ -267,7 +267,7 @@ EXPORT_SYMBOL_GPL(fail_sunrpc);
 
 static void fail_sunrpc_init(void)
 {
-	struct dentry *dir;
+	struct debugfs_node *dir;
 
 	dir = fault_create_debugfs_attr("fail_sunrpc", NULL,
 					&fail_sunrpc.attr);
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 12b780de8779..fd8b1b2f575f 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -44,7 +44,7 @@ LIST_HEAD(cfg80211_rdev_list);
 int cfg80211_rdev_list_generation;
 
 /* for debugfs */
-static struct dentry *ieee80211_debugfs_dir;
+static struct debugfs_node *ieee80211_debugfs_dir;
 
 /* for the cleanup, scan and event works */
 struct workqueue_struct *cfg80211_wq;
diff --git a/net/wireless/debugfs.c b/net/wireless/debugfs.c
index 40e49074e2ee..b9822e13a414 100644
--- a/net/wireless/debugfs.c
+++ b/net/wireless/debugfs.c
@@ -136,7 +136,7 @@ static void wiphy_locked_debugfs_read_work(struct wiphy *wiphy,
 	complete(&w->completion);
 }
 
-static void wiphy_locked_debugfs_read_cancel(struct dentry *dentry,
+static void wiphy_locked_debugfs_read_cancel(struct debugfs_node *dentry,
 					     void *data)
 {
 	struct debugfs_read_work *w = data;
@@ -216,7 +216,7 @@ static void wiphy_locked_debugfs_write_work(struct wiphy *wiphy,
 	complete(&w->completion);
 }
 
-static void wiphy_locked_debugfs_write_cancel(struct dentry *dentry,
+static void wiphy_locked_debugfs_write_cancel(struct debugfs_node *dentry,
 					      void *data)
 {
 	struct debugfs_write_work *w = data;
diff --git a/samples/qmi/qmi_sample_client.c b/samples/qmi/qmi_sample_client.c
index b27d861f354f..28942134c09f 100644
--- a/samples/qmi/qmi_sample_client.c
+++ b/samples/qmi/qmi_sample_client.c
@@ -443,12 +443,12 @@ static const struct qmi_msg_handler qmi_sample_handlers[] = {
 struct qmi_sample {
 	struct qmi_handle qmi;
 
-	struct dentry *de_dir;
-	struct dentry *de_data;
-	struct dentry *de_ping;
+	struct debugfs_node *de_dir;
+	struct debugfs_node *de_data;
+	struct debugfs_node *de_ping;
 };
 
-static struct dentry *qmi_debug_dir;
+static struct debugfs_node *qmi_debug_dir;
 
 static int qmi_sample_probe(struct platform_device *pdev)
 {
diff --git a/sound/core/jack.c b/sound/core/jack.c
index e4bcecdf89b7..330898d855b5 100644
--- a/sound/core/jack.c
+++ b/sound/core/jack.c
@@ -22,7 +22,7 @@ struct snd_jack_kctl {
 	struct snd_jack *jack;  /* pointer to struct snd_jack */
 	bool sw_inject_enable;  /* allow to inject plug event via debugfs */
 #ifdef CONFIG_SND_JACK_INJECTION_DEBUG
-	struct dentry *jack_debugfs_root; /* jack_kctl debugfs root */
+	struct debugfs_node *jack_debugfs_root; /* jack_kctl debugfs root */
 #endif
 };
 
diff --git a/sound/core/sound.c b/sound/core/sound.c
index 6531a67f13b3..53f51f90c56e 100644
--- a/sound/core/sound.c
+++ b/sound/core/sound.c
@@ -41,7 +41,7 @@ int snd_ecards_limit;
 EXPORT_SYMBOL(snd_ecards_limit);
 
 #ifdef CONFIG_SND_DEBUG
-struct dentry *sound_debugfs_root;
+struct debugfs_node *sound_debugfs_root;
 EXPORT_SYMBOL_GPL(sound_debugfs_root);
 #endif
 
diff --git a/sound/drivers/pcmtest.c b/sound/drivers/pcmtest.c
index 72378f354fd0..804bba1007b5 100644
--- a/sound/drivers/pcmtest.c
+++ b/sound/drivers/pcmtest.c
@@ -69,7 +69,7 @@ static short fill_mode = FILL_MODE_PAT;
 
 static u8 playback_capture_test;
 static u8 ioctl_reset_test;
-static struct dentry *driver_debug_dir;
+static struct debugfs_node *driver_debug_dir;
 
 module_param(index, int, 0444);
 MODULE_PARM_DESC(index, "Index value for pcmtest soundcard");
diff --git a/sound/pci/hda/cs35l56_hda.h b/sound/pci/hda/cs35l56_hda.h
index 38d94fb213a5..f1db0ee219aa 100644
--- a/sound/pci/hda/cs35l56_hda.h
+++ b/sound/pci/hda/cs35l56_hda.h
@@ -18,6 +18,7 @@
 #include <sound/cs35l56.h>
 
 struct dentry;
+#define debugfs_node dentry
 
 struct cs35l56_hda {
 	struct cs35l56_base base;
@@ -38,7 +39,7 @@ struct cs35l56_hda {
 	struct snd_kcontrol *mixer_ctl[4];
 
 #if IS_ENABLED(CONFIG_SND_DEBUG)
-	struct dentry *debugfs_root;
+	struct debugfs_node *debugfs_root;
 #endif
 };
 
diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 735a1e487c6f..7f64a648aed7 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -835,7 +835,7 @@ static void cs35l56_dsp_work(struct work_struct *work)
 static int cs35l56_component_probe(struct snd_soc_component *component)
 {
 	struct cs35l56_private *cs35l56 = snd_soc_component_get_drvdata(component);
-	struct dentry *debugfs_root = component->debugfs_root;
+	struct debugfs_node *debugfs_root = component->debugfs_root;
 	unsigned short vendor, device;
 
 	BUILD_BUG_ON(ARRAY_SIZE(cs35l56_tx_input_texts) != ARRAY_SIZE(cs35l56_tx_input_values));
diff --git a/sound/soc/fsl/fsl_ssi.h b/sound/soc/fsl/fsl_ssi.h
index db57cad80449..6f95e230fc12 100644
--- a/sound/soc/fsl/fsl_ssi.h
+++ b/sound/soc/fsl/fsl_ssi.h
@@ -269,7 +269,7 @@ struct device;
 #if IS_ENABLED(CONFIG_DEBUG_FS)
 
 struct fsl_ssi_dbg {
-	struct dentry *dbg_dir;
+	struct debugfs_node *dbg_dir;
 
 	struct {
 		unsigned int rfrc;
diff --git a/sound/soc/fsl/imx-audmux.c b/sound/soc/fsl/imx-audmux.c
index cc2918ee2cf5..861ed15b5221 100644
--- a/sound/soc/fsl/imx-audmux.c
+++ b/sound/soc/fsl/imx-audmux.c
@@ -29,7 +29,7 @@ static u32 reg_max;
 #define IMX_AUDMUX_V2_PDCR(x)		((x) * 8 + 4)
 
 #ifdef CONFIG_DEBUG_FS
-static struct dentry *audmux_debugfs_root;
+static struct debugfs_node *audmux_debugfs_root;
 
 /* There is an annoying discontinuity in the SSI numbering with regard
  * to the Linux number of the devices */
diff --git a/sound/soc/intel/avs/avs.h b/sound/soc/intel/avs/avs.h
index eca6ec0428bb..dcada59e3c62 100644
--- a/sound/soc/intel/avs/avs.h
+++ b/sound/soc/intel/avs/avs.h
@@ -163,7 +163,7 @@ struct avs_dev {
 	u32 aging_timer_period;
 	u32 fifo_full_timer_period;
 	u32 logged_resources;	/* context dependent: core or library */
-	struct dentry *debugfs_root;
+	struct debugfs_node *debugfs_root;
 	/* probes */
 	struct hdac_ext_stream *extractor;
 	unsigned int num_probe_streams;
diff --git a/sound/soc/mediatek/mt8365/mt8365-afe-common.h b/sound/soc/mediatek/mt8365/mt8365-afe-common.h
index 731406e15ac7..076fd701ada0 100644
--- a/sound/soc/mediatek/mt8365/mt8365-afe-common.h
+++ b/sound/soc/mediatek/mt8365/mt8365-afe-common.h
@@ -345,7 +345,7 @@ struct mt8365_afe_private {
 	spinlock_t afe_ctrl_lock;
 	struct mutex afe_clk_mutex;	/* Protect & sync APLL TUNER registers access*/
 #ifdef CONFIG_DEBUG_FS
-	struct dentry *debugfs_dentry[MT8365_AFE_DEBUGFS_NUM];
+	struct debugfs_node *debugfs_dentry[MT8365_AFE_DEBUGFS_NUM];
 #endif
 	int apll_tuner_ref_cnt[MT8365_AFE_APLL_NUM];
 	unsigned int tdm_out_mode;
diff --git a/sound/soc/renesas/rcar/debugfs.c b/sound/soc/renesas/rcar/debugfs.c
index 26d3b310b9db..81b722924cdf 100644
--- a/sound/soc/renesas/rcar/debugfs.c
+++ b/sound/soc/renesas/rcar/debugfs.c
@@ -68,7 +68,7 @@ int rsnd_debugfs_probe(struct snd_soc_component *component)
 {
 	struct rsnd_priv *priv = dev_get_drvdata(component->dev);
 	struct rsnd_dai *rdai;
-	struct dentry *dir;
+	struct debugfs_node *dir;
 	char name[64];
 	int i;
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 3c6d8aef4130..f69b9abfd687 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -127,7 +127,7 @@ static const struct attribute_group *soc_dev_attr_groups[] = {
 };
 
 #ifdef CONFIG_DEBUG_FS
-struct dentry *snd_soc_debugfs_root;
+struct debugfs_node *snd_soc_debugfs_root;
 EXPORT_SYMBOL_GPL(snd_soc_debugfs_root);
 
 static void soc_init_component_debugfs(struct snd_soc_component *component)
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index b5116b700d73..809e90493131 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2254,7 +2254,7 @@ static const struct file_operations dapm_bias_fops = {
 };
 
 void snd_soc_dapm_debugfs_init(struct snd_soc_dapm_context *dapm,
-	struct dentry *parent)
+	struct debugfs_node *parent)
 {
 	if (IS_ERR_OR_NULL(parent))
 		return;
@@ -2294,7 +2294,7 @@ static void dapm_debugfs_cleanup(struct snd_soc_dapm_context *dapm)
 
 #else
 void snd_soc_dapm_debugfs_init(struct snd_soc_dapm_context *dapm,
-	struct dentry *parent)
+	struct debugfs_node *parent)
 {
 }
 
diff --git a/sound/soc/sof/debug.c b/sound/soc/sof/debug.c
index d0ffa1d71145..4047d2c085bc 100644
--- a/sound/soc/sof/debug.c
+++ b/sound/soc/sof/debug.c
@@ -314,7 +314,7 @@ int snd_sof_dbg_init(struct snd_sof_dev *sdev)
 	const struct snd_sof_dsp_ops *ops = sof_ops(sdev);
 	struct snd_sof_pdata *plat_data = sdev->pdata;
 	const struct snd_sof_debugfs_map *map;
-	struct dentry *fw_profile;
+	struct debugfs_node *fw_profile;
 	int i;
 	int err;
 
diff --git a/sound/soc/sof/ipc4-mtrace.c b/sound/soc/sof/ipc4-mtrace.c
index aa5b78604db6..7447a0eb0a55 100644
--- a/sound/soc/sof/ipc4-mtrace.c
+++ b/sound/soc/sof/ipc4-mtrace.c
@@ -381,7 +381,7 @@ static const struct file_operations sof_dfs_priority_mask_fops = {
 static int mtrace_debugfs_create(struct snd_sof_dev *sdev)
 {
 	struct sof_mtrace_priv *priv = sdev->fw_trace_data;
-	struct dentry *dfs_root;
+	struct debugfs_node *dfs_root;
 	char dfs_name[100];
 	int i;
 
diff --git a/sound/soc/sof/sof-client-ipc-flood-test.c b/sound/soc/sof/sof-client-ipc-flood-test.c
index 11b6f7da2882..443d36294c99 100644
--- a/sound/soc/sof/sof-client-ipc-flood-test.c
+++ b/sound/soc/sof/sof-client-ipc-flood-test.c
@@ -28,7 +28,7 @@
 #define DEBUGFS_IPC_FLOOD_DURATION	"ipc_flood_duration_ms"
 
 struct sof_ipc_flood_priv {
-	struct dentry *dfs_root;
+	struct debugfs_node *dfs_root;
 	struct dentry *dfs_link[2];
 	char *buf;
 };
@@ -286,7 +286,7 @@ static int sof_ipc_flood_probe(struct auxiliary_device *auxdev,
 			       const struct auxiliary_device_id *id)
 {
 	struct sof_client_dev *cdev = auxiliary_dev_to_sof_client_dev(auxdev);
-	struct dentry *debugfs_root = sof_client_get_debugfs_root(cdev);
+	struct debugfs_node *debugfs_root = sof_client_get_debugfs_root(cdev);
 	struct device *dev = &auxdev->dev;
 	struct sof_ipc_flood_priv *priv;
 
diff --git a/sound/soc/sof/sof-client-ipc-kernel-injector.c b/sound/soc/sof/sof-client-ipc-kernel-injector.c
index 8b28c3dc920c..4717ff3cb213 100644
--- a/sound/soc/sof/sof-client-ipc-kernel-injector.c
+++ b/sound/soc/sof/sof-client-ipc-kernel-injector.c
@@ -17,7 +17,7 @@
 #define SOF_IPC_CLIENT_SUSPEND_DELAY_MS	3000
 
 struct sof_msg_inject_priv {
-	struct dentry *kernel_dfs_file;
+	struct debugfs_node *kernel_dfs_file;
 	size_t max_msg_size;
 
 	void *kernel_buffer;
@@ -92,7 +92,7 @@ static int sof_msg_inject_probe(struct auxiliary_device *auxdev,
 				const struct auxiliary_device_id *id)
 {
 	struct sof_client_dev *cdev = auxiliary_dev_to_sof_client_dev(auxdev);
-	struct dentry *debugfs_root = sof_client_get_debugfs_root(cdev);
+	struct debugfs_node *debugfs_root = sof_client_get_debugfs_root(cdev);
 	struct device *dev = &auxdev->dev;
 	struct sof_msg_inject_priv *priv;
 	size_t alloc_size;
diff --git a/sound/soc/sof/sof-client-ipc-msg-injector.c b/sound/soc/sof/sof-client-ipc-msg-injector.c
index ba7ca1c5027f..2d0a2da8eea4 100644
--- a/sound/soc/sof/sof-client-ipc-msg-injector.c
+++ b/sound/soc/sof/sof-client-ipc-msg-injector.c
@@ -22,7 +22,7 @@
 #define SOF_IPC_CLIENT_SUSPEND_DELAY_MS	3000
 
 struct sof_msg_inject_priv {
-	struct dentry *dfs_file;
+	struct debugfs_node *dfs_file;
 	size_t max_msg_size;
 	enum sof_ipc_type ipc_type;
 
@@ -252,7 +252,7 @@ static int sof_msg_inject_probe(struct auxiliary_device *auxdev,
 				const struct auxiliary_device_id *id)
 {
 	struct sof_client_dev *cdev = auxiliary_dev_to_sof_client_dev(auxdev);
-	struct dentry *debugfs_root = sof_client_get_debugfs_root(cdev);
+	struct debugfs_node *debugfs_root = sof_client_get_debugfs_root(cdev);
 	static const struct file_operations *fops;
 	struct device *dev = &auxdev->dev;
 	struct sof_msg_inject_priv *priv;
diff --git a/sound/soc/sof/sof-client-probes.c b/sound/soc/sof/sof-client-probes.c
index aff9ce980429..c9921f576fe3 100644
--- a/sound/soc/sof/sof-client-probes.c
+++ b/sound/soc/sof/sof-client-probes.c
@@ -385,7 +385,7 @@ static int sof_probes_client_probe(struct auxiliary_device *auxdev,
 				   const struct auxiliary_device_id *id)
 {
 	struct sof_client_dev *cdev = auxiliary_dev_to_sof_client_dev(auxdev);
-	struct dentry *dfsroot = sof_client_get_debugfs_root(cdev);
+	struct debugfs_node *dfsroot = sof_client_get_debugfs_root(cdev);
 	struct device *dev = &auxdev->dev;
 	struct snd_soc_dai_link_component platform_component[] = {
 		{
diff --git a/sound/soc/sof/sof-client-probes.h b/sound/soc/sof/sof-client-probes.h
index da04d65b8d99..7d2cfbc3df51 100644
--- a/sound/soc/sof/sof-client-probes.h
+++ b/sound/soc/sof/sof-client-probes.h
@@ -52,8 +52,8 @@ extern const struct sof_probes_ipc_ops ipc3_probe_ops;
 extern const struct sof_probes_ipc_ops ipc4_probe_ops;
 
 struct sof_probes_priv {
-	struct dentry *dfs_points;
-	struct dentry *dfs_points_remove;
+	struct debugfs_node *dfs_points;
+	struct debugfs_node *dfs_points_remove;
 	u32 extractor_stream_tag;
 	struct snd_soc_card card;
 	void *ipc_priv;
diff --git a/sound/soc/sof/sof-client.c b/sound/soc/sof/sof-client.c
index 4c7951338c66..1c40d0d555bb 100644
--- a/sound/soc/sof/sof-client.c
+++ b/sound/soc/sof/sof-client.c
@@ -401,7 +401,7 @@ int sof_resume_clients(struct snd_sof_dev *sdev)
 }
 EXPORT_SYMBOL_NS_GPL(sof_resume_clients, "SND_SOC_SOF_CLIENT");
 
-struct dentry *sof_client_get_debugfs_root(struct sof_client_dev *cdev)
+struct debugfs_node *sof_client_get_debugfs_root(struct sof_client_dev *cdev)
 {
 	return cdev->sdev->debugfs_root;
 }
diff --git a/sound/soc/sof/sof-client.h b/sound/soc/sof/sof-client.h
index b6ccc2cd69e5..d38b7329b587 100644
--- a/sound/soc/sof/sof-client.h
+++ b/sound/soc/sof/sof-client.h
@@ -12,6 +12,7 @@ struct sof_ipc_fw_version;
 struct sof_ipc_cmd_hdr;
 struct snd_sof_dev;
 struct dentry;
+#define debugfs_node dentry
 
 struct sof_ipc4_fw_module;
 
@@ -48,7 +49,7 @@ int sof_client_ipc_set_get_data(struct sof_client_dev *cdev, void *ipc_msg,
 
 struct sof_ipc4_fw_module *sof_client_ipc4_find_module(struct sof_client_dev *c, const guid_t *u);
 
-struct dentry *sof_client_get_debugfs_root(struct sof_client_dev *cdev);
+struct debugfs_node *sof_client_get_debugfs_root(struct sof_client_dev *cdev);
 struct device *sof_client_get_dma_dev(struct sof_client_dev *cdev);
 const struct sof_ipc_fw_version *sof_client_get_fw_version(struct sof_client_dev *cdev);
 size_t sof_client_get_ipc_max_payload_size(struct sof_client_dev *cdev);
diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
index abbb5ee7e08c..4bfce1e4db71 100644
--- a/sound/soc/sof/sof-priv.h
+++ b/sound/soc/sof/sof-priv.h
@@ -606,7 +606,7 @@ struct snd_sof_dev {
 	size_t dsp_oops_offset;
 
 	/* debug */
-	struct dentry *debugfs_root;
+	struct debugfs_node *debugfs_root;
 	struct list_head dfsentry_list;
 	bool dbg_dump_printed;
 	bool ipc_dump_printed;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index ba0327e2d0d3..ca7fdbbf9fa3 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -115,7 +115,7 @@ static struct kmem_cache *kvm_vcpu_cache;
 static __read_mostly struct preempt_ops kvm_preempt_ops;
 static DEFINE_PER_CPU(struct kvm_vcpu *, kvm_running_vcpu);
 
-static struct dentry *kvm_debugfs_dir;
+static struct debugfs_node *kvm_debugfs_dir;
 
 static const struct file_operations stat_fops_per_vm;
 
@@ -1001,7 +1001,7 @@ static void kvm_destroy_vm_debugfs(struct kvm *kvm)
 static int kvm_create_vm_debugfs(struct kvm *kvm, const char *fdname)
 {
 	static DEFINE_MUTEX(kvm_debugfs_lock);
-	struct dentry *dent;
+	struct debugfs_node *dent;
 	char dir_name[ITOA_MAX_LEN * 2];
 	struct kvm_stat_data *stat_data;
 	const struct _kvm_stats_desc *pdesc;
@@ -1017,7 +1017,7 @@ static int kvm_create_vm_debugfs(struct kvm *kvm, const char *fdname)
 	dent = debugfs_lookup(dir_name, kvm_debugfs_dir);
 	if (dent) {
 		pr_warn_ratelimited("KVM: debugfs: duplicate directory %s\n", dir_name);
-		dput(dent);
+		debugfs_node_put(dent);
 		mutex_unlock(&kvm_debugfs_lock);
 		return 0;
 	}
@@ -4037,7 +4037,7 @@ DEFINE_SIMPLE_ATTRIBUTE(vcpu_get_pid_fops, vcpu_get_pid, NULL, "%llu\n");
 
 static void kvm_create_vcpu_debugfs(struct kvm_vcpu *vcpu)
 {
-	struct dentry *debugfs_dentry;
+	struct debugfs_node *debugfs_dentry;
 	char dir_name[ITOA_MAX_LEN * 2];
 
 	if (!debugfs_initialized())

