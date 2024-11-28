Return-Path: <linux-fsdevel+bounces-36065-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8B49DB622
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 11:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5766BB25EC7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 10:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B0A195385;
	Thu, 28 Nov 2024 10:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RQpfXtxP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A28D1922EE
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2024 10:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732791511; cv=none; b=HPP4l57hzNVaGcz+ssSJ6CPuYOXUX5HtSek72nxENWUsacqdnw3MUgDE8n6wSxPTvU3ZGPxveeNlCfVcjgJ22/RiatrRjDiYunHNfpCa4/unOqyjxfHinEAd5h4wCY7rHMJzyL8juv3TuYnLpUHvcbuj9ldw25+yjegN5W12OFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732791511; c=relaxed/simple;
	bh=eyrbuq8AV5SNu8EkXqabgmyHvioxsSeqj2tJNvW6AhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsttlQqtZa8vfm30WrWhwDDgCKawf5980zSWsQylD5C+MeKW3+mx9h6THL7kJ/1woIVXsASLgk1VR2oVot62aL0R5ziYWVJg68sH7m3tjL0/cheZ3cLN1cY98q6ouGDY5nX41uQsrFRy8N7tvDIrD2sfTROJRA8UG6VjNO1gzGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RQpfXtxP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732791508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W2kvyP7qMQ8GW2DH8xtax0gdNkHtiuZEU/a4aFZyJ8E=;
	b=RQpfXtxPHH5pWEGFm/rVDrtfSh7MRIU4ADZtYOOuieWchUOEj8HB/CKDJ5yp3SstHby4DK
	Gueu2rSGwRcj9gjJoY/uFNDsBqla/68bWCx2x9mk7bjYSR8VyJiNBaRE7VNIBWhSpUysul
	XDhoi2Xiw2K9oEnSwVgsVzAgwk5o4U0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-280-a2Q4UtEwNPiA7BBxzF0lhw-1; Thu,
 28 Nov 2024 05:58:24 -0500
X-MC-Unique: a2Q4UtEwNPiA7BBxzF0lhw-1
X-Mimecast-MFC-AGG-ID: a2Q4UtEwNPiA7BBxzF0lhw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BEED21955D83;
	Thu, 28 Nov 2024 10:58:22 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.12])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 22F21300018D;
	Thu, 28 Nov 2024 10:58:19 +0000 (UTC)
Date: Thu, 28 Nov 2024 11:58:16 +0100
From: Karel Zak <kzak@redhat.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Hongbo Li <lihongbo22@huawei.com>, linux-um@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Benjamin Berg <benjamin@sipsolutions.net>, rrs@debian.org
Subject: Re: UML mount failure with Linux 6.11
Message-ID: <c7hrptra3k6g6jwemz3h5gp4syyz4bttpnepdhpa33htnrltxu@iuusct5yzaso>
References: <ac1b8ddd62ab22e6311ddba0c07c65b389a1c5df.camel@sipsolutions.net>
 <b0acfbdf-339b-4f7b-9fbd-8d864217366b@huawei.com>
 <buizu3navazyzdg23dsphmdi26iuf5mothe3l4ods4rbqwqfnh@rgnqbq7n4j4g>
 <9f56df34-68d4-4cb1-9b47-b8669b16ed28@huawei.com>
 <3d5e772c-7f13-4557-82ff-73e29a501466@huawei.com>
 <ykwlncqgbsv7xilipxjs2xoxjpkdhss4gb5tssah7pjd76iqxf@o2vkkrjh2mgd>
 <6e6ccc76005d8c53370d8bdcb0e520e10b2b7193.camel@sipsolutions.net>
 <5e5e465e-0380-4fbf-915d-69be5a8e0b65@huawei.com>
 <uppzc2p5bn6fhrdlzzkbdrkoigurkii5ockigngknm4waewl5z@z2a6c6iivu7s>
 <f565e434afc84090ffd7bff69ce9cf5643302233.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f565e434afc84090ffd7bff69ce9cf5643302233.camel@sipsolutions.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Nov 27, 2024 at 02:15:54PM GMT, Johannes Berg wrote:
> Let me try to unify the threads, and perhaps further my understanding -
> you seem to already have much more of that than me :)
> 
> > > > But this is still a regression, so we need to figure out what to do
> > > > short term?
> > > > 
> > > So for short term, even long term, can we consider handling the hostfs
> > > situation specially within libmount?
> > 
> > Yes (see reply to Johannes ).
> 
> I'd argue though that this doesn't count as fixing the regression, since
> the kernel was fine before the changes there (even before porting hostfs
> to the new API) with _any_ version of userspace. Except perhaps for when
> there's a comma in the path, which I suppose would've broken one way or
> the other by mount(8) moving to the new API?

Another option is to hardcode a libmount exception that, for hostfs,
the default behavior should be to use the classic mount(2) syscall if
the hostfs= option is not present.
    
 -t hostfs -o /home/hostfs,dir          --> mount(8)
 -t hostfs -o hostfs="/home/hostfs,dir" --> new API

(Alternatively, use the old mount(8) for hostfs regardless of the
options chosen.)

> Assuming no commas, would mount(8) today send the path as the key to a
> flag option? 

 Yes, (I have no hostfs here, so example with ext4):

 # strace -e fsconfig mount -t ext4 -o /home/hostfs none /mnt/test

 fsconfig(3, FSCONFIG_SET_STRING, "source", "none", 0) = 0
 fsconfig(3, FSCONFIG_SET_FLAG, "/home/hostfs", NULL, 0) = -1 EINVAL (Invalid argument)

> We could perhaps find a way to handle that in the kernel,
> and then just do the longer-term plan of moving users to hostfs="..."
> (by documentation/warning) in the future?

The question is whether investing time in using the path-as-key
approach makes sense. Perhaps it would be better to stick with the old
mount(2) and focus on developing a new API that does not have any
legacy issues. Users who choose to use the hostfs= option and the new
kernel will be able to utilize the new API.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


