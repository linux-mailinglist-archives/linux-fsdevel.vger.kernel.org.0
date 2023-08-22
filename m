Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C46A783C5D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Aug 2023 10:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbjHVI7P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Aug 2023 04:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbjHVI7O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Aug 2023 04:59:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3129ACC8
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Aug 2023 01:58:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B45F065008
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Aug 2023 08:58:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B135C433C8;
        Tue, 22 Aug 2023 08:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692694717;
        bh=4qZ7RppNg9qYWoZJetV/MXqzmQCT9MKmJKzbdyaQ3Y0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y1dezFNnX0NvdIqNeO5gHPMmW8rQdSDv9lYav1w373oqrjRLJ6n+XTYalCGcgVsAO
         F7dBkLXWJAPjSSlBid46Qkv3QP45lENIQAfwcH0liP1mMc3G0SVwS0ZhFmpES1YI27
         DAnnsr6+uPhqE2kU0HMmrAKG99Z41a+iI6D6vFVnFQKISKOUpsFpyGVO/22t0C5BE9
         kR+qlbBzNfITKy8VFOd85VicZRA+Xtk4LBB8k2zyVM87CSerzmnz1HFm/fpp6x97T0
         NJPGvPiz+Bw5zZTEV8ik3X338CtqlWgZ2MusF1sCDKWKMuEdiAvnF/Q4VwH9EbQaGc
         NLrtIDF9gWaTw==
From:   Christian Brauner <brauner@kernel.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleksandr Tymoshenko <ovt@google.com>,
        Carlos Maiolino <cem@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Miklos Szeredi <miklos@szeredi.hu>, Daniel Xu <dxu@dxuuu.xyz>,
        Chris Down <chris@chrisdown.name>, Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Pete Zaitcev <zaitcev@redhat.com>,
        Helge Deller <deller@gmx.de>,
        Topi Miettinen <toiwoton@gmail.com>,
        Yu Kuai <yukuai3@huawei.com>,
        Franklin Mathieu <snaipe@arista.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: (subset) [PATCH vfs.tmpfs] tmpfs,xattr: GFP_KERNEL_ACCOUNT for simple xattrs
Date:   Tue, 22 Aug 2023 10:58:26 +0200
Message-Id: <20230822-anordnen-tracht-4dd042da0e09@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <f6953e5a-4183-8314-38f2-40be60998615@google.com>
References: <e92a4d33-f97-7c84-95ad-4fed8e84608c@google.com> <20230809-postkarten-zugute-3cde38456390@brauner> <20230809-leitgedanke-weltumsegelung-55042d9f7177@brauner> <cdedadf2-d199-1133-762f-a8fe166fb968@google.com> <20230810-notwehr-denkbar-3be0cc53a87a@brauner> <f6953e5a-4183-8314-38f2-40be60998615@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1511; i=brauner@kernel.org; h=from:subject:message-id; bh=4qZ7RppNg9qYWoZJetV/MXqzmQCT9MKmJKzbdyaQ3Y0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ8qVhrdHjfzayJgX7KP7/31IqX3Dhux1QR6n1T8Kx56rSv b28rdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkTQQjQ8+r5AQvRpV9j+P3qrxQ/7 t+xifBxZsW1B2Kje+LmaoVdpaRYc2jghl7vDbvv+Qc7daxWX92w2mnfRJ75wbePix3d3LvHj4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 21 Aug 2023 10:39:20 -0700, Hugh Dickins wrote:
> It is particularly important for the userns mount case (when a sensible
> nr_inodes maximum may not be enforced) that tmpfs user xattrs be subject
> to memory cgroup limiting.  Leave temporary buffer allocations as is,
> but change the persistent simple xattr allocations from GFP_KERNEL to
> GFP_KERNEL_ACCOUNT.  This limits kernfs's cgroupfs too, but that's good.
> 
> (I had intended to send this change earlier, but had been confused by
> shmem_alloc_inode() using GFP_KERNEL, and thought a discussion would be
> needed to change that too: no, I was forgetting the SLAB_ACCOUNT on that
> kmem_cache, which implicitly adds __GFP_ACCOUNT to all its allocations.)
> 
> [...]

Applied to the vfs.tmpfs branch of the vfs/vfs.git tree.
Patches in the vfs.tmpfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.tmpfs

[1/1] tmpfs,xattr: GFP_KERNEL_ACCOUNT for simple xattrs
      https://git.kernel.org/vfs/vfs/c/572a3d1e5d3a
