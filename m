Return-Path: <linux-fsdevel+bounces-53128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 361FDAEAD29
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 05:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4BC7567B0B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 03:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAB415746E;
	Fri, 27 Jun 2025 03:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="e5rjIE75";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iN31Ogkf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFCC23DE
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Jun 2025 03:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750993405; cv=none; b=gSGWGeZbfWY6QVyMFjxYYDlphsoRqASsLY39krg8eYLV6H7XYiz+UQr6kpbOQ0adqZOow8CtHvsb3C+WzMb8dX8RpApfQvrLz1tmrh+sWtZ6g7BrVV3Ex1bbLFHJHJin8c40IRzUAgIDdrvEdcpXyeJribnfMgcwTucSWMv2fbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750993405; c=relaxed/simple;
	bh=EUfBE2Y9WxD5Dsnjnl2medmR2gH+6YtPzDrg6JN+i/Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rWpjYWQBfrHFS3aqO/WOeX6kC+s8cEpRQU/tdc3FB6+nDMyqWr0OacnviOAuQdkViPlziZ2n8FMXDqjd0cGifxVnZYV12jYM/wxDxZYh9YnQKNCURAxLAlwpSGYzQwxhiztlxdgHbUoyaVzjitYOjD35fCcmXonXAYgkWUQPZjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=e5rjIE75; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iN31Ogkf; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7DBB07A02FB;
	Thu, 26 Jun 2025 23:03:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 26 Jun 2025 23:03:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1750993401;
	 x=1751079801; bh=udyZ3TgqlDvfbPNXwZgfUJieiS1jS2LCUH66GwXIRhA=; b=
	e5rjIE75JjXQn4twzofcK/XnW8ENuohy9rXTf/ledf/EhQ8fHrsz+qIxCi2yH0fO
	n9pnDhnvsBjtYdR1EU5xU6/DYkP2S+rCAhukFly+BRVVRsus/RxCYkosmqK0LNnr
	ZOXsNGV9UqNNgmOHRluTm5a3BzTsZj4XyfKhVvbwvnD1SG16gazb27SrJhd8o+Nr
	fxeZio/4QkRgJ4wB2N5K/aJ6jphfpnHAtN4QYVnygBRup9LzYF5aNNI0Qh7RRXeZ
	rEHg+0e51ef29441cxV/6X4j2wGzAjX6l2zycCHKDRw0EDqCO1Zxhaame0N5bM7h
	cd8mXSgDLVY/ymiiTZJOeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1750993401; x=
	1751079801; bh=udyZ3TgqlDvfbPNXwZgfUJieiS1jS2LCUH66GwXIRhA=; b=i
	N31OgkfjcorPYzqyLEetJ4iq8JghTksc3iFN2rMmtVf2ho2EgaFE947oAMrFSLBe
	83u/7nrZpzwPZoPK4JkEfZegt2lsaX4aYsPCEQ9dYWS2Puy/Sr2kVFD30jtcELaR
	ExpP9OpPC5JGQLyQx1IeCmd75oV3GiD3orrC9G1kWEJkxxHrkfwcZDHjVVvZvnkM
	bTtN+QRgIhRa36SagGYQ/SHMAtxJ3Agl/a43p1/rZxHAdP5yZ+AnbTLc+YuOjet+
	d/oyXD4uYyyJNebXprjQsd6e7+r4krQLJsmquXhBnQrByd4sHfTt8GV6ZASCu4T1
	vfSsXEb9Dcneppkz3Sq4A==
X-ME-Sender: <xms:-AleaD_kQIdzG_ZKhMLepM7mxNcMW7shiaHcNUP4i9CWVHoVpH2COw>
    <xme:-AleaPvkuzdZI8gO455TJQCJD5HoMeqaLQ-XPBIcJRJJ_sVazBX9Qk1dwwfYh7uaB
    YT0q9ICp2Ku>
X-ME-Received: <xmr:-AleaBBZfkNz8jg9_ks-WSs_gJpGQ-Oh_w1rn17z79C66h2Wp-2br9Bl-Qj60rjgFC8bP1Yfmw8euPc-z4MYCI0fEn78Lb7sVWpFPfSJDmxnyuuYPcoCV3U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epkfffgggfuffhvfevfhgjtgfgsehtkeertddtvdejnecuhfhrohhmpefkrghnucfmvghn
    thcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepvefgvd
    ehhfevhfevgfegffejheetieegjefhjeefffeutdfhtdeikefhgfejjeejnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnhesthhhvg
    hmrgifrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtghpthhtoh
    eplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrggtkhessh
    hushgvrdgtiidprhgtphhtthhopehtohhrvhgrlhgusheslhhinhhugidqfhhouhhnuggr
    thhiohhnrdhorhhgpdhrtghpthhtohepvggsihgvuggvrhhmseigmhhishhsihhonhdrtg
    homh
X-ME-Proxy: <xmx:-AleaPe3c4D74kA-9Kr4sgRIpl5Q9tlqUtHyH418HbvCcQiFhrxyfA>
    <xmx:-AleaIMCha5ckmqr3wcfcttYBrCzaiWd-hE4cBizk2I0ifmgFEIAmQ>
    <xmx:-AleaBlgjjoGEBOzMhWqRSlX9BXgxq61Z6rRVNIVazV6J30hkPgL3Q>
    <xmx:-AleaCvynpA23vxzad0EYejM8F62iTAjPenXZvnvidD5FwD2vmeOIg>
    <xmx:-QleaDM0NFmBO3CVFSl0oecQx1-YO9uci45lUsNWatgQZPZsNL-9VMG5>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Jun 2025 23:03:18 -0400 (EDT)
