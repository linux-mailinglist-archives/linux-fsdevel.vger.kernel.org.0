Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70A7EF03B8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2019 18:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730937AbfKERFL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Nov 2019 12:05:11 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53691 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728756AbfKERFL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Nov 2019 12:05:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572973510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GsUIs0PxyvJkU8tBUrC1vdu5JXZuWTORoAJ8kG/FaUE=;
        b=fJCeHWWv42m/hsR7LD6Sds+1tMk2n0y2L6pHp6QXNodUHfMxNIANf9M8d0JA5IPVtQsaqh
        NckknLV0kHt5BI6jJJ96W8Z/Q7wgvW5OwPedDulTBBip2pPzWoxHCnWEmALo6ovOsCaqpg
        7ja8fxnSgSQYqCjaXVQCtwY4ZA6lFVE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-hv2alWZENk2-tTEzd97Tug-1; Tue, 05 Nov 2019 12:05:05 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3CCDE800C73;
        Tue,  5 Nov 2019 17:05:04 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E2EE608AC;
        Tue,  5 Nov 2019 17:05:03 +0000 (UTC)
Date:   Tue, 5 Nov 2019 12:05:01 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/28] xfs: synchronous AIL pushing
Message-ID: <20191105170501.GB28493@bfoster>
References: <20191031234618.15403-1-david@fromorbit.com>
 <20191031234618.15403-18-david@fromorbit.com>
MIME-Version: 1.0
In-Reply-To: <20191031234618.15403-18-david@fromorbit.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: hv2alWZENk2-tTEzd97Tug-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 01, 2019 at 10:46:07AM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
>=20
> Provide an interface to push the AIL to a target LSN and wait for
> the tail of the log to move past that LSN. This is used to wait for
> all items older than a specific LSN to either be cleaned (written
> back) or relogged to a higher LSN in the AIL. The primary use for
> this is to allow IO free inode reclaim throttling.
>=20
> Factor the common AIL deletion code that does all the wakeups into a
> helper so we only have one copy of this somewhat tricky code to
> interface with all the wakeups necessary when the LSN of the log
> tail changes.
>=20

The above paragraph doesn't seem applicable to this patch. With that
fixed:

Reviewed-by: Brian Foster <bfoster@redhat.com>

> xfs_ail_push_sync() is temporary infrastructure to facilitate
> non-blocking, IO-less inode reclaim throttling that allows further
> structural changes to be made. Once those structural changes are
> made, the need for this function goes away and it is removed. In
> essence, it is only provided to ensure git bisects don't break while
> the changes to the reclaim algorithms are in progress.
>=20
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  fs/xfs/xfs_trans_ail.c  | 32 ++++++++++++++++++++++++++++++++
>  fs/xfs/xfs_trans_priv.h |  2 ++
>  2 files changed, 34 insertions(+)
>=20
> diff --git a/fs/xfs/xfs_trans_ail.c b/fs/xfs/xfs_trans_ail.c
> index 685a21cd24c0..3e1d0e1439e2 100644
> --- a/fs/xfs/xfs_trans_ail.c
> +++ b/fs/xfs/xfs_trans_ail.c
> @@ -662,6 +662,36 @@ xfs_ail_push_all(
>  =09=09xfs_ail_push(ailp, threshold_lsn);
>  }
> =20
> +/*
> + * Push the AIL to a specific lsn and wait for it to complete.
> + */
> +void
> +xfs_ail_push_sync(
> +=09struct xfs_ail=09=09*ailp,
> +=09xfs_lsn_t=09=09threshold_lsn)
> +{
> +=09struct xfs_log_item=09*lip;
> +=09DEFINE_WAIT(wait);
> +
> +=09spin_lock(&ailp->ail_lock);
> +=09while ((lip =3D xfs_ail_min(ailp)) !=3D NULL) {
> +=09=09prepare_to_wait(&ailp->ail_push, &wait, TASK_UNINTERRUPTIBLE);
> +=09=09if (XFS_FORCED_SHUTDOWN(ailp->ail_mount) ||
> +=09=09    XFS_LSN_CMP(threshold_lsn, lip->li_lsn) < 0)
> +=09=09=09break;
> +=09=09if (XFS_LSN_CMP(threshold_lsn, ailp->ail_target) > 0)
> +=09=09=09ailp->ail_target =3D threshold_lsn;
> +=09=09wake_up_process(ailp->ail_task);
> +=09=09spin_unlock(&ailp->ail_lock);
> +=09=09schedule();
> +=09=09spin_lock(&ailp->ail_lock);
> +=09}
> +=09spin_unlock(&ailp->ail_lock);
> +
> +=09finish_wait(&ailp->ail_push, &wait);
> +}
> +
> +
>  /*
>   * Push out all items in the AIL immediately and wait until the AIL is e=
mpty.
>   */
> @@ -702,6 +732,7 @@ xfs_ail_update_finish(
>  =09if (!XFS_FORCED_SHUTDOWN(mp))
>  =09=09xlog_assign_tail_lsn_locked(mp);
> =20
> +=09wake_up_all(&ailp->ail_push);
>  =09if (list_empty(&ailp->ail_head))
>  =09=09wake_up_all(&ailp->ail_empty);
>  =09spin_unlock(&ailp->ail_lock);
> @@ -858,6 +889,7 @@ xfs_trans_ail_init(
>  =09spin_lock_init(&ailp->ail_lock);
>  =09INIT_LIST_HEAD(&ailp->ail_buf_list);
>  =09init_waitqueue_head(&ailp->ail_empty);
> +=09init_waitqueue_head(&ailp->ail_push);
> =20
>  =09ailp->ail_task =3D kthread_run(xfsaild, ailp, "xfsaild/%s",
>  =09=09=09ailp->ail_mount->m_fsname);
> diff --git a/fs/xfs/xfs_trans_priv.h b/fs/xfs/xfs_trans_priv.h
> index 35655eac01a6..1b6f4bbd47c0 100644
> --- a/fs/xfs/xfs_trans_priv.h
> +++ b/fs/xfs/xfs_trans_priv.h
> @@ -61,6 +61,7 @@ struct xfs_ail {
>  =09int=09=09=09ail_log_flush;
>  =09struct list_head=09ail_buf_list;
>  =09wait_queue_head_t=09ail_empty;
> +=09wait_queue_head_t=09ail_push;
>  };
> =20
>  /*
> @@ -113,6 +114,7 @@ xfs_trans_ail_remove(
>  }
> =20
>  void=09=09=09xfs_ail_push(struct xfs_ail *, xfs_lsn_t);
> +void=09=09=09xfs_ail_push_sync(struct xfs_ail *, xfs_lsn_t);
>  void=09=09=09xfs_ail_push_all(struct xfs_ail *);
>  void=09=09=09xfs_ail_push_all_sync(struct xfs_ail *);
>  struct xfs_log_item=09*xfs_ail_min(struct xfs_ail  *ailp);
> --=20
> 2.24.0.rc0
>=20

