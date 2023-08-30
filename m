Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B104B78DAC7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbjH3ShJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242335AbjH3IGE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 04:06:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCFDF4
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 01:06:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 364D260DC7
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 08:06:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F63C433C7;
        Wed, 30 Aug 2023 08:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693382761;
        bh=3PR3pUSzxk2EyvwEKLnU5xp0oTSy2O6BEYeVQBem1E8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gaumzDgvBmpGf6mrv89IbzIMZ+jf4G2La8qgWDc9D/vV7h91ivE3fKzG8GeFGHW+Y
         mtJ/ZLg5QdGV0UbkQzKRSNEQ4rBWsSDuVxlai2/+aDcTRMVPE4WShHopVGe5HU7Wqt
         bUeLJP5tn6y4jBGDU/kxCGxbEOFH9Kc4VwwSpD6rbZdbg3pF7Xx7KJeOqrfq/JX3um
         kudxWcwZKWXf5fO16gnYbX4ElWnKDif+h9Xh3jsOZQ4Fa+ugPTykmRo1jJDfT98ei6
         o8Hsq6iYSRGWNw+YIoX3JvEMrfTkZkF7hnHcMLCrTiP1+Vbq1/PAD3vg8vHxc6vHmH
         PqyfEziWSFBPg==
Date:   Wed, 30 Aug 2023 10:05:57 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.cz>, Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] fs: export sget_dev()
Message-ID: <20230830-befanden-geahndet-2f084125d861@brauner>
References: <20230829-vfs-super-mtd-v1-0-fecb572e5df3@kernel.org>
 <20230829-vfs-super-mtd-v1-1-fecb572e5df3@kernel.org>
 <20230830061409.GB17785@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230830061409.GB17785@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 30, 2023 at 08:14:09AM +0200, Christoph Hellwig wrote:
> > +struct super_block *sget_dev(struct fs_context *fc, dev_t dev)
> 
> A kerneldoc comment would probably be useful here.

Added the following in-treep:

diff --git a/fs/super.c b/fs/super.c
index 158e093f23c9..19fa906b118a 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1388,6 +1388,26 @@ static int super_s_dev_test(struct super_block *s, struct fs_context *fc)
                s->s_dev == *(dev_t *)fc->sget_key;
 }

+/**
+ * sget_dev - Find or create a superblock by device number
+ * @fc:        Filesystem context.
+ * @dev: device number
+ *
+ * Find or create a superblock using the provided device number that
+ * will be stored in fc->sget_key.
+ *
+ * If an extant superblock is matched, then that will be returned with
+ * an elevated reference count that the caller must transfer or discard.
+ *
+ * If no match is made, a new superblock will be allocated and basic
+ * initialisation will be performed (s_type, s_fs_info and s_id will be
+ * set and the set() callback will be invoked), the superblock will be
+ * published and it will be returned in a partially constructed state
+ * with SB_BORN and SB_ACTIVE as yet unset.
+ *
+ * Return: an existing or newly created superblock on success, an an
+ *         error pointer on failure.
+ */
 struct super_block *sget_dev(struct fs_context *fc, dev_t dev)
 {
        fc->sget_key = &dev;
