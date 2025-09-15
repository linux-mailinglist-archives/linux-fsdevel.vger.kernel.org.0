Return-Path: <linux-fsdevel+bounces-61404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2D7B57DC7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 15:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20642161E7C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 13:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F8C30DD06;
	Mon, 15 Sep 2025 13:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="Wym1hIkk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UAOshNW8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDD630C357;
	Mon, 15 Sep 2025 13:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757943891; cv=none; b=fRDmKZcoH1Gw9qnzBqR3xQ10xjp9xO8ms2qRfpLrGU60KNKTni/8OkwRMrBSaE3G9Rspb/6Q3x73lgzkX+YefZhbw971OtGGj/XOCtOEqa/zMFHN4MXkoXRvqkcdi+Wd4AQcXue1dhk0paxOHYOZ+akbp5TkK17UQmhwahigEFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757943891; c=relaxed/simple;
	bh=e75sPnLacRIrPaTasHXEuwKUhxcZAlEkczgammwe/1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nciF1rm8PxBzRUSYUMikF8n7aEmdB+oXrH5xxjJZCUweMqN2AA4lGWu/ymtoPA6+Q1y7DqakizKl/0pClGde1j3O07CZ2VkgvVBOQQlst95yN2Lz6BqNpTx07aXEjJk0NuCls3OWxZm7ihSIzg5Smr6Qq3tM4QO+SrpyNohuQrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=Wym1hIkk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UAOshNW8; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 6D449EC03B7;
	Mon, 15 Sep 2025 09:44:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 15 Sep 2025 09:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757943888;
	 x=1758030288; bh=v7L59rPe1s3khD5kn4HEHFqEsYaKc21moOaR2xGoNB0=; b=
	Wym1hIkk7/6nEyjvxRKxIOq8LkIBwUN9JqfdREpZYx4IbIrxmKAzqe8GsFlBuZr7
	DsVbHp9prLHakkzg/wWrG2j7ebvAurwZIX+KulqgrayoQ5A+oZ++H4vRGJzajTQ7
	O7XVVmijIpGFDxGj7yXNvWitEsLY5crVB/BAcoUB2uiQZuiTPlHcJ3dXzT+h76Tx
	zMQh8YOCpu22F6pWWRLU9b0aosIumfWQCueWteuSfcn6JqivK4DidgytInh8yZvy
	lurThtD0l9e2ebFsKfSPeNF8nVOSSXAuyp2LZYww4oYW6BOIvOiP/gvqb9eeeXC4
	H46lJ6orGiuN+Lrx37ZZ+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757943888; x=
	1758030288; bh=v7L59rPe1s3khD5kn4HEHFqEsYaKc21moOaR2xGoNB0=; b=U
	AOshNW82njNpPpHiLQGS5NYdYlmY6JRRUeE6sBqzoaOi54QLfecF5lPFLqvtHG4Y
	FyfZskjIBhLSPAK2M4rpbL28h2uFa49kZjBe2yiFFZYj77K1h0HJ9NbAIGWbcvZk
	ucpvVsbsktFYOXe7eHU+6vZ1/+MvX1c/X4vdiNgO10HOw7jKgfPHh6+56KYC9cqb
	C+8AKFEh39iUBmS9mTIWPxUxzYm+LndqZEWuYR+FhK1jR28LlmSe2MaQ6d1ZKW/i
	QmWzx6Fgjad1EMUqczVlfPA4TKu8cTSBzgAHU3gUyZWvwi77uZp6vbhaULbFZ4vd
	so2FEWqRGX141ko3EbkHw==
X-ME-Sender: <xms:TxjIaL6wlaLkZ9LgChql5AEUyXNLWTLcyi82ePtW-Tm-Ij9qr_8Gtw>
    <xme:TxjIaMuUdRa6lzPFQT-md6mPo2JpLWOy2d6y8hlkhYdKNxsJr4awUKyUy-XM5l1YI
    NrkX781ukANRz2ouRA>
X-ME-Received: <xmr:TxjIaI7gSYQEtDTAf6l0lZJhjeltCIWlEYi1lJsXj2cVxqzOP4acOYrKpxQqaJLRzY6vWZ3arjocUZW2s971FcOO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjeekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepvfhinhhgmhgr
    ohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeduke
    evhfegvedvveeihedvvdeghfeglefgudegfeetvdekiefgledtheeggefhgfenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmh
    drohhrghdpnhgspghrtghpthhtohepudegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegrshhmrgguvghushestghouggvfihrvggtkhdrohhrghdprhgtphhtthhopehmih
    gtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepvghrihgtvhhhsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehluhgthhhosehiohhnkhhovhdrnhgvthdprhgtphhtthhope
    hlihhnuhigpghoshhssegtrhhuuggvsgihthgvrdgtohhmpdhrtghpthhtohepvhelfhhs
    sehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepghhnohgrtghksehgohhogh
    hlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgv
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgrtghksehsuhhsvgdrtg
    ii
