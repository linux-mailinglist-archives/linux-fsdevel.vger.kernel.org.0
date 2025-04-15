Return-Path: <linux-fsdevel+bounces-46509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A68A8A68E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 20:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B15D1190111E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 18:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C0E225A32;
	Tue, 15 Apr 2025 18:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="G4q6bk1o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from crocodile.elm.relay.mailchannels.net (crocodile.elm.relay.mailchannels.net [23.83.212.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABE021ABAE;
	Tue, 15 Apr 2025 18:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744740863; cv=pass; b=r6Uu797NoCSPCeDJ4C8VBRDzhwMW8tCKZKhDsXb+XdfoYutT0mZpTA9n/W7Y0eQYMze5Vg2jXGEO0UpDGgj0SGJIMp86AWAzzvZNOPdIwKarUqLY/eM11ogx7xSgFpiv3TGX/1vAeLMmzmquUbVkex81WOXFR36Fa4pLodHhddw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744740863; c=relaxed/simple;
	bh=bqPyP70PEWYuCJ6mlcNc67gGfoPR1cUIZVFQBbY62vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/X0GB65N+AH1BP84DoG1eaoGZIDfZB05R85XQZHNCQDUWAhFmcAIm8S75HO5dSl8c5ceyh5LxoyLnx6t8MDnovdROMwlT5Nf71goGtOF67jyEPFgZZvQDCIoaemuatV6t1lx0N0h6zl7Pc8B7yZXiK0FCf0wYPkvil5w++z/Ic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=G4q6bk1o; arc=pass smtp.client-ip=23.83.212.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id BDA8D8A5406;
	Tue, 15 Apr 2025 18:14:15 +0000 (UTC)
Received: from pdx1-sub0-mail-a279.dreamhost.com (100-110-114-166.trex-nlb.outbound.svc.cluster.local [100.110.114.166])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id A255A8A5D6F;
	Tue, 15 Apr 2025 18:14:14 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1744740855; a=rsa-sha256;
	cv=none;
	b=rkt5r0vZEQJ5SC5pH+p56jwbff5PHkchL641YfF5zY4myfshefBqFCcxyNAnOEVIQppNfx
	W8xnG6Op3/4JXDstAswcDJCJ/HdhoHyFMgRo2qqQ1JEiC+hwTeNyKm23WISfpKTKWE2gDS
	lc6EolQr0+wEbctjUNqxCImE8q1hV2yJK5Hb2arnulSVJ7wrtdFesxATmRvIjr4ZJ3dkSJ
	8uUz8uFuHQfsWlpTFHuTMyneccJBg/2nZqV16PrkkwcfyFj/i8Sx17Dh21TY/puTtSfePd
	mNE9XQxsLQ0sVQelYWYh4o2aQFQxuQJje+dfoN94kAbdDGC7V/YN3SiFv9B7/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1744740855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=bqPyP70PEWYuCJ6mlcNc67gGfoPR1cUIZVFQBbY62vk=;
	b=4py5Z77tpQMIkf0HN8tDSaA2mZazeLffSWythqK+dEKT1n+Ea5zoIfUBFyjUwE3IBwM93b
	dV1hmtAE/JIShWRYDVQfZyyphf77vD8lRKry9yrjjWLtsAd5EeY3rl0ZMBS37QkfiLBTx1
	HMAyN7dhi6F5BKmy7Oh4MDy3w0Onq3i0qf5n3umxioe2RNnTlXGHJyuopQYaDPE7SP7GId
	7twuseHwyIO0tm0UgJJW8t4ISPSWWfXz+jNlxTs3WsXHMyPDPLEJuTiyKQnhD3231tpwdv
	o8PoY0OoI++YIhUknkjMWKtLBfCyNCj+DbVHNdwLLVtrOcGbvHEQv9P2SyWZWA==
ARC-Authentication-Results: i=1;
	rspamd-5dd7f8b4cd-9lwvj;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Whistle-Ruddy: 20c0a1780448f057_1744740855404_3157517117
X-MC-Loop-Signature: 1744740855404:2507718386
X-MC-Ingress-Time: 1744740855403
Received: from pdx1-sub0-mail-a279.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.110.114.166 (trex/7.0.3);
	Tue, 15 Apr 2025 18:14:15 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a279.dreamhost.com (Postfix) with ESMTPSA id 4ZcXNj26v2zJB;
	Tue, 15 Apr 2025 11:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1744740854;
	bh=bqPyP70PEWYuCJ6mlcNc67gGfoPR1cUIZVFQBbY62vk=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=G4q6bk1oZJ4IbXrRbZv0DiKjppGGnWDbh0B6C8i1Po1oLU2A4Qe8htuO1ob0chAOy
	 nY56dU4ysVjX/YoK5elTTDcx5cLWSCjDvXQvvr9JbCTJunVrRfZG/kz7QKaqhXzBdA
	 UEnvnGFsO4KsatO1DV9k2HqWUOy/0RHN2aoU6rnNSSNIJR5QvRJC/ScdSpq/qF+55s
	 IHmYRN+vFHi6xWvMSDGRdAxqy9fYAGZaEx0hU9Z/nFCWKcnXM6Rio5tmHdOiNQ+4so
	 6ddPVbSHhJIZV55t62WCru9PvzJHwyLXS484xEzHSjxiypwFQCuP53pZYvnyVC1NY4
	 w9HA9WErc7h+w==
Date: Tue, 15 Apr 2025 11:14:09 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Jan Kara <jack@suse.cz>
Cc: Luis Chamberlain <mcgrof@kernel.org>, brauner@kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	riel@surriel.com, willy@infradead.org, hannes@cmpxchg.org,
	oliver.sang@intel.com, david@redhat.com, axboe@kernel.dk,
	hare@suse.de, david@fromorbit.com, djwong@kernel.org,
	ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com,
	syzbot+f3c6fda1297c748a7076@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 1/8] migrate: fix skipping metadata buffer heads on
 migration
Message-ID: <20250415181409.eqkichqm4dddq4z4@offworld>
Mail-Followup-To: Jan Kara <jack@suse.cz>,
	Luis Chamberlain <mcgrof@kernel.org>, brauner@kernel.org,
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
 <20250415013641.f2ppw6wov4kn4wq2@offworld>
 <kldodwnbi5ab5nostpqrbhxtolyzn5vqvmyjdwgehpkzknyrv4@u5y6ewg6hnon>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <kldodwnbi5ab5nostpqrbhxtolyzn5vqvmyjdwgehpkzknyrv4@u5y6ewg6hnon>
User-Agent: NeoMutt/20220429

On Tue, 15 Apr 2025, Jan Kara wrote:

>On Mon 14-04-25 18:36:41, Davidlohr Bueso wrote:
>> On Wed, 09 Apr 2025, Luis Chamberlain wrote:
>>
>> > corruption can still happen even with the spin lock held. A test was
>> > done using vanilla Linux and adding a udelay(2000) right before we
>> > spin_lock(&bd_mapping->i_private_lock) on __find_get_block_slow() and
>> > we can reproduce the same exact filesystem corruption issues as observed
>> > without the spinlock with generic/750 [1].
>>
>> fyi I was actually able to trigger this on a vanilla 6.15-rc1 kernel,
>> not even having to add the artificial delay.
>
>OK, so this is using generic/750, isn't it? How long did you have to run it
>to trigger this? Because I've never seen this tripping...

Correct, generic/750. It triggered after 90+ hrs running.

