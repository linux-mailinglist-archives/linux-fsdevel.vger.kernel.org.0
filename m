Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C256B653E1C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Dec 2022 11:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235295AbiLVKQY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Dec 2022 05:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235257AbiLVKQS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Dec 2022 05:16:18 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8DB64E7
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Dec 2022 02:16:17 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 870A44505;
        Thu, 22 Dec 2022 10:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671704174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=qPMzuztYQzMF24kB+/3l7Y63wHy8ObryHtBexy1wadQ=;
        b=1Y6MJxrRxcpKvtWghDI0Zo/w4unCSaE66jFsXygKg+KI58a/i4aNC04yZpwBlV6IX6qvwA
        0wBZWU3lgc1rZbQK5UJBUe1T/JERANa/zbTBrXyKNMalc88HSy05wjvsWKNKZJxhONoma2
        WKWOUhAShOW9OEAP2UT14l6Z2YE15Jk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671704174;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=qPMzuztYQzMF24kB+/3l7Y63wHy8ObryHtBexy1wadQ=;
        b=vNwGEVSFOHOnezYS2zh1AAL5U3sHmJDsXlTbaJbEM4kk7d4Lv7tbmWUqZcsxdC0wiOQBwd
        w+SrrPJxRrzAUTDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 633831391B;
        Thu, 22 Dec 2022 10:16:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UnCKF24upGMvWwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 22 Dec 2022 10:16:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 06BCAA0732; Thu, 22 Dec 2022 11:16:12 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 0/7] udf: Couple more fixes for extent and directory handling
Date:   Thu, 22 Dec 2022 11:15:57 +0100
Message-Id: <20221222101300.12679-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=269; i=jack@suse.cz; h=from:subject:message-id; bh=65BD8UxLBVMYbE7D2U7Lt31ZE7XkN5JuMinwO4CEpJ4=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjpC5XGtHTHfle9WAMq/t767/ZGQE2GCXWQDBtvbui SqlVdTWJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY6QuVwAKCRCcnaoHP2RA2a2ECA DNF8D0JWYHjHLoVQoTDhUSrSQKZBV0So5bF6KiSMXQME/hwxP/A/wOwqPM20SeChf95E2J22Tmvi3G w8bZSjyWUcElL5WErakMbAnwL/OaQUmnXc1JBDmv+5wHhQMWQ5JToCBJEDJSAFKvzOt8UuGo23ysf+ Gz8igoEKdM7ANpYvMqHV82U64t2oM7s9iJo38sgAuNJi07dYAR7WeeuijgtDstrJfjx+5WX7nmopYc X/l0SqZ8mFKzknDlept4708jfC9xHyZZEaIQKfb2X0DIHPM9squseNEGkPftvhRuldOtKmcRJgS8c/ 0iA/wDuMGHsg+ReTs6cO5wum6Cci5x
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

these patches fix couple of problems with handling of errors when filesystem
goes out of space while adding indirect extents to the file and also reduces
stack usage for directory iteration code.

I'll merge these fixes through my tree.

								Honza
