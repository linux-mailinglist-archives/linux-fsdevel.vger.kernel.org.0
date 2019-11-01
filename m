Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2F14EC26B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2019 13:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730491AbfKAMEd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Nov 2019 08:04:33 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28434 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726710AbfKAMEd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Nov 2019 08:04:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572609871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FSqgKM31QO3mDmN5Beu3iKdlLlgfszQorlElD0I3nfI=;
        b=EiLrMe+tl87t7ouNSjfhR48lGYmDpGHHaap1C7ouXApd7MQzeuTRL7L5FyM8Ul3uzXeHc/
        1kiO8BLRn+dX8dsn7S2aAjdVtGgQ1BDJ/Ub5NuWJDcVRgaSvvxrJON0QHWWqYoLpwjvngs
        J+1LwNTEJ35pZkhGfgapSqOvxLl272A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-dE2T_71ZP7uvzeBkiO6iWw-1; Fri, 01 Nov 2019 08:04:29 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C79911005500;
        Fri,  1 Nov 2019 12:04:28 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 243045D6A7;
        Fri,  1 Nov 2019 12:04:28 +0000 (UTC)
Date:   Fri, 1 Nov 2019 08:04:26 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/28] xfs: Throttle commits on delayed background CIL
 push
Message-ID: <20191101120426.GC59146@bfoster>
References: <20191031234618.15403-1-david@fromorbit.com>
 <20191031234618.15403-3-david@fromorbit.com>
MIME-Version: 1.0
In-Reply-To: <20191031234618.15403-3-david@fromorbit.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: dE2T_71ZP7uvzeBkiO6iWw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 01, 2019 at 10:45:52AM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
>=20
> In certain situations the background CIL push can be indefinitely
> delayed. While we have workarounds from the obvious cases now, it
> doesn't solve the underlying issue. This issue is that there is no
> upper limit on the CIL where we will either force or wait for
> a background push to start, hence allowing the CIL to grow without
> bound until it consumes all log space.
>=20
> To fix this, add a new wait queue to the CIL which allows background
> pushes to wait for the CIL context to be switched out. This happens
> when the push starts, so it will allow us to block incoming
> transaction commit completion until the push has started. This will
> only affect processes that are running modifications, and only when
> the CIL threshold has been significantly overrun.
>=20
> This has no apparent impact on performance, and doesn't even trigger
> until over 45 million inodes had been created in a 16-way fsmark
> test on a 2GB log. That was limiting at 64MB of log space used, so
> the active CIL size is only about 3% of the total log in that case.
> The concurrent removal of those files did not trigger the background
> sleep at all.
>=20
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> Reviewed-by: Brian Foster <bfoster@redhat.com>
> ---

I don't recall posting an R-b tag for this one...

That said, I think my only outstanding feedback (side discussion aside)
was the code factoring in xlog_cil_push_background().

Brian

