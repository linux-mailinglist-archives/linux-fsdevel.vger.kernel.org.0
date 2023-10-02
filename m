Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7143D7B4ACD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 04:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbjJBCb4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Oct 2023 22:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235137AbjJBCbz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Oct 2023 22:31:55 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE40399
        for <linux-fsdevel@vger.kernel.org>; Sun,  1 Oct 2023 19:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4AnR85rsjiuD1oFzzScjoOARp5ltt5SGcQanpgN2lOg=; b=LKSK1Ymt22gwkXB6byW2clLd2F
        daEwEw1Cc7cTEiCbbAxlVOR0g4/+Edvl12K8peZmTppyQHalYwAuAzfVR6j+k45RiRvIfwja8xL6L
        NJRTfD2Cmq9ygJucZ0kgtvbrUHv2Ro61SA6Nw6fDP1NHQFDYXYKBRLbUxyCyOYDIqiszorbohAcSz
        mSUmyfIksV64LEOlOJHI76i3fmhWyOVcD73sBG4uph56yp5y0kernPtTpQJOCjbPzlXFRe7ixgN7X
        8LYHrLLXuh+eMM00m/ukVYs/1OIHYHuGEr0X2uJ5VV97NTqg3IrLqmGg19FZ/HCxQ12Tz5iXvgMN0
        GcqMT9WQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qn8is-00EDsP-1a;
        Mon, 02 Oct 2023 02:31:50 +0000
Date:   Mon, 2 Oct 2023 03:31:50 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        David Sterba <dsterba@suse.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Steve French <sfrench@samba.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 05/15] cifs_get_link(): bail out in unsafe case
Message-ID: <20231002023150.GF3389589@ZenIV>
References: <20231002022815.GQ800259@ZenIV>
 <20231002022846.GA3389589@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002022846.GA3389589@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

->d_revalidate() bails out there, anyway.  It's not enough
to prevent getting into ->get_link() in RCU mode, but that
could happen only in a very contrieved setup.  Not worth
trying to do anything fancy here unless ->d_revalidate()
stops kicking out of RCU mode at least in some cases.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/smb/client/cifsfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 22869cda1356..2b044e47a3a6 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1170,6 +1170,9 @@ const char *cifs_get_link(struct dentry *dentry, struct inode *inode,
 {
 	char *target_path;
 
+	if (!dentry)
+		return ERR_PTR(-ECHILD);
+
 	target_path = kmalloc(PATH_MAX, GFP_KERNEL);
 	if (!target_path)
 		return ERR_PTR(-ENOMEM);
-- 
2.39.2

