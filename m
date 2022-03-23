Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39734E49E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 01:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240831AbiCWAFp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 20:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiCWAFo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 20:05:44 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD1B5DE5A;
        Tue, 22 Mar 2022 17:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647993847;
        bh=0yxjAeOJUxPaChfZdFnQMQePqTfKiuPi9ApmStNanz0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=OJsnfMIz9vTVjigiY0Noe+U/F0pnnwggcXFuob4vfkcRg6mRKBRgflZNxhXbj5GL+
         41+k8CVILQKORycK2eYxvrrQP3t+RqZZqWtFapzi6hKM8bjgTpvPqhxVEiFsyAnXfW
         mcuIQJPFJN3p+FnbJIAFiCWNQKnuOgQ9Psddabyw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N6bfw-1o8p2046T0-0183gV; Wed, 23
 Mar 2022 01:04:07 +0100
Message-ID: <029c8738-52e4-c39c-87ce-67fe286b5a56@gmx.com>
Date:   Wed, 23 Mar 2022 08:04:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 06/40] btrfs: split submit_bio from btrfsic checking
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20220322155606.1267165-1-hch@lst.de>
 <20220322155606.1267165-7-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220322155606.1267165-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:D5OfV9QEenvO6/a2pARbrsSwcYcnxGbr3wKyIb7xytfxe0ndMoH
 JbtKDybEtATmoLsmbjp+e4g0kLVSItLo3ng6aDUUg5Jpn4qtXgYqVMi6oc1F76c1m8SdENB
 aTfc+pkx+ecJeyBhjHtCi5I8j4Nogldd9uiUGXkhTjPzJbnGXRe0zu9PYius+Fc/1qw2RMG
 ECUPnaN4a1D6iA2DEzmgA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UN6WocYM4L8=:NFkDaE2vyD2O9N0lPgZHId
 lgsMWdmevAmX3vntoC0woR6w8ZAOwbtjTVff4w13QNwymj5zUwju9ccMSxOc+EVbUUeVNq6Oc
 FJsoKzp1jKV5Te+ieMtd9CFFfU3Z5DjYYhaqsCTdONNcYuqEb8ULOh7tZpEs7maZRsM+Hi0ic
 4JMblLqE2igj9PkgK/Pk3JT+0MdUf8Vu/b2us9wZAPW6bXoK6gnjRXuHkotNLZMYZTEc2wJpV
 rThwKx0LHT2RUC9fv/wA61hSrD/YwGwpWdcCvxmOzAiPaza1EVGmS4af88I6Lm+ZwCfejOSq2
 xV1GwZiM8hcBqnpU0U8ciSL9XcN0IB9nyGxhyIIHYKL+WI9L/9NnFMFjzKPJ2FpahoL+k4+P6
 q8l+1uBBnK31qwrgaWIb/MRmHlGTeHoPSK2RX8OyVtgH89ie14xQ5zobSfCnEI766qL+2u0Oo
 LNMg6KB9YF25dTxPbNWocv2vcEWdoUZ8aE4Oc5Vl3cKsZ0CI4zNjsZtjZiYVnz1ng7O9feg66
 0jVrWVl5LoT7uT/OXD20TrVhQ/j7TA103toHFehgO4leESyzXXyRqL2P4PjFpFbodeEnj3rJY
 +kZrKzn4sPTTubHJHuE791sQ/+gBycsyBP9w4loNjCm+Le3C1pSZeoYiTcJv1G5P4enIY1yEU
 QMlXXRRXZ+hBW3fXLPlBDu3xGu/wSM7ZcpvEEDyxtNIlwPEL3y80PrZRE3Qh6EdL2YV1lQzbY
 kZiA0VMnIImeWM3IIHnVKWwZBTlbR78RRKsZCaYavrpF3Lf69A4SfHwleV+fNG1B6vbdIoMef
 Zm6jWdBoAnsSxZHnMHkMQ1ua20jzc7IrpBVwaCt3hO8hy3yOfVbVCd6OuSVPOs2kUWfx8Cqvn
 EnXdrEkQyyx0eRUhSpaYQPIjMXyfapZwuWSvuE0N/FFcBS0eDfu8I5MuGp/mdZVuUWF4KcZAf
 bjmxGg/UuA56Jfx6bdjSL/WScQti5GI5NEihC6+RcxMO5gpgBZN5/Y6Oc6cYOAa6cz/DSIfP8
 HVBbkWK34GTpP2m888a85033urcpmgrdsYW/YyokdgL+bCUGXsBWXg38J/HNTDrctL10/psCE
 2oQB8upf4gazjU=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2022/3/22 23:55, Christoph Hellwig wrote:
