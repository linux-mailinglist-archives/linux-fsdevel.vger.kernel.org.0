Return-Path: <linux-fsdevel+bounces-35641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D229D6A83
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 18:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB0A3281EF7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 17:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89EC146013;
	Sat, 23 Nov 2024 17:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="S104uy/M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E14E11CA9
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 Nov 2024 17:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732382355; cv=none; b=oN9pkCb1TD/sVcuE0w37WEEVxvr0glpCfIXdTR5UhI7VUoNcJL7f5jmOMj3aWrwckdqzNexo9ln/X70sHwjDTbjFrVizafDxRV5vuDnyemtZlm4iPjq3gYKFoLr8bDqkdcQh/vPY1MO83wNRRHzTudvSQY4yPEKEE0Uw36+MQo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732382355; c=relaxed/simple;
	bh=QNIZtU4UrRNcRlunJNgMSCglLrYx5rpbKWGGR17NwJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rMaexwX/cJ7d9Ahd8Z80F7kMCR3YuOX+pQ+5zn4+ItiL2egPk3n7LXpReOOZrBSQ/9aixlNLzQHGTpe/EB2F5OG23QvrnuY2Hp7fOpWMHi3KjurHE5BfqQlT8vaFuM4cueT8Ih3q4/+TIxydok4U2cUyMU1MDYKSIrcyVHcWXJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=S104uy/M; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a850270e2so516709066b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Nov 2024 09:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732382351; x=1732987151; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d5ChkXbScmteXOdHtNzIaXrYK9u5mdbWBULNnkBZeec=;
        b=S104uy/Mmq8ePJYaZ/iehPGsIQiH7DO5g7nZXzIqaTLvWthUwAeeYjwBXxZrOLp8qN
         PELXalv34hVIbzFhTiVuXHR++UdJcZalj2OGQuvlLHK+SJKCnC2uDHkIkp63bnAKayWl
         N5qMPHa3gejLeODnNIJuurFLxIm+exhuroOfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732382351; x=1732987151;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d5ChkXbScmteXOdHtNzIaXrYK9u5mdbWBULNnkBZeec=;
        b=s6Xf2kKKoJYuMe3sEzZjesnsIK7nqqSYa8J0bZPaCRVCD+c+rzgl6GXmVP8W/6O1cE
         ujybUKJy0dBLA1Aqj6/15Xaw59NcVVt64gfvCTfQybEGfJ4TViqU0UC1fC9CBy3/WfBi
         oXGJEHS4BvMdiwsbMFIOT7LyvLWbSaLNnL6FdgU5xjxqROXgP7z+UZIF+bIlYD6vC+7P
         0vuFoKx7SNWGAXLxSPOW0wUcgGQL0svVOmTVANL48BCaigmCSNWxFnr4bDDMH+5XQvz8
         kzK9dMB22d6qnl7Trn7QkH8bG345F4dlsENzPXe2I2rm0E33q80I4d+pLhTfMmhIrkWE
         FbFA==
X-Forwarded-Encrypted: i=1; AJvYcCWX+Ie5MaUnOZqY8nPic8TCjjxCRkv2CqUqy9ZgZN9ef5h2bp89flAVczs0GHH8V4RQRXTwARNZAHc07OAV@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9c8qeFoyIPjNQTlP1aLj4Qcns2kz4YmQ8jfRNZ8rc8AQaFwis
	FTq4k3IfXrln0WkaFyscwPiAxknNGMrp5jQsmTECGyFoRcQAKrTFAEBLZ65TQVsPLfVgXu/WSiF
	4D3K++A==
X-Gm-Gg: ASbGncvWfE2ZAGnGGHfOTzp+xTlsmzYOapXCXbb0wcCidYNrdk3Bc7h1CQ+6B7V7Exo
	Z6FYzJZoJNOJhQRtcPblbek3rKmpOTAddWOkawf1I6jkiNkszjc57RZBhrquQKePh8iGXyalv6v
	bcBDZ1KaR8Ts5W+8hHDHKJUjqX2em58kM1L54EWkTuZMrJnmwSPd7a4JTz2Wqqmtm11fJkzQSze
	7NblNzxuH5MCYsn2f+RDHRSkS0ERFzRbynMlrYKuYYU0j5UP661lqnb0DhozoKdPQl6VkMTZupM
	Q8WpchRM1HU+JTqHnhedh+xX
X-Google-Smtp-Source: AGHT+IEKiCSOTK1dmx9CsyWwibkiv9U4dgMx5TC1cTej+d0q30QH3EAmj3GW+2ylyIy5aLSPh0o6dQ==
X-Received: by 2002:a17:906:cc0e:b0:a9a:ea4:2834 with SMTP id a640c23a62f3a-aa509984a83mr556223866b.33.1732382351503;
        Sat, 23 Nov 2024 09:19:11 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b57c1e6sm247526666b.157.2024.11.23.09.19.10
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Nov 2024 09:19:10 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5cfc035649bso4227934a12.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Nov 2024 09:19:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVpT/sM72sC2bgHL1COlHZWSxImtGfLRfjOYJpHLhU8AxH56gPsuZQf0mWutALtdi/Ada85LM2CNTkMzoxx@vger.kernel.org
X-Received: by 2002:a17:906:2191:b0:aa5:cad:eb08 with SMTP id
 a640c23a62f3a-aa50cadec25mr539778766b.39.1732382350257; Sat, 23 Nov 2024
 09:19:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122095746.198762-1-amir73il@gmail.com> <CAHk-=wg_Hbtk1oeghodpDMc5Pq24x=aaihBHedfubyCXbntEMw@mail.gmail.com>
 <CAHk-=wgLSHFvUhf7J5aJuuWpkW7vayoHjmtbnY1HZZvT361uxA@mail.gmail.com> <20241123061407.GR3387508@ZenIV>
In-Reply-To: <20241123061407.GR3387508@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 23 Nov 2024 09:18:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiWYnr+V1-RbgvxkuD6uSQUJWGuounVMXThyH8jJ49c2w@mail.gmail.com>
Message-ID: <CAHk-=wiWYnr+V1-RbgvxkuD6uSQUJWGuounVMXThyH8jJ49c2w@mail.gmail.com>
Subject: Re: [GIT PULL] overlayfs updates for 6.13
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Nov 2024 at 22:14, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Fri, Nov 22, 2024 at 10:09:04PM -0800, Linus Torvalds wrote:
>
> >  (a) add a new "dup_cred()" helper
> >
> >     /* Get the cred without clearing the 'non_rcu' flag */
> >     const struct cred *dup_cred(const struct cred *cred)
> >     { get_new_cred((struct cred *)cred); return cred; }
>
> Umm...  Something like hold_cred() might be better - dup usually
> implies copying an object...

Ack. "dup" is clearly a horrible name, and I'm ashamed and properly chastised.

               Linus

