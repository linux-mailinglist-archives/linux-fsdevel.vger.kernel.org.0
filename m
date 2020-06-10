Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20001F5B98
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 20:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbgFJS47 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 14:56:59 -0400
Received: from mout.web.de ([212.227.17.11]:55065 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729901AbgFJS46 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 14:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591815388;
        bh=zrM6Mstw671L2C4xtRcmtowMACOwlHKJxE3bL92A/5k=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=s4uUlhbsWkfjxBAKYA0FrJyVsEdQtY0MSTmL2Jjlae8x+MDIpJRrJhshTMqMSBXUs
         yH2xNbh/MxMO5g8+Qnk332BE86fwIdWKo4XOHmH9IEQvKkQ2zYqztO9FYpo3Bz1aRx
         yMgyPQq+3XJru37B4yM86q2pzZND6xHd1O2cCme0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.155.16]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MOixm-1jp9ty1K3K-00655L; Wed, 10
 Jun 2020 20:56:28 +0200
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
 <740ce77a-5404-102b-832f-870cbec82d56@web.de> <20200610184517.GC4282@kadam>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <b44caf20-d3fc-30ac-f716-2375ed55dc9a@web.de>
Date:   Wed, 10 Jun 2020 20:56:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200610184517.GC4282@kadam>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Kz2+KDJLii4lL+1Xq2+9GxI+E0FxfHagFzciCsIy+29xKVvu7mA
 fU8FYsR5LaTIj6xwHd2nstAMqXJexfBtcsDd48FeSlOmFx7n0uxCWv1lw/o5fDEw2/DK4mI
 SUyYmAcNketJS8ZPH/aGeb3bQgemmgpw467QyN++E6HJtm4Dk+pMp93SmLJgmGIld4JUwoH
 qQbV2BCmHwWKMtxBhE4dw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:avbKXkX+ZGU=:LwHUAiqxl+y2SPTQwBKMWJ
 DO7HRV4bdf0mvjFYttBISox2Xn5do32ZY1+mkRTHhf2iODnqgtnoYlkjkArQpmHaCcUFx0LSU
 GAxXHW2WcfdPZrG4kk/zFsX+qr8scYxwRLh2fBgnVutNuh/lDi05gu8Zy6i9s5L+zmyamcmJ0
 EfLRjM9CR3I/piYXStmrIZ9Vh07y6GbeXkjkxKoEyeLfRAI/lZP+mETdSbp0MUdy6xSHz9BIw
 U1CqERzQamW+wRAq13TCSVdkOBEoIHWaTuTPVM2T/EoyIQ9TTh1e9h1HZ9gZCqsw73hlqTx5r
 LTGFTCO1S9AZD6crH5WfwwzJr1Nq68Glt/1a311TF3f74uR4pZKcW5in/hDgbAgrXli1usG6w
 elzbNW5kSgVmj7qVj7SQKD6GEyec6f6pFTuYMVrrTCpU9rvPzao2R+LtC9QGPyv879zDTlHHW
 GvxLMuX5TxBsjnv+DsttXSj1TgjuZQbS3UaOIhzdsPLwoZNif0yp4kHvwEmJWP7fVOj2fkv9R
 4ZShZONj6hmncEz8FgyLF4v4TCWIx3bm4xYbUfWQZ69zLFnvoYWk9F19PzRw6oHkPnJ0O42q5
 lVBCRXZzzqb6Wj1zIKu6xIY0JNcyvae11J0TCdGJ0iNdNW/umMYQBJ+0EJ8/4Vt6NpzwK7aGs
 WsN3EufinUbv2J+JtN8JdmHS9HjkrFJ06lRBY0M/kOr2Jqc2Qj0c0QklKmlFLaGM6CDAc3eaG
 diBjYgoxaY9rUk//nXvrmgpvdi6eHwK0KAVeSak4fEXo1xor7LuaMbSruUd/tf45qnvWW29gE
 CwYN5f4W53PLRoXzBeT9PK5WwxpNHjlvCUjRuhon9P+olBDuaL49O7106SfCahJYIfaz9EsQp
 K2PnVBs4u4AW3Di6eOSrBJXCbPoeegtrBY4MZ9WFXXtaFa+dqskjgeBFTWAk4S/E95vhi1YkT
 CV5QHm2rKevj0lU/X4OUGadgcO2dr/0gyq/XgoPm5YMJzyDnaB/g7ziBYaBGlxYx+GqMMF49T
 YpUr+xtjE0I+gUd5eS8Ap2G+paMkd6FqXCY9wKizL0h3afsMNsbqlowYZkpMkjTNs1X48hTCX
 DA2LXOwo7OeKdmPq3Au/1UKT4lJW6k2+VgmdvTshNu92QOCrfIdRmrpL0LoXOJLrQtTZZUQx+
 Zi4xeMjdnfr/nJSaoeAzTCfUY9Dzwcyx+Cyx4ELZixETwLldga8MNiuTlORYwpmIVLShbdLh+
 R6hViB9FP6V64Qunw
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>>> If the second exfat_get_dentry() call fails then we need to release
>>> "old_bh" before returning.  There is a similar bug in exfat_move_file(=
).
>>
>> Would you like to convert any information from this change description
>> into an imperative wording?
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?id=3D5b14671be58d0084e7e2d1c=
c9c2c36a94467f6e0#n151
>
> I really feel like imperative doesn't add anything.  I understand that
> some people feel really strongly about it, but I don't know why.  It
> doesn't make commit messages more understandable.

Do you insist to deviate from the given guideline?


> The important thing is that the problem is clear, the fix is clear and
> the runtime impact is clear.

I have got further ideas to improve also this commit message.
I am curious if other contributors would like to add another bit of
patch review.

Regards,
Markus
