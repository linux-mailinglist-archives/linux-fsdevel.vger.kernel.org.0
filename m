Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B65015A229
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 08:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbgBLHhV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 02:37:21 -0500
Received: from verein.lst.de ([213.95.11.211]:36725 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727669AbgBLHhU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:37:20 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id BD9B868B05; Wed, 12 Feb 2020 08:37:17 +0100 (CET)
Date:   Wed, 12 Feb 2020 08:37:17 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: Re: [PATCH 01/12] mm: fix a comment in sys_swapon
Message-ID: <20200212073717.GB25555@lst.de>
References: <20200114161225.309792-1-hch@lst.de> <20200114161225.309792-2-hch@lst.de> <20200210152942.2ec4d0b71851feccb7387266@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210152942.2ec4d0b71851feccb7387266@linux-foundation.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 10, 2020 at 03:29:42PM -0800, Andrew Morton wrote:
> On Tue, 14 Jan 2020 17:12:14 +0100 Christoph Hellwig <hch@lst.de> wrote:
> 
> > claim_swapfile now always takes i_rwsem.
> > 
> > ...
> >
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -3157,7 +3157,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
> >  	mapping = swap_file->f_mapping;
> >  	inode = mapping->host;
> >  
> > -	/* If S_ISREG(inode->i_mode) will do inode_lock(inode); */
> > +	/* will take i_rwsem; */
> >  	error = claim_swapfile(p, inode);
> >  	if (unlikely(error))
> >  		goto bad_swap;
> 
> http://lkml.kernel.org/r/20200206090132.154869-1-naohiro.aota@wdc.com
> removes this comment altogether.  Please check that this is OK?

Killing it is fine with me.  Just the fact that the comment was wrong
while I did an audit of the area really thew me off.
