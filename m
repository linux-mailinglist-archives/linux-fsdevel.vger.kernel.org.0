Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7D470D900
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 11:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235259AbjEWJ2r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 05:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjEWJ2q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 05:28:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D864E6;
        Tue, 23 May 2023 02:28:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A195614B2;
        Tue, 23 May 2023 09:28:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA2EC433D2;
        Tue, 23 May 2023 09:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684834124;
        bh=l6zlO3zrfqNyX7yFpEx6BRzK5yGcYjeoYtH9xlr+994=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HM298nrMQgJkZY147EZroy4PK7mr5PO1OKvTSfI9+RY+oAzcPrhBfxJGv+QtFPmed
         48Lr8wvAVWllrJRyoY2o/ZZfRNzZma++cSt5/0sb+JoPMoODU5cXuAgxqcA9+xzQPM
         6BndpH3IdRP5EWrIVVQr7fNn5YalW3kbs5xeLYY0C6BmP2AvrUPSZlrablsQPSfaUj
         7bwdhbsDaSYMtzxjpOAeNbvemmcDYY/IG4MAG8eBMAb25UBVHzPQsStvWPxUj1cHYJ
         AdLNaaj9d3KFvldgtPGwAL3TJH3hTm9ocKGCxBLySPlWIifNbTU3OvSXjoV9P92dPb
         rfzr060cwMPoQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Dave Chinner <dchinner@redhat.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: (subset) [PATCH 22/32] vfs: inode cache conversion to hash-bl
Date:   Tue, 23 May 2023 11:28:38 +0200
Message-Id: <20230523-zujubeln-heizsysteme-f756eefe663e@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230509165657.1735798-23-kent.overstreet@linux.dev>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev> <20230509165657.1735798-23-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1340; i=brauner@kernel.org; h=from:subject:message-id; bh=l6zlO3zrfqNyX7yFpEx6BRzK5yGcYjeoYtH9xlr+994=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTktNsoO3+5lbI+eNuhP803wtzbZnrxf9y8/bFq4ZNA78kT IqbadpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzE+CDDf79WZo+Q06qzlzYUXg+KPp VnzWx90LlJXYfJSXuprtKhhQz/M6ILLaZlzozr23v4144mneiNcbWfluy+Eui1+bddz4R2NgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 09 May 2023 12:56:47 -0400, Kent Overstreet wrote:
> Because scalability of the global inode_hash_lock really, really
> sucks.
> 
> 32-way concurrent create on a couple of different filesystems
> before:
> 
> -   52.13%     0.04%  [kernel]            [k] ext4_create
>    - 52.09% ext4_create
>       - 41.03% __ext4_new_inode
>          - 29.92% insert_inode_locked
>             - 25.35% _raw_spin_lock
>                - do_raw_spin_lock
>                   - 24.97% __pv_queued_spin_lock_slowpath
> 
> [...]

This is interesting completely independent of bcachefs so we should give
it some testing.

I updated a few places that had outdated comments.

---

Applied to the vfs.unstable.inode-hash branch of the vfs/vfs.git tree.
Patches in the vfs.unstable.inode-hash branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.unstable.inode-hash

[22/32] vfs: inode cache conversion to hash-bl
        https://git.kernel.org/vfs/vfs/c/e3e92d47e6b1
