Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1DB6908E5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Feb 2023 13:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjBIMca (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Feb 2023 07:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjBIMcM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Feb 2023 07:32:12 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F4349559;
        Thu,  9 Feb 2023 04:32:10 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1DB3937478;
        Thu,  9 Feb 2023 12:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675945929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qvuorklveraurLcK6QZ4mrS02HsJE4d+WeMXOh2Sd9M=;
        b=CqmvW0jJ3DIGd+grXAIql03BHQqGkK991C6Wi/E2LQDYyC81PqbbRNsLN58sTPW/f9eeNR
        46Q2L1SdgD4NsmyatNgmANAy47H6LO4bS097sh7idyKKRF8Fxtd0K+pcd9/acCE2hE5R1h
        JueXPVPxo906sx84zxJWyIaa/eQRZ0E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675945929;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qvuorklveraurLcK6QZ4mrS02HsJE4d+WeMXOh2Sd9M=;
        b=tq6vAYDBQAPD+mTUztBhpxRGG5W7kgIlBecfOjKwc5V3IHSaF7kmh4eqHKEyrF+eRPINmE
        5ib8Hi0bQ3OvJgAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 11748138E4;
        Thu,  9 Feb 2023 12:32:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7Jg8BMnn5GPGWQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 09 Feb 2023 12:32:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 982C7A06F2; Thu,  9 Feb 2023 13:32:06 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     <linux-block@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        David Hildenbrand <david@redhat.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 5/5] iomap: Bounce pinned pages during writeback
Date:   Thu,  9 Feb 2023 13:31:57 +0100
Message-Id: <20230209123206.3548-5-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230209121046.25360-1-jack@suse.cz>
References: <20230209121046.25360-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1103; i=jack@suse.cz; h=from:subject; bh=jvs7yXeGV+Ti+9CbBYnSlNBqaLxxaizxHND1BJeW90M=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBj5Oe8w55rhlFdINcQXnpIh1RKW3XbWlfIU3Y2TDA8 67+oTNmJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY+TnvAAKCRCcnaoHP2RA2fhCB/ 4/2JpDK+0V232sGOIsqPKWw7XV7L4ti40Cg3tBEmAVQxehU+I8NK4CzzdA8EZTSvTLVZqxg5+/M6s3 bmQbCDaG0JJs98lmbFy1SWxxvOXgww4EXeQpC6BQVC6JuPMfUp8ZF5WKOy6NLsB07ZacUYwIXp3+iH vAYxabUp7I4r/qYnPszdwAwfSxdRNLzAMYlIdHglipFfjmmyjszncki6Qtux7gBGcygYWRXcHByucy 7NvP6kGl4qovVvUreW7xU027/wR8JU4aOpC5Eg+x3McBfThsCPvBFXez0gjVOSfunRnsQ9YoCL3hPj Ucbv/ceayUl3fYswgCPMwHjX26Fu+/
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When there is direct IO (or other DMA write) running into a page, it is
not generally safe to submit this page for writeback because this can
cause DIF/DIX failures or similar issues. Ask block layer to bounce the
page in this case.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/iomap/buffered-io.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 356193e44cf0..e6469e7715cc 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1563,6 +1563,14 @@ iomap_add_to_ioend(struct inode *inode, loff_t pos, struct folio *folio,
 		bio_add_folio(wpc->ioend->io_bio, folio, len, poff);
 	}
 
+	/*
+	 * Folio may be modified by the owner of the pin and we require stable
+	 * page contents during writeback? Ask block layer to bounce the bio.
+	 */
+	if (inode->i_sb->s_iflags & SB_I_STABLE_WRITES &&
+	    folio_maybe_dma_pinned(folio))
+		wpc->ioend->io_bio->bi_flags |= 1 << BIO_NEED_PIN_BOUNCE;
+
 	if (iop)
 		atomic_add(len, &iop->write_bytes_pending);
 	wpc->ioend->io_size += len;
-- 
2.35.3

