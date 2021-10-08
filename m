Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4480A4273E8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Oct 2021 00:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243657AbhJHWtg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Oct 2021 18:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbhJHWtf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Oct 2021 18:49:35 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D468C061755
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Oct 2021 15:47:39 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id s16so9402316pfk.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Oct 2021 15:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=IDL1dGbYQGd5Z4n8MbIk3dyJApzaVNleP7ehAou5XC4=;
        b=k/DtfYhTXoNzDDeSt76IrPgiHKVbJzl+yCmhiVP/k9h8OwZ+VHDbs2A9FEOSncQ6Nu
         c0oNPpuSA0nexNb/AGdFb+q1kORF6YZCNXJNkA0aiLO369TZ7sk5ShzhZMZeTnhRLb7A
         UNQpET4n7Z7KsW9liWrD/WoMIMHK7Ci23ktRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IDL1dGbYQGd5Z4n8MbIk3dyJApzaVNleP7ehAou5XC4=;
        b=ZPgW6JdOQLafTnURE66wdk1pBX6vUNULoYStjqN8AQ9yyUvJtSyInKNLh4f014a8p4
         M7z/cKnfgRxxFqqhEuaMlpNwI9gvCqk9ErWXEYPVnuhR9JIMkecJgStKXqpcrbJqix8L
         8mmozahgo74r7cPyrBuCgTauSMImLd4SEyyI3dOMaI3ISRCvUN16NWmF/Ao5C9oPKWim
         CaeSlbnmGm3ahaH6zffZelC1SfOCoYFWFmTfqXkjpLsqPkIHqwXGrp+hhnB7gX0VTtc3
         Tqx8xuw2+m6MGVi1ldkxKRFTwQCffXN4pbe7JprBpWjWgqJrV9OiJoQRL0K3AOHBePS8
         CP0g==
X-Gm-Message-State: AOAM531F/RHpfXoQKbHm03Tdc9JE7drmDa84MuwBXRBNPwsya2mTWhpr
        qbDh+S7fLPbVWsqzb4mWNQOdZQ==
X-Google-Smtp-Source: ABdhPJwvnmLJjnp89CGi8tOitxi5+0+62XoRbPGjNi0V+bAyRDLPPpqmm4mrkramzCbREIT8ipI6YQ==
X-Received: by 2002:a05:6a00:1944:b0:438:d002:6e35 with SMTP id s4-20020a056a00194400b00438d0026e35mr12543299pfk.20.1633733258954;
        Fri, 08 Oct 2021 15:47:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k17sm295225pff.214.2021.10.08.15.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 15:47:38 -0700 (PDT)
Date:   Fri, 8 Oct 2021 15:47:37 -0700
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
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v14 0/3] Add trusted_for(2) (was O_MAYEXEC)
Message-ID: <202110081545.8D8C2980@keescook>
References: <20211008104840.1733385-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211008104840.1733385-1-mic@digikod.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 08, 2021 at 12:48:37PM +0200, Mickaël Salaün wrote:
> This patch series is mainly a rebase on v5.15-rc4 with some cosmetic
> changes suggested by Kees Cook.  Andrew, can you please consider to
> merge this into your tree?

Thanks for staying on this series! This is a good step in the right
direction for finally plugging the "interpreter" noexec hole. I'm pretty
sure Chrome OS will immediately use this as they've been carrying
similar functionality for a long time.

-- 
Kees Cook
