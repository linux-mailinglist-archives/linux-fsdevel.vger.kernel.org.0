Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42EB864A445
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Dec 2022 16:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbiLLPho (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Dec 2022 10:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbiLLPhe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Dec 2022 10:37:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79805FAF2;
        Mon, 12 Dec 2022 07:37:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30D85B80D8C;
        Mon, 12 Dec 2022 15:37:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B95C3C433EF;
        Mon, 12 Dec 2022 15:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670859450;
        bh=bQjHMEaKvjiDu5gcF5ghATIIUpXsdMD8g72o/V7Njb0=;
        h=Date:From:To:Cc:Subject:From;
        b=YDsQ85XQB6Mr86XiBFCvmb6vUdAjUkakzRQCA9XfMOXg7a4utz20UPR51SasSNGed
         NwaevPxWWVxwjCL67L36THQvYsa/0yYB+Hix0Q+b8OP03TbAb4zTUynEaHk0kXzRf3
         D0hWY2LFzWYPG1MaDclrZUNNYb30gw5bhvg/UoY8ZlFg1bYRB82UtZ1wnJsMPo4MIT
         FfG3TQJjsLemi4OQhxMmGx7/IVX6/4HBcV9/fid6EB/y7S9yfa2qnydGJHlJxEWk5p
         kFHQ/IG+KiQ3I2Jor6Nngq07xYXYFwOl1GTsoPDo0oVrXEDc1QCnSYBOIAUjdHbUFZ
         i2w8kvxE6+BPg==
Date:   Mon, 12 Dec 2022 09:37:29 -0600
From:   Seth Forshee <sforshee@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] xattr audit fix for v6.2
Message-ID: <Y5dKudhCyAktI/8E@do-x1extreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

/* Summary */
This is a single patch to remove auditing of the
capability check in simple_xattr_list(). This check is done to check
whether trusted xattrs should be included by listxattr(2). SELinux will
normally log a denial when capable() is called and the task's SELinux
context doesn't have the corresponding capability permission allowed,
which can end up spamming the log. Since a failed check here cannot be
used to infer malicious intent, auditing is of no real value, and it
makes sense to stop auditing the capability check.

/* Testing */
The patch is based off of 6.1-rc4 and has been sitting in linux-next. No
build failures or warnings were observed and fstests, selftests, and LTP
show no regressions.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next. A test merge with current mainline also showed no conflicts.

The following changes since commit f0c4d9fc9cc9462659728d168387191387e903cc:

  Linux 6.1-rc4 (2022-11-06 15:07:11 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.xattr.simple.noaudit.v6.2

for you to fetch changes up to e7eda157c4071cd1e69f4b1687b0fbe1ae5e6f46:

  fs: don't audit the capability check in simple_xattr_list() (2022-11-07 16:55:45 +0100)

Please consider pulling these changes from the signed
fs.xattr.simple.noaudit.v6.2.

Thanks!
Seth

----------------------------------------------------------------
fs.xattr.simple.noaudit.v6.2

----------------------------------------------------------------
Ondrej Mosnacek (1):
      fs: don't audit the capability check in simple_xattr_list()

 fs/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
