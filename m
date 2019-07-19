Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 587B16E459
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2019 12:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfGSK34 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jul 2019 06:29:56 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53325 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727625AbfGSK3v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jul 2019 06:29:51 -0400
Received: by mail-wm1-f65.google.com with SMTP id x15so28298956wmj.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jul 2019 03:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/54Z+i2NAAKKYqTyaHCknB2yONX433P+mrrcxDIdMKQ=;
        b=JAjsDhcTKFikvYch2sdYf3M1YIU4lD8gtr6ULD+m66RVXVuqlNpAWJ5aCmwhzsJqfu
         NYMs/ngfnZnIR8qK+5gnlfw/LTN1DoKaojW4kG3ixmkDG7tw9PX3Gi1H6Z3rJyqaYFRY
         gtdhUxjOR3aQahCtFDINrBG/OSP8pnsgZFupRZsDuzUdLCVJo0FcPvznY5c5cU461qY8
         z6fVQ/+Mbzs3h37QWljm/AYaqqO87pyj8pyd6RorqrMiW7iIeyvakf6A7A7GAM2bH4rw
         cbSgv5bCTz5aSE0toZ8ZOUCkVQ0c1BjSzCzQ1F1IbaB+eNv/4FBgS3Np35nlQBPDWp48
         Qe+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/54Z+i2NAAKKYqTyaHCknB2yONX433P+mrrcxDIdMKQ=;
        b=TwRwdRz/XeWadTxRG1HFO4nCNbWx9KfdYxYDCDL72y9ebe6H0zZ1Qo3My+BXTsqvzN
         SL/apu+C3WN1oSxEP3nXhuV6JaMozmw0idp6JBdgShDKdWZTQA3vCAQNo3kutbfEKSEv
         i+bUkAuJjeju5TX7rNfDI98cVeBxDHo0Bt9lXf3pScv1utV1kxCTVdX8fQgIUKDZ5BCd
         +tm58xq1p0F12lhnUTlh1q+Zcc4W0F1mJfk7CaX19T3YUDb1bQ01bLmi3DMFLk+hlWWN
         X0AzBTJT9EaCaczmK5L5lCQDlWz7VCI6tW7W1oMImFl23g6jSyluJT+bZrerXhUn+1jn
         tgsg==
X-Gm-Message-State: APjAAAXbS6pyIVu7QGOZAf1MrY3pm/gU5VNmWqBxan45oOmgAEPgBmNc
        knQ3Ebsq4Zs/9SRE8G0B7cg=
X-Google-Smtp-Source: APXvYqynzSxRaiMvY03x+MCUOq/ut+wmSYg6CTggvreuOHjcm6imyyhYbJGXSWZ87v9KsAJECqBb6Q==
X-Received: by 2002:a1c:c145:: with SMTP id r66mr47654238wmf.139.1563532189209;
        Fri, 19 Jul 2019 03:29:49 -0700 (PDT)
Received: from brauner.io ([81.92.17.140])
        by smtp.gmail.com with ESMTPSA id v4sm25167633wmg.22.2019.07.19.03.29.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 19 Jul 2019 03:29:49 -0700 (PDT)
Date:   Fri, 19 Jul 2019 12:29:41 +0200
From:   Christian Brauner <christian@brauner.io>
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org,
        alpha <linux-alpha@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-mips@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        sparclinux <sparclinux@vger.kernel.org>
Subject: Re: [PATCH v9 08/10] open: openat2(2) syscall
Message-ID: <20190719102932.274pvmxnrbjcc6gu@brauner.io>
References: <20190706145737.5299-1-cyphar@cyphar.com>
 <20190706145737.5299-9-cyphar@cyphar.com>
 <CAK8P3a33rGhPDFfRBAQyLTMG_WoEgX_toDgWR2O7rSwxKsZG+w@mail.gmail.com>
 <20190718161231.xcno272nvqpln3wj@yavin>
 <CAK8P3a3MiYK4bJiA3G_m5H-TpfN5__--b+=szsJBhG7_it+NQg@mail.gmail.com>
 <20190719021218.GB18022@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190719021218.GB18022@altlinux.org>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 19, 2019 at 05:12:18AM +0300, Dmitry V. Levin wrote:
> On Thu, Jul 18, 2019 at 11:29:50PM +0200, Arnd Bergmann wrote:
> [...]
> > 5. you get the same problem with seccomp and strace that
> >    clone3() has -- these and others only track the register
> >    arguments by default.
> 
> Just for the record, this is definitely not the case for strace:
> it decodes arrays, structures, netlink messages, and so on by default.

There sure is value in trying to design syscalls that can be handled
nicely by seccomp but that shouldn't become a burden on designing
extensible syscalls.
I suggested a session for Ksummit where we can discuss if and how we can
make seccomp more compatible with pointer-args in syscalls.

Christian
