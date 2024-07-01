Return-Path: <linux-fsdevel+bounces-22883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7216B91E1FB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 16:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B8621C22E92
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 14:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA7816131A;
	Mon,  1 Jul 2024 14:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bx6gl0u0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F63215E5A6;
	Mon,  1 Jul 2024 14:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719843153; cv=none; b=AWpDw4D2yabVnV19QO82sTjVeSWTTkU+Nvp3AnkAFeKKIhEsYUEc9B3JKGjukhoYj9Dw6c045GUXjy72t8qwWcQOBK9dXbtRycLedAuMajJTfDZqBD3rP5G3UlIIMgD+ht8pqM6YAyjxWm+bkMmpHwpY4Nmrfq9mmeKlfr7upqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719843153; c=relaxed/simple;
	bh=1VVWwQxpbYpxgTGynZjIRizmv2vMmvHZ76g/uhUNoXw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DbQjITkpBzwUGgslzg1pvc3threVNDOtfsKznridTMqOi5Kt4drcQ299g2X6gYM9XgQOvkGwazjCjMXMMTXAaRYvKC1TK6Yqfj+jYI3ZZBQp/Xmsyq+u0fZwQUihGrM/GPOC7i8QQ5Wf5gt1f4Jf6hTo2a6LddUhA7r6fsXIXIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bx6gl0u0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F24C116B1;
	Mon,  1 Jul 2024 14:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719843153;
	bh=1VVWwQxpbYpxgTGynZjIRizmv2vMmvHZ76g/uhUNoXw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Bx6gl0u0KpVIjrIpzrfYuY6WoBWEJEEFsy7b/cg2a/dYiOrt9fM/DJGDrY4QzS/z2
	 BtJ2c2Y8K4NKN+etRhqcUQVzjCCN2h5D7xdOOXxL5/4RUam5MFz6a5hFvUmmHrbjSW
	 GBdgrvmiHCBMiiPg8KwsHfBQSvqTTXGjspMQ8+oIkERaDsrnslkOSLiNDBbJCCVNht
	 /HKEoG8hniCJoiHW0rvXZ6VGbyPTaEMa8dRiFPRr0P5g4yDZ+n/Rir8GoP0agHiEDr
	 zbOJgH3sUJKUT1OpmSMSjDXDkXEvDtLAmCs0lSDgEg0QZPn/+DDoPCdTUZUf/Qmq/8
	 RZQkXLVyvBeww==
Message-ID: <1c3cee9f7ef81e1da09e0c7b4ee1e47dc9161a75.camel@kernel.org>
Subject: Re: [PATCH v2 00/11] fs: multigrain timestamp redux
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
Date: Mon, 01 Jul 2024 10:12:29 -0400
In-Reply-To: <20240701135332.GD504479@perftesting>
References: <20240701-mgtime-v2-0-19d412a940d9@kernel.org>
	 <20240701135332.GD504479@perftesting>
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

On Mon, 2024-07-01 at 09:53 -0400, Josef Bacik wrote:
> On Mon, Jul 01, 2024 at 06:26:36AM -0400, Jeff Layton wrote:
> > This set is essentially unchanged from the last one, aside from the
> > new file in Documentation/. I had a review comment from Andi Kleen
> > suggesting that the ctime_floor should be per time_namespace, but I
> > think that's incorrect as the realtime clock is not namespaced.
> >=20
> > At LSF/MM this year, we had a discussion about the inode change
> > attribute. At the time I mentioned that I thought I could salvage the
> > multigrain timestamp work that had to be reverted last year [1].=C2=A0 =
That
> > version had to be reverted because it was possible for a file to get a
> > coarse grained timestamp that appeared to be earlier than another file
> > that had recently gotten a fine-grained stamp.
> >=20
> > This version corrects the problem by establishing a per-time_namespace
> > ctime_floor value that should prevent this from occurring. In the above
> > situation that was problematic before, the two files might end up with
> > the same timestamp value, but they won't appear to have been modified i=
n
> > the wrong order.
> >=20
> > That problem was discovered by the test-stat-time gnulib test. Note tha=
t
> > that test still fails on multigrain timestamps, but that's because its
> > method of determining the minimum delay that will show a timestamp
> > change will no longer work with multigrain timestamps. I have a patch t=
o
> > change the testcase to use a different method that I've posted to the
> > bug-gnulib mailing list.
> >=20
> > The big question with this set is whether the performance will be
> > suitable. The testing I've done seems to show performance parity with
> > multigrain timestamps enabled, but it's hard to rule this out regressin=
g
> > some workload.
> >=20
> > This set is based on top of Christian's vfs.misc branch (which has the
> > earlier change to track inode timestamps as discrete integers). If ther=
e
> > are no major objections, I'd like to let this soak in linux-next for a
> > bit to see if any problems shake out.
> >=20
> > [1]: https://lore.kernel.org/linux-fsdevel/20230807-mgctime-v7-0-d1dec1=
43a704@kernel.org/
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>=20
> I have a few nits that need to be addressed, but you can add
>=20
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
>=20
> to the series once they're addressed.=C2=A0 Thanks,
>=20

Thanks! Fixed them up in my tree. I left the IS_I_VERSION check out as
well, and added a note to the changelog on the btrfs patch.
--=20
Jeff Layton <jlayton@kernel.org>

