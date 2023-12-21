Return-Path: <linux-fsdevel+bounces-6759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E042D81C193
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 00:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9685F2868FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 23:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2023379492;
	Thu, 21 Dec 2023 23:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rWneAvCJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6846379466;
	Thu, 21 Dec 2023 23:01:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8340C433C7;
	Thu, 21 Dec 2023 23:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703199716;
	bh=Gi5//iEP+wF2L1cPim8HDnKfYBJ/YrKYxwasffiQaNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rWneAvCJRSBNAyWgSITLyHiTAhjP/opK7g7PxZJ7CPATJr1YyX58tYGKBidMV6sC2
	 CWbTAMvwUBG0fgz50QWg2Dmy8xlABJyCrpSvFOEREtVmnWcicaR4BaqQaQJR1mIAex
	 VIuoZsGed03Wy/nRNeqLA5A/Hcjlsu58G9u2TXDT59l84Nja9iEGuqU9wmFsbcLB1l
	 9hKvpIoGKMhaXZ8WUpRMnhfiVMKWBX3Jm69V6flvlr3GhqY3kP+OQcyXbnWqpdb1FF
	 f9XlgcW2SNOXNm2XdJZWKh1ukq1QJJClCg+oJZ1lkgh6sNkFy/kTKbcQUFrsK06V0G
	 Znz7Crj+wuMjA==
Date: Thu, 21 Dec 2023 16:01:53 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Christian Brauner <christian@brauner.io>, linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 37/40] netfs: Optimise away reads above the point at
 which there can be no data
Message-ID: <20231221230153.GA1607352@dev-arch.thelio-3990X>
References: <20231221132400.1601991-1-dhowells@redhat.com>
 <20231221132400.1601991-38-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221132400.1601991-38-dhowells@redhat.com>

Hi David,

On Thu, Dec 21, 2023 at 01:23:32PM +0000, David Howells wrote:
> Track the file position above which the server is not expected to have any
> data (the "zero point") and preemptively assume that we can satisfy
> requests by filling them with zeroes locally rather than attempting to
> download them if they're over that line - even if we've written data back
> to the server.  Assume that any data that was written back above that
> position is held in the local cache.  Note that we have to split requests
> that straddle the line.
> 
> Make use of this to optimise away some reads from the server.  We need to
> set the zero point in the following circumstances:
> 
>  (1) When we see an extant remote inode and have no cache for it, we set
>      the zero_point to i_size.
> 
>  (2) On local inode creation, we set zero_point to 0.
> 
>  (3) On local truncation down, we reduce zero_point to the new i_size if
>      the new i_size is lower.
> 
>  (4) On local truncation up, we don't change zero_point.
> 
>  (5) On local modification, we don't change zero_point.
> 
>  (6) On remote invalidation, we set zero_point to the new i_size.
> 
>  (7) If stored data is discarded from the pagecache or culled from fscache,
>      we must set zero_point above that if the data also got written to the
>      server.
> 
>  (8) If dirty data is written back to the server, but not fscache, we must
>      set zero_point above that.
> 
>  (9) If a direct I/O write is made, set zero_point above that.
> 
> Assuming the above, any read from the server at or above the zero_point
> position will return all zeroes.
> 
> The zero_point value can be stored in the cache, provided the above rules
> are applied to it by any code that culls part of the local cache.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-cachefs@redhat.com
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-mm@kvack.org
> ---

<snip>

