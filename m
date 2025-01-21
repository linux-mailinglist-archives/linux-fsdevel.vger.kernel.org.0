Return-Path: <linux-fsdevel+bounces-39798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74770A18777
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 22:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D30F16207D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 21:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFF81F8908;
	Tue, 21 Jan 2025 21:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NR+cz3yM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65DE1F78E8;
	Tue, 21 Jan 2025 21:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737495878; cv=none; b=iXQxrI76BqiS5EorCl4d6/syecD3aG3hjlrSZ5dfkI3S6ivvMwcdqtv1f8z8g9FswCe89oVFgTSY+GBbkPyl3eVOU/gI65UZAhlAI1bNj1xOeMRIAadA/Bjwh8dbSuGUrPYzFN4IFaeheILwyRQ4JK3lqhJvV+rUX1JuwGPH7zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737495878; c=relaxed/simple;
	bh=HQ2fQltf0cvoSqUKK/4C9OZeu8bqSVsXMu1ELJoxhF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KIeccCfIwmdgM1gRdSeDrrN2Jp07JfrMPCnEvxWAno6UYC3JQpkG98LB/5p14f8UY70MOFACTeEiJxhN4GFNnLHpwHFw6iZcNDY3Lu0EJpcuPREu2SRBebaUz+sfvJiUP3e47H4fTGRvR9a8uKZkTaeI7NUvIwXpndJy0TNm0yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NR+cz3yM; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d3d0205bd5so10004002a12.3;
        Tue, 21 Jan 2025 13:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737495875; x=1738100675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGa8GGEi2xoA7dETBROw5QhceFKF0tNSzjx0PsmP81Q=;
        b=NR+cz3yMly+ZVWZaiXg0xP3KsTUhhvFFF3j0SOBnuBKW83ewpj7k2LKSirQ0IgYJuV
         40hVJPO9ztMcLGmoNA2lUe6/3ot9Om/4cDeEM2Mx8nqWWaz8JOyuAykNTRWk6RAuIEqh
         MVkLUeEe8TnEIVn03vL0sd5rQgbio517lyc5RqXt1SFWj0wBn5yG7RiZ70liB2AuFstD
         pIB7bR3exXBJ48eZePpJl6siJmjaut1D0PPZ7Jkax+bg5GslQqYmV6sR91MMmOCgrCoX
         fpS2HsSl9KT3e2epz3vbJLtVUljJ23UaXjF7awF49aXV/rl7mqEP+h9/sIsU5Y/XSltE
         IFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737495875; x=1738100675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGa8GGEi2xoA7dETBROw5QhceFKF0tNSzjx0PsmP81Q=;
        b=CilAXRcMluSrr/50NmC/MwCPXpEExpW10Tkod95ZX1/olz+X98OmStDaI/iHAy9CBX
         6oUkbUWXtSmX3nNQqPghNRhIXC4X4Vp0fOjiKK/nFqwQX+axQuHn9H2cKpt178bBN1Yi
         gDOX3nLXiz7WEE8CoSHUdOJEEKDmx/pOJ25beQJNFi9O0uhHnQXJpg3/2fpVUTieKsHl
         bBjrAeX3ln5hSsf/Of/xQwT0gxWGbFljX3oQymk9B1zOE2hOgmGJpIu38xoco4lop9pW
         bc5Eyw3jV5a124RFtScRAM/czbi3PuxvvhVCW2eXtsd+AI7ag4U4twKOpy5oU/cJUPzU
         kNcw==
X-Forwarded-Encrypted: i=1; AJvYcCVBBbI73TToul5t5g23nE0DmCh1+V6XAm6PA1weusjARpfbfF/Wj5GssoS2FM+/wnxuR1JohBEyW09G+jDD@vger.kernel.org, AJvYcCXPCYDDu1Fpqp5PmNaDSaDV6wlAp9vyADVqEzZfnW3OIzZAXc/ceMrPkKVDCSthS+cOxgmSm+fR0Wi6@vger.kernel.org
X-Gm-Message-State: AOJu0YxDKMW9vop8uPOK2TZwzk5hwV8rQqNjNEiSflqp/k9LgFpyxj/Q
	zp2lbUK2+qR6XAF9xCG2siIHqErkEtIwUkaMteItumFZrOmnwAVbX+SToun/2z52lJLAlLMcisz
	F7ir9wHze0eGPEWLjWDCQ0ugJS0Y=
X-Gm-Gg: ASbGncveHDRVWO2Pfdmij4OBTNsgU8i5JSL2Zp/NqtWlr+0S90/3bUjx5CG6AOt36bl
	Zrw8Sb4Q4louzIK7vBDoOE+o6tuys8Rx0ZZexYMWeQ8XFTOSo/4o=
