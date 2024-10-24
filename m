Return-Path: <linux-fsdevel+bounces-32691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C76E9ADBC2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 08:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E8F01F21E9E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 06:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68F0175D53;
	Thu, 24 Oct 2024 06:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7JWcuA0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCBE17BD3;
	Thu, 24 Oct 2024 06:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729750200; cv=none; b=FrzrHzEI0V1nA8HduzCmC8cq9nuocRqKaryxG4rG1IFoy+9QN95nHSVngBV1OpMfyxgLA2l1QgUv8DY+i1ctgw1l6lzEQ8KB2vUxnxiV6KU4xCq1asuExW2Pm1MGkLtr9A/heb2NabHfa9gccEZ0hXHlQvWYR+pz3z3dCJTg+DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729750200; c=relaxed/simple;
	bh=Rb6ntbZSVwnjaYn15Q1UXmMWbHf3qu9YkFhJ89kDEs0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PqGZss9D3nxExWcCnoG9ULA/CrOqFuUCYWRI0ckXqfIFlKvpKZKvz5aIfjdP7WvpC8BrpZozvP+UOeqDtqwmvKQeZoUvmoNxtem63cn+WpShInCw99+89RQcWOto24Bf7sGPjj3zAXDngUV0tpp8WXNk90yWhfjodmy53nG47CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y7JWcuA0; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-7ea7e250c54so366151a12.0;
        Wed, 23 Oct 2024 23:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729750197; x=1730354997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3YtbyEaMsa4GAbWnsy2Tbe/1HjhrxOqJDOx9rhvgg2o=;
        b=Y7JWcuA0TzX2F+a91fvvpbCJACOl5XCoImMZMZZW/GgNFQC9nn6s+SYVHId3pMBjGu
         CdIN4jYPzcwirPhLUvIm3LFyUeTW0tH6cO9OnvIyhK4JQF2m7RnXfGUASapizsj5bQ/a
         dEtSGMKQlLRiTlks66pCtn4kqrSc0QP8ySOD31ZuJixHDYqfM25RkNVUPVASEFGnwxVi
         u6XQvQGtpxxFcwxFSRBlvyQQRF0mNr8t9Ksfty+g38y6rRSCnOmrpDOHrATteVFCe+QQ
         cwUbHjHUicq+jSZWlj7KmE3CXX+e0LrXDqPNmAJcbh55CF6/FA/Dr2o+oV25eN1XJEMy
         zWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729750197; x=1730354997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3YtbyEaMsa4GAbWnsy2Tbe/1HjhrxOqJDOx9rhvgg2o=;
        b=g2Us5Qa7o/+DkyrARtm6dAn2VVtGAgzM9Ht3I8r654kg0vkBjhZ5AquRSzJztspVXn
         rG6KGStXw3Ugvj+i/lmfkV/X3qjGBY8ENEEuUhN5A6Zzfzsi3CmZDWO3EMkd31dpQ4wN
         f7/krC6/SjyDPJp9ije+wv7TsXxxmvi2Qh0kJ7fT4iF6s6dgvs65SYtVtI42zbyOpxg8
         N4gPAg1F7VBATUrn46U/lVAVHGVtwtCCxfluo5h6Afm2Jf41/cKlaS6GkVScaUXhko8t
         vFG2CJRTgRTzdr/5uyOvl6+NLmYlDZrzcZijop9heReEelDaObBNRmlbkmjUG4leKnkm
         kCLw==
X-Forwarded-Encrypted: i=1; AJvYcCU9G8USnfSM2m90aI9n2scoHqeZzfrjdw/JWuBfi12y/yl/7CkFrC8CtEK5HkS07JLReI0qTcjj81fmVp6A@vger.kernel.org, AJvYcCXgS6Bq8gW/Cy5NI2gxrpCTVaq1Q37CzFcRs8hl6duDMy3xkg8qH3qbs0fTbaPE45DiARzXfIsVnC2Kr543@vger.kernel.org
X-Gm-Message-State: AOJu0Yy43X6f7hnjzkwLHKz3vlLFJX+HGoY1wd4eb0UHD7XBH00spy7d
	zhzjRjkCObVUmM3Wb4TcejZ/APZ41iPDWbHRnIBYq4e/fYYtfLAb
