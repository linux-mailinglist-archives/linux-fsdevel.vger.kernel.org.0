Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E6E7194DE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 09:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjFAH70 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 03:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbjFAH7J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 03:59:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0499E10E6;
        Thu,  1 Jun 2023 00:56:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8755F63A53;
        Thu,  1 Jun 2023 07:56:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1564AC433EF;
        Thu,  1 Jun 2023 07:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685606186;
        bh=zy6FD3ieq9VzpaczjqQeq4turLjMaDfUirLGdrUvrRQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hzrpdr+vftwHjZujbikxA7vGJd48YfbEE7beZiaLvSofMfOTfdYZxvoLnJnl5fSLI
         LS/gbTJ28xOK0yBM2aTT0CsdWZuW7J8AjXMMAzOUNmUFZUQFFbOyz8qFtBggIxYAtH
         xusfTFvu5Qs3P8J7CpoIrMLI1HAWQGgOafA93PyV6/+pfMjn0M9mpubH/ZrcGNnTd1
         b47x/Mj+emASiuhI45Nog1aPycW4wbvZmrGr03UZ+I+0PpIjBl66aau6c8x6vvJ4Us
         R4rCj5U0UmY89xiSt6D1lLKn8t+f9+qeWOgllP4EJSqR7zbB6/Tpau6TZtByfStvyo
         N8CO/qbQ4NOZw==
From:   Christian Brauner <brauner@kernel.org>
To:     Prince Kumar Maurya <princekumarmaurya06@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzkaller-bugs@googlegroups.com, linux-fsdevel@vger.kernel.org,
        syzbot+aad58150cbc64ba41bdc@syzkaller.appspotmail.com,
        skhan@linuxfoundation.org, dchinner@redhat.com,
        viro@zeniv.linux.org.uk, chenzhongjin@huawei.com
Subject: Re: [PATCH v4] fs/sysv: Null check to prevent null-ptr-deref bug
Date:   Thu,  1 Jun 2023 09:55:45 +0200
Message-Id: <20230601-puder-unbekannt-9d74525f40d7@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230528184422.596947-1-princekumarmaurya06@gmail.com>
References: <000000000000cafb9305fc4fe588@google.com> <20230531013141.19487-1-princekumarmaurya06@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=795; i=brauner@kernel.org; h=from:subject:message-id; bh=zy6FD3ieq9VzpaczjqQeq4turLjMaDfUirLGdrUvrRQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRU+L11uWbFsP+T8uqmzbkBs2fWmWxNcp59hCXr6RrLrvz2 +Ul5HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOZGszIsKSrrMWh/MryuA8rfOpX9J ZFd1zdLXxIQGVmW7IqzwKJZkaG9+8z7yZrmzalXNuRFrho2lv59cvsV/NxKGSXCEi4FJ7lBQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 28 May 2023 11:44:22 -0700, Prince Kumar Maurya wrote:
> sb_getblk(inode->i_sb, parent) return a null ptr and taking lock on
> that leads to the null-ptr-deref bug.
> 
> 

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] fs/sysv: Null check to prevent null-ptr-deref bug
      https://git.kernel.org/vfs/vfs/c/47f9da4bc5e6
