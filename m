Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7FA4E1C89
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Mar 2022 17:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245432AbiCTQZ1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Mar 2022 12:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiCTQZ1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Mar 2022 12:25:27 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4E318A3FC;
        Sun, 20 Mar 2022 09:24:02 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v22so3944225wra.2;
        Sun, 20 Mar 2022 09:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iO9ghiHrWRwldt1lRbZ9gFcjDUVBAIs+eEsTLY6nEqs=;
        b=IPbIBlY4XwqKgt1vMEvAZpb9XHnbiJ3gFus4DdaW843VNh0F0Qjb1yPaw7QstdZgtQ
         J/Ibx4HHlnRQcATjjZdMQEdUGdS6OMSdtk0R3lQ9ic5gTvdSjq4i88XOACxkPOQ4zEH5
         qhYae06LEP/zwt68oYGmk84BrJBlvMR16HXVOJMRnFc3VozM8sHzEMzKvIJfDUmduZr9
         XKNpJNtlVU4ExcSgFys6bSa8rgF2KvyBOu+cCEnI0cesMjwrMwAHPmnKlte82Cy0GoxJ
         q+u1hf65BkqUO/uJCivlK7lQkKL8h8BOQ8f6Bewufhl6j3rwxgy47JXr69yv2cHx6xhv
         q7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iO9ghiHrWRwldt1lRbZ9gFcjDUVBAIs+eEsTLY6nEqs=;
        b=YZrhOAPwYVN1DD7vze5QOo4khuvxZG/JRV0OOYlDed9h8hjhcy4q0+ooWye8h3Zhb2
         7v6XRYqQV7QoosdCCjhRZ092NJzpFIuj3Fula8TRb84EAQR1YxDqOcqmR86FID9Q5A2d
         pob0c9rtVUeK4XsO986G1jwUiUAwpfKx0ipL83jCQI1C4kDB6WNb8sIkrigAwOmUaoXj
         fVmpQW+cSfn/nOZKcNtDx4WQVkYEhYFL5BtIlEIq0X9ZZ4Vang6k/7htVKgyg6rrbZ/o
         sRbdfXzd8SiNc29fzFJDk0+SOENrwUVsMVLItoemIJf6MwrhxFHAQlu50072seFrOMIg
         X11w==
X-Gm-Message-State: AOAM531EH9k022XhlYTG95fPLp2rG5rM5yeHDISl2ZoGr8OQfzyxhdiU
        2k3QPUWsEOxEpWzdyaBX+w==
X-Google-Smtp-Source: ABdhPJzWrg6AC/uaSvnYbuOa/xRIrOJMyIqV3YXji759re76caJF0Wyb6S5ewPMNWS31h7e53OYg0w==
X-Received: by 2002:a05:6000:1d82:b0:203:e5cc:c19b with SMTP id bk2-20020a0560001d8200b00203e5ccc19bmr15195700wrb.553.1647793440713;
        Sun, 20 Mar 2022 09:24:00 -0700 (PDT)
Received: from localhost.localdomain ([46.53.252.217])
        by smtp.gmail.com with ESMTPSA id a14-20020a05600c348e00b00389ab74c033sm11517293wmq.4.2022.03.20.09.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 09:24:00 -0700 (PDT)
Date:   Sun, 20 Mar 2022 19:23:58 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        hui li <juanfengpy@gmail.com>, linux-fsdevel@vger.kernel.org
Subject: [PATCH] proc: fix dentry/inode overinstantiating under
 /proc/${pid}/net
Message-ID: <YjdVHgildbWO7diJ@localhost.localdomain>
References: <CAPmgiUJVaACDyWkEhpC5Tfk233t-Tw6_f-Y99KLUDqv6dEq0tw@mail.gmail.com>
 <YjMFTSKZp9eX/c4k@localhost.localdomain>
 <CAPmgiUJsd-gdq=JG1rF8BHfpADeS45rcVWwnC2qKE=7W1EryiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPmgiUJsd-gdq=JG1rF8BHfpADeS45rcVWwnC2qKE=7W1EryiQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When a process exits, /proc/${pid}, and /proc/${pid}/net dentries are flushed.
However some leaf dentries like /proc/${pid}/net/arp_cache aren't.
That's because respective PDEs have proc_misc_d_revalidate() hook which
returns 1 and leaves dentries/inodes in the LRU.

Force revalidation/lookup on everything under /proc/${pid}/net by inheriting
proc_net_dentry_ops.

Fixes: c6c75deda813 ("proc: fix lookup in /proc/net subdirectories after setns(2)")
Reported-by: hui li <juanfengpy@gmail.com>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/generic.c  |    4 ++++
 fs/proc/proc_net.c |    3 +++
 2 files changed, 7 insertions(+)

--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -448,6 +448,10 @@ static struct proc_dir_entry *__proc_create(struct proc_dir_entry **parent,
 	proc_set_user(ent, (*parent)->uid, (*parent)->gid);
 
 	ent->proc_dops = &proc_misc_dentry_ops;
+	/* Revalidate everything under /proc/${pid}/net */
+	if ((*parent)->proc_dops == &proc_net_dentry_ops) {
+		pde_force_lookup(ent);
+	}
 
 out:
 	return ent;
--- a/fs/proc/proc_net.c
+++ b/fs/proc/proc_net.c
@@ -376,6 +376,9 @@ static __net_init int proc_net_ns_init(struct net *net)
 
 	proc_set_user(netd, uid, gid);
 
+	/* Seed dentry revalidation for /proc/${pid}/net */
+	pde_force_lookup(netd);
+
 	err = -EEXIST;
 	net_statd = proc_net_mkdir(net, "stat", netd);
 	if (!net_statd)
