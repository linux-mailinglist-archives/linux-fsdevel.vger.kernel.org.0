Return-Path: <linux-fsdevel+bounces-50538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48086ACD02A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 01:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93FF51896308
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 23:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4612422331C;
	Tue,  3 Jun 2025 23:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NbpzYLiA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A552066CF
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Jun 2025 23:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748992682; cv=none; b=FXauV3XHfIHweArn8oZO9EceuGQh52NeHRkfIvITWhj5X1Ai1aNiCotgn02IUc5188wGG9gkzpHC5jB5zPCltRo7e3BmnIm4UBQ6zM8Zeqs15TS3hIGBvyLtcbv4xjMO/1Bmv49lWw2Aakw0JDiypNLEsYW3GiuAJS6d4Ha04Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748992682; c=relaxed/simple;
	bh=aKRTBTPzODxhjtmx1jxxWVRwUf2dDMPT+fN2VXGNFdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JUjeA7zkJURNJI6FFtxeHQOqz/xu3K1z07UPoIDsLEJG2n+QqEuPFgtKW6S1bqIjhcxuUv/wjDenAQSJlICuQ26Sq7BQyG+JdZy9vbmdnnMaOIPZmM1WMzZdjUFC8H6rto1ckhWrVKcb9MKqndO48FRhGtIi97O7djNFPQ9ldC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NbpzYLiA; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-606b58241c9so2250483a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Jun 2025 16:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1748992678; x=1749597478; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9ls4Z/Di/ECZk+H5cxevQ4VaCWIK0e7YkQdAFUYBELU=;
        b=NbpzYLiAPYsLJOG0pOPHBqGWQtdKo9lDKTGsoe4SD7DYxWELcLM8hRugIJwjj+rRr+
         dZruSetFaLoJmjktdi9YTJ7RPgRrxu52o7VyAdtd5RrVbMoiYBdoH4i9uj5MDvzwbDAO
         PC2ES3FqqQRUcvCW60Zvkq2ljjAl0McOidO+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748992678; x=1749597478;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ls4Z/Di/ECZk+H5cxevQ4VaCWIK0e7YkQdAFUYBELU=;
        b=uS+R90fLxV3ud21wIMQN8PBRgJ1qpscxYB8OifJ/LUURmM8BWwFvuGJid1YWfLbwKF
         I7NBGI9c8IyeXB/H7vtq5mpp7btRl5fxdB8n2xTVcpaVt5sOpRVgy0fvKa10bB0Ndsj+
         bOMXtc1gYUyOaT++aHK31vM9wLSak5XTpgDIkH8xHcpnzm0RRptPbBqLVi4GFZe98hhq
         f/iprYu2WkOonKtpiJpXktLjCtlwj3q6om46mOTN7+IJgCPOXvvlksfLh/4WsZ86dGpk
         NnJkmATktwd2ZQODYi5xfSht0JjjsMNHy14R+aGXdCFfWctCLLufljo/8XYwuLOjVf9q
         n/bw==
X-Gm-Message-State: AOJu0YyRbJfTmxQLVozLrsHYBPpTe84Nzt4x/6lmoucuMsdFKQWE3Uc0
	URyHy2MDRr8mRoo01kfhop94Q2n6lxgcF6EwxM6JrHvuDnVkRthQDEMEdjT4OC8boDhDc2nPZtO
	SGlGm1ZfPzw==
X-Gm-Gg: ASbGnctBEY08Yk4Mbcr2xHYf9HTkMYG/V+hzzs5w7ql5nl4EUmtD6KY9KWG1ZnW65gk
	7j3JwMI/rGxAqQjJmNEpGpsIGXnVscwKRtWACELlLHnJHLGBlCvxuQWsw+xQDf/aGEGdDzhGSvV
	kaxQ8KtrRSQYTRUn7H0egQKrm9mGtvPHIPrEUBQUngG5/ABCVgz/pHibBbinRIgc6nbj0VB/+yI
	x0e4Meqe+0QpPHaTpvFGUBfF4gOYIiXmChMTL2KATfc74qqWlsszwc21LtHcEXPp8u5fL0AM1aC
	/ifMHYAmk8JluJYdWuYWdXMWfYoEFFCOV8WOk+Axii3cQqTn2DvhWLpuU8m8q+r0y0o+ZljDxGb
	QvS9tL7KkZ02oDYNOohpMrF6y2FP0qACOYWQP
X-Google-Smtp-Source: AGHT+IF+JiTklaY/pKMn/5nDTu0RphW2OkUQjcH5FrgCSAlnlsHuC3pCV2UMMt16xM6kkQ3xNJm+6g==
X-Received: by 2002:a05:6402:2789:b0:602:1b8b:2902 with SMTP id 4fb4d7f45d1cf-606e941b388mr860080a12.15.1748992678237;
        Tue, 03 Jun 2025 16:17:58 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-606ec566bc4sm191450a12.7.2025.06.03.16.17.56
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 16:17:57 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-606b58241c9so2250437a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Jun 2025 16:17:56 -0700 (PDT)
X-Received: by 2002:a05:6402:510b:b0:604:a869:67e9 with SMTP id
 4fb4d7f45d1cf-606e9694598mr873295a12.22.1748992675940; Tue, 03 Jun 2025
 16:17:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603204704.GB299672@ZenIV>
In-Reply-To: <20250603204704.GB299672@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 3 Jun 2025 16:17:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgwWWxsivo8ggn7mz6cfjNX-zevq+fxkbpeJq_=P5U0+w@mail.gmail.com>
X-Gm-Features: AX0GCFuBxXhwnBslpm8XQiaQ0tPIETFEk5LG5lmeJOIEdEyhIdCCRgJOIC2MrrE
Message-ID: <CAHk-=wgwWWxsivo8ggn7mz6cfjNX-zevq+fxkbpeJq_=P5U0+w@mail.gmail.com>
Subject: Re: [RFC] separate the internal mount flags from the rest
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Jun 2025 at 13:47, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Objections?  The thing I really want is clear locking rules for that
> stuff.  Reduced contention on mount_lock and fewer increments of its
> seqcount component wouldn't hurt either, but that's secondary...

No objection at all, as long as you also change the name of the flag.
Which I assume you were planning on doing anyway.

We've occasionally had various flags that had the same "namespace"
prefix but were split across multiple fields, and it's always painful
and very confusing.

            Linus

