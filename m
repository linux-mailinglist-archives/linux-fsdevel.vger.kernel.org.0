Return-Path: <linux-fsdevel+bounces-39170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A37FDA11093
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 19:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0A9F1887592
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 18:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4833F1FCD0B;
	Tue, 14 Jan 2025 18:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="dI6aJoAK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0634118952C
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 18:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736881106; cv=none; b=fEcARruHdj9ptLeiJgVf9cal/1itNK7VGGYphAnZTevCdQNU8U90+89o6WqMAIslAWSpd0/VAJVEaJMnV3kzftaZiqlu6J19VnYN17wD0Que4yLMI9m3Efwu17OtO0WEtDNC4YCY/pJ6vGSpgBOT9UI3rNCsBofpQ7e4pOk0b1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736881106; c=relaxed/simple;
	bh=E22XMeXcNnEZ78hii3SpuED7iwQCwqwXb5d7n9hxVJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XOZWCTGctCQAQQ15h9fDQGGKkvmWbAKfbgupJ3gLfSXMEYtQsLav4dd2Jf16au8AjrvELeJ39rAFjGA5uIKDjIQpK+GQCsRi51y6iuQ3cvvNYlCWIM6dYrwytkBWMTNaBWP76I9UAaBwOx0rt2xCMINSj+ZPiqlsN7nNtQvy++Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=dI6aJoAK; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-467a3f1e667so39255161cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 10:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1736881104; x=1737485904; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/WzFf6cXletL0uXmsxaDWc/Nt+YM0HqJR8M/t9ippOg=;
        b=dI6aJoAK8+na1oMmIQ7J+RKEP1ikkDJhlDMKhghW0/649pPMIksu/eLBpw8Ekog2I4
         kZfYzbAgZManAq2U3dAeh2KMQBqCE31HYsvzmxHtNN3GYyqF9SIn/odAy5UpGkwJdSGS
         aWEb/tRum8eHm43vYUJ1i5VutwT610J2tOpFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736881104; x=1737485904;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/WzFf6cXletL0uXmsxaDWc/Nt+YM0HqJR8M/t9ippOg=;
        b=ALmVTOelImiQUJ3iVU9sAqGv026w7/ZSwPelf1kLmtfpeWEaNjHHGvQsVzMM7navwZ
         AczA+Hph/o37QNQcT6Wp1C2qpYr1qeFM5DpOKTVfnybJl48wU435YH3Jmh9/wROwsyrc
         PiGWsVoHorVs7wsuRAif/vSssCf3bGiRrXaTM42s/0J2LsI2FVsdnKeZfB7potJROQ5/
         PPBr9FnhRad7v7Q8dhaFqX6L/aflBywRlWZ52VIvhGbMd1hf871O/DHFyTnH3lVlVA0a
         Hn5HhBpfIEWxisyStBzbRXxvL0lbd7pEQYo27f30l9JIC4+dP4dOdF6dtdJhPb7lRQgP
         MfrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWInXNOSC560xqUrCuHBpM6GSmaVrKHxxQvdYJedicv/QYkmxgTk7PZciVHWyetxTTK4vXgMc00PfJ3XbSi@vger.kernel.org
X-Gm-Message-State: AOJu0YzQzOiS6qIEDpOfzXJWdh3rrn+OBv8hz73eMhLzUDJ3fucVtvgk
	vxZPj9RQCs0QQ1yZsYUHH4G0Rj/oxWbJrnbWu3geUcYWQ9i6AZ2iIEuNLDNoQJDZvZiEPNFbo3R
	Eemu+k0cxRCIMMAEY8yUVtj1PtDuHBBmIXLrQZA==
X-Gm-Gg: ASbGncsOfQJBqswEcfOLPQ/d6pM9Zdl/sKub1dFeyEtP/zY/YyxQqOrJv832+ygD5vD
	hVI1V20gTNDebaMI3E50wfRgzXMAgtj+8qwJD
