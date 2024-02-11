Return-Path: <linux-fsdevel+bounces-11060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E49E2850815
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Feb 2024 09:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D32B1C21457
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Feb 2024 08:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D22F45954;
	Sun, 11 Feb 2024 08:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmqD598k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B8A45018
	for <linux-fsdevel@vger.kernel.org>; Sun, 11 Feb 2024 08:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707638417; cv=none; b=o+hhTlgCb3BKIRHn0Qt8sJvKctK2oxNS4FFYIUC9ngd7H63zYimhP2KjodWwTIRIcNdSPHA/Bs2x1jk/gecJ5GJU2Xj6WmLq4mYZCZoU7XUgF0hHvOrW+pWy/9rXC52xLhrw/M9Y+7AK3SVhDx1Iy0aBBIC1nE1yI0+0f6AJul8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707638417; c=relaxed/simple;
	bh=7x3RxTEvLB93tnH8HEf7JWs2cU5whjam5NeBqLP6fzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cvbhX/MKfkjUonp+3LxE1WtQSTC4MnMZZVXLV/9g82cn0cGqwKzakRX7OGFSGgd/rhjYWX/wZitQzU9sYtjzMGAiL8cCDxU4tT2+fOt3qSHURsHDu80WKGnd6Ntp4T2MroYsCjvvKzFAHvl0d+t5amyhTAb4+301maVgfookqvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmqD598k; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-42c754ddbc9so747811cf.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Feb 2024 00:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707638415; x=1708243215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7RVwFYMmn/yXkNsv7iyoMoXoHmtiHWyMvShCWqtVtMw=;
        b=BmqD598kguzAQIXQjsKuhx+WKaEfcmMBbJJdyIoSQj6XtrHj9/ducCgMFoycuqdJVq
         e2Z/NKol+F/2FmhJtXWdLXihDteYE/fw7JfFa50IBOH9sqUwmOSJimHY4YJ8v4+QjTmN
         ogQE5Pzrgx1hs4Lcl4Rt8K6JH9UKyZod+eKK3dNYdWE1AnHYTD8xPqjJ0aI5F9+KuLkX
         NHIpYmoh1FcEyJM+V4I6CFiMcJkl3YLZHB4XWPVlfwfXh9W5hE7vlAdw+54O+u7BSow8
         Q82tbOlSLVyw4YRv9jkt+FTg15opRuCi+3gwJF4jM4gxJH8DW1AHa8D5Qcyd9OZePqxG
         Utew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707638415; x=1708243215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7RVwFYMmn/yXkNsv7iyoMoXoHmtiHWyMvShCWqtVtMw=;
        b=q7taoHZeTAMskXmMOhn4T9CikQzljddOzh6kg5pX/J1Z/T7Vsrd9kiugioqcvfgkuC
         Hdit9Jjeixa0YnPUYFAaDfm/AVReVx6YbD926/M8aX0Z29GucuXnvnRWEh+FiRJ/Wne2
         Q1lWZEODtLE1SagtnsdV7x1okGETTt1BtZUoeoX1HyaNhhuowjjAqGmb7Y1/Axe4ZZkj
         odoOveblNjI4/Tqorp+Aeq2a6ythUyWjuhQLvweulVytdJcUD8X/fje170+BEGU6loFo
         1owo4pUPKckjJQA19xVr+0ZG1e9Ee++kzm8NMGG2y7PVbz0eJUXN4rxu+bmoq0d75U15
         NyBA==
X-Forwarded-Encrypted: i=1; AJvYcCUyB5iLG9Lr3xYZ7CE3iZ3uwpxV7Aog4JMid6hqP14q6K9OP2pH8Ql6k1QdLTDAyn6mhOGWM6V5jmBCc1Jk27uH1GUkY2bytvCJzLEDvQ==
X-Gm-Message-State: AOJu0YztCDCQe2GW3LPmGpCtwQeOpnSB5jPZmlDHOZkk+SiDUrptdqSX
	xO9YMWJ1LR+TM2RFfOEb5H6aHdcgod11oCLEiVCxqYBvtD5ZAfp4aEmJzUHvCUpsF0KKHiYUgkn
	AnOSqKM6qjJYtD8ZE0AhrZn408RI=
X-Google-Smtp-Source: AGHT+IFDtbK/Iwo90UjzF3WWk/MlZOit094P/oGYfC9ZuuUdOYNfYqftDzjahfOUKLlERXzDIFVcKexEjoJgWh1FAxU=
X-Received: by 2002:a05:622a:1113:b0:42c:68a7:f45d with SMTP id
 e19-20020a05622a111300b0042c68a7f45dmr4267769qty.0.1707638414934; Sun, 11 Feb
 2024 00:00:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240210100643.2207350-1-amir73il@gmail.com> <20240210232718.GG608142@ZenIV>
In-Reply-To: <20240210232718.GG608142@ZenIV>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 11 Feb 2024 10:00:03 +0200
Message-ID: <CAOQ4uxhs9y27Z5VWm=5dA-VL61-YthtNK14_-7URWs3be53QFw@mail.gmail.com>
Subject: Re: [PATCH] dcache: rename d_genocide()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 11, 2024 at 1:27=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Sat, Feb 10, 2024 at 12:06:43PM +0200, Amir Goldstein wrote:
>
> > I am not usually for PC culture and I know that you are on team
> > "freedom of speech" ;-), but IMO this one stood out for its high ratio
> > of bad taste vs. usefulness.
> >
> > The patch is based on your revert of "get rid of DCACHE_GENOCIDE".
> > I was hoping that you could queue my patch along with the revert.
> >
> > BTW, why was d_genocide() only dropping refcounts on the s_root tree
> > and not on the s_roots trees like shrink_dcache_for_umount()?
> > Is it because dentries on s_roots are not supposed to be hashed?
>
> Because secondary roots make no sense for "everything's in dcache"
> kind of filesystems, mostly.
>
> FWIW, I don't believe that cosmetic renaming is the right thing to
> do here.  The real issue here is that those fs-pinned dentries are
> hard to distinguish.  The rule is "if dentry on such filesystem is
> positive and hashed, that contributes 1 to its refcount".
>
> Unfortunately, that doesn't come with sane locking rules.
> If nothing else, I would rather have an explicit flag set along
> with bumping ->d_count on creation side and cleared along with
> dropping refcount on removal, both under ->d_lock.
>
> Another piece of ugliness is the remaining places that try to
> open-code simple_recursive_removal(); they get it wrong more
> often than not.  Connected to the previous, since that's where
> those games with simple_unlink()/simple_rmdir() and associated
> fun with refcounts tend to happen.
>
> I'm trying to untangle that mess - on top of that revert, obviously.

That sounds perfect.

> Interposing your patch in there is doable, of course,
> but it's not particularly useful, IMO, especially since the

Merging my rename patch is not the goal.
Clarifying the code is.

> whole d_genocide() thing is quite likely to disappear, turning
> kill_litter_super() into an alias for kill_anon_super().

2-in-1, getting rid of cruelty in the human and animal kingdom ;)

Thanks,
Amir.

