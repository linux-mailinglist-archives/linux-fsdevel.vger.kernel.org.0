Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A969072F74C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 10:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbjFNIF1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 04:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243632AbjFNIE6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:04:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78430CD;
        Wed, 14 Jun 2023 01:04:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DDC663949;
        Wed, 14 Jun 2023 08:04:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54CF5C433C8;
        Wed, 14 Jun 2023 08:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686729896;
        bh=587fmz2klRa2g4aJ3HVM7KHqlrIy3jsGHL5MkwAbBz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q3e/G1ZFtWdjRyuLaXw77zGwVvnjZ70w0mOlu/ssVKUfvGWvo6XYFgDkyhQFZ/iqr
         e+/WFTbmUZLvA9EFuPXzN7QqeBtGjKJq/3CoX3yUdBhPdF7u2ZxHBd+kLy3SCoY0KL
         TUUHfohGuQj9k/6gbsdhsJaJeHBgTwLasrbhGX+rZdTk+KAI6Op5BV4tZUhRzQNS4v
         pYWl6DSjo3585DAXlW45T0hLCmHDSJKaUi4MM1VNexaTrdsx73trRbemTn1U0Ek8pF
         JqserqFT0sQQF/LIKZN4u99ElP7w4QlZREtW/xhSMsd9bXCmkUd5fwIY6xXk1vbY8j
         eyKhmtMMS/HOw==
From:   Christian Brauner <brauner@kernel.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] fs/aio: Stop allocating aio rings from HIGHMEM
Date:   Wed, 14 Jun 2023 10:04:43 +0200
Message-Id: <20230614-langhaarig-soweit-5d3bb172559f@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230609145937.17610-1-fmdefrancesco@gmail.com>
References: <20230609145937.17610-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=889; i=brauner@kernel.org; h=from:subject:message-id; bh=587fmz2klRa2g4aJ3HVM7KHqlrIy3jsGHL5MkwAbBz0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR0lky+eFtdJPeF9t4fsQEKqxb2c7/8zVXz0DTZ+l6PjflE k+8/OkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbizczwzzbnqcyymY45TTv0C5VZmP cX3Xql8ih8idO7OeZnHl7/HcbIMCOFa+/bCwEzPNkFrANu3ClcYf+95qQNbzOTyIr5Tu/k+QA=
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

On Fri, 09 Jun 2023 16:59:37 +0200, Fabio M. De Francesco wrote:
> There is no need to allocate aio rings from HIGHMEM because of very
> little memory needed here.
> 
> Therefore, use GFP_USER flag in find_or_create_page() and get rid of
> kmap*() mappings.
> 
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

[1/1] fs/aio: Stop allocating aio rings from HIGHMEM
      https://git.kernel.org/vfs/vfs/c/c9657715af76
