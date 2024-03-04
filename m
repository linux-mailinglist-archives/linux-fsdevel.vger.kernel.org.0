Return-Path: <linux-fsdevel+bounces-13431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5952F86FC5B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 09:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AED31C214A5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 08:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9262D1B267;
	Mon,  4 Mar 2024 08:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="c6xrS2dv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEB31AAD7
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 08:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709541912; cv=none; b=t7Q9TCcyjwSu2mSaafdUVD1jmzhvJfItj2X6714T45Oq+jcnR/iB2PXc4WSf2k3vO1GEugamiI3eioSOiooWvvvSLpy3OeFTNC5EcBdgV3MhWTuH8j9Ofsn0iqjAnMhRyAI2Q3JscxdtIRyKgSaZOzbVLpZ9CxB88uOQhquB5Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709541912; c=relaxed/simple;
	bh=8rehqnzCcHrOwGJPr2KpFJIuo5TztlnyQMl/2hcsPio=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=aW2uyVlrRJ9PMABh3ZbF0Q916oCYw+Ns9bl10y13t5RxTwNOQ1lq3LyTkh9SbeScIZMfAFijhXgu+Pcl0j4Y1Yzkdt9fQca7xr7QJNyhmJGLyq0/WX0r/eM9iGaAMY5gLaO7htqLL7aMNJEhVNrLd/qhQsNAS4EZnREAYGO4h+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=c6xrS2dv; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240304084502epoutp04eb423853bf3687f0f729d6722d2bf108~5g01meRjD0906209062epoutp04l
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 08:45:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240304084502epoutp04eb423853bf3687f0f729d6722d2bf108~5g01meRjD0906209062epoutp04l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1709541902;
	bh=MzjG5e5XdhbXljyyApNLCReLS6qauAisDpFd1adbVWg=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=c6xrS2dvlMNjpwy4if1PU2tfVM7DTf4/BndqTmo/cfyhX1dLM1NZz8yL98IQQ2aEj
	 sG8+nk4FqJU9XBRT2wOVs+phaj1TzzpuuELMqchx6kB2uOkRbf7VoCqoEDgLKET6el
	 SA2AMthpjDxZjP47WieLblABHpAnK4P9bkx5LRog=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTP id
	20240304084501epcas1p30e36c574df8a52c0e2881da54041c91d~5g01X3XYL0206302063epcas1p3F;
	Mon,  4 Mar 2024 08:45:01 +0000 (GMT)
