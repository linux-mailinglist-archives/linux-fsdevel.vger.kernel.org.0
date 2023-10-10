Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E46C7BFA1F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 13:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjJJLon (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Oct 2023 07:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjJJLom (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:44:42 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35308A9
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 04:44:39 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4053c6f0db8so51643225e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 04:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696938277; x=1697543077; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dehdlhg2EDwAJUL11rByCk36xUEuX6DKabhCiiZaKfI=;
        b=CWQ8u4/4H5SqKV/8wYlGQcGwFjxxOj7G6aJWHKlgqeqDcTD2w4JDuUXDbaVVXiLrWQ
         WnKF8vFT5YWIHRuHYZ5upZcLcnPNKSbJex3YdFIsbbbi54nUExewe2GkiS41ebN+/4Nx
         29E9rbyXC0S9L+YyiiMcebXgmHdlTgbXYsx/Ea4/Gwgs9tZWp3VUD5HaHP6tHAjk9L+9
         /J41RX26JPKvjiQmM3o2cOnDVXZlQ1ks8rI4hO3oaSNaksvy/ns4g67ICfC5vO4xcxTA
         rg1l4o72bHlhiXfVwqWyCd9qRRwdHWflVmy266/aT8Jx8Rv62JTxRNNl5hKSywq1djJU
         Xq8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696938277; x=1697543077;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dehdlhg2EDwAJUL11rByCk36xUEuX6DKabhCiiZaKfI=;
        b=UoD05M3Uf53t7m5yk1viINO1G/+Vimv/B+J2/b+cO71oBRkrmogmbXQvRZBSgxCjry
         +Af1SfIAQp9BcXImZYlfsv+oCb7iK61HsI0+UbXJ62Un7TJlLPmom/8vQ/ODMW3aOdbD
         mEuAs/UxTLBKPCCgQXWGfd/On0uqtlpEqIlNW0hqnJnkagy4R2hvOW+hkMDPsgGYeSFl
         YhjeIXWZmgvGctUJLrHBLy8NvjWKXeqDxSHPbRVu2fSWsl0VS3wWfPRXd03/24nDcFeG
         QII6Ds5YLtep/Gi6AfmcoxlaNgMkR6wBvw79LO3w+q3LZetAwRRABAIoIQGWoYmefeCP
         EbTg==
X-Gm-Message-State: AOJu0Yyz+WCpiD21eSBcmUYf8J/lHxNIVmGnGYzdfVKmN3laRDGd2dxx
        53jKCUikixo2nTq9fGoMeA==
X-Google-Smtp-Source: AGHT+IE50xl1/Jv/PZqQLZh3jblTd3whvFqfuBZA6Lsz1mrKBWIHY9nwiQ+f9J+4mfDcEs1ZXj/B7Q==
X-Received: by 2002:adf:f1cb:0:b0:31a:d6cb:7f9e with SMTP id z11-20020adff1cb000000b0031ad6cb7f9emr13393600wro.21.1696938277410;
        Tue, 10 Oct 2023 04:44:37 -0700 (PDT)
Received: from p183 ([46.53.254.83])
        by smtp.gmail.com with ESMTPSA id m15-20020adfe94f000000b0031984b370f2sm12453872wrn.47.2023.10.10.04.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 04:44:37 -0700 (PDT)
Date:   Tue, 10 Oct 2023 14:44:35 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Matthew Bobrowski <repnop@google.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] fanotify: delete useless parenthesis in FANOTIFY_INLINE_FH
 macro
Message-ID: <633c251a-b548-4428-9e91-1cf8147d8c55@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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

Parenthesis around identifier name in declaration are useless.
This is just "put every macro argument inside parenthesis" practice.

Now "size" must be constant expression, but using comma expression in
constant expression is useless too, therefore [] will guard "size"
expression just as well as ().

Also g++ is somewhat upset about these:

	fs/notify/fanotify/fanotify.h:278:28: warning: unnecessary parentheses in declaration of ‘object_fh’ [-Wparentheses]
	  278 |         struct fanotify_fh (name);

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/notify/fanotify/fanotify.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -275,9 +275,9 @@ static inline void fanotify_init_event(struct fanotify_event *event,
 
 #define FANOTIFY_INLINE_FH(name, size)					\
 struct {								\
-	struct fanotify_fh (name);					\
+	struct fanotify_fh name;					\
 	/* Space for object_fh.buf[] - access with fanotify_fh_buf() */	\
-	unsigned char _inline_fh_buf[(size)];				\
+	unsigned char _inline_fh_buf[size];				\
 }
 
 struct fanotify_fid_event {
