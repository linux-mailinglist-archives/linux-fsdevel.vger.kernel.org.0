Return-Path: <linux-fsdevel+bounces-63796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F788BCE18F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 19:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3619B4EF649
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 17:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2E972614;
	Fri, 10 Oct 2025 17:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="YhBjrtSf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12894A02
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 17:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760117755; cv=none; b=XdAB2FBEtIe5SeECCWMZgHGJdwN9J7fzPVFQWsrCvgZhwyPrnXhm1ybwS8LU6CZV4wQv0OLzzVWOk0ZstnPnP/Z6YIoMa0WZfB1RhCBRH+xbewI5fCfidO7TosKiJrTix11ghVok2GnEg787Zmf/719xfeWubpzMnlk2HSPSfBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760117755; c=relaxed/simple;
	bh=IggglKYr/mYXyJC0Xtb77bCR7NPMqzz+1XJexnGAlKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D1sSk5Z0R2RHIG0PpL+I85lX7HbBSdktmGX3WrHVvap87p+bzel40TfQswLX2yau48pww4IGf9RAS7EGGuo2/mnoVrGYzZH2w1cjoKhnYnYga6GkzwSI+e+D4z2UTfU5CLFlRyyjhShlef0ZLR50gLUXCuvRZL7pt3fF8oTa4ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=YhBjrtSf; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-57e8e67aa3eso4174948e87.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 10:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1760117752; x=1760722552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WaJha/RTsiGsaafyilWUj58SigVqroEjGwJdfzbg+mo=;
        b=YhBjrtSfFIlndoPYWOsFp+0K5W9+lhszy5jBkHHzwMqs8geondC4Zn9mT8GGrFJFyG
         sTmfuLzn4xBXtWjMJw8D56dl/qyuXW09Swxs+1WDhLP7UcfOHr2/vigGr7kWy5l7WsIn
         lpYVjTwhFTH5Bmt5ElPpT9YlnFECjR2fXeeFGRMptdiO1b0xt6FE3J7Xs1O4zXze7RPR
         lb/s1mgGJbrr5LPaNMZ+CHM0LRrs7NNbjdHV7LNG1v0aVmW4kinIzYOuYG9c8R6uMeJB
         rf0h0jOTG4WJGwl/r99s6dWmZkedeKkj0mhVDYDMW27B9FnA4m2syfqalXRsShC0LosZ
         fvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760117752; x=1760722552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WaJha/RTsiGsaafyilWUj58SigVqroEjGwJdfzbg+mo=;
        b=TxAx+O2rZthZxAO05HtLBbUOViUEkLLXk9Hq3VApqX5clAqkgER9iyoLABZSRxw+8Y
         3HNOB5GcBTr6cBht0h5h8SNjzJmPHAXVhj92NKOiXVItCyyk50o0PjQ2+TRA0e8LKhzo
         5qIlh/J8EsTf9T4w9LlTfIrF+dpzm51H7FJU6VkL77kYZVlaGnxRVv158bTHQxr77CZ8
         g6ybyZ7GNZWzoOPcfptYibYhX8SK8pXDORWAY+IPUhZRh5jG06K8aA0LaH4s4v5IP4OA
         Fsrp2JGRrbUL1Glq9HLMT/ADEJYSPr9f7Nj9HGcFEtUiGltCXqBcTDrQUOjbQTF7LwyW
         8oWA==
X-Forwarded-Encrypted: i=1; AJvYcCXvewmXZyi4s741oCYirpKUw4iXqFInlCQpZjJkDoTnYaM6WoaiI6Q1I17zTCOSeS0g9Pdvgoe0wo0xk5rj@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4SobpHaSnPQBYigR/QlCG8R0EJbnsWdxRNHDj4pKZMvh6BEVw
	ffhx+htPlrrz4rqFPD2Le9Rv/jIotnfohTKnbRBKa5dWhpiJga230rPNQatHtErrnyRQJKVlLlf
	jfgVE+cqJA1D7xGOwI2igYKSYz7n2FiyHmOUlGKmW
