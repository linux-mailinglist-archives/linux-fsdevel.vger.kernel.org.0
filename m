Return-Path: <linux-fsdevel+bounces-40951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD916A29890
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 19:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6827816729F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 18:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17341FCF5B;
	Wed,  5 Feb 2025 18:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToHVoxxM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481A01DE2C1;
	Wed,  5 Feb 2025 18:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738779419; cv=none; b=RrPNM2ZPr+HQ81cmUGZgqZQAjh5gjL36tiAT0ixi9/IUKpz59XFKQ9gMKEh08llBVtCKwaX7xJRUbiB2F3uNW+WADaiZYgEjtcjBf5SqJ7IxMNFTqZcYj6njbV36V34yTKWjpKLc7bZLwq5fPFF9MJe7iFD9q3SJM1of66WcXMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738779419; c=relaxed/simple;
	bh=swy9UIt6rQ6rsisbYwB8QtBRf5xRoozbACII/GoFBZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZt24owpd7RgUUNxd7iBGKIoG8ne+p1qeqsmI2nyBm3a7P3tGXLS5zqK/1khFFeEipn2LTd+8YHd+TyF/g8G7jxNTH0dXdYkvsgFryEVOGjnkWio4FOXU/emmVk1oxHcNXvrEH35kRTMKZzmbZAPVLWIMd4us/BfCAGUd8oPIg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ToHVoxxM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC6CC4CED1;
	Wed,  5 Feb 2025 18:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738779418;
	bh=swy9UIt6rQ6rsisbYwB8QtBRf5xRoozbACII/GoFBZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ToHVoxxMuEtdnprPYlsl+qi9dxbi70+iKvxe2L2aY1U9ft6B5wOLs2BpE9LBiJVnZ
	 iZqYG3rjT5wABW8Ti1+rXMfayp038wWveYPVQSIlwlaAqNOF3jlonMp3psqWHQh2ZB
	 73t8oib06PogNJqKBk5vSuGIciC49eL7v2VFxSsksn8UVybfW9a21Ol8zyzJchCm9w
	 zoJTCH+i/fmeLB4AQopz0qrkhcIY1dNX0NtAsF3DE1oikm2a4szP/0Q457V5dOvR6V
	 u/INHooODSDOaKFlSBTZ2zd0O8f/NJiCpZLjnpnOji9x5/T2MDjc2oE7Cdj2oidmQ0
	 7jhPGdEwvFQgg==
Received: by pali.im (Postfix)
	id 25DF74FC; Wed,  5 Feb 2025 19:16:46 +0100 (CET)
Date: Wed, 5 Feb 2025 19:16:45 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	ronnie sahlberg <ronniesahlberg@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Steve French <sfrench@samba.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Immutable vs read-only for Windows compatibility
Message-ID: <20250205181645.4ps3kzafyasg4dgj@pali>
References: <CAOQ4uxhh1LDz5zXzqFENPhJ9k851AL3E7Xc2d7pSVVYX4Fu9Jw@mail.gmail.com>
 <20250117185947.ylums2dhmo3j6hol@pali>
 <20250202152343.ahy4hnzbfuzreirz@pali>
 <CAOQ4uxgjbHTyQ53u=abWhyQ81ATL4cqSeWKDfOjz-EaR0NGmug@mail.gmail.com>
 <20250203221955.bgvlkp273o3wnzmf@pali>
 <CAOQ4uxhkB6oTJm7DvQxFbxkQ1u_KMUFEL0eWKVYf39hnuYrnfQ@mail.gmail.com>
 <20250203233403.5a5pcgl5xylj47nb@pali>
 <CAOQ4uxisXgDOuE1oDH6qtLYoiFeG55kjpUJaXDxZ+tp2ck++Sg@mail.gmail.com>
 <20250204212638.3hhlbc5muutnlluw@pali>
 <CAOQ4uxg5k5FP43y93FRujj54kVk8TyXD2AeO_VFJ2m+aB=b1_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxg5k5FP43y93FRujj54kVk8TyXD2AeO_VFJ2m+aB=b1_Q@mail.gmail.com>
