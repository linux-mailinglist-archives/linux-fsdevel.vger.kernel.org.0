Return-Path: <linux-fsdevel+bounces-77637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJU2MqRBlmkHdAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 23:48:04 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBE315AAE5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 23:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 122DE3032CC9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 22:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D3A337BBA;
	Wed, 18 Feb 2026 22:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RpOES2uA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PxG+qqEH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC75335546
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 22:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771454879; cv=none; b=c0qHu7bB7b5WvX9t3Q45daAMx0ZyeKMYrpYw635DKmGcQNS+k8TL25Kxl8fnXdu+Jr0MGi7uvqGWSMBhXFZIGteUTP2IThwmzVDgqUOseK9yr4dLQVZDFLv4zdnIH09n+ciSPg0H28CDd1xwS5WKXKL6nEOXhxweh7ygpoQ4XtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771454879; c=relaxed/simple;
	bh=kRCHYz0Xd0NnTIoK9UqQX2Oo5RQJElwvY2aC6aZu/4g=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=uZ6qyXFj6RubAabxRh4FtCnIMnmL88OgzoK7V2LPmOgg8JN9Sa+sB9Dcivsh/WMoo3q6tSHo8SlFfmssXsaCJ8rk9jy/YHLSVMALAU1bur+WgsMjcJn3SnSxA7JVVUDe2iHShE+c6mCuWPujdr66Yteewa1n+cjSEjzP18W790Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RpOES2uA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PxG+qqEH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771454877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oshiPuz5QWA4k8XAtwqJ3emvRiyyYfl/NwESTnGQ8+M=;
	b=RpOES2uAypojXOfW2SGjYoMWpWRKps/rMiAlKD92z+/GENHipElv4vqH1wkKODS/8vvBWC
	TsNrbnl/NI/BkSd5gKDKxwwoCsifYJDQ8GBaT8XraItWRhcr1D7+HIvBdT5Ing5ixBK4l4
	QNNYW0c8KdDgQ34DDhqAJEUBGcHzC7k=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-5uFRVZMQNQi7E4IvFn6u2w-1; Wed, 18 Feb 2026 17:47:55 -0500
X-MC-Unique: 5uFRVZMQNQi7E4IvFn6u2w-1
X-Mimecast-MFC-AGG-ID: 5uFRVZMQNQi7E4IvFn6u2w_1771454875
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-89546cbb998so28047746d6.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 14:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771454875; x=1772059675; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oshiPuz5QWA4k8XAtwqJ3emvRiyyYfl/NwESTnGQ8+M=;
        b=PxG+qqEHzTagmAlAe3HuLdqerd1m56u8hhNODA6hlb/mh80DqzfhYDed9HgfjHStoc
         T0B/xmNNQ+ZbOKIPwlP8cWog6mIQfVkVyHN/bslolcWMzZCllWFWpmRLt0WdIND1YOmb
         gn4+pN2X/VdteExAdCdkZWLlSly+1UIFXuSjoW+uYXuyAH4tZd5hRMPpBRR4WRaeVpgl
         vAYwQ60B3u8jR0CYNAi9AdyTahZSUgmkJPoVC3s+QbDlrfWGSBEp+Cttljw427++eogz
         JnpDl3S1/OLmtHGGQdD1o5RKxw7xmTBSiXeLp2VhsmlXGbvPGlTFEuHFZyorfJ0Q9lBl
         Q2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771454875; x=1772059675;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oshiPuz5QWA4k8XAtwqJ3emvRiyyYfl/NwESTnGQ8+M=;
        b=pS1wq2P/bMM9vIfOC8o7TCbJsDDSLp4pSm2fHDikaDLrZg08YRImtyohV14VxCEQl7
         H352mOiAJ5OhHFxvChuJxDkwOVabymgnlv0yAsxB8xDhiO49+ji4chgAQas7ZETrXWZz
         +9LWlDmOGuwV29xQHuJxNQJQfInQya8gcBpMrQmRRcPjQkuA6ZI+he1vZH4yjwgVouBU
         mxlMbHc+6Lzu46zaKQa2bAwFNTZe4NI9NyZIVWggHsuO1R53gVeFwPIHFbk5c+uXVeI3
         fH+s6nRJdMmrXvcN5dfmktPSjaLDxLJga5AIQMANqujQntCMocEwyJETCx8CoEJzqa3c
         vMpw==
