Return-Path: <linux-fsdevel+bounces-63554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A9CBC1C55
	for <lists+linux-fsdevel@lfdr.de>; Tue, 07 Oct 2025 16:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0956219A2B7F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Oct 2025 14:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498F62E03F1;
	Tue,  7 Oct 2025 14:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QOrvezoB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F66534BA35
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Oct 2025 14:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759847876; cv=none; b=msvNnj2zj7gN4urMKEXg1YSxkRkR0jnmoY/lSTAhdgVK9DpSCoZ4gFdG0c3oQq6Ki5FMQ2fwZqE5w0QXl6ZlXp9ePe2u7VyJIg6cCNo5hYvk2r/ZKxVe7HxsTx4eDThL789i7nhRgGUoBzrGv80edxmoX+We2JMjPoLrRl7sUU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759847876; c=relaxed/simple;
	bh=xbA/vOCemtbtTInzARhHUWKv2Yk4vi7C+6iBhm/9QwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=auyApOWt+8gO8BeBcbRI7hV25sp1LzeF25QEubikoZkyk6USS0tMGtKi2VTVX0LcJ1zv1reQ8mA/mSLsBWbYL32XxbneTkTJ1EWDCbOE3eGe970k+QpBBHq+R55Vgp04X+0c5P8jgMfXN8etG77dSJt7iNlkxhdlrLA/bGzRj5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QOrvezoB; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-635c9db8a16so6683990d50.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Oct 2025 07:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1759847873; x=1760452673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HeCKVhYwSuSkyQUvoOdDBGibmvtgPMz0EvM7ZPnUdiU=;
        b=QOrvezoB8McGxehhvBw7tZq1xJ8yVMtAjjd1qmOieQ02D4nedQdhfvbmjIX5EkYeaW
         ghRASaFA+WhcbrT6L41VZkg0w5yogxUZ6P2qGrhNPwUgLatTpy9mFV0Dj3pofPqP3Jst
         K9sMlgFftm3+YlCwYq4Czeppk9Il6UDTd1wm70BI2N9Iq8OWiaoaEsXp3FUmrJxaU+oQ
         DxhVB+0nOM7ioHKjlxj6MFK7cNdQ+SexpmeiS8+Yql/Yc0KVBcZDs6XuLKi034jgqCDM
         KJrN2tiBrKnmVqsuqYMuSD9pTpxGaufeJAeIvkn//jBhil4/cNB5VBu0BSO6zvj8SVEV
         n+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759847873; x=1760452673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HeCKVhYwSuSkyQUvoOdDBGibmvtgPMz0EvM7ZPnUdiU=;
        b=ms6l3ZR1wInmK19g+4q0zoYE0d6F9W64LcHKF7/xc5PUypoDizvP/hE5t3Rix93jop
         tWc32THk4mWfI+28a3ofnYVMlzqKAWCoYx6hDfT1NC3j2wQRHhTjeC+xVS5z8xHHwd8e
         f16jibEEpkhMutZFJCzCuP759M4Gz7uv5ib2zFSLxs+JNXckz6TZlfzX/4wzeqJb+T8Z
         4vVU4hbB3Zsug5aAE0DpFC5fGXBhaoGJd6G5eadCBzxzDIB+TUhF2A/cxicZFQNUlOT9
         9gSegzWJvGbjmkeAiIa9EICGI4hinxYNzseVdjVQApxV3lxyJs/hbEoFVesFBwi8Bmt/
         7dHw==
X-Gm-Message-State: AOJu0Yyy/7dpAFl6yr6Uim42O0PhttxdXLXY1XLyjUpwrN8dKAsp3rA2
	s1ZAmrhgDitWjBlEHhCrzxnxL0fugtbHEpkVMvywbmr2/9nmVSez4EAKVg5iblzGUKxdajpys7z
	c+x71G1MvTllTLc63wQ4/LQ4ZQq9HM/YRe6HKnbw4Fg==
