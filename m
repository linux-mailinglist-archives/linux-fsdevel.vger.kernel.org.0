Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3D44E49FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 01:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240903AbiCWASK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 20:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiCWASK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 20:18:10 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94296E8FB;
        Tue, 22 Mar 2022 17:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647994595;
        bh=Lmv7gJQ4OtTJmtWag6k61rhKF5+or/S/h13XFp2lObw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=W3G7zWHzDvQ+0DzOkHt0wW/S6k673TG25Cc0aSqe9UtRPvFUQsPnV4Peff4FpQbx1
         NePuK1RPUn0tFk9ZuwqiFwDKClF0uVccEs5LqfIUVC9SpJJnDwXxK4MPhThqlQthv7
         wdARDHe55YZALF7x2rBym/dcCNBUXURsv5dbY5o0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N8XTv-1oAjyd0oHB-014UHv; Wed, 23
 Mar 2022 01:16:35 +0100
Message-ID: <0ecd3ad4-e1be-d08d-4093-fe03fd480a59@gmx.com>
Date:   Wed, 23 Mar 2022 08:16:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 14/40] btrfs: don't allocate a btrfs_bio for raid56
 per-stripe bios
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20220322155606.1267165-1-hch@lst.de>
 <20220322155606.1267165-15-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220322155606.1267165-15-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Vrza/qRASFZJmIRnas2Cj4weqEqkAd1wqUos8iapVhjfAgpAks1
 JWZWj89mpivcYLbh3ab+sE/qnkTN5S/dmunzBxFSTuTeziZ+wb0Ap/CoPsRa+4cO4EtOfm3
 Z0RFZ70ssn+Im22URNFl+43bMoSufDuTM689KSvOL/du/BJNozrQOI3QdEsLDNc/HmbKY0K
 Py5ieMfiWA7e9oC/qM7SQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:04noAKnM8Ws=:AbnARXfswYvO5yWXWc2Fu2
 iX2cNiNO5pMBZrYjaBlAVwDXuSv161gi/0Re05CYG4s8t87gOmAlj/CszM6OIn17ecOit3oPu
 B/TIMoMm5U5MPetwSsraLSejWZYpHl7xffNOeCQqQwtfE3V2UCjA9/GEieNkgBlvGew4vwzyt
 +AFIelCVyXNag+6R+p0voAhMt7KxKleuySb+l6W8OAXGJkxIVK2/Tkl8Zu65CvO5r1B5tyq0d
 IggcOMqg9UgtXIBZPDLK+GkS3A2k1fW8HmKg4RaDY9EeJW7KBYNt/snouivuUJ7r8jBArJ0Z8
 AJJUBWj3ochnnEVBnnnSJMjFmMdMrkoU3WRHcPFQvD65HBtRKeXfllzybkvjtDwdIPRoeeH6+
 TsmKE89zmD+gP8MrpXFK5IXulVQaGful5dr9psFU6xkYA+HFsnGHHVK+R04J7493du1/x5Mby
 pFJba9QFYBCBoECgJiD68ku3B+jhjN30FjUFZv7ZfKVaCAtSl42dGwm8KRaRFqGeUrrIb3Zrw
 vwsgRGhSAZA8pBqhtzoFhG6y+/BjmxOw7PGzthCWT0mwXzCnRisUupedgmze1hbC+oCjIxnbJ
 nYuP/33LGb7A4guFxyK+ubnR4A08+3KDJ2aq4U72JadxMnboVc89n00erusd1VMjJDFIm8Myz
 IQtjE26xKwWKwmn4z8mKfJ+9UDGJulK6JzNGrpPwle5QsKscT1fdK6y4sundybe+DWj/7m4PV
 9R/VPF+kCKaWcuVIf9M2LQAWK1d6LbjsLq+L1fqVa/7DBzbmY/8LWn3wPrw0oCBNahfpopwb1
 5EQXFdHiSX9jMyBFsQHQ1fJyNGPR+LYI3inlVRPsjJ6udscyUeHF9z3z7Sn8We6fDHN86XZAO
 Cer7Zdv5bGTfqjIqWxG7ibX8fVgMVbgsPr/8a6gqEWvEIEwM03D23a4nIkQTS06AziK4SN+kd
 S4Ty7XqXFrdpxpYKXRjSvoOiHySkGm5cTh2AcJH7LvwXm1g0kGpjrj7zc6NT4B0Rj6t3TFirG
 Ry+Z3t0g/opGvvR1/OnXgUip2MbUXTs5bsIe/RWIVVwtpPFfK3gEaejqiWehtK1ai/Gi7IffY
 4UpTPJObtsaV2o=
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
> Except for the spurious initialization of ->device just after allocation
> nothing uses the btrfs_bio, so just allocate a normal bio without extra
> data.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

RAID56 layer doesn't need to bother special things like mirror_num nor
checksum, as it's at a lower layer under logical layer.

So this is completely fine, and save quite some cleanup I'm going to do
related to RAID56.

Reviewed-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/raid56.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index 2f1f7ca27acd5..a0d65f4b2b258 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -1103,11 +1103,8 @@ static int rbio_add_io_page(struct btrfs_raid_bio=
 *rbio,
>   	}
>
>   	/* put a new bio on the list */
> -	bio =3D btrfs_bio_alloc(bio_max_len >> PAGE_SHIFT ?: 1);
> -	btrfs_bio(bio)->device =3D stripe->dev;
> -	bio->bi_iter.bi_size =3D 0;
> -	bio_set_dev(bio, stripe->dev->bdev);
> -	bio->bi_opf =3D opf;
> +	bio =3D bio_alloc(stripe->dev->bdev, max(bio_max_len >> PAGE_SHIFT, 1U=
L),
> +			opf, GFP_NOFS);
>   	bio->bi_iter.bi_sector =3D disk_start >> 9;
>   	bio->bi_private =3D rbio;
>
