Return-Path: <linux-fsdevel+bounces-5594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E55D280DF8B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 00:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66281B215AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 23:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A1B5676C;
	Mon, 11 Dec 2023 23:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n+7ae+m9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [IPv6:2001:41d0:203:375::b0])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C0ECB
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Dec 2023 15:32:36 -0800 (PST)
Date: Mon, 11 Dec 2023 18:32:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702337554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wxovv5SVt/JRYz/4ndFTxe3W8eaNQpCfYkKewjXWTHY=;
	b=n+7ae+m9mvLKsYh+IktU5paZ1ry5vyX8VbtkzCp1dgA3ATkKnu96wdB7VbFNupxzH5gXif
	In5mUWHVHYnD/jAjXKUe8WyNYOG1K5mpCu6q4yik0XJZmvy8WMeFA1rv2so9mL407kXQPx
	T12zad43G0t/JvJUVMJjuAkiU6Vn34k=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: NeilBrown <neilb@suse.de>
Cc: Donald Buczek <buczek@molgen.mpg.de>, linux-bcachefs@vger.kernel.org,
	Stefan Krueger <stefan.krueger@aei.mpg.de>,
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: file handle in statx (was: Re: How to cope with subvolumes and
 snapshots on muti-user systems?)
Message-ID: <20231211233231.oiazgkqs7yahruuw@moria.home.lan>
References: <12f711f9-70a2-408e-8588-2839e599b668@molgen.mpg.de>
 <170181366042.7109.5045075782421670339@noble.neil.brown.name>
 <97375d00-4bf7-4c4f-96ec-47f4078abb3d@molgen.mpg.de>
 <170199821328.12910.289120389882559143@noble.neil.brown.name>
 <20231208013739.frhvlisxut6hexnd@moria.home.lan>
 <170200162890.12910.9667703050904306180@noble.neil.brown.name>
 <20231208024919.yjmyasgc76gxjnda@moria.home.lan>
 <630fcb48-1e1e-43df-8b27-a396a06c9f37@molgen.mpg.de>
 <20231208200247.we3zrwmnkwy5ibbz@moria.home.lan>
 <170233460764.12910.276163802059260666@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170233460764.12910.276163802059260666@noble.neil.brown.name>
X-Migadu-Flow: FLOW_OUT

On Tue, Dec 12, 2023 at 09:43:27AM +1100, NeilBrown wrote:
> On Sat, 09 Dec 2023, Kent Overstreet wrote:
> > On Fri, Dec 08, 2023 at 12:34:28PM +0100, Donald Buczek wrote:
> > > On 12/8/23 03:49, Kent Overstreet wrote:
> > > 
> > > > We really only need 6 or 7 bits out of the inode number for sharding;
> > > > then 20-32 bits (nobody's going to have a billion snapshots; a million
> > > > is a more reasonable upper bound) for the subvolume ID leaves 30 to 40
> > > > bits for actually allocating inodes out of.
> > > > 
> > > > That'll be enough for the vast, vast majority of users, but exceeding
> > > > that limit is already something we're technically capable of: we're
> > > > currently seeing filesystems well over 100 TB, petabyte range expected
> > > > as fsck gets more optimized and online fsck comes.
> > > 
> > > 30 bits would not be enough even today:
> > > 
> > > buczek@done:~$ df -i /amd/done/C/C8024
> > > Filesystem         Inodes     IUsed      IFree IUse% Mounted on
> > > /dev/md0       2187890304 618857441 1569032863   29% /amd/done/C/C8024
> > > 
> > > So that's 32 bit on a random production system ( 618857441 == 0x24e303e1 ).
> 
> only 30 bits though.  So it is a long way before you use all 32 bits.
> How many volumes do you have?
> 
> > > 
> > > And if the idea to produce unique inode numbers by hashing the filehandle into 64 is followed, collisions definitely need to be addressed. With 618857441 objects, the probability of a hash collision with 64 bit is already over 1% [1].
> > 
> > Oof, thanks for the data point. Yeah, 64 bits is clearly not enough for
> > a unique identifier; time to start looking at how to extend statx.
> > 
> 
> 64 should be plenty...
> 
> If you have 32 bits for free allocation, and 7 bits for sharding across
> 128 CPUs, then you can allocate many more than 4 billion inodes.  Maybe
> not the full 500 billion for 39 bits, but if you actually spread the
> load over all the shards, then certainly tens of billions.
> 
> If you use 22 bits for volume number and 42 bits for inodes in a volume,
> then you can spend 7 on sharding and still have room for 55 of Donald's
> filesystems to be allocated by each CPU.
> 
> And if Donald only needs thousands of volumes, not millions, then he
> could configure for a whole lot more headroom.
> 
> In fact, if you use the 64 bits of vfs_inode number by filling in bits from
> the fs-inode number from one end, and bits from the volume number from
> the other end, then you don't need to pre-configure how the 64 bits are
> shared.
> You record inum-bits and volnum bits in the filesystem metadata, and
> increase either as needed.  Once the sum hits 64, you start returning
> ENOSPC for new files or new volumes.
> 
> There will come a day when 64 bits is not enough for inodes in a single
> filesystem.  Today is not that day.

Except filesystems are growing all the time: that leaves almost no room
for growth and then we're back in the world where users had to guess how
many inodes they were going to need in their filesystem; and if we put
this off now we're just kicking the can down the road until when it
becomes really pressing and urgent to solve.

No, we need to come up with something better.

I was chatting a bit with David Howells on IRC about this, and floated
adding the file handle to statx. It looks like there's enough space
reserved to make this feasible - probably going with a fixed maximum
size of 128-256 bits.

Thoughts?

