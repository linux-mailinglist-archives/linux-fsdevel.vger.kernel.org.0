Return-Path: <linux-fsdevel+bounces-52895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB49AE807D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 13:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9DE14A5CAD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 10:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A66C27FB10;
	Wed, 25 Jun 2025 10:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="HBrpqhAd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h/VcZs/J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2AA1C07C4
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 10:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750849115; cv=none; b=dvYyPjmCWOnpqJHQCZ9A8Ksn9hGM1XqVt/GlY0AptAnTkb6EqcEE/Ss91MJA+AbqRJ6sWPhA7wPAmpVcgYu7p8w3xwy3Lw7e6gB982AedHOecqmHODDm5SRQ0kjcHNL0b766eB95BetgGTXEcNl0eXvTVRqR1difnNiPZyB9QG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750849115; c=relaxed/simple;
	bh=3F3hwL+YjEduvOp1W2c4ueZctixMEJW9CN4zg+0FyF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jKerRwZJAU5s614C4UTT1wy8KpJ0kTYjOSQkNCcVRojKbpLLwsrO2KnfkVVHGUsR8Ydd8VVTAospwJ4dwXhXWGMtvaRzIEnjnWpyFPKvnzrS6Y4SHjqi49R5c6RinE3+QXlqoRty8U6KovQ/kfPuBDhQGicrz2hj5UM8e2rX4Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=HBrpqhAd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h/VcZs/J; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 8A8DE1D0024E;
	Wed, 25 Jun 2025 06:58:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 25 Jun 2025 06:58:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1750849111;
	 x=1750935511; bh=2cPhUuxc1i+LnKFBZiVIBSPWqjQvR51oF4Fd16ihxaQ=; b=
	HBrpqhAd399eyf/pwU/9113oSOMpQKf5A2I7wnJm0jNJGzsMPTrLW4X6UfzATg/5
	vWo3eXBNW2Qnyja9HjFNpIq01d6DYUKiD87gZnXLDVwKlDJylFgS+0PVAma7kKbc
	593yKQwKuyBSFVQWlE4XkiC6KtrEWUnh1uoM0l6vCAFHenIMUtZhPToN9A1BtUA2
	F+328Ld79S5RNhKyEf9G95ieyuZHZADeImWzEUL2/e8IHsNWluF+/8/6qMLO4uNH
	PUeG3odzGTEeavosbm9YCAQHLqqVQkKrxSwf48Va22QqWBEg2m+OwtZCIdn+ZTG2
	a9vfvWD1cUoDPzfTT7unxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1750849111; x=
	1750935511; bh=2cPhUuxc1i+LnKFBZiVIBSPWqjQvR51oF4Fd16ihxaQ=; b=h
	/VcZs/JMxGBbtzrbyvAwzv45HEqsM+hPCeLjsuepfrweqClHI4B04Ku0dsGI24ab
	I1XZQkMTDYniLlS/FpEFsHhiRh5wEwGrz1kOyvO59j+EfcStPHCLWD+EP6LMQSMM
	9+RL4THuXvqcZ+qZ1txUFkI4d1udBLYgbauYe3WzIkH2mzbKQLnPLCUrZe+oPlId
	WxRaIirQdsDknuWptznF1qbnB49dSCanmhErLwzWhg1NkQlvNu3vtDLAnU/0uLyT
	E7MZDwNA4tkolpzhhVMJLgyKMeMWjE7e/NEiVcJDfLMII+8R4mrAUbV3oUCrUmDP
	iQZx3s3d8hDm6r1Rnyg4g==
X-ME-Sender: <xms:VtZbaJCnWHp8tBYu6KTNgAzs6adzAEh7-JBi3g_oDVwL1QGGwppXxg>
    <xme:VtZbaHjUAF-H3vwG7217sVrlAsp3MtVRb9yIuDe5nsiMhVY9H-RIptrFRRqZPyTCE
    LavXSY5S9pM>
X-ME-Received: <xmr:VtZbaEmfPhjA498YyZNrlc7_AWSNEtyORhcXIIxhvLktOHlZffSBPxw6sOkZimwG9d-WMUA75lauZrHpyoVh0-zeffX3OD93MOKWQXQMtnTcJXm8LVBUjXM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvvdehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepkfgrnhcumfgv
    nhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpedtud
    fghedtudfgfefgtdejgedutddtveefheetvdefueefgffggfdvieelteffgeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthh
    gvmhgrfidrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtphhtth
    hopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgrtghkse
    hsuhhsvgdrtgiipdhrtghpthhtohepthhorhhvrghlughssehlihhnuhigqdhfohhunhgu
    rghtihhonhdrohhrghdprhgtphhtthhopegvsghivgguvghrmhesgihmihhsshhiohhnrd
    gtohhm
