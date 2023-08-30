Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC18678DAAC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236925AbjH3Sgw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244042AbjH3MTq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 08:19:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F14CC5
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 05:19:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E82D6264E
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 12:19:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35276C433C7;
        Wed, 30 Aug 2023 12:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693397983;
        bh=0ZJakMDxCfcw2QZ9pOt6kXe0KlVTEjDGHCfwEPNgDRM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uc9Vso8xRKGBDD1JsnyeAauloHfTi+eHmouQXVWP8RurJW43pBA5sfSP7qwsUQdhz
         tEUQZRkFZ7FMVw/cCZ7ykArxQXJ222UxNMz092/r54633OMkc+GMSKCrSYNtr4lKPl
         F3bffAGjAXBEaeMKLOLagNAkoKZxquanpGgto3CMW0sEhkezXps9F+smCl4ahQR1X7
         QWa88BZ5T2UKCfAbf5fbWGbIeCmGpjhJz6pBOHzckWZxi2S2DzYlRennf/kEjAx5dM
         BFOdEtpfp4MiqlnXtVstAu9QcYqtDb7kXirCtX02jx5koVHnegmPIAGA8WUyuaGXhI
         YUSqkLyOMlKfw==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Richard Weinberger <richard@nod.at>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2] mtd: switch to keying by dev_t
Date:   Wed, 30 Aug 2023 14:19:26 +0200
Message-Id: <20230830-vorabend-tanzsaal-690a955d976b@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829-vfs-super-mtd-v1-0-fecb572e5df3@kernel.org>
References: <20230829-vfs-super-mtd-v1-0-fecb572e5df3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1313; i=brauner@kernel.org; h=from:subject:message-id; bh=0ZJakMDxCfcw2QZ9pOt6kXe0KlVTEjDGHCfwEPNgDRM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS8N17XP8c4Ia/6llXepwVKKyLWZn3ft8KhxHmuprdc7aGY 4katjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIncbmVkuHHo2XGB6D8BCU/CU1XSrh ztXv29TGCF2aspha3uop2LdBgZOm101kpluTNtdm7beMD80AGlM2reP5aahHvrXuuxuM7BCQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 29 Aug 2023 17:23:55 +0200, Christian Brauner wrote:
> Hey,
> 
> For this cycle Jan, Christoph, and myself switched the generic super
> code to key superblocks for block devices by device number (sb->s_dev)
> instead of block device pointers (sb->s_bdev).
> 
> Not just does this allow us to defer opening block devices after we
> allocated a superblock it also allows us to move closing block devices
> to a later point to avoid various deadlocks.
> 
> [...]

Applied to the vfs.super branch of the vfs/vfs.git tree.
Patches in the vfs.super branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.super

[1/2] fs: export sget_dev()
      https://git.kernel.org/vfs/vfs/c/9c4d12957d16
[2/2] mtd: key superblock by device number
      https://git.kernel.org/vfs/vfs/c/ff7c9910eaad
