Return-Path: <linux-fsdevel+bounces-57608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3198B23CD0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 01:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A27B46E4706
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 23:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F672DCF73;
	Tue, 12 Aug 2025 23:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="ueNoPElG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PYdpvhUV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274FB2FFDD8;
	Tue, 12 Aug 2025 23:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755042825; cv=none; b=f35Dp7WFOlx06Ob0qDni3a3bf87bffr4we3JMb7XBXKAJztQo448XtzM3m2uj/9Pwll9ZzNsz8u2dWDkCfYRqU5L9s+nXb095E3EGUS5DwqsyeOOpQis60Ut3Wt6I6crsOPQmMIlkjPEWc+Uio6drb5guP5gSvWmamnVAddxujM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755042825; c=relaxed/simple;
	bh=8bvUfGdy/4CX9YbEa5WAWf+9OFbb/luone3iWCIXdPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WFhDH2m0RzXaXcP53O0KN2VBslxq0Eog0hZiWA3ITMsUM9XLNGC413PGFtj1DCr0saFd/bs4GYPP7/pyS9rQLXSxd9iQIMM85TjErLy1+KJDd1ltMfwy8BY0E0bAX7PuZzW39h5PjSLPjnJdmzyvoCOzpEKNiZEVphwDLM0C/JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=ueNoPElG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PYdpvhUV; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5247C140005B;
	Tue, 12 Aug 2025 19:53:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 12 Aug 2025 19:53:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755042822;
	 x=1755129222; bh=XLBQ1JOtdE1KY0DlabBTT2NFzPxxhYJ/GR+ZB9hVK3U=; b=
	ueNoPElGunDTP+AIYiQYHCXPrE4tdYAGBQQFc7C0j/KVq5B/rso1okMxxNhcjnFu
	lDaO+CNTCJTOhGtWXKKK2JXbOBEjsiG4zyU673ntIxsgYiaumtV6pB2SVUfKte8Y
	a2Km2FTL3KR5rXOGPBmxAm8AOxz3JFm/nAClGYJ4JzNCiCmo0Twq6GPXObsvH8RS
	K0GJZAPmnnU2TLMGaPZTzPegp9lWly6bypTW6HjTOxHlsRoG3AwAffegWg9kXsnC
	vXM1AYqGMMUYwKedoplrCrsbRjM+zo8LLgEwnSXOboDbk5pjIYzTu9CXjwLrUeNf
	50DeMjcqFYnDs4nuUdgEoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755042822; x=
	1755129222; bh=XLBQ1JOtdE1KY0DlabBTT2NFzPxxhYJ/GR+ZB9hVK3U=; b=P
	YdpvhUVpylpmritIomVjV4uY6espHnL9LGgeBKmxp9vrXk43vO873MDCCE7Af8iX
	jhNahXhtSs2j0w6eGtFCGx2C8MWYs1pMlUd1kktPgFOcOnAcy+JaJqHL63JlWK3V
	W4UlmMLfPiKe5qC6Tro9hR87A5OZXWGG2DC4ujuKe5Dv7dpSo2/w9ti/qnDHjAam
	w8ANm49HVWsYX5NXiF0/snZX+dJ7Rq7ArGR/lSTHPuCa8PwW1NPHdi1UheFsyqde
	csODme7txn4I/nSsiEAhVtOfcNsFA/CKZ+Eebp/8rcrHSdOS7p9mVbsNn09cmLsy
	7CRuBvjlyeFUGVQdLLEIA==
X-ME-Sender: <xms:BNSbaArauuSEbZVtq-of3rqid7cVmtX1v81Z3s94m5xuVm3y5Vz_WQ>
    <xme:BNSbaFJaFhANtvwLXIqCxEsNlVe6fiLzy2CzZa6vs6Qi1Rd4eKWT3shC45sFBDi3W
    2B9fGaH7BEUDoYYxJ0>
