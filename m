Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF36588233
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Aug 2022 21:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbiHBTCF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Aug 2022 15:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbiHBTBN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Aug 2022 15:01:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5422F2316B;
        Tue,  2 Aug 2022 12:01:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 01A2E3829C;
        Tue,  2 Aug 2022 19:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659466871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vRtirq+uU7yY7pvbQcromr3NncF0jF3pOqCKRQG0aeU=;
        b=IW9PJe7fSui1cLBUt8PTGeqq3ft2UYZorTP2qFIQTup9FRvfTXhu1yIMoI5bk/+o41cuF7
        svugMZgCgEQpK7qlLBO0JQtXk+wUuA8ezmOD6OCA+pbxcZicJC5l+jdxeqqTiCS2R2anaB
        gTyK50H5QqZ3nNdOplBuxWrs0gYRvNQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659466871;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vRtirq+uU7yY7pvbQcromr3NncF0jF3pOqCKRQG0aeU=;
        b=o/Y27oxJNAaNJoTg23JJE5WYq0JQLTKWP1UwYw32O6fPkTy1/fD+PQ78+BaQhrAvjBYD23
        APOB6JW5cveyQvBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7276213A8E;
        Tue,  2 Aug 2022 19:01:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id p9g1DXZ06WIEYAAAMHmgww
        (envelope-from <ematsumiya@suse.de>); Tue, 02 Aug 2022 19:01:10 +0000
From:   Enzo Matsumiya <ematsumiya@suse.de>
To:     linux-cifs@vger.kernel.org
Cc:     smfrench@gmail.com, pc@cjr.nz, ronniesahlberg@gmail.com,
        nspmangalore@gmail.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tom@talpey.com,
        samba-technical@lists.samba.org, pshilovsky@samba.org,
        jlayton@kernel.org, rpenny@samba.org
Subject: [RFC PATCH v2 5/5] smbfs: show a warning about new name
Date:   Tue,  2 Aug 2022 16:00:48 -0300
Message-Id: <20220802190048.19881-6-ematsumiya@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220802190048.19881-1-ematsumiya@suse.de>
References: <20220802190048.19881-1-ematsumiya@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Also inform users about a possible removal of the existing aliases.

Signed-off-by: Enzo Matsumiya <ematsumiya@suse.de>
---
 fs/smb/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/smb/core.c b/fs/smb/core.c
index 4bc019ef90e2..0d69e3f0eee9 100644
--- a/fs/smb/core.c
+++ b/fs/smb/core.c
@@ -1724,6 +1724,10 @@ init_cifs(void)
 		goto out_init_cifs_idmap;
 	}
 
+	pr_warn("This module has been renamed to \"smbfs.ko\" and its "
+		"current aliases (\"cifs\" and \"smb3\") might be removed "
+		"in a future kernel release.\n");
+
 	return 0;
 
 out_init_cifs_idmap:
-- 
2.35.3

