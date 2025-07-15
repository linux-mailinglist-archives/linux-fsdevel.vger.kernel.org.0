Return-Path: <linux-fsdevel+bounces-54908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 332A0B05028
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 06:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A49418868A7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 04:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF512D3EE0;
	Tue, 15 Jul 2025 04:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="cK61xtd+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6B12D12F7
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 04:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752552433; cv=none; b=B5NHUv/+JklB9NyKNXdRpuSuJ8NeSj23VsG1AStH8k7BE7yq7vvTAJxvHlu52zI1l+d98xwe6R3jitw7VApqLElblfpWWkk64gtFiDLUjEhVzoWWO2BgzcEXNU8M1hj2FnPUwy5Kge9321Q1LFBiInMq23jfc2++xjIJx/e1VFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752552433; c=relaxed/simple;
	bh=16YuOXnyHNBa4xRumnTGtefkX15zcHJlAFqOug6HSWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JAIYs6VIBxG7YovFQxosR+XxSmin6E2iqtV5Hq/M881SZ8PFf+J9MnYNrDVGBA0G2PPS/FuJPqiBCQQgOE9dapMcrPX5jdWS8h9Rg2iU37j77SC3xl7jyHK5WE1c4KVuEwMnTo7P+rVQjE4nqzXcdlNcI32ee5qnKKWn6qmhagU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=cK61xtd+; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-108-26-156-88.bstnma.fios.verizon.net [108.26.156.88])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 56F46OdZ005344
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 00:06:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1752552387; bh=48j+0fyCeUynZPfeA504+in5P/rOTdddUoo4ZZolQmA=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=cK61xtd+ZQsZtrcv48O6KhL2oTkrXT9d8+Y7kCz4ziDTvThcwVnG0dXwqO6K9jHWl
	 loIQpB9eMC2PA7F0TIAY+WZRTvOhrN9b0hQQasl3bmGe2aM89aD6HnBdk6XErdavcp
	 XdB2SO8rVJ33jdLngCO2Z8kKOgT+GeuuJe6cj3urjY07pIBGI14hkYzotVUuGyoIjd
	 1WN00qSrLXIs9js8AX4RM+CjlEwN1OrnZFuegxBzSvk7zteK1apoxNVGZOWt4OgSFn
	 uWKgGD8nqcCyr/z93eCRGeT3+l10Nhp3cNwoPqTAbJTqEHcQEz+8OlJl+GizlxJ+/v
	 S5+ILDBc1wNOg==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id D07EA2E00D5; Tue, 15 Jul 2025 00:06:23 -0400 (EDT)
Date: Tue, 15 Jul 2025 00:06:23 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        ojaswin@linux.ibm.com, sfr@canb.auug.org.au, yi.zhang@huawei.com,
        libaokun1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH -next] ext4: fix the compile error of
 EXT4_MAX_PAGECACHE_ORDER macro
Message-ID: <20250715040623.GA112967@mit.edu>
References: <20250715031203.2966086-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715031203.2966086-1-yi.zhang@huaweicloud.com>

On Tue, Jul 15, 2025 at 11:12:03AM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Since both the input and output parameters of the
> EXT4_MAX_PAGECACHE_ORDER should be unsigned int type, switch to using
> umin() instead of min(). This will silence the compile error reported by
> _compiletime_assert() on powerpc.

I've updated patch "ext4: limit the maximum folio order" with the
one-character change in the patch.  Thanks for providing the fix, and
thanks for Stephe for reporting the build failure on PowerPC.

I've updated the dev and pu branches.  (The proposed update patches
are the patch series that I'm currently testing and is under review.)

*   e30451675144 - (HEAD -> pu, ext4/pu) Merge branch 'bl/scalable-allocations' into pu (9 minutes ago)
|\  
| * abbcf4c5726d - (bl/scalable-allocations) ext4: implement linear-like traversal across order xarrays (10 minutes ago)
| * b81f9dc5d0ba - ext4: refactor choose group to scan group (10 minutes ago)
| * 7f4f2b5fcc3c - ext4: convert free groups order lists to xarrays (10 minutes ago)
| * e47286abe4d8 - ext4: factor out ext4_mb_scan_group() (10 minutes ago)
| * d1751cabc522 - ext4: factor out ext4_mb_might_prefetch() (10 minutes ago)
| * e91438837515 - ext4: factor out __ext4_mb_scan_group() (10 minutes ago)
| * 681eed57747a - ext4: fix largest free orders lists corruption on mb_optimize_scan switch (10 minutes ago)
| * f63c2c051c86 - ext4: fix zombie groups in average fragment size lists (10 minutes ago)
| * 985751249886 - ext4: merge freed extent with existing extents before insertion (10 minutes ago)
| * f73e72c088df - ext4: convert sbi->s_mb_free_pending to atomic_t (10 minutes ago)
| * 7963f5081eb7 - ext4: fix typo in CR_GOAL_LEN_SLOW comment (10 minutes ago)
| * fe14b9db818e - ext4: get rid of some obsolete EXT4_MB_HINT flags (10 minutes ago)
| * f9090356786d - ext4: utilize multiple global goals to reduce contention (10 minutes ago)
| * 83f7fa7c57df - ext4: remove unnecessary s_md_lock on update s_mb_last_group (10 minutes ago)
| * 79aef63bd0e5 - ext4: remove unnecessary s_mb_last_start (10 minutes ago)
| * b29898a8ca5c - ext4: separate stream goal hits from s_bal_goals for better tracking (10 minutes ago)
| * 7555f2d09299 - ext4: add ext4_try_lock_group() to skip busy groups (10 minutes ago)
* |   92c2926d33ce - Merge branch 'tt/dotdot' into pu (10 minutes ago)
|\ \  
| |/  
|/|   
| * 4a1458d4d3a6 - (tt/dotdot) ext4: refactor the inline directory conversion and new directory codepaths (11 minutes ago)
| * c75c1d7897e5 - ext4: use memcpy() instead of strcpy() (11 minutes ago)
| * 63f1e6f25c71 - ext4: replace strcmp with direct comparison for '.' and '..' (11 minutes ago)
|/  
* b12f423d598f - (ext4/dev, dev) ext4: limit the maximum folio order (15 minutes ago)
* 5137d6c8906b - ext4: fix insufficient credits calculation in ext4_meta_trans_blocks() (24 hours ago)
* 57661f28756c - ext4: replace ext4_writepage_trans_blocks() (24 hours ago)
* bbbf150f3f85 - ext4: reserved credits for one extent during the folio writeback (24 hours ago)
* 95ad8ee45cdb - ext4: correct the reserved credits for extent conversion (24 hours ago)
* 6b132759b0fe - ext4: enhance tracepoints during the folios writeback (24 hours ago)
* e2c4c49dee64 - ext4: restart handle if credits are insufficient during allocating blocks (24 hours ago)
* 2bddafea3d0d - ext4: refactor the block allocation process of ext4_page_mkwrite() (24 hours ago)
* ded2d726a304 - ext4: fix stale data if it bail out of the extents mapping loop (24 hours ago)
* f922c8c2461b - ext4: move the calculation of wbc->nr_to_write to mpage_folio_done() (24 hours ago)
* 1bfe6354e097 - ext4: process folios writeback in bytes (24 hours ago)
* a073e8577f18 - ext4: remove unused EXT_STATS macro from ext4_extents.h (2 days ago)
* c5da1f66940d - ext4: remove unnecessary duplicate check in ext4_map_blocks() (3 days ago)
* b6f3801727e4 - ext4: remove duplicate check for EXT4_FC_REPLAY (4 days ago)

       	   	      		    	  - Ted

