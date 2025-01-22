Return-Path: <linux-fsdevel+bounces-39824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74922A18E10
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 10:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20D051886F1F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 09:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CAD20FAB4;
	Wed, 22 Jan 2025 09:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ute6+765"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693C11BC9F6;
	Wed, 22 Jan 2025 09:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737536751; cv=none; b=jepNJNZKoylaan8ne0lssnSX0LWbb+LrAsgoR4sCOmrPKyal01Y/jMuJjOeycAw7xyEE23/bwY2U/NOOXPmGmp/sHCv1MNGdH4VzZgVtAwSiQvgCOXZAwtNiikHl/LGxexC/93XjBglpGFm3YYHSOsPg5njWp6Ue60a9FIAFNTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737536751; c=relaxed/simple;
	bh=3RRmpZxmAoe1uIw4WI7VUakriYibc2DFuvjmFJ3pSeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TzOds5N62lFP1g20Ypq0dvRcoXIPnLTd48WVwdSTcpb6RCSCgMN+GBDOSufcxL9XbHVf74HzaJ3Lu1weJ1XFFBkp9rvRONey6BOIdXPU9eYHvWTwwCS2cib8ODpZ9YKeFjYJ7YUTXl3qC1rG/20XX2NttnkCLspMy/a7zbEgSdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ute6+765; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d9f0a6ad83so4398223a12.2;
        Wed, 22 Jan 2025 01:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737536748; x=1738141548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0vRmHoSrgU1nPWeuH0WqSKgeGcll17yciHQbL0asNDA=;
        b=Ute6+765jFyodSC2PffP4yGGT8NXVAag1dk5o/mDzCflG/U+Jppn06DzUc2GhgmADX
         LA70pKhmkUAQzkK8sIq8Cpb5WBYh+bWddUhCtyGL248vScUYZHPZ6fs9YFAGGP8Mw5Bg
         BVOqhki8ofdTL5D3lXh3T+MSL88nyECjXfdxy6rIIsrnCIjJ8KHRcQyJJtS07XlEIClW
         kByhKd4cuSs8Kx+bLwrtPG39KyxGFHDJ+XvwxCqhWRmiubbvDc5PvNaHrmVoeELxzABi
         r2FrdxO+pfTuc/ENY59B/m+nFCwFwXjlnXX5TEM3rNZhw6lsBSZZh7UyZXqQ0K0XvMOJ
         q2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737536748; x=1738141548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0vRmHoSrgU1nPWeuH0WqSKgeGcll17yciHQbL0asNDA=;
        b=pMkNmY3DX4uVjU4elKp8mdz5nk4zOrOTqYeV8z4WvjGfvYPzPZkVI9xEC671+sA9zp
         yvvamRgxujp6lCHlBG+WDxH6im6GBro02pyEslox/qg8W+rVgS5HUaTarZsx8MvgqANq
         mj0w+M3WVGqA4X6T0QDX2L9VywLXgOmMtrfE54+ThXw9f1fgQDxvpUPnLooV75FlLwCr
         MLyaJGF3DfXG4zilvk/GVDLSr7mz5cFboqT9/w0O0lv4d1tS6CNiX1TYcsO9lOuKWOrb
         ghLULFp9MdAJo0hqw+TUeKYT/JU/uJXBhUuGX2KKCK5WhqZ5SeIXOdTRbp4cjver2NKs
         Cxaw==
X-Forwarded-Encrypted: i=1; AJvYcCUikTIQGFoeeHu4UtHkrre8D2Fu1SMVquRcOJokhULb1N2tRBzVNs8CHpWlxp4yb+Exjhm+U9MUAQOmRfDm@vger.kernel.org, AJvYcCX4l0fsSF7d3ZzWByu+zQeVA5LA7T1YaAS4PARb5EbYCC7CfqJPyHKycZF/p2bs67WKlLfle6PL6Muc@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg9VPd27WTCRzoDXa3BJqDFIBXknmMr/d5mudEvw48IdkX5Fdc
	QolXAJrPOVZHQduAtmDSZD718r/J8remUFegZ72FVoTsOs5H9mEJ+PjA4DPT7D9brYQ4abewO7O
	5XDbhHTJ0iPd/2EYQSOjle1vopao=
