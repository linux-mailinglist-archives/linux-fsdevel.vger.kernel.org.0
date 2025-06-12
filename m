Return-Path: <linux-fsdevel+bounces-51494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B95AD73BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 16:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 681891885BB8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 14:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E456A24BD0C;
	Thu, 12 Jun 2025 14:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f3STIfw0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60565146593
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jun 2025 14:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749737854; cv=none; b=SAz7eMnpdZ4uz15m4MOaLtr3HsrI57o5DDOInVPZU18BYk5hjnee9SGdjndVKnXD14KFguZQH9p9o3KE/PzQ4NidoHefLjYvEDRv7VpKCbKXc2NdGglf4Q5noyHypZNmBC+EpaLG6pzD5LJYR+6G2er2aOA8f0FF3pNlDkX+aaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749737854; c=relaxed/simple;
	bh=pv9cfHRqnSI0/wXWn49LAXKEJNNISKs3HhbGThQzmxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VjsxamnH3AubIUZ3Gnz2mDr3/FPtMYGWsvRufEdHfeHEzTqtDWZzrx/fgZQHFMZPR7u986fhRw18Rb3POCcqZiooIYFC5FJUpN3Nfa6AeupgRwq7PadgWP2uQr0o9LTA1sIAHzUQca0qgPZ5Xq/EBtFv7ar/6shYcGvEllwULbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f3STIfw0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749737851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yB/uUYoimKDAGyxop4yqaCFmze5RWxvmDd5eWQv1rHc=;
	b=f3STIfw03jRqKeZ8Ind8EwlBFYS3b9jyoIEiYEe8466VnjqQa05z7Eit8G3+LXyzWHvbhh
	T4JFlNgPiTSAC4C2Hs7J9W8aiio3g9oSw3fK42M/pS5IXQ2TstnuA3d+nAtnmzh8u9kMya
	4abM5lwdBqzgxMySydBjF/fjD4aDrUU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-UKEH77YcPrC-7DCS_qZzgw-1; Thu,
 12 Jun 2025 10:17:28 -0400
X-MC-Unique: UKEH77YcPrC-7DCS_qZzgw-1
X-Mimecast-MFC-AGG-ID: UKEH77YcPrC-7DCS_qZzgw_1749737847
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D871E19560BE;
	Thu, 12 Jun 2025 14:17:26 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.58.9])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA2A4195E340;
	Thu, 12 Jun 2025 14:17:24 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, Mike Snitzer <snitzer@kernel.org>,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>
Subject: Re: need SUNRPC TCP to receive into aligned pages [was: Re: [PATCH
 1/6] NFSD: add the ability to enable use of RWF_DONTCACHE for all IO]
Date: Thu, 12 Jun 2025 10:17:22 -0400
Message-ID: <5D9EA89B-A65F-40A1-B78F-547A42734FC2@redhat.com>
In-Reply-To: <d13ef7d6-0040-40ac-9761-922a1ec5d911@oracle.com>
References: <20250610205737.63343-1-snitzer@kernel.org>
 <20250610205737.63343-2-snitzer@kernel.org>
 <4b858fb1-25f6-457f-8908-67339e20318e@oracle.com>
 <aEnWhlXjzOmRfCJf@kernel.org>
 <7c48e17c4b575375069a4bd965f346499e66ac3a.camel@kernel.org>
 <aEn2-mYA3VDv-vB8@kernel.org>
 <110c7644b829ce158680979e6cd358193ea3f52b.camel@kernel.org>
 <d13ef7d6-0040-40ac-9761-922a1ec5d911@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 12 Jun 2025, at 9:28, Chuck Lever wrote:

