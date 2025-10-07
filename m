Return-Path: <linux-fsdevel+bounces-63550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A0CBC18AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 07 Oct 2025 15:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64FB91886784
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Oct 2025 13:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF082E0B6A;
	Tue,  7 Oct 2025 13:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="3JbK6vld"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FF22D46BB
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Oct 2025 13:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759844458; cv=none; b=qDdQAs1Yf4e/eIKLm1HoaJ7pDbU3E23+rHcYSzWsNmRgjEjxNPm97LrKqpIIeQKUwcvKea/qoD40aFAMQrSjAtV5kIW0tlXNi6+fXpayPgVNJW3EmERgPBkiS5YLy4kWXDnJ4SZKnYuwHQPZjYdJlU9jBBCZ3LwJT75EeKy4Pnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759844458; c=relaxed/simple;
	bh=maR5I0NRG+pVQzt1ZqXCzGrjCBiXFmvoqkdMd1ZLotw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LxK/ReCiggeu0dagGlV2NFyKtJ9i7+Bf9g8YpCvkX5QIe/E0+t8CIrbfqHKaMfu3i1f5XHm9pOEtOVZyuSL+qvWQWuBY7lCaFTqYu+Hz++fMbfdXN18IPCENLFDezHeU6Q3KZeCZkZSx4O0Te0SfEZazdRI02sGitfV2vQ6/4GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=3JbK6vld; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-36bf096b092so60879311fa.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Oct 2025 06:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1759844455; x=1760449255; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xRBV/A+wYkc5dgFJj6Y8p0jl0ix5QJORnEw5CJQ5ixk=;
        b=3JbK6vldew0Ih99+2O5z+sPBU1+pXLud6Z5ZFXgS8qonCHWcVHJVL/gMdEsJwJlvmT
         bjuhhLadvVxU8Q5Tps/QHY5Pnmtfg5+njXNVwccNEasAKvw2k/XumkQf7QHGTAH/hMRe
         WRMIlcbWyShAyEiwqlenIMrXhTHVHRhvjZmjRfu0KxGZuMHBIATZTJuP+gL4jRYNaKGe
         sGvWS8/DjJu/mZY4ZRzpaHgHiSXG5UiEg3pr3EvsEflD8QtzQnLKgP/gIc7WbKRLdAuY
         LIvMgUwh2HVvoYzI1vc+DsUrteMLPeSkQufo9fS4ByVDZ9VHvFNhknzF4OkLoe0xKy2l
         YbCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759844455; x=1760449255;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xRBV/A+wYkc5dgFJj6Y8p0jl0ix5QJORnEw5CJQ5ixk=;
        b=Bmddd8yKVnkD1hLiS2SRX/ZdaN+35w0uDvOCxcJZV/Y/mHMlNEsuH70v84rwtiQWa3
         4CLeQEGMA5FHhFbuUQJ5BwTM0XdlahHvHCpPhPnMrZkDY4ykB1wkeQdpUOwLD0Qk+j6z
         C6K5k0rrN300rsqEfbeL1DyU1kfWChElWLE90n8NhbVUpt4qu1izMDEEgPfY2zrdx1jK
         DBgATGEb+tXGUFv78QnilDr54cNV1KTtBP0TlCNinN+Kd/EwzFCVJzidBgJXWVTBXQBP
         lC/OOsl8gM6Ut6AzHyRx16E0H0Vj72umM0Od0xBq1WJFUny1uKATvTUweUeh8lTomsvF
         8qEw==
X-Forwarded-Encrypted: i=1; AJvYcCUOhz6PxoZIYRiPYcGOoDKDuvft/S3lpWqWmVlTyIjskOyMLpw+dT8muyz3lZd+axGypUJzgH61Hv819dyd@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp2jIAO+gfJlQITVgYQY9+2NKWqBOmX4s4v/5WQN7Lsp0C+cm4
	fWTNRuq+zgaV9zHxIcgavh+qn0ptguCVK0Bq7CkUaasrmopatc/E9XZ/BcEdTXH4P/K9TGQuEbt
	d95kyabc=
