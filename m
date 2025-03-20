Return-Path: <linux-fsdevel+bounces-44637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC921A6AE8A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 20:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B70BE173053
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 19:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8539229B0E;
	Thu, 20 Mar 2025 19:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ue+uI5MD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC33227B8C;
	Thu, 20 Mar 2025 19:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742499021; cv=none; b=EKMKUs1zeO9FMxqyYozxogCI+JmZE9EPDfsqGEKK0SrjLkmhBelhbXRjI1KP0Bm9XkNUpBe5xnYL03WDCYFW8080ObOzIDGIPAHL0Y7TeM+qTF2tSJbl5BdY681lz6A6vQSy3sBeABL7/7Y4jqPCKUDPYzSX+k1STif1GlkidAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742499021; c=relaxed/simple;
	bh=cjrQ7/A+o0M9kLVQ8XCMiZxelReUueYnwhxfM4/ol8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ba0r5JN7R3SDLsygfKLo176yBPuLogJBMjJ+oTRYKKJvCGESJdRq3GYYXrXzzI1a7AIhoR/QNqXjTvrGTA4TZbLMQemGv+qliFtfNgAZ5HP2GmgbhZKeme96JBQ1ID0LiK1oYKcpAkiTtBk+y8XHeb0w2BI8+nONVm9jo/24J/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ue+uI5MD; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac289147833so229446566b.2;
        Thu, 20 Mar 2025 12:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742499017; x=1743103817; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rnlUos378azUvuCBgqiYKu7ZcTNbQdf2U1HIKDB6jhM=;
        b=Ue+uI5MDNPOeg0q6ykY937qTPo9O7oBlao1/BRPEPBxPNxy0f1AMxGSBsSNvbXc7j6
         nKp8torqGqDUCi7Tjoj9QYpLnE79lN+v7sOe8TU5X8iTesiQKQyTYLtScbqw3g8D0aNv
         /s3XKlamKuYdk/MOUvLtzlWkmuSa2qv1zFss8WsbpOmhdj9bf+kuIPin7iNVwPbiShAz
         4IJrsV9VHXYsH7+qt1V1xPMknOPl4oWEN0M7Sw7IGz1D0Xbe8Cl3chcf+gtD8GwHL+nP
         E7KOl5/6d/bHhAUPtRatVDyY9BHiP//EkNXLuGNADKbRYMJmZ/T7amWbn2FbAWJ0d6qZ
         2Cgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742499017; x=1743103817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rnlUos378azUvuCBgqiYKu7ZcTNbQdf2U1HIKDB6jhM=;
        b=UzX2TFlpbnhinsdJ8yjV7ATNgcdmAXb3jpsfdbO5RG5esJtmmbtwbecDyFs5Ymc1zY
         BKTpBcoQIG79ule8g0Oof5i1y6LUVG81wr9X50YZn99IbXM7Slk4IjyaFnzYL6plqAOD
         LiuHhLgNrNTTP7nH6a8vtzcR+CW/rqXemtfncv2B1RKXJIW77c2XYQOIZgbxacA7UBQB
         OozTL+wso72lIwpd4BX+MjfRd4CWkczW5K/0smeUPHtn4xPqsaoG6bQR3iVCLNb/z6sf
         aCt80OlLG0SHXCyvzETZ8e5NCVyeGRuJwNvtUeMit/NyA75iBKoj6oYLyXgwAkKHHqf/
         uhPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDPzLhOMygsS+TmYt3MsVSVXfeC/HF6zHapVAszIYxIPf705G8TVCp2GP9ERkQKHAf8C7Wxy0MA9pghZE=@vger.kernel.org, AJvYcCVcL76hDwMnjTNTNx+DePsPmIl9Wilrvh+GYxDQ+QuMzQPV0rer6cVxnZJzultBhrsdT+y+5yQM@vger.kernel.org
X-Gm-Message-State: AOJu0YzWPR+YeTFOPqYbQB1ZDw4TLNwojO0JNtIwXCkQqthnblSARB9x
	Awk+fA/8AEKX7q5KnskyJ7XPGs5czfgV0QeyCwLBpA4hvC7LOL2l4xZs4a6f
X-Gm-Gg: ASbGncuVSGbHURaNS1yFK8WKKEJ2Uew48ofRQ0JWTU1eF0ozbeWJqrUzSh35/HBeU76
	1t3btmOmxzs4Y44OdF+NUfYM8etDLgubzi++Zn26UZX4qIQCZuuBvw7VF18BTKDtImetokRtG8q
	BA6NAScuBk46Pv9ydWKRtlJ1UNohppE6fmgxF17MvhIwoeFNJJ284zuKiJl3Vdw6zlWRqmtPS3e
	2alYwHYyADTT4owP+6JhZ9GSE2SdqzCjBcFQKXPAEokesNAxw+jEioIA/2hYV78EtxySUDHFLqq
	ivPoVRTPXMBUBiOqNQZpsP7kwEZYhVODgLyI3LdwhAG9HDBs30DO/SJGQjkjjOT5x6QsRA3L7Wu
	yPw==
