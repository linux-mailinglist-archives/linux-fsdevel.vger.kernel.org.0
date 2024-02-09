Return-Path: <linux-fsdevel+bounces-10915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 079AB84F3CF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 11:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4929B24538
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 10:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3C425629;
	Fri,  9 Feb 2024 10:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="QWeivL+X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FC82560F
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 10:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707475859; cv=none; b=Mwi4+0NDGeiAdb8M0egO+h/MjuhPgFJSE5J+mY4Zm8X9UH2pOS6QCnoq17aZ50tgNYjI2DLQIWbIf6m0x4ya/Tigs6n/QbSUYJ5h0pKh5CLKY2pQANRQWbgqPRfD3oWYbwUIKKVYkLDwRWRbh+yEQWKVSa9tiPiRbaFBZD3q7rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707475859; c=relaxed/simple;
	bh=dc26LiReYCWMJ6Qh6WbioB67jp51bbn9sD9cCkeh/Rw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S6tqRKB3KKBHStuGmaTjFSSQQBbTpIHx/47qeyILAF85zdAEqru+7+jnUiYNKEP+ZQVUrJEV5mzTqV6XOAGJju0gSQCfUBnvG3Sdxcla/bQyYwrWeRKffDtMRhCj0eVOOD9GnFY/o8sFIZvohJb4ygvWSdXPi/60eKFTRNJgplE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=QWeivL+X; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56001d49cc5so994683a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Feb 2024 02:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1707475855; x=1708080655; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aBX0TN7XfaZPT2aCL0bx3hGF5/5aXMKfUL0x4Jgf+Wc=;
        b=QWeivL+XTZpS+mmJ/SV/tWGKfFKdFyRULXynORs2tjz3OGTWdpAod7YzfN5ecPu55K
         MvbM3eaV3TyerLn/O+dl/g+P8knhA16/ZX5BUsRdTGmf0BG6gwBW0g8eBKFWgoT8gEbo
         VMG5F2vYEG6woqoKyNyPynFaq8Iu5C/7QRSLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707475855; x=1708080655;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aBX0TN7XfaZPT2aCL0bx3hGF5/5aXMKfUL0x4Jgf+Wc=;
        b=ZwQ6GfaZd0By/ZqZOLFJmt+gVVgNwkmCl1Mk7R/wduArJ2Co3LgleHn2YSqWs+/DY1
         aB/j+cbl4kuDvrHjhT1DoNHH3L/zljFOT2tJOz65CvZ24UqBv8WjvO2ZSw8I22WEYOAQ
         Egc6Zy/dFWLTNesbLGdAtT/ve17g8cPxgG5w2KSmfDFm3bDhc5KorKz5BpBaQ3R4Q0sq
         zkpfv/YpiVMYg2oDF/33KHwEjeniXfEaJ5okCUtnZ9SHweJHgg06JG2khAOm2RBiFtx/
         0EkeOnDOYRO6iky8NXhds6NqMrLEPlBUBPf5O6Aeh1ga/PkkGLxk0AIDBOZQu389Jbs2
         K3mw==
X-Gm-Message-State: AOJu0YyKrWj1SRcyua/c6Vash9PgBa5Bx4+MKAUiS2AedOApS9Mnl3D5
	A7OAF24oOZUTG9asOzxOQvVI8RS/+7R99SjpWtoj3Ww+uJztH7wJ1p8beNBt4hJ96r7gpY8NSBX
	SmzOymzNYW8jcuV9zInuBuvm3pe8jp78p5yTreA==
X-Google-Smtp-Source: AGHT+IEjzbTnV+sSgcBtRLYI8PST85FNGtVgIUHCQpGwLA4DkdFLTUJ+6LHWiAllMjxUT74ZpYKyQMXt4WKMSNGKN20=
X-Received: by 2002:a17:906:2452:b0:a38:15a5:ea2d with SMTP id
 a18-20020a170906245200b00a3815a5ea2dmr847771ejb.66.1707475855505; Fri, 09 Feb
 2024 02:50:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208170603.2078871-1-amir73il@gmail.com> <20240208170603.2078871-10-amir73il@gmail.com>
In-Reply-To: <20240208170603.2078871-10-amir73il@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 9 Feb 2024 11:50:44 +0100
Message-ID: <CAJfpegtcqPgb6zwHtg7q7vfC4wgo7YPP48O213jzfF+UDqZraw@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] fuse: allow parallel dio writes with FUSE_DIRECT_IO_ALLOW_MMAP
To: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, linux-fsdevel@vger.kernel.org, 
	Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Feb 2024 at 18:09, Amir Goldstein <amir73il@gmail.com> wrote:

>  static int fuse_inode_get_io_cache(struct fuse_inode *fi)
>  {
> +       int err = 0;
> +
>         assert_spin_locked(&fi->lock);
> -       if (fi->iocachectr < 0)
> -               return -ETXTBSY;
> -       if (fi->iocachectr++ == 0)
> -               set_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
> -       return 0;
> +       /*
> +        * Setting the bit advises new direct-io writes to use an exclusive
> +        * lock - without it the wait below might be forever.
> +        */
> +       set_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
> +       while (!err && fuse_is_io_cache_wait(fi)) {
> +               spin_unlock(&fi->lock);
> +               err = wait_event_killable(fi->direct_io_waitq,
> +                                         !fuse_is_io_cache_wait(fi));
> +               spin_lock(&fi->lock);
> +       }
> +       /*
> +        * Enter caching mode or clear the FUSE_I_CACHE_IO_MODE bit if we
> +        * failed to enter caching mode and no other caching open exists.
> +        */
> +       if (!err)
> +               fi->iocachectr++;
> +       else if (fi->iocachectr <= 0)
> +               clear_bit(FUSE_I_CACHE_IO_MODE, &fi->state);

This seems wrong:  if the current task is killed, and there's anther
task trying to get cached open mode, then clearing
FUSE_I_CACHE_IO_MODE will allow new parallel writes, breaking this
logic.

I'd suggest fixing this by not making the wait killable.  It's just a
nice to have, but without all the other waits being killable (e.g.
filesystem locks) it's just a drop in the ocean.

Thanks,
Miklos

