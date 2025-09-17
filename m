Return-Path: <linux-fsdevel+bounces-61982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D083AB814B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 20:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 114231C80D3C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 18:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A232FFDDA;
	Wed, 17 Sep 2025 18:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AcF2qaJR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B292FAC0E
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 18:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758132233; cv=none; b=ikjSJeYdP2M7lpTkLEO2k7Hjj4vVYuT7dVoLZTh2WhLNGkfzVVQx1q1nmPKJfwyqjXNQ/qLa4Ea1UP/DU6ZVkuqGzKZfCmuRJOOlLG6CSrJyPdkaoEZ8xvYWkgR9ml2g9L6SSzBjEyj6OejW732hXNlKxJ70VCXEF/tB3m7O44Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758132233; c=relaxed/simple;
	bh=Dl8/1xbvll9SNNPORV5wD3aLW8Yo2wXdT32MfHewHgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GXgGZkQDcVnTKrGaGrF8/MH9UmRjxDeFEalE/3hcigl8xJc6GQlPSReUcdoc7+mVjCnXeUoumJd0trCLDJN8QoC5QnwxlQLbcMFp67VHfjSYP5DQgilW6Evnd2OFUFc8YT/pC7iN0d/9RtGbQTbElfNIOdqIp5t2ArobE6U88lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AcF2qaJR; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b5eee40cc0so1213811cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 11:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758132230; x=1758737030; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dl8/1xbvll9SNNPORV5wD3aLW8Yo2wXdT32MfHewHgw=;
        b=AcF2qaJRmIFva6vSJx8CiYocTs+0gZGpFcswLaGxddDob2spa+FFOuJcZL/GqZnapT
         kC9kS/5HAMZ5ONne+4OQAFtGzVBPpVZI3CJpdiiEAlhIR0zCa04tzybroA8GxKGKLeGB
         ZNvcAjhkwNh+Fq6HFHbC9N2egX8bT9V4FEC9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758132230; x=1758737030;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dl8/1xbvll9SNNPORV5wD3aLW8Yo2wXdT32MfHewHgw=;
        b=Z8cTLIeghdk6fN27DU+PSsBwDVu3O/JBiaXrxRr4FhoCgtYN8VBo9kHkijOM2DZ288
         4/6tfCjexNefJzpr7tQod059dNA+hWRqY3gNnUmeKaqkvovyzRandQNyyklwQovAZ15K
         kTQcA/mhzuuCGZErzu+ZI/pNmZ0XP6mrRTQhqoDPLt1+PEpfbzfGDEH4yyEd8Jk2pFjt
         QOY5L0fmT6lzGZxi74EBU7b8/9ssWOWz4j8yPE8+vHp4j7akspp1oUDKysHOr33PDDvz
         c4/5STyuRjspAexzzsm9qq7QVRz+Uiu3We/lyBrtCCfgc8VEZr01cW2rLgdo12h5Make
         NIsg==
X-Forwarded-Encrypted: i=1; AJvYcCUuWy4v4HswgMftk3UDWikVb9eoVWpvio2k98HeWbbcjbX8kShBHJqz+uYa2Y3XKdhTs0WivxBX+F40u8At@vger.kernel.org
X-Gm-Message-State: AOJu0YyIuRg/MCwMIZR/hz/2dFmMsAg5VwBQzWdajpGorv6eCe0IbJMo
	jG8eD/QPi5OtK/7cz6eCDMwl7D3wOYUHWSUYRy0KDZHOkUny4VVu7ImS6xV9qAz6AsJoWEZRsBx
	y1XYiPQ==
X-Gm-Gg: ASbGncvRqVlnLNZVmdD2B7j0MLh4vLfXIxu8TSuhI6rxLcDU7n0pNssDmqHfHwT6wY1
	kpSXG1JHATlt1PchQ4ZnMsEV2xtEt83t40ufjnWGDcBcZN/f+BprWRkd5X+gKuCNu3/qa/AXfge
	UxWhOY3Mx4LBSyzLQ2wopoBJCdx9HYnvk5uDn5X4Yjcdyu0NOLDRAgTewp7dW8DgVaSNYJFr2Np
	OjwtODhXYAsogFiJVImow6b7tynpwnQXsn2eCdQoXeImRobD+X5D9KR77b9IeBvSiW5ds6C1vcH
	Q6/rE+EVe5VLJZnJzGhnAVH6orZejlgI8Z9t+0hzcyYaJoKeofmkQoFOBtqRvRhlj0esel6H66y
	MGDoC+Y0JYDIJq4JEFTu39GSkbwERvHZ/f/tI0HXK28vNYKvuhtbNbl8cmoyN9g4=
