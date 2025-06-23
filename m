Return-Path: <linux-fsdevel+bounces-52575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5230AE45C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 16:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B81D61886399
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 14:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB5151C5A;
	Mon, 23 Jun 2025 14:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3J3XxW0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4623D24B26;
	Mon, 23 Jun 2025 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750687225; cv=none; b=nmn3uU8+oSk+5kgFJn5fAJ4NuwjqTj3RvW9ZcC7VSRmD9pK4wQK1DqeBetlULWzaXDNIuxP7lWFWebQ9LnqK/AZo8zt22VubJfqtHLRmGA1AqxOToqExIpOTKzf4i2b9VyaWD1NUmQaOrTNy8YTeViJfznV0tzApvH8r7kWHqqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750687225; c=relaxed/simple;
	bh=vp8nzhyVufPZQuMb9n47ViecmwT/NSKPUuj/YWX5rFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZHIsWvD2XSricRDyg+Ko6xf0spkZXXcbcWiXrtmTGjjIlyGjAyFCDiW84sUOyCxqrCxOe9SeKwgflscopApzNl7Z6j8rUdKAw8ly3PWpAF4HirvO/lzV1ZugoAuFTRg0sGGZbHTYCFe67KkvP9j1pbo/JWGijcAXKfD0ceDGhzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3J3XxW0; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-609c6afade7so9675994a12.1;
        Mon, 23 Jun 2025 07:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750687221; x=1751292021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P8kRXLlacyg1IoWkjPz3YkxKCyN2r99lIN3ebI2CEIw=;
        b=Y3J3XxW0iyLdXszpU6nhmREBSXKvj4xJ49O4pTvZVL2OOtov0pQ/Iuj2Vp66xh0Fng
         f9SYUU/I+vh1+htDHxO+/UFfU85Dk339ZE1N6fk5GgGuNlk2uJ5X2k0R4fUXIvcf7lQn
         YaQfYJ5xpvNrvR/sBVk7JQXAMZwabjmmT+IF8aB/6DDycrH3bZYPFPzP5lleq2ybl4NL
         pT3tDATshhq66TeRuK8Ch47rIPbGf1q+npq2xvXNOPZz/ftVV+UCYbcxr+nuGRdUaZVN
         Ik3LAuN5vCWeXrtXVT75m8MUjk4MExLIEZSbjRIKB9Su8+KPdpeL3G+1Zarq3x/Mdf1y
         LJ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750687221; x=1751292021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P8kRXLlacyg1IoWkjPz3YkxKCyN2r99lIN3ebI2CEIw=;
        b=MuemxkoNgEB1nPb/e3BKJ+IsuKBtvenVErqiXrW/7fku+8qaG//+lkvh7jPEUSchJ9
         Kp7NNgWXDPySxsNurUlFd8ZtvfiSPu+kSH5Ng7hntgfk37raef+O8/MR2zI0s522SMxW
         n8HX1RGytiE8d7Kl1Um3ZOtAiMaNw/0N4lbDnKqqg3gCSliCGfWzv/Yd0Qm2VVg/JGAv
         J0Omk9P3fFortq17LhUA0xBPNXLsu+cUnniTBjkqpXBGAXGQbVEJIyjF3xdKN53atS6C
         T5nCNLZFqUq/RAmcqSdJZbhom4mMq0d1MH8PtWgxDGB/kt9XnuOKzJ8HVaLSKiEVs82U
         EYgg==
X-Forwarded-Encrypted: i=1; AJvYcCVMosOGHwop6UUYv5WD36kefTwTbMLmO5VG6/mRKu2gyTbLX9QZvjEI0pJzD4qAx4+dF6EADClaaF4e@vger.kernel.org, AJvYcCX4az+rEl8zE5i4ZxtuYt4L8eUbtaxUThfuwSDuTu5ao9CUDSYIQw5rJDF2QJA5u8NvT0P19aQfwaZBOrEh@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4oqr3KGHoAJ02na4R3dl3bwNs6Pf84vsDUR3uOjLmw4Pl0AlO
	7lioab7DWs4p0bW7AWSBpSmruVZQSVAu4869N4bJaj1yFkpgpngB/Fx0RcPqQppirEssmckdggS
	6CYCNUaEyovHwXCqCuYG8276iIMOawNk=
X-Gm-Gg: ASbGncvlN/Kr6ogyYd3go4AXPbUwXPEG8rSpJaldtBBFsynMv7NVJoycQrT7uu/tdQr
	ickLKD2UkQcaGD41+JrV3+1Ftw5Luhc3M6zacQdzd56M+pN3uBhnn749HLmjwkrqIblKFZlXHa4
	TL08fezrca0CI+o95D0WdfGI/yp3mCLLPsjlZUT3iId2E=
X-Google-Smtp-Source: AGHT+IFi8L9ZYu+UkU+cD+/lIoM+yBb+XfhCjwvihHkHjtEt/O4pCHo/sfK4zfR/AB950GBf6xJwOuFOJm/zz5W87Rs=
X-Received: by 2002:a17:907:7255:b0:ad5:a122:c020 with SMTP id
 a640c23a62f3a-ae05afc075amr1166295566b.16.1750687221048; Mon, 23 Jun 2025
 07:00:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623-work-pidfs-fhandle-v1-0-75899d67555f@kernel.org>
 <20250623-work-pidfs-fhandle-v1-8-75899d67555f@kernel.org>
 <ipk5yr7xxdmesql6wqzlbs734jjvn3had5vzqrck6e2ke4zanu@6sotvp4bd5lu>
 <20250623-wegnehmen-fragen-9dfdfdf0b2af@brauner> <CAOQ4uxjZy8tc_tOChJ_r_FPkUxE0qrz0CxmKeJj2MZ7wyhLpBw@mail.gmail.com>
 <20250623-notstand-aufkreuzen-7e558b3b8f7e@brauner> <nbiurss2to6tvxu2oybpyn2bjcocxal3hqjtzqjol2vw3zs3pp@m5kf4kbr4mxl>
