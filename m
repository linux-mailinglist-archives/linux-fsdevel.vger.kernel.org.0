Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680AC580F38
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jul 2022 10:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238603AbiGZIjg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jul 2022 04:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiGZIje (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jul 2022 04:39:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B582F3B2;
        Tue, 26 Jul 2022 01:39:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B4A00374C5;
        Tue, 26 Jul 2022 08:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658824771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Vx26rEKV7MqSSzbR7MBXXd4/9NX9efq6khCfCJWSLgk=;
        b=Fz97wcTwZHidHvSwZP5uCrWGjuqrqNngLKF8PBdUBUiq+WF28xyNCYeqKtLAi5XAf+Y+Kv
        Hgz1g4hv7Yop/Ic6+Jl4waRgCjY6c3g3NJQNmuTWFR24ROVG5REUbQKNLdLS9QMXzCw5ko
        7gSw57vOyMVN3/KuWm1PzCTVxEeJ+Fw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658824771;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Vx26rEKV7MqSSzbR7MBXXd4/9NX9efq6khCfCJWSLgk=;
        b=QTbU84lvBp5BkLJWRfSf7NFJE6lHyts9tMKzKN+2GUUD+r6GJHh4v7ZAKyk8mNrKmyvBp6
        uZC5JuemPbVwJNDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 874F313A7C;
        Tue, 26 Jul 2022 08:39:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SLlAIEOo32LYDQAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 26 Jul 2022 08:39:31 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Petr Vorel <pvorel@suse.cz>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] exfat: Fixes for ENAMETOOLONG error handling
Date:   Tue, 26 Jul 2022 10:39:24 +0200
Message-Id: <20220726083929.1684-1-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
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

Hi,

this is a revised series for fixing the error code of rename syscall
as well as cleanup / suppress the superfluous error messages.

As an LTP test case reported, exfat returns the inconsistent error
code for the case of renaming oversized file names:
  https://bugzilla.suse.com/show_bug.cgi?id=1201725
The first patch fixes this inconsistency.

The second patch is just for correcting the definitions as bit flags,
and the remaining two patches are for suppressing the error message
that can be triggered too easily to debug messages.


thanks,

Takashi

===

v1: https://lore.kernel.org/r/20220722142916.29435-1-tiwai@suse.de

v1->v2:
* Expand to pr_*() directly in exfat_*() macros
* Add a patch to drop superfluous newlines in error messages

===

Takashi Iwai (5):
  exfat: Return ENAMETOOLONG consistently for oversized paths
  exfat: Define NLS_NAME_* as bit flags explicitly
  exfat: Expand exfat_err() and co directly to pr_*() macro
  exfat: Downgrade ENAMETOOLONG error message to debug messages
  exfat: Drop superfluous new line for error messages

 fs/exfat/exfat_fs.h | 18 ++++++++++--------
 fs/exfat/fatent.c   |  2 +-
 fs/exfat/misc.c     | 17 -----------------
 fs/exfat/namei.c    |  2 +-
 fs/exfat/nls.c      |  4 ++--
 fs/exfat/super.c    |  4 ++--
 6 files changed, 16 insertions(+), 31 deletions(-)

-- 
2.35.3