User-Agent: NeoMutt/20180716

On Wednesday 05 February 2025 17:33:30 Amir Goldstein wrote:
> On Tue, Feb 4, 2025 at 10:26 PM Pali Rohár <pali@kernel.org> wrote:
> >
> > On Tuesday 04 February 2025 12:54:01 Amir Goldstein wrote:
> > > On Tue, Feb 4, 2025 at 12:34 AM Pali Rohár <pali@kernel.org> wrote:
> > > >
> > > > On Tuesday 04 February 2025 00:02:44 Amir Goldstein wrote:
> > > > > On Mon, Feb 3, 2025 at 11:20 PM Pali Rohár <pali@kernel.org> wrote:
> > > > > >
> > > > > > On Monday 03 February 2025 22:59:46 Amir Goldstein wrote:
> > > > > > > On Sun, Feb 2, 2025 at 4:23 PM Pali Rohár <pali@kernel.org> wrote:
> > > > > > > > And there is still unresolved issue with FILE_ATTRIBUTE_READONLY.
> > > > > > > > Its meaning is similar to existing Linux FS_IMMUTABLE_FL, just
> > > > > > > > FILE_ATTRIBUTE_READONLY does not require root / CAP_LINUX_IMMUTABLE.
> > > > > > > >
> > > > > > > > I think that for proper support, to enforce FILE_ATTRIBUTE_READONLY
> > > > > > > > functionality, it is needed to introduce new flag e.g.
> > > > > > > > FS_IMMUTABLE_FL_USER to allow setting / clearing it also for normal
> > > > > > > > users without CAP_LINUX_IMMUTABLE. Otherwise it would be unsuitable for
> > > > > > > > any SMB client, SMB server or any application which would like to use
> > > > > > > > it, for example wine.
> > > > > > > >
> > > > > > > > Just to note that FreeBSD has two immutable flags SF_IMMUTABLE and
> > > > > > > > UF_IMMUTABLE, one settable only by superuser and second for owner.
> > > > > > > >
> > > > > > > > Any opinion?
> > > > > > >
> > > > > > > For filesystems that already support FILE_ATTRIBUTE_READONLY,
> > > > > > > can't you just set S_IMMUTABLE on the inode and vfs will do the correct
> > > > > > > enforcement?
> > > > > > >
> > > > > > > The vfs does not control if and how S_IMMUTABLE is set by filesystems,
> > > > > > > so if you want to remove this vfs flag without CAP_LINUX_IMMUTABLE
> > > > > > > in smb client, there is nothing stopping you (I think).
> > > > > >
> > > > > > Function fileattr_set_prepare() checks for CAP_LINUX_IMMUTABLE when
> > > > > > trying to change FS_IMMUTABLE_FL bit. This function is called from
> > > > > > ioctl(FS_IOC_SETFLAGS) and also from ioctl(FS_IOC_FSSETXATTR).
> > > > > > And when function fileattr_set_prepare() fails then .fileattr_set
> > > > > > callback is not called at all. So I think that it is not possible to
> > > > > > remove the IMMUTABLE flag from userspace without capability for smb
> > > > > > client.
> > > > > >
> > > > >
> > > > > You did not understand what I meant.
> > > > >
> > > > > You cannot relax the CAP_LINUX_IMMUTABLE for setting FS_IMMUTABLE_FL
> > > > > and there is no reason that you will need to relax it.
> > > > >
> > > > > The vfs does NOT enforce permissions according to FS_IMMUTABLE_FL
> > > > > The vfs enforces permissions according to the S_IMMUTABLE in-memory
> > > > > inode flag.
> > > > >
> > > > > There is no generic vfs code that sets S_IMMUTABLE inode flags, its
> > > > > the filesystems that translate the on-disk FS_IMMUTABLE_FL to
> > > > > in-memory S_IMMUTABLE inode flag.
> > > > >
> > > > > So if a filesystem already has an internal DOSATTRIB flags set, this
> > > > > filesystem can set the in-memory S_IMMUTABLE inode flag according
> > > > > to its knowledge of the DOSATTRIB_READONLY flag and the
> > > > > CAP_LINUX_IMMUTABLE rules do not apply to the DOSATTRIB_READONLY
> > > > > flag, which is NOT the same as the FS_IMMUTABLE_FL flag.
> > > > >
> > > > > > And it would not solve this problem for local filesystems (ntfs or ext4)
> > > > > > when Samba server or wine would want to set this bit.
> > > > > >
> > > > >
> > > > > The Samba server would use the FS_IOC_FS[GS]ETXATTR ioctl
> > > > > API to get/set dosattrib, something like this:
> > > > >
> > > > > struct fsxattr fsxattr;
> > > > > ret = ioctl_get_fsxattr(fd, &fsxattr);
> > > > > if (!ret && fsxattr.fsx_xflags & FS_XFLAG_HASDOSATTR) {
> > > > >     fsxattr.fsx_dosattr |= fs_dosattrib_readonly;
> > > > >     ret = ioctl_set_fsxattr(fd, &fsxattr);
> > > > > }
> > > >
> > > > Thanks for more explanation. First time I really did not understood it.
> > > > But now I think I understood it. So basically there would be two flags
> > > > which would result in setting S_IMMUTABLE on inode. One is the existing
> > > > FS_IMMUTABLE_FL which requires the capability and some new flag (e.g.
> > > > FS_XFLAG_HASDOSATTR) which would not require it and can be implemented
> > > > for cifs, vfat, ntfs, ... Right?
> > > >
> > >
> > > Well, almost right.
> > > The flag that would correspond to FILE_ATTRIBUTE_READONLY
> > > is FS_DOSATTRIB_READONLY from the new field fsx_dosattrib
> > > (see below)
> >
> > Thank you for example, it is for sure good starting point for me.
> >
> > > --- a/include/uapi/linux/fs.h
> > > +++ b/include/uapi/linux/fs.h
> > > @@ -145,7 +145,8 @@ struct fsxattr {
> > >         __u32           fsx_nextents;   /* nextents field value (get)   */
> > >         __u32           fsx_projid;     /* project identifier (get/set) */
> > >         __u32           fsx_cowextsize; /* CoW extsize field value (get/set)*/
> > > -       unsigned char   fsx_pad[8];
> > > +       __u32           fsx_dosattrib;  /* dosattrib field value (get/set) */
> > > +       unsigned char   fsx_pad[4];
> > >  };
> > >
> > >  /*
> > > @@ -167,7 +168,16 @@ struct fsxattr {
> > >  #define FS_XFLAG_FILESTREAM    0x00004000      /* use filestream allocator */
> > >  #define FS_XFLAG_DAX           0x00008000      /* use DAX for IO */
> > >  #define FS_XFLAG_COWEXTSIZE    0x00010000      /* CoW extent size
> > > allocator hint */
> > > -#define FS_XFLAG_HASATTR       0x80000000      /* no DIFLAG for this   */
> > > +#define FS_XFLAG_HASATTR       0x80000000      /* has extended attributes */
> > > +
> > > +/*
> > > + * Flags for the fsx_dosattrib field
> > > + */
> > > +#define FS_DOSATTRIB_READONLY  0x00000001      /* R - read-only */
> > > +#define FS_DOSATTRIB_HIDDEN    0x00000002      /* H - hidden */
> > > +#define FS_DOSATTRIB_SYSTEM    0x00000004      /* S - system */
> > > +#define FS_DOSATTRIB_ARCHIVE   0x00000020      /* A - archive */
> > > +#define FS_DOSATTRIB_HASATTR   0x80000000      /* has dos attributes */
> >
> > Should these FS_DOSATTRIB_* constants follows the Windows
> > FILE_ATTRIBUTE_* constants? Because I see that you put a gap between
> > system and archive.
> >
> 
> Well, no, they do not need to follow Windows contestants,
> but then again, why not?

