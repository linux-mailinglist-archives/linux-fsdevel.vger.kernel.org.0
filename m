Return-Path: <linux-fsdevel+bounces-42972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C65A4C8FB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 18:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 551F7167D87
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 17:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39A922CBFA;
	Mon,  3 Mar 2025 16:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BJgZhaWc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C32825BAAB
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Mar 2025 16:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020604; cv=none; b=b4I/w88xsvmEwQ4/2NsInE0MolibJZm8ZbmB0puK1IqgXKeffut/vSCEqINN1OduzBkCHWt+S3ABMbDNZKwg1WiatWFoN3cvdX3BKG6aVuZ1ku70f31o7OVyPzWpOSmRz0uXpBqxtfpnh0dEz/UipZh2IG4yCgf0Z+ZHtnIUy5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020604; c=relaxed/simple;
	bh=d8/WZ74KpxSBBuf8SBqXQmQCVS+FqdR4GegQqBBnNVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqYL9AxBVCiX3IvWbd4/A2Ap3DtkCL4sA/VIsUWCSdPXidtmvcuq6nlZDK3sIsWDhxy8zDQilTn/svg/tdxUgEsn/P9OogX9RI21C6RnJmeJyCmI/HHAV92TpKtarYtJ3iALgiZ2VQmdr38Wimk1ey7nZJ1Eo/avvRo3aCFZlF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BJgZhaWc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741020601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CRFDMhYCdzohXSQPdHzmNODZ58R1W+2Bk5NhU9gOXmU=;
	b=BJgZhaWc9kmE6LNUolbX2WMY6f/MBfqV0eu7kLdUb+30Kwxlsoj469H5Mh5DNPLIrP9YeU
	AMRT/13Ux18kjzDr249U4T+8gOEFl4TBIzn0jfYrZyNtgjaKh6hZHo23JAJ7fcpn4GrnSD
	3h0wR3I+YDcyhTxt5dT8/uRQqeZHpVQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-c6G75LhJOnyN0hUAVZFQOg-1; Mon,
 03 Mar 2025 11:49:58 -0500
X-MC-Unique: c6G75LhJOnyN0hUAVZFQOg-1
X-Mimecast-MFC-AGG-ID: c6G75LhJOnyN0hUAVZFQOg_1741020596
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E33781800877;
	Mon,  3 Mar 2025 16:49:55 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.32.16])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 06A651955F0F;
	Mon,  3 Mar 2025 16:49:50 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  3 Mar 2025 17:49:25 +0100 (CET)
Date: Mon, 3 Mar 2025 17:49:19 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: "Sapkal, Swapnil" <swapnil.sapkal@amd.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Manfred Spraul <manfred@colorfullife.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
	Neeraj.Upadhyay@amd.com, Ananth.narayan@amd.com,
	Alexey Gladkov <legion@kernel.org>
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
Message-ID: <20250303164918.GA9870@redhat.com>
References: <20250102140715.GA7091@redhat.com>
 <e813814e-7094-4673-bc69-731af065a0eb@amd.com>
 <20250224142329.GA19016@redhat.com>
 <qsehsgqnti4csvsg2xrrsof4qm4smhdhv6s4v4twspf76bp3jo@2mpz5xtqhmgt>
 <c63cc8e8-424f-43e2-834f-fc449b24787e@amd.com>
 <20250227211229.GD25639@redhat.com>
 <06ae9c0e-ba5c-4f25-a9b9-a34f3290f3fe@amd.com>
 <20250228143049.GA17761@redhat.com>
 <20250228163347.GB17761@redhat.com>
 <03a1f4af-47e0-459d-b2bf-9f65536fc2ab@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03a1f4af-47e0-459d-b2bf-9f65536fc2ab@amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Hi!

On 03/03, Sapkal, Swapnil wrote:
>
> >but if you have time, could you check if this patch (with or without the
> >previous debugging patch) makes any difference? Just to be sure.
>
> Sure, I will give this a try.

Forget ;)

[...snip...]

> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -417,9 +417,19 @@ static inline int is_packetized(struct file *file)
>  /* Done while waiting without holding the pipe lock - thus the READ_ONCE() */
>  static inline bool pipe_writable(const struct pipe_inode_info *pipe)
>  {
> -	unsigned int head = READ_ONCE(pipe->head);
> -	unsigned int tail = READ_ONCE(pipe->tail);
>  	unsigned int max_usage = READ_ONCE(pipe->max_usage);
> +	unsigned int head, tail;
> +
> +	tail = READ_ONCE(pipe->tail);
> +	/*
> +	 * Since the unsigned arithmetic in this lockless preemptible context
> +	 * relies on the fact that the tail can never be ahead of head, read
> +	 * the head after the tail to ensure we've not missed any updates to
> +	 * the head. Reordering the reads can cause wraparounds and give the
> +	 * illusion that the pipe is full.
> +	 */
> +	smp_rmb();
> +	head = READ_ONCE(pipe->head);
>  	return !pipe_full(head, tail, max_usage) ||
>  		!READ_ONCE(pipe->readers);

Ooh, thanks!!!

And sorry, can't work today. To be honest, I have some concerns, but probably
I am wrong... I'll return tomorrow.

In any case, finally we have a hint. Thank you both!

(btw, please look at pipe_poll).

Oleg.


