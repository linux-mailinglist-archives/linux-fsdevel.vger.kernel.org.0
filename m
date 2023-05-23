Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8161E70D8FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 11:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236308AbjEWJ1s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 05:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbjEWJ1r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 05:27:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29302102;
        Tue, 23 May 2023 02:27:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1E0961458;
        Tue, 23 May 2023 09:27:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900DDC433EF;
        Tue, 23 May 2023 09:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684834065;
        bh=GxCw8XHZQUNgn/D+d/HLdZIvI8/UxcZX98tov3QuGj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bsHAyqOH8UJkZXzpSVReuacSD72TtW+QHZeXB4wupk7QE3JOv9zINpvrColtflgJT
         TIGVGfu8CsGH3uYj20Q+LBEgkakBI8UTll6zs+aaQkmN5HFluFbD3AaNs1UW/BZ4SN
         3C4u3KZVmBfypshuf9F47ZO7EgUzYCw9WaDPujasCp0bPym+e2dQLVYzYzY+1EwTh6
         MrkC29E+EKHpwWqAYHywfRUxPQhdw3RI1D9yyskYhSWE8NMjxgOg73vfLg2tBIKmqz
         GeGAwRlY3HnTwfMv7wchxAqYLH/7ovPk6Vj/KObVjbzpRABJaQi5hOiW2wvoVMa13R
         KIYa9qXd7nnrw==
From:   Christian Brauner <brauner@kernel.org>
To:     Dave Chinner <dchinner@redhat.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: (subset) [PATCH 21/32] hlist-bl: add hlist_bl_fake()
Date:   Tue, 23 May 2023 11:27:37 +0200
Message-Id: <20230523-bitumen-misskredit-a5e4ae904d58@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230509165657.1735798-22-kent.overstreet@linux.dev>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev> <20230509165657.1735798-22-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1044; i=brauner@kernel.org; h=from:subject:message-id; bh=GxCw8XHZQUNgn/D+d/HLdZIvI8/UxcZX98tov3QuGj8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTktDPnfnKdFVK4s6BJUn/Nm+Qv8g7xGeL+juFCEUltCwv0 efs6SlkYxLgYZMUUWRzaTcLllvNUbDbK1ICZw8oEMoSBi1MAJpJ0k5Hh/rED3XsD3ppYTlKwdnG79d rFc0VNsueTDTtXnli82yWOj+GfXeFiz9f3+aMS/8iGf7ZXFXrhWGDj3Taxt7V9Vu96jz5eAA==
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

On Tue, 09 May 2023 12:56:46 -0400, Kent Overstreet wrote:
> in preparation for switching the VFS inode cache over the hlist_bl
> lists, we nee dto be able to fake a list node that looks like it is
> hased for correct operation of filesystems that don't directly use
> the VFS indoe cache.
> 
> 

This is interesting completely independent of bcachefs so we should give
it some testing.

---

Applied to the vfs.unstable.inode-hash branch of the vfs/vfs.git tree.
Patches in the vfs.unstable.inode-hash branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.unstable.inode-hash

[21/32] hlist-bl: add hlist_bl_fake()
        https://git.kernel.org/vfs/vfs/c/0ef99590b01f
