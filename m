Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA2F7B3E58
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 07:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbjI3FEU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Sep 2023 01:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234245AbjI3FDm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Sep 2023 01:03:42 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55401BE;
        Fri, 29 Sep 2023 22:02:28 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-577e62e2adfso10221548a12.2;
        Fri, 29 Sep 2023 22:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696050148; x=1696654948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UNIhEufzQwgDPjs0KxNTWIPnnrU94TNvqQfHawN6Ek=;
        b=hjvt9rgdArJTKxAh3KZYRzCVF76mT/jhVvgVRswetn92DMW/ceiIkYAiA920AC3LBS
         48wonSkESEV0MClwYBzrAPVRNvFZvBu7lOkQgHTWkF6UT5xuj9MGKLmVxx5NMo53TaJW
         5mRxP02XwYgUYf2TAAmhDswS3V0hSmCQuEBOy0OPPAYVEJh6K5dVTC5CVeOtKwT25wvc
         lLsLs7XhBhNUCaH+WbDgqVxMjPPE5plxHojF9WFj7rsp3BdF1A3YkYhpQ1DTFcojQZ8y
         xuhd2ACHnzaxKLRpr9/+/RbYq818aDYlOYBtSx0C84m29GhNre64V3o0m7XU8HOA0DLp
         TCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696050148; x=1696654948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9UNIhEufzQwgDPjs0KxNTWIPnnrU94TNvqQfHawN6Ek=;
        b=M+smeOnQmx542mX/j7E1W+jpguBI7b2vZ6v6kAllnm14L0Y6IHzlYd0LsdOFlE+VoP
         znf2Vzl3UWMueJYVmetCMIfvd+yK2bIWT4OblCoiod4n1mwsp/TiHPBULLjcU9C1KxGr
         IQyq6gAOCaMuim88rpWlwkmRXChN1DPz1U58Y4DBfnrAO3DKTu65c9MEmkjG2BoAJL20
         85hJDEGXvzIem542DofSMEGwWXUSLfPR2vrK82CFqEElMMcGfzW7HjSHmn/JygqoqV9j
         62IgC+ezB9r1OzbR+OrVN9LnPBCwyDC+Lqf7pAhRJEj8RDxqUU5Y6kY6Ri+UX0dhzc3c
         jK/g==
X-Gm-Message-State: AOJu0YyUdQQH0RTIdVTe0VfkyWTVPaHp+j09t/gKfmVEI8lgw/sXnFBt
        DaHHgLZ6R6bwJgJtusx8n/k=
X-Google-Smtp-Source: AGHT+IGK8lZjKBjcRi0tEG6QuG+fRqfGeAdmvOQZdnvrwhwoxWP+occWiKHweWnohT8za84P1Nc9SA==
X-Received: by 2002:a17:902:e881:b0:1c4:4c10:6ae3 with SMTP id w1-20020a170902e88100b001c44c106ae3mr6845902plg.23.1696050148169;
        Fri, 29 Sep 2023 22:02:28 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id y10-20020a17090322ca00b001c322a41188sm392136plg.117.2023.09.29.22.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 22:02:27 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-unionfs@vger.kernel.org
Subject: [PATCH 27/29] overlayfs: move xattr tables to .rodata
Date:   Sat, 30 Sep 2023 02:00:31 -0300
Message-Id: <20230930050033.41174-28-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230930050033.41174-1-wedsonaf@gmail.com>
References: <20230930050033.41174-1-wedsonaf@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Wedson Almeida Filho <walmeida@microsoft.com>

This makes it harder for accidental or malicious changes to
ovl_trusted_xattr_handlers or ovl_user_xattr_handlers at runtime.

Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 fs/overlayfs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index cc8977498c48..fe7af47be621 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -477,13 +477,13 @@ static const struct xattr_handler ovl_other_xattr_handler = {
 	.set = ovl_other_xattr_set,
 };
 
-static const struct xattr_handler *ovl_trusted_xattr_handlers[] = {
+static const struct xattr_handler * const ovl_trusted_xattr_handlers[] = {
 	&ovl_own_trusted_xattr_handler,
 	&ovl_other_xattr_handler,
 	NULL
 };
 
-static const struct xattr_handler *ovl_user_xattr_handlers[] = {
+static const struct xattr_handler * const ovl_user_xattr_handlers[] = {
 	&ovl_own_user_xattr_handler,
 	&ovl_other_xattr_handler,
 	NULL
-- 
2.34.1

