Return-Path: <linux-fsdevel+bounces-28446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D4D96A563
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 19:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E684BB26FDC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 17:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F2918DF78;
	Tue,  3 Sep 2024 17:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1LYCDhi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1425618BC22
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 17:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725384368; cv=none; b=u16Gzw7KCp0L6yayHf8nmmxSOy6JUuO5O9/iJzfqeXjGqu/kZKEDAnsmZmj4Y83js9RBnpku6BBZg1Luu1Dypjp1UWw0MuEfI/gMzKBWr4xQ1iitfppwpAIMkdmSpgEIPwVSP8KSTDP8oh25hJV/WKOwRwpPTjIMc4Mso66t29s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725384368; c=relaxed/simple;
	bh=YbyfSo8to798X5Ze7/wc4HFakG0YE8HNXsMjW30KYhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rfroH5VrUol/30vS9gEWelCa+U/oUEcrq1fO8ZUCAHQJsqmXvP4lp2HTZ2vYyeEHDPNDmaX4D7aJIlnEa+tuqweP8jqCoC8rCec2X4x9tIINC9tiS9j3qtUleQap28ht853ExTmPBfNluDj4Tr2+fRA4yG3w/Xlpc5nWAjf3LLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1LYCDhi; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7093ba310b0so2377819a34.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Sep 2024 10:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725384366; x=1725989166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1oPWbt0ldNgNG7GSta+oIeTV2yMUTpvbZFiQloqBLQ=;
        b=M1LYCDhiVt0JCbRcbB9usm8FkHsBSnFjcm1op5Y7zZrmSQIUsDMwk1yOvN5qVzWaBD
         y8cYHNIa5DtZg/ldMMHdcv+L+bkqp/L0qkbwJInNs3fMogUVIHPEiVGoG48Sj5oeDjm5
         abTTOJc8Vq8/rsnSsBrav1ZtWDVpa/u+m7hfy84M7Pj38SvJzq07Ik0PYKThPnqo/2d5
         guomGMjgUy6Hz/SX9HZodyd8btveCk/Gt2SC0/ulD1q5IJdRRs8XstNipt0SOHJQp9I4
         5Uh/psl5PxeLLbn73rRmMM2hQlWXnHkpeyra1AVPRybBkvdwajPyqOTG7iyDNEgsy4vg
         EQoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725384366; x=1725989166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c1oPWbt0ldNgNG7GSta+oIeTV2yMUTpvbZFiQloqBLQ=;
        b=W7OALGw5pRYV6BL1OVytaiAmaTz3rV2LN4NOKzPRSTbez6qrfhgZPEtP6Obmi0xf2O
         N4Ev6J9qMnrIBX1pO0iCOabJlO/Dp/ngkPLnSi9EftfEBT3/5FKFaV7eFXsPPTp0oKmO
         LdL7Br9jPnYee4w5FIwqHbvFomnMX4j+mk5GSD6U2tGLuPbATlbCtxqbnQe2O9SwCO1y
         +9lRAQprUpSspcuhGja3+pfMa61B04OrnJF5kXD8bKbuAqvrbtP8zPEtZBelYIupnFrY
         0JXewlUQxg4y90QAqS65lD6OgzeH6QlUBTrXMkH0st4QZFIfOJbGTIyT2ePXhq+Cvy4g
         w9ug==
X-Gm-Message-State: AOJu0YzGpgr1jf/0spAKE2EA8UuOykZ21gLBEq4uEz3Y1m/4Tq0rM+ss
	q0ubYjHjBkLKs6zSxUtJ2CA1MPcAC/QMWgoPU34ZsNH6iYLuVDNmnl4kIoP58z3Bn9e4A5S8Yfh
	vj0Vt+H8qGgDaU7lJBwr6xvWlf40=
X-Google-Smtp-Source: AGHT+IHYdFVSgLAXZK9RFotUrdJg9ZlOGxldaR72FRNy4Hhr8ZmXCaIMwQzYo+5jOt5K21SVlbLtNJoAvKD9DMkGkJg=
X-Received: by 2002:a05:6808:170e:b0:3db:3b15:7e76 with SMTP id
 5614622812f47-3df1ca5c605mr10798561b6e.47.1725384366066; Tue, 03 Sep 2024
 10:26:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830162649.3849586-1-joannelkoong@gmail.com>
 <20240830162649.3849586-2-joannelkoong@gmail.com> <CAJfpegug0MeX7HYDkAGC6fn9HaMtsWf2h3OyuepVQar7E5y0tw@mail.gmail.com>
In-Reply-To: <CAJfpegug0MeX7HYDkAGC6fn9HaMtsWf2h3OyuepVQar7E5y0tw@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 3 Sep 2024 10:25:55 -0700
Message-ID: <CAJnrk1ZSEk+GuC1kvNS_Cu9u7UsoFW+vd2xOsrbL5i_GNAoEkQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] fuse: add optional kernel-enforced timeout for requests
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, laoar.shao@gmail.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 3:38=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> On Fri, 30 Aug 2024 at 18:27, Joanne Koong <joannelkoong@gmail.com> wrote=
:
> >
> > There are situations where fuse servers can become unresponsive or
> > stuck, for example if the server is in a deadlock. Currently, there's
> > no good way to detect if a server is stuck and needs to be killed
> > manually.
> >
> > This commit adds an option for enforcing a timeout (in seconds) on
> > requests where if the timeout elapses without a reply from the server,
> > the connection will be automatically aborted.
>
> Okay.
>
> I'm not sure what the overhead (scheduling and memory) of timers, but
> starting one for each request seems excessive.
>
> Can we make the timeout per-connection instead of per request?
>
> I.e. When the first request is sent, the timer is started. When a
> reply is received but there are still outstanding requests, the timer
> is reset.  When the last reply is received, the timer is stopped.
>
> This should handle the frozen server case just as well.  It may not
> perfectly handle the case when the server is still alive but for some
> reason one or more requests get stuck, while others are still being
> processed.   The latter case is unlikely to be an issue in practice,
> IMO.

In that case, if the timeout is per-connection instead of per-request
and we're not stringent about some requests getting stuck, maybe it
makes more sense to just do this in userspace (libfuse) then? That
seems pretty simple with having a watchdog thread that periodically
(according to whatever specified timeout) checks if the number of
requests serviced is increasing when
/sys/fs/fuse/connections/*/waiting is non-zero.

If there are multiple server threads (eg libfuse's fuse_loop_mt
interface) and say, all of them are deadlocked except for 1 that is
actively servicing requests, then this wouldn't catch that case, but
even if this per-connection timeout was enforced in the kernel
instead, it wouldn't catch that case either.

So maybe this logic should just be moved to libfuse then? For this
we'd need to pass the connection's device id (fc->dev) to userspace
which i don't think we currently do, but that seems pretty simple. The
one downside I see is that this doesn't let sysadmins enforce an
automatic system-wide "max timeout" against malicious fuse servers but
if we are having the timeout be per-connection instead of per-request,
then a malicious server could still be malicious anyways (eg
deadlocking all threads except for 1).

Curious to hear what your and Bernrd's thoughts on this are.

Thanks,
Joanne
>
> Thanks,
> Miklos

