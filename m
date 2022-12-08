Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6D464709E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Dec 2022 14:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiLHNQF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Dec 2022 08:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiLHNQB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Dec 2022 08:16:01 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A4092FF0
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Dec 2022 05:16:00 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 50D173397E;
        Thu,  8 Dec 2022 13:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670505359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=6vYI4dxCtXFAZtJ/Bxnp8GPmXehOWe4KqbPlGvEzb74=;
        b=b4rsERPtO1mr1INNsOurE/efRSi4KykXphUnvSe8K7qPajYoi7uyIbBzQjoNWY9VYtWRt7
        eARv4zZde2UmJkQryTux7QGu06EOWNrbL25mnjfjp0hdOxde1IHNDxY1Oq0yjfpaWF9QCJ
        S4YOLaKLhZFW7ygpoizqQqqeZcdlD4A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670505359;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=6vYI4dxCtXFAZtJ/Bxnp8GPmXehOWe4KqbPlGvEzb74=;
        b=ZFBAZmnWzOlswkNDApobx46fObeDTGBasl/m5jzpxNtgHzPQniBRqLmGWhd9ioxFUXMjoK
        4QBU3F7vvsyfRQDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 45412138E0;
        Thu,  8 Dec 2022 13:15:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id y/JsEI/jkWNVTQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 08 Dec 2022 13:15:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B665FA0725; Thu,  8 Dec 2022 14:15:58 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 0/4] udf: Fix data corruption with fsx
Date:   Thu,  8 Dec 2022 14:15:47 +0100
Message-Id: <20221208131111.29134-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=409; i=jack@suse.cz; h=from:subject:message-id; bh=/B4Kxly8RJUqRLafOaNWbDESWmV5+FjaQ5U9WEBanSo=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjkeN8MW0ttL+kxgSASJ7XgaJreFWHE3bFEjOHejuH y4kSx5SJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY5HjfAAKCRCcnaoHP2RA2XQwB/ 9WmkjWKBRqLe3NBu6avr/DMejvJ02qt+inzljqRXj7bC4qCSG8oqLjVzQAWYXkw5TVgJR/20P6CSYk aFcj2Dq24kD7PF9TpHo363p79nlI9tKnpkMnjxNz4aFxmHW3mnyavdy+DjmsPWgo7eQn6x/gvLn+o0 ZU+BSi61jSrPc9KxP9zDIM/tHAcBeDZDdPNyuXrk38bD+kAcvyB0YVDnFKuQeBgo5jUnKx0megnJaM MFc005zIIkDdzayam1FYcFfBrXHLdNd87gMcEo1kX9JrvgUh2tiFPlesI5vvoJSG6gwg5p9mKpravb v76Bp5f46XihDhRKk7bGbJhT+yIjDL
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

when running fsx on UDF I've spotted several data corruption issues mostly
involving handling of holes and preallocation extents (which people usually
don't trip on because if UDF is used in RW mode, it is usually on USB sticks to
copy files in and out...). This series fixes them so fsx doesn't show any
more issues. Unless someone objects, I'll queue these fixes to my tree.

								Honza
