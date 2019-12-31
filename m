Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D520912D960
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2019 15:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfLaOGQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Dec 2019 09:06:16 -0500
Received: from mout.web.de ([212.227.17.12]:44799 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfLaOGQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Dec 2019 09:06:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1577801160;
        bh=hgmnvESjrr7UKhObL6AX/4Q1g8WZ0OymJawxhAj9BQY=;
        h=X-UI-Sender-Class:Cc:References:Subject:From:To:Date:In-Reply-To;
        b=lUlLqYXPhOZpnZj8CPieuhEYPPCZOwa4eKb+r7gSgDjhwN1bgtFXuBS9nDO8+VG7S
         p415zCX6/zykuUL+PT1ZTM6sn2Zgrt2ur31H+3rSbLIxlOfNLqQJEjPNlguIBGMfuU
         7JVyUfrQrgLXKtRaKvc374UdKxhzUoBAeSpF/5V8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.105.164]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MSrgv-1jDTWn0qhh-00RpZv; Tue, 31
 Dec 2019 15:06:00 +0100
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linkinjeon@gmail.com
References: <20191220062419.23516-2-namjae.jeon@samsung.com>
Subject: Re: [PATCH v8 01/13] exfat: add in-memory and on-disk structures and
 headers
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org
Message-ID: <527e28b8-7c66-7aff-c5be-6dfb368caec7@web.de>
Date:   Tue, 31 Dec 2019 15:05:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191220062419.23516-2-namjae.jeon@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QfvG9Q5Jccks3TgzeSXnO+btGki+kEs7h0p5A48LZaEoxb41c/A
 ho4CkQvW95Q23YvLbfkLBA4AuAP6jhYNx6737FIngLPwR2jU8GzXkG7K7Frm4CAfWBQfkSt
 MDAUPPwt2NCv3cGdv99pGwXuydmEy6A0/8sb73BPYmlxDHIX3REJKjHzOQPaRRtdvwA1+bk
 0qd0AhcEP5ea8mTdHCGXg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:s/H9pmRCsuM=:occWQ9FTMeFcnLI1vDffbe
 JB4+E3DPthr/7uou6tEG/tmcP791s+1qfUNq/VUtEAEXN0XeW3VButHxAQVEj/elXqpT0WkxI
 dUdaO/2byHJK3vO3DPpaDwOkLRtWBWAVZDBMzMm1VtJxaj6aiho2QMw3Ps1sIrOOPVaWmdcWd
 4cZg5UC5ynLL1g0MItWWyRaa57ncNaFVBpfSVVkB/7o2C9AoXj5fq/C7gETd0wtPfLd2y3/cv
 RS73syj17N6ZngyKCOo6z1lsLl/RsgRc+zAkSvTIfNyHNcMnyfCA0M/B9G5v4Ixc6kw0w8ZUh
 DAsQ/0qtuNB7pniyZXtTLecGQ2z6E+FLBrt8gVVGZ79/PvLR01V8rdpgdcQnYJs6EyHqilbUg
 +Bw2UybsDYr5QKRC6/Aq4DOhFy8Aky5fioa/Db27fToZBkekp83u2WsW8BO9KBskTyI/KSBW+
 4fqfX2ccEZuoZvcMHVuM3P0IzJuG2yCvEVKbsOohUgjt9CVgrBKBUPAr0YpiCzGIVJaELuK+P
 sD4ScyqU2ENBXvG4QEREJNgOM6Xz0aZJ6mpkZG/ov2s/c2QuboohaIcA6stPKz5FYrGBE8u3B
 1BdckFy6XHeZVrNXeHDezJ2Iubf5Lh0cRI5Bawe5nb7KXC5iGcJ6mIb+g7psYK5GrL8C7WQzC
 htRUyMVn1kdVEpBAevHiB4YTdKTJyiUe7y7Lr5M4maezsfOpC8Vy4ZK+sc2fmxUraD6UnGtKR
 YGAA2awYqWLcC5BeQg/gAK6MZPS6gi81kYQU53OnYC8B0SrKiEtEvbjBOWqeJd6DY9caBgmof
 t0YKHr52ZxnDvHcdwFUUnrGOT5p3rdj/paOJnU0bRttx7OvEXk7mapaIBGnapdFqHRNo5nIzb
 zup7j/1JjlMTRa8N4CIuvpJAndfZCvEbYvz+JREI8HJ62ZheHVWRVkyxFjPcmhjmMvMpaALg6
 EdsbbzcE1sBGe4GB6sbsRKf1NrUeM2+YWANTmd5VFPnX+yTBmQP7CGMYjas8XiwKEWHAOUlth
 /cnlzvCXc+CrO/xTFskeDp5sAM4ZYTsPEWw/3bYsKOgXMdtLbYB58BshHNsiKytz6kRbr6J7i
 GG/vN6oV1F9Ne6V3uaSXMMPDS3VtIzPmm96u73s0B9h/Nhi5eVeYnT/SKqeaQtxs0/ZZfosXu
 1RZhaDJkuAyxxaT6fl31NB/vdGb7EHx5PxyCAJwu6OC1fs3PgX88S8vRsEtPMDXkIeCArXhnZ
 V9vxVVrE2RKjq5KMpSX82Kk78oFxmL1C+ZfFQuqg9qQ8jSC11vzXFEPlRg30=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

=E2=80=A6
> +++ b/fs/exfat/exfat_fs.h
=E2=80=A6
> +unsigned int exfat_get_entry_type(struct exfat_dentry *p_entry);
=E2=80=A6
> +int exfat_calc_num_entries(struct exfat_uni_name *p_uniname);
=E2=80=A6
> +int exfat_count_dir_entries(struct super_block *sb, struct exfat_chain =
*p_dir);
=E2=80=A6
> +int exfat_nls_cmp_uniname(struct super_block *sb, unsigned short *a,
> +		unsigned short *b);


I have taken another look also at these function declarations.
Please improve the const-correctness here.

Regards,
Markus
