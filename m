Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BB87777B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 14:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbjHJMAD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 08:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjHJMAC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 08:00:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D4BE4D;
        Thu, 10 Aug 2023 05:00:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A84A65A89;
        Thu, 10 Aug 2023 12:00:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5EDEC433C8;
        Thu, 10 Aug 2023 11:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691668800;
        bh=cLcSp/OITxB2lIR6ZNDHQ4eJMnOnALLPpdxcYxd5zyQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mXItDfQ3tcVHY/X2iUJFOjdIIiTQ86KreeAXKzmfffSizVS7vKOzViqW3o42TL17L
         IyxnBJ3igK7CzygdZsmesvKml6PS8VwMNhdbUkOjGTQ/IpnMyrAVku/yclApQ8ev44
         8M32m5gbkOxu1y94SKAxYuebUOGQOAGTYmv7ynTXbQC1yCz2f+M+twVp1cC0O+Ybgy
         F2dtuRnfWs1dlDYUm/mRKlhjo0cH9Cu2MiF+NqgqvGbdrqLqJhAorX1miwt6sb+4ws
         SwRDQr0SFP0nn9mGTD2bFSR40e7zl549MkTqnBgtscdBmQMUcbFp7TiUnpz5nWl25x
         Rtd7hQ4SczzTA==
From:   Christian Brauner <brauner@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Leonardo Bras <leobras@redhat.com>,
        Yair Podemsky <ypodemsk@redhat.com>,
        P J P <ppandit@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/buffer.c: disable per-CPU buffer_head cache for isolated CPUs
Date:   Thu, 10 Aug 2023 13:59:53 +0200
Message-Id: <20230810-vordem-prospekt-28a1fb423f73@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZJtBrybavtb1x45V@tpad>
References: <ZJtBrybavtb1x45V@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1164; i=brauner@kernel.org; h=from:subject:message-id; bh=cLcSp/OITxB2lIR6ZNDHQ4eJMnOnALLPpdxcYxd5zyQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRcuWgW6jFB+Zwc41y7g766M9e53L26//nqhABFsfe1cxnr AjYkdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkRCLDX/mnrId5ND55KVVJnVJ7o5 p2tlrMRE2D4w7fjds7bUKTDRkZNjUcT5haq/d6vc2vg6u3r71zb7MO46aXhZcfKWxdKNmhygwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 27 Jun 2023 17:08:15 -0300, Marcelo Tosatti wrote:
> For certain types of applications (for example PLC software or
> RAN processing), upon occurrence of an event, it is necessary to
> complete a certain task in a maximum amount of time (deadline).
> 
> One way to express this requirement is with a pair of numbers,
> deadline time and execution time, where:
> 
> [...]

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] fs/buffer.c: disable per-CPU buffer_head cache for isolated CPUs
      https://git.kernel.org/vfs/vfs/c/9ed7cfdf38b8
