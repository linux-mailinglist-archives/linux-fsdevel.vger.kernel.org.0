Return-Path: <linux-fsdevel+bounces-2980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B147EE810
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 21:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BFF328106A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 20:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B8C328A2;
	Thu, 16 Nov 2023 20:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ULLBsbmj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706E81A7
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Nov 2023 12:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700165050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+4XQ4i8Y5DNwJiAj9ly/ReOTlxs9KYLdEh1NBejN2C4=;
	b=ULLBsbmjFpAKMFDy1pMo30YfvOIAHW7SFTM+xEGk+YUDy8qhjbOpjyGmTBUlErICP2TxHD
	QPazj7hRecNE1see8k1TP6+n+LOyhfQRSXF/N2YBlg6A7tqe8FigD9BdsxdipWDpzuoaYw
	VzGZ5dEOmyshE4KqEM78lRHx4kJDcIs=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-VT-Vt-3INyqxZjl4VSFwJA-1; Thu, 16 Nov 2023 15:04:08 -0500
X-MC-Unique: VT-Vt-3INyqxZjl4VSFwJA-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1ef39189888so290145fac.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Nov 2023 12:04:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700165048; x=1700769848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4XQ4i8Y5DNwJiAj9ly/ReOTlxs9KYLdEh1NBejN2C4=;
        b=wQ/wQx9jYhqiz0IrzdGM2Ybmddtg/4k3Wnsj6eztcBMv/+WQQPgGGBgb1K+uErUNg3
         Si0Ps9vf88gaPkI6zJjqcNUQd1NmcdOr26Cf5Gusc3GLwrAWCJOtkBuYJ/cEw1FTGDMj
         VXfAUyCx6mST2PxDp/DczsuZ6rP9Ft21eOUcspeEtHF5oOJcSwxFbKQUSUtBMEwFR+5E
         ehDsYICUf5xefZAhwQLbTD2HhdeEwjzX6+WICLPGyMLa4WfY4MqpNhSg5Uwe5gCwA0Y8
         myB/kEZdDNigrrmHSxG0MbYMptlYV1U0fiwty69Wd4bL9h+73xmzrTjYlbNxCvSoqjtO
         yfLg==
X-Gm-Message-State: AOJu0YxcDoQEV+UD2qH+lwZ36Ys2AMgNC/zlsrtszl0KziJOH47hERd6
	3xi8IkTAwUwLR1C7y5CLVJDRSOquW5+HRojs5TQ9oVWweaBXArV56JzzOVRJhOhqt+SnvK8yj2x
	Koy0sEVme6IFjgy0KZOOq6nhRuw==
X-Received: by 2002:a05:6870:2301:b0:1ea:7463:1b8f with SMTP id w1-20020a056870230100b001ea74631b8fmr10381848oao.0.1700165048056;
        Thu, 16 Nov 2023 12:04:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDPS7+wKj9qqDek4+rigv0rYOE1IH7oReMKMjyyoPNCSs/XVBtexRivZXLqhWKUZiqpeXWhA==
X-Received: by 2002:a05:6870:2301:b0:1ea:7463:1b8f with SMTP id w1-20020a056870230100b001ea74631b8fmr10381812oao.0.1700165047537;
        Thu, 16 Nov 2023 12:04:07 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id j17-20020ac86651000000b0041b3deef647sm33619qtp.8.2023.11.16.12.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 12:04:06 -0800 (PST)
Date: Thu, 16 Nov 2023 15:04:04 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	syzbot <syzbot+7ca4b2719dc742b8d0a4@syzkaller.appspotmail.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
	wangkefeng.wang@huawei.com
Subject: Re: [syzbot] [mm?] WARNING in unmap_page_range (2)
Message-ID: <ZVZ1tLoOpRJu5n3g@x1n>
References: <000000000000b0e576060a30ee3b@google.com>
 <20231115140006.cc7de06f89b1f885f4583af0@linux-foundation.org>
 <a8349273-c512-4d23-bf85-5812d2a007d1@redhat.com>
 <ZVZYvleasZddv-TD@x1n>
 <6308590a-d958-4ecc-a478-ba088cf7984d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6308590a-d958-4ecc-a478-ba088cf7984d@redhat.com>

On Thu, Nov 16, 2023 at 07:13:44PM +0100, David Hildenbrand wrote:
> > It should be fine, as:
> > 
> > static void make_uffd_wp_pte(struct vm_area_struct *vma,
> > 			     unsigned long addr, pte_t *pte)
> > {
> > 	pte_t ptent = ptep_get(pte);
> > 
> > #ifndef CONFIG_USERFAULTFD_
> > 
> > 	if (pte_present(ptent)) {
> > 		pte_t old_pte;
> > 
> > 		old_pte = ptep_modify_prot_start(vma, addr, pte);
> > 		ptent = pte_mkuffd_wp(ptent);
> > 		ptep_modify_prot_commit(vma, addr, pte, old_pte, ptent);
> > 	} else if (is_swap_pte(ptent)) {
> > 		ptent = pte_swp_mkuffd_wp(ptent);
> > 		set_pte_at(vma->vm_mm, addr, pte, ptent);
> > 	} else {                                      <----------------- this must be pte_none() already
> > 		set_pte_at(vma->vm_mm, addr, pte,
> > 			   make_pte_marker(PTE_MARKER_UFFD_WP));
> > 	}
> > }
> 
> Indeed! Is pte_swp_mkuffd_wp() reasonable for pte markers? I rememebr that
> we don't support multiple markers yet, so it might be good enough.

Not really that reasonable, but nothing harmful either that I see so far;
the current code handles any pte marker without caring any of those hint
bits.

I can also reproduce this syzbot error easily with !UFFD config on x86.
Let me send the patchset to fix current known issues first.

Thanks,

-- 
Peter Xu


