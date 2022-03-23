Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9AC4E4A05
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 01:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbiCWAWX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 20:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiCWAWV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 20:22:21 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8485EDCC;
        Tue, 22 Mar 2022 17:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647994846;
        bh=DeXPJ50PuI0JA5jpifPXgc62pgyFVj9O5bc8G9sSlio=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=BH/lm6qKGDa3SXvVqRCaXGCKJKmYVTcqIohTU/3x/3XChZxltiT+PiXhgUZVtTMUH
         5dVDhTm2jFX81QtlA7vixntK+/kDZMzgXX2hZ1t2cmbPEClWG8jeee4xFEZ4TCP5k0
         HP6F0MgehhRPZkQ72Dp8Vlxm2P/khRM0YcFOiN10=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N9dsb-1oBpqS14ar-015csX; Wed, 23
 Mar 2022 01:20:45 +0100
Message-ID: <49d2563e-a611-0b44-569e-8e88053b7385@gmx.com>
Date:   Wed, 23 Mar 2022 08:20:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 17/40] btrfs: remove the submit_bio_hook argument to
 submit_read_repair
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20220322155606.1267165-1-hch@lst.de>
 <20220322155606.1267165-18-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220322155606.1267165-18-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EphsUVClpm9fqs+jGMdxwMyAd/am3vEeB+ovJ6C8PCiKRne4KEF
 IruZCv2mwQMy74kqWtT1OYkBoRP0+RiY8g8jhoUOUd3Whpat+qimBxBzQnEuuZC3WYY05ze
 96VojvKlIgxrNAIEIpfk5ZLbe5mX7n/xIC6WTIiHcF7I/tXmUKruuk7J34E9kLCyhydpiYS
 Sovto33uXbV8gD/qLNMtQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OgLbHs4P3BM=:5QwarakI0UeWwmoTwblc9K
 VlFWozSqvf501IfUnwnBTL0tuLC3xYTBt09ejmHJBhZIezyvjsP8UhJU6JnVcvuYHUARltnfV
 dYX/+uFv/sr4aBjQgeABsoiGw9CjHbWYHdTYGhSENXqYNJHauvyWTQwaoh19JLvB/R1m7jsan
 jWlSMH6fXQ0KHXmYuC87x8liKRscycBtvsonh3MkH9f8Mq8QnrznjH91duUT7ZrFHod2NVlTL
 qBhSu4Fn+SaeSGoqIVIeju9P/hyfA394GHt65NzJlFzG/eieuqeTMkIBHZSqcnhG67WO5Iw6a
 TaXpIHwRfN9sW++YXgS73SS7N+g8N9FtKw0p7WhOUz5zz/TB2+UCPcsR5HrlUpz6rjFFrS7En
 T4R2jxagTPehZR9HS7oGiBbcImq/rNlqwXGbYCaWLr9F67Dq85talfrJJ7f7586wditGrXpRo
 tm6N4Ip+4geJg5TB3lNWSuj9AwPkBQJtjiBPSTchgAefcqNzNEb1mvsrT2Gxt6zRtQ3Uck4c2
 ol0MXGbqEJz8543gYmoLseye1vZbsXBNT09dKekFmJl16PBvv99C6LsvUuQhfxbB+uAj0MLh0
 V3GL8R+uzI0tbH6MBIMHvYsofG4FjOdyA/oPPzAv29n+o5gQrIL0vUmrqYduYs0fzJ268uQ62
 SfMGFNtKGHtjGJSxLmpFO2pp2+CwBjepWXxR0k3njROQNVZley642fjHjM2VN7tlNgkQHy8v0
 m3xGxHd/ysWvCEAMk2O8HrOkhqghN9piT0gH/Iiuh1CfQXWBtdM2LviLkX7aqfCQC70x9uZwg
 eJEKOPrExqBwRvCYwENw6yhFEpDdBikh6dVOisDGEE0xEXTswWsYrKpnoCuIYOB6m3tqOXXoD
 b9uXZ5EqJTvnHst4jJQZh7Wu1nupvf7ukCJ75KnjySHVLeLWktSKxmzP6lWygqcM7xjhzY6oO
 gXdPEBhIXfO69ap3QzBY3+zjgmo798ILBElDpth8KBL41IpJY3oK1ynckoKDIYJE92gVWIU4d
 vgQFEkkwmK0tSWBNeZ4VXNV9gi67ORGTprVV4b+g99hC9WRDH8lyMlCX6NTfGFLckof3fwhjP
 h+3YEVSrSRjXJI=
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
> submit_bio_hooks is always set to btrfs_submit_data_bio, so just remove
> it.
>

The same as my recent cleanup for it.

https://lore.kernel.org/linux-btrfs/9e29ec4e546249018679224518a465d0240912=
b0.1647841657.git.wqu@suse.com/T/#u

Although I did extra renaming as submit_read_repair() only works for
data read.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/extent_io.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 88d3a46e89a51..238252f86d5ad 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2721,8 +2721,7 @@ static blk_status_t submit_read_repair(struct inod=
e *inode,
>   				      struct bio *failed_bio, u32 bio_offset,
>   				      struct page *page, unsigned int pgoff,
>   				      u64 start, u64 end, int failed_mirror,
> -				      unsigned int error_bitmap,
> -				      submit_bio_hook_t *submit_bio_hook)
> +				      unsigned int error_bitmap)
>   {
>   	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
>   	const u32 sectorsize =3D fs_info->sectorsize;
> @@ -2760,7 +2759,7 @@ static blk_status_t submit_read_repair(struct inod=
e *inode,
>   		ret =3D btrfs_repair_one_sector(inode, failed_bio,
>   				bio_offset + offset,
>   				page, pgoff + offset, start + offset,
> -				failed_mirror, submit_bio_hook);
> +				failed_mirror, btrfs_submit_data_bio);
>   		if (!ret) {
>   			/*
>   			 * We have submitted the read repair, the page release
> @@ -3075,8 +3074,7 @@ static void end_bio_extent_readpage(struct bio *bi=
o)
>   			 */
>   			submit_read_repair(inode, bio, bio_offset, page,
>   					   start - page_offset(page), start,
> -					   end, mirror, error_bitmap,
> -					   btrfs_submit_data_bio);
> +					   end, mirror, error_bitmap);
>
>   			ASSERT(bio_offset + len > bio_offset);
>   			bio_offset +=3D len;
