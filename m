Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D036164EDD9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Dec 2022 16:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbiLPP1L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Dec 2022 10:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbiLPP1E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:27:04 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A9A60378
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Dec 2022 07:27:01 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 18140343DF;
        Fri, 16 Dec 2022 15:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671204420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Zomkq+XCr5C7TUGzNpiPa6STaltcrhp/fTLl9JEmsIA=;
        b=NcPeyTtuqUvk3xF7ECTpPRUFUN3rMPzDaOLJBcWFieBqeOAjYF7iRo8tsFvk3/LdyRHqTl
        yEFHXPdJFg3dxMDJ7oP6GRtWIZFqPms0vrlLuytF6EBPizoG2s7OspVjyaFbH7vpo8dQXw
        O/RE6NRKI4E93geme4PPE0YOuWizrkk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671204420;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Zomkq+XCr5C7TUGzNpiPa6STaltcrhp/fTLl9JEmsIA=;
        b=dztjIY9oahzlDOLjOJmSwcHvORAwN5un9OraN4gavZjQPGV8M3soqrYqBIXk+5y7Iysmsq
        bZTzVqCWKHCaa6Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D971D138FD;
        Fri, 16 Dec 2022 15:26:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2Y4KNUOOnGO2CAAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 16 Dec 2022 15:26:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6EB0EA0762; Fri, 16 Dec 2022 16:26:56 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 0/20] udf: Fix various syzbot reports
Date:   Fri, 16 Dec 2022 16:24:04 +0100
Message-Id: <20221216121344.14025-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=506; i=jack@suse.cz; h=from:subject:message-id; bh=BhJdercy5KeZ4bvLcUQglNVGexfV9kOIo0owzjDqcZI=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjnI2OmGX/iJHX5v6mrFoy4mbYJxKFyFmp/qVnuh1F QDzPiGGJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY5yNjgAKCRCcnaoHP2RA2b6DB/ 9PPvqdA10J4mxPT1KQkL5Tv6FG4UMocJYWQDKUdDcyDqj23L+uSrt4vcv2RE/r5Eubool2c6EFdPvy MfvPvgOmKI4EQS1va4u+XZc9eHQI9quK0r6MAtDhrtVPpXlZ35Li5PS7nAf78En8iE+GowwiGh0+iE MaquSlEhDLKUamyGH1tKAsriN0sT19bq4vH/U/7dlBBiZ/X/x+zRImihvlLEpnZgl0Y8Ajjh4nndTU yfFoWzbdCoqcY36YBPP7UOXZLca24DM+pijuzDvqAFy1LlrdxySRNKkvUK2Y6OGed3N/I++TLLeSz7 2X+4I2CsVrcobmiYeYc6ISdezNTujv
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

recently, syzbot evidently found an efficient way to fuzz UDF filesystem images
creating subtly corrupted directories which were causing all sorts of trouble
for UDF directory handling code. The code has already been rather convoluted
so it was not really easy to plug the holes syzbot found. The patch set
rewrites udf directory handling code to a more managable codebase and as an
side-effect also fixes several syzbot reports.

I plan to queue the patches to my tree.

								Honza
