Return-Path: <linux-fsdevel+bounces-37466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EE69F2887
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 03:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C22CE7A1444
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 02:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBCC1487ED;
	Mon, 16 Dec 2024 02:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvFJdwPs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338CD1119A
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2024 02:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734316513; cv=none; b=Cs3L5UHJXzWXwlhQ7tTvyQ0DVeXZFW8+eHo/yLW292bDg9PXhmTPRqZ0rSjkHiJd3zAzLkdw7DyGh2WvB4xkTnHcdJbQFXlqXOCCIYCpp4QXD0yp0fTJH844felSh8wVNI8G+qI5A7WwRNLT0JLhdiOG1DRzFklcuQzysTsFQhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734316513; c=relaxed/simple;
	bh=5eCcBPBrl3+uiBX+zZZYBRt3oBaguvJCk/OgKKJwQLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AMKN7foHUY/nGDPAKNl/whPn0MysaYK/g/xqU2zqx5ixHcq/c+pS/ED6b9n/nXfzXmulMsIqudACfGJrUaH6ctK18cH6HJrXoaSsp57ACwKMVBrGsaEvg4qTpszonF9LoMhmv7l1pFBlrK5+eepikdRCdVq/LuNxjj4JFXIuNvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZvFJdwPs; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-467b74a1754so22567531cf.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Dec 2024 18:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734316511; x=1734921311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VaQm1CpzEoH1BTbufou81oJavqcrA5CTPWGaV4H/sKk=;
        b=ZvFJdwPsFljnt++o56/glF9UuCuS89r5U62o08tZa+wu8r6hNQxBHsImhUspthKIGS
         Y9NJT3JwPMJxk12WTWQdfv0YZydyqNE+UPUN9x5SAcQYTXpiNo7zfKiN98KtgWmxu253
         tAZK0vc2yXrLtH3/aI4tu8GC8CVraI9FaBRTNqv8Kl8I3oN4zp7oOXef4dmH/qSpRLV4
         6Lp9MPDzx9yZNbF8i9uHzNF/Ye5K1bWKoPseYY6ftjWo5RWMpqZKWoYUGbJhK4zKXaMR
         KfP3O5j/nCIc43xWT3rSoitkJkThTAQzxbDF2su4llq973fHJdObIvJ8Hjor/ZhnHaYE
         eE1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734316511; x=1734921311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VaQm1CpzEoH1BTbufou81oJavqcrA5CTPWGaV4H/sKk=;
        b=p0UgSeLA3hRG3NXWptXhxlgga6dGte6cm3T/ZVK9h0c6MJVeJac2moW/Mo8p33DJlW
         zuZlIwvws5DSnEEQBtwqhepCA3nb0zR7PYKOH6yJwE95bHOVypLJToOB+Xw9kHWr86bz
         abtMKpoyzZ4kuxtKHvuW/RKcz+PXz6/nGEEPXnApYhBlZbSSRt5Q8ZsxADIlHp09Aau/
         uWkFYrgMB74E78j2dGIfjLtVdJNGqIz0mmjpaVvMVoSzT6wbl2YsamJmohNup7xnJynq
         0HMXBFtYKUiYwkS2pecRuzZ5XDlL0YlN5bx+RbELArxW/32x3zX3wf8HzgzNr9ihLa0U
         6iiA==
X-Forwarded-Encrypted: i=1; AJvYcCWUnRehywq32KU2mqT8H23svlxHDxLZDOtxSIcuXZZBl2WFGx4kQoub5JyO7MWicbrBU58v2rEeg0neDEB5@vger.kernel.org
X-Gm-Message-State: AOJu0YzGXMn6yzd86hnMIKeB9ORwnkiIly8NUkOrq77AMXwx7XWK+8wO
	3/HQctOjETlnvzJgm2HAlK+3eZyQMtSx9ZiO35yc0V3kueZbZvN6Qol6DY6f4KtFlJ7GylpT0tN
	eKmXHKUNu8JthZI415tIhNVJib1f9498B
X-Gm-Gg: ASbGncuecabxtZakPY8Ws14XlGpXcaHs+gN/FB2xilCD374Jt369Xv31FXMC/xiKak8
	1H87We7CrJnIATPaEyWT01YmUzaSEYCO5//PAyqI=
X-Google-Smtp-Source: AGHT+IETRW+6Y350RxtrVhNB6UdqKqBc6UhSnbYcGa6LhK4xVOjgfLhqCt6fLqTPz6Kkl2if0JZCJB0Optzkuy+NUvE=
X-Received: by 2002:ac8:59d5:0:b0:467:58ae:b8d9 with SMTP id
 d75a77b69052e-467a574de0dmr202767771cf.17.1734316511093; Sun, 15 Dec 2024
 18:35:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241214022827.1773071-1-joannelkoong@gmail.com> <20241214022827.1773071-2-joannelkoong@gmail.com>