I have just few cons:
- there are gaps and unused bits (e.g. FILE_ATTRIBUTE_VOLUME)
- there are bits which have more meanings (FILE_ATTRIBUTE_EA / FILE_ATTRIBUTE_RECALL_ON_OPEN)
- there are bits used only by WinAPI and not by NT / SMB
- there are bits which have different NT meaning in readdir() and in stat()
- there are bits for which we already have FS_IOC_GETFLAGS API

I think it that is is bad a idea if bit N in our ioctl() would have
different meaning than in our statx().

Should we duplicate FS_IOC_GETFLAGS FS_COMPR_FL and FS_ENCRYPT_FL into
that new fsx_dosattrib? For me it sounds like that it is a better idea
to have compression bit and encryption bit only in one field and not
duplicated.

But we can slightly follow Windows constants. Not exactly, but remove
redundancy, remove reserved bits, modify bits to have exactly one
meaning, etc... So basically do some sane modifications.

> I mean if we only ever needed the 4 RHSA bits above, we could
> have used the FS_XFLAG_* flags space, but if we extend the API
> with a new 32bit field, why not use 1-to-1 mapping at least as a starting point.

I understand it, for me it looks also a good idea, just needs to resolve
those problems above... and it would result in incompatibility that it
would not be 1-to-1 mapping at the end.

