Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C92C516A5A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 May 2022 07:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358661AbiEBFpe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 May 2022 01:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiEBFpd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 May 2022 01:45:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A643635847;
        Sun,  1 May 2022 22:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=+dTUFiPSgcPyKn27SG2SzO7pIAPQqql66xRPG3Hmnd0=; b=ZS+Jl8aHtWueRkdYl6tmmnK5X2
        glIsYRJy1nHd7JNVkjdoNq4qALnvkQ2hS1bqXO+rM4QrZP7JnyVz2MFEzBHL1cLtOfWRMgDYRRFQm
        hVmmSUrVBfkM10IqkO+704tPUauNTMZcevGv6XfYRfZHuKFJVOAzsERzgVC2FZE3woLduVBWNK1iP
        Kn7lGVu2eUJ+w8PjsBl0i7POFQ7VqO0x31MNEcTMIGAnrR+cmyVz+0IDlOBdQuZhz/kgU/hEZyC7w
        YV7rA++Ch28bz7UENEAMYAQDe/1XVoij+v4JIOlDjF4yfn3MTZLjhuzGe7mBpVghK9eOpZ1KwvNia
        dKMv4FDQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlOot-00EYzz-NC; Mon, 02 May 2022 05:42:03 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        cluster-devel@redhat.com, linux-mtd@lists.infradead.org,
        linux-nfs@vger.kernel.org
Subject: [PATCH 0/3] Unify filler_t and read_folio
Date:   Mon,  2 May 2022 06:41:56 +0100
Message-Id: <20220502054159.3471078-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I realised there was no good reason for any of the three filesystems which
actually use read_cache_page() to pass in something that wasn't a struct
file pointer.  Indeed, it made each of them more complex.  These aren't
filesystems I test regularly, so please scrutinise carefully.  This is
on top of the read_folio() patchset that I posted recently and can be
found at git://git.infradead.org/users/willy/pagecache.git for-next

Matthew Wilcox (Oracle) (3):
  jffs2: Pass the file pointer to jffs2_do_readpage_unlock()
  nfs: Pass the file pointer to nfs_symlink_filler()
  fs: Change the type of filler_t

 fs/gfs2/aops.c          | 29 +++++++++++------------------
 fs/jffs2/file.c         |  9 ++++-----
 fs/jffs2/gc.c           |  2 +-
 fs/jffs2/os-linux.h     |  2 +-
 fs/nfs/symlink.c        | 16 ++++++++--------
 include/linux/pagemap.h |  6 +++---
 mm/filemap.c            | 40 ++++++++++++++++++++--------------------
 7 files changed, 48 insertions(+), 56 deletions(-)

-- 
2.34.1

