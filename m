Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7D54971D1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jan 2022 14:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236442AbiAWN6j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Jan 2022 08:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbiAWN6j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Jan 2022 08:58:39 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB843C06173B;
        Sun, 23 Jan 2022 05:58:38 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id l5so34585607edv.3;
        Sun, 23 Jan 2022 05:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=95TazuZQsQAb+6+Cyn0Q0lj2p+IE58JHP/Lpdw7ffK8=;
        b=efMzwR2tClrVr3brfSTRr+G73je8UTrP3vx0tDzw+VCmWGzQIRkBbd7F024hmuY7BG
         0IVBQA0tjZRWFMEmlqOVdo/bMQ1vtBBrmxawXfe4iMaAHUSVMpp51/U+SVXzi1kHwKh2
         URBDzGT70YIT29f5ca2+b8Zeuw5/QJQbeUhXUlAMnW/Jm3rvV3B70k+xkt1M5WrBDKMd
         IHjxQ5OTD3YZv1sRmWYcMBBS2hFsvI7jMwZh5U7gAmhydnNkbBbw0dgmK+Tzk45GHFJt
         5u7bz5g+Cy/lU16UogB6vWiXhFtlRh6bpx+XjO4JGawmbNIMRSWnNk2wSMEMpuUpQH6p
         697g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=95TazuZQsQAb+6+Cyn0Q0lj2p+IE58JHP/Lpdw7ffK8=;
        b=6Dd/Xiw+jSeDCwX5UkPpwq7CRFwKPrhooySRfoSgMHOHTm2mntDh+ozdKLjtJ5KPBY
         t33WEoNFcXGPkV7wHSLc+NpLklk06tj+gjWSwOv5kkb4RtgMmGzduWw3ynrPPWJp2c+b
         Df5/+fZ9xcIjeHC6xDxPO37YaQCsxQ5fvtHzALrt103B8FhK5EWtmJdaWTt4j83q0JYk
         vT486dV5fvNLfVMfs1EQsgxFLH15gNoT0/WJ8r0FPR6qeHCNyZ+7Vivtj5K2rZtiIKuy
         A2qqjhxZkm4wQ8aHrNoKxLjJTRt2ChkHRm0ROLLjlvTB9JowkEnMkkQ2f2FlmNbKl3ww
         x4Vw==
X-Gm-Message-State: AOAM532spLTiiDX8tIBr33uokc1l8sdNNClp/iUx8nd7TdnU+IZsFt/h
        vm5daYzAPKk1UGoMqzBnta/WHs9HWg==
X-Google-Smtp-Source: ABdhPJwTjIp5EcAnrbSKUGrz0qUthK4X5rBWJUKfcOoMToyw8eevp0ZvscaxYOxpce3qbLWRYnI7nw==
X-Received: by 2002:a05:6402:50d3:: with SMTP id h19mr11670245edb.346.1642946317280;
        Sun, 23 Jan 2022 05:58:37 -0800 (PST)
Received: from localhost.localdomain ([46.53.248.28])
        by smtp.gmail.com with ESMTPSA id ch27sm960587edb.74.2022.01.23.05.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 05:58:36 -0800 (PST)
Date:   Sun, 23 Jan 2022 16:58:35 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     christian.brauner@ubuntu.com, keescook@chromium.org,
        jamorris@linux.microsoft.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hao Lee <haolee.swjtu@gmail.com>
Subject: [PATCH v2] proc: alloc PATH_MAX bytes for /proc/${pid}/fd/ symlinks
Message-ID: <Ye1fCxyZZ0I5lgOL@localhost.localdomain>
References: <20220123100837.GA1491@haolee.io>
 <Ye1eZ5rl2E/jy8Tk@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ye1eZ5rl2E/jy8Tk@localhost.localdomain>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Hao Lee <haolee.swjtu@gmail.com>

It's not a standard approach that use __get_free_page() to alloc path
buffer directly. We'd better use kmalloc and PATH_MAX.

	PAGE_SIZE is different on different archs. An unlinked file
	with very long canonical pathname will readlink differently
	because "(deleted)" eats into a buffer.	--adobriyan

Signed-off-by: Hao Lee <haolee.swjtu@gmail.com>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/base.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1764,25 +1764,25 @@ static const char *proc_pid_get_link(struct dentry *dentry,
 
 static int do_proc_readlink(struct path *path, char __user *buffer, int buflen)
 {
-	char *tmp = (char *)__get_free_page(GFP_KERNEL);
+	char *tmp = (char *)kmalloc(PATH_MAX, GFP_KERNEL);
 	char *pathname;
 	int len;
 
 	if (!tmp)
 		return -ENOMEM;
 
-	pathname = d_path(path, tmp, PAGE_SIZE);
+	pathname = d_path(path, tmp, PATH_MAX);
 	len = PTR_ERR(pathname);
 	if (IS_ERR(pathname))
 		goto out;
-	len = tmp + PAGE_SIZE - 1 - pathname;
+	len = tmp + PATH_MAX - 1 - pathname;
 
 	if (len > buflen)
 		len = buflen;
 	if (copy_to_user(buffer, pathname, len))
 		len = -EFAULT;
  out:
-	free_page((unsigned long)tmp);
+	kfree(tmp);
 	return len;
 }
 