X-Google-Smtp-Source: AGHT+IGhyJUXqoVPMm/eFLIPB/85/jtnECEyBDDv7SujgfZiKEDH97oUxcOvpa/dUwbLA1Nco1VYIw==
X-Received: by 2002:a05:622a:5c8b:b0:4b7:983b:b70c with SMTP id d75a77b69052e-4ba6b4670c3mr42502061cf.67.1758132229502;
        Wed, 17 Sep 2025 11:03:49 -0700 (PDT)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com. [209.85.160.173])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8363203a546sm20060085a.52.2025.09.17.11.03.48
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 11:03:48 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b78657a35aso41331cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 11:03:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVTBQUBV9LvMsF4TlpJ6m62zRPXCVLbM9WdK1YLrZ/KgIIOniESbuSZPHml8DHfKHQt1un4Czt94DMe6Cxg@vger.kernel.org
X-Received: by 2002:ac8:7f91:0:b0:4b4:9863:5d76 with SMTP id
 d75a77b69052e-4b9dd3c17d4mr9004781cf.8.1758132227600; Wed, 17 Sep 2025
 11:03:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752824628.git.namcao@linutronix.de> <43d64ad765e2c47e958f01246320359b11379466.1752824628.git.namcao@linutronix.de>
 <aflo53gea7i6cyy22avn7mqxb3xboakgjwnmj4bqmjp6oafejj@owgv35lly7zq>
 <87zfat19i7.fsf@yellow.woof> <CAGudoHFLrkk_FBgFJ_ppr60ARSoJT7JLji4soLdKbrKBOxTR1Q@mail.gmail.com>
 <CAGudoHE=iaZp66pTBYTpgcqis25rU--wFJecJP-fq78hmPViCg@mail.gmail.com>
In-Reply-To: <CAGudoHE=iaZp66pTBYTpgcqis25rU--wFJecJP-fq78hmPViCg@mail.gmail.com>
From: Khazhy Kumykov <khazhy@chromium.org>
Date: Wed, 17 Sep 2025 11:03:35 -0700
X-Gmail-Original-Message-ID: <CACGdZYKcQmJtEVt8xoO9Gk53Rq1nmdginH4o5CmS4Kp3yVyM-Q@mail.gmail.com>
X-Gm-Features: AS18NWBTH_B8R-w_buHc5fkH54TOh_tt5uj3eXyk2xndepoDoKd89R4ajv-MBKE
Message-ID: <CACGdZYKcQmJtEVt8xoO9Gk53Rq1nmdginH4o5CmS4Kp3yVyM-Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] eventpoll: Fix epoll_wait() report false negative
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Nam Cao <namcao@linutronix.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Soheil Hassas Yeganeh <soheil@google.com>, 
	Willem de Bruijn <willemb@google.com>, Eric Dumazet <edumazet@google.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I think the justification for the original comment is: epoll_wait
returns either when events are available, or the timeout is hit -> and
if the timeout is hit, "event is available" is undefined (or another
way: it would be incorrect to interpret a timeout being hit as "no
events available"). So one could justify this missed event that way,
but it does feel against the spirit of the API, especially since the
event may have existed for an infinite amount of time, and still be
missed.

Glancing again at this code, ep_events_available() should return true
if rdllist is not empty, is actively being modified, or if ovflist is
not EP_UNACTIVE_PTR.

One ordering thing that sticks out to me is ep_start_scan first
splices out rdllist, *then* clears ovflist (from EP_UNACTIVE_PTR ->
NULL). This creates a short condition where rdllist is empty, not
being modified, but ovflist is still EP_UNACTIVE_PTR -> which we
interpret as "no events available" - even though a local txlist may
have some events. It seems like, for this lockless check to remain
accurate, we should need to reverse the order of these two operations,
*and* ensure the order remains observable. (and for users using the
lock, there should be no observable difference with this change)

