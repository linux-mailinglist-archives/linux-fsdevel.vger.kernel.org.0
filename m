Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97793319294
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Feb 2021 19:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbhBKSza (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Feb 2021 13:55:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:57594 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230493AbhBKSzP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Feb 2021 13:55:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 14A0EAD57;
        Thu, 11 Feb 2021 18:54:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 10DDFDA6E9; Thu, 11 Feb 2021 19:52:35 +0100 (CET)
Date:   Thu, 11 Feb 2021 19:52:34 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, clm@fb.com,
        josef@toxicpanda.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V2 4/8] mm/highmem: Add VM_BUG_ON() to mem*_page() calls
Message-ID: <20210211185234.GG1993@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, clm@fb.com,
        josef@toxicpanda.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20210210062221.3023586-1-ira.weiny@intel.com>
 <20210210062221.3023586-5-ira.weiny@intel.com>
 <20210210125502.GD2111784@infradead.org>
 <20210210162901.GB3014244@iweiny-DESK2.sc.intel.com>
 <20210210185606.GF308988@casper.infradead.org>
 <20210210212228.GF3014244@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210212228.GF3014244@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 10, 2021 at 01:22:28PM -0800, Ira Weiny wrote:
> On Wed, Feb 10, 2021 at 06:56:06PM +0000, Matthew Wilcox wrote:
> > On Wed, Feb 10, 2021 at 08:29:01AM -0800, Ira Weiny wrote:
> > > And I thought it was a good idea.  Any file system development should have
> > > tests with DEBUG_VM which should cover Matthew's concern while not having the
> > > overhead in production.  Seemed like a decent compromise?
> > 
> > Why do you think these paths are only used during file system development?
> 
> I can't guarantee it but right now most of the conversions I have worked on are
> in FS's.
> 
> > They're definitely used by networking, by device drivers of all kinds
> > and they're probably even used by the graphics system.
> > 
> > While developers *should* turn on DEBUG_VM during development, a
> > shockingly high percentage don't even turn on lockdep.
> 
> Honestly, I don't feel strongly enough to argue it.

I checked my devel config and I don't have DEBUG_VM enabled, while I
have a bunch of other debugging options related to locking or other
fine-grained sanity checks. The help text is not very specific what
exactly is being checked other that it hurts performance, so I read it
as that it's for MM developers that change the MM code, while in
filesystem we use the APIs.

However, for the this patchset I'll turn it on all testing instances of
course.

> Andrew?  David?  David this is going through your tree so would you feel more
> comfortable with 1 or the other?

I think it's a question for MM people, for now I assume it's supposed to
be VM_BUG_ON.
