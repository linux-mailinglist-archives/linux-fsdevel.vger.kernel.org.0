Return-Path: <linux-fsdevel+bounces-37513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E509F379A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 18:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B4471889BD1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 17:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD302066C5;
	Mon, 16 Dec 2024 17:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZZ+0I4H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CF4203D5E
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2024 17:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734370345; cv=none; b=eqFQc05EpnlBTFq9pEM2zJlPDF/79gVFZU5WMNSSOa6N5sidigcy1IfZFsQy/6Z+SVNjTJPgKCzG0pd/EYfBQToI+uwjMOIzZ2XJ2WDHvX6YcGBAsjyOP38HKQWPzeV5c151p6+42sXUN5jGZwzN3JYTZJYrm+rLJQEiVE2C6dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734370345; c=relaxed/simple;
	bh=FAa5Wiqlalb/Z2dzWYjkfYOTJI7gLlkUtp0zFGfC0Yk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XPeS8gfJBc/4NvzSUJyQ07gtpX4j+PsX39wBBuy2231kXKX02dNDzDF2sIjothF3z/8sde10DL65MmU+Cb4jhQ+ZmQv4D60qBzyVz+t5OXwbiOH1RYKGbq7eElbNbPSb3bLQ0KPaYMvBQCvv7St7OMaf69PPJSWfYVRQ4gBMh5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZZ+0I4H; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-467725245a2so43946441cf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2024 09:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734370342; x=1734975142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kTWUbyNxq/mwwPmdFguLeTq9ih2dSKb55GUx3Ec4AgU=;
        b=UZZ+0I4HoxRfh6QpQFQWN36hovI8HFPfIOnAXz3O3wQnL9Kf/FKhTlVSAskx5o+r/z
         yBT4jnMhlws9vDPMmdjRY4Pb6OIb56x/jNV341Ly/yzIk7SBuPetfGtQYkrmfxEIxlsr
         OKgc6e5Ie/OuRhlGl73DkmFu9rsrTrbfVZaanwgVucAABgNF17Ft9D71mVNENb0IIhg4
         wjFdgOwZRHHD/x0CtTdcAFXKWoHeDfHL15pp40sCsLpOw4UrAV9QSRwLfMwhY2Uyqtid
         RIj08EZekscZsqZ9bJBcibKWrenvIsZGo7IxUQV6oboRdxP7pQTvpUHvdzLEB3F6XURA
         JWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734370342; x=1734975142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kTWUbyNxq/mwwPmdFguLeTq9ih2dSKb55GUx3Ec4AgU=;
        b=qaNR0+pW8vE13wTyI4naQdwSngS4/sWLuK/9rEu+lOGJW6Sazo9EFU/N/NyCL04AOw
         ZMIVeuNJFhmcQehddq2VE8Jm7UWfgVhRip3nV9GcjL92CfJ8CTS6RzpNSFf9ukjrMlm5
         KFlYyD+l2+WHJdH2awGJ7LJpgYanhGten0KYJsBotHs4e0KMCVlfaRLNozGChKEHFJ/C
         D6qYK32FFD3YGs2/RalyMO5KTtnjBNA+2Bay8cy0ocR6TesUlb/N1rytkGDu7ZPBIBH9
         L7a1wBpaCUaOE+yxsS8P+RyYd7UzfyW4A5Utowakvja8Lh1L0LLJ9NdSvo2vl++1dlXz
         W8ww==
X-Forwarded-Encrypted: i=1; AJvYcCUfcYtTglb6pglL+xhH0R1rVEasnOMySc2tdHyjx9gkNxhNF5KvmVFavDr/z36yctA1amtSsTtzfCtufYbH@vger.kernel.org
X-Gm-Message-State: AOJu0YwJSpmonB0SvorQij8WRYdMiVgdFYcJy/8qzQ40Rw8qOWsRR3zQ
	URbGDc0S/wMRGYUHivklaAfQ/d2mopKVpExpcLvTe9QK7yuVlC+rpYe4qKJkbes/kfkewWN4dpR
	rosm57bY9zCFzW6sNlujqv0Ehw8abtg==