>  fs/xfs/xfs_log_cil.c  | 37 +++++++++++++++++++++++++++++++++----
>  fs/xfs/xfs_log_priv.h | 24 ++++++++++++++++++++++++
>  fs/xfs/xfs_trace.h    |  1 +
>  3 files changed, 58 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/xfs/xfs_log_cil.c b/fs/xfs/xfs_log_cil.c
> index a1204424a938..fc3f8e849dec 100644
> --- a/fs/xfs/xfs_log_cil.c
> +++ b/fs/xfs/xfs_log_cil.c
> @@ -670,6 +670,11 @@ xlog_cil_push(
>  =09push_seq =3D cil->xc_push_seq;
>  =09ASSERT(push_seq <=3D ctx->sequence);
> =20
> +=09/*
> +=09 * Wake up any background push waiters now this context is being push=
ed.
> +=09 */
> +=09wake_up_all(&ctx->push_wait);
> +
>  =09/*
>  =09 * Check if we've anything to push. If there is nothing, then we don'=
t
>  =09 * move on to a new sequence number and so we have to be able to push
> @@ -746,6 +751,7 @@ xlog_cil_push(
>  =09 */
>  =09INIT_LIST_HEAD(&new_ctx->committing);
>  =09INIT_LIST_HEAD(&new_ctx->busy_extents);
> +=09init_waitqueue_head(&new_ctx->push_wait);
>  =09new_ctx->sequence =3D ctx->sequence + 1;
>  =09new_ctx->cil =3D cil;
>  =09cil->xc_ctx =3D new_ctx;
> @@ -900,7 +906,7 @@ xlog_cil_push_work(
>   */
>  static void
>  xlog_cil_push_background(
> -=09struct xlog=09*log)
> +=09struct xlog=09*log) __releases(cil->xc_ctx_lock)
>  {
>  =09struct xfs_cil=09*cil =3D log->l_cilp;
> =20
> @@ -914,14 +920,36 @@ xlog_cil_push_background(
>  =09 * don't do a background push if we haven't used up all the
>  =09 * space available yet.
>  =09 */
> -=09if (cil->xc_ctx->space_used < XLOG_CIL_SPACE_LIMIT(log))
> +=09if (cil->xc_ctx->space_used < XLOG_CIL_SPACE_LIMIT(log)) {
> +=09=09up_read(&cil->xc_ctx_lock);
>  =09=09return;
> +=09}
> =20
>  =09spin_lock(&cil->xc_push_lock);
>  =09if (cil->xc_push_seq < cil->xc_current_sequence) {
>  =09=09cil->xc_push_seq =3D cil->xc_current_sequence;
>  =09=09queue_work(log->l_mp->m_cil_workqueue, &cil->xc_push_work);
>  =09}
> +
> +=09/*
> +=09 * Drop the context lock now, we can't hold that if we need to sleep
> +=09 * because we are over the blocking threshold. The push_lock is still
> +=09 * held, so blocking threshold sleep/wakeup is still correctly
> +=09 * serialised here.
> +=09 */
> +=09up_read(&cil->xc_ctx_lock);
> +
> +=09/*
> +=09 * If we are well over the space limit, throttle the work that is bei=
ng
> +=09 * done until the push work on this context has begun.
> +=09 */
> +=09if (cil->xc_ctx->space_used >=3D XLOG_CIL_BLOCKING_SPACE_LIMIT(log)) =
{
> +=09=09trace_xfs_log_cil_wait(log, cil->xc_ctx->ticket);
> +=09=09ASSERT(cil->xc_ctx->space_used < log->l_logsize);
> +=09=09xlog_wait(&cil->xc_ctx->push_wait, &cil->xc_push_lock);
> +=09=09return;
> +=09}
> +
>  =09spin_unlock(&cil->xc_push_lock);
> =20
>  }
> @@ -1038,9 +1066,9 @@ xfs_log_commit_cil(
>  =09=09if (lip->li_ops->iop_committing)
>  =09=09=09lip->li_ops->iop_committing(lip, xc_commit_lsn);
>  =09}
> -=09xlog_cil_push_background(log);
> =20
> -=09up_read(&cil->xc_ctx_lock);
> +=09/* xlog_cil_push_background() releases cil->xc_ctx_lock */
> +=09xlog_cil_push_background(log);
>  }
> =20
>  /*
> @@ -1199,6 +1227,7 @@ xlog_cil_init(
> =20
>  =09INIT_LIST_HEAD(&ctx->committing);
>  =09INIT_LIST_HEAD(&ctx->busy_extents);
> +=09init_waitqueue_head(&ctx->push_wait);
>  =09ctx->sequence =3D 1;
>  =09ctx->cil =3D cil;
>  =09cil->xc_ctx =3D ctx;
> diff --git a/fs/xfs/xfs_log_priv.h b/fs/xfs/xfs_log_priv.h
> index abd382cfffe3..1cc5333a3f6a 100644
> --- a/fs/xfs/xfs_log_priv.h
> +++ b/fs/xfs/xfs_log_priv.h
> @@ -242,6 +242,7 @@ struct xfs_cil_ctx {
>  =09struct xfs_log_vec=09*lv_chain;=09/* logvecs being pushed */
>  =09struct list_head=09iclog_entry;
>  =09struct list_head=09committing;=09/* ctx committing list */
> +=09wait_queue_head_t=09push_wait;=09/* background push throttle */
>  =09struct work_struct=09discard_endio_work;
>  };
> =20
> @@ -339,10 +340,33 @@ struct xfs_cil {
>   *   buffer window (32MB) as measurements have shown this to be roughly =
the
>   *   point of diminishing performance increases under highly concurrent
>   *   modification workloads.
> + *
> + * To prevent the CIL from overflowing upper commit size bounds, we intr=
oduce a
> + * new threshold at which we block committing transactions until the bac=
kground
> + * CIL commit commences and switches to a new context. While this is not=
 a hard
> + * limit, it forces the process committing a transaction to the CIL to b=
lock and
> + * yeild the CPU, giving the CIL push work a chance to be scheduled and =
start
> + * work. This prevents a process running lots of transactions from overf=
illing
> + * the CIL because it is not yielding the CPU. We set the blocking limit=
 at
> + * twice the background push space threshold so we keep in line with the=
 AIL
> + * push thresholds.
> + *
> + * Note: this is not a -hard- limit as blocking is applied after the tra=
nsaction
> + * is inserted into the CIL and the push has been triggered. It is large=
ly a
> + * throttling mechanism that allows the CIL push to be scheduled and run=
. A hard
> + * limit will be difficult to implement without introducing global seria=
lisation
> + * in the CIL commit fast path, and it's not at all clear that we actual=
ly need
> + * such hard limits given the ~7 years we've run without a hard limit be=
fore
> + * finding the first situation where a checkpoint size overflow actually
> + * occurred. Hence the simple throttle, and an ASSERT check to tell us t=
hat
> + * we've overrun the max size.
>   */
>  #define XLOG_CIL_SPACE_LIMIT(log)=09\
>  =09min_t(int, (log)->l_logsize >> 3, BBTOB(XLOG_TOTAL_REC_SHIFT(log)) <<=
 4)
> =20
> +#define XLOG_CIL_BLOCKING_SPACE_LIMIT(log)=09\
> +=09(XLOG_CIL_SPACE_LIMIT(log) * 2)
> +
>  /*
>   * ticket grant locks, queues and accounting have their own cachlines
>   * as these are quite hot and can be operated on concurrently.
> diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
> index c13bb3655e48..d3635d1e3de6 100644
> --- a/fs/xfs/xfs_trace.h
> +++ b/fs/xfs/xfs_trace.h
> @@ -1011,6 +1011,7 @@ DEFINE_LOGGRANT_EVENT(xfs_log_regrant_reserve_sub);
>  DEFINE_LOGGRANT_EVENT(xfs_log_ungrant_enter);
>  DEFINE_LOGGRANT_EVENT(xfs_log_ungrant_exit);
>  DEFINE_LOGGRANT_EVENT(xfs_log_ungrant_sub);
> +DEFINE_LOGGRANT_EVENT(xfs_log_cil_wait);
> =20
>  DECLARE_EVENT_CLASS(xfs_log_item_class,
>  =09TP_PROTO(struct xfs_log_item *lip),
> --=20
> 2.24.0.rc0
>=20

