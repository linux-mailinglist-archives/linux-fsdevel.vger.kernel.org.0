Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19663F03C2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2019 18:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390340AbfKERF3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Nov 2019 12:05:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20276 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390304AbfKERF2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Nov 2019 12:05:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572973527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/eDR/0pirtNuiOuE989IpBGTNQbLyeeJPfKz3K19tXI=;
        b=WD7JqZp6yYBecwXsE2He/jh+7+4OW4WS4hy2F1U35FO+uCxK/omPevD1bz4jT0ERFxjbWs
        Gs448ZMoSvVJICMKZIUi3h++pbXgUlcxRbRCcjEpoRYuGvYaYW5iVdMfqgrENmROoVs34g
        kT2O1qR9duGlv8cj3im6IRXR9tCFa3w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-_rGDOizNNZ2PwgnDIWN6nw-1; Tue, 05 Nov 2019 12:05:23 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AEC9C107ACC4;
        Tue,  5 Nov 2019 17:05:22 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B16119C4F;
        Tue,  5 Nov 2019 17:05:22 +0000 (UTC)
Date:   Tue, 5 Nov 2019 12:05:20 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 20/28] xfs: kill background reclaim work
Message-ID: <20191105170520.GD28493@bfoster>
References: <20191031234618.15403-1-david@fromorbit.com>
 <20191031234618.15403-21-david@fromorbit.com>