X-Gm-Gg: ASbGncvbfZ/dV5M0Bn1SQGKwnJXGreaCXphiUx2ZIzi6cEjBR5bciXZdvaISljn5Il7
	iyOq9f2mskjWELvqQ+L13wn5goU4E8803/SEZl1wuYfm2JDel6JZk5A==
X-Google-Smtp-Source: AGHT+IG2ZQx93HJxQYl/owz75J+GpVL+zY1Yl1bzM/6J89Ln1CTyQQVtTn3lava4JwfAWy2xCgVdt2NHUvIvuF07km4=
X-Received: by 2002:a05:622a:1a29:b0:467:7fbf:d121 with SMTP id
 d75a77b69052e-467a574e78fmr244408971cf.12.1734370342405; Mon, 16 Dec 2024
 09:32:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241214022827.1773071-1-joannelkoong@gmail.com>
 <20241214022827.1773071-2-joannelkoong@gmail.com> <8d0e50812e0141e24855f99b63c3e6d7cb57e7f8.camel@kernel.org>
In-Reply-To: <8d0e50812e0141e24855f99b63c3e6d7cb57e7f8.camel@kernel.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 16 Dec 2024 09:32:11 -0800
Message-ID: <CAJnrk1a+hxtv5kiaEJu-m-C35E8Bbg-ehd8yRjc1fBd2Amm8Ug@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] fuse: add kernel-enforced timeout option for requests
To: Jeff Layton <jlayton@kernel.org>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, laoar.shao@gmail.com, 
	senozhatsky@chromium.org, tfiga@chromium.org, bgeffon@google.com, 
	etmartin4313@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 14, 2024 at 4:10=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Fri, 2024-12-13 at 18:28 -0800, Joanne Koong wrote:
> > There are situations where fuse servers can become unresponsive or
> > stuck, for example if the server is deadlocked. Currently, there's no
> > good way to detect if a server is stuck and needs to be killed manually=
.
> >
> > This commit adds an option for enforcing a timeout (in seconds) for
> > requests where if the timeout elapses without the server responding to
> > the request, the connection will be automatically aborted.
> >
> > Please note that these timeouts are not 100% precise. For example, the
> > request may take roughly an extra FUSE_TIMEOUT_TIMER_FREQ seconds beyon=
d
> > the requested timeout due to internal implementation, in order to
> > mitigate overhead.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  fs/fuse/dev.c    | 83 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  fs/fuse/fuse_i.h | 22 +++++++++++++
> >  fs/fuse/inode.c  | 23 ++++++++++++++
> >  3 files changed, 128 insertions(+)
> >
> > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > index 27ccae63495d..e97ba860ffcd 100644
> > --- a/fs/fuse/dev.c
> > +++ b/fs/fuse/dev.c
> >
> >  static struct fuse_req *fuse_request_alloc(struct fuse_mount *fm, gfp_=
t flags)
> > @@ -2308,6 +2388,9 @@ void fuse_abort_conn(struct fuse_conn *fc)
> >               spin_unlock(&fc->lock);
> >
> >               end_requests(&to_end);
> > +
> > +             if (fc->timeout.req_timeout)
> > +                     cancel_delayed_work(&fc->timeout.work);
>
> As Sergey pointed out, this should be a cancel_delayed_work_sync(). The
> workqueue job can still be running after cancel_delayed_work(), and
> since it requeues itself, this might not be enough to kill it
> completely.

I don't think we need to synchronously cancel it when a connection is
aborted. The fuse_check_timeout() workqueue job can be simultaneously
running when cancel_delayed_work() is called and can requeue itself,
but then on the next trigger of the job, it will check whether the
connection was aborted (eg the if (!fc->connected)... return; lines in
fuse_check_timeout()) and will not requeue itself if the connection
was aborted. This seemed like the simplest / cleanest approach to me.

>
> Also, I'd probably do this at the start of fuse_abort_conn() instead of
> waiting until the end. By the time you're in that function, you're
> killing the connection anyway, and you probably don't want the
> workqueue job running at the same time. They'll just end up competing
> for the same locks.

Sounds good, I'll move this to be called right after the "if
(fc->connected)" line.


Thanks,
Joanne
>
> >       } else {
> >               spin_unlock(&fc->lock);
> >       }

> --
> Jeff Layton <jlayton@kernel.org>

