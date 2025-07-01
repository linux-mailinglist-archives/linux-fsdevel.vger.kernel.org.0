Return-Path: <linux-fsdevel+bounces-53530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09ACFAEFE09
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 17:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD1BE4A5030
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 15:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9F6279DBE;
	Tue,  1 Jul 2025 15:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b="dSL3j6YY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C410D2797AA
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jul 2025 15:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751383453; cv=none; b=NZh3t8Yk9+nP6cQa8TDuLTbUvHxYR5yTy381FdLUhacAI+NUKizc/YzFpHlbYuguA5tJK+t6qX2U0egLE1NUj+iuGXr3ZJe9WFwrMmPSTg81fuZSsn3w4xpwIPiBYQaHtrpMgig+lm6emK6KAQTnBvuWLaFwLfjOQCCIgRtsmKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751383453; c=relaxed/simple;
	bh=KA9ODyRRf+UBfYBzhhZp8RYRH1PTEq1C15fpPH4METo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gr6mgye+sKHGw9tIz0UDXeHtZoGcfa2LZzTfJhnl9VGA8RjK7vR45Q1VIM7OCrivrbZVVUC7HMhrYp57Pj1XgcA+0XIFT9oxLg7mB3m3+4WgiZRZBoQv6n0I6m4Mjksy2dMDywotUVfIdkpkASL1m7AwaJ0agNObNWHve7FG/U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com; spf=pass smtp.mailfrom=omnibond.com; dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b=dSL3j6YY; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omnibond.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-313eeb77b1fso2667190a91.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Jul 2025 08:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20230601.gappssmtp.com; s=20230601; t=1751383451; x=1751988251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtMZYsy2INz7OM+nmuG6EuPPR9OM94xwy6B8MUHX1WY=;
        b=dSL3j6YYf85fOS4G/6lIi+auP2ptHDw4xR0HPHvcMtGH3CT1h7MgiuuyPvn+3qWcbV
         WbjBbroRE9V3Eb5LAc7Umgy25a3dOVUZFqBaS8/22d7LWslRgJYbjhZBQyLH366o8ODU
         BZVOQ2iZn5laO2/FuAinkUieM5bIqkY33M3Q+k1QrRgtcv+i4AMmRRsb+O5h4LRsGS4/
         4B6Mq/CKHlvcwcZ2IjiLocwVdK4qxu/ZpbfmS+ZJShYvyPIFWbY3p7bc7CJcwvVRI1OF
         kYeilCTaEk9RGClTxuY59rRoQZYRfaPA+YvYxaaUFXJ01W1E9ETCcHUS76R9cN2Yxztb
         YTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751383451; x=1751988251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DtMZYsy2INz7OM+nmuG6EuPPR9OM94xwy6B8MUHX1WY=;
        b=wt8yWb21pvoVttmqth10AaJaFi5eBIMVFKzXpyYYGaUlvPLsrurn73FNEkOmR/jcXm
         HHzaYNGdlQH58o059dKMaO+EiR7TnjBsVKGO4KcWQP4kOzOULiQPit3YO2ccrzlxadJk
         Elr5H3ovxTBj5YzWWEYyuncsBQNpe5Dg2iBaT3Hz3tUihhBB8qZUs7QVmIz385731vWs
         G7CFJrh9YMwB1TaQGdWlls0e3RshHzDiFUGiPAfi8FsUL6H3hs4GUZqx77+QoISYhVU2
         SxUUHEXteExBTlm/Noo5GNf2i8LgQ+7Q3eGOS3uAk82f/szTZIiXDtY6aZ4CcLQqidsh
         Hkzg==
X-Forwarded-Encrypted: i=1; AJvYcCU7lwTKBAIywLcr+qpzsdnOzYPCn1N3yJU12jZs9gEYn0t2XmrJQVaGFkkoN2+vJrfXaRokNTCIZLFL6IgK@vger.kernel.org
X-Gm-Message-State: AOJu0YzxhewyBVKFNeAdgY4KGg2QA6dJ4dssEjDnrx/qhgN90whEAS3v
	Er93cRs+WV1HbUlsuxCNTnK7qIaICJTHXtvg61eqS259StmcSzYlH4vH4Ugkijla1LSLgfAh3/5
	5OcfzM/gsDsE+iIU1gFVpSJYEdTQaBBBcIaz+d0jmFRU2PL3Imp4=
