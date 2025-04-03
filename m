Return-Path: <linux-fsdevel+bounces-45627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60ACAA7A0A2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 12:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6073C3B4611
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 10:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB94243387;
	Thu,  3 Apr 2025 10:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLVh+OZh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E493C0B;
	Thu,  3 Apr 2025 10:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743674794; cv=none; b=Fmg2ZZLbOxGnZUxPCL1BlDDSjVXNyAXOBmrXcmJRUhhZstMNNGLTTu+bxDeX3tsLpP6vw/F1eu2hBmDuNmzumdGFaB+Vx6b/ks+oNgdOPQqRv99Ty8JnkIAOaVtEAnucP3E1F3+t7Xm0moizoVOyfrg2NLJef85vZmcrAX6aG38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743674794; c=relaxed/simple;
	bh=gYZrtpuyChSlZBcE+uwVPR47Bv/VGpJQBcO4x4coLu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ox+4UgZwDZvEOqWTk9MW0ckXTc41Ige0YjgYpIJbOX23b2H1IRs5WuiGqi60Gyr9Q7vf0YaX2ne1gEhpGENsP+Y4zGv6nfZFH1q1Z4pBFzXb30UpNS/TyNCcUS8zK1BBs6zKFGWw+PLcnp4KXiydTdQS1ZEKWOgbRi7nToBjYWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bLVh+OZh; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e6f4b3ebe5so1347440a12.0;
        Thu, 03 Apr 2025 03:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743674790; x=1744279590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BW4HJh5TQsbwyhxoNGo8Vn28Ag5k9m/e5obY0huku+w=;
        b=bLVh+OZhZqb69Trw0x/3v7DQRIrF8+7OXrYIMgeuSNlmFUzV1CkDGR0uZrHrBxcT8Q
         fGztc1rRsE+B/KJjNmmnAQ3kzaBhwrqb6IyJkR4WLT6gBAKoTe7XAkakEQwK3amQTWfB
         wfzSeENHQPxA2WNy51/rjsMOovqu5417LX9bwDYcP1E+gneGV9LIlS0lbDHAubD60ik+
         t/PgxbvPtqivosOiPR7+4B2mCphKR2MApCGgmPWSlnkahruEA25a+aVnYTaXEyxwmJ6s
         6uglL09lygHZ5yXWlYWk62WZxml+3Dg0yNwAYi54ozBW19YohgJr+rizU/qPBZ97LHp/
         90CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743674790; x=1744279590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BW4HJh5TQsbwyhxoNGo8Vn28Ag5k9m/e5obY0huku+w=;
        b=SAq2rPIo26b9dWGF3KbdujOr+Lp4SDc7wI++G7sDrwuGWUUxr42e8yqKVdHeAHcFLK
         mSCx6PcRe0kza9J7ThGizrnBK9m4fMXOqtiQa3l8CAvPdoquAMrgOLo7JbPLZos2eWGr
         JEGiwm+h3Ca09WIJpTHJJzP1ZL4m7K8ZJKwhnTDtnDfmZGbiFei3y5McjDVsdyRATpCX
         /HM4LyweoP6+XwuDRXsIxfmcC/wJKhqW6ov0YF8QA4wgK4OAX3A6K7kyB3vRPWwKrcVm
         5KsIptEcvtyrb83mHX5xs2R5+S6na6Z9/LgyqLW/8/IFiRhVaePvUj1BGj5Iy4LpF7uH
         uy/g==
X-Forwarded-Encrypted: i=1; AJvYcCWIJnpyOyp1hUysJu4BHiW9egNP6dkV/nRkAE1hqEtbycCp76sfDGwD3NYRNeRLo1uzshcIpB5MrPkpgx8b@vger.kernel.org, AJvYcCWfOhsnrrzoi97IPbG2jSo4nGFFFZ4pGp17yNgfrj53GUbtlscG1N9Z5LCR/DDawKB3vnTe89u9bEY6@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1zFH7zD1srPRjyEcLYHsvaj7o27Rtpiy53j2wP/R0bY8ef5d4
	FP4F57dKZvqUa0NeAmMhb56OqdvUGMxv11Z9Iaup6XZNjF+FGD8YNLLUxEqhEvIDw1mukIH7bPC
	2CCModmDGQ7+RlbncNi3egO0T5+XTdW4+
X-Gm-Gg: ASbGncuz8/uG66cesTJWd1+QmGk2QJbUfDelFqojpYVXoap5wWohmIXLS7flAOu4KJa
	m+Yfy23olcdIimLjP82gQsaE7NTsrblTeBYWkCig400Sn7gSlvIFjdBMqig5qjP9DJsyMNqNX+j
	144kYj11SODB1krhpL+Ezo1+0ttA==
X-Google-Smtp-Source: AGHT+IH5TofJhGxSJMpvFZfSY4wrwSaZ3M1/bEkXd8abTMdEjzpBkhwVb3nruC6GKiwdXhtGnfTvcf1fvwzD8ToaTP4=
X-Received: by 2002:a05:6402:1e8a:b0:5e5:bbd5:676a with SMTP id
 4fb4d7f45d1cf-5f087224c0dmr1772585a12.22.1743674790199; Thu, 03 Apr 2025
 03:06:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250330125536.1408939-1-amir73il@gmail.com> <de54ad3do3vz3mi7swdojhwzrpssxk6rzqrfzlrmjaxz4pud6r@ha64lyrespvy>
