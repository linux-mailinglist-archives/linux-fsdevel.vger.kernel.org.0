Return-Path: <linux-fsdevel+bounces-49585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B27CABF9EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 17:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88F19188CA53
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 15:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0582220F3C;
	Wed, 21 May 2025 15:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CCNipJKN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB1921422B
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 May 2025 15:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747841881; cv=none; b=F/Dj3Lka1vtnNVtQknBXf8GCMSyxDKd9+vyLNkA+CKuZTShdP3Yu1Hp4ydFaGf441AK/Es9rGQa19mAim4TYa2kGdFWb3LmtaBYzj/s++rUjJ8wU5zIPqBqlBSdWXZyhJBh6+ifIHlKeIjOp8OWqAkwj9tfTlw7ZT1Iplx7RQkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747841881; c=relaxed/simple;
	bh=mOFwZi8uF/Vd7QR19RQnmQPwENX+UWRgxsy3kizbkWA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k2ODKSdx1wj/EKYZAff3O3cYIPDVhWMFUUvMzz06OAXYWkWubvNO6pXTmXMgP362y43l1ofiPSigEOeTeeCDVM5yMC+tSiqy1zLeTFaLFaqdQ0N0W7HYtNRJS8GdZu18E7qCUvGxt4MpWarDIiddkFNOYurC5t2yW1fpb3UyKw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CCNipJKN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747841878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4OYI585nduQE5fAKYci/xXzRDgiHeBkKRLTnL/6NwgA=;
	b=CCNipJKN/k89nGBdgOdnknhJqmjAbb19znfU7J5gycbbcHoCdB7M3AdQqb19hYxCrfp+s0
	QjMlb9CMTMqt2eot22VUOonI6eDEuJwZmjoVD8pEcKJ72paR3kCpFirjYTPgrxzzqFudgG
	G1wWXuQd5wNdK4MEDvq5FQzXj7E5c0c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-9qpvj7eLOPGmA50dQx927w-1; Wed, 21 May 2025 11:37:57 -0400
X-MC-Unique: 9qpvj7eLOPGmA50dQx927w-1
X-Mimecast-MFC-AGG-ID: 9qpvj7eLOPGmA50dQx927w_1747841876
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43ceeaf1524so37813745e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 May 2025 08:37:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747841876; x=1748446676;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4OYI585nduQE5fAKYci/xXzRDgiHeBkKRLTnL/6NwgA=;
        b=wXCkRifgODsECQlwvQxdROVNoAVCzg0T8bmNgjShvfiEelAmJD4IDJZVgVHPtvbhae
         WlRaIZ0v6Qzd5VKQRn1lv4XfhwM0KuUZy5eVNrnZ7bV+/xp0jLpUXhMAvKLRpIZtgbZ7
         BIAZyfI8pX8anGsgeviGD2ceyxEflM4IM8k7tCzfsiscclaROr9cQXlLR7vSmhesmJE7
         nZBU5t3PZRHyIx4PXnfHzEMyS5p9x/RjivhD6xJVbMX1A7BheIc5IfADJ7PhgKI96BGl
         ohxaGfvq/t9LFFrcYNXX+6WBgygVfBi49FK/Kh6m6Eg3FFU6MoZ8FOYqThDOOc99FOlF
         7htw==
X-Forwarded-Encrypted: i=1; AJvYcCVFO4f0i71kM2rE+o+uh7KolecO2xCsc752IR9AeSrU01LIh2bRv4TpXfnErWXQEdYICXsz5bOmL+wFPjrC@vger.kernel.org
X-Gm-Message-State: AOJu0YxJMRQnK8PX7hDu3+A7aufb0VrS2AlCMtk62/J0Uwo2lKL26VoS
	5c2dYfJMPjGQXzxfxg+MOaD2FNr2T51aHV96IC8uqO/gAFLsZckP4ooarERvNcEULd2mzdjqthX
	4ZIBM0m+XgMsB9I7FogCCmMiVCHm7ByWgi2augnn8pt0Xy3vLP2BzvFktW4R8GN7cjic=
