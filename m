Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9310F679787
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 13:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbjAXMSV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 07:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbjAXMSR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:18:17 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65EB37F02
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 04:18:15 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 877902188B;
        Tue, 24 Jan 2023 12:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674562694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=CkI2CbLTlbfchSG+TaO49TTKo3ZphBREcicyX5BFi2o=;
        b=ruZj3TGQiHNeeq4yhUQlAlo8aNa+lo7FmYQriT6IwiMccsg19fW1CjxsGc0FAEGxNX5Trq
        ubN62+NoTVcsceKg8l8WKUqyCmLyAg9vgJ7Ot1uJ2mww9xjvGawDk5EVUWanmYVO7ySSSV
        pE2FI9VxOWDcFjBAuYX+LMWok/cBtUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674562694;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=CkI2CbLTlbfchSG+TaO49TTKo3ZphBREcicyX5BFi2o=;
        b=TVQFjo9nOekjpdnaZPVagwQleWJ9aMqXRypvBoMcv0/Qjzn+I0vqIqON1Z8bzD+PKYZY4d
        1ACTguI5zYvfd5Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7A4D313A04;
        Tue, 24 Jan 2023 12:18:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1DYcHYbMz2PPNwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 24 Jan 2023 12:18:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 02D21A06B5; Tue, 24 Jan 2023 13:18:13 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 0/22] udf: Fix couple of preallocation related bugs
Date:   Tue, 24 Jan 2023 13:17:46 +0100
Message-Id: <20230124120835.21728-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=667; i=jack@suse.cz; h=from:subject:message-id; bh=mJJXb9qXqM439ozwvVXIA6UUEXORNFWgB9aA0FizOuI=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjz8xsrhE7H4CbxXllWk24w45jjSbR6bPswp/u84JB zKEfIUaJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY8/MbAAKCRCcnaoHP2RA2YdGB/ 0VEMECdcQgsjK9ZLXmchEtJezBZi98z/DhGvwU3vJw5j9O7mq/ZCsDMP2w1+cJfbMKSopPTUJ3P6Tp Kd/pUA/yUD7rtADA+wXXBeFJSVCOgDBMP/5MXSLbupR8899kP8CXlS5ORDcN+uExeWOS5S3WltQZyA rKuQi93hmGcOC4UhybvruWduUeb054VHj288aWVwZV1EfcQtq6AxqX8DeDbIRjDscD4vM06x+ri82N mhPqOWIh/hl0mrjp9Y4k485TiRU5C9Vse8UrK3O8mWQ1X4ezIQmcx8TiTkGpehVt5MEbRKjwToYI+m TAdv7uIy9SbM/PksQnPFzDWj5Nxp8O
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

fsx has revealed a couple of bugs related to preallocation handling in UDF.
Firstly, we were not properly cleaning up preallocation for files that
were dirtied via mmap, secondly, we didn't discard preallocation in some
cases when expanding file with a hole which later led to confusion and
data corruption. As part of these changes we start allocating blocks on
page fault time instead of at writeback time and we also cleanup block mapping
interfaces in UDF.

The patches are based on top of my for_next branch:

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs for_next

I plan to queue these patches to my tree.

								Honza
