Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A949130922
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jan 2020 17:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgAEQiF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jan 2020 11:38:05 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35350 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgAEQiE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jan 2020 11:38:04 -0500
Received: by mail-pl1-f195.google.com with SMTP id g6so20925619plt.2;
        Sun, 05 Jan 2020 08:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:mime-version:content-id:date:message-id;
        bh=Sg2ZUGIhJpn7PCT7cRYcPKqWuxsP1DI8xKhNXhtGnP0=;
        b=pNcuamb2vrsA6l76Bv/eDPE8HH0sTuQUSDmCtxwNtcYQoxkQ6nGw/+qWCYntmeDMwj
         5ksbb5/NdBDyNTTvD4bi+dC8OHiYPu7g1tP4n4RR8lViiHO5oLl4LLSRMh/WI0K9ds8k
         ym83LTMqrwwluBaynYwXxygRMiM2G2fW9+SkYaGeoDclh1avlRAdLRuI2FrygBWqr3zA
         po+7pBE2WPYgrFRE9E8vtVxqg9J/y3DLg8FUItI7nY5XZj/eChPsqUbsklQpZJz5Wpx4
         XnVboQ6A480I/m2yBWRbIxECqjKeu6Gu5zDfJKPig6zgxr66LDs1kGQVdZ3N//66auDw
         C0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:mime-version:content-id:date
         :message-id;
        bh=Sg2ZUGIhJpn7PCT7cRYcPKqWuxsP1DI8xKhNXhtGnP0=;
        b=h7+FHjpYHnr0IVsc39tMDPoAeDMBnjizFXB9s2Flk2rtpEwknod2OTfmYtcQ/TbUca
         BKDBHnJL3m5CAqh0nyCqAm6uML9ck9Z67vb2b2nEfr7wz2pm+mSGM3ZGI2dXuZJLivUl
         KJ/TG1+KYGjKZSK8lKzADuFRd+a8CIz/btsWXeE6IVrV+AHlHtdh6HMbV+WlN64oCiny
         K51vR9d0STmZP2pGJDi14jU4X/Pe1l2IW4xZ8/xu0mQRgqpLpN4GilbhqlVvAt3uBSnL
         SXQswv7PjF2WZRvK/XyzuZDMG5pCGUoBntSehGevNbljBHlD0p0kWNATV1BwWVgYEeb2
         PGHQ==
X-Gm-Message-State: APjAAAUuCt2/aA5vU8tCVTQJ9cYnq5ngysOIyUJKbZpKIcBA8XSV4NPn
        vDUTlfYFo53U8nBqIjuj3jkC3yus
X-Google-Smtp-Source: APXvYqyGQs3fJOwyKi/FCliqHcHdHhgBDmx+hbNdDw8bU4P4GjbDIMhYKz27htAB/U3cP1YzICdGZA==
X-Received: by 2002:a17:90a:fa82:: with SMTP id cu2mr38836428pjb.109.1578242284166;
        Sun, 05 Jan 2020 08:38:04 -0800 (PST)
Received: from jromail.nowhere (h219-110-240-103.catv02.itscom.jp. [219.110.240.103])
        by smtp.gmail.com with ESMTPSA id r3sm75340960pfg.145.2020.01.05.08.38.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Jan 2020 08:38:03 -0800 (PST)
Received: from localhost ([127.0.0.1] helo=jrobl) by jrobl id 1io8ug-0007ZR-89 ; Mon, 06 Jan 2020 01:38:02 +0900
From:   "J. R. Okajima" <hooanon05g@gmail.com>
To:     trond.myklebust@hammerspace.com, bfields@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH]: nfs acl: bugfix, don't use static nfsd_acl_versions[]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <29103.1578242282.1@jrobl>
Date:   Mon, 06 Jan 2020 01:38:02 +0900
Message-ID: <29104.1578242282@jrobl>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Here is a patch to fix nfs acl.

J. R. Okajima

----------------------------------------
commit 8684b9a7c55e9283e8b21112fbdf19b4d27f36b7
Author: J. R. Okajima <hooanon05g@gmail.com>
Date:   Mon Jan 6 01:31:20 2020 +0900

    nfs acl: bugfix, don't use static nfsd_acl_versions[]
    
    By the commit for v5.2-rc1,
    e333f3bbefe3 2019-04-24 nfsd: Allow containers to set supported nfs versions
    the line to copy a value from nfsd_acl_version[] to static
    nfsd_acl_versions[] was removed.  It is OK, but nfsd_acl_versions[] is
    still set to nfsd_acl_program.pg_vers which means pg_vers has NULLs for
    its all entires and nfsacl stops working entirely.
    I am afraid the removal of static nfsd_acl_versions[] was just
    forgotten.
    
    Signed-off-by: J. R. Okajima <hooanon05g@gmail.com>

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 18d94ea984ba..7f938bcb927d 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -94,12 +94,11 @@ static const struct svc_version *nfsd_acl_version[] = {
 
 #define NFSD_ACL_MINVERS            2
 #define NFSD_ACL_NRVERS		ARRAY_SIZE(nfsd_acl_version)
-static const struct svc_version *nfsd_acl_versions[NFSD_ACL_NRVERS];
 
 static struct svc_program	nfsd_acl_program = {
 	.pg_prog		= NFS_ACL_PROGRAM,
 	.pg_nvers		= NFSD_ACL_NRVERS,
-	.pg_vers		= nfsd_acl_versions,
+	.pg_vers		= nfsd_acl_version,
 	.pg_name		= "nfsacl",
 	.pg_class		= "nfsd",
 	.pg_stats		= &nfsd_acl_svcstats,
