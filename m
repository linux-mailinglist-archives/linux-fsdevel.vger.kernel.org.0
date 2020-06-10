Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6F71F5B06
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 20:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbgFJSNP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 14:13:15 -0400
Received: from mout.web.de ([212.227.17.12]:55669 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728505AbgFJSNP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 14:13:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591812768;
        bh=SIIkYbqg/co3MSWUR1tpZyKgTHzJDpfXxExpHdt0t8w=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ZfMIzqBBWGD03pX4LMW0BTTjyrLE41+Tvl0Jww7kcoF9tnJkBUyWSyQlnWE4vIxz8
         YPrFxIlv+svwASL1JlhZ0XTGaRkvu5HD8HJGzDM2TOWfFebJ3l71VDN4WwbGKbe/so
         yhtxV+YWFO4Xje7K/JQPXAn65L1pzBnbYvTGT4G4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.155.16]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MDMvE-1jbtxB3kIg-00AWly; Wed, 10
 Jun 2020 20:12:48 +0200
Subject: Re: [PATCH v2] exfat: add missing brelse() calls on error paths
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-fsdevel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Tetsuhiro Kohada <kohada.t2@gmail.com>,
        Wei Yongjun <weiyongjun1@huawei.com>
References: <20200610172213.GA90634@mwanda>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <740ce77a-5404-102b-832f-870cbec82d56@web.de>
Date:   Wed, 10 Jun 2020 20:12:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200610172213.GA90634@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
X-Provags-ID: V03:K1:tQXCrRN7QEqaEr1ol2/bC7wS9d+4/upBCYWKmKkgCWKEBNdql4b
 nyN7GqZn76mkiu9jyIPg1Kl1dwrkaeiWB2gmrUYU4ZDnCFR27CwSHx62hnsn5WzWPjgOleg
 ZKdO/3ucbz+M2GoE6zWftPQL85Ks4Lcedbia5g0O0e34VLwAokiGmMqMtrRhFqRUA1dYdw+
 e5d7SztBXQvEGmgDElf0A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z5/qdkECikU=:KOlwUNzTj31itfKzIpbuxL
 Gv3QVMMpQtKWEpGAnWa88qfYXSlA/jqtu8E9OsS72MNI7CGctHMsbYWyZ+d1/kgo7qqPBOMTG
 4q8WN7gaM20TvLPrHP8rVlTCvPd6pezw2a3TkBhbsIeg7i4MGOxx14uRjVzthQk411AwLlEFc
 NmiG9239X7U6WxXVgYD9OErhEGCg2ng/x0Q8bDYB1TzEQQacliHtvboQlxUiUaUfmAtzzlrqZ
 XYfw8/4ni8Xu1bJAxAWBobGbnYEISYBVva04pOj4u5HzU8s/4ktWC4Hik3hr5HXyG/xtFUW8R
 1WnFlglOmhb3kiODs1V+ihEmuMPYiZl4Ntgrvh9Q7H/xBpAE2J7eag2Vw0uWHo0AFZnFe1aSF
 znFxO/mCwymxsiKJuzadvrj3TA7WreDUGFXR9SgEcKjUF2xTGng0prh0eMsi5f6SZkmB0A2+9
 VWDN9pse6wKwZDwfoC7LWdfPfqIYmooa8XsmhmKkbZ8JaWmZ5pRnI1w6sbnxpIWWlk2Rr+LS/
 Qin17FDNWEZDRml1yAy0punUcKv7DRV8b6sC92IRcQrExsa9R1Dw4tsoy/foY9WLNMHYAfNtz
 14iGQJyz2Ldx8zGhjP/bc8ISSvNzOOtdsXhJ6p9jfMRiFAHL2kQWgj8KAilmR9PVriacb68LV
 9jG5TKy553T5Un7PC1A25Wl4BglWZaJty9dQcVJRlm/S1mvo7hGL5H3iD5RFblunJ+HsofdCr
 eTrfaz3MLI7SHiz3K3wUV//ZSD5ZE+/QLkVYt6d+O5cVl0y3PLk9hQUspinvSewulG3D/RSuf
 Dd2TEyVnu5e+WoJvLNSfpvvJz3KCp/X+yrQFmHeHnHlgGgGlu+h5R8vnpH3jJT/f8qRaDgJzN
 BWVtD6TXjtcI15605eUiOjatuR3u/vipJkv4LxFuBFe3uVfYRDDFrOrilLDNjS6CmG1978z6X
 oq0ISKd5lvgnUsfvVGChSa2IU+UndT9KadULd0ohzpO1Rjd8OjTvMpoIidkhx6HU6zCiyJ3Sv
 Sc2YerulTW92VON5YVl+r0/62Ew8d67eGO5JLRHQDDDs41hZsOML+WTNlatfSLpj9Q5vTkiX5
 +FCnaOTZeFUHImO7250kLPtGk89omXy534te3IaVZ3jD5jPJbW2/dvuYPdp/quIKObc/oiw9X
 NkxDHiZ0FnRNsyn4mnk8mD/HQ2ejdHdunRpaFpj0HhuUnRJnVNO0w8/Xxl3xp8/UZVppbGCe9
 xL/Gg768RGJmfBh1N
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> If the second exfat_get_dentry() call fails then we need to release
> "old_bh" before returning.  There is a similar bug in exfat_move_file().

Would you like to convert any information from this change description
into an imperative wording?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=5b14671be58d0084e7e2d1cc9c2c36a94467f6e0#n151

Regards,
Markus
