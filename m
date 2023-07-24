Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749C275EDAB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 10:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjGXIce (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 04:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjGXIc3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:32:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5679E53;
        Mon, 24 Jul 2023 01:32:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CA4960FD0;
        Mon, 24 Jul 2023 08:32:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A767C433C8;
        Mon, 24 Jul 2023 08:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690187542;
        bh=egWt7y4jgZ8tHSuRoj/Tqwj5nCUPzHwsGsF525qhG5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hs26hFg3PZTNQ/UhFJ7AIcPLJpg7U4Ip4h0b9RFu7EowaM7ByozzIoGNVg+sXHsIT
         kd1iX7HzHittxIIirNwUuBWiiq1aI0VzHLlwewc1Nhd+kOh4by8EezRULIi3iRG0p3
         S6VnYDL3CrR7A1jMypv/yh2xa2+/VszxK0oWtaN+yv0s67+rRjlFbIix2dSYJaLTz/
         RlAX5umNuyyg728K8M0yC9ePs6O2B7kD37BQanVOiwtHgw3GMEBoiec+3/2n5ykdMY
         JWeIk6qLevjIZTG1/r4JBtF9phj5889AbI+zljzlh1z3lfxFmtbjl5NzjHHfCtBnxH
         I/MUKtl4xVznQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2] ext4: fix the time handling macros when ext4 is using small inodes
Date:   Mon, 24 Jul 2023 10:32:13 +0200
Message-Id: <20230724-vorgreifen-fernbedienung-c4f71dc6e01e@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230719-ctime-v2-1-869825696d6d@kernel.org>
References: <20230719-ctime-v2-1-869825696d6d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1278; i=brauner@kernel.org; h=from:subject:message-id; bh=egWt7y4jgZ8tHSuRoj/Tqwj5nCUPzHwsGsF525qhG5M=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTsM2dMF/ETVwj5M0Gkb7FZeO397ll7hL+ni8UIx9Xf5nk3 K35WRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESc9RkZ+h++yNb8ucu5ccvhGSInwz d8Fo0V+18dcCWHzZ5zTvgyVYZ/hp430+a5/Pp9Pnwqhzvv+kOphbFbt0n6mjadcf7RdS2SGwA=
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

On Wed, 19 Jul 2023 06:32:19 -0400, Jeff Layton wrote:
> If ext4 is using small on-disk inodes, then it may not be able to store
> fine grained timestamps. It also can't store the i_crtime at all in that
> case since that fully lives in the extended part of the inode.
> 
> 979492850abd got the EXT4_EINODE_{GET,SET}_XTIME macros wrong, and would
> still store the tv_sec field of the i_crtime into the raw_inode, even
> when they were small, corrupting adjacent memory.
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

[1/1 FOLD] ext4: fix the time handling macros when ext4 is using small inodes
      https://git.kernel.org/vfs/vfs/c/1311011c2bb7
