Return-Path: <linux-fsdevel+bounces-39206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E63A11597
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 00:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E9A67A1729
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 23:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CE821ADD1;
	Tue, 14 Jan 2025 23:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIqZsE86"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8B321423A;
	Tue, 14 Jan 2025 23:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736898160; cv=none; b=UBMR6bX0YmTbxEpycaWBGYhxh1bCaOyhlzK1PzREWI0/RCwQr+mVZC/hnPsQJH38GhTcuNXkvQkuf8dd9Zg/qR/4+5Kd4o86+FWtpnSCK7eLEjVJJtCahY4XFsU/QiazawR792FSqfbNTWGTZHwBJqlPq9FErbR6nWVcFDBIcTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736898160; c=relaxed/simple;
	bh=yLnnR/D2Cs5GDfkk3Hf9EEVwQ5C+xBnPJs/Bp4dV7kE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bS7hlnOqu6+k73SIHTs2pCEkeDEYssq++218E5fulXol6J4SIJ9Gb45e+e++rqQM9kWC6ru4amPg4GPIkkttsVtpXEidP23YvSs2Y92i1fSgYpGgkFJeZSF7+ZNlZKRy940wX44Pvv7VtuzKWm60A1I1q7B5W0rGnYccBuXDwG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIqZsE86; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ef72924e53so10083960a91.3;
        Tue, 14 Jan 2025 15:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736898158; x=1737502958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=quyaB8ziKmWh5lICJCqpbl7CI7id+IgEsASBV0XeQtQ=;
        b=BIqZsE862mh5jfzuEYu40PYgNG0oO1wfsBEkf4VxZOIYbshUhLdH1oIvWC2KojzFPP
         z+fN/EeqcgU+5SvUmH5GWh925J3gzXe36hS/AMGtcjfgh5RTUZaoqVCXWckRWvNcSaEo
         UeAjLz8HdqWT44vdO2/kBKrXU0sfL4ZWR7EcZxSO14NhirEWC/Flw3rNc2xXPDKV6vog
         i3U/L8nx2fs1NaB5VLlY7S3EtvJ7+2T/ikl6WbvIZL/Sc90T2oYUz2H3FyoteXoljxlS
         uTdPthG21k54ejOl8q/h0L4TIdJzMZuyTrs+tw55Bobu2uE+FS01JGbjaS1QXohzNu+c
         P7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736898158; x=1737502958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=quyaB8ziKmWh5lICJCqpbl7CI7id+IgEsASBV0XeQtQ=;
        b=a29iu6q3aufl6C5mJiuPzqeqPzLpz2Fno+MSBW6gVYF0MVuePuTla7XAxfkHeIHZg8
         zpj+ZmDs02P/W+4YCX726J2ilKif9P50RcxGliOQyNMsIAlbG13YqbmMga9MVB+TeSdw
         P8E92Bcsb8T3quATSs578rJ7JbmrpLieC4gquQVGAjJrh0RXNc6iQSlPm/ogr52F4Acs
         QaPC7rV33PlHKDJlj03jnrST6Hnma3kEoRVAq3rCAt+4p2ZXnRb27VRUIGMTcl4mGbrP
         LqPj/gm0GDxkfMdGsR8TdgP4ViGrYp+QCvBIFjdfNvDsmgDbUuxAvYfTN7aIszYu6r36
         00vA==
X-Forwarded-Encrypted: i=1; AJvYcCUVa0lbwWoq78FxgeKSrWKgfQ/BLlRq7Am20HVy1nmf82yQ5rPAday0sO8+lWJGlBHMKO5AUJGpWNlq@vger.kernel.org, AJvYcCVQYwjePUocplCvUX2DXe+sSCikK4R9+/wXHyPxGMo8ENuz4azSLI3Gi8dX91/AF4Nv3vH/pYNrfj0UPIbi@vger.kernel.org, AJvYcCVQm8Wcm/0o1oL+uvPtSt7cq2r2YpNEGNApzdydune3Weks3l9l5PCwTBMJToD5z73IiRqCYOmpFSuqEChwCw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3oXc8lmMS1wuzsYZEO+1pA8vdJ+4Jr45kvIoFqztZ0PugeoRr
	7thqErJg0i+BTJq1quXFyPV1K3urSGgL6eZ2bMnoP+SkfbgLYdyt2Zj01pu3I4Bv+BWc4PuYqGB
	tujZoJjdafklUkdC3UydDXKufeLk=
X-Gm-Gg: ASbGncuZldmlFfxsitJChUq4GOHLh29LJmC20nPXvJ8+kRCjf6DNyjAS9CFCSmTpjAa
	+kUYo+XpZlHXXOv36qCRkF108ZAYGj5SL3dMcjQ==
