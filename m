Return-Path: <linux-fsdevel+bounces-35840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E299D8B81
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 18:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D083B2848B0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 17:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6C21B85E4;
	Mon, 25 Nov 2024 17:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fPcFwinT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5615914D43D
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2024 17:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732556650; cv=none; b=hIt2SqcsneTKUg8n5VASyuM4BhbfAMi94RkdO5G90IWsGll1Xssvb3Ex7SOT8rjZ6BXOjggwvOaua987HaHnME+vwvFxqU9JpXcKbS2L6YfQGN99hho0aWQrcf1DLf4dTGI3EaEHZXwW9b2vCKOffmCuepzEhkT/MRaCHVdh6Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732556650; c=relaxed/simple;
	bh=2DbZ5Ppd3jOgJoy/Iw4IUmQ9PKsI8ksUT8Pvljemf3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYpjhW4NcqVOy+e+4wiJpELg4teewbJUoIL5YlC13gT0VoA2ULT3V1OsrRjEMyXMi1X6wOPDu4T5WcUPQYgaG5BdhDaWPCoBLckpDuTYIJnwxlr8XzpJjDg13qc3XzW3skXwBQJdxPAUAKj6aFpoo8YnwQmaqvKI0OsJr+2uTO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fPcFwinT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732556647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i1zyTvm0SiQ2Og0Kpt6UMawusjwfmCj5SiNgpCOF4PA=;
	b=fPcFwinTAiZe/dWXQwl3sFi/j0pLCgIb+N2il78P7jnVoJ+eOJMMjJ/V7QwPr8rxrM9m2T
	TOp+NQA3Ob/HbgySOc+rbcl7uOELPm8dfzZNfmy6fp4dc936mNU9WRs3N6glzx1t1Ndmu6
	GW+mkJrcVs7MUW4B0kdoz/H58nNdhpg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-360-ADs_7fLGNtuo0lix5HnpqA-1; Mon,
 25 Nov 2024 12:44:02 -0500
X-MC-Unique: ADs_7fLGNtuo0lix5HnpqA-1
X-Mimecast-MFC-AGG-ID: ADs_7fLGNtuo0lix5HnpqA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C6D531955F3E;
	Mon, 25 Nov 2024 17:43:55 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.223])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 395981944CC9;
	Mon, 25 Nov 2024 17:43:52 +0000 (UTC)
Date: Mon, 25 Nov 2024 18:43:49 +0100
From: Karel Zak <kzak@redhat.com>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-um@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Benjamin Berg <benjamin@sipsolutions.net>, 
	Johannes Berg <johannes@sipsolutions.net>, rrs@debian.org
Subject: Re: UML mount failure with Linux 6.11
Message-ID: <ykwlncqgbsv7xilipxjs2xoxjpkdhss4gb5tssah7pjd76iqxf@o2vkkrjh2mgd>
References: <093e261c859cf20eecb04597dc3fd8f168402b5a.camel@debian.org>
 <3acd79d1111a845aed34ed283f278423d0015be3.camel@sipsolutions.net>
 <0ce95bbf-5e83-44a3-8d1a-b8c61141c0a7@huawei.com>
 <420d651a262e62a15d28d9b28a8dbc503fec5677.camel@sipsolutions.net>
 <f562158e-a113-4272-8be7-69b66a3ac343@huawei.com>
 <ac1b8ddd62ab22e6311ddba0c07c65b389a1c5df.camel@sipsolutions.net>
 <b0acfbdf-339b-4f7b-9fbd-8d864217366b@huawei.com>
 <buizu3navazyzdg23dsphmdi26iuf5mothe3l4ods4rbqwqfnh@rgnqbq7n4j4g>
 <9f56df34-68d4-4cb1-9b47-b8669b16ed28@huawei.com>
 <3d5e772c-7f13-4557-82ff-73e29a501466@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d5e772c-7f13-4557-82ff-73e29a501466@huawei.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Thu, Nov 21, 2024 at 09:53:06PM GMT, Hongbo Li wrote:
> > > The options has been always parsed by mount(8) and it's very fragile
> > > to assume that kernel get as in the original order (etc.).
> > > 
> > > For decades, commas have been supported in mount options. For example,
> > > SeLinux uses them frequently in context settings. All you need to do
> > > is use quotes, but be careful because the shell will strip them off.
> > > Therefore, double quoting is required.
> > > 
> > 
> > Thanks for your reply!
> > 
> > If I'm not mistaken, we should add double quoting explicitly if we need
> > commas in mount options. However, it seems different for hostfs. For
> > example, with hostfs, if we use "mount -t hostfs none -o
> > /home/hostfs,dir /mnt" in the older interface, which can successfully
> > mount the host directory `/home/hostfs,dir`, then we should use "mount
> > -t hostfs none -o '"/home/hostfs,dir"' /mnt" in the new interface. If
> > that is the case, we should change the mount command which is hardcoded
> > in the original project.
> Sorry for the disturbance. So am I right?

The old interface (mount(2)) sends all options together as one string.
This means that if mount(8)/libmount does not modify the string in an
unwanted way, then you are safe.

The new interface uses one fsconfig() call for each option, so parsing
is required to split the "-o string". This means that you will always
be affected by options separators interpretation. This is the reason
why I have suggested quoting.

I see a different issue (and I apologize for missing it in my previous
reply). mount(8) only supports quoting for named options, which means
using the format NAME="v,a,l,u,e". This is not expected if you do not
use NAME=, for example "/home/hostfs,dir".


I am not sure, but there may be another issue with your use-case. "-o
'/home/hostfs,dir'" means that "/home/hostfs,dir" will be used as the
key (variable name) in the fsconfig() syscall. I have doubts that it
is designed for long strings like paths. At first glance, kernel uses
only 256 bytes for the key (and since it is a variable without a
value, libmount will use it as FSCONFIG_SET_FLAG). 

Maybe Christian will know more details.

For now, my suggestion is to use the LIBMOUNT_FORCE_MOUNT2=always
environment variable to force mount(8) to use the classic mount(2)
syscall.

The long-term solution would be to clean up hostfs and use named
variables, such as "mount -t hostfs none -o 'path="/home/hostfs"'.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