X-Gm-Gg: ASbGncva8l4kNci7nEC0isKh+lCA93UeHBrKqToLbr5O3Cd544Htl/1pyuSXUu02fKp
	Th6rixbTaYnNzFHYSGrvi1n2oMMwTtFH1fX2OICtsjxgRBRH//KI=
X-Google-Smtp-Source: AGHT+IETsyA++uT3CJZEqDhwbzFtZoINbmEq0iZs6sydjpak197Sd0WPTWd0YlrQn2O8yq8bvZ7nCiWGneC+NIiDnDE=
X-Received: by 2002:a17:906:7953:b0:aa6:6885:e2fa with SMTP id
 a640c23a62f3a-ab38b26f4acmr1722528766b.14.1737536747162; Wed, 22 Jan 2025
 01:05:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxh4PS0d6HuHCM_GTfNDpkM1EJ5G55Fs83tDRW0bGu2v-A@mail.gmail.com>
 <173750034870.22054.1620003974639602049@noble.neil.brown.name>
In-Reply-To: <173750034870.22054.1620003974639602049@noble.neil.brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 22 Jan 2025 10:05:35 +0100
X-Gm-Features: AbW1kvY23JMUBUXQOt8kQHHyYSxHI09hU7DHT8V2lCY2VddmflSX8bjQa04cMQo
Message-ID: <CAOQ4uxiXC8Xa7zEKYeJ0pADg3Mq19jpA6uEtZfG1QORzuZy9gQ@mail.gmail.com>
Subject: Re: [PATCH v2] nfsd: map EBUSY to NFS4ERR_ACCESS for all operations
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, Trond Myklebust <trondmy@hammerspace.com>, 
	Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 11:59=E2=80=AFPM NeilBrown <neilb@suse.de> wrote:
