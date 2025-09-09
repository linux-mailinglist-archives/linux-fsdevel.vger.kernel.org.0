Return-Path: <linux-fsdevel+bounces-60619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC27B4A2CA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 09:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15CEC167562
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 07:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EEC3043AE;
	Tue,  9 Sep 2025 07:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yo5ddjSM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AFF1F09BF;
	Tue,  9 Sep 2025 07:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757401276; cv=none; b=rZGP3CqQktCy7DkeEnLOiTv+s4bttBi9g3epAYsrSIJpUyFzBMtWceW6z6+9cE+6AbbO81GQgbUyl4CqlC9lLbDJbREuzTFXLfc2UHo9tK++jtAwaeKgBXJvNlIMMsCq7WwOW8Lj4dDRS8MK+hTNiCmXGWIDzglHN8F60+fV2uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757401276; c=relaxed/simple;
	bh=yW4o2oLzqegUHsbT1Tk7z8wmU31LlfNgMT3GjZWs7fA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oCUU6DCsGrbCEeYc+/qXfjvlrLveOcN7D3G2NuYmW1o8VRWa7rMPZw28FhEuaPR6VDzqWsIdmH9yPlQgLfDJpZVdKOvpz6FPPkRKQvvzTWINZH8GDaRbzZoksXZdu+rdYHuC3/zeyR67vRVEaqcCDNRKoGc2SunmgIclrbQnkgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yo5ddjSM; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32bb1132c11so3153802a91.0;
        Tue, 09 Sep 2025 00:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757401273; x=1758006073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+aaFG5+6xLCsxlpa38p1LAYBqnKybEnSORRwPhgG7Y=;
        b=Yo5ddjSMQfDIuusAt8KX2yagVTTczdlRcqfwDZIn8qWg+mBJQwS3Xj7nv+p6rnOtQc
         i1+ncCD42Dv+MPavlJ5MNxvNkSEEzEkTnAn6Fa+WdPnDodEpOo2BWxr8Gn6nnAh0iXEa
         pXfjeXo24OSHLRxJwQ0U+VBj0CQcBJWzzlAxkoyYXKd9f3Rh5cJ7m6dFSSTxNMfa3c8C
         0Fi+MiJpxPgKmzxYj4tzCmuQQUEerR7bhc/OfyeDHSmxIeCuSipKJ/iM/23mo40+vZYu
         CAE7jjSfPCOtzwL1WsVHja0XvzLa+I6Yk4lV8tVIur4SJN9vR2cxjPI+RbrMJ1/rnlco
         b/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757401273; x=1758006073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+aaFG5+6xLCsxlpa38p1LAYBqnKybEnSORRwPhgG7Y=;
        b=NqQJ4XJWn+KkpDG3Wd8qNDCEdoHQ4Und2MIA3yJR+stJUHcpElvuhdVVgSGb1VZCYs
         Qm+SWj3zeiMOB8NSm0Xy9xNyihzDdi92s8tHsl+rKvD+s0hN+lDty13G/WHXwxRBp471
         tlSnknaxVyGOyUg7OauKLTVmwikiOQmjgXP3ZL2qpE97DqFx9xdBRTZZmXwqlZk2wdDH
         49I9+aq8Lw9OVbsNDQsUHzl3Oz2v+KEwiuYKHuFIVzraaVhIq7sxQkTDb91iw1s9Rmnx
         lceY/vMpl3DCIDAwa3AXU++ZrAHMAP6shEC4y84dYjsQO/yzRdC9PraGAEvozIDb3KsP
         4Nnw==
X-Forwarded-Encrypted: i=1; AJvYcCWifmD3Vx9yFzf2G2xJ7/mlk33HpvQCg3hIez0jbJ2FpmFwGai3RKU8/rcETV8c5aV9OSk0gyRhk/NPi4Hr@vger.kernel.org
X-Gm-Message-State: AOJu0YyGcxMLWm/uoqOZgvdtOq+zZ0HyE3yAgQAK+cDRlfj4Pmk3jugN
	7JbqgFV1oUurFzvR7rM3DSIvyHaK1UJHN9oXHM5JKobJxfR3DBs7v44Q7NIkKSa2oCXXfgv0j1T
	8Ba+b8A7UpEtc+2UxDh8jI4NGB2oTwTo=
X-Gm-Gg: ASbGnct/NuAIu1xX8/+R2Oos+ALY8buXhDdzzj+Ts+r3w3PAZMyNOR4jRCab6gKtjOL
	Vg1nEcrdtFmM97KW9jIymaibEXZdozza0HAj5G/Y+qb+eEvnHnYudU52zTmklrKz8Ggi73iBYW5
	PTSb7zlsdFqpUaYSi6XmautxNGxuuEr1scZx1CGG6cE2xrleB1xPYwVjO17erxsTZ/5x806y+ck
	woTLww=
X-Google-Smtp-Source: AGHT+IE0JA/jHcBpJ9iz3tNERqjSRdQkN1t/8Uj8IUT/tTodJ0krtrAF3YX47zJbJSreNrDaqh1aoPj/phlc3mu+ZAA=
X-Received: by 2002:a17:90b:4fd0:b0:325:15bf:4dc2 with SMTP id
 98e67ed59e1d1-32d44f86e71mr14872697a91.0.1757401272875; Tue, 09 Sep 2025
 00:01:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908183717.218437-2-slava@dubeyko.com>
In-Reply-To: <20250908183717.218437-2-slava@dubeyko.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Tue, 9 Sep 2025 09:01:01 +0200
X-Gm-Features: Ac12FXxvPl3_wFWrlXWHwoyB44y2R9l4Jjj55Pvm0eH0wfKIqM0aTceXcz1Joyg
Message-ID: <CAOi1vP9=DawXDjgoQWm=v8geRKPQky0qiJWrct+BeR9PnwXNyg@mail.gmail.com>
Subject: Re: [PATCH v2] ceph: add in MAINTAINERS bug tracking system info
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	pdonnell@redhat.com, amarkuze@redhat.com, Slava.Dubeyko@ibm.com, 
	vdubeyko@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 8:37=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.co=
m> wrote:
>
> From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
>
> CephFS kernel client depends on declaractions in
> include/linux/ceph/. So, this folder with Ceph
> declarations should be mentioned for CephFS kernel
> client. Also, this patch adds information about
> Ceph bug tracking system.
>
> v2
> Ilya Dryomov suggested to add bug tracking system info
> for RADOS BLOCK DEVICE (RBD) entry and to correct
> CephFS and libceph maintainers info.

Hi Slava,

I also suggested to not duplicate include/linux/ceph/ path under CEPH
DISTRIBUTED FILE SYSTEM CLIENT (CEPH) ;)  The dependency argument can
be extended to other includes and a large chunk of net/ceph/ as well,
so it's not really viable.

I can drop that bit when applying the patch.

Thanks,

                Ilya

