Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87E15A9B8A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 17:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbiIAP1N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 11:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbiIAP0n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 11:26:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D218975CE6
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Sep 2022 08:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662045998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V7YMU843VlzNWC/pPcXDFCFCDg71epze0+Cwzb9ajlw=;
        b=g0g0vDEVHCnSMAYVt8KWC/tJLRLkxFcHwZdx0lfiwPK6uOQFJNtz1TTi8XX6AWIUtatVqt
        dfgGynX45eHIRVqyM7Ei3CAyxFlrL5uj2bQdcIZcrFuiMAutpybDJuVvZCcuHpVKxcCnnI
        hXsEu4j9f5t7qYktHobEDRrdEz38bPA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-341-CIfe35V_PHeVf1XHxXrSCg-1; Thu, 01 Sep 2022 11:26:37 -0400
X-MC-Unique: CIfe35V_PHeVf1XHxXrSCg-1
Received: by mail-ej1-f71.google.com with SMTP id dr17-20020a170907721100b00741a1ef8a20so5248175ejc.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Sep 2022 08:26:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=V7YMU843VlzNWC/pPcXDFCFCDg71epze0+Cwzb9ajlw=;
        b=6M5Z7FDYRViQpzY/JUHwyC6xWhRb3GcyQdIGJQ3KQ7GkhSSv6T/GnN1rKTm6vVjBYc
         irNJNPmXVsnuixK+uE4soHyMb/mVN4xTBtnqZHtTtdZ30uyGM7i/3P+EGfwJK8p7ckmy
         k+K+0KoZqcCPYwls9JpdfAaJsbhm0Rtvun5B0jmk4lWXcVt3K0sLLubrnaSXO5YvANHQ
         NMTsdxAtYvOLnuJ9re1BRyviO6ibhADmpjNd6MTsoeCCF8XCF2xZL77Qc5o/UItSk7aR
         Skcsu/3hIA/OVaTMnjc+Z120dSIavPRQI6ZHev8abJ6wNTC9YhA5TdOjNqWm6LjqEZcp
         jsVw==
X-Gm-Message-State: ACgBeo2GL3pnLQXjJwruKDWLUpT21SksC0lHwkJ/aJJVWvXOfPzM5LA1
        o9SGQX/yFke+IGvivs8wDJtXpZur7T0YMOC8Yy1bUBJ8Le11Gi52BBTgO+Ev6l79Vonr5nQqEy6
        lmLH1Pjy90Pj5lTO2qsQzZx4bQw==
X-Received: by 2002:a05:6402:2791:b0:448:763c:666f with SMTP id b17-20020a056402279100b00448763c666fmr16544847ede.36.1662045996602;
        Thu, 01 Sep 2022 08:26:36 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6IWwgCT5rUYou5fGNheuAznqzf2ytt4UDRtNcZDjDbVuQbEp4YWjiAyIYJGVUT6zs409BVUA==
X-Received: by 2002:a05:6402:2791:b0:448:763c:666f with SMTP id b17-20020a056402279100b00448763c666fmr16544831ede.36.1662045996400;
        Thu, 01 Sep 2022 08:26:36 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id o23-20020a170906775700b00730bfe6adc4sm8646031ejn.37.2022.09.01.08.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 08:26:35 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Pitt <mpitt@redhat.com>
Subject: [PATCH 2/2] fs: don't call capable() prematurely in simple_xattr_list()
Date:   Thu,  1 Sep 2022 17:26:32 +0200
Message-Id: <20220901152632.970018-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220901152632.970018-1-omosnace@redhat.com>
References: <20220901152632.970018-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Calling capable() pre-emptively causes a problem for SELinux, which will
normally log a denial whenever capable() is called and the task's
SELinux context doesn't have the corresponding capability permission
allowed.

With the current implementation of simple_xattr_list(), any time a
process without CAP_SYS_ADMIN calls listxattr(2) or similar on a
filesystem that uses this function, a denial is logged even if there are
no trusted.* xattrs on the inode in question. In such situation, policy
writers are forced to chose one of the following options:

1. Grant CAP_SYS_ADMIN to the given SELinux domain even though it
   doesn't really need it. (Not good for security.)
2. Add a rule to the policy that will silence CAP_SYS_ADMIN denials for
   the given domain without actually granting it. (Not good, because now
   denials that make actual difference may be hidden, making
   troubleshooting harder.)
3. Do nothing and let the denials appear. (Not good, because the audit
   spam could obscure actual important denials.)

To avoid this misery, only call capable() when an actual trusted.* xattr
is encountered. This is somewhat less optimal, since capable() will now
be called once per each trusted.* xattr, but that's pretty unlikely to
matter in practice.

Even after this fix any process listing xattrs on an inode that has one
or more trusted.* ones may trigger an "irrelevant" denial if it doesn't
actually care about the trusted.* xattrs, but such cases should be rare
and thus silencing the denial in such cases would not be as big of a
deal.

Fixes: b09e0fa4b4ea ("tmpfs: implement generic xattr support")
Reported-by: Martin Pitt <mpitt@redhat.com>
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 fs/xattr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index fad2344f1168..84a459ac779a 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -1155,7 +1155,6 @@ static int xattr_list_one(char **buffer, ssize_t *remaining_size,
 ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
 			  char *buffer, size_t size)
 {
-	bool trusted = capable(CAP_SYS_ADMIN);
 	struct simple_xattr *xattr;
 	ssize_t remaining_size = size;
 	int err = 0;
@@ -1180,7 +1179,7 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
 	rcu_read_lock();
 	list_for_each_entry_rcu(xattr, &xattrs->head, list) {
 		/* skip "trusted." attributes for unprivileged callers */
-		if (!trusted && xattr_is_trusted(xattr->name))
+		if (xattr_is_trusted(xattr->name) && !capable(CAP_SYS_ADMIN))
 			continue;
 
 		err = xattr_list_one(&buffer, &remaining_size, xattr->name);
-- 
2.37.2

