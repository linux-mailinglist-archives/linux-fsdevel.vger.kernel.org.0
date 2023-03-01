Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0086A6D55
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 14:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjCANqp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Mar 2023 08:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjCANqo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Mar 2023 08:46:44 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2D93CE39
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Mar 2023 05:46:43 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E684E21A95;
        Wed,  1 Mar 2023 13:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677678401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=M03kOdbzbYTH8vDIieXpYhxNBTcKHYdXVe6f1cBk/II=;
        b=Xrdsue/jEesZkh3Dih9zAIDg6owLBCzKhsejwc1I5Z/T1rtITo+9KgCRwDOWYG0e7aO/En
        c0WE4QZVi1It66TXvTCn4VLduSou8DUq7KGCt8H3K4p8QUsNrf6RnjMZoF962oLz7QFzIp
        meO6KHDOM9J6/v5peeLWbztTXjzTdRY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677678401;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=M03kOdbzbYTH8vDIieXpYhxNBTcKHYdXVe6f1cBk/II=;
        b=tthCbHKZHMnjV0oP0xLSx0s54ktPzjIWuSpv2UvP5CdUGm1wvFdDNiDVYLQf5R8oPZwtUG
        gqKRto9XnX1k+cCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D8EBF13A65;
        Wed,  1 Mar 2023 13:46:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QoTWNEFX/2ObIAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 01 Mar 2023 13:46:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4524FA06E5; Wed,  1 Mar 2023 14:46:41 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 0/3] udf: Fix handling of in-ICB files
Date:   Wed,  1 Mar 2023 14:46:34 +0100
Message-Id: <20230301133937.24267-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=569; i=jack@suse.cz; h=from:subject:message-id; bh=IcYVg1sJILdwEK1Cs7v23jtTWw4ZD3RG/mlZdyVvgX8=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBj/1c0U3fpK4YgzuapB8hZAEtnZLvW1tG1j9EA3w+B Va4FspmJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY/9XNAAKCRCcnaoHP2RA2dTeB/ 0a3K2b2YwIVN8MwY1goy6fO7uoTQ0TolcgQE9P8Q5A/s660Xk+N/KkzB7pXjw4qJfoM5KwcPeQofgQ 7Wy8Hy6mCRRt6cvfJDNSfOBGIqSNqSPpKIajIGzAqgK/KMYWrFcEB4+iVv1pk728RITdz/JKQfwaMS DG10AHP2CQvKZWdg5rk8MIjcwRVihKGKk//tjDjoC8bg6A9tGb8OgvqXID+VF2xzfVpE4XTUnd/pBG o3z82BhmlMYX8ZOusqnviIIAewZCtL+WVmR+eiBZs7sn6d7zS6PDMh4i8VdNBinS1ncWb/v1IdmxVw LyZCh4Nwy0H1kewqZbcPj27XI8VDtM
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

Hello,

conversion of UDF to use the same address_space operations for normal an inline
(in-ICB) files had two bugs resulting in buffered reads / writes not really
working properly for in-ICB files. Interestingly none of the xfstests
discovered this (likely because files have to be small to fit within ICB and
you have to evict the first file page from the page cache to notice). I've
now verified with manual testing that read & writes to in-ICB files work
again after these fixes. I plan to push these fixes to Linus through my
tree soon.

								Honza