X-ME-Proxy: <xmx:TxjIaI01R24TBVRKz2z7OiWh6POySximiW72YbYcVMgMQHSRD9-egQ>
    <xmx:TxjIaDjuFMZ2Rw_ESAnZ2vEWHngfkoR-yprwZOLOrYx_Z2g3kFoO-w>
    <xmx:TxjIaAouc7HfXT4WhMvo8H28CX3LL1awUmXpcfLZYYIowlp7X1KiJQ>
    <xmx:TxjIaONlMX3QsIYI8ubPbXSgBbsYZUrBmVtW_TgtQEpGOXdFRnFFtg>
    <xmx:UBjIaNQaKJjTGOwDI5EslRElZguoM5DUysXrF2m9xjsNFmhsiOrkqg-2>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 09:44:45 -0400 (EDT)
Message-ID: <41d761e6-d826-4c29-b673-1fb2b0af77b9@maowtm.org>
Date: Mon, 15 Sep 2025 14:44:44 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] fs/9p: Reuse inode based on path (in addition to
 qid)
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov
 <lucho@ionkov.net>, Christian Schoenebeck <linux_oss@crudebyte.com>,
 v9fs@lists.linux.dev, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 linux-security-module@vger.kernel.org, Jan Kara <jack@suse.cz>,
 Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 linux-fsdevel@vger.kernel.org
References: <cover.1756935780.git.m@maowtm.org>
 <2acd6ae7-caf5-4fe7-8306-b92f5903d9c0@maowtm.org>
 <aMgMOnrAOrwQyVbp@codewreck.org>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <aMgMOnrAOrwQyVbp@codewreck.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/15/25 13:53, Dominique Martinet wrote:
> Hi Tingmao,
> 
> thanks for pushing this forward, I still have very little time so
> haven't been able to review this properly

No worries and thanks for the quick reply :)

> 
> Tingmao Wang wrote on Sun, Sep 14, 2025 at 10:25:02PM +0100:
>> I had a chat with Mickaël earlier this week and some discussion following
>> that, and we thought of a potential alternative to what I was proposing
>> here that might work for Landlock: using the inode number (or more
>> correctly, qid.path) directly as the keys for Landlock rules when
>> accessing 9p files.  I'm not sure how sound this is from the perspective
>> of 9pfs (there are pros and caveats), and I would like to gather some
>> thoughts on this idea.
> 
> I'm honestly split on this:
> - I really don't like tracking the full path of each file around;
> there are various corner cases with files being removed (possibly server
> side!) or hard links; and it's potentially slowing down all operations a
> bit...

The way I see it, this tracking is really a best-effort, pragmatic
solution, and in the presence of server-side changes, it's not going to
always be correct (but then, because of the possibility of qid collisions,
there is not really a fully fool-proof way in any case).  In some sense
currently hard links doesn't "work" anyway in uncached mode since each
inode is separate - this doesn't change that.  Files being removed is not
a problem, and if another file with the same name is recreated, if it has
a different qid we will create a new inode anyway (since this patch really
matches against path _and_ qid).  I've not measured the slowdown, but I
think in uncached mode the time is mostly domainated communication
overhead in any case... I think.

However, alternatives do exist (as discussed above and below)

> - OTOH as you pointed out qid isn't as reliable, and having file paths
> around opens the way to rebuilding fids on reconnect for non-local
> servers, which could potentially be interesting (not that I ever see
> myself having time to work on this as I no longer have any stake there,
> I just know that would have interested my previous employer when they
> were still using 9p/rdma...)

If you / anyone else would be interested in that I can implement it, but
that would probably be best done by landing the ino_path struct in this
patchset first.

> 
>> In discussion with Mickaël he thought that it would be acceptable for
>> Landlock to assume that the server is well-behaved, and Landlock could
>> specialize for 9pfs to allow access if the qid matches what's previously
>> seen when creating the Landlock ruleset (by using the qid as the key of
>> the rule, instead of a pointer to the inode).
> 
> I'm not familiar at all with landlock so forgive this question: what is
> this key about exactly?
> When a program loads a ruleset, paths referred in that ruleset are
> looked up by the kernel and the inodes involved kept around in some hash
> table for lookup on further accesses?

Yes, that is correct (but it uses rbtree, not hash table, currently).

> 
> I'm fuzzy on the details but I don't see how inode pointers would be
> stable for other filesystems as well, what prevents
> e.g. vm.drop_caches=3 to drop these inodes on ext4?

