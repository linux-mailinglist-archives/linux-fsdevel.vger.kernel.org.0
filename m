Return-Path: <linux-fsdevel+bounces-13621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE8387210F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 15:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A26E51F21475
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 14:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481D68613C;
	Tue,  5 Mar 2024 14:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FIc73DM5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBCA86131
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Mar 2024 14:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709647442; cv=none; b=jPjsFPSp1K8fS+ZIUDIA+5Nok6fRLuTUJ4rCIXvAbfRKNQzIgwcwdy3EmTlFBc6ISX2DlTmGhgLdoAtwFzdO8XhSoqJbXP1nMc5QBDYc/4OLZivMYRjs/g780hoFxeAGTBApzYwzcrgbQ3Oi79CxWKTH3klQzsn3FNfJUPLjI0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709647442; c=relaxed/simple;
	bh=aa0qIuAm1hvJ4ja2F5wKSBEUEOY9l4Gw7o1veFKZ7lg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fpbA7T/Jee/ffInTD0dfYn+756Et/OeMBEuFzbLMIjvnvO2JATjJZ3J7LXf2VPZAIbcFAGqCvXfC0WsOPhfkRN/4n2a81cBl1FyXcCR7wJaBjSfReNtj5tlCENEDekVSEsjdccGtx81CnMhGAO9f7CMk9Gbl6ElmCLKvjmydk+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FIc73DM5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709647439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aUqJp7Tz54/mZg3h4LVetsuvTHNQsDWjWKBoM6zc2vw=;
	b=FIc73DM55q0P/1PUSKGnWGG+61w/MHSV5Lfg5x41zm8Bn7sW4S3P6pfbGuD5prB/03K2GH
	+EHlJlc6h2xOnzMroiMWewGu31SvFOgmNi6YnPHMCJGprp3e4TEZC9cEkC8egtwDjai7iO
	PW6niyxKBDo1w6+yRY+0z8wvF4h+P+k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-v9wFYUOUMkOe-e5Gw-9onA-1; Tue, 05 Mar 2024 09:03:54 -0500
X-MC-Unique: v9wFYUOUMkOe-e5Gw-9onA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EEC9584B063;
	Tue,  5 Mar 2024 14:03:53 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E5FE51C05E1C;
	Tue,  5 Mar 2024 14:03:53 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id CE99E30C1B93; Tue,  5 Mar 2024 14:03:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id CA5AD3FB4E;
	Tue,  5 Mar 2024 15:03:53 +0100 (CET)
Date: Tue, 5 Mar 2024 15:03:53 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Christian Brauner <brauner@kernel.org>
cc: Hugh Dickins <hughd@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
    Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] tmpfs: don't interrupt fallocate with EINTR
In-Reply-To: <20240305-zugunsten-busbahnhof-6dc705d80152@brauner>
Message-ID: <a3834f3-8beb-988a-e387-5c8d31e013f@redhat.com>
References: <ef5c3b-fcd0-db5c-8d4-eeae79e62267@redhat.com> <20240305-abgas-tierzucht-1c60219b7839@brauner> <84acfa88-816f-50d7-50a2-92ea7a7db42@redhat.com> <20240305-zugunsten-busbahnhof-6dc705d80152@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7



On Tue, 5 Mar 2024, Christian Brauner wrote:

> On Tue, Mar 05, 2024 at 10:34:26AM +0100, Mikulas Patocka wrote:
> > 
> > 
> > On Tue, 5 Mar 2024, Christian Brauner wrote:
> > 
> > > On Mon, Mar 04, 2024 at 07:43:39PM +0100, Mikulas Patocka wrote:
> > > > 
> > > > Index: linux-2.6/mm/shmem.c
> > > > ===================================================================
> > > > --- linux-2.6.orig/mm/shmem.c	2024-01-18 19:18:31.000000000 +0100
> > > > +++ linux-2.6/mm/shmem.c	2024-03-04 19:05:25.000000000 +0100
> > > > @@ -3143,7 +3143,7 @@ static long shmem_fallocate(struct file
> > > >  		 * Good, the fallocate(2) manpage permits EINTR: we may have
> > > >  		 * been interrupted because we are using up too much memory.
> > > >  		 */
> > > > -		if (signal_pending(current))
> > > > +		if (fatal_signal_pending(current))
> > > 
> > > I think that's likely wrong and probably would cause regressions as
> > > there may be users relying on this?
> > 
> > ext4 fallocate doesn't return -EINTR. So, userspace code can't rely on it.
> 
> I'm confused what does this have to do with ext4 since this is about
> tmpfs.

You said that applications may rely on -EINTR and I said they don't 
because ext4 doesn't return -EINTR.

> Also note, that fallocate(2) documents EINTR as a valid return
> value. And fwiw, the manpage also states that "EINTR  A signal was
> caught during execution; see signal(7)." not a "fatal signal".

Yes, but how should the userspace use the fallocate call reliably? Block 
all the signals around the call to fallocate? What to do if I use some 
library that calls fallocate and retries on EINTR?

> Aside from that. If a user sends SIGUSR1 then with the code as it is now
> that fallocate call will be interrupted. With your change that SIGUSR1
> won't do anything anymore. Instead userspace would need to send SIGKILL.
> So userspace that uses SIGUSR1 will suddenly hang.

It will survive one SIGUSR, but it hangs if the signal is being sent at a 
periodic interval.

A quick search shows that people are already adding loops when fallocate 
returns EINTR. All these loops will livelock when a signal is repeatedly 
being delivered: 
https://forge.chapril.org/hardcoresushi/libgocryptfs/commit/8518d6d7bde33fdc7ef5bcb7c3c7709404392ad8?style=unified&whitespace= 
https://postgrespro.com/media/maillist-attaches/pgsql-hackers/2022/07/1/20220701154105.jjfutmngoedgiad3@alvherre.pgsql/v2-0001-retry-ftruncate.patch 
https://lists.nongnu.org/archive/html/qemu-devel/2015-02/msg01116.html

Here, Postgres developers hit the same problem with retrying (they have 
5ms timer):
https://www.postgresql.org/message-id/CA%2BhUKGKS2Radu-1Ewhe1-LEj19C-3XAQ7wnkQMb4e9E9q9ZXSg%40mail.gmail.com

Mikulas


