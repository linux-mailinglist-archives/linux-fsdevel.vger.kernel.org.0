Return-Path: <linux-fsdevel+bounces-411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9907CAB02
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 16:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA1A12816FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 14:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DD128DB2;
	Mon, 16 Oct 2023 14:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AdtBRvrY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D52B286A6;
	Mon, 16 Oct 2023 14:11:15 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175A29B;
	Mon, 16 Oct 2023 07:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=czV84VhOyQlJV3boH+4QfGzVmblLtaU2dw7F3ceDF1A=; b=AdtBRvrY0I7rDxLM3v6Xhb14vK
	pgYuVcXg9Fc97jR6r0nofizvmWPF7ePoe3c518Uiix2HWu8YOKh9+jkLQaO/SLHahQf9hf1ZKSo4Z
	QuYvPyeMoXlz130uNdkiG9okgrwfKPybajkRTryFhfDHVlpw3dKqhXBxpDtY3dTajR640O/16fDG3
	aLJonvWi/fNtdnYvbFHdHtt4UYGEZJtOJqsy8ySp5XydZXV4xycLu6wCZbsDaNolEcr1flKH9wbSB
	XuPeRhrD7TVuwT8XQo+8UEurGWyZSjnyj1siPNHt3Zd0d6YBjt1bPsDkY3leLRpkJ1zwGeAOmqiaZ
	mJdmezOQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qsOIT-006Str-8h; Mon, 16 Oct 2023 14:10:17 +0000
Date: Mon, 16 Oct 2023 15:10:17 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Peng Zhang <zhangpeng.00@bytedance.com>
Cc: Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
	brauner@kernel.org, surenb@google.com, michael.christie@oracle.com,
	mjguzik@gmail.com, mathieu.desnoyers@efficios.com,
	npiggin@gmail.com, peterz@infradead.org, oliver.sang@intel.com,
	mst@redhat.com, maple-tree@lists.infradead.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 03/10] maple_tree: Introduce interfaces __mt_dup() and
 mtree_dup()
Message-ID: <ZS1ESVpQ+vY0yDt4@casper.infradead.org>
References: <20231016032226.59199-1-zhangpeng.00@bytedance.com>
 <20231016032226.59199-4-zhangpeng.00@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016032226.59199-4-zhangpeng.00@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 11:22:19AM +0800, Peng Zhang wrote:
> +++ b/lib/maple_tree.c
> @@ -4,6 +4,10 @@
>   * Copyright (c) 2018-2022 Oracle Corporation
>   * Authors: Liam R. Howlett <Liam.Howlett@oracle.com>
>   *	    Matthew Wilcox <willy@infradead.org>
> + *
> + * Algorithm for duplicating Maple Tree
> + * Copyright (c) 2023 ByteDance
> + * Author: Peng Zhang <zhangpeng.00@bytedance.com>

You can't copyright an algorithm.  You can copyright the
_implementation_ of an algorithm.  You have a significant chunk of code
in this file, so adding your copyright is reasonable (although not
legally required, AIUI).  Just leave out this line:

+ * Algorithm for duplicating Maple Tree

> +/**
> + * __mt_dup(): Duplicate an entire maple tree
> + * @mt: The source maple tree
> + * @new: The new maple tree
> + * @gfp: The GFP_FLAGS to use for allocations
> + *
> + * This function duplicates a maple tree in Depth-First Search (DFS) pre-order
> + * traversal. It uses memcopy() to copy nodes in the source tree and allocate

memcpy()?

> +int __mt_dup(struct maple_tree *mt, struct maple_tree *new, gfp_t gfp)
> +{
> +	int ret = 0;
> +	MA_STATE(mas, mt, 0, 0);
> +	MA_STATE(new_mas, new, 0, 0);
> +
> +	mas_dup_build(&mas, &new_mas, gfp);
> +
> +	if (unlikely(mas_is_err(&mas))) {
> +		ret = xa_err(mas.node);
> +		if (ret == -ENOMEM)
> +			mas_dup_free(&new_mas);
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(__mt_dup);

Why does it need to be exported?