X-Forwarded-Encrypted: i=1; AJvYcCVXh8hsZugB8gceOZvAEBwAaSYjhlEKgOiOgqfZWmMuXPlngGkYGF7EGmdH3kVOLQRCfV4RywrgzgVbnFMl@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0fN0TInix8Dr2D/7HTmbAr4wlaceZp0m1lfB1hEPRFDNvTi/h
	bmJWt9xEw9/i+HExGosaAFUgXkk+xPtI8vQHmzbmdOXOfV+cw4rbIkTVaTSAE7lqD5UxPS9e66H
	OBwtNzo50x/1WRQ+/6XAk4E6fZlNJZrC9evdmipbdjv/II1DZdxSW1BZgTJCuDXLDQv8=
X-Gm-Gg: AZuq6aIYGGEwuHexEHSWOOKUeu8XKxNSYI77xEaMxXBSDwOE1dTTrg2vxD99858MxgG
	ra/sS/ff5dghdWUdss+y2FyTIyOVH5SuYiPhNdsJpvQxs1zfj5mtqqWlSlk9wTTHVfHrByYUzEo
	tJxvaJfoIzSYggBfv/hLhezYmjiLuMUBntNnVjrU+uQzr4oLZU6YhSH8gUJptPaWnhJzpp/lAug
	rvj4Dcx9YAgXwdKu/FDp0PWd8tIcd3Nn9rQdyyMXA4an4pr/JI53Eph5BB+CMi99HMWnKxecZOD
	NkP7hVsXceiSUW6jAy0qMvcIofXxC9pX2g/BPrga3qw4it798wQpSSteiHbebcR5N6xFVZCdDGO
	XV3C17yOr+4ZtYYEMDJ66XnH/c7V02UHHSIL49Pz98R2X7raxtInDynXZCdNukWWT5ySc
X-Received: by 2002:a05:6214:2a47:b0:896:f97c:2f83 with SMTP id 6a1803df08f44-89734916acemr287995546d6.33.1771454875264;
        Wed, 18 Feb 2026 14:47:55 -0800 (PST)
X-Received: by 2002:a05:6214:2a47:b0:896:f97c:2f83 with SMTP id 6a1803df08f44-89734916acemr287995356d6.33.1771454874917;
        Wed, 18 Feb 2026 14:47:54 -0800 (PST)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cd8d1e8sm260088336d6.24.2026.02.18.14.47.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Feb 2026 14:47:54 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <1aab1afa-d23b-40c6-8e56-a6314fa728dc@redhat.com>
Date: Wed, 18 Feb 2026 17:47:52 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/1] rwsem: Shrink rwsem by one pointer
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 linux-kernel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, Christoph Hellwig <hch@infradead.org>,
 linux-fsdevel@vger.kernel.org
References: <20260217190835.1151964-1-willy@infradead.org>
 <20260217190835.1151964-2-willy@infradead.org>
Content-Language: en-US
In-Reply-To: <20260217190835.1151964-2-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-77637-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,kernel.org,gmail.com,vger.kernel.org,linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[llong@redhat.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1FBE315AAE5
X-Rspamd-Action: no action

On 2/17/26 2:08 PM, Matthew Wilcox (Oracle) wrote:
> Instead of embedding a list_head in struct rw_semaphore, store a pointer
> to the first waiter.  The list of waiters remains a doubly linked list
> so we can efficiently add to the tail of the list, remove from the front
> (or middle) of the list.
>
> Some of the list manipulation becomes more complicated, but it's a
> reasonable tradeoff on the slow paths to shrink some core data structures
> like struct inode.

If the goal is to use only one pointer for the rwsem structure, would it 
make sense to change list_head to hlist_head for instance? At least we 
have existing helpers that can be used instead of making our own coding 
convention here.

Cheers,
Longman


