Return-Path: <linux-fsdevel+bounces-60395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0F9B46629
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 23:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 338F5A405A7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 21:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317942EF673;
	Fri,  5 Sep 2025 21:50:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from swift.blarg.de (swift.blarg.de [138.201.185.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8535422129B;
	Fri,  5 Sep 2025 21:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.201.185.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757109038; cv=none; b=f7hAQh2UTHXxl1gSSa/E0ALuVmc8rqmP4no0/FBBHhdlwP9n8ClJ2Tmbwp8WcUQd2zyrhAYXRvSuB9yGpYdRNbt7K1j72YkVlqTDI2SDrQ0qq90oWQS0RtQ7HKnFkTDnBF7aU0FoVV8O4pBkG4xkWuilfLHpMdADIpHDBOfQgqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757109038; c=relaxed/simple;
	bh=ZDFZijTwvgM6et+oHqMpWt2nF4R/mLDt/L9xrb17Mec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XF5e3bLudIOWSNcawz1tiPVa7+TMKsGqeAm8tklKVEl6DXqpV9zHVdWIuLrIkc+NucO5A+m62EA6gYx5DeBgLoHqJpq+qMBwrN2GtRsX7uGTj2QzkdSDr/HDXTL+TSKC+TiuUo1925q+KAY60rRUqiVUpe+WrewPjwzfUccXcnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blarg.de; spf=pass smtp.mailfrom=blarg.de; arc=none smtp.client-ip=138.201.185.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blarg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blarg.de
Received: from swift.blarg.de (swift.blarg.de [IPv6:2a01:4f8:c17:52a8::2])
	(Authenticated sender: max)
	by swift.blarg.de (Postfix) with ESMTPSA id C7A8C40C96;
	Fri,  5 Sep 2025 23:50:33 +0200 (CEST)
Date: Fri, 5 Sep 2025 23:50:32 +0200
From: Max Kellermann <max@blarg.de>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com,
	amarkuze@redhat.com, Slava.Dubeyko@ibm.com, vdubeyko@redhat.com
Subject: Re: [RFC PATCH 01/20] ceph: add comments to metadata structures in
 auth.h
Message-ID: <aLtbKDnpS_Fymd7h@swift.blarg.de>
References: <20250905200108.151563-1-slava@dubeyko.com>
 <20250905200108.151563-2-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905200108.151563-2-slava@dubeyko.com>

On 2025/09/05 22:00, Viacheslav Dubeyko <slava@dubeyko.com> wrote:
> +	/* Sign outgoing messages using session keys */
>  	int (*sign_message)(struct ceph_auth_handshake *auth,
>  			    struct ceph_msg *msg);
> +	/* Verify signatures on incoming messages */
>  	int (*check_message_signature)(struct ceph_auth_handshake *auth,
>  				       struct ceph_msg *msg);

No, this function does not verify the signatureS of incoming messageS
(two plurals).
It verifies one signature of one message.

Same mistake on sign_message.

Apart from these plurals, the text barely adds any value because this
is obvious enough from the names.  What would really have been helpful
would be an explanation of parameters and return values.  But I guess
Claude didn't know...  and fortunately didn't hallucinate anything.

> +	/* Preferred connection security mode */
> +	int preferred_mode;
> +	/* Fallback connection security mode */
> +	int fallback_mode;

You have removed important information from the old comment about what
kinds of values are expected here.

> +	/* Protects concurrent access to auth state */
>  	struct mutex mutex;

What is "auth state"?  What exactly is being protected?  Does "auth
state" mean all fields of this struct are being protected?  I guess
Claude didn't know so it just wrote some generic text devoid of
information.

