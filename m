Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931A95A9276
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 10:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbiIAIz5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 04:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234263AbiIAIzr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:55:47 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0624C59FA;
        Thu,  1 Sep 2022 01:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662022529;
        bh=rwYCAO8yDRRur3j86dE5qwXiUPEMd2fozLv/nG8R3ig=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=FcDh2a6NYE8OwzmZYQQlzCeOxZbat96S2D9hTT9lV1alaTucjdXK00VH7T4o/oM5v
         3cTbQkT9aOpr3xKnQR3tLknWYCP76IC1Dr+1dLeA947tZCQa9inbiFmosCKz/pB8Gb
         LU2RXdoVyHEz07oBuTj7WCUTljXCkIvCmGWlMLxA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MatVb-1p62bj16d9-00cS8p; Thu, 01
 Sep 2022 10:55:28 +0200
Message-ID: <df2c493c-b2dd-a877-1d93-65cee86b6478@gmx.com>
Date:   Thu, 1 Sep 2022 16:55:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 02/17] btrfs: stop tracking failed reads in the I/O tree
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20220901074216.1849941-1-hch@lst.de>
 <20220901074216.1849941-3-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220901074216.1849941-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:roJw62nU23md/ThLWQdDEe7ZWAs/A5N7sDDS+SykOFgqa2eVBxs
 bBGL399CsEeobaq+mT/atseOHiBTO4yrC77KMVhKhK4yOl1iPChVWT96k/oJLVUnwTTlpjR
 jLUIswlvhH9JnXq+IMM8BcusKmC13gZy5T8gAC84HzISTXZ5uPB2n7k0jMWzLIwRTOT8tzt
 ZOa9XJ42RsFHzVJgNJj6w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Yj2cfIkDmC0=:os/vHxsoqylNvP5JPIuATN
 +CDM/cHKOYGevXB6I1ZBN3Lx04E2hIpzm0AdgAaNQasyLx69ZGgl3yMrsnrfEmoWMHngcdxLl
 g4BemH8yWaUDWA5/EW2TK3uWjTZDDDe1njhXwxANMvK7fhdXfPtnhmSkM8Yne+qR9vBW/GnAU
 jbh3PJYaykbHyj0NIio8kGTSOTzU/jIcWJQ1wm5B9ApJgu8/GJzV4Y8bYf2iDwqYDGfyP1ywl
 7F2VYBC4/VHtZxugXsRchpj0Qz/VBa51YX9K81Cj3a0xQp9/PBzdto4zpw5Hd4NiF7p2qoU1H
 Tu0ZIE6HwLdEHEvHHaUuzqfXCjjRnNzrZFYKYqy+4uXvOkTfsEiE59tDeC7C/u4NCkafsGVO/
 T0YZxW9mj3CYolMiKkSU3PxDZCoF819KV9ugPL23ppG19kJgDiYyJMwgalMRHNvYqyzQgb/Ac
 Y3VFLlX1yTzRrwy/QLOg3wgKYFeEyNbNMKSH+bMghM+3h3o0m0Lswo41q0W4H9a2RAZEp48e6
 s5gU/7xLoPyHY9RuFqqQkcZJAbTa/gGeTBRtIHEeKi9d0C9xvLIjJZ/qij7wyt0jSxiPumEMq
 XtQ9a1Tf9WXkWo9lu0x/t+mDw1uh3XKcRcej77z7nlSjGar9CFcWbsF9Oz+BwLYMS/Bh2GYe+
 3Y11VZMs02LkVWD0ipVHVDVLb7qXgxGGMjoaAzuR5weaJoFIs9PMLKAwysELjMJbQK2q0jLIh
 YT7G0Ow2tzinGQgeIyhjYdqCbnUDn5wPUn+oPadBZYd44gC3VNHAa+vr264nXphEp+4eCdvVh
 kY/To/5GZnB+JeB8MpKLYTltHYrY8pvzY5EpSdHWMaulsWplHxf9sxse0gIk2X1bc7DDXPE29
 Cx5V7Ao0gTY2yCGOgP1skojM8AUl1sLYVqUVYsA0HanYo0lrICCqk30bVuweJjDGLdVRJWVYl
 4IXXd+tJmM7xiTapekgHhQbPgNmRiMOcUWTiDpj8sLFgt8TPnCMUe+5f39xYZVAN/r9SRa6gY
 tr1/gCQKqZ1DD8FG/TfHmFx/pHLkhmKH+mqy4X24ARogAptwJC4mqS1XFV38g5N6poVhWA/IJ
 VzJyOhGOC7exFmVy3z9KLi6mtUJb0ookhxCU2W5t0GQZ7HJZDPb/8Lge42w05inPeWOeo9y9R
 k5fYNPH6EQSpmNr1eyZpUe11nL
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2022/9/1 15:42, Christoph Hellwig wrote:
> There is a separate I/O failure tree to track the fail reads, so remove
> the extra EXTENT_DAMAGED bit in the I/O tree.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Reducing extent flags is already a good thing.

