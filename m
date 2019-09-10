Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 465BBAE3D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2019 08:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393497AbfIJGfm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Sep 2019 02:35:42 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34009 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729627AbfIJGfl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Sep 2019 02:35:41 -0400
Received: by mail-wr1-f66.google.com with SMTP id a11so7851369wrx.1;
        Mon, 09 Sep 2019 23:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9uC8BSyBqqvpBHr+UBJrMjpTjeLS9eaSkiimfXBOGmI=;
        b=RT2CZzYflWq0hJIviZ1qNiz7T8GR4+WUrisMZXe3m9cauTkqIyyVGGFPULrde7A02W
         tj7FplDkEllE02owPbUYDzEtapP1C48use/4kFc7fZZmFt/DdDZTI55D8qvOaO2r24Ne
         q4FNPrvlkjfx+lYW3lSYcZ69k2e463dcG9Y4rn+PPa/Glpr++eDfgJ8gFO5kdGQ+ZZAk
         nXhnUxrt/DhKZTkCCWYef7FPywkEzNn0z8LUShNXRMIkZZwOG/G3kJoXGIwG7zGeC0aS
         TI+DZ2QVgsA7VVK9EZCvbN7bPdpk9PkNXAPdUVWeWNcFfO4yiY8K5tj2pJUrGvJYeUSW
         9/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9uC8BSyBqqvpBHr+UBJrMjpTjeLS9eaSkiimfXBOGmI=;
        b=OGIIu7kQiC9NfKryZfiQuYrZPpsBPFxbvEH8fwEKiZuuqtgtF7jXfIN29NnGbc7fId
         rvFMXp1KemiGvI8uDGKpmB7TKTpH09ZSH+pP6wff/kjUKi7y/gzYWD37MGi08QJKXSU5
         qIzIK/9psV/Dmfg+9g4+w5obNvUboDNYacCXAulcDEnDDCAlCvNGVCW+/KRRgW+yYKgs
         bJbBptmLeUkrnIBvsbU7dGCeqeZV5c2GnIcnxDregkX0MA47Sf4/LsthdFQLCntmSSpS
         lDqB3Sg9s1mVKXpH8rGLDUn39r1sa8uWlauqHahO9JXETkbxQ2gJO9wOvf2hvpR7bsNy
         0bJQ==
X-Gm-Message-State: APjAAAVO1jrEEqNqZtkwzYjI7tJkcM927HxyjlUx7zJFLbv3jtpt93vv
        vOFlChZAgfWDE3vxlNeRRCw=
X-Google-Smtp-Source: APXvYqw8XHm4leFwnC6sWR8BjhyMsv0e/YjeclMhzrktUUdT/wG1WxzN3IHekSLZEGkf3MnHklk0qA==
X-Received: by 2002:a5d:6b0f:: with SMTP id v15mr22340960wrw.19.1568097336267;
        Mon, 09 Sep 2019 23:35:36 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id u22sm32329249wru.72.2019.09.09.23.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 23:35:35 -0700 (PDT)
Date:   Tue, 10 Sep 2019 08:35:32 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Jeff Layton <jlayton@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
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
Subject: Re: [PATCH v12 11/12] open: openat2(2) syscall
Message-ID: <20190910063532.GB1579@gmail.com>
References: <20190904201933.10736-1-cyphar@cyphar.com>
 <20190904201933.10736-12-cyphar@cyphar.com>
 <7236f382d72130f2afbbe8940e72cc67e5c6dce0.camel@kernel.org>
 <CAHk-=whZx97Nm-gUK0ppofj2RA2LLz2vmaDUTKSSV-+yYB9q_Q@mail.gmail.com>
 <C81D6D29-F6BF-48E6-A15E-3ABCB2C992E5@amacapital.net>
 <CAHk-=whe90Ec_RRrMRLE0=bJOHNS9YmVwcytVxmrfK3oCuZF6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whe90Ec_RRrMRLE0=bJOHNS9YmVwcytVxmrfK3oCuZF6A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sat, Sep 7, 2019 at 10:42 AM Andy Lutomirski <luto@amacapital.net> wrote:
> >
> > Linus, you rejected resolveat() because you wanted a *nice* API
> 
> No. I rejected resoveat() because it was a completely broken garbage
> API that couldn't do even basic stuff right (like O_CREAT).
> 
> We have a ton of flag space in the new openat2() model, we might as
> well leave the old flags alone that people are (a) used to and (b) we
> have code to support _anyway_.
> 
> Making up a new flag namespace is only going to cause us - and users -
> more work, and more confusion. For no actual advantage. It's not going
> to be "cleaner". It's just going to be worse.

I suspect there is a "add a clean new flags namespace" analogy to the 
classic "add a clean new standard" XKCD:

	https://xkcd.com/927/

Thanks,

	Ingo
