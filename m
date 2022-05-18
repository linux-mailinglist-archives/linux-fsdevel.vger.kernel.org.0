Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E7252B636
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 May 2022 11:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233937AbiERJQf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 05:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbiERJQF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 05:16:05 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44694140D4
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 May 2022 02:16:03 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220518091601euoutp01f05daebee26c3fa0119aebcd6a7b70ce~wKEoBECCX2116821168euoutp01I
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 May 2022 09:16:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220518091601euoutp01f05daebee26c3fa0119aebcd6a7b70ce~wKEoBECCX2116821168euoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652865361;
        bh=02PK4+O2aeQtWtkRiTGgprSK3KlsrzpSAGa3d80mXIM=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=APji2QMkgVlaRNO7yCs/aQMHtzdialyZeiznatrlvDzvOCWguWrtsfvwwh91Ge/mM
         l5nHKnz3+HRnMQN8fxMq+Qgne7K6356Jd0fo0EtVpxWbX4YvDp9eAFVR+MIJkCYh3d
         tCPqLbwBoSx3a2sI1fzWTIXpucpqwvBi7sqHmjdk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220518091556eucas1p23fa8121f563bd4cdb43b27949f0bacba~wKEi8vgjM1876518765eucas1p2c;
        Wed, 18 May 2022 09:15:56 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 92.DD.10009.B49B4826; Wed, 18
        May 2022 10:15:56 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220518091555eucas1p16a9ead30703054b30e76c2227cd4f629~wKEid_GJl2284822848eucas1p1W;
        Wed, 18 May 2022 09:15:55 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220518091555eusmtrp1e75ce65f06f2fb713ae2679ccd687280~wKEidEsht1304613046eusmtrp1J;
        Wed, 18 May 2022 09:15:55 +0000 (GMT)
X-AuditID: cbfec7f2-e7fff70000002719-42-6284b94b8d52
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 72.98.09522.B49B4826; Wed, 18
        May 2022 10:15:55 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220518091555eusmtip2b2f3d735ee7a617445733660bddd54a0~wKEiS6z1b0225002250eusmtip2Y;
        Wed, 18 May 2022 09:15:55 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.7) by CAMSVWEXC01.scsc.local
        (106.1.227.71) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 18 May
        2022 10:15:53 +0100
Message-ID: <717a2c83-0678-9310-4c75-9ad5da0472f6@samsung.com>
Date:   Wed, 18 May 2022 11:15:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.8.1
Subject: Re: [PATCH v4 08/13] btrfs:zoned: make sb for npo2 zone devices
 align with sb log offsets
