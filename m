Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768BE736A0D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 12:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbjFTK51 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 06:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbjFTK5U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:57:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD551A7;
        Tue, 20 Jun 2023 03:57:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50D82611A5;
        Tue, 20 Jun 2023 10:57:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD415C433C0;
        Tue, 20 Jun 2023 10:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687258634;
        bh=FPNlR/goPfEl0ZNuR4JEClLiKcSj4qMu+uag8y5elZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GE41u+NBg3yEjP+j11L2FGfEteAwhwgJ82XGtGHu6nc+dKVMfELbezTRIW1ID4Awv
         rrgqYvlzFkHmFwHtiTBK9hENu+K7hEmyvz8TZHs4JjOEaK4XG1yHPmhX1dcxVIIR3g
         JXJUdmUIsU40Ofwqel2uzbcrDz1r0amR3s7RCzv5/Ps7N752zN9qmmuv0uFzKt9bNb
         PGd/JkPSsSEmGLdbQ6E+g1IIgsA78VRUWXUAENICWfZGf9cj9KaVDCGX2I3DrW3L5D
         WyWWm0xSEzpDmOWeDB2TaMaeDOTmJ3USmo+w2gZwQDj/TnSc2GSYx1Y4nKNSadfW4o
         xtcHwxF64k0nw==
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v5 0/5] Handle notifications on overlayfs fake path files
Date:   Tue, 20 Jun 2023 12:57:03 +0200
Message-Id: <20230620-bettruhe-gecoacht-15e69518e47b@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230615112229.2143178-1-amir73il@gmail.com>
References: <20230615112229.2143178-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1757; i=brauner@kernel.org; h=from:subject:message-id; bh=FPNlR/goPfEl0ZNuR4JEClLiKcSj4qMu+uag8y5elZs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRMbP0c/eXLxvZApX+ywR0Po3+9fRky//ruow92bLsRad3k Lj53QkcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEph1h+Kf74Up9z/wpezdWJf/6ce MPX/AbixtyaibLD9r5mbK/a/rC8N9xd/6p2b+sw75MLHrL4pg4VTRlrllr+oLJMU/LBdotPTgA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 15 Jun 2023 14:22:24 +0300, Amir Goldstein wrote:
> Christian,
> 
> A little while ago, Jan and I realized that an unprivileged overlayfs
> mount could be used to avert fanotify permission events that were
> requested for an inode or sb on the underlying fs.
> 
> The [v1] patch set was an attempt to implement Miklos' suggestion
> (opt-in to query the fake path) which turned out to affet the vfs in
> many places, so Miklos and I agreed on a solution that will be less
> intrusive for vfs (opt-in to query the real path).
> 
> [...]

I incorporated all the fixes suggested by Christoph and the missing
decrement of nr_files.

---

Applied to the vfs.backing.file branch of the vfs/vfs.git tree.
Patches in the vfs.backing.file branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.backing.file

[1/5] fs: rename {vfs,kernel}_tmpfile_open()
      https://git.kernel.org/vfs/vfs/c/d56e0ddb8fc3
[2/5] fs: use a helper for opening kernel internal files
      https://git.kernel.org/vfs/vfs/c/cbb0b9d4bbcf
[3/5] fs: move kmem_cache_zalloc() into alloc_empty_file*() helpers
      https://git.kernel.org/vfs/vfs/c/8a05a8c31d06
[4/5] fs: use backing_file container for internal files with "fake" f_path
      https://git.kernel.org/vfs/vfs/c/62d53c4a1dfe
[5/5] ovl: enable fsnotify events on underlying real files
      https://git.kernel.org/vfs/vfs/c/bc2473c90fca
