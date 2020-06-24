Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8AD206AD6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 06:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgFXEA7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 00:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgFXEA6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 00:00:58 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F56C061573;
        Tue, 23 Jun 2020 21:00:58 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id h10so719994pgq.10;
        Tue, 23 Jun 2020 21:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WokCtReRqQ4npkuhRh+Pfv3SxLZISJ46jpj8on+jnkI=;
        b=P+PxYDY9SRnYNMWqBYfMQ15SGzD/AUQ45NOUAgGvJRqAHkoxsSB+/cXdvOHH9uQ9Iw
         zvT02uM19A/ye6hhphs3JdF1zSQ1tPDFjtTeIlqntJiBMrtDMC3yLzRJw+xfi/g+tqab
         Ksx17/BV8dpD1zv1w5dqTHURkcURRVW2hqr/h9vfpHoFaGNtor3+36UQUhh3auG1ytEm
         9UcwtfrHzfJFIfX4fxHCxKH5uc1ofG7nJklw/gml+hclRzrIlu7ITVKlUnTtjJD1P4d7
         +aJ1A5eCLnpbAh800WQNuiB+pMKD3b5pdH23Aj8KJVpM2wgW3E1QOCkmUc36hSli/wTt
         QgNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WokCtReRqQ4npkuhRh+Pfv3SxLZISJ46jpj8on+jnkI=;
        b=rKsXKIem0zbBwL3ZbfSdh+KCtWDvGxAyJfxHqjPOfSZxZtcbLQMSo4BpdOTsN8ezXa
         L68Vnfg+AZnj6qrQ5yg8XaZZxAe9RHYKUn4MPm/0S+LtRSzRV7UIAhnKsFPvOLBAT+2a
         abhfRjO6tWotLg9jqr2DDJnBuaubDsrGSbpq5v3X2Zsx4mEPJrGGolnjgvUzUecoO1tu
         jgDK160TUdfJiMi+ovbm7ud3yJBHVE+SKLu8CA2SCE/80oF+wmGv4S6OQmbl0vNzzvlV
         A2STGoktrsVfmDHO+m3Ns5OmdqmHTjJGvWs75ViHZkOGSnvQ5B61F0d6l6wvOCmaFBPT
         LB/A==
X-Gm-Message-State: AOAM5316jSxGy8yEV+wHPw72y5F5GOW90pAYfgAsg+goWWf6XEon323C
        wJz47d68zxhWebV8jl82dYI=
X-Google-Smtp-Source: ABdhPJxFe1q9ZKK1WhqmZXvZXrG1RJ2omGkkh8vAUN3K3NADNExTsXlc54hbTzvACxWT1DiOLDMqrA==
X-Received: by 2002:a63:2a8a:: with SMTP id q132mr19423102pgq.279.1592971257997;
        Tue, 23 Jun 2020 21:00:57 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:4e7a])
        by smtp.gmail.com with ESMTPSA id y4sm1781920pfn.28.2020.06.23.21.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 21:00:57 -0700 (PDT)
Date:   Tue, 23 Jun 2020 21:00:54 -0700
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
Message-ID: <20200624040054.x5xzkuhiw67cywzl@ast-mbp.dhcp.thefacebook.com>
References: <87bllngirv.fsf@x220.int.ebiederm.org>
 <CAADnVQ+qNxFjTYBpYW9ZhStMh_oJBS5C_FsxSS=0Mzy=u54MSg@mail.gmail.com>
 <CAADnVQLuGYX=LamARhrZcze1ej4ELj-y99fLzOCgz60XLPw_cQ@mail.gmail.com>
 <87ftaxd7ky.fsf@x220.int.ebiederm.org>
 <20200616015552.isi6j5x732okiky4@ast-mbp.dhcp.thefacebook.com>
 <87h7v1pskt.fsf@x220.int.ebiederm.org>
 <20200623183520.5e7fmlt3omwa2lof@ast-mbp.dhcp.thefacebook.com>
 <87h7v1mx4z.fsf@x220.int.ebiederm.org>
 <20200623194023.lzl34qt2wndhcehk@ast-mbp.dhcp.thefacebook.com>
 <b4a805e7-e009-dfdf-d011-be636ce5c4f5@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4a805e7-e009-dfdf-d011-be636ce5c4f5@i-love.sakura.ne.jp>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 24, 2020 at 10:51:15AM +0900, Tetsuo Handa wrote:
> On 2020/06/24 4:40, Alexei Starovoitov wrote:
> > There is no refcnt bug. It was a user error on tomoyo side.
> > fork_blob() works as expected.
> 
> Absolutely wrong! Any check which returns an error during current->in_execve == 1
> will cause this refcnt bug. You are simply ignoring that there is possibility
> that execve() fails.

you mean security_bprm_creds_for_exec() denying exec?
hmm. got it. refcnt model needs to change then.

> > Not true again.
> > usermode_blob is part of the kernel module.
> 
> Disagree.

Disagree with what? that blob is part of kernel module? huh?
what is it then?

> 
> > Kernel module when loaded doesn't have path.
> 
> Disagree.
> 
> Kernel modules can be trusted via module signature mechanism, and the byte array
> (which contains code / data) is protected by keeping that byte array within the
> kernel address space. Therefore, pathname based security does not need to complain
> that there is no pathname when kernel module is loaded.

I already explained upthread that blob is part of .rodata or .init.rodata
of kernel module and covered by the same signature mechanism.

> However, regarding usermode_blob, although the byte array (which contains code / data)
> might be initially loaded from the kernel space (which is protected), that byte array
> is no longer protected (e.g. SIGKILL, strace()) when executed because they are placed
> in the user address space. Thus, LSM modules (including pathname based security) want
> to control how that byte array can behave.

It's privileged memory regardless. root can poke into kernel or any process memory.

> On 2020/06/24 3:53, Eric W. Biederman wrote:
> > This isn't work anyone else can do because there are not yet any real in
> > tree users of fork_blob.  The fact that no one else can make
> > substantials changes to the code because it has no users is what gets in
> > the way of maintenance.
> 
> It sounds to me that fork_blob() is a dangerous interface which anonymously
> allows arbitrary behavior in an unprotected environment. Therefore,

I think you missed the part that user blob is signed as part of kernel module.

> > Either a path needs to be provided or the LSMs that work in terms
> > of paths need to be fixed.
> 
> LSM modules want to control how that byte array can behave. But Alexei
> still does not explain how information for LSM modules can be provided.

huh?
please see net/bpfilter/.

> 
> > My recomendation for long term maintenance is to split fork_blob into 2
> > functions: fs_from_blob, and the ordinary call_usermodehelper_exec.
> > That removes the need for any special support for anything in the exec
> > path because your blob will also have a path for your file, and the
> > file in the filesystem can be reused for restart.
> 
> Yes, that would be an approach for providing information for LSM modules.
> 
> > But with no in-tree users none of us can do anything bug guess what
> > the actual requirements of fork_usermode_blob are.
> 
> Exactly. Since it is not explained why the usermode process started by
> fork_usermode_blob() cannot interfere (or be interfered by) the rest of
> the system (including normal usermode processes), the byte array comes from
> the kernel address space is insufficient for convincing LSM modules to
> ignore what that byte array can do.

Sounds like tomoyo doesn't trust kernel modules. I don't think that is
fixable with any amount of explantation.
