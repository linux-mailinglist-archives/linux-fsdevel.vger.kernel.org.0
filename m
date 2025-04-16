Return-Path: <linux-fsdevel+bounces-46529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79176A8ADD3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 04:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D90C44133E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 02:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0911FECBF;
	Wed, 16 Apr 2025 02:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="CQPJelMk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dog.birch.relay.mailchannels.net (dog.birch.relay.mailchannels.net [23.83.209.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A4915E96;
	Wed, 16 Apr 2025 02:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744769250; cv=pass; b=XPDNvT86IlV2mZ6aVxWaNpkeodTP2cLKZEio7E2eyYkOVhFdT1JrQrhZoo+0yv76CkfPdIXejsQbyUFMTGHimzEtRIZq9rMKNfsvvMJRY5K0HKSc8Nqhm3q1PD4YOg5r57qD1eTCwdeYrLDHSKsleQsmL5tdLyZD0d0XxSFAXyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744769250; c=relaxed/simple;
	bh=EgFwQezJYypIPTLjbAO7+wgBDKuxG1DACqpgT5oKBE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufEc2l+bQpWXKT5I+oDN8u7vVrRkpSYMUteAFH9ibaloWavTmpFAs9OhHsJUJC66oRzEmd8vUloGeGFnNcy2cfkZnpKePXQWj22VPpnuoBOYeE++ye4n6xso2OZa4k1IbfK4LK5f0rXc+QT56XmKILzCNKPPAbCaNSJJI4MsR8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=CQPJelMk; arc=pass smtp.client-ip=23.83.209.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 8FCA8458B5;
	Wed, 16 Apr 2025 02:02:13 +0000 (UTC)
Received: from pdx1-sub0-mail-a270.dreamhost.com (trex-6.trex.outbound.svc.cluster.local [100.110.51.53])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id E44A645942;
	Wed, 16 Apr 2025 02:02:12 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1744768933; a=rsa-sha256;
	cv=none;
	b=ShPKZgvbJsioWDJ6zr+jN3RuXQx3pXzihIoxXcdZaSyjN9R5n1ACCkvuyN7X1ynEKwIIGY
	R8GLEc4WHPGi2YxHjgspbU56rRPhzKKeMOhaS3HOIxlSSTIWWXJmDKgW6g8jueiTB+5MOS
	0b5be/c6VN4uAVl8LeDqWz9iTfaOK8HP39Wn4J0ZhH10leg8DbSoew4l5g5Xxgfe9b1hhv
	w+nIn0fb8z9cV6LnelyJ2Sr1Q4CAaxrL7Qn4i3hjNw/0+AmXAnmCZ7M7t6UAp7HmTrGpma
	ogtNCT/bxQXwq+HYkQZ0VY8t4ro3prNAHPfWKpOvwLo+hIyWNNiXI/xr87ARPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1744768933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=EgFwQezJYypIPTLjbAO7+wgBDKuxG1DACqpgT5oKBE4=;
	b=w1Vi/dc5LKt/pF3kalouhzHVe1gKlaQAefi7r4+A6nPgdr/Vcv+OEFNcFeVZprLl10Ehmk
	xxG41EPehHgismJsEC2a4EyNj8TaSN46COqL6jgv4uvnxKkTxn3mN4z/Pgb41dnmq19u5E
	hv1PDrdutvORtuSdzhIxjeXkCivOD17/tQd0BWsgk73Ys9RBPaX+74hfz0bj0RvO93ZwW7
	0Fpzja0Vz8YGHS4C8xHLWbJ+IEsUl/7njEELgFasx0YpUETwi63Fk2RDr1I5cvMtmJbA1n
	v5+O4LWQ3bE8rHAcSqL1Fm/W5NVFSDPCri4/wcG66b68BWgtjhaA8jvKAk+tgQ==
ARC-Authentication-Results: i=1;
	rspamd-5dd7f8b4cd-2pb8p;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Spot-Thread: 23261b3b7b19990f_1744768933328_4128009771
