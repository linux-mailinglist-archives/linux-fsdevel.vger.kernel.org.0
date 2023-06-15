Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86B7731C18
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 17:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344648AbjFOPB6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 11:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343645AbjFOPBo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 11:01:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AD71FE2
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jun 2023 08:01:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8635622D1
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jun 2023 15:01:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDDD2C433C8;
        Thu, 15 Jun 2023 15:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686841302;
        bh=rXTpC6VRpFOsVNUQwVqdRTh+kDSPbuNX8/ZeyrRbkBc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f8nWoze/BhK57qShg7iDoO6cVoNsaKNX4r/qK5rVqGIn4muEKqS3csnF3wNKILsRn
         urVOpUCaekFW5f5mmPsBA93sfCWHza0Z7w7AOtfLSGDqUjYL9Z7ZMzLPBIuPdac6Wi
         aZ5rtekgd8A/nwewn/Xp1XELajfspacfsBrE74tJnSVKYpCwJ0bEpUofjF33x0Kl51
         5J+NxhWWIrfKfSPXYJ12ACt8pTIi6my1OF9vxkEA72K7sR4SOR4+0grTRGlA0q9YiV
         0HFraeIISjIZxKkJ9w54iVeXiUyAjI0exr5yxFE9h+6KBf72NmrowFZEHQs8qsCFWk
         3+ySEFQO1pyRw==
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Ted Tso <tytso@mit.edu>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] fs: Protect reconfiguration of sb read-write from racing writes
Date:   Thu, 15 Jun 2023 17:01:22 +0200
Message-Id: <20230615-drehen-pigmente-60396afc2fb2@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230615113848.8439-1-jack@suse.cz>
References: <20230615113848.8439-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1701; i=brauner@kernel.org; h=from:subject:message-id; bh=rXTpC6VRpFOsVNUQwVqdRTh+kDSPbuNX8/ZeyrRbkBc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR0q2+VdixS8P/aJLbk0JSw70uiphzYFlO/b0/u7fIT8er+ Tu2PO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYSvIOR4eRPRrn1ixpVnri8tOae/K phxtXjU6qS9y+/xFbDb6P1pYiRYcmTmh41hkhOuXYeeTe+Bx7ie11dd1+rTtM03Rsce0SUGQA=
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

On Thu, 15 Jun 2023 13:38:48 +0200, Jan Kara wrote:
> The reconfigure / remount code takes a lot of effort to protect
> filesystem's reconfiguration code from racing writes on remounting
> read-only. However during remounting read-only filesystem to read-write
> mode userspace writes can start immediately once we clear SB_RDONLY
> flag. This is inconvenient for example for ext4 because we need to do
> some writes to the filesystem (such as preparation of quota files)
> before we can take userspace writes so we are clearing SB_RDONLY flag
> before we are fully ready to accept userpace writes and syzbot has found
> a way to exploit this [1]. Also as far as I'm reading the code
> the filesystem remount code was protected from racing writes in the
> legacy mount path by the mount's MNT_READONLY flag so this is relatively
> new problem. It is actually fairly easy to protect remount read-write
> from racing writes using sb->s_readonly_remount flag so let's just do
> that instead of having to workaround these races in the filesystem code.
> 
> [...]

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] fs: Protect reconfiguration of sb read-write from racing writes
      https://git.kernel.org/vfs/vfs/c/496de0b41695
