Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77F9218919
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 15:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbgGHNcy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 09:32:54 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33707 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729323AbgGHNcx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 09:32:53 -0400
Received: by mail-pf1-f194.google.com with SMTP id m9so9717909pfh.0;
        Wed, 08 Jul 2020 06:32:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G3W3NkSnYhvVkNWYcmyRPWMbSJt95CSFGEsN8GxSyEw=;
        b=mVanR3Whkf4arRJg+Thx4buqfyznr1htPmIEtMovYg8JU2x4Y0fUITkChQIPudh8fs
         IaFhf8DzAIITNTmXFtWk70Da3vB6SYOCXMOUwZ3XrGf04jz8aqKmtHQxZ9vXgXV/HV3A
         Y8FIcCnZLjSJM2XZQHLYxOaElpwgJHyDPqbSbthyXWUjBlnKVdTwY0KdIuyh0eh7YsjJ
         uXrHbeIS6GlGmGjEOH6m8O6RXXLIFsb0+EcyT+OWuftQv+J369LEHLIyzuHX1SY3Xanw
         3h5k17dvLZilYwqfMN5Qvxqh6dzRc9I59PRmRNkuzAlkRUutb9ZeQBXoshmUkxAXtDer
         ew2g==
X-Gm-Message-State: AOAM533d3i/ukNuyU4lsK1I//23MxoKIm+kvoMK9TRA1+JoEvoleeajw
        yb+OTEw3xRrL1HqERj9ZlNE=
X-Google-Smtp-Source: ABdhPJwZ7feFM1ZYPTAtPzjUOIBUzFcSp+eVIFKh44MG9j3GZhMy3GAUeMk4BS0+DEkeaPGPchsaFA==
X-Received: by 2002:a62:7505:: with SMTP id q5mr50170680pfc.262.1594215171970;
        Wed, 08 Jul 2020 06:32:51 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id n25sm12846pff.51.2020.07.08.06.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 06:32:51 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 801FF401AE; Wed,  8 Jul 2020 13:32:50 +0000 (UTC)
Date:   Wed, 8 Jul 2020 13:32:50 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 10/16] exec: Remove do_execve_file
Message-ID: <20200708133250.GH4332@42.do-not-panic.com>
References: <87y2o1swee.fsf_-_@x220.int.ebiederm.org>
 <20200702164140.4468-10-ebiederm@xmission.com>
 <20200708063525.GC4332@42.do-not-panic.com>
 <20200708124148.GP13911@42.do-not-panic.com>
 <87y2nugnnq.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2nugnnq.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 08, 2020 at 08:08:09AM -0500, Eric W. Biederman wrote:
> Luis Chamberlain <mcgrof@kernel.org> writes:
> 
> > On Wed, Jul 08, 2020 at 06:35:25AM +0000, Luis Chamberlain wrote:
> >> On Thu, Jul 02, 2020 at 11:41:34AM -0500, Eric W. Biederman wrote:
> >> > Now that the last callser has been removed remove this code from exec.
> >> > 
> >> > For anyone thinking of resurrecing do_execve_file please note that
> >> > the code was buggy in several fundamental ways.
> >> > 
> >> > - It did not ensure the file it was passed was read-only and that
> >> >   deny_write_access had been called on it.  Which subtlely breaks
> >> >   invaniants in exec.
> >> > 
> >> > - The caller of do_execve_file was expected to hold and put a
> >> >   reference to the file, but an extra reference for use by exec was
> >> >   not taken so that when exec put it's reference to the file an
> >> >   underflow occured on the file reference count.
> >> 
> >> Maybe its my growing love with testing, but I'm going to have to partly
> >> blame here that we added a new API without any respective testing.
> >> Granted, I recall this this patch set could have used more wider review
> >> and a bit more patience... but just mentioning this so we try to avoid
> >> new api-without-testing with more reason in the future.
> >> 
> >> But more importantly, *how* could we have caught this? Or how can we
> >> catch this sort of stuff better in the future?
> >
> > Of all the issues you pointed out with do_execve_file(), since upon
> > review the assumption *by design* was that LSMs/etc would pick up issues
> > with the file *prior* to processing, I think that this file reference
> > count issue comes to my attention as the more serious issue which I
> > wish we could address *first* before this crusade.
> >
> > So I have to ask, has anyone *really tried* to give a crack at fixing
> > this refcount issue in a smaller way first? Alexei?
> >
> > I'm not opposed to the removal of do_execve_file(), however if there
> > is a reproducible crash / issue with the existing user, this sledge
> > hammer seems a bit overkill for older kernels.
> 
> It does not matter for older kernels because there is exactly one user.
> That one user is just a place holder keeping the code alive until a real
> user comes along.
> 
> For older kernels the solution is to just mark the bpfilter code broken
> in Kconfig and refuse to compile it.  That is the trivial backportable
> fix if anyone wants one.

This seals the deal for me, thanks! Carry on, but hey, please add
yourself to MAINTAINERS too :)
 
  Luis
