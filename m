Return-Path: <linux-fsdevel+bounces-52288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E742AAE12A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 06:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E27481BC2193
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 04:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1930C1F150A;
	Fri, 20 Jun 2025 04:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VYxGS7kv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C675336D
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jun 2025 04:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750395234; cv=none; b=BN3LE860D2cl2OaI/3us5bnM1ENOqOQFW6qs/1vWCGqNQ1I3wFAENLAjl+Z+pzlxDcQU5R162yNvG/DxlgQDK8kOjGmmx3IGolrBKO3X80imAh5ENrAyK5rhfsE6X5NUI08Gcd5ygNRjHtuEkDLYzH4QLRrhhoIIVd/e2P7PoLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750395234; c=relaxed/simple;
	bh=E/YiGHnW1wZQ5X/0H0XDdrD4sDL0PuYMkMZ0cU3VFVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0OXisMQhvRdmWYS03U13vbQtrCM36lfhsRN5zyhX+Fb5yV6/N0tsFfyTqIBs25mRjJpfU4ZUGjwPIfRfzVcUc1svmlkOLhKhhzfVejBz+UYYijG84/JwtH7/1WkFoRKxIK6FipGStruUMaEx4d1ykV9vI3kIo87vyXWbazhqI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VYxGS7kv; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23636167b30so13094465ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jun 2025 21:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1750395232; x=1751000032; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q2G3dD31TRdLmU2kMFyJcNMrg5YHR0QH2/Tfvo3Rsac=;
        b=VYxGS7kv0WvICnF/14n2jOIJQ7K2q3TkVpgidj7fojgr4C4T8vd04Vp6eacnQKact5
         x70QzlIK7YU6UoezLZfoWwCbIXayGQqK0a6Qq6OX2Tg05Fi0CmjQyUxtTbJY+UmS+4pq
         hMbDGu4EdDWwlWImlDqTDy1ccuy5Ry+HdV5Zw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750395232; x=1751000032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2G3dD31TRdLmU2kMFyJcNMrg5YHR0QH2/Tfvo3Rsac=;
        b=hmazFJLOQkuNfHISf2aloa+/aXsbPTQQcPLw8dqFTHWj1FFouVd4xqyaoHunLjUR0a
         bsn1XWEaaQLHK323zOh/LcnnIB5pJ9U0s8SJXGeDaOEGwZm5DtOWzwJhWhra16xEeVBp
         PhplA1E2xvC2wOk0hZ7bfHHJl8Bj6MXrvXHc4PcOAmeNFZ5Pm8zZgctbn2YDv59ZjuCO
         eLAgBeBLcE10RpnIpJZzUJsQQWkXS8rgVm9BOhgK59O8MuEYgqbfS3Rdkt1mzAcQpB9V
         oaaTgA9Bc7ch84QPoSr15fZWD+sSJbNjp8vcEHvQdMfkuF7L5WhCvoxCnB01IHQ4eIJX
         x21w==
X-Forwarded-Encrypted: i=1; AJvYcCUDm1tgDLyKMax1IClzZ6mUXzwC1dG9c1E4yQeXa41qvJPV92Edr78c00Y+8BRj0Flxp1iBytF24TIlxvYl@vger.kernel.org
X-Gm-Message-State: AOJu0YwO00Y7xAy1qjnB3C/VAPXpm6FgHFQN9T7MZ0IlJ3KvroGO5L9F
	Grl67gCIuAdQ4NqemvGE9qYnK9YUvJpGl/IOXHjBn96tVx+a0/oWyPXPHdZmXUns4g==
X-Gm-Gg: ASbGncskrJlBIOIitPGF+O1CFKKpFjPmLV5P9KlnwjqeY9BrHeQWEBmof9zqEQ52vfK
	OJSfrhoHYkSdAqC3ejfJkqiVnY3gdUwDHl20MTm4QvjFdL+i2maL0HCuIyS6Te5dOx0b1OAPH90
	nFcUMVXYG2x1pho8QUFoKrdqc6ZxHUqzxfohMROAOgOwQ8PJjmPDNV25JDaranLElt1AZk3scWA
	y9vEKjP+YxgMsDQUMFB0SEBKWYwY9hnJ4Ub8WEIAvEyr4+D748G9RtrmNfyPpjVxIsUStx7cfok
	F9f5XR9rWeqcv3PK7p3xrj/VU98aDYxNeKjgADHpR64dcGESOFSL1E6ZUicud3/FKg==
X-Google-Smtp-Source: AGHT+IFk7B8k/GlrcRZRoZuXgJlsllcTVXF/E2PZN7eWGLXhECASjJTNH1UzB9LoljR7ceAwxCiMEA==
X-Received: by 2002:a17:902:e842:b0:234:ef42:5d48 with SMTP id d9443c01a7336-237d9980027mr24292165ad.38.1750395232197;
        Thu, 19 Jun 2025 21:53:52 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:e574:cc97:5a5d:2a87])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d860a854sm8018115ad.116.2025.06.19.21.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 21:53:51 -0700 (PDT)
Date: Fri, 20 Jun 2025 13:53:47 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>, 
	Matthew Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [RFC PATCH] fanotify: wake-up all waiters on release
Message-ID: <76mwzuvqxrpml7zm3ebqaqcoimjwjda27xfyqracb7zp4cf5qv@ykpy5yabmegu>
References: <3p5hvygkgdhrpbhphtjm55vnvprrgguk46gic547jlwdhjonw3@nz54h4fjnjkm>
 <20250520123544.4087208-1-senozhatsky@chromium.org>
 <bsji6w5ytunjt5vlgj6t53rrksqc7lp5fukwi2sbettzuzvnmg@fna73sxftrak>
 <ccdghhd5ldpqc3nps5dur5ceqa2dgbteux2y6qddvlfuq3ar4g@m42fp4q5ne7n>
 <xlbmnncnw6swdtf74nlbqkn57sxpt5f3bylpvhezdwgavx5h2r@boz7f5kg3x2q>
 <yo2mrodmg32xw3v3pezwreqtncamn2kvr5feae6jlzxajxzf6s@dclplmsehqct>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yo2mrodmg32xw3v3pezwreqtncamn2kvr5feae6jlzxajxzf6s@dclplmsehqct>

On (25/05/26 23:12), Sergey Senozhatsky wrote:
[..]
> > >  schedule+0x534/0x2540
> > >  fsnotify_destroy_group+0xa7/0x150
> > >  fanotify_release+0x147/0x160
> > >  ____fput+0xe4/0x2a0
> > >  task_work_run+0x71/0xb0
> > >  do_exit+0x1ea/0x800
> > >  do_group_exit+0x81/0x90
> > >  get_signal+0x32d/0x4e0

[..]

> @@ -945,8 +945,10 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
>         if (FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS)) {
>                 fsid = fanotify_get_fsid(iter_info);
>                 /* Racing with mark destruction or creation? */
> -               if (!fsid.val[0] && !fsid.val[1])
> -                       return 0;
> +               if (!fsid.val[0] && !fsid.val[1]) {
> +                       ret = 0;
> +                       goto finish;
> +               }
>         }

Surprisingly enough, this did not help.

Jan, one more silly question:

fsnotify_get_mark_safe() and fsnotify_put_mark_wake() can be called on
NULL mark.  Is it possible that between fsnotify_prepare_user_wait(iter_info)
and fsnotify_finish_user_wait(iter_info) iter_info->marks[type] changes in
such a way that creates imbalance?  That is, fsnotify_finish_user_wait() sees
more NULL marks and hence does not rollback all the group->user_waits
increments that fsnotify_prepare_user_wait() did?

