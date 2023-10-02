Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2412B7B4AD7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 04:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235407AbjJBCgr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Oct 2023 22:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235396AbjJBCgq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Oct 2023 22:36:46 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BC8CE
        for <linux-fsdevel@vger.kernel.org>; Sun,  1 Oct 2023 19:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tQHM/Q4vObkj4H32QkFiMX0KySqsWMREApB37lCIJpA=; b=FQnc6Zz3dlnAoyrquyC5PuLuX+
        5NXocrhxwGVwILV+olrLFTJdymOr0E+VFz0CMYRWErXlQ02frj0qLGAZX53+as8+dDo7jL2UNeJyB
        LZTExosGQfw7PvQ6zz1HCxk/6AH1l3nqvICEm98zZJubPTAyIPokHq1mjIW05SrJ9dCcgPF0zyGWL
        4Tz5Uy4RGstO8PAONqtCFLyK7xnPaF2cPBRsrBEdQBZjfyBTf79PMfRifmiEIRaOisareDN+bTr4x
        Hq740z6LDj5TNLhjCP0grhysORN9o9q9Qhxi0nPV9ITaBhiDdPVH3RFNnK73Y6Rx0n6KAM8VWGSpF
        ZJQ+SCag==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qn8nb-00EDzg-0P;
        Mon, 02 Oct 2023 02:36:43 +0000
Date:   Mon, 2 Oct 2023 03:36:43 +0100
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
Subject: [PATCH 14/15] ovl_dentry_revalidate_common(): fetch inode once
Message-ID: <20231002023643.GO3389589@ZenIV>
References: <20231002022815.GQ800259@ZenIV>
 <20231002022846.GA3389589@ZenIV>
 <20231002023613.GN3389589@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002023613.GN3389589@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

d_inode_rcu() is right - we might be in rcu pathwalk;
however, OVL_E() hides plain d_inode() on the same dentry...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/overlayfs/super.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index f09184b865ec..905d3aaf4e55 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -104,8 +104,8 @@ static int ovl_revalidate_real(struct dentry *d, unsigned int flags, bool weak)
 static int ovl_dentry_revalidate_common(struct dentry *dentry,
 					unsigned int flags, bool weak)
 {
-	struct ovl_entry *oe = OVL_E(dentry);
-	struct ovl_path *lowerstack = ovl_lowerstack(oe);
+	struct ovl_entry *oe;
+	struct ovl_path *lowerstack;
 	struct inode *inode = d_inode_rcu(dentry);
 	struct dentry *upper;
 	unsigned int i;
@@ -115,6 +115,8 @@ static int ovl_dentry_revalidate_common(struct dentry *dentry,
 	if (!inode)
 		return -ECHILD;
 
+	oe = OVL_I_E(inode);
+	lowerstack = ovl_lowerstack(oe);
 	upper = ovl_i_dentry_upper(inode);
 	if (upper)
 		ret = ovl_revalidate_real(upper, flags, weak);
-- 
2.39.2

