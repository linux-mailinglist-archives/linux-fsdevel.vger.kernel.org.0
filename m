Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8673DAFCA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 01:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbhG2XUu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jul 2021 19:20:50 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:40972 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbhG2XUu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jul 2021 19:20:50 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 2A9A5B0AA25; Thu, 29 Jul 2021 19:20:39 -0400 (EDT)
Date:   Thu, 29 Jul 2021 19:20:39 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     NeilBrown <neilb@suse.de>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Neal Gompa <ngompa13@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs@vger.kernel.org,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH/RFC 00/11] expose btrfs subvols in mount table correctly
Message-ID: <20210729232039.GF10106@hungrycats.org>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
 <20210728125819.6E52.409509F4@e16-tech.com>
 <20210728140431.D704.409509F4@e16-tech.com>
 <162745567084.21659.16797059962461187633@noble.neil.brown.name>
 <CAEg-Je8Pqbw0tTw6NWkAcD=+zGStOJR0J-409mXuZ1vmb6dZsA@mail.gmail.com>
 <20210728191431.GA3152@fieldses.org>
 <20210729012931.GK10170@hungrycats.org>
 <162752300106.21659.7482208502904653864@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162752300106.21659.7482208502904653864@noble.neil.brown.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 29, 2021 at 11:43:21AM +1000, NeilBrown wrote:
> On Thu, 29 Jul 2021, Zygo Blaxell wrote:
> > 
> > I'm looking at a few machines here, and if all the subvols are visible to
> > 'df', its output would be somewhere around 3-5 MB.  That's too much--we'd
> > have to hack up df to not show the same btrfs twice...as well as every
> > monitoring tool that reports free space...which sounds similar to the
> > problems we're trying to avoid.
> 
> Thanks for providing hard data!! How many of these subvols are actively
> used (have a file open) a the same time? Most? About half? Just a few??

Between 1% and 10% of the subvols have open fds at any time (not counting
bees, which holds an open fd on every subvol most of the time).  The ratio
is higher (more active) when the machine has less storage or more CPU/RAM:
we keep idle subvols around longer if we have lots of free space, or we
make more subvols active at the same time if we have lots of RAM and CPU.

I don't recall if stat() triggers automount, but most of the subvols are
located in a handful of directories.  Could a single 'ls -l' command
activate all of their automounts?  If so, then we'd be hitting those
at least once every 15 minutes--these directories are browseable, and
an entry point for users.  Certainly anything that looks inside those
directories (like certain file-browsing user agents that look for icons
one level down) will trigger automount as they search children of the
subvol root.

Some of this might be fixable, like I could probably make bees be
more parsimonious with subvol root fds, and I could probably rework
reporting scripts to avoid touching anything inside subdirectories,
and I could probably rework our subvolume directory layout to avoid
accidentally triggering thousands of automounts.  But I'd rather not.
I'd rather have working NFS and a 15-20 line df output with no new
privacy or scalability concerns.

> Thanks,
> NeilBrown
