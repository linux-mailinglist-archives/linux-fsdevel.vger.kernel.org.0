Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60A61FFA2F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Nov 2019 15:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfKQOQD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Nov 2019 09:16:03 -0500
Received: from mout.web.de ([212.227.17.12]:46271 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbfKQOQC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Nov 2019 09:16:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574000146;
        bh=khYjmsAlHeJ/yxNUCSYVsBtEtQ46bLQCesW0YQ4jjEE=;
        h=X-UI-Sender-Class:Cc:References:Subject:From:To:Date:In-Reply-To;
        b=SjzxEjqWiAP30V4pokfScQR5Do0oSG9E5vofcjFjAeQwrTgicM11dAe1X6R8ZujOG
         Rh+Tko5K85j60wTO1VJ/Yj1z1n4gv4yRGdTPBzHusRgc54ahy3HFORvcYnTt6f+QsP
         VAceP2npgzBNLahiBxKmuGEq2gpjevSPO4D6enE4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.59.42]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MbyIM-1iGJrI0HGY-00JKlD; Sun, 17
 Nov 2019 15:15:46 +0100
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linkinjeon@gmail.com
References: <20191113081800.7672-4-namjae.jeon@samsung.com>
Subject: Re: [PATCH 03/13] exfat: add inode operations
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org
Message-ID: <82520012-9940-7f2b-3bac-bea5c2396ccd@web.de>
Date:   Sun, 17 Nov 2019 15:15:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191113081800.7672-4-namjae.jeon@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zf5nEkDn57Q5Ka1RPQHVODxHgldyqQQEzkQAVmuz2Kwcvj/OaQs
 hXv/X/M260bK754j/ijQ6SSORwPGgZo7ytpXZtRy3FxSRSzoSZZiInPTn0icG5Rhed5NJQL
 J0yqXGWBhtDIxU+pZXmT9A5KNbzAOtuoMN+yx/qTYOA4xpTVAZCauPjXMzY0hIxhjUwts0z
 M80h4631Q6ix+y/QvO/NA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Mlrv3wFmRxA=:HYZ1apU/qF5XMUnZoetoB4
 fiuuGP/QQ9nJhlSlOgVueG8H3MjiR0r2b/gbJTKyWolkevhU7p2LXcWgkcHBWrh+zbCLveede
 2jqGCK+DSIuMrIbMOM1TTOZG8zFDtqlLBelleWhbLJQ7vC0HFMUBi6uTLUXVXxB7XidjL2IaB
 iMFkx/UbS0lwnSeG8P2KsLYQZWcczPc+b7t1/b4/0J0UF+RyFjiSHX0/4Q5YemI6IyfCF0PKH
 M49haKHYy9ESbkqcc6CKjdOJ7mZpDPPGgeF3KKxX46JY0hi4zH/MvQYCRBchP+MyABIiGoEzU
 31za4GC5BEvCB/SKVEBawCOY9jnQCF09R7/MxDZk1qmXDrHYeCaGrIF1knaijCGeezeo87FGT
 sx8Oc/o94P8KUgzez06bK5zCEmdzM6K/kEjrATrUBc5mx2UEGvRZ/NCgiicd6q6cI4Mu5b500
 XJLrb5n5vu1hFKJk9C2XocBYLUv0J3aEU9iLDNgONo9IOWgC1IGlCjuICj0um93ejLfaaKOrF
 NX7tSVTPXpl+babhmycuxKfE7QeVAJsxOmY0l7JnVm0gAjILd/fSUsv4lKrF5wobKtYCtoWDm
 iPQHZFLesQEdyyN2Ep5haOS+IwuBXYAlGFqYeulyelK+9s4wZj4bPncFYsZTS/zhWFVcnHSAE
 wnBzEhyFlRMG+gazZtxfYrQnXbZU2W6BZk6lw1CRdge2Re3oVraGZHVSriWqoCYcnWEUadG/d
 VjaS/lXeaoWec8TdYwODxsi52w3y/MRpKptZRscdlBwrxJSuSm6qpcWi5BKhEpctLnqE8sQuF
 MDP0ZrvJglF+aU9ojE1gRstdxnqoWbLJN5hEV8IUXiDm2hUH0OeqcD7rCJ+OhCCSBGA9WuC0y
 1pGTBSJA9XBDBne/5XGW6z4SZGKlBsqTfZ/GLMffTW9K0CAcbFNH3cypSPh5EU4EobQkcr8l3
 5so5xKpXwqSV7bIrbkh4ucns7JSaeg5CR0hUVZ+yWz0nHkTu/4W33bAyRZGL6QoDDR9ddBrvg
 RqE2TuArzHbd6W4b/4gnlJzHsjDJGbmzGBQCrnwV62bQG6tLbJHSWJ42TeEvsA4mwGfm4qfIU
 GFCy8rWgPHaSrZxBDNjAmNa0FFNaEEQP9UyCdwNK7wBVzxm7UH+H+jnckzNr7eBOb0JTlCL09
 3zRfcETGsPKWEAAGJr84Ab8WXeCjfckZEOOLZMU8boey3cmgpSpwMrPDraMMxfjszcIOHdPby
 Np+DzLdoOYtyAvm5XNnIXKDVf7FCAlLxtnwj0b6PjBhQkQ1HVHddD88RYNHI=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

=E2=80=A6
> +++ b/fs/exfat/inode.c
=E2=80=A6
> +static int exfat_create(struct inode *dir, struct dentry *dentry, umode=
_t mode,
> +		bool excl)
> +{
=E2=80=A6
+out:
+	mutex_unlock(&EXFAT_SB(sb)->s_lock);

Can the label =E2=80=9Cunlock=E2=80=9D be more appropriate?


> +static struct dentry *exfat_lookup(struct inode *dir, struct dentry *de=
ntry,
> +		unsigned int flags)
> +{
=E2=80=A6
> +error:
> +	mutex_unlock(&EXFAT_SB(sb)->s_lock);

Would you like to use the label =E2=80=9Cunlock=E2=80=9D also at this plac=
e (and similar ones)?


> +static int exfat_search_empty_slot(struct super_block *sb,
> +		struct exfat_hint_femp *hint_femp, struct exfat_chain *p_dir,
> +		int num_entries)
> +{
=E2=80=A6
> +out:
> +	kfree(clu);

How do you think about to rename the label to =E2=80=9Cfree_clu=E2=80=9D?

Regards,
Markus