Landlock holds a reference to the inode in the ruleset, so they shouldn't
be dropped.  On security_sb_delete Landlock will iput those inodes so they
won't cause issue with unmounting.  There is some special mechanism
("landlock objects") to decouple the ruleset themselves from the actual
inodes, so that previously Landlocked things can keep running even after
the inode has disappeared as a result of unmounting.

> 
> In general I'd see the file handle (as exposed to userspace by
> name_to_handle_at) as a stable key, that works for all filesystems
> supporting fhandles (... so, not 9p, right... But in general it's
> something like inode number + generation, and we could expose that as
> handle and "just" return ENOTSUP on open_by_handle_at if that helps)

Hmm, I think this would be a good way for 9pfs to expose the qid to
Landlock, by exposing it as a handle, since that is standardized.

> 
> Although looking at the patches what 9p seems to need isn't a new stable
> handle, but "just" not allocating new inodes in iget5...
> This was attempted in 724a08450f74 ("fs/9p: simplify iget to remove
> unnecessary paths"), but later reverted in be2ca3825372 ("Revert "fs/9p:
> simplify iget to remove unnecessary paths"") because it broke too many
> users, but if you're comfortable with a new mount option for the lookup
> by path I think we could make a new option saying
> "yes_my_server_has_unique_qids"... Which I assume would work for
> landlock/fsnotify?

I noticed that, but assumed that simply reverting them without additional
work (such as tracking the string path) would be a no go given the reason
why they are reverted.

> 
> If you'd like to try, you can re-revert these 4 patches:
> Fixes: be2ca3825372 ("Revert "fs/9p: simplify iget to remove unnecessary paths"")
> Fixes: 26f8dd2dde68 ("Revert "fs/9p: fix uaf in in v9fs_stat2inode_dotl"")
> Fixes: fedd06210b14 ("Revert "fs/9p: remove redundant pointer v9ses"")
> Fixes: f69999b5f9b4 ("Revert " fs/9p: mitigate inode collisions"")
> 
> If that works, and having this only work when a non-default option is
> set is acceptable, I think that's as good a way forward as we'll find.

Well, if you think there is no other possibility for a default solution
(and tracking paths by default is not feasible) I think it might also be
alright if we expose the qid as a handle to Landlock (without any need for
mount options), and figure out a way for Landlock to keep a fid open.

> 
>> 1. The qid is 9pfs internal data, and we may need extra API for 9pfs to
>>    expose this to Landlock.  On 64bit, this is easy as it's just the inode
>>    number (offset by 2), which we can already get from the struct inode.
>>    But perhaps on 32bit we need a way to expose the full 64bit server-sent
>>    qid to Landlock (or other kernel subsystems), if we're going to do
>>    this.
> 
> I'm not sure how much effort we want to spend on 32bit: as far as I
> know, if we have inode number collision on 32 bit we're already in
> trouble (tools like tar will consider such files to be hardlink of each
> other and happily skip reading data, producing corrupted archives);
> this is not a happy state but I don't know how to do better in any
> reasonable way, so we can probably keep a similar limitation for 32bit
> and use inode number directly...

I think if 9pfs export a handle it can be the full 64bit qid.path on any
platform, right?

> 
>> 2. Even though qids are supposed to be unique across the lifetime of a
>>    filesystem (including deleted files), this is not the case even for
>>    QEMU in multidevs=remap mode, when running on ext4, as tested on QEMU
>>    10.1.0.
> 
> I'm not familiar with the qid remap implementation in qemu, but I'm
> curious in what case you hit that.
> Deleting and recreating files? Or as you seem to say below the 'qid' is
> "freed" when fd is closed qemu-side and re-used by later open of other
> files?

I tried mounting a qemu-exported 9pfs backed on ext4, with
multidevs=remap, and created a file, used stat to note its inode number,
deleted the file, created another file (of the same OR different name),
and that new file will have the same inode number.

(If I don't delete the file, then a newly created file would of course
have a different ext4 inode number, and in that case QEMU exposes a
different qid)

> 
> If this is understood I think this can be improved, reusing the qid on
> different files could yield problems with caching as well so I think
> it's something that warrants investigations.
> 
>>    Unfortunately, holding a dentry in Landlock prevents the filesystem
>>    from being unmounted (causes WARNs), with no (proper) chance for
>>    Landlock to release those dentries.  We might do it in
>>    security_sb_umount, but then at that point it is not guaranteed that
>>    the unmount will happen - perhaps we would need a new security_ hooks
>>    in the umount path?
> 
> Hmm yeah that is problematic, I don't see how to take "weak" refs that
> wouldn't cause a warning for the umount to free yet still prevent
> recycling the inode, so another hook to free up resources when really
> umounting sounds appropriate if we go that way... At least umount isn't
> usually performance sensitive so it would probably be acceptable?
> 
> 

