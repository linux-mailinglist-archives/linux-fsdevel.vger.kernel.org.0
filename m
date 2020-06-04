Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA4241EE617
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jun 2020 15:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbgFDNzl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Jun 2020 09:55:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:57296 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728337AbgFDNzl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Jun 2020 09:55:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A9129ACCC;
        Thu,  4 Jun 2020 13:55:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B47ECDA818; Thu,  4 Jun 2020 15:55:35 +0200 (CEST)
Date:   Thu, 4 Jun 2020 15:55:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Filipe Manana <fdmanana@gmail.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] iomap: Return zero in case of unsuccessful pagecache
 invalidation before DIO
Message-ID: <20200604135535.GD27034@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Filipe Manana <fdmanana@gmail.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christoph Hellwig <hch@infradead.org>
References: <20200528192103.xm45qoxqmkw7i5yl@fiona>
 <20200529002319.GQ252930@magnolia>
 <20200601151614.pxy7in4jrvuuy7nx@fiona>
 <CAL3q7H60xa0qW4XdneDdeQyNcJZx7DxtwDiYkuWB5NoUVPYdwQ@mail.gmail.com>
 <CAL3q7H4=N2pfnBSiJ+TApy9kwvcPE5sB92sxcVZN10bxZqQpaA@mail.gmail.com>
 <20200603190252.GG8204@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603190252.GG8204@magnolia>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 03, 2020 at 12:02:52PM -0700, Darrick J. Wong wrote:
> > > So the next fsync on the file will return that error, despite the
> > > fsync having completed successfully with any errors.
> > >
> > > Since patchset to make btrfs direct IO use iomap is already in Linus'
> > > tree, we need to fix this somehow.
> 
> Y'all /just/ sent the pull request containing that conversion 2 days
> ago.  Why did you move forward with that when you knew there were
> unresolved fstests failures?

Because we didn't know that. And the whole mixed buffered io and dio is
considered obscure, documented as 'do not do that', that tests that
report the warning are more of an annyonance (btrfs/004).

That the test generic/547 sometimes returns EIO on fsync is a
regression, reported after the pull request had been merged, but with a
proposed fix that is not that intrusive, so this all counts as a normal
development.

There is always some risk merging code the like dio-iomap and it was
known but with an ultimate fallback plan to revert it in case we
encounter problems that are not solvable before release. But we're not
there yet.

> > > This makes generic/547 fail often for example - buffered write against
> > > file + direct IO write + fsync - the later returns -EIO.
> > 
> > Just to make it clear, despite the -EIO error, there was actually no
> > data loss or corruption (generic/547 checks that),
> > since the direct IO write path in btrfs figures out there's a buffered
> > write still ongoing and waits for it to complete before proceeding
> > with the dio write.
> > 
> > Nevertheless, it's still a regression, -EIO shouldn't be returned as
> > everything went fine.
> 
> Now I'm annoyed because I feel like you're trying to strong-arm me into
> making last minute changes to iomap when you could have held off for
> another cycle.

The patchset was held off for several releases, gradually making into
state where it can be merged, assuming we will be able to fix potential
regressions. Besides SUSE people involved in the patchset, Christoph
asked why it's not merged and how can he help to move it forward. He's
listed as iomap maintainer so it's not like we were pushing code without
maintainers' involved.

Regarding the last minute change, that's not something we'd ask you to
do without testing first. There are 4 filesystems using iomap for
direct io, making sure it does not regress on them is something I'd
consider necessary before asking you to merge it.

This patchset is lacking that but it started a discussion to understand
the full extent of the bug. We're not in rc5 where calling it 'last
minute' would be appropriate.

The big-hammer option to revert 4 patches is still there. If the fix
turns out to require changes beyond iomap and btrfs code, I'd consider
that as a good reason and I'm ready to do the revert (say rc2 at the
latest).
