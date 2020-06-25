Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1280209843
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jun 2020 03:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389016AbgFYBfY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 21:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388778AbgFYBfX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 21:35:23 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2F4C061573;
        Wed, 24 Jun 2020 18:35:23 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g67so1612115pgc.8;
        Wed, 24 Jun 2020 18:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8AMsEtMPyIPz6aBefbbRCpn0EeTLWAujh7PMXD7e1o8=;
        b=cq1CjO0kZr/+PAPlvrG/fQJoirloBWo1rePn7DpGhXyiH9F2MrGMM8WAYk4XYdyt3w
         Amfxo/TrQnaWMyNZhHffznZVKFzClxR8Fegt2IkYDMzlLLBfIdmv8Dv2gmDq1JuolNez
         kSJcawlAbMnTLngkG5rrLlKeYbkoX0De/X29DlIfA+sxjPRXzh4SpuTX7DThx2TBdtlI
         LW7oThAK7Mt6Yexc9T9bF+j8YD9QlcvP2qP6e5iquL9az/rKWWTIRLKaNjJoqOfxkGa6
         s7eRelgmn3wCX0BCJimdZhgMoDlDB0+f7pnjfl96FHbIzWyBt0VXPlkQhBtC+6tWwmA5
         W4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8AMsEtMPyIPz6aBefbbRCpn0EeTLWAujh7PMXD7e1o8=;
        b=A/JqOTPudqGMkDaf3d8ckjXgKhY3uDqsCYQyB+eSPyuBmVE8igLJ/102m4nmcmFxfh
         FQ0O4C+l+GmlG6G5NzM+L4Jw23pwugzEPrHu09TXX42w3zYaarD1o4vzqwMkoWcjDZR0
         Pm7ok9EqKjVAofY3bl+v/IYJ6mD6P6uk4w/GQIGVT7q8PO0PlsBLTh7xJx7PgjcctUXq
         hQtG3+36CR12q/97NpZkj/AtGwBq2FOLSjFfJklPGTGk3MWfoaFYyjjsreleTjFuqxb0
         f0gS2gRFPh3Gsf9BolIz2xt3WBVdR+QuFnLo/k83rm6nGB/Xpa3MMADQg0DljabqQc++
         5Now==
X-Gm-Message-State: AOAM531Rda9L2iJvs72aa0KeKt0Vnp8XXCoIdJfQWJFYXn1qOxVlA7/b
        7L112wrh+mmpsrwr/sr6zxA=
X-Google-Smtp-Source: ABdhPJwPzIwR/mkiShfwMRVPGJlUyMzAyo+HgWskH9F7Zm1ygoIOpHCUm3f6WP9QMUV+wdjmx7VAJA==
X-Received: by 2002:a63:d912:: with SMTP id r18mr21144784pgg.358.1593048922749;
        Wed, 24 Jun 2020 18:35:22 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:b86c])
        by smtp.gmail.com with ESMTPSA id u12sm6100176pjy.37.2020.06.24.18.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 18:35:21 -0700 (PDT)
Date:   Wed, 24 Jun 2020 18:35:18 -0700
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
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently
 unmantained
Message-ID: <20200625013518.chuqehybelk2k27x@ast-mbp.dhcp.thefacebook.com>
References: <CAADnVQLuGYX=LamARhrZcze1ej4ELj-y99fLzOCgz60XLPw_cQ@mail.gmail.com>
 <87ftaxd7ky.fsf@x220.int.ebiederm.org>
 <20200616015552.isi6j5x732okiky4@ast-mbp.dhcp.thefacebook.com>
 <87h7v1pskt.fsf@x220.int.ebiederm.org>
 <20200623183520.5e7fmlt3omwa2lof@ast-mbp.dhcp.thefacebook.com>
 <87h7v1mx4z.fsf@x220.int.ebiederm.org>
 <20200623194023.lzl34qt2wndhcehk@ast-mbp.dhcp.thefacebook.com>
 <878sgck6g0.fsf@x220.int.ebiederm.org>
 <CAADnVQL8WrfV74v1ChvCKE=pQ_zo+A5EtEBB3CbD=P5ote8_MA@mail.gmail.com>
 <2f55102e-5d11-5569-8248-13618d517e93@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f55102e-5d11-5569-8248-13618d517e93@i-love.sakura.ne.jp>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 25, 2020 at 08:14:20AM +0900, Tetsuo Handa wrote:
> On 2020/06/24 23:26, Alexei Starovoitov wrote:
> > On Wed, Jun 24, 2020 at 5:17 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
> >>
> >> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
> >>
> >>> On Tue, Jun 23, 2020 at 01:53:48PM -0500, Eric W. Biederman wrote:
> >>
> >>> There is no refcnt bug. It was a user error on tomoyo side.
> >>> fork_blob() works as expected.
> >>
> >> Nope.  I have independently confirmed it myself.
> > 
> > I guess you've tried Tetsuo's fork_blob("#!/bin/true") kernel module ?
> > yes. that fails. It never meant to be used for this.
> > With elf blob it works, but breaks if there are rejections
> > in things like security_bprm_creds_for_exec().
> > In my mind that path was 'must succeed or kernel module is toast'.
> > Like passing NULL into a function that doesn't check for it.
> > Working on a fix for that since Tetsuo cares.
> > 
> 
> What is unhappy for pathname based LSMs is that fork_usermode_blob() creates
> a file with empty filename. I can imagine that somebody would start abusing
> fork_usermode_blob() as an interface for starting programs like modprobe, hotplug,
> udevd and sshd. When such situation happened, how fork_usermode_blob() provides
> information for identifying the intent of such execve() requests?
> 
> fork_usermode_blob() might also be an unhappy behavior for inode based LSMs (like
> SELinux and Smack) because it seems that fork_usermode_blob() can't have a chance
> to associate appropriate security labels based on the content of the byte array
> because files are created on-demand. Is fork_usermode_blob() friendly to inode
> based LSMs?

blob is started by a kernel module. Regardless of path existence that kernel module
could have disabled any LSM and any kernel security mechanism.
People who write out of tree kernel modules found ways to bypass EXPORT_SYMBOL
with and without _GPL. Modules can do anything. It's only the number of hoops
they need to jump through to get what they want. 
Signed and in-tree kernel module is the only way to protect the integrity of the system.
That's why user blob is part of kernel module elf object and it's covered by the same
module signature verification logic.
