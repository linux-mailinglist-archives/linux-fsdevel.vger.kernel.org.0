Return-Path: <linux-fsdevel+bounces-35974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8162F9DA78F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 13:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F314B239BF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 11:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2FF1F9EB4;
	Wed, 27 Nov 2024 11:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b2R4VYZh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636E51F9EAD
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Nov 2024 11:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732708560; cv=none; b=nahLYTeZVRMq0zoHmoT4JtbsSQBlAXKdhjyOjt5GHQ4jPY0dKrmrI902QiPe+DiBdR0CzVo1dKiIFhyhihzEj7YdxF80FOlaK9HfzuFCJ42OB12fLvI9c4gpMvxiUD4bLJTEGEWBBAyktHTeE8+7wlTNtuNlrKtXhvPJk05avFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732708560; c=relaxed/simple;
	bh=AS0fqCpZez9MQZoP17NfqIvBNcLyWvTeUem59mtncb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIlDd1cF2+3MOwdPmdBOdBrvj+De20/1e/rLunAjIrIvCHOJDenZjaZaBRzQ6dl00ILq2mLRloQfEqEMZCJkqK2BiyCvsDuL1nCJFPJ0cjwqnqpwD6I+3/M1hnjlTEcosrCoOWLwcVZQO9aShrxVisEaYBYICBumrcV7hp3XeWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b2R4VYZh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732708557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EAuGY7uo2VzmKZwEMUSolagvh7kfqhqchgraIgCqyKk=;
	b=b2R4VYZhvRhzdlMCn8Nd+BnqifvNjdTBGDKFMxHCemeUjN6NqdMgfVlYLVONc+XqgjQ8kD
	djT7GMAgEjyLGokd69Klj304GYagV9NysgoXt71YQ4Rz23QjY6f/8VL62GkBMJ1IrQHxmu
	etHDuv3+FHuN1NggVgfDdB9FFQJEqJo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-IvGzQ0E8Nua4bG8MX5F6qA-1; Wed,
 27 Nov 2024 06:55:55 -0500
X-MC-Unique: IvGzQ0E8Nua4bG8MX5F6qA-1
X-Mimecast-MFC-AGG-ID: IvGzQ0E8Nua4bG8MX5F6qA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C0B9B19560BD;
	Wed, 27 Nov 2024 11:55:53 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.12])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 194B11956086;
	Wed, 27 Nov 2024 11:55:50 +0000 (UTC)
Date: Wed, 27 Nov 2024 12:55:47 +0100
From: Karel Zak <kzak@redhat.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Hongbo Li <lihongbo22@huawei.com>, linux-um@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Benjamin Berg <benjamin@sipsolutions.net>, rrs@debian.org
Subject: Re: UML mount failure with Linux 6.11
Message-ID: <dywzjfeburew25fitcwspay7i4ckynhehpuvtmsi2k6b4ip7wd@xfcbztze47q6>
References: <0ce95bbf-5e83-44a3-8d1a-b8c61141c0a7@huawei.com>
 <420d651a262e62a15d28d9b28a8dbc503fec5677.camel@sipsolutions.net>
 <f562158e-a113-4272-8be7-69b66a3ac343@huawei.com>
 <ac1b8ddd62ab22e6311ddba0c07c65b389a1c5df.camel@sipsolutions.net>
 <b0acfbdf-339b-4f7b-9fbd-8d864217366b@huawei.com>
 <buizu3navazyzdg23dsphmdi26iuf5mothe3l4ods4rbqwqfnh@rgnqbq7n4j4g>
 <9f56df34-68d4-4cb1-9b47-b8669b16ed28@huawei.com>
 <3d5e772c-7f13-4557-82ff-73e29a501466@huawei.com>
 <ykwlncqgbsv7xilipxjs2xoxjpkdhss4gb5tssah7pjd76iqxf@o2vkkrjh2mgd>
 <6e6ccc76005d8c53370d8bdcb0e520e10b2b7193.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e6ccc76005d8c53370d8bdcb0e520e10b2b7193.camel@sipsolutions.net>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Tue, Nov 26, 2024 at 02:50:38PM GMT, Johannes Berg wrote:
> On Mon, 2024-11-25 at 18:43 +0100, Karel Zak wrote:
> > 
> > The long-term solution would be to clean up hostfs and use named
> > variables, such as "mount -t hostfs none -o 'path="/home/hostfs"'.
> 
> That's what Hongbo's commit *did*, afaict, but it is a regression.
> 
> Now most of the regression is that with fsconfig() call it was no longer
> possible to specify a bare folder, and then we got discussing what
> happens if the folder name actually contains a comma...
> 
> But this is still a regression, so we need to figure out what to do
> short term?

I will add support for quotes for unnamed options, so that
"/home/hostfs,dir" will be treated as a single option for libmount.

I am unsure how to resolve this issue without using quotes, as we need
a method to distinguish between a path with a comma and other options.

> Ignoring the "path with comma" issue, because we can't even fix that in
> the kernel given what you describe changed in userspace, we can probably
> only
> 
>  1) revert the hostfs conversion to the new API, or
>  2) somehow not require the hostfs= key?

The hostfs= key is likely the most reliable method to use fsconfig().
The goal should be to get from userspace:

    fsconfig(fs, FSCONFIG_SET_STRING, "hostfs", "/home/hostfs,dir");

I can add a temporary workaround to libmount for hostfs, which will
automatically add the hostfs= key for unnamed paths. This will allow
you to receive the expected fsconfig() data from userspace.

If we will go this way, then it would be nice to update hostfs docs to
motivate users to use hostfs="" in configuration, and I will probably
add later a warning to mount(8) to force users to use hostfs="" key.

Does it make sense?

> Fixing the regression fully (including for paths containing commas)
> probably also requires userspace changes. If you don't want to make
> those we can only point to your workarounds instead, since we can't do
> anything on the kernel side.

I am open to temporary FS-specific libmount workarounds, but I would
like to see a long-term solution and plan on how to encourage users to
use it.

> I don't know the fsconfig() API, is it possible to have key-less or
> value-less calls? What does happen 

The key is always required; otherwise, you will receive an -EINVAL error.
https://github.com/torvalds/linux/blob/master/fs/fsopen.c#L369

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


