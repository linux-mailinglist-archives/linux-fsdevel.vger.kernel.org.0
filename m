Return-Path: <linux-fsdevel+bounces-41671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B13CFA348D5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 17:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EC9E188F3DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 16:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2491FFC5C;
	Thu, 13 Feb 2025 16:01:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC891E0087
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Feb 2025 16:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739462506; cv=none; b=L31Kv999DrOYAn+dKWDwPQ+xV0CP1HFnWQ8lmJOTqi6aX2HEUDFSb6buI3uabQiuYYgaZXK8sCCrL6N58sh+I9R0XJwcxECWQITE1cxWKX+9tPzlg2+mn5qe6QSKO5j6I1u9xLThosZDCQ0dhAGn+NElXNaqVIG4MJ9Wn/ZD9s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739462506; c=relaxed/simple;
	bh=kHjRefsv4ThbOtqwiuf5n1stwZEZB/5LIQ4AAEYCQqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sDEkNyjN8CSm7FoT7th9AJQNY2MF8fplZn1rEcslQAivxqRtVPNkU2YP9HAo6gXHFOUhRdUGA7btP/FnXf+5gnxd+74GbEuc1d3iS0TDFhfts2iBcB2+AqEMP0wRYprsqSNwuImo8c87YoDLEd50i7yk8R50ySRVZcSrrHbg1Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-224.bstnma.fios.verizon.net [173.48.82.224])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 51DG13NZ005146
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 11:01:05 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id AAA7715C000B; Thu, 13 Feb 2025 11:01:03 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Zhang Yi <yi.zhang@huaweicloud.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        ojaswin@linux.ibm.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
        yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v5 00/10] ext4: clean up and refactor fallocate
Date: Thu, 13 Feb 2025 11:00:56 -0500
Message-ID: <173946232424.399068.12866754767074223463.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241220011637.1157197-1-yi.zhang@huaweicloud.com>
References: <20241220011637.1157197-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 20 Dec 2024 09:16:27 +0800, Zhang Yi wrote:
> Changes since v4:
>  - In patch 1, call ext4_truncate_folio() only if truncating range is
>    PAGE_SIZE unaligned, and rename the variable start_boundary to
>    page_boundary.
> Changes since v3:
>  - In patch 1, rename ext4_truncate_folios_range() and move journalled
>    mode specified handles and truncate_pagecache_range() into this
>    helper.
>  - In patch 3, switch to use ext4_truncate_page_cache_block_range().
>  - In patch 4, use IS_ALIGNED macro to check offset alignments and
>    introduce EXT4_B_TO_LBLK to do the lblk conversion.
>  - In patch 5, keep the first ext4_alloc_file_blocks() call before
>    truncating pagecache.
>  - In patch 9, rename 'out' label to 'out_inode_lock'.
> Changes since v2:
>  - Add Patch 1 to address a newly discovered data loss issue that occurs
>    when using mmap to write after zeroing out a partial page on a
>    filesystem with the block size smaller than the page size.
>  - Do not write all data before punching hole, zeroing out and
>    collapsing range as Jan suggested, also drop current data writeback
>    in ext4_punch_hole().
>  - Since we don't write back all data in these 4 operations, we only
>    writeback data during inserting range,so do not factor out new
>    helpers in the last two patches, just move common components of
>    sub-operations into ext4_fallocate().
>  - Only keep Jan's review tag on patch 2 and 8, other patches contain
>    many code adaptations, so please review them again.
> Changes since v1:
>  - Fix an using uninitialized variable problem in the error out path in
>    ext4_do_fallocate() in patch 08.
> 
> [...]

Applied, thanks!

[01/10] ext4: remove writable userspace mappings before truncating page cache
        commit: 17207d0bb209e8b40f27d7f3f96e82a78af0bf2c
[02/10] ext4: don't explicit update times in ext4_fallocate()
        commit: 73ae756ecdfa9684446134590eef32b0f067249c
[03/10] ext4: don't write back data before punch hole in nojournal mode
        commit: 43d0105e2c7523cc6b14cad65e2044e829c0a07a
[04/10] ext4: refactor ext4_punch_hole()
        commit: 982bf37da09d078570650b691d9084f43805a5de
[05/10] ext4: refactor ext4_zero_range()
        commit: 53471e0bedad5891b860d02233819dc0e28189e2
[06/10] ext4: refactor ext4_collapse_range()
        commit: 162e3c5ad1672ef41dccfb28ad198c704b8aa9e7
[07/10] ext4: refactor ext4_insert_range()
        commit: 49425504376c335c68f7be54ae7c32312afd9475
[08/10] ext4: factor out ext4_do_fallocate()
        commit: fd2f764826df5489b849a8937b5a093aae5b1816
[09/10] ext4: move out inode_lock into ext4_fallocate()
        commit: ea3f17efd36b56c5839289716ba83eaa85893590
[10/10] ext4: move out common parts into ext4_fallocate()
        commit: 2890e5e0f49e10f3dadc5f7b7ea434e3e77e12a6

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

