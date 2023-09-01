Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29AA3790212
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Sep 2023 20:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350596AbjIASei (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Sep 2023 14:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbjIASeh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Sep 2023 14:34:37 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA84E19E
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Sep 2023 11:34:33 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c1ff5b741cso18917765ad.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Sep 2023 11:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693593273; x=1694198073; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Tq1EURtK5iT/JOAA9Bn+fOSTaz8ZmzG3v1Z2miOriec=;
        b=Sh07G1cA259YD6yFoXtHN42kG7guoGfOiTjjthwTEd+vzIV7SUtV6cSQgp1h6aVqGu
         i+T4RJ6Q8j9knuxgV4ak3RlGOpQgmWDTT3FwbwFLgS33xkaec/t9fX3ETABJrUiUlQa6
         gwM0vHf38liWh0kYbFyjFRtNHto8rH1bp9JtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693593273; x=1694198073;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tq1EURtK5iT/JOAA9Bn+fOSTaz8ZmzG3v1Z2miOriec=;
        b=FgT2JJcsQ/T3zmGWTMLz4dbXq6M3aN06AhUy1SSFChBvHfKSysJANnmleh+Okl0Uh5
         +mdcYMe1FV3zQTWtF5oUOg+M77pJ8ZGTcTlLIMjGVoU+KhTdl8I/5pfXPzyxweHe5gC9
         cZnwk3EoGGa8OQCTj9cFIWIq0MS4MAumNZUbOZwk1WADC99ax16TimMSu2ORIFqRSAuu
         fKA/c9X0Gk6iF3hNGiHodQ/w/9j+yCdlVn30mtf/1xEWLn8TBgiGIPYBygH8uRCocXWL
         TV0TDzAxAB1tWrp7FS/S0O8ihkPGY9xTEEj7Nw4kd5OyYhIfzXX39SFpkxXtRp97Vmys
         rusg==
X-Gm-Message-State: AOJu0YxX8X6rYb+BLfVx8wMZLgdbBjWkci6YVMxxC/RqgsSIYiHwDZqg
        vKv9fVFIyWvF0xZcgtSIQ8GdBQ==
X-Google-Smtp-Source: AGHT+IFryZGHKWCVOHEdkh98Zm1lPohKlq7V2+pyDpR6BzIqdx+03ZDWCYThp7Q1cOAgeQiMqcM8nA==
X-Received: by 2002:a17:902:c1ca:b0:1b8:8223:8bdd with SMTP id c10-20020a170902c1ca00b001b882238bddmr3566419plc.59.1693593273272;
        Fri, 01 Sep 2023 11:34:33 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c25500b001aaecc0b6ffsm3314254plg.160.2023.09.01.11.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 11:34:32 -0700 (PDT)
Date:   Fri, 1 Sep 2023 11:34:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jeff Xu <jeffxu@google.com>, Aleksa Sarai <cyphar@cyphar.com>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] fcntl: add fcntl(F_CHECK_ORIGINAL_MEMFD)
Message-ID: <202309011133.10D66D0785@keescook>
References: <20230831203647.558079-1-mclapinski@google.com>
 <20230831203647.558079-2-mclapinski@google.com>
 <20230901-lockt-erbfolge-e1f9a26f0d63@brauner>
 <CAAi7L5f1KYrAyCYLzUN0dSy6xuQCGcC7SQML4+KUdxnQ6RaFfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAi7L5f1KYrAyCYLzUN0dSy6xuQCGcC7SQML4+KUdxnQ6RaFfg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 01, 2023 at 04:50:53PM +0200, Michał Cłapiński wrote:
> On Fri, Sep 1, 2023 at 2:56 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Thu, Aug 31, 2023 at 10:36:46PM +0200, Michal Clapinski wrote:
> > > Add a way to check if an fd points to the memfd's original open fd
> > > (the one created by memfd_create).
> > > Useful because only the original open fd can be both writable and
> > > executable.
> > >
> > > Signed-off-by: Michal Clapinski <mclapinski@google.com>
> > > ---
> > >  fs/fcntl.c                 | 3 +++
> > >  include/uapi/linux/fcntl.h | 9 +++++++++
> > >  2 files changed, 12 insertions(+)
> > >
> > > diff --git a/fs/fcntl.c b/fs/fcntl.c
> > > index e871009f6c88..301527e07a4d 100644
> > > --- a/fs/fcntl.c
> > > +++ b/fs/fcntl.c
> > > @@ -419,6 +419,9 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
> > >       case F_SET_RW_HINT:
> > >               err = fcntl_rw_hint(filp, cmd, arg);
> > >               break;
> > > +     case F_CHECK_ORIGINAL_MEMFD:
> > > +             err = !(filp->f_mode & FMODE_WRITER);
> > > +             break;
> >
> > Honestly, make this an ioctl on memfds. This is so specific that it
> > really doesn't belong into fcntl().
> 
> I've never touched ioctls but if I'm correct, I can't just add it to
> memfd. I would have to add it to the underlying fs, so hugetlbfs and
> shmem (which I think can be defined as ramfs so also there). File
> sealing fcntl is already memfd specific. Are you sure ioctl will be a
> better idea?

Does this check "mean" anything for other files? Because if it's
generically useful (and got renamed) it maybe would be right for
fcntl...

-- 
Kees Cook
