Return-Path: <linux-fsdevel+bounces-41805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61438A3777E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2025 21:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 245801891ABF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2025 20:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF16F1A2846;
	Sun, 16 Feb 2025 20:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRKfaHzp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D9E199BC;
	Sun, 16 Feb 2025 20:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739738098; cv=none; b=EJ4uu2cpzf0OaLu5QWqW3yBiPeq9/Na/xU91eCrWqW01JkE0qWK+wYtsptFXusEfoyNon012mhgC0jMk9uvuEp74W/P5L1RlMcUYQJ5CHKH4oduiVuqOvOfz3xuXgW31yEvQivyIHBl4z+gECMHTAgVojYNHn0V2D/C+dfPqszM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739738098; c=relaxed/simple;
	bh=tbdZfNwPywGgHW6/+NQifvp4+EhJly+SbEaGC6px/K0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VpYH+j1qt8HYrMReeaFRR0irTt2EhSzKIc1xrW6AvtJIEly4fmyI499lZY8gTkqgduydr25w83Ek43/nKvA5qURXpWHAAKphccnhZetvarAARRisvwgECaqhAmrHaHIXKRiUUy5O5AHRpUTlneJfY/E+njGcw5UuVhWtYq43jkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jRKfaHzp; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-abb7f539c35so231620866b.1;
        Sun, 16 Feb 2025 12:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739738094; x=1740342894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nvb9ZLL31KBMxONAQ2Am53GDyU5AuCZFJJf/PtswdNs=;
        b=jRKfaHzpjugVbH5+6AE/NrfYO0RcV/25BWp/MnwNoHKnY95bS1sZzie1nIX6UVwFrR
         pPkFm2sqZj2K6fLo5oILaaRa8uROabH1qtzAsCdlpQXcALZkIw8dfion5iUg7nCFea5K
         bAeTHF6Her48g+EMM/EMhW884x4UV5suZXUrzdjxKSCM1lHFMlbZmRKFJjT/Ny6WQwLd
         j+Y4T9S6kTJmOK2iMzJZNRWo1K4IqClFep8vcnQlrzzO7Bz0AWeNamPXfRpXyLZpSjE3
         PJnlnkaM2eXn5JVn+6E0s0ziol/TicN0qbNnW4oxoBH+LCluIopbMbFXiiX+QCoku/IV
         kNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739738094; x=1740342894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nvb9ZLL31KBMxONAQ2Am53GDyU5AuCZFJJf/PtswdNs=;
        b=P73nB0nNQPiLRpBYyQEFy3+a9jxZMbxZjEgTPeYdIP87iPY3x0DvS/84Om21fC8V+N
         quLDBdGQAqWAuPAOQDdmboL4/2FRtqmHScQdRyPvV7uDHjnqnuFF86Qm3YbcuuQNj0lO
         jtbVYS/X1djelKz0g0HE7Gl3ItZzZuTTVR/pX47uue+uVyyakjf35ZlFXdaqBw+aqXyQ
         +SXk52V0W1Uq3BaJOzPUlR3Gkw57JC5tmSzZzRQeeLRNkcUSJ5jdmbRbKuKPyUfSVSTo
         HS54E7GProIdNNFls6J791Q5OZyWn77zaht9SgKO71rUyrxiWcLdBPLt/0iGFk9SWv5J
         qB9g==
X-Forwarded-Encrypted: i=1; AJvYcCUuua93zbF/0gVflO+mbfSYOAIfe/WvZyoEpByeLfSd/qujQi0RMXP707rodZbUQNwXWR0PvJ4xAVKv85gH5w==@vger.kernel.org, AJvYcCWEhVGu3WN5MuQtO+GNwGm54Lv8m+Njp7Z22iimT5y0xzVx0DQlwXb8UOdoQZpCJs7E1+I+0mdPrd4y1WxI@vger.kernel.org, AJvYcCXZyXYMNt44h0JDSeB/lfpSOAcxcAEwbOPrezCq1gQr4v6tbjZx6vRBtHwWst+7559c9SS2Z8LuHK87@vger.kernel.org
X-Gm-Message-State: AOJu0YzXPf1+3OSzjltTdVRFkiBBTMy2K6JehCa6EYjMzuEKfu5GB29D
	Fe0DbFgVmuihWeIb3eN/8G3V+atdNT5SN81zXR26BNwKjfEhDKeU69hwWj60p7pQT480KmqR5zE
	UDk1Z+5OL5S2ZzKtzzLbBXdB09dI=
