Return-Path: <linux-fsdevel+bounces-3293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E88197F26D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 08:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A460A282A33
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 07:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5104D38DEA;
	Tue, 21 Nov 2023 07:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A090CC3;
	Mon, 20 Nov 2023 23:58:43 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4SZGcc6rRPz9y5Z0;
	Tue, 21 Nov 2023 15:45:04 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwD35HQHY1xldiUUAQ--.11542S2;
	Tue, 21 Nov 2023 08:58:13 +0100 (CET)
Message-ID: <884eb5167283c7ce0604b3dae9807d99b661eff8.camel@huaweicloud.com>
Subject: Re: [PATCH v6 25/25] security: Enforce ordering of 'ima' and 'evm'
 LSMs
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Casey Schaufler <casey@schaufler-ca.com>, viro@zeniv.linux.org.uk, 
 brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
 neilb@suse.de,  kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
 paul@paul-moore.com,  jmorris@namei.org, serge@hallyn.com,
 zohar@linux.ibm.com,  dmitry.kasatkin@gmail.com, dhowells@redhat.com,
 jarkko@kernel.org,  stephen.smalley.work@gmail.com, eparis@parisplace.org,
 mic@digikod.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, 
	selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Date: Tue, 21 Nov 2023 08:57:56 +0100
In-Reply-To: <24a9f95d-6a28-47d3-a0cf-48e1698e2445@schaufler-ca.com>
References: <20231120173318.1132868-1-roberto.sassu@huaweicloud.com>
	 <20231120173318.1132868-26-roberto.sassu@huaweicloud.com>
	 <24a9f95d-6a28-47d3-a0cf-48e1698e2445@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwD35HQHY1xldiUUAQ--.11542S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAr1DtFW5WFWfuFW3ZFWrXwb_yoW5CF18pa
	yqqFWfKF4kAryIgwn3Xay3WF1S93ykCF15Ar9xJw1UJ3yqvr1vkr4xtrWfuFyDJr1DCa4I
	vr42gw1fGws0yaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAkuxUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAIBF1jj5atPwAAs4
X-CFilter-Loop: Reflected

On Mon, 2023-11-20 at 16:50 -0800, Casey Schaufler wrote:
> On 11/20/2023 9:33 AM, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >=20
> > The ordering of LSM_ORDER_LAST LSMs depends on how they are placed in t=
he
> > .lsm_info.init section of the kernel image.
> >=20
> > Without making any assumption on the LSM ordering based on how they are
> > compiled, enforce that ordering at LSM infrastructure level.
> >=20
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  security/security.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >=20
> > diff --git a/security/security.c b/security/security.c
> > index 351a124b771c..b98db79ca500 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -263,6 +263,18 @@ static void __init initialize_lsm(struct lsm_info =
*lsm)
> >  	}
> >  }
> > =20
> > +/* Find an LSM with a given name. */
> > +static struct lsm_info __init *find_lsm(const char *name)
> > +{
> > +	struct lsm_info *lsm;
> > +
> > +	for (lsm =3D __start_lsm_info; lsm < __end_lsm_info; lsm++)
> > +		if (!strcmp(lsm->name, name))
> > +			return lsm;
> > +
> > +	return NULL;
> > +}
> > +
> >  /*
> >   * Current index to use while initializing the lsm id list.
> >   */
> > @@ -333,10 +345,23 @@ static void __init ordered_lsm_parse(const char *=
order, const char *origin)
> > =20
> >  	/* LSM_ORDER_LAST is always last. */
> >  	for (lsm =3D __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> > +		/* Do it later, to enforce the expected ordering. */
> > +		if (!strcmp(lsm->name, "ima") || !strcmp(lsm->name, "evm"))
> > +			continue;
> > +
>=20
> Hard coding the ordering of LSMs is incredibly ugly and unlikely to scale=
.
> Not to mention perplexing the next time someone creates an LSM that "has =
to be last".

Uhm, yes, not the best solution.

> Why isn't LSM_ORDER_LAST sufficient? If it really isn't, how about adding
> and using LSM_ORDER_LAST_I_REALLY_MEAN_IT* ?

I don't know if the order at run-time reflects the order in the
Makefile (EVM is compiled after IMA). If it does, there is no need for
this patch.

> Alternatively, a declaration of ordering requirements with regard to othe=
r
> LSMs in lsm_info. You probably don't care where ima is relative to Yama,
> but you need to be after SELinux and before evm. lsm_info could have=20
> must_precede and must_follow lists. Maybe a must_not_combine list, too,
> although I'm hoping to make that unnecessary.=20

Uhm, I agree. Will think about how to make it more straightforward.

> And you should be using LSM_ID values instead of LSM names.

Ok.

Thanks

Roberto

> ---
> * Naming subject to Paul's sensibilities, of course.
>=20
> >  		if (lsm->order =3D=3D LSM_ORDER_LAST)
> >  			append_ordered_lsm(lsm, "   last");
> >  	}
> > =20
> > +	/* Ensure that the 'ima' and 'evm' LSMs are last and in this order. *=
/
> > +	lsm =3D find_lsm("ima");
> > +	if (lsm)
> > +		append_ordered_lsm(lsm, "   last");
> > +
> > +	lsm =3D find_lsm("evm");
> > +	if (lsm)
> > +		append_ordered_lsm(lsm, "   last");
> > +
> >  	/* Disable all LSMs not in the ordered list. */
> >  	for (lsm =3D __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> >  		if (exists_ordered_lsm(lsm))


