Return-Path: <linux-fsdevel+bounces-72413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7D9CF660C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 02:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A166307DBD5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 01:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588C8218AAB;
	Tue,  6 Jan 2026 01:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Q9Foh+b6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90232216E24;
	Tue,  6 Jan 2026 01:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767664105; cv=none; b=o//OBIiAnYQDB4Yv5opCaQ/XXwWuNG6MZjoNtCBY9sdUdRZX2N/XlBT0DrB+RX9e+LjwAEa/nUqNGZN4yX2NQpWHZsrDoiE5KjyDasDYLKLdABZe4RLxE0FRUMiw4UbgBeWhGX81uVQZksjs3OiSri8DCw8pplMCA8eFNi6EBo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767664105; c=relaxed/simple;
	bh=1/kzawURfiBIGn4XEZ9FPaoyI0WW3RZ6ou8fvJ0ipT8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=iPKcqDTQsHhwRHM2g6nWEcDB1K956UQt4SHZdM6nn+KFyPyE3AagcW+v05ali+CMLQnCQGhKenlmLE6NEgqPAgy4zeyLHJVAP3hyu7Hd+ahVkaRJFS1padvSa7y+vMK4uUSBVWIaRLcYoomFaaTAOrJd2h0efJqiDK7Od6IRThg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Q9Foh+b6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB75AC116D0;
	Tue,  6 Jan 2026 01:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1767664105;
	bh=1/kzawURfiBIGn4XEZ9FPaoyI0WW3RZ6ou8fvJ0ipT8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q9Foh+b6h09pHMzu+j9QQgqKvZpYFqmKPByoqpG7MmWQ3FYkyfaGsubCnK7WEI2UI
	 /0ZFeeyAVDHXbug9r2Yk+Zt2QAKUtqdi52HgkRt46P+aoQ6VhSyjC5s7ss2gPN/Lou
	 NF1jZF9kF6Q2/s1x/v3lV3/dEWG0yhc5a9WT5AGg=
Date: Mon, 5 Jan 2026 17:48:24 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: david@redhat.com, miklos@szeredi.hu, linux-mm@kvack.org,
 athul.krishna.kr@protonmail.com, j.neuschaefer@gmx.net, carnil@debian.org,
 linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, Bernd Schubert
 <bschubert@ddn.com>
Subject: Re: [PATCH v3 1/1] fs/writeback: skip AS_NO_DATA_INTEGRITY mappings
 in wait_sb_inodes()
Message-Id: <20260105174824.5ea19dc45b79e29e0219e6a3@linux-foundation.org>
In-Reply-To: <20260105211737.4105620-2-joannelkoong@gmail.com>
References: <20260105211737.4105620-1-joannelkoong@gmail.com>
	<20260105211737.4105620-2-joannelkoong@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon,  5 Jan 2026 13:17:27 -0800 Joanne Koong <joannelkoong@gmail.com> wr=
ote:

> Above the while() loop in wait_sb_inodes(), we document that we must
> wait for all pages under writeback for data integrity. Consequently, if
> a mapping, like fuse, traditionally does not have data integrity
> semantics, there is no need to wait at all; we can simply skip these
> inodes.
>=20
> This restores fuse back to prior behavior where syncs are no-ops. This
> fixes a user regression where if a system is running a faulty fuse
> server that does not reply to issued write requests, this causes
> wait_sb_inodes() to wait forever.
>=20
> Fixes: 0c58a97f919c ("fuse: remove tmp folio for writebacks and internal =
rb tree")
> Reported-by: Athul Krishna <athul.krishna.kr@protonmail.com>
> Reported-by: J. Neusch=E4fer <j.neuschaefer@gmx.net>
> Cc: stable@vger.kernel.org
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Reviewed-by: Bernd Schubert <bschubert@ddn.com>
> Tested-by: J. Neusch=E4fer <j.neuschaefer@gmx.net>

Thanks.

>  fs/fs-writeback.c       |  7 ++++++-
>  fs/fuse/file.c          |  4 +++-
>  include/linux/pagemap.h | 11 +++++++++++
>  3 files changed, 20 insertions(+), 2 deletions(-)

I'll queue this in mm.git's mm-hotfixes branches for a 6.19-rcX merge.


