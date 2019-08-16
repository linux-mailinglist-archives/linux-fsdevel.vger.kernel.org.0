Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAC1906FF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2019 19:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbfHPRe5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Aug 2019 13:34:57 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35455 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfHPRe4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Aug 2019 13:34:56 -0400
Received: by mail-pg1-f193.google.com with SMTP id n4so3287307pgv.2;
        Fri, 16 Aug 2019 10:34:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3Xy9YcG04MIYCahd4cU2uQmTISnqMkZBSAqzvxVs66w=;
        b=rN0oUiXrFng512e6g3ezQL6fiGhv0TxqmSjI4KHY6Ez7A7tjEarRb9PLIhFWCcmBvF
         ENJ8R23G1moGWPzGokDkPkflbbKaIldr6wWIo22TOfCIjqp2nVSfCp94bNUHVOLSa3ot
         Ep2XaGgGsnfdBaDwaqyiaxQ8oKPDe1kktpkzsJOYc9vBVFH04Ex4vlHQQ6FSuXMRpPEo
         DUtf7h3dL+cYDsnh0M+TNiGkNyw+HZpnJ1OLX9LuD5dm0mkDUu1hPceFZTduL+ILupco
         cr4LueRkkrgmdtTJlWFIkX5c3sVmBEgxwiBUx9FEF6Bd77G+ohfczqxyVGq7wLB7Kozk
         gfqA==
X-Gm-Message-State: APjAAAWxCiqqOWHsRZv9t0tkt2tlMYOF7nM+zPBgt43p4HDAeE7xXfxB
        hMTWeV0IjnZZaDxSRCF1dNI=
X-Google-Smtp-Source: APXvYqxbyOqhPRPZESWOfYzipDa4UMvpwJhisE0n7mQeRUvSAD4C/o0spTVjdA/59LWOOMcUb8HtcQ==
X-Received: by 2002:a65:4044:: with SMTP id h4mr8820268pgp.164.1565976895783;
        Fri, 16 Aug 2019 10:34:55 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id ck8sm4601529pjb.25.2019.08.16.10.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 10:34:54 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 93993403B8; Fri, 16 Aug 2019 17:34:53 +0000 (UTC)
Date:   Fri, 16 Aug 2019 17:34:53 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>, fstests@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Sasha Levin <levinsasha928@gmail.com>,
        Valentin Rothberg <valentinrothberg@gmail.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [ANN] oscheck: wrapper for fstests check.sh - tracking and
 working with baselines
Message-ID: <20190816173453.GM16384@42.do-not-panic.com>
References: <CAB=NE6UjcBgQhoQvZoWKXnPWoHVNMbeYdyGfYsHdgeA=L1M4wQ@mail.gmail.com>
 <20180713205154.GA8782@bombadil.infradead.org>
 <20180713205931.GC3620@garbanzo.do-not-panic.com>
 <20180714222115.GA13230@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180714222115.GA13230@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 14, 2018 at 03:21:15PM -0700, Matthew Wilcox wrote:
> On Fri, Jul 13, 2018 at 01:59:31PM -0700, Luis R. Chamberlain wrote:
> > > It's still ridiculously hard
> > > to set up a DAX test environment though. 
> 
> > > The best I've been able to
> > > do is now merged into Kent's ktest -- but you're not based on that,
> > > so I'll try and get your ostest set up to work with DAX.  Or maybe Ross
> > > can do it since he's actually been able to get 2MB pages working and I
> > > still haven't :-(
> > 
> > Patches and new sections to cover more ground indeed are appreciated!
> 
> I feel like we need to merge ktest and oscheck.

In the end I disagreed.

> oscheck assumes that you
> know how to set up qemu, and ktest takes care of setting up qemu for you.

I really disliked all the stupid hacks we had both mine and Kent's
solution. So I wrote a proper modern devops environment for Linux kernel
development which is agnostic to from an architectural pespective to
your OS, and virtualization environment, whether that be local or cloud.

Addressing cloud and local virtual environment proved more diffcult and
took a bit of time. But with a bit of patience, I found something
suitable, and better than just hacks put together.

It relies on ansible, vagrant and terraform. The later two unfortunately
rely on Ruby...  Let me be clear though, I have my own reservations
about relying on solutions which rely on Ruby... but I find that
startups *should* do a better job than a few kernel developers writing
shell hacks for their own prefferred virtual environment. With a bit of
proper ... nudging...  I think we can steer things in the right
direction. vagrant / terraform are at least perhaps more usable and
popular then a few shell hacks.

oscheck now embraces this solution, and you don't need to know much
about setting up qemu, and even supports running on OS X. I've announced
the effort through lkml as it turns out the nuts and bolts about the
generic setup is actually a more common goal than for filesystems. The
results:

https://people.kernel.org/mcgrof/kdevops-a-devops-framework-for-linux-kernel-development

  Luis