X-Google-Smtp-Source: AGHT+IG1laRnncd4S5WR1QMv9Sw2KujDsk/j1Btblhy+3PmCDOaT1Vhe+IGLBg1Mr2jtSmH90s2Fyy39KMB7YaT1e3Q=
X-Received: by 2002:a05:6402:2808:b0:5d3:bab1:513f with SMTP id
 4fb4d7f45d1cf-5db7d3009b3mr20280388a12.18.1737495874704; Tue, 21 Jan 2025
 13:44:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121103954.415462-1-amir73il@gmail.com> <7d2299dc-b91a-4e23-924a-f3462b69d4bc@oracle.com>
In-Reply-To: <7d2299dc-b91a-4e23-924a-f3462b69d4bc@oracle.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 21 Jan 2025 22:44:23 +0100
X-Gm-Features: AbW1kvZWQK1N22pKr1M6Maf7lNUDnPRzWVsNHZ8c5ADP67ZkmebSWLxUsgWG4jU
Message-ID: <CAOQ4uxh4PS0d6HuHCM_GTfNDpkM1EJ5G55Fs83tDRW0bGu2v-A@mail.gmail.com>
Subject: Re: [PATCH v2] nfsd: map EBUSY to NFS4ERR_ACCESS for all operations
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, Trond Myklebust <trondmy@hammerspace.com>, 
	NeilBrown <neilb@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 8:45=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> Please send patches To: the NFSD reviewers listed in MAINTAINERS and
> Cc: linux-nfs and others. Thanks!
>
>
> On 1/21/25 5:39 AM, Amir Goldstein wrote:
> > Commit 466e16f0920f3 ("nfsd: check for EBUSY from vfs_rmdir/vfs_unink."=
)
> > mapped EBUSY host error from rmdir/unlink operation to avoid unknown
> > error server warning.
>
> > The same reason that casued the reported EBUSY on rmdir() (dir is a
> > local mount point in some other bind mount) could also cause EBUSY on
> > rename and some filesystems (e.g. FUSE) can return EBUSY on other
> > operations like open().
> >
> > Therefore, to avoid unknown error warning in server, we need to map
> > EBUSY for all operations.
> >
> > The original fix mapped EBUSY to NFS4ERR_FILE_OPEN in v4 server and
> > to NFS4ERR_ACCESS in v2/v3 server.
> >
> > During the discussion on this issue, Trond claimed that the mapping
> > made from EBUSY to NFS4ERR_FILE_OPEN was incorrect according to the
> > protocol spec and specifically, NFS4ERR_FILE_OPEN is not expected
> > for directories.
>
> NFS4ERR_FILE_OPEN might be incorrect when removing certain types of
> file system objects. Here's what I find in RFC 8881 Section 18.25.4:
>
>  > If a file has an outstanding OPEN and this prevents the removal of the
>  > file's directory entry, the error NFS4ERR_FILE_OPEN is returned.
>
> It's not normative, but it does suggest that any object that cannot be
> associated with an OPEN state ID should never cause REMOVE to return
> NFS4ERR_FILE_OPEN.
>
>
> > To keep things simple and consistent and avoid the server warning,
> > map EBUSY to NFS4ERR_ACCESS for all operations in all protocol versions=
.
>
> Generally a "one size fits all" mapping for these status codes is
> not going to cut it. That's why we have nfsd3_map_status() and
> nfsd_map_status() -- the set of permitted status codes for each
> operation is different for each NFS version.
>
> NFSv3 has REMOVE and RMDIR. You can't pass a directory to NFSv3 REMOVE.
>
> NFSv4 has only REMOVE, and it removes the directory entry for the
> object no matter its type. The set of failure modes is different for
> this operation compared to NFSv3 REMOVE.
>
> Adding a specific mapping for -EBUSY in nfserrno() is going to have
> unintended consequences for any VFS call NFSD might make that returns
> -EBUSY.
>
> I think I prefer that the NFSv4 cases be dealt with in nfsd4_remove(),
> nfsd4_rename(), and nfsd4_link(), and that -EBUSY should continue to
> trigger a warning.
>
>

Sorry, I didn't understand what you are suggesting.

FUSE can return EBUSY for open().
What do you suggest to do when nfsd encounters EBUSY on open()?

vfs_rename() can return EBUSY.
What do you suggest to do when nfsd v3 encounters EBUSY on rename()?

This sort of assertion:
        WARN_ONCE(1, "nfsd: non-standard errno: %d\n", errno);

Is a code assertion for a situation that should not be possible in the
code and certainly not possible to trigger by userspace.

Both cases above could trigger the warning from userspace.
If you want to leave the warning it should not be a WARN_ONCE()
assertion, but I must say that I did not understand the explanation
for not mapping EBUSY by default to NFS4ERR_ACCESS in nfserrno().

Thanks,
Amir.

