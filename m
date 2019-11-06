Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD13F1C5A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2019 18:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732378AbfKFRWY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Nov 2019 12:22:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58804 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729014AbfKFRWY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Nov 2019 12:22:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573060942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wZtDGdfo7vXdtWrOoV18T6iDMYJ4ms1A4QXFYMIJNHA=;
        b=cxv9ZpLOgT7I2VjMllNWBPMsNkxubwwN+inUgfqQ4qprPg/3iB8ZNEsiY9/mLDdeQMkExu
        rThWXkytgOEQNsafcTEy3e0A95zzmMUwYr70uuV99hybECUZSTyYTULFO3mZ4xRF9UTnB6
        KxfRzaLBfuZ0yN3ohA7/cwtP16yyr80=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-1dEdgbm0PpGYAyVYiGNXng-1; Wed, 06 Nov 2019 12:22:19 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D04C1477;
        Wed,  6 Nov 2019 17:22:17 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3CFD45C1C3;
        Wed,  6 Nov 2019 17:22:17 +0000 (UTC)
Date:   Wed, 6 Nov 2019 12:22:15 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 26/28] xfs: use xfs_ail_push_all in xfs_reclaim_inodes
Message-ID: <20191106172215.GD37080@bfoster>
References: <20191031234618.15403-1-david@fromorbit.com>
 <20191031234618.15403-27-david@fromorbit.com>
MIME-Version: 1.0
In-Reply-To: <20191031234618.15403-27-david@fromorbit.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 1dEdgbm0PpGYAyVYiGNXng-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 01, 2019 at 10:46:16AM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
>=20
> If we are reclaiming all inodes, it is likely we need to flush the
> entire AIL to do that. We have mechanisms to do that without needing
> to push to a specific LSN.
>=20
> Convert xfs_relaim_all_inodes() to use xfs_ail_push_all variant so
> we can get rid of the hacky xfs_ail_push_sync() scaffolding we used
> to support the intermediate stages of the non-blocking reclaim
> changeset.
>=20
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  fs/xfs/xfs_icache.c     | 17 +++++++++++------
>  fs/xfs/xfs_trans_ail.c  | 32 --------------------------------
>  fs/xfs/xfs_trans_priv.h |  2 --
>  3 files changed, 11 insertions(+), 40 deletions(-)
>=20
> diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> index 71a729e29260..11bf4768d491 100644
> --- a/fs/xfs/xfs_icache.c
> +++ b/fs/xfs/xfs_icache.c
...
> @@ -1066,13 +1074,10 @@ xfs_reclaim_all_inodes(
>  =09=09=09=09      xfs_inode_reclaim_isolate, &ra, to_free);
>  =09=09xfs_dispose_inodes(&ra.freeable);
> =20
> -=09=09if (freed =3D=3D 0) {
> +=09=09if (freed =3D=3D 0)
>  =09=09=09xfs_log_force(mp, XFS_LOG_SYNC);
> -=09=09=09xfs_ail_push_all(mp->m_ail);
> -=09=09} else if (ra.lowest_lsn !=3D NULLCOMMITLSN) {
> -=09=09=09xfs_ail_push_sync(mp->m_ail, ra.lowest_lsn);
> -=09=09}
> -=09=09cond_resched();
> +=09=09else if (ra.dirty_skipped)
> +=09=09=09congestion_wait(BLK_RW_ASYNC, HZ/10);

Why not use xfs_ail_push_all_sync() in this function and skip the direct
stall? This is only used in the unmount and quiesce paths so the big
hammer approach seems reasonable. As it is, the former already calls
xfs_ail_push_all_sync() before xfs_reclaim_all_inodes() and the latter
calls xfs_log_force(mp, XFS_LOG_SYNC).

Brian

