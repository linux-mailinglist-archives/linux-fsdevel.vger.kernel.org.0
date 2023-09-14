Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A8579FE95
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 10:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjINIjw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 04:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjINIjw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 04:39:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB761BFC;
        Thu, 14 Sep 2023 01:39:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6852C433C8;
        Thu, 14 Sep 2023 08:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694680787;
        bh=ErdQXXYaeVBX6KtsxtBdnX85rtohjDZ0IEg5DDNK3C4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=upfKxjOeWkG/U/pT5EOvCVrvnh+AXChGutV9oXszGOOzSfMupYGZ0nDoyB1Fj9HfQ
         WDQPGToPYrinncUFqwqbEc3AdPViehNG9MZ27oqyH5Bc2GSflGjAedexK7v88KfGtX
         8crR9YqYvHr4sUME5C17JiONj1ga0s+XUf2ndY03m4uWPHIelvtMU6+nTpz57hMiMD
         c8DESAHxo3W50Ks2qFCrcJmX5Iqe1tygZmJITaa9e/Zx2z2NLiZYNyOW4iqGXzHXI2
         AoTBubApbz4CowunHbS1vx+aiukAxbFgiNDYRLDnDhqIpN20Rx11sLk/hBUT7HAKTs
         XnC24Sr+7ILRA==
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH] overlayfs: set ctime when setting mtime and atime
Date:   Thu, 14 Sep 2023 10:39:23 +0200
Message-Id: <20230914-hautarzt-bangen-f9ed9a2a3152@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230913-ctime-v1-1-c6bc509cbc27@kernel.org>
References: <20230913-ctime-v1-1-c6bc509cbc27@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1316; i=brauner@kernel.org; h=from:subject:message-id; bh=ErdQXXYaeVBX6KtsxtBdnX85rtohjDZ0IEg5DDNK3C4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQyHdtSImJc2tKv9cpCOsFHU3273pZbzWu2MjiXNLFJP+xv z1zVUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJE+U0aGNdNud4avZYxeeuYCY3NH5D pO8YsH51tWf5v2JfuVje+haoa/gq4LYzjmv7r7bY+t9eTsjJyzcQKTepICY1LObl4VGtzIBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 13 Sep 2023 09:33:12 -0400, Jeff Layton wrote:
> Nathan reported that he was seeing the new warning in
> setattr_copy_mgtime pop when starting podman containers. Overlayfs is
> trying to set the atime and mtime via notify_change without also
> setting the ctime.
> 
> POSIX states that when the atime and mtime are updated via utimes() that
> we must also update the ctime to the current time. The situation with
> overlayfs copy-up is analogies, so add ATTR_CTIME to the bitmask.
> notify_change will fill in the value.
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

[1/1] overlayfs: set ctime when setting mtime and atime
      https://git.kernel.org/vfs/vfs/c/f8edd3368615