X-Gm-Gg: ASbGncuYRTydpw/TofVA4FbDwx5fuXsCRwvG1V//gA0ClvSlACiFNs4D/LlgaC+S6qf
	g+Z/XR3RC1r+y530tgbmBxqA/aoYd+MnMGvITx5s08bVsBAzp3hcMDOb6XK0RhWhB+929yutf9s
	WcCewHgU1mVxD/ZnOKfwtIA2oNP45/zNmo8uvSzfIPQaadhYsOPbASR1NzJCF/cSGSdF6j+49sU
	+IOHh7kv6xbMbk6ZqLTHStLhrfgKl0JAx3yjcnE1Rx+FJ789Dn8QbVKJyJkQeo1aj7rV6QhJJkn
	X2CSnAe2yV6NMac2wmylWjK5XwOM+Wy/2kfeqqYGRyITs5JFyT75C4dUTGhsD9Me8zJ4qnQCszx
	+YGqErpQfttUopP7hGLgRQSlt7eBpyr/ZCfSbWpE86LNrqwbMiwGkM/1DRcg=
X-Google-Smtp-Source: AGHT+IFHxO2m8T/MgbMT85edP7c603ruD5Ye6htT8rb/M8e+XOKBexOHQ+jUa0yBLYyuI5v4+gKA8w==
X-Received: by 2002:a05:6512:1245:b0:58a:92cc:581d with SMTP id 2adb3069b0e04-58cbbbee331mr4524737e87.50.1759844454433;
        Tue, 07 Oct 2025 06:40:54 -0700 (PDT)
Received: from [10.78.74.174] ([212.248.24.216])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59067823d9esm350641e87.69.2025.10.07.06.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 06:40:53 -0700 (PDT)
Message-ID: <6ec98658418f12b85e5161d28a59c48a68388b76.camel@dubeyko.com>
Subject: Re: [PATCH] hfs: Validate CNIDs in hfs_read_inode
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: George Anthony Vernon <contact@gvernon.com>, Viacheslav Dubeyko
	 <Slava.Dubeyko@ibm.com>
Cc: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>, 
 "frank.li@vivo.com"	 <frank.li@vivo.com>, "skhan@linuxfoundation.org"
 <skhan@linuxfoundation.org>,  "linux-fsdevel@vger.kernel.org"	
 <linux-fsdevel@vger.kernel.org>, "linux-kernel-mentees@lists.linux.dev"	
 <linux-kernel-mentees@lists.linux.dev>, 
 "syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com"	
 <syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com>, 
 "linux-kernel@vger.kernel.org"	 <linux-kernel@vger.kernel.org>
Date: Tue, 07 Oct 2025 06:40:50 -0700
In-Reply-To: <aOB3fME3Q4GfXu0O@Bertha>
References: <20251003024544.477462-1-contact@gvernon.com>
	 <405569eb2e0ec4ce2afa9c331eb791941d0cf726.camel@ibm.com>
	 <aOB3fME3Q4GfXu0O@Bertha>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 (flatpak git) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-10-04 at 02:25 +0100, George Anthony Vernon wrote:
> On Fri, Oct 03, 2025 at 10:40:16PM +0000, Viacheslav Dubeyko wrote:
> > Let's pay respect to previous efforts. I am suggesting to add this
> > line:
> >=20
> > Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> >=20
> > Are you OK with it?
> I agree with paying respect to Tetsuo. The kernel docs indicate that
> the SoB tag
> isn't used like that. Would the Suggested-by: tag be more
> appropriate?
>=20

Frankly speaking, I don't see how Suggested-by is applicable here. :)
My point was that if you mentioned the previous discussion, then it
means that you read it. And it sounds to me that your patch is
following to the points are discussed there. So, your code is
inevitably based on the code is shared during that discussion. This is
why I suggested the Signed-off-by. But if you think that it's not
correct logic for you, then I am completely OK. :)

> > I think we can declare like this:
> >=20
> > static inline
> > bool is_valid_cnid(unsigned long cnid, s8 type)
> >=20
> > Why cnid has unsigned long type? The u32 is pretty enough.
> Because struct inode's inode number is an unsigned long.

The Catalog Node ID (CNID) is identification number of item in Catalog
File of HFS/HFS+ file system. And it hasn't direct relation with inode
number. The Technical Note TN1150 [1] define it as:

The catalog node ID is defined by the CatalogNodeID data type.

typedef UInt32 HFSCatalogNodeID;

The hfs.h declares CNID as __be32 always. Also, hfsplus_raw.h defines
CNID as: typedef __be32 hfsplus_cnid;.

So, it cannot be bigger than 32 bits. But unsigned long could be bigger
than unsigned int. Potentially, unsigned long could be 64 bits on some
platforms.

> >=20
> > Why type has signed type (s8)? We don't expect negative values
> > here. Let's use
> > u8 type.
> Because the type field of struct hfs_cat_rec is an s8. Is there
> anything to gain
> by casting the s8 to a u8?
>=20

