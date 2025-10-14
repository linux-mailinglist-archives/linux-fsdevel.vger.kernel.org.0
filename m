Return-Path: <linux-fsdevel+bounces-64156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA376BDAF15
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 20:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45B6A1923BC8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 18:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7301829ACF7;
	Tue, 14 Oct 2025 18:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRX7ddMY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA41296BD3
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 18:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760466460; cv=none; b=XsAZ8yygAGyxIiFqxEEQjpLtE5Qd6hJNGLathC8QuZPjpY6zFkN1Lp7GWKkK62ysfdSpJKRPZJnuAyLncWX5sEt1FSDmDDQNUdpHld0weTuKnUMDO2/2LlJchW9i+QVD9WN7kjkWu+tt2unx4BlNZkrEOh79hNO4i9KOKbCm6Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760466460; c=relaxed/simple;
	bh=RB74I7aLFP9qio5yu8di8G1iTGBsm2anqMXvHShWuJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KdqwxOuDil3T8gFkDvPhUirM1zKnsuoG1qGhZavFJbFD+L3jzTjDd7xGzB9qna3rq8eXd3MUG3rIf/8GZGTb+rVhpLxAWqZOiZRjOyHrv6pU0536QYiM3JhABXMRA9N2huHW6Mf1ZeMO6B/B4irldGnTD+w8+kUP53+YJQ1v650=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRX7ddMY; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-791fd6bffbaso88142916d6.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 11:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760466458; x=1761071258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tSfTQUEeojQQB/O4AumuztWKmGZiVkZuY+HewObt1DM=;
        b=PRX7ddMYMmH5UjMSvlec7gbIoWkdzrabslLufLYe1hkjMH56gfmaRi0Et2DsFQLKaL
         Mu75410tlrPqwEX6wG6a3D90VZyZplLi6iIOw4VC++d0wYppFM7uOGpt7GIBc25G0hSj
         7459r/HKJZdiw5FHGIOBuHvw8H6yEPNGP3dnTNS282lI9chf4fBCMMPJZwLtauuvp7Yc
         S/9l2TvCUan4OdDaERCqn7mRNvhx0QT/GvyjP9zb7P4Yoln153KGfp17UHH6MnvJnJYc
         PLf1rT49hCcDo8NaVAuwlhOTpxSnScbHY/gEpMiH0kWixgHssIvEtVN6EHJufpgYXWYW
         c1Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760466458; x=1761071258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tSfTQUEeojQQB/O4AumuztWKmGZiVkZuY+HewObt1DM=;
        b=II2P59t+Pb+tBKxZPHn0oaCajdP11NJS5xL1e/kU/cmJKnXSxS1ucOYdDKo7I4EdOR
         8TstSBZ6i4pXJCmQiQwRqzKxvFS+Xth5kletK4lm5Lsszv/IrHULpeuUkgHbF/ZtiWwa
         z6/ckIGclyYk54ftoGzz2F9nQGkOwouv/KOgwI0+QOWy/ycq7ePLwNFonFzNvnCjeJei
         fNtjpjec64tjKgtB8N3CudJ41SHkCNjgvic/kBJGN704HUT337du3kiHW2yJlO1mpbQS
         jkgNCOCHhzlzYDvWWGNA1Ph8yDu3n5HcnCsPjX7RoOB4gLH3ATpqSwPe2SgTdJ7ascDj
         NFGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbF2fUgxgZo3qlEXePVLkgfjC6kAfSpIwLF0SBh/9tBF9pS5EFy3xoj0HtaxSARrIQDOpYG+8o9OD8lfmJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0VXh6OViHNNz+Dg3rPV9fKq2wY6bG0rUDYD+mYi6r9LgrdcD9
	lrPHDWNnrvAGEo9T95FzTX8KIvvf72dIPX1ANHaSPfCpzUtEk5HeYvl0Lcy3pBcRrCvC1xQr6rF
	7XaP0RgqTOoSc9UWhhtZYRJdz5vkert4=
X-Gm-Gg: ASbGnctxPN4K4lWruRy7j1pM7/i7HFXJXOAQjsQCqkBt1ALp9Vq6ASkdujiynvOYy/0
	oxZVNcJUbzJnV1M6JfZ3vHQOr0WKOjQmA87rqaCIcRPbOQao0LAYQoq2rez3i620/L6WFw5SBBH
	hzRdRyV1jHkSft+19DOfpy9Bs8xAh4ZhDDtx8r2ju4POk+YvdKZggUwpXykRGd6vaDmP6eD615u
	gD2rKe2Lk/9RXMGCcFsI89boEyy8I3fkP46lIuZVQtAmDfkYEfAnFEe1LMpTSAHfXNO8aTcCutG
	lruZ219TWTy6NQlmEbeL3V677CzKPGLN4zbwCLURFW8H1XGIOxjEjs2Qqk0sGtBjNBKOnRdb7Dl
	R1XXEuR1WiTuFGomegk+EOe4qBXEc6wfEh62JhNk=
X-Google-Smtp-Source: AGHT+IFU6XFIR+qGieXOiN15wCcKNp7saGyGYeqcKac09vSAanvqo/pyqL6UQId++kEk6bi2MHN+oNsiaYZwxnbnOWI=
X-Received: by 2002:a05:6214:f6b:b0:804:19ef:45dd with SMTP id
 6a1803df08f44-87b2101d85amr393750166d6.25.1760466457838; Tue, 14 Oct 2025
 11:27:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014133551.82642-1-dhowells@redhat.com>
