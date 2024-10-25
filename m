Return-Path: <linux-fsdevel+bounces-32879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B969B0179
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 13:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C4C71F2298B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 11:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEAC201026;
	Fri, 25 Oct 2024 11:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iik2Qg6U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D161B2188;
	Fri, 25 Oct 2024 11:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729856408; cv=none; b=NwPBG/fP1LRw1RzTR6D5wytSQ0lt9sVLuN5i9FS50EwZFOEZxMH8uwagzl3Oal27vcFlr64tf4D5gesn0l8IL0L4/d3hJQOsnvJ7ly86jza4tkY1nv/VyIknuzNMEIBaV+EwmnBBChzLf+cofdjc0Sh6mzDSg6HuKLFJusgLgMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729856408; c=relaxed/simple;
	bh=fur9jKAR9Lb/bZRjB6AmqRM0k4fPKhiKa1ITzOgw5AQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=SR7bmNHvTVolyuEMJBKKme4QmS6yPn2EZj+oVLvr0yWIWmAjwD7z7aSF7G9pefe4khFEhsoDgQ2ABEgfFoyoLbICmGdxR12+Z4/B8/kKywCfK9RIL368JeAZS/6RV4UPYC8XF7R5+rLHh8fsd/ByPKVt04c/eDLELTy6L/LRqVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iik2Qg6U; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20cdda5cfb6so16944445ad.3;
        Fri, 25 Oct 2024 04:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729856405; x=1730461205; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/odYXUmRFVxj1YAIb6jJQzkELhw4AM9pvz8h7Ed9TCQ=;
        b=Iik2Qg6UtVnv+Y9ldfmQnppPpb3SQ428wnjrHekwWglOPX3v34dgXj/c9/t2C7JL9Z
         mNaJDSfh1mQZPBBn5pEMszJDgk5z1qohA1Ty9IQSYEcREixzqCr9gLn/aeMwkKUB5lmE
         PP6lEE7y3VXBiRe80aBsPvBKVfeAcRn9yGk+fRRK6Xl0Pu+72NFDsrGLOLneMmvS4mNu
         qLJmRraEe3LkPOS5raYgGsns7ocz4uR5ywyJGW83WUTmOo1tpu4q4a/QrLgRJjiiUICk
         kSWAnmSXAXsMtWNqa/TRxHLo8DkSnt0Z04ZYmpcIR40m/eW+6tHliXKowOXV/fJIcT8f
         5Tag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729856405; x=1730461205;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/odYXUmRFVxj1YAIb6jJQzkELhw4AM9pvz8h7Ed9TCQ=;
        b=bX9TKpO74HG4J5CywCav5WEy3rm4hPTKgOzrCajdeV8BY4w9wH35rhUq4AKyCFfVwV
         zcf29IxUoAkGBtk+Bi3l9ecEIw0ip6cPiy6T2KmlJoRmwqpx1hIdYwr9x6Andi3S/Nmv
         RkPTuCZprEoEUapdpIh2WaFs3Q+xpOu+3S9inJCUGbboWn5mHwaACJA5JbrZnMI3AjiH
         fOJnf5NO2cbPhfuuCT3EZ80rCGduXUZyWm7yJKQh01Rid0DmSGYU7k8c15aezq93jPuv
         Xk8pLUsF5peAxuY1NV0WrHDJxVD81q3BH2hodNZsX9iVtEihSNEuagDq3oF+HyXG6DNa
         eb/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUFuU7s26NKqTj0VSiFCcx+R66Ak1BGbLUsD7mJvop4PSKSGLE8YP5BsYSxLQA4/qgjriRrzzGpSnYb@vger.kernel.org, AJvYcCUGPnwVdssH8GrM9eLNdDZVrdLmF6CIW0BVMuU4JrxNAocc09ZvLhJ9rel7ayISqS55pmKusuxRHQMYmRNx@vger.kernel.org, AJvYcCV0GO8dsI3L1+UiHuesYFJb1SPabEFAM0iqcibv6NU8ulhgehJVlI0m4NXxj08RqohZW1uRrM2Y4lTv@vger.kernel.org, AJvYcCWLSeyzcOwnwHDQxXxOdoQvLA72ZSrtXWwgKy2Y2l47k0gWVfj+WQM1S4otVD05hatAFcVOKwaDMIZMSDMw7A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7yE3edynKnYN3qyOcjTT8wXha697k6QUqHTeAWM8W/C05OUnh
	VZBoFooJiqC91AZZJZ1nmFg8NBftG1KePjp6+y9odhI+vRGG1sbzrVYEFA==
