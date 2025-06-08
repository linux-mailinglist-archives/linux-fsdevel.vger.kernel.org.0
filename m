Return-Path: <linux-fsdevel+bounces-50929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D23A7AD12D9
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jun 2025 17:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E56683A661D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jun 2025 15:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C4D24EAB2;
	Sun,  8 Jun 2025 15:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AiYWIozn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F7478C9C
	for <linux-fsdevel@vger.kernel.org>; Sun,  8 Jun 2025 15:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749395211; cv=none; b=cMEXfNQmA1S6v56j9I5rviJe6nTuOdl0PO7helBEQvfn3V5g6N00MklHQ8tlVFxedVvwrmZxxRHpleHVpc1st0/VDRLfY+6RAxCBIMSKdB0D6m+jAXaiL+SAchowecOoZbERNLbLs2vmS34tw+qXlbXM0gKdYdNHrPsdhgdXWjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749395211; c=relaxed/simple;
	bh=MITcrC3F5nd5i2+Vqe9MmqvGNbrT9JumcAsIUER5kzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fj2RWVY0uHTqL1u2wVxoNFgNW1SAasnvVoX2Jj+YvFY60CyBXOSHkKV2td/k9+nrT/CdH88OXngjWbQ8FPebMuQY9eyyPxZDRLIPRsJXViGRmC60xHwrp444Gc6EXoaBd29LXS0SlFW/hizgV2oyOE/zc7j+cGlx4NtYlNbakvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AiYWIozn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749395208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=32hTUAw/xpZ+1jdocsdQHGZ/eU502h+xQ6g/nDhB37w=;
	b=AiYWIoznYT7WOvZUh4UJAbuClntS+A0fLPZcjctjUcAiB1svrcnI2xys8s63oEPz183xkX
	pFfphBAXxridP0jMzeHD+/6mKMwl0QSfzEfc2k01wPmZ6xumak9V5IIC/AcSeTI+DCAvmZ
	IoZGL3DO/DHNHeIttTZ5SfM8wRFWxeQ=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-5B89EqQjPoy3OhtwhwvEPg-1; Sun, 08 Jun 2025 11:06:46 -0400
X-MC-Unique: 5B89EqQjPoy3OhtwhwvEPg-1
X-Mimecast-MFC-AGG-ID: 5B89EqQjPoy3OhtwhwvEPg_1749395206
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-4e775f2d1a3so211608137.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Jun 2025 08:06:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749395206; x=1750000006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=32hTUAw/xpZ+1jdocsdQHGZ/eU502h+xQ6g/nDhB37w=;
        b=Sw7H7mOxIgKm/Y35+vwExjAUpWdruV72VmTGiSYKNLLgyXpCjw0VhSsblqkWEWPFDj
         JwDeaLdDO9WOGvnxW420m9Fb8l71CgT2t8+bLGsy3y0qVJNZPrLfB9umSkVNI7pynIUY
         omhM0fJq4iF4AWj8QrTuWWS2FqTUjH8rCPT5lfWpQSBR+a4TS5KpyH8dxbk+b160JlxA
         qLEeLDA0DVr5Nr+383xCgdFd+0r2TnYo1YmvBdlXynBo6CrlZUFJBZM91whyIGi/9JAm
         0WWa6fB/we2k8TFRmsiVJSuynDGk1IrrPlViqVcz311n9/yNA2xorOmWv4jYuNNW4QHP
         7Tfg==
X-Forwarded-Encrypted: i=1; AJvYcCWRdC0x2qukUciY5mzbt/QElOxSUuL34utYEEkEDIV5wcENqQHy40CQhKFJ+eau3nmHu4NalrSMUodjGHra@vger.kernel.org
X-Gm-Message-State: AOJu0Yyup1SJoGO4+oGmrgmLeTJk4aE2zClc0sQ5i5kiCwxS/7MfmOx5
	5fwCn/NouG63+Aq+A7VapfmVTlviucAZlFeEwUgz8SnzpUwBWekRC2a/D9hk/tXNBGNGN9Q0g1P
	MrGDpv02234NvNZ5a0c4hLMd4DAsQTPDvWOzyfmCQqpun13dmz98uI9m/K+e51k5kP92QTj6em3
	HNRwH2iOR3LktQpz1DOOlv+8xh8lcM8CHCnHe5L0pNsQ==
