Return-Path: <linux-fsdevel+bounces-9281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F04883FBE7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 02:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58AF2282776
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 01:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9B4DF57;
	Mon, 29 Jan 2024 01:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EPoje+CC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EF8DDD4
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 01:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706492573; cv=none; b=bQc78R7Y4cYLNFbRJkkOSDSd3ll11uQat697iEFmQFy0KZ4DKVUqxSrGbTTDtQPIXKzHnh6Ox1P6+S0OPJ4E478W6nlIeo8mVcgkikDMMpbqSAtvTXnUcmVpib5z3Y8cnvVexTwl3tFBp+RPD1v/XRPUO0ViXokKW8SfjFj9kbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706492573; c=relaxed/simple;
	bh=jWloI5phTfFMjDxmvM5fOgnQ0vyxnALm4mf/sCbpm20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qn+Y7V6ziid4XNRwwJYBOUjqa4sS3XJRrZ/lc2I8jw3TSTYo8HVRsSIMygHuEb3U8Ic7MjytRiSVw9bxfb3ii3caDOfDSPqXe85SVSo9hyDWDc5427z0Mj1ED2DD6+xhAJG4ea0DRPPnuOjZpxZhuaxRGmhXj750DIOH5+vDPNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EPoje+CC; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5110c7b4be2so666692e87.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jan 2024 17:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706492569; x=1707097369; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tmwJigiCm1y/pWMgjrvap0eEiQZ4O/kCC0i78tTYfew=;
        b=EPoje+CCAclWIpjRXfnDgG3Nz6WnRC8FZSxgmqIW8oLuvFk+EL2fhnGYmcDKWsV/u9
         j93QXlJX/RY1WivxAJHmBGl9sJpY6s9dD0nYkITI45Uv7aQUJotzdrLn9RYZQ0R9MlzE
         Yt5wBhzMZUpdxTvQLImF0fnPd/gzDtDsBwUzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706492569; x=1707097369;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tmwJigiCm1y/pWMgjrvap0eEiQZ4O/kCC0i78tTYfew=;
        b=qo2bUzbsX2+qKSdJ7aKMRlo86uDxVvS9lJNdoQYm/xrhuJuRmf6dhxp5UZh5qjIuTv
         jnN4YxbiAB4eS2/AKNpWWIsjhXL0w2/0gVjLNtcQBhp6AOarDkPZRIpFWBe/HJP5Qprt
         yy5afAk4ZsJkOgVcxPHdymF7/kWgojxUW/KJ4YRgiRgcq1YDIDCvfBdIH5FFRrihSvHF
         8kFv7U7J1GI8TIkRwN3bMShx1b0T1GU5E7xF60tiaxTVnflVZUyPe7K5Aixv2zRsf0tH
         UaU5uaSO32QfT9be14Bq5NdA380Li5xgLEZWqHwfr1Dh2eMf8EPU+R7RpCUcj2AN2Xww
         d1FA==
X-Gm-Message-State: AOJu0Yz09VzWRCzjdfboISbOOARsf3hC3nUTFt9UlWzW1bl8C+nOA87S
	AaLGOXXjGDDqaPagl8XGBFV/s/bi0pwvEb17FWgMBVb0l2th7S2z/ZHzFjio6Yr/B80TxN10bGq
	gbaLb/Q==
X-Google-Smtp-Source: AGHT+IHWTNLCizM7BGsaHZo4aPpI0wyi0zEKSlMRurpspW0vIn9p/6qZCvA/sjRvWoxShwvGBQO9Ww==
X-Received: by 2002:ac2:482d:0:b0:510:2582:5592 with SMTP id 13-20020ac2482d000000b0051025825592mr3479782lft.38.1706492569200;
        Sun, 28 Jan 2024 17:42:49 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id vg14-20020a170907d30e00b00a30f3e8838bsm3361830ejc.127.2024.01.28.17.42.47
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jan 2024 17:42:48 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55f0b2c79cdso177320a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jan 2024 17:42:47 -0800 (PST)
X-Received: by 2002:aa7:c70f:0:b0:55e:c2d9:3750 with SMTP id
 i15-20020aa7c70f000000b0055ec2d93750mr2555420edq.5.1706492567478; Sun, 28 Jan
 2024 17:42:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126150209.367ff402@gandalf.local.home> <CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
 <20240126162626.31d90da9@gandalf.local.home> <CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
 <CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com>
 <CAHk-=wj+DsZZ=2iTUkJ-Nojs9fjYMvPs1NuoM3yK7aTDtJfPYQ@mail.gmail.com>
 <20240128175111.69f8b973@rorschach.local.home> <CAHk-=wjHc48QSGWtgBekej7F+Ln3b0j1tStcqyEf3S-Pj_MHHw@mail.gmail.com>
 <20240128185943.6920388b@rorschach.local.home> <20240128192108.6875ecf4@rorschach.local.home>
 <CAHk-=wg7tML8L+27j=7fh8Etk4Wvo0Ay3mS5U7JOTEGxjy1viA@mail.gmail.com>
In-Reply-To: <CAHk-=wg7tML8L+27j=7fh8Etk4Wvo0Ay3mS5U7JOTEGxjy1viA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 28 Jan 2024 17:42:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjKagcAh5rHuNPMqp9hH18APjF4jW7LQ06pNQwZ1Qp0Eg@mail.gmail.com>
Message-ID: <CAHk-=wjKagcAh5rHuNPMqp9hH18APjF4jW7LQ06pNQwZ1Qp0Eg@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Devel <linux-trace-devel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Jan 2024 at 17:00, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>    mkdir dummy
>    cd dummy
>    echo "Hello" > hello
>    ( sleep 10; cat ) < hello &
>    rm hello
>    cd ..
>    rmdir dummy

Note that it's worth repeating that simple_recursive_removal()
wouldn't change any of the above. It only unhashes things and makes
them *look* gone, doing things like clearing i_nlink etc.

But those VFS data structures would still exist, and the files that
had them open would still continue to be open.

So if you thought that simple_recursive_removal() would make the above
kind of thing not able to happen, and that eventfs wouldn't have to
deal with dentries that point to event_inodes that are dead, you were
always wrong.

simple_recursive_removal() is mostly just lipstick on a pig. It does
cause the cached dentries that have no active use be removed earlier,
so it has that "memory pressure" kind of effect, but it has no real
fundamental semantic effect.

Of course, for a filesystem where the dentry tree *is* the underlying
data (ie the 'tmpfs' kind, but also things like debugfs or ipathfs,
for example), then things are different.

There the dentries are the primary thing, and not just a cache in
front of the backing store.

But you didn't want that, and those days are long gone as far as
tracefs is concerned.

              Linus