X-Gm-Gg: ASbGncsCtSelUySZRqfhZmzOoFxwo4pL+dp8Nx8wNme1cPtHRzD3Jc5/Nn2TdDcEeaX
	Hjs2L+6kx3xMx7EOfkouDsu61HK76BFQOJOgO2H6ObrnIMZ4QzG8uIa/jL+yTDQjHXczZ+8tF
X-Google-Smtp-Source: AGHT+IF4xkXfTpXDqdyzoY+JM4F8EwDzom/5rXFcz0XnJ5xnjvbxxxkJpjOjdBGcro0oSiMGM9NfrWT3RQ9tZ3RPmco=
X-Received: by 2002:a17:906:4794:b0:ab7:e899:2de7 with SMTP id
 a640c23a62f3a-abb70b1eaccmr748319866b.14.1739738093391; Sun, 16 Feb 2025
 12:34:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250216164029.20673-1-pali@kernel.org> <20250216164029.20673-3-pali@kernel.org>
 <CAOQ4uxi0saGQYF5qgCKWu_mLNg8FZBHqZu3TvnqpY8v8Hmq-nQ@mail.gmail.com> <20250216200120.svl6w3vko7tdgedo@pali>
In-Reply-To: <20250216200120.svl6w3vko7tdgedo@pali>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 16 Feb 2025 21:34:42 +0100
X-Gm-Features: AWEUYZmGVCu1oXWs9eM7wsHUTPlOwrkTCVqZ_Aq9IHZrh-5hhnoNg0cQ12hPeU8
Message-ID: <CAOQ4uxi4V0ONe-Sapp8=vncs_F4zOb67_1EpFuydPs7iundZJA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] fs: Extend FS_IOC_FS[GS]ETXATTR API for Windows attributes
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, ronnie sahlberg <ronniesahlberg@gmail.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Steve French <sfrench@samba.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 16, 2025 at 9:01=E2=80=AFPM Pali Roh=C3=A1r <pali@kernel.org> w=
rote:
>
> On Sunday 16 February 2025 20:55:09 Amir Goldstein wrote:
> > On Sun, Feb 16, 2025 at 5:42=E2=80=AFPM Pali Roh=C3=A1r <pali@kernel.or=
g> wrote:
> > >
> > > struct fsxattr has 8 reserved padding bytes. Use these bytes for defi=
ning
> > > new fields fsx_xflags2, fsx_xflags2_mask and fsx_xflags_mask in backw=
ard
> > > compatible manner. If the new FS_XFLAG_HASEXTFIELDS flag in fsx_xflag=
s is
> > > not set then these new fields are treated as not present, like before=
 this
> > > change.
> > >
> > > New field fsx_xflags_mask for SET operation specifies which flags in
> > > fsx_xflags are going to be changed. This would allow userspace applic=
ation
> > > to change just subset of all flags. For GET operation this field spec=
ifies
> > > which FS_XFLAG_* flags are supported by the file.
> > >
> > > New field fsx_xflags2 specify new flags FS_XFLAG2_* which defines som=
e of
> > > Windows FILE_ATTRIBUTE_* attributes, which are mostly not going to be
> > > interpreted or used by the kernel, and are mostly going to be used by
> > > userspace. Field fsx_xflags2_mask then specify mask for them.
> > >
> > > This change defines just API without filesystem support for them. The=
se
> > > attributes can be implemented later for Windows filesystems like FAT,=
 NTFS,