X-ME-Received: <xmr:BNSbaAtgYOxMwNeAsWk3AePFkbeEGoEFHfUIvUu6ImxjMKuyp9AWaE1gFT12yni601klHQRuZfQO1p5W0BXBEQ5f>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeeijedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefvihhnghhm
    rghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepud
    ekvefhgeevvdevieehvddvgefhgeelgfdugeeftedvkeeigfeltdehgeeghffgnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifth
    hmrdhorhhgpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheprghsmhgruggvuhhssegtohguvgifrhgvtghkrdhorhhgpdhrtghpthhtoheplh
    hinhhugigpohhsshestghruhguvggshihtvgdrtghomhdprhgtphhtthhopegvrhhitghv
    hheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhutghhohesihhonhhkohhvrdhnvg
    htpdhrtghpthhtohepvhelfhhssehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthht
    ohepmhhitgesughighhikhhougdrnhgvthdprhgtphhtthhopehgnhhorggtkhesghhooh
    hglhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqshgvtghurhhithihqdhmohguuhhl
    vgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrggtkhesshhushgvrd
    gtii
X-ME-Proxy: <xmx:BNSbaCBa8jG_WH2gUrLcLw72gKwi6ROtUq2biWNbEWI2EpnfTR9JpA>
    <xmx:BNSbaI6fiRcGpQ1cRv1HqRjZARKpKL2rFDMERYhsq001qNkWTjUAmQ>
    <xmx:BNSbaKAUlihntSxmA44arQgYRy1n2GU0xia-l8upFBnO7WEt17Kfyw>
    <xmx:BNSbaO6cI2nKsRdbcGk2JFdpOm0HyfVY5EdhUq3ZiQLWhA-mV45JIg>
    <xmx:BtSbaK608ARYjuEsDIdb5PnIT52AdUV1E8NBCVLOCuqqJSY5ss_8cwO2>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Aug 2025 19:53:39 -0400 (EDT)
Message-ID: <b9aa9f6f-483f-41a5-a8d7-a3126d7e4b8f@maowtm.org>
Date: Wed, 13 Aug 2025 00:53:37 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/6] fs/9p: Reuse inode based on path (in addition to
 qid)
To: Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>, v9fs@lists.linux.dev,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 linux-security-module@vger.kernel.org, Jan Kara <jack@suse.cz>,
 Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>,
 Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
References: <cover.1743971855.git.m@maowtm.org>
 <aJXRAzCqTrY4aVEP@codewreck.org> <13395769.lPas3JvW2k@silver>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <13395769.lPas3JvW2k@silver>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/8/25 11:27, Dominique Martinet wrote:
> Sorry for the delay...

No worries, thanks for picking this up!

> 
> Tingmao Wang wrote on Sun, Apr 06, 2025 at 09:43:01PM +0100:
>> Unrelated to the above problem, it also seems like even with the revert in
>> [2], because in cached mode inode are still reused based on qid (and type,
>> version (aka mtime), etc), the setup mentioned in [2] still causes
>> problems in th latest kernel with cache=loose:
> 
> cache=loose is "you're on your own", I think it's fine to keep as is,
> especially given qemu can handle it with multidevs=remap if required

On 8/8/25 11:52, Christian Schoenebeck wrote:
>> [...]
> 
> As of QEMU 10.0, multidevs=remap (i.e. remapping inodes from host to guest) is
> now the default behaviour, since inode collisions were constantly causing
> issues and confusion among 9p users.
> 
> And yeah, cache=loose means 9p client is blind for whatever changes on 9p
> server side.
> 
> /Christian
> 

My understanding of cache=loose was that it only assumes that the server
side can't change the fs under the client, but otherwise things like
inodes should work identically, even though currently it works differently
due to (only) cached mode re-using inodes - was this deliberate?

Basically, assuming no unexpected server side changes, I would think that
the user would not be totally "on their own" (even if there are colliding
qids).  But given the issue with breaking how hardlinks currently works in
cached mode, as Dominique mentioned below, and the fact that inode
collisions should be rare given the new QEMU default, maybe we do need to
handle this differently (i.e. keep the existing behaviour and working
hardlinks for cached mode)?  I'm happy either way (Landlock already works
currently with cached mode)

