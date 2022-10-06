Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13FCA5F6ED7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Oct 2022 22:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbiJFUUn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 16:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbiJFUUj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:20:39 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9301F17279B
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Oct 2022 13:20:38 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so5361620pjq.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Oct 2022 13:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date;
        bh=Rk5zz4A39+pbcgAoB20NzVrsEawygpTbgx4vBx4ppIs=;
        b=BYx3cjQRaQ61qD4kci8lj8sUlKGwxBQTGugOVwVFovwHCmI/LQDbCjb+DkICpsvW4m
         STdWXo4QVJpb8zGJImpu91r/m8zGJm3KZaeFnkzRlgCgjI+0GDcxB5MTmrhucCW633IN
         I6hYYHjSrLy5aixD/PhLwPqvTzNVP1wuQopiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Rk5zz4A39+pbcgAoB20NzVrsEawygpTbgx4vBx4ppIs=;
        b=M/oOTTic4CnagwXkWytw4ytOP2r0YAJUNTqWEVhAFWZsyToILlayLlApkxdqCqBX67
         HyPb9KmwwBJ5nbnFvU1Y776lcKqrXGVRveJKo+dH89BcMy8hYY9OsLCVf5GuopSgVSLo
         /A0wKNYJoBBRrKMAURwS35cMgED4wSCVOdmpk6AI5CmoSo1YGXC6NFH3zxDNJcgQ5dgh
         ga6fladJO60EFMVK2I1xCR6Ljt+sVLHenjJY2b0VrcSF5po2GFNURB+DQEw9ZXL73vhb
         FyYNFXsiSf4fRDi/frPM0SOfpdolfLIoH+EU9L7F8h6p/3jEFS32Hv6LjpOh2unLz9Es
         ZdXg==
X-Gm-Message-State: ACrzQf11MK9VkyMHZM9VUhIhwsj73Mer4GpCbfBQ7szq03Z5S1u0xGyJ
        NbPs/vGc2aZdcO+Pwbced/geOw==
X-Google-Smtp-Source: AMsMyM6jQK6faWu8ciVNIyHuo5DdhGUHU792hu5M2+fkiWdd1JDFyJ7HN7J/+hDDUVtrL381rrTPHQ==
X-Received: by 2002:a17:902:864c:b0:179:fe02:611e with SMTP id y12-20020a170902864c00b00179fe02611emr1539895plt.10.1665087637621;
        Thu, 06 Oct 2022 13:20:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p8-20020a635b08000000b0045328df8bd0sm148201pgb.71.2022.10.06.13.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:20:36 -0700 (PDT)
Date:   Thu, 6 Oct 2022 13:20:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jorge Merlino <jorge.merlino@canonical.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Todd Kjos <tkjos@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Prashanth Prahlad <pprahlad@redhat.com>,
        Micah Morton <mortonm@chromium.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>, linux-kernel@vger.kernel.org,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] Fix race condition when exec'ing setuid files
Message-ID: <202210061301.207A20C8E5@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202209131456.76A13BC5E4@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 13, 2022 at 15:03:38 -0700, Kees Cook wrote:
> It seems quite unusual to have a high-load heavily threaded
> process decide to exec.

In looking at this a bunch more, I actually think everything is working
as intended. If a process is actively launching threads while also trying
to exec, they're going to create races for themselves.

So the question, then, is "why are they trying to exec while actively
spawning new threads?" That appears to be the core problem here, and as
far as I can tell, the kernel has behaved this way for a very long time.
I don't think the kernel should fix this, either, because it leads to a
very weird state for userspace, where the thread spawner may suddenly
die due to the exec happening in another thread. This really looks like
something userspace needs to handle correctly (i.e. don't try to exec
while actively spawning threads).

For example, here's a fix to the original PoC:

--- a.c.original        2022-10-06 13:07:13.279845619 -0700
+++ a.c 2022-10-06 13:10:27.702941645 -0700
@@ -8,8 +8,10 @@
        return NULL;
 }
 
+int stop_spawning;
+
 void *target(void *p) {
-       for (;;) {
+       while (!stop_spawning) {
                pthread_t t;
                if (pthread_create(&t, NULL, nothing, NULL) == 0)
                        pthread_join(t, NULL);
@@ -17,18 +19,26 @@
        return NULL;
 }
 
+#define MAX_THREADS    10
+
 int main(void)
 {
+       pthread_t threads[MAX_THREADS];
        struct timespec tv;
        int i;
 
-       for (i = 0; i < 10; i++) {
-               pthread_t t;
-               pthread_create(&t, NULL, target, NULL);
+       for (i = 0; i < MAX_THREADS; i++) {
+               pthread_create(&threads[i], NULL, target, NULL);
        }
        tv.tv_sec = 0;
        tv.tv_nsec = 100000;
        nanosleep(&tv, NULL);
+
+       /* Signal shut down, and collect spawners. */
+       stop_spawning = 1;
+       for (i = 0; i < MAX_THREADS; i++)
+               pthread_join(threads[i], NULL);
+
        if (execl("./b", "./b", NULL) < 0)
                perror("execl");
        return 0;


-- 
Kees Cook
