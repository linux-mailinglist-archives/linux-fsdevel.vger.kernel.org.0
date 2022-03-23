Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736554E49DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 01:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240822AbiCWACa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 20:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiCWACa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 20:02:30 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9C51FA65;
        Tue, 22 Mar 2022 17:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647993653;
        bh=jReiL1ambKA9tFk04wQO1niA1igxUaK8c5hqq5yCVHw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=E0G2GGrqkT4lThJ1tIBTc9QAUfF6UtZpFpoP4AyaB1U8GNmqTB2duZ0H2F2MYYh0l
         w3mrZ6zGeGJ3bD4ijUeAxiB7PCk4Y37dfDebTXQYlfTHZNGQ+50rW8u0OzzyxCDcIa
         QWkUKIHGAeCPDBe3az9h7A83zvODvyhXcPOl0A/c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1ML9yS-1nnn5K29wY-00IFzr; Wed, 23
 Mar 2022 01:00:53 +0100
Message-ID: <e7b7aed3-a231-3413-9500-5a98db72454a@gmx.com>
Date:   Wed, 23 Mar 2022 08:00:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 03/40] btrfs: fix direct I/O writes for split bios on
 zoned devices
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20220322155606.1267165-1-hch@lst.de>
 <20220322155606.1267165-4-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220322155606.1267165-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eV2ruAsClXmqiOmRecSfhG5OfMflT//jtvnrqIteKCz3kIrMGn/
 ZygrxZw7UK5fBAc06g53MxFmb4nXkucOswVcuqKe6kgcyKuEq74oGzbVXSzGLK/PHsGe4Bs
 OkFUeBhQ/H/alH+QvghSXvh819cxpa8pphDLVxO11BRRsvG9+pAaHpibw04uU9mm+gebjmc
 +lEymRWWwykWpuG05axBQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Fn7XU70/hJg=:EqBNS+G/kX/fDs4r5glwVu
 c+Hlati92yt2pNFRo3jPqt6sxl7JmF2qIS2ks/0D7QmUKLBjugxQEao0hfeLPtmWCQukjS0JA
 pRo39EIia5gur/2GH3C10xZoYFD6r6naqBL8qathk2OThd1KqK2dbbbIiu712Y8nO+nnVhvRz
 lcn1flDlfkZvS+trZsZBs6nUPna0670sJwqw/2neqXRA+UgA3/0wnwwlM7ilUhq03yq+o0ZGP
 rb9y944NWJBM0SU6AXMM5KLotMUM25JHqmX99QxOERH1GY5myIJhFG7a4ceoVrjL9iq/jMP9Q
 h2mI7Q5GU0Sd2F2TaY0KSmLzWBfQPE/JrCw+jhKr6riICUFaaihfTcu8j4iLdH0Ia24EPHJdv
 me1G3+uloeVIkebyWPuYWpovxOIiHoLUh5dx8dQez2/KqPpYATL7eh8KiPQhKtN2W5RbqPKjM
 5FBt8LaTqw8VmzTtwHHuwE8SLshhTKFhZlQIBmizXNWGTdnZ3G9m8tG0LjCpmUV2G5GItTtkh
 3DqyBOJ94ckvcyR51M+EAZ+kfalMKr21FpWAjAfA+lcKoA2ulmk6cVrt1HBGlcXnGbtg4xKm9
 VxZNzrjL+EDFMtFMr5t689De41mlpnFNbx5qYg+HR0eKF82wq1J/xt0fTQ/MAIdt6w6KC8gqD
 vaFoWF0iOKKDjTTO+IPivNyrWqldvjA/m1NxRc9KF/bULZlsiKd4eiUfZljecRJu/TWTWB+zp
 J2MPjO7vhh3u0qSC/baYl6ZS3hmLyf5cjwAmJO+3MsDrNQXLOLb1Xr64gLlleLta4ZrovFNpF
 zGQ3lPUR4CuDNFOPAGjwY4KEgqRZFUgW7d9NjukXrfU1aO5gZJdWTWKjng75Il79Vo34OJnhE
 c0xnM/irwe6RXE3wN9dZNwqb1PWXOj9S/cigDkpygW6JygPH1rCZAVsWD6PusCnO86gdKYNXh
 4OJEAZhX/uRp4kv/mrrgjMr5HAp5dIMYYDILe/nr9smW2ohJgWho39y+5c/gNuTpNOO0R8LpO
 13G2aTh/bNGNgRykF5JvvTWpoAtNVZHSY6Pl6Q4qXlq9op3oQzvLqplbFo/gyXzLFoq29XZdr
 iuk1lHZplIQw6U=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2022/3/22 23:55, Christoph Hellwig wrote:
> When a bio is split in btrfs_submit_direct, dip->file_offset contains
> the file offset for the first bio.  But this means the start value used
> in btrfs_end_dio_bio to record the write location for zone devices is
> icorrect for subsequent bios.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Maybe better to be folded with previous patch?

It looks good to me though.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/inode.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 93f00e9150ed0..325e773c6e880 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -7829,6 +7829,7 @@ static blk_status_t btrfs_submit_bio_start_direct_=
io(struct inode *inode,
>   static void btrfs_end_dio_bio(struct bio *bio)
>   {
>   	struct btrfs_dio_private *dip =3D bio->bi_private;
> +	struct btrfs_bio *bbio =3D btrfs_bio(bio);
>   	blk_status_t err =3D bio->bi_status;
>
>   	if (err)
> @@ -7839,12 +7840,12 @@ static void btrfs_end_dio_bio(struct bio *bio)
>   			   bio->bi_iter.bi_size, err);
>
>   	if (bio_op(bio) =3D=3D REQ_OP_READ)
> -		err =3D btrfs_check_read_dio_bio(dip, btrfs_bio(bio), !err);
> +		err =3D btrfs_check_read_dio_bio(dip, bbio, !err);
>
>   	if (err)
>   		dip->dio_bio->bi_status =3D err;
>
> -	btrfs_record_physical_zoned(dip->inode, dip->file_offset, bio);
> +	btrfs_record_physical_zoned(dip->inode, bbio->file_offset, bio);
>
>   	bio_put(bio);
>   	btrfs_dio_private_put(dip);
