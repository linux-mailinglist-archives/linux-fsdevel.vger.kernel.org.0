Return-Path: <linux-fsdevel+bounces-42156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC93A3D586
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 10:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AC9B16C6A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 09:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8E51EFFA7;
	Thu, 20 Feb 2025 09:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QiaX2qhm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6095E1EE7C4
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2025 09:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045250; cv=none; b=U4IKaveE22eMz4Ltw1k5YgIu2dO7b8D/VUJqPpsvEcNL1mymzK8MKMo/wxELHnLmRN9BqSw/eAq7xW8aHVxLcZFlFdSET8HT2zKxIYABwffgHacT0m7/c4dIlN/Jhvi35yd+NqtGRkl/+UYGST0TAOrEql8kCmhg28yB7+cZrnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045250; c=relaxed/simple;
	bh=+VZRYVqIuwD7qh9ESBsfALtQS3D6YlY3oIdB/hY0f9s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ldGV2nLLvPOLuKTxNkoAg4u3odYcg1/IxHq6ULIcEBTEq0Q/vPGExeXO/vpS09bnpQRegzyC/Sg1LVBOQi/ze+VhIl5Ijgr8I6XP0kHIK/1sbT64JdkFpfLwmdA9ebF2KKOWVKhKpH51VZ8K2QjSiQ/MzI4BHbGmL5SQ81NZU/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QiaX2qhm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740045247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KejBM56aDgLmHo1KH1mgvdjJXqmeByoSUgLPzHmbYVk=;
	b=QiaX2qhm8gWCjUsMuzqMCV0E87TOf1tWqVCl7GgqrBwucqOYgmXy6u4TrnmbLAIHu93s0N
	i4VpTbBbMeaA8CwIpu04UdGTOIQu5VbAluNI5JTwYruzdskFaWvbM55ZpcnJiImRHxntBm
	GWQWj8kwb5BAnOTn2LR407/2XU2K4fY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-hQY9_Dz7OQWtYP_WvQaFiA-1; Thu,
 20 Feb 2025 04:54:03 -0500
X-MC-Unique: hQY9_Dz7OQWtYP_WvQaFiA-1
X-Mimecast-MFC-AGG-ID: hQY9_Dz7OQWtYP_WvQaFiA_1740045242
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C0FB2190F9E4;
	Thu, 20 Feb 2025 09:54:00 +0000 (UTC)
Received: from localhost (unknown [10.44.33.68])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 106251955BCB;
	Thu, 20 Feb 2025 09:53:59 +0000 (UTC)
From: Giuseppe Scrivano <gscrivan@redhat.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>,  Miklos Szeredi
 <mszeredi@redhat.com>,  linux-unionfs@vger.kernel.org,
  linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/5] ovl: make redirect/metacopy rejection consistent
In-Reply-To: <CAJfpegvUdaCeBcPPc_Qe6vK4ELz7NXWCxuDcVHLpbzZJazXsqA@mail.gmail.com>
	(Miklos Szeredi's message of "Wed, 12 Feb 2025 17:57:50 +0100")
References: <20250210194512.417339-1-mszeredi@redhat.com>
	<20250210194512.417339-3-mszeredi@redhat.com>
	<CAOQ4uxiqis6kawuv4pa6jxHYgpQPc18izFP8e0TORfA_mVu_-w@mail.gmail.com>
	<CAJfpegt=PWs8ZDF11p3nOCWHbWescE5nwVtUt82f=B6B+S0Miw@mail.gmail.com>
	<CAOQ4uxiQQV_O1MJgTksKycBjJ6Bneqc=CQbUoghvXc=8KEEsMg@mail.gmail.com>
	<CAJfpegsuN+C4YiA9PAuY3+-BJ959aSAaXTYBwKNCjEnhXVw0pg@mail.gmail.com>
	<CAOQ4uxjkBQP=x6+2YPYw4pCfaNy0=x48McLCMPJdEJYEb85f-A@mail.gmail.com>
	<CAJfpegvUdaCeBcPPc_Qe6vK4ELz7NXWCxuDcVHLpbzZJazXsqA@mail.gmail.com>
Date: Thu, 20 Feb 2025 10:53:58 +0100
Message-ID: <87a5ahdjrd.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Miklos Szeredi <miklos@szeredi.hu> writes:

> On Tue, 11 Feb 2025 at 16:52, Amir Goldstein <amir73il@gmail.com> wrote:
>
>> It sounds very complicated. Is that even possible?
>> Do we always know the path of the upper alias?
>> IIRC, the absolute redirect path in upper is not necessary
>> the absolute path where the origin is found.
>> e.g. if there are middle layer redirects of parents.
>
> Okay, it was a stupid idea.
>
>> > > Looking closer at ovl_maybe_validate_verity(), it's actually
>> > > worse - if you create an upper without metacopy above
>> > > a lower with metacopy, ovl_validate_verity() will only check
>> > > the metacopy xattr on metapath, which is the uppermost
>> > > and find no md5digest, so create an upper above a metacopy
>> > > lower is a way to avert verity check.
>> >
>> > I need to dig into how verity is supposed to work as I'm not seeing it
>> > clearly yet...
>> >
>>
>> The short version - for lazy data lookup we store the lowerdata
>> redirect absolute path in the ovl entry stack, but we do not store
>> the verity digest, we just store OVL_HAS_DIGEST inode flag if there
>> is a digest in metacopy xattr.
>>
>> If we store the digest from lookup time in ovl entry stack, your changes
>> may be easier.
>
> Sorry, I can't wrap my head around this issue.  Cc-ing Giuseppe.
>
>> > > So I think lookup code needs to disallow finding metacopy
>> > > in middle layer and need to enforce that also when upper is found
>> > > via index.
>> >
>> > That's the hard link case.  I.e. with metacopy=on,index=on it's
>> > possible that one link is metacopyied up, and the other one is then
>> > found through the index.  Metacopy *should* work in this case, no?
>> >
>>
>> Right. So I guess we only need to disallow uppermetacopy from
>> index when metacoy=off.

is that be safe from a user namespace?

Regards,
Giuseppe


