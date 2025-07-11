Return-Path: <linux-fsdevel+bounces-54693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF741B02454
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 21:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C38BD1C45DB2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 19:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE872F2C79;
	Fri, 11 Jul 2025 19:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="TIbcL63m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="entiRvvW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E2421504E;
	Fri, 11 Jul 2025 19:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752261111; cv=none; b=F1a1FxkY39OBXT02ri+6Ni0ifrCSNi+hy7ksKKYPs+jaSUhGqMxpkCrOlJiiuvEIoeJptyr29CBml9bVPJ1CqBj28BhKJf/6yOP5ggv4XQDaoy1ED/u1axArQdeNLyAmL+EYy1y6IMmiudOrmPjyYp7mWWUSAKh3b+L1UADyaaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752261111; c=relaxed/simple;
	bh=IIg3URYmv6xWYI14i1THAS7URsoobYG/rgtasZkZ9OQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T+JpRTIAUiVlqEM8FW6AQwBvXSAnOoFDE37URY7EEa0593IVsGuvj+hu0BnTOSrtmxbwhOBZKvn+DNHUtMJLXpSA0p5aYqHS2gHx41DACtgShkXrqp9Y45Q4Ld3ewhfu7d/mDFR7Xqcps4N3WeZuI7BIDcACJ2dG/OKbCL2z0qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=TIbcL63m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=entiRvvW; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CE0DF14000BA;
	Fri, 11 Jul 2025 15:11:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 11 Jul 2025 15:11:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752261108;
	 x=1752347508; bh=zVqXbJMyuYU/2MbDexMJAmbazqSopFPwjDQCJvXjDSs=; b=
	TIbcL63m4VSaBnN3C60VDQT+NlcNNA6nunXsxXM63w+wHOsw5n5/Q4MQfTxbLKHG
	FMAegqxnvKYlt1t0FEkXZOTl7CVBMTPGhi9SJzzLETPWxGEmJeFYgP/+WwFzgAHi
	XjWTP0F3Sl1eKU69lNCU+4TU2IZv5BWZlP3/sIJJmHqbr4tBEeT9NcrQygJh4RHk
	e2f/pPcJ9Zt6iUL/rCQa2/UhDgQsARgetTVE2t6SZzZ8Is78o5x+8PV8gL2gEK2i
	GdoZaLu4ZwNgff4iNPnst9tY7GNPworsIdIMzigQEJ3Fzv+lKIPQu01DtfBEcTJJ
	3gGSsmiMKZIUBsu4iD9URA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752261108; x=
	1752347508; bh=zVqXbJMyuYU/2MbDexMJAmbazqSopFPwjDQCJvXjDSs=; b=e
	ntiRvvWup2vYHXmq1f5P/DM8XAlJcNZfTkbKTFTxU/Lygko0jcVWJDnp+i3mX6tR
	eIXjW90D7jlZjpwspusx32U1Cb/GfJ+UtD5hqIn4EiZj0UZKG/NFgDcuIlu6YLmO
	bjW5uDyHuFynPKJPEzbVv7p/lIXY8NgZ5BTHZN+NCvs+M4WStm8Bs3gF6dwxzzSf
	R+oPlTKl2NnxsRnWKgMMYBgYz63/dDMhqb4LzDVEE7cfcGqwJYbtnkthTzTe8i+S
	I6r0zPDd3FNUoBDep0q0kC4J0Dmu9Q7ilcroWAQAfZT4YXcEpvlcfPzFUUQZlH66
	Na/PX6JtXfSxWOVfGZ9bQ==
X-ME-Sender: <xms:82FxaES5_AN-I-b8mIybwkqLsJVN2yXB6B41vbZ1NYziHlIYEVE1MQ>
    <xme:82FxaASCKKOJUeCIcDNdOO11Hb6c7k8S2jzzn9MXXmGXSxHfaRlgGhoC-zupJisUw
    gMAuEp6HDX5IhH75p8>