I am not completely sure that s8 was correct declaration type in struct
hfs_cat_rec and other ones. But if we will use s8 as input parameter,
then we could have soon another syzbot report about crash because this
framework has generated negative values as input parameter. And I would
like to avoid such situation by using u8 data type. Especially,
because, negative values don't make sense for type of object.

> >=20
> > > +{
> > > +	if (likely(cnid >=3D HFS_FIRSTUSER_CNID))
> > > +		return true;
> > > +
> > > +	switch (cnid) {
> > > +	case HFS_POR_CNID:
> > > +	case HFS_ROOT_CNID:
> > > +		return type =3D=3D HFS_CDR_DIR;
> > > +	case HFS_EXT_CNID:
> > > +	case HFS_CAT_CNID:
> > > +	case HFS_BAD_CNID:
> > > +	case HFS_EXCH_CNID:
> > > +		return type =3D=3D HFS_CDR_FIL;
> > > +	default:
> > > +		return false;
> >=20
> > We can simply have default that is doing nothing:
> >=20
> > default:
> > =C2=A0=C2=A0=C2=A0 /* continue logic */
> > =C2=A0=C2=A0=C2=A0 break;
> >=20
> > > +	}
> >=20
> > I believe that it will be better to return false by default here
> > (after switch).
> We can do that, but why would it be better, is it an optimisation? We
> don't have
> any logic to continue.

We have this function flow:

bool is_valid_cnid()
{
   if (condition)
      return <something>;

   switch () {
   case 1:
      return something;
   }
}

Some compilers can treat this like function should return value but has
no return by default. And it could generate warnings. So, this is why I
suggested to have return at the end of function by default.

>=20
> > > +			break;
> > > +		}
> > > =C2=A0		inode->i_size =3D be16_to_cpu(rec->dir.Val) + 2;
> > > =C2=A0		HFS_I(inode)->fs_blocks =3D 0;
> > > =C2=A0		inode->i_mode =3D S_IFDIR | (S_IRWXUGO & ~hsb-
> > > >s_dir_umask);
> >=20
> > We have practically the same check for the case of
> > hfs_write_inode():
> >=20
> > int hfs_write_inode(struct inode *inode, struct writeback_control
> > *wbc)
> > {
> > 	struct inode *main_inode =3D inode;
> > 	struct hfs_find_data fd;
> > 	hfs_cat_rec rec;
> > 	int res;
> >=20
> > 	hfs_dbg("ino %lu\n", inode->i_ino);
> > 	res =3D hfs_ext_write_extent(inode);
> > 	if (res)
> > 		return res;
> >=20
> > 	if (inode->i_ino < HFS_FIRSTUSER_CNID) {
> > 		switch (inode->i_ino) {
> > 		case HFS_ROOT_CNID:
> > 			break;
> > 		case HFS_EXT_CNID:
> > 			hfs_btree_write(HFS_SB(inode->i_sb)-
> > >ext_tree);
> > 			return 0;
> > 		case HFS_CAT_CNID:
> > 			hfs_btree_write(HFS_SB(inode->i_sb)-
> > >cat_tree);
> > 			return 0;
> > 		default:
> > 			BUG();
> > 			return -EIO;
> >=20
> > I think we need to select something one here. :) I believe we need
> > to remove
> > BUG() and return -EIO, finally. What do you think?=20
>=20
> I think that with validation of inodes in hfs_read_inode this code
> path should
> no longer be reachable by poking the kernel interface from userspace.
> If it is
> ever reached, it means kernel logic is broken, so it should be
> treated as a bug.
>=20

We already have multiple syzbot reports with kernel crashes for
likewise BUG() statements in HFS/HFS+ code. From one point of view, it
is better to return error instead of crashing kernel. From another
point of view, the 'return -EIO' is never called because we have BUG()
before. So, these two statements together don't make sense. This is why
I am suggesting to rework this code.

Thanks,
Slava.

> >=20
> > 		}
> > 	}
> >=20
> > <skipped>
> > }
> >=20
> > What's about to use your check here too?
>=20
> Let's do that, I'll include it in V2.
>=20
> >=20
> > Mostly, I like your approach but the patch needs some polishing
> > yet. ;)
> >=20
> > Thanks,
> > Slava.
>=20
> Thank you for taking the time to give detailed feedback, I really
> appreciate it.
>=20
> George

[1]
https://dubeyko.com/development/FileSystems/HFSPLUS/tn1150.html#CatalogFile