Received: from epcpadp3 (unknown [182.195.40.17]) by epsnrtp3.localdomain
	(Postfix) with ESMTP id 4TpC1n5Csrz4x9Q7; Mon,  4 Mar 2024 08:45:01 +0000
	(GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240304084254epcas1p23c78cade5e8467010c70b9bf8713c0aa~5gy-EAtgJ0830608306epcas1p2B;
	Mon,  4 Mar 2024 08:42:54 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240304084254epsmtrp22250b0e780de955972145425a09fa24c~5gy-CyBiZ1870118701epsmtrp2N;
	Mon,  4 Mar 2024 08:42:54 +0000 (GMT)
X-AuditID: b6c32a28-a2ffe70000001cc8-9e-65e5898edc12
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	03.B3.07368.E8985E56; Mon,  4 Mar 2024 17:42:54 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240304084254epsmtip21c5de87afbfcf9ca786db710e08e4100~5gy_4ECpW2992929929epsmtip25;
	Mon,  4 Mar 2024 08:42:54 +0000 (GMT)
From: "Sungjong Seo" <sj1557.seo@samsung.com>
To: <Yuezhang.Mo@sony.com>, <linkinjeon@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>, <Andy.Wu@sony.com>,
	<Wataru.Aoyama@sony.com>
In-Reply-To: <PUZPR04MB63166D7502785B1D91C962D181232@PUZPR04MB6316.apcprd04.prod.outlook.com>
Subject: RE: [PATCH v2 02/10] exfat: add exfat_get_empty_dentry_set() helper
Date: Mon, 4 Mar 2024 17:42:54 +0900
Message-ID: <1891546521.01709541901716.JavaMail.epsvc@epcpadp3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQD1XOdcIp7+XJ9DfDES51wZq2IvPQHKtfRcAYc4wk6y1swosA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRmVeSWpSXmKPExsWy7bCSvG5f59NUg8ct6hatR/YxWrw8pGkx
	cdpSZos9e0+yWGz5d4TV4uOD3YwW1988ZHVg99i0qpPNo2/LKkaP9gk7mT0+b5ILYInisklJ
	zcksSy3St0vgypg0+z1zwVTRipv7t7M0MN7i6WLk5JAQMJH4+esASxcjF4eQwG5GiQWvHjN2
	MXIAJaQkDu7ThDCFJQ4fLoYoec4osWLXdkaQXjYBXYknN34yg9giAqYSXy6fYAOxmQVCJX7e
	2cUO0XCNUWLlwufsIAlOgViJV49XM4MMFRbwkTizwx8kzCKgIjF55QewObwClhJLfr1ng7AF
	JU7OfMICMVNb4unNp3D2soWvmSHuV5DY/ekoK8QNThI3tm1hh6gRkZjd2cY8gVF4FpJRs5CM
	moVk1CwkLQsYWVYxSqYWFOem5yYbFhjmpZbrFSfmFpfmpesl5+duYgTHj5bGDsZ78//pHWJk
	4mA8xCjBwawkwlvz60mqEG9KYmVValF+fFFpTmrxIUZpDhYlcV7DGbNThATSE0tSs1NTC1KL
	YLJMHJxSDUyvRFovWH1Wd/z6Qf3W0aaz3w6bOqXE3V+VsFhZI39hoJZh7oKJdmadt6rEZyhP
	j/vUVlqSJ9Ewb9n/3otLH2k7Jc64UK3Qua0q4oLM5YjFKlpfduz1+POHW89KXC5ETvvl9DUT
	z74QOcR4W9apiX3hBzYr/TOHnsdmKkwsuL7gwK+Xmw/JH7bv8S7haInK1qnYt+F0CRPn1zOh
	Rpo+rCvmVz9tbVRTZpabUrTsXoRT936XqIbeuPvrl/Se31ewT2mf3++Zd71vHF66QymLzan7
	5qknDzKFSveH/kr0F+sU/Le1+E3E4bC5959tXKBa9fDLHH17xycpzuWHVJtvp3B9YG+ulMxw
	csv8fdg8bJcSS3FGoqEWc1FxIgD5C0E5DgMAAA==
X-CMS-MailID: 20240304084254epcas1p23c78cade5e8467010c70b9bf8713c0aa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-CPGSPASS: Y
X-ArchiveUser: EV
X-Hop-Count: 3
X-CMS-RootMailID: 20231228065938epcas1p3112d227f22639ca54849441146d9bdbf
References: <CGME20231228065938epcas1p3112d227f22639ca54849441146d9bdbf@epcms1p1>
	<1891546521.01709530081906.JavaMail.epsvc@epcpadp4>
	<PUZPR04MB63166D7502785B1D91C962D181232@PUZPR04MB6316.apcprd04.prod.outlook.com>

> > Sent: Monday, March 4, 2024 12:43 PM
> > >
> > > This patch set is intended to improve the performance of sync
> > > dentry, I don't think it is a good idea to change other logic in this
> patch set.
> > Yeah, as you said, this patch set should keep the original logic
> > except for the sync related parts. The reason I left a review comment
> > is because the code before this patch set allows deleted dentries to
> > follow unused dentries.
>=20
> Which commit changed to allow deleted dentries to follow unused dentries?
Not changed. It has been allowed from the initial commit as follows.
5f2aa075070c ("exfat: add inode operations")

>=20
> The following code still exists if without this patch set. It does not
> allow deleted dentries to follow unused dentries.

It may be the same part as the code you mentioned, but remember that
the first if-statement handles both an unused dentry and
a deleted dentry together.

static int exfat_search_empty_slot(...)
{
    ...
    if (type =3D=3D TYPE_UNUSED || type =3D=3D TYPE_DELETED) {
        ...
    } else {
        if (hint_femp->eidx !=3D EXFAT_HINT_NONE &&
             hint_femp->count =3D=3D CNT_UNUSED_HIT) {
             /* unused empty group means
              * an empty group which includes
              * unused dentry
              */
             exfat_fs_error(sb,
                         "found bogus dentry(%d) beyond unused empty group(=
%d) (start_clu : %u, cur_clu : %u)",
                         dentry, hint_femp->eidx,
                         p_dir->dir, clu.dir);
             return -EIO;
       }
       ...
    }
    ...
}

>=20
> > Please let me know if I missed anything.
> >
> > > Patch [7/10] moves the check from exfat_search_empty_slot() to
> > > exfat_validate_empty_dentry_set().
> > >
> > > -                                if (hint_femp->eidx !=3D
> > EXFAT_HINT_NONE &&
> > > -                                    hint_femp->count =3D=3D
> > CNT_UNUSED_HIT) {
> > > -                                        /* unused empty group
> > means
> > > -                                         * an empty group
> > which includes
> > > -                                         * unused dentry
> > > -                                         */
> > > -                                        exfat_fs_error(sb,
> > > -                                                "found bogus
> > dentry(%d) beyond
> > > unused empty group(%d) (start_clu : %u, cur_clu : %u)",
> > > -                                                dentry,
> > hint_femp->eidx,
> > > -                                                p_dir->dir,
> > clu.dir);
> > >



