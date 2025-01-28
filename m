Return-Path: <linux-fsdevel+bounces-40243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 001EDA20F39
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 17:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C03C43A6C43
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 16:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256201B040B;
	Tue, 28 Jan 2025 16:52:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D24419E967;
	Tue, 28 Jan 2025 16:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738083123; cv=none; b=opvgY9XCJ7jaqniOVYbaXhdAlPM4yzumel9rzF+VA+w1S/GtNlrVSO1/vG/7yN1b7v0dnAPCbKujLwdjWgJR+tfKM8buILzlcrsqp4hcDPeOMM/Y2mNcKgbWgVtyG+QviOtRkhE2bsEUCw9ziu4y013oLs76LvIEV5yvqGcaqq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738083123; c=relaxed/simple;
	bh=rgGyPw6WivR4wckN2azykOiMjybNsZ0pBxyqM9AmsYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cCWmumD286GcOATvB52nIs8ySmEq/Imi1p2oqwph/It8At/vTHiKUPsW3wPLnpa63/7Le/Su/GP0f3fx5Hs6oxXpXuDqNb2Iashvf6Ti6eR7pjdsf31315/Yb4+pa6yb50zLjbRz+fmUIg5vjaT1n0OIS6xvuVMZKDxSFydtDw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=auristor.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaee0b309adso185715366b.3;
        Tue, 28 Jan 2025 08:52:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738083119; x=1738687919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u6y7s2ycTPBwMzwbJK9iV/0/faT4TnIsalXlg0D1E2U=;
        b=R1mfcXK7Hkbt163QgVag7lWmntI0FN6hWmLvakMfr9dn1J2uZ638CCizme/kZzkZu4
         m9g/N4XSkOKjjje48kS5ES0A5AbmrX+IJUhBT8zdHMvscS2ZPvREuetjOszw+5ZpjbpF
         vZlWFDLmX3EmdtRU1Pyj3SYTmnk3BO5gBaUIVaf4wyfgc0VFv56E6e38nPo2JM0FJ3tP
         mCZmQO/lbY4VO5Qj44aBzegVlXszXBRqbNlYMrR7vQpu4Uj3wHAb2RFfJxl/r0spKxqI
         pIqeZ4sO9VQttAV4RMQYjxWsx1C4rJvnGEAPL+yKMIqkX79Ta5QBDHBTuDxnstR/HzyR
         Ff5Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/0LthBAfGh8KoBgJZvwbOFkI9x1KrlT9pgMMxl5xnP1q3iVZcNjH0sp1pTSjmOBiFd24palkCPJYaR2bdKQ==@vger.kernel.org, AJvYcCVDPM/hOEfD13eh4LE/esV1fPdC511QYS+UAtf58XuuASzJgGQEhhAudB+UhtS9Z8gbmXtw4CctPym/xJSV@vger.kernel.org, AJvYcCX1xu7xYDGnTfzP453gSEpADS54gsjRkoNKI3IrdBlR/Wi0OhKnChpjWwj5bmUpVxMG+CBU9UWgqupj@vger.kernel.org
X-Gm-Message-State: AOJu0YzN8Gc/t8bri2zahI1IBE7ImP4EBQDJHjsPVAgrJ7nCyLtPImnN
	jrueHzhQ4aBfdHPEwt13kqcyODAfH3+ixDaG3rSnU7KIXeXs/pJOS6UKbHSX64w=
X-Gm-Gg: ASbGnctQROM0TjmlJoqkw7A7wmvnr9qEkd3OVZNESZdldMC/xCPkDPT9jZIZEgu+mKu
	dw8mZRtavz1DE4Vf09IkHDeOudJe/3dby4psi2Qp87SSOtyYdy8jpFdc3HxDh2GdVl60zrAmcpF
	+bFqaZWEAqHpPMQ3LlXRzGHPlVNaAzZ2h6dYfzCX7jRd/RnEKX3lKZZ4Ai357JvErjTECXjb+dG
	bxiaDsKGICPeYFWfmvMTUEvx4vUCk9i+WPju2UJsJ98+4CM5DdkZrXxELF2OU3jrqZNJriLWkXh
	a7dEnCcjMx+CSLolvbaeSt+5OQMP23Pxij7nTfFRonzboI37Jr9mTRwtuoU=