X-Google-Smtp-Source: AGHT+IGZkHAl3P77GpfZG69NdPzPaI+hK8rshv9qxUxYrl3QrlbN3uIpkEUU1JzBvDjnKGwjWMfntw==
X-Received: by 2002:a17:902:f68a:b0:20c:80d9:9982 with SMTP id d9443c01a7336-20fa9eb9761mr131474915ad.47.1729856405328;
        Fri, 25 Oct 2024 04:40:05 -0700 (PDT)
Received: from dw-tp ([171.76.85.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc01784dsm7975255ad.177.2024.10.25.04.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 04:40:04 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: John Garry <john.g.garry@oracle.com>, linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>, "Darrick J . Wong" <djwong@kernel.org>, Christoph Hellwig <hch@infradead.org>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/6] iomap: Lift blocksize restriction on atomic writes
In-Reply-To: <7e322989-c6e0-424a-94bd-3ad6ce5ffee9@oracle.com>
Date: Fri, 25 Oct 2024 16:49:27 +0530
Message-ID: <87ttd0mnuo.fsf@gmail.com>
References: <cover.1729825985.git.ritesh.list@gmail.com> <f5bd55d32031b49bdd9e2c6d073787d1ac4b6d78.1729825985.git.ritesh.list@gmail.com> <1efb8d6d-ba2e-499d-abc5-e4f9a1e54e89@oracle.com> <87zfmsmsvc.fsf@gmail.com> <fc6fddee-2707-4cca-b0b7-983c8dd17e16@oracle.com> <87v7xgmpwo.fsf@gmail.com> <7e322989-c6e0-424a-94bd-3ad6ce5ffee9@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

John Garry <john.g.garry@oracle.com> writes:

> On 25/10/2024 11:35, Ritesh Harjani (IBM) wrote:
>>>> Same as mentioned above. We can't have atomic writes to get split.
>>>> This patch is just lifting the restriction of iomap to allow more than
>>>> blocksize but the mapped length should still meet iter->len, as
>>>> otherwise the writes can get split.
>>> Sure, I get this. But I wonder why would we be getting multiple
>>> mappings? Why cannot the FS always provide a single mapping?
>> FS can decide to split the mappings when it couldn't allocate a single
>> large mapping of the requested length. Could be due to -
>> - already allocated extent followed by EOF,
>> - already allocated extent followed by a hole
>> - already mapped extent followed by an extent of different type (e.g. written followed by unwritten or unwritten followed by written)
>
> This is the sort of scenario which I am concerned with. This issue has 
> been discussed at length for XFS forcealign support for atomic writes.

extsize and forcealign is being worked for ext4 as well where we can
add such support, sure.

>
> So far, the user can atomic write a single FS block regardless of 
> whether the extent in which it would be part of is in written or 
> unwritten state.
>
> Now the rule will be to write multiple FS blocks atomically, all blocks 
> need to be in same written or unwritten state.

FS needs to ensure that the writes does not get torned. So for whatever reason
FS splits the mapping then we need to return an -EINVAL error to not
allow such writes to get torned. This patch just does that.

But I get your point. More below.

>
> This oddity at least needs to be documented.

Got it. Yes, we can do that.

>
> Better yet would be to not have this restriction.
>

I haven't thought of a clever way where we don't have to zero out the
rest of the unwritten mapping. With ext4 bigalloc since the entire
cluster is anyway reserved - I was thinking if we can come up with a
clever way for doing atomic writes to the entire user requested size w/o
zeroing out.

Zeroing out the other unwritten extent is also a cost penalty to the
user anyways. So user will anyway will have to be made aware of not to
attempt writes of fashion which can cause them such penalties. 

As patch-6 mentions this is a base support for bs = ps systems for
enabling atomic writes using bigalloc. For now we return -EINVAL when we
can't allocate a continuous user requested mapping which means it won't
support operations of types 8k followed by 16k.

We can document this behavior as other things are documented for atomic
writes on ext4 with bigalloc e.g. pow_of_2 length writes, natural
alignment w.r.t pos and length etc.

Does that sound ok?

>> - delalloc (not delalloc since we invalidate respective page cache pages before doing DIO).
>> - fragmentation or ENOSPC - For ext4 bigalloc this will not happen since
>> we reserve the entire cluster. So we know there should be space. But I
>> am not sure how other filesystems might end up implementing this functionality.
>
> Thanks,
> John

-ritesh

