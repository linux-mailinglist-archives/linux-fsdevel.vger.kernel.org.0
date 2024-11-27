Return-Path: <linux-fsdevel+bounces-35976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E10949DA757
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 13:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ED36161E01
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 12:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC6C1FA24C;
	Wed, 27 Nov 2024 12:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AKDaZVbN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8821FA179
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Nov 2024 12:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732708985; cv=none; b=Guw7beRgL+0qySYexZhUWbkzPrhcsLkSCOy1DCGiADJ8B7EAfvuVyfalslShbSPT9lQZIuItlzTp8KeTFDarKkhrM5x/J7S9/WeaH8G0McyrPAo9/vf0R9tIXjMPInDlLHQalqb8sQFtSPT5wxLyFlQBu+g/aZl5eXZTO76ZVt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732708985; c=relaxed/simple;
	bh=7XRjTaRnTE3p3ALpSwkaiaM7yiC2CQgpqokhbbs5RZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5nWPz02jJmpaUrnQ5tHzDTC+/Bwfpr1Y3Jb6RfBEJICwVlXheel1nVRZChrq3C/wOGXCjNrpmrsRrm+sM7YfViFOGxy3HEkWbpGeCn6+tzniyaORs8A90fNV9EMaCeq4Ke3u6OLMCmhcxdhCQ1AxS4vhBvW4hCZiZa1oy9Br1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AKDaZVbN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732708983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5XuurAi60ovgVG4u4UNaWnG8aq075t+aiuMPD1bhYEI=;
	b=AKDaZVbNMB6ANOyl7Ya8BVN64s4NR34C6IyMbjcrssWNGfDCC1wIP1meDeFqSmIufaD14/
	FT9YgJE0NC+X1hYRk7Emb5UXJW1NVWe+jYMoSQDx9v7bmhuFm4REP0eaQ83wikr+LIHhhY
	hZRk9w71eGiGk2S2K8Rutl/9V5Def9g=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-nOj8QUA_NWaMT_4AY99rkw-1; Wed,
 27 Nov 2024 07:02:57 -0500
X-MC-Unique: nOj8QUA_NWaMT_4AY99rkw-1
X-Mimecast-MFC-AGG-ID: nOj8QUA_NWaMT_4AY99rkw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E96EA195604F;
	Wed, 27 Nov 2024 12:02:55 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.12])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 98A94300019E;
	Wed, 27 Nov 2024 12:02:53 +0000 (UTC)
Date: Wed, 27 Nov 2024 13:02:50 +0100
From: Karel Zak <kzak@redhat.com>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, 
	linux-um@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Benjamin Berg <benjamin@sipsolutions.net>, rrs@debian.org
Subject: Re: UML mount failure with Linux 6.11
Message-ID: <uppzc2p5bn6fhrdlzzkbdrkoigurkii5ockigngknm4waewl5z@z2a6c6iivu7s>
References: <420d651a262e62a15d28d9b28a8dbc503fec5677.camel@sipsolutions.net>
 <f562158e-a113-4272-8be7-69b66a3ac343@huawei.com>
 <ac1b8ddd62ab22e6311ddba0c07c65b389a1c5df.camel@sipsolutions.net>
 <b0acfbdf-339b-4f7b-9fbd-8d864217366b@huawei.com>
 <buizu3navazyzdg23dsphmdi26iuf5mothe3l4ods4rbqwqfnh@rgnqbq7n4j4g>
 <9f56df34-68d4-4cb1-9b47-b8669b16ed28@huawei.com>
 <3d5e772c-7f13-4557-82ff-73e29a501466@huawei.com>
 <ykwlncqgbsv7xilipxjs2xoxjpkdhss4gb5tssah7pjd76iqxf@o2vkkrjh2mgd>
 <6e6ccc76005d8c53370d8bdcb0e520e10b2b7193.camel@sipsolutions.net>
 <5e5e465e-0380-4fbf-915d-69be5a8e0b65@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e5e465e-0380-4fbf-915d-69be5a8e0b65@huawei.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Nov 27, 2024 at 09:26:46AM GMT, Hongbo Li wrote:
> 
> 
> On 2024/11/26 21:50, Johannes Berg wrote:
> > On Mon, 2024-11-25 at 18:43 +0100, Karel Zak wrote:
> > > 
> > > The long-term solution would be to clean up hostfs and use named
> > > variables, such as "mount -t hostfs none -o 'path="/home/hostfs"'.
> > 
> > That's what Hongbo's commit *did*, afaict, but it is a regression.
> > 
> > Now most of the regression is that with fsconfig() call it was no longer
> > possible to specify a bare folder, and then we got discussing what
> > happens if the folder name actually contains a comma...
> > 
> > But this is still a regression, so we need to figure out what to do
> > short term?
> > 
> So for short term, even long term, can we consider handling the hostfs
> situation specially within libmount?

Yes (see reply to Johannes ).

> Such as treat the whole option as one
> key(also may be with comma, even with equal)

There could be userspace specific options, VFS flags, etc.

  -o /home/hostfs,ro,noexec

Is it one path or path and two options?

> in this case, libmount will
> use it as FSCONFIG_SET_FLAG. We can do that because for hostfs, it only has
> one mount option, and no need for extension.

We can automatically add a key (e.g. hostfs=) and use FSCONFIG_SET_FLAG.
The goal should be to get the path as a value, because key is limited to
256 bytes.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


