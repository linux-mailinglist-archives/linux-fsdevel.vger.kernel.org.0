Return-Path: <linux-fsdevel+bounces-14286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C8887A7E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 13:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10A39B23F50
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 12:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CD03E48C;
	Wed, 13 Mar 2024 12:55:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72FD2BB09;
	Wed, 13 Mar 2024 12:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710334558; cv=none; b=Kmid1jitbktOtsrymhJsjqaL6iHb1wy7hvm9V5Bix0wTVxQsVjGe1lrOciis7NkLrr0pjq/U4m8/M/klxhlmdRAUiMoGIG/N9mZ2Ed07DY0ehMX9XHXuLP8Ts+fby0ovEC1EsS0eub3nO9buI5QzRnEWt0a8CEKiBwhwG5BfuiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710334558; c=relaxed/simple;
	bh=2ZbXdNCF7VRaFuWddkKTBt2RjQgCB6ZAM6OU/+Eg7vQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SMmFuM4nxNVIUNoJM7I3OgmbWn/0ek3Tr7iSR8vygiiaGgv35YiHdTp1fQBoZsmY4FDbV7eIjudIVKGYDkj3cSeXkVp+9ihzepNYpZ3vmMgYrgPWIn9bwBoAbCTdjelWQMb4L59pR9MAhMY22F8SBAh9wowb5Ns+xm6/DIWIS9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=auristor.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a4649c6f040so198334066b.0;
        Wed, 13 Mar 2024 05:55:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710334555; x=1710939355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0X0cdnFvvOmLgYMcXVX2p5itfqG06uErHXMYJpV+q+k=;
        b=mlW/jrVxtEuZWaJr2gcIbbOxijphYYQX3DilPZdoGBtV0kxZMZzf4aFfE9C/vqURNP
         izEsPnQ07WOXzbUHjkw7G7DpOhKge8fPOd6GaYpQTBbm+SzCo5EWun6DrgfX1WzMVOnB
         Kxu26PqbSmZI5N9V9wLK9a05QZJ3Njf8ZaUAWFLT3kDV/2gtoxRVCyTnqx+f1LJWoke8
         ud1wqQ5COeSoV43lCvAhD6ZpP9KSiPJ4Pm/6DEuMFhADx8qm/Spafdm+u415nPwCDCmG
         7ZiV8IpsmDbt1D/KMPVG/CsoigQnphMvP1gM8V0S7vEi0JPsc5ivTt8rGnUqZzrJ0Ijy
         QY3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWAuO5Rrq0pH6MZBP/BZcDjOmHa6BSKJgb5lJTxwOV4xNIlLqMq84qOyEhqm2IplvX+yu339oWWGlfcEhDt3DtoClOREYdUijtzuB/tVXBRWmB/r0DQ38iHa1H7m5oAArjc5DgSqeKBGsEC3Q==
X-Gm-Message-State: AOJu0YxT00nI62Pf5tYgKgz4gCDA6HumpzLD5XTpyXa2wzUoaA9GHara
	k3McggRfW5JRlcJ1S60rHM3ZC/LYgDz4b90R1GXbMq+qwzBfGhTqpp3Oa1BFOEU=
X-Google-Smtp-Source: AGHT+IHcmzMf4OLtxvftcDvZVjJndOnSjSgMFnq10oH7Xqp3Ad7rSabGX2ggtOMK/TC7ZABJ9mJxIg==
X-Received: by 2002:a17:907:2d11:b0:a45:abec:cff4 with SMTP id gs17-20020a1709072d1100b00a45abeccff4mr10042308ejc.32.1710334554617;
        Wed, 13 Mar 2024 05:55:54 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id bp1-20020a17090726c100b00a46196a7faesm3682299ejc.57.2024.03.13.05.55.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 05:55:54 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-566e869f631so7933360a12.0;
        Wed, 13 Mar 2024 05:55:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV+y+r959e6IZv211vXwFazGan2Ddk2I0veImwAyEYB2jT7iZis/F21GkcgbWee4WIV8ULO6Mpvcmg/aV3wRxhMUOu0WraSYrqTj8aq4pRp2wRYeB9SaU/rK1UPVPzZWOvPN4EVhT7AFw1Fng==
X-Received: by 2002:a17:906:99d5:b0:a46:2fa:bbe9 with SMTP id
 s21-20020a17090699d500b00a4602fabbe9mr8816062ejn.45.1710334554072; Wed, 13
 Mar 2024 05:55:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313081505.3060173-1-dhowells@redhat.com>
In-Reply-To: <20240313081505.3060173-1-dhowells@redhat.com>
From: Marc Dionne <marc.dionne@auristor.com>
Date: Wed, 13 Mar 2024 09:55:42 -0300
X-Gmail-Original-Message-ID: <CAB9dFdsYOJ4OyCPZL3ercCoSMHdAGwrXMp2Y2O7iKP2U0L9_bA@mail.gmail.com>
Message-ID: <CAB9dFdsYOJ4OyCPZL3ercCoSMHdAGwrXMp2Y2O7iKP2U0L9_bA@mail.gmail.com>
Subject: Re: [PATCH 0/2] afs: Miscellaneous fixes
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, linux-afs@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 5:15=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
> Hi Marc,
>
> Here are some fixes for afs, if you could look them over?
>
>  (1) Fix the caching of preferred address of a fileserver.  By doing that=
, we
>      stick with whatever address we get a response back from first rather=
 then
>      obeying any preferences set.
>
>  (2) Fix an occasional FetchStatus-after-RemoveDir.  The FetchStatus then
>      fails with VNOVNODE (equivalent to -ENOENT) that confuses parts of t=
he
>      driver that aren't expecting that.
>
> The patches can be found here:
>
>         https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs=
.git/log/?h=3Dafs-fixes
>
> Thanks,
> David
>
> David Howells (2):
>   afs: Don't cache preferred address
>   afs: Fix occasional rmdir-then-VNOVNODE with generic/011
>
>  fs/afs/rotate.c     | 21 ++++-----------------
>  fs/afs/validation.c | 16 +++++++++-------
>  2 files changed, 13 insertions(+), 24 deletions(-)

Reviewed-by: Marc Dionne <marc.dionne@auristor.com>

Marc

