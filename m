Return-Path: <linux-fsdevel+bounces-39744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EBFA17403
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 22:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 674ED3A27E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 21:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB941E9B00;
	Mon, 20 Jan 2025 21:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcJwKxqn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CB1190059
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 21:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737407735; cv=none; b=mYYfsMK57QgruFsw1QEweb67daCnH/Cc3cDywrmLLvOKXJ0x+WZyGiQK0PTHRUVAFVL/iVrLgVWhWpPrY0dx94TJfmINFobRqRDaQ3sBnEypq6xsJNcjQJdCYfz4PytwOBXrKyQgDswGWf43DR08ICqpJ3waZRvGW/nNkliXPC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737407735; c=relaxed/simple;
	bh=Nk9ptFzWoNFmqDSP4gjGSCw25adjsmfJufY+aMhJcqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZOljfdk8wLfSynDkST+prNBxXiI3Hfld3/3uWHvfSKvx3bHNZk1UOCy9DO91ukB/54+W6oaxBSxmRiD6orM78BPO11zVCR8C24YlX/Ea0yW74hniz2ZuExwBRdWfgh+VNeF8Cnh7dbRErCM///Mt4SOXYZBiLjv+rW4C12eibzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcJwKxqn; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d3bbb0f09dso8487098a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 13:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737407731; x=1738012531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nk9ptFzWoNFmqDSP4gjGSCw25adjsmfJufY+aMhJcqQ=;
        b=AcJwKxqnkQKVj062kfgfej40EWHRpXRUS73/Y5y46DmxFAJcDBcgHGAnnkKNGk9LL0
         iKLftDl2Z3yWmQFm25Wdalq5Dg3RhblXabgmEUoZ//Uv/Nx9OHBjMdCfSj3kouvBQ4Ax
         yzrnRWE1quDUai9SBfzTokB1BBTPi5B2CwJk3cDaNsDEClGnkxxN+ApmCKsQrGINd1sf
         m3QnTjVEa4X8KmSDuQG1HodEOZ92oHkRwg+IjYQ7xH44NcYGMmqPPxZyt0EbTKSdF4GC
         12l+PKrh9+RxLPoZ45bj3Caz4x4QEYv9LzZwqpOUotqT/x+cVowl8yscw3wrBf96TLMZ
         Ugdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737407732; x=1738012532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nk9ptFzWoNFmqDSP4gjGSCw25adjsmfJufY+aMhJcqQ=;
        b=KCUchj8q0AdsZcbz/+Gk1tTKRj5kTTV1FkfOeDou2MEcjb1GdHOT1I3mvBthbeRXta
         oIXD4Ub7YjLA9HkhOK5u0jIGV4I6RUi757NxpWfs7borrOuzRGteqWQ8KAEAFZbGG+f5
         0OMQps7BNxpSi6aFFtoCFBLPW64uL0qraqM8dElh4SeQaqglt4fIYbe26Bd8uKqT+ZdR
         BRafCSPur4XtKVSX5sCUeVz33grn3Xtookk+/XqkRhC6uDcHjXX922zOzgHqbG0veh01
         N2nq3ntP2ql5vGyyzqyzYz5u2wTUWw2tOyIPx8rZEwfrWD9Fv1lL3ZVPEBHeZW38vr9R
         VD+Q==
X-Forwarded-Encrypted: i=1; AJvYcCV8r0JB84F9kK6sVikudCFzAqSw3QK/M9FdPLYmHOmZxMBtDw56S4XWqYrtkqX7KdiVhI8PWOxdJZb+fdOe@vger.kernel.org
X-Gm-Message-State: AOJu0YycNkbArDHkxFpGqWinbAPUzhTyxh6nFi6LOAouZSbt2qfMXQQk
	8tDtyyOKuzeTOiiqAAnTr4D1VgDWuPNHp2LjNH6B+zDSK58JCr8qsGT747xR/OFvhMx5LQ1a6PN
	8haRkms1KGbALOgX7e57HWgDo0+3S+w==
