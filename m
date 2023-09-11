Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6AA879B14F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 01:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbjIKUwV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236062AbjIKJuG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:50:06 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EB6E40
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 02:50:02 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1befe39630bso9369145ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 02:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694425802; x=1695030602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ZTXwNwx2asy91EMQXlbltwoITBr0NKqwsB4INdumqY=;
        b=UMiOGCTVQiuFQ6anleEsdS5CH2pEDZ4MJ5+1y9lsdnX+S/VVBqcEazgkGCExzeNeOL
         oqb8QbJKapCbJKBIm2YVt8GXr7tCAhyVHg6wu+BrFIkYbWFbjUz66hLOk2ufygQ80I01
         0pYVhTiJqAXluasvRyC26kHSMZQbG8TTxpyLldx189IGVMPkiqbHzLDXjizizGBmKidF
         VzQFfPzZ9w9sc93rt8LuMzvpxOL520Pe5gBAsn86CNNoLZf461LCNDbbyOJ5OdiVjs4U
         S/yCR3fR1AOJegizOmLssoRLoncu3QneFF0RxjuuVhAul7MKXkMrKkp2ZmxOMjSFUQr/
         ofdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694425802; x=1695030602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ZTXwNwx2asy91EMQXlbltwoITBr0NKqwsB4INdumqY=;
        b=lVYrPN/Ufbq9lRzMAAHoN/JIabjd307D9NxgbI9YjgqauZhIewcAZ+zeHtMHHnbkmi
         KKUEAdy3c+ltNGSmOsC/knbfGyJhlEUewl/6WCiK2cuXxEHX+hhP0YR+PXM4ONWdO8mf
         5g7yvSVCLzRZeW2Wp87hbOPzZrB6X/QRYww7IlozPTX/cGcgtmfxhsr+CdK11yBItZ+7
         QuZOIliZI6jk5kDAAIQIlh8lJu6LRiN/Qrv5nl+/HHAcFRRu8jHXLyd7H1X6xSSy6o3H
         ZfFb2BkL8VthoBDAIENixCp9NBdyAla+OEPyHBdIrLP3AZ26PzjwUWoEYIW3ERFvSsCI
         t9hA==
X-Gm-Message-State: AOJu0YziBG+9pNm+jwqNsZSlmoNlFuudodxr1q0aMrIYfu/XjQpckMmW
        IOZMVlkz88Gal+jwceoE2DoPsA==
X-Google-Smtp-Source: AGHT+IEkexmOMmPsZvWCanh2pWTN/2CGfh7wrAzfAIoePXtjWRgsy+zRfdte7qLYby2W0F9SEkI+cA==
X-Received: by 2002:a17:902:ced1:b0:1b8:a469:53d8 with SMTP id d17-20020a170902ced100b001b8a46953d8mr11188132plg.0.1694425801744;
        Mon, 11 Sep 2023 02:50:01 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id az7-20020a170902a58700b001bdc2fdcf7esm5988188plb.129.2023.09.11.02.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 02:50:01 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org
Subject: [PATCH v6 32/45] nfsd: dynamically allocate the nfsd-client shrinker
Date:   Mon, 11 Sep 2023 17:44:31 +0800
Message-Id: <20230911094444.68966-33-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
References: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In preparation for implementing lockless slab shrink, use new APIs to
dynamically allocate the nfsd-client shrinker, so that it can be freed
asynchronously via RCU. Then it doesn't need to wait for RCU read-side
critical section when releasing the struct nfsd_net.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: Chuck Lever <chuck.lever@oracle.com>
Acked-by: Jeff Layton <jlayton@kernel.org>
CC: Jeff Layton <jlayton@kernel.org>
CC: Olga Kornievskaia <kolga@netapp.com>
CC: Dai Ngo <Dai.Ngo@oracle.com>
CC: Tom Talpey <tom@talpey.com>
CC: linux-nfs@vger.kernel.org
---
 fs/nfsd/netns.h     |  2 +-
 fs/nfsd/nfs4state.c | 19 +++++++++++--------
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index ec49b200b797..f669444d5336 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -195,7 +195,7 @@ struct nfsd_net {
 	int			nfs4_max_clients;
 
 	atomic_t		nfsd_courtesy_clients;
-	struct shrinker		nfsd_client_shrinker;
+	struct shrinker		*nfsd_client_shrinker;
 	struct work_struct	nfsd_shrinker_work;
 };
 
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 8534693eb6a4..23b3b38c8cda 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4400,8 +4400,7 @@ static unsigned long
 nfsd4_state_shrinker_count(struct shrinker *shrink, struct shrink_control *sc)
 {
 	int count;
-	struct nfsd_net *nn = container_of(shrink,
-			struct nfsd_net, nfsd_client_shrinker);
+	struct nfsd_net *nn = shrink->private_data;
 
 	count = atomic_read(&nn->nfsd_courtesy_clients);
 	if (!count)
@@ -8149,12 +8148,16 @@ static int nfs4_state_create_net(struct net *net)
 	INIT_WORK(&nn->nfsd_shrinker_work, nfsd4_state_shrinker_worker);
 	get_net(net);
 
-	nn->nfsd_client_shrinker.scan_objects = nfsd4_state_shrinker_scan;
-	nn->nfsd_client_shrinker.count_objects = nfsd4_state_shrinker_count;
-	nn->nfsd_client_shrinker.seeks = DEFAULT_SEEKS;
-
-	if (register_shrinker(&nn->nfsd_client_shrinker, "nfsd-client"))
+	nn->nfsd_client_shrinker = shrinker_alloc(0, "nfsd-client");
+	if (!nn->nfsd_client_shrinker)
 		goto err_shrinker;
+
+	nn->nfsd_client_shrinker->scan_objects = nfsd4_state_shrinker_scan;
+	nn->nfsd_client_shrinker->count_objects = nfsd4_state_shrinker_count;
+	nn->nfsd_client_shrinker->private_data = nn;
+
+	shrinker_register(nn->nfsd_client_shrinker);
+
 	return 0;
 
 err_shrinker:
@@ -8252,7 +8255,7 @@ nfs4_state_shutdown_net(struct net *net)
 	struct list_head *pos, *next, reaplist;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
-	unregister_shrinker(&nn->nfsd_client_shrinker);
+	shrinker_free(nn->nfsd_client_shrinker);
 	cancel_work(&nn->nfsd_shrinker_work);
 	cancel_delayed_work_sync(&nn->laundromat_work);
 	locks_end_grace(&nn->nfsd4_manager);
-- 
2.30.2

