Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65577B2229
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 18:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjI1QWI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 12:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjI1QWG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:22:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D31DB7;
        Thu, 28 Sep 2023 09:22:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1E0C433C7;
        Thu, 28 Sep 2023 16:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695918124;
        bh=0MlJccgS93tYhYBmiMCadXQzGmVcPB51jzpzwfRNecY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b4qb0NxyQjwWq/Zfx4eRW2G+km70dYY4EiUPdBvHHIRyw1G4C8gJ5Mtr6qfF5hj9I
         oYHC3luT7EBfvKJm71UJcB0E/RpjpVYR2qzuYxa2IH5eCstWdU30hh5+ERicQ21/sH
         LaNcPjIEunprotj8FpYdXoS1EVdsU45LR+nm1B0Y15pA10nCexGyeXCpS6mvXm7/Ew
         +MS34iuIeWITEhMBwWkAUGDEJ2ss3RQYeBSutgHjCModZ+5EN1Ke2uKRfxBExTOSYy
         pDNi1Z6cLp9NCNPlpRF4buIBRdvv9GH7IFHsz8LksZyaNoO5toPNKHPhdRx/q7todN
         Bfqf6lMPkvR8Q==
From:   Christian Brauner <brauner@kernel.org>
To:     Luis Henriques <lhenriques@suse.de>
Cc:     Christian Brauner <brauner@kernel.org>,
        Mateusz Guzik <mjguzik@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v2] fs: simplify misleading code to remove ambiguity regarding ihold()/iput()
Date:   Thu, 28 Sep 2023 18:21:58 +0200
Message-Id: <20230928-zecken-werkvertrag-59ae5e5044de@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928152341.303-1-lhenriques@suse.de>
References: <20230928152341.303-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1250; i=brauner@kernel.org; h=from:subject:message-id; bh=0MlJccgS93tYhYBmiMCadXQzGmVcPB51jzpzwfRNecY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSKrlAsqy0/WLrX+1usVIPYk2fn775wNNT+9u9rpEpB7nbV ++v/d5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkwXZGhsZN+Xt4Mu1TI+y4pV+69f zJnN79OTWq/YnMT4myT8enGzP8z15m+HPSkdaFAfxXtqj4zeRfcu6qyM0/BdG2ypMKkv8e5wYA
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

On Thu, 28 Sep 2023 16:23:41 +0100, Luís Henriques wrote:
> Because 'inode' is being initialised before checking if 'dentry' is negative
> it looks like an extra iput() on 'inode' may happen since the ihold() is
> done only if the dentry is *not* negative.  In reality this doesn't happen
> because d_is_negative() is never true if ->d_inode is NULL.  This patch only
> makes the code easier to understand, as I was initially mislead by it.
> 
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

[1/1] fs: simplify misleading code to remove ambiguity regarding ihold()/iput()
      https://git.kernel.org/vfs/vfs/c/5c29bcfaa4cf
