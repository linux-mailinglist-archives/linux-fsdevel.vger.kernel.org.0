Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B599766FCE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 16:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237256AbjG1Otj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 10:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237254AbjG1Oth (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 10:49:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052E43A81;
        Fri, 28 Jul 2023 07:49:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96C5D62180;
        Fri, 28 Jul 2023 14:49:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31870C433C8;
        Fri, 28 Jul 2023 14:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690555774;
        bh=Zk7JtkqNjeR9iUr3DQ3eXax1rb6KEOpEedUttEhe6fI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K/LS7DGAzlKwbHSrmWGbI+phRq08imhm6pEYUvIKQFphGACxYBnMIBy0PaNcL1vNT
         quWXTdQa42qXtnxHix5zsOCHEaGiyFhe1iCOAXQFth1YtPpzcV4SmeGyh8c6P4J0ib
         n8QuSGCgngJOZ1DS9Kq8adbk9/DOoM/OnZ2iG6ikIlsQxOWzcPGP6QQsdV+IhRWhDA
         fCjKsJMJceDz2IcVY0Xq9Q5X6QghKtWQzxk3yoE8W4fJBQi0LRp8T7Rva2Gx5axJWC
         kZkg/tSJB2WzWCxvFmgRA3Zw/L7dfDpBPCyKWugJcvt1kEopTpPli9zwtCKe/BpIc8
         SmGjJJP8R+8Ig==
From:   Christian Brauner <brauner@kernel.org>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Alexey Gladkov <legion@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fchmodat2: add support for AT_EMPTY_PATH
Date:   Fri, 28 Jul 2023 16:49:25 +0200
Message-Id: <20230728-ecken-umliegenden-76b55cb82ea5@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230728-fchmodat2-at_empty_path-v1-1-f3add31d3516@cyphar.com>
References: <20230728-fchmodat2-at_empty_path-v1-1-f3add31d3516@cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1271; i=brauner@kernel.org; h=from:subject:message-id; bh=Zk7JtkqNjeR9iUr3DQ3eXax1rb6KEOpEedUttEhe6fI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQcvlp0xyumw47hzjxVdd+90v23XnZcqs/JTdLomKG8pDvn DeurjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImoezIyLHtyfqp5BVNWedJMphKHqJ vGHcaPjzs5SvLP6JncEiQRyMgwuZ+rk2VKytLlB7JmG79plpkkX+8z6b2Rtu7pHUsVZndyAAA=
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

On Fri, 28 Jul 2023 21:58:26 +1000, Aleksa Sarai wrote:
> This allows userspace to avoid going through /proc/self/fd when dealing
> with all types of file descriptors for chmod(), and makes fchmodat2() a
> proper superset of all other chmod syscalls.
> 
> The primary difference between fchmodat2(AT_EMPTY_PATH) and fchmod() is
> that fchmod() doesn't operate on O_PATH file descriptors by design. To
> quote open(2):
> 
> [...]

A follow-up patch with selftests would be appreciated.

---

Applied to the vfs.fchmodat2 branch of the vfs/vfs.git tree.
Patches in the vfs.fchmodat2 branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fchmodat2

[1/1] fchmodat2: add support for AT_EMPTY_PATH
      https://git.kernel.org/vfs/vfs/c/5daeb41a6fc9
