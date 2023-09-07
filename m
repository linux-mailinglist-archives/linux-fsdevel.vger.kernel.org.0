Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B6D797AD8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 19:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237042AbjIGRxC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 13:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjIGRxC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:53:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CED31700;
        Thu,  7 Sep 2023 10:52:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E06C433D9;
        Thu,  7 Sep 2023 16:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694104439;
        bh=Tl7vhegXVwuJ4ZvlyXuRvL1PMLNp1QhwYV2qByndv0M=;
        h=From:Subject:Date:To:Cc:From;
        b=LyHzwRhW/1WH8vGEjolJBeAxo+0fnV54+EKtfS7fbcWru4PkPuic4KaNfEqOOHvo+
         UMf9YAvH1RllPXOjbZQpYuzNI552aIcmiGGsyD8x0cLUoEMwXraz9kjmbfcXMD0FZl
         rKQicb7RlhznhMKqRQk3EoeMGsMl2HjASoF5GK2jGgJty2REhwxmPUncErJlNNmkfm
         VMeGlQ9454qnCCGZT9OjQtNLvTsdkPv2FxYlAXK7bemuYZ4y8MKegFMNYT9ort1H+p
         zSVEGZNmls9dWhxLa7BsgCQbrbT/1P+swRvoUI1DPE88hQJf7SXsdLd6lfx/HVvXdR
         CwHMSmyn+ArXg==
From:   Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 0/2] fs: fixes for multigrain ctime code
Date:   Thu, 07 Sep 2023 12:33:46 -0400
Message-Id: <20230907-ctime-fixes-v1-0-3b74c970d934@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGr7+WQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDSwNz3eSSzNxU3bTMitRi3dRkM2NDy+REA8OkVCWgjoKiVLAEUEN0bG0
 tAB/Kz5VdAAAA
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        kernel test robot <oliver.sang@intel.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1116; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Tl7vhegXVwuJ4ZvlyXuRvL1PMLNp1QhwYV2qByndv0M=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBk+ft2JmbTYxfi47ZsnUhmwPG2XIyZJofSPLphP
 9TqCH5nSyCJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZPn7dgAKCRAADmhBGVaC
 FVFfD/9dO1oz+QsPO5nQ9QVPnj3TUFlSi/iws7NHnnTbVApK4PtoR0eDkE4oTZsXh6LXeNvky++
 GxDGDgBDF7Q6pY6+zvH4juGZ2ovrZcgruV0PcqgbJ2+ktLIsxHeFnSWyU1qLjrIQGyJXnXlPVB9
 W8861z/XlNUNTJaLiNawfKts7Td414e7psyj+SrZDi5Om5HvCz+smue7KUiwXwwYaRd5OGv3ikp
 gb7pdoY4yIwlIJi0h2PlaEjWEYoaZpXwVATrg4Uykr3/5S3sVOi7ddeLPzLSFisaLj2XxU1gwTI
 HVUQaLk9EP1hS+FOsv09z0tz2qNp4aFLrBCf/dZvZFwcfQRwWxyl9FjWivJJHj711rRzHW2EsuW
 4DQv6nT+WPrJkpTZot2DVetRN6yQpHS9mqNBLzOwkRoP00wCvmVPKy2ZVfnk3miCR51MbiWycPe
 QbwdQdfEaK1SH6gG3iC1x63Od4g+SCC2hgznD6DpE4iqT98C4zlLAg3TQvBlGfxT232+ikl4Ps+
 TYkJ6a5kSi10qPt9j4QBKa5AEd6iYtxVGtnvlosOqOBQWv+cBGa1vkM/f/PqPrBGho9xzci5ksS
 gILN0yMLurzYelhEpDVw+CP9Hiy083RmP6JzkSLSC0XK8wDAcIZmTYEATPmfZntc2q3CVjeo8pd
 ZWI7SNFEWgAvIww==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The kernel test robot noted some test failures with the LTP mount03 test
on tmpfs. From the test output, it looked like the atime had gone
backward.

One way this could happen would be for tmpfs to get a new inode from the
slab that had a ctime that appeared to be in the future.
inode_update_ctime_current would just return that time and then the
mtime and atime would be set to the same value. Then later, the atime
gets overwritten by "now" which is still lower than the garbage ctime
value.

I've not been able to reproduce this on my test rig, so I'm not certain
this fixes the problem that was reported. I'm hopeful though, so I've
left the KTR tags in place.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (2):
      fs: initialize inode->__i_ctime to the epoch
      fs: don't update the atime if existing atime is newer than "now"

 fs/inode.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)
---
base-commit: 7ba2090ca64ea1aa435744884124387db1fac70f
change-id: 20230907-ctime-fixes-ec6319ca01be

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>