X-ME-Received: <xmr:82FxaNUy3c62v67MiJCuOnpEG8q4XBjUH9c5CXUVJuGCxGA1r8sxLSjOmGcW0znT1YB9bc8_UsEoTs5b6LfwGHCb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeggeduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepvfhinhhgmhgr
    ohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeefvd
    ehleeutdfhlefgvedvgfeklefgleekgedtvdehvdfgtdefieelhfdutefgudenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmh
    drohhrghdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepvg
    hrihgtvhhhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrshhmrgguvghushestgho
    uggvfihrvggtkhdrohhrghdprhgtphhtthhopehluhgthhhosehiohhnkhhovhdrnhgvth
    dprhgtphhtthhopehlihhnuhigpghoshhssegtrhhuuggvsgihthgvrdgtohhmpdhrtghp
    thhtohepvhelfhhssehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepmhhitg
    esughighhikhhougdrnhgvthdprhgtphhtthhopehgnhhorggtkhesghhoohhglhgvrdgt
    ohhmpdhrtghpthhtoheplhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:82FxaCKWsUSLcdIxnvdy-hZo8ep_vf1iCNMrglKRCw9txHNRQKQH-w>
    <xmx:82FxaGj4t_CGr_kNoJy3SwyRAXsx0JdKJZOJSEOzRKzT97IcFX07DA>
    <xmx:82FxaHLFHToADESeSdAwu1LyemwAjPFZpVYWM2YM5XJLQfjaRpRN3Q>
    <xmx:82FxaFiSXuZY2Ki2KG282lPnaM-h1-gy8QUf0N3ZXyvxmNMatk3Xug>
    <xmx:9GFxaCDF018BJZDYmjfCR_IJjuN5VQfQs-kCHx1VZ-2sNGQb5fAFIXKy>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Jul 2025 15:11:45 -0400 (EDT)
Message-ID: <b32e2088-92c0-43e0-8c90-cb20d4567973@maowtm.org>
Date: Fri, 11 Jul 2025 20:11:44 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/6] fs/9p: Add ability to identify inode by path for
 .L
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Christian Schoenebeck <linux_oss@crudebyte.com>, v9fs@lists.linux.dev,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 linux-security-module@vger.kernel.org, Jan Kara <jack@suse.cz>,
 Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>,
 linux-fsdevel@vger.kernel.org
References: <cover.1743971855.git.m@maowtm.org>
 <e839a49e0673b12eb5a1ed2605a0a5267ff644db.1743971855.git.m@maowtm.org>
 <20250705002536.GW1880847@ZenIV>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20250705002536.GW1880847@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Al, thanks for the review :)  I haven't had the chance to properly
think about this until today, so apologies for the delay.

