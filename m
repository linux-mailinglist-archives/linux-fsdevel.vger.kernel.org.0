Return-Path: <linux-fsdevel+bounces-72347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1784ECF03D6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 03 Jan 2026 19:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE8F3301F26D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Jan 2026 18:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A49222582;
	Sat,  3 Jan 2026 18:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CBuBU4gQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB21A41;
	Sat,  3 Jan 2026 18:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767463391; cv=none; b=ISxTig3hu9ob2aRiRW748JXNT93fqn7oas52BurZL7zk+t/T6jdGD0GLi/UfW4OxsvSVl7NAwCpUMROQeA0vVyRBJsGuBe1DZ6N56cWu5w7f+OH8hkNh/NEO51+NXqYYQvCNf32MU+2xErrGHixCS02Qb/aKc2rX4eEBY0OYZwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767463391; c=relaxed/simple;
	bh=wjDin5AVThhZYNUvty8R27rS+ed9u1J/ub9S0aOSht8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Q8jYTd4MzhIZrJGBz42BVlth4p6fMkXi6t8MyHVmTadpv3gzdn2jaJ+MLOWJhVNrhWXJx3Z47zkfNmSHf82w/jPZfS6nsGE6OoWY7YhWa9JqRSKEcST6yFYTYzQ7rDopAIA5HQRNXGhfgzpvTM1d+8AiqJHU73ZVgJ1+qq12lw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CBuBU4gQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E50C113D0;
	Sat,  3 Jan 2026 18:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1767463391;
	bh=wjDin5AVThhZYNUvty8R27rS+ed9u1J/ub9S0aOSht8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CBuBU4gQ4AkZBrbUoPRDpNX7SRB7Jc7wspQPnrfo/ldXBoOBchIV8+zxKvHz6Ut6P
	 ec1XLPh2xj3CcWAkOZRDjJh0FDRR1pxWLJR7GUu2bA/k4V4kLq6phPh3HeBnn+9sIY
	 AuOljrHMMdIRPejyf0VkLJs8P40rfOcNbC5SEDIA=
Date: Sat, 3 Jan 2026 10:03:10 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: david@redhat.com, miklos@szeredi.hu, linux-mm@kvack.org,
 athul.krishna.kr@protonmail.com, j.neuschaefer@gmx.net, carnil@debian.org,
 linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] fs/writeback: skip AS_NO_DATA_INTEGRITY mappings
 in wait_sb_inodes()
Message-Id: <20260103100310.7181968cda53b14def0455b3@linux-foundation.org>
In-Reply-To: <20251215030043.1431306-2-joannelkoong@gmail.com>
References: <20251215030043.1431306-1-joannelkoong@gmail.com>
	<20251215030043.1431306-2-joannelkoong@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Sun, 14 Dec 2025 19:00:43 -0800 Joanne Koong <joannelkoong@gmail.com> wr=
ote:

> Skip waiting on writeback for inodes that belong to mappings that do not
> have data integrity guarantees (denoted by the AS_NO_DATA_INTEGRITY
> mapping flag).
>=20
> This restores fuse back to prior behavior where syncs are no-ops. This
> is needed because otherwise, if a system is running a faulty fuse
> server that does not reply to issued write requests, this will cause
> wait_sb_inodes() to wait forever.
>=20
> Fixes: 0c58a97f919c ("fuse: remove tmp folio for writebacks and internal =
rb tree")
> Reported-by: Athul Krishna <athul.krishna.kr@protonmail.com>
> Reported-by: J. Neusch=E4fer <j.neuschaefer@gmx.net>
> Cc: stable@vger.kernel.org
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>
> ..
>
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -2751,7 +2751,8 @@ static void wait_sb_inodes(struct super_block *sb)
>  		 * do not have the mapping lock. Skip it here, wb completion
>  		 * will remove it.
>  		 */
> -		if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK))
> +		if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK) ||
> +		    mapping_no_data_integrity(mapping))
>  			continue;

It's not obvious why a no-data-integrity mapping would want to skip
writeback - what do these things have to do with each other?

So can we please have a v2 which has a comment here explaining this to the
reader?