In-Reply-To: <20251014133551.82642-1-dhowells@redhat.com>
From: Steve French <smfrench@gmail.com>
Date: Tue, 14 Oct 2025 13:27:26 -0500
X-Gm-Features: AS18NWDSIxnc3mGWD21jCuzZgR1tbiQpCXCnv_rdJ8bZ8-EdEWCR6tu4SyA_6UY
Message-ID: <CAH2r5muBUFcGWZ+-d8OteT=k7xVk1sK97URmKfwF5saq4ms2Zw@mail.gmail.com>
Subject: Re: [PATCH 0/2] vfs, afs, bash: Fix miscomparison of foreign user IDs
 in the VFS
To: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <christian@brauner.io>, 
	Marc Dionne <marc.dionne@auristor.com>, Jeffrey Altman <jaltman@auristor.com>, 
	Steve French <sfrench@samba.org>, linux-afs@lists.infradead.org, 
	openafs-devel@openafs.org, linux-cifs@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Additionally, filesystems (CIFS being a notable example) may also have us=
er
identifiers that aren't simple integers

Yes - this is a bigger problem for cifs.ko (although presumably NFS
since they use user@domain for NFSv4.1 and 4.2, instead of small 32
bit uids, could have some overlapping issues as well).

In the protocols, users are represented (e.g. in ACLs and in ownership
info returned by the server) as globally unique "SIDs" which are much
larger than UIDs and so can be safely mapped across large numbers of
systems.

On Tue, Oct 14, 2025 at 8:36=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
> Hi Al, Christian,
>
> Here's a pair of fixes that deal with some places the VFS mishandles
> foreign user ID checks.  By "foreign" I mean that the user IDs from the
> filesystem do not belong in the same number space as the system's user ID=
s.
> Network filesystems are prime examples of this, but it may also impact
> things like USB drives or cdroms.
>
> Take AFS as example: Whilst each file does have a numeric user ID, the fi=
le
> may be accessed from a world-accessible public-facing server from some
> other organisation with its own idea of what that user ID refers to.  IDs
> from AFS may also collide with the system's own set of IDs and may also b=
e
> unrepresentable as a 32-bit UID (in the case of AuriStor servers).
>
> Further, kAFS uses a key containing an authentication token to specify th=
e
> subject doing an RPC operation to the server - and, as such, this needs t=
o
> be used instead of current_fsuid() in determining whether the current use=
r
> has ownership rights over a file.
>
> Additionally, filesystems (CIFS being a notable example) may also have us=
er
> identifiers that aren't simple integers.
>
> Now the problem in the VFS is that there are a number of places where it
> assumes it can directly compare i_uid (possibly id-mapped) to either than
> on another inode or a UID drawn from elsewhere (e.g. current_uid()) - but
> this doesn't work right.
>
> This causes the write-to-sticky check to work incorrectly for AFS (though
> this is currently masked by a workaround in bash that is slated to be
> removed) whereby open(O_CREAT) of such a file will fail when it shouldn't=
.
>
> Two patches are provided:
>
>  (1) Add a pair of inode operations, one to compare the ownership of a pa=
ir
>      of inodes and the other to see if the current process has ownership
>      rights over an inode.  Usage of this is then extended out into the
>      VFS, replacing comparisons between i_uid and i_uid and between i_uid
>      and current_fsuid().  The default, it the inode ops are unimplemente=
d,
>      is to do those direct i_uid comparisons.
>
>  (2) Fixes the bash workaround issue with regard to AFS, overriding the
>      checks as to whether two inodes have the same owner and the check as
>      to whether the current user owns an inode to work within the AFS
>      model.
>
> kAFS uses the result of a status-fetch with a suitable key to determine
> file ownership (if the ADMINISTER bit is set) and just compares the 64-bi=
t
> owner IDs to determine if two inodes have the same ownership.
>
> Note that chown may also need modifying in some way - but that can't
> necessarily supply the information required (for instance, an AuriStor YF=
S ID
> is 64 bits, but chown can only handle a 32-bit integer; CIFS might use a
> GUID).
>
> The patches can be found here:
>
>         https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs=
.git/log/?h=3Dafs-sticky-2
>
> Thanks,
> David
>
> David Howells (2):
>   vfs: Allow filesystems with foreign owner IDs to override UID checks
>   afs, bash: Fix open(O_CREAT) on an extant AFS file in a sticky dir
>
>  Documentation/filesystems/vfs.rst |  21 ++++
>  fs/afs/dir.c                      |   2 +
>  fs/afs/file.c                     |   2 +
>  fs/afs/internal.h                 |   3 +
>  fs/afs/security.c                 |  46 +++++++++
>  fs/attr.c                         |  58 ++++++-----
>  fs/coredump.c                     |   2 +-
>  fs/inode.c                        |  11 +-
>  fs/internal.h                     |   1 +
>  fs/locks.c                        |   7 +-
>  fs/namei.c                        | 161 ++++++++++++++++++++++++------
>  fs/remap_range.c                  |  20 ++--
>  include/linux/fs.h                |   6 +-
>  13 files changed, 269 insertions(+), 71 deletions(-)
>
>


--=20
Thanks,

Steve

