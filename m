Return-Path: <linux-fsdevel+bounces-16821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4598A3453
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 19:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A7781F22987
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 17:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A2D14D2BD;
	Fri, 12 Apr 2024 17:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="PIA/i4s+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C16148FE0
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 17:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712941536; cv=none; b=MPt7LpB0USOwk803166x334yYd25ksBgjMJ4vMLydP9HKrynJnNfhlG5qhyKG4qmiclxpO36zUVDZU2A5yYpi0Xl7ojOWPLAhQN48BRsfmSnPs6TnNkYMHfzn7ZhkTw8oHe5qZ9kIgGZ0vfv589MxFNFYQqHmzbRPoAdSenCp0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712941536; c=relaxed/simple;
	bh=+su7OSUJsFls4CIQXxEZl65t0clagHiB1QsWAMbAmDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dK5bywlA9EF1cus3pqnJlgwtbw8wcOkOrDeHIi9R4QoOIbPgDu8FsfUM4gXTsR/25p+Pq6miI24FJor5ZjVu4sSFqhwG9D6ILk/CKjpiZUXFHbmo1ZDkS1JRKSQmO/C0XBE/FtxLMZCdzw5hKdsctuj4XN+ZYbtCE9iCvMbvT3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=PIA/i4s+; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2228c4c5ac3so650478fac.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 10:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1712941534; x=1713546334; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/EuVGwHTxmbtDwTp4fNMFd9ojHayxYpTNJMubGDO+yg=;
        b=PIA/i4s+83uQbaOaXto2oSszm8r4MTN8R47nuVJ5DKe7kQipQJoPAEJLySGKEaduoi
         fBhzWW8686wJPotlI9vTyuNTFVQ1/NgKD4YGRbAwmGPCE+EW6hcRFU6vD48QyFN0oiUL
         jrcLnNsM9nFzlKMCcrZxq0Prpz6jiiVreEg88ZC+Dk9IyK6in6rraBhlALD1hLnfPbj3
         KyGuJBg3D5Y/7hLw1+Lo3fyfpQLwtYJ4c9QxFHdczXGO7nHr8k7m/4N1xKArcoGF+/oG
         jeLKP3Gh7zn1JEtCgwVWkdYSNXUIayQvSZXgWtYEFlLNy0JbIHimXFCGGHd6DNop9T2f
         0a2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712941534; x=1713546334;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/EuVGwHTxmbtDwTp4fNMFd9ojHayxYpTNJMubGDO+yg=;
        b=NbhQXzRGKaLh59Yzlh8KSeZnhP96iiR7A8cSc0vEFEgn+fhXC6WsvXzSgduwQY/Bo2
         99sg9l/Lk6QDZGACm58fIi8t4bwTwkhAMT5iPXYCVeMuSwnjZIBA2Hletn9afQo+xbfe
         jjhUTRLSU8D4i3zFqTu7o9AV6cnzscpAv33Q17GvZlOK+SpRs0CcNyfFprRB1w0tvucm
         6dJHu0z4qMMH7Nlwnku3T786syC2R5r3sUSom8hyY9u1G5V2KWWiri3VpJkJJmRy71mY
         UTJyfOte5WSa+jObY/F4nNv9GVzxTHrpLKjGaPpLFxeqppI/3TJ9uNV+iH0VTS9V6LP4
         U4pA==
X-Forwarded-Encrypted: i=1; AJvYcCXWdW73iE5NYl7M2CCCD3WwlZgCNZCy19EI0Wkz6rZQ4VKmxGPO5RYl3L4TOayr57i5Z4ng4j10e9F3fn3nnuyJumXEVM3DXVUw7TDNIw==
X-Gm-Message-State: AOJu0YzlggVcN4PuQ5FBHlcszEwyzKAPfFVHSDxRMBs62MER/XN0Bfth
	5oDmg/wwtu8bgd3HaV59MMt3BgDT9BaOvcQMfrYyGjhYnfTpXNWz7FhmBq2d3GlokpTm3u3GlH+
	7UH+4mtffD1z7A6qkSL1EmB2a6PwWC6yFvgGxDw==
X-Google-Smtp-Source: AGHT+IFFWNWDQpb4IdXMSld7uI+GGFrLl02QQNkjBBmvPtfyGISuhykwiEhQTc4Uews9+sCsYC//GV0j7fEO9UlX82A=
X-Received: by 2002:a05:6870:1650:b0:22e:ed14:3e3d with SMTP id
 c16-20020a056870165000b0022eed143e3dmr3334118oae.33.1712941534211; Fri, 12
 Apr 2024 10:05:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220214558.3377482-1-souravpanda@google.com>
 <20240220214558.3377482-2-souravpanda@google.com> <20240319143320.d1b1ef7f6fa77b748579ba59@linux-foundation.org>
In-Reply-To: <20240319143320.d1b1ef7f6fa77b748579ba59@linux-foundation.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 12 Apr 2024 13:04:57 -0400
Message-ID: <CA+CK2bDMNkCq6ts1BLAgJbAcUiq-106GCZZr_=cU0hW+jDYeiw@mail.gmail.com>
Subject: Re: [PATCH v9 1/1] mm: report per-page metadata information
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sourav Panda <souravpanda@google.com>, corbet@lwn.net, gregkh@linuxfoundation.org, 
	rafael@kernel.org, mike.kravetz@oracle.com, muchun.song@linux.dev, 
	rppt@kernel.org, david@redhat.com, rdunlap@infradead.org, 
	chenlinxuan@uniontech.com, yang.yang29@zte.com.cn, tomas.mudrunka@gmail.com, 
	bhelgaas@google.com, ivan@cloudflare.com, yosryahmed@google.com, 
	hannes@cmpxchg.org, shakeelb@google.com, kirill.shutemov@linux.intel.com, 
	wangkefeng.wang@huawei.com, adobriyan@gmail.com, vbabka@suse.cz, 
	Liam.Howlett@oracle.com, surenb@google.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	willy@infradead.org, weixugc@google.com
Content-Type: text/plain; charset="UTF-8"

> >  Documentation/filesystems/proc.rst |  3 +++
> >  fs/proc/meminfo.c                  |  4 ++++
> >  include/linux/mmzone.h             |  4 ++++
> >  include/linux/vmstat.h             |  4 ++++
> >  mm/hugetlb_vmemmap.c               | 17 ++++++++++++----
> >  mm/mm_init.c                       |  3 +++
> >  mm/page_alloc.c                    |  1 +
> >  mm/page_ext.c                      | 32 +++++++++++++++++++++---------
> >  mm/sparse-vmemmap.c                |  8 ++++++++
> >  mm/sparse.c                        |  7 ++++++-
> >  mm/vmstat.c                        | 26 +++++++++++++++++++++++-
> >  11 files changed, 94 insertions(+), 15 deletions(-)
>
> And yet we offer the users basically no documentation.  The new sysfs
> file should be documented under Documentation/ABI somewhere and

There are no new sysfs files in this change. The new Memmap field in
/proc/meminfo is documented.

> perhaps we could prepare some more expansive user-facing documentation
> elsewhere?
>
> I'd like to hear others' views on the overall usefulness/utility of this
> change, please?

Sourav, could you please consolidate the cover letter and the patch
into one email, sync it with the upstream kernel, and send the new
version putting the necessary background information into the stat
area in the patch.

Thanks,
Pasha

