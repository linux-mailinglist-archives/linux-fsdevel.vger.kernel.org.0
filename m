Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E48F78E77A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 09:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244303AbjHaH7T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 03:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241346AbjHaH7T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 03:59:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5DF1A4;
        Thu, 31 Aug 2023 00:59:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E460362B3B;
        Thu, 31 Aug 2023 07:59:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5DFBC433C8;
        Thu, 31 Aug 2023 07:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693468755;
        bh=1IDargtq6F+yIc84SteCGwgylhMk1XwO1s/IaQI5xmY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gT5POzm8IpA/aBwRqaRgfXhzV5u+7f+9x8vGVcp4PF8KxEgaySyFBKLfIRZUXWekw
         1ewxIkIIjVnn3/xN0ZIGIIjpj65f75P+3Vel8WwfGN2UL2KBcQg0m6KjGrLzYN7mfL
         v89OwXNvNxxRxPTTk8Iu7C+1cK2z0Ow6XPZ49c1pB0QXfTkwypZmePHYrsgkSSRJ5M
         IWhsBI7ZIWSJDg8qBqQwd18alxtHl1i85QIIcVMYYjhjxkg9JAAYzMqfD9wDm8Z5vF
         p6nxYOe8HP40JBY/EiL2QAi5uUTOEYofvSXAzVgTphj+8n5JCdYQ+W25i9lAL61Qtg
         tmzbuFu+kHNqg==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christian Brauner <brauner@kernel.org>,
        trond.myklebust@hammerspace.com, anna@kernel.org, jack@suse.cz,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] NFS: switch back to using kill_anon_super
Date:   Thu, 31 Aug 2023 09:59:08 +0200
Message-Id: <20230831-alphabet-exzess-305e114f6597@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831052940.256193-1-hch@lst.de>
References: <20230831052940.256193-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1471; i=brauner@kernel.org; h=from:subject:message-id; bh=1IDargtq6F+yIc84SteCGwgylhMk1XwO1s/IaQI5xmY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR88HDTVnAxPZTV/95vXsWJ4IVa4keuK7zXm9Vo77z5iWhg 8eN1HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABN50MbIcGXJjAOrazqmf1BLf5f0fc t+G4ZONu6/jbsnZ4Rf8T7f38nI8CDfRS2s4V7zl0/i+qxttYE2jeoqFRW3ZReYBPHk6cfwAgA=
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

On Thu, 31 Aug 2023 07:29:40 +0200, Christoph Hellwig wrote:
> NFS switch to open coding kill_anon_super in 7b14a213890a
> ("nfs: don't call bdi_unregister") to avoid the extra bdi_unregister
> call.  At that point bdi_destroy was called in nfs_free_server and
> thus it required a later freeing of the anon dev_t.  But since
> 0db10944a76b ("nfs: Convert to separately allocated bdi") the bdi has
> been free implicitly by the sb destruction, so this isn't needed
> anymore.
> 
> [...]

This fix is needed to account for new changes to the generic super code.
So I'll put this into the same set of fixes as the mtd superblock changes.
The plan is to have this all fixed up before -rc1 is out.

---

Applied to the vfs.super branch of the vfs/vfs.git tree.
Patches in the vfs.super branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.super

[1/1] NFS: switch back to using kill_anon_super
      https://git.kernel.org/vfs/vfs/c/db80f8437753
