Return-Path: <linux-fsdevel+bounces-18907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B30F38BE598
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 16:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E6C3283967
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 14:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF9916EBF4;
	Tue,  7 May 2024 14:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Av4TfY/Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6818516C6B2
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 May 2024 14:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715091271; cv=none; b=tqo8UW38ePCDOFc0u1mg1D/QiDaFAcU8J4+FS/Znlmj8E0JcVlNdr24z+0Hp61RfgFJ9pvE1LPiUCUlfFqn1/My2Fa4Db7rJ+2OqFbQt8SZ7oMykrpMSc9qKc3gj7RMGJUSqW2MviS4aVr2k7qV9xMzznr7rNyD69yfI7xcR+XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715091271; c=relaxed/simple;
	bh=xdOHfuHS5StnxBHCTEJkYsqUj8aOzNvad/FTP0nEDaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJVGYc3BmTGtVVbhXgxVB4mDxL73P+lB0Wrh+ia43GwAK2NXtOmQ3Bs9RRyqFrfJKFdx9yczidyXfSEMetAdA+49D4R8icp1tNwyOS2akBegXJdNUu80NcDKuP5vf4cZzMiVlFR6+PSIlYLjOPCRi7lXBcSq0tHoxnSK3dzsmas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Av4TfY/Z; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 7 May 2024 10:14:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715091266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VRyoFPGhxdjbkIozpMsjzFu89GHel68HSD+8ZqqtWG0=;
	b=Av4TfY/ZIvxNTOvtyyb+RY1VowrMG5yD4yAQcHHjk7mtfG2am+asc1aypyqQNNh+eMf+aj
	xCspfKfbcKl2rGkWluqfmHWGMr8QvxXmmwiZMFHvkmV/8gFSRz5PpHabzMG5RbsJ+WEO3c
	O7H1jBCxqPHp9aBvk8j2tctCqLmDgZg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+c48865e11e7e893ec4ab@syzkaller.appspotmail.com, 
	bfoster@redhat.com, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] bcachefs: fix oob in bch2_sb_clean_to_text
Message-ID: <x73mcz4gjzdmwlynj426sq34zj232wr2z2xjbjc4tkcdbfpegb@hr55sh6pn7ol>
References: <000000000000918c290617b914ba@google.com>
 <tencent_816D842DE96C309554E8E2ED9ACC6078120A@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_816D842DE96C309554E8E2ED9ACC6078120A@qq.com>
X-Migadu-Flow: FLOW_OUT

On Tue, May 07, 2024 at 05:19:29PM +0800, Edward Adam Davis wrote:
> When got too small clean field, entry will never equal vstruct_end(&clean->field), 
> the dead loop resulted in out of bounds access.
> 
> Fixes: 12bf93a429c9 ("bcachefs: Add .to_text() methods for all superblock sections")
> Fixes: a37ad1a3aba9 ("bcachefs: sb-clean.c")
> Reported-and-tested-by: syzbot+c48865e11e7e893ec4ab@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>

I've already got a patch up for this - the validation was missing as
well.

commit f39055220f6f98a180e3503fe05bbf9921c425c8
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Sun May 5 22:28:00 2024 -0400

    bcachefs: Add missing validation for superblock section clean
    
    We were forgetting to check for jset entries that overrun the end of the
    section - both in validate and to_text(); to_text() needs to be safe for
    types that fail to validate.
    
    Reported-by: syzbot+c48865e11e7e893ec4ab@syzkaller.appspotmail.com
    Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>

diff --git a/fs/bcachefs/sb-clean.c b/fs/bcachefs/sb-clean.c
index 35ca3f138de6..194e55b11137 100644
--- a/fs/bcachefs/sb-clean.c
+++ b/fs/bcachefs/sb-clean.c
@@ -278,6 +278,17 @@ static int bch2_sb_clean_validate(struct bch_sb *sb,
 		return -BCH_ERR_invalid_sb_clean;
 	}
 
+	for (struct jset_entry *entry = clean->start;
+	     entry != vstruct_end(&clean->field);
+	     entry = vstruct_next(entry)) {
+		if ((void *) vstruct_next(entry) > vstruct_end(&clean->field)) {
+			prt_str(err, "entry type ");
+			bch2_prt_jset_entry_type(err, le16_to_cpu(entry->type));
+			prt_str(err, " overruns end of section");
+			return -BCH_ERR_invalid_sb_clean;
+		}
+	}
+
 	return 0;
 }
 
@@ -295,6 +306,9 @@ static void bch2_sb_clean_to_text(struct printbuf *out, struct bch_sb *sb,
 	for (entry = clean->start;
 	     entry != vstruct_end(&clean->field);
 	     entry = vstruct_next(entry)) {
+		if ((void *) vstruct_next(entry) > vstruct_end(&clean->field))
+			break;
+
 		if (entry->type == BCH_JSET_ENTRY_btree_keys &&
 		    !entry->u64s)
 			continue;

