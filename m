Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E312674723B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 15:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbjGDNGY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 09:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjGDNGY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:06:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E62510CB;
        Tue,  4 Jul 2023 06:06:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5A87420571;
        Tue,  4 Jul 2023 13:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688475980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PLWsrgQGO+3VhW83lxnVnQ99rfvakSITgWsQ0pI4pLk=;
        b=GK481svLpNqmVShIN08o8MxgNo+yP70Nst/BOrp8pUGQnsw4fNrxRQwo6ws1GcgUM+GK5F
        xLiVByckhFA79LROHXeaoWxZIkRqmVs2tg5oB1QVHeHkYTxC4EZTSw27Ek8KeIls5NWQ0W
        LiWoqxK7VjWOGdmccGUY9bqyKMl0zQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688475980;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PLWsrgQGO+3VhW83lxnVnQ99rfvakSITgWsQ0pI4pLk=;
        b=mZ1ECUtIK1wcVzoMlyCdYOXR1iLpLCuDb8w8nULxNQ6DICuU4g1GEET7uLhgJLpsjeEy4w
        wvJgS6V6N7gzucBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CC0251346D;
        Tue,  4 Jul 2023 13:06:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id D/iUJkoZpGQfSQAAMHmgww
        (envelope-from <colyli@suse.de>); Tue, 04 Jul 2023 13:06:18 +0000
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [PATCH 10/32] bcache: Convert to blkdev_get_handle_by_path()
From:   Coly Li <colyli@suse.de>
In-Reply-To: <20230704122224.16257-10-jack@suse.cz>
Date:   Tue, 4 Jul 2023 21:06:06 +0800
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-bcache@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <469E31EF-E55F-4C00-801E-638E8F63C95A@suse.de>
References: <20230629165206.383-1-jack@suse.cz>
 <20230704122224.16257-10-jack@suse.cz>
To:     Jan Kara <jack@suse.cz>
X-Mailer: Apple Mail (2.3731.600.7)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> 2023=E5=B9=B47=E6=9C=884=E6=97=A5 20:21=EF=BC=8CJan Kara =
<jack@suse.cz> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Convert bcache to use blkdev_get_handle_by_path() and pass the handle
> around.
>=20
> CC: linux-bcache@vger.kernel.org
> CC: Coly Li <colyli@suse.de
> CC: Kent Overstreet <kent.overstreet@gmail.com>
> Signed-off-by: Jan Kara <jack@suse.cz>


Acked-by: Coly Li <colyli@suse.de <mailto:colyli@suse.de>>

Thanks.


Coly Li