X-Gm-Gg: ASbGnctURJpmO13LXz8WoqPgHbI3CmyYx8zgjN2R+cDETbndS627Xw1ua9SLcyq4w1S
	zclauAGaqwfkAL+JXKd80MOmPdQAPIu6YYvcDrcxFOoDflVpTwHJlrX4U6BsA3OaXkQHTdO8X2+
	AcCCOneOa1jwUMZwnAIi6nCu8XgeJOqf1ldK3iYGNg3LX2US1NtH9HLZs=
X-Google-Smtp-Source: AGHT+IHI0Dve+NCFkA17jJsHD2vjpfbyP+YtEvQH8vjGVnJrWzDYwPZNbMLX1MSm5FQn0EApBiwCpvGbWtB2BSHF5/Q=
X-Received: by 2002:a17:90b:2dd1:b0:311:f05b:869b with SMTP id
 98e67ed59e1d1-318c930f9e9mr21667197a91.30.1751383450909; Tue, 01 Jul 2025
 08:24:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624152545.36763-1-shankari.ak0208@gmail.com> <CAPRMd3kM8Eaf64vdMd+43cuV-QTBca9Zxm+Ou4S-DFCY5ovDBQ@mail.gmail.com>
In-Reply-To: <CAPRMd3kM8Eaf64vdMd+43cuV-QTBca9Zxm+Ou4S-DFCY5ovDBQ@mail.gmail.com>
From: Mike Marshall <hubcap@omnibond.com>
Date: Tue, 1 Jul 2025 11:23:59 -0400
X-Gm-Features: Ac12FXyZ5SO4i36eiyT3nJ2ClMSI9KR9oOEBuBstY0HrkZKGrIFtXNJsB9FYKdM
Message-ID: <CAOg9mST4S-d=Fcio64MLVHouSmNi2P7r9Fc8pMHL1HyWCYnT0A@mail.gmail.com>
Subject: Re: [PATCH v2] fs: orangefs: replace scnprintf() with sysfs_emit()
To: Shankari Anand <shankari.ak0208@gmail.com>
Cc: devel@lists.orangefs.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Mike Marshall <hubcap@omnibond.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I have it xfstested and plan to upload it along with a couple of other
patches to my linux-next tree soon...

Thanks!

-Mike

