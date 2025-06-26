Return-Path: <linux-fsdevel+bounces-53043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94625AE9338
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 02:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0647016F933
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 00:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B67D433D1;
	Thu, 26 Jun 2025 00:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="lyhuNiKt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CHaVK/ET"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C55F171C9;
	Thu, 26 Jun 2025 00:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750896464; cv=none; b=S4euL8esp0A3p27fI4OjRdQ9te4/nPaY9EeiEfzATAzFm/949sEUdxwtUicAaJOvZXgfTjI+WJFYVflIQqTalMXgiBcwSyebMM3X9naf+jan3yBEusj+LXnZEqbH948H7fVteCyb+A09Yt3VR7FHngYE2t7SOjsHBOosYr4i07s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750896464; c=relaxed/simple;
	bh=kUnWFnjCaiq9I4fMukWqZx0HnF1nLkWlR58aOt8J6Xs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ti8nk7Yalhoc+rzqXIYcPse6X+kCzzCejhijr0sHa0sKv6PWNbZ2tF6FVkv9SzarUoRTUBo9i/GNr4LK81IkjJYh0iM+Xg3R7kCINmtxwQHJkRd+gZXAjrfhP5h9HB5Yw5p2sxYJELdjNDXD+AhEGuNLYoO7TbXuSARussBOiqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=lyhuNiKt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CHaVK/ET; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D94797A00AA;
	Wed, 25 Jun 2025 20:07:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 25 Jun 2025 20:07:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1750896460;
	 x=1750982860; bh=6iB4j192is+XcHHs5pGOohrQltXRFVd8r1/AZa100HY=; b=
	lyhuNiKtkWBct2tuJ7nvGabQt1EmOi702ZSkOICY0hr3nvC/mY005tbk0UTTVaPA
	dIyHC8w4Pz2RKz2IceX/djV4/m+2uncDwSCe3v3EfV3oDiY4reY6v0bBfCxFlWHX
	N49N0b2SRT6ig8dpkrUqD7EjlnJojmoUJXlw7mp+f0y1l3xU1ItNxSM6DFRQVYFZ
	6xyjeUqbFP9QDKLtzYlm+71J6B9NjBpLTCWp4SK1VEXYSY6pA2fVjHpwKxjNi+5l
	40DwH8T2CXy9xt6e3mBmWNQfrlmQnByVvxqP0fsItud35HGdFJPjRZkQKiuvHQki
	yO0fA0N65ATbdb/6VFKl6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1750896460; x=
	1750982860; bh=6iB4j192is+XcHHs5pGOohrQltXRFVd8r1/AZa100HY=; b=C
	HaVK/ET0I+AUVHSKOQxFuxdtOIAsYb2WWK5DuF9BgQ3ZV0qEeQrnpBQHUhMoKS8r
	By5IwsQf3/WJ/8hW/FdQUaCOxZI3gfwcpEsCft2bo1pez8cXeCiVdhDhDahrkqJa
	6Ps3NQn5BABRdBXP0qO9wzoQ5+nZs9Is4+x0Hh8o4xurrJtWi6AjQyVQg5pzyC8n
	NvNU0lIPeomzc6P9txvn3K3V7YZr7OcpYKJrOGfK3JNjg8fwK43SPKiLPJ85xoZ0
	fJiIvUFlPBx/2ApMkK5SVOw5D5y9QapzpowQzebfenewWwlSMA1OAHAtDRDnPzU9
	KowRobPoKQQmrps80+7UA==
X-ME-Sender: <xms:S49caFLFcrSApcU2jOpUlI00gsCkB2x3A6CoSOBf2-4He9X1ZrmRVg>
    <xme:S49caBLMsz0Yr_4etyJDA2L45ck-iQb1dWk90rt6j2sPkY54gy9bTqKfoRMPdp1av
    Ugot86l5hvmQGdNsig>
X-ME-Received: <xmr:S49caNtn3oJl2C__wU4KcfbaKsxbs6IJpoPuorqG1ROWhEGY5qtsMeYtQW45xYnAwGUsE439iRay-u96370KYt6k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvgedujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfhuffvvehfjggtgfesthekredttddvjeenucfhrhhomhepvfhinhhgmhgr
    ohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeejfe
    fggefhjeeuhfehieegvdetteduiedufeevhfehgffgfffhtedufeetveduffenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepmhesmhgrohifthhmrdhorhhgpdhnsggprhgtphhtthhopedu
    ledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvihhlsegsrhhofihnrdhnrg
    hmvgdprhgtphhtthhopehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepshho
    nhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsphhfsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughu
    lhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesmhgvthgrrdgt
    ohhm
X-ME-Proxy: <xmx:S49caGZmyHa7KTwgB-YjJh1GahuTe_A09zBNX8Ps1bu4-mDa6sm0yA>
    <xmx:S49caMYBn7U26qAl9lQNLL8Id6sTzuMtT5DH0nrw3wtcCvwEDWF_ZQ>
    <xmx:S49caKBBugcSMCDAtCGK5jZSd6CHsziHDZCH7IkQYHNc45qv9ZHshA>
    <xmx:S49caKZCYVNCEODdnE7P0ZAi-9VA0sl1Y2BZO_AloU2GqG9lgILfMA>
    <xmx:TI9caJs9aJd61SNdXBl1LFCVQJ7acDQS08ldytdxSP7rPodU9dzpWOaw>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jun 2025 20:07:37 -0400 (EDT)
