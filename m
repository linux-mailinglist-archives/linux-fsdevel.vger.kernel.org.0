Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4264C167C78
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 12:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgBULrN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 06:47:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:60680 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726989AbgBULrM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 06:47:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 42F4DACF2;
        Fri, 21 Feb 2020 11:47:10 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C690C1E0BAE; Fri, 21 Feb 2020 12:47:09 +0100 (CET)
Date:   Fri, 21 Feb 2020 12:47:09 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        tytso@mit.edu, "Darrick J. Wong" <darrick.wong@oracle.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cmaiolino@redhat.com
Subject: Re: [RFCv2 0/4] ext4: bmap & fiemap conversion to use iomap
Message-ID: <20200221114709.GB27165@quack2.suse.cz>
References: <cover.1580121790.git.riteshh@linux.ibm.com>
 <20200130160018.GC3445353@magnolia>
 <20200205124750.AE9DDA404D@d06av23.portsmouth.uk.ibm.com>
 <20200205155733.GH6874@magnolia>
 <20200206052619.D4BBCA405F@b06wcsmtp001.portsmouth.uk.ibm.com>
 <20200206102254.GK14001@quack2.suse.cz>
 <20200220170304.80C3E52051@d06av21.portsmouth.uk.ibm.com>
 <20200220170953.GA11221@infradead.org>
 <20200221041644.53A9852052@d06av21.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221041644.53A9852052@d06av21.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 21-02-20 09:46:43, Ritesh Harjani wrote:
> 
> 
> On 2/20/20 10:39 PM, Christoph Hellwig wrote:
> > On Thu, Feb 20, 2020 at 10:33:03PM +0530, Ritesh Harjani wrote:
> > > So I was making some changes along the above lines and I think we can take
> > > below approach for filesystem which could determine the
> > > _EXTENT_LAST relatively easily and for cases if it cannot
> > > as Jan also mentioned we could keep the current behavior as is and let
> > > iomap core decide the last disk extent.
> > 
> > Well, given that _EXTENT_LAST never worked properly on any file system
> > since it was added this actually changes behavior and could break
> > existing users.  I'd rather update the documentation to match reality
> > rather than writing a lot of code for a feature no one obviously cared
> > about for years.
> 
> Well I agree to this. Since either ways the _EXTENT_LAST has never worked
> properly or in the same manner across different filesystems.
> In ext4 itself it works differently for extent v/s non-extent based FS.
> So updating the documentation would be a right way to go from here.
> 
> Ted/Jan - do you agree here:-
> Shall we move ahead with this patch series in converting ext4_fiemap to
> use iomap APIs, without worrying about how _EXTENT_LAST is being set via
> iomap core code?

Yes, I'd go ahead with the conversion and don't really bother with backward
compatibility here. In the unlikely case someone comes with a real breakage
this causes, we can always think about how to fix this.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