X-Gm-Gg: ASbGncs4d64lXJCX7T8EVlZqkXScObmg6VG72jRLkdVN45KM6uWF56qzP6QEej2hWh2
	eS9ZmIKRJBAbksTQVBtFVmAMe26thqNR5AAss3xNW5xQ/bXM2jVoR1nNI/cn4YCIYFgPWA/+IdF
	ERnuaIf14HCSg45NLPJWLFKbBQwPtACyT90+G8U8BGRB2/7PcRGVVsMviA02Y1YpsOToMmbNN+U
	FvZQjPhWHdH9jtXyNwCPbk+Zd+Sou3Tp1iew84Bzrir3aDc9audM6mUxi0YjtHiv0omqQCw359y
	eIGn8TpZ7cRvCg3HxvYqQ2EcX9HYqRapI/bJF3Ii8IKlRpIKr4fEUPuRDMnmatJHaYPwm4Mt
X-Received: by 2002:a05:600c:8889:10b0:442:f4a3:a2c0 with SMTP id 5b1f17b1804b1-443024b8820mr116363105e9.13.1747841875807;
        Wed, 21 May 2025 08:37:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcHFJCDU0kERgNNpbSG5LzwmKXYOVL8DXbNu1j1znxGmyPxiSylKOJBGAP3Ew47kasRlgLlA==
X-Received: by 2002:a05:600c:8889:10b0:442:f4a3:a2c0 with SMTP id 5b1f17b1804b1-443024b8820mr116362885e9.13.1747841875376;
        Wed, 21 May 2025 08:37:55 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f73d3defsm71546225e9.18.2025.05.21.08.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 08:37:54 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>, Clark
 Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, linux-rt-users@vger.kernel.org, Joe Damato
 <jdamato@fastly.com>, Martin Karsten <mkarsten@uwaterloo.ca>, Jens Axboe
 <axboe@kernel.dk>, Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH] eventpoll: Fix priority inversion problem
In-Reply-To: <20250521145320.oqUIOaRG@linutronix.de>
References: <20250519074016.3337326-1-namcao@linutronix.de>
 <xhsmh8qmq9h37.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20250521145320.oqUIOaRG@linutronix.de>
Date: Wed, 21 May 2025 17:37:54 +0200
Message-ID: <xhsmh5xhu9dpp.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 21/05/25 16:53, Nam Cao wrote:
> On Wed, May 21, 2025 at 04:25:00PM +0200, Valentin Schneider wrote:
>> > +	llist_for_each_entry_safe(epi, tmp, txlist.first, rdllink) {
>> > +		/*
>> > +		 * We are done iterating. Allow the items we took to be added back to the ready
>> > +		 * list.
>> > +		 */
>> > +		xchg(&epi->link_locked, false);
>> > +
>> > +		/*
>> > +		 * In the loop above, we may mark some items ready, and they should be added back.
>> > +		 *
>> > +		 * Additionally, someone else may also attempt to add the item to the ready list,
>> > +		 * but got blocked by us. Add those blocked items now.
>> > +		 */
>> > +		if (smp_load_acquire(&epi->ready)) {
>> >                       ep_pm_stay_awake(epi);
>> > +			epitem_ready(epi);
>> >               }
>>
>> Isn't this missing a:
>>
>>                 list_del_init(&epi->rdllink);
>>
>> AFAICT we're always going to overwrite that link when next marking the item
>> as ready, but I'd say it's best to exit this with a clean state. That would
>> have to be before the clearing of link_locked so it doesn't race with a
>> concurrent epitem_ready() call.
>
> To confirm I understand you: there is no functional problem, and your
> comment is more of a "just to be safe"?
>

Yup, even if they're not accessed it's good to not have stray references to
stack addresses.

> Thanks so much for the review,
> Nam


