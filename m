Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045DB595965
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 13:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235276AbiHPLFT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 07:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiHPLEr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:04:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1678B9BD;
        Tue, 16 Aug 2022 03:30:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E95A60693;
        Tue, 16 Aug 2022 10:30:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D473C433C1;
        Tue, 16 Aug 2022 10:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660645845;
        bh=blPhcC0pgTkrB9jGvICGYlhhM6GmXD3Tvwm3zPr4qZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sh2vymdjBrlgaS4VfqRxqiifkmcyk9X5K1mM4jSnUka9oNnYgQUrp+kxxyJfn5SsU
         uB8oKiKdAHK4nfaNfuJWVEfU8JyUqG/eqsJtNhrc3psL/VdmOFaKR7BqMa6nSJbwdD
         TPktetHrsDRvXwHPBGyx9f3OsSwfg3WmhpjcoWo8Pxo5PfXdG13dWgHzsmsehpdcU5
         VOCnLr8nG/kiVVr28LYYAACPEIu1J8kMbWvhYc/7rmnUEdTcreXo17fOXDu7mfLcmR
         chFJ9Gp//keE0kbaCM03wsIpENJach1Xv6kvMJhegVEpn/uyDUvr4viOXRyUNiG6eI
         DKSnblbj+NljA==
Date:   Tue, 16 Aug 2022 12:30:40 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Su Yue <glass@fydeos.io>
Cc:     linux-fsdevel@vger.kernel.org, fstests@vger.kernel.org,
        l@damenly.su, Seth Forshee <sforshee@digitalocean.com>
Subject: Re: [PATCH] attr: validate kuid first in chown_common
Message-ID: <20220816103040.gtgg2w75tzpejas5@wittgenstein>
References: <20220816092538.84252-1-glass@fydeos.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220816092538.84252-1-glass@fydeos.io>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 16, 2022 at 05:25:38PM +0800, Su Yue wrote:
> Since the commit b27c82e12965 ("attr: port attribute changes to new
> types"), chown_common stores vfs{g,u}id which converted from kuid into
> iattr::vfs{g,u}id without check of the corresponding fs mapping ids.
> 
> When fchownat(2) is called with unmapped {g,u}id, now chown_common
> fails later by vfsuid_has_fsmapping in notify_change. Then it returns
> EOVERFLOW instead of EINVAL to the caller.
> 
> Fix it by validating k{u,g}id whether has valid fs mapping ids in
> chown_common so it can return EINVAL early and make fchownat(2)
> behave consistently.
> 
> This commit fixes fstests/generic/656.
> 
> Cc: Christian Brauner (Microsoft) <brauner@kernel.org>
> Cc: Seth Forshee <sforshee@digitalocean.com>
> Fixes: b27c82e12965 ("attr: port attribute changes to new types")
> Signed-off-by: Su Yue <glass@fydeos.io>
> ---

Thanks for the patch, Su!

I'm aware of this change in behavior and it is intentional. The
regression risk outside of fstests is very low. So I would prefer if we
fix the test in fstests first to check for EINVAL or EOVERFLOW.

The reason is that reporting EOVERFLOW for this case is the correct
behavior imho:

- EINVAL should only be reported because the target {g,u}id_t has no
  mapping in the caller's idmapping, i.e. doesn't yield a valid k{g,u}id_t.
- EOVERFLOW should be reported because the target k{g,u}id_t doesn't
  have a mapping in the filesystem idmapping or mount idmapping. IOW,
  the filesystem cannot represent the intended value. The mount's
  idmapping is on a par with the filesystem idmapping and thus a failure
  to represent a vfs{g,u}id_t in the filesystem should yield EOVERFLOW.

Would you care to send something like the following:

diff --git a/src/vfs/idmapped-mounts.c b/src/vfs/idmapped-mounts.c
index 63297d5f..ee41110f 100644
--- a/src/vfs/idmapped-mounts.c
+++ b/src/vfs/idmapped-mounts.c
@@ -7367,7 +7367,7 @@ static int setattr_fix_968219708108(const struct vfstest_info *info)
                 */
                if (!fchownat(open_tree_fd, FILE1, 0, 0, AT_SYMLINK_NOFOLLOW))
                        die("failure: change ownership");
-               if (errno != EINVAL)
+               if (errno != EINVAL && errno != EOVERFLOW)
                        die("failure: errno");

                /*
@@ -7457,7 +7457,7 @@ static int setattr_fix_968219708108(const struct vfstest_info *info)
                 */
                if (!fchownat(open_tree_fd, FILE1, 0, 0, AT_SYMLINK_NOFOLLOW))
                        die("failure: change ownership");
-               if (errno != EINVAL)
+               if (errno != EINVAL && errno != EOVERFLOW)
                        die("failure: errno");

                /*

to fstests upstream?