> ---
> drivers/md/bcache/bcache.h |  2 +
> drivers/md/bcache/super.c  | 79 ++++++++++++++++++++------------------
> 2 files changed, 44 insertions(+), 37 deletions(-)
>=20
> diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
> index 5a79bb3c272f..2aa3f2c1f719 100644
> --- a/drivers/md/bcache/bcache.h
> +++ b/drivers/md/bcache/bcache.h
> @@ -299,6 +299,7 @@ struct cached_dev {
> struct list_head list;
> struct bcache_device disk;
> struct block_device *bdev;
> + struct bdev_handle *bdev_handle;
>=20
> struct cache_sb sb;
> struct cache_sb_disk *sb_disk;
> @@ -421,6 +422,7 @@ struct cache {
>=20
> struct kobject kobj;
> struct block_device *bdev;
> + struct bdev_handle *bdev_handle;
>=20
> struct task_struct *alloc_thread;
>=20
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index 0ae2b3676293..2b3f35fd7477 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -1368,8 +1368,8 @@ static void cached_dev_free(struct closure *cl)
> if (dc->sb_disk)
> put_page(virt_to_page(dc->sb_disk));
>=20
> - if (!IS_ERR_OR_NULL(dc->bdev))
> - blkdev_put(dc->bdev, dc);
> + if (dc->bdev_handle)
> + blkdev_handle_put(dc->bdev_handle);
>=20
> wake_up(&unregister_wait);
>=20
> @@ -1444,7 +1444,7 @@ static int cached_dev_init(struct cached_dev =
*dc, unsigned int block_size)
> /* Cached device - bcache superblock */
>=20
> static int register_bdev(struct cache_sb *sb, struct cache_sb_disk =
*sb_disk,
> - struct block_device *bdev,
> + struct bdev_handle *bdev_handle,
> struct cached_dev *dc)
> {
> const char *err =3D "cannot allocate memory";
> @@ -1452,14 +1452,15 @@ static int register_bdev(struct cache_sb *sb, =
struct cache_sb_disk *sb_disk,
> int ret =3D -ENOMEM;
>=20
> memcpy(&dc->sb, sb, sizeof(struct cache_sb));
> - dc->bdev =3D bdev;
> + dc->bdev_handle =3D bdev_handle;
> + dc->bdev =3D bdev_handle->bdev;
> dc->sb_disk =3D sb_disk;
>=20
> if (cached_dev_init(dc, sb->block_size << 9))
> goto err;
>=20
> err =3D "error creating kobject";
> - if (kobject_add(&dc->disk.kobj, bdev_kobj(bdev), "bcache"))
> + if (kobject_add(&dc->disk.kobj, bdev_kobj(dc->bdev), "bcache"))
> goto err;
> if (bch_cache_accounting_add_kobjs(&dc->accounting, &dc->disk.kobj))
> goto err;
> @@ -2216,8 +2217,8 @@ void bch_cache_release(struct kobject *kobj)
> if (ca->sb_disk)
> put_page(virt_to_page(ca->sb_disk));
>=20
> - if (!IS_ERR_OR_NULL(ca->bdev))
> - blkdev_put(ca->bdev, ca);
> + if (ca->bdev_handle)
> + blkdev_handle_put(ca->bdev_handle);
>=20
> kfree(ca);
> module_put(THIS_MODULE);
> @@ -2337,16 +2338,18 @@ static int cache_alloc(struct cache *ca)
> }
>=20
> static int register_cache(struct cache_sb *sb, struct cache_sb_disk =
*sb_disk,
> - struct block_device *bdev, struct cache *ca)
> + struct bdev_handle *bdev_handle,
> + struct cache *ca)
> {
> const char *err =3D NULL; /* must be set for any error case */
> int ret =3D 0;
>=20
> memcpy(&ca->sb, sb, sizeof(struct cache_sb));
> - ca->bdev =3D bdev;
> + ca->bdev_handle =3D bdev_handle;
> + ca->bdev =3D bdev_handle->bdev;
> ca->sb_disk =3D sb_disk;
>=20
> - if (bdev_max_discard_sectors((bdev)))
> + if (bdev_max_discard_sectors((bdev_handle->bdev)))
> ca->discard =3D CACHE_DISCARD(&ca->sb);
>=20
> ret =3D cache_alloc(ca);
> @@ -2354,10 +2357,10 @@ static int register_cache(struct cache_sb *sb, =
struct cache_sb_disk *sb_disk,
> /*
> * If we failed here, it means ca->kobj is not initialized yet,
> * kobject_put() won't be called and there is no chance to
> - * call blkdev_put() to bdev in bch_cache_release(). So we
> - * explicitly call blkdev_put() here.
> + * call blkdev_handle_put() to bdev in bch_cache_release(). So
> + * we explicitly call blkdev_handle_put() here.
> */
> - blkdev_put(bdev, ca);
> + blkdev_handle_put(bdev_handle);
> if (ret =3D=3D -ENOMEM)
> err =3D "cache_alloc(): -ENOMEM";
> else if (ret =3D=3D -EPERM)
> @@ -2367,7 +2370,7 @@ static int register_cache(struct cache_sb *sb, =
struct cache_sb_disk *sb_disk,
> goto err;
> }
>=20
> - if (kobject_add(&ca->kobj, bdev_kobj(bdev), "bcache")) {
> + if (kobject_add(&ca->kobj, bdev_kobj(bdev_handle->bdev), "bcache")) =
{
> err =3D "error calling kobject_add";
> ret =3D -ENOMEM;
> goto out;
> @@ -2382,14 +2385,14 @@ static int register_cache(struct cache_sb *sb, =
struct cache_sb_disk *sb_disk,
> goto out;
> }
>=20
> - pr_info("registered cache device %pg\n", ca->bdev);
> + pr_info("registered cache device %pg\n", ca->bdev_handle->bdev);
>=20
> out:
> kobject_put(&ca->kobj);
>=20
> err:
> if (err)
> - pr_notice("error %pg: %s\n", ca->bdev, err);
> + pr_notice("error %pg: %s\n", ca->bdev_handle->bdev, err);
>=20
> return ret;
> }
> @@ -2445,7 +2448,7 @@ struct async_reg_args {
> char *path;
> struct cache_sb *sb;
> struct cache_sb_disk *sb_disk;
> - struct block_device *bdev;
> + struct bdev_handle *bdev_handle;
> void *holder;
> };
>=20
> @@ -2456,8 +2459,8 @@ static void register_bdev_worker(struct =
work_struct *work)
> container_of(work, struct async_reg_args, reg_work.work);
>=20
> mutex_lock(&bch_register_lock);
> - if (register_bdev(args->sb, args->sb_disk, args->bdev, args->holder)
> -    < 0)
> + if (register_bdev(args->sb, args->sb_disk, args->bdev_handle,
> +  args->holder) < 0)
> fail =3D true;
> mutex_unlock(&bch_register_lock);
>=20
> @@ -2477,7 +2480,8 @@ static void register_cache_worker(struct =
work_struct *work)
> container_of(work, struct async_reg_args, reg_work.work);
>=20
> /* blkdev_put() will be called in bch_cache_release() */
> - if (register_cache(args->sb, args->sb_disk, args->bdev, =
args->holder))
> + if (register_cache(args->sb, args->sb_disk, args->bdev_handle,
> +   args->holder))
> fail =3D true;
>=20
> if (fail)
> @@ -2514,7 +2518,7 @@ static ssize_t register_bcache(struct kobject =
*k, struct kobj_attribute *attr,
> char *path =3D NULL;
> struct cache_sb *sb;
> struct cache_sb_disk *sb_disk;
> - struct block_device *bdev, *bdev2;
> + struct bdev_handle *bdev_handle, *bdev_handle2;
> void *holder =3D NULL;
> ssize_t ret;
> bool async_registration =3D false;
> @@ -2547,15 +2551,16 @@ static ssize_t register_bcache(struct kobject =
*k, struct kobj_attribute *attr,
>=20
> ret =3D -EINVAL;
> err =3D "failed to open device";
> - bdev =3D blkdev_get_by_path(strim(path), BLK_OPEN_READ, NULL, NULL);
> - if (IS_ERR(bdev))
> + bdev_handle =3D blkdev_get_handle_by_path(strim(path), =
BLK_OPEN_READ,
> + NULL, NULL);
> + if (IS_ERR(bdev_handle))
> goto out_free_sb;
>=20
> err =3D "failed to set blocksize";
> - if (set_blocksize(bdev, 4096))
> + if (set_blocksize(bdev_handle->bdev, 4096))
> goto out_blkdev_put;
>=20
> - err =3D read_super(sb, bdev, &sb_disk);
> + err =3D read_super(sb, bdev_handle->bdev, &sb_disk);
> if (err)
> goto out_blkdev_put;
>=20
> @@ -2567,13 +2572,13 @@ static ssize_t register_bcache(struct kobject =
*k, struct kobj_attribute *attr,
> }
>=20
> /* Now reopen in exclusive mode with proper holder */
> - bdev2 =3D blkdev_get_by_dev(bdev->bd_dev, BLK_OPEN_READ | =
BLK_OPEN_WRITE,
> -  holder, NULL);
> - blkdev_put(bdev, NULL);
> - bdev =3D bdev2;
> - if (IS_ERR(bdev)) {
> - ret =3D PTR_ERR(bdev);
> - bdev =3D NULL;
> + bdev_handle2 =3D blkdev_get_handle_by_dev(bdev_handle->bdev->bd_dev,
> + BLK_OPEN_READ | BLK_OPEN_WRITE, holder, NULL);
> + blkdev_handle_put(bdev_handle);
> + bdev_handle =3D bdev_handle2;
> + if (IS_ERR(bdev_handle)) {
> + ret =3D PTR_ERR(bdev_handle);
> + bdev_handle =3D NULL;
> if (ret =3D=3D -EBUSY) {
> dev_t dev;
>=20
> @@ -2608,7 +2613,7 @@ static ssize_t register_bcache(struct kobject =
*k, struct kobj_attribute *attr,
> args->path =3D path;
> args->sb =3D sb;
> args->sb_disk =3D sb_disk;
> - args->bdev =3D bdev;
> + args->bdev_handle =3D bdev_handle;
> args->holder =3D holder;
> register_device_async(args);
> /* No wait and returns to user space */
> @@ -2617,14 +2622,14 @@ static ssize_t register_bcache(struct kobject =
*k, struct kobj_attribute *attr,
>=20
> if (SB_IS_BDEV(sb)) {
> mutex_lock(&bch_register_lock);
> - ret =3D register_bdev(sb, sb_disk, bdev, holder);
> + ret =3D register_bdev(sb, sb_disk, bdev_handle, holder);
> mutex_unlock(&bch_register_lock);
> /* blkdev_put() will be called in cached_dev_free() */
> if (ret < 0)
> goto out_free_sb;
> } else {
> /* blkdev_put() will be called in bch_cache_release() */
> - ret =3D register_cache(sb, sb_disk, bdev, holder);
> + ret =3D register_cache(sb, sb_disk, bdev_handle, holder);
> if (ret)
> goto out_free_sb;
> }
> @@ -2640,8 +2645,8 @@ static ssize_t register_bcache(struct kobject =
*k, struct kobj_attribute *attr,
> out_put_sb_page:
> put_page(virt_to_page(sb_disk));
> out_blkdev_put:
> - if (bdev)
> - blkdev_put(bdev, holder);
> + if (bdev_handle)
> + blkdev_handle_put(bdev_handle);
> out_free_sb:
> kfree(sb);
> out_free_path:
> --=20
> 2.35.3
>=20

