Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA3061409B5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 13:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgAQM1s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 07:27:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:49826 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726812AbgAQM1r (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 07:27:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 643E7C0F0;
        Fri, 17 Jan 2020 12:27:45 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 056E61E0D53; Fri, 17 Jan 2020 13:27:42 +0100 (CET)
Date:   Fri, 17 Jan 2020 13:27:42 +0100
From:   Jan Kara <jack@suse.cz>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        "Steven J. Magnani" <steve.magnani@digidescorp.com>
Subject: Re: udf: Commit b085fbe2ef7fa (udf: Fix crash during mount) broke
 CD-RW support
Message-ID: <20200117122741.GK17141@quack2.suse.cz>
References: <20200112144735.hj2emsoy4uwsouxz@pali>
 <20200113114838.GD23642@quack2.suse.cz>
 <20200116154643.wtxtki7bbn5fnmfc@pali>
 <20200117112254.GF17141@quack2.suse.cz>
 <20200117113147.hs4hylolxzej4urh@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200117113147.hs4hylolxzej4urh@pali>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 17-01-20 12:31:47, Pali Rohár wrote:
> On Friday 17 January 2020 12:22:54 Jan Kara wrote:
> > On Thu 16-01-20 16:46:43, Pali Rohár wrote:
> > > On Monday 13 January 2020 12:48:38 Jan Kara wrote:
> > > > Hello,
> > > > 
> > > > On Sun 12-01-20 15:47:35, Pali Rohár wrote:
> > > > > Commit b085fbe2ef7fa (udf: Fix crash during mount) introduced check that
> > > > > UDF disk with PD_ACCESS_TYPE_REWRITABLE access type would not be able to
> > > > > mount in R/W mode. This commit was added in Linux 4.20.
> > > > > 
> > > > > But most tools which generate UDF filesystem for CD-RW set access type
> > > > > to rewritable, so above change basically disallow usage of CD-RW discs
> > > > > formatted to UDF in R/W mode.
> > > > > 
> > > > > Linux's cdrwtool and mkudffs (in all released versions), Windows Nero 6,
> > > > > NetBSD's newfs_udf -- all these tools uses rewritable access type for
> > > > > CD-RW media.
> > > > > 
> > > > > In UDF 1.50, 2.00 and 2.01 specification there is no information which
> > > > > UDF access type should be used for CD-RW medias.
> > > > > 
> > > > > In UDF 2.60, section 2.2.14.2 is written:
> > > > > 
> > > > >     A partition with Access Type 3 (rewritable) shall define a Freed
> > > > >     Space Bitmap or a Freed Space Table, see 2.3.3. All other partitions
> > > > >     shall not define a Freed Space Bitmap or a Freed Space Table.
> > > > > 
> > > > >     Rewritable partitions are used on media that require some form of
> > > > >     preprocessing before re-writing data (for example legacy MO). Such
> > > > >     partitions shall use Access Type 3.
> > > > > 
> > > > >     Overwritable partitions are used on media that do not require
> > > > >     preprocessing before overwriting data (for example: CD-RW, DVD-RW,
> > > > >     DVD+RW, DVD-RAM, BD-RE, HD DVD-Rewritable). Such partitions shall
> > > > >     use Access Type 4.
> > > > > 
> > > > > And in 6.14.1 (Properties of CD-MRW and DVD+MRW media and drives) is:
> > > > > 
> > > > >     The Media Type is Overwritable (partition Access Type 4,
> > > > >     overwritable)
> > > > > 
> > > > > Similar info is in UDF 2.50.
> > > > 
> > > > Thanks for detailed info. Yes, UDF 2.60 spec is why I've added the check
> > > > you mentioned. I was not aware that the phrasing was not there in earlier
> > > > versions and frankly even the UDF 2.60 spec is already 15 years old... But
> > > > the fact that there are tools creating non-compliant disks certainly
> > > > changes the picture :)
> > > 
> > > I tested also Nero Linux 4 (Nero provides free trial version which is
> > > fully working even in 2020) and it creates 1.50 CD-RW discs in the same
> > > way with Rewritable partition. Interestingly for 2.50 and 2.60 it does
> > > not use Overwritable, but Writeonce (yes, for CD-RW with Spartable).
> > > 
> > > And because previous UDF specification do not say anything about it, I
> > > would not sat that those discs are non-compliant.
> > > 
> > > Moreover, is there any tool (for Linux or other system) which uses
> > > Overwritable partition type for CD-RW discs? All which I tested uses
> > > Rewritable.
> > 
> > No. But CD-RW means that the media needs "erasing" before overwriting so
> > using 'Rewritable' partitions there is fine and in the kernel we do want to
> > force such mounts read-only because we don't support "erasing", do we?
> 
> I guess that this formulation as you wrote is the reason why all
> formatting tools decided to use Overwritable type for CD-RW.
> 
> But it is not completely truth. You need erase CD-RW before formatting,
> not before rewriting blocks on it. And kernel already supports rewriting
> one random block on CD-RW media via pktcdvd.ko layer (part of mainline
> kernel).
> 
> So to mount CD-RW media with UDF fs on it in R/W mode, you need:
> 
> 1) erase & format CD-RW media (e.g. via cdrwtool)
> 2) setup pktcdvd layer for CD-RW media (e.g. via pktsetup or via /sys)
> 3) mount pktcdvd block device with udf fs
> 
> So, kernel supports UDF on CD-RW media also in R/W mode, just it is not
> straightforward as for other hard disk block devices.

Ah, OK, thanks for clarification.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