X-MC-Loop-Signature: 1744768933328:3434343757
X-MC-Ingress-Time: 1744768933328
Received: from pdx1-sub0-mail-a270.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.110.51.53 (trex/7.0.3);
	Wed, 16 Apr 2025 02:02:13 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a270.dreamhost.com (Postfix) with ESMTPSA id 4Zckmg3Gr7z2c;
	Tue, 15 Apr 2025 19:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1744768932;
	bh=EgFwQezJYypIPTLjbAO7+wgBDKuxG1DACqpgT5oKBE4=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=CQPJelMkHR9c9PwOQz1qB9oLMoQ0ijerkO/7sTliU3wShQdMiumwtZeUz8qKG4hQH
	 P/+Ba9DrECHulLQADswnJQAn7N7p6JgJOjhObbZsvwzjl1ctJj9h4ZCrzAkqDRFUXu
	 p0S045L32lw1PwuZUJqHayjEwt1ltr9Rp+CEuY1ayAOdHWv190+04JcmqhwNHhuIhK
	 0/2MpjusbdsgGViBxeOeRKPuszsMvIgUOy21txdcZrW66eV/RDnRe9TOYDbaf6ZziO
	 fxFGoIfQeyeU/EDzaCZ+mmP69qqdonxNJRnFc4V8OBjj/3+x97Y7HdQmSxM8hXxUi1
	 VFDZD9KTPnAzw==
Date: Tue, 15 Apr 2025 19:02:07 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
	tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	riel@surriel.com, willy@infradead.org, hannes@cmpxchg.org,
	oliver.sang@intel.com, david@redhat.com, axboe@kernel.dk,
	hare@suse.de, david@fromorbit.com, djwong@kernel.org,
	ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com,
	syzbot+f3c6fda1297c748a7076@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 1/8] migrate: fix skipping metadata buffer heads on
 migration
Message-ID: <20250415232501.iypezdhizhttidpc@offworld>
Mail-Followup-To: Luis Chamberlain <mcgrof@kernel.org>,
	Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
	tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	riel@surriel.com, willy@infradead.org, hannes@cmpxchg.org,
	oliver.sang@intel.com, david@redhat.com, axboe@kernel.dk,
	hare@suse.de, david@fromorbit.com, djwong@kernel.org,
	ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com,
	syzbot+f3c6fda1297c748a7076@syzkaller.appspotmail.com
References: <20250410014945.2140781-1-mcgrof@kernel.org>
 <20250410014945.2140781-2-mcgrof@kernel.org>
 <dpn6pb7hwpmajoh5k5zla6x7fsmh4rlttstj3hkuvunp6tok3j@ikz2fxpikfv4>
 <Z_15mCAv6nsSgRTf@bombadil.infradead.org>
 <Z_2J9bxCqAUPgq42@bombadil.infradead.org>
 <20250415-freihalten-tausend-a9791b9c3a03@brauner>
 <Z_5_p3t_fNUBoG7Y@bombadil.infradead.org>
 <dkjq2c57du34wq7ocvtk37a5gkcondxfedgnbdxse55nhlfioy@v6tx45lkopfm>
 <Z_7KTEKEzC9Fh2rn@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z_7KTEKEzC9Fh2rn@bombadil.infradead.org>
User-Agent: NeoMutt/20220429

On Tue, 15 Apr 2025, Luis Chamberlain wrote:

>On Tue, Apr 15, 2025 at 06:23:54PM +0200, Jan Kara wrote:
>> So I don't like removing that commit because it makes a
>> "reproducible with a heavy stress test" problem become a "reproduced by
>> real world workloads" problem.
>
>So how about just patch 2 and 8 in this series, with the spin lock
>removal happening on the last patch for Linus tree?

fyi I sent out a new series (trimmed some recipients), addressing the concerns
laid out in this approach.

https://lore.kernel.org/all/20250415231635.83960-1-dave@stgolabs.net/

Similar to adding artificial delays to a vanilla kernel, the only behavior
these modifications cause is a quicker triggering of the aforementioned
(yet independent) ext4 warning splat/corruption.

