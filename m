Return-Path: <linux-fsdevel+bounces-50930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA62AD12DB
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jun 2025 17:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAA2716876B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jun 2025 15:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DC82505CE;
	Sun,  8 Jun 2025 15:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aayEj3IL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFC32505AF
	for <linux-fsdevel@vger.kernel.org>; Sun,  8 Jun 2025 15:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749395242; cv=none; b=nJWHTbv8tlHEp2KsNdJC1C01jtYfGUvvc//LEuWg9IA9dC7kDTI9Zu2tiWNG5PdmrATrCoUwwlvZ6Q4wX/Gc7mggDqaoEiR7yJz8HYHET+t1BLCEsJnsm5oCd/Jn2DhkZmtjVz1Up1CMKj2ubTC1lz023AUB9fBfcIZWfA7Tbn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749395242; c=relaxed/simple;
	bh=bWM3F234xLwCvNWi74EmLuLiAWakpD4gug5a93vVJIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iV136XF/cPDggnj0Za8YkdWCczJsso248LSAWAiOf5qTWOG+EjwNDoo7ASV06/plZh5MT2yyg55kziKLoqqoGDfLw5AwWZ3aTsctVCcXpxUq9D2nGYE8463LdcIWdqAxuCJc3u7B/mhxjxqAvYuwgGTZtiaWQJ5mklVvCOqIZyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aayEj3IL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749395238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qe8FdhFYZnl5uKznrvXsigqbG5dH1PHILMaKQyy33bQ=;
	b=aayEj3ILdGFRNg8CmlGOT9hHPkpPppG0cUKbg8AiagtqSclKgeTQu3GiDTzSwu5riKcMjF
	2Wm0+lLT/cAZzCAnltdrJN2hoW0M+n2vgz6/mCc47bFNKGUPx1u3/M+5o6dwXIPXq+sFQv
	OA88FGSSZnJAtyczQV2shHVT4ZS5t4c=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-BBVp75CUNMiUkpX-9JmmOA-1; Sun, 08 Jun 2025 11:07:15 -0400
X-MC-Unique: BBVp75CUNMiUkpX-9JmmOA-1
X-Mimecast-MFC-AGG-ID: BBVp75CUNMiUkpX-9JmmOA_1749395235
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c5e28d0cc0so556758185a.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Jun 2025 08:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749395235; x=1750000035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qe8FdhFYZnl5uKznrvXsigqbG5dH1PHILMaKQyy33bQ=;
        b=a/JdaU2oz30INdM1Nr9bA3Fhxn96Wx2/INp7EO2P9uUyDVpKiKZbyt3vOwJse3/ewQ
         fgtbkbJRuhUJ6ZM/kajXgRrYA0SF1NRktDtTbZUenf0xhbcDtH5LfvNRnGtOI5Rly6lo
         ROB0q2BFgeA5jW4adI9nqZkqfIvGj9vk+B9Z6pPNZUvnoxFT/i2ppwYnuBEqSyv1KGGu
         Lp2wCaNBgM3ODS6Bt9RmEjXiFkyuJzW0i6kJqpUGz5pO6K6yHhaFKggpoHQvobMn97Uh
         n2JSZCRlYL7wDzqndxpJuNzI3nxOkWuj+11S3VHu4AfThlf1/pLK90LDzSXuP2Llkp3N
         WtZw==
X-Forwarded-Encrypted: i=1; AJvYcCVmMJfITxp8GhQ4Ec7M9NsvbqEM3ihUDBVLhY994aEi/o8s3rUz4+7XgBTwk67WulRmEQeUDeBSpFJndqSj@vger.kernel.org
X-Gm-Message-State: AOJu0YwgLRw0KLIFfvbsIZCi5zb/BY5R9ylM19R4tTiTUO7DZBJ67CI7
	E/Q1du5yEgf/hSJ3TGNX0XQhFSl0sJaeXFK/lZMf0qAveqebW4fg6pQnpYBBvVwfCNGKztBBkdc
	e7otTE7PGoSpZjM5xOemw0eWW7/k6J8xMVbZNrJPTYchbUU0/0OUgNNlqAdQK8gohrXcjE7j8Wh
	j6H8BuXxjaJC7E0+5zjSdTimOkxLfg5uKjEgjpgpmDJQ==
X-Gm-Gg: ASbGncvJEVMe+W4Cc2BJ8dApduwvM0Cnf3M6N/s+Oak7ToloJs3UNrFvhzLXb9Ovc87
	1uFWh7la3CPZB5NY2Dj0cnQLyGTu8ZDhuyLGqEEymTUcLspcByDPsMV5lvwtLdAP932Nrf75wbs
	4qKws=
X-Received: by 2002:a05:620a:4447:b0:7d2:25df:4e30 with SMTP id af79cd13be357-7d2298eb391mr1734443785a.48.1749395235463;
        Sun, 08 Jun 2025 08:07:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFndNHijDgv+d3Mmf8A9vptGVGLU273o7QFaSjhBtY1oc/gyRzlk2eHmaZGE5nkf7EK+zh6gnx0L7wG5IDNUno=
X-Received: by 2002:a05:620a:4447:b0:7d2:25df:4e30 with SMTP id
 af79cd13be357-7d2298eb391mr1734440885a.48.1749395235194; Sun, 08 Jun 2025
 08:07:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606190432.438187-1-slava@dubeyko.com>
In-Reply-To: <20250606190432.438187-1-slava@dubeyko.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Sun, 8 Jun 2025 18:07:04 +0300
X-Gm-Features: AX0GCFsdf9pnv04pEi6pK8zoebl06DM9Jqii1jy1KXPxQIwSvgOtkUp4A4H2Pgc
Message-ID: <CAO8a2SjAv6TPwVRurTgBq3D2N=N_F=-PBy=Qk=aEesgBkPfgzA@mail.gmail.com>
Subject: Re: [PATCH] ceph: add checking of wait_for_completion_killable()
 return value
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com, 
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com, Slava.Dubeyko@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed by: Alex Markuze <amarkuze@redhat.com>

On Fri, Jun 6, 2025 at 10:04=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.c=
om> wrote:
>
> From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
>
> The Coverity Scan service has detected the calling of
> wait_for_completion_killable() without checking the return
> value in ceph_lock_wait_for_completion() [1]. The CID 1636232
> defect contains explanation: "If the function returns an error
> value, the error value may be mistaken for a normal value.
> In ceph_lock_wait_for_completion(): Value returned from
> a function is not checked for errors before being used. (CWE-252)".
>
> The patch adds the checking of wait_for_completion_killable()
> return value and return the error code from
> ceph_lock_wait_for_completion().
>
> [1] https://scan5.scan.coverity.com/#/project-view/64304/10063?selectedIs=
sue=3D1636232
>
> Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> ---
>  fs/ceph/locks.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
> index ebf4ac0055dd..dd764f9c64b9 100644
> --- a/fs/ceph/locks.c
> +++ b/fs/ceph/locks.c
> @@ -221,7 +221,10 @@ static int ceph_lock_wait_for_completion(struct ceph=
_mds_client *mdsc,
>         if (err && err !=3D -ERESTARTSYS)
>                 return err;
>
> -       wait_for_completion_killable(&req->r_safe_completion);
> +       err =3D wait_for_completion_killable(&req->r_safe_completion);
> +       if (err)
> +               return err;
> +
>         return 0;
>  }
>
> --
> 2.49.0
>


