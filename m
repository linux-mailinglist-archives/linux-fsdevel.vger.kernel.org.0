Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07EF22745A7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Sep 2020 17:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgIVPoB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Sep 2020 11:44:01 -0400
Received: from mga05.intel.com ([192.55.52.43]:47272 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbgIVPoA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Sep 2020 11:44:00 -0400
IronPort-SDR: 5bc38UqX+uuwKTYbu+imdSTQ0tG36TLQnS7WFjdMHacoHyqa3qhO2p0DYxRpxOMfcDhz6Bsf/O
 bNAW32O2VTMA==
X-IronPort-AV: E=McAfee;i="6000,8403,9752"; a="245468157"
X-IronPort-AV: E=Sophos;i="5.77,291,1596524400"; 
   d="scan'208";a="245468157"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 08:44:00 -0700
IronPort-SDR: CrBX6uCXF/Ea+FOpNE7cJh8tZR89yO3TH83yCb8vusQ0t2a2qis7v6kd/QGYtfr1T+ca/2ACIf
 8+8dfadffPrg==
X-IronPort-AV: E=Sophos;i="5.77,291,1596524400"; 
   d="scan'208";a="486006776"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 08:44:00 -0700
Date:   Tue, 22 Sep 2020 08:43:59 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Eric Sandeen <esandeen@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Kani, Toshi" <toshi.kani@hpe.com>,
        "Norton, Scott J" <scott.norton@hpe.com>,
        "Tadakamadla, Rajesh (DCIG/CDI/HPS Perf)" 
        <rajesh.tadakamadla@hpe.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Subject: Re: [RFC] nvfs: a filesystem for persistent memory
Message-ID: <20200922154359.GT2540965@iweiny-DESK2.sc.intel.com>
References: <alpine.LRH.2.02.2009140852030.22422@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4gh=QaDB61_9_QTgtt-pZuTFdR6td0orE0VMH6=6SA2vw@mail.gmail.com>
 <alpine.LRH.2.02.2009211133190.15623@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2009211133190.15623@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 21, 2020 at 12:19:07PM -0400, Mikulas Patocka wrote:
> 
> 
> On Tue, 15 Sep 2020, Dan Williams wrote:
> 
> > > TODO:
> > >
> > > - programs run approximately 4% slower when running from Optane-based
> > > persistent memory. Therefore, programs and libraries should use page cache
> > > and not DAX mapping.
> > 
> > This needs to be based on platform firmware data f(ACPI HMAT) for the
> > relative performance of a PMEM range vs DRAM. For example, this
> > tradeoff should not exist with battery backed DRAM, or virtio-pmem.
> 
> Hi
> 
> I have implemented this functionality - if we mmap a file with 
> (vma->vm_flags & VM_DENYWRITE), then it is assumed that this is executable 
> file mapping - the flag S_DAX on the inode is cleared on and the inode 
> will use normal page cache.
> 
> Is there some way how to test if we are using Optane-based module (where 
> this optimization should be applied) or battery backed DRAM (where it 
> should not)?
> 
> I've added mount options dax=never, dax=auto, dax=always, so that the user 
                                      ^^^^^^^^
				      dax=inode?

'inode' is the option used by ext4/xfs.

Ira

> can override the automatic behavior.
> 
> Mikulas
> 
