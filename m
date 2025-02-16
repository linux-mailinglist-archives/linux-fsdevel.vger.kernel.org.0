Return-Path: <linux-fsdevel+bounces-41799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48516A3774D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2025 20:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF24B168F8F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2025 19:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0617619E7F7;
	Sun, 16 Feb 2025 19:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WF3UQQNI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CD414A4DF;
	Sun, 16 Feb 2025 19:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739735724; cv=none; b=q8/F92VaBsa0UBxyvy3xEJoC4PwkrOdK4cP/hS2FpmeQLUYSCBJ8HnwXtIEXq6p1TwoSWTg1pDQvFRmc3efv/l4z7O4DhBAklCVLhKBe+F8Gj9R+WM0P0UveqEJlkMfJKvW2lMwTuHgm7dtfRvzbEAvdWnSAtW7OxVn4jR8qYWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739735724; c=relaxed/simple;
	bh=cUFwdCYp1y9cf9WgQ7945xolw8SU5jXmThPQFq26R3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ri/DgSI1nXzHmdiJ2WuCqFObvlgb4f0wqni3Q30XynkuBvuCDDtfm+OhtLJJywZoKkvQni1rYJ/AQOLl8HSpQNBrjUJ9A+GoEyM5tGoMpWI9HyXjcGPJFcSDzwV5HGebmhxRMWNhuXO2pxGzcE1IKeKYSNrToNdZ7gKl7Lky1pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WF3UQQNI; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-abb999658fbso35057466b.3;
        Sun, 16 Feb 2025 11:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739735721; x=1740340521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FjuEgIRPEVxOOOXwspmjErHTDOYB/IsuvwkVh9SDhiE=;
        b=WF3UQQNIZum36jc9IcpIiuGwVAS2aHrLlBP6x/LmwuRGX+JRK9f6gJDxTFZiJGL5Qo
         4LKlY2D2HqNmgJpE+lAArkgRdaCrFbYpgIkfGQ2ugYqwXcq8anT6+esLC5t0z4YlF4IG
         09s/1s0coM03uIxQ3Ddzh3yB5lpA7hGesK2iPQQ6ikcOYhuJybfd3jlJ5A8tPFE6hF4c
         4jWOE65Ma7Ft9NAFBLm8mUnQc36NQNYT4VA0FLRjA7byR4Eecl0PyyxDeq4+ar3ZYhwb
         an1tAq9kPteVoACOsLPF8dImum7cyFdgkozwhMVuRa5+xRNk9cNITMgV0I7EmEPsdcmD
         TvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739735721; x=1740340521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FjuEgIRPEVxOOOXwspmjErHTDOYB/IsuvwkVh9SDhiE=;
        b=HSZNtH79znkpV1I8mHWj/BevCA2E4Mkt4SIMzf31zEaJDgrqR/BN7TNArUdARL8xTk
         j0/mesjmInz2VWG/DKLSJFlKLlBtYx14oZvLMIYNKqNqZ0aRB2HIvltYGXd6dJZ3XwG3
         wuZzdvsgSFAXleQv8f0GACMhS2DqG/5ttTWCX1x/MN3LF5sphps6LkkJKvfMcEFvGPkG
         LabZ5wuCXAQtqrupXprSl/cLEV/fGqTGQtanjdtHkfrkSMNFUcZ8krV0SKzHLlztvQPL
         YkBC2EzhVi6/cninRM8frsPNpcRAZRks1FWZQN/BQOmXurYGftLcaKEANII5q7ceyPNg
         PM6w==
X-Forwarded-Encrypted: i=1; AJvYcCVHEuWQRItLNs2aM1yOsfRhjPvBhtM4ny0JpLF5o6igoCaqdLJ0+bqYHzPfwV0QkSjcbuTl9Rits53V@vger.kernel.org, AJvYcCWKsb64w/uYwl0ur1yL/1NM0hn/MSXm4bDBOm1sZgIRMH6tdbBZeQmOY8b9X/dcbAHdVXrqFVPE2n/0JZPi@vger.kernel.org, AJvYcCXGUj8knbPPZCrI8Cb+QBc8+ZT6kpzKAFxOBvFEgxilScHvKve8tHzpl+1+8yijwMQzVeL+rjwCV/TLkQh4+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsgrf05chZ2hh03HaXtfMNvacYYUxUgUgACKaRxoVi+/p9zuCy
	DUFFEzhpxD+Ja3I0QMXv0PmrMQrw7FbzX+Du8zp3jPdkSM8tNjLstLlIx21C/LIPq3v0P9BRke5
	Aw9yt/NS0fXQggtXy5FZ1b5RNF+g=