X-Google-Smtp-Source: AGHT+IEb4DbHvwbycDEptOsdZXO6q1mXwibi0nQJsNWuqbQ3vGbu82WIslgzpjLzZdW8RPJK3z2x2A==
X-Received: by 2002:a05:6a21:174d:b0:1cf:38cf:df92 with SMTP id adf61e73a8af0-1d978b2e2d8mr6172207637.30.1729750197500;
        Wed, 23 Oct 2024 23:09:57 -0700 (PDT)
Received: from localhost.localdomain ([43.154.34.99])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec132ffb8sm7329074b3a.50.2024.10.23.23.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 23:09:57 -0700 (PDT)
From: Jim Zhao <jimzhao.ai@gmail.com>
To: akpm@linux-foundation.org
Cc: jimzhao.ai@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	willy@infradead.org
Subject: Re: [PATCH] mm/page-writeback: Raise wb_thresh to prevent write blocking with strictlimit
Date: Thu, 24 Oct 2024 14:09:54 +0800
Message-Id: <20241024060954.443574-1-jimzhao.ai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241023162447.2bf480b4ce590fdeb8b6c52d@linux-foundation.org>
References: <20241023162447.2bf480b4ce590fdeb8b6c52d@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On Wed, 23 Oct 2024 18:00:32 +0800 Jim Zhao <jimzhao.ai@gmail.com> wrote:

> > With the strictlimit flag, wb_thresh acts as a hard limit in
> > balance_dirty_pages() and wb_position_ratio(). When device write
> > operations are inactive, wb_thresh can drop to 0, causing writes to
> > be blocked. The issue occasionally occurs in fuse fs, particularly
> > with network backends, the write thread is blocked frequently during
> > a period. To address it, this patch raises the minimum wb_thresh to a
> > controllable level, similar to the non-strictlimit case.

> Please tell us more about the userspace-visible effects of this.  It
> *sounds* like a serious (but occasional) problem, but that is unclear.

> And, very much relatedly, do you feel this fix is needed in earlier
> (-stable) kernels?

The problem exists in two scenarios:
1. FUSE Write Transition from Inactive to Active

sometimes, active writes require several pauses to ramp up to the appropriate wb_thresh.
As shown in the trace below, both bdi_setpoint and task_ratelimit are 0, means wb_thresh is 0. 
The dd process pauses multiple times before reaching a normal state.

dd-1206590 [003] .... 62988.324049: balance_dirty_pages: bdi 0:51: limit=295073 setpoint=259360 dirty=454 bdi_setpoint=0 bdi_dirty=32 dirty_ratelimit=18716 task_ratelimit=0 dirtied=32 dirtied_pause=32 paused=0 pause=4 period=4 think=0 cgroup_ino=1
dd-1206590 [003] .... 62988.332063: balance_dirty_pages: bdi 0:51: limit=295073 setpoint=259453 dirty=454 bdi_setpoint=0 bdi_dirty=33 dirty_ratelimit=18716 task_ratelimit=0 dirtied=1 dirtied_pause=0 paused=0 pause=4 period=4 think=4 cgroup_ino=1
dd-1206590 [003] .... 62988.340064: balance_dirty_pages: bdi 0:51: limit=295073 setpoint=259526 dirty=454 bdi_setpoint=0 bdi_dirty=34 dirty_ratelimit=18716 task_ratelimit=0 dirtied=1 dirtied_pause=0 paused=0 pause=4 period=4 think=4 cgroup_ino=1
dd-1206590 [003] .... 62988.348061: balance_dirty_pages: bdi 0:51: limit=295073 setpoint=259531 dirty=489 bdi_setpoint=0 bdi_dirty=35 dirty_ratelimit=18716 task_ratelimit=0 dirtied=1 dirtied_pause=0 paused=0 pause=4 period=4 think=4 cgroup_ino=1
dd-1206590 [003] .... 62988.356063: balance_dirty_pages: bdi 0:51: limit=295073 setpoint=259531 dirty=490 bdi_setpoint=0 bdi_dirty=36 dirty_ratelimit=18716 task_ratelimit=0 dirtied=1 dirtied_pause=0 paused=0 pause=4 period=4 think=4 cgroup_ino=1
...

2. FUSE with Unstable Network Backends and Occasional Writes
Not easy to reproduce, but when it occurs in this scenario, 
it causes the write thread to experience more pauses and longer durations.


Currently, some code is in place to improve this situation, but seems insufficient:
if (dtc->wb_dirty < 8)
{
	// ...
}

So the patch raise min wb_thresh to keep the occasional writes won't be blocked and
active writes can rampup the threshold quickly.

--

Thanks,
Jim Zhao


