Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69B2F25D8D0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Sep 2020 14:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbgIDMmV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Sep 2020 08:42:21 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:49272 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729297AbgIDMmR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Sep 2020 08:42:17 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id C8382187;
        Fri,  4 Sep 2020 15:41:24 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1599223284;
        bh=4xVR0meJIvh1rEibqmfyPtAJgTOGQBkBefyqLtNjf1I=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=BGzSa721zbnxxY03ztTSlOE5OcXrCC8OiYOjYvqGqOMPC9JYVgbZU96tL5lslDc1u
         AMOVX1VXIETE1IIaYkYwcbfRxyc4TkQJtUH+UVynYJLf5qvO01aO1fg5Df/5ZPLzMe
         CV0p0vm3Vh2uSezYcJUoHJlvfdsiEq6AeTcKbtyE=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 4 Sep 2020 15:41:24 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%6]) with mapi
 id 15.01.1847.003; Fri, 4 Sep 2020 15:41:24 +0300
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
Thread-Index: AQHWfUkmGGliHMdep0qOFBeV9s6Y96lNd7cAgAr+VLA=
Date:   Fri, 4 Sep 2020 12:41:24 +0000
Message-ID: <d82dae3c12d94db7a2a212a8b8b79e8b@paragon-software.com>
References: <20200828143938.102889-1-almaz.alexandrovich@paragon-software.com>
 <20200828143938.102889-5-almaz.alexandrovich@paragon-software.com>
 <20200828154544.GJ1236603@ZenIV.linux.org.uk>
In-Reply-To: <20200828154544.GJ1236603@ZenIV.linux.org.uk>
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

From: Al Viro <viro@ftp.linux.org.uk>
Sent: Friday, August 28, 2020 6:46 PM
> On Fri, Aug 28, 2020 at 07:39:32AM -0700, Konstantin Komarov wrote:
>=20
> > +static struct dentry *__ntfs_lookup(struct inode *dir, struct dentry *=
dentry,
> > +				    struct ntfs_fnd *fnd)
> > +{
> > +	struct dentry *d;
> > +	struct inode *inode;
> > +
> > +	inode =3D dir_search(dir, &dentry->d_name, fnd);
> > +
> > +	if (!inode) {
> > +		d_add(dentry, NULL);
> > +		d =3D NULL;
> > +		goto out;
> > +	}
> > +
> > +	if (IS_ERR(inode)) {
> > +		d =3D ERR_CAST(inode);
> > +		goto out;
> > +	}
> > +
> > +	d =3D d_splice_alias(inode, dentry);
> > +	if (IS_ERR(d)) {
> > +		iput(inode);
> > +		goto out;
> > +	}
> > +
> > +out:
> > +	return d;
> > +}
>=20
> This is bollocks.  First and foremost, d_splice_alias() *does* iput() on
> failure, so you've got double-put there.  What's more
> 	* d_splice_alias(ERR_PTR(err), dentry) return err
> 	* d_splice_alias(NULL, dentry) is equivalent to d_add(dentry, NULL) and =
returns NULL
>=20
> IOW, all that boilerplate could be replaced with one line:
>=20
> 	return d_splice_alias(dir_search(dir, &dentry->d_name, fnd), dentry);

Hi Al! Agreed. Will be fixed in v4.
Thanks.
