Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9A520F9F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jun 2020 18:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389910AbgF3Qzl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jun 2020 12:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387839AbgF3Qzk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jun 2020 12:55:40 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178E3C061755;
        Tue, 30 Jun 2020 09:55:41 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id z5so10217154pgb.6;
        Tue, 30 Jun 2020 09:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eoz3Pq8kUpqZqE/rV7PU7fyf3xWjp/m0nHwjaG4KRwE=;
        b=PODnF+l0rjCnsE+RxJCoNmZU19ALYCpdn9HbLnhdAU00bhmfKviYN3YNUS1EdyhqrX
         Ci/EETDvLpNIdyj2y2OGdwjd6GgTpyGxz37sURehqja2Cvnje8LVamKm3Iwj5sJUPTsP
         XOYiMxbS6tVQfIFbkNJR+tU9vAo/BSV+18EZXrbKoCILDiWeNtJ4288xhjRvIcUByf16
         5jhz14JjKOmL7GGAcZEwWVoZSEpz98LURwlAwHsI+jT7r8RJwgy2XNSBZDFvjgoknArz
         AraKcUCMGDwQDZORTg5JeGLIaFu3RjUS8CAykcsQC+MoJdUHCVskRPMJZ71N69xLMfb8
         BxvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eoz3Pq8kUpqZqE/rV7PU7fyf3xWjp/m0nHwjaG4KRwE=;
        b=MgYDDSuT8zU0N/RpJ5WTBUDHndRA/1M8usHBHlGaz9YqPBuSbLFRx5Z706VmYbU6Ny
         XLUEIUWTukeRyE+qPGeLODyQ9u1JsWpMIO/2slZY6r7QXvEfKGUS46ZM6fXvKM0K2MWA
         +s4ZBBL9J2HHZ6/pEZHzndFtkTi/s21e1rjhKPawRwdc8wOWRiQIwVxhulxxHdL6u7A+
         z+8jtQO85VLt4LsKgpNhDV02NfhvW1wlNTWF3dBQ99ovx3V6oFUgKIZQEWcRvdg+1uog
         9RkrnsWqgGqZk2ZQKCqasQ0eAkTmm/nW7Rm7+AjxLchF+VNSdGAVPzX/VPHC3avK5p6S
         omfA==
X-Gm-Message-State: AOAM530X2O5HkCnT3Q6IcpMSgv0JM5Nk/xKqIuUUGXCMx1HWF30j6URl
        /EnfBSzCMxcLCQnSfuSafws=
X-Google-Smtp-Source: ABdhPJx0io5eJXz+CA0pAIwthbDFQEzc7Jl+71RSIYSn+jf5Py8ZP0DOchWskQdaN+pfZJisRpAOOw==
X-Received: by 2002:a05:6a00:15c8:: with SMTP id o8mr20444419pfu.286.1593536140578;
        Tue, 30 Jun 2020 09:55:40 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:e083])
        by smtp.gmail.com with ESMTPSA id n12sm3210703pgr.88.2020.06.30.09.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 09:55:39 -0700 (PDT)
Date:   Tue, 30 Jun 2020 09:55:36 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 10/15] exec: Remove do_execve_file
Message-ID: <20200630165536.c4ffmurfz5kosx7e@ast-mbp.dhcp.thefacebook.com>
References: <20200625.123437.2219826613137938086.davem@davemloft.net>
 <CAHk-=whuTwGHEPjvtbBvneHHXeqJC=q5S09mbPnqb=Q+MSPMag@mail.gmail.com>
 <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org>
 <87y2oac50p.fsf@x220.int.ebiederm.org>
 <87bll17ili.fsf_-_@x220.int.ebiederm.org>
 <87lfk54p0m.fsf_-_@x220.int.ebiederm.org>
 <20200630054313.GB27221@infradead.org>
 <87a70k21k0.fsf@x220.int.ebiederm.org>
 <20200630133802.GA30093@infradead.org>
 <878sg4y6f9.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878sg4y6f9.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 30, 2020 at 09:28:10AM -0500, Eric W. Biederman wrote:
> Christoph Hellwig <hch@infradead.org> writes:
> 
> > On Tue, Jun 30, 2020 at 07:14:23AM -0500, Eric W. Biederman wrote:
> >> Christoph Hellwig <hch@infradead.org> writes:
> >> 
> >> > FYI, this clashes badly with my exec rework.  I'd suggest you
> >> > drop everything touching exec here for now, and I can then
> >> > add the final file based exec removal to the end of my series.
> >> 
> >> I have looked and I haven't even seen any exec work.  Where can it be
> >> found?
> >> 
> >> I have working and cleaning up exec for what 3 cycles now.  There is
> >> still quite a ways to go before it becomes possible to fix some of the
> >> deep problems in exec.  Removing all of these broken exec special cases
> >> is quite frankly the entire point of this patchset.
> >> 
> >> Sight unseen I suggest you send me your exec work and I can merge it
> >> into my branch if we are going to conflict badly.
> >
> > https://lore.kernel.org/linux-fsdevel/20200627072704.2447163-1-hch@lst.de/T/#t
> 
> 
> Looking at your final patch I do not like the construct.
> 
> static int __do_execveat(int fd, struct filename *filename,
>  		const char __user *const __user *argv,
>  		const char __user *const __user *envp,
> 		const char *const *kernel_argv,
> 		const char *const *kernel_envp,
>  		int flags, struct file *file);
> 
> 
> It results in a function that is full of:
> 	if (kernel_argv) {
>         	// For kernel_exeveat 
> 		...
> 	} else {
>         	// For ordinary exeveat
>         	
>         }
> 
> Which while understandable.  I do not think results in good long term
> maintainble code.
> 
> The current file paramter that I am getting rid of in my patchset is
> a stark example of that.  Because of all of the if's no one realized
> that the code had it's file reference counting wrong (amoung other
> bugs).
> 
> I think this is important to address as exec has already passed
> the point where people can fix all of the bugs in exec because
> the code is so hairy.
> 
> I think to be maintainable and clear the code exec code is going to
> need to look something like:
> 
> static int bprm_execveat(int fd, struct filename *filename,
> 			struct bprm *bprm, int flags);
> 
> int kernel_execve(const char *filename,
> 		  const char *const *argv, const char *const *envp, int flags)
> {
> 	bprm = kzalloc(sizeof(*pbrm), GFP_KERNEL);
>         bprm->argc = count_kernel_strings(argv);
>         bprm->envc = count_kernel_strings(envp);
>         prepare_arg_pages(bprm);
>         copy_strings_kernel(bprm->envc, envp, bprm);
>         copy_strings_kernel(bprm->argc, argc, bprm);
> 	ret = bprm_execveat(AT_FDCWD, filename, bprm);
>         free_bprm(bprm);
>         return ret;
> }
> 
> int do_exeveat(int fd, const char *filename,
> 		const char __user *const __user *argv,
>                 const char __user *const __user *envp, int flags)
> {
> 	bprm = kzalloc(sizeof(*pbrm), GFP_KERNEL);
>         bprm->argc = count_strings(argv);
>         bprm->envc = count_strings(envp);
>         prepare_arg_pages(bprm);
>         copy_strings(bprm->envc, envp, bprm);
>         copy_strings(bprm->argc, argc, bprm);
> 	ret = bprm_execveat(fd, filename, bprm);
>         free_bprm(bprm);
>         return ret;
> }
> 
> More work is required obviously to make the code above really work but
> when the dust clears a structure like that doesn't have funny edge cases
> that can hide bugs and make it tricky to change the code.

+1 to the approach.
I think Christoph's work need to be on top of Eric's.
