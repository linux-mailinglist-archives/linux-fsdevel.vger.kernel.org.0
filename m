Return-Path: <linux-fsdevel+bounces-24010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DDD937924
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 16:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9D7B1C21EFC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 14:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E184013AD22;
	Fri, 19 Jul 2024 14:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BU6Kwq9t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98DA83A19;
	Fri, 19 Jul 2024 14:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721399188; cv=none; b=GcRgBo9YMMDlEwwQZPy83eK8Fvfi5HYbtyURaZSVLlup/F7A6eys6qJeN5U5ldQW95hqomBiLqREwRokvrQKmVtCvoZd78aA8IGNPNwGNHTYUHT0A99rX9HRFHmkoqBtIlvNP/NZG3ZCzomXqiJnmXe7jJeLCcm7iXaAtfI1CHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721399188; c=relaxed/simple;
	bh=x+5npN4ZKIc11/Ku5TU4KwXy+Xupw5mqYOoZTVQqacg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tzSMge5V5BArf/XQDFxYHZFNVECd0TVmhvxl2EcX/LWI9pM3ijGYiwSYEle3yiexfZFGn6XRNvacLZ2Xq4sy1jdw/XMgepiJ5ux73dQZ8useWsFOR3iuOdxBNh1ROQn03ziTVXKIh6FBk3dcOBCal537Z2JbTQkY+ugRTTI2o3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BU6Kwq9t; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2eedec7fbc4so25538401fa.0;
        Fri, 19 Jul 2024 07:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721399184; x=1722003984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYZZP32OLM66abDpfGOlT54GseEflZJl3/fT3OrXm9M=;
        b=BU6Kwq9tg9F1jOa1dWryakt11rj3GSijHn2C93upS6x8WCBxCKIj0uuy1LOVHZ2v6N
         ueREi1ugLfcf01QI3dJr/dBfCnOjm/0aAKc/FMnqcaibpk85ps+w3UcFmRPQBJa7ui5v
         B3hiXGmOJIJWYvRWG+mA18qhUMo9yyH51LJe39RWTb7pkERL+Qqs9wnAREWdj6nQuP+e
         AzwR0nZJ0DZY7iMygr0mif9HvEfNrlbQlcpZPsFnZGoEn47SRO6K9Ae7ZULA0iYurcK5
         OFL3b3zC4CGhd8guOjmQ6tnLbneWWjZmvHwWn3MUqtHo7a1nAsfLx9+zB+loZWd5fsyn
         9Dyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721399184; x=1722003984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kYZZP32OLM66abDpfGOlT54GseEflZJl3/fT3OrXm9M=;
        b=FCA6PzGeNB8PgBqD4urJjDgT5W6JqtE3z9WN+uzohWmuw2d0D4Kh1Z8c0frxy60Ce+
         CRq6oUljo/aOI+3ZDYKM/P9tba/twmahsrDc3UNznTpa8pfIhlIG5xUnGwyg0oZ0YjkZ
         /pdDUPOfEWhoPtr1SUyhHPC2a5DPPyWBIiREG26sTpLaqxWgqA5A8JRzP+abw9kO7KNm
         KHuET+MkRFGYpz0+DQfuKJGUHSI2NRboRJvR8lFvmCbIKv4fgK3+/HC+k+MaSjCq/i0z
         0XRc/3Wfvw6hVMBRs/BllJvDQp8EeD0mRrSr7RrZxcW5IDXmJyCaP7Z87PXeHno/tCul
         Ggsg==
X-Forwarded-Encrypted: i=1; AJvYcCXOJbvJvGHxzwfaz1/Mg6o48X/BAq+B/MoAkA+A9MiVMwLOgqNFQomeK7rNXGQPh0tOKYCdQLdRLucR7dtpEKXb7HBWkR1D0cV92oh7krWP33v/HZwY5CCIysLeWIb/uSt4DiRp15ra+mw=
X-Gm-Message-State: AOJu0YyNamZvTaX82gDNalBdPEAmV62wpLPkMHYL/0+N+Jylq19Bqf05
	FCi3EF5im1t8grf4PW9CfMhGHI0x0ZJ5J3iyTVehNf0316qrHrxfP9tquKHcXJBI8UhomvfnEfC
	O6i8gzMNLPeB0z3ln0JnSIfgWR7s=
X-Google-Smtp-Source: AGHT+IGb1/gRV0iOwfuKjNtDGIRiCr1yZswiyWIgcVq2bdcVPtUHXxxoT8iE5yunQVBLy2lFJ74lMAewnzZpIcVexfE=
X-Received: by 2002:a05:6512:10c5:b0:52c:e180:4eba with SMTP id
 2adb3069b0e04-52ee54420a9mr6098877e87.62.1721399183666; Fri, 19 Jul 2024
 07:26:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719140907.1598372-1-dhowells@redhat.com>
In-Reply-To: <20240719140907.1598372-1-dhowells@redhat.com>
From: Steve French <smfrench@gmail.com>
Date: Fri, 19 Jul 2024 09:26:12 -0500
Message-ID: <CAH2r5mtLC+jFBLNiHF-tovQufBrkPw6SwCC7iUdmRHRse557gg@mail.gmail.com>
Subject: Re: [PATCH 0/4] cifs: Miscellaneous fixes and a trace point
To: David Howells <dhowells@redhat.com>
Cc: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
	Shyam Prasad N <nspmangalore@gmail.com>, Rohith Surabattula <rohiths.msft@gmail.com>, 
	Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

applied to cifs-2.6.git for-next and running regression tests on it now

On Fri, Jul 19, 2024 at 9:09=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
> Hi Steve,
>
> Here are four patches for cifs:
>
>  (1) Fix re-repick of a server upon subrequest retry.
>
>  (2) Fix some error code setting that got accidentally removed.
>
>  (3) Fix the handling of the zero_point after a DIO write.  It always nee=
ds
>      to be bumped past the end of the DIO write.
>
>  (4) Add a tracepoint and some debugging to keep track of when we've ende=
d
>      the ->in_flight contribution from an operation.
>
> I've pushed the patches here also:
>
>         https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs=
.git/log/?h=3Dcifs-fixes
>
> David
>
> David Howells (4):
>   cifs: Fix server re-repick on subrequest retry
>   cifs: Fix missing error code set
>   cifs: Fix setting of zero_point after DIO write
>   cifs: Add a tracepoint to track credits involved in R/W requests
>
>  fs/smb/client/cifsglob.h  | 17 +++++++-----
>  fs/smb/client/file.c      | 47 +++++++++++++++++++++++++++++----
>  fs/smb/client/smb1ops.c   |  2 +-
>  fs/smb/client/smb2ops.c   | 42 ++++++++++++++++++++++++++----
>  fs/smb/client/smb2pdu.c   | 43 +++++++++++++++++++++++++-----
>  fs/smb/client/trace.h     | 55 ++++++++++++++++++++++++++++++++++++++-
>  fs/smb/client/transport.c |  8 +++---
>  7 files changed, 184 insertions(+), 30 deletions(-)
>
>


--=20
Thanks,

Steve

