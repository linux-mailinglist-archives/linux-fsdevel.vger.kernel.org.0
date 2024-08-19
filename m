Return-Path: <linux-fsdevel+bounces-26323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D50C957793
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 00:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25382285DCF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 22:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E021DD3B0;
	Mon, 19 Aug 2024 22:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="uTzpq9U0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jPRlare2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2501DD394
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Aug 2024 22:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724107010; cv=none; b=JekXMgqbfFDbK8wT5fydqTvqrBdhQrCyWU/SR7rIktAC/sn88RaKHm12YWvtx2ABQtNWvsw2MN/DO2PLmorojvnf0VVLzR7KhEcB5euc/nRz0VmSMIaLOQhm8s+Xt6UMNpcqi0Q8fcbsKO3A1cy7OeCo5O7oIYZXDPJzo644Ah0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724107010; c=relaxed/simple;
	bh=QdhFYQXidTpXUATGlxh9uljbb2EsBdhPb5Yq2ETXspg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k2TucpWWHN1TCGBvaZ7ALKyi6SK1raBSXoSVd65dW9d+8B8iFSGtI/3e9FhqLMOsScEfx3BX/q8TatHRkuWf8V1xhy1/3rsQRFI1JbNu/3hrfE729oCN5NOeR0zQBInoSBDDHAh9pyiyFwpthLdNkePT1GiSuGGptAznDlA7ENU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=uTzpq9U0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jPRlare2; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2A8FE138EBAE;
	Mon, 19 Aug 2024 18:36:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 19 Aug 2024 18:36:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1724107007;
	 x=1724193407; bh=zBsedjLPrjSCCJpRg2DcZ8AUqiYJTAJ28CzEvAyqevY=; b=
	uTzpq9U0g86MIIuGA6tLkYbsiBGgKlN1h+6rfrnQJfd/VUIfUrYmMM3kbSmp9abH
	FYApW/IJ8ntvcwgMRC4+I/HR1i95l+QQ05AwSuju317cjxBzjrrgUoi8YXNlaSRP
	Sezjd+o56wjqbhVOTsCaKBHxumcgp6yvnjrGclsen7jYnQytaTpUqS53aHqmFDR+
	krirskfDYE26haT0Mq/fvyPzsrbgb1gcEfk6C7ltRKuNVV16FV80Wewh2XEijG3X
	0jdkegbVPE76UrKiF9tNnIg/skxDqm+aQ/CwfNeqmMNpzTKOrg/2mbirceDup1MO
	ve+WqhBGZNH3JvV/ZZ+yQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724107007; x=
	1724193407; bh=zBsedjLPrjSCCJpRg2DcZ8AUqiYJTAJ28CzEvAyqevY=; b=j
	PRlare2yWOlN0sTZgzcXvkh6+U3FoydRonCuoajgll0ehzuvlLyNOhnzaoLQT440
	BE/z9epOmrGd/vLV5m4ZIxEz85Hrx/4YxQa714998NNmtyVrRjTWmPICMJWeJilf
	icfGcBdChCASskoy772DXvhJAulKy+t0dIO350/MSe2mrc15hYy4cJ3puqRmTXjY
	7i9exqdHUkY9JZruFGTj9P4jACPLCogKBRN12djsqLcdZdZRXkYIbg8HfTjqQ1j/
	dS0RxCISnZh38j5+Hu/tdKkT1GRNxayeiCspAj/H9/axBA7AKwA1T3jrBIUtYEOY
	kwIyPCjUlKACBIJfdfQDA==
X-ME-Sender: <xms:_sjDZhn9n1RT-_ezwV91WAwD1KK9gaWqBdd1KWAsBrb9jWDH192ksg>
    <xme:_sjDZs1VhQ4g0sz8ye_ditFrPxILQRyzai2IBPj5EYUYf15MT7V-mn95WYGWJaA_r
    oKr4UPECGRBIGil>
X-ME-Received: <xmr:_sjDZnoOONDzt4mSbenqRFwloF3Fz5jdC4CjhNKDnEz86eChkyLDeP3Tt47ooXdduEsuX5wIhhBZ5PXluDQvWuDqdPM8gEcWmPDKbZWndXEi4sdBuGM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduhedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdej
    necuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvg
    hrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepuedtkeeileeghedu
    kefghfdtuddvudfgheeljeejgeelueffueekheefheffveelnecuffhomhgrihhnpehgih
    hthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmhdpnhgspg
    hrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhorghnnhgv
    lhhkohhonhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhikhhlohhssehsiigvrh
    gvughirdhhuhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepjhhoshgvfhesthhogihitghprghnuggrrdgtoh
    hmpdhrtghpthhtohepohhsrghnughovhesohhsrghnughovhdrtghomhdprhgtphhtthho
    pehsfigvvghtthgvrgdqkhgvrhhnvghlseguohhrmhhinhihrdhmvgdprhgtphhtthhope
    hkvghrnhgvlhdqthgvrghmsehmvghtrgdrtghomhdprhgtphhtthhopegushhinhhghhes
    uggunhdrtghomh
