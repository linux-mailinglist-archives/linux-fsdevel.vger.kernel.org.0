Return-Path: <linux-fsdevel+bounces-2746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C657E897E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Nov 2023 07:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5792DB20BDA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Nov 2023 06:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393646FDC;
	Sat, 11 Nov 2023 06:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LEndJGQI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285F36FB6;
	Sat, 11 Nov 2023 06:21:14 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500D11BD;
	Fri, 10 Nov 2023 22:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HjnXgPbnUna/oPgDe8pEjrr2CwDcTyuc+FlgnPW0cEU=; b=LEndJGQIQvi05zDNMiV2VbqNWw
	QtZjw7fZehxVtinobkFEIB0CmpZhTCBVAun9aIyFYPuY5ZZ/bdcEKeaxwJcuJBOAHC1hFp3JI2L3S
	uJg+zFEiMGAIuL0aZbs/60b3dpkki+9fC+Nuxyknv5K8bbWm2HynYnSjxG2zh/mEK3N4IihxzcinA
	Hj28C5DGl9xC6AWA9p0COKynwntiWbGP9Tav34JFfMiEwZfkx1DhKzXlC4mZmLMNIeMOH6ui6g0AK
	x2U8dgZoHix86uO3+8OmLMLkLI1GPpxuwS8Pd9WBmPFF71bZ5xUDGyAR+Z5tdyqLVBehBBAL8FFDV
	cbvopBIQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r1hMZ-000Kw2-Ej; Sat, 11 Nov 2023 06:20:59 +0000
Date: Sat, 11 Nov 2023 06:20:59 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+4d81015bc10889fd12ea@syzkaller.appspotmail.com, boris@bur.io,
	clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] btrfs: fix warning in create_pending_snapshot
Message-ID: <ZU8dS0dlOGOblbxf@casper.infradead.org>
References: <0000000000001959d30609bb5d94@google.com>
 <tencent_DB6BA6C1B369A367C96C83A36457D7735705@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_DB6BA6C1B369A367C96C83A36457D7735705@qq.com>

On Sat, Nov 11, 2023 at 01:06:01PM +0800, Edward Adam Davis wrote:
> +++ b/fs/btrfs/disk-io.c
> @@ -4931,7 +4931,8 @@ int btrfs_get_free_objectid(struct btrfs_root *root, u64 *objectid)
>  		goto out;
>  	}
>  
> -	*objectid = root->free_objectid++;
> +	while (find_qgroup_rb(root->fs_info, root->free_objectid++));
> +	*objectid = root->free_objectid;

This looks buggy to me.  Let's say that free_objectid is currently 3.

Before, it would assign 3 to *objectid, and increment free_objectid to
4.  After (assuming the loop terminates on first iteration), it will
increment free_objectid to 4, then assign 4 to *objectid.

I think you meant to write:

	while (find_qgroup_rb(root->fs_info, root->free_objectid))
		root->free_objectid++;
	*objectid = root->free_objectid++;

And the lesson here is that more compact code is not necessarily more
correct code.

(I'm not making any judgement about whether this is the correct fix;
I don't understand btrfs well enough to have an opinion.  Just that
this is not an equivalent transformation)

