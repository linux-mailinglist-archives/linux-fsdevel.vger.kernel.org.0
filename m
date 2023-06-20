Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7050C736B65
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 13:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbjFTLuN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 07:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjFTLuM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 07:50:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8B8186
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jun 2023 04:50:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 275CC611EA
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jun 2023 11:50:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C12C433C0;
        Tue, 20 Jun 2023 11:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687261810;
        bh=kSvztI56FO1Zkr5LutuDa30cOInJ3oxsUK1M4aZpHWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rFnNz6eCfm6XV68TdiVMNI+PUp61705rnbUZgFSYr4gLDPPTeCgyrGJUdumqsKW5+
         FPeFlCprXM45d9aWlQemTGN2T6m88sYGMimnQlq/Sj9VDR/eswBVC6UU1SEEdbyCvL
         K35ZfEQYaHVuHbhG/uvlqrXgE2Vnl54jP5jYmuS5H7J5UioiKIaKIH1y5/5BgTtr5r
         33DxJHqJASo4xRxKrZ+aGd2o62DibkxCXeieSHnWe8FFGLi2aHa4dD0Fm8WT0qTd/R
         JqggzDZmVFomwbNShES3/PYDD6KFCSP1SZFTU5kzDMki2uhfa9FjXfB7NueBOhxj0K
         C9m7O3/pIB98Q==
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v3] fs: Provide helpers for manipulating sb->s_readonly_remount
Date:   Tue, 20 Jun 2023 13:49:59 +0200
Message-Id: <20230620-frisieren-zugute-1b1e9486e388@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620112832.5158-1-jack@suse.cz>
References: <20230620112832.5158-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=877; i=brauner@kernel.org; h=from:subject:message-id; bh=JQbOzrYQtOjM2yByK9ejTp/ybXq+2XR1LqTAz197w6Q=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRMnBSqOuulcs9jltMpQdv/HKhmaheKCunyb+PWnK/1d7/r N668jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInkrWT4p/dZKFfsx5mknk8hC4MPFK R222UWJKyNCXeYGD67d660JSPDoZglM35Lm7d/OOz+e/eidM/Xah4m5XsVZSLL16VtfvqNFwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 20 Jun 2023 13:28:32 +0200, Jan Kara wrote:
> Provide helpers to set and clear sb->s_readonly_remount including
> appropriate memory barriers. Also use this opportunity to document what
> the barriers pair with and why they are needed.
> 
> 

Thanks for the updated comments.

---

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] fs: Provide helpers for manipulating sb->s_readonly_remount
      https://git.kernel.org/vfs/vfs/c/67a91f780e98