Content-Language: en-US
To:     <dsterba@suse.cz>
CC:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <pankydev8@gmail.com>, <dsterba@suse.com>, <hch@lst.de>,
        <linux-nvme@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-btrfs@vger.kernel.org>, <jiangbo.365@bytedance.com>,
        <linux-block@vger.kernel.org>, <gost.dev@samsung.com>,
        <linux-kernel@vger.kernel.org>, <dm-devel@redhat.com>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <20220517124257.GD18596@twin.jikos.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.7]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (106.1.227.71) To
        CAMSVWEXC01.scsc.local (106.1.227.71)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIKsWRmVeSWpSXmKPExsWy7djP87o+O1uSDHbdYLRYfbefzeL32fPM
        FnvfzWa1uPCjkcli8e/vLBYrVx9lsug58IHFYu8tbYtLj1ewW+zZe5LF4vKuOWwW85c9ZbdY
        c/MpiwOvx78Ta9g8ds66y+5x+Wypx+Yl9R67bzYARVrvs3q833eVzWP9lqssHmcWHGH3+LxJ
        LoArissmJTUnsyy1SN8ugStjX/MjtoLFChXnvs5jbWBcINnFyMkhIWAisfHvUdYuRi4OIYEV
        jBLbO2+yQzhfGCWW3VvHAuF8ZpQ48echO0zLmjOXmSASyxkl7s8+zQ5X9fT1QyhnDaPEiw33
        gPo5OHgF7CQWLNcD6WYRUJXYMqeXFcTmFRCUODnzCQuILSoQITFt1hk2kHJhgRSJHSuLQMLM
        AuISt57MZwKxRQREJS7tXwF2EbPASyaJ47+PsYPUswloSTR2gh3HKWAs0XDwAjtEr6ZE6/bf
        ULa8xPa3c5ghHlCUuLnyF9gqCYFkiQ0zwyDClzgl7j0KhbBdJCYfWMMKYQtLvDq+Bep3GYnT
        k3tYIOxqiac3fjODnCMh0MIo0b9zPdRMa4m+MzkQNY4Sl759ZoYI80nceCsIcQ2fxKRt05kn
        MKrOQgqHWUgenoXkgVlIHljAyLKKUTy1tDg3PbXYMC+1XK84Mbe4NC9dLzk/dxMjMNWd/nf8
        0w7Gua8+6h1iZOJgPMQowcGsJMLLmNuSJMSbklhZlVqUH19UmpNafIhRmoNFSZw3OXNDopBA
        emJJanZqakFqEUyWiYNTqoGpcsfk6tJ7W67wfGafVl50gely/u6izlUf3/82Nb169KSz/4TH
        Zrb8a9wb/L7G+D7ZVmttd8cu2jfghIxryJv+rZw8Jpwv4g1cGc7tvWy71PtYcPPcb2uKN3P0
        /hTZ6T6lZuWs3/uPrD5/tH+a2JTzF3ZmSLLplTT8kp7w927P1uUnUtrm839V1j4tsHR1wbcz
        VdM+La5rvsHj88Kre9lvC40Tzv++vLHOLzuQbHL9V6jtpg0sTaIHjpgF8FToRKyaIXNOnJtF
        cq6Y6KoPqxg+1O/fLq5SM0E6XNKxb8Hy670nrKZlTxJrMbgsGaC3dXVhlN5WBh7Z2Y+jr8Vr
        tv3jaevV53/E1BXrsC52fYSPEktxRqKhFnNRcSIAGQTGuOQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleLIzCtJLcpLzFFi42I5/e/4PV3vnS1JBg9fyFmsvtvPZvH77Hlm
        i73vZrNaXPjRyGSx+Pd3FouVq48yWfQc+MBisfeWtsWlxyvYLfbsPclicXnXHDaL+cueslus
        ufmUxYHX49+JNWweO2fdZfe4fLbUY/OSeo/dNxuAIq33WT3e77vK5rF+y1UWjzMLjrB7fN4k
        F8AVpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJex
        r/kRW8FihYpzX+exNjAukOxi5OSQEDCRWHPmMlMXIxeHkMBSRokdDd1sEAkZiU9XPrJD2MIS
        f651sUEUfWSUaDr8EapjDaPE6a4zQBkODl4BO4kFy/VAGlgEVCW2zOllBbF5BQQlTs58wgJi
        iwpESDzYfRYsLiyQIvHo02wwm1lAXOLWk/lMILaIgKjEpf0rWCDmv2CUeN36jR3EYRZ4ySRx
        /PcxdpBlbAJaEo2dYNdxChhLNBy8wA4xSFOidftvKFteYvvbOcwQHyhK3Fz5C+xOCYFkib+3
        wicwis5Cct4sJGfMQjJpFpJJCxhZVjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgQmiW3Hfm7e
        wTjv1Ue9Q4xMHIyHGCU4mJVEeBlzW5KEeFMSK6tSi/Lji0pzUosPMZoCw2gis5Rocj4wTeWV
        xBuaGZgamphZGphamhkrifN6FnQkCgmkJ5akZqemFqQWwfQxcXBKNTDN5TY72SWRv227Oh/f
        oYt8Uzln1+y2P3i2dL9whL+KznKXMvHlqx93vpbITjjZtC/pS2HDy49sL0X5pBqeSdzeyJv/
        qCF5X9mLuh8bE9eXKFyqToxlUf1yW/1fR3HKjEatnhN/n66WNU31ORK97u3GyL7XTt8fr77h
        8/s0Cxdf/Cuh84HcHtMr1r64eb69pivIwGTm4wyVU1fvHvrDEiFaGTJl+qTJpSlrS1fcVeiK
        5f0/59vpK+wvbcOc5hv83N+7mPP3aWWmixJ3fwo/2Wj3WHLFsscc7x9P1p+fsHHz6bfKshE3
        t7T1cAdwNjHKv28Ped6dmLw8vWKaKdvprWplGyaczJgv8PtmoknDmS03lFiKMxINtZiLihMB
        g5KR95sDAAA=
