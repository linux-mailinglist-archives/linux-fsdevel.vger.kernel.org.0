Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B23DB205AE5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jun 2020 20:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387472AbgFWSf2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jun 2020 14:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387410AbgFWSfY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jun 2020 14:35:24 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79546C061573;
        Tue, 23 Jun 2020 11:35:24 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s10so10272546pgm.0;
        Tue, 23 Jun 2020 11:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AQ/e5sEh4Ldk6IXzWL/y51NsKG35Zs68anCke7z6z/s=;
        b=dKJ9nmNCJ+mPmEBiBGGewsP8s8aWxQEcaHIQDSRKzOJ9/hC+J9YXD/CaJ2z3tEscXJ
         f/7IBOhx640GOZzY04ZSgQPVsl0/Ew0ie85ObaEiVTyP5+kqRkh5tvpxuSgsy8gOnoWf
         vWBaR0QK638Qci3adZPSQQ5tkf9e6QeFZrzKEgKhU1Qc/oK/YJ3+p7oDmIvQl49YfLU2
         iPkJMRdgkwFGkez0R2SiQ5wDGaqcNPg+V7q5K4TkLLugSP2yBMpPW7Oqwoy3PcoAyS3J
         2lYmRQQXjeYUxfVu959Nx0e6BnO16L3pSh3VuiYPB3h3FqrHoEyt55mhJyTh/JPPYsI+
         j6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AQ/e5sEh4Ldk6IXzWL/y51NsKG35Zs68anCke7z6z/s=;
        b=ijyW5hcKY5KyGkYy6Fd0TDarpUFPm/X90ygqGddvCmL8vHrpSpGFGzR5Kd4GMugjB4
         sk4fiGzb0ezaOEAQ9EoAC6GWljdruWsXFhABCJRI6wKGnZSCbWf+ua9IJXDAr75IDqz/
         IU0GSmV9tYK34su5y4SvchQhWtYdfoePkyi7Y0qUkv5BvQvpJHmoyA/6BK00iUv6Yt71
         KbeIoc4nMWEul3wbVAfokFJqfGlPJWHiIo62nynDub3VdCep8BzXDLU4H0hMHEjijNlr
         fD9Vv1TidnyAOlW7mmPHyjXtSJCKCEy6ebMoZjP/x74+pi3+WJZW8Nj35pRuZu+D1k1a
         uDKw==
X-Gm-Message-State: AOAM532OsugUoxScJU3JwvWUMHbvK1CHN6v6spU5lHeSXraSM17Ldmxu
        gu0YTnppKvrb5TAOPVlvL5c=
X-Google-Smtp-Source: ABdhPJz4xrsrL7BmMRFrYv1otPe1IxIPy1IbscbS3JFyG63yahruWjjbACaZB3Otqprxu6LPZHkqFw==
X-Received: by 2002:a62:1654:: with SMTP id 81mr26744482pfw.137.1592937323995;
        Tue, 23 Jun 2020 11:35:23 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:4e7a])
        by smtp.gmail.com with ESMTPSA id f3sm3176496pjw.57.2020.06.23.11.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 11:35:23 -0700 (PDT)
Date:   Tue, 23 Jun 2020 11:35:20 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
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
Message-ID: <20200623183520.5e7fmlt3omwa2lof@ast-mbp.dhcp.thefacebook.com>
References: <87r1uo2ejt.fsf@x220.int.ebiederm.org>
 <20200609235631.ukpm3xngbehfqthz@ast-mbp.dhcp.thefacebook.com>
 <87d066vd4y.fsf@x220.int.ebiederm.org>
 <20200611233134.5vofl53dj5wpwp5j@ast-mbp.dhcp.thefacebook.com>
 <87bllngirv.fsf@x220.int.ebiederm.org>
 <CAADnVQ+qNxFjTYBpYW9ZhStMh_oJBS5C_FsxSS=0Mzy=u54MSg@mail.gmail.com>
 <CAADnVQLuGYX=LamARhrZcze1ej4ELj-y99fLzOCgz60XLPw_cQ@mail.gmail.com>
 <87ftaxd7ky.fsf@x220.int.ebiederm.org>
 <20200616015552.isi6j5x732okiky4@ast-mbp.dhcp.thefacebook.com>
 <87h7v1pskt.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7v1pskt.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 23, 2020 at 01:04:02PM -0500, Eric W. Biederman wrote:
> 
> Sigh.  I was busy last week so I left reading this until now in the
> hopes I would see something reasonable.
> 
> What I see is rejecting of everything that is said to you.
> 
> What I do not see are patches fixing issues.  I will await patches.

huh?
I can say exactly the same. You keep ignoring numerous points I brought up.
You still haven't showed what kind of refactoring you have in mind and
why fork_blob is in its way.