On Tue, Jul 1, 2025 at 2:13=E2=80=AFAM Shankari Anand <shankari.ak0208@gmai=
l.com> wrote:
>
> Hello, can this patch be picked for review?
>
> On Tue, Jun 24, 2025 at 8:56=E2=80=AFPM Shankari Anand
> <shankari.ak0208@gmail.com> wrote:
> >
> > Documentation/filesystems/sysfs.rst mentions that show() should only
> > use sysfs_emit() or sysfs_emit_at() when formating the value to be
> > returned to user space. So replace scnprintf() with sysfs_emit().
> >
> > Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
> > ---
> > v1 -> v2: Fix minor parameter error
> > ---
> >  fs/orangefs/orangefs-sysfs.c | 28 ++++++++++------------------
> >  1 file changed, 10 insertions(+), 18 deletions(-)
> >
> > diff --git a/fs/orangefs/orangefs-sysfs.c b/fs/orangefs/orangefs-sysfs.=
c
> > index 04e15dfa504a..b89e516f9bdc 100644
> > --- a/fs/orangefs/orangefs-sysfs.c
> > +++ b/fs/orangefs/orangefs-sysfs.c
> > @@ -217,36 +217,31 @@ static ssize_t sysfs_int_show(struct kobject *kob=
j,
> >
> >         if (!strcmp(kobj->name, ORANGEFS_KOBJ_ID)) {
> >                 if (!strcmp(attr->attr.name, "op_timeout_secs")) {
> > -                       rc =3D scnprintf(buf,
> > -                                      PAGE_SIZE,
> > +                       rc =3D sysfs_emit(buf,
> >                                        "%d\n",
> >                                        op_timeout_secs);
> >                         goto out;
> >                 } else if (!strcmp(attr->attr.name,
> >                                    "slot_timeout_secs")) {
> > -                       rc =3D scnprintf(buf,
> > -                                      PAGE_SIZE,
> > +                       rc =3D sysfs_emit(buf,
> >                                        "%d\n",
> >                                        slot_timeout_secs);
> >                         goto out;
> >                 } else if (!strcmp(attr->attr.name,
> >                                    "cache_timeout_msecs")) {
> > -                       rc =3D scnprintf(buf,
> > -                                      PAGE_SIZE,
> > +                       rc =3D sysfs_emit(buf,
> >                                        "%d\n",
> >                                        orangefs_cache_timeout_msecs);
> >                         goto out;
> >                 } else if (!strcmp(attr->attr.name,
> >                                    "dcache_timeout_msecs")) {
> > -                       rc =3D scnprintf(buf,
> > -                                      PAGE_SIZE,
> > +                       rc =3D sysfs_emit(buf,
> >                                        "%d\n",
> >                                        orangefs_dcache_timeout_msecs);
> >                         goto out;
> >                 } else if (!strcmp(attr->attr.name,
> >                                    "getattr_timeout_msecs")) {
> > -                       rc =3D scnprintf(buf,
> > -                                      PAGE_SIZE,
> > +                       rc =3D sysfs_emit(buf,
> >                                        "%d\n",
> >                                        orangefs_getattr_timeout_msecs);
> >                         goto out;
> > @@ -256,14 +251,12 @@ static ssize_t sysfs_int_show(struct kobject *kob=
j,
> >
> >         } else if (!strcmp(kobj->name, STATS_KOBJ_ID)) {
> >                 if (!strcmp(attr->attr.name, "reads")) {
> > -                       rc =3D scnprintf(buf,
> > -                                      PAGE_SIZE,
> > +                       rc =3D sysfs_emit(buf,
> >                                        "%lu\n",
> >                                        orangefs_stats.reads);
> >                         goto out;
> >                 } else if (!strcmp(attr->attr.name, "writes")) {
> > -                       rc =3D scnprintf(buf,
> > -                                      PAGE_SIZE,
> > +                       rc =3D sysfs_emit(buf,
> >                                        "%lu\n",
> >                                        orangefs_stats.writes);
> >                         goto out;
> > @@ -497,19 +490,18 @@ static ssize_t sysfs_service_op_show(struct kobje=
ct *kobj,
> >                 if (strcmp(kobj->name, PC_KOBJ_ID)) {
> >                         if (new_op->upcall.req.param.op =3D=3D
> >                             ORANGEFS_PARAM_REQUEST_OP_READAHEAD_COUNT_S=
IZE) {
> > -                               rc =3D scnprintf(buf, PAGE_SIZE, "%d %d=
\n",
> > +                               rc =3D sysfs_emit(buf, "%d %d\n",
> >                                     (int)new_op->downcall.resp.param.u.
> >                                     value32[0],
> >                                     (int)new_op->downcall.resp.param.u.
> >                                     value32[1]);
> >                         } else {
> > -                               rc =3D scnprintf(buf, PAGE_SIZE, "%d\n"=
,
> > +                               rc =3D sysfs_emit(buf, "%d\n",
> >                                     (int)new_op->downcall.resp.param.u.=
value64);
> >                         }
> >                 } else {
> > -                       rc =3D scnprintf(
> > +                       rc =3D sysfs_emit(
> >                                 buf,
> > -                               PAGE_SIZE,
> >                                 "%s",
> >                                 new_op->downcall.resp.perf_count.buffer=
);
> >                 }
> >
> > base-commit: 78f4e737a53e1163ded2687a922fce138aee73f5
> > --
> > 2.34.1
> >