X-Gm-Gg: ASbGncsaJ83067DghNh8avhP6BcxPadJ1rOLM8qy/kemBqm5iBqJcNmGYHato+H6TlB
	Uu56bpp9STzGZk1uttuIoSqbt14QNCsqvNhF7xnEhfwcPtpjekUjVflIRNjfh0tIJ+Rf1Fr1oYz
	kh80rMNyQFt6xavazjUzVNZFg30mH/iA9tuA9Ubt6/g7/X8N5fMje8sR8cKw7eOImdsxJrzN6ib
	fTUOvpplJjGnpldivOeiBMz
X-Google-Smtp-Source: AGHT+IEg7U2mRo/sCuEaMBZi05IWQuozDnPwTLA4K00+QiyXbv0V6gmyV4WkX+TMmnnBajijbS/MI1qHRlcuMRqTE5k=
X-Received: by 2002:a05:651c:1543:b0:372:8cb2:c061 with SMTP id
 38308e7fff4ca-375f50e0c56mr40792551fa.8.1760117751464; Fri, 10 Oct 2025
 10:35:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003093213.52624-1-xemul@scylladb.com> <aOCiCkFUOBWV_1yY@infradead.org>
 <CALCETrVsD6Z42gO7S-oAbweN5OwV1OLqxztBkB58goSzccSZKw@mail.gmail.com>
 <aOSgXXzvuq5YDj7q@infradead.org> <CALCETrW3iQWQTdMbB52R4=GztfuFYvN_8p52H1fopdS8uExQWg@mail.gmail.com>
 <aOiZX9iqZnf9jUdQ@infradead.org>
In-Reply-To: <aOiZX9iqZnf9jUdQ@infradead.org>
From: Andy Lutomirski <luto@amacapital.net>
Date: Fri, 10 Oct 2025 10:35:39 -0700
X-Gm-Features: AS18NWBX3sP91gIkaFjkVoWU_yHoCZUlMOojFvFO4ylrXOUPmoyQCz0m51oXW2k
Message-ID: <CALCETrXLu_iarb7TWC_6kP8c2Yyh-PweRsKhiHxS=takbG_Kqw@mail.gmail.com>
Subject: Re: [PATCH] fs: Propagate FMODE_NOCMTIME flag to user-facing O_NOCMTIME
To: Christoph Hellwig <hch@infradead.org>
Cc: Pavel Emelyanov <xemul@scylladb.com>, linux-fsdevel@vger.kernel.org, 
	"Raphael S . Carvalho" <raphaelsc@scylladb.com>, linux-api@vger.kernel.org, 
	linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 10:27=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Wed, Oct 08, 2025 at 08:22:35AM -0700, Andy Lutomirski wrote:
> > On Mon, Oct 6, 2025 at 10:08=E2=80=AFPM Christoph Hellwig <hch@infradea=
d.org> wrote:
> > >
> > > On Sat, Oct 04, 2025 at 09:08:05AM -0700, Andy Lutomirski wrote:
> > > > > Well, we'll need to look into that, including maybe non-blockin
> > > > > timestamp updates.
> > > > >
> > > >
> > > > It's been 12 years (!), but maybe it's time to reconsider this:
> > > >
> > > > https://lore.kernel.org/all/cover.1377193658.git.luto@amacapital.ne=
t/
> > >
> > > I don't see how that is relevant here.  Also writes through shared
> > > mmaps are problematic for so many reasons that I'm not sure we want
> > > to encourage people to use that more.
> > >
> >
> > Because the same exact issue exists in the normal non-mmap write path,
> > and I can even quote you upthread :)
>
> The thread that started this is about io_uring nonblock writes, aka
> O_DIRECT.  So there isn't any writeback to defer to.

I haven't followed all the internal details, but RWF_DONTCACHE is
looking pretty good these days, and it does go through the writeback
path.  I wonder if it's getting good enough that most or all O_DIRECT
users could switch to using it.

--Andy

