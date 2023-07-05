Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1B7748CBE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbjGETDb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbjGETD2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:03:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D081985;
        Wed,  5 Jul 2023 12:03:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2762616C4;
        Wed,  5 Jul 2023 19:03:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35903C433C8;
        Wed,  5 Jul 2023 19:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583799;
        bh=Y/meLmwCWNAsn5J38ZDDhtkdnkG182kUzNf/PHgf2VI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pM+4NH2Mids4CxpLS5rSap4VcC4ygdGDr8BXUIqOTu8qDZ0KNP0PhUxrSYwjdG2tm
         TNg4o34B2caVF+Ipkq7ZskuLUN6XwbobArABtlRZCnHavfYBUY123MGBOgOYAqMicm
         ixxlWo8iaZ0xg49JGuSmrCF+oLZjIFCcD6BahO8Dm1kEIng0qGhfSs1OcTyf3FIBP+
         K58HB33IflEhe5BayuDCKNhAkauNUNi4cZHi+QBXYbcMFQtLMEHJcLrXwMULmPWdRS
         oShNaFMagHkUpIx06ahi+hey20WIelFocVARFoSJuFKOfrj3dq9czS3726+0xGw5jl
         4acVjPoiSzdxw==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org
Subject: [PATCH v2 06/92] cifs: update the ctime on a partial page write
Date:   Wed,  5 Jul 2023 15:00:33 -0400
Message-ID: <20230705190309.579783-6-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705190309.579783-1-jlayton@kernel.org>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
MIME-Version: 1.0
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

POSIX says:

    "Upon successful completion, where nbyte is greater than 0, write()
     shall mark for update the last data modification and last file status
     change timestamps of the file..."

Add the missing ctime update.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/smb/client/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 879bc8e6555c..0a5fe8d5314b 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -2596,7 +2596,7 @@ static int cifs_partialpagewrite(struct page *page, unsigned from, unsigned to)
 					   write_data, to - from, &offset);
 		cifsFileInfo_put(open_file);
 		/* Does mm or vfs already set times? */
-		inode->i_atime = inode->i_mtime = current_time(inode);
+		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
 		if ((bytes_written > 0) && (offset))
 			rc = 0;
 		else if (bytes_written < 0)
-- 
2.41.0

