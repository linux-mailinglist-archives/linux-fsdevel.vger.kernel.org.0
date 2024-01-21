Return-Path: <linux-fsdevel+bounces-8369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2DD835763
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jan 2024 20:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02B08281B57
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jan 2024 19:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAE8383A1;
	Sun, 21 Jan 2024 19:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dASLluEm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FADD374FA;
	Sun, 21 Jan 2024 19:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705865811; cv=none; b=lD+A1OsgyNAkr+D18oWw0cxxoY0lOrYnXGCkkXIv1NxoKuPRRivYMPNsKpO0Thx+WNGP92A3+y2DrQElC5o2VPy5VGwHFL1+N3vpjmJGyWwbbERb16ZdeuvAvz50s1XySByTSgHErFyo5GMKZ0Gu9uL+5ev8V57ctOVLbGBu+kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705865811; c=relaxed/simple;
	bh=4hiZpI+icBUVDpLbFrS9OTX9iRY/GXVx9pFghTt39N8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=leVnmM5yaakkzrEio/J6A6jI20nXe/ewJiW1hYtR4dQ892+Ia87RNDz6Ik9wqh/d6a54/2dYvuho7CI/nYYtQnLGY7pDB8rSYA1gRK5tM3/YoI5zO4LiobgkuUnDJrcT6kLu0sV9WXLQ4Th9hv3Sh76hDAn3UZJI80C89qLEywM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dASLluEm; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-599903c5618so23010eaf.3;
        Sun, 21 Jan 2024 11:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705865809; x=1706470609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9mrkCTZLpLTIVgbodq3Q2yrWiCs3Y0QddwuBNQZBFk=;
        b=dASLluEmHz8dxnwJJ6038dimIoR+yKBfdr1vetvmcywAtbCwXt71l7y8W2v93cK/N7
         sWcV1EZY0Zx0B7B4P27UD/tzysKs/QtNCm0m9LeWjDBdcBphQby5he2GSK8J6poKzqLr
         QyNihb999wYyNxaYJNhbmZBFkegMLmJGIGi6HymU2F6ju4IFXqXC/LUptsjJhaCfGXcI
         fZagwv5X9fZSeJagXtaRcjLf31noTLFAuEGtROL5GtY3C125y99+ID/74BKp/W6HuO7l
         3Z1qGnh5YC8SQslkO0ENfsYKXZJg/1eUDZAzYJkrwPo3V3FFZfBei3wWgaJDirWg7AM+
         um2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705865809; x=1706470609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9mrkCTZLpLTIVgbodq3Q2yrWiCs3Y0QddwuBNQZBFk=;
        b=vPAAYdJtkuCQwN3JmYpyj9pSjfzOBEWT/PMwvCCj3WEUVrP0eDF5UQeetY8M3BKJMb
         JYre4E/KobMCtg94cMI9ALpSmd/aUvUcn0xzM/nz8YVA1eJeaCIR0Q0BLz/ueMafz57Z
         i9KMv5e6ndqqO1HGxgq9A6a3VrcKm3qDekp9yLVOGJfDHOGaHWVaeuo2/zLQZK9pV2Y6
         PggYUABNCQjoOWSWukRDL3ph/kXRP9twRembhEH4ysxlhCQtldHivtaixJJijVMdxAOX
         q8lXURTJCLIHYrnZKtgcpWKT/wMk0l0mi1hqMQ80/oHmCF4SCjMG6aap0cSAbylS3Ava
         8aMg==
X-Gm-Message-State: AOJu0YzxJDML535Om4WNfjfrbFEL8VhAVhBtWYUkXm2uY6svhs89Cf8t
	b5tTSXI0Z0N1Rd0y/nneL9OO5O1WrglHkYLxMedsmBwh5fh0iM9CLi4MDhcv/IUnYGaaJ7PuPXB
	lpXf2QwJCKyXHYP0ngQFQRtqtCr8=
X-Google-Smtp-Source: AGHT+IFHv3E1uLwSsI4rohW7rEz+xLP0rfk9sXAsk3whE30cLxW9a2uBMCxCxEMiXjlbr3MXh4ro5os96q60sPf58GY=
X-Received: by 2002:a05:6358:63a4:b0:176:4c81:bc0c with SMTP id
 k36-20020a05635863a400b001764c81bc0cmr620221rwh.48.1705865808940; Sun, 21 Jan
 2024 11:36:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119050000.3362312-1-andrii@kernel.org> <CAHk-=wg3BUNT1nmisracRWni9LzRYxeanj8sePCjya0HTEnCCQ@mail.gmail.com>
In-Reply-To: <CAHk-=wg3BUNT1nmisracRWni9LzRYxeanj8sePCjya0HTEnCCQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Sun, 21 Jan 2024 11:36:36 -0800
Message-ID: <CAEf4BzYTZ0KZYc+zgwSdm6h9i0nQAfM_ne8cdMoPJ36c3yNC1A@mail.gmail.com>
Subject: Re: [GIT PULL] BPF token for v6.8
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	paul@paul-moore.com, brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 21, 2024 at 11:27=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 18 Jan 2024 at 21:00, Andrii Nakryiko <andrii@kernel.org> wrote:
> >
> > This time I'm sending them as a dedicated PR. Please let me know if you=
 are OK
> > pull them directly now, or whether I should target it for the next merg=
e
> > window. If the latter is decided, would it be OK to land these patches =
into
> > bpf-next tree and then include them in a usual bpf-next PR batch?
>
> So I was keeping this pending while I dealt with all the other pulls
> (and dealt with the weather-related fallout here too, of course).
>
> I've now looked through this again, and I'm ok with it, but notice
> that it has been rebased in the last couple of days, which doesn't
> make me all that happy doing a last-minute pull in this merge window.

Yes, I understand. BPF token patches change common (internal) parts of
libbpf, and so there were conflicts with other libbpf-side changes in
the bpf tree.

>
> End result: I think this might as well go through the bpf-next tree
> and come next merge window through the usual channels.

Sounds good, I'll route it through bpf-next, then. Thanks!

>
> I think Christian's concerns were sorted out too, but in case I'm
> mistaken, just holler.

I believe they were, yes.

>
>                   Linus

