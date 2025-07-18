Return-Path: <linux-fsdevel+bounces-55462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB7EB0AA41
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 20:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 598C816A7AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 18:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C092E7F25;
	Fri, 18 Jul 2025 18:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="RkRalH5P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UnNILgq/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CA72E6D00
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 18:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752863963; cv=none; b=Bp4UHlwSr0/sGahLz32MIvsL4TJf547NNuStRbr0SCeEdoqJJ54LnuN19NXeuTPcR7s2lfKZlNzIczyXwFuHUrwCU+F1ARW6TPZA7Z9xSi+P/eRl0qyv5vwljt/qmRizz/LRG2LcqZjYtGkEvcFCc/yivCIHt6ZS24zULYmVnh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752863963; c=relaxed/simple;
	bh=Z1epH5MAaRgCiurOzsXgBrs3RqHG7qGPQ0vqo1vVf7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BmUnktyfyeJHtAHf4a484/Gjb0TcP/4w7KPqOytUzit6+o/OQPCR6HgfpGeHwDIYzEy7jvQJBAF2MC1KibDdWp7IqxOUllbxKh9ugI6aq591tZ4rLAXs4OkfKokZZx4wnzLAU+jp82XfcPZ+jcbnY4BMD3nR1OPSwxjInGj+0rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=RkRalH5P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UnNILgq/; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 2EFA3EC017D;
	Fri, 18 Jul 2025 14:39:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 18 Jul 2025 14:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752863961;
	 x=1752950361; bh=5Of5gvRwcQdescj/btbDg6BC680UVFvE03yRAT5qIQc=; b=
	RkRalH5PSJttczIvPXDR3Bm6G5rKyEmEx0IvEj2aIEr1jJmQcMMFAN3dBujvRABr
	IqL7QX6mqYYJ1Uff3MEy+s10nT9fxphY6yqOFOnqtOsZ7E/Mt0+1PRcyCTYrpYWK
	LY06aRv8ZkIiwqb17GTem/UPJpciczGOe6xI4uwPpeWk3je0hu6rOZ3hRR0a7HnG
	4hcO2+5vVXiPSqtr1DxVjrzlNGQpEsEVNAQ1zBNkXJHrqXd2mRMgyvcY7jPa9UwV
	K0Fs9OWHebg0A+JKBJ/HaaFeL3PM992Y53lO+0FVKngy3kKRPXN8zYONF4TAS54R
	MpfpqHHkxjEdE9zCiq6Jpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752863961; x=
	1752950361; bh=5Of5gvRwcQdescj/btbDg6BC680UVFvE03yRAT5qIQc=; b=U
	nNILgq/b+jdmoX7WHXdqZ7zwsJJPDxuzwWTq2ZWVEinoptZMqAUBW+N9z50gbCig
	nchPK0E+1s+DOIgXSb5M190IHCNLUyCNeMbaCSaCgNa9L7pz4kJgmQxa5H7Ey9S0
	4OuxaQ5TsUrrIQxd8CBVi22M+WSZTuJrFCYuMSnN63HMWRJuFQ2zo5FS7rhDwGE0
	A2fRVpp2IxKq10/+ZzLDe07TmvNB4S+fSvqU6BbHkI+KVwHVFRhXCdpvujWFmaMy
	iTHBuqIjWwwH3b0W9s3kG/adZc74G17ZoQ9sRE+JZmx5eHA+1SGN/CMEyas3UuPj
	CDhCPt35RGGQhS01kr7Gg==
X-ME-Sender: <xms:2JR6aGeiu0K4fAlWxgBJ7a3tSgCixHYV_KXaYBOESziq9H7zhHisUg>
    <xme:2JR6aNyLBPJlPqu1qIQbrCmF9kj7aMV-Ij7HkHDUpHHeSBTaghStYWycAb99ss4eB
    F1t7pDm4nVQ-ZWh>
X-ME-Received: <xmr:2JR6aN-iFmcSyagN1yHHJFrV723Odupu9QqkMUJzeoap-_Oj6ag72_wEbUVFYe99kYIhtVCJbBFSjKXrgh9w3sKrBZW0ZMrR2JlenMHPMP_vmpXrLz_z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeigedvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnhepfeeggeefffekudduleefheelleehgfffhedujedvgfetvedvtdefieehfeel
    gfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    gvrhhnugessghssggvrhhnugdrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepughjfihonhhgsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopegrmhhirhejfehilhesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhig
    qdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvrg
    hlsehgohhmphgrrdguvghvpdhrtghpthhtohepjhhohhhnsehgrhhovhgvshdrnhgvthdp
    rhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohepjhhorg
    hnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:2JR6aFiHQAojsEHjYAnrdaDM_I9VQuKzhiW7hEewkZYfWkYj9xoPlw>
    <xmx:2JR6aEEQgL6gx36hLDimVVIPQE26bre0a1Ruw9Pyrednyy6S2kcBiw>
    <xmx:2JR6aE-t5_gIl73M8_cGyyMBi-N8LzofkMmZiNWs6rJ85xx72vl-Og>
    <xmx:2JR6aLy_lvU2KDSiOtwMNnCSZxXTCbgMx8T3li80rh4gGwTN3LfnTw>
    <xmx:2ZR6aPGYKhVotj_OOy6wqWBAsF1V3tlJPdppxhyMTyMtuxEm_pT6eOud>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Jul 2025 14:39:19 -0400 (EDT)
Message-ID: <9ffc3eb8-c0ef-42ae-9d66-2a2b5d0e9197@bsbernd.com>
Date: Fri, 18 Jul 2025 20:39:18 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] fuse: implement buffered IO with iomap
To: "Darrick J. Wong" <djwong@kernel.org>, Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net,
 miklos@szeredi.hu, joannelkoong@gmail.com
