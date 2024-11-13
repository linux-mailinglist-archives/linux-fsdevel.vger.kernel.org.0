Return-Path: <linux-fsdevel+bounces-34637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9282E9C7053
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 14:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B704B34D5E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 13:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102791DF994;
	Wed, 13 Nov 2024 13:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=e43.eu header.i=@e43.eu header.b="lM9TGnpy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rgb4JjIc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48721433CE;
	Wed, 13 Nov 2024 13:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731503224; cv=none; b=NM27Z+kZDzmA7eAfOJMRnmQ1vtEKnSNjaDwROhvJpG/84vI546ieeh5VL08YOaPmEBFiXIVCI05zCLi28f1KXP322GzeGRLjaX64P8hJvIYme6KVjUa/HbHLK4/MuQCyNsznUZ+n8zXpQrzT0YkFaown9UqEwMq0jrk39QCiy/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731503224; c=relaxed/simple;
	bh=MZJMFdLbfj2d9uYoHT71yz+7ZbhL4j2Wakq234FiW5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YuUAwBtEAUoxm+4+NuSGlxaFby85ZcXzPond5bpW0iU0YG14pZYnMK7vW54B+IKEyNH9uptNfgXs8ARYXrKHVUQm3m55uDl7zXvjduVUcDL8/FPqRjkZj+X6+kBskfv3G7OsaYGgguCHuwicrm1fHwItqFw5Cd4vEml4a2gEWTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e43.eu; spf=pass smtp.mailfrom=e43.eu; dkim=pass (2048-bit key) header.d=e43.eu header.i=@e43.eu header.b=lM9TGnpy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rgb4JjIc; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e43.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e43.eu
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 4C40F11400D8;
	Wed, 13 Nov 2024 08:07:01 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 13 Nov 2024 08:07:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=e43.eu; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1731503221;
	 x=1731589621; bh=XTxnHJW8mR+NsXXS5qyTVOPc9MPa7KtgtkWNh0WnRtc=; b=
	lM9TGnpyNm7sMXTgM9CVAQFM+XE1uY5vz7faZi1V5efEY1aod9aXvCwmDGHLi8n1
	q1ejWvPT8EkSGvP0Nfhr73sz1Xh2EMgOlzIp4m6fCkfxNtK2d9l3Gs/IGuLAq/Ad
	0My5tCx0pLDAxwUi/PAbVWn6JLvUvvVcYjLeuCDn99wGZRkj2Wy+HDe5eGAPA3VE
	xJW6H6AcqK6dgk4d22DvYNnLB68So3t5HhKQttZVUz8jlcAD7Js7fhhc3YuksaKH
	XxhYoAGcLyAKKhRzB/B07JDnse0zko8ZJs6zmAzHrFA2fdpT2tpXByQskMK5pJY1
	HRTVqhpqXdBJObo1q4Zyqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731503221; x=
	1731589621; bh=XTxnHJW8mR+NsXXS5qyTVOPc9MPa7KtgtkWNh0WnRtc=; b=R
	gb4JjIcQy343TlZ817w8VPh+qr4hg3Y66xgQSsA5g+PuYOMISfzpDjYyVWHd1vaK
	w3GCvvWZLYpXZLg88iJGomm3ZFSctX3RSDO70Z5ATqLkxPxD8HkjfvGrH6kSLp3z
	vcQk2KcAPvzw7322mtx9RXlNgPiU3eZw8osuyNcqkARJVNyM2ldlE3xMVAIfVkIy
	qQ7AM3y8Z2Ggs9Kg04GK8RPS34Pf+sKeUfXyT3w1Wv9QJfn1vjPq4qv5k0Ih0Cxb
	RJ1kD+n8wiO/lXPSZ0i5emv2MtIc1IqojH7R9uKe9jUeWeRyB+Boix3qZ13E4m3p
	igvSvs6UfXNq5FZZJ6EQQ==
X-ME-Sender: <xms:dKQ0Z6fGh5Ga2DJn6YH2LkunWIgb1rSmjDQzWfMdURS8mv7R-YJZbg>
    <xme:dKQ0Z0O7My-pyApU1gSu2YhMs3xb4AKg6yWNUbY5zQrcQmW11HDGISBTlUqt6RPln
    XR9V58ENtEsJ0Tt44c>
X-ME-Received: <xmr:dKQ0Z7hFaUY8QX7ASBaW3llcG6B5wP-JgzP8Xxbh-UEz1XDtcFEPI78kqSi6rkEsTuxPAU4mowxH9CDYK-6I96FCnKqY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddtgdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeen
    ucfhrhhomhepgfhrihhnucfuhhgvphhhvghrugcuoegvrhhinhdrshhhvghphhgvrhguse
    gvgeefrdgvuheqnecuggftrfgrthhtvghrnhepjeeftdelheduueetjeehvdefhfefvddv
    ieekleejfeevffdtheduheejledvfedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepvghrihhnrdhshhgvphhhvghrugesvgegfedrvghupdhn
    sggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsrhgruh
    hnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvg
    hlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhes
    sghrrghunhgvrhdrihhopdhrtghpthhtohepphgruhhlsehprghulhdqmhhoohhrvgdrtg
    homhdprhgtphhtthhopegslhhutggrseguvggsihgrnhdrohhrgh