> > > exFAT, UDF, SMB, NFS4 which all native storage for those attributes (=
or at
> > > least some subset of them).
> > >
> > > Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> > > ---
> > >  include/uapi/linux/fs.h | 36 +++++++++++++++++++++++++++++++-----
> > >  1 file changed, 31 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> > > index 367bc5289c47..93e947d6e604 100644
> > > --- a/include/uapi/linux/fs.h
> > > +++ b/include/uapi/linux/fs.h
> > > @@ -145,15 +145,26 @@ struct fsxattr {
> > >         __u32           fsx_nextents;   /* nextents field value (get)=
   */
> > >         __u32           fsx_projid;     /* project identifier (get/se=
t) */
> > >         __u32           fsx_cowextsize; /* CoW extsize field value (g=
et/set)*/
> > > -       unsigned char   fsx_pad[8];
> > > +       __u16           fsx_xflags2;    /* xflags2 field value (get/s=
et)*/
> > > +       __u16           fsx_xflags2_mask;/*mask for xflags2 (get/set)=
*/
> > > +       __u32           fsx_xflags_mask;/* mask for xflags (get/set)*=
/
> > > +       /*
> > > +        * For FS_IOC_FSSETXATTR ioctl, fsx_xflags_mask and fsx_xflag=
s2_mask
> > > +        * fields specify which FS_XFLAG_* and FS_XFLAG2_* flags from=
 fsx_xflags
> > > +        * and fsx_xflags2 fields are going to be changed.
> > > +        *
> > > +        * For FS_IOC_FSGETXATTR ioctl, fsx_xflags_mask and fsx_xflag=
s2_mask
> > > +        * fields specify which FS_XFLAG_* and FS_XFLAG2_* flags are =
supported.
> > > +        */
> > >  };
> > >
> > >  /*
> > > - * Flags for the fsx_xflags field
> > > + * Flags for the fsx_xflags and fsx_xflags_mask fields
> > >   */
> > >  #define FS_XFLAG_REALTIME      0x00000001      /* data in realtime v=
olume */
> > >  #define FS_XFLAG_PREALLOC      0x00000002      /* preallocated file =
extents */
> > > -#define FS_XFLAG_IMMUTABLE     0x00000008      /* file cannot be mod=
ified */
> > > +#define FS_XFLAG_IMMUTABLEUSER 0x00000004      /* file cannot be mod=
ified, changing this bit does not require CAP_LINUX_IMMUTABLE, equivalent o=
f Windows FILE_ATTRIBUTE_READONLY */
> >
> > So why not call it FS_XFLAG2_READONLY? IDGI
>
> Just because to show that these two flags are similar, just one is for
> root (or CAP_LINUX_IMMUTABLE) and another is for normal user.
>
> For example FreeBSD has also both flags (one for root and one for user)
> and uses names SF_IMMUTABLE and UF_IMMUTABLE.
>
> For me having FS_XFLAG_IMMUTABLE and FS_XFLAG2_READONLY sounds less
> clear, and does not explain how these two flags differs.
>

Yes, I understand, but I do not agree.

What is your goal here?

Do you want to implement FreeBSD UF_IMMUTABLE?
maybe UF_APPEND as well?
Did anyone ask for this functionality?
Not that I know of.
The requirement is to implement an API to the functionality known
as READONLY in SMB and NTFS. Right?

TBH, I did not study the semantics of READONLY, but I had a
strong feeling that if we looked closely, we will find that other things ar=
e
possible to do with READONLY files that are not possible with IMMUTABLE
files. So I asked ChatGPT and it told me that all these can be changed:
1. File Attributes (Hidden, System, Archive, or Indexed).
2. Permissions (ACL - Access Control List)
3. Timestamps
4. Alternate Data Streams (ADS)

I do not know if ChatGPT is correct, but it also told me that a READONLY
file can be deleted (without removing the flag first).

This is very very far from what IS_IMMUTABLE is.
IS_IMMUTABLE is immutable to any metadata change.

Thanks,
Amir.