In-Reply-To: <nbiurss2to6tvxu2oybpyn2bjcocxal3hqjtzqjol2vw3zs3pp@m5kf4kbr4mxl>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 23 Jun 2025 16:00:09 +0200
X-Gm-Features: AX0GCFvkfa_fTYvVJpBkYetdAa8aL5kBttT7ZpNwf_-UzGvl3kqoXOpI1OMDMSc
Message-ID: <CAOQ4uxjOXuhbi-txJMS7j6A=jiydirPmGrNuVWyAibZmkwpF0Q@mail.gmail.com>
Subject: Re: [PATCH 8/9] fhandle, pidfs: support open_by_handle_at() purely
 based on file handle
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 3:21=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 23-06-25 15:00:43, Christian Brauner wrote:
> > On Mon, Jun 23, 2025 at 02:54:00PM +0200, Amir Goldstein wrote:
> > > On Mon, Jun 23, 2025 at 2:25=E2=80=AFPM Christian Brauner <brauner@ke=
rnel.org> wrote:
> > > >
> > > > On Mon, Jun 23, 2025 at 02:06:43PM +0200, Jan Kara wrote:
> > > > > On Mon 23-06-25 11:01:30, Christian Brauner wrote:
> > > > > > Various filesystems such as pidfs (and likely drm in the future=
) have a
> > > > > > use-case to support opening files purely based on the handle wi=
thout
> > > > > > having to require a file descriptor to another object. That's e=
specially
> > > > > > the case for filesystems that don't do any lookup whatsoever an=
d there's
> > > > > > zero relationship between the objects. Such filesystems are als=
o
> > > > > > singletons that stay around for the lifetime of the system mean=
ing that
> > > > > > they can be uniquely identified and accessed purely based on th=
e file
> > > > > > handle type. Enable that so that userspace doesn't have to allo=
cate an
> > > > > > object needlessly especially if they can't do that for whatever=
 reason.
> > > > > >
> > > > > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > > >
> > > > > Hmm, maybe we should predefine some invalid fd value userspace sh=
ould pass
> > > > > when it wants to "autopick" fs root? Otherwise defining more spec=
ial fd
> > > > > values like AT_FDCWD would become difficult in the future. Or we =
could just
> > > >
> > > > Fwiw, I already did that with:
> > > >
> > > > #define PIDFD_SELF_THREAD               -10000 /* Current thread. *=
/
> > > > #define PIDFD_SELF_THREAD_GROUP         -20000 /* Current thread gr=
oup leader. */
> > > >
> > > > I think the correct thing to do would have been to say anything bel=
ow
> > > >
> > > > #define AT_FDCWD                -100    /* Special value for dirfd =
used to
> > > >
> > > > is reserved for the kernel. But we can probably easily do this and =
say
> > > > anything from -10000 to -40000 is reserved for the kernel.
> > > >
> > > > I would then change:
> > > >
> > > > #define PIDFD_SELF_THREAD               -10000 /* Current thread. *=
/
> > > > #define PIDFD_SELF_THREAD_GROUP         -10001 /* Current thread gr=
oup leader. */
> > > >
> > > > since that's very very new and then move
> > > > PIDFD_SELF_THREAD/PIDFD_SELF_THREAD_GROUP to include/uapi/linux/fcn=
tl.h
> > > >
> > > > and add that comment about the reserved range in there.
> > > >
> > > > The thing is that we'd need to enforce this on the system call leve=
l.
> > > >
> > > > Thoughts?
> > > >
> > > > > define that FILEID_PIDFS file handles *always* ignore the fd valu=
e and
> > > > > auto-pick the root.
> > > >
> > > > I see the issue I don't think it's a big deal but I'm open to addin=
g:
> > > >
> > > > #define AT_EBADF -10009 /* -10000 - EBADF */
> > > >
> > > > and document that as a stand-in for a handle that can't be resolved=
.
> > > >
> > > > Thoughts?
> > >
> > > I think the AT prefix of AT_FDCWD may have been a mistake
> > > because it is quite easy to confuse this value with the completely
> > > unrelated namespace of AT_ flags.
> > >
> > > This is a null dirfd value. Is it not?
> >
> > Not necessarily dirfd. We do allow direct operations of file descriptor
> > of any type. For example, in the mount api where you can mount files
> > onto other files.
> >
> > >
> > > FD_NULL, FD_NONE?
> >
> > FD_INVALID, I think.
> >
> > >
> > > You could envision that an *at() syscalls could in theory accept
> > > (FD_NONE , "/an/absolute/path/only", ...
> > >
> > > or MOUNTFD_NONE if we want to define a constant specifically for
> > > this open_by_handle_at() extension.
> >
> > I think this is useful beyond open_by_handle_at().
>
> Yes, defining FD_INVALID seems like useful addition that may become usefu=
l
> in other cases in the future as well.

Sounds good to me.

Thanks,
Amir.

