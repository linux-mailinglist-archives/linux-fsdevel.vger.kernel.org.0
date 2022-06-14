Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B248C54A988
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 08:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352019AbiFNGet (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jun 2022 02:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbiFNGes (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jun 2022 02:34:48 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEAB2F657
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jun 2022 23:34:47 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id i1so6981150plg.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jun 2022 23:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:references:to
         :cc:in-reply-to:content-transfer-encoding;
        bh=skhpWdz/fVr5Z4eL8Xj0/NttsCVeBDmRP9w0g3/Whag=;
        b=n69xLhdnFBVD/mcAfXKXlmHjIZVMxn/jpE+0WcQVD5bHzB6SRmnaMOnnpQ5fOTQ9Qf
         ltWsIcvXS97GNnnrcJLc+WjZFJvqbUaOKU1VQ7VYRpcwJvlF6J1boCWLAp3eTkMNXEp0
         lStAB8cE4yXkRsgUX9BLzqALcs5FtLTtG9VAtIsiNSgxVYzj33Gt2fd9pxfCwLEas0pW
         gbffQYN91qk11OAYPvc8/HK5U4g4YQumghRpARQiR9OrLoucl2AAYMHe6RyHJWHzcGYd
         GQgGdm4EGRWSbmjR5VCzzHwtrNof69Lu2YDzST2YX4VIW7EmTa9JKVL3K4Fi12XHe2iY
         nkTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:references:to:cc:in-reply-to:content-transfer-encoding;
        bh=skhpWdz/fVr5Z4eL8Xj0/NttsCVeBDmRP9w0g3/Whag=;
        b=jd0WXU4f9u3RYamx8w1RMKElvY+Y+6bAy5k1CYtzqkpO94BCU6qYNpVpSnR6w5BIMG
         5Yyi93i56W1O+bWZwibPMDyQyJ4sj14S3f1bZiIu3GMR9J4jtL6oGe0EDSfwgOlpT2p2
         Bhjv6PLy6HNJcM/PY6qgTIEyuMq2vP8hhTuJuG2QHxHbJT7GvdAMfvDYQyzaEoCKq9LM
         wSXFfzlDdlZVh0CzVKyJCrZrA+LuSTTpx1jajdDSFT6sOooYNGofVOz0nfHcyIbh6NfV
         /l9MBDXoQq1UvYX5C/CUtlI1M/MLhyrwDNcgySFbn/de8tb/HrJIF/GOHLmurEFNpI10
         Ku5g==
X-Gm-Message-State: AJIora9RlDPXHp+uOKu1kRH329y5Xw/APD/xv9e1CRi/ayzv8AJqbJNn
        UwXi2IA036/Bpf0/2pggshkexxPNlzgpAA==
X-Google-Smtp-Source: AGRyM1uEWpuqApQ0YFIqPF26m4yeyOyFetT/gzggOr8wuWGCa0nbZWfha1AghEBVfB+9NYDL7BJdRQ==
X-Received: by 2002:a17:902:b784:b0:168:b8ee:a27f with SMTP id e4-20020a170902b78400b00168b8eea27fmr2722444pls.107.1655188487024;
        Mon, 13 Jun 2022 23:34:47 -0700 (PDT)
Received: from [10.4.226.233] ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id t4-20020a1709027fc400b00163fa4b7c12sm6317799plb.34.2022.06.13.23.34.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 23:34:46 -0700 (PDT)
Message-ID: <275d80bb-2f14-58c3-e829-119c88bf18f9@bytedance.com>
Date:   Tue, 14 Jun 2022 14:34:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
From:   Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH 1/1] cachefiles: Add a command to restore on-demand requests
References: <0a015f53-00f1-57d0-bca3-74cd7db8ed2e@bytedance.com>
To:     dhowells@redhat.com, Jeffle Xu <jefflexu@linux.alibaba.com>,
        xiang@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-erofs@lists.ozlabs.org, zhujia.zj@bytedance.com,
        chao@kernel.org
In-Reply-To: <0a015f53-00f1-57d0-bca3-74cd7db8ed2e@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


In on-demand read scenario, as long as the device connection
is not released, user daemon can restore the inflight request
by setting the request flag to CACHEFILES_REQ_NEW.

Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
---
  fs/cachefiles/daemon.c   |  1 +
  fs/cachefiles/internal.h |  3 +++
  fs/cachefiles/ondemand.c | 25 +++++++++++++++++++++++++
  3 files changed, 29 insertions(+)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 5956bf10cb4b..280104171996 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -77,6 +77,7 @@ static const struct cachefiles_daemon_cmd 
cachefiles_daemon_cmds[] = {
  	{ "tag",	cachefiles_daemon_tag		},
  #ifdef CONFIG_CACHEFILES_ONDEMAND
  	{ "copen",	cachefiles_ondemand_copen	},
+	{ "restore",	cachefiles_ondemand_restore	},
  #endif
  	{ "",		NULL				}
  };
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 6cba2c6de2f9..402f552a9756 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -289,6 +289,9 @@ extern ssize_t 
cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
  extern int cachefiles_ondemand_copen(struct cachefiles_cache *cache,
  				     char *args);

+extern int cachefiles_ondemand_restore(struct cachefiles_cache *cache,
+				     char *args);
+
  extern int cachefiles_ondemand_init_object(struct cachefiles_object 
*object);
  extern void cachefiles_ondemand_clean_object(struct cachefiles_object 
*object);

diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 2506e6d56965..0d0ed82f4814 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -174,6 +174,31 @@ int cachefiles_ondemand_copen(struct 
cachefiles_cache *cache, char *args)
  	return ret;
  }

+int cachefiles_ondemand_restore(struct cachefiles_cache *cache, char *args)
+{
+	struct cachefiles_req *req;
+	XA_STATE(xas, &cache->reqs, 0);
+
+	if (!test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags))
+		return -EOPNOTSUPP;
+
+	if (test_bit(CACHEFILES_DEAD, &cache->flags))
+		return -EIO;
+
+	xas_lock(&xas);
+	/*
+	 * Search the requests that being proceessed before
+	 * the user daemon crashed.
+	 * Set the CACHEFILES_REQ_NEW flag and user daemon will reprocess it.
+	 */
+	xas_for_each(&xas, req, ULONG_MAX) {
+		if (!xas_get_mark(&xas, CACHEFILES_REQ_NEW))
+			xas_set_mark(&xas, CACHEFILES_REQ_NEW);
+	}
+	xas_unlock(&xas);
+	return 0;
+}
+
  static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
  {
  	struct cachefiles_object *object;
-- 
2.20.1

