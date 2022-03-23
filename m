Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A73B4E4A7A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 02:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbiCWBaO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 21:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbiCWBaN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 21:30:13 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550E333E3D;
        Tue, 22 Mar 2022 18:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647998918;
        bh=BacUzfzBf7e5yOac9Eib1Pye4apR1aZl9W7xr+kd5bg=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=DXWi25mUOhJJzCuvf3G/OtSuPXcNr6YvyYYT+zVMrWe0g/9rxt+fZA/N0s4guEgk9
         DCNY8EGOIQSYbmg30pQk3psXZgX9b6Bd/Gr2yxiNtWwe97DJEFzTE7X3FI5H/CqGkH
         PGECERhm25xsbyLGs+3NCTkyh3g+agx7k+RhCKtk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MAfYw-1nLoFx1edU-00B0vt; Wed, 23
 Mar 2022 02:28:38 +0100
Message-ID: <7d24309f-6851-da18-efab-36eb4b65e130@gmx.com>
Date:   Wed, 23 Mar 2022 09:28:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 39/40] btrfs: pass private data end end_io handler to
 btrfs_repair_one_sector
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20220322155606.1267165-1-hch@lst.de>
 <20220322155606.1267165-40-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220322155606.1267165-40-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T+oYpreXt3NHe3JYZjG77uJreb9k3xaGHTdgSm+cFRpMY1dc5tO
 HEU3qC+BrJF6udYUDqcnvvUf98eBPiueMk5YGaLKKJgdXv/5WvwsW2EnW3xvO93086PobXy
 c9nB6JgkRMH+wqF5AJlvLgZmqd4ZdXcVugt7Wp3kHmOP1i468005rsTaRQnfvUy7Fq+rgSy
 WEN4nHs5blUVx5shBgNUw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YQFBpcmw34E=:M3FNntCgTg0YxwNv08/O6T
 pd4BP99kimQQCYHyrbU2pP+Sh6308jKc7dBn7t/aYZqQ53p5tePM2g6OS7luNYmrDYq6Z88bK
 Xd4XWl5/NWwhGQIgRiiGxsm5w+39sdxWS5EtFmYOtWYI7LApPcefj4zFSXwLGWJlgi3xl5dJh
 TlzlveObe1B0VcNjwb3THFYBW8uKXKE5qKpaKSpLB1J9LgRgBPYubOalaz9da051QAO25MLBD
 mbbbRBmMurHe4/zLrYqknE2duzGHCoJ/NGjucgqzcbh7PgMmaZ3ZQHsc7VuNGSYaP7Fq4HhkF
 HRDPh5tGPuDWqqK1Y65RCkDQIXDYttIOD0m375dHN6yEpNrEQ3CeJxcm0hK/OmBFEXbhkWWaG
 HvkDNEDMXA6wHAfV61MNmihBBsDYpcwQT+P3lNsxlUBf39H/EcYtijEKdze1hlD6YXN0LPeW3
 bmXubb8ignPWJWuMJ8SlwFPVUf2gnaXOvLJ7qFFoLi+QAh+strrwXXi0N1/uJskUw8SvgMERU
 kefnsX7gk+X8aYZQKTpgYIlVMLdyGCa9z6k/9MmOyFJJz3K6uipy7PadzNQQKatyBhuzWuHdr
 30Bb/pfw39IekOwBhlSt1U6MXN3+BCKxhT+2sKdGhvI4w+zQ+dkyr02PqxYrr6DPxbKcAFVIf
 8xRQ9xLgMAy8f7hwpffai8+qhAwG7xGD2tOg0UKmbF7fhj7EKBKrKOfOS/JYTsrwtw4bJaKsk
 R6OWg84DANTw6p7fsnA90DslKkBF4ucPItNgpUaGnJArhY80FTljySrKA1Ldoo6TrvK1iBFCg
 7coO42bVCS2TUpphkr1y3X7LjkoUiUB2szSdHI7TEUTkrFf7NnEGCE3iGv3mdchGao2l7sCLg
 eesqw/FKJzxMg1DlZLm/VGUFtMOD23fdDEv8soG6b0yHMdFAtbjYbRmg852f7ZTr/JMKL9M4L
 yRKHd465vgYQsMs6DJS9tbaF2c9uZ8++QT1nVxPDogIZKWj67HSehzEAxo85CC5etDzDJkv7S
 GhzdMe4yicaeGPiM/O3U88/aq0eg8wTX41WD3wOqe1BLop2ni8za7LFsmgSIVd769pW9U/8Rk
 DxaKIX4Hri7q9g=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2022/3/22 23:56, Christoph Hellwig wrote:
> Allow the caller to control what happens when the repair bio completes.
> This will be needed streamline the direct I/O path.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/extent_io.c | 15 ++++++++-------
>   fs/btrfs/extent_io.h |  8 ++++----
>   fs/btrfs/inode.c     |  4 +++-
>   3 files changed, 15 insertions(+), 12 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 2fdb5d7dd51e1..5a1447db28228 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2627,10 +2627,10 @@ static bool btrfs_check_repairable(struct inode =
*inode,
>   }
>
>   blk_status_t btrfs_repair_one_sector(struct inode *inode,
> -			    struct bio *failed_bio, u32 bio_offset,
> -			    struct page *page, unsigned int pgoff,
> -			    u64 start, int failed_mirror,
> -			    submit_bio_hook_t *submit_bio_hook)
> +		struct bio *failed_bio, u32 bio_offset, struct page *page,
> +		unsigned int pgoff, u64 start, int failed_mirror,
> +		submit_bio_hook_t *submit_bio_hook,
> +		void *bi_private, void (*bi_end_io)(struct bio *bio))

Not a big fan of extra parameters for a function which already had enough.=
..

And I always have a question on repair (aka read from extra copy).

Can't we just make the repair part to be synchronous?
Instead of putting everything into another endio call back, and wait for
the read and re-check in the same context.

That would definitely streamline the workload way more than this.

And I don't think users would complain about btrfs is slow on reading
when correcting the corrupted data.

Thanks,
Qu
>   {
>   	struct io_failure_record *failrec;
>   	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
> @@ -2660,9 +2660,9 @@ blk_status_t btrfs_repair_one_sector(struct inode =
*inode,
>   	repair_bio =3D btrfs_bio_alloc(inode, 1, REQ_OP_READ);
>   	repair_bbio =3D btrfs_bio(repair_bio);
>   	repair_bbio->file_offset =3D start;
> -	repair_bio->bi_end_io =3D failed_bio->bi_end_io;
>   	repair_bio->bi_iter.bi_sector =3D failrec->logical >> 9;
> -	repair_bio->bi_private =3D failed_bio->bi_private;
> +	repair_bio->bi_private =3D bi_private;
> +	repair_bio->bi_end_io =3D bi_end_io;
>
>   	if (failed_bbio->csum) {
>   		const u32 csum_size =3D fs_info->csum_size;
> @@ -2758,7 +2758,8 @@ static blk_status_t submit_read_repair(struct inod=
e *inode,
>   		ret =3D btrfs_repair_one_sector(inode, failed_bio,
>   				bio_offset + offset,
>   				page, pgoff + offset, start + offset,
> -				failed_mirror, btrfs_submit_data_bio);
> +				failed_mirror, btrfs_submit_data_bio,
> +				failed_bio->bi_private, failed_bio->bi_end_io);
>   		if (!ret) {
>   			/*
>   			 * We have submitted the read repair, the page release
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index 0239b26d5170a..54e54269cfdba 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -304,10 +304,10 @@ struct io_failure_record {
>   };
>
>   blk_status_t btrfs_repair_one_sector(struct inode *inode,
> -			    struct bio *failed_bio, u32 bio_offset,
> -			    struct page *page, unsigned int pgoff,
> -			    u64 start, int failed_mirror,
> -			    submit_bio_hook_t *submit_bio_hook);
> +		struct bio *failed_bio, u32 bio_offset, struct page *page,
> +		unsigned int pgoff, u64 start, int failed_mirror,
> +		submit_bio_hook_t *submit_bio_hook,
> +		void *bi_private, void (*bi_end_io)(struct bio *bio));
>
>   #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
>   bool find_lock_delalloc_range(struct inode *inode,
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 93b3ef48cea2f..e25d9d860c679 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -7799,7 +7799,9 @@ static blk_status_t btrfs_check_read_dio_bio(struc=
t btrfs_dio_private *dip,
>   				ret =3D btrfs_repair_one_sector(inode, &bbio->bio,
>   						bio_offset, bvec.bv_page, pgoff,
>   						start, bbio->mirror_num,
> -						submit_dio_repair_bio);
> +						submit_dio_repair_bio,
> +						bbio->bio.bi_private,
> +						bbio->bio.bi_end_io);
>   				if (ret)
>   					err =3D ret;
>   			}
