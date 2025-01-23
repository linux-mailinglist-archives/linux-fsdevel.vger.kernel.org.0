Return-Path: <linux-fsdevel+bounces-39967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1B5A1A78B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 17:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E20716A22F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 16:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06121369AA;
	Thu, 23 Jan 2025 16:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UguDqaHa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667E849625
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 16:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737648369; cv=none; b=mB96w0ylF+AT01AVVMerBaXPdVPOtUaZ/1vH+iTnbIYhjx8pHksqwGFy0PEhwGGDf9UDyZ4JFuOBzcbMQIF6eb4GLfDT6/zj2GRBWOmAvnBn/5iGSLd8rpxzdfO8TnlIMhdhwLHtE/boZOvA2d7H5ASXYmUjEemwkTF4mEvoBgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737648369; c=relaxed/simple;
	bh=GJUgJ2qE2qDZ51qhDQwIgAjoqzKDjjgckVPYpYUhXSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D+2oflYVANydgfcHP+oZ/JT0i87Vi8U6PY0ryovBdOfxjdHqPbdEdqgCtTwb5qL/HxQK0Be782T0CX6zTyBNorifJSMO1L2yD6KzuoDltS6WF6yCOl5g1YgmTuy0T9tYKsAZblOT8MvhaDT2nYazNFPfeCKcPYyZ/wgYJj/8fn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UguDqaHa; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d3f28a4fccso1694165a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 08:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737648366; x=1738253166; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b49FjlzRTIHc2Kzf+x/ZLcRxHdUv0/Ig2ZucLVqkp7A=;
        b=UguDqaHaaK6G+2KizONrmQXWYo+46kmbovP4YHXDuikFaXFVChQRjTJaykFm7WhvmP
         hzsXAQ+gorRKrXtBWw7k30xw6jbKdMpSfQSD/V8NQGJmqvt3b+hA3qOrO7+x2ncQXTIT
         ejdv6MKMxAx3zQqZ9MoKuP1TaOXYRKyfn/Tly5E8GDTnKxQQtnUfZ5iRPZ1rwC8wuUjf
         cZneXmAYhjo4KZKlc2+DmGsjkVn3swfi2pikiWxHUpetrovwlORk6VFz0vZ57G7tNk0d
         NbmpMCVaSpDiWQaz6IslSdfQEj7CIc6gP7g+ThpBl23hp71ZIquuDWCq+KDuu+V5pCef
         axUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737648366; x=1738253166;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b49FjlzRTIHc2Kzf+x/ZLcRxHdUv0/Ig2ZucLVqkp7A=;
        b=sSs79Sc7uRMCf8TwWi1vB2XPyWR2GQpwlMTHXM/J6gSNoKHF4fIn5DUoBcAqeyvYqa
         bdH66am+cvTyQJkvAm7qC++eIihTtHH3tF63UaVrUpawYhPx7prEbaW3SKZ9Xy6o4Z82
         Q76ATC2D9g+o0LyQgmOrAVUhgb+VZkXB2SwdiaoKJo4NJWjubAYKlpo/nHmpGmQ1FrU9
         UKaw9mbxMhhuoFJ6WcGLKWx5U/ZS0by9yKAeqbGbaeLbH56ZUCLAsj0lZldHD+TWDzgG
         LcxMPT7gzSWis4pQ3Kn3Ms6PAEUChLlqVRV4f5l56aiivonep+xFg4MRVSBazcCEGGxD
         sbxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjLD2eolduvFEAhQYC3c8NeO0xcwxJRbaWs0aPKvBBHTtSJq4LXTDNt/SD+ufAsAThDvgP3k1sT5JVDyHe@vger.kernel.org
X-Gm-Message-State: AOJu0YwpXWp8P8fsDgU9df7o1+mIaYpu+U/32TvYwmIelSh/cqEWlirQ
	PS0t09RbCGWTmA41V1FP5HFBwK2DKA4oEO5TUBWLqJYPxs5ItPTF
X-Gm-Gg: ASbGncu6d1UdKKhPFjjDeFR4oAad8GCmvaIk3HAzm1gMYtSkX8/mc/H0o2Pf1bHa4oU
	9q1JT+JhaLI74MrP2c+PKd6Mhpr5+mpQvkBWhscoPZG07BG6Aa/Vcd24BUxgkRbRdRFXfgn3P6T
	J6/TSmk0/ptAU8+1DKQo7oEiE23l8yB81k1E2nTPEnOxTF7ooitfXc+DJLKP8b4nL0RcIeARwcJ
	mtwOBtapbxwTLGhUazrZp4JJyhH+kxveFr3IpGIGloQudKINR+7+k2oTEPTx2AeNh/xqdY1TYfc
	P6hSKGcz5jD5zyrQ5PcWQW/VtbS3+s7vqSuy2A==