X-Gm-Gg: ASbGncsMroDzBXNipDmU5AbzPSUOe8Y5HXoFjOucepdun9zn2GBCSvduFBV37TXfFGc
	5NYEJ5HJStN9xDj+ulKdCY7Y1Eo4IJF0rYsEh5pI3b0/1HOqCwF864uvMDB0zxI22p/IfZgTC
X-Google-Smtp-Source: AGHT+IGeUh5D2COm7DcMHyM5fyROj+2hiuMiWSXd7/XaOT0L3NOIbBruVcshszxVHb/lbtMUy7x8ICnFwlGoJdcOB3w=
X-Received: by 2002:a05:6402:3547:b0:5dc:cf9b:b04a with SMTP id
 4fb4d7f45d1cf-5e035ff9d49mr16638900a12.1.1739735720389; Sun, 16 Feb 2025
 11:55:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250216164029.20673-1-pali@kernel.org> <20250216164029.20673-3-pali@kernel.org>
In-Reply-To: <20250216164029.20673-3-pali@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 16 Feb 2025 20:55:09 +0100
X-Gm-Features: AWEUYZlaY-TvdolXkAkXWU4H4qU60nI1n-YilFzKQFF4WUuxD4hzLDGa7m4iGBU
Message-ID: <CAOQ4uxi0saGQYF5qgCKWu_mLNg8FZBHqZu3TvnqpY8v8Hmq-nQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] fs: Extend FS_IOC_FS[GS]ETXATTR API for Windows attributes
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, ronnie sahlberg <ronniesahlberg@gmail.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Steve French <sfrench@samba.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 16, 2025 at 5:42=E2=80=AFPM Pali Roh=C3=A1r <pali@kernel.org> w=
rote:
>
> struct fsxattr has 8 reserved padding bytes. Use these bytes for defining
> new fields fsx_xflags2, fsx_xflags2_mask and fsx_xflags_mask in backward
> compatible manner. If the new FS_XFLAG_HASEXTFIELDS flag in fsx_xflags is
> not set then these new fields are treated as not present, like before thi=
s
> change.
>
> New field fsx_xflags_mask for SET operation specifies which flags in
> fsx_xflags are going to be changed. This would allow userspace applicatio=
n
> to change just subset of all flags. For GET operation this field specifie=
s
> which FS_XFLAG_* flags are supported by the file.
>
> New field fsx_xflags2 specify new flags FS_XFLAG2_* which defines some of
> Windows FILE_ATTRIBUTE_* attributes, which are mostly not going to be
> interpreted or used by the kernel, and are mostly going to be used by
> userspace. Field fsx_xflags2_mask then specify mask for them.
>
> This change defines just API without filesystem support for them. These
> attributes can be implemented later for Windows filesystems like FAT, NTF=
S,
> exFAT, UDF, SMB, NFS4 which all native storage for those attributes (or a=
t
> least some subset of them).
>
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> ---
>  include/uapi/linux/fs.h | 36 +++++++++++++++++++++++++++++++-----
>  1 file changed, 31 insertions(+), 5 deletions(-)
>
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index 367bc5289c47..93e947d6e604 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -145,15 +145,26 @@ struct fsxattr {
>         __u32           fsx_nextents;   /* nextents field value (get)   *=
/
>         __u32           fsx_projid;     /* project identifier (get/set) *=
/
>         __u32           fsx_cowextsize; /* CoW extsize field value (get/s=
et)*/
> -       unsigned char   fsx_pad[8];
> +       __u16           fsx_xflags2;    /* xflags2 field value (get/set)*=
/
> +       __u16           fsx_xflags2_mask;/*mask for xflags2 (get/set)*/
> +       __u32           fsx_xflags_mask;/* mask for xflags (get/set)*/
> +       /*
> +        * For FS_IOC_FSSETXATTR ioctl, fsx_xflags_mask and fsx_xflags2_m=
ask
> +        * fields specify which FS_XFLAG_* and FS_XFLAG2_* flags from fsx=
_xflags
> +        * and fsx_xflags2 fields are going to be changed.
> +        *
> +        * For FS_IOC_FSGETXATTR ioctl, fsx_xflags_mask and fsx_xflags2_m=
ask
> +        * fields specify which FS_XFLAG_* and FS_XFLAG2_* flags are supp=
orted.
> +        */
>  };
>
>  /*
> - * Flags for the fsx_xflags field
> + * Flags for the fsx_xflags and fsx_xflags_mask fields
>   */
>  #define FS_XFLAG_REALTIME      0x00000001      /* data in realtime volum=
e */
>  #define FS_XFLAG_PREALLOC      0x00000002      /* preallocated file exte=
nts */
> -#define FS_XFLAG_IMMUTABLE     0x00000008      /* file cannot be modifie=
d */
> +#define FS_XFLAG_IMMUTABLEUSER 0x00000004      /* file cannot be modifie=
d, changing this bit does not require CAP_LINUX_IMMUTABLE, equivalent of Wi=
ndows FILE_ATTRIBUTE_READONLY */