> On 6/12/25 6:28 AM, Jeff Layton wrote:
>> On Wed, 2025-06-11 at 17:36 -0400, Mike Snitzer wrote:
>>> On Wed, Jun 11, 2025 at 04:29:58PM -0400, Jeff Layton wrote:
>>>> On Wed, 2025-06-11 at 15:18 -0400, Mike Snitzer wrote:
>>>>> On Wed, Jun 11, 2025 at 10:31:20AM -0400, Chuck Lever wrote:
>>>>>> On 6/10/25 4:57 PM, Mike Snitzer wrote:
>>>>>>> Add 'enable-dontcache' to NFSD's debugfs interface so that: Any data
>>>>>>> read or written by NFSD will either not be cached (thanks to O_DIRECT)
>>>>>>> or will be removed from the page cache upon completion (DONTCACHE).
>>>>>>
>>>>>> I thought we were going to do two switches: One for reads and one for
>>>>>> writes? I could be misremembering.
>>>>>
>>>>> We did discuss the possibility of doing that.  Still can-do if that's
>>>>> what you'd prefer.
>>>>>
>>>>
>>>> Having them as separate controls in debugfs is fine for
>>>> experimentation's sake, but I imagine we'll need to be all-in one way
>>>> or the other with a real interface.
>>>>
>>>> I think if we can crack the problem of receiving WRITE payloads into an
>>>> already-aligned buffer, then that becomes much more feasible. I think
>>>> that's a solveable problem.
>>>
>>> You'd immediately be my hero!  Let's get into it:
>>>
>>> In a previously reply to this thread you aptly detailed what I found
>>> out the hard way (with too much xdr_buf code review and tracing):
>>>
>>> On Wed, Jun 11, 2025 at 08:55:20AM -0400, Jeff Layton wrote:
>>>>>
>>>>> NFSD will also set RWF_DIRECT if a WRITE's IO is aligned relative to
>>>>> DIO alignment (both page and disk alignment).  This works quite well
>>>>> for aligned WRITE IO with SUNRPC's RDMA transport as-is, because it
>>>>> maps the WRITE payload into aligned pages. But more work is needed to
>>>>> be able to leverage O_DIRECT when SUNRPC's regular TCP transport is
>>>>> used. I spent quite a bit of time analyzing the existing xdr_buf code
>>>>> and NFSD's use of it.  Unfortunately, the WRITE payload gets stored in
>>>>> misaligned pages such that O_DIRECT isn't possible without a copy
>>>>> (completely defeating the point).  I'll reply to this cover letter to
>>>>> start a subthread to discuss how best to deal with misaligned write
>>>>> IO (by association with Hammerspace, I'm most interested in NFS v3).
>>>>>
>>>>
>>>> Tricky problem. svc_tcp_recvfrom() just slurps the whole RPC into the
>>>> rq_pages array. To get alignment right, you'd probably have to do the
>>>> receive in a much more piecemeal way.
>>>>
>>>> Basically, you'd need to decode as you receive chunks of the message,
>>>> and look out for WRITEs, and then set it up so that their payloads are
>>>> received with proper alignment.
>>>
>>> 1)
>>> Yes, and while I arrived at the same exact conclusion I was left with
>>> dread about the potential for "breaking too many eggs to make that
>>> tasty omelette".
>>>
>>> If you (or others) see a way forward to have SUNRPC TCP's XDR receive
>>> "inline" decode (rather than have the 2 stage process you covered
>>> above) that'd be fantastic.  Seems like really old tech-debt in SUNRPC
>>> from a time when such care about alignment of WRITE payload pages was
>>> completely off engineers' collective radar (owed to NFSD only using
>>> buffered IO I assume?).
>>>
>>> 2)
>>> One hack that I verified to work for READ and WRITE IO on my
>>> particular TCP testbed was to front-pad the first "head" page of the
>>> xdr_buf such that the WRITE payload started at the 2nd page of
>>> rq_pages.  So that looked like this hack for my usage:
>>>
>>> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
>>> index 8fc5b2b2d806..cf082a265261 100644
>>> --- a/net/sunrpc/svc_xprt.c
>>> +++ b/net/sunrpc/svc_xprt.c
>>> @@ -676,7 +676,9 @@ static bool svc_alloc_arg(struct svc_rqst *rqstp)
>>>
>>>         /* Make arg->head point to first page and arg->pages point to rest */
>>>         arg->head[0].iov_base = page_address(rqstp->rq_pages[0]);
>>> -       arg->head[0].iov_len = PAGE_SIZE;
>>> +       // FIXME: front-pad optimized to align TCP's WRITE payload
>>> +       // but may not be enough for other operations?
>>> +       arg->head[0].iov_len = 148;
>>>         arg->pages = rqstp->rq_pages + 1;
>>>         arg->page_base = 0;
>>>         /* save at least one page for response */
>>>
>>> That gut "but may not be enough for other operations?" comment proved
>>> to be prophetic.
>>>
>>> Sadly it went on to fail spectacularly for other ops (specifically
>>> READDIR and READDIRPLUS, probably others would too) because
>>> xdr_inline_decode() _really_ doesn't like going beyond the end of the
>>> xdr_buf's inline "head" page.  It could be that even if
>>> xdr_inline_decode() et al was "fixed" (which isn't for the faint of
>>> heart given xdr_buf's more complex nature) there will likely be other
>>> mole(s) that pop up.  And in addition, we'd be wasting space in the
>>> xdr_buf's head page (PAGE_SIZE-frontpad).  So I moved on from trying
>>> to see this frontpad hack through to completion.
>>>
>>> 3)
>>> Lastly, for completeness, I also mentioned briefly in a previous
>>> recent reply:
>>>
>>> On Wed, Jun 11, 2025 at 04:51:03PM -0400, Mike Snitzer wrote:
>>>> On Wed, Jun 11, 2025 at 11:44:29AM -0400, Jeff Layton wrote:
>>>>
>>>>> In any case, for now at least, unless you're using RDMA, it's going to
>>>>> end up falling back to buffered writes everywhere. The data is almost
>>>>> never going to be properly aligned coming in off the wire. That might
>>>>> be fixable though.
>>>>
>>>> Ben Coddington mentioned to me that soft-iwarp would allow use of RDMA
>>>> over TCP to workaround SUNRPC TCP's XDR handling always storing the
>>>> write payload in misaligned IO.  But that's purely a stop-gap
>>>> workaround, which needs testing (to see if soft-iwap negates the win
>>>> of using O_DIRECT, etc).
>>>
>>> (Ab)using soft-iwarp as the basis for easily getting page aligned TCP
>>> WRITE payloads seems pretty gross given we are chasing utmost
>>> performance, etc.
>>>
>>> All said, I welcome your sage advice and help on this effort to
>>> DIO-align SUNRPC TCP's WRITE payload pages.
>>>
>>> Thanks,
>>> Mike
>>
>> (Sent this to Mike only by accident yesterday -- resending to the full
>> list now)
>>
>> I've been looking over the code today. Basically, I think we need to
>> have svc_tcp_recvfrom() receive in phases. At a high level:
>>
>> 1/ receive the record marker (just like it does today)
>>
>> 2/ receive enough for the RPC header and then decode it.
>>
>> 3/ Use the rpc program and version from the decoded header to look up
>> the svc_program. Add an optional pg_tcp_recvfrom callback to that
>> structure that will receive the rest of the data into the buffer. If
>> pg_tcp_recvfrom isn't set, then just call svc_tcp_read_msg() like we do
>> today.
>
> The layering violations here are mind-blowing.

What's already been mentioned elsewhere, but not yet here:

The transmitter could always just tell the receiver where the data is, we'd
need an NFS v3.1 and an extension for v4.2?

Pot Stirred,
Ben