X-Google-Smtp-Source: AGHT+IETEMGqDaE4BlIeB9alG//R0Lq625UvJpFXYBmzGXsEuzqWX/tjjOe5CYHiTP4N46uc1QHP7Q==
X-Received: by 2002:a17:907:1b1d:b0:aa6:834b:d138 with SMTP id a640c23a62f3a-ab38b1122e8mr4276850966b.19.1738083118903;
        Tue, 28 Jan 2025 08:51:58 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab676114a73sm806958166b.162.2025.01.28.08.51.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2025 08:51:58 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa684b6d9c7so177636366b.2;
        Tue, 28 Jan 2025 08:51:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU1GWt/X2E5MmGVdg1rDFhDd0G9G8Rh2AEZ20o3klSwt3yWXqq7Xj5gzpTG6W/b433w31gPJbhTWGdt7Ksn@vger.kernel.org, AJvYcCUGMC4SW9rccwxCO6/p8vzNE4MJU8hB+VCizRDzVErpIS52SD7tM3eVGFnWECRcyaVXaOIrcvIXiQ6V@vger.kernel.org, AJvYcCVYRlJiol0P6w2mO4+Cr/yAevHVbclIOZ7JrPxaGGNQAvysYLAoWYRd2tFeFQcaECnjucj3qNxNIPu7sYz2lw==@vger.kernel.org
X-Received: by 2002:a17:907:d0f:b0:aa6:a9fe:46dd with SMTP id
 a640c23a62f3a-ab38b3aff9fmr4771843366b.38.1738083117609; Tue, 28 Jan 2025
 08:51:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3173328.1738024385@warthog.procyon.org.uk>
