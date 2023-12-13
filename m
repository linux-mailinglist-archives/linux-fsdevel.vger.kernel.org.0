Return-Path: <linux-fsdevel+bounces-5855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3E2811356
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 14:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B07E41C20F38
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 13:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8152DF87;
	Wed, 13 Dec 2023 13:48:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15F6DD;
	Wed, 13 Dec 2023 05:48:32 -0800 (PST)
Received: from [141.14.31.7] (theinternet.molgen.mpg.de [141.14.31.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: buczek)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1E48761E5FE0A;
	Wed, 13 Dec 2023 14:48:14 +0100 (CET)
Message-ID: <7ed8baa0-b895-43a2-bb13-93a92e18a823@molgen.mpg.de>
Date: Wed, 13 Dec 2023 14:48:13 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: file handle in statx
Content-Language: en-US
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Theodore Ts'o <tytso@mit.edu>, Dave Chinner <david@fromorbit.com>,
 NeilBrown <neilb@suse.de>, linux-bcachefs@vger.kernel.org,
 Stefan Krueger <stefan.krueger@aei.mpg.de>,
 David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
References: <20231208200247.we3zrwmnkwy5ibbz@moria.home.lan>
 <170233460764.12910.276163802059260666@noble.neil.brown.name>
 <20231211233231.oiazgkqs7yahruuw@moria.home.lan>
 <170233878712.12910.112528191448334241@noble.neil.brown.name>
 <20231212000515.4fesfyobdlzjlwra@moria.home.lan>
 <170234279139.12910.809452786055101337@noble.neil.brown.name>
 <ZXf1WCrw4TPc5y7d@dread.disaster.area>
 <e07d2063-1a0b-4527-afca-f6e6e2ecb821@molgen.mpg.de>
 <20231212152016.GB142380@mit.edu>
 <a0f820a7-3cf5-4826-a15b-e536abb5b1de@molgen.mpg.de>
 <20231213122820.umqmp3yvbbvizfym@moria.home.lan>
From: Donald Buczek <buczek@molgen.mpg.de>
In-Reply-To: <20231213122820.umqmp3yvbbvizfym@moria.home.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/13/23 13:28, Kent Overstreet wrote:
> On Wed, Dec 13, 2023 at 08:37:57AM +0100, Donald Buczek wrote:
>> Probably not for the specific applications I mentioned (backup, mirror,
>> accounting). These are intended to run continuously, slowly and unnoticed
>> in the background, so they are memory and i/o throttled via cgroups anyway
>> and one is even using sleep after so-and-so many stat calls to reduce
>> its impact.
>>
>> If they could tell a directory from a snapshot, I would probably stop them
>> from walking into snapshots. And if not, the snapshot id is all that is
>> needed to tell a clone in a snapshot from a hardlink. So these don't really
>> need the filehandle.
> 
> Perhaps we should allocate a bit for differentiating a snapshot from a
> non snapshot subvolume?
Are there non-snapshots subvolumes?

From  debugfs bcachefs/../btrees, I've got the impression, that every
volume starts with a (single) snapshot.

new fileystem:

subvolumes
==========
u64s 10 type subvolume 0:1:0 len 0 ver 0: root 4096 snapshot id 4294967295 parent 0

snapshots
=========
u64s 10 type snapshot 0:4294967295:0 len 0 ver 0: is_subvol 1 deleted 0 parent          0 children          0          0 subvol 1 tree 1 depth 0 skiplist 0 0 0

`bcachefs subvolume create /mnt/v`

subvolumes
==========
u64s 10 type subvolume 0:1:0 len 0 ver 0: root 4096 snapshot id 4294967295 parent 0
u64s 10 type subvolume 0:2:0 len 0 ver 0: root 1207959552 snapshot id 4294967294 parent 0

snapshots
=========
u64s 10 type snapshot 0:4294967294:0 len 0 ver 0: is_subvol 1 deleted 0 parent          0 children          0          0 subvol 2 tree 2 depth 0 skiplist 0 0 0
u64s 10 type snapshot 0:4294967295:0 len 0 ver 0: is_subvol 1 deleted 0 parent          0 children          0          0 subvol 1 tree 1 depth 0 skiplist 0 0 0

`bcachefs subvolume snapshot /mnt/v /mnt/s`

subvolumes
==========
u64s 10 type subvolume 0:1:0 len 0 ver 0: root 4096 snapshot id 4294967295 parent 0
u64s 10 type subvolume 0:2:0 len 0 ver 0: root 1207959552 snapshot id 4294967292 parent 0
u64s 10 type subvolume 0:3:0 len 0 ver 0: root 1207959552 snapshot id 4294967293 parent 2

snapshot
========
u64s 10 type snapshot 0:4294967292:0 len 0 ver 0: is_subvol 1 deleted 0 parent 4294967294 children          0          0 subvol 2 tree 2 depth 1 skiplist 4294967294 4294967294 4294967294
u64s 10 type snapshot 0:4294967293:0 len 0 ver 0: is_subvol 1 deleted 0 parent 4294967294 children          0          0 subvol 3 tree 2 depth 1 skiplist 4294967294 4294967294 4294967294
u64s 10 type snapshot 0:4294967294:0 len 0 ver 0: is_subvol 0 deleted 0 parent          0 children 4294967293 4294967292 subvol 0 tree 2 depth 0 skiplist 0 0 0
u64s 10 type snapshot 0:4294967295:0 len 0 ver 0: is_subvol 1 deleted 0 parent          0 children          0          0 subvol 1 tree 1 depth 0 skiplist 0 0 0

Now reading and interpreting the filehandles:

/mnt/.     type  177 : 00 10 00 00 00 00 00 00 01 00 00 00 00 00 00 00 : inode 0000000000001000 subvolume 00000001 generation 00000000
/mnt/v     type  177 : 00 00 00 48 00 00 00 00 02 00 00 00 00 00 00 00 : inode 0000000048000000 subvolume 00000002 generation 00000000
/mnt/s     type  177 : 00 00 00 48 00 00 00 00 03 00 00 00 00 00 00 00 : inode 0000000048000000 subvolume 00000003 generation 00000000


So is there really a type difference between the objects created by
`bcachefs subvolume create` and `bcachefs subvolume snapshot` ? It appears
that they both point to a volume which points to a snapshot in the snapshot
tree.

Best

  Donald


>> In the thread it was assumed, that there are other (unspecified)
>> applications which need the filehandle and currently use name_to_handle_at().
>>
>> I though it was self-evident that a single syscall to retrieve all
>> information atomically is better than a set of syscalls. Each additional
>> syscall has overhead and you need to be concerned with the data changing
>> between the calls.
> 
> All other things being equal, yeah it would be. But things are never
> equal :)
> 
> Expanding struct statx is not going to be as easy as hoped, so we need
> to be a bit careful how we use the remaining space, and since as Dave
> pointed out the filehandle isn't needed for checking uniqueness unless
> nlink > 1 it's not really a hotpath in any application I can think of.
> 
> (If anyone does know of an application where it might matter, now's the
> time to bring it up!)
> 
>> Userspace nfs server as an example of an application, where visible
>> performance is more relevant, was already mentioned by someone else.
> 
> I'd love to hear confirmation from someone more intimately familiar with
> NFS, but AFAIK it shouldn't matter there; the filehandle exists to
> support resuming IO or other operations to a file (because the server
> can go away and come back). If all the client did was a stat, there's no
> need for a filehandle - that's not needed until a file is opened.

-- 
Donald Buczek
buczek@molgen.mpg.de
Tel: +49 30 8413 1433


