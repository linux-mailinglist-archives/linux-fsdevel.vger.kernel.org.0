Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7C03FFA69
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Nov 2019 16:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfKQPB3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Nov 2019 10:01:29 -0500
Received: from mout.web.de ([212.227.17.12]:46353 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbfKQPB3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Nov 2019 10:01:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574002873;
        bh=4y0JcFtoJHnVUVsgn9gCbYaTiaGGxKXqzTKBrHi+a54=;
        h=X-UI-Sender-Class:Cc:References:Subject:From:To:Date:In-Reply-To;
        b=Clx0utPDw9li1KIIzn7ZiLIBYvt/8gSD4n3iObl3PF4KNqsLdUGPXoUlDi89U8wZW
         4ePPzs6MegPGnsa475UfizwvVBlZYgTb6/NdkCbbkna0LYgeByJ0EuzzXPXGethODg
         JIp/tvcxauYjlBLO/5UX9jLQ4QFvIEpI49BvtfHo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.59.42]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MWj2N-1iLYY61gmx-00XsYS; Sun, 17
 Nov 2019 16:01:13 +0100
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linkinjeon@gmail.com
References: <20191113081800.7672-8-namjae.jeon@samsung.com>
Subject: Re: [PATCH 07/13] exfat: add bitmap operations
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org
Message-ID: <bb89f610-3eac-6b28-1aff-265b358d22af@web.de>
Date:   Sun, 17 Nov 2019 16:01:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191113081800.7672-8-namjae.jeon@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1BcEh6UV2GsvuNc3kQjQ07WYZY+wFuuOEKg4iP+VeefPd8n2yKp
 b7t1Pksbc5cd9o+X7KdXRfISd5tVwpWMbs3NncXgawlv75EJRGzpD8ONiNM7NGrvfrT9tTd
 5ABSar5iwitpMxb//a8m+Ti/KKd0jWOD2ZepyiCxTeKIb3jpvQSjIeJjegrTnLTe7yQh3HB
 cP8GPdc4PL6KZCbUQIYeg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2TMbCF1ntDs=:jYNXu0WuoM+9XypO892FN3
 eyKA2y9pteDbhlp3Jhhpki5xoGQFWKWwOKQ3/m2snB0AmdQmBlEWxCP0Y8f12WyfImh3nfTbx
 1ep5ev+lwHQB24XEBuaYeGZqu8iLq/vwmz9ttUqZzr3Qm2xlRc+NM1gunFvf55rOjQMi20eAK
 JTAbIpb1/jOK1cgm2ibTkPrMjbn5U4x/ymtO4xTzu33YJd77E9Uv3DVELA5yvcIxLbphyTrR5
 Du3rpAp1LjLIXylCuarb2zfLy+86i7n7iHcxyeO4pgTAwpzG4s+6KgSFnsdKwTW71g1hnNWzU
 x4hcVAxvZFIszouo1pt0wggrKC8nb60TBa9BHgz/nd8gFlbzVSfEaL+y/oQL7HExNaxdz9Dgs
 tWAloXlBqha2uAZEZwXZxMI+5sVtDngxRzSLvDFD75czFXyF7ozpAl9WD6jImz8XnefwRp/kK
 6Fis0A3G24pHGkK0DudUTvBWo0cQpH3gBC5fEJBcTxg5b+gBO4y14JTs34rqktfrdsBjX+0nN
 XDh4WOU6nicDMz5fbO2bJBYTH/K0n9v6BJBru3DujfyJf4iPiP+K4+Rls6HmWvDhAkuNAECA6
 nA1qcyBJzN5LjCFRxwaezYvDJKKnyC6RSNvbWVqfpJtzXyAh1/srigMur/vXYbIeMNXJTPnqf
 dTtEvP4tFagGJIUgtVHOn9YRoes7H2ehC4BYYRbPVE7gsFyaOPdoBFI6QFi0SajabrhqrdUSv
 jWmxPMcxHs75iVfTgVebJKfHr+syMCYbXpQAxVzGUGZiQXSUxex5KhsawwmrQ3LOXcODCKDkI
 FqRIi7Lpeb+/rDE1UMCMKBq0YPWfZw8V41tYhdBRZC/M0s7o7x4m02QLHmbrUCN3mID4PfC2t
 n7b8U/bfDJcBgI96LqMXomjp3mfYpsFaz+aJKjr+8JaMRiVK/9HeJW+ydbDMf8NRIq9ThTBRW
 see98NIkNdYDuKAlPH1kAJyeJReCGDhafZguMFIpEnSCk+4aT6TELtweDhFVxoaUkS68/QpCx
 N0mx6gFD7B3aF4eYxJ+3KK48k26aVgJSTJZ8AO9p5ipnXLYAtDqeGcL4wQ2xEtpDECDwAyPIC
 FsP5JPfWmxZhNix2tkatnyJvWEjxXGPikMau80mop21+tgXcE8VBNw5xkkCun2j0LiRgqwIwA
 npLU0gStKtNTXcQMmSwlmOFZ288PpekrblbCOzGT2/ny9JeVVXRQn1lFTwWXiRaRBP5hgyR+H
 bDtUCE9AErsWXoJZ9jpNhpSVQcucrAV4SPJICLZEOWiSWNifsVXBaxU+vZcg=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

=E2=80=A6
> +++ b/fs/exfat/balloc.c
=E2=80=A6
+int exfat_count_used_clusters(struct super_block *sb, unsigned int *ret_c=
ount)
+{
=E2=80=A6
+	/* FIXME : abnormal bitmap count should be handled as more smart */
+	if (total_clus < count)
+		count =3D total_clus;

Would you like to improve any implementation details according to this com=
ment?

Regards,
Markus