> You can see that it is quite common that filesystems re-define the
> same constants for these flags (e.g. EXT4_IMMUTABLE_FL).
> I am a bit surprised that there is no build time assertion
> BUILD_BUG_ON(EXT4_IMMUTABLE_FL != FS_IMMUTABLE_FL)
> which would be the standard way to make sure that the constants
> stay in sync if they need to be in sync, but some filesystems don't
> even assume that these constants are in sync (e.g. f2fs_fsflags_map)
> 
> > > This last special flag is debatable and I am not really sure that we need it.
> >
> > This constant has very similar meaning to FILE_ATTRIBUTE_NORMAL. Both
> > has some compatibility meaning that "field is valid or something is set".
> > Just FILE_ATTRIBUTE_NORMAL is not 31th bit.
> >
> 
> No it does not. I don't think that you understood the meaning of
> FS_DOSATTRIB_HASATTR.
> Nevermind it was a bad idea anyway. see more below.
> 
> > > It is needed for proper backward compat with existing userspace tools.
> > > For example, if there was a backup tool storing the fsxattr blob result of
> > > FS_IOC_FSGETXATTR and sets it later during restore with
> > > FS_IOC_FSSETXATTR, then it would be better to ignore a zero
> > > value of fsx_dosattrib instead of resetting all of the on-disk dosattrib flags
> > > if the restore happens after ntfs gained support for setting dosattrib flags
> > > via FS_IOC_FSSETXATTR.
> > >
> > > When using the standard tools to set fsxattr (chattr and xfs_io -c chattr)
> > > the tool does FS_IOC_FSGETXATTR + modify + FS_IOC_FSSETXATTR,
> > > so those tools are expected to leave new bits in fsx_dosattrib at their
> > > value if ntfs gains support for get/set fsx_dosattrib.
> > >
> > > Setting the auxiliary FS_DOSATTRIB_HASATTR flag can help the
> > > kernel/fs to explicitly state that the values returned in fsx_dosattrib
> > > are valid and the tool to state that values set in fsx_dosattrib are valid.
> > > But using a single flag will not help expanding ntfs support for more
> > > fsx_dosattrib flags later, so I am not sure if it is useful (?).
> >
> > If the fsx_dosattrib would match all FILE_ATTRIBUTE_* then we can do it
> > as the ntfs matches FILE_ATTRIBUTE_* and no extension is needed for
> > future.
> >
> > And I think that this backward compatibility sounds good.
> >
> 
> That's only true if you can support ALL the dosattrib flags from the
> first version and that Windows will not add any of the reserved
> flags in the future, which is hard to commit to.

