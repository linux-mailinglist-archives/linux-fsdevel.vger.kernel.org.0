Return-Path: <linux-fsdevel+bounces-22882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6199291E19E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 15:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D245B1F22930
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 13:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D807E15F322;
	Mon,  1 Jul 2024 13:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFyo1kPU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E75415ECE1;
	Mon,  1 Jul 2024 13:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719842268; cv=none; b=ICX3b9OY+v+ue5BDBCLUjwVQNtkd7nCbhftCxx6YwNe0pK9xULFZp0SK+EeEKLhWbPt/aadncoqHRPQ4nSWZyQM7MNNV2MCqOGnWnGp9K/I/e9ywz+17eQCeqSqG1bBwhGVT7F0d9pwCmI/ZN31sBR+mVWbwnao9kvIIxj7pczM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719842268; c=relaxed/simple;
	bh=Quf3kWmtSfxquIJibTHIXScRxkXGjBoizQwXS/tOBAE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uRrBj1GOXHfR1y1JAZM5iHicS2XBdLXn6zoKX+ituh3y6qYm0eRKmpxmqfztuo3Rz0rcGIThwKlaz/ZdexcTtg+q2cdy85n148NxEi01A8smpJRUaokP6Rq+KNv6oaGoTOKt/CnhFslY8mrIV+E9WbJ/9UBzBfW+aV66yHkYrnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFyo1kPU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01963C116B1;
	Mon,  1 Jul 2024 13:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719842267;
	bh=Quf3kWmtSfxquIJibTHIXScRxkXGjBoizQwXS/tOBAE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=qFyo1kPUve5gOe5FaBvZUsvLZXqk1Ydsj9Xpjcf8Zjp1oy36l7CdEIIOiB+KwbQwS
	 HX+DCqRd74tKmfNkja4zS3IBJOb5K+musSXsw+5VNvdQV4U8MZTBG5F9skorBxJ4te
	 Shy6KBRT4Rr7gJbCYSTwr7st5U6zvMyS0/sROfvCf1CXlb+Bg3oLizmTOtwW75YaQb
	 NfFisn+rd54QEaTPWJ4eAicuUrOPM4/BNjSV3M3H/pWc6vm3Ev3jpq9xTCiso/6szE
	 xn7nyojwnlzarsc25/foE/nm1Z5GNCaUCnyTQuyv5u5uc7mFUDSBXS2p9NnOvyn2AX
	 hXe1y5f71oHrg==
Message-ID: <ec952d79bbe19d80a7aff495e9784c60a1a1e668.camel@kernel.org>
Subject: Re: [PATCH v2 09/11] btrfs: convert to multigrain timestamps
From: Jeff Layton <jlayton@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Chandan Babu R
 <chandan.babu@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>, Theodore
 Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, Chris
 Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, Hugh Dickins
 <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, Andi Kleen
 <ak@linux.intel.com>,  kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-trace-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org,  linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-mm@kvack.org,  linux-nfs@vger.kernel.org
Date: Mon, 01 Jul 2024 09:57:43 -0400
In-Reply-To: <20240701134936.GB504479@perftesting>
References: <20240701-mgtime-v2-0-19d412a940d9@kernel.org>
	 <20240701-mgtime-v2-9-19d412a940d9@kernel.org>
	 <20240701134936.GB504479@perftesting>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-01 at 09:49 -0400, Josef Bacik wrote:
> On Mon, Jul 01, 2024 at 06:26:45AM -0400, Jeff Layton wrote:
> > Enable multigrain timestamps, which should ensure that there is an
> > apparent change to the timestamp whenever it has been written after
> > being actively observed via getattr.
> >=20
> > Beyond enabling the FS_MGTIME flag, this patch eliminates
> > update_time_for_write, which goes to great pains to avoid in-memory
> > stores. Just have it overwrite the timestamps unconditionally.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > =C2=A0fs/btrfs/file.c=C2=A0 | 25 ++++---------------------
> > =C2=A0fs/btrfs/super.c |=C2=A0 3 ++-
> > =C2=A02 files changed, 6 insertions(+), 22 deletions(-)
> >=20
> > diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> > index d90138683a0a..409628c0c3cc 100644
> > --- a/fs/btrfs/file.c
> > +++ b/fs/btrfs/file.c
> > @@ -1120,26 +1120,6 @@ void btrfs_check_nocow_unlock(struct
> > btrfs_inode *inode)
> > =C2=A0	btrfs_drew_write_unlock(&inode->root->snapshot_lock);
> > =C2=A0}
> > =C2=A0
> > -static void update_time_for_write(struct inode *inode)
> > -{
> > -	struct timespec64 now, ts;
> > -
> > -	if (IS_NOCMTIME(inode))
> > -		return;
> > -
> > -	now =3D current_time(inode);
> > -	ts =3D inode_get_mtime(inode);
> > -	if (!timespec64_equal(&ts, &now))
> > -		inode_set_mtime_to_ts(inode, now);
> > -
> > -	ts =3D inode_get_ctime(inode);
> > -	if (!timespec64_equal(&ts, &now))
> > -		inode_set_ctime_to_ts(inode, now);
> > -
> > -	if (IS_I_VERSION(inode))
> > -		inode_inc_iversion(inode);
> > -}
> > -
> > =C2=A0static int btrfs_write_check(struct kiocb *iocb, struct iov_iter
> > *from,
> > =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0 size_t count)
> > =C2=A0{
> > @@ -1171,7 +1151,10 @@ static int btrfs_write_check(struct kiocb
> > *iocb, struct iov_iter *from,
> > =C2=A0	 * need to start yet another transaction to update the
> > inode as we will
> > =C2=A0	 * update the inode when we finish writing whatever data
> > we write.
> > =C2=A0	 */
> > -	update_time_for_write(inode);
> > +	if (!IS_NOCMTIME(inode)) {
> > +		inode_set_mtime_to_ts(inode,
> > inode_set_ctime_current(inode));
> > +		inode_inc_iversion(inode);
>=20
> You've dropped the
>=20
> if (IS_I_VERSION(inode))
>=20
> check here, and it doesn't appear to be in inode_inc_iversion.=C2=A0 Is
> there a
> reason for this?=C2=A0 Thanks,
>=20

AFAICT, btrfs always sets SB_I_VERSION. Are there any cases where it
isn't? If so, then I can put this check back. I'll make a note about it
in the changelog if not.

--=20
Jeff Layton <jlayton@kernel.org>