So why not call it FS_XFLAG2_READONLY? IDGI

Does anyone think that FS_XFLAG_IMMUTABLEUSER is more clear or something?

Thanks,
Amir.

> +#define FS_XFLAG_IMMUTABLE     0x00000008      /* file cannot be modifie=
d, changing this bit requires CAP_LINUX_IMMUTABLE */
>  #define FS_XFLAG_APPEND                0x00000010      /* all writes app=
end */
>  #define FS_XFLAG_SYNC          0x00000020      /* all writes synchronous=
 */
>  #define FS_XFLAG_NOATIME       0x00000040      /* do not update access t=
ime */
> @@ -167,10 +178,25 @@ struct fsxattr {
>  #define FS_XFLAG_FILESTREAM    0x00004000      /* use filestream allocat=
or */
>  #define FS_XFLAG_DAX           0x00008000      /* use DAX for IO */
>  #define FS_XFLAG_COWEXTSIZE    0x00010000      /* CoW extent size alloca=
tor hint */
> -#define FS_XFLAG_COMPRESSED    0x00020000      /* compressed file */
> -#define FS_XFLAG_ENCRYPTED     0x00040000      /* encrypted file */
> +#define FS_XFLAG_COMPRESSED    0x00020000      /* compressed file, equiv=
alent of Windows FILE_ATTRIBUTE_COMPRESSED */
> +#define FS_XFLAG_ENCRYPTED     0x00040000      /* encrypted file, equiva=
lent of Windows FILE_ATTRIBUTE_ENCRYPTED */
> +#define FS_XFLAG_CHECKSUMS     0x00080000      /* checksum for data and =
metadata, equivalent of Windows FILE_ATTRIBUTE_INTEGRITY_STREAM */
> +#define FS_XFLAG_HASEXTFIELDS  0x40000000      /* fields fsx_xflags_mask=
, fsx_xflags2 and fsx_xflags2_mask are present */
>  #define FS_XFLAG_HASATTR       0x80000000      /* no DIFLAG for this   *=
/
>
> +/*
> + * Flags for the fsx_xflags2 and fsx_xflags2_mask fields
> + */
> +#define FS_XFLAG2_HIDDEN       0x0001  /* inode is hidden, equivalent of=
 Widows FILE_ATTRIBUTE_HIDDEN */
> +#define FS_XFLAG2_SYSTEM       0x0002  /* inode is part of operating sys=
tem, equivalent of Windows FILE_ATTRIBUTE_SYSTEM */
> +#define FS_XFLAG2_ARCHIVE      0x0004  /* inode was not archived yet, eq=
uivalent of Windows FILE_ATTRIBUTE_ARCHIVE */
> +#define FS_XFLAG2_TEMPORARY    0x0008  /* inode content does not have to=
 preserved across reboots, equivalent of Windows FILE_ATTRIBUTE_TEMPORARY *=
/
> +#define FS_XFLAG2_NOTINDEXED   0x0010  /* inode will not be indexed by c=
ontent indexing service, equivalent of Windows FILE_ATTRIBUTE_NOT_CONTENT_I=
NDEXED */
> +#define FS_XFLAG2_NOSCRUBDATA  0x0020  /* file inode will not be checked=
 by scrubber (proactive background data integrity scanner), for directory i=
node it means that newly created child would have this flag set, equivalent=
 of Windows FILE_ATTRIBUTE_NO_SCRUB_DATA */
> +#define FS_XFLAG2_OFFLINE      0x0040  /* inode is marked as HSM offline=
, equivalent of Windows FILE_ATTRIBUTE_OFFLINE */
> +#define FS_XFLAG2_PINNED       0x0080  /* inode data content must be alw=
ays stored in local HSM storage, equivalent of Windows FILE_ATTRIBUTE_PINNE=
D */
> +#define FS_XFLAG2_UNPINNED     0x0100  /* inode data content can be remo=
ved from local HSM storage, equivalent of Windows FILE_ATTRIBUTE_UNPINNED *=
/
> +
>  /* the read-only stuff doesn't really belong here, but any other place i=
s
>     probably as bad and I don't want to create yet another include file. =
*/
>
> --
> 2.20.1
>

