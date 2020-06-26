Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75ED720B80D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jun 2020 20:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbgFZSWn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jun 2020 14:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgFZSWn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jun 2020 14:22:43 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566ACC03E979;
        Fri, 26 Jun 2020 11:22:43 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d10so4559324pls.5;
        Fri, 26 Jun 2020 11:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gPRKQHqm6sZx4nx7rIc/Ck2wASuw3VV19IQZEQ741Rk=;
        b=dTvRyJfQ3Blfhxf3pDzLJQwwrEmprE8++A3HaLXLp5Q+DGxrsGf3W0PhKwPUCHr8Ry
         pkaowC8SyUb1avgQo4c1xh1e+H2QWb5XKQxYoe9EzntrriWIgsG8lqurzmaFn3HKittV
         o335AIa8IFUg+7UzR+3CcBXz9H9Fzj9ABI47CB+eujOCgIfNqehkk/2+QNDwZzsjdjyD
         fwj/lp4D0hbQY5Qg/IUmp8bV6lzIyMM0qjN+UdleejA5nTpd/ezcIzBQMpTDNfbdwT1A
         VlKf7ISr76mmdi2IKAKQ0JQQQYvJ2ClEvNQw2UNG2OUiAaGeAJRbvm8NPiay3VTbUFIz
         Zr0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gPRKQHqm6sZx4nx7rIc/Ck2wASuw3VV19IQZEQ741Rk=;
        b=duIKc92dOOZaS2Ar+AsyhqnBqxvzfWLNm6EdfsUBkUwlPpLQ/elBkwzXdll2DitXxd
         sgqXj01ZPkvWQlQ/OVaa+mdRo3w/f/xS+wzi/bQcDT0IIvcdCIO6z36ww3fekW5zciFv
         mMcp+qaPQhBcXirQwB0VnGNUhCZsdyM/bOUxp4MWzipVe/xL1593qsYhZ5p/VgFum3Og
         QFn6EEslxZnXktr9bErnRYG5cOwJu+dTGXyxrxP/sExJTelR8HL1wC8AeucRdBrBiE+u
         lRge1A6AwpvzATKmh5dJNnAlmzyZt3iv9TK+Yq0GRQdCV2psGqUsQP3/anhbq0IiP0vq
         eVOw==
X-Gm-Message-State: AOAM532we8qW2FOAIIPpXVrphQzEvf1JLf4mIXoteKzJxpYKqHwoH8Hh
        syvczP84EeBRFBqtVvM68DQ=
X-Google-Smtp-Source: ABdhPJyuluSpkCCzQlqONsfwK+vF/2NvmP24zQveFjTNg93fMAPJ1DVKjH3L8mEHTOn7VSfkm2sxlQ==
X-Received: by 2002:a17:90a:e983:: with SMTP id v3mr4750105pjy.71.1593195762787;
        Fri, 26 Jun 2020 11:22:42 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:52bf])
        by smtp.gmail.com with ESMTPSA id j36sm23889057pgj.39.2020.06.26.11.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 11:22:42 -0700 (PDT)
Date:   Fri, 26 Jun 2020 11:22:39 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
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
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH 00/14] Make the user mode driver code a better citizen
Message-ID: <20200626182239.in7lsupe257zlz5x@ast-mbp.dhcp.thefacebook.com>
References: <20200625095725.GA3303921@kroah.com>
 <778297d2-512a-8361-cf05-42d9379e6977@i-love.sakura.ne.jp>
 <20200625120725.GA3493334@kroah.com>
 <20200625.123437.2219826613137938086.davem@davemloft.net>
 <CAHk-=whuTwGHEPjvtbBvneHHXeqJC=q5S09mbPnqb=Q+MSPMag@mail.gmail.com>
 <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org>
 <20200626164055.5iasnou57yrtt6wz@ast-mbp.dhcp.thefacebook.com>
 <87sgeh926j.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sgeh926j.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 26, 2020 at 12:17:40PM -0500, Eric W. Biederman wrote:
> 
> > I'm swamped with other stuff today and will test the set Sunday/Monday
> > with other patches that I'm working on.
> > I'm not sure why you want to rename the interface. Seems
> > pointless. But fine.
> 
> For maintainability I think the code very much benefits from a clear
> separation between the user mode driver code from the user mode helper
> code.

you mean different name gives that separation? makes sense.

> > As far as routing trees. Do you mind I'll take it via bpf-next ?
> > As I said countless times we're working on bpf_iter using fork_blob.
> > If you take this set via your tree we would need to wait the whole kernel release.
> > Which is 8+ weeks before we can use the interface (due to renaming and overall changes).
> > I'd really like to avoid this huge delay.
> > Unless you can land it into 5.8-rc2 or rc3.
> 
> I also want to build upon this code.
> 
> How about when the review is done I post a frozen branch based on
> v5.8-rc1 that you can merge into the bpf-next tree, and I can merge into
> my branch.  That way we both can build upon this code.  That is the way
> conflicts like this are usually handled.

sure. that works too.

> Further I will leave any further enhancements to the user mode driver
> infrastructure that people have suggested to you.

ok