Message-ID: <4577db64-64f2-4102-b00e-2e7921638a7c@maowtm.org>
Date: Thu, 26 Jun 2025 01:07:36 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tingmao Wang <m@maowtm.org>
Subject: Re: [PATCH v5 bpf-next 0/5] bpf path iterator
To: NeilBrown <neil@brown.name>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>
Cc: Song Liu <song@kernel.org>, bpf@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, brauner@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, viro@zeniv.linux.org.uk,
 jack@suse.cz, kpsingh@kernel.org, mattbobrowski@google.com,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
References: <> <20250625.Ee2Ci6chae8h@digikod.net>
 <175089269668.2280845.5681675711269608822@noble.neil.brown.name>
Content-Language: en-US
In-Reply-To: <175089269668.2280845.5681675711269608822@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/26/25 00:04, NeilBrown wrote:
> On Wed, 25 Jun 2025, Mickaël Salaün wrote:
>> On Wed, Jun 25, 2025 at 07:38:53AM +1000, NeilBrown wrote:
>>>
>>> Can you spell out the minimum that you need?
>>
>> Sure.  We'd like to call this new helper in a RCU
>> read-side critical section and leverage this capability to speed up path
>> walk when there is no concurrent hierarchy modification.  This use case
>> is similar to handle_dots() with LOOKUP_RCU calling follow_dotdot_rcu().
>>
>> The main issue with this approach is to keep some state of the path walk
>> to know if the next call to "path_walk_parent_rcu()" would be valid
>> (i.e. something like a very light version of nameidata, mainly sequence
>> integers), and to get back to the non-RCU version otherwise.
>>
>>>
>>> My vague impression is that you want to search up from a given strut path,
>>> no further then some other given path, looking for a dentry that matches
>>> some rule.  Is that correct?
>>
>> Yes
>>
>>>
>>> In general, the original dentry could be moved away from under the
>>> dentry you find moments after the match is reported.  What mechanisms do
>>> you have in place to ensure this doesn't happen, or that it doesn't
>>> matter?
>>
>> In the case of Landlock, by default, a set of access rights are denied
>> and can only be allowed by an element in the file hierarchy.  The goal
>> is to only allow access to files under a specific directory (or directly
>> a specific file).  That's why we only care of the file hierarchy at the
>> time of access check.  It's not an issue if the file/directory was
>> moved or is being moved as long as we can walk its "current" hierarchy.
>> Furthermore, a sandboxed process is restricted from doing arbitrary
>> mounts (and renames/links are controlled with the
>> LANDLOCK_ACCESS_FS_REFER right).
>>
>> However, we need to get a valid "snapshot" of the set of dentries that
>> (could) lead to the evaluated file/directory.
> 
> A "snapshot" is an interesting idea - though looking at the landlock
> code you one need inodes, not dentries.
> I imagine an interface where you give it a starting path, a root, and
> and array of inode pointers, and it fills in the pointers with the path
> - all under rcu so no references are needed.
> But you would need some fallback if the array isn't big enough, so maybe
> that isn't a good idea.
> 
> Based on the comments by Al and Christian, I think the only viable
> approach is to pass a callback to some vfs function that does the
> walking.
> 
>    vfs_walk_ancestors(struct path *path, struct path *root,
> 		      int (*walk_cb)(struct path *ancestor, void *data),
> 		      void *data)
> 
> where walk_cb() returns a negative number if it wants to abort, and is
> given a NULL ancestor if vfs_walk_ancestors() needed to restart.
> 
> vfs_walk_ancestors() would initialise a "struct nameidata" and
> effectively call handle_dots(&nd, LAST_DOTDOT) repeatedly, calling
>     walk_cb(&nd.path, data)
> each time.

handle_dots semantically does more than dget_parent + choose_mountpoint
tho (which is what Landlock currently does, and is also what Song's
iterator will do).  There is the step_into which will step into
mountpoints (there is also code to handle symlinks, although I'm not sure
if that's relevant for following ".."), and it will also return ENOENT if
the path is disconnected.

Also I guess we might not need to have an entire nameidata?  In theory it
only needs to do what follow_dotdot_rcu does without the path_connected
check.  So it seems like given we have path and root as function argument,
it would only need nd->{seq,m_seq}.

I might be wrong tho, but certainly the behaviour is different.

> 
> How would you feel about that sort of interface?

I can't speak for Mickaël, but a callback-based interface is less flexible
(and _maybe_ less performant?).  Also, probably we will want to fallback
to a reference-taking walk if the walk fails (rather than, say, retry
infinitely), and this should probably use Song's proposed iterator.  I'm
not sure if Song would be keen to rewrite this iterator patch series in
callback style (to be clear, it doesn't necessarily seem like a good idea
to me, and I'm not asking him to), which means that we will end up with
the reference walk API being a "call this function repeatedly", and the
rcu walk API taking a callback.  I think it is still workable (after all,
if Landlock wants to reuse the code in the callback it can just call the
callback function itself when doing the reference walk), but it seems a
bit "ugly" to me.

But this is just my opinion, and if there is a stronger desire to not
expose any VFS seqcount integers then maybe we will just need to work with
a callback.

Quick note in case anyone reading this has not seen it, a while ago I made
a POC of a non-callback style API for rcu parent walk based on Song's
series:
https://lore.kernel.org/all/dbc7ee0f1f483b7bc2ec9757672a38d99015e9ae.1749402769@maowtm.org/#iZ31fs:namei.c

> 
> NeilBrown
> 


