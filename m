Return-Path: <linux-fsdevel+bounces-48787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 930B7AB4802
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 01:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E78E4462A14
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 23:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B59267B6B;
	Mon, 12 May 2025 23:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8zKnU2n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA0A79D2;
	Mon, 12 May 2025 23:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747093235; cv=none; b=j65UcWDpIvFhFOFjFf16tr9Jz+McUyBZ/g8Y26u48RLczi9MqJHaENtIMRPthjkw7M1KrFFrnam5NFAF3BfZuNE7hdx81diibhS86hHg0f/PUa5C4rAdUUon1g9ZPjBq241nOb1Q6i8waeMijYIQFktmKH6/dNYTjfRImnkNgGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747093235; c=relaxed/simple;
	bh=XpFUmPLDn67gUJ5IU2ERgA2EBgtYyvY1tJex1tyNjac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDaTHe8t7+zAAwi2k9CA53crjm6DwJ0edlQLhoAayXhh7QyI8WXZeiVefAc/pKgmfsLdKmhShH4Ucae+wrtXAB/MQnDbvne+G94u7BDv2VpXQInPpbkEp2xo4qjJWF8sFzJMPd9emSD6Qd86gZMpeNLGGMsxEDr+3s/PeUlvBBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8zKnU2n; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-8783d2bf386so1317555241.0;
        Mon, 12 May 2025 16:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747093233; x=1747698033; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XpFUmPLDn67gUJ5IU2ERgA2EBgtYyvY1tJex1tyNjac=;
        b=e8zKnU2najObSWctvBvgGeRGleFn2Hyy/jgD8uTOZapRVMkm7X3UTQSuszw8TJEq2v
         Shr+gvPoKoR1pU55EIkR62QCJ51JVJqSS5GB7m1+nIgdxabMrlY7XP6q/w46wEZyKdzd
         yGoAskrRDSNGjkTxV+JBB7jP8rFdlzMH273KThwnixsjRYT4Qy3ZEwGS/bc8jU9XrEbQ
         2gFQahfFuYRe4i5HnzqeFdHUAB0F48YE9YPZPzOAMrlfGUmHq+NzSRsjb6MkSLNoI7nP
         bhgaAWD15p+UpiATM3DsJYqPwUiOGKF5Pbu/QIILK3YJJ1yV1iEJzo2h2Q2pTXq3bV1G
         nE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747093233; x=1747698033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XpFUmPLDn67gUJ5IU2ERgA2EBgtYyvY1tJex1tyNjac=;
        b=ZEZuwzecsWOslMMBkzCRE5tXCo/cRsCRrcpn3DWNqlcsot4+j+srOG1u3grATnqKt3
         7bScHz5Rc04L6jyBjAnXnTDQYiDUhhsZs0Es9f1qtTR4PUqmOL6po4JpAR/fBZABXj7l
         kcNQxdTBYWos7NEJ+Exus+m7mPqN/09MnzE2Xj+uQlGEzkNTrhhq4Oiy9YlpyskWBQhx
         VBDqBVbXMSli1u022evXzRBQZIfcDGid6413QULkojjPejeN8cQGAxijGU7ilTNePwox
         n2ww/6cLrQqp9sd7QGnfnRrJNb0icl1yzE/XaYBJbK8RfHQ/xijatvPy8J/qJJwkXcDy
         lIAw==
X-Forwarded-Encrypted: i=1; AJvYcCUEn04s738ihQTesCxzkfEaXgrEr+D3pyRkEtiFUq8AlS/sXBNVRqZyIWzlTOEdBqVaN6DOb32Wnuu8JYJ3@vger.kernel.org, AJvYcCV+oEhZMCf9FOJ/3JgvjmjTARlXWhwmlFRMB0ZkAKAwuHNorJQ8coVMHv+HhNSFBRQ6N8L4mketP2JrwIIB@vger.kernel.org
X-Gm-Message-State: AOJu0YwEvc5U9s+uH2/C5/WrQ+q8AxSYVO8HgoMkfKO7UJ9vEAeLZBYp
	SzlrR/kRTYVwzB8Uu3JEwSwDqK3xq6LUDfytQyEB/nUhLvetPX/q
X-Gm-Gg: ASbGncsM6OjW/XbrYuV2fnnbFZOXaSoUNlyekkxu/ItsZVn05Lo29iCqQqfgmDrteGd
	g4JzuO4D7d2WahtZpqs89q6Yrn6lMpn+9cOucHrnqrwXaUm3I7ie42pbFehQm6zpnUaW+etKwxv
	BHCM28g1QemQ2EUHSEDL/a8Yog+paVRGCe+W0rETHCUehwDRR6I/6FO640bl3E2t24cXwGsp3TS
	5hQYa53bq8xPc5caNarHoN4XZKclflginKg3SNADz302L5s/Va+8KSPirqJ18b9dgdu30S+2Cda
	khU0oqXICWedQzosqk5qIkq8S33v+jv8muZVrfpm859eW4PZWSdjC88FbwDj
X-Google-Smtp-Source: AGHT+IGoypguHEsX6HpvemdJ88QptMQH6H/Q9D2t7EN+1BBtVIyJSPv44Lv+/lxCrY1e1SpOMmMQTA==
X-Received: by 2002:a67:e7cc:0:b0:4c1:85d9:5641 with SMTP id ada2fe7eead31-4deed370764mr13126706137.11.1747093232903;
        Mon, 12 May 2025 16:40:32 -0700 (PDT)
Received: from eaf ([2802:8010:d51f:e600:10da:2fb3:1edf:2e90])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-879f603551dsm6063651241.0.2025.05.12.16.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 16:40:32 -0700 (PDT)
Date: Mon, 12 May 2025 20:40:24 -0300
From: Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?= <ernesto.mnd.fernandez@gmail.com>
To: Yangtao Li <frank.li@vivo.com>
Cc: ethan@ethancedwards.com, asahi@lists.linux.dev, brauner@kernel.org,
	dan.carpenter@linaro.org, ernesto@corellium.com,
	gargaditya08@live.com, gregkh@linuxfoundation.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev, sven@svenpeter.dev, tytso@mit.edu,
	viro@zeniv.linux.org.uk, willy@infradead.org, slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de
Subject: Re: Subject: [RFC PATCH v2 0/8] staging: apfs: init APFS filesystem
 support
Message-ID: <20250512234024.GA19326@eaf>
References: <20250319-apfs-v2-0-475de2e25782@ethancedwards.com>
 <20250512101122.569476-1-frank.li@vivo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512101122.569476-1-frank.li@vivo.com>

Hi Yangtao,

On Mon, May 12, 2025 at 04:11:22AM -0600, Yangtao Li wrote:
> I'm interested in bringing apfs upstream to the community, and perhaps
> slava and adrian too.

Do you have any particular use case in mind here? I don't mind putting in
the work to get the driver upstream, but I don't want to be fighting people
to convince them that it's needed. I'm not even sure about it myself.

Ernesto

