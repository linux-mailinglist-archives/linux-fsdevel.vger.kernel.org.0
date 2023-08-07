Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCE67725C7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Aug 2023 15:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbjHGNa7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 09:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234047AbjHGNan (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:30:43 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA061BF3
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Aug 2023 06:29:47 -0700 (PDT)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1589244281
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Aug 2023 13:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691414914;
        bh=ARhwDsiPa3Ci/G2xteJutduXCGuj42UUR3o8sfJhjpo=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=DrMmRgqdpSag4Jsz0m9QIh0IK7fxSty2QofN+/UoSuV9wtB+F5gqtTkoNYUq536V0
         f/qhrT5O3sdEn6/E2jNDFy3BiQ2S8nXncARkZ300zHE6/XyAf+cUOaMpGHDFLFM5iT
         wgbiAOPppQSZlYusCvpIEYxfvT37pEhPo+yklau7r3CeAQ46ud+vgLB82AY7DaRRgy
         sYeFHXjiHDeesOVo6/4i6Hi9PDHAugSIBez2uyCgVB5xr74rBBl/4P7bis9quVkfFe
         7TKEf8yNqN4zZs3kx9vbqgdyA5qF2q9AKZBI8tJO9L1O3OP7oQi00MgbLneE7kPELZ
         4eJEq/vpEvWTg==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-993eeb3a950so343976066b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Aug 2023 06:28:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691414913; x=1692019713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ARhwDsiPa3Ci/G2xteJutduXCGuj42UUR3o8sfJhjpo=;
        b=EVXSATz+jCCctYhhfBFdPGzi+xQYrf5/9guhEFz3MIE2cVyKcAFzUiPzOuB0Dh68Ms
         6m3CgfPenjwcgWBuztxC0WgmIogm9ORqSegYKarHkaoIpbjbkicQZBhZ3resVUJRkhHd
         HrNMIe6hzngJJkcjw+H2MtCec1JkdXxZfnhxie106GWIzMlBERRpp/AlJx+FjLlbTaah
         ZJ01fFq71va4ld5Kov8bHh0RpADkhtJywcujFqS2mi4jXPh41WWE3p8QR0VTjISPX6JW
         XN5f/xnj7wf8YnbsfylYgfByhiZWAsqGFYV+LzzOpiBPq7KI9qNzGDKou7i4Sv0Oiq/C
         HsUA==
X-Gm-Message-State: AOJu0YyddDzJp5h2yWgp7Y73fawWFGYSv5YFlrd56aLLCOr6Mw8hp9B8
        dHX0sDijhg7wFcu7OpdWbSzu0pKESwt3rjUe3m1y2k1UHoVas68/wNxwBIjfpAaPY9kl0v8KMRE
        tpOI6VpA1jxjrSmKpG9KDVhN51J1+bbey1M/pUgKckio=
X-Received: by 2002:a17:906:10cc:b0:98e:2097:f23e with SMTP id v12-20020a17090610cc00b0098e2097f23emr7419776ejv.77.1691414913481;
        Mon, 07 Aug 2023 06:28:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGltB/ZZoCQVwgCS4UTRIz0u73a/bCvTNvfAJknZZvuyuqC87rnvtadbkCLyDzGWG1RAK7amQ==
X-Received: by 2002:a17:906:10cc:b0:98e:2097:f23e with SMTP id v12-20020a17090610cc00b0098e2097f23emr7419770ejv.77.1691414913267;
        Mon, 07 Aug 2023 06:28:33 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id lg12-20020a170906f88c00b00992ca779f42sm5175257ejb.97.2023.08.07.06.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 06:28:33 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 10/12] ceph/acl: allow idmapped set_acl inode op
Date:   Mon,  7 Aug 2023 15:26:24 +0200
Message-Id: <20230807132626.182101-11-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807132626.182101-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230807132626.182101-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <brauner@kernel.org>

Enable ceph_set_acl() to handle idmapped mounts. This is just a matter
of passing down the mount's idmapping.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/ceph/acl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
index 89280c168acb..ffc6a1c02388 100644
--- a/fs/ceph/acl.c
+++ b/fs/ceph/acl.c
@@ -107,7 +107,7 @@ int ceph_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	case ACL_TYPE_ACCESS:
 		name = XATTR_NAME_POSIX_ACL_ACCESS;
 		if (acl) {
-			ret = posix_acl_update_mode(&nop_mnt_idmap, inode,
+			ret = posix_acl_update_mode(idmap, inode,
 						    &new_mode, &acl);
 			if (ret)
 				goto out;
-- 
2.34.1

