Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100DD79ADA2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 01:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237357AbjIKUxM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238214AbjIKNv3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:51:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14BBFA
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 06:51:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9752C433C8;
        Mon, 11 Sep 2023 13:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694440284;
        bh=+xei6KDA/BXmaQMqJkhsjOTENISNPYrcTQHHI/FT+38=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rBxNtdpr6yNtZFmZRdzXwj2uzapfsvZoTVJisEF5kYxDXFOilp1WF19QXkwraF5vQ
         Bi753pZIKTZyQrIoDmTpR2dOqVOwyHrFT9k8trQPiPBHhLa24eOd17hkRVNBrzAIaz
         3FOD6Nll5pXJi5a9tEfhogbA70GxyDe5NLNML+juzsrqlm75l6JdwNEyraug2BAIfD
         wgTZFy53ixdpEjt5heyPndbE11dAcWF8Mc7uWntt+fU/DATweOF2ql05D8ig4lud5E
         nIfbbfQG/8tEvHG3a/R9h9OLakffWhHcE+3+B6uCgsO2rfeNRZ92gVoi3fvgVZSI0r
         wWmCxDFq3Vmhw==
From:   Christian Brauner <brauner@kernel.org>
To:     Reuben Hawkins <reubenhwk@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>, amir73il@gmail.com,
        mszeredi@redhat.com, willy@infradead.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] vfs: fix readahead(2) on block devices
Date:   Mon, 11 Sep 2023 15:51:15 +0200
Message-Id: <20230911-plakat-machwerk-7cb027631a5e@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230911114713.25625-1-reubenhwk@gmail.com>
References: <20230911114713.25625-1-reubenhwk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1139; i=brauner@kernel.org; h=from:subject:message-id; bh=+xei6KDA/BXmaQMqJkhsjOTENISNPYrcTQHHI/FT+38=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT8l/bPOnI3+b2qU+CrAqfNrt4z9doWfs41dLb+JjjpZ86i N3fvdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkm4/hN3tkzwemre6NO7krdDQ5Wd KLNix8+fb9ifYbjv9sjqz478jwV1rbe8GMGaJ1LfP7vSrE36wwD7+wePmOai/pDdyTc79s5QYA
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

On Mon, 11 Sep 2023 06:47:13 -0500, Reuben Hawkins wrote:
> Readahead was factored to call generic_fadvise.  That refactor added an
> S_ISREG restriction which broke readahead on block devices.
> 
> This change removes the S_ISREG restriction to fix block device readahead.
> The change also means that readahead will return -ESPIPE on FIFO files
> instead of -EINVAL.
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

[1/1] vfs: fix readahead(2) on block devices
      https://git.kernel.org/vfs/vfs/c/d05ad99006a6
