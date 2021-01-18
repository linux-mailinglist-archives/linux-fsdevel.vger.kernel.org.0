Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293E12F9D1A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 11:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388965AbhARKrQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 05:47:16 -0500
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:43710 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389427AbhARKC2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 05:02:28 -0500
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 9F758437;
        Mon, 18 Jan 2021 13:00:53 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1610964053;
        bh=aAXmNjz4q5S0W0c0IZ1Bv7RcX/Rhi8sD8uJj4s1AT5I=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=O8ghBgYgNWPpgMYC+hBI2YeSoGvWMrjn+dnreqKMR8EHU3pJ1qhQpOaa9XfUNwXrW
         aAVH2pTNiHJgBE1S5d8sYhM9D42NbP33v/GSp4CSotLbZ2yLSlBxKNY5+hKbN+VHzA
         8enpxFdH0Vu3Ic0zhPgdBxP6VLuV1OneuxmitcHc=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Mon, 18 Jan 2021 13:00:53 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%6]) with mapi
 id 15.01.1847.003; Mon, 18 Jan 2021 13:00:53 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     Kari Argillander <kari.argillander@gmail.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pali@kernel.org" <pali@kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "aaptel@suse.com" <aaptel@suse.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "joe@perches.com" <joe@perches.com>,
        "mark@harmstone.com" <mark@harmstone.com>,
        "nborisov@suse.com" <nborisov@suse.com>,
        "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>,
        "anton@tuxera.com" <anton@tuxera.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "hch@lst.de" <hch@lst.de>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "andy.lavr@gmail.com" <andy.lavr@gmail.com>
Subject: RE: [PATCH v17 04/10] fs/ntfs3: Add file operations and
 implementation
Thread-Topic: [PATCH v17 04/10] fs/ntfs3: Add file operations and
 implementation
Thread-Index: AQHW34lDl37E64dyR0CcHdNH1rcznqoWRYIAgBb3I5A=
Date:   Mon, 18 Jan 2021 10:00:53 +0000
Message-ID: <cf76ecec5ec1419eacf4c170df65a57d@paragon-software.com>
References: <20201231152401.3162425-1-almaz.alexandrovich@paragon-software.com>
 <20201231152401.3162425-5-almaz.alexandrovich@paragon-software.com>
 <20210103215732.vbgcrf42xnao6gw2@kari-VirtualBox>
In-Reply-To: <20210103215732.vbgcrf42xnao6gw2@kari-VirtualBox>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.0.64]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Kari Argillander <kari.argillander@gmail.com>
Sent: Monday, January 4, 2021 12:58 AM
> To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> Cc: linux-fsdevel@vger.kernel.org; viro@zeniv.linux.org.uk; linux-kernel@=
vger.kernel.org; pali@kernel.org; dsterba@suse.cz;
> aaptel@suse.com; willy@infradead.org; rdunlap@infradead.org; joe@perches.=
com; mark@harmstone.com; nborisov@suse.com;
> linux-ntfs-dev@lists.sourceforge.net; anton@tuxera.com; dan.carpenter@ora=
cle.com; hch@lst.de; ebiggers@kernel.org;
> andy.lavr@gmail.com
> Subject: Re: [PATCH v17 04/10] fs/ntfs3: Add file operations and implemen=
tation
>=20
> On Thu, Dec 31, 2020 at 06:23:55PM +0300, Konstantin Komarov wrote:
> > This adds file operations and implementation
> >
> > Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software=
.com>
> > ---
> >  fs/ntfs3/dir.c     |  570 ++++++++
> >  fs/ntfs3/file.c    | 1140 ++++++++++++++++
> >  fs/ntfs3/frecord.c | 3088 ++++++++++++++++++++++++++++++++++++++++++++
> >  fs/ntfs3/namei.c   |  590 +++++++++
> >  fs/ntfs3/record.c  |  614 +++++++++
> >  fs/ntfs3/run.c     | 1254 ++++++++++++++++++
> >  6 files changed, 7256 insertions(+)
> >  create mode 100644 fs/ntfs3/dir.c
> >  create mode 100644 fs/ntfs3/file.c
> >  create mode 100644 fs/ntfs3/frecord.c
> >  create mode 100644 fs/ntfs3/namei.c
> >  create mode 100644 fs/ntfs3/record.c
> >  create mode 100644 fs/ntfs3/run.c
> >
> > diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
>=20
> > +int ntfs_file_fsync(struct file *filp, loff_t start, loff_t end, int d=
atasync)
> > +{
> > +	return generic_file_fsync(filp, start, end, datasync);
> > +}
>=20
> Do we have a reson why we implement this if we just use generic. Isn't
> it more clear if we use generic fsync straight away?
>=20
Hi! Indeed. Migration to the generic fsync will be introduced in v18.