X-Google-Smtp-Source: AGHT+IHKs3cu6tkz43TIfe0jWaTc0n3EfDjVYt7Y9K+iXgi+jBHFRqM+oGMhKLnNGjobnnoRhLRc7QepTP8256Doxt4=
X-Received: by 2002:a05:622a:1494:b0:467:50d0:8866 with SMTP id
 d75a77b69052e-46c7108ebb1mr431321431cf.19.1736881103975; Tue, 14 Jan 2025
 10:58:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <hftauqdz22ujgkkgrf6jbpxuubfoms42kn5l5nuft3slfp7eaz@yy6uslmp37pn>
 <CAJnrk1aPCCjbKm+Ay9dz3HezCFehKDfsDidgsRyAMzen8Dk=-w@mail.gmail.com>
 <c04b73a2-b33e-4306-afb9-0fab8655615b@redhat.com> <CAJfpegtzDvjrH75oXS-d3t+BdZegduVYY_4Apc4bBoRcMiO-PQ@mail.gmail.com>
 <gvgtvxjfxoyr4jqqtcpfuxnx3y6etbgxfhcee25gmoiagqyxkq@ejnt3gokkbjt>
 <791d4056-cac1-4477-a8e3-3a2392ed34db@redhat.com> <plvffraql4fq4i6xehw6aklzmdyw3wvhlhkveneajzq7sqzs6h@t7beg2xup2b4>
 <1fdc9d50-584c-45f4-9acd-3041d0b4b804@redhat.com> <54ebdef4205781d3351e4a38e5551046482dbba0.camel@kernel.org>
 <ccefea7b-88a5-4472-94cd-1e320bf90b44@redhat.com> <e3kipe2qcuuvyefnwpo4z5h4q5mwf2mmf6jy6g2whnceze3nsf@uid2mlj5qfog>
 <2848b566-3cae-4e89-916c-241508054402@redhat.com> <dfd5427e2b4434355dd75d5fbe2460a656aba94e.camel@kernel.org>
 <CAJfpegs_YMuyBGpSnNKo7bz8_s7cOwn2we+UwhUYBfjAqO4w+g@mail.gmail.com>
 <CAJfpeguSXf0tokOMjoOP-gnxoNHO33wTyiMXH5pQP8eqzj_R0g@mail.gmail.com>
 <060f4540-6790-4fe2-a4a5-f65693058ebf@fastmail.fm> <CAJfpegsrGX4oBHmRn_+8iwiMkJD_rcVEyPVH5tBAAByw4gSCQA@mail.gmail.com>
 <CAJnrk1ZP4yZZDR0fZghBmuN-N=JfrbJZALBH0pdaC5_gGWFwEw@mail.gmail.com>
In-Reply-To: <CAJnrk1ZP4yZZDR0fZghBmuN-N=JfrbJZALBH0pdaC5_gGWFwEw@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 14 Jan 2025 19:58:12 +0100
X-Gm-Features: AbW1kvZdiun2F4o3_s0jXL2ZodO0oFy95oYHpuYNK56cTPlZwwnooKjPTUDzXbU
Message-ID: <CAJfpegvqZnMmgYcy28iDD_T=bFgeXgWD7ZZkpuJfXdBmjCK9hA@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Jeff Layton <jlayton@kernel.org>, 
	David Hildenbrand <david@redhat.com>, Shakeel Butt <shakeel.butt@linux.dev>, Zi Yan <ziy@nvidia.com>, 
	linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com, 
	josef@toxicpanda.com, linux-mm@kvack.org, kernel-team@meta.com, 
	Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>, 
	Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 Jan 2025 at 19:08, Joanne Koong <joannelkoong@gmail.com> wrote:

> - my understanding is that the majority of use cases do use splice (eg
> iirc, libfuse does as well), in which case there's no point to this
> patchset then

If it turns out that non-splice writes are more performant, then
libfuse can be fixed to use non-splice by default.   It's not as clear
cut though, since write through (which is also the default in libfuse,
AFAIK) should not be affected by all this, since that never used tmp
pages.

> - codewise, imo this gets messy (eg we would still need the rb tree
> and would now need to check writeback against folio writeback state
> and against the rb tree)

I'm thinking of something slightly different: remove the current tmp
page mess, but instead of duplicating a page ref on splice, fall back
to copying the cache page (see the user_pages case in
fuse_copy_page()).  This should have very similar performance to what
we have today, but allows us to deal with page accesses the same way
for both regular and splice I/O on /dev/fuse.

Thanks,
Miklos

