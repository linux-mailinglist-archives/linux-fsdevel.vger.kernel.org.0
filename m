Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514216B0D47
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 16:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjCHPr7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 10:47:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbjCHPrl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:47:41 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0353929E
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Mar 2023 07:47:31 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 04E0721A58;
        Wed,  8 Mar 2023 15:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678290450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=GUV2wdfEcb8nMnFkCDkg2S4kFGWy3RLu5dN/dRToso4=;
        b=nLHBgFXw3Yj0H/vBa7Eny+DIV6oB06YzJ3Ud0KwUtIGmo1srtCg9fh7jdc0VtdTjXvdJ72
        JllcCR1acl+5/LQqVJCdd5IbrzuqhqHbS7O/Wp5NcpVVWulDz9h/1NRNGVovpQR9XSNy1Y
        JlJcQjHrTHUWu+pJE+m5NHOpNCL3nmU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678290450;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=GUV2wdfEcb8nMnFkCDkg2S4kFGWy3RLu5dN/dRToso4=;
        b=OZ9NDPC0GwWNTsRIbmX00aZGUt5Tx0cPi3ey0S4QwNcVlTrVhUAQzUE9gUIOchLastvl49
        e80zcsmf/jehtwDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EC7DF1391B;
        Wed,  8 Mar 2023 15:47:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IMmyORGuCGS6HQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 08 Mar 2023 15:47:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 586A0A06FF; Wed,  8 Mar 2023 16:47:29 +0100 (CET)
Date:   Wed, 8 Mar 2023 16:47:29 +0100
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] udf fixes for 6.3-rc2
Message-ID: <20230308154729.zes6jnivoawftrkd@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.3-rc2

to get three patches fixing bugs in the UDF caused by the big pile of
changes that went in during the merge window.

Top of the tree is 63bceed808c5. The full shortlog is:

Jan Kara (3):
      udf: Fix lost writes in udf_adinicb_writepage()
      udf: Fix reading of in-ICB files
      udf: Warn if block mapping is done for in-ICB files

The diffstat is

 fs/udf/inode.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

							Thanks
								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
