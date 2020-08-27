Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87659254A4B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 18:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgH0QO0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 12:14:26 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:41030 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726123AbgH0QOY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 12:14:24 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id AF977425;
        Thu, 27 Aug 2020 19:14:22 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1598544862;
        bh=D0iFd0HwiCnS07gs0PSchR2wvXFcHlxmi/ESrc/MLYU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=IWJn97ni71VN/PWXAki7hnk+ntwYGe1wO4LKL1xBE4a0V4A92cfa2Y7uarzyI1WtH
         +RKuHIHPg+Afj9604KaVhLb9dYzAAVgu671kjGVtz9XYBAS+diut93eN2XoBIIOsuw
         e+SSKufEk8pT3hcrC3tjiwYqfE86rRTtF6Qn7QbM=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 27 Aug 2020 19:14:21 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%6]) with mapi
 id 15.01.1847.003; Thu, 27 Aug 2020 19:14:21 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     Joe Perches <joe@perches.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     =?iso-8859-1?Q?Pali_Roh=E1r?= <pali@kernel.org>
Subject: RE: [PATCH v2 02/10] fs/ntfs3: Add initialization of super block
Thread-Topic: [PATCH v2 02/10] fs/ntfs3: Add initialization of super block
Thread-Index: AdZ30tAfM9dNSlAKR92rLVrbgJq3AAABsW8AASzZqLA=
Date:   Thu, 27 Aug 2020 16:14:21 +0000
Message-ID: <83acd2652133437c8d9f62fcc37ad5e4@paragon-software.com>
References: <caddbe41eaef4622aab8bac24934eed1@paragon-software.com>
 <1ad67130d11ae089fbc46fd373e1e019e1de06f8.camel@perches.com>
In-Reply-To: <1ad67130d11ae089fbc46fd373e1e019e1de06f8.camel@perches.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.8.36]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Joe Perches <joe@perches.com>
Sent: Friday, August 21, 2020 10:39 PM
>=20
> On Fri, 2020-08-21 at 16:25 +0000, Konstantin Komarov wrote:
> > Initialization of super block for fs/ntfs3
> []
> > diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
> []
> > +
> > +/**
> > + * ntfs_trace() - print preformated ntfs specific messages.
> > + */
> > +void __ntfs_trace(const struct super_block *sb, const char *level,
> > +		  const char *fmt, ...)
>=20
> This is a printk mechanism.
>=20
> I suggest renaming this __ntfs_trace function to ntfs_printk
> as there is a naming expectation conflict with the tracing
> subsystem.
>=20
> > +{
[]
> > +	else
> > +		printk("%sntfs3: %s: %pV", level, sb->s_id, &vaf);
> > +	va_end(args);
> > +}
>=20
> Also it would be rather smaller overall object code to
> change the macros and uses to embed the KERN_<LEVEL> into
> the format and remove the const char *level argument.
>=20
> Use printk_get_level to retrieve the level from the format.
>=20
> see fs/f2fs/super.c for an example.
>=20
> This could be something like the below with a '\n' addition
> to the format string to ensure that messages are properly
> terminated and cannot be interleaved by other subsystems
> content that might be in another simultaneously running
> thread starting with KERN_CONT.
>=20
> void ntfs_printk(const struct super_block *sb, const char *fmt, ...)
> {
> 	struct va_format vaf;
> 	va_list args;
> 	int level;
>=20
> 	va_start(args, fmt);
>=20
> 	level =3D printk_get_level(fmt);
> 	vaf.fmt =3D printk_skip_level(fmt);
> 	vaf.va =3D &args;
> 	if (!sb)
> 		printk("%c%cntfs3: %pV\n",
> 		       KERN_SOH_ASCII, level, &vaf);
> 	else
> 		printk("%c%cntfs3: %s: %pV\n",
> 		       KERN_SOH_ASCII, level, sbi->sb->s_id, &vaf);
>=20
> 	va_end(args);
> }
>=20
> > +
> > +/* prints info about inode using dentry case if */
> > +void __ntfs_inode_trace(struct inode *inode, const char *level, const =
char *fmt,
>=20
> ntfs_inode_printk
>=20
> > +			...)
> > +{
> > +	struct super_block *sb =3D inode->i_sb;
> > +	ntfs_sb_info *sbi =3D sb->s_fs_info;
> > +	struct dentry *dentry;
> > +	const char *name =3D "?";
> > +	char buf[48];
> > +	va_list args;
> > +	struct va_format vaf;
> > +
> > +	if (!__ratelimit(&sbi->ratelimit))
> > +		return;
> > +
> > +	dentry =3D d_find_alias(inode);
> > +	if (dentry) {
> > +		spin_lock(&dentry->d_lock);
> > +		name =3D (const char *)dentry->d_name.name;
> > +	} else {
> > +		snprintf(buf, sizeof(buf), "r=3D%lx", inode->i_ino);
> > +		name =3D buf;
> > +	}
> > +
> > +	va_start(args, fmt);
> > +	vaf.fmt =3D fmt;
> > +	vaf.va =3D &args;
> > +	printk("%s%s on %s: %pV", level, name, sb->s_id, &vaf);
> > +	va_end(args);
> > +
> > +	if (dentry) {
> > +		spin_unlock(&dentry->d_lock);
> > +		dput(dentry);
> > +	}
> > +}
>=20
> Remove level and use printk_get_level as above.
> Format string should use '\n' termination here too.
>=20

Thanks for pointing this out and for your effort with the patch, Joe. We wi=
ll rework logging in V3 so that it's more compliant with Kernel's approach.

