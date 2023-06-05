Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49947226B3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 14:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbjFEM7Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 08:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbjFEM7U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 08:59:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB0EDF;
        Mon,  5 Jun 2023 05:58:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86FA56125F;
        Mon,  5 Jun 2023 12:58:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F661C433D2;
        Mon,  5 Jun 2023 12:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685969935;
        bh=e+/NPwB2cmtfwaz0YKxkffDVpHR8DXa9brk/DDgZvRQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lLOLWISW9hmy6QVf/WV8uFCGPjEHUSxX7Dby9AT4hfQfErjCD1+Z8WZhnwv4psKZq
         IwbDC23gEG/gqTdtrwPq0KgbOiX6htT2AVEB3SkVn4/zN04hb15t2UUwEdokTTErb2
         Li/aPO4PRr8l2Fl4xV9ZgycB3jlFbaNYBTt3/K/26Uoocg+Lm/JT/ljNjw5qjRYhaI
         OJXOKZX3XQfk6VIRYKjH0LrlqO+UpIdtmU7ALI14iLw9k7qviVETjWpQv975hATTQ3
         fyPeaH4GevsPryYk3pVbp2ksBbq+C9pUo9FQKbyagVJL8cXrXa6I4O1gWkeUyWDuj1
         sFMexLUjGo81A==
From:   Christian Brauner <brauner@kernel.org>
To:     chenzhiyin <zhiyin.chen@intel.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        nanhai.zou@intel.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] fs.h: Optimize file struct to prevent false sharing
Date:   Mon,  5 Jun 2023 14:58:39 +0200
Message-Id: <20230605-polterabend-weggehen-44570d4b7429@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230601092400.27162-1-zhiyin.chen@intel.com>
References: <20230531-wahlkabine-unantastbar-9f73a13262c0@brauner> <20230601092400.27162-1-zhiyin.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1529; i=brauner@kernel.org; h=from:subject:message-id; bh=e+/NPwB2cmtfwaz0YKxkffDVpHR8DXa9brk/DDgZvRQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTU3v4gHbP/yZsVZ5cXLPg5K9VgLacEQ9icXqH9iyY0Ba98 MD3FpKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi73oZ/md+P3p58bYp9ofefFHmWP v4Fsst3kVaf8IUl+3Ws5WzWTSNkeFAx/8+XR3Px+YdStMlpQKDZx25417y4f5d58+BQc18LFwA
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

On Thu, 01 Jun 2023 05:24:00 -0400, chenzhiyin wrote:
> In the syscall test of UnixBench, performance regression occurred due
> to false sharing.
> 
> The lock and atomic members, including file::f_lock, file::f_count and
> file::f_pos_lock are highly contended and frequently updated in the
> high-concurrency test scenarios. perf c2c indentified one affected
> read access, file::f_op.
> To prevent false sharing, the layout of file struct is changed as
> following
> (A) f_lock, f_count and f_pos_lock are put together to share the same
> cache line.
> (B) The read mostly members, including f_path, f_inode, f_op are put
> into a separate cache line.
> (C) f_mode is put together with f_count, since they are used frequently
>  at the same time.
> Due to '__randomize_layout' attribute of file struct, the updated layout
> only can be effective when CONFIG_RANDSTRUCT_NONE is 'y'.
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

[1/1] fs.h: Optimize file struct to prevent false sharing
      https://git.kernel.org/vfs/vfs/c/b63bfcf3c65d