Thanks,
Qu
> ---
>   fs/btrfs/extent-io-tree.h        |  1 -
>   fs/btrfs/extent_io.c             | 16 +---------------
>   fs/btrfs/tests/extent-io-tests.c |  1 -
>   include/trace/events/btrfs.h     |  1 -
>   4 files changed, 1 insertion(+), 18 deletions(-)
>
> diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
> index ec2f8b8e6faa7..e218bb56d86ac 100644
> --- a/fs/btrfs/extent-io-tree.h
> +++ b/fs/btrfs/extent-io-tree.h
> @@ -17,7 +17,6 @@ struct io_failure_record;
>   #define EXTENT_NODATASUM	(1U << 7)
>   #define EXTENT_CLEAR_META_RESV	(1U << 8)
>   #define EXTENT_NEED_WAIT	(1U << 9)
> -#define EXTENT_DAMAGED		(1U << 10)
>   #define EXTENT_NORESERVE	(1U << 11)
>   #define EXTENT_QGROUP_RESERVED	(1U << 12)
>   #define EXTENT_CLEAR_DATA_RESV	(1U << 13)
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 591c191a58bc9..6ac76534d2c9e 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2280,23 +2280,13 @@ int free_io_failure(struct extent_io_tree *failu=
re_tree,
>   		    struct io_failure_record *rec)
>   {
>   	int ret;
> -	int err =3D 0;
>
>   	set_state_failrec(failure_tree, rec->start, NULL);
>   	ret =3D clear_extent_bits(failure_tree, rec->start,
>   				rec->start + rec->len - 1,
>   				EXTENT_LOCKED | EXTENT_DIRTY);
> -	if (ret)
> -		err =3D ret;
> -
> -	ret =3D clear_extent_bits(io_tree, rec->start,
> -				rec->start + rec->len - 1,
> -				EXTENT_DAMAGED);
> -	if (ret && !err)
> -		err =3D ret;
> -
>   	kfree(rec);
> -	return err;
> +	return ret;
>   }
>
>   /*
> @@ -2521,7 +2511,6 @@ static struct io_failure_record *btrfs_get_io_fail=
ure_record(struct inode *inode
>   	u64 start =3D bbio->file_offset + bio_offset;
>   	struct io_failure_record *failrec;
>   	struct extent_io_tree *failure_tree =3D &BTRFS_I(inode)->io_failure_t=
ree;
> -	struct extent_io_tree *tree =3D &BTRFS_I(inode)->io_tree;
>   	const u32 sectorsize =3D fs_info->sectorsize;
>   	int ret;
>
> @@ -2573,9 +2562,6 @@ static struct io_failure_record *btrfs_get_io_fail=
ure_record(struct inode *inode
>   			      EXTENT_LOCKED | EXTENT_DIRTY);
>   	if (ret >=3D 0) {
>   		ret =3D set_state_failrec(failure_tree, start, failrec);
> -		/* Set the bits in the inode's tree */
> -		ret =3D set_extent_bits(tree, start, start + sectorsize - 1,
> -				      EXTENT_DAMAGED);
>   	} else if (ret < 0) {
>   		kfree(failrec);
>   		return ERR_PTR(ret);
> diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io=
-tests.c
> index a232b15b8021f..ba4b7601e8c0a 100644
> --- a/fs/btrfs/tests/extent-io-tests.c
> +++ b/fs/btrfs/tests/extent-io-tests.c
> @@ -80,7 +80,6 @@ static void extent_flag_to_str(const struct extent_sta=
te *state, char *dest)
>   	PRINT_ONE_FLAG(state, dest, cur, NODATASUM);
>   	PRINT_ONE_FLAG(state, dest, cur, CLEAR_META_RESV);
>   	PRINT_ONE_FLAG(state, dest, cur, NEED_WAIT);
> -	PRINT_ONE_FLAG(state, dest, cur, DAMAGED);
>   	PRINT_ONE_FLAG(state, dest, cur, NORESERVE);
>   	PRINT_ONE_FLAG(state, dest, cur, QGROUP_RESERVED);
>   	PRINT_ONE_FLAG(state, dest, cur, CLEAR_DATA_RESV);
> diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
> index 73df80d462dc8..f8a4118b16574 100644
> --- a/include/trace/events/btrfs.h
> +++ b/include/trace/events/btrfs.h
> @@ -154,7 +154,6 @@ FLUSH_STATES
>   	{ EXTENT_NODATASUM,		"NODATASUM"},		\
>   	{ EXTENT_CLEAR_META_RESV,	"CLEAR_META_RESV"},	\
>   	{ EXTENT_NEED_WAIT,		"NEED_WAIT"},		\
> -	{ EXTENT_DAMAGED,		"DAMAGED"},		\
>   	{ EXTENT_NORESERVE,		"NORESERVE"},		\
>   	{ EXTENT_QGROUP_RESERVED,	"QGROUP_RESERVED"},	\
>   	{ EXTENT_CLEAR_DATA_RESV,	"CLEAR_DATA_RESV"},	\
