Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2E44202574
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jun 2020 19:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgFTRCY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Jun 2020 13:02:24 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38352 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgFTRCX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Jun 2020 13:02:23 -0400
Received: by mail-pf1-f195.google.com with SMTP id x207so6087215pfc.5;
        Sat, 20 Jun 2020 10:02:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hkYGXZYFNkz40ca5bdh2l8rwBQsGz5Dfq7lbQQ/ZMb4=;
        b=X9q8UfJZmL34AI1GiO5Dnai9g9KS072++uMh4hlNtqTqlfTy5/ba7jBlkjyo535lWC
         tUjHuWsJ6BPP/ng5gG33nwINjMbyZyZXMLjmIIqzIeVChyJTJIG4F6u8B9q4RB2Ma+y8
         WJcvd4TZ3OI9OplZ3O/vxXPXbSeB8wfjr/U6oY6tCu2sC50Vye2G/kNYpLsk6cIOSamP
         guRd24fxw8r53lgGCHCwHvgsFDXv+sVkbrHH5E41l0PLB8LSubGIpnQ6sJj/G6Mscd93
         SSnVhc8HhP3+CXxlv76lEjbFs4oQuFkWahQsOtVi5j94GE4u11uRpTmvgCdU01InmuDF
         noQw==
X-Gm-Message-State: AOAM532IfNgmHSESpXOm/8YZ5RnmvNPpxNVpAeW2B8+AFwNFEkzkSkgR
        tAqhwQpGJwLLW+PloRYKDzduPcQOyUA=
X-Google-Smtp-Source: ABdhPJw4cY69dDBjGxi+dEmU+lne2Jaj+Kt7j3+OOL+ZesgQbK+T06ayny/Nuk+eU5cbc92qa9tynQ==
X-Received: by 2002:a63:7c5e:: with SMTP id l30mr7050243pgn.276.1592672542711;
        Sat, 20 Jun 2020 10:02:22 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id x18sm9195784pfr.106.2020.06.20.10.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2020 10:02:20 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id B439940430; Sat, 20 Jun 2020 17:02:19 +0000 (UTC)
Date:   Sat, 20 Jun 2020 17:02:19 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Brian Gerst <brgerst@gmail.com>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] kernel: add a kernel_wait helper
Message-ID: <20200620170219.GT11244@42.do-not-panic.com>
References: <20200618144627.114057-1-hch@lst.de>
 <20200618144627.114057-7-hch@lst.de>
 <20200619211700.GS11244@42.do-not-panic.com>
 <20200620063538.GA2408@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200620063538.GA2408@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 20, 2020 at 08:35:38AM +0200, Christoph Hellwig wrote:
> On Fri, Jun 19, 2020 at 09:17:00PM +0000, Luis Chamberlain wrote:
> > On Thu, Jun 18, 2020 at 04:46:27PM +0200, Christoph Hellwig wrote:
> > > --- a/kernel/exit.c
> > > +++ b/kernel/exit.c
> > > @@ -1626,6 +1626,22 @@ long kernel_wait4(pid_t upid, int __user *stat_addr, int options,
> > >  	return ret;
> > >  }
> > >  
> > > +int kernel_wait(pid_t pid, int *stat)
> > > +{
> > > +	struct wait_opts wo = {
> > > +		.wo_type	= PIDTYPE_PID,
> > > +		.wo_pid		= find_get_pid(pid),
> > > +		.wo_flags	= WEXITED,
> > > +	};
> > > +	int ret;
> > > +
> > > +	ret = do_wait(&wo);
> > > +	if (ret > 0 && wo.wo_stat)
> > > +		*stat = wo.wo_stat;
> > 
> > Since all we care about is WEXITED, that could be simplified
> > to something like this:
> > 
> > if (ret > 0 && KWIFEXITED(wo.wo_stat)
> >  	*stat = KWEXITSTATUS(wo.wo_stat)
> > 
> > Otherwise callers have to use W*() wrappers.
> > 
> > > +	put_pid(wo.wo_pid);
> > > +	return ret;
> > > +}
> > 
> > Then we don't get *any* in-kernel code dealing with the W*() crap.
> > I just unwrapped this for the umh [0], given that otherwise we'd
> > have to use KW*() callers elsewhere. Doing it upshot one level
> > further would be even better.
> > 
> > [0] https://lkml.kernel.org/r/20200610154923.27510-1-mcgrof@kernel.org              
> Do you just want to pick this patch up, add your suggested bits and
> add it to the beginning of your series?  That should clean the whole
> thing up a bit.  Nothing else in this series depends on the patch.

Sure but let's wait to hear from the NFS folks.

I'm waiting to hear from NFS folks if the one place where the UMH is
fixed for the error code (on fs/nfsd/nfs4recover.c we never were
disabling the upcall as the error code of -ENOENT or -EACCES was *never*
properly checked for) to see how critical that was. If it can help
stable kernels the fix can go in as I proposed, followed by this patch
to further take the KWEXITSTATUS() up further, and ensure we *never*
deal with this in-kernel. If its not a fix stable kernels should care
for what you suggest of taking this patch first would be best and I'd be
happy to do that.

  Luis
