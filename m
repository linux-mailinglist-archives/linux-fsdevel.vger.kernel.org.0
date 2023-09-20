Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971BF7A764C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 10:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbjITIuZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 04:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233862AbjITIuV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:50:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7001F11C;
        Wed, 20 Sep 2023 01:50:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 474F1C433C8;
        Wed, 20 Sep 2023 08:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695199813;
        bh=a6Cx13G+BAFAsuWIX1Bm+h0K8xfI+SeQ91FEMjJ9938=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F4rg5xyP5CGfk7RuM6cKFbv8FMxQJ+oqXSiOiTonnGcKus/CasmfVPujhgXzjzo9O
         BEpWtXi845D+xFrTnIcEmhEjDHUb7wqmZT1Rng2XDoHlBFq/LiN6SUavyvCeG7KBs5
         lYgpm9oy5xDHjxX59Jfe2zSOtMTP4sSJYxg23Hx8H8+Xh+3D03/2l/bqzWHuV7WNOP
         3YqnfOpo8NBOX5Sca+pU1sQ3PuGf3ke8KXvUhbLC/EJtRyyEnW2zz7xz1L+n2LTwsK
         ZN3NJxc+JtS1qxBSCwbqLhMRumJzsDeAnVagU5N0EWO4F2sUELfq08Q8zZmJWMGmlg
         Ch9T9ofUvZTdg==
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs: add bounds checking when updating ctime
Date:   Wed, 20 Sep 2023 10:49:52 +0200
Message-Id: <20230920-kauffreudig-getarnt-7d40f13f7830@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230919-ctime-v1-1-97b3da92f504@kernel.org>
References: <20230919-ctime-v1-1-97b3da92f504@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1143; i=brauner@kernel.org; h=from:subject:message-id; bh=a6Cx13G+BAFAsuWIX1Bm+h0K8xfI+SeQ91FEMjJ9938=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRybbxu+kE7OvjAr5ilLywb1VTj1UNjrfm4s5Wiv4Y0CC6R U33eUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJFF0Qx/RfqLP01qW+Ypentawaq8zd 2m5zd3/DN56cS44Jdy9bOVmxgZ1m249/Zo0PFnYUskPx7/f0TsYMm9RtElCXcyWd9Yz7B35wAA
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

On Tue, 19 Sep 2023 13:35:11 -0400, Jeff Layton wrote:
> During some discussion around another patch, Linus pointed out that
> we don't want to skip updating the ctime unless the current coarse
> time is in a reasonable range.
> 
> When updating the ctime on a multigrain filesystem, only keep the
> current ctime if the coarse time is less than 2 jiffies earlier.
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

[1/1] fs: add bounds checking when updating ctime
      https://git.kernel.org/vfs/vfs/c/0445adc637bc