>  =09}
>  }
> =20
> diff --git a/fs/xfs/xfs_trans_ail.c b/fs/xfs/xfs_trans_ail.c
> index 3e1d0e1439e2..685a21cd24c0 100644
> --- a/fs/xfs/xfs_trans_ail.c
> +++ b/fs/xfs/xfs_trans_ail.c
> @@ -662,36 +662,6 @@ xfs_ail_push_all(
>  =09=09xfs_ail_push(ailp, threshold_lsn);
>  }
> =20
> -/*
> - * Push the AIL to a specific lsn and wait for it to complete.
> - */
> -void
> -xfs_ail_push_sync(
> -=09struct xfs_ail=09=09*ailp,
> -=09xfs_lsn_t=09=09threshold_lsn)
> -{
> -=09struct xfs_log_item=09*lip;
> -=09DEFINE_WAIT(wait);
> -
> -=09spin_lock(&ailp->ail_lock);
> -=09while ((lip =3D xfs_ail_min(ailp)) !=3D NULL) {
> -=09=09prepare_to_wait(&ailp->ail_push, &wait, TASK_UNINTERRUPTIBLE);
> -=09=09if (XFS_FORCED_SHUTDOWN(ailp->ail_mount) ||
> -=09=09    XFS_LSN_CMP(threshold_lsn, lip->li_lsn) < 0)
> -=09=09=09break;
> -=09=09if (XFS_LSN_CMP(threshold_lsn, ailp->ail_target) > 0)
> -=09=09=09ailp->ail_target =3D threshold_lsn;
> -=09=09wake_up_process(ailp->ail_task);
> -=09=09spin_unlock(&ailp->ail_lock);
> -=09=09schedule();
> -=09=09spin_lock(&ailp->ail_lock);
> -=09}
> -=09spin_unlock(&ailp->ail_lock);
> -
> -=09finish_wait(&ailp->ail_push, &wait);
> -}
> -
> -
>  /*
>   * Push out all items in the AIL immediately and wait until the AIL is e=
mpty.
>   */
> @@ -732,7 +702,6 @@ xfs_ail_update_finish(
>  =09if (!XFS_FORCED_SHUTDOWN(mp))
>  =09=09xlog_assign_tail_lsn_locked(mp);
> =20
> -=09wake_up_all(&ailp->ail_push);
>  =09if (list_empty(&ailp->ail_head))
>  =09=09wake_up_all(&ailp->ail_empty);
>  =09spin_unlock(&ailp->ail_lock);
> @@ -889,7 +858,6 @@ xfs_trans_ail_init(
>  =09spin_lock_init(&ailp->ail_lock);
>  =09INIT_LIST_HEAD(&ailp->ail_buf_list);
>  =09init_waitqueue_head(&ailp->ail_empty);
> -=09init_waitqueue_head(&ailp->ail_push);
> =20
>  =09ailp->ail_task =3D kthread_run(xfsaild, ailp, "xfsaild/%s",
>  =09=09=09ailp->ail_mount->m_fsname);
> diff --git a/fs/xfs/xfs_trans_priv.h b/fs/xfs/xfs_trans_priv.h
> index 1b6f4bbd47c0..35655eac01a6 100644
> --- a/fs/xfs/xfs_trans_priv.h
> +++ b/fs/xfs/xfs_trans_priv.h
> @@ -61,7 +61,6 @@ struct xfs_ail {
>  =09int=09=09=09ail_log_flush;
>  =09struct list_head=09ail_buf_list;
>  =09wait_queue_head_t=09ail_empty;
> -=09wait_queue_head_t=09ail_push;
>  };
> =20
>  /*
> @@ -114,7 +113,6 @@ xfs_trans_ail_remove(
>  }
> =20
>  void=09=09=09xfs_ail_push(struct xfs_ail *, xfs_lsn_t);
> -void=09=09=09xfs_ail_push_sync(struct xfs_ail *, xfs_lsn_t);
>  void=09=09=09xfs_ail_push_all(struct xfs_ail *);
>  void=09=09=09xfs_ail_push_all_sync(struct xfs_ail *);
>  struct xfs_log_item=09*xfs_ail_min(struct xfs_ail  *ailp);
> --=20
> 2.24.0.rc0
>=20

