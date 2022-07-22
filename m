Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7183B57E308
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 16:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbiGVO3b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jul 2022 10:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235094AbiGVO30 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jul 2022 10:29:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63689D511;
        Fri, 22 Jul 2022 07:29:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 018B3204D9;
        Fri, 22 Jul 2022 14:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658500161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=0G4xjEaairc/ku3Vspm2RXTqyzglibQcxUIE7phU3hY=;
        b=GQOaFwj0xtXpIVAUjObSSc4rnj0D6xZK8c1R001x+NYiw3eFBm1yJ55bgMLrR8t8A3CAnS
        pNIWBLCI/3F1BQnLU+5Z0fPrYBhIKdTpNPgmcvBdykxf5WjMUxWiGDPnarVOh4kp6p7IKl
        RjyIfBt1kyh8HT71LHw2DrGAvJrevzw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658500161;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=0G4xjEaairc/ku3Vspm2RXTqyzglibQcxUIE7phU3hY=;
        b=/aTy/zr3aHiqxnsdvFtiav8pcObFFEf/eJ1Ucsyltf0fGsPkX/yOhGfNidzhootSMoMnRT
        SECUlVyKl7AymgCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D0B8F134A9;
        Fri, 22 Jul 2022 14:29:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BBwQMkC02mJ7bwAAMHmgww
        (envelope-from <tiwai@suse.de>); Fri, 22 Jul 2022 14:29:20 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] exfat: Fixes for ENAMETOOLONG error handling
Date:   Fri, 22 Jul 2022 16:29:12 +0200
Message-Id: <20220722142916.29435-1-tiwai@suse.de>
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

this is a series for fixing the error code of rename syscall as well
as cleanup / suppress the superfluous error messages.

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

Takashi Iwai (4):
  exfat: Return ENAMETOOLONG consistently for oversized paths
  exfat: Define NLS_NAME_* as bit flags explicitly
  exfat: Expand exfat_err() and co directly to pr_*() macro
  exfat: Downgrade ENAMETOOLONG error message to debug messages

 fs/exfat/exfat_fs.h | 21 +++++++++++++--------
 fs/exfat/misc.c     | 17 -----------------
 fs/exfat/namei.c    |  2 +-
 fs/exfat/nls.c      |  2 +-
 4 files changed, 15 insertions(+), 27 deletions(-)

-- 
2.35.3

