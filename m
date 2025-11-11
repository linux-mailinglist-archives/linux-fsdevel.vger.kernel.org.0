Return-Path: <linux-fsdevel+bounces-67999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDE0C4FE2A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 22:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 08EED4E3F90
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 21:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C217D326955;
	Tue, 11 Nov 2025 21:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6UltxeT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DB4317706
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 21:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762897037; cv=none; b=F5HZf6wS3xPu6qeke6rOKaJ+arpPFPRuqzfyBKOZVnwsiBF65DzoqAqn9t7JIeHS2SmImpCam2yum7je+aCej4SsT3V2Gbu+40GtFPuStpp2QkyhPTiGtUjbscngg+V9sVPSqb0C9x3V/i0sZl0zSnoWM2+7R4s/4xp6gOwB6Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762897037; c=relaxed/simple;
	bh=EYDbDcuROBgBT+pTg8UkpNsR/0U0TMWxx9V21LB4ea8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mha3DTRrDzHh5/ycC4PfX88UFDZjeFoU1apyZgbcmFISj8I3d1UbUs0re2BB085NPXca5wIYiuzohy49ZDcmEUT6MxwbVqtxnev+G+SF3ardz9z3dhV6kKVOfPXaLbgz1PiSHkOGVpBqm9YKOl0Pg4mmTeo1ei9Hx/A39Q7zQ24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6UltxeT; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b8c0c0cdd61so125584a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 13:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762897035; x=1763501835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTkH8R1tmJJjrkk9nlGD9gsFksiAaPNa0XLwG/EYRKs=;
        b=C6UltxeT4LBmpMVPEiRszq+luP9uQBsNXKIxxNObGcig4iHH92PuqtrOvCbvtJIwdU
         4yR+AUjxa3tqg9ZqA46WkX5oAAAU1Dz35HY75FwpgFFtZjXBsqO9z51wpRGvNm8zT3YA
         VPmWDru0+a0ElH1JoRT8MR0taFKeSOpJ+bMqu+eyVt2V2R7eOjImDcS8TOi1lqjIhoAl
         yQBoAgVhs8vYJ3bUoWLqa0lZpXXhqnOVPtPzPzEMNa4e6uhXWl/JFauIcCTUkF6SSczQ
         ETAOEtvdM+sfmFGPg2Qr65BUtRIfax78pcirx7+VHR8YRAy6tUhE+0giCEzqOwIb1pAx
         2m7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762897035; x=1763501835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RTkH8R1tmJJjrkk9nlGD9gsFksiAaPNa0XLwG/EYRKs=;
        b=QAf4mwBZTLx+X+DZradnQPcxFkEPzqNZ5l/xXubCdMFDbdw0m2Ar3tYMigBsV1g9pE
         QdlIgk9JilVDmDieS5vFVB3nX+rmZXccCWepHolCOdjaW0uIZUHaYJ6RTJ1SELQLiO3m
         lNCebQAZRCNd8vyz4b6mneK6Ltw7Rw9UZ6xpe3zhYAxcLLlOKd3dwou/CZlXq0XGYorB
         q0q4dAfRZjfb8SJrbl3t9iIB3zCfUuayO65YUmmlqUdsL8ZxKoOyiS+NKE28ZeVAL7BJ
         zjTElCvveKA9rYkvxnl1OoqsUTv3h0ZMw6Y7l4PY7lmi1hiKAwjd1A1Dnlf/QjfM5lcm
         magA==
X-Forwarded-Encrypted: i=1; AJvYcCUO3Eoi46VriGdzpd/vWcrBONpBllxv44rWjvNQ2Nj3cNXgljS8/GaZWYfTtgrmxyvfjRidsSgN4cujSveZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz15tZsY9wH80Hg3YHhlmvDCjIvdU/EjWisFmJxClewJXOAiCd4
	C3qmkGPBZD96khVkEaUJB04qQlfzAJc+pS3sEoeq8abkadchbjZ1fAB1xoQdh3VI60+CKldls1o
	+YWs53GGZQJtsFCG/DU5YViZkeGGf6jE=
X-Gm-Gg: ASbGncsgW4/4y+qEh2juF+tGjvdiY8Lc7fpcRbOnz8EI1+VWfiPHC70cLUG5A3FWEMi
	7nCW1vmk7VFk30v/mYTTaxi5l9KaqL72Ib20UT+e4zPYC/UUoj3CnAbsOFx2gJKh+p5im5y1L3P
	tm5qJ+CwZLcVg/tnJoEChrkQsVC7ZEfRc6Z2pv8QJ11nRvgkFpJcH+eDd4/B/de9d5iLgS1jvgl
	R1YF4pSgi6qs2jQT/0KPZ8mkvqjEdc44B2pvOnq/lxKzH8WgR5Ro41SYAWNJou9kH3n3FA=
X-Google-Smtp-Source: AGHT+IGouFBEbImDSLi3o8hAs4vG/yROxxQ5Ye+ck7MBfPE/TMSUahljkZ0pr4e0Jtg+dx820cxj2OcmRrdUMuaXaNw=
X-Received: by 2002:a17:902:ce83:b0:295:9e4e:4092 with SMTP id
 d9443c01a7336-2984ee05655mr9153845ad.56.1762897035186; Tue, 11 Nov 2025
 13:37:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111205627.475128-2-slava@dubeyko.com> <CAOi1vP_tHEgBn-+EmSeOtpWnQezEZDnGWapGZ3ngXZYkzvPpiw@mail.gmail.com>
In-Reply-To: <CAOi1vP_tHEgBn-+EmSeOtpWnQezEZDnGWapGZ3ngXZYkzvPpiw@mail.gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Tue, 11 Nov 2025 22:37:03 +0100
X-Gm-Features: AWmQ_bmeptX2xT3ZqAGwLnw2pDIbz79m30BfjBNgOZ44D9hCNFZfrND2Dbww-3o
Message-ID: <CAOi1vP8uaeSQtnHKSk+=4121VDzNB2tDD+rPZkMzRb4GzD+3BQ@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix crash in process_v2_sparse_read() for
 fscrypt-encrypted directories
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	pdonnell@redhat.com, amarkuze@redhat.com, Slava.Dubeyko@ibm.com, 
	vdubeyko@redhat.com, Pavan.Rallabhandi@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 10:35=E2=80=AFPM Ilya Dryomov <idryomov@gmail.com> =
wrote:
> >         int ret;
> >
> > +       ceph_msg_data_cursor_init(cursor, con->in_msg, con->in_msg->dat=
a_length);
>
> This line is too wrong, please wrap before the last argument.
                   ^^^^^

I meant long, of course.

Thanks,

                Ilya

