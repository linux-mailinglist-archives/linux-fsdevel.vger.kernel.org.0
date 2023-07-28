Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8ABE767062
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 17:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbjG1PVe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 11:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjG1PVd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:21:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AFF30FC;
        Fri, 28 Jul 2023 08:21:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D72362179;
        Fri, 28 Jul 2023 15:21:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 594CDC433C7;
        Fri, 28 Jul 2023 15:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690557691;
        bh=+vGD95FiuFK2Y6X382FKhaAh/WRxIeJtQkOfitTGD/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mFAoUMg5jgsMix2IIbMPp0qO4w8P3uoiq6qizkBBtrCcaWQD6znG8UcjXchymD8Gc
         sxMxl85UDOV4h3bC6CcEPrK27zWAJKThw362pMKRIIY0z6o/Ag4/fDMHIP1rh/PfIE
         3wURTOEtMbUPbTm3k/pr67T1d1+L4a9DR3DL71tehtXk3NFR0q67kk4zmF9UH7/kBO
         bu3hgraw2dq4RYCzBLzC+1HKRszbIzYIoE7Gx1tBr4l0o0C5rOBmWW0ZcCy4XOhPh+
         5Zu/2eqPh++5uOvwJ+0zb/I0k5UVwnt1MDdTLKIOcx7Gx3Mv7TNIKueouq4liIuRFp
         9HrtwZfDej5rA==
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs: compare truncated timestamps in current_mgtime
Date:   Fri, 28 Jul 2023 17:21:17 +0200
Message-Id: <20230728-insel-zukauf-e3da5defe5a2@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230728-mgctime-v1-1-5b0ddc5df08e@kernel.org>
References: <20230728-mgctime-v1-1-5b0ddc5df08e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1213; i=brauner@kernel.org; h=from:subject:message-id; bh=+vGD95FiuFK2Y6X382FKhaAh/WRxIeJtQkOfitTGD/g=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQcvvNy28Ya93VB55pzOL31bNcUCOoXfThnmO++peSYcISB ynXRjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkc2Mnwh+M4x+KnSmaHst8Ebjp88W J79WMr+aq7kiYhPw7kdodrZzAy3OS09f2io1FkbqSSM7VDhNGt4PUvrak/CiwlN1XaJQSzAgA=
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

On Fri, 28 Jul 2023 09:21:37 -0400, Jeff Layton wrote:
> current_mgtime compares the ctime (which has already been truncated) to
> the value from ktime_get_coarse_real_ts64 (which has not). All of the
> existing filesystems that enable mgtime have 1ns granularity, so this is
> not a problem today, but it is more correct to compare truncated
> timestamps instead.
> 
> Do the truncate earlier, so we're comparing like things.
> 
> [...]

Applied to the vfs.ctime branch of the vfs/vfs.git tree.
Patches in the vfs.ctime branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.ctime

[1/1] fs: compare truncated timestamps in current_mgtime
      https://git.kernel.org/vfs/vfs/c/dec705a2d44a
