Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667B1705809
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 21:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjEPTyz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 15:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjEPTyv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 15:54:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44172C1;
        Tue, 16 May 2023 12:54:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDFA662CEE;
        Tue, 16 May 2023 19:54:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9AD0C433EF;
        Tue, 16 May 2023 19:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684266889;
        bh=ephEl7G1z6WaYBIJFTE6QgAOh66gp022Xrli5jHzoSg=;
        h=From:To:Cc:Subject:Date:From;
        b=VACMJeXaOUxjDd/zTMoPAoKSVlUW5gDq0LgnxtkgFDCThDHYTgDroPc41nWujY6kE
         LjqEA5Slpkyh3Q53xcmBsbv2aGDduxJf6KfDWi5iKCcYkauyYw0dsNv337jUWfrJsU
         5W72LjBi/AT2+qH6FNU57cshXnigtxGyCOD4q0yPxUacqQCyDmi9Krqm1IiVyl3De5
         YTUvQVVg9+CI07PNJrdyoiCyQV4YEwQlGxpCfnlnBFG21J3MiVzse0eNeCDshjdqkp
         FPVrQWF+aI/ldTpp+TyrxscFPebKm8p+Iq9uYQBSIe3QrjKnZa73yET9fqO3H30o38
         AOS1KFgp85Jrw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] fs: d_path: include internal.h
Date:   Tue, 16 May 2023 21:54:38 +0200
Message-Id: <20230516195444.551461-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

make W=1 warns about a missing prototype that is defined but
not visible at point where simple_dname() is defined:

fs/d_path.c:317:7: error: no previous prototype for 'simple_dname' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/d_path.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/d_path.c b/fs/d_path.c
index 56a6ee4c6331..5f4da5c8d5db 100644
--- a/fs/d_path.c
+++ b/fs/d_path.c
@@ -7,6 +7,7 @@
 #include <linux/slab.h>
 #include <linux/prefetch.h>
 #include "mount.h"
+#include "internal.h"
 
 struct prepend_buffer {
 	char *buf;
-- 
2.39.2