X-Google-Smtp-Source: AGHT+IHwOnHn/OPnmxw1hXAmG5orFUpWtoLHAXBjATbXD2GbMuYqg+O3YQ6DhE9VbQp9r//mO8NZBw==
X-Received: by 2002:a17:906:4fcb:b0:aa6:90a8:f5ff with SMTP id a640c23a62f3a-ab38b3fbfe3mr2625342766b.50.1737648365372;
        Thu, 23 Jan 2025 08:06:05 -0800 (PST)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:7d36])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384f860edsm1083325466b.137.2025.01.23.08.06.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 08:06:04 -0800 (PST)
Message-ID: <7eafdfb1-71d7-4724-9197-175fcc444456@gmail.com>
Date: Thu, 23 Jan 2025 16:06:36 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: Bernd Schubert <bernd.schubert@fastmail.fm>,
 Jeff Layton <jlayton@kernel.org>, Joanne Koong <joannelkoong@gmail.com>,
 Miklos Szeredi <miklos@szeredi.hu>
Cc: David Hildenbrand <david@redhat.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Zi Yan <ziy@nvidia.com>,
 linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com,
 josef@toxicpanda.com, linux-mm@kvack.org, kernel-team@meta.com,
 Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>,
 Michal Hocko <mhocko@kernel.org>, David Wei <dw@davidwei.uk>,
 Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@kernel.dk>
References: <hftauqdz22ujgkkgrf6jbpxuubfoms42kn5l5nuft3slfp7eaz@yy6uslmp37pn>
 <1fdc9d50-584c-45f4-9acd-3041d0b4b804@redhat.com>
 <54ebdef4205781d3351e4a38e5551046482dbba0.camel@kernel.org>
 <ccefea7b-88a5-4472-94cd-1e320bf90b44@redhat.com>
 <e3kipe2qcuuvyefnwpo4z5h4q5mwf2mmf6jy6g2whnceze3nsf@uid2mlj5qfog>
 <2848b566-3cae-4e89-916c-241508054402@redhat.com>
 <dfd5427e2b4434355dd75d5fbe2460a656aba94e.camel@kernel.org>
 <CAJfpegs_YMuyBGpSnNKo7bz8_s7cOwn2we+UwhUYBfjAqO4w+g@mail.gmail.com>
 <CAJfpeguSXf0tokOMjoOP-gnxoNHO33wTyiMXH5pQP8eqzj_R0g@mail.gmail.com>
 <060f4540-6790-4fe2-a4a5-f65693058ebf@fastmail.fm>
 <CAJfpegsrGX4oBHmRn_+8iwiMkJD_rcVEyPVH5tBAAByw4gSCQA@mail.gmail.com>
 <CAJnrk1ZP4yZZDR0fZghBmuN-N=JfrbJZALBH0pdaC5_gGWFwEw@mail.gmail.com>
 <CAJfpegvqZnMmgYcy28iDD_T=bFgeXgWD7ZZkpuJfXdBmjCK9hA@mail.gmail.com>
 <CAJnrk1Y14Xn8y2GLhGeVaistpX3ncTpkzSNBhDvN37v7YGSo4g@mail.gmail.com>
 <d5ffad60606fbf467af6c3b1aee3e5a59bd6c5a8.camel@kernel.org>
 <630dd043-6094-482a-9544-f4eb4202d1c2@fastmail.fm>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <630dd043-6094-482a-9544-f4eb4202d1c2@fastmail.fm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/14/25 21:40, Bernd Schubert wrote:
...
> My personal thinking regarding ZC was to hook into Mings work, I
> didn't into deep details but from interface point of view it sounded
> nice, like
> 
> - Application write
> - fuse-client/kernel request/CQEs with write attempts
> - fuse server prepares group SQE, group leader prepares
>    the write buffer, other group members are consumers
>    using their buffer part for the final destination
> - release of leader buffer when other group members
>    are done
> 
> 
> Though, Pavel and Jens have concerns and have a different suggestion
> and at least the example Pavel gave looks like splice

That's the same approach but with adjusted api, i.e. instead of caging
into groups it uses an io_uring private table, but in both cases one
request provides a buffer, subsequent requests do IO with that buffer.
And fwiw, it has nothing to do with pipes.
  > https://lore.kernel.org/all/f3a83b6a-c4b9-4933-998d-ebd1d09e3405@gmail.com/

That one is simple and easy to maintain, we can trivially pick it up
if needed.

> I think David is looking into a different ZC solution, but I
> don't have details on that.
> Maybe fuse-io-uring and ublk splice approach should be another LSFMM
> topic.

Unfortunately, I won't make it, but maybe Jens is planning to go.

-- 
Pavel Begunkov


