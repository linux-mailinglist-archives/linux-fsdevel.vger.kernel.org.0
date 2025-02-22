Return-Path: <linux-fsdevel+bounces-42324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B0BA403FE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2025 01:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7AA3178095
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2025 00:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC3A35947;
	Sat, 22 Feb 2025 00:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VzktxGgU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA7D22331;
	Sat, 22 Feb 2025 00:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740183536; cv=none; b=Sqsw/0tPem0xod95OGpfyDO/suCae45BZqYj+TTg2jaAwX3daRkGtanGFGAEALotimKJZ4uozNM1UU23lyYqe7yGg1ULOnZaUvtSz3otTQSNmi8B3jmTT3T5cAYjbEnFiXSrNdpeStRNyfknSihmB3OJc2FCpZGxxFUR058HfII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740183536; c=relaxed/simple;
	bh=hTH20HE00ojYpGIGqwByOQxK8RWRsSVWt1TZjk0M8IQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=W3In8yUcRBZSeLciSpQHKSnsbr15T2Y4Rbb5xRlUzgzyKdiGEVVs8BANrpgTs8TPH5ky4x75vKvoi63pKZnkuyYrP/sXQKhsIOzbo1hAOUWXbafbg7tvue7scvLfldwtIQs5cXRQwXKZjhDpgnTZ3eySCLH4iJ87jzTRBior7Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VzktxGgU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D545CC4CEE4;
	Sat, 22 Feb 2025 00:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1740183535;
	bh=hTH20HE00ojYpGIGqwByOQxK8RWRsSVWt1TZjk0M8IQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VzktxGgUVOCI/gPHLFDP2ZOmRho5qrckTGuSNqDQObut3r2Qf9szEApVd0/IVR/M8
	 5KIge2VX94QvesQtvaL+j2zX9HOQhpRfOgC56mRHZdCLrS8qTHDQjD8FgvgHBSLUhr
	 D2LL5dvZ8c3VXWqPErutmDH9JLNnyi/GMBBr0gXk=
Date: Fri, 21 Feb 2025 16:18:54 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Michal =?ISO-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Mikhalitsyn
 <alexander@mihalicyn.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Kees
 Cook <kees@kernel.org>, "Eric W . Biederman" <ebiederm@xmission.com>, Oleg
 Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 2/2] pid: Optional first-fit pid allocation
Message-Id: <20250221161854.8ea0dd0b2da05d38574cefc4@linux-foundation.org>
In-Reply-To: <20250221170249.890014-3-mkoutny@suse.com>
References: <20250221170249.890014-1-mkoutny@suse.com>
	<20250221170249.890014-3-mkoutny@suse.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Feb 2025 18:02:49 +0100 Michal Koutn=FD <mkoutny@suse.com> wrote:

> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -1043,6 +1043,8 @@ The last pid allocated in the current (the one task=
 using this sysctl
>  lives in) pid namespace. When selecting a pid for a next task on fork
>  kernel tries to allocate a number starting from this one.
> =20
> +When set to -1, first-fit pid numbering is used instead of the next-fit.
> +

This seems thin.  Is there more we can tell our users?  What are the
visible effects of this?  What are the benefits?  Why would they want
to turn it on?

I mean, there are veritable paragraphs in the changelogs, but just a
single line in the user-facing docs.  Seems there could be more...

