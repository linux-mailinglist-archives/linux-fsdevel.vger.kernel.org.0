Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03D6D98277
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 20:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbfHUSNq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 14:13:46 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37129 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728433AbfHUSNq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 14:13:46 -0400
Received: by mail-qk1-f193.google.com with SMTP id s14so2681130qkm.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2019 11:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bHHnCAoSSDpRzr3ZJCedqeeuFCaqygWmcbOwu0GqMSA=;
        b=Qgcco7IZqTKFGWri3OFKIxQs50TLEE0TiNlti7iAsNa2YxoUtIEC/kmkG4mqzWd5vx
         dAEYm1l8akW6Dx6gkXMeyTYrYWzVvqqhXLc9Wi33WF5eexaQlMNP9I1tANW4BWLO9X4m
         U690GPIOS3FTXncPXRbHujnFKeyts2lwK8TpavTJeLIZzmMHBBQrWrIx6R4/RpLjsB+K
         jyh5fH82OUkzUtaCjFCtqAj5ocmtqZyIW2+9FMIJs00RrZvm58Azy/ZF7FnMOgpINn2B
         bTnaW1HjV9dtBuNXocm8W2Z0TEVmpnYHF+UdRfnviC/aqKSI5dij5v+64SWvwnRCwj6y
         /eyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bHHnCAoSSDpRzr3ZJCedqeeuFCaqygWmcbOwu0GqMSA=;
        b=k2NuiNkK3o4tL5i1NS1T01M9J+v7wSulkFa+0LMhDnQM8vyXUOgwjfYF0tkWLbEpHZ
         O88M6nKdK6xDTBIj21tMubudkT44PGImJHuNK88KLP3Su1X8yxmwFzWSGi/y7S9keq2J
         axYiJpuLZ9rnXCUYZ6sItnMrkexJrvziM7sspZcZxQAFvRNdcBanFfgBZ/2wc9h/sOCs
         gUjxek5P+PK1nv7z+Jnnl666UKuR8LcTf+ujI+dmbqSRuXon0IAmlvpsP4I99Sj10YK7
         uybl7h3f+nZRgXvcCHCs9cNHhgxO2CGfQvlPGlvt3ECrDkh5F10HpAqCh4vfBgTJwIEH
         4W+w==
X-Gm-Message-State: APjAAAUSAnQrKO70rYCcyG/vH/h8xTEcaFgLscFft6JY7lK2fEBVfwyC
        wBOqw0imY2kQH4Xn4dFkzi7MZw==
X-Google-Smtp-Source: APXvYqwFXCEFWzK4RJb35JVztczAA867594O8rIt9PQNCYO3wOwCiP8oQWX35qTf9qi8kUZj5grU/g==
X-Received: by 2002:a05:620a:15c4:: with SMTP id o4mr26683337qkm.326.1566411224893;
        Wed, 21 Aug 2019 11:13:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id i8sm10205025qkm.46.2019.08.21.11.13.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Aug 2019 11:13:44 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i0V79-00076J-Vz; Wed, 21 Aug 2019 15:13:43 -0300
Date:   Wed, 21 Aug 2019 15:13:43 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>, linux-xfs@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-ext4@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 00/19] RDMA/FS DAX truncate proposal V1,000,002 ;-)
Message-ID: <20190821181343.GH8653@ziepe.ca>
References: <20190814180848.GB31490@iweiny-DESK2.sc.intel.com>
 <20190815130558.GF14313@quack2.suse.cz>
 <20190816190528.GB371@iweiny-DESK2.sc.intel.com>
 <20190817022603.GW6129@dread.disaster.area>
 <20190819063412.GA20455@quack2.suse.cz>
 <20190819092409.GM7777@dread.disaster.area>
 <20190819123841.GC5058@ziepe.ca>
 <20190820011210.GP7777@dread.disaster.area>
 <20190820115515.GA29246@ziepe.ca>
 <20190821180200.GA5965@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821180200.GA5965@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 21, 2019 at 11:02:00AM -0700, Ira Weiny wrote:
> On Tue, Aug 20, 2019 at 08:55:15AM -0300, Jason Gunthorpe wrote:
> > On Tue, Aug 20, 2019 at 11:12:10AM +1000, Dave Chinner wrote:
> > > On Mon, Aug 19, 2019 at 09:38:41AM -0300, Jason Gunthorpe wrote:
> > > > On Mon, Aug 19, 2019 at 07:24:09PM +1000, Dave Chinner wrote:
> > > > 
> > > > > So that leaves just the normal close() syscall exit case, where the
> > > > > application has full control of the order in which resources are
> > > > > released. We've already established that we can block in this
> > > > > context.  Blocking in an interruptible state will allow fatal signal
> > > > > delivery to wake us, and then we fall into the
> > > > > fatal_signal_pending() case if we get a SIGKILL while blocking.
> > > > 
> > > > The major problem with RDMA is that it doesn't always wait on close() for the
> > > > MR holding the page pins to be destoyed. This is done to avoid a
> > > > deadlock of the form:
> > > > 
> > > >    uverbs_destroy_ufile_hw()
> > > >       mutex_lock()
> > > >        [..]
> > > >         mmput()
> > > >          exit_mmap()
> > > >           remove_vma()
> > > >            fput();
> > > >             file_operations->release()
> > > 
> > > I think this is wrong, and I'm pretty sure it's an example of why
> > > the final __fput() call is moved out of line.
> > 
> > Yes, I think so too, all I can say is this *used* to happen, as we
> > have special code avoiding it, which is the code that is messing up
> > Ira's lifetime model.
> > 
> > Ira, you could try unraveling the special locking, that solves your
> > lifetime issues?
> 
> Yes I will try to prove this out...  But I'm still not sure this fully solves
> the problem.
> 
> This only ensures that the process which has the RDMA context (RDMA FD) is safe
> with regard to hanging the close for the "data file FD" (the file which has
> pinned pages) in that _same_ process.  But what about the scenario.

Oh, I didn't think we were talking about that. Hanging the close of
the datafile fd contingent on some other FD's closure is a recipe for
deadlock..

IMHO the pin refcnt is held by the driver char dev FD, that is the
object you need to make it visible against.

Why not just have a single table someplace of all the layout leases
with the file they are held on and the FD/socket/etc that is holding
the pin? Make it independent of processes and FDs?

Jason