X-Google-Smtp-Source: AGHT+IEOkrFDlJ3CDOjczpR7YBZ9RD2D1W4AQ7cRnHkYS1odRc0LsFdmFqWUY6c/gNjIvQLEwzloiqj+6cjmjfUI9qU=
X-Received: by 2002:a17:90b:2f45:b0:2ef:2f49:7d7f with SMTP id
 98e67ed59e1d1-2f548ece7afmr42867667a91.18.1736898158308; Tue, 14 Jan 2025
 15:42:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241227121508.nofy6bho66pc5ry5@pali> <ckqak3zq72lapwz5eozkob7tcbamrvafqxm4mp5rmevz7zsxh5@xytjbpuj6izz>
 <28f0aa2e-58d7-4b56-bc19-b1b3aa284d8f@oracle.com> <20250104-bonzen-brecheisen-8f7088db32b0@brauner>
 <cf0b8342-8a4b-4485-a5d1-0da20e6d14e7@oracle.com> <20250114211050.iwvxh7fon7as7sty@pali>
 <0659dfe1-e160-40fd-b95a-5d319ca3504f@oracle.com> <Z4b0H5hQv0ocD75j@dread.disaster.area>
In-Reply-To: <Z4b0H5hQv0ocD75j@dread.disaster.area>
From: ronnie sahlberg <ronniesahlberg@gmail.com>
Date: Wed, 15 Jan 2025 09:42:26 +1000
X-Gm-Features: AbW1kvYJBu5VJLEJM1yKyFVzTzmTetgu7Qt4ucboXL1SJgcKdfDphZiDjCsymBg
Message-ID: <CAN05THT8oP4q90wqxSN3vR+EYEPXfe1Ts=rqVYg6mthUXytWbA@mail.gmail.com>
Subject: Re: Immutable vs read-only for Windows compatibility
To: Dave Chinner <david@fromorbit.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Steve French <sfrench@samba.org>, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 15 Jan 2025 at 09:32, Dave Chinner <david@fromorbit.com> wrote:
>
> On Tue, Jan 14, 2025 at 04:44:55PM -0500, Chuck Lever wrote:
> > On 1/14/25 4:10 PM, Pali Roh=C3=A1r wrote:
> > > > My thought was to have a consistent API to access these attributes,=
 and
> > > > let the filesystem implementers decide how they want to store them.=
 The
> > > > Linux implementation of ntfs, for example, probably wants to store =
these
> > > > on disk in a way that is compatible with the Windows implementation=
 of
> > > > NTFS.
> > > >
> > > > A common API would mean that consumers (like NFSD) wouldn't have to=
 know
> > > > those details.
> > > >
> > > >
> > > > --
> > > > Chuck Lever
> > >
> > > So, what about introducing new xattrs for every attribute with this p=
attern?
> > >
> > > system.attr.readonly
> > > system.attr.hidden
> > > system.attr.system
> > > system.attr.archive
> > > system.attr.temporary
> > > system.attr.offline
> > > system.attr.not_content_indexed
>
> "attr" is a poor choice for an attribute class (yes, naming is
> hard...). It's a windows file attribute class, the name should
> reflect that.
>
> However, my main problem with this approach is that it will be
> pretty nasty in terms of performance regressions. xattr lookup is
> *much* more expensive than reading a field out of the inode itself.
>
> If you want an example of the cost of how a single xattr per file
> can affect the performance of CIFS servers, go run dbench (a CIFS
> workload simulator) with and without xattrs. The difference in
> performance storing a single xattr per file is pretty stark, and it
> only gets worse as we add more xattrs. i.e. xattrs like this will
> have significant performance implications for all file create,
> lookup/stat and unlink operations.
>
> IOWs, If this information is going to be stored as an xattr, it
> needs to be a single xattr with a well defined bit field as it's
> value (i.e. one bit per attribute). The VFS inode can then cache
> that bitfield with minimal addition overhead during the first
> lookup/creation/modification for the purpose of fast, low overhead,
> statx() operation.

For this use case I don't think he means to store them on the cifs
server as xattr
(or case-insensitive extended attributes as cifs does).
They can already be read/written using SMB2 GetInfo/SetInfo commands.

What I think he means is to read these attributes using SMB2 GetInfo
but then present this to the application via a synthetic xattr.
Application reads a magic xattr and then the driver just makes it up based =
on
other information it has. (cifs does this for other things already afaik)

Correct me if I am wrong Pali, but you mean translate the SMB2 attribute fi=
eld
into a magic xattr?  But that means it is not storage of the
attributes anymore but rather
the API for applications to read these attributes.

>
> > Yes, all of them could be stored as xattrs for file systems that do
> > not already support these attributes.
> >
> > But I think we don't want to expose them directly to users, however.
> > Some file systems, like NTFS, might want to store these on-disk in a wa=
y
> > that is compatible with Windows.
> >
> > So I think we want to create statx APIs for consumers like user space
> > and knfsd, who do not care to know the specifics of how this informatio=
n
> > is stored by each file system.
> >
> > The xattrs would be for file systems that do not already have a way to
> > represent this information in their on-disk format.
>
> Even the filesystems that store this information natively should
> support the xattr interface - they just return the native
> information in the xattr format, and then every application has a
> common way to change these attributes. (i.e. change the xattr to
> modify the attributes, statx to efficiently sample them.
>
> -Dave.
> --
> Dave Chinner
> david@fromorbit.com
>

