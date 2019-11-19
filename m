Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51D66102573
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2019 14:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfKSNdQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Nov 2019 08:33:16 -0500
Received: from mout.web.de ([212.227.17.12]:39257 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbfKSNdP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Nov 2019 08:33:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574170378;
        bh=J0nlCot3D5m63Vr8bCyo808UTTRfDNMnYGsfOvTgHno=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=OSTB4eBBD+yXG9QBwuGQ3EB4zcwtXOoGrm2L+BHQ7CMGhygyInGGIeYU+CN/3bQKE
         oQ2PoqhjSC0Z2XTz082C7Ne34rzB9SS93x3VaUaVUwWE42JJa8UxDohXc0LS7NN+GK
         J34QSrGo0lY86uuccBr6rFxtAPNaPfc9/Fcyeesc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.243.93.164]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MJTVP-1iYQ8Q3QqZ-0036KV; Tue, 19
 Nov 2019 14:32:57 +0100
Subject: Re: [PATCH v3 02/13] exfat: add super block operations
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
 <CGME20191119094021epcas1p1ef79711e2ea59c4e909a30a9ac2daa3d@epcas1p1.samsung.com>
 <20191119093718.3501-3-namjae.jeon@samsung.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <3bf9fea7-99d3-3a9b-6565-39d62f5ee473@web.de>
Date:   Tue, 19 Nov 2019 14:32:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191119093718.3501-3-namjae.jeon@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+LhCsVf5ZSyc7xF1CIwC4YJHjV6/SDldnJnKztI6+s1Pw1F4uEw
 yMt3DjWnf9LHcw49mYgtxBaB+zSHLVTNI5oQ3/ARx08hdoMTQA6EYEnzZMv0rWHj3+pTBxS
 QdWM9CUt/GRrTtUsYKC95DEQATxcQaNjmG/Fa8iJpMTk4KgAzafICV/b+7MiyybTY7W0ekp
 0pA84IwA7iZ5387zzo8FQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:v2m+BP4dEJk=:odSbwjcRPE4mQ/8DiBQXCq
 KEZCzOUPt9Lv+v0PLB/an8f56dhxcFnQT434j0h0S9l0U/dMR0nkrUSaHWquT8lePRakgzGH6
 jSjze9B1hXa4BYMzjG8tViFAH39kOuEjIKMWDIWeqeWzPBrDWM7xV15G3013HSY1fYlxhRWrP
 4l/cAtNWEtgU9C0LNdjcAsjlXWoEc2v7Keq1GXMwiuIpfe3dldf+6V4xFqMX9i/xJ/5kzrjoC
 FhJ3wLxP/JnBv6xGFDW9biWw/mJWCnTL2wNIc6EkF08cKxOF5UNBHcUUkyFrmPh9LrzpZqH+p
 abYcO4yyWRPNHQ1enOGRgpC3qVlvxlxL7RRbL7WNJVjEdkBt7FWv27y2S1yO0c2HYFb/RenbP
 LUI13FPGYrWu1GrGDuS5fQAPKa8Z95VXZtQwq0uk2cqi3y442dNHknkGQ5JnGJdkpeCNhRliQ
 OYKwyeR7VSQM2GfWaL1Vbo/q8NNmcGRpLDLdLqfhjPV8OsITZyADbCM+hnC0JbFRrceHbBVPL
 KfsE11oNIbuFJiTou0CE4kIQv659Z9KUU1jWMRmtIHIf+0do3HVllJhIglqkzU+611w8xr6Jw
 6QpWFzI8bAGNl3K+LN9pUCIAU7aYztSxq8H1FXTkQm+zlFsaBJx4qeFr79i0Kavr6m2CVmKaP
 YxexAn5usE5USm8YHaYWtUcYPjNqCqdzMfcAuvfCdtqVOuy9vAm9G0cSqjIo/9zD92lk5MHu5
 NQ6dOAySBXotwVdY4QR8lgUijAOXPUQ1O3oxxBskiF2nupXHY6ZBm8CnbD1KPNSFVVeliA7re
 UldjvdfYyrELHoxqYz5rEuPl461fblcrxT5KY6V/WvTelceKvqZDp4dTJiphM1ZgPBq+DYzRW
 hCU8TyYkdR27+g6Yr8jzj9xXrJY2TQApr9Bg9rVO1k6eIG5rYKLZhWg45fhlm+IIk5AVUUKhV
 S/5zpOc+47mCDcP/xCNNLxdH/1sQq0nSW/e2aGJB2HoUxc635HgKysvRllJlFSfzrfCoVvNh5
 C96poPRxp8hIaseNDvPv2rQ14//l3iKxBoG4GZNzOpcq1VTxSHe2VcYamNOhf1/sBEDvUg7y3
 9uC18OLJSacA2Kd8lgDonlKneRWKypbM1hJpCmwp9RdF/xnOJn682LOsVC340yA5eECpsrohe
 GbFFk50Kb5bDZ4Tf+FzZA9zwFvE0toqL37fYwgm1eLS+JUzzuPH99eJZYGlJ1ONfVJ31IkZ0h
 6lyyixS4vVgVyp3Rxhh9d8s2ccxWxzf4vVDp0xQA96E6798BPfUmw1X0B1yU=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

=E2=80=A6
> +++ b/fs/exfat/super.c
=E2=80=A6
> +static int __exfat_fill_super(struct super_block *sb)
> +{
=E2=80=A6
> +free_upcase:
> +	exfat_free_upcase_table(sb);

Label alternatives?
* free_table
* free_upcase_table


=E2=80=A6
> +static int exfat_fill_super(struct super_block *sb, struct fs_context *=
fc)
> +{
=E2=80=A6
> +	if (EXFAT_SB(sb)->options.case_sensitive)
> +		sb->s_d_op =3D &exfat_dentry_ops;
> +	else
> +		sb->s_d_op =3D &exfat_ci_dentry_ops;

How do you think about the usage of conditional operators at similar place=
s?

+	sb->s_d_op =3D EXFAT_SB(sb)->options.case_sensitive
+		     ? &exfat_dentry_ops;
+		     : &exfat_ci_dentry_ops;


=E2=80=A6
> +failed_mount3:
> +	iput(root_inode);

I find the label =E2=80=9Cput_inode=E2=80=9D more appropriate.


=E2=80=A6
> +failed_mount2:
> +	exfat_free_upcase_table(sb);

I find the label =E2=80=9Cfree_table=E2=80=9D more helpful.


=E2=80=A6
> +failed_mount:
> +	if (sbi->nls_io)
> +		unload_nls(sbi->nls_io);

Can the label =E2=80=9Ccheck_nls_io=E2=80=9D be nicer?


=E2=80=A6
> +static int __init init_exfat_fs(void)
> +{
=E2=80=A6
> +shutdown_cache:
> +	exfat_cache_shutdown();
> +
> +	return err;

Would you like to omit blank lines at similar places?

Regards,
Markus
