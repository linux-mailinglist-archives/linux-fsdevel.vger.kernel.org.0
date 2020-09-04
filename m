Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD2925D8EE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Sep 2020 14:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbgIDMtn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Sep 2020 08:49:43 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:47117 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729897AbgIDMtk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Sep 2020 08:49:40 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 07CAB821B3;
        Fri,  4 Sep 2020 15:49:36 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1599223776;
        bh=iIKIV8uVQGjpCl71N9fISrvkPdnOthL3MPyErRGWCRU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=YqJ5b7RTE6V/FIfsxYtmvuZ4kpP5mjYUA9+SRMfTJhzfeoN6c+zgCXRDCeQJ0pmdr
         mplAk1Ui+agCayfsK38nIXf6/izOceqV14tQIcSNm8Il1sdRnQl0Ua8QkdVFyAV0IC
         rGyaKODhvPPUHkVTlxLY3QlNn1PtbVuJ/+4zyWnQ=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 4 Sep 2020 15:49:35 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%6]) with mapi
 id 15.01.1847.003; Fri, 4 Sep 2020 15:49:35 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pali@kernel.org" <pali@kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "aaptel@suse.com" <aaptel@suse.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "joe@perches.com" <joe@perches.com>,
        "mark@harmstone.com" <mark@harmstone.com>
Subject: RE: [PATCH v3 04/10] fs/ntfs3: Add file operations and implementation
Thread-Topic: [PATCH v3 04/10] fs/ntfs3: Add file operations and
 implementation
Thread-Index: AQHWfUkmGGliHMdep0qOFBeV9s6Y96lNenOAgAr+F6A=
Date:   Fri, 4 Sep 2020 12:49:35 +0000
Message-ID: <ff7c8d0f1aae4dad99f7c2139760c840@paragon-software.com>
References: <20200828143938.102889-1-almaz.alexandrovich@paragon-software.com>
 <20200828143938.102889-5-almaz.alexandrovich@paragon-software.com>
 <20200828155531.GK1236603@ZenIV.linux.org.uk>
In-Reply-To: <20200828155531.GK1236603@ZenIV.linux.org.uk>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.8.36]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@ftp.linux.org.uk> On Behalf Of Al Viro
Sent: Friday, August 28, 2020 6:56 PM
> On Fri, Aug 28, 2020 at 07:39:32AM -0700, Konstantin Komarov wrote:
>=20
> > +static int ntfs_atomic_open(struct inode *dir, struct dentry *dentry,
> > +			    struct file *file, u32 flags, umode_t mode)
> > +{
[]
> > +		if (d_really_is_positive(dentry)) {
> > +			if (file->f_mode & FMODE_OPENED) {
>=20
> 	How do we get FMODE_OPENED here?
>=20
> > +				dput(d);
> > +				err =3D 0;
> > +			} else
> > +				err =3D finish_no_open(file, d);
> > +			goto out1;
> > +		}
> > +		WARN_ON(d);
> > +	}
> > +
> > +	if (!(flags & O_CREAT)) {
> > +		err =3D -ENOENT;
> > +		goto out1;
> > +	}
>=20
> 	Just return finish_no_open() in that case.  And let the caller handle
> that.
>=20
> > +	err =3D ntfs_create_inode(dir, dentry, file, mode, 0, NULL, 0, excl, =
fnd,
> > +				&inode);
> > +
> > +out1:
> > +	fnd_put(fnd);
> > +out:
> > +	ni_unlock(ni);
> > +
> > +	return err;
> > +}
>=20
> BTW, what's the point of that ni_lock() here?  d_in_lookup() is stable
> regardless of that and any attempts to create something in the parent
> are serialized by ->i_rwsem.  If you want it around the actual file
> creation, why not take it just there, and replace the open-coded
> ntfs_lookup() with the call of the real thing?  As in
> 	if (d_in_lookup(dentry)) {
> 		d =3D ntfs_lookup(....);
> 		if (IS_ERR(d))
> 			return d;
> 		if (d)
> 			dentry =3D d;
> 	}
>         if (!(flags & O_CREAT) || d_really_is_positive(dentry))
> 		return finish_no_open(file, d);
> 	/* deal with creation of file */
> 	ni_lock(...);
> 	....

Thanks for the feedback! We refactored the atomic_open() based on
your concerns. Will be published in v4 patch today.
