Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A96ED4273DE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Oct 2021 00:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbhJHWqs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Oct 2021 18:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243643AbhJHWqs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Oct 2021 18:46:48 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71942C061764
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Oct 2021 15:44:52 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id g14so9357992pfm.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Oct 2021 15:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=tZEn/oAYWz3OcPJexi2kL6PvuHBhh8RYYUTzGNKbmSU=;
        b=DhKhOYtI0pBL6NCNFhLl35WOj9Pbn0YptqtJC1eqqOh1krXIhDiyulLRdDnN09WxhN
         4ODUUIY2goSTSm/XDlA9aerxN9TrWKJwe4C0uO6BXyJUc/M0Rb4Qo34q+wo1Cs6Kdbrx
         wM6E7zu705f4gxd7Ly+0oFdjD/mjV9w3i9uaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tZEn/oAYWz3OcPJexi2kL6PvuHBhh8RYYUTzGNKbmSU=;
        b=Yg8pYKUtB1TJUjqP9zhoFRKQ3hrKB7zzIQE/mpSUH3jX5Y2ar62Kgm15RxteIxRRo6
         ARocxFlxFpo2exaG/QKgTUgQIXmYRbQqzlyLR2MAPn/Aias7MhpoEJQfvNQi+04FcgZE
         1FUWUDLuKXLN5qSwYXICeW5GwZkn2/xOejBA8QR0aJIjSqlD4rx6LEOukNB3utpKK3Ib
         3g1ZaYT7jEC9m7OoxkTzhHrqtpD3cOwIVwzWmtV4JhUS9jO8wprq7FJqtyyEDnQAJGk6
         /3zTHtv4e9FHYuKxd3oeDqndBGbeb5BBjn+/L3fxNynXU9X8REuIsOszaUois9SzfzNb
         WxgA==
X-Gm-Message-State: AOAM533WAQo8HfjkFKYudhPLXmAG6/g0PCf+W8YwSgegz/dR/P4kJEM+
        6xMHIUm7nIMtSiQYMuUn8QXH4g==
X-Google-Smtp-Source: ABdhPJzc82UFKnEHL2nXeW/1+UZrI2+VOZcKuFOfe0n0xCQmI8hpLGTGT0H7X/rjlFKvQ2WBHiiUwA==
X-Received: by 2002:a63:cc48:: with SMTP id q8mr6758353pgi.171.1633733091937;
        Fri, 08 Oct 2021 15:44:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k190sm350501pgc.11.2021.10.08.15.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 15:44:51 -0700 (PDT)
Date:   Fri, 8 Oct 2021 15:44:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        Philippe =?iso-8859-1?Q?Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>
Subject: Re: [PATCH v14 3/3] selftest/interpreter: Add tests for
 trusted_for(2) policies
Message-ID: <202110081544.85B7DA3@keescook>
References: <20211008104840.1733385-1-mic@digikod.net>
 <20211008104840.1733385-4-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211008104840.1733385-4-mic@digikod.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 08, 2021 at 12:48:40PM +0200, Mickaël Salaün wrote:
> From: Mickaël Salaün <mic@linux.microsoft.com>
> 
> Test that checks performed by trusted_for(2) on file descriptors are
> consistent with noexec mount points and file execute permissions,
> according to the policy configured with the fs.trust_policy sysctl.
> 
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>

Thanks for the adjustments!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
