Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF43746BC3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 10:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjGDIXJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 04:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjGDIXI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 04:23:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94861AC
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jul 2023 01:23:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AFF661167
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jul 2023 08:23:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAAADC433C8;
        Tue,  4 Jul 2023 08:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688458986;
        bh=wKiibmqF8IKNQe6XFN0V5Jjw8qoZsQ9w/Q2/NFhGlX0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aQEPpn2RXnce8pJYKVbg6kkPNAp7MWhcJYdM+ej8T1UXAz4FCYRpct1tFLMPIH6wZ
         Rbw0cxp3pCQtlSrB4jYQsp9+l7zyrKi3973zhCQ7EWGpXyNyX4nZfn5P5mAC9QDaxt
         1miiGCV11MOUA0pCwtRnc9hb8ZH7VL27XXDFrqlMyNrmwt4S5p9wVt7fIkulz2hOBf
         hJ7WmRigKczkpzIUBa49JBma8cmAVM986eB6KiJEae50UjNztPGJe6vD2SNA09bAI+
         9mx/T7CI5z4gu2i3XeI0NEMVxyHHtSBZcyJkZKaJ3Xi5qmcUWyb27/6lufIb+T5LWS
         RegHcgukgHHgA==
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH 0/2] fs: rename follow-up fixes
Date:   Tue,  4 Jul 2023 10:22:54 +0200
Message-Id: <20230704-gesund-wahlheimat-c915c69e4d93@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230703-vfs-rename-source-v1-0-37eebb29b65b@kernel.org>
References: <20230703-vfs-rename-source-v1-0-37eebb29b65b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1204; i=brauner@kernel.org; h=from:subject:message-id; bh=wKiibmqF8IKNQe6XFN0V5Jjw8qoZsQ9w/Q2/NFhGlX0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQsvnbrgKvu26qvLVdOpDD6Tg/m8Hv95tizCa9zGbNFFctb ljwo6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIbzlGhj0fji8zYZHwMtY2MFcLlf t0jtXwwO7GObnbpNKzWfyXcDH8r5aPMzDkbpvpMdXZs718VZXl9bBfX72K3n29Pv1D4Y2vPAA=
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

On Mon, 03 Jul 2023 16:49:10 +0200, Christian Brauner wrote:
> Jan,
> 
> Two minor fixes for the rename work for this cycle. First one is based
> on a static analysis report from earlier today. The second one is based
> on manual review.
> 
> Thanks!
> Christian
> 
> [...]

I've used your authorship on this, Jan and used my commit message.

---

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/2] fs: no need to check source
      https://git.kernel.org/vfs/vfs/c/66d8fc0539b0
[2/2] fs: don't assume arguments are non-NULL
      https://git.kernel.org/vfs/vfs/c/33ab231f83cc
