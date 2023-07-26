Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA2E763149
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 11:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbjGZJKb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 05:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbjGZJJ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:09:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172F8268B;
        Wed, 26 Jul 2023 02:06:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F0F6618E2;
        Wed, 26 Jul 2023 09:06:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED81C433C7;
        Wed, 26 Jul 2023 09:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690362375;
        bh=qw7N0geLh/7O+YFGms6S6G8hXqAkOc3FsrusV/KL+RU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jc11UcNFpdhVQksWMoTAsOXXmz2R8iFHxBeM1ass1vgxLxy8PiLUx5Wwe8wYNmDJU
         uXdPN0nvW5cZrAO7FcvWn5C2tT2STexnw89victYle3r48fiJ1ikQSVr8rMle1x1fq
         rFpcHxultW2BggkYhCDhOFosX70I6o1nVer6OMx1ExUKJ2fgYlLvGHkH9zbZgORfmU
         +mPBq1emQtssbj9SH3B5omuuDpxqz7GhINsikLFQ9+G48iQxnoW8ufHYX/SFwbKfHV
         epo/EIupW6SxDiIW4+21cHB26JO4S2i75lZtNa1bVodD+1o3ctQ8IajZh4V2/1iRwW
         DyNSfFJl6/uwQ==
From:   Christian Brauner <brauner@kernel.org>
To:     thunder.leizhen@huaweicloud.com
Cc:     Christian Brauner <brauner@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] epoll: simplify ep_alloc()
Date:   Wed, 26 Jul 2023 11:06:06 +0200
Message-Id: <20230726-achthundert-angehalten-62077a7fdbab@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726032135.933-1-thunder.leizhen@huaweicloud.com>
References: <20230726032135.933-1-thunder.leizhen@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=925; i=brauner@kernel.org; h=from:subject:message-id; bh=qw7N0geLh/7O+YFGms6S6G8hXqAkOc3FsrusV/KL+RU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQcePi708B/3VWXuQqrDf4+mm5gn3G2pcL03O/XTjcZ1/4M /bassqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiQRcYGdbO+X9qQfzdIw/KTRtYxH v9vyjwLHL3f61wJVhN7ubOfm1Ghue32ASfVzz5U9zDc+JsqWRsy/aHyh9DCkzcXfM2e7A0cwEA
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

On Wed, 26 Jul 2023 11:21:35 +0800, thunder.leizhen@huaweicloud.com wrote:
> The get_current_user() does not fail, and moving it after kzalloc() can
> simplify the code a bit.
> 
> 

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

[1/1] epoll: simplify ep_alloc()
      https://git.kernel.org/vfs/vfs/c/3f3ecbd73071