In-Reply-To: <3173328.1738024385@warthog.procyon.org.uk>
From: Marc Dionne <marc.dionne@auristor.com>
Date: Tue, 28 Jan 2025 12:51:46 -0400
X-Gmail-Original-Message-ID: <CAB9dFdtdNXR4K6dMaLTrWCO_Op7_g=NZZ5icB-iarvrLp8eoeA@mail.gmail.com>
X-Gm-Features: AWEUYZnlT7G53bpulMTDgO_Ga7IAUdNVp8mNwIWx3vbOISgKSRaogUhhtO1InLA
Message-ID: <CAB9dFdtdNXR4K6dMaLTrWCO_Op7_g=NZZ5icB-iarvrLp8eoeA@mail.gmail.com>
Subject: Re: [PATCH] netfs: Fix a number of read-retry hangs
To: David Howells <dhowells@redhat.com>
Cc: Ihor Solodrai <ihor.solodrai@pm.me>, Steve French <stfrench@microsoft.com>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	Paulo Alcantara <pc@manguebit.com>, Jeff Layton <jlayton@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, v9fs@lists.linux.dev, linux-cifs@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 8:33=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
> Hi Ihor, Marc, Steve,
>
> I think this patch should better fix the hangs that have been seen than I=
hor's
> previously tested fix (which I think isn't actually correct).
>
> David
> ---
> From: David Howells <dhowells@redhat.com>
>
> netfs: Fix a number of read-retry hangs
>
> Fix a number of hangs in the netfslib read-retry code, including:
>
>  (1) netfs_reissue_read() doubles up the getting of references on
>      subrequests, thereby leaking the subrequest and causing inode evicti=
on
>      to wait indefinitely.  This can lead to the kernel reporting a hang =
in
>      the filesystem's evict_inode().
>
>      Fix this by removing the get from netfs_reissue_read() and adding on=
e
>      to netfs_retry_read_subrequests() to deal with the one place that
>      didn't double up.
>
>  (2) The loop in netfs_retry_read_subrequests() that retries a sequence o=
f
>      failed subrequests doesn't record whether or not it retried the one
>      that the "subreq" pointer points to when it leaves the loop.  It may
>      not if renegotiation/repreparation of the subrequests means that few=
er
>      subrequests are needed to span the cumulative range of the sequence.
>
>      Because it doesn't record this, the piece of code that discards
>      now-superfluous subrequests doesn't know whether it should discard t=
he
>      one "subreq" points to - and so it doesn't.
>
>      Fix this by noting whether the last subreq it examines is superfluou=
s
>      and if it is, then getting rid of it and all subsequent subrequests.
>
>      If that one one wasn't superfluous, then we would have tried to go
>      round the previous loop again and so there can be no further unretri=
ed
>      subrequests in the sequence.
>
>  (3) netfs_retry_read_subrequests() gets yet an extra ref on any addition=
al
>      subrequests it has to get because it ran out of ones it could reuse =
to
>      to renegotiation/repreparation shrinking the subrequests.
>
>      Fix this by removing that extra ref.
>
>  (4) In netfs_retry_reads(), it was using wait_on_bit() to wait for
>      NETFS_SREQ_IN_PROGRESS to be cleared on all subrequests in the
>      sequence - but netfs_read_subreq_terminated() is now using a wait
>      queue on the request instead and so this wait will never finish.
>
>      Fix this by waiting on the wait queue instead.  To make this work, a
>      new flag, NETFS_RREQ_RETRYING, is now set around the wait loop to te=
ll
>      the wake-up code to wake up the wait queue rather than requeuing the
>      request's work item.
>
>      Note that this flag replaces the NETFS_RREQ_NEED_RETRY flag which is
>      no longer used.
>
>  (5) Whilst not strictly anything to do with the hang,
>      netfs_retry_read_subrequests() was also doubly incrementing the
>      subreq_counter and re-setting the debug index, leaving a gap in the
>      trace.  This is also fixed.
>
> One of these hangs was observed with 9p and with cifs.  Others were force=
d
> by manual code injection into fs/afs/file.c.  Firstly, afs_prepare_read()
> was created to provide an changing pattern of maximum subrequest sizes:
>
>         static int afs_prepare_read(struct netfs_io_subrequest *subreq)
>         {
>                 struct netfs_io_request *rreq =3D subreq->rreq;
>                 if (!S_ISREG(subreq->rreq->inode->i_mode))
>                         return 0;
>                 if (subreq->retry_count < 20)
>                         rreq->io_streams[0].sreq_max_len =3D
>                                 umax(200, 2222 - subreq->retry_count * 40=
);
>                 else
>                         rreq->io_streams[0].sreq_max_len =3D 3333;
>                 return 0;
>         }
>
> and pointed to by afs_req_ops.  Then the following:
>
>         struct netfs_io_subrequest *subreq =3D op->fetch.subreq;
>         if (subreq->error =3D=3D 0 &&
>             S_ISREG(subreq->rreq->inode->i_mode) &&
>             subreq->retry_count < 20) {
>                 subreq->transferred =3D subreq->already_done;
>                 __clear_bit(NETFS_SREQ_HIT_EOF, &subreq->flags);
>                 __set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
>                 afs_fetch_data_notify(op);
>                 return;
>         }
>
> was inserted into afs_fetch_data_success() at the beginning and struct
> netfs_io_subrequest given an extra field, "already_done" that was set to
> the value in "subreq->transferred" by netfs_reissue_read().
>
> When reading a 4K file, the subrequests would get gradually smaller, a ne=
w
> subrequest would be allocated around the 3rd retry and then eventually be
> rendered superfluous when the 20th retry was hit and the limit on the fir=
st
> subrequest was eased.
>
> Reported-by: Ihor Solodrai <ihor.solodrai@pm.me>
> Closes: https://lore.kernel.org/r/a7x33d4dnMdGTtRivptq6S1i8btK70SNBP2XyX_=
xwDAhLvgQoPox6FVBOkifq4eBinfFfbZlIkMZBe3QarlWTxoEtHZwJCZbNKtaqrR7PvI=3D@pm.=
me/
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: Steve French <stfrench@microsoft.com>
> cc: Eric Van Hensbergen <ericvh@kernel.org>
> cc: Latchesar Ionkov <lucho@ionkov.net>
> cc: Dominique Martinet <asmadeus@codewreck.org>
> cc: Christian Schoenebeck <linux_oss@crudebyte.com>
> cc: Paulo Alcantara <pc@manguebit.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: v9fs@lists.linux.dev
> cc: linux-cifs@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/netfs/read_collect.c      |    6 ++++--
>  fs/netfs/read_retry.c        |   40 ++++++++++++++++++++++++++++++------=
----
>  include/linux/netfs.h        |    2 +-
>  include/trace/events/netfs.h |    4 +++-
>  4 files changed, 38 insertions(+), 14 deletions(-)
>
> diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
> index f65affa5a9e4..636cc5a98ef5 100644
> --- a/fs/netfs/read_collect.c
> +++ b/fs/netfs/read_collect.c
> @@ -470,7 +470,8 @@ void netfs_read_collection_worker(struct work_struct =
*work)
>   */
>  void netfs_wake_read_collector(struct netfs_io_request *rreq)
>  {
> -       if (test_bit(NETFS_RREQ_OFFLOAD_COLLECTION, &rreq->flags)) {
> +       if (test_bit(NETFS_RREQ_OFFLOAD_COLLECTION, &rreq->flags) &&
> +           !test_bit(NETFS_RREQ_RETRYING, &rreq->flags)) {
>                 if (!work_pending(&rreq->work)) {
>                         netfs_get_request(rreq, netfs_rreq_trace_get_work=
);
>                         if (!queue_work(system_unbound_wq, &rreq->work))
> @@ -586,7 +587,8 @@ void netfs_read_subreq_terminated(struct netfs_io_sub=
request *subreq)
>         smp_mb__after_atomic(); /* Clear IN_PROGRESS before task state */
>
>         /* If we are at the head of the queue, wake up the collector. */
> -       if (list_is_first(&subreq->rreq_link, &stream->subrequests))
> +       if (list_is_first(&subreq->rreq_link, &stream->subrequests) ||
> +           test_bit(NETFS_RREQ_RETRYING, &rreq->flags))
>                 netfs_wake_read_collector(rreq);
>
>         netfs_put_subrequest(subreq, true, netfs_sreq_trace_put_terminate=
d);
> diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
> index 2290af0d51ac..8316c4533a51 100644
> --- a/fs/netfs/read_retry.c
> +++ b/fs/netfs/read_retry.c
> @@ -14,7 +14,6 @@ static void netfs_reissue_read(struct netfs_io_request =
*rreq,
>  {
>         __clear_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
>         __set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
> -       netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
>         subreq->rreq->netfs_ops->issue_read(subreq);
>  }
>
> @@ -48,6 +47,7 @@ static void netfs_retry_read_subrequests(struct netfs_i=
o_request *rreq)
>                                 __clear_bit(NETFS_SREQ_MADE_PROGRESS, &su=
breq->flags);
>                                 subreq->retry_count++;
>                                 netfs_reset_iter(subreq);
> +                               netfs_get_subrequest(subreq, netfs_sreq_t=
race_get_resubmit);
>                                 netfs_reissue_read(rreq, subreq);
>                         }
>                 }
> @@ -75,7 +75,7 @@ static void netfs_retry_read_subrequests(struct netfs_i=
o_request *rreq)
>                 struct iov_iter source;
>                 unsigned long long start, len;
>                 size_t part;
> -               bool boundary =3D false;
> +               bool boundary =3D false, subreq_superfluous =3D false;
>
>                 /* Go through the subreqs and find the next span of conti=
guous
>                  * buffer that we then rejig (cifs, for example, needs th=
e
> @@ -116,8 +116,10 @@ static void netfs_retry_read_subrequests(struct netf=
s_io_request *rreq)
>                 /* Work through the sublist. */
>                 subreq =3D from;
>                 list_for_each_entry_from(subreq, &stream->subrequests, rr=
eq_link) {
> -                       if (!len)
> +                       if (!len) {
> +                               subreq_superfluous =3D true;
>                                 break;
> +                       }
>                         subreq->source  =3D NETFS_DOWNLOAD_FROM_SERVER;
>                         subreq->start   =3D start - subreq->transferred;
>                         subreq->len     =3D len   + subreq->transferred;
> @@ -154,19 +156,21 @@ static void netfs_retry_read_subrequests(struct net=
fs_io_request *rreq)
>
>                         netfs_get_subrequest(subreq, netfs_sreq_trace_get=
_resubmit);
>                         netfs_reissue_read(rreq, subreq);
> -                       if (subreq =3D=3D to)
> +                       if (subreq =3D=3D to) {
> +                               subreq_superfluous =3D false;
>                                 break;
> +                       }
>                 }
>
>                 /* If we managed to use fewer subreqs, we can discard the
>                  * excess; if we used the same number, then we're done.
>                  */
>                 if (!len) {
> -                       if (subreq =3D=3D to)
> +                       if (!subreq_superfluous)
>                                 continue;
>                         list_for_each_entry_safe_from(subreq, tmp,
>                                                       &stream->subrequest=
s, rreq_link) {
> -                               trace_netfs_sreq(subreq, netfs_sreq_trace=
_discard);
> +                               trace_netfs_sreq(subreq, netfs_sreq_trace=
_superfluous);
>                                 list_del(&subreq->rreq_link);
>                                 netfs_put_subrequest(subreq, false, netfs=
_sreq_trace_put_done);
>                                 if (subreq =3D=3D to)
> @@ -187,14 +191,12 @@ static void netfs_retry_read_subrequests(struct net=
fs_io_request *rreq)
>                         subreq->source          =3D NETFS_DOWNLOAD_FROM_S=
ERVER;
>                         subreq->start           =3D start;
>                         subreq->len             =3D len;
> -                       subreq->debug_index     =3D atomic_inc_return(&rr=
eq->subreq_counter);
>                         subreq->stream_nr       =3D stream->stream_nr;
>                         subreq->retry_count     =3D 1;
>
>                         trace_netfs_sreq_ref(rreq->debug_id, subreq->debu=
g_index,
>                                              refcount_read(&subreq->ref),
>                                              netfs_sreq_trace_new);
> -                       netfs_get_subrequest(subreq, netfs_sreq_trace_get=
_resubmit);
>
>                         list_add(&subreq->rreq_link, &to->rreq_link);
>                         to =3D list_next_entry(to, rreq_link);
> @@ -256,14 +258,32 @@ void netfs_retry_reads(struct netfs_io_request *rre=
q)
>  {
>         struct netfs_io_subrequest *subreq;
>         struct netfs_io_stream *stream =3D &rreq->io_streams[0];
> +       DEFINE_WAIT(myself);
> +
> +       set_bit(NETFS_RREQ_RETRYING, &rreq->flags);
>
>         /* Wait for all outstanding I/O to quiesce before performing retr=
ies as
>          * we may need to renegotiate the I/O sizes.
>          */
>         list_for_each_entry(subreq, &stream->subrequests, rreq_link) {
> -               wait_on_bit(&subreq->flags, NETFS_SREQ_IN_PROGRESS,
> -                           TASK_UNINTERRUPTIBLE);
> +               if (!test_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags))
> +                       continue;
> +
> +               trace_netfs_rreq(rreq, netfs_rreq_trace_wait_queue);
> +               for (;;) {
> +                       prepare_to_wait(&rreq->waitq, &myself, TASK_UNINT=
ERRUPTIBLE);
> +
> +                       if (!test_bit(NETFS_SREQ_IN_PROGRESS, &subreq->fl=
ags))
> +                               break;
> +
> +                       trace_netfs_sreq(subreq, netfs_sreq_trace_wait_fo=
r);
> +                       schedule();
> +                       trace_netfs_rreq(rreq, netfs_rreq_trace_woke_queu=
e);
> +               }
> +
> +               finish_wait(&rreq->waitq, &myself);
>         }
> +       clear_bit(NETFS_RREQ_RETRYING, &rreq->flags);
>
>         trace_netfs_rreq(rreq, netfs_rreq_trace_resubmit);
>         netfs_retry_read_subrequests(rreq);
> diff --git a/include/linux/netfs.h b/include/linux/netfs.h
> index 071d05d81d38..c86a11cfc4a3 100644
> --- a/include/linux/netfs.h
> +++ b/include/linux/netfs.h
> @@ -278,7 +278,7 @@ struct netfs_io_request {
>  #define NETFS_RREQ_PAUSE               11      /* Pause subrequest gener=
ation */
>  #define NETFS_RREQ_USE_IO_ITER         12      /* Use ->io_iter rather t=
han ->i_pages */
>  #define NETFS_RREQ_ALL_QUEUED          13      /* All subreqs are now qu=
eued */
> -#define NETFS_RREQ_NEED_RETRY          14      /* Need to try retrying *=
/
> +#define NETFS_RREQ_RETRYING            14      /* Set if we're in the re=
try path */
>  #define NETFS_RREQ_USE_PGPRIV2         31      /* [DEPRECATED] Use PG_pr=
ivate_2 to mark
>                                                  * write to cache on read=
 */
>         const struct netfs_request_ops *netfs_ops;
> diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
> index 6e699cadcb29..f880835f7695 100644
> --- a/include/trace/events/netfs.h
> +++ b/include/trace/events/netfs.h
> @@ -99,7 +99,7 @@
>         EM(netfs_sreq_trace_limited,            "LIMIT")        \
>         EM(netfs_sreq_trace_need_clear,         "N-CLR")        \
>         EM(netfs_sreq_trace_partial_read,       "PARTR")        \
> -       EM(netfs_sreq_trace_need_retry,         "NRTRY")        \
> +       EM(netfs_sreq_trace_need_retry,         "ND-RT")        \
>         EM(netfs_sreq_trace_prepare,            "PREP ")        \
>         EM(netfs_sreq_trace_prep_failed,        "PRPFL")        \
>         EM(netfs_sreq_trace_progress,           "PRGRS")        \
> @@ -108,7 +108,9 @@
>         EM(netfs_sreq_trace_short,              "SHORT")        \
>         EM(netfs_sreq_trace_split,              "SPLIT")        \
>         EM(netfs_sreq_trace_submit,             "SUBMT")        \
> +       EM(netfs_sreq_trace_superfluous,        "SPRFL")        \
>         EM(netfs_sreq_trace_terminated,         "TERM ")        \
> +       EM(netfs_sreq_trace_wait_for,           "_WAIT")        \
>         EM(netfs_sreq_trace_write,              "WRITE")        \
>         EM(netfs_sreq_trace_write_skip,         "SKIP ")        \
>         E_(netfs_sreq_trace_write_term,         "WTERM")

Looks good in testing, with afs.  Took quite a few iterations to see
evidence of a retry occurring, where the new stat was helpful.

Tested-by: Marc Dionne <marc.dionne@auristor.com>

Marc