X-Gm-Gg: ASbGncvZi+LO2BC+jDOllt//Qur1Asc227kzvM1jiszYbeOq7mX2vVITUMmKE1bfplj
	PtY970bMSrIfFnLrkI78NqwRFq2iW8farKVy+8uBn+WMV7AMJsGWkGgJSeT01UalzDkfNcZdqT8
	fwoak=
X-Received: by 2002:a05:6102:458a:b0:4e5:93f5:e834 with SMTP id ada2fe7eead31-4e772ade074mr9247916137.24.1749395206260;
        Sun, 08 Jun 2025 08:06:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmU7O5VbKAYIwDPSdC251qcnesmgsa6yOTiFhiI07/Aryqa52oyHAzSdbVa9G2kY63iGJJFwgpJIvbdxMoEH4=
X-Received: by 2002:a05:6102:458a:b0:4e5:93f5:e834 with SMTP id
 ada2fe7eead31-4e772ade074mr9247884137.24.1749395205956; Sun, 08 Jun 2025
 08:06:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606190521.438216-1-slava@dubeyko.com>
In-Reply-To: <20250606190521.438216-1-slava@dubeyko.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Sun, 8 Jun 2025 18:06:35 +0300
X-Gm-Features: AX0GCFvciVRCAjxa1zpih-dLhNmd4RBOeZ4q6loeeFbMdgN2huyJ_qLoKl-Ggzk
Message-ID: <CAO8a2SgJd+hB-6f+6i1ViibR=UmHj=kX7c7mnOSO_vWQ4i4UaQ@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix wrong sizeof argument issue in register_session()
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com, 
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com, Slava.Dubeyko@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed by: Alex Markuze <amarkuze@redhat.com>

On Fri, Jun 6, 2025 at 10:05=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.c=
om> wrote:
>
> From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
>
> The Coverity Scan service has detected the wrong sizeof
> argument in register_session() [1]. The CID 1598909 defect
> contains explanation: "The wrong sizeof value is used in
> an expression or as argument to a function. The result is
> an incorrect value that may cause unexpected program behaviors.
> In register_session: The sizeof operator is invoked on
> the wrong argument (CWE-569)".
>
> The patch introduces a ptr_size variable that is initialized
> by sizeof(struct ceph_mds_session *). And this variable is used
> instead of sizeof(void *) in the code.
>
> [1] https://scan5.scan.coverity.com/#/project-view/64304/10063?selectedIs=
sue=3D1598909
>
> Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> ---
>  fs/ceph/mds_client.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 230e0c3f341f..5181798643d7 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -979,14 +979,15 @@ static struct ceph_mds_session *register_session(st=
ruct ceph_mds_client *mdsc,
>         if (mds >=3D mdsc->max_sessions) {
>                 int newmax =3D 1 << get_count_order(mds + 1);
>                 struct ceph_mds_session **sa;
> +               size_t ptr_size =3D sizeof(struct ceph_mds_session *);
>
>                 doutc(cl, "realloc to %d\n", newmax);
> -               sa =3D kcalloc(newmax, sizeof(void *), GFP_NOFS);
> +               sa =3D kcalloc(newmax, ptr_size, GFP_NOFS);
>                 if (!sa)
>                         goto fail_realloc;
>                 if (mdsc->sessions) {
>                         memcpy(sa, mdsc->sessions,
> -                              mdsc->max_sessions * sizeof(void *));
> +                              mdsc->max_sessions * ptr_size);
>                         kfree(mdsc->sessions);
>                 }
>                 mdsc->sessions =3D sa;
> --
> 2.49.0
>