X-Google-Smtp-Source: AGHT+IGixscxCkTYfDVvi1DbrSr0AdhyZkhqAfzSfKOrjBwSF3czxPS6d+7fx+I4sGD3g6Dt7F5uzQ==
X-Received: by 2002:a17:906:c111:b0:ac3:8feb:26d2 with SMTP id a640c23a62f3a-ac3f20b9bedmr49710566b.2.1742499017006;
        Thu, 20 Mar 2025 12:30:17 -0700 (PDT)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efd24f6esm24958966b.154.2025.03.20.12.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 12:30:16 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 4C8A5BE2DE0; Thu, 20 Mar 2025 20:30:15 +0100 (CET)
Date: Thu, 20 Mar 2025 20:30:15 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Vasiliy Kovalev <kovalev@altlinux.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-patches@linuxtesting.org, dutyrok@altlinux.org,
	gerben@altlinux.org,
	syzbot+5f3a973ed3dfb85a6683@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] hfs/hfsplus: fix slab-out-of-bounds in hfs_bnode_read_key
Message-ID: <Z9xsx-w4YCBuYjx5@eldamar.lan>
References: <20241019191303.24048-1-kovalev@altlinux.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241019191303.24048-1-kovalev@altlinux.org>

Hi

On Sat, Oct 19, 2024 at 10:13:03PM +0300, Vasiliy Kovalev wrote:
> Syzbot reported an issue in hfs subsystem:
> 
> BUG: KASAN: slab-out-of-bounds in memcpy_from_page include/linux/highmem.h:423 [inline]
> BUG: KASAN: slab-out-of-bounds in hfs_bnode_read fs/hfs/bnode.c:35 [inline]
> BUG: KASAN: slab-out-of-bounds in hfs_bnode_read_key+0x314/0x450 fs/hfs/bnode.c:70
> Write of size 94 at addr ffff8880123cd100 by task syz-executor237/5102
> 
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:377 [inline]
>  print_report+0x169/0x550 mm/kasan/report.c:488
>  kasan_report+0x143/0x180 mm/kasan/report.c:601
>  kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
>  __asan_memcpy+0x40/0x70 mm/kasan/shadow.c:106
>  memcpy_from_page include/linux/highmem.h:423 [inline]
>  hfs_bnode_read fs/hfs/bnode.c:35 [inline]
>  hfs_bnode_read_key+0x314/0x450 fs/hfs/bnode.c:70
>  hfs_brec_insert+0x7f3/0xbd0 fs/hfs/brec.c:159
>  hfs_cat_create+0x41d/0xa50 fs/hfs/catalog.c:118
>  hfs_mkdir+0x6c/0xe0 fs/hfs/dir.c:232
>  vfs_mkdir+0x2f9/0x4f0 fs/namei.c:4257
>  do_mkdirat+0x264/0x3a0 fs/namei.c:4280
>  __do_sys_mkdir fs/namei.c:4300 [inline]
>  __se_sys_mkdir fs/namei.c:4298 [inline]
>  __x64_sys_mkdir+0x6c/0x80 fs/namei.c:4298
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fbdd6057a99
> 
> Add a check for key length in hfs_bnode_read_key to prevent
> out-of-bounds memory access. If the key length is invalid, the
> key buffer is cleared, improving stability and reliability.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+5f3a973ed3dfb85a6683@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=5f3a973ed3dfb85a6683
> Cc: stable@vger.kernel.org
> Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
> ---
>  fs/hfs/bnode.c     | 6 ++++++
>  fs/hfsplus/bnode.c | 6 ++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
> index 6add6ebfef8967..cb823a8a6ba960 100644
> --- a/fs/hfs/bnode.c
> +++ b/fs/hfs/bnode.c
> @@ -67,6 +67,12 @@ void hfs_bnode_read_key(struct hfs_bnode *node, void *key, int off)
>  	else
>  		key_len = tree->max_key_len + 1;
>  
> +	if (key_len > sizeof(hfs_btree_key) || key_len < 1) {
> +		memset(key, 0, sizeof(hfs_btree_key));
> +		pr_err("hfs: Invalid key length: %d\n", key_len);
> +		return;
> +	}
> +
>  	hfs_bnode_read(node, key, off, key_len);
>  }
>  
> diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
> index 87974d5e679156..079ea80534f7de 100644
> --- a/fs/hfsplus/bnode.c
> +++ b/fs/hfsplus/bnode.c
> @@ -67,6 +67,12 @@ void hfs_bnode_read_key(struct hfs_bnode *node, void *key, int off)
>  	else
>  		key_len = tree->max_key_len + 2;
>  
> +	if (key_len > sizeof(hfsplus_btree_key) || key_len < 1) {
> +		memset(key, 0, sizeof(hfsplus_btree_key));
> +		pr_err("hfsplus: Invalid key length: %d\n", key_len);
> +		return;
> +	}
> +
>  	hfs_bnode_read(node, key, off, key_len);
>  }
>  
> -- 
> 2.33.8

I do realize that the HFS filesystem is "Orphan". But in the light of
the disclosure in
https://ssd-disclosure.com/ssd-advisory-linux-kernel-hfsplus-slab-out-of-bounds-write/
is there still something which needs to be done here?

Does the above needs to be picked in mainline and then propagated to
the supported stable versions?

Regards,
Salvatore

