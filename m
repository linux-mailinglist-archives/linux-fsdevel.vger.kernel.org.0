Return-Path: <linux-fsdevel+bounces-30105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF7898637D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 17:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59BFA1C26D37
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 15:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7755712E1CA;
	Wed, 25 Sep 2024 15:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tQZCg/98"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349BE127E01;
	Wed, 25 Sep 2024 15:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727277618; cv=none; b=QItQpZB7pmwQVN6tDd7V7NLP1lSNmFOX0cA69UQ6G3jWK2NWlyQsVaa3qsd/w3g5PpMD45xRqj0u5VXyhUAlqW6ByhF8attBY6/MiKetk6GqaZHVt7ZudNShfX6IcSFpHwqhsS0UXivsUdkNukFzeE64sC0RnkxRllJo7PC1RCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727277618; c=relaxed/simple;
	bh=2OzWc76CJ5Bsdr55197joKnim82KEQLgiZs3sWvyAuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KcICDikE8iOEDRFy5OWhT4I1n5joVz8teahmi6v0lGeaNWyJLUn8RDClTyTSxG3HsJIa0vttRMsGlQEOIrCRqAX6cSpotpWJlf4pbDr2iNP5WJAYAyuD+RImC9iQNJbrkfRH3uIuKYnX42XX3cqUmHyTa9GTfDZKlvAtiNLV98Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tQZCg/98; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 25 Sep 2024 11:20:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727277614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aiHBYW61Q99lbPSaV3HFKFXGi8oz8BK9hAfEMY5UgxM=;
	b=tQZCg/98FFy29MUkAxwsbzmf8AF1oEoXBMLojN/+ZjZYOa1tHJZbz3oL0DfOnQlSiVteru
	EHfuraK3s6oGhieaq/Jp9xGDoGbN4N2+es2xxuW/cKTAHxHnZwAPqejT2gF46hF6rGG0Ax
	ULXMvYRDez98G852BeNmHa8uTm+5r2E=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+c0360e8367d6d8d04a66@syzkaller.appspotmail.com, 
	brauner@kernel.org, jack@suse.cz, jfs-discussion@lists.sourceforge.net, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] bcachefs: return the error code instead of the return
 value of IS_ERR_OR_NULL
Message-ID: <ywccsi7uqqnsfha4yvg6lycsbafeqwylwabwvkjprjrv66q4sb@kxuz3ygc5qp7>
References: <66f33aad.050a0220.457fc.0030.GAE@google.com>
 <tencent_4A8FBB4133EA9E461B0C4B2C1B2425FFBA08@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_4A8FBB4133EA9E461B0C4B2C1B2425FFBA08@qq.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Sep 25, 2024 at 09:53:00PM GMT, Edward Adam Davis wrote:
> Syzbot report a kernel BUG in vfs_get_tree.
> The root cause is that read_btree_nodes() returned 1 and returned -EINTR
> due to kthread_run() execution failure.
> 
> The -EINTR needs to be returnned to bch2_fs_recovery(), not return to
> "ret = IS_ERR_OR_NULL(t)".
> 
> Reported-and-tested-by: syzbot+c0360e8367d6d8d04a66@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=c0360e8367d6d8d04a66
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  fs/bcachefs/btree_node_scan.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/bcachefs/btree_node_scan.c b/fs/bcachefs/btree_node_scan.c
> index b28c649c6838..df7090ca1e81 100644
> --- a/fs/bcachefs/btree_node_scan.c
> +++ b/fs/bcachefs/btree_node_scan.c
> @@ -281,6 +281,10 @@ static int read_btree_nodes(struct find_btree_nodes *f)
>  			closure_put(&cl);
>  			f->ret = ret;
>  			bch_err(c, "error starting kthread: %i", ret);
> +			if (IS_ERR(t)) {
> +				closure_sync(&cl);
> +				return PTR_ERR(t);
> +			}
>  			break;
>  		}
>  	}
> -- 
> 2.43.0
> 

I fixed this last night with the patch below...

commit c1a6f5ca052b7f8609917d13cd11fc60c94396aa
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Tue Sep 24 19:31:22 2024 -0400

    bcachefs: Fix incorrect IS_ERR_OR_NULL usage
    
    Returning a positive integer instead of an error code causes error paths
    to become very confused.
    
    Closes: syzbot+c0360e8367d6d8d04a66@syzkaller.appspotmail.com
    Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>

diff --git a/fs/bcachefs/btree_node_scan.c b/fs/bcachefs/btree_node_scan.c
index b28c649c6838..1e694fedc5da 100644
--- a/fs/bcachefs/btree_node_scan.c
+++ b/fs/bcachefs/btree_node_scan.c
@@ -275,7 +275,7 @@ static int read_btree_nodes(struct find_btree_nodes *f)
 		w->ca		= ca;
 
 		t = kthread_run(read_btree_nodes_worker, w, "read_btree_nodes/%s", ca->name);
-		ret = IS_ERR_OR_NULL(t);
+		ret = PTR_ERR_OR_ZERO(t);
 		if (ret) {
 			percpu_ref_put(&ca->io_ref);
 			closure_put(&cl);

