Return-Path: <linux-fsdevel+bounces-24117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E497F939DCC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 11:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DAD11F230B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 09:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFD314E2FB;
	Tue, 23 Jul 2024 09:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HwDbjiv+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA30C14D2BD;
	Tue, 23 Jul 2024 09:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721726877; cv=none; b=P6ypRknK4efbGIFpMIiGyDPABnDdkloIMpxBpeGdwWZqKZWolx2R8CCzNWg4cKIGd1hgFWc+FjedgeVV0/71tSed9g0kcGwbIbpIgrHx8qu++X4Fy8zx4Zq8j9vG50JnsHsQw3wkWIr4kfrX/D2K13mczst7mTXoEeuxYWr4IGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721726877; c=relaxed/simple;
	bh=pacHTGzkR2gkhTSagG2dx/AjchwXfuboSWpk0BhMkKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ja9ANSOlESO43MHrgagem/l3ea132d2jAPRAAiD5wDw1nYilkn3Q/5C1OGOglxK87fqH6AGElVmNF6lQtBy/Ao7XZTwa7j7ZrUZkp+YTDeQp1++Be7UqeAdd5QMgryo2NnXFZdi+VFDcwX+P2xb2ZtudEjyvpodbs8qoV5NRwhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HwDbjiv+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F342FC4AF0A;
	Tue, 23 Jul 2024 09:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721726877;
	bh=pacHTGzkR2gkhTSagG2dx/AjchwXfuboSWpk0BhMkKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HwDbjiv+lxddX51ZCTbQpsP3QQdi4i+a2LAWuChZVK+v3TkqDj1dLmojvBZW6KAVd
	 tkOi3cXHcCmnu2hCTZON+hINyw8RDFqORhiIIHLHFQB3X32vSoZAxUa+bZEYRg9soF
	 aBlK2KBGSdsIWHSInAczO50aBWhIZ4WOavDaoLT9dGfsO6ae1ZetA02DNxEuf2h58x
	 0/vfn0Pzh/GSl2rKgHrFXxgGdPvCoEdLvgjb4l0T2fBvG4yg7PLYCLKAmyPCK+ceMX
	 OB0da2OW0HXFY4a5J6N9G7pzgsvwz2o95plgHb+RYiOtkwEoQBOrG0d9xkZVSdGEDy
	 r4jljFtHVlR2A==
Date: Tue, 23 Jul 2024 12:25:51 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	SeongJae Park <sj@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Subject: Re: [PATCH v3 6/7] tools: separate out shared radix-tree components
Message-ID: <Zp93H8-sNyWPoO_d@kernel.org>
References: <cover.1721648367.git.lorenzo.stoakes@oracle.com>
 <d5905fa6f25b159a156a5a6a87c5b1ac25568c5b.1721648367.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5905fa6f25b159a156a5a6a87c5b1ac25568c5b.1721648367.git.lorenzo.stoakes@oracle.com>

On Mon, Jul 22, 2024 at 12:50:24PM +0100, Lorenzo Stoakes wrote:
> The core components contained within the radix-tree tests which provide
> shims for kernel headers and access to the maple tree are useful for
> testing other things, so separate them out and make the radix tree tests
> dependent on the shared components.
> 
> This lays the groundwork for us to add VMA tests of the newly introduced
> vma.c file.
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  tools/testing/radix-tree/Makefile             | 68 +++----------------
>  tools/testing/radix-tree/maple.c              | 15 +---
>  tools/testing/radix-tree/xarray.c             | 10 +--
>  tools/testing/shared/autoconf.h               |  2 +
>  tools/testing/{radix-tree => shared}/bitmap.c |  0
>  tools/testing/{radix-tree => shared}/linux.c  |  0

maybe tools/testing/lib

>  .../{radix-tree => shared}/linux/bug.h        |  0

and tools/testing/include?


-- 
Sincerely yours,
Mike.

