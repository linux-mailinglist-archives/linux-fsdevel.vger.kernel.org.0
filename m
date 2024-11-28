Return-Path: <linux-fsdevel+bounces-36098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6019DBB41
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 17:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7982164577
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 16:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8773D1BE238;
	Thu, 28 Nov 2024 16:25:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937942744E;
	Thu, 28 Nov 2024 16:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732811145; cv=none; b=RUf217FGWBeTdrFbY0qWmN+AbxpfOZE3bG4yMXHFIaXztAfqM3FQleNH1bhzjFOjblAm9Byk4lyYmXL59ReYgoS3FUPiyIrxQDsHeTLGRbrx9Pp4nSwyaxZw3YpMP7355tLbE7ZurjjKMKLJRJXJ13VYoccoAV7KjmyDNT3CbU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732811145; c=relaxed/simple;
	bh=cIcUqMLjWP354kYtE+Raag2eS84h1gxaXuZaR+YTpc8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gvr65VtL37l3odc8LJTQGhmD3c3ZvQb4UCSayAtJNzld5zlQPxWkYEYQcrYo1Qb/xGaoUV+9rXfyOUv1NmioPmIkPqDvjnU2DLLNlLWCM2VEFHOP0YrLr4Gw+e7ZeCq4cmNVPQ13A0FFx+66bc9UDhlBnuq4JwYdzVZvTZIUUf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Xzh2l1Wysz9v7VJ;
	Fri, 29 Nov 2024 00:04:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 68BD714035F;
	Fri, 29 Nov 2024 00:25:36 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwBHYYB1mUhnN_l3Ag--.45451S2;
	Thu, 28 Nov 2024 17:25:35 +0100 (CET)
Message-ID: <99408482e7f5002b2b3defb6d7b816b25e11cbbf.camel@huaweicloud.com>
Subject: Re: [PATCH v2 6/7] ima: Discard files opened with O_PATH
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Christian Brauner <brauner@kernel.org>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, zohar@linux.ibm.com, 
 dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, paul@paul-moore.com, 
 jmorris@namei.org, serge@hallyn.com, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
 linux-security-module@vger.kernel.org, Roberto Sassu
 <roberto.sassu@huawei.com>,  stable@vger.kernel.org
Date: Thu, 28 Nov 2024 17:25:21 +0100
In-Reply-To: <20241128-musikalisch-soweit-7feb366d2c7a@brauner>
References: <20241128100621.461743-1-roberto.sassu@huaweicloud.com>
	 <20241128100621.461743-7-roberto.sassu@huaweicloud.com>
	 <20241128-musikalisch-soweit-7feb366d2c7a@brauner>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwBHYYB1mUhnN_l3Ag--.45451S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw1DKFyfXrWUKw4rKw4kWFg_yoW8AFWDpa
	95Ga4FyF1DXryxCF4fGayayayrK3y2kr4UWws5X3WavFnxXF9Ygr1fJr15WFySyF1Yyr10
	vr43Kryak3Wqy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	UAwIDUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgABBGdH1XMGJAAAsj

On Thu, 2024-11-28 at 17:22 +0100, Christian Brauner wrote:
> On Thu, Nov 28, 2024 at 11:06:19AM +0100, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >=20
> > According to man open.2, files opened with O_PATH are not really opened=
. The
> > obtained file descriptor is used to indicate a location in the filesyst=
em
> > tree and to perform operations that act purely at the file descriptor
> > level.
> >=20
> > Thus, ignore open() syscalls with O_PATH, since IMA cares about file da=
ta.
> >=20
> > Cc: stable@vger.kernel.org # v2.6.39.x
> > Fixes: 1abf0c718f15a ("New kind of open files - "location only".")
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  security/integrity/ima/ima_main.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima=
/ima_main.c
> > index 50b37420ea2c..712c3a522e6c 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -202,7 +202,8 @@ static void ima_file_free(struct file *file)
> >  	struct inode *inode =3D file_inode(file);
> >  	struct ima_iint_cache *iint;
> > =20
> > -	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
> > +	if (!ima_policy_flag || !S_ISREG(inode->i_mode) ||
> > +	    (file->f_flags & O_PATH))
> >  		return;
> > =20
> >  	iint =3D ima_iint_find(inode);
> > @@ -232,7 +233,8 @@ static int process_measurement(struct file *file, c=
onst struct cred *cred,
> >  	enum hash_algo hash_algo;
> >  	unsigned int allowed_algos =3D 0;
> > =20
> > -	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
> > +	if (!ima_policy_flag || !S_ISREG(inode->i_mode) ||
> > +	    (file->f_flags & O_PATH))
> >  		return 0;
>=20
> if (file->f_mode & FMODE_PATH)
>=20
> please.

Oh, ok.

Thanks

Roberto


