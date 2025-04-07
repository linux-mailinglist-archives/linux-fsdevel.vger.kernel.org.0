Return-Path: <linux-fsdevel+bounces-45833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A72A7D25C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 05:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5294F1670A6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 03:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94BF213254;
	Mon,  7 Apr 2025 03:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erqqHE6C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E43212F8A
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Apr 2025 03:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743995617; cv=none; b=rUtO4kdmwmwSShRYuhfMU4kmy+XOYHcCPE/CG/XOv3k8ACjk8HZqUTo8VytEnsdOUzaGY1oWPq8vZtjTRzo0A6nAdH1LFZhjBTktbK04FRLvZpNdaeRe2T2R9PvyRdCGUAAzjH9zOk52v50G51odYt1g+awARW9gB0UA5mcjuxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743995617; c=relaxed/simple;
	bh=yGC7W48pGIR14uwgfpwb5QbtLcySgKLjTGaKrunxkxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=HKoAD0tvAcU06YRx3NPqJrBT4pcA2FyLMFSogJqiSI6q59izUdFZlzDEG9PFAp4m4T4SYYZfk/6WJD+U5jAdDjXMBobHncb7yTjwF7/ZEkNQjc0b3fZHDFpNVoYM04IUd8sjSXg+HgQ+ync1JDDL0AQ7hDnevGg9ksG7T2DKBpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=erqqHE6C; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4766631a6a4so39449791cf.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Apr 2025 20:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743995613; x=1744600413; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vPQVY4WOstGEl2DC9PQd1EMUw4jAZBuklAEaNTH+0Os=;
        b=erqqHE6CEZNHNfbN8pVGcw6iiWQPKEa3as02LXDoDVdOMpVYwYTidCX+LD2SumAaVB
         xdH488uFT2I7WIWNtrymiDd3nYIi6mfdVhLZyrVHmM1H8XhF5y5cin8sXn69DYwqy47u
         Sjh+yFrgW3Zwe2bx0wA9rnvG71SRdbzagLKOFGEtlqKs4an3ZftbwFF38KMgsDxjVi4g
         T2/90Y1oCToX37SjvAJ1irrtTqwXdK7cLtkfg5xDk5EsxnrZ3CFGFUrhtYRV8XrXVVw8
         o1Xtx6wwR92e2/RCp+QiyX2qSnwCVB5TEJoG/9mMcyRPwMx795DkRRjwdfZQPd91fXsf
         JDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743995613; x=1744600413;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vPQVY4WOstGEl2DC9PQd1EMUw4jAZBuklAEaNTH+0Os=;
        b=dwC3yzkdQT/HsaI5fe//crXrkWDflTxmHWXg8NfBw0RADKk7xGUNfRfUuBMF7kj+HO
         fWX8L2SSTkb/pR1T/yOAocNNHrfkPIrp+FxzftNEo86G3n2kzmIcMenLcR5AvUyvUs1Z
         h5vxxEGbXlPpsnAX8reSZvWMfjDQnbTOp3B+ooCwFwxv9WUEBbIcS5UbmjyH5Yr9g8Do
         BYS9xx2fvYTgbJfQw0iAuLh56CJLBbvJ3UrInCh23V60boQL0fGoLCOkfEJ2LfoCXQeC
         HzuUZjFGEvRkumXmABmOW4cDCaJyi7Y7nbLLXtLfG2C0dcckljmEgI+esUyC6bBuch0Z
         HLYw==
X-Forwarded-Encrypted: i=1; AJvYcCVGfeIH22KFj/ifxhhSRZUuaGMcAP6igeFruNyTWlu0sQhztNH7E2JZWlaTBN4eqnPViFgDUmt5ctK62b9N@vger.kernel.org
X-Gm-Message-State: AOJu0YzQTUdNMvRzfcC8BHX6KXS6ngsni4iWdTFa9wJvctigSMcZbcx4
	wDy+CT2w4jOQl9lway4u8dROoQdnHbaUFicDnCrV+yD1Dz6wB8Jb48eUyzuFCBgp0gyJA7uPtMi
	jXTsC/6+TnE0wjwFfzUzinIuqMGc=
X-Gm-Gg: ASbGncvIXzP39tk5WNHLozkgF2mDTi3YxPQMlHpA38P0jApPV7w9YFO7GAVy3H2ew05
	wLF4/nZYXZjvdPc+8JAQ81TdjtzsPEiwU5l88yP4daucZ5rkyPserR9F/JXmP3Enl9WqbHIrzWR
	00ny30sk3Qscm/FQ0+tPjglJt1+3M=