X-Gm-Gg: ASbGncvd1JkI/9hEd1EOSWIUr5cWbUockbv4PBucn774qZ5PzVifrfF5KVu5l80xq7Y
	jCb3sqYuBUVrknuBKYeveXMdNO1crZRowBwLJOrGoD2XfSQIpANshq/e1TpnU0w==
X-Google-Smtp-Source: AGHT+IEmAcDTDwTJjkFr7qyNTkQgUXuY92WJyzdkQs4zIcxDDFvwotc+M6aDRc6D7Ir2zyf0CU2scwGua8bt2J+M82g=
X-Received: by 2002:a05:6402:13cb:b0:5d3:d8bb:3c5c with SMTP id
 4fb4d7f45d1cf-5db7d2f0e98mr13980841a12.12.1737407731371; Mon, 20 Jan 2025
 13:15:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202501201311.6d25a0b9-lkp@intel.com> <leot53sdd6es2xsnljub4rr4n3xgusft6huntr437wmaoo5rob@hhbtzrwgxel2>
 <20250120121928.GA7432@redhat.com> <20250120124209.GB7432@redhat.com>
 <CAGudoHFOsRWT0nKRKqFwgHdAhs0NOEO4y-q7Gg4cjm9KBxQc9A@mail.gmail.com> <20250120203118.GF7432@redhat.com>
In-Reply-To: <20250120203118.GF7432@redhat.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 20 Jan 2025 22:15:18 +0100
X-Gm-Features: AbW1kvae8sfSEYL3GYYYms3fsiZWUz4ARlh9Pktd0QvT3NI_SSKkChY4poFrJC4
Message-ID: <CAGudoHHb5qsiTDQ8XO8mjVH6NOQ1T0V5Y-+Ug80mkpLTdiAsCA@mail.gmail.com>
Subject: Re: [linux-next:master] [pipe_read] aaec5a95d5: stress-ng.poll.ops_per_sec
 11.1% regression
To: Oleg Nesterov <oleg@redhat.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	Christian Brauner <brauner@kernel.org>, WangYuli <wangyuli@uniontech.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 9:31=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wro=
te:
> I'm afraid my emails can look as if I am trying to deny the problem.
> No. Just I think we need to understand why exactly this patch makes
> a difference.
>

I agree.

I was going to state there is 0 urgency as long as the patch does not
make the merge window, but it just did.

Since the change does not introduce a bug or crater performance (that
we know of anyway), I guess this outcome still means there is 0
urgency. ;)

> And I don't understand what workload this logic tries to simulate, but
> this doesn't matter.
>

So one would preferably survey a bunch of real workloads, see what
happens with real pipes with both policies -- the early wake up is
basically a tradeoff and it very well may be it is worth it in the
real world.

However, I would argue cycles needed to for such an effort would be
best spent on other things.

Per one of my previous messages the tee thing which got a significant
win is doing some crap which should be avoided in real programs. The
rest, with unknown real-world applicability, does suffer losses. The
early wake up definitely has its own merits, so one can't say outright
it was the right call to whack it.

My suggestion to Christian is to revert the patch and call it a day.
For all I know there are other yet to be reported regressions lurking
(wins as well of course :>). By now there is no denying there is more
to the patch than originally anticipated, but it is also doubtful it
is worth poking around.

If you feel nerd sniped to figure this out, then well, more power to you. :=
)

Perhaps someone(tm) would be interested in looking at pipe performance
in general. I can tell you right now that there is definitely loss
stemming from repeated SMAP trips when changing buffers etc. Trying to
get a real understanding what's up with pipes vs real workloads and
fixing whatever crappers which pop up would justify the investigation.

That said I'm buggering off this issue, cheers :)
--=20
Mateusz Guzik <mjguzik gmail.com>

