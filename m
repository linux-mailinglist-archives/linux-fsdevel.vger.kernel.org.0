Return-Path: <linux-fsdevel+bounces-22987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CBB924C17
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 01:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 620D21F2389D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 23:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666D617A59C;
	Tue,  2 Jul 2024 23:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5dxT+c5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59FA1DA30B;
	Tue,  2 Jul 2024 23:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719962721; cv=none; b=ldEIyYTcQogPE5FovEpicCNxuNskIGCykIddz+e9s3RbTnfuDN28KmgE26tfaKwts61tn3lSEX9iWFLboyZ1U6pFUF+4iPYkdR9POSAWEvCGEQu0BShSDrvTN/diwaTzMXc/kutF/5j7x5ueBiwni8mJc7HYIm0noRTXEB0Ql8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719962721; c=relaxed/simple;
	bh=snJ1gW7dX8zqfRyagH8cMhyEIKYnDspHshplSlOrO7A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F6st957E4k2M4p9elebcS0ykx3390ZGlqHI41NkEpoSmHrAnhCEfH9FxcGHuk7xzoePqSeoQL9/M26JL8r43ex57TvIawyqHRonKZjJSCjY7D22gi9lApJ0iIHcxQgJTXfNMygKaJcFIg6KMgJZc4xrLG9L56sAiUwGwu7SGjKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5dxT+c5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CA1C116B1;
	Tue,  2 Jul 2024 23:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719962721;
	bh=snJ1gW7dX8zqfRyagH8cMhyEIKYnDspHshplSlOrO7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i5dxT+c5rSv/i12bnxDufNjLnkdhnzVZP9wg+0pdzma2NZNPZDd5fT+U9O6ZDYuBW
	 z57ItWM2QQgYA9IqYEBd5+zE2pmrd0dW8WvO6GP5+956nmqhr0pfltQdiWZaFNcIjk
	 uDQc4ZsHyTZgEBO8hBYpuCzhnT5hx3nnFuSle8SInuA7zOVqc/SBnDdMIz8/sgFmMg
	 pc7MkQSflSQxrc5ydRab8ICNHAlUsdMIYic0hdwSWMjesHX+vIak9t0E+VsGRZggp1
	 /9x3wov2vKDl2z/pQOh0R+tS8OdVpT+rl6phbyk0gIHvJOG9+WUtcFvUg1XUEJvG+b
	 1H+myUYgtqELg==
From: SeongJae Park <sj@kernel.org>
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [RFC PATCH v2 7/7] tools: add skeleton code for userland testing of VMA logic
Date: Tue,  2 Jul 2024 16:25:16 -0700
Message-Id: <20240702232516.78977-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <73c7a094524bdb21e25d8c436c9059820ad82cb5.1719584707.git.lstoakes@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Lorenzo,

On Fri, 28 Jun 2024 15:35:28 +0100 Lorenzo Stoakes <lstoakes@gmail.com> wrote:

> Establish a new userland VMA unit testing implementation under
> tools/testing which utilises existing logic providing maple tree support in
> userland utilising the now-shared code previously exclusive to radix tree
> testing.
> 
> This provides fundamental VMA operations whose API is defined in mm/vma.h,
> while stubbing out superfluous functionality.
> 
> This exists as a proof-of-concept, with the test implementation functional
> and sufficient to allow userland compilation of vma.c, but containing only
> cursory tests to demonstrate basic functionality.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>  MAINTAINERS                            |   1 +
>  include/linux/atomic.h                 |   2 +-
>  include/linux/mmzone.h                 |   3 +-
>  tools/testing/vma/.gitignore           |   6 +
>  tools/testing/vma/Makefile             |  15 +
>  tools/testing/vma/errors.txt           |   0
>  tools/testing/vma/generated/autoconf.h |   2 +
>  tools/testing/vma/linux/atomic.h       |  12 +
>  tools/testing/vma/linux/mmzone.h       |  38 ++
>  tools/testing/vma/vma.c                | 207 ++++++
>  tools/testing/vma/vma_internal.h       | 882 +++++++++++++++++++++++++
>  11 files changed, 1166 insertions(+), 2 deletions(-)
>  create mode 100644 tools/testing/vma/.gitignore
>  create mode 100644 tools/testing/vma/Makefile
>  create mode 100644 tools/testing/vma/errors.txt
>  create mode 100644 tools/testing/vma/generated/autoconf.h
>  create mode 100644 tools/testing/vma/linux/atomic.h
>  create mode 100644 tools/testing/vma/linux/mmzone.h
>  create mode 100644 tools/testing/vma/vma.c
>  create mode 100644 tools/testing/vma/vma_internal.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0847cb5903ab..410062bd8e21 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23983,6 +23983,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>  F:	mm/vma.c
>  F:	mm/vma.h
>  F:	mm/vma_internal.h
> +F:	tools/testing/vma

According to the description of 'F:' section description at the beginning of
this file (quoting below), I think adding a trailing slash to the above line
would be nice?

        F: *Files* and directories wildcard patterns.
           A trailing slash includes all files and subdirectory files.
           F:   drivers/net/    all files in and below drivers/net


Thanks,
SJ

[...]