X-Google-Smtp-Source: AGHT+IHNm4DcMOYCFt5CSjMwqq0XExLgak27FoxSmqtjNEkPsxuFQudJxcHK3Hljvd54+UWbfKkumfHlYBjnulyZ+oQ=
X-Received: by 2002:ac8:58c2:0:b0:476:7b0b:3110 with SMTP id
 d75a77b69052e-47930f97387mr105228281cf.20.1743995613351; Sun, 06 Apr 2025
 20:13:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALf2hKtnFskBvmZeigK_=mqq9Vd4TWT+YOXcwfNNt1ydOY=0Yg@mail.gmail.com>
In-Reply-To: <CALf2hKtnFskBvmZeigK_=mqq9Vd4TWT+YOXcwfNNt1ydOY=0Yg@mail.gmail.com>
From: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Date: Mon, 7 Apr 2025 11:13:22 +0800
X-Gm-Features: ATxdqUHw2AYcYwDncI101N28YFmcnPdXhi2dhhGFlrzPD-Y6Dyb5mAtf5TeKAuM
Message-ID: <CALf2hKtNemTQPCGkbCfRZj3Lkd_2-L2QX+Y2rUxGgxMgdpJ8Jw@mail.gmail.com>
Subject: Re: [Kernel Bug] BUG: unable to handle kernel paging request in const_folio_flags
To: mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	ocfs2-devel@lists.linux.dev, willy@infradead.org, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Is there any update on this issue? Shall I sumit a patch for it? If
there is anything that I can help with please let me know.

Wish you have a nice day!

Best,
Zhiyu Zhang

Zhiyu Zhang <zhiyuzhang999@gmail.com> =E4=BA=8E2025=E5=B9=B43=E6=9C=8823=E6=
=97=A5=E5=91=A8=E6=97=A5 01:52=E5=86=99=E9=81=93=EF=BC=9A
>
> Dear Developers and Maintainers,
>
> We would like to report a Linux kernel bug titled "BUG: unable to
> handle kernel paging request in const_folio_flags" found in
> Linux-6.14-rc7 by our modified tool. We have reproduced the crash and
> applied a patch that can avoid the kernel panic. Here are the relevant
> attachments:
>
> kernel config: https://drive.google.com/file/d/1vHuHlQyiKlXbyuo03sZTiuaA5=
jZ5MtV6/view?usp=3Dsharing
> report: https://drive.google.com/file/d/11LD1uFid1u3r7brsvd85-SrBzvXwH-w2=
/view?usp=3Dsharing
> syz reproducer:
> https://drive.google.com/file/d/10v3FtkewHcAnTjsUGqFCDl7k7hiCJ12-/view?us=
p=3Dsharing
> C reproducer: https://drive.google.com/file/d/1L9WTVbO2pfqXLjXyQcMy4f-Am3=
obTJcN/view?usp=3Dsharing
> crash log: https://drive.google.com/file/d/1zwYU3061pnTSVIEpuZ-EBR7FYvWPx=
X4z/view?usp=3Dsharing
>
> We speculate this vulnerability arises from a missing check for error
> pointers in the array folios[i] within the function
> ocfs2_unlock_and_free_folios(). When the kernel fails to write or
> allocate folios for writing (e.g., due to OOM), the wc->w_folios[i]
> may be assigned an error pointer (e.g., -ENOMEM) in
> fs/ocfs2/aops.c:1075, which is then returned as an error to
> ocfs2_write_begin_nolock(). Within ocfs2_unlock_and_free_folios(),
> there is no proper handling for error pointers, so the function
> attempts to process folios[i] directly. This results in the kernel
> attempting to dereference an invalid pointer during the call chain:
> ocfs2_unlock_and_free_folios->folio_unlock->folio_test_locked->const_foli=
o_flags.
> Specifically, during debugging, we observe that the kernel attempts to
> read data from rbx+0x8 (where rbx =3D 0xfffffffffffffff4), causing a
> page fault and kernel panic.
>
> I tested the following patch, which prevents the kernel panic by
> checking for error pointers before accessing folios[i]:
>
> --- a/fs/ocfs2/aops.c
> +++ b/fs/ocfs2/aops.c
> @@ -767,7 +767,7 @@ void ocfs2_unlock_and_free_folios(struct folio
> **folios, int num_folios)
>         int i;
>
>         for(i =3D 0; i < num_folios; i++) {
> -               if (!folios[i])
> +               if (!folios[i] || IS_ERR(folios[i]))    // or use
> IS_ERR_OR_NULL instead
>                         continue;
>                 folio_unlock(folios[i]);
>                 folio_mark_accessed(folios[i]);
>
> However, I am not sure if the analysis and patch are appropriate.
> Could you check this issue? With the verification, I would like to
> submit a patch.
>
> Wish you a nice day!
>
> Best,
> Zhiyu Zhang

