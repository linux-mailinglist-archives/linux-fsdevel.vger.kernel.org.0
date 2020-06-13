Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F051F80BB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jun 2020 05:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgFMDi0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 23:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbgFMDiZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 23:38:25 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE95C03E96F;
        Fri, 12 Jun 2020 20:38:25 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id s23so5227028pfh.7;
        Fri, 12 Jun 2020 20:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nvZ8ZPQQ2Ao+T8CSV7zjmFR3kWqVRNjhytQMJrXZzTU=;
        b=MKlwCxj9ezu8XfqLnTsxJf6T8fsjK7ThFtT9OuD7rd8/wZK7zFVaMw6RaHbpj/gRGM
         McxML2ryVcEr+oq8OXwIQhqnBktQVYtpRm8Jf0H5wWZccGbIwv1L0Gx3rAhGWx3Dfoh0
         DkPMoyE5NUNqeHvQS5ONYlLrW5N4e/UH3ceK8Fb2RYPrHPD0Yf/EtPVFPK7plfoUShGN
         7SIZQg/sO4gZwbJVFTv9Ie5OfN2z/Y3r5qrkEEv6hCruVPPEyENIZyyQbKMnGIZaPNqW
         wGO/T7L79XkW/yQnESIjprpWYVDUW8B9nfk7yPIRHAOM5//7vWYaSCeAUkj2XwQ7yHWd
         yLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nvZ8ZPQQ2Ao+T8CSV7zjmFR3kWqVRNjhytQMJrXZzTU=;
        b=eFqSRFdTnJJjIhYKxRsoWUB5DmQWvLZ2iO66bcCYjL/W/8nx35kB/zRIZijNi0Xcev
         IBIIST9MN6eCshsFzwiEcmlwLYdUM54Guh1596pTJbIyZs/a62OB/LlPqAdUJ5K5uSgS
         fscHdHPOquaX8C38925bwBT+nyZcdI/2urB6DMurDk7sm3/tkuiFtDjEjO2oGZnWUVJu
         vbODVIoN5GkkBbGRAPQ3gxWlo5x1AX4Fe+sBJHrPhlDLnq19ee9bjZfvHDo6bqipXt6a
         aM2ficEucoZthWa+IEi6UP4Wx9l5Ok4LOeG22kQXeq17mCVQwtxwmKq7OIb0p9PzwhFK
         9mBQ==
X-Gm-Message-State: AOAM530CUPCy+Vawl75jU4140uBJzpAir000plL9ic5yl9XTp4igZXpu
        YqR4HuTYipXz2wvxSRhigaI=
X-Google-Smtp-Source: ABdhPJxsjIEetDiwLo8Z4+WtTFZ25AtbM+HqNjzgwDwf5VGQCJiI3J4aj+WFLURqWKaVgJrXFT51sw==
X-Received: by 2002:a63:1b20:: with SMTP id b32mr13383883pgb.39.1592019504930;
        Fri, 12 Jun 2020 20:38:24 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:400::5:9709])
        by smtp.gmail.com with ESMTPSA id a16sm6466343pgk.88.2020.06.12.20.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 20:38:24 -0700 (PDT)
Date:   Fri, 12 Jun 2020 20:38:21 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently
 unmantained
Message-ID: <20200613033821.l62q2ed5ligheyhu@ast-mbp>
References: <20200606201956.rvfanoqkevjcptfl@ast-mbp>
 <CAHk-=wi=rpNZMeubhq2un3rCMAiOL8A+FZpdPnwFLEY09XGgAQ@mail.gmail.com>
 <20200607014935.vhd3scr4qmawq7no@ast-mbp>
 <33cf7a57-0afa-9bb9-f831-61cca6c19eba@i-love.sakura.ne.jp>
 <20200608162306.iu35p4xoa2kcp3bu@ast-mbp.dhcp.thefacebook.com>
 <87r1uo2ejt.fsf@x220.int.ebiederm.org>
 <20200609235631.ukpm3xngbehfqthz@ast-mbp.dhcp.thefacebook.com>
 <87d066vd4y.fsf@x220.int.ebiederm.org>
 <20200611233134.5vofl53dj5wpwp5j@ast-mbp.dhcp.thefacebook.com>
 <62859212-df69-b913-c1e0-cd2e358d1adf@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62859212-df69-b913-c1e0-cd2e358d1adf@i-love.sakura.ne.jp>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 12, 2020 at 09:57:40AM +0900, Tetsuo Handa wrote:
> 
> , the userspace memory can be easily interfered from userspace. The kernel module
> running in kernel space is protected (unless methods like /dev/{mem,kmem} are used)
> but the kernel module running in user space is not protected.

huh? One user process 'can easily interfere' with memory of other process?

> 
> You said
> 
>   What you're saying is tomoyo doesn't trust kernel modules that are built-in
>   as part of vmlinux and doesn't trust vmlinux build.
> 
> but the word 'trust' has multiple aspects. One of aspects is "can the program
> contain malicious code?" which would be mitigated by cryptographic signing

usermode_blob is either part of kernel module or part of vmlinux.
If it's part of vmlinux it's inherently trusted.
If it's part of ko it's signed along with the rest of ko.

> We might need to invent built-in "protected userspace" because existing
> "unprotected userspace" is not trustworthy enough to run kernel modules.
> That's not just inventing fork_usermode_blob().

sorry, but this makes no sense at all to me.

> can be interfered) is so painful. I won't be able to trust kernel modules running
> in userspace memory.

The part that I suspect is still missing is what triggers fork_usermode_blob().
It's always kernel code == trusted code.

Currently we have the following:

vmlinux {
  core code of kernel
  built-in mod_A {
    kernel code
  }
  built-in mod_B {
    kernel code
  }
}
loadable mod_C {
  kernel code
}

With fork_usermode_blob() kernel modules can delegate parts of their
functionality to run in user space:

vmlinux {
  core code of kernel
  built-in mod_A {
    kernel code
    code to run in user space
  }
  built-in mod_B {
    kernel code
    code to run in user space
  }
}
loadable mod_C {
  kernel code
  code to run in user space
}

The interface between kernel part of .ko and user part of .ko is
specific to that particular kernel module. It's not a typical user space.
Take bpfilter, for example. It has its own format of structures
that are being passed between kernel side of bpfilter and user side
of bpfilter. It's bpfilter's internal interface that doesn't
create user api. bpfilter in kernel 5.x could be passing different
structs vs bpfilter in kernel 6.x.
It also cannot be started via init=, but it has to be ready
if pid 1 needs it.
Say, bpfilter was compiled as loadable kernel module.
In such case bpfilter.ko will not be loaded into the kernel
until the first iptables sockopt. It may never be loaded.
But when loaded the bpfilter.ko will start its user space side
via fork_usermode_blob() that is specific to that version of .ko.
Other kernel modules like bpf_lsm.ko will decide what's appropriate
for them in terms of when user side should start and exit.
Likely bpf_lsm.ko would want to be built-in.
In all cases kernel module cannot rely on traditional usermode_helper,
because usermode_helper is true uapi. The admin can boot kernel 5.x
and it must work with usermode_helpers installed in rootfs. The admin
will reboot to kernel 6.x and it should still work without changing rootfs.
Whereas usermode_blobs are ko and kernel specific.
