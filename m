Return-Path: <linux-fsdevel+bounces-43423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB1DA567E6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 13:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 026F01898614
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 12:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87A62192FD;
	Fri,  7 Mar 2025 12:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U3omxWDY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8709518D65C
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Mar 2025 12:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741350930; cv=none; b=QrVNRwiTu4g0eiGH4Tm8uEqmR+8rs6k5uJsk3xJYYpCA0tb2ZNndHEWL8xDlI8brOxvINhD8h0iTayLKyzonKQySsSlBXS6OC3tAJPltx0RsveXeWRF0GSMhHAMyv2zC4RKXa6WYtQRgwnplHVQmi3YrjfLa/NK4o0hsFjKD9WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741350930; c=relaxed/simple;
	bh=+O60ObcSeqCKo6IVaNkmv38iQCdtkc6nnzxjPx7o408=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMai1PX3UIPgNQZGApccXN+EkCcz4NpUIpELsyW+QTDXC3T3BH9UDoUcOeFWAd+7eKRO6VgEsIC+7E7AqjpDb2vQsuOOxcDjGIUskMcIJUWgX92NIhGwV/ZXKFEvur8J8j947/k4XJVNGwJFkO796jflSp4wRdkKaWoyi71CXUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U3omxWDY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741350927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0c0G0Xk8+hb6RAUbjAEw0Q8vL0/F3bRXsSDovOnkZzE=;
	b=U3omxWDYkhYmbCiDI9sPNVk40hvWpXX8Nr9fzfShMAKESuFVgtHDAYiMLZTlLmESS5Uvbu
	0BKLijrRxZdMWWZEiTOGigxPM6rMiRmnK0KTrvZDRG2JKOcoiB7cD2Irzl7oI2EjCJ78FH
	uGoVl1qjGYIbKwumzgQJ36PKSCmTklY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-90-bTPcYI5HO32vd-ICEio1MA-1; Fri,
 07 Mar 2025 07:35:20 -0500
X-MC-Unique: bTPcYI5HO32vd-ICEio1MA-1
X-Mimecast-MFC-AGG-ID: bTPcYI5HO32vd-ICEio1MA_1741350919
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B72D19560A2;
	Fri,  7 Mar 2025 12:35:18 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.33.108])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D34EA1944F2E;
	Fri,  7 Mar 2025 12:35:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  7 Mar 2025 13:34:47 +0100 (CET)
Date: Fri, 7 Mar 2025 13:34:43 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Hillf Danton <hdanton@sina.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	"Sapkal, Swapnil" <swapnil.sapkal@amd.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
Message-ID: <20250307123442.GD5963@redhat.com>
References: <20250228143049.GA17761@redhat.com>
 <20250228163347.GB17761@redhat.com>
 <20250304050644.2983-1-hdanton@sina.com>
 <20250304102934.2999-1-hdanton@sina.com>
 <20250304233501.3019-1-hdanton@sina.com>
 <20250305045617.3038-1-hdanton@sina.com>
 <20250305224648.3058-1-hdanton@sina.com>
 <20250307060827.3083-1-hdanton@sina.com>
 <20250307104654.3100-1-hdanton@sina.com>
 <20250307112920.GB5963@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307112920.GB5963@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

In case I wasn't clear...

On 03/07, Oleg Nesterov wrote:
>
> On 03/07, Hillf Danton wrote:
> >
> > On Fri, 7 Mar 2025 11:54:56 +0530 K Prateek Nayak <kprateek.nayak@amd.com>
> > >> step-03
> > >> 	task-118766 new reader
> > >> 	makes pipe empty
> > >
> > >Reader seeing a pipe full should wake up a writer allowing 118768 to
> > >wakeup again and fill the pipe. Am I missing something?
> > >
> > Good catch, but that wakeup was cut off [2,3]

Please note that "that wakeup" was _not_ removed by the patch below.

"That wakeup" is another wakeup pipe_read() does before return:

	if (wake_writer)
		wake_up_interruptible_sync_poll(&pipe->wr_wait, ...);

And wake_writer must be true if this reader changed the pipe_full()
condition from T to F.

Note also that pipe_read() won't sleep if it has read even one byte.

> > [2] https://lore.kernel.org/lkml/20250304123457.GA25281@redhat.com/
> > [3] https://lore.kernel.org/all/20250210114039.GA3588@redhat.com/
>
> Why do you think
>
> 	[PATCH v2 1/1] pipe: change pipe_write() to never add a zero-sized buffer
> 	https://lore.kernel.org/all/20250210114039.GA3588@redhat.com/
>
> can make any difference ???
>
> Where do you think a zero-sized buffer with ->len == 0 can come from?

Oleg.