Message-ID: <d459a74a-f46f-4411-ae49-b55ea0d7b766@themaw.net>
Date: Fri, 27 Jun 2025 11:03:14 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHES v2][RFC][CFR] mount-related stuff
From: Ian Kent <raven@themaw.net>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Linus Torvalds <torvalds@linux-foundation.org>,
 Eric Biederman <ebiederm@xmission.com>
References: <20250610081758.GE299672@ZenIV> <20250623044912.GA1248894@ZenIV>
 <93a5388a-3063-4aa2-8e77-6691c80d9974@themaw.net>
 <20250623185540.GH1880847@ZenIV>
 <45bb3590-7a6e-455c-bb99-71f21c6b2e6c@themaw.net>
 <20250625075733.GS1880847@ZenIV>
 <9b9e1ce4-bd58-4f67-933e-f28b6ff7d838@themaw.net>
Content-Language: en-US
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <9b9e1ce4-bd58-4f67-933e-f28b6ff7d838@themaw.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25/6/25 18:58, Ian Kent wrote:
> On 25/6/25 15:57, Al Viro wrote:
>> On Tue, Jun 24, 2025 at 02:48:53PM +0800, Ian Kent wrote:
>>
>>> +    for (p = mnt; p; p = next_mnt(p, mnt)) {
>>> +        unsigned int f = 0;
>>> +
>>> +        if (p->mnt_mountpoint != mnt->mnt.mnt_root) {
>> ???  The loop goes over everything mounted on mnt, no matter how
>> deep it is.  Do you mean "p is mounted on the root of its parent",
>> or is it "p is mounted on some mount of the same fs, with mountpoint
>> that just happens to be equal to root dentry of mnt (which may be
>> not the mount p is mounted on)"?
>
> I was trying to check if p is not covered but that's not what it does.
>
>
>>
>>> +        /* p is a covering mnt, need to check if p or any of its
>>> +         * children are in use. A reference to p is not held so
>>> +         * don't pass TREE_BUSY_REFERENCED to the propagation
>>> +         * helper.
>>> +         */
>> ... so for these you keep walking through the subtree on them (nevermind
>> that outer loop will walk it as well)...
>>
>>> +        for (q = p; q; q = next_mnt(q, p)) {
>>> +            if (propagate_mount_tree_busy(q, f)) {
>>> +                busy = true;
>>> +                break;
>>> +            }
>> ... and yet you still keep going in the outer loop?  Confused...
>
> Yes, I've not got this right at all.
>
>
>>>       }
>>>       unlock_mount_hash();
>>> +    up_read(&namespace_sem);
>>> + * count greater than the minimum reference count (ie. are in use).
>>> + */
>>> +int propagate_mount_tree_busy(struct mount *mnt, unsigned int flags)
>>> +{
>>> +    struct mount *m;
>>> +    struct mount *parent = mnt->mnt_parent;
>>> +    int refcnt = flags & TREE_BUSY_REFERENCED ? 2 : 1;
>>> +
>>> +    if (do_refcount_check(mnt, refcnt))
>>> +        return 1;
>>> +
>>> +    for (m = propagation_next(parent, parent); m;
>>> +            m = propagation_next(m, parent)) {
>>> +        struct mount *child;
>>> +
>>> +        child = __lookup_mnt(&m->mnt, mnt->mnt_mountpoint);
>>> +        if (!child)
>>> +            continue;
>>> +
>>> +        if (do_refcount_check(child, 1))
>>> +            return 1;
>>> +    }
>>> +    return 0;
>>> +}
>> What is the daemon expected to do with your subtree?  Take it apart with
>> a series of sync (== non-lazy) umount(2)?  I presume it is normal for
>> it to run into -EBUSY halfway through - i.e. get rid of some, but not
>> all of the subtree, right?
>
> All I need is to check if a mount and its children are in use, 
> essentially
>
> check if a mount subtree is in use in some way, working directory or open
>
> file(s).
>
>
> I think what I should be doing is very similar to what may_umount() 
> does but
>
> for the passed in mount and it's children with the adjustment for the 
> ref held
>
> on the passed in mount.
>
>
> I rather like your implementation of may_umount() and 
> propagate_mount_busy().
>
> I think the only difference to what I need is that the passed in mount 
> won't be
>
> the global root and will usually have children (so I'd invert that 
> list_empty()
>
> check or leave it out for this check).
>
>
> I'll have a go at that refactor and post it, we'll see if I can come 
> up with
>
> something acceptable.
>
>
> The other difficulty is that automount can be run in a separate mount 
> namespace
>
> (eg. a container) which introduces a special case environment. I'm not 
> sure how
>
> the propagation will behave in this case. Atm. I'm thinking it might 
> be sufficient
>
> to just use what may_umount_tree() is now so it deliberately only 
> checks the mount
>
> tree in it's own namespace.


So I clearly got this wrong so I've started over.

Unfortunately it looks like I have found a bug so I can get to the 
checking the propagation

slave behaviors I want to work on.


The "unshare -m" command will create a shell with a new mount namespace 
that is propagation

private.


If I mount something in the origin mount namespace and then run the 
unshare command it is

included in the new namespace.


But, with the series here, it looks like if I set my woring directory to 
this mount in the

new namespace and then umount the above mount in the origin namespace 
the umount gets propagated

to the created propagation private namespace and without regard for the 
process working directory.


The behavior in earlier kernels is the mount remains requiring it be 
umounted in the namespace

or be dissolved on namespace destruction.


Ian