> Require a separate call to the integrity checking helpers from the
> actual bio submission.

All-in for this!

I can't remember how many times I feel embarrassed when the bio
submission is done inside a function which by its name should only do
sanity checks.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/check-integrity.c | 14 +-------------
>   fs/btrfs/check-integrity.h |  8 ++++----
>   fs/btrfs/disk-io.c         |  6 ++++--
>   fs/btrfs/extent_io.c       |  3 ++-
>   fs/btrfs/scrub.c           | 12 ++++++++----
>   fs/btrfs/volumes.c         |  3 ++-
>   6 files changed, 21 insertions(+), 25 deletions(-)
>
> diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
> index 9efc1feb6cb08..49f9954f1438f 100644
> --- a/fs/btrfs/check-integrity.c
> +++ b/fs/btrfs/check-integrity.c
> @@ -2703,7 +2703,7 @@ static void btrfsic_check_flush_bio(struct bio *bi=
o,
>   	}
>   }
>
> -static void __btrfsic_submit_bio(struct bio *bio)
> +void btrfsic_check_bio(struct bio *bio)
>   {
>   	struct btrfsic_dev_state *dev_state;
>
> @@ -2725,18 +2725,6 @@ static void __btrfsic_submit_bio(struct bio *bio)
>   	mutex_unlock(&btrfsic_mutex);
>   }
>
> -void btrfsic_submit_bio(struct bio *bio)
> -{
> -	__btrfsic_submit_bio(bio);
> -	submit_bio(bio);
> -}
> -
> -int btrfsic_submit_bio_wait(struct bio *bio)
> -{
> -	__btrfsic_submit_bio(bio);
> -	return submit_bio_wait(bio);
> -}
> -
>   int btrfsic_mount(struct btrfs_fs_info *fs_info,
>   		  struct btrfs_fs_devices *fs_devices,
>   		  int including_extent_data, u32 print_mask)
> diff --git a/fs/btrfs/check-integrity.h b/fs/btrfs/check-integrity.h
> index bcc730a06cb58..ed115e0f2ebbd 100644
> --- a/fs/btrfs/check-integrity.h
> +++ b/fs/btrfs/check-integrity.h
> @@ -7,11 +7,11 @@
>   #define BTRFS_CHECK_INTEGRITY_H
>
>   #ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
> -void btrfsic_submit_bio(struct bio *bio);
> -int btrfsic_submit_bio_wait(struct bio *bio);
> +void btrfsic_check_bio(struct bio *bio);
>   #else
> -#define btrfsic_submit_bio submit_bio
> -#define btrfsic_submit_bio_wait submit_bio_wait
> +static inline void btrfsic_check_bio(struct bio *bio)
> +{
> +}
>   #endif
>
>   int btrfsic_mount(struct btrfs_fs_info *fs_info,
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index c245e1b131964..9b8ee74144910 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -4048,7 +4048,8 @@ static int write_dev_supers(struct btrfs_device *d=
evice,
>   		if (i =3D=3D 0 && !btrfs_test_opt(device->fs_info, NOBARRIER))
>   			bio->bi_opf |=3D REQ_FUA;
>
> -		btrfsic_submit_bio(bio);
> +		btrfsic_check_bio(bio);
> +		submit_bio(bio);
>
>   		if (btrfs_advance_sb_log(device, i))
>   			errors++;
> @@ -4161,7 +4162,8 @@ static void write_dev_flush(struct btrfs_device *d=
evice)
>   	init_completion(&device->flush_wait);
>   	bio->bi_private =3D &device->flush_wait;
>
> -	btrfsic_submit_bio(bio);
> +	btrfsic_check_bio(bio);
> +	submit_bio(bio);
>   	set_bit(BTRFS_DEV_STATE_FLUSH_SENT, &device->dev_state);
>   }
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index e789676373ab0..1a39b9ffdd180 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2370,7 +2370,8 @@ static int repair_io_failure(struct btrfs_fs_info =
*fs_info, u64 ino, u64 start,
>   	bio->bi_opf =3D REQ_OP_WRITE | REQ_SYNC;
>   	bio_add_page(bio, page, length, pg_offset);
>
> -	if (btrfsic_submit_bio_wait(bio)) {
> +	btrfsic_check_bio(bio);
> +	if (submit_bio_wait(bio)) {
>   		/* try to remap that extent elsewhere? */
>   		btrfs_bio_counter_dec(fs_info);
>   		bio_put(bio);
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 2e9a322773f28..605ecc675ba7c 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -1479,7 +1479,8 @@ static void scrub_recheck_block(struct btrfs_fs_in=
fo *fs_info,
>   		bio->bi_iter.bi_sector =3D spage->physical >> 9;
>   		bio->bi_opf =3D REQ_OP_READ;
>
> -		if (btrfsic_submit_bio_wait(bio)) {
> +		btrfsic_check_bio(bio);
> +		if (submit_bio_wait(bio)) {
>   			spage->io_error =3D 1;
>   			sblock->no_io_error_seen =3D 0;
>   		}
> @@ -1565,7 +1566,8 @@ static int scrub_repair_page_from_good_copy(struct=
 scrub_block *sblock_bad,
>   			return -EIO;
>   		}
>
> -		if (btrfsic_submit_bio_wait(bio)) {
> +		btrfsic_check_bio(bio);
> +		if (submit_bio_wait(bio)) {
>   			btrfs_dev_stat_inc_and_print(spage_bad->dev,
>   				BTRFS_DEV_STAT_WRITE_ERRS);
>   			atomic64_inc(&fs_info->dev_replace.num_write_errors);
> @@ -1723,7 +1725,8 @@ static void scrub_wr_submit(struct scrub_ctx *sctx=
)
>   	 * orders the requests before sending them to the driver which
>   	 * doubled the write performance on spinning disks when measured
>   	 * with Linux 3.5 */
> -	btrfsic_submit_bio(sbio->bio);
> +	btrfsic_check_bio(sbio->bio);
> +	submit_bio(sbio->bio);
>
>   	if (btrfs_is_zoned(sctx->fs_info))
>   		sctx->write_pointer =3D sbio->physical + sbio->page_count *
> @@ -2057,7 +2060,8 @@ static void scrub_submit(struct scrub_ctx *sctx)
>   	sbio =3D sctx->bios[sctx->curr];
>   	sctx->curr =3D -1;
>   	scrub_pending_bio_inc(sctx);
> -	btrfsic_submit_bio(sbio->bio);
> +	btrfsic_check_bio(sbio->bio);
> +	submit_bio(sbio->bio);
>   }
>
>   static int scrub_add_page_to_rd_bio(struct scrub_ctx *sctx,
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index b07d382d53a86..bfa8e825e5047 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6755,7 +6755,8 @@ static void submit_stripe_bio(struct btrfs_io_cont=
ext *bioc, struct bio *bio,
>
>   	btrfs_bio_counter_inc_noblocked(fs_info);
>
> -	btrfsic_submit_bio(bio);
> +	btrfsic_check_bio(bio);
> +	submit_bio(bio);
>   }
>
>   static void bioc_error(struct btrfs_io_context *bioc, struct bio *bio,=
 u64 logical)