In-Reply-To: <de54ad3do3vz3mi7swdojhwzrpssxk6rzqrfzlrmjaxz4pud6r@ha64lyrespvy>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 3 Apr 2025 12:06:18 +0200
X-Gm-Features: ATxdqUGrHuHJygO2Fh4JKzKf5KR7S8Ekl9s_I7gmHC-WMZ3ExBTFM68JRPXge_4
Message-ID: <CAOQ4uxgpvJDYfvRxO-AG43hkDKeKAvbH6YgPF+Au83JHM6vGJg@mail.gmail.com>
Subject: Re: [PATCH] fanotify: Document FAN_PRE_ACCESS event
To: Alejandro Colomar <alx@kernel.org>
Cc: Alejandro Colomar <alx.manpages@gmail.com>, Jan Kara <jack@suse.cz>, 
	Josef Bacik <josef@toxicpanda.com>, Christian Brauner <brauner@kernel.org>, linux-man@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 2, 2025 at 10:58=E2=80=AFPM Alejandro Colomar <alx@kernel.org> =
wrote:
>
> Hi Amir,
>
> On Sun, Mar 30, 2025 at 02:55:36PM +0200, Amir Goldstein wrote:
> > The new FAN_PRE_ACCESS events are created before access to a file range=
,
> > to provides an opportunity for the event listener to modify the content
> > of the object before the user can accesss it.
> >
> > Those events are available for group in class FAN_CLASS_PRE_CONTENT
> > They are reported with FAN_EVENT_INFO_TYPE_RANGE info record.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  man/man2/fanotify_init.2 |  4 ++--
> >  man/man2/fanotify_mark.2 | 14 +++++++++++++
> >  man/man7/fanotify.7      | 43 ++++++++++++++++++++++++++++++++++++++--
> >  3 files changed, 57 insertions(+), 4 deletions(-)
> >
> > diff --git a/man/man2/fanotify_init.2 b/man/man2/fanotify_init.2
> > index 23fbe126f..b1ef8018c 100644
> > --- a/man/man2/fanotify_init.2
> > +++ b/man/man2/fanotify_init.2
> > @@ -57,8 +57,8 @@ Only one of the following notification classes may be=
 specified in
> >  .B FAN_CLASS_PRE_CONTENT
> >  This value allows the receipt of events notifying that a file has been
> >  accessed and events for permission decisions if a file may be accessed=
.
> > -It is intended for event listeners that need to access files before th=
ey
> > -contain their final data.
> > +It is intended for event listeners that may need to write data to file=
s
> > +before their final data can be accessed.
> >  This notification class might be used by hierarchical storage managers=
,
> >  for example.
> >  Use of this flag requires the
> > diff --git a/man/man2/fanotify_mark.2 b/man/man2/fanotify_mark.2
> > index 47cafb21c..edbcdc592 100644
> > --- a/man/man2/fanotify_mark.2
> > +++ b/man/man2/fanotify_mark.2
> > @@ -445,6 +445,20 @@ or
> >  .B FAN_CLASS_CONTENT
> >  is required.
> >  .TP
> > +.BR FAN_PRE_ACCESS " (since Linux 6.14)"
> > +.\" commit 4f8afa33817a6420398d1c177c6e220a05081f51
> > +Create an event before read or write access to a file range,
> > +that provides an opportunity for the event listener
> > +to modify the content of the file
> > +before access to the content
> > +in the specified range.
> > +An additional information record of type
> > +.B FAN_EVENT_INFO_TYPE_RANGE
> > +is returned for each event in the read buffer.
> > +An fanotify file descriptor created with
> > +.B FAN_CLASS_PRE_CONTENT
> > +is required.
> > +.TP
> >  .B FAN_ONDIR
> >  Create events for directories\[em]for example, when
> >  .BR opendir (3),
> > diff --git a/man/man7/fanotify.7 b/man/man7/fanotify.7
> > index 7844f52f6..6f3a9496e 100644
> > --- a/man/man7/fanotify.7
> > +++ b/man/man7/fanotify.7
> > @@ -247,6 +247,26 @@ struct fanotify_event_info_error {
> >  .EE
> >  .in
> >  .P
> > +In case of
> > +.B FAN_PRE_ACCESS
> > +events,
> > +an additional information record describing the access range
> > +is returned alongside the generic
> > +.I fanotify_event_metadata
> > +structure within the read buffer.
> > +This structure is defined as follows:
> > +.P
> > +.in +4n
> > +.EX
> > +struct fanotify_event_info_range {
> > +    struct fanotify_event_info_header hdr;
> > +    __u32 pad;
> > +    __u64 offset;
> > +    __u64 count;
> > +};
> > +.EE
> > +.in
> > +.P
> >  All information records contain a nested structure of type
> >  .IR fanotify_event_info_header .
> >  This structure holds meta-information about the information record
> > @@ -509,8 +529,9 @@ The value of this field can be set to one of the fo=
llowing:
> >  .BR FAN_EVENT_INFO_TYPE_FID ,
> >  .BR FAN_EVENT_INFO_TYPE_DFID ,
> >  .BR FAN_EVENT_INFO_TYPE_DFID_NAME ,
> > -or
> > -.BR FAN_EVENT_INFO_TYPE_PIDFD .
> > +.BR FAN_EVENT_INFO_TYPE_PIDFD ,
> > +.BR FAN_EVENT_INFO_TYPE_ERROR ,
> > +.BR FAN_EVENT_INFO_TYPE_RANGE .
> >  The value set for this field
> >  is dependent on the flags that have been supplied to
> >  .BR fanotify_init (2).
> > @@ -711,6 +732,24 @@ Identifies the type of error that occurred.
> >  This is a counter of the number of errors suppressed
> >  since the last error was read.
> >  .P
> > +The fields of the
> > +.I fanotify_event_info_range
> > +structure are as follows:
> > +.TP
> > +.I hdr
>
> We should use .hdr here too (and in the fields below, '.' too), right?
>

Sure that was your idea.
I am fine with it.

I guess it could be changed later with other instances,

Thanks,
Amir.

