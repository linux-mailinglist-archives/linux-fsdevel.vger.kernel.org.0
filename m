Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78AF21026FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2019 15:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbfKSOkf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Nov 2019 09:40:35 -0500
Received: from mout.web.de ([212.227.17.11]:33701 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727351AbfKSOkf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Nov 2019 09:40:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574174419;
        bh=JxsUoMHheXU/KdGBNnEpaHryq9RrGzadPVe4yz26uNM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=VsYVAiTx2UVbJEFVx04DUML3XkXoAfWhKOIyLw/7tgJoKOImy91w07thHIEFBdZTw
         ryfTcb6JhJKyDuRdOMFBdy20OImaO0wM6PfRu0IgUpf8WRDfb0857zNhCVWkOZj3L8
         uCNKxtYTg3FLbj5ReRRvnuhga33c+jguvGpDUIqw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.243.93.164]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LoHcD-1hvEss1DIH-00gIgs; Tue, 19
 Nov 2019 15:40:19 +0100
Subject: Re: [PATCH v3 08/13] exfat: add exfat cache
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Daniel Wagner <dwagner@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linkinjeon@gmail.com
References: <20191119093718.3501-1-namjae.jeon@samsung.com>
 <CGME20191119094024epcas1p1be385d521ef64ae0e62da3f6f9bf3401@epcas1p1.samsung.com>
 <20191119093718.3501-9-namjae.jeon@samsung.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <c1db28a9-7905-be5e-68fa-21e23400b4a5@web.de>
Date:   Tue, 19 Nov 2019 15:40:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191119093718.3501-9-namjae.jeon@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JEkbcMI3twANPqjwWQAeufGCc0HTvD4tuO7TVhn8Oa374e1bn63
 zsbJbNjxvrIu3mNyyvRUiwI7FFU4EIs1w7MJ42Y79BepxSQ11gka78Lvya9HJLHW2pREuuQ
 nHBqMJ8jd3qyc9LVHeVl4hY+1cYPgAvqpfGJmjCjrKv3de/+zLXkD4UywSDYVEsq3hRZaFS
 iUGCWvfwPll2RpgpbMfaA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hr07JeH+9i0=:jrHSJRRtxMIwEoCTW5S3++
 rvUFmYULeDdbKli3zRS+PZfLVV36xCo1wgT6CvBdTaduV13bq9Msh57ZTRfOqstHgmozkDqp0
 L+Mdvl/HSnBMz0MmeQGFpbVtseBr2R4mh1aAkU2bvCy/gz/waDzHjwAtezMk8I7q4z8q14KmT
 tCxNeQCy57HVB7u/zaCX6feCumG80zJ8hjYn4UJGhAVVfM0qORSkvcNu4Ipzv3ffhETuxaQEX
 D6d19YZXFnIcApGMuwIDPBxZw+UEhuOle4ej7tCessBHVMBRISL3s4bGWYEU2tyujdnbb8zGa
 uIAYaJsKpMkDOmE3XGMeH2sdFz+9gqnXzQQkLO9tNo0PmJo/lWbPlVqFkzol6sehE2zoqnUQu
 ZkJb4R6XWN/eRQ85bVhvwfpfQlMPVrP5QLFLfvXNFAyvH7K/legySCcWvW/Yz3xVD8PqhGMek
 o0WGsYOMmGnsR/Pbsqw2c21lYqmWgfgEoGtt595W48JSbhTdi8NMcVVKiwi7kyJl0od4IQrSq
 P/w8TqfTtOiFgYuyqNC+uOD8uNtOi/tY2R+fHbwJ1flHbmpTFEOjXZz8lzO3Via6iSionLqSE
 kyErlrqG3sDUb+SBIHBorcotpoqdkpvIEKUPSb3ioinp6EHHpeLSbb9vjLdybKJ3n9Phyn0WM
 09alF6Mr+qbPJxqLVOuA80Zw3/cJ5guYacPIouGIxjBrA5DiN2i47mq3aiRCACNNd8/QXDo0R
 UO3CyTRWmXZDPIksZW11+hVVA/t21K9zaxh7gxEqy00eQlznmWhEzD7Uprh629oHHtZDV51U0
 vcLR/AbKBR/HXGrxoDdSZKIKiaeIUFXOqxQdXISpS6SmUFIyIfqZIfN7ElvmYR11EcmQDh2tX
 MsjIP9k6Hsm/42caRY/+HLL/N9RthmtGTTRBip/lXdn6c2ShDMw6n3k2WXOXjgYAchX8e2Ih4
 vRL7h4iKSkmbo+x+CV/KiNtFul+86NRWqxpusizmvRHc52uOXLIP/uT1JAGoImT7vpeCYvOoQ
 kqOm8fNQSVxAnh0LA8iFt0TEh9dhrAOKlLRHQiqSy6HDm9oUgrlsg3wAAwgy3511VH7CBTfCa
 nsxdiYzYVVyO2HVfNOxqrg63eGULLJ8IhaQX87jVvk3QDJ8fO11yU7/oM0aGCUDmeRpEAgOiM
 LWGm+OCEtgcWkufKRn8QL+4fPbQ5MP0Yp/DR/OZGscqveErUe++sxiso7iHiV3PeX4/q/Mi0I
 eadh0oLMiTy68UVuv7BG4e1WZEDJcmhAIe28JQzN6OJ4T81Sy8KDHtvQ8IJ0=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

=E2=80=A6
> +++ b/fs/exfat/cache.c
=E2=80=A6
> +static void exfat_cache_add(struct inode *inode,
> +		struct exfat_cache_id *new)
> +{
=E2=80=A6
> +out:
> +	spin_unlock(&ei->cache_lru_lock);
=E2=80=A6

Can the label =E2=80=9Cunlock=E2=80=9D be more helpful?

Regards,
Markus