X-ME-Proxy: <xmx:dKQ0Z39r-alYs1-aidJV8ErGLUkBmeC8w1k_NIGSbxLEsN5tSSFnig>
    <xmx:dKQ0Z2ujHu1NhvtpsuFW4flXuMvjYC-12TesJtZVOhMERlSMq3KYuA>
    <xmx:dKQ0Z-FSaG4fx4XyAI2u7ir1_m0PVXxH0yt5Vw5C4BRAnQHeXQ6s5A>
    <xmx:dKQ0Z1MB67QUx7kym0bv6GiuQViM2eyEaxVwYGcG1LyMIoJdUUhYIw>
    <xmx:daQ0Z6gjIFJs81tfIs3E0Ide1xnShWbH4gSmMSySyhuDQHdR_WfQAHXS>
Feedback-ID: i313944f9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 08:06:59 -0500 (EST)
Message-ID: <65e22368-d4f8-45f5-adcb-4d8c297ae293@e43.eu>
Date: Wed, 13 Nov 2024 14:06:56 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] pidfs: implement fh_to_dentry
Content-Language: en-GB
To: Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 christian@brauner.io, paul@paul-moore.com, bluca@debian.org
References: <20241101135452.19359-1-erin.shepherd@e43.eu>
 <20241101135452.19359-5-erin.shepherd@e43.eu>
 <20241113-erlogen-aussehen-b75a9f8cb441@brauner>
From: Erin Shepherd <erin.shepherd@e43.eu>
In-Reply-To: <20241113-erlogen-aussehen-b75a9f8cb441@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/11/2024 13:09, Christian Brauner wrote:

> Hm, a pidfd comes in two flavours:
>
> (1) thread-group leader pidfd: pidfd_open(<pid>, 0)
> (2) thread pidfd:              pidfd_open(<pid>, PIDFD_THREAD)
>
> In your current scheme fid->pid = pid_nr(pid) means that you always
> encode a pidfs file handle for a thread pidfd no matter if the provided
> pidfd was a thread-group leader pidfd or a thread pidfd. This is very
> likely wrong as it means users that use a thread-group pidfd get a
> thread-specific pid back.
>
> I think we need to encode (1) and (2) in the pidfs file handle so users
> always get back the correct type of pidfd.
>
> That very likely means name_to_handle_at() needs to encode this into the
> pidfs file handle.

I guess a question here is whether a pidfd handle encodes a handle to a pid
in a specific mode, or just to a pid in general? The thought had occurred
to me while I was working on this initially, but I felt like perhaps treating
it as a property of the file descriptor in general was better.

Currently open_by_handle_at always returns a thread-group pidfd (since
PIDFD_THREAD) isn't set, regardless of what type of pidfd you passed to
name_to_handle_at. I had thought that PIDFD_THREAD/O_EXCL would have been
passed through to f->f_flags on the restored pidfd, but upon checking I see that
it gets filtered out in do_dentry_open.

I feel like leaving it up to the caller of open_by_handle_at might be better
(because they are probably better informed about whether they want poll() to
inform them of thread or process exit) but I could lean either way.

>> +static struct dentry *pidfs_fh_to_dentry(struct super_block *sb,
>> +					 struct fid *gen_fid,
>> +					 int fh_len, int fh_type)
>> +{
>> +	int ret;
>> +	struct path path;
>> +	struct pidfd_fid *fid = (struct pidfd_fid *)gen_fid;
>> +	struct pid *pid;
>> +
>> +	if (fh_type != FILEID_INO64_GEN || fh_len < PIDFD_FID_LEN)
>> +		return NULL;
>> +
>> +	pid = find_get_pid_ns(fid->pid, &init_pid_ns);
>> +	if (!pid || pid->ino != fid->ino || pid_vnr(pid) == 0) {
>> +		put_pid(pid);
>> +		return NULL;
>> +	}
> I think we can avoid the premature reference bump and do:
>
> scoped_guard(rcu) {
>         struct pid *pid;
>
> 	pid = find_pid_ns(fid->pid, &init_pid_ns);
> 	if (!pid)
> 		return NULL;
>
> 	/* Did the pid get recycled? */
> 	if (pid->ino != fid->ino)
> 		return NULL;
>
> 	/* Must be resolvable in the caller's pid namespace. */
> 	if (pid_vnr(pid) == 0)
> 		return NULL;
>
> 	/* Ok, this is the pid we want. */
> 	get_pid(pid);
> }

I can go with that if preferred. I was worried a bit about making the RCU
critical section too large, but of course I'm sure there are much larger
sections inside the kernel.

>> +
>> +	ret = path_from_stashed(&pid->stashed, pidfs_mnt, pid, &path);
>> +	if (ret < 0)
>> +		return ERR_PTR(ret);
>> +
>> +	mntput(path.mnt);
>> +	return path.dentry;
>>  }

Similarly here i should probably refactor this into dentry_from_stashed in
order to avoid a needless bump-then-drop of path.mnt's reference count