X-CMS-MailID: 20220518091555eucas1p16a9ead30703054b30e76c2227cd4f629
X-Msg-Generator: CA
X-RootMTR: 20220516165429eucas1p272c8b4325a488675f08f2d7016aa6230
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220516165429eucas1p272c8b4325a488675f08f2d7016aa6230
References: <20220516165416.171196-1-p.raghav@samsung.com>
        <CGME20220516165429eucas1p272c8b4325a488675f08f2d7016aa6230@eucas1p2.samsung.com>
        <20220516165416.171196-9-p.raghav@samsung.com>
        <20220517124257.GD18596@twin.jikos.cz>
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022-05-17 14:42, David Sterba wrote:
> On Mon, May 16, 2022 at 06:54:11PM +0200, Pankaj Raghav wrote:
>> Superblocks for zoned devices are fixed as 2 zones at 0, 512GB and 4TB.
>> These are fixed at these locations so that recovery tools can reliably
>> retrieve the superblocks even if one of the mirror gets corrupted.
>>
>> power of 2 zone sizes align at these offsets irrespective of their
>> value but non power of 2 zone sizes will not align.
>>
>> To make sure the first zone at mirror 1 and mirror 2 align, write zero
>> operation is performed to move the write pointer of the first zone to
>> the expected offset. This operation is performed only after a zone reset
>> of the first zone, i.e., when the second zone that contains the sb is FULL.
> 
> Is it a good idea to do the "write zeros", instead of a plain "set write
> pointer"? I assume setting write pointer is instant, while writing
> potentially hundreds of megabytes may take significiant time. As the
> functions may be called from random contexts, the increased time may
> become a problem.
> 
Unfortunately it is not possible to just move the WP in zoned devices.
The only alternative that I could use is to do write zeroes which are
natively supported by some devices such as ZNS. It would be nice to know
if someone had a better solution to this instead of doing write zeroes
in zoned devices.

>> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
>> ---
>>  fs/btrfs/zoned.c | 68 ++++++++++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 63 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
>> index 3023c871e..805aeaa76 100644
>> --- a/fs/btrfs/zoned.c
>> +++ b/fs/btrfs/zoned.c
>> @@ -760,11 +760,44 @@ int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info)
>>  	return 0;
>>  }
>>  
>> +static int fill_sb_wp_offset(struct block_device *bdev, struct blk_zone *zone,
>> +			     int mirror, u64 *wp_ret)
>> +{
>> +	u64 offset = 0;
>> +	int ret = 0;
>> +
>> +	ASSERT(!is_power_of_two_u64(zone->len));
>> +	ASSERT(zone->wp == zone->start);
>> +	ASSERT(mirror != 0);
> 
> This could simply accept 0 as the mirror offset too, the calculation is
> trivial.
> 
Ok. I will fix it up!
>> +
>> +	switch (mirror) {
>> +	case 1:
>> +		div64_u64_rem(BTRFS_SB_LOG_FIRST_OFFSET >> SECTOR_SHIFT,
>> +			      zone->len, &offset);
>> +		break;
>> +	case 2:
>> +		div64_u64_rem(BTRFS_SB_LOG_SECOND_OFFSET >> SECTOR_SHIFT,
>> +			      zone->len, &offset);
>> +		break;
>> +	}
>> +
>> +	ret =  blkdev_issue_zeroout(bdev, zone->start, offset, GFP_NOFS, 0);
>> +	if (ret)
>> +		return ret;
>> +
>> +		/*
>> +		 * Non po2 zone sizes will not align naturally at
>> +		 * mirror 1 (512GB) and mirror 2 (4TB). The wp of the
>> +		 * 1st zone in those superblock mirrors need to be
>> +		 * moved to align at those offsets.
>> +		 */
> 
> Please move this comment to the helper fill_sb_wp_offset itself, there
> it's more discoverable.
> 
Ok.
>> +		is_sb_offset_write_req =
>> +			(zones_empty || (reset_zone_nr == 0)) && mirror &&
>> +			!is_power_of_2(zones[0].len);
> 
> Accepting 0 as the mirror number would also get rid of this wild
> expression substituting and 'if'.
> 
>>  
>>  		if (reset && reset->cond != BLK_ZONE_COND_EMPTY) {
>>  			ASSERT(sb_zone_is_full(reset));
>> @@ -795,6 +846,13 @@ static int sb_log_location(struct block_device *bdev, struct blk_zone *zones,
>>  			reset->cond = BLK_ZONE_COND_EMPTY;
>>  			reset->wp = reset->start;
>>  		}
>> +
>> +		if (is_sb_offset_write_req) {
> 
> And get rid of the conditional. The point of supporting both po2 and
> nonpo2 is to hide any implementation details to wrappers as much as
> possible.
> 
Alright. I will move the logic to the wrapper instead of having the
conditional in this function.
>> +			ret = fill_sb_wp_offset(bdev, &zones[0], mirror, &wp);
>> +			if (ret)
>> +				return ret;
>> +		}
>> +
>>  	} else if (ret != -ENOENT) {
>>  		/*
>>  		 * For READ, we want the previous one. Move write pointer to
Thanks for your comments.
