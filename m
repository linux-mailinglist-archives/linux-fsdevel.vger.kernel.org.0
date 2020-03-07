Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC46617C9A0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Mar 2020 01:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgCGAUF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 19:20:05 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45852 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbgCGAUF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 19:20:05 -0500
Received: by mail-pf1-f193.google.com with SMTP id 2so1871754pfg.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Mar 2020 16:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=34J28lgHrpYhHjKOEF2LFXrP2R68/iu1HhoAglQIiu8=;
        b=j1sLhFYaHguaJXa97cYJ42mzQj+XxEOiLC8RHWmJdh65QSlxFjrxBP498kLkxgmGnZ
         guiewPA+UUcIG15xzS3RPoskofT39l8eZkbG5nMxs3/mZyDtfJI6Yez3lwWzuAgCnm+z
         4etgWiZOirvqtBmuG4qy8yK6L3fIwsx0AmhrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=34J28lgHrpYhHjKOEF2LFXrP2R68/iu1HhoAglQIiu8=;
        b=iQbosdBxae/B1xaNVQZh3+M8mcaCC+ECn5M9iURyGtBYZk9bBGhxpIF2sscHQWh6pG
         KArnBywf1rTGpwlS7JBWJbDCYXpT1H5nN50X/OXCInvsSKQkVuMwtXtmaHiasoKcVSK5
         zPueUwzImzAb4TZgCxntm9+7iVJGVphm4UGqmag93ubBTsR5EnYoEuTNZgPPJPCHAq/J
         scBPqD9AWf9w3fHX5m+T8mQetvEXFEgJo/iS5o0CVtjwi4AvMaJj20ZnDSIOP+r+aUlR
         RuNbyE7BGDBiD6w4LhY6CW+39vqCJzr0gDUFRX0b4ukq+xli7NI5+hkQ0NY5onvELAuv
         ui6A==
X-Gm-Message-State: ANhLgQ1QqtIvOPn8vxdIT+hym15kLaC2KNAZPNvLr4zurn3zSGB2UmSZ
        ABGzuoa1psZBTaIq6PCkz9jnIg==
X-Google-Smtp-Source: ADFU+vuzIIoftwyB2+mS5QJZvibeBUZGiH3Fg/M4pv/0zP7Xiq47/0vF+lo4/psqqym1fXDQXpqZ/w==
X-Received: by 2002:a63:fe0a:: with SMTP id p10mr5484311pgh.96.1583540404467;
        Fri, 06 Mar 2020 16:20:04 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v123sm11797272pfv.146.2020.03.06.16.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 16:20:03 -0800 (PST)
Date:   Fri, 6 Mar 2020 16:20:02 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs_parse: Remove pr_notice() about each validation
Message-ID: <202003061617.A8835CAAF@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This notice fills my boot logs with scary-looking asterisks but doesn't
really tell me anything. Let's just remove it; validation errors
are already reported separately, so this is just a redundant list of
filesystems.

$ dmesg | grep VALIDATE
[    0.306256] *** VALIDATE tmpfs ***
[    0.307422] *** VALIDATE proc ***
[    0.308355] *** VALIDATE cgroup ***
[    0.308741] *** VALIDATE cgroup2 ***
[    0.813256] *** VALIDATE bpf ***
[    0.815272] *** VALIDATE ramfs ***
[    0.815665] *** VALIDATE hugetlbfs ***
[    0.876970] *** VALIDATE nfs ***
[    0.877383] *** VALIDATE nfs4 ***

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/fs_parser.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index 7e6fb43f9541..ab53e42a874a 100644
--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -368,8 +368,6 @@ bool fs_validate_description(const char *name,
 	const struct fs_parameter_spec *param, *p2;
 	bool good = true;
 
-	pr_notice("*** VALIDATE %s ***\n", name);
-
 	for (param = desc; param->name; param++) {
 		/* Check for duplicate parameter names */
 		for (p2 = desc; p2 < param; p2++) {
-- 
2.20.1


-- 
Kees Cook
