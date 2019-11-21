Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0051052B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 14:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfKUNJH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 08:09:07 -0500
Received: from mout.web.de ([212.227.17.11]:50009 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbfKUNJG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 08:09:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574341650;
        bh=Bl1M9oXask9WgvTRgAZYOO+YcirOmLpgsPrvqH+BMV4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=CciPYHuN5K6YIBjpeF9sMfjUvJguqACBNF/5DGvP1F3RNGYSzV0rnuBeyuWrJrd2C
         6xnRSjsSN7T5w+ZXtANXznndW6EE8pP3Pn++u+X8PYFfTWnGlp0J0/bmeFpVovrBY3
         iLUq2DUC4HqxfAWM9octfXKhDafptxZ8Nt8Q1/Zk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.48.172.213]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MQNeK-1iQAQv2uEu-00TmZM; Thu, 21
 Nov 2019 14:07:29 +0100
Subject: Re: [PATCH v4 04/13] exfat: add directory operations
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Daniel Wagner <dwagner@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nikolay Borisov <nborisov@suse.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linkinjeon@gmail.com
References: <20191121052618.31117-1-namjae.jeon@samsung.com>
 <CGME20191121052917epcas1p259b8cb61ab86975cabc0cf4815a8dc38@epcas1p2.samsung.com>
 <20191121052618.31117-5-namjae.jeon@samsung.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <498a958f-9066-09c6-7240-114234965c1a@web.de>
Date:   Thu, 21 Nov 2019 14:07:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191121052618.31117-5-namjae.jeon@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MOEVo3x2zyMK82ubMAciySTOlnzTy6xS7QKdHLf+vQEI0peQnRq
 ORFwXWRwq8iv7kqMvBA7XEgbMtHERM+N9oOtfsl7w/1CCL+YMqJ2wTywCFh+ZAnI6fwnBvh
 Mp42RPxORAC1zcbtKo6lfCbvD87z1zG/oreKzLr8FBoDxOgwB4QamzGRaMpVdmgC/h3AULv
 VgI1C0qvSERXQwETnYqlA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:u+e4M6qFg6g=:oiz/zLSIstBOFSjDLhfu8N
 06gVP2W3o8g12gtktWbYv2nR3UAh7yoOMbBPeYglkv3k985qIpGeMszVrdMSLRhQ8EmLmBStu
 ar045SwM3S4QhghSJF/ooGdNQ/ggyWoPhArB+Cyphw65eahYrzW2LjWJxaiYAab+ULuyZF/he
 Ihl5Mwwyxv8pWPwRMQySXW+EbKAGq6UQsnvXZ7mUIOcC1OJM1chtVOAEqP8eKBREl5+5nnqoh
 nqeNISdJQcJ5NqAjB8DBYAl1QoPpBQsaSra/bFrG70AKoRoEvfqLA1GSF3VDOphMJB+8sF3Ss
 iWbf5OYJe0Qgie6d6/OqFmATxjbkaNcJ2LLegw9vIaUiGmiH8dN7W/x81yPMxn8F6pZOPKhTW
 XB5NmUHPGJdAG2cAT7GTO07BLkY7OAbiZmAkX5BS3eErLSL5UeW7YEEx0JMZyagqNvCLYsQjU
 I8+ZVa1m1IZIVFdl+l2rsTieT7BAzWDjMIIaoKosexRkCpz9orG1Sp1Dn19Andlxn4CxFH6Gn
 2v451p4exG975f9OfSuXEuBE1CIhHy8GUo0VhKbqsSdAk6e4QPvLm7kljdjx2AoLjeWw/mhwt
 VdRBQyO1FMsKbG87oJvVC3QOUsikcygz/ZBMNYgAbF8AkRRAVoTJKmuZ8d/hYHOfd2UjYqs+V
 NjlFs0GhgU3iSlWqFEHea2SkBLEEhaXJjBhr+VZSvmdpLtILbnFJYM4kGFB/ZSmMuN5kV5GWB
 xlTowt+sDINQ5XMSvkvkARONaOXiJttu3l6e3tc2rAV93NgE1XDKkFWCyP7m0Mn39NeTwLdpq
 ccEogc9F3clMJmU49H0mPqak0MDjCqzWxOY5hhxPnV1Tp3NnMttvPt4BUzzFzY3wRjEjmQRH4
 UwFQ2d0ZEmDHrDH1UIfyQ8+RouUpXnHPoR38mIu08VXNeUUc7Vf2/JG1R28iJadltmuSXkouv
 btRMSXAXci4K9/jeyoTaaEapvgtlMCdrdykHBrPwgFScaYdoZDc/BkMwpgnT0bUCT+0unLS/s
 GbyhgRNaZjJemmqgMYli5EDw/MMhKxML4Et+yoaRLvNXwbYlL33hGQCoRxkXyfuXPYITMLMmb
 UNvXlrvPkLCr+n+OnSk/Kto+7qJ93Tt9pd2lh/dYuhOSvcOWiEqWnH70h8P8mc3kKyjcz+RGC
 a2VDtyo8SLWM7leUTPZltihpdwIxN4F+mECws6DxzbkR8cqZzQfrFwLLdiYJQwWppqtF7rqv6
 5df9ftlc9jIJUvNibTRwsNMOFx+TlIV1ETQwMQ25/aHh2vBRZJZVECehXCgI=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

