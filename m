Return-Path: <linux-fsdevel+bounces-33327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE57B9B7582
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 08:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D52431C216CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 07:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D7314B08C;
	Thu, 31 Oct 2024 07:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wsqz2dvT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBBD1494C2;
	Thu, 31 Oct 2024 07:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730360554; cv=none; b=UfLeMv7u0B2yVgAyNNTLdWtVkBquNIDmDKrbt4PfXFLhE6Dw+7hgb98njpLKdzKmHhy7EMXk9KQQahiztVyLSi6WcJBjt/n9NBdZ0b61bHQkFHMiH0YTKpPg+jIt4VqzWitL6+jnF/31s7nfqOZ26G4lzS33IILRnNVhFO/t6kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730360554; c=relaxed/simple;
	bh=Cm1ePPY50HvXXACjlxjtVpKghXaONxJD6t8CIkZJam8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nP4mfg+YeHGjAD1k63uTzf17Z7Oo8LyxwMyMKvKrTuNXUuK0JzO0LewyAaH+ys3RJBSUOODxlV6b2u4h/nofo0Myp3tHewZ2hAh34zCIssu5/qZAkjCKzpgcvEIqi8ty5mmiOpBYJYAo73RS9TkHSyhLWDcOS9ph/2Zax3/+9zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wsqz2dvT; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso88349566b.1;
        Thu, 31 Oct 2024 00:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730360551; x=1730965351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cm1ePPY50HvXXACjlxjtVpKghXaONxJD6t8CIkZJam8=;
        b=Wsqz2dvTSRP97nbFKnE2xx6nhBe6DciuBBG8PLdvjq2qrAih/gBfJGpe0XbueFVzQp
         SSYwNL06aYU/SKbcG9pL3fIiX9dyJkoLG62Q99fwdc+j1kFxcfLYKsv+fFXadO6zN4vG
         XJIvV+uVu57WFNvIFdR/4g5vxsqkZydoHSBLUQIbAdRBmK/PNj1oNSvVca9wpIzFgZGm
         QKC37ZjrQoV0I0gVFFtXk6/IEeshxGOvBxcSVlJScTXBB+GvMKItveIe1H6fk7MkpC8t
         HDZRB71hT8kgS5MT3l+z1BmpLSXyXCSg74PEi6IMwH6zJhsOvFNEvBmytKLD8uDZLagX
         zvsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730360551; x=1730965351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cm1ePPY50HvXXACjlxjtVpKghXaONxJD6t8CIkZJam8=;
        b=iLuyD/y591ysZI+0M1zsbu+RorTvkyg4KmX7nTlJMIdUWfVVE49wPwx0RP3Jc/+1d0
         YcCJcpJ6O/bSViMVlghmcrDNN/sBfgRPuchrtTcsTq26qTuQfUyuQGtJSkkWkoFhCr+g
         xY14da9xtBnaJk/LtTuGKGIDkqB4eTzQS2H7VTtDyllS4JdJp8dDI2JR1N8p8qKvXPmR
         n/It9xXdzorEnaV6iXE8+6pGcd9EKTObYZIPzPIQMJVItgqb7d52KEVFESBEQrx/Zu9k
         x49efKibXxhYJ8/vzfXWQqoqZR7WsaGGqSEsAHS9rN+NcDJ8skBrGO/EqPORYdruWa+q
         btvA==
X-Forwarded-Encrypted: i=1; AJvYcCV8FZLK0FZO/P0ApHtokU0aPsZng/aTn1V7GhLBpxCJDh0MvrqHcMqsonq5UMNFLyRGLSQG0yAY6w/63xwx@vger.kernel.org, AJvYcCW9N+/qFVQzvfTsX/eUCfjjGEF+p1BcqQZk5GdBP9U2DWnkQSb11F9kR+nPnbLCf7x2/fLMafxMbpbQUYZG@vger.kernel.org
X-Gm-Message-State: AOJu0YyTOoxtNRA6LHTsm0pBu0rx7oA6LsEXzQ/WFnEXoxf5FKZcBSF0
	n12ndmWVp3xSG+kQo51Ohzp5UYd1XnYtokM66KZW1Yw6Kb1bNAj5mPVKnt5EmeOJyRAu/3zSwhS
	Sz/7J6RtWVNNDMxkk8PGlQlmoq68=
X-Google-Smtp-Source: AGHT+IEAsrZ04qOp5HUPiMXHSYCKf7ywUxkMsfYUIUBhyrjq2ngvTN436ihH6lVXI09jaLuNlZJdvsDck7l2NJnAVzU=
X-Received: by 2002:a17:907:72ce:b0:a99:7539:2458 with SMTP id
 a640c23a62f3a-a9de6455bf8mr1576175566b.65.1730360550601; Thu, 31 Oct 2024
 00:42:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614163416.728752-1-yu.ma@intel.com> <20240717145018.3972922-1-yu.ma@intel.com>
 <20240717145018.3972922-2-yu.ma@intel.com> <20240814213835.GU13701@ZenIV>
 <d5c8edc6-68fc-44fd-90c6-5deb7c027566@intel.com> <20240815034517.GV13701@ZenIV>
In-Reply-To: <20240815034517.GV13701@ZenIV>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 31 Oct 2024 08:42:18 +0100
Message-ID: <CAGudoHEu07q72u_XFH61kGXyKr+vAqGFhn_tSSu6U2uMDABLdw@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] fs/file.c: remove sanity_check and add
 likely/unlikely in alloc_fd()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: "Ma, Yu" <yu.ma@intel.com>, brauner@kernel.org, jack@suse.cz, edumazet@google.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pan.deng@intel.com, tianyou.li@intel.com, tim.c.chen@intel.com, 
	tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 5:45=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Thu, Aug 15, 2024 at 10:49:40AM +0800, Ma, Yu wrote:
>
> > Yes, thanks Al, fully agree with you. The if (error) could be removed h=
ere
> > as the above unlikely would make sure no 0 return here. Should I submit
> > another version of patch set to update it, or you may help to update it
> > directly during merge? I'm not very familiar with the rules, please let=
 me
> > know if I'd update and I'll take action soon. Thanks again for your car=
eful
> > check here.
>
> See the current work.fdtable...

this patchset seems to have fallen through the cracks. anything
holding up the merge?

--=20
Mateusz Guzik <mjguzik gmail.com>