X-ME-Proxy: <xmx:_sjDZhkyO26fVgfdLVl_Wuz0UYpZ6WC9Il7PBTacPafJPrs5P98Law>
    <xmx:_sjDZv2Ohjf7mewIKcvuTVKDlYxpnA8q1zc4OZhir4jwFUIlVpySEA>
    <xmx:_sjDZgvM5EBsSJ5Jf7urrJYRL2uXvKE3-XZVvF6e5eahfgkH20OOkQ>
    <xmx:_sjDZjVUfkdK4FcUfBLa2PnLaiyti1mSPlPFTI0e9NH_UQKy4WT1uw>
    <xmx:_8jDZoKJT9VofW-S6a_bZxwCNQfzkVatV4L9mqZ2VMh1TyVhsvysZigG>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Aug 2024 18:36:44 -0400 (EDT)
Message-ID: <e36998aa-3bb6-4d57-b29f-6bcdc586357b@fastmail.fm>
Date: Tue, 20 Aug 2024 00:36:43 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: add FOPEN_FETCH_ATTR flag for fetching attributes
 after open
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com,
 osandov@osandov.com, sweettea-kernel@dorminy.me, kernel-team@meta.com,
 Dharmendra Singh <dsingh@ddn.com>
References: <20240813212149.1909627-1-joannelkoong@gmail.com>
 <4c37917a-9a64-4ea0-9437-d537158a8f40@fastmail.fm>
 <CAJnrk1aC-qUTb1e-n7O-wqrbUKMcq18tyE7LAxattdGU22NaPA@mail.gmail.com>
 <C23FB164-EB7A-436F-8C3F-533B00F67730@fastmail.fm>
 <CAJnrk1ZZ2eEcwYeXHmJxxMywQ8=iDkffvcJK8W8exA02vjrvUg@mail.gmail.com>
 <9941c561-b358-4058-8797-3e8081b019dc@fastmail.fm>
 <CAJnrk1a3EFerySC+eEkfLdeo9fe8bqccOqcFK_S547aoLVWUEw@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJnrk1a3EFerySC+eEkfLdeo9fe8bqccOqcFK_S547aoLVWUEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/14/24 20:06, Joanne Koong wrote:
> On Wed, Aug 14, 2024 at 10:52 AM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
>>
>>
>>
>> On 8/14/24 19:18, Joanne Koong wrote:
>>> On Tue, Aug 13, 2024 at 3:41 PM Bernd Schubert
>>> <bernd.schubert@fastmail.fm> wrote:
>>>>
>>>> On August 13, 2024 11:57:44 PM GMT+02:00, Joanne Koong <joannelkoong@gmail.com> wrote:
>>>>> On Tue, Aug 13, 2024 at 2:44 PM Bernd Schubert
>>>>> <bernd.schubert@fastmail.fm> wrote:
>>>>>>
>>>>>> On 8/13/24 23:21, Joanne Koong wrote:
>>>>>>> Add FOPEN_FETCH_ATTR flag to indicate that attributes should be
>>>>>>> fetched from the server after an open.
>>>>>>>
>>>>>>> For fuse servers that are backed by network filesystems, this is
>>>>>>> needed to ensure that file attributes are up to date between
>>>>>>> consecutive open calls.
>>>>>>>
>>>>>>> For example, if there is a file that is opened on two fuse mounts,
>>>>>>> in the following scenario:
>>>>>>>
>>>>>>> on mount A, open file.txt w/ O_APPEND, write "hi", close file
>>>>>>> on mount B, open file.txt w/ O_APPEND, write "world", close file
>>>>>>> on mount A, open file.txt w/ O_APPEND, write "123", close file
>>>>>>>
>>>>>>> when the file is reopened on mount A, the file inode contains the old
>>>>>>> size and the last append will overwrite the data that was written when
>>>>>>> the file was opened/written on mount B.
>>>>>>>
>>>>>>> (This corruption can be reproduced on the example libfuse passthrough_hp
>>>>>>> server with writeback caching disabled and nopassthrough)
>>>>>>>
>>>>>>> Having this flag as an option enables parity with NFS's close-to-open
>>>>>>> consistency.
>>>>>>>
>>>>>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>>>>>> ---
>>>>>>>  fs/fuse/file.c            | 7 ++++++-
>>>>>>>  include/uapi/linux/fuse.h | 7 ++++++-
>>>>>>>  2 files changed, 12 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>>>>>>> index f39456c65ed7..437487ce413d 100644
>>>>>>> --- a/fs/fuse/file.c
>>>>>>> +++ b/fs/fuse/file.c
>>>>>>> @@ -264,7 +264,12 @@ static int fuse_open(struct inode *inode, struct file *file)
>>>>>>>       err = fuse_do_open(fm, get_node_id(inode), file, false);
>>>>>>>       if (!err) {
>>>>>>>               ff = file->private_data;
>>>>>>> -             err = fuse_finish_open(inode, file);
>>>>>>> +             if (ff->open_flags & FOPEN_FETCH_ATTR) {
>>>>>>> +                     fuse_invalidate_attr(inode);
>>>>>>> +                     err = fuse_update_attributes(inode, file, STATX_BASIC_STATS);
>>>>>>> +             }
>>>>>>> +             if (!err)
>>>>>>> +                     err = fuse_finish_open(inode, file);
>>>>>>>               if (err)
>>>>>>>                       fuse_sync_release(fi, ff, file->f_flags);
>>>>>>>               else if (is_truncate)
>>>>>>
>>>>>> I didn't come to it yet, but I actually wanted to update Dharmendras/my
>>>>>> atomic open patches - giving up all the vfs changes (for now) and then
>>>>>> always use atomic open if available, for FUSE_OPEN and FUSE_CREATE. And
>>>>>> then update attributes through that.
>>>>>> Would that be an alternative for you? Would basically require to add an
>>>>>> atomic_open method into your file system.
>>>>>>
>>>>>> Definitely more complex than your solution, but avoids a another
>>>>>> kernel/userspace transition.
>>>>>
>>>>> Hi Bernd,
>>>>>
>>>>> Unfortunately I don't think this is an alternative for my use case. I
>>>>> haven't looked closely at the implementation details of your atomic
>>>>> open patchset yet but if I'm understanding the gist of it correctly,
>>>>> it bundles the lookup with the open into 1 request, where the
>>>>> attributes can be passed from server -> kernel through the reply to
>>>>> that request. I think in the case I'm working on, the file open call
>>>>> does not require a lookup so it can't take advantage of your feature.
>>>>> I just tested it on libfuse on the passthrough_hp server (with no
>>>>> writeback caching and nopassthrough) on the example in the commit
>>>>> message and I'm not seeing any lookup request being sent for that last
>>>>> open call (for writing "123").
>>>>>
>>>>
>>>>
>>>> Hi Joanne,
>>>>
>>>> gets late here and I'm typing on my phone.  I hope formatting is ok.
>>>>
>>>> what I meant is that we use the atomic open op code for both, lookup-open and plain open - i.e. we always update attributes on open. Past atomic open patches did not do that yet, but I later realized that always using atomic open op
>>>>
>>>> - avoids the data corruption you run into
>>>> - probably no need for atomic-revalidate-open vfs patches anymore  as we can now safely set a high attr timeout
>>>>
>>>>
>>>> Kind of the same as your patch, just through a new op code.
>>>
>>> Awesome, thanks for the context Bernd. I think this works for our use
>>> case then. To confirm the "we will always update attributes on open"
>>> part, this will only send the FUSE_GETATTR request to the server if
>>> the server has invalidated the inode (eg through the
>>> fuse_lowlevel_notify_inval_inode() api), otherwise this will not send
>>> an extra FUSE_GETATTR request, correct? Other than the attribute
>>
>> If we send FUSE_OPEN_ATOMIC (or whatever we name it) in
>> fuse_file_open(), it would always ask server side for attributes.
> 
> Oh I see, the FUSE_OPEN_ATOMIC request itself would ask for attributes
> and the attributes would be sent by the server as the reply to the
> FUSE_ATOMIC_OPEN. This sounds great! in my patch, there's an
> additional FUSE_GETATTR request incurred to get the attributes.
> 
>> I.e. we assume that a server that has atomic open implemented can easily
>> provide attributes or asks for close-to-open coherency.
>>
>>
>> I'm not sure if I correctly understood your questions about
>> notifications and FUSE_GETATTR - from my point of view that that is
>> entirely independent from open. And personally I try to reduce
> 
> I missed that the attributes would be bundled with FUSE_OPEN_ATOMIC so
> I thought we would need an additional FUSE_GETATTR request to get
> them. Apologies for the confusion!
> 
>> kernel/userspace transitions - additional notifications and FUSE_GETATTR
>> are not helpful here :)
>>
>>> updating, would there be any other differences from using plain open
>>> vs the atomic open version of plain open?
>>
>> Just the additional file attributes and complexity that brings.
>>
>>>
>>> Do you have a tentative timeline in mind for when the next iteration
>>> of the atomic open patchset would be out?
>>
>> I wanted to have new fuse-uring patches ready by last week, but I'm
>> still refactoring things - changing things on top of the existing series
>> is easy, rebasing it is painful...  I can _try_ to make a raw new
>> atomic-open patch set during the next days (till Sunday), but not promised.
>>
> 
> Sounds great. thanks for your work on this!

Here is a totally untested (and probably ugly) version of what I had in my 
mind 

https://github.com/bsbernd/linux/commits/open-getattr/
https://github.com/libfuse/libfuse/pull/1020

(It builds, but nothing more tested).

Instead of rather complex atomic-open it adds FUSE_OPEN_GETATTR and hooks into
fuse_file_open. 
I was considering to hook into fuse_do_open, but that would cause quite some code
dup for fuse_file_open. We need the inode to update attributes and in fuse_do_open
we could use file->f_inode, but I didn't verify if it is reliable at this stage
(do_dentry_open() assignes it, but I didn't verify possible other code paths) - for
now I added the inode parameter to all code paths.


Going to test and clean it up tomorrow.


Thanks,
Bernd

