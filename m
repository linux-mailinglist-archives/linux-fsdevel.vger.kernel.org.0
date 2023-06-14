Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D819A72F76D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 10:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjFNIKy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 04:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243184AbjFNIJd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:09:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8E5B5;
        Wed, 14 Jun 2023 01:09:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4ED3963C3F;
        Wed, 14 Jun 2023 08:09:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B775C433C8;
        Wed, 14 Jun 2023 08:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686730171;
        bh=znlbGaKAZ44Y3s2Y9/HYLCysbzX2Qza4/9WvzVNIdwg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kUfDf25yknKIpqQSy+tIhNlS6DrLXiV+DUfr9Y2yk9sQrkvI2XlDtABPIqeYsQeQE
         g+D6eYdaRjTRDIJ9FBv5JjtHgdhmd0mwIZ0C/Y05wpuDc65p4gmAUHF5DaFUnBJyIo
         6vhh6YA9bf/jlrJLZVdOJXmoihQFf2jxc7Z0DVp6Wyb6tWbz4WZw46eP4BA6/6gYj8
         K8yc9Qux/PpWDaC1egFYOlmN1RJ+YxnEMwB6UveY/v4e4INsk1k0+SkZdx6G38SXJy
         lUrRQ35w/2onPzkY6B0v+Ku950rJgyQtVw9SxeoL5JkFTrvQItaGoOE2F19Hgdz/E2
         At1ysBRZjpS8A==
From:   Christian Brauner <brauner@kernel.org>
To:     wenyang.linux@foxmail.com
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Dylan Yudaken <dylany@fb.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2] eventfd: show the EFD_SEMAPHORE flag in fdinfo
Date:   Wed, 14 Jun 2023 10:09:21 +0200
Message-Id: <20230614-rohstoff-sitzheizung-43fe06a57ce1@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <tencent_05B9CFEFE6B9BC2A9B3A27886A122A7D9205@qq.com>
References: <tencent_05B9CFEFE6B9BC2A9B3A27886A122A7D9205@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=803; i=brauner@kernel.org; h=from:subject:message-id; bh=znlbGaKAZ44Y3s2Y9/HYLCysbzX2Qza4/9WvzVNIdwg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR0lq7q0ljqE2Qg+HRuwy7NA17Kvw+G+v0JPNbRkj35kkXw x7dvOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACby1IWR4UbrHelnJj9+26S+U11gcP hpqopNxaqlr+Z3CU+6+sjumBTDP0O3+m+vkqtuGPTI+f6bsaHGYr2Dy67eA/8mnFkuenS6KS8A
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

On Wed, 14 Jun 2023 01:01:22 +0800, wenyang.linux@foxmail.com wrote:
> The EFD_SEMAPHORE flag should be displayed in fdinfo,
> as different value could affect the behavior of eventfd.
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

[1/1] eventfd: show the EFD_SEMAPHORE flag in fdinfo
      https://git.kernel.org/vfs/vfs/c/33c8c098aaf6
