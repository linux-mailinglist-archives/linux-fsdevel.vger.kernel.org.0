Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60EE1C46C8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 21:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgEDTI6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 15:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726377AbgEDTI6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 15:08:58 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2892CC061A0E
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 May 2020 12:08:58 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id j21so211962pgb.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 May 2020 12:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Zrx3KcYEt5bVqdNCWLI716yOCASV0eftVoL6kM8jlEE=;
        b=IEU5IwMxFtRk3KIEubc7CSarG2e5aA3KYJVCBlu5RFT6cG8AIhTu/rNtCCVcZhY5Mc
         6psUHFRL28vexVfV1Tp5r/wPpyt9Hv9eV4SW3rmUcmmF0Nj+SDXwV9JJpUl8SbDeFl4s
         X+OaxkcLd2hZyiZtGCIkCm8VLdQE1QArMAS8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Zrx3KcYEt5bVqdNCWLI716yOCASV0eftVoL6kM8jlEE=;
        b=qgWV9npgcDns3FFMB0yOXfjLrPkv9M2Sem6lAQp4FC4SV+3qlzv81wEJi8GJl6Sz5a
         07jULTJpuwZ0Bf6c2BxeQ2/gQ/7PuqHC3H8jp5cTdkZayq3fEjIBcg6FzX7We1kzAcdk
         by34LyBztDXDYrdJoyxZNfSMS431+9Itl18zG1u+dhXR/vRiQEWRhgGqqUtnId6EahVo
         Y5AQz0+cro2L4GCNs7NuAP4stG/LAHTOXqapzWvQ1e8IpNruKXf66Pc/bnk98TpDWkXs
         ePJmt8FtR3e6w17Gla5r9zEUFfFmg/mEoQCKbITFl7yof4QW3hIy4F8TMwvb5qib5DFT
         M+YQ==
X-Gm-Message-State: AGi0Pua2A2XkLnQ5sT26Av1OIHL6VnSi+6Qe6RYdMVDATzRbOOE7aT5p
        hdYPpd+AjjYkU1gFUYhQIYeNxQ==
X-Google-Smtp-Source: APiQypK4ozjl+LdphG8sRjiK+3521UTvXFxbtTSfBtQdVv4J5SnSauPrkUIQ1A1bSi3nL/QSZDKBJA==
X-Received: by 2002:a63:df0a:: with SMTP id u10mr410764pgg.79.1588619337719;
        Mon, 04 May 2020 12:08:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d18sm9498013pfq.177.2020.05.04.12.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 12:08:56 -0700 (PDT)
Date:   Mon, 4 May 2020 12:08:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sysctl: Make sure proc handlers can't expose heap memory
Message-ID: <202005041205.C7AF4AF@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just as a precaution, make sure that proc handlers don't accidentally
grow "count" beyond the allocated kbuf size.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
This applies to hch's sysctl cleanup tree...
---
 fs/proc/proc_sysctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 15030784566c..535ab26473af 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -546,6 +546,7 @@ static ssize_t proc_sys_call_handler(struct file *filp, void __user *ubuf,
 	struct inode *inode = file_inode(filp);
 	struct ctl_table_header *head = grab_header(inode);
 	struct ctl_table *table = PROC_I(inode)->sysctl_entry;
+	size_t count_max = count;
 	void *kbuf;
 	ssize_t error;
 
@@ -590,6 +591,8 @@ static ssize_t proc_sys_call_handler(struct file *filp, void __user *ubuf,
 
 	if (!write) {
 		error = -EFAULT;
+		if (WARN_ON(count > count_max))
+			count = count_max;
 		if (copy_to_user(ubuf, kbuf, count))
 			goto out_free_buf;
 	}
-- 
2.20.1


-- 
Kees Cook
