Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74A870262E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 09:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjEOHiB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 03:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234967AbjEOHh5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 03:37:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C5D1A5;
        Mon, 15 May 2023 00:37:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9D3E611C5;
        Mon, 15 May 2023 07:37:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7763BC433EF;
        Mon, 15 May 2023 07:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684136275;
        bh=WjuJTRI0yDa5tJ0OvZ+Ic4uBPIR1vsm5WT5pCGM3Bwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GS0ZdfqvzuRLDVaYXKytaGyFmq34hv6ZO0MVLxZrswStvtnsAunJEKkgfFMcta4SI
         3rF1QMYsowzoTmpOJ1LBaLCyZLOLBQSC+jMIM8j0L3hus86l74auc93hhYDXub4PxQ
         xHCqlHPfnDV4xIR4sej7gwR1fiUNGFrTomT7OiB/ddsNjsC69uKPfTcst48PhgMPaS
         kqwuq50Zp5Sbzd8unmTD7xW0lT1Y4dGYbHxUBdMD6Awp5QAIW6PfISUrzrk9ymjdHd
         /5IvxIy+EctF4Wan9h3PoKDk76cnUkw5UpkHRvj+eeD/pt0lOuyUS2NVUjvnea5zcu
         LpAjDE7PreRzA==
From:   Christian Brauner <brauner@kernel.org>
To:     Min-Hua Chen <minhuadotchen@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs: use correct __poll_t type
Date:   Mon, 15 May 2023 09:37:40 +0200
Message-Id: <20230515-mengenlehre-reinreden-a4ca60c63d75@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230511164628.336586-1-minhuadotchen@gmail.com>
References: <20230511164628.336586-1-minhuadotchen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=769; i=brauner@kernel.org; h=from:subject:message-id; bh=WjuJTRI0yDa5tJ0OvZ+Ic4uBPIR1vsm5WT5pCGM3Bwc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQkPtR9nn03eNHaRY+evZou4rwo91vaKZXVy9rWRwg858t+ E8PH3VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRyCZGhvXhDhwrfp+3FtVda+TvfX /6duGF6awxiQ8lsrcqr1jsuoKR4aW12bK++DVHatts2WqnpM3Mi6iNea9ffnJFp6hq2cfnzAA=
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

On Fri, 12 May 2023 00:46:25 +0800, Min-Hua Chen wrote:
> Fix the following sparse warnings by using __poll_t instead
> of unsigned type.
> 
> fs/eventpoll.c:541:9: sparse: warning: restricted __poll_t degrades to integer
> fs/eventfd.c:67:17: sparse: warning: restricted __poll_t degrades to integer
> 
> 
> [...]

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] fs: use correct __poll_t type
      https://git.kernel.org/vfs/vfs/c/1454df87a544
