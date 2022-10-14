Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F695FE7C6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Oct 2022 05:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiJNDyX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Oct 2022 23:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiJNDyT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Oct 2022 23:54:19 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32F396238
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Oct 2022 20:54:16 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d10so3780162pfh.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Oct 2022 20:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BQMeWu4NUS5XHxpYjKe5lPkeUdCMvZeCueelrFJNv7g=;
        b=hVsj8yBrgKuKkK7M8xkb+HyKOAR1jqjYGdTOSBbuFw1xtWaGZRldfWed4W2s4PX8vj
         gMHC+/MyceBR4MHXpZkl8R1pYEcZzKSZwB0eAGg1tk/SYjiAH2KDJtEmiRns8TV0xEj3
         Z26bm3qSWSWPK1j2fJ6oI+/9oCd9hoET+A3WM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQMeWu4NUS5XHxpYjKe5lPkeUdCMvZeCueelrFJNv7g=;
        b=iGj2hGmaDnyybgms6ZAi6WR62CMjwCTsDUvJIXBjBtwTJqEs/MZ3hQ33OEyqBfSGp1
         fCPqMGych+YWDbBciJBiqp8qpIgr2T4CPzhjov7T8hq7ztr9vVHMm74z9sQcuW5V0Zmh
         HJXNYU4UPiZ5Mnw11Nn941X3nVyFGlJuvu2+ZiKq7xQvz6XUlQvcPSYoMeyqI0NlOOcL
         4+UuzfMzPL9epI0QSDahQhG6Ht2xRWINjcJIyfxVoJgXlCyjr4+fASWnbKOvjHzgjDRI
         VvBpRCNogkG1EPRruH8f7+Z1hJYXmU7Lbbt3nd2QwECMqYz9yNIuY0AMWGfBHnC2lYfl
         mJcQ==
X-Gm-Message-State: ACrzQf0PZ0rirAETdVSBXGqmqnRJk2DosgqwHHFeOm5Ow4dFNiN7R0iu
        tR4cjJNNK2GaYUWmn8AGP/Tx+A==
X-Google-Smtp-Source: AMsMyM7vCfA8wFrsyDJjLw6KB1kvioIeLEFXGEDdVpYcSJdvjz4XjS2+1dICHf/21nwZwt5L/DrvHw==
X-Received: by 2002:a63:591c:0:b0:464:bb3b:d1ad with SMTP id n28-20020a63591c000000b00464bb3bd1admr2830780pgb.146.1665719656162;
        Thu, 13 Oct 2022 20:54:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h4-20020a17090a710400b0020ae09e9724sm474301pjk.53.2022.10.13.20.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 20:54:15 -0700 (PDT)
Date:   Thu, 13 Oct 2022 20:54:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Jann Horn <jannh@google.com>,
        Christian Brauner <brauner@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jorge Merlino <jorge.merlino@canonical.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
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
        Andrei Vagin <avagin@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2] fs/exec: Explicitly unshare fs_struct on exec
Message-ID: <202210132052.32AE372@keescook>
References: <20221006082735.1321612-1-keescook@chromium.org>
 <20221006082735.1321612-2-keescook@chromium.org>
 <20221006090506.paqjf537cox7lqrq@wittgenstein>
 <CAG48ez0sEkmaez9tYqgMXrkREmXZgxC9fdQD3mzF9cGo_=Tfyg@mail.gmail.com>
 <2032f766-1704-486b-8f24-a670c0b3cb32@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2032f766-1704-486b-8f24-a670c0b3cb32@app.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 13, 2022 at 08:18:04PM -0700, Andy Lutomirski wrote:
> But seriously, this makes no sense at all.  It should not be possible to exec a program and then, without ptrace, change its cwd out from under it.  Do we really need to preserve this behavior?

Yup, already abandoned:
https://lore.kernel.org/lkml/202210061301.207A20C8E5@keescook/

-- 
Kees Cook
