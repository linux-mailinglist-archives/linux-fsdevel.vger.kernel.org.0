Return-Path: <linux-fsdevel+bounces-37519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F909F38D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 19:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A648162EEE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 18:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F158A2063E0;
	Mon, 16 Dec 2024 18:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKrTdLHh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E707D14375D
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2024 18:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734373423; cv=none; b=NqFONGFX85ewWYPL44Tvh3Eaf6HhyTuYVwsSjlRsfajRdXSl1CDTSvE466nDYtHmeopWI+fpu93juAPVrFdxO1hIPWV/ILtiAzFtW0r3ubTsdkhdKquMqPuSIiNzlZP5ZMZVIPvbEaNnBsS0YlboYcO0WQLxajVH9e8tUDpjU7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734373423; c=relaxed/simple;
	bh=bU0DSxyD4cuhxC1mmcZw0msM8c6eowlSXfQ91hC600k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aB+Hu2eaDrMIMK+JHBVD5voCqqrXPykHkc7t2lZiAasIwhmi4PS3ZywCSfJUMjqmLdJDkxyngy1bEBtAWW1RzmmP+BavGs3jzYQmT9PSkdicMZ5Q1a0RyQ29Cz/j1+CY+Z/02gOlHj05GA+TWQfxDcWth+IBTX1Xt7Wc7jxasd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKrTdLHh; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6d89dc50927so32426626d6.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2024 10:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734373421; x=1734978221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtSiKjT4kSv1Ff2Bc0xrr7As1y1kstBy4hKr3zIE7ps=;
        b=EKrTdLHhPiHrB3IP9bM8fFYJ3SH70D83vLQ0Hig1AMv3TSVexXOX6Hlephkgov9Ssg
         o0GenRAZw0P/G/Y93iMIqi9Uq1oCrSmavFwGcq3BOgDn5CXzOS2sxAlsvgVNUUrNTDZP
         9IZ3sCSsubUIDTFwA2i+e3pOrODC0IB3lJBtZEGg5XSKiJfEFCjfgHLRHE1o7CBXdw4n
         qCo7peLJiz0ntnAeNAw2RufpRbLHHjN2DJZ1QM1T86TUSfvtBCGKFgtFRG38qyZd/TRV
         kOG7CfMhL/0ToOKZBggDZJQrk+/kkAgMJT/PNyW3mBaN49+Nf9p134MH7DVIyfsF9b3x
         X4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734373421; x=1734978221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LtSiKjT4kSv1Ff2Bc0xrr7As1y1kstBy4hKr3zIE7ps=;
        b=SezNzIpSRBmvF17gX7WDdwcVaZu8IRkblaBwUHP3L+FMGI0k8ZKXqyvRt+8hhSoDqD
         BzbYdBIxzvoDx5QLFRFSrl9QTQz00kW1axLX/U3Kzf9MAgpTIlutNIUpf85nwj+eNUxS
         6iC/gHVmy/5QKE0N7JURvav+bfWfnlIdT23UoBxkfIQXnxv27xqY0TBo5JhsydJawCmK
         2MUtz1QobdbzMMtRnhbdAZE1Vbc6hP36M7SV/rM9lhDrcq09nO8Qu2JgFaiMmvh9AW0x
         KzxYMvheIMMZMChgxggy+e77mitKf7vweQNosuaHVLdZrkCDGx5F2N8O/ynoQONpQTiz
         HGdg==
X-Forwarded-Encrypted: i=1; AJvYcCU5AG4a3U6iILXJ4X6CmIUOlLbjKticOXawCjqcsXJ8aZy7XG9KHlIf0IsTMO00q1dBBcP2V4IaJZcLvzkJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0hyuSMwnVqAJ6hE/4HMA79ev5i0uOo6vVzF0HbamakwEKJzro
	IRQi7xRoWltK2hWSwy6k2Az9yr8hysa5dOxfzPT6V5j5WpEjLK8QmnGErzYOp5b+lZrd3TRo+tW
	qs+4Yfri8U8i2jrbv2L7txd0ja7Q=
X-Gm-Gg: ASbGncvx6yPBD89GzVmkcBhj3VGSXGOVMpWGAGqPJKQ4NoNd/ozovmckMfl+Zn/e3JA
	+2rZuuh2I3u8xjIwHCjEyn8CBxF+JyFamRbevKKBvJ1myDlc73sf99g==
X-Google-Smtp-Source: AGHT+IGY9kLKW3Sf+8Hri+UimclQXFiAv+OkzfKnFM6ZiVPk0ayyJUu/1BMr9M85O8NbNjKmIVL+Y789iKcRJ2mB87c=
X-Received: by 2002:a05:6214:2428:b0:6d8:b3a7:759e with SMTP id
 6a1803df08f44-6dc969af843mr210380636d6.46.1734373420796; Mon, 16 Dec 2024
 10:23:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241214022827.1773071-1-joannelkoong@gmail.com>
 <20241214022827.1773071-2-joannelkoong@gmail.com> <qmxxocm2vazh7uu374t7hcgf5dxt4757fdcer7d2wxffgtp64t@o3s4icrss5f4>
In-Reply-To: <qmxxocm2vazh7uu374t7hcgf5dxt4757fdcer7d2wxffgtp64t@o3s4icrss5f4>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 16 Dec 2024 10:23:29 -0800
Message-ID: <CAJnrk1bAaf9Fi6XSYWr4TJchGD-Mn6u52EMoYObYQAi6bicbkw@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] fuse: add kernel-enforced timeout option for requests
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, laoar.shao@gmail.com, 
	jlayton@kernel.org, tfiga@chromium.org, bgeffon@google.com, 
	etmartin4313@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 10:53=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (24/12/13 18:28), Joanne Koong wrote:
> > +void fuse_check_timeout(struct work_struct *work)
> > +{
> > +     struct delayed_work *dwork =3D to_delayed_work(work);
> > +     struct fuse_conn *fc =3D container_of(dwork, struct fuse_conn,
> > +                                         timeout.work);
> > +     struct fuse_iqueue *fiq =3D &fc->iq;
> > +     struct fuse_req *req;
> > +     struct fuse_dev *fud;
> > +     struct fuse_pqueue *fpq;
> > +     bool expired =3D false;
> > +     int i;
> > +
> > +     spin_lock(&fiq->lock);
> > +     req =3D list_first_entry_or_null(&fiq->pending, struct fuse_req, =
list);
> > +     if (req)
> > +             expired =3D request_expired(fc, req);
>
> A nit: you can factor these out into a small helper
>
> static bool request_expired(struct fuse_conn *fc, struct list_head *list)
> {
>        struct fuse_req *req;
>
>        req =3D list_first_entry_or_null(list, struct fuse_req, list);
>        if (!req)
>                return false;
>        return time_after(jiffies, req->create_time + fuse_watchdog_timeou=
t());
> }
>
> and just call it passing the corresponding list pointer
>
>         abort =3D request_expired(fc, &fiq->pending);
>
> kinda makes the function look less busy.

Good idea! I'll do this refactoring as part of v11.

>
> [..]
> > @@ -2308,6 +2388,9 @@ void fuse_abort_conn(struct fuse_conn *fc)
> >               spin_unlock(&fc->lock);
> >
> >               end_requests(&to_end);
> > +
> > +             if (fc->timeout.req_timeout)
> > +                     cancel_delayed_work(&fc->timeout.work);
>
> When fuse_abort_conn() is called not from fuse_check_timeout(), but from
> somewhere else, should this use cancel_delayed_work_sync()?

I left a comment about this under the reply to Jeff.


Thanks,
Joanne

