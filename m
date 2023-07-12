Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F304F750C83
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 17:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbjGLPcp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 11:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbjGLPco (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:32:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D165C2;
        Wed, 12 Jul 2023 08:32:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6DBD6185F;
        Wed, 12 Jul 2023 15:32:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 537FDC433C8;
        Wed, 12 Jul 2023 15:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689175963;
        bh=xfa7h3Klsd00AJ8ejRF/z4YHp1gLDwV0HIcoBg7YmMw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OzVRD1zTuDP9kS+eUuUh3E9d/4rYmhAYAKCJTKjGZi6zuBpWXLJrjO7JCHv63UPAa
         sKC0agJ1z2nkCwga5Lbgynzz8yf2FMpeygqiI8Ozmuy7C6Ppi6iBjpxd7P33cmcSmp
         bJ74G65u11SGIwEY2zGNzBgh1w9GQdDTvQotQg5myCF5P6LYw2iiTXBLTNjlg3pwEd
         3u0f3BMR670eD8xDj/JsYqRP7Zd1VhxioKCeHQ5z+n7/A8+8NNPFYkYDZr6ZjANNrs
         LH65XZU0tOQXy0ttT/AV8qoeGTIy0IkjOG1ZAbemtTe5DHIDtP06YD84YFQIABRpRj
         +25tAvqOj64Lw==
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] ext4: fix decoding of raw_inode timestamps
Date:   Wed, 12 Jul 2023 17:32:37 +0200
Message-Id: <20230712-wohnzimmer-gelaufen-a8d663a1e566@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712150251.163790-1-jlayton@kernel.org>
References: <20230712150251.163790-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1007; i=brauner@kernel.org; h=from:subject:message-id; bh=xfa7h3Klsd00AJ8ejRF/z4YHp1gLDwV0HIcoBg7YmMw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSsO96T4Cy6tJe7+gLHh27HQ3K9XXayZ2WTTR2lJrVY9eRv cF7RUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJElnxkZ9nSJGqRwb1S9dHraBp8LMr WnuyQ/y12zPHp34Z+vyzn2aTIyTMgz8F529NV97nxByT42l5QFLaxSR1Z6Zp2I3R9a8dmFCQA=
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

On Wed, 12 Jul 2023 11:02:49 -0400, Jeff Layton wrote:
> When we covert a timestamp from raw disk format, we need to consider it
> to be signed, as the value may represent a date earlier than 1970. This
> fixes generic/258 on ext4.
> 
> 

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

[1/1 FOLDED] ext4: convert to ctime accessor functions
      https://git.kernel.org/vfs/vfs/c/f65cb009d449
