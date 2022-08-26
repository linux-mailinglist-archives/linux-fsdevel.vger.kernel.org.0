Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457435A29FF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Aug 2022 16:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243211AbiHZOtR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Aug 2022 10:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiHZOtP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Aug 2022 10:49:15 -0400
X-Greylist: delayed 432 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 26 Aug 2022 07:49:14 PDT
Received: from mail.stoffel.org (li1843-175.members.linode.com [172.104.24.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54314D87EB;
        Fri, 26 Aug 2022 07:49:14 -0700 (PDT)
Received: from quad.stoffel.org (068-116-170-226.res.spectrum.com [68.116.170.226])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.stoffel.org (Postfix) with ESMTPSA id 0BD202189D;
        Fri, 26 Aug 2022 10:42:01 -0400 (EDT)
Received: by quad.stoffel.org (Postfix, from userid 1000)
        id 4B1F7A7E15; Fri, 26 Aug 2022 10:42:00 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <25352.56248.283092.213037@quad.stoffel.home>
Date:   Fri, 26 Aug 2022 10:42:00 -0400
From:   "John Stoffel" <john@stoffel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/RFC 00/10 v5] Improve scalability of directory operations
In-Reply-To: <166147828344.25420.13834885828450967910.stgit@noble.brown>
References: <166147828344.25420.13834885828450967910.stgit@noble.brown>
X-Mailer: VM 8.2.0b under 27.1 (x86_64-pc-linux-gnu)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>>>>> "NeilBrown" == NeilBrown  <neilb@suse.de> writes:

NeilBrown> [I made up "v5" - I haven't been counting]

My first comments, but I'm not a serious developer...

NeilBrown> VFS currently holds an exclusive lock on the directory while making
NeilBrown> changes: add, remove, rename.
NeilBrown> When multiple threads make changes in the one directory, the contention
NeilBrown> can be noticeable.
NeilBrown> In the case of NFS with a high latency link, this can easily be
NeilBrown> demonstrated.  NFS doesn't really need VFS locking as the server ensures
NeilBrown> correctness.

NeilBrown> Lustre uses a single(?) directory for object storage, and has patches
NeilBrown> for ext4 to support concurrent updates (Lustre accesses ext4 directly,
NeilBrown> not via the VFS).

NeilBrown> XFS (it is claimed) doesn't its own locking and doesn't need the VFS to
NeilBrown> help at all.

This sentence makes no sense to me... I assume you meant to say "...does
it's own locking..."

NeilBrown> This patch series allows filesystems to request a shared lock on
NeilBrown> directories and provides serialisation on just the affected name, not the
NeilBrown> whole directory.  It changes both the VFS and NFSD to use shared locks
NeilBrown> when appropriate, and changes NFS to request shared locks.

Are there any performance results?  Why wouldn't we just do a shared
locked across all VFS based filesystems?  

NeilBrown> The central enabling feature is a new dentry flag DCACHE_PAR_UPDATE
NeilBrown> which acts as a bit-lock.  The ->d_lock spinlock is taken to set/clear
NeilBrown> it, and wait_var_event() is used for waiting.  This flag is set on all
NeilBrown> dentries that are part of a directory update, not just when a shared
NeilBrown> lock is taken.

NeilBrown> When a shared lock is taken we must use alloc_dentry_parallel() which
NeilBrown> needs a wq which must remain until the update is completed.  To make use
NeilBrown> of concurrent create, kern_path_create() would need to be passed a wq.
NeilBrown> Rather than the churn required for that, we use exclusive locking when
NeilBrown> no wq is provided.

Is this a per-operation wq or a per-directory wq?  Can there be issues
if someone does something silly like having 1,000 directories, all of
which have multiple processes making parallel changes?  

Does it degrade gracefully if a wq can't be allocated?  

NeilBrown> One interesting consequence of this is that silly-rename becomes a
NeilBrown> little more complex.  As the directory may not be exclusively locked,
NeilBrown> the new silly-name needs to be locked (DCACHE_PAR_UPDATE) as well.
NeilBrown> A new LOOKUP_SILLY_RENAME is added which helps implement this using
NeilBrown> common code.

NeilBrown> While testing I found some odd behaviour that was caused by
NeilBrown> d_revalidate() racing with rename().  To resolve this I used
NeilBrown> DCACHE_PAR_UPDATE to ensure they cannot race any more.

NeilBrown> Testing, review, or other comments would be most welcome,