=E2=80=A6
> +++ b/fs/exfat/dir.c
=E2=80=A6
> +static int exfat_readdir(struct inode *inode, struct exfat_dir_entry *d=
ir_entry)
> +{
=E2=80=A6
> +			if (!ep) {
> +				ret =3D -EIO;
> +				goto free_clu;
> +			}

How do you think about to move a bit of common exception handling code
(at similar places)?

+			if (!ep)
+				goto e_io;


=E2=80=A6
> +free_clu:
> +	kfree(clu);
> +	return ret;

+
+e_io:
+	ret =3D -EIO;
+	goto free_clu;

> +}
=E2=80=A6
> +static void exfat_set_entry_type(struct exfat_dentry *ep, unsigned int =
type)
> +{
> +	if (type =3D=3D TYPE_UNUSED) {
> +		ep->type =3D EXFAT_UNUSED;
> +	} else if (type =3D=3D TYPE_DELETED) {
> +		ep->type &=3D EXFAT_DELETE;

The other assignments are working without the ampersand.
Thus I would find its usage suspicious at this place.


=E2=80=A6
> +int update_dir_chksum(struct inode *inode, struct exfat_chain *p_dir,
> +		int entry)
> +{
=E2=80=A6
> +out_unlock:
> +	brelse(fbh);

Can the label =E2=80=9Crelease_fbh=E2=80=9D be more helpful?


=E2=80=A6
> +struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *=
sb,
> +		struct exfat_chain *p_dir, int entry, unsigned int type,
> +		struct exfat_dentry **file_ep)
> +{
=E2=80=A6
> +	/* FIXME : is available in error case? */
> +	if (p_dir->dir =3D=3D DIR_DELETED) {
> +		exfat_msg(sb, KERN_ERR, "access to deleted dentry\n");
> +		return NULL;
> +	}

Will this place need any further improvements?


=E2=80=A6
> +	bh =3D sb_bread(sb, sec);
> +	if (!bh)
> +		goto err_out;

Can it be nicer to return directly?


=E2=80=A6
> +	ep =3D (struct exfat_dentry *)(bh->b_data + off);
> +	entry_type =3D exfat_get_entry_type(ep);
> +
> +	if (entry_type !=3D TYPE_FILE && entry_type !=3D TYPE_DIR)
> +		goto err_out;

+		goto release_bh;

=E2=80=A6
> +		if (!exfat_validate_entry(exfat_get_entry_type(ep), &mode))
> +			goto err_out;


=E2=80=A6
> +	brelse(bh);
> +
> +	return es;
> +err_out:
> +	kfree(es);
> +	brelse(bh);

I suggest to improve the exception handling also for this function impleme=
ntation.

+	brelse(bh);
+	return es;
+
+free_es:
+	kfree(es);
+release_bh:
+	brelse(bh);


* Would you like to adjust any more jump targets at similar places?

* Can another initialisation be omitted then for a pointer variable?

Regards,
Markus