X-ME-Proxy: <xmx:VtZbaDzU9P-gjij9W-Q11kMn0gQzfPex3jqw5WgnZ6tSchPfn8xKpg>
    <xmx:VtZbaOQJgN0pHV7ACaoKSlAnbzJU4CyuO6y_RwRM8QrwOivr_bcFWA>
    <xmx:VtZbaGaqfa9IRTYDGpJMzpO_WMT-qKYp8PEcfikeDeNeREw9P3ONXw>
    <xmx:VtZbaPTCPpzGMWTsqSKoTo_hfFfRdUAH0i1dR3BbFrBDxz2zCWOADQ>
    <xmx:V9ZbaFTDM_rmLIRlT9qCCm9ervXLDmKzmYlwwPJSdbX-vc0A9so0Zgwe>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jun 2025 06:58:28 -0400 (EDT)
Message-ID: <9b9e1ce4-bd58-4f67-933e-f28b6ff7d838@themaw.net>
Date: Wed, 25 Jun 2025 18:58:25 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHES v2][RFC][CFR] mount-related stuff
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Linus Torvalds <torvalds@linux-foundation.org>,
 Eric Biederman <ebiederm@xmission.com>
References: <20250610081758.GE299672@ZenIV> <20250623044912.GA1248894@ZenIV>
 <93a5388a-3063-4aa2-8e77-6691c80d9974@themaw.net>
 <20250623185540.GH1880847@ZenIV>
 <45bb3590-7a6e-455c-bb99-71f21c6b2e6c@themaw.net>
 <20250625075733.GS1880847@ZenIV>
Content-Language: en-US
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <20250625075733.GS1880847@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25/6/25 15:57, Al Viro wrote:
> On Tue, Jun 24, 2025 at 02:48:53PM +0800, Ian Kent wrote:
>
>> +    for (p = mnt; p; p = next_mnt(p, mnt)) {
>> +        unsigned int f = 0;
>> +
>> +        if (p->mnt_mountpoint != mnt->mnt.mnt_root) {
> ???  The loop goes over everything mounted on mnt, no matter how
> deep it is.  Do you mean "p is mounted on the root of its parent",
> or is it "p is mounted on some mount of the same fs, with mountpoint
> that just happens to be equal to root dentry of mnt (which may be
> not the mount p is mounted on)"?

I was trying to check if p is not covered but that's not what it does.


>
>> +        /* p is a covering mnt, need to check if p or any of its
>> +         * children are in use. A reference to p is not held so
>> +         * don't pass TREE_BUSY_REFERENCED to the propagation
>> +         * helper.
>> +         */
> ... so for these you keep walking through the subtree on them (nevermind
> that outer loop will walk it as well)...
>
>> +        for (q = p; q; q = next_mnt(q, p)) {
>> +            if (propagate_mount_tree_busy(q, f)) {
>> +                busy = true;
>> +                break;
>> +            }
> ... and yet you still keep going in the outer loop?  Confused...

Yes, I've not got this right at all.


>>       }
>>       unlock_mount_hash();
>> +    up_read(&namespace_sem);
>> + * count greater than the minimum reference count (ie. are in use).
>> + */
>> +int propagate_mount_tree_busy(struct mount *mnt, unsigned int flags)
>> +{
>> +    struct mount *m;
>> +    struct mount *parent = mnt->mnt_parent;
>> +    int refcnt = flags & TREE_BUSY_REFERENCED ? 2 : 1;
>> +
>> +    if (do_refcount_check(mnt, refcnt))
>> +        return 1;
>> +
>> +    for (m = propagation_next(parent, parent); m;
>> +            m = propagation_next(m, parent)) {
>> +        struct mount *child;
>> +
>> +        child = __lookup_mnt(&m->mnt, mnt->mnt_mountpoint);
>> +        if (!child)
>> +            continue;
>> +
>> +        if (do_refcount_check(child, 1))
>> +            return 1;
>> +    }
>> +    return 0;
>> +}
> What is the daemon expected to do with your subtree?  Take it apart with
> a series of sync (== non-lazy) umount(2)?  I presume it is normal for
> it to run into -EBUSY halfway through - i.e. get rid of some, but not
> all of the subtree, right?

All I need is to check if a mount and its children are in use, essentially

check if a mount subtree is in use in some way, working directory or open

file(s).


I think what I should be doing is very similar to what may_umount() does but

for the passed in mount and it's children with the adjustment for the 
ref held

on the passed in mount.


I rather like your implementation of may_umount() and 
propagate_mount_busy().

I think the only difference to what I need is that the passed in mount 
won't be

the global root and will usually have children (so I'd invert that 
list_empty()

check or leave it out for this check).


I'll have a go at that refactor and post it, we'll see if I can come up with

something acceptable.


The other difficulty is that automount can be run in a separate mount 
namespace

(eg. a container) which introduces a special case environment. I'm not 
sure how

the propagation will behave in this case. Atm. I'm thinking it might be 
sufficient

to just use what may_umount_tree() is now so it deliberately only checks 
the mount

tree in it's own namespace.


Ian


