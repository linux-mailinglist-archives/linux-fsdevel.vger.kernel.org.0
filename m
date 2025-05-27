Return-Path: <linux-fsdevel+bounces-49892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B28AC479E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 07:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36D9B1894FF7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 05:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D4E1DF244;
	Tue, 27 May 2025 05:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z5oE8IYb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB9113AD3F
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 May 2025 05:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748323726; cv=none; b=lR/Kb20YQvAYPD+WUxMjJbmv5GdPVQjDCJrwdij13Z1czVNjc0k4tqr0DLo9lReI0fN5CuyObW8Uequa/B8hR45j2ov4SYmdezPsXc6XcfC63aM+Vb8GkuLsJKgPgbF3opPt023ccnOoyA1zEKx585qK4HaHpKPOIDlWW5I689k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748323726; c=relaxed/simple;
	bh=1Sib9gBMl8hnWPq2xz0C25YBREla2zAHNdN1LcPwDVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W0L/I/QLqZxUeqtnQQyegXlURFFU5+3dKN0YE5t4m6bcYDI5xJYOg0TTV3MAujANbs4DTN0eK0FTFTKr1jTLnNs/eOIx0qf+3fdoGIA3IOSqi3vub9ZOWuLw6slyxDobdl1DoDlQaEvSZ/YSIq//pUW8afVqaJJKV4c/tOariKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Z5oE8IYb; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2347012f81fso16506175ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 May 2025 22:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1748323723; x=1748928523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aMPUq7D6PukAbWgN0eC3EH73KmEOPEeZrHNJC7dBZq8=;
        b=Z5oE8IYbwTHYNBQWEXkZnSghcLm0bxUSAUl/Wdm3vzQmOtC98jMd06Hsqu3hAyzkVk
         4h0qzi1jUwflICqVvllKisH5TaVS2G8rfpgsGKvBWTBc2bpDUAtcKbrOeYR72BLw5HpU
         LcCb/Vzj/RpaY0M5vVtGPa1jnsAm7rF6LW3pA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748323723; x=1748928523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aMPUq7D6PukAbWgN0eC3EH73KmEOPEeZrHNJC7dBZq8=;
        b=AhPGFYhOMM20kmEv1+gbNwNPGoBCZScXoDGmLZDAUYZOdlfg32MlokCJcCohZU/RtJ
         xqwWngTDovL1XTaGnIddrdAabyj6XjmSBWl8qOOCakvvbInJLJXeWfTIr9d5D3vlzZob
         qdciuiU/06OjBBFNkyZAhPsT2mvP4w9xeoYHlW60iOC8o8waUF/Du3m5Nn95sejAIjQN
         caIyk/yhwtWuOzkYc8bXqHrwYEKW1u7RtRwU+tU9ldn2+uBDN7Jy83hK9ontl3LeGqeG
         vIwV8F3QWc+YfPF5u75xha0GGJeBtk4zQVBLvbOhIvSCG6Vds1Q9JklYds0d+aFchEC/
         xuQA==
X-Forwarded-Encrypted: i=1; AJvYcCVpgEnF7avW5Xq9ImocwXYn+vPKrhMDo+53HrvW1VWQHk+PHgs/7wpESXLYW18EqjvcVUGzg+eRz/gW6kro@vger.kernel.org
X-Gm-Message-State: AOJu0YyzO4qKFbdC6lxH1wqtvT3fXwt87VdV82x/Mus2phFSejq9tupj
	RTTJ7El1KjvV6xu1NtkbeZyS4eIm60Q+ar+ddnkx/pecUV4zrwMXrPgaZH6yXGQjPQ==
X-Gm-Gg: ASbGncvv113ELgJyIbImREphoVq8lhDVDc2SXf0ubXjOkP0Wn9HsPk7qkJx71fNDILM
	0Yn1UBxxHcTYW66rSFdgB+H5BWNdC8WwDfLfgL0MPLeoYO0uWfipd5aYyXCvG8LIwnzTbaHh5tG
	4JimMjKe/agV6jYBsfy+WSAxdcBAApib4/wr6rtJUrNxZhwqhAhjwhfo6bUq3cTulmi8e58NKI6
	j5XW0lt1v1GK9f0xbUXUZKG7dx/yuQ5P0m2d1jS/gbMnue9Wn6T35Al/jlIgjPvyTrRWFf3e6sU
	lr3JCHWGU52GhkjeDS1FNEzxUtsdWm1Hs7TY9Gr3EHtc1KupEoRpTmc=
X-Google-Smtp-Source: AGHT+IEzAcpd5IAd/5qHpi0TBrWgDvqlGt9jD8mtQVODpolQ+2SSc4qm1HBo7vCFZixFRyqqMGV4pw==
X-Received: by 2002:a17:903:4296:b0:234:a139:11fa with SMTP id d9443c01a7336-234a139147dmr5707465ad.3.1748323723167;
        Mon, 26 May 2025 22:28:43 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:c29c:b6db:d3d9:3acf])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23444765fe7sm35561665ad.0.2025.05.26.22.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 22:28:42 -0700 (PDT)
Date: Tue, 27 May 2025 14:28:39 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Jan Kara <jack@suse.cz>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] fanotify: wake-up all waiters on release
Message-ID: <yo37kh4b27m2v5uddoorxmuhxif5n56hrc5h7ndl5btghiovdj@lsriah45m5ua>
References: <3p5hvygkgdhrpbhphtjm55vnvprrgguk46gic547jlwdhjonw3@nz54h4fjnjkm>
 <20250520123544.4087208-1-senozhatsky@chromium.org>
 <bsji6w5ytunjt5vlgj6t53rrksqc7lp5fukwi2sbettzuzvnmg@fna73sxftrak>
 <ccdghhd5ldpqc3nps5dur5ceqa2dgbteux2y6qddvlfuq3ar4g@m42fp4q5ne7n>
 <xlbmnncnw6swdtf74nlbqkn57sxpt5f3bylpvhezdwgavx5h2r@boz7f5kg3x2q>
 <yo2mrodmg32xw3v3pezwreqtncamn2kvr5feae6jlzxajxzf6s@dclplmsehqct>
 <pehvvmy3vzimalic3isygd4d66j6tb6cnosoiu6xkgfjy3p3up@ikj4bhpmx4yt>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pehvvmy3vzimalic3isygd4d66j6tb6cnosoiu6xkgfjy3p3up@ikj4bhpmx4yt>

On (25/05/26 18:47), Jan Kara wrote:
> > Another silly question: what decrements group->user_waits in case of
> > that race-condition?
> > 
> > ---
> > 
> > diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> > index 9dac7f6e72d2b..38b977fe37a71 100644
> > --- a/fs/notify/fanotify/fanotify.c
> > +++ b/fs/notify/fanotify/fanotify.c
> > @@ -945,8 +945,10 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
> >         if (FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS)) {
> >                 fsid = fanotify_get_fsid(iter_info);
> >                 /* Racing with mark destruction or creation? */
> > -               if (!fsid.val[0] && !fsid.val[1])
> > -                       return 0;
> > +               if (!fsid.val[0] && !fsid.val[1]) {
> > +                       ret = 0;
> > +                       goto finish;
> > +               }
> >         }
> 
> This code is not present in current upstream kernel. This seems to have
> been inadvertedly fixed by commit 30ad1938326b ("fanotify: allow "weak" fsid
> when watching a single filesystem") which you likely don't have in your
> kernel.

Oh, sweet.  Thanks for the pointers, Jan.