>
> On Wed, 22 Jan 2025, Amir Goldstein wrote:
> > On Tue, Jan 21, 2025 at 8:45=E2=80=AFPM Chuck Lever <chuck.lever@oracle=
.com> wrote:
> > >
> > > Please send patches To: the NFSD reviewers listed in MAINTAINERS and
> > > Cc: linux-nfs and others. Thanks!
> > >
> > >
> > > On 1/21/25 5:39 AM, Amir Goldstein wrote:
> > > > Commit 466e16f0920f3 ("nfsd: check for EBUSY from vfs_rmdir/vfs_uni=
nk.")
> > > > mapped EBUSY host error from rmdir/unlink operation to avoid unknow=
n
> > > > error server warning.
> > >
> > > > The same reason that casued the reported EBUSY on rmdir() (dir is a
> > > > local mount point in some other bind mount) could also cause EBUSY =
on
> > > > rename and some filesystems (e.g. FUSE) can return EBUSY on other
> > > > operations like open().
> > > >
> > > > Therefore, to avoid unknown error warning in server, we need to map
> > > > EBUSY for all operations.
> > > >
> > > > The original fix mapped EBUSY to NFS4ERR_FILE_OPEN in v4 server and
> > > > to NFS4ERR_ACCESS in v2/v3 server.
> > > >
> > > > During the discussion on this issue, Trond claimed that the mapping
> > > > made from EBUSY to NFS4ERR_FILE_OPEN was incorrect according to the
> > > > protocol spec and specifically, NFS4ERR_FILE_OPEN is not expected
> > > > for directories.
> > >
> > > NFS4ERR_FILE_OPEN might be incorrect when removing certain types of
> > > file system objects. Here's what I find in RFC 8881 Section 18.25.4:
> > >
> > >  > If a file has an outstanding OPEN and this prevents the removal of=
 the
> > >  > file's directory entry, the error NFS4ERR_FILE_OPEN is returned.
> > >
> > > It's not normative, but it does suggest that any object that cannot b=
e
> > > associated with an OPEN state ID should never cause REMOVE to return
> > > NFS4ERR_FILE_OPEN.
> > >
> > >
> > > > To keep things simple and consistent and avoid the server warning,
> > > > map EBUSY to NFS4ERR_ACCESS for all operations in all protocol vers=
ions.
> > >
> > > Generally a "one size fits all" mapping for these status codes is
> > > not going to cut it. That's why we have nfsd3_map_status() and
> > > nfsd_map_status() -- the set of permitted status codes for each
> > > operation is different for each NFS version.
> > >
> > > NFSv3 has REMOVE and RMDIR. You can't pass a directory to NFSv3 REMOV=
E.
> > >
> > > NFSv4 has only REMOVE, and it removes the directory entry for the
> > > object no matter its type. The set of failure modes is different for
> > > this operation compared to NFSv3 REMOVE.
> > >
> > > Adding a specific mapping for -EBUSY in nfserrno() is going to have
> > > unintended consequences for any VFS call NFSD might make that returns
> > > -EBUSY.
> > >
> > > I think I prefer that the NFSv4 cases be dealt with in nfsd4_remove()=
,
> > > nfsd4_rename(), and nfsd4_link(), and that -EBUSY should continue to
> > > trigger a warning.
> > >
> > >
> >
> > Sorry, I didn't understand what you are suggesting.
> >
> > FUSE can return EBUSY for open().
> > What do you suggest to do when nfsd encounters EBUSY on open()?
> >
> > vfs_rename() can return EBUSY.
> > What do you suggest to do when nfsd v3 encounters EBUSY on rename()?
> >
> > This sort of assertion:
> >         WARN_ONCE(1, "nfsd: non-standard errno: %d\n", errno);
> >
> > Is a code assertion for a situation that should not be possible in the
> > code and certainly not possible to trigger by userspace.
> >
> > Both cases above could trigger the warning from userspace.
> > If you want to leave the warning it should not be a WARN_ONCE()
> > assertion, but I must say that I did not understand the explanation
> > for not mapping EBUSY by default to NFS4ERR_ACCESS in nfserrno().
>
> My answer to this last question is that it isn't obvious that EBUSY
> should map to NFS4ERR_ACCESS.
> I would rather that nfsd explicitly checked the error from unlink/rmdir a=
nd
> mapped EBUSY to NFS4ERR_ACCESS (if we all agree that is best) with a
> comment (like we have now) explaining why it is best.

Can you please suggest the text for this comment because I did not
understand the reasoning for the error.
All I argued for is conformity to NFSv2/3, but you are the one who chose
NFS3ERR_ACCES for v2/3 mapping and I don't know what is the
reasoning for this error code. All I have is:
"For NFSv3, the best we can do is probably NFS3ERR_ACCES,
  which isn't true, but is not less true than the other options."

> And nfsd should explicitly check the error from open() and map EBUSY to
> whatever seems appropriate.  Maybe that is also NS4ERR_ACCESS but if it
> is, the reason is likely different to the reason that it is best for
> rmdir.
> So again, I would like a comment in the code explaining the choice with
> a reference to FUSE.

My specific FUSE filesystem can return EBUSY for open(), but FUSE
filesystem in general can return EBUSY for any operation if that is what
the userspace server returns.

>
> Then if some other function that we haven't thought about starts
> returning EBUSY, we'll get warning and have a change to think about it.
>

I have no objection to that, but I think that the WARN_ONCE should be
converted to pr_warn_once() or pr_warn_ratelimited() because userspace
should not be able to trigger a WARN_ON in any case.

I realize the great value of the stack trace that WARN_ON provides in
this scenario, but if we include in the warning the operation id and the
filesystem sid I think that would be enough information to understand
where the unmapped error is coming from.

This is not expected stop the whack-a-mole of patches like mine and this on=
e:
340e61e44c1d2 ("nfsd: map the EBADMSG to nfserr_io to avoid warning")
but at least the severity of the issues will be reduced without the scary
WARN_ON splat.

I can write a patch if there is an agreement on that.

Thanks,
Amir.