In-Reply-To: <20241214022827.1773071-2-joannelkoong@gmail.com>
From: Etienne Martineau <etmartin4313@gmail.com>
Date: Sun, 15 Dec 2024 21:35:00 -0500
Message-ID: <CAMHPp_TVTvKC4xcuSy=kHB+5r8pTa-72bAaJF+dCp8PnrK=m7A@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] fuse: add kernel-enforced timeout option for requests
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, laoar.shao@gmail.com, 
	jlayton@kernel.org, senozhatsky@chromium.org, tfiga@chromium.org, 
	bgeffon@google.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 9:29=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> There are situations where fuse servers can become unresponsive or
> stuck, for example if the server is deadlocked. Currently, there's no
> good way to detect if a server is stuck and needs to be killed manually.
>
> This commit adds an option for enforcing a timeout (in seconds) for
> requests where if the timeout elapses without the server responding to
> the request, the connection will be automatically aborted.
>
> Please note that these timeouts are not 100% precise. For example, the
> request may take roughly an extra FUSE_TIMEOUT_TIMER_FREQ seconds beyond
> the requested timeout due to internal implementation, in order to
> mitigate overhead.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/dev.c    | 83 ++++++++++++++++++++++++++++++++++++++++++++++++
>  fs/fuse/fuse_i.h | 22 +++++++++++++
>  fs/fuse/inode.c  | 23 ++++++++++++++
>  3 files changed, 128 insertions(+)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 27ccae63495d..e97ba860ffcd 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -45,6 +45,85 @@ static struct fuse_dev *fuse_get_dev(struct file *file=
)
>         return READ_ONCE(file->private_data);
>  }
>
> +static bool request_expired(struct fuse_conn *fc, struct fuse_req *req)
> +{
> +       return time_is_before_jiffies(req->create_time + fc->timeout.req_=
timeout);
> +}
> +
> +/*
> + * Check if any requests aren't being completed by the time the request =
timeout
> + * elapses. To do so, we:
> + * - check the fiq pending list
> + * - check the bg queue
> + * - check the fpq io and processing lists
> + *
> + * To make this fast, we only check against the head request on each lis=
t since
> + * these are generally queued in order of creation time (eg newer reques=
ts get
> + * queued to the tail). We might miss a few edge cases (eg requests tran=
sitioning
> + * between lists, re-sent requests at the head of the pending list havin=
g a
> + * later creation time than other requests on that list, etc.) but that =
is fine
> + * since if the request never gets fulfilled, it will eventually be caug=
ht.
> + */
> +void fuse_check_timeout(struct work_struct *work)
> +{
> +       struct delayed_work *dwork =3D to_delayed_work(work);
> +       struct fuse_conn *fc =3D container_of(dwork, struct fuse_conn,
> +                                           timeout.work);
> +       struct fuse_iqueue *fiq =3D &fc->iq;
> +       struct fuse_req *req;
> +       struct fuse_dev *fud;
> +       struct fuse_pqueue *fpq;
> +       bool expired =3D false;
> +       int i;
> +
> +       spin_lock(&fiq->lock);
> +       req =3D list_first_entry_or_null(&fiq->pending, struct fuse_req, =
list);
> +       if (req)
> +               expired =3D request_expired(fc, req);
> +       spin_unlock(&fiq->lock);
> +       if (expired)
> +               goto abort_conn;
> +
> +       spin_lock(&fc->bg_lock);
> +       req =3D list_first_entry_or_null(&fc->bg_queue, struct fuse_req, =
list);
> +       if (req)
> +               expired =3D request_expired(fc, req);
> +       spin_unlock(&fc->bg_lock);
> +       if (expired)
> +               goto abort_conn;
> +
> +       spin_lock(&fc->lock);
> +       if (!fc->connected) {
> +               spin_unlock(&fc->lock);
> +               return;
> +       }
> +       list_for_each_entry(fud, &fc->devices, entry) {
> +               fpq =3D &fud->pq;
> +               spin_lock(&fpq->lock);

Can fuse_dev_release() run concurrently to this path here?
If yes say fuse_dev_release() comes in first, grab the fpq->lock and
splice the
fpq->processing[i] list into &to_end and release the fpq->lock which
unblock this
path.

Then here we start checking req off the fpq->processing[i] list which is
getting evicted on the other side by fuse_dev_release->end_requests(&to_end=
);

Maybe we need a cancel_delayed_work_sync() at the beginning of
fuse_dev_release ?
Thanks
Etienne

> +               req =3D list_first_entry_or_null(&fpq->io, struct fuse_re=
q, list);
> +               if (req && request_expired(fc, req))
> +                       goto fpq_abort;
> +
> +               for (i =3D 0; i < FUSE_PQ_HASH_SIZE; i++) {
> +                       req =3D list_first_entry_or_null(&fpq->processing=
[i], struct fuse_req, list);
> +                       if (req && request_expired(fc, req))
> +                               goto fpq_abort;
> +               }
> +               spin_unlock(&fpq->lock);
> +       }
> +       spin_unlock(&fc->lock);
> +
> +       queue_delayed_work(system_wq, &fc->timeout.work,
> +                          secs_to_jiffies(FUSE_TIMEOUT_TIMER_FREQ));
> +       return;
> +
> +fpq_abort:
> +       spin_unlock(&fpq->lock);
> +       spin_unlock(&fc->lock);
> +abort_conn:
> +       fuse_abort_conn(fc);
> +}
> +

