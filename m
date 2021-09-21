Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1AC413003
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 10:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhIUIPx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Sep 2021 04:15:53 -0400
Received: from verein.lst.de ([213.95.11.211]:55455 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230488AbhIUIPp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Sep 2021 04:15:45 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 241FF67373; Tue, 21 Sep 2021 10:14:15 +0200 (CEST)
Date:   Tue, 21 Sep 2021 10:14:14 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs@vger.kernel.org, dan.j.williams@intel.com,
        david@fromorbit.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        rgoldwyn@suse.de, viro@zeniv.linux.org.uk, willy@infradead.org
Subject: Re: [PATCH v9 7/8] xfs: support CoW in fsdax mode
Message-ID: <20210921081414.GA28927@lst.de>
References: <20210915104501.4146910-1-ruansy.fnst@fujitsu.com> <20210915104501.4146910-8-ruansy.fnst@fujitsu.com> <20210916002227.GD34830@magnolia> <20210916063251.GE13306@lst.de> <20210917153304.GB10250@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917153304.GB10250@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 17, 2021 at 08:33:04AM -0700, Darrick J. Wong wrote:
> > More importantly before we can merge this series we also need the VM
> > level support for reflink-aware reverse mapping.  So while this series
> > here is no in a good enough shape I don't see how we could merge it
> > without that other series as we'd have to disallow mmap for reflink+dax
> > files otherwise.
> 
> I've forgotten why we need mm level reverse mapping again?  The pmem
> poison stuff can use ->media_failure (or whatever it was called,
> memory_failure?) to find all the owners and notify them.  Was there
> some other accounting reason that fell out of my brain?
> 
> I'm more afraid of 'sharing pages between files needs mm support'
> sparking another multi-year folioesque fight with the mm people.

Because of the way page->mapping is used by DAX.  But I think this is
mostly under control in the other series.