References: <175279449855.711291.17231562727952977187.stgit@frogsfrogsfrogs>
 <175279450066.711291.11325657475144563199.stgit@frogsfrogsfrogs>
 <CAOQ4uxjfTp0My7xv39BA1_nD95XLQd-TqERAMG-C4V3UFYpX8w@mail.gmail.com>
 <20250718180121.GV2672029@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20250718180121.GV2672029@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/18/25 20:01, Darrick J. Wong wrote:
> On Fri, Jul 18, 2025 at 05:10:14PM +0200, Amir Goldstein wrote:
>> On Fri, Jul 18, 2025 at 1:32 AM Darrick J. Wong <djwong@kernel.org> wrote:
>>>
>>> From: Darrick J. Wong <djwong@kernel.org>
>>>
>>> Implement pagecache IO with iomap, complete with hooks into truncate and
>>> fallocate so that the fuse server needn't implement disk block zeroing
>>> of post-EOF and unaligned punch/zero regions.
>>>
>>> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
>>> ---
>>>  fs/fuse/fuse_i.h          |   46 +++
>>>  fs/fuse/fuse_trace.h      |  391 ++++++++++++++++++++++++
>>>  include/uapi/linux/fuse.h |    5
>>>  fs/fuse/dir.c             |   23 +
>>>  fs/fuse/file.c            |   90 +++++-
>>>  fs/fuse/file_iomap.c      |  723 +++++++++++++++++++++++++++++++++++++++++++++
>>>  fs/fuse/inode.c           |   14 +
>>>  7 files changed, 1268 insertions(+), 24 deletions(-)
>>>
>>>
>>> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
>>> index 67e428da4391aa..f33b348d296d5e 100644
>>> --- a/fs/fuse/fuse_i.h
>>> +++ b/fs/fuse/fuse_i.h
>>> @@ -161,6 +161,13 @@ struct fuse_inode {
>>>
>>>                         /* waitq for direct-io completion */
>>>                         wait_queue_head_t direct_io_waitq;
>>> +
>>> +#ifdef CONFIG_FUSE_IOMAP
>>> +                       /* pending io completions */
>>> +                       spinlock_t ioend_lock;
>>> +                       struct work_struct ioend_work;
>>> +                       struct list_head ioend_list;
>>> +#endif
>>>                 };
>>
>> This union member you are changing is declared for
>> /* read/write io cache (regular file only) */
>> but actually it is also for parallel dio and passthrough mode
>>
>> IIUC, there should be zero intersection between these io modes and
>>  /* iomap cached fileio (regular file only) */
>>
>> Right?
> 
> Right.  iomap will get very very confused if you switch file IO paths on
> a live file.  I think it's /possible/ to switch if you flush and
> truncate the whole page cache while holding inode_lock() but I don't
> think anyone has ever tried.
> 
>> So it can use its own union member without increasing fuse_inode size.
>>
>> Just need to be carefull in fuse_init_file_inode(), fuse_evict_inode() and
>> fuse_file_io_release() which do not assume a specific inode io mode.
> 
> Yes, I think it's possible to put the iomap stuff in a separate struct
> within that union so that we're not increasing the fuse_inode size
> unnecessarily.  That's desirable for something to do before merging,
> but for now prototyping is /much/ easier if I don't have to do that.
> 
> Making that change will require a lot of careful auditing, first I want
> to make sure you all agree with the iomap approach because it's much
> different from what I see in the other fuse IO paths. :)
> 
> Eeeyiks, struct fuse_inode shrinks from 1272 bytes to 1152 if I push the
> iomap stuff into its own union struct.
> 
>> Was it your intention to allow filesystems to configure some inodes to be
>> in file_iomap mode and other inodes to be in regular cached/direct/passthrough
>> io modes?
> 
> That was a deliberate design decision on my part -- maybe a fuse server
> would be capable of serving up some files from a local disk, and others
> from (say) a network filesystem.  Or maybe it would like to expose an
> administrative fd for the filesystem (like the xfs_healer event stream)
> that isn't backed by storage.
> 
>> I can't say that I see a big benefit in allowing such setups.
>> It certainly adds a lot of complication to the test matrix if we allow that.
>> My instinct is for initial version, either allow only opening files in
>> FILE_IOMAP or
>> DIRECT_IOMAP to inodes for a filesystem that supports those modes.
> 
> I was thinking about combining FUSE_ATTR_IOMAP_(DIRECTIO|FILEIO) for the
> next RFC because I can't imagine any scenario where you don't want
> directio support if you already use iomap for the pagecache.  fuse iomap
> requires directio write support for writeback, so the server *must*
> support IOMAP_WRITE|IOMAP_DIRECT.
> 
>> Perhaps later we can allow (and maybe fallback to) FOPEN_DIRECT_IO
>> (without parallel dio) if a server does not configure IOMAP to some inode
>> to allow a server to provide the data for a specific inode directly.
> 
> Hrmm.  Is FOPEN_DIRECT_IO the magic flag that fuse passes to the fuse
> server to tell it that a file is open in directio mode?  There's a few
> fstests that initiate aio+dio writes to a dm-error device that currently
> fail in non-iomap mode because fuse2fs writes everything to the bdev
> pagecache.


The other way around, FOPEN_DIRECT_IO is a flag that fuse-server tells
the kernel that it wants to bypass the page cache. And also allows
parallel DIO IO (shared vs exclusive lock).


Thanks,
Bernd