> diff --git a/include/linux/netfs.h b/include/linux/netfs.h
> index 8cde618cf6d9..a5374218efe4 100644
> --- a/include/linux/netfs.h
> +++ b/include/linux/netfs.h
> @@ -136,6 +136,8 @@ struct netfs_inode {
>  	struct fscache_cookie	*cache;
>  #endif
>  	loff_t			remote_i_size;	/* Size of the remote file */
> +	loff_t			zero_point;	/* Size after which we assume there's no data
> +						 * on the server */
>  	unsigned long		flags;
>  #define NETFS_ICTX_ODIRECT	0		/* The file has DIO in progress */
>  #define NETFS_ICTX_UNBUFFERED	1		/* I/O should not use the pagecache */
> @@ -463,22 +465,30 @@ static inline void netfs_inode_init(struct netfs_inode *ctx,
>  {
>  	ctx->ops = ops;
>  	ctx->remote_i_size = i_size_read(&ctx->inode);
> +	ctx->zero_point = ctx->remote_i_size;
>  	ctx->flags = 0;
>  #if IS_ENABLED(CONFIG_FSCACHE)
>  	ctx->cache = NULL;
>  #endif
> +	/* ->releasepage() drives zero_point */
> +	mapping_set_release_always(ctx->inode.i_mapping);
>  }

I bisected a crash that I see when trying to mount an NFS volume to this
change as commit 6e3c8451f624 ("netfs: Optimise away reads above the
point at which there can be no data") in next-20231221:

  [   45.964963] BUG: kernel NULL pointer dereference, address: 0000000000000078
  [   45.964975] #PF: supervisor write access in kernel mode
  [   45.964982] #PF: error_code(0x0002) - not-present page
  [   45.964987] PGD 0 P4D 0
  [   45.964996] Oops: 0002 [#1] PREEMPT SMP NOPTI
  [   45.965004] CPU: 2 PID: 2419 Comm: mount.nfs Not tainted 6.7.0-rc6-next-20231221-debug-09925-g857647efa9be #1 adbbe7bc5037c662bc8f9b8e78ccf16be15b5e58
  [   45.965014] Hardware name: HP HP Desktop M01-F1xxx/87D6, BIOS F.12 12/17/2020
  [   45.965019] RIP: 0010:nfs_alloc_inode+0xa2/0xc0 [nfs]
  [   45.965092] Code: 80 b0 01 00 00 00 00 00 00 48 c7 80 38 04 00 00 00 f7 1e c2 48 c7 80 58 04 00 00 00 00 00 00 48 c7 80 40 04 00 00 00 00 00 00 <f0> 80 0a 80 48 05 b8 01 00 00 e9 5f 2b 20 f5 66 66 2e 0f 1f 84 00
  [   45.965099] RSP: 0018:ffffc900058f7bc0 EFLAGS: 00010286
  [   45.965107] RAX: ffff8881958c7290 RBX: ffff888168f0f800 RCX: 0000000000000000
  [   45.965112] RDX: 0000000000000078 RSI: ffffffffc2140a71 RDI: ffff88817a12b880
  [   45.965118] RBP: ffff888168f0f800 R08: ffffc900058f7b70 R09: 88728c958188ffff
  [   45.965123] R10: 000000000003a5c0 R11: 0000000000000005 R12: ffffffffc22f1a80
  [   45.965128] R13: ffffc900058f7c30 R14: 0000000000000000 R15: 0000000000000002
  [   45.965134] FS:  00007ff78c318740(0000) GS:ffff8887ff280000(0000) knlGS:0000000000000000
  [   45.965140] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [   45.965146] CR2: 0000000000000078 CR3: 000000018a514000 CR4: 0000000000350ef0
  [   45.965152] Call Trace:
  [   45.965160]  <TASK>
  [   45.965167]  ? __die+0x23/0x70
  [   45.965183]  ? page_fault_oops+0x173/0x4e0
  [   45.965197]  ? nfs_alloc_inode+0x21/0xc0 [nfs aac4a012b174ef6e5996d0df3638a0616e82eb47]
  [   45.965279]  ? exc_page_fault+0x7e/0x180
  [   45.965291]  ? asm_exc_page_fault+0x26/0x30
  [   45.965308]  ? nfs_alloc_inode+0x21/0xc0 [nfs aac4a012b174ef6e5996d0df3638a0616e82eb47]
  [   45.965374]  ? nfs_alloc_inode+0xa2/0xc0 [nfs aac4a012b174ef6e5996d0df3638a0616e82eb47]
  [   45.965441]  alloc_inode+0x1e/0xc0
  [   45.965452]  ? __pfx_nfs_find_actor+0x10/0x10 [nfs aac4a012b174ef6e5996d0df3638a0616e82eb47]
  [   45.965517]  iget5_locked+0x97/0xf0
  [   45.965525]  ? __pfx_nfs_init_locked+0x10/0x10 [nfs aac4a012b174ef6e5996d0df3638a0616e82eb47]
  [   45.965593]  nfs_fhget+0xe4/0x700 [nfs aac4a012b174ef6e5996d0df3638a0616e82eb47]
  [   45.965666]  nfs_get_root+0xc6/0x4a0 [nfs aac4a012b174ef6e5996d0df3638a0616e82eb47]
  [   45.965732]  ? kernfs_rename_ns+0x85/0x210
  [   45.965754]  nfs_get_tree_common+0xc7/0x520 [nfs aac4a012b174ef6e5996d0df3638a0616e82eb47]
  [   45.965826]  vfs_get_tree+0x29/0xf0
  [   45.965836]  fc_mount+0x12/0x40
  [   45.965846]  do_nfs4_mount+0x12e/0x370 [nfsv4 9bac1f2bd94d7294fbbaf875b7b5cec5adc527f5]
  [   45.965946]  nfs4_try_get_tree+0x48/0xd0 [nfsv4 9bac1f2bd94d7294fbbaf875b7b5cec5adc527f5]
  [   45.966034]  vfs_get_tree+0x29/0xf0
  [   45.966041]  ? srso_return_thunk+0x5/0x5f
  [   45.966051]  path_mount+0x4ca/0xb10
  [   45.966063]  __x64_sys_mount+0x11a/0x150
  [   45.966074]  do_syscall_64+0x64/0xe0
  [   45.966083]  ? do_syscall_64+0x70/0xe0
  [   45.966090]  ? syscall_exit_to_user_mode+0x2b/0x40
  [   45.966098]  ? srso_return_thunk+0x5/0x5f
  [   45.966106]  ? do_syscall_64+0x70/0xe0
  [   45.966113]  ? srso_return_thunk+0x5/0x5f
  [   45.966121]  ? exc_page_fault+0x7e/0x180
  [   45.966130]  entry_SYSCALL_64_after_hwframe+0x6c/0x74
  [   45.966138] RIP: 0033:0x7ff78c5f2a1e
  ...

It appears that ctx->inode.i_mapping is NULL in netfs_inode_init(). This
patch appears to cure the problem for me but I am not sure if it is
proper or not.

Cheers,
Nathan

diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index a5374218efe4..8daaba665421 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -471,7 +471,8 @@ static inline void netfs_inode_init(struct netfs_inode *ctx,
 	ctx->cache = NULL;
 #endif
 	/* ->releasepage() drives zero_point */
-	mapping_set_release_always(ctx->inode.i_mapping);
+	if (ctx->inode.i_mapping)
+		mapping_set_release_always(ctx->inode.i_mapping);
 }
 
 /**

