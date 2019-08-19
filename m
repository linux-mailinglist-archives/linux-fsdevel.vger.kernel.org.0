Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 308A5923A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2019 14:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfHSMit (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Aug 2019 08:38:49 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44429 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbfHSMin (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Aug 2019 08:38:43 -0400
Received: by mail-qk1-f196.google.com with SMTP id d79so1205332qke.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Aug 2019 05:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kcl2qjS+S92HqUsWy/tjB3qoqqgCsFoa4lNkLGm9eqU=;
        b=Kw5dYDPC3RCMymknBRy1kIe+iDY+gtMlsFiGqHh0HRHDdkA1mVDMtLhKZZ0CG2KFv3
         LVYv+T9FGmeylYTDi+kh5M9/Ntuhs1KUREG17679sHQhmPsIVOwRG2eQbHs3GIhuH2De
         teqAib33hkHc6gnoEGXxQH7ITS22Bxbhltn46+fBqORa9Jb9jv/kTbwn4XmLd12IuyM5
         /yPvmu7+YELsKojRcfZOMaNBoqJ1qtrNgLmHYKwBdl9/gdtpWh1vLo6xyTHwMVm7oA6I
         7K86YItRgHihPHUhSIgXXcp4Bm7RF41NJgLrAPGgKKR410ENEsEKjr9s9uuDjUGnheP5
         bsRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kcl2qjS+S92HqUsWy/tjB3qoqqgCsFoa4lNkLGm9eqU=;
        b=fHOxNAGihI9HmisG2tVMfS/HZgZ2T71Hzux/Z0pgkwG1MDOQI67fcleOZWaDGtzlZq
         WZ0gSiAEAp6QA3lgc3IcFG16K2wFYLJt7gBuMyELLgj4bT0MfMyUma5fAkbxoB953WV4
         6yFx9Ek+/o1DwFiCb8tKNrNc2FWvXZETt7PIkZLHuGKYwSFYu4SHhQB926QxjmkRD6+S
         2t91GTeW8qaW6L4qwvCmrtZG1xiiez3Iiz+D19VRdcjNExW2JVrBAot2SFoRZ1SwHhDH
         IXycst1AFa6nJRtUDVAThEH++CWDrOzOhD0DBj+F1w+vx8m1P3C678DeRnkhagUMcwY/
         /rBQ==
X-Gm-Message-State: APjAAAWd4M2zDrbK4tHTKpx2zhbvHUregLdI3lJfFcaa1dwIkmzGQwml
        EQBQhCK4IoVMmsoSf07D8ZrCkw==
X-Google-Smtp-Source: APXvYqzbQNTYwMVTncdSqshKmZtcSi8KUDzyxSrbcJIuOywIrId5vXd75IqedVtc8bcWHqWRX6iGcQ==
X-Received: by 2002:a37:a14a:: with SMTP id k71mr20104946qke.281.1566218322367;
        Mon, 19 Aug 2019 05:38:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id r15sm6916339qtp.94.2019.08.19.05.38.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Aug 2019 05:38:41 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hzgvp-0001vJ-9J; Mon, 19 Aug 2019 09:38:41 -0300
Date:   Mon, 19 Aug 2019 09:38:41 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jan Kara <jack@suse.cz>, Ira Weiny <ira.weiny@intel.com>,
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
Message-ID: <20190819123841.GC5058@ziepe.ca>
References: <20190809225833.6657-1-ira.weiny@intel.com>
 <20190814101714.GA26273@quack2.suse.cz>
 <20190814180848.GB31490@iweiny-DESK2.sc.intel.com>
 <20190815130558.GF14313@quack2.suse.cz>
 <20190816190528.GB371@iweiny-DESK2.sc.intel.com>
 <20190817022603.GW6129@dread.disaster.area>
 <20190819063412.GA20455@quack2.suse.cz>
 <20190819092409.GM7777@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819092409.GM7777@dread.disaster.area>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 19, 2019 at 07:24:09PM +1000, Dave Chinner wrote:

> So that leaves just the normal close() syscall exit case, where the
> application has full control of the order in which resources are
> released. We've already established that we can block in this
> context.  Blocking in an interruptible state will allow fatal signal
> delivery to wake us, and then we fall into the
> fatal_signal_pending() case if we get a SIGKILL while blocking.

The major problem with RDMA is that it doesn't always wait on close() for the
MR holding the page pins to be destoyed. This is done to avoid a
deadlock of the form:

   uverbs_destroy_ufile_hw()
      mutex_lock()
       [..]
        mmput()
         exit_mmap()
          remove_vma()
           fput();
            file_operations->release()
             ib_uverbs_close()
              uverbs_destroy_ufile_hw()
               mutex_lock()   <-- Deadlock

But, as I said to Ira earlier, I wonder if this is now impossible on
modern kernels and we can switch to making the whole thing
synchronous. That would resolve RDMA's main problem with this.

Jason
