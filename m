Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8505A9423
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 22:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbfIDUyX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Sep 2019 16:54:23 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46763 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfIDUyX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Sep 2019 16:54:23 -0400
Received: by mail-lf1-f67.google.com with SMTP id t8so89424lfc.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Sep 2019 13:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YRdCAVRAhTdLrO2mQDquZKKD1XyXDQFQecwZBQrW2l0=;
        b=Ze7jrxDdyMP3SGOIesp7e7J/31BijZsyDh1sIQ7zUiaQzSssRLwu0Ke8i7Ma6J1ANp
         +Y5ZM0aEii6+0RhihFBDvVJHDKpgy6odNUVXcrGCLgyyDaE911gL75i/CI9XscaVSNbQ
         F9aqFQyEV98rhO6Nc66q5tz/D9khPZIijk1p4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YRdCAVRAhTdLrO2mQDquZKKD1XyXDQFQecwZBQrW2l0=;
        b=pogXRTWl4HjgXPodeBjsyaeCniXpdxTkBBaW8oNX3/kzGO16FQ9LI3wtkHGhkq75hL
         ZgyHRa+Kkn35TtuPgYC2q+QR5lmoi5bOaeaALxB0f7hCXspOgyT0pFhwd4Arr6YnKYnk
         9zisWoVUgBWfeKoDf/2o1CyjSxsBKs0N34+6z3nYCjxn6RsPT3Gd2mbJScYH5vikXM0b
         sznJ0NkP2kvsmpVEtzBjLRTlmuOYd3ZrtnGvcCn32u0bATJP70r7ffwZkGQTH0ip4t6Q
         niYLDDekk8yeAbsvgamASBiGkCALj3K7o+cp+6DQlGW7GnoOffHEAjTQbB5x4FWwy1Zs
         K8ew==
X-Gm-Message-State: APjAAAW20rt5xXsKqXLWJNXzqd71u9qbyweaA0hjOQ/FYO6CZzHCQ8iW
        PlRq/IbVMBjoJX9PeXW/ZKnS465AvtE=
X-Google-Smtp-Source: APXvYqzSHpf3T7meF7s3venTSAGHttC6aWiGVPKOplvna11Aanlw3WxhbVCuuc4mOvnLi8GMAn+osw==
X-Received: by 2002:a19:6d02:: with SMTP id i2mr42352lfc.191.1567630460400;
        Wed, 04 Sep 2019 13:54:20 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id o2sm2173800lfl.20.2019.09.04.13.54.20
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2019 13:54:20 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id j4so111377lfh.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Sep 2019 13:54:20 -0700 (PDT)
X-Received: by 2002:a19:f204:: with SMTP id q4mr52203lfh.29.1567630138756;
 Wed, 04 Sep 2019 13:48:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190904201933.10736-1-cyphar@cyphar.com> <20190904201933.10736-2-cyphar@cyphar.com>
In-Reply-To: <20190904201933.10736-2-cyphar@cyphar.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 4 Sep 2019 13:48:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiDUA-cMy4VZxO6o6q+Cs3D6Od_MwEK53gcXuVn-dqv2g@mail.gmail.com>
Message-ID: <CAHk-=wiDUA-cMy4VZxO6o6q+Cs3D6Od_MwEK53gcXuVn-dqv2g@mail.gmail.com>
Subject: Re: [PATCH v12 01/12] lib: introduce copy_struct_{to,from}_user helpers
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Aleksa Sarai <asarai@suse.de>,
        Linux Containers <containers@lists.linux-foundation.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 4, 2019 at 1:20 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
>
> A common pattern for syscall extensions is increasing the size of a
> struct passed from userspace, such that the zero-value of the new fields
> result in the old kernel behaviour (allowing for a mix of userspace and
> kernel vintages to operate on one another in most cases).

Ack, this makes the whole series (and a few unrelated system calls) cleaner.

           Linus
