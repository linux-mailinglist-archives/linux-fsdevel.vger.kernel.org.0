Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E9B7710E2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Aug 2023 19:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjHERSM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Aug 2023 13:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjHERSL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Aug 2023 13:18:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004F7A2;
        Sat,  5 Aug 2023 10:18:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87F3B60B58;
        Sat,  5 Aug 2023 17:18:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37CD0C433C8;
        Sat,  5 Aug 2023 17:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691255885;
        bh=OXwj6Cooj9Ihg/sm7mrynr9GEszBwcmewtrFn+JYvEA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lbUO+5dNDie2ZigbafEP2076+UnaBSTN9incnnYL4IhzVZSIxrA3ojH4+NhfI7CD6
         3mZjuYkMg3ZyQ/qwmlmWyuWDmlGH7iZQLo9mYl0b5GH3Ketu3lLLiHhEZZhLXTaGa3
         zoYKc04FJ09rLJew451JxhKi0S2xe3aHnmLTva3hh6nGvYZ92MkEBqUOerzqA+vQxk
         9iv67Ru+frwU2Gi2LhMTiQKqbYez9KP82GaEZeh2J9uPywvQUDOXsvESiF9+CbT4S9
         93Va7WOZKOaPO0ZVyGxnzJGQHki6nrKVcWI5b9fVMhPfsOpFJYJabX4WsF7DZ/r/z1
         hnzd2xjOpbLkg==
From:   Christian Brauner <brauner@kernel.org>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] open: make RESOLVE_CACHED correctly test for O_TMPFILE
Date:   Sat,  5 Aug 2023 19:17:54 +0200
Message-Id: <20230805-ignorant-kahlkopf-9749ac3cd20a@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230806-resolve_cached-o_tmpfile-v1-1-7ba16308465e@cyphar.com>
References: <20230806-resolve_cached-o_tmpfile-v1-1-7ba16308465e@cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1070; i=brauner@kernel.org; h=from:subject:message-id; bh=OXwj6Cooj9Ihg/sm7mrynr9GEszBwcmewtrFn+JYvEA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSca7GXmqIzx996ktP0Gl3pK68nJvWG1K8J3XcrsP+22EbL 9h+GHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABM5sJORYar/Xgnn47aGRetCS/dzuH 1ZkXfl0sMXNhmKrbw11Yvm9TP8M64Ndv//1Nv36oE7U12FTE6f9beazfV46/kM1Uc3pbPTuAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 06 Aug 2023 02:11:58 +1000, Aleksa Sarai wrote:
> O_TMPFILE is actually __O_TMPFILE|O_DIRECTORY. This means that the old
> fast-path check for RESOLVE_CACHED would reject all users passing
> O_DIRECTORY with -EAGAIN, when in fact the intended test was to check
> for __O_TMPFILE.
> 
> 

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

[1/1] open: make RESOLVE_CACHED correctly test for O_TMPFILE
      https://git.kernel.org/vfs/vfs/c/7c62794bc37f
