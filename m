Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56CCA954E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 05:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbfHTDOZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Aug 2019 23:14:25 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:37373 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728890AbfHTDOZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Aug 2019 23:14:25 -0400
Received: by mail-pf1-f172.google.com with SMTP id 129so2435048pfa.4;
        Mon, 19 Aug 2019 20:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K4of2PnnHi951vdKUeK2K+sxyHzoe/hoiqAy/eVEirM=;
        b=qnvx2lkhaPKZ2PX5FAyasqmmW2NoOyz64n3FGHz179t53oPUjxZUlnwbnIk+4Dlg3D
         EzguXrsYM8ygUZVVDCwCFcdo/++fB2CYHoLBUbn3WUEqKpQhN1+UTg5OpFs1B18ai88u
         3v1SzY7sxLZQFdWWUYgFwNh3giTFWs3V9tuVqjLxgZTxsXGT5wbirhQd2czpspT5FoNL
         ibmdQmM2egXzqR1sqZU/Hu66LpSBAIosjOCr6WLfQJtNJKEMZPuz2fDM1qzHWI7nr6nU
         sT+WvHPw5Y5bSv8PuGW2oXUaxI3njyq7YSYoplv4frx38erw+my9Z7S0Lh6ELbGgpW8q
         brug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K4of2PnnHi951vdKUeK2K+sxyHzoe/hoiqAy/eVEirM=;
        b=B1MJF1536wQUwJFADj/eUxhalDpaVj1x4nk8SxJBGsJqdYyk0bLPRevyQVLTBpt/qO
         ZUHEmlxaNzsnrz8n9lyjrdpbvMENcIMSVWk+6SnY3ooMiswfQ0KpniDZcbakICMvItf4
         eep52MiVZOnrQGd0bA+CEcK8veEEsykb3r6Pc+PUHGttvaGJb7B0v/QJUroKSMZ4lzZa
         CZCV1G0V1DTR3Omj9fsGgr/SE1xxZAMUaZpSZD1hxjOXjMzf4yuE0QYggTdnbvDiN8m7
         XGAu8xzUSzBIXS5w0BKdzSAiVlFBj0hMTe8IQXNxA8YOUyTLgbDLXWriDnE1mosMGkc0
         5/gA==
X-Gm-Message-State: APjAAAUY8ou/Xb4iTn1vig+etKryCP0WebBSamHRHv1x7S2eblac7p9d
        bE5/6WR61w7wmVazHjr+ZEs=
X-Google-Smtp-Source: APXvYqz9a/3SyryqSwUMcB7DFqYmpTTlG+WpK9xSoJbY4pJWLd2w/rkmZkHdR5wOYLwXn7nrZmj2Kg==
X-Received: by 2002:a65:52c5:: with SMTP id z5mr22933012pgp.118.1566270864801;
        Mon, 19 Aug 2019 20:14:24 -0700 (PDT)
Received: from localhost.localdomain ([175.223.16.125])
        by smtp.gmail.com with ESMTPSA id y16sm22979651pfc.36.2019.08.19.20.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 20:14:24 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCHv2 2/2] i915: do not leak module ref counter
Date:   Tue, 20 Aug 2019 12:13:59 +0900
Message-Id: <20190820031359.11717-2-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190820031359.11717-1-sergey.senozhatsky@gmail.com>
References: <20190820031359.11717-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Always put_filesystem() in i915_gemfs_init().

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 - v2: rebased (i915 does not remount gemfs anymore)

 drivers/gpu/drm/i915/gem/i915_gemfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i915/gem/i915_gemfs.c b/drivers/gpu/drm/i915/gem/i915_gemfs.c
index 5e6e8c91ab38..0a398e1e45fc 100644
--- a/drivers/gpu/drm/i915/gem/i915_gemfs.c
+++ b/drivers/gpu/drm/i915/gem/i915_gemfs.c
@@ -30,6 +30,7 @@ int i915_gemfs_init(struct drm_i915_private *i915)
 	 */
 
 	gemfs = kern_mount(type);
+	put_filesystem(type);
 	if (IS_ERR(gemfs))
 		return PTR_ERR(gemfs);
 
-- 
2.23.0

