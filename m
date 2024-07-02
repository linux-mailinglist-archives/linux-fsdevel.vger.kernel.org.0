Return-Path: <linux-fsdevel+bounces-22986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9028A924C10
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 01:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B14B1F237E4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 23:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CB717A592;
	Tue,  2 Jul 2024 23:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a18w35X3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E6D1DA30B;
	Tue,  2 Jul 2024 23:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719962377; cv=none; b=gWwmZoWaJgD5PoyLRRTb96avfTYLBUq9Ya4Ah3DnQ1R2xxhvcsZqZJfL+7NIihrfHr7tIkk812WfYW+GTFUWGpPjs9YzPbgyrIZri+/U+JCAVc3rIJmvtwYYowFdycqqgGQsOb8FPyuOn5SOBtm3kJlw34Xh4cyGVCrOxm6gsVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719962377; c=relaxed/simple;
	bh=bQ06CraotrSkN7AxaRIsNmFzHLZgnyqFgvxFVuefRxA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NIOxWB6GMiSU/8E1Lggm4n/pERmIbP0CSrXzdGLaLheJ6smPBrJzQTZPhYa0aJ3EO2hVJEx8K+XNIKq1wc6l/mUGIAdAwj7ZBbtqQ8Wvl153kMcsGYc903rk2T4VJBm8uWNJOEKsI8ayBPCpnFdNL3Sdb4sn7t4tFKKtzfsNu+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a18w35X3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3105C2BD10;
	Tue,  2 Jul 2024 23:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719962376;
	bh=bQ06CraotrSkN7AxaRIsNmFzHLZgnyqFgvxFVuefRxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a18w35X3SJOnfUOilKyaCN3KPlK+3XTqA9O3RrSVf7Wl2k+7uY/FqCJmdoeB6tryh
	 xXI6VL5bbIa3RSucHTTpdgdf0ylMbQWScXfEBmzJQ+/fAkHEaA60bXkuLuqzBhWWAC
	 pU2gq5f+Z/jIBzmNSOyFLxc8IQKriBmIaMYP64H2DMJLnJZzgniEGs8jvQZPhTxvZQ
	 f+pdhInzJHUrYe10h0f3gszF1p2iza+6M0RMccFkj1/5kyOpGoKLhiyhk3Rr8ThHEy
	 NAJJys0rfNzg2rZwvf90HAoJS3O7nWpDBZtYhLY5jRnFyw9uvlr57P2QrrSmDbf2D2
	 /3s/5QHet59ug==
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
Subject: Re: [RFC PATCH v2 5/7] MAINTAINERS: Add entry for new VMA files
Date: Tue,  2 Jul 2024 16:19:32 -0700
Message-Id: <20240702231933.78857-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <0319419d965adc03bf22fee66e39244fc3d65528.1719584707.git.lstoakes@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Lorenzo,

On Fri, 28 Jun 2024 15:35:26 +0100 Lorenzo Stoakes <lstoakes@gmail.com> wrote:

> The vma files contain logic split from mmap.c for the most part and are all
> relevant to VMA logic, so maintain the same reviewers for both.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>  MAINTAINERS | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 098d214f78d9..0847cb5903ab 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23971,6 +23971,19 @@ F:	include/uapi/linux/vsockmon.h
>  F:	net/vmw_vsock/
>  F:	tools/testing/vsock/
>  
> +VMA
> +M:	Andrew Morton <akpm@linux-foundation.org>
> +R:	Liam R. Howlett <Liam.Howlett@oracle.com>
> +R:	Vlastimil Babka <vbabka@suse.cz>
> +R:	Lorenzo Stoakes <lstoakes@gmail.com>
> +L:	linux-mm@kvack.org
> +S:	Maintained
> +W:	http://www.linux-mm.org

I know this is just copy-pasted. But, what about using https instead of http?

> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> +F:	mm/vma.c
> +F:	mm/vma.h
> +F:	mm/vma_internal.h
> +
>  VMALLOC
>  M:	Andrew Morton <akpm@linux-foundation.org>
>  R:	Uladzislau Rezki <urezki@gmail.com>
> -- 
> 2.45.1
> 
> 


Thanks,
SJ

