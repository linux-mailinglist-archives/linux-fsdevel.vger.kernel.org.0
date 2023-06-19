Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A232C735BE5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 18:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjFSQGZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jun 2023 12:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbjFSQGY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jun 2023 12:06:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B121B1AB
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jun 2023 09:06:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FC2260DC0
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jun 2023 16:06:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6FBC433C0;
        Mon, 19 Jun 2023 16:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687190782;
        bh=RGC7nehLqnq/4053AiPtdl/mPtDLYM/Dq2dE3H4CpnY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l4QuDONltHO2vX6D2iDPb0CvKlvHh7+uR9Uip0ovvKh838agEDJPNVxdSw0U5cLLu
         dyptpHRv63LwXr1sKbIUIXybo6f+mzvAlvhKdScHBxX1M/Qisf5ishmMix7LgVfGpg
         90mR74Q2b483uvxQzobcMZlusER6B9qx7rZCVyx27g1k4rPnREka9iY+kFPHgOyaSP
         IF8peLfPw9DKPfWYY1JvQ42US8XqixBI+c3DbpSoVJRGiQOh1o8lXIePAa1+xatXUE
         lcBxQAZBMr/EbR255dg0WxIQw0Bl+zEK7lCPGiirDspopkiaSucuBtKhIKlc8us5fk
         pgrOWlTKZfbRQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v2] fs: Provide helpers for manipulating sb->s_readonly_remount
Date:   Mon, 19 Jun 2023 18:06:09 +0200
Message-Id: <20230619-nutzt-textzeilen-0b0493a88185@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230619111832.3886-1-jack@suse.cz>
References: <20230619111832.3886-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1111; i=brauner@kernel.org; h=from:subject:message-id; bh=lic8vYReJ8sau6iaw5IiJRLgPlH2zgPUxTEmkXa43Ow=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRMqFn8/Qof689bMiwif1ecn/Nvfs/yLvv5H0s3aau++jLD JdOnuqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAijrMZGSarrgr4VWf+LCBt65k67W sNzrzql/wEWjrjwzNltWPvlDL893/4x/m3l9eqrjcnL0g/6b77q5vzUfV9RbVZu0rcfqQUsgEA
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

On Mon, 19 Jun 2023 13:18:32 +0200, Jan Kara wrote:
> Provide helpers to set and clear sb->s_readonly_remount including
> appropriate memory barriers. Also use this opportunity to document what
> the barriers pair with and why they are needed.
> 
> 

I'm traveling back from Vienna to Berlin today so will back online
completely tomorrow. This looks good to me now. Thanks for the nice
cleanup. Fwiw, it could've also waited until after the merge window but
now is obviously fine too.

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
      https://git.kernel.org/vfs/vfs/c/5cf8f23baf5f