MIME-Version: 1.0
In-Reply-To: <20191031234618.15403-21-david@fromorbit.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: _rGDOizNNZ2PwgnDIWN6nw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 01, 2019 at 10:46:10AM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
>=20
> This function is now entirely done by kswapd, so we don't need the
> worker thread to do async reclaim anymore.
>=20
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  fs/xfs/xfs_icache.c | 44 --------------------------------------------
>  fs/xfs/xfs_icache.h |  2 --
>  fs/xfs/xfs_mount.c  |  2 --
>  fs/xfs/xfs_mount.h  |  2 --
>  fs/xfs/xfs_super.c  | 11 +----------
>  5 files changed, 1 insertion(+), 60 deletions(-)
>=20
> diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> index 189cf423fe8f..7e175304e146 100644
> --- a/fs/xfs/xfs_icache.c
> +++ b/fs/xfs/xfs_icache.c
> @@ -138,44 +138,6 @@ xfs_inode_free(
>  =09__xfs_inode_free(ip);
>  }
> =20
> -/*
> - * Queue a new inode reclaim pass if there are reclaimable inodes and th=
ere
> - * isn't a reclaim pass already in progress. By default it runs every 5s=
 based
> - * on the xfs periodic sync default of 30s. Perhaps this should have it'=
s own
> - * tunable, but that can be done if this method proves to be ineffective=
 or too
> - * aggressive.
> - */
> -static void
> -xfs_reclaim_work_queue(
> -=09struct xfs_mount        *mp)
> -{
> -
> -=09rcu_read_lock();
> -=09if (radix_tree_tagged(&mp->m_perag_tree, XFS_ICI_RECLAIM_TAG)) {
> -=09=09queue_delayed_work(mp->m_reclaim_workqueue, &mp->m_reclaim_work,
> -=09=09=09msecs_to_jiffies(xfs_syncd_centisecs / 6 * 10));
> -=09}
> -=09rcu_read_unlock();
> -}
> -
> -/*
> - * This is a fast pass over the inode cache to try to get reclaim moving=
 on as
> - * many inodes as possible in a short period of time. It kicks itself ev=
ery few
> - * seconds, as well as being kicked by the inode cache shrinker when mem=
ory
> - * goes low. It scans as quickly as possible avoiding locked inodes or t=
hose
> - * already being flushed, and once done schedules a future pass.
> - */
> -void
> -xfs_reclaim_worker(
> -=09struct work_struct *work)
> -{
> -=09struct xfs_mount *mp =3D container_of(to_delayed_work(work),
> -=09=09=09=09=09struct xfs_mount, m_reclaim_work);
> -
> -=09xfs_reclaim_inodes(mp, SYNC_TRYLOCK);
> -=09xfs_reclaim_work_queue(mp);
> -}
> -
>  static void
>  xfs_perag_set_reclaim_tag(
>  =09struct xfs_perag=09*pag)
> @@ -192,9 +154,6 @@ xfs_perag_set_reclaim_tag(
>  =09=09=09   XFS_ICI_RECLAIM_TAG);
>  =09spin_unlock(&mp->m_perag_lock);
> =20
> -=09/* schedule periodic background inode reclaim */
> -=09xfs_reclaim_work_queue(mp);
> -
>  =09trace_xfs_perag_set_reclaim(mp, pag->pag_agno, -1, _RET_IP_);
>  }
> =20
> @@ -1393,9 +1352,6 @@ xfs_reclaim_inodes_nr(
>  {
>  =09int=09=09=09sync_mode =3D SYNC_TRYLOCK;
> =20
> -=09/* kick background reclaimer */
> -=09xfs_reclaim_work_queue(mp);
> -
>  =09/*
>  =09 * For kswapd, we kick background inode writeback. For direct
>  =09 * reclaim, we issue and wait on inode writeback to throttle
> diff --git a/fs/xfs/xfs_icache.h b/fs/xfs/xfs_icache.h
> index 48f1fd2bb6ad..4c0d8920cc54 100644
> --- a/fs/xfs/xfs_icache.h
> +++ b/fs/xfs/xfs_icache.h
> @@ -49,8 +49,6 @@ int xfs_iget(struct xfs_mount *mp, struct xfs_trans *tp=
, xfs_ino_t ino,
>  struct xfs_inode * xfs_inode_alloc(struct xfs_mount *mp, xfs_ino_t ino);
>  void xfs_inode_free(struct xfs_inode *ip);
> =20
> -void xfs_reclaim_worker(struct work_struct *work);
> -
>  int xfs_reclaim_inodes(struct xfs_mount *mp, int mode);
>  int xfs_reclaim_inodes_count(struct xfs_mount *mp);
>  long xfs_reclaim_inodes_nr(struct xfs_mount *mp, int nr_to_scan);
> diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
> index 3e8eedf01eb2..8f76c2add18b 100644
> --- a/fs/xfs/xfs_mount.c
> +++ b/fs/xfs/xfs_mount.c
> @@ -952,7 +952,6 @@ xfs_mountfs(
>  =09 * qm_unmount_quotas and therefore rely on qm_unmount to release the
>  =09 * quota inodes.
>  =09 */
> -=09cancel_delayed_work_sync(&mp->m_reclaim_work);
>  =09xfs_reclaim_inodes(mp, SYNC_WAIT);
>  =09xfs_health_unmount(mp);
>   out_log_dealloc:
> @@ -1035,7 +1034,6 @@ xfs_unmountfs(
>  =09 * reclaim just to be sure. We can stop background inode reclaim
>  =09 * here as well if it is still running.
>  =09 */
> -=09cancel_delayed_work_sync(&mp->m_reclaim_work);
>  =09xfs_reclaim_inodes(mp, SYNC_WAIT);
>  =09xfs_health_unmount(mp);
> =20
> diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
> index a46cb3fd24b1..8c6885d3b085 100644
> --- a/fs/xfs/xfs_mount.h
> +++ b/fs/xfs/xfs_mount.h
> @@ -163,7 +163,6 @@ typedef struct xfs_mount {
>  =09uint=09=09=09m_chsize;=09/* size of next field */
>  =09atomic_t=09=09m_active_trans;=09/* number trans frozen */
>  =09struct xfs_mru_cache=09*m_filestream;  /* per-mount filestream data *=
/
> -=09struct delayed_work=09m_reclaim_work;=09/* background inode reclaim *=
/
>  =09struct delayed_work=09m_eofblocks_work; /* background eof blocks
>  =09=09=09=09=09=09     trimming */
>  =09struct delayed_work=09m_cowblocks_work; /* background cow blocks
> @@ -180,7 +179,6 @@ typedef struct xfs_mount {
>  =09struct workqueue_struct *m_buf_workqueue;
>  =09struct workqueue_struct=09*m_unwritten_workqueue;
>  =09struct workqueue_struct=09*m_cil_workqueue;
> -=09struct workqueue_struct=09*m_reclaim_workqueue;
>  =09struct workqueue_struct *m_eofblocks_workqueue;
>  =09struct workqueue_struct=09*m_sync_workqueue;
> =20
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index ebe2ccd36127..a4fe679207ef 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -794,15 +794,10 @@ xfs_init_mount_workqueues(
>  =09if (!mp->m_cil_workqueue)
>  =09=09goto out_destroy_unwritten;
> =20
> -=09mp->m_reclaim_workqueue =3D alloc_workqueue("xfs-reclaim/%s",
> -=09=09=09WQ_MEM_RECLAIM|WQ_FREEZABLE, 0, mp->m_fsname);
> -=09if (!mp->m_reclaim_workqueue)
> -=09=09goto out_destroy_cil;
> -
>  =09mp->m_eofblocks_workqueue =3D alloc_workqueue("xfs-eofblocks/%s",
>  =09=09=09WQ_MEM_RECLAIM|WQ_FREEZABLE, 0, mp->m_fsname);
>  =09if (!mp->m_eofblocks_workqueue)
> -=09=09goto out_destroy_reclaim;
> +=09=09goto out_destroy_cil;
> =20
>  =09mp->m_sync_workqueue =3D alloc_workqueue("xfs-sync/%s", WQ_FREEZABLE,=
 0,
>  =09=09=09=09=09       mp->m_fsname);
> @@ -813,8 +808,6 @@ xfs_init_mount_workqueues(
> =20
>  out_destroy_eofb:
>  =09destroy_workqueue(mp->m_eofblocks_workqueue);
> -out_destroy_reclaim:
> -=09destroy_workqueue(mp->m_reclaim_workqueue);
>  out_destroy_cil:
>  =09destroy_workqueue(mp->m_cil_workqueue);
>  out_destroy_unwritten:
> @@ -831,7 +824,6 @@ xfs_destroy_mount_workqueues(
>  {
>  =09destroy_workqueue(mp->m_sync_workqueue);
>  =09destroy_workqueue(mp->m_eofblocks_workqueue);
> -=09destroy_workqueue(mp->m_reclaim_workqueue);
>  =09destroy_workqueue(mp->m_cil_workqueue);
>  =09destroy_workqueue(mp->m_unwritten_workqueue);
>  =09destroy_workqueue(mp->m_buf_workqueue);
> @@ -1520,7 +1512,6 @@ xfs_mount_alloc(
>  =09spin_lock_init(&mp->m_perag_lock);
>  =09mutex_init(&mp->m_growlock);
>  =09atomic_set(&mp->m_active_trans, 0);
> -=09INIT_DELAYED_WORK(&mp->m_reclaim_work, xfs_reclaim_worker);
>  =09INIT_DELAYED_WORK(&mp->m_eofblocks_work, xfs_eofblocks_worker);
>  =09INIT_DELAYED_WORK(&mp->m_cowblocks_work, xfs_cowblocks_worker);
>  =09mp->m_kobj.kobject.kset =3D xfs_kset;
> --=20
> 2.24.0.rc0
>=20

