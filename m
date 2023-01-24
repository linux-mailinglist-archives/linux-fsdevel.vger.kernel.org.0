Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A323D67973D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 13:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbjAXMGc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 07:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjAXMGb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:06:31 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9930B2330C
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 04:06:30 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4C0F521856;
        Tue, 24 Jan 2023 12:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674561989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=XEvfZzdaR24/0o+pLYYLesWNnR7QvEmewDhq5cyBJOU=;
        b=pUa0i6HlkWm9LwdWefWFcLJT0K31+K75LqMh4azcXL0hOuYTpteye5LOaMuYfytJX+h7kS
        dBjpTAKMzHnl24BispQGJaps2vDIEx181vkkFkskFycaXoSbjI5qoIxdIBgYQ7S9+gugIs
        HrnYIrIG+WE2IH7nj4vW9IiqGnks+iw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674561989;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=XEvfZzdaR24/0o+pLYYLesWNnR7QvEmewDhq5cyBJOU=;
        b=Bf+BKxfA91hekNc+4UhYPHt+qwXDebF7NAj8ALIXMW0fGQprsMllgLhRV/H+VpolnU3S+0
        pbvrzkphwHw1+pCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3FE77139FB;
        Tue, 24 Jan 2023 12:06:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sJSTD8XJz2P3MAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 24 Jan 2023 12:06:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C3B83A06B5; Tue, 24 Jan 2023 13:06:28 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/10] udf: Unify aops
Date:   Tue, 24 Jan 2023 13:06:11 +0100
Message-Id: <20230124120221.31585-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=360; i=jack@suse.cz; h=from:subject:message-id; bh=r2VqhVCnnAfChzTkSdUmsC5D/RKTzjkAWbNMGbH4zV4=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjz8mzr5FQBr2UG2PaxGRI/lHzFOjopOQa5HT49DD3 NR7OZLaJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY8/JswAKCRCcnaoHP2RA2bpnCA DMNPj6eQWqbauxflCZ6G1fTqmgpi38yPI6mA0lv3lrcw+Y+TN8x7GFpQDxqkPvczwyBcm1vloiQgu1 r1ybs+Cnji7an8ZULShGcM0ehilqVtJx+Ai5gBNY2P9PF2GFkVeUsi5ZwKMYz11ED0F9GS4w8pJYJK mJjI85/jyXufOeLqETeGWMZjcrB4rxWWVFqKBIdIqqSJs1FeOAeY8cc5a/gE+0mGecfEiYYh129sZM peobmZUm5f6kdBnmzuFYFEoTt7Y1sJnEnbhxFXlZXsLF3SyRHhMrqeMps3jgfOr51eEPS6hEaFoFOG uDL994XXOGzW8IbZrpM7wrND+Ov75A
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

this patch series makes UDF use the same address_space_operations for both
normal and in-ICB files as switching aops on live files is prone to races
as spotted by syzbot. When already dealing with this code, switch readpage
function from using kmap_atomic() to use kmap_local_page().

I plan to queue these patches to my tree.

								Honza
