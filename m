Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F04B782D3E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 17:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236349AbjHUP07 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 11:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236337AbjHUP06 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 11:26:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79487E2
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Aug 2023 08:26:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D211626B7
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Aug 2023 15:26:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE1DC433C7;
        Mon, 21 Aug 2023 15:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692631616;
        bh=DO2QcR8A0FD7wmc5VMkteT5y3lkw9AM0aG//Yt2E56c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tT79kI6YjVDt9WNchLZ8s+TKUtCnlDFBuMHUdBol+sOtCivJCOiAXPD9qbQPFDtRt
         fwxzX2wf6OiYCjuvcq9RjlimsC+IhOobv/HDl2GLfblYUtgNI+UZjchoBHciwA5kpX
         YQw0wYrwqOQHRqXLwAl1tUONWNkdXVa0ujHecpIEW0vGB3DUuB6O/LKjBsLVpbrNo8
         0KBO3ient3bolRNfaSCMWTUHyPI/6sfyWzQCWapYVD3+3+0wTIjgFMl4Ql+Zy2i8+c
         QCGqpBMBBShOT6HH5bIxGmp04nZmLF0Z8drCsKL3q29sEMdBh2RPeSzGOi4Xv/NxIo
         JLwCnpuQh7Iow==
From:   Christian Brauner <brauner@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] splice: Convert page_cache_pipe_buf_confirm() to use a folio
Date:   Mon, 21 Aug 2023 17:26:51 +0200
Message-Id: <20230821-bosse-anmarsch-2f6d5db27115@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821141541.2535953-1-willy@infradead.org>
References: <20230821141541.2535953-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=992; i=brauner@kernel.org; h=from:subject:message-id; bh=DO2QcR8A0FD7wmc5VMkteT5y3lkw9AM0aG//Yt2E56c=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ8brJ89mdO9KfZ4tlmG+ZJv64IE7lrszFFe+WGOWGTJllu 3vght6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiO10ZGWa39HyZ+NjyTvuHSTafrX VO2EzyTeRZ/npz3I5UQe0vDj0M/3Mz2Lhv5ulPepEfmnfqRqx2nPyuqFNbXfREecpX7ow/ygwA
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

On Mon, 21 Aug 2023 15:15:41 +0100, Matthew Wilcox (Oracle) wrote:
> Convert buf->page to a folio once instead of five times.  There's only
> one uptodate bit per folio, not per page, so we lose nothing here.
> 
> 

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

[1/1] splice: Convert page_cache_pipe_buf_confirm() to use a folio
      https://git.kernel.org/vfs/vfs/c/4e1428925b4b