> > +static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, lo=
ff_t len)
> > +{
>=20
> > +	/* Return error if mode is not supported */
> > +	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
> > +		     FALLOC_FL_COLLAPSE_RANGE))
> > +		return -EOPNOTSUPP;
>=20
> > +
> > +	if (mode & FALLOC_FL_PUNCH_HOLE) {
>=20
> > +	} else if (mode & FALLOC_FL_COLLAPSE_RANGE) {
>=20
> > +	} else {
> > +		/*
> > +		 * normal file: allocate clusters, do not change 'valid' size
> > +		 */
> > +		err =3D ntfs_set_size(inode, max(end, i_size));
> > +		if (err)
> > +			goto out;
> > +
> > +		if (is_sparsed(ni) || is_compressed(ni)) {
> > +			CLST vcn_v =3D ni->i_valid >> sbi->cluster_bits;
> > +			CLST vcn =3D vbo >> sbi->cluster_bits;
> > +			CLST cend =3D bytes_to_cluster(sbi, end);
> > +			CLST lcn, clen;
> > +			bool new;
> > +
> > +			/*
> > +			 * allocate but not zero new clusters (see below comments)
> > +			 * this breaks security (one can read unused on-disk areas)
> > +			 * zeroing these clusters may be too long
> > +			 * may be we should check here for root rights?
> > +			 */
> > +			for (; vcn < cend; vcn +=3D clen) {
> > +				err =3D attr_data_get_block(ni, vcn, cend - vcn,
> > +							  &lcn, &clen, &new);
> > +				if (err)
> > +					goto out;
> > +				if (!new || vcn >=3D vcn_v)
> > +					continue;
> > +
> > +				/*
> > +				 * Unwritten area
> > +				 * NTFS is not able to store several unwritten areas
> > +				 * Activate 'ntfs_sparse_cluster' to zero new allocated clusters
> > +				 *
> > +				 * Dangerous in case:
> > +				 * 1G of sparsed clusters + 1 cluster of data =3D>
> > +				 * valid_size =3D=3D 1G + 1 cluster
> > +				 * fallocate(1G) will zero 1G and this can be very long
> > +				 * xfstest 016/086 will fail whithout 'ntfs_sparse_cluster'
> > +				 */
> > +				/*ntfs_sparse_cluster(inode, NULL, vcn,
> > +				 *		    min(vcn_v - vcn, clen));
> > +				 */
> > +			}
> > +		}
> > +
> > +		if (mode & FALLOC_FL_KEEP_SIZE) {
>=20
> Isn't this hole else already (mode & FALLOC_FL_KEEP_SIZE?

Sorry, can you please clarify your question? Not sure, understood it.
>=20
> > +			ni_lock(ni);
> > +			/*true - keep preallocated*/
> > +			err =3D attr_set_size(ni, ATTR_DATA, NULL, 0,
> > +					    &ni->file.run, i_size, &ni->i_valid,
> > +					    true, NULL);
> > +			ni_unlock(ni);
> > +		}
> > +	}
> > +
> > +	if (!err) {
> > +		inode->i_ctime =3D inode->i_mtime =3D current_time(inode);
> > +		mark_inode_dirty(inode);
> > +	}
> > +out:
> > +	if (err =3D=3D -EFBIG)
> > +		err =3D -ENOSPC;
> > +
> > +	inode_unlock(inode);
> > +	return err;
> > +}
>=20
> > diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
>=20
> > +int mi_get(struct ntfs_sb_info *sbi, CLST rno, struct mft_inode **mi)
> > +{
> > +	int err;
> > +	struct mft_inode *m =3D ntfs_alloc(sizeof(struct mft_inode), 1);
> > +
> > +	if (!m)
> > +		return -ENOMEM;
> > +
> > +	err =3D mi_init(m, sbi, rno);
>=20
> If error happend should we just free end exit. Now we call mi_put() to
> clean up.
>=20

Done, will be fixed in v18.

> > +	if (!err)
> > +		err =3D mi_read(m, false);
> > +
> > +	if (err) {
> > +		mi_put(m);
> > +		return err;
> > +	}
> > +
> > +	*mi =3D m;
> > +	return 0;
> > +}
>=20
> > +struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
> > +{
> > +	const struct MFT_REC *rec =3D mi->mrec;
> > +	u32 used =3D le32_to_cpu(rec->used);
> > +	u32 t32, off, asize;
> > +	u16 t16;
> > +
> > +	if (!attr) {
> > +		u32 total =3D le32_to_cpu(rec->total);
> > +
> > +		off =3D le16_to_cpu(rec->attr_off);
> > +
> > +		if (used > total)
> > +			goto out;
> > +
> > +		if (off >=3D used || off < MFTRECORD_FIXUP_OFFSET_1 ||
> > +		    !IsDwordAligned(off)) {
> > +			goto out;
> > +		}
> > +
> > +		/* Skip non-resident records */
> > +		if (!is_rec_inuse(rec))
> > +			goto out;
> > +
> > +		attr =3D Add2Ptr(rec, off);
> > +	} else {
> > +		/* Check if input attr inside record */
> > +		off =3D PtrOffset(rec, attr);
> > +		if (off >=3D used)
> > +			goto out;
> > +
> > +		asize =3D le32_to_cpu(attr->size);
> > +		if (asize < SIZEOF_RESIDENT)
> > +			goto out;
> > +
> > +		attr =3D Add2Ptr(attr, asize);
> > +		off +=3D asize;
> > +	}
> > +
> > +	asize =3D le32_to_cpu(attr->size);
> > +
> > +	/* Can we use the first field (attr->type) */
> > +	if (off + 8 > used) {
> > +		static_assert(QuadAlign(sizeof(enum ATTR_TYPE)) =3D=3D 8);
> > +		goto out;
> > +	}
> > +
> > +	if (attr->type =3D=3D ATTR_END) {
> > +		if (used !=3D off + 8)
> > +			goto out;
>=20
> This if is not needed if there is return NULL after. But return
> NULL might also be bug.
>=20

Thanks, will also be fixed in v18.

> > +		return NULL;
> > +	}
> > +
> > +	t32 =3D le32_to_cpu(attr->type);
> > +	if ((t32 & 0xf) || (t32 > 0x100))
> > +		goto out;
> > +
> > +	/* Check boundary */
> > +	if (off + asize > used)
> > +		goto out;
> > +
> > +	/* Check size of attribute */
> > +	if (!attr->non_res) {
> > +		if (asize < SIZEOF_RESIDENT)
> > +			goto out;
> > +
> > +		t16 =3D le16_to_cpu(attr->res.data_off);
> > +
> > +		if (t16 > asize)
> > +			goto out;
> > +
> > +		t32 =3D le32_to_cpu(attr->res.data_size);
> > +		if (t16 + t32 > asize)
> > +			goto out;
> > +
> > +		return attr;
> > +	}
> > +
> > +	/* Check some nonresident fields */
> > +	if (attr->name_len &&
> > +	    le16_to_cpu(attr->name_off) + sizeof(short) * attr->name_len >
> > +		    le16_to_cpu(attr->nres.run_off)) {
> > +		goto out;
> > +	}
> > +
> > +	if (attr->nres.svcn || !is_attr_ext(attr)) {
> > +		if (asize + 8 < SIZEOF_NONRESIDENT)
> > +			goto out;
> > +
> > +		if (attr->nres.c_unit)
> > +			goto out;
> > +	} else if (asize + 8 < SIZEOF_NONRESIDENT_EX)
> > +		goto out;
> > +
> > +	return attr;
> > +
> > +out:
> > +	return NULL;
> > +}
>=20
> > diff --git a/fs/ntfs3/run.c b/fs/ntfs3/run.c
>=20
> > +static inline int run_packed_size(const s64 *n)
> > +{
> > +#ifdef __BIG_ENDIAN
>=20
> These are whole functions with ifdef. It would be maybe more clear
> that there really is whole functions to both endiand.
>=20

This is controversial question, but fixed as well (in v18).

> > +	const u8 *p =3D (const u8 *)n + sizeof(*n) - 1;
> > +
> > +	if (*n >=3D 0) {
> > +		if (p[-7] || p[-6] || p[-5] || p[-4])
> > +			p -=3D 4;
> > +		if (p[-3] || p[-2])
> > +			p -=3D 2;
> > +		if (p[-1])
> > +			p -=3D 1;
> > +		if (p[0] & 0x80)
> > +			p -=3D 1;
> > +	} else {
> > +		if (p[-7] !=3D 0xff || p[-6] !=3D 0xff || p[-5] !=3D 0xff ||
> > +		    p[-4] !=3D 0xff)
> > +			p -=3D 4;
> > +		if (p[-3] !=3D 0xff || p[-2] !=3D 0xff)
> > +			p -=3D 2;
> > +		if (p[-1] !=3D 0xff)
> > +			p -=3D 1;
> > +		if (!(p[0] & 0x80))
> > +			p -=3D 1;
> > +	}
> > +	return (const u8 *)n + sizeof(*n) - p;
>=20
> }
> #else
> static inline int run_packed_size(const s64 *n)
> {
>=20
> Something like this.
>=20
> > +	const u8 *p =3D (const u8 *)n;
> > +
> > +	if (*n >=3D 0) {
> > +		if (p[7] || p[6] || p[5] || p[4])
> > +			p +=3D 4;
> > +		if (p[3] || p[2])
> > +			p +=3D 2;
> > +		if (p[1])
> > +			p +=3D 1;
> > +		if (p[0] & 0x80)
> > +			p +=3D 1;
> > +	} else {
> > +		if (p[7] !=3D 0xff || p[6] !=3D 0xff || p[5] !=3D 0xff ||
> > +		    p[4] !=3D 0xff)
> > +			p +=3D 4;
> > +		if (p[3] !=3D 0xff || p[2] !=3D 0xff)
> > +			p +=3D 2;
> > +		if (p[1] !=3D 0xff)
> > +			p +=3D 1;
> > +		if (!(p[0] & 0x80))
> > +			p +=3D 1;
> > +	}
> > +
> > +	return 1 + p - (const u8 *)n;
> > +#endif
> > +}
> > +
> > +/*
> > + * run_pack
> > + *
> > + * packs runs into buffer
> > + * packed_vcns - how much runs we have packed
> > + * packed_size - how much bytes we have used run_buf
> > + */
> > +int run_pack(const struct runs_tree *run, CLST svcn, CLST len, u8 *run=
_buf,
> > +	     u32 run_buf_size, CLST *packed_vcns)
> > +{
> > +	CLST next_vcn, vcn, lcn;
> > +	CLST prev_lcn =3D 0;
> > +	CLST evcn1 =3D svcn + len;
> > +	int packed_size =3D 0;
> > +	size_t i;
> > +	bool ok;
> > +	s64 dlcn, len64;
> > +	int offset_size, size_size, t;
> > +	const u8 *p;
> > +
> > +	next_vcn =3D vcn =3D svcn;
> > +
> > +	*packed_vcns =3D 0;
> > +
> > +	if (!len)
> > +		goto out;
> > +
> > +	ok =3D run_lookup_entry(run, vcn, &lcn, &len, &i);
> > +
> > +	if (!ok)
> > +		goto error;
> > +
> > +	if (next_vcn !=3D vcn)
> > +		goto error;
> > +
> > +	for (;;) {
> > +		/* offset of current fragment relatively to previous fragment */
> > +		dlcn =3D 0;
>=20
> This dlcn
>=20
> > +		next_vcn =3D vcn + len;
> > +
> > +		if (next_vcn > evcn1)
> > +			len =3D evcn1 - vcn;
> > +
> > +		/*
> > +		 * mirror of len, but signed, because run_packed_size()
> > +		 * works with signed int only
> > +		 */
> > +		len64 =3D len;
> > +
> > +		/* how much bytes is packed len64 */
> > +		size_size =3D run_packed_size(&len64);
>=20
> Does (s64 *)&len work just fine?
>=20

In addition to Mattew's response:
NTFS by it's spec supports 64bit clusters, however ntfs.sys driver
uses 32bit clusters only. This is a default for ntfs3 as well, which may
be configured to 64bit as well. I.e. len may be both.

> > +
> > +		/* offset_size - how much bytes is packed dlcn */
> > +		if (lcn =3D=3D SPARSE_LCN) {
> > +			offset_size =3D 0;
>=20
> dlcn might be better to live here?
>=20

You are right, done.

> > +		} else {
> > +			/* NOTE: lcn can be less than prev_lcn! */
> > +			dlcn =3D (s64)lcn - prev_lcn;
> > +			offset_size =3D run_packed_size(&dlcn);
> > +			prev_lcn =3D lcn;
> > +		}
> > +=09
> > +		t =3D run_buf_size - packed_size - 2 - offset_size;
> > +		if (t <=3D 0)
> > +			goto out;
> > +
> > +		/* can we store this entire run */
> > +		if (t < size_size)
> > +			goto out;
> > +
> > +		if (run_buf) {
> > +			p =3D (u8 *)&len64;
> > +
> > +			/* pack run header */
> > +			run_buf[0] =3D ((u8)(size_size | (offset_size << 4)));
> > +			run_buf +=3D 1;
> > +
> > +			/* Pack the length of run */
> > +			switch (size_size) {
> > +#ifdef __BIG_ENDIAN
> > +			case 8:
> > +				run_buf[7] =3D p[0];
> > +				fallthrough;
> > +			case 7:
> > +				run_buf[6] =3D p[1];
> > +				fallthrough;
> > +			case 6:
> > +				run_buf[5] =3D p[2];
> > +				fallthrough;
> > +			case 5:
> > +				run_buf[4] =3D p[3];
> > +				fallthrough;
> > +			case 4:
> > +				run_buf[3] =3D p[4];
> > +				fallthrough;
> > +			case 3:
> > +				run_buf[2] =3D p[5];
> > +				fallthrough;
> > +			case 2:
> > +				run_buf[1] =3D p[6];
> > +				fallthrough;
> > +			case 1:
> > +				run_buf[0] =3D p[7];
> > +#else
> > +			case 8:
> > +				run_buf[7] =3D p[7];
> > +				fallthrough;
> > +			case 7:
> > +				run_buf[6] =3D p[6];
> > +				fallthrough;
> > +			case 6:
> > +				run_buf[5] =3D p[5];
> > +				fallthrough;
> > +			case 5:
> > +				run_buf[4] =3D p[4];
> > +				fallthrough;
> > +			case 4:
> > +				run_buf[3] =3D p[3];
> > +				fallthrough;
> > +			case 3:
> > +				run_buf[2] =3D p[2];
> > +				fallthrough;
> > +			case 2:
> > +				run_buf[1] =3D p[1];
> > +				fallthrough;
> > +			case 1:
> > +				run_buf[0] =3D p[0];
> > +#endif
> > +			}
>=20
> Why is this not own function? We use this like 5 places. Also isn't
> little endian just memcopy()
>=20

You are right, for little endiand this is just memcopy, but if it isn't
inlined, we will have overhead calling the function.

> > +
> > +			run_buf +=3D size_size;
> > +			p =3D (u8 *)&dlcn;
>=20
> I think that when we have function for that switch tmp p is not needed
> anymore.
>=20

Yes, but this doesn't give more readability or simplification I think.
More of a personal preference.

> > +
> > +			/* Pack the offset from previous lcn */
> > +			switch (offset_size) {
> > +#ifdef __BIG_ENDIAN
> > +			case 8:
> > +				run_buf[7] =3D p[0];
> > +				fallthrough;
> > +			case 7:
> > +				run_buf[6] =3D p[1];
> > +				fallthrough;
> > +			case 6:
> > +				run_buf[5] =3D p[2];
> > +				fallthrough;
> > +			case 5:
> > +				run_buf[4] =3D p[3];
> > +				fallthrough;
> > +			case 4:
> > +				run_buf[3] =3D p[4];
> > +				fallthrough;
> > +			case 3:
> > +				run_buf[2] =3D p[5];
> > +				fallthrough;
> > +			case 2:
> > +				run_buf[1] =3D p[6];
> > +				fallthrough;
> > +			case 1:
> > +				run_buf[0] =3D p[7];
> > +#else
> > +			case 8:
> > +				run_buf[7] =3D p[7];
> > +				fallthrough;
> > +			case 7:
> > +				run_buf[6] =3D p[6];
> > +				fallthrough;
> > +			case 6:
> > +				run_buf[5] =3D p[5];
> > +				fallthrough;
> > +			case 5:
> > +				run_buf[4] =3D p[4];
> > +				fallthrough;
> > +			case 4:
> > +				run_buf[3] =3D p[3];
> > +				fallthrough;
> > +			case 3:
> > +				run_buf[2] =3D p[2];
> > +				fallthrough;
> > +			case 2:
> > +				run_buf[1] =3D p[1];
> > +				fallthrough;
> > +			case 1:
> > +				run_buf[0] =3D p[0];
> > +#endif
> > +			}
>=20
> > +int run_get_highest_vcn(CLST vcn, const u8 *run_buf, u64 *highest_vcn)
> > +{
>=20
> > +		/* skip size_size */
> > +		run +=3D size_size;
> > +
> > +		if (!len)
> > +			goto error;
> > +
> > +		run +=3D offset_size;
>=20
> Can this be straight
> run +=3D size_size + offset_size;
>=20

Done.

> > +
> > +#ifdef NTFS3_64BIT_CLUSTER
> > +		if ((vcn >> 32) || (len >> 32))
> > +			goto error;
> > +#endif
> > +		vcn64 +=3D len;
> > +	}
> > +
> > +	*highest_vcn =3D vcn64 - 1;
> > +	return 0;
> > +}
