Return-Path: <linux-fsdevel+bounces-24012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E5893792A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 16:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 014F8282D8E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 14:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988F1137775;
	Fri, 19 Jul 2024 14:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTo+B63H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2704713AD22;
	Fri, 19 Jul 2024 14:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721399313; cv=none; b=TYWy9aSdodt1bQrt/BDPxwGPL5oYY2nu5S9pI6GOTBa9k3h3TIhn0I/h8pLAwxlYJm97kg7zYXUyZcTkMTK5LGSMP7A8JSEck8LUtbhJDD+SECHGWLrVW5hbs0gszPGeKmYuShnb1f/KmSx+keHi4GVLyPhDmYlKHdCPtJBOLT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721399313; c=relaxed/simple;
	bh=Vc67S1kdc7iKyDC7H3kMbghNofGLtY7/Kf7SW+N5/ec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yf11imtcgRqP8CYfJ7FDKRcXEOTljKT1icjD4i0wGAuo1Wceis1HT+eVJRnzhx4fvES2bZKe3VxHU3qVucFwcvRblM8PUdyNY/bAvdyawmqTQ5isSVfvRTKnrhgw3zPyrVc8IZ826ZXyYnmcoNAAqgM53rTdGAixWyYwxXtIn9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTo+B63H; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52eeae38f6aso2441903e87.1;
        Fri, 19 Jul 2024 07:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721399309; x=1722004109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vc67S1kdc7iKyDC7H3kMbghNofGLtY7/Kf7SW+N5/ec=;
        b=fTo+B63HsW1eA6GHuD4z8YCy/3R9JjbiXbxpzOXreyEyhkVAvugcL622TRE2d7rUnb
         pgrWcuTAQ4PtPYQomi+L2HZmrc/UCk3LUSLHfm628685sravU6Yh3ZY8GY5G62nMy1Z8
         wcb46OfJgHDzIck7gEmt8yYi/F8i+S1T41dtZOQGJKnpobk9eTYTXKz1LWNOYO4AcH6+
         jyTvUDGUSOTwKaETPzubAfKHQs/D6eSzV/BTyahRy9ZGFqSPvG3HAYACAbzGh+q3Tq0S
         K8zkTFDEDjenoJL8nWi/1vrXSUqv/ObEvdELYFhB/0x0Av/JP4teLzlVCG1VrvOzkgNI
         oEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721399309; x=1722004109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vc67S1kdc7iKyDC7H3kMbghNofGLtY7/Kf7SW+N5/ec=;
        b=Zd1sE0SsfCbCPrSd0n1hPt6/njc4fBztTPVqoyvM51J7uRa0y/Tzr0ZTErjXBuYJFi
         SP6aIGJy92b/DjqNf6uogklvpFS0NNQ5BxJ02j6QBonO2Rc5hpR3yo7iqR6hFL33sNJr
         Atbg3+OUDQavPS2P6TbNmJtuSYm3qpfzFCzwp5AMXsIFZKl3WVKQQnvcDXAovmp4L9QR
         i1YUPuRxXluxc8orIZI7iXky9cZIb3WqOvrdZ47K5Ccprv+XQFD+Usc+hhpEPVPzFy0P
         VIThmvLtXbd53Hbd5zq+vCncHaDIOGU3qlpc9mvzSHHVN/u4Gqco9TtCDbjg5wwfMWzB
         mowA==
X-Forwarded-Encrypted: i=1; AJvYcCVvKCdtSPotbClVaE2UT/EQO4rHBkTtFjaBP+yDRnJ1L0RBIEDk3AqjKFaxrnFPUnDlO0vF6REAHQjz8fPzT6UGusFQahN9bpO2SFyASxiZR/sQJREpsrN/4Q7tbbC4HT6pMTQ6NPrVp0lPJA==
X-Gm-Message-State: AOJu0Yxc7IT/dx5oYUDyJmhnVOUIhp3+qP2WlnvHP8Q0DED2cJBA6/or
	/DC2xx7hzZRmoipIFtoKAIZVXLDFjDJcwVYDeJQtltTM2Omj4hxH9awd61Gk9rD54yngKWIk+nh
	vpU+uJIKh4/ODp49VOkaQJbF6bR0aRBh8
X-Google-Smtp-Source: AGHT+IEl20bZ1rbKHuxKfD3ohnwBvqEtcb9/MlOAaSiLNDkt6m1MNwWETMaTtXODiBeTcyxvY+1aERXHVxLVB9Z1fJ0=
X-Received: by 2002:a05:6512:1292:b0:52c:c9b6:df0f with SMTP id
 2adb3069b0e04-52ef588067amr1235998e87.61.1721399308925; Fri, 19 Jul 2024
 07:28:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718151838.611807-1-mjguzik@gmail.com> <20240719062550.0c132049@kernel.org>
In-Reply-To: <20240719062550.0c132049@kernel.org>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 19 Jul 2024 16:28:15 +0200
Message-ID: <CAGudoHFZ+rCMEXM4rqd-Gwaq1n6yr21+KqByJ2-FgjV1zN+ncw@mail.gmail.com>
Subject: Re: [PATCH] vfs: handle __wait_on_freeing_inode() and evict() race
To: Jakub Kicinski <kuba@kernel.org>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Dominique Martinet <asmadeus@codewreck.org>, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 3:25=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 18 Jul 2024 17:18:37 +0200 Mateusz Guzik wrote:
> > Link: https://lore.kernel.org/v9fs/20240717102458.649b60be@kernel.org/
> > Reported-by: Dominique Martinet <asmadeus@codewreck.org>
>
> =F0=9F=A7=90=EF=B8=8F click on that link... Anyway, can confirm, problem =
goes away:
>

well the reporter address can be easily massaged if you want, I
grabbed the person who cc'ed me

> Tested-by: Jakub Kicinski <kuba@kernel.org>

thanks

--=20
Mateusz Guzik <mjguzik gmail.com>