I see, it would not work. And Windows will for sure use some reserved
bits in future.

> > What could be useful for userspace is also ability to figure out which
> > FS_DOSATTRIB_* are supported by the filesystem. Because for example UDF
> > on-disk format supports only FS_DOSATTRIB_HIDDEN bit. And FAT only those
> > attributes which are in the lowest byte.
> >
> 
> Exactly.
> statx has this solved with the stx_attributes_mask field.
> 
> We could do the same for FS_IOC_FS[GS]ETXATTR, but because
> right now, this API does not verify that fsx_pad is zero, we will need to
> define a new set of ioctl consants FS_IOC_[GS]ETFSXATTR2
> with the exact same functionality but that userspace knows that they
> publish and respect the dosattrib mask:

I understand and this is a problem.

> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -868,9 +868,11 @@ static int do_vfs_ioctl(struct file *filp, unsigned int fd,
>         case FS_IOC_SETFLAGS:
>                 return ioctl_setflags(filp, argp);
> 
> +       case FS_IOC_GETFSXATTR2:
>         case FS_IOC_FSGETXATTR:
>                 return ioctl_fsgetxattr(filp, argp);
> 
> +       case FS_IOC_SETFSXATTR2:
>         case FS_IOC_FSSETXATTR:
>                 return ioctl_fssetxattr(filp, argp);
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -145,7 +145,8 @@ struct fsxattr {
>         __u32           fsx_nextents;   /* nextents field value (get)   */
>         __u32           fsx_projid;     /* project identifier (get/set) */
>         __u32           fsx_cowextsize; /* CoW extsize field value (get/set)*/
> -       unsigned char   fsx_pad[8];
> +       __u32           fsx_dosattrib;  /* dosattrib field value (get/set) */
> +       __u32           fsx_dosattrib_mask; /* dosattrib field validity mask */
>  };
> 
>  /*
> @@ -238,6 +248,9 @@ struct fsxattr {
>  #define FS_IOC32_SETFLAGS              _IOW('f', 2, int)
>  #define FS_IOC32_GETVERSION            _IOR('v', 1, int)
>  #define FS_IOC32_SETVERSION            _IOW('v', 2, int)
> +#define FS_IOC_GETFSXATTR2              _IOR('x', 31, struct fsxattr)
> +#define FS_IOC_SETFSXATTR2              _IOW('x', 32, struct fsxattr)
> +/* Duplicate legacy ioctl numbers for backward compact */
>  #define FS_IOC_FSGETXATTR              _IOR('X', 31, struct fsxattr)
>  #define FS_IOC_FSSETXATTR              _IOW('X', 32, struct fsxattr)
>  #define FS_IOC_GETFSLABEL              _IOR(0x94, 49, char[FSLABEL_MAX])
> 
> We could also use this opportunity to define a larger fsxattr2 struct
> that also includes an fsx_xflags_mask field, so that the xflags namespace
> could also be extended in a backward compat way going forward:
> 
> @@ -145,7 +145,21 @@ struct fsxattr {
>         __u32           fsx_nextents;   /* nextents field value (get)   */
>         __u32           fsx_projid;     /* project identifier (get/set) */
>         __u32           fsx_cowextsize; /* CoW extsize field value (get/set)*/
>         unsigned char   fsx_pad[8];
> 
>  };
> +
> +/*
> + * Structure for FS_IOC_[GS]ETFSXATTR2.
> + */
> +struct fsxattr2 {
> +       __u32           fsx_xflags;     /* xflags field value (get/set) */
> +       __u32           fsx_extsize;    /* extsize field value (get/set)*/
> +       __u32           fsx_nextents;   /* nextents field value (get)   */
> +       __u32           fsx_projid;     /* project identifier (get/set) */
> +       __u32           fsx_cowextsize; /* CoW extsize field value (get/set)*/
> +       __u32           fsx_xflags_mask; /* xflags field validity mask */
> +       __u32           fsx_dosattrib;  /* dosattrib field value (get/set) */
> +       __u32           fsx_dosattrib_mask; /* dosattrib field validity mask */
> +};
> 
> And you'd also need to flug those new mask and dosattrib
> via struct fileattr into filesystems - too much to explain.
> try to figure it out (unless someone objects) and if you can't figure
> it out let me know.

Yea, I think that this is thing which I should be able to figure out
once I start changing it.

Anyway, I have alternative idea to the problem with fsx_pad. What about
introducing new fsx_xflags flag which would say that fsx_pad=fsx_dosattrib
is present? E.g.

#define FS_XFLAG_HASDOSATTRIB 0x40000000

Then we would not need new FS_IOC_GETFSXATTR2/FS_IOC_SETFSXATTR2 ioctls.

Also fsx_pad has 8 bytes, which can store both attrib and mask, so new
struct fsxattr2 would not be needed too.

> > >
> > > > > For ntfs/ext4, you will need to implement on-disk support for
> > > > > set/get the dosattrib flags.
> > > >
> > > > ntfs has already on-disk support for FILE_ATTRIBUTE_READONLY.
> > > >
> > >
> > > This is interesting.
> >
> > I mean that ntfs filesystem has support for FILE_ATTRIBUTE_READONLY.
> > I did not mean linux ntfs implementation.
> >
> > But I'm aware of some of those details in linux fs implementations, but
> > I did not wanted to mentioned it as basically every linux fs
> > implementation has its own way how flags are handled or exported to
> > userspace. It is good to know, but not important when designing or
> > discussing the unified/generic standard API.
> >
> 
> A good API will describe what the existing filesystems already support
> and what they do not support.
> 
> > > fat/ntfs both already have a mount option sys_immutable to map
> > > FILE_ATTRIBUTE_SYSTEM to S_IMMUTABLE in-memory.
> > >
> > > fat does not support fileattr_set(), but has a proprietary ioctl
> > > FAT_IOCTL_SET_ATTRIBUTES which enforces
> > > CAP_LINUX_IMMUTABLE for changing S_IMMUTABLE.
> > >
> > > ntfs also maps FILE_ATTRIBUTE_SYSTEM to S_IMMUTABLE
> > > and it allows changing FILE_ATTRIBUTE_SYSTEM via ntfs_setxattr
> > > of system.{dos,ntfs}_attrib without enforcing CAP_LINUX_IMMUTABLE,
> > > or any other permissions at all (?)
> > > This does not change S_IMMUTABLE in-memory, so change will
> > > only apply on the next time inode is loaded from disk.
> > > Bottom line: seems like *any user at all* can change the READONLY
> > > and SYSTEM attributes on ntfs.
> > >
> > > OTOH, ntfs does support fileattr_set() - it allows changing
> > > S_IMMUTABLE and S_APPEND in-memory, but as far as I can
> > > tell, this change is not stored on-disk (?).
> > >
> > > Also in ntfs, FILE_ATTRIBUTE_READONLY is mapped
> > > to not having posix write permissions on-disk:
> > >                 /* Linux 'w' -> Windows 'ro'. */
> > >                 if (0222 & inode->i_mode)
> > >                         ni->std_fa &= ~FILE_ATTRIBUTE_READONLY;
> > >                 else
> > >                         ni->std_fa |= FILE_ATTRIBUTE_READONLY;
> > >
> > > So for ntfs, S_IMMUTABLE could be updated depending on three
> > > independent flags: SYSTEM, READONLY and  FS_XFLAG_IMMUTABLE.
> > >
> > > Having ntfs treat FILE_ATTRIBUTE_READONLY as S_IMMUTABLE
> > > internally, is completely confined to ntfs and has nothing to do with vfs
> > > or with a new standard API.
> > >
> > > > On-disk support for ext4 and other linux filesystems can be discussed
> > > > later. I think that this could be more controversial.
> > > >
> > >
> > > Obviously there are existing users that need this.
> > > Samba has its own xattr user.DOSATTRIB and if people really want
> > > to be able to export those attributes in a standard way, I doubt there
> > > will be objection to adding on-disk support (e.g. to ext4/xfs).
> > > But somebody has to do the work and adding new on-disk support
> > > is not so easy.
> >
> > Yes, it is not easy and on-disk support can be done later or basically
> > independently of this work here. So I will let it for other people.
> >
> > > I can help with that when the time comes.
> > > First thing first, try to propose patches to extend fsx_dosattrib and
> > > support them in ntfs/fat/smb.
> >
> > Ok. Thanks.
> >
> > > > > I can certainly not change the meaning of existing on-disk
> > > > > flag of FS_IMMUTABLE_FL to a flag that can be removed
> > > > > without CAP_LINUX_IMMUTABLE. that changes the meaning
> > > > > of the flag.
> > > > >
> > > > > If ext4 maintainers agrees, you may be able to reuse some
> > > > > old unused on-disk flags (e.g.  EXT4_UNRM_FL) as storage
> > > > > place for FS_DOSATTRIB_READONLY, but that would be
> > > > > quite hackish.
> > > > >
> > > > > > > How about tackling this one small step at a time, not in that order
> > > > > > > necessarily:
> > > > > > >
> > > > > > > 1. Implement the standard API with FS_IOC_FS[GS]ETXATTR ioctl
> > > > > > >     and with statx to get/set some non-controversial dosattrib flags on
> > > > > > >     ntfs/smb/vfat
> > > > > > > 2. Wire some interesting dosattrib flags (e.g. compr/enrypt) to local
> > > > > > >     filesystems that already support storing those bits
> > > > > > > 3. Wire network servers (e.g. Samba) to use the generic API if supported
> > > > > > > 4. Add on-disk support for storing the dosattrib flags to more local fs
> > > > > > > 5. Update S_IMMUTABLE inode flag if either FS_XFLAG_IMMUTABLE
> > > > > > >     or FS_DOSATTRIB_READONLY are set on the file
> > > > > > >
> > > > > > > Thoughts?
> > > > > > >
> > > > >
> > > > > Anything wrong with the plan above?
> > > > > It seems that you are looking for shortcuts and I don't think that
> > > > > it is a good way to make progress.
> > > > >
> > > > > Thanks,
> > > > > Amir.
> > > >
> > > > If other developers agree that the FS_IOC_FS[GS]ETXATTR ioctl is the
> > > > right direction then for me it looks good.
> > >
> > > This thread has been going on for a while.
> > > I did not see any objections to this idea that Darrick proposed,
> > > so I think next step for you is to post patches, because some
> > > developers will only engage when there are patches to discuss.
> > >
> > > Thanks,
> > > Amir.
> >
> > Ok, I will try to prepare something. Just give me some weeks as would
> > not have time for this right now. I just wanted to be sure that this
> > is really the right direction and also that this is something which
> > makes sense. I did not wanted to start doing something which could be
> > completely useless... That is why I started rather longer discussion
> > first.
> 
> No rush on my side.
> You'd better wait a while to let other people comment before
> going to implement anything.
> 
> People often have many and different opinions when it comes
> to APIs design, so you will also need some patience to get to
> consensus.
> 
> Thanks,
> Amir.

Yes, that is fine. And thank you for your input.