X-Gm-Gg: ASbGncsEoS3lFtvzk/iQkYxg3nMr2b8QgYuAAKGN/T90v4SGBSTwjyBVfRe5lgfSSdS
	40BdtlMEgZAWviDyGVTRA9ndY8nfg6HzMAAdpROmbllsomRG7zFf1X6x4ORtuaR9VobtcBJdnGy
	2poj3Bo5j03T5iklUVUht56oWRfRi2YacQTpH5sIwlvIOGWHUy+58xaaz23CPqlsd4TWLXDvfDy
	RH6XPgf03Haj5MAwWcMxLBc/0FEs5DP/MGcGy0cO347PmwklOMgfEY=
X-Google-Smtp-Source: AGHT+IGd7ZCpvANiz+V6iz6TpeEqJdm9RZTPYG6LUrr5pHJyZJZY3pFJIt5BXtk51VAz06xzaulPKaDqkMABUJC+rbE=
X-Received: by 2002:a53:d20b:0:b0:635:4ecf:bdcc with SMTP id
 956f58d0204a3-63b9a10a79fmr11663823d50.46.1759847872762; Tue, 07 Oct 2025
 07:37:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930065637.1876707-1-sunjunchao@bytedance.com>
 <20251006-zenit-ozonwerte-32bf073c7a02@brauner> <CAHSKhte2naFFF+xDFQt=jQ+S-HaNQ_s7wBkxjaO+QwKmnmqVgg@mail.gmail.com>
In-Reply-To: <CAHSKhte2naFFF+xDFQt=jQ+S-HaNQ_s7wBkxjaO+QwKmnmqVgg@mail.gmail.com>
From: Julian Sun <sunjunchao@bytedance.com>
Date: Tue, 7 Oct 2025 22:37:39 +0800
X-Gm-Features: AS18NWC_xakesu1JDIruHUijFRo7fvsxNMKDDTMv8BR3ZI7RqpMU7F1gek5-OFU
Message-ID: <CAHSKhtckJwprCQapkg-AKaz-X_gjX7n_5+LzE8G7iZ0VzHCU3Q@mail.gmail.com>
Subject: Re: (subset) [PATCH v3 1/2] writeback: Wake up waiting tasks when
 finishing the writeback of a chunk.
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, 
	Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Kindly ping..

On Mon, Oct 6, 2025 at 10:29=E2=80=AFPM Julian Sun <sunjunchao@bytedance.co=
m> wrote:
>
> Hi Christian,
>
> It looks like an earlier version of my patch was merged, which may
> cause a null pointer dereference issue. The latest and correct version
> can be found here:
> https://lore.kernel.org/linux-fsdevel/20250930085315.2039852-1-sunjunchao=
@bytedance.com/.
>
> Sorry for the confusion, and thank you for your time and help!
>
> Best,
>
>
> On Mon, Oct 6, 2025 at 6:44=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
> >
> > On Tue, 30 Sep 2025 14:56:36 +0800, Julian Sun wrote:
> > > Writing back a large number of pages can take a lots of time.
> > > This issue is exacerbated when the underlying device is slow or
> > > subject to block layer rate limiting, which in turn triggers
> > > unexpected hung task warnings.
> > >
> > > We can trigger a wake-up once a chunk has been written back and the
> > > waiting time for writeback exceeds half of
> > > sysctl_hung_task_timeout_secs.
> > > This action allows the hung task detector to be aware of the writebac=
k
> > > progress, thereby eliminating these unexpected hung task warnings.
> > >
> > > [...]
> >
> > Applied to the vfs-6.19.writeback branch of the vfs/vfs.git tree.
> > Patches in the vfs-6.19.writeback branch should appear in linux-next so=
on.
> >
> > Please report any outstanding bugs that were missed during review in a
> > new review to the original patch series allowing us to drop it.
> >
> > It's encouraged to provide Acked-bys and Reviewed-bys even though the
> > patch has now been applied. If possible patch trailers will be updated.
> >
> > Note that commit hashes shown below are subject to change due to rebase=
,
> > trailer updates or similar. If in doubt, please check the listed branch=
.
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> > branch: vfs-6.19.writeback
> >
> > [1/2] writeback: Wake up waiting tasks when finishing the writeback of =
a chunk.
> >       https://git.kernel.org/vfs/vfs/c/334b83b3ed81
>
>
>
> --
> Julian Sun <sunjunchao@bytedance.com>



--=20
Julian Sun <sunjunchao@bytedance.com>