On 8/8/25 11:27, Dominique Martinet wrote:
> Tingmao Wang wrote on Sun, Apr 06, 2025 at 09:43:01PM +0100:
> [...]
>> With the above in mind, I have a proposal for 9pfs to:
>> 1. Reuse inodes even in uncached mode
>> 2. However, reuse them based on qid.path AND the actual pathname, by doing
>>    the appropriate testing in v9fs_test(_new)?_inode(_dotl)?
> 
> I think that's fine for cache=none, but it breaks hardlinks on
> cache=loose so I think this ought to only be done without cache
> (I haven't really played with the cache flag bits, not check pathname if
> any of loose, writeback or metadata are set?)
> 

I think currently 9pfs reuse inodes if cache is either loose or metadata
(but not writeback), given:

	else if (v9ses->cache & (CACHE_META|CACHE_LOOSE))
		inode = v9fs_get_inode_from_fid(v9ses, fid, dir->i_sb);
	else
		inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);

in v9fs_vfs_lookup, so maybe we keep this pattern and not check pathname
if (loose|metadata) is set (but not writeback)?

>> The main problem here is how to store the pathname in a sensible way and
>> tie it to the inode.  For now I opted with an array of names acquired with
>> take_dentry_name_snapshot, which reuses the same memory as the dcache to
>> store the actual strings

(Self correction: technically, the space is only shared if they are long
enough to not be inlined, which is DNAME_INLINE_LEN = 40 for 64bit or 20
for 32bit, so in most cases the names would probably be copied.  Maybe it
would be more compact in terms of memory usage to just store the path as a
string, with '/' separating components?  But then the code would be more
complex and we can't easily use d_same_name anymore, so maybe it's not
worth doing, unless this will prove useful for other purposes, like the
re-opening of fid mentioned below?)

>> , but doesn't tie the lifetime of the dentry with
>> the inode (I thought about holding a reference to the dentry in the
>> v9fs_inode, but it seemed like a wrong approach and would cause dentries
>> to not be evicted/released).
> 
> That's pretty hard to get right and I wish we had more robust testing
> there... But I guess that's appropriate enough.
> 
> I know Atos has done an implementation that keeps the full path
> somewhere to re-open fids in case of server reconnections, but that code
> has never been submitted upstream that I can see so I can't check how
> they used to store the path :/ Ohwell.
> 
>> Storing one pathname per inode also means we don't reuse the same inode
>> for hardlinks -- maybe this can be fixed as well in a future version, if
>> this approach sounds good?
> 
> Ah, you pointed it out yourself. I don't see how we could fix that, as
> we have no way other than the qid to identify hard links; so this really
> ought to depend on cache level if you want to support landlock/*notify
> in cache=none.

In that case, and as discussed above, I'm happy to change this patch
series to only affect uncached.

> 
> Frankly the *notify use-case is difficult to support properly, as files
> can change from under us (e.g. modifying the file directly on the host
> in qemu case, or just multiple mounts of the same directory), so it
> can't be relied on in the general case anyway -- 9p doesn't have
> anything like NFSv4 leases to get notified when other clients write a
> file we "own", so whatever we do will always be limited...
> But I guess it can make sense for limited monitoring e.g. rebuilding
> something on change and things like that?

One of the first use case I can think of here is IDE/code editors
reloading state (e.g. the file tree) on change, which I think didn't work
for 9pfs folders opened with vscode if I remembered correctly (but I
haven't tested this recently).  Even though we can't monitor for remote
changes, having this work for local changes would still be nice.


Note that aside from Mickaël's comments which I will apply in the next
version, I also realized that I haven't done the proper handling for
renames (it should probably update the v9fs_ino_path in the renamed
inode).  I will do that in the next version (in addition to changing the
cached behaviour).  Do let me know if you have any other comment on the
patch series.

Best,
Tingmao

