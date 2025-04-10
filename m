Return-Path: <linux-fsdevel+bounces-46220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E6AA84B06
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 19:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAB011733C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 17:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9845828A40A;
	Thu, 10 Apr 2025 17:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="UUqUSk7O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from serval.cherry.relay.mailchannels.net (serval.cherry.relay.mailchannels.net [23.83.223.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0552853F8;
	Thu, 10 Apr 2025 17:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744306244; cv=pass; b=GNowVTcRKaG7+A7+YYgpdDlicRO66+eCx6w0+avBaWGkbZ2p9JC+KcIfLATvOvihIJVKUjmIqTjkg97aaATvMjX7gEap7tCIDYffQRe3gc8dBvWqoZS3N85nBfwyNbKZ8i2OiXp5/qHJsSqQeyoovvw6zzeyfP9imyGWTURg/1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744306244; c=relaxed/simple;
	bh=2zIEaRV4vT1EhWbqAg8KwbQXkdExAg1EqK3KM68lkao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9AbrLkTwDX4kDPqsbQ49Vr7D96ZoREEQpJpGjWJHkEsQQIuAsyvtbJ0KOWcNn1XPognyUXRX6Kot8fFIbeWZ3G/5bc3QHS3rOaqaaGmTi8Jxmt8w3013aDgn4tOgWHmDCbtLLsyjjn6SnK+rRLlclCSRP1yshMdN0UKIk4CbEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=UUqUSk7O; arc=pass smtp.client-ip=23.83.223.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id EADE8183A43;
	Thu, 10 Apr 2025 17:30:34 +0000 (UTC)
Received: from pdx1-sub0-mail-a250.dreamhost.com (100-97-44-91.trex-nlb.outbound.svc.cluster.local [100.97.44.91])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 628C91833A0;
	Thu, 10 Apr 2025 17:30:34 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1744306234; a=rsa-sha256;
	cv=none;
	b=Lm6I/Hb4iU7NDmuUwx5azvSi8cdQxTRmxGQP3eXZrbVMpBlOgLEFA/nsu9M14hpciulNAn
	Lvw01q6tMhj3RTrYGdThy1pg+VZWmO7oCM7DaAoQ9i4jrWO2WE2Os4eRSxT4szm7K6u8aO
	XlvvmV6lvTuPPz9dzOXHAbe9teRRT7j9PKiPDow5HZtF/4AGbY0yMQAypEVRscLVUcIxrG
	EjrEDqz2FHV6Ylg73qko53YW58DgdBcdN4JBvzLakV/n7rINk5TFWHOi3RAgb/bcy7FPXN
	zjDnwkfYRpy2OSZ4xmPxGlsM+mfolWJBlHOH74hJfhrvWe4E4SOEbMJmgfcf7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1744306234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=t+oYNTEtBazT/u3SGm75P4mURykaPqZ2OKAXDYWbnK8=;
	b=OZG4s0/FK+9IkHyZnUy+qgUH/wZyjaVygxj6jcxTfGl2x1J33Nl9l0HFSsRPy3XB9J4JxJ
	jjhKoe0DTpOz3i4ozIHz/NJIR1vvfQJXef11S24KfmCVqCR9qbI8PNnGRr+j+VoPsXJWkk
	BYb16icIKIsDXzoy1xEXgAksZ9Wlpph9JqhDW7uCFNKck+9lJ0ygAPZdSo006lmymz07x3
	fZGSZL1Tr7JuFKOCXhe6HUil2yveoIrZZPlhw1YgHAgUTtN86y1a0Y4hh1+2lxyIEkSOcK
	UyQTkY1DZ2ECpJYpQnLqx83WejBmuSAeAiFftvtsu2UjRRic+O4WTq+w3qOvuw==
ARC-Authentication-Results: i=1;
	rspamd-75b96967bb-96crn;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Bubble-Macabre: 37d8ce8e175e33a6_1744306234805_3271725725
X-MC-Loop-Signature: 1744306234805:3416749709
X-MC-Ingress-Time: 1744306234805
Received: from pdx1-sub0-mail-a250.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.97.44.91 (trex/7.0.3);
	Thu, 10 Apr 2025 17:30:34 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a250.dreamhost.com (Postfix) with ESMTPSA id 4ZYRfc28Cpz70;
	Thu, 10 Apr 2025 10:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1744306234;
	bh=t+oYNTEtBazT/u3SGm75P4mURykaPqZ2OKAXDYWbnK8=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=UUqUSk7OOKeKzELRdmJjZ9yqnpuWJsLNu6v90laLWXOp5BvYpMC6VcQ4GWYaKb3jF
	 zCzM6DQE1ub8ulevbbp1qfkmZwwxqRdqNS9qjv03NIqKR6HYjWqagFxf+/vn44lRt5
	 3cexnIPpJk1MEp6dKBw0aNCGan80IBTcUoQ7j6hm7d5i2detXiOhK/16Dz0i4akzWu
	 rcvVZ2bLoX1kJGryM4XYpO25ua1DxfHwmawajZJlbKE6OiuxdoBBWNIPbZjRJzYoqm
	 qgsiLipPCi4Ia5/6BEqknekJkKhN2s0309gtG9Za80C1oyfi87VZenrsKCS9Jf8Qgv
	 73VD0kT3iJN/Q==
Date: Thu, 10 Apr 2025 10:30:28 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Jan Kara <jack@suse.cz>
Cc: Luis Chamberlain <mcgrof@kernel.org>, brauner@kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	riel@surriel.com, willy@infradead.org, hannes@cmpxchg.org,
	oliver.sang@intel.com, david@redhat.com, axboe@kernel.dk,
	hare@suse.de, david@fromorbit.com, djwong@kernel.org,
	ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com
Subject: Re: [PATCH v2 7/8] mm/migrate: enable noref migration for jbd2
Message-ID: <20250410173028.2ucbsnlut2bpupm3@offworld>
Mail-Followup-To: Jan Kara <jack@suse.cz>,
	Luis Chamberlain <mcgrof@kernel.org>, brauner@kernel.org,
	tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	riel@surriel.com, willy@infradead.org, hannes@cmpxchg.org,
	oliver.sang@intel.com, david@redhat.com, axboe@kernel.dk,
	hare@suse.de, david@fromorbit.com, djwong@kernel.org,
	ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com
References: <20250410014945.2140781-1-mcgrof@kernel.org>
 <20250410014945.2140781-8-mcgrof@kernel.org>
 <rnhdk7ytdiiodckgc344novyknixn6jqeoy6bk4jjhtijjnc7z@qwofsm5ponwn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <rnhdk7ytdiiodckgc344novyknixn6jqeoy6bk4jjhtijjnc7z@qwofsm5ponwn>
User-Agent: NeoMutt/20220429

On Thu, 10 Apr 2025, Jan Kara wrote:

>> @@ -851,6 +851,8 @@ static int __buffer_migrate_folio(struct address_space *mapping,
>>		bool busy;
>>		bool invalidated = false;
>>
>> +		VM_WARN_ON_ONCE(test_and_set_bit_lock(BH_Migrate,
>> +						      &head->b_state));
>
>Careful here. This breaks the logic with !CONFIG_DEBUG_VM.

Ok, I guess just a WARN_ON_ONCE() here then.

