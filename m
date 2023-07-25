Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44788761DB3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 17:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbjGYPxn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jul 2023 11:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjGYPxm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:53:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF18212F
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 08:53:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FE6C617C8
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 15:53:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B554C433C7;
        Tue, 25 Jul 2023 15:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690300416;
        bh=yrA38A3YvfdrQJYbMZLtu+u8CQxlhUeS8fS+SQAd20c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dyxLQgt4ep2azH/brrh4x/vUQPVdKCz0dqnBCVq4soZ71fb+uFdSjFEQTwRSxOkIg
         UUw023ovaPRe5wXC1C7mQ3AiRkuWbbLLHyWy6c3V5xGlztKvFV7lsg0qC3wDlN7lAi
         9+dYZnoaui3L9VUyQO+luiMLf4izBqhK7MyJN7ZrQjumoYECTKUicB5l+KVevvdB6Q
         +NNh6JCvwqVuJvfWEIiILHqkm4trYgNlMPX7lVQQbE0oCRZxLMcH2yjAtp65Rsgb5I
         2H1sTCdls2OB5PZevtAZmgyinUaNiFoSBabICdsxjz2HrW3J8Q9BuTtKF97vb/5a+f
         aV59gjqIzjbUA==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz
Subject: Re: [PATCH] fs: open the block device after allocation the super_block
Date:   Tue, 25 Jul 2023 17:53:25 +0200
Message-Id: <20230725-klebstoff-walzwerk-f9163eb2cdb6@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724175145.201318-1-hch@lst.de>
References: <20230724175145.201318-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1201; i=brauner@kernel.org; h=from:subject:message-id; bh=yrA38A3YvfdrQJYbMZLtu+u8CQxlhUeS8fS+SQAd20c=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTsf/+mvf7O9A8SR9L5jubXark6XHxxm+lCeoPbCrXoWsuw V8FnO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaygp+R4aFK7j9Ztf1ijM9q+lT+rX mqwmE//bCo4hGdBk/nj9ruOxgZVkt8Y5Ri1dM+Z6t77H9u3qwF/r93GEe9OtX/aSO7ktUSdgA=
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

On Mon, 24 Jul 2023 10:51:45 -0700, Christoph Hellwig wrote:
> Currently get_tree_bdev and mount_bdev open the block device before
> commiting to allocating a super block.  This means the block device
> is opened even for bind mounts and other reuses of the super_block.
> 
> That creates problems for restricting the number of writers to a device,
> and also leads to a unusual and not very helpful holder (the fs_type).
> 
> [...]

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] fs: open block device after superblock creation
      https://git.kernel.org/vfs/vfs/c/787388e88395
