Return-Path: <linux-fsdevel+bounces-6479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9693B818271
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 08:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 370DE1F23963
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 07:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF824C8C3;
	Tue, 19 Dec 2023 07:42:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EF48838;
	Tue, 19 Dec 2023 07:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.31.7] (theinternet.molgen.mpg.de [141.14.31.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: buczek)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id B16B361E5FE01;
	Tue, 19 Dec 2023 08:41:29 +0100 (CET)
Message-ID: <cf9ddb5f-357a-474d-9ca9-9e7ef0dd7bc3@molgen.mpg.de>
Date: Tue, 19 Dec 2023 08:41:29 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: file handle in statx
Content-Language: en-US
From: Donald Buczek <buczek@molgen.mpg.de>
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
 <7ed8baa0-b895-43a2-bb13-93a92e18a823@molgen.mpg.de>
In-Reply-To: <7ed8baa0-b895-43a2-bb13-93a92e18a823@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Dear Kent,

On 12/13/23 14:48, Donald Buczek wrote:
> On 12/13/23 13:28, Kent Overstreet wrote:
>> On Wed, Dec 13, 2023 at 08:37:57AM +0100, Donald Buczek wrote:
>>> Probably not for the specific applications I mentioned (backup, mirror,
>>> accounting). These are intended to run continuously, slowly and unnoticed
>>> in the background, so they are memory and i/o throttled via cgroups anyway
>>> and one is even using sleep after so-and-so many stat calls to reduce
>>> its impact.
>>>
>>> If they could tell a directory from a snapshot, I would probably stop them
>>> from walking into snapshots. And if not, the snapshot id is all that is
>>> needed to tell a clone in a snapshot from a hardlink. So these don't really
>>> need the filehandle.
>>
>> Perhaps we should allocate a bit for differentiating a snapshot from a
>> non snapshot subvolume?

> Are there non-snapshots subvolumes?
> 
> From  debugfs bcachefs/../btrees, I've got the impression, that every
> volume starts with a (single) snapshot.
> [...]
> So is there really a type difference between the objects created by
> `bcachefs subvolume create` and `bcachefs subvolume snapshot` ? It appears
> that they both point to a volume which points to a snapshot in the snapshot
> tree.


On a second thought: Even if my guesses were true, it would make sense to give
userspace the information. I'd probably code my backup code to walk into volumes
(or singleton snapshots) directories and copy the data just as it would do
with conventional directories. There is no risk of seeing the same file multiple
times. Only the hardlink logic should regard these volume borders and don't
treat entries in different volumes as hardlink candidates.

Only for subvolumes which potentially duplicate data we'd need
special coding to avoid copying the same data to the backup volume over
and over. Although we already might have a similar problem already with
reflink copies.

Best
  Donald


> 
> Best
> 
>   Donald
> 
> 
>>> In the thread it was assumed, that there are other (unspecified)
>>> applications which need the filehandle and currently use name_to_handle_at().
>>>
>>> I though it was self-evident that a single syscall to retrieve all
>>> information atomically is better than a set of syscalls. Each additional
>>> syscall has overhead and you need to be concerned with the data changing
>>> between the calls.
>>
>> All other things being equal, yeah it would be. But things are never
>> equal :)
>>
>> Expanding struct statx is not going to be as easy as hoped, so we need
>> to be a bit careful how we use the remaining space, and since as Dave
>> pointed out the filehandle isn't needed for checking uniqueness unless
>> nlink > 1 it's not really a hotpath in any application I can think of.
>>
>> (If anyone does know of an application where it might matter, now's the
>> time to bring it up!)
>>
>>> Userspace nfs server as an example of an application, where visible
>>> performance is more relevant, was already mentioned by someone else.
>>
>> I'd love to hear confirmation from someone more intimately familiar with
>> NFS, but AFAIK it shouldn't matter there; the filehandle exists to
>> support resuming IO or other operations to a file (because the server
>> can go away and come back). If all the client did was a stat, there's no
>> need for a filehandle - that's not needed until a file is opened.
> 

-- 
Donald Buczek
buczek@molgen.mpg.de
Tel: +49 30 8413 1433


