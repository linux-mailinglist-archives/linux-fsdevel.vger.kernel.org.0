Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E83D71B17CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 22:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgDTU67 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 16:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgDTU6O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 16:58:14 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FFBC061A0C;
        Mon, 20 Apr 2020 13:58:13 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id r26so1192501wmh.0;
        Mon, 20 Apr 2020 13:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oJ3c5qOQfz7hY1h+qnaRsaFeSzEi0ESCJo4fsW8HRog=;
        b=JeR5HjYyEmGmALLfAktwkQ2yJCEX90zhqS4fMYiZGpDGxy7ngv/NG3+jHScg47hJym
         VZ4G58jg4j6tZwSI793VYxsUlppJeLYh0sfKgdQJazlzTuDnsfQRi3nfGVLafZsHFoNP
         UNuKn4phDCyCxtcTJipdi5vRhXmRicCs5YzsenDO+MzQCtxweVuRF9cx4vBiG+s+NZlb
         ArssGsBFQJT6qww5Zmp+qLX5YzmLIaNfwAhP+FWhbShDDQqhoMQgkOyY2xM8xHv/HMwM
         5OwvfgY0zVFoVUUxbi/hgz91xamwsQvdu2DwmbjgkvSOibnBqAnG+1/qSxG3oW0G4JGQ
         C+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oJ3c5qOQfz7hY1h+qnaRsaFeSzEi0ESCJo4fsW8HRog=;
        b=hGzCgmiDgejGoPsEKwpsou1wfYLkZ4VH38JXqIsM1TdTra9GiDFvMkS9HVDCHaPWav
         1N6QMmpErjbbFk3FiQRV7NgjtB2yfWaNhyihUhn/2qEF+fxg9LvHICkVP5xX/6EAyXhx
         H60HoA/iYDYW61meKA8CQKguwbZrXz37RHM2r5CqZLg7xzJO3igWxCSiv6zp2D+Uu7p9
         9pjFdEW5iqsCuSoKiEJoafwFHSao1AHbBarhpjBoqWeLkFVTa5kZsUBGKCl2bfkIRRG6
         CQ8iRPIreivPPaHa/VOTlR+TJ9pK54ShG1lG7Naq5UKo30lEaqzwYRL3P/ZaX1dujBWu
         humg==
X-Gm-Message-State: AGi0PuZoN7VgXRMkgvgSz1hdAci1brovy4ivtd+0GlyZvtraOeyxbOxk
        lfwRWPnYKKrOOQk0B3qfAw==
X-Google-Smtp-Source: APiQypLc+yt2zpQLnK/oPplGke40lWtaNcp2XhWmBICE6UT5Q37a++RyKYNQxJLyxzVfr729LstgYA==
X-Received: by 2002:a1c:1b58:: with SMTP id b85mr1240849wmb.112.1587416291975;
        Mon, 20 Apr 2020 13:58:11 -0700 (PDT)
Received: from avx2.telecom.by ([46.53.249.74])
        by smtp.gmail.com with ESMTPSA id m8sm863069wrx.54.2020.04.20.13.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 13:58:11 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     adobriyan@gmail.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, pmladek@suse.com,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk
Subject: [PATCH 05/15] print_integer, proc: rewrite /proc/thread-self via print_integer()
Date:   Mon, 20 Apr 2020 23:57:33 +0300
Message-Id: <20200420205743.19964-5-adobriyan@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200420205743.19964-1-adobriyan@gmail.com>
References: <20200420205743.19964-1-adobriyan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 fs/proc/thread_self.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/proc/thread_self.c b/fs/proc/thread_self.c
index f61ae53533f5..c29d37e3bd28 100644
--- a/fs/proc/thread_self.c
+++ b/fs/proc/thread_self.c
@@ -15,14 +15,20 @@ static const char *proc_thread_self_get_link(struct dentry *dentry,
 	struct pid_namespace *ns = proc_pid_ns(inode);
 	pid_t tgid = task_tgid_nr_ns(current, ns);
 	pid_t pid = task_pid_nr_ns(current, ns);
+	char buf[10 + 6 + 10 + 1];
+	char *p = buf + sizeof(buf);
 	char *name;
 
 	if (!pid)
 		return ERR_PTR(-ENOENT);
-	name = kmalloc(10 + 6 + 10 + 1, dentry ? GFP_KERNEL : GFP_ATOMIC);
+	name = kmalloc(sizeof(buf), dentry ? GFP_KERNEL : GFP_ATOMIC);
 	if (unlikely(!name))
 		return dentry ? ERR_PTR(-ENOMEM) : ERR_PTR(-ECHILD);
-	sprintf(name, "%u/task/%u", tgid, pid);
+	*--p = '\0';
+	p = _print_integer_u32(p, pid);
+	p = memcpy(p - 6, "/task/", 6);
+	p = _print_integer_u32(p, tgid);
+	memcpy(name, p, buf + sizeof(buf) - p);
 	set_delayed_call(done, kfree_link, name);
 	return name;
 }
-- 
2.24.1

