Return-Path: <linux-fsdevel+bounces-48414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADE3AAE921
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 20:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EA634A7A03
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 18:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8CC28E576;
	Wed,  7 May 2025 18:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUyggFmA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E43528B7EB;
	Wed,  7 May 2025 18:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746643141; cv=none; b=i4pDUB5uuj7k29qydTnkfIqUB0H8dNC0a/odouvWxNMv6zItXhcsiTfvnG1uxw/CXWbVm1NzFXb5a4a43EbpBFfT8SCiJffyzVdETt9pHGQFkiP1a/hSr2eCf9Fi8BcTSw4oQqH0fmoeUZYNnHCIlfDv727bpJ9DET9yoaCB0Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746643141; c=relaxed/simple;
	bh=PV737ALlxa0MeAF/NHQ8BESH0VjY7KX6yUU/8UuLB3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p6KJi/9lQlgAecqITrHlusyGOWEF2V5QAnfHTNcc+fvDHb+ssx8UZInijDlhr8wIJXML9hVnJSM0OGU/ovHU/G04c45SnfEnvoCq2P2yJq/iw+hGtlsjprwchOqvbu72i5apsvEtyG9o1BZsxExiz/Mag2rg+V9AUuIa3NvR0R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUyggFmA; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac3b12e8518so28061466b.0;
        Wed, 07 May 2025 11:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746643138; x=1747247938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WwOZ6sM38vEmJemz8hfnEukIYKzcuyuDEhTG4BejXDQ=;
        b=mUyggFmA7+nVI2aWg6UIjcKXlpi/3DFpnIc3l12yEKSwrsFmruvGLXUhgM6aPKtllW
         IkW9cSmU3br68o4aXQh/Dw2EIepGpcQidzG290e7i7YRHVUf10sLBlZJHQmn/xgFWC3t
         P3cSgfEmh5qvHXyW/GG+RYtCatVyiZGWrzV8Hdlq1O0QpzMBqGvUNF7OvnajRxRSO1iz
         okV2Y3zKRWKhlDoiqOUiA/BWIkBj7uI6rNk/4Zg0gjR10A+QaD9FkJa3T4uwQGqKtHz/
         5nG8ivMdPb9y1T5tFR1JUZOrrNRqlOxjmYRgJo66wpsN4U8wCRUWg+Y1jvTTQgdruwYo
         E9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746643138; x=1747247938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WwOZ6sM38vEmJemz8hfnEukIYKzcuyuDEhTG4BejXDQ=;
        b=RC5INiMT1puTcXUPny9xMskFwfPHvAlG6OPNLV6zQOJpj/UbwNMOfXS0kK9JdWryLf
         /tpJVKRLku6loQ0hrC1A55w1fdvplXId86nFQdyooVeBCbs+pWvousLue6y0Zf59/CY8
         l1j86Xicq5E8jpnihdhmGebyFX4IGTjqKy6ZBAGobsFGwAoQJY7A/Qgbp1gMdXVK4thH
         mjX1GBqanNVanQBX1ch+B/ozi3qppFB+2Mn5fv4fMvLwoxp/15viG7gyN5s8LMW3I09R
         g8AJMvvSwRwmHB+zaRbq8DxUvV0XnQPGL6dzcNQlXsIbaBb581XZCBR2exkeZC5Wo5jG
         O9/A==
X-Forwarded-Encrypted: i=1; AJvYcCVIqZxw1NUzrSbrcO3VbYjRZPyJHswDE1NXIIpBrTexP5pqswU5fp8lNFZas1iMdJjoqYcf3tlnBNLWlqF5@vger.kernel.org, AJvYcCXZtU3fsw41brmrcOzS5crIduiq+uKnD20pQf2oHZe1l19qa5OPb9+xByTNRcM6h53/D3ZxSFu+sPyEkFbV@vger.kernel.org
X-Gm-Message-State: AOJu0YzDeyUOIxtsrAV5l4apVya1G7F8jarG/h2mStIG+zrtHVRyjk3n
	E9tJOUVUmD2Rw1tCCCNBb9ShcY9KNXn1S5ughi3cloRl6j7UG86G2ksUZ14J84YVsmdrfGbYCMY
	8QqMXmZoLsT4rA3vnr9CiDW9d9c4EMkFk5wTRdw==
X-Gm-Gg: ASbGncsqeLGzY5NwRhqn76hx3QMYtql8JNcV0nVaKg8zT5foVHJkmD/Cpu7qk8GtkIL
	F9rc9ziUexb1Ntj/CDXrKhL1+U/UcYF7vyWhG8RHC+fbbR7a2IaZjI5E7lfPO95I20YhSThBeWZ
	RIb6qzLSPVSUmGqgWWB7YPQw==
X-Google-Smtp-Source: AGHT+IFr+3Ye5QMBuJIsFDOQ2klnsMlUpF41G2L/3TujM36UNYhyO4/udyRLjWeLjkwseybUqZhsLAI8bt4uiKLuqhQ=
X-Received: by 2002:a17:906:d542:b0:ad1:a87d:3de8 with SMTP id
 a640c23a62f3a-ad1e8b9580emr478125966b.5.1746643137312; Wed, 07 May 2025
 11:38:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507032926.377076-2-chenlinxuan@uniontech.com>
 <CAOQ4uxjKFXOKQxPpxtS6G_nR0tpw95w0GiO68UcWg_OBhmSY=Q@mail.gmail.com>
 <CAC1kPDP4oO29B_TM-2wvzt1+Gc6hWTDGMfHSJhOax4_Cg2dEkg@mail.gmail.com>
 <CAOQ4uxgS3OUy9tpphAJKCQFRAn2zTERXXa0QN_KvP6ZOe2KVBw@mail.gmail.com> <CAC1kPDPY=qpGNRO3CH6_jSMKh6RyfHPFw71gCcpBZ-ogG41psA@mail.gmail.com>
In-Reply-To: <CAC1kPDPY=qpGNRO3CH6_jSMKh6RyfHPFw71gCcpBZ-ogG41psA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 7 May 2025 20:38:45 +0200
X-Gm-Features: ATxdqUHFHlh6G7irS8Pz1TUWzU4HF3KGg5Uc-QyCpr3WaPLK2uyUoX3kINubol8
Message-ID: <CAOQ4uxg=HvoGFV+WerJcuD-qMyr-9fTBRA_+ZQRejodtBd0mnA@mail.gmail.com>
Subject: Re: [RFC PATCH] fs: fuse: add backing_files control file
To: Chen Linxuan <chenlinxuan@uniontech.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 7:03=E2=80=AFPM Chen Linxuan <chenlinxuan@uniontech.=
com> wrote:
>
> On Thu, May 8, 2025 at 12:57=E2=80=AFAM Amir Goldstein <amir73il@gmail.co=
m> wrote:
>
> > It means everything to userspace.
> > backing ids are part of the userspace UAPI - you have documented it you=
rself.
> > The fuse server used backing ids to manage access to backing files
> > https://github.com/libfuse/libfuse/blob/master/example/passthrough_hp.c=
c#L855
>
> Oh, I see.

For the record, I mean to print the same format as io_uring:
                        seq_printf(m, "%5u: ", id);
                        seq_file_path(m, f, " \t\n\\");
                        seq_puts(m, "\n");

Thanks,
Amir.

