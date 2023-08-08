Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7797877499C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 21:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjHHT6z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 15:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234601AbjHHT5C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:57:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028DC1BACA;
        Tue,  8 Aug 2023 11:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=bJxgIoR4mJQUg5rLnZqrYlT5xT1x+GwLxo5eAVskIAQ=; b=OHuO8Wh/1Q0P/1nF6gcUMbFQod
        5LDs5mgcANOxNCq0J3IZZlQoDbqurokslJv5aV7vgb5wdZXBYUqawpWm00FUa/uPb02aaSVb4wI5g
        rnCkGWvpHMwutgEFJIyE5/sBuoiFVhJo7NyGL9dOIDqkQAzPlSG1hJ0nKYjwWmAzgUHr8WKbj6YPL
        SqOrhQza8PU1DgJrj+sXMT3/PrNpObo8Q2k8AC0XixhL1WHDOUqVAWIktwgfmggi1B9Ka3wYnfIL5
        UU7mPiBIs3lje/6PilCNjLgTb5WM4BFOuiJzPfWVzS6/3Qwt7X4FAqkSozzcDNGTUOsRMKVnmbjYB
        4x5fl+PQ==;
Received: from [4.28.11.157] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qTPNJ-002vao-0x;
        Tue, 08 Aug 2023 16:16:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: s_fs_info and ->kill_sb revisited
Date:   Tue,  8 Aug 2023 09:15:47 -0700
Message-Id: <20230808161600.1099516-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

this series is against the VFS vfs.super branch does two slightly
related things:

 - move closing of the external devices in ext4 and xfs from ->put_super
   into ->kill_sb so that this isn't done under s_umount which creates
   lock ordere reversal
 - move freeing the private dta in s_fs_info into ->kill_sb for file systems
   that pass it in through the fs_context, as otherwise we could leak it
   before fill_super is called (this is something new on the vfs.super
   branch because of the changed place where blkdev_get is called)

Diffstat:
 exfat/exfat_fs.h |    2 -
 exfat/super.c    |   39 +++++++++++++-------------
 ext4/super.c     |   50 +++++++++++++++++-----------------
 ntfs3/super.c    |   33 ++++++++++------------
 xfs/xfs_buf.c    |    7 +++-
 xfs/xfs_super.c  |   80 +++++++++++++++++++++++++------------------------------
 6 files changed, 102 insertions(+), 109 deletions(-)