On 7/5/25 01:19, Al Viro wrote:
> On Sun, Apr 06, 2025 at 09:43:02PM +0100, Tingmao Wang wrote:
> 
>> +struct v9fs_ino_path *make_ino_path(struct dentry *dentry)
>> +{
>> +	struct v9fs_ino_path *path;
>> +	size_t path_components = 0;
>> +	struct dentry *curr = dentry;
>> +	ssize_t i;
>> +
>> +	lockdep_assert_held_read(&v9fs_dentry2v9ses(dentry)->rename_sem);
>> +
>> +	rcu_read_lock();
>> +
>> +    /* Don't include the root dentry */
>> +	while (curr->d_parent != curr) {
>> +		path_components++;
>> +		curr = curr->d_parent;
>> +	}
>> +	if (WARN_ON(path_components > SSIZE_MAX)) {

(Looking at this again I think this check is a bit bogus.  I don't know
how would it be possible at all for us to have > SSIZE_MAX deep
directories especially since each level requires a dentry allocation, but
even if this check is actually useful, it should be in the while loop,
before each path_components++)

>> +		rcu_read_unlock();
>> +		return NULL;
>> +	}
>> +
>> +	path = kmalloc(struct_size(path, names, path_components),
>> +		       GFP_KERNEL);
> 
> Blocking allocation under rcu_read_lock().

I think my first instinct of how to fix this, if the original code is
correct barring this allocation issue, would be to take rcu read lock
twice (first walk to calculate how much to allocate, then second walk to
actually take the snapshots).  We should be safe to rcu_read_unlock() in
the middle as long as caller has a reference to the target dentry (this
needs to be true even if we just do one rcu_read_lock() anyway), and we
can start a parent walk again.  The v9fs rename_sem should ensure we see
the same path again.

Alternatively, we can use dget_parent to do the walk, and not lock RCU at
all.  We still need to walk twice tho, to know how much to allocate.  But
for now I will keep the current approach.

New version:

/*
 * Must hold rename_sem due to traversing parents.  Caller must hold
 * reference to dentry.
 */
struct v9fs_ino_path *make_ino_path(struct dentry *dentry)
{
	struct v9fs_ino_path *path;
	size_t path_components = 0;
	struct dentry *curr = dentry;
	ssize_t i;

	lockdep_assert_held_read(&v9fs_dentry2v9ses(dentry)->rename_sem);
	might_sleep(); /* Allocation below might block */

	rcu_read_lock();

	/* Don't include the root dentry */
	while (curr->d_parent != curr) {
		if (WARN_ON(path_components >= SSIZE_MAX)) {
			rcu_read_unlock();
			return NULL;
		}
		path_components++;
		curr = curr->d_parent;
	}

	/*
	 * Allocation can block so don't do it in RCU (and because the
	 * allocation might be large, since name_snapshot leaves space for
	 * inline str, not worth trying GFP_ATOMIC)
	 */
	rcu_read_unlock();

	path = kmalloc(struct_size(path, names, path_components), GFP_KERNEL);
	if (!path) {
		rcu_read_unlock();
		return NULL;
	}

	path->nr_components = path_components;
	curr = dentry;

	rcu_read_lock();
	for (i = path_components - 1; i >= 0; i--) {
		take_dentry_name_snapshot(&path->names[i], curr);
		curr = curr->d_parent;
	}
	WARN_ON(curr != curr->d_parent);
	rcu_read_unlock();
	return path;
}

How does this look?

On 7/5/25 01:25, Al Viro wrote:
> On Sun, Apr 06, 2025 at 09:43:02PM +0100, Tingmao Wang wrote:
>> +bool ino_path_compare(struct v9fs_ino_path *ino_path,
>> +			     struct dentry *dentry)
>> +{
>> +	struct dentry *curr = dentry;
>> +	struct qstr *curr_name;
>> +	struct name_snapshot *compare;
>> +	ssize_t i;
>> +
>> +	lockdep_assert_held_read(&v9fs_dentry2v9ses(dentry)->rename_sem);
>> +
>> +	rcu_read_lock();
>> +	for (i = ino_path->nr_components - 1; i >= 0; i--) {
>> +		if (curr->d_parent == curr) {
>> +			/* We're supposed to have more components to walk */
>> +			rcu_read_unlock();
>> +			return false;
>> +		}
>> +		curr_name = &curr->d_name;
>> +		compare = &ino_path->names[i];
>> +		/*
>> +		 * We can't use hash_len because it is salted with the parent
>> +		 * dentry pointer.  We could make this faster by pre-computing our
>> +		 * own hashlen for compare and ino_path outside, probably.
>> +		 */
>> +		if (curr_name->len != compare->name.len) {
>> +			rcu_read_unlock();
>> +			return false;
>> +		}
>> +		if (strncmp(curr_name->name, compare->name.name,
>> +			    curr_name->len) != 0) {
> 
> ... without any kind of protection for curr_name.  Incidentally,
> what about rename()?  Not a cross-directory one, just one that
> changes the name of a subdirectory within the same parent?

As far as I can tell, in v9fs_vfs_rename, v9ses->rename_sem is taken for
both same-parent and different parent renames, so I think we're safe here
(and hopefully for any v9fs dentries, nobody should be causing d_name to
change except for ourselves when we call d_move in v9fs_vfs_rename?  If
yes then because we also take v9ses->rename_sem, in theory we should be
fine here...?)

(Let me know if I missed anything.  I'm assuming only the filesystem
"owning" a dentry should d_move/d_exchange the dentry.)

However, I see that there is a d_same_name function in dcache.c which is
slightly more careful (but still requires the caller to check the dentry
seqcount, which we do not need to because of the reasoning above), and in
hindsight I think that is probably the more proper way to do this
comparison (and will also handle case-insensitivity, although I've not
explored if this is applicable to 9pfs).

New version:

/*
 * Must hold rename_sem due to traversing parents
 */
bool ino_path_compare(struct v9fs_ino_path *ino_path, struct dentry *dentry)
{
	struct dentry *curr = dentry;
	struct name_snapshot *compare;
	ssize_t i;

	lockdep_assert_held_read(&v9fs_dentry2v9ses(dentry)->rename_sem);

	rcu_read_lock();
	for (i = ino_path->nr_components - 1; i >= 0; i--) {
		if (curr->d_parent == curr) {
			/* We're supposed to have more components to walk */
			rcu_read_unlock();
			return false;
		}
		compare = &ino_path->names[i];
		if (!d_same_name(curr, curr->d_parent, &compare->name)) {
			rcu_read_unlock();
			return false;
		}
		curr = curr->d_parent;
	}
	rcu_read_unlock();
	if (curr != curr->d_parent) {
		/* dentry is deeper than ino_path */
		return false;
	}
	return true;
}

If you think this is not enough, can you suggest what would be needed?
I'm thinking maybe we can check dentry seqcount to be safe, but from
earlier discussion in "bpf path iterator" my impression is that that is
VFS internal data - can we use it here (if needed)?

(I assume, from looking at the code, just having a reference does not
prevent d_name from changing)


