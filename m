Return-Path: <linux-fsdevel+bounces-22695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED79F91B270
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 01:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CAE1B240E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 23:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BA61A2FB7;
	Thu, 27 Jun 2024 23:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bImEv+/c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450981CA9F;
	Thu, 27 Jun 2024 23:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719529244; cv=none; b=UwcEw4QSrzy5MJBfieGR4pmKVqiLB2g/LOoLcf5hKtc1LqYW5OeOTD2nYZUOSNwWCyEfyTRsb4hEIUl+8Ye11Uky64D4PQrfAZsqvDr279Us11TyJoLZxxTa8HpkKENONqqfcg8cjd6/4+v+H8tWcxSvhTRtaulFUVMHm38j+xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719529244; c=relaxed/simple;
	bh=bgGQ/d7DqnsysiddreU9LWxiDKypE1sKJ6+96W8e904=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lFEnn7MW5q+Erzwm4gkGa77cCSJ86bzcFYgGcE2ragSiCOwdWi/soSf8A1B6Wz+xKyrcoJQ8oCFej9a2w+L+VdlRSNBv+UIm5ztozrRbzHa82gExps60pw9H4B2j/z/RZVdbeK91INXWjCI4F2/Oxywi5m7yi6vFNFuoLlF2fjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bImEv+/c; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719529243; x=1751065243;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=bgGQ/d7DqnsysiddreU9LWxiDKypE1sKJ6+96W8e904=;
  b=bImEv+/cHOLnVjJ3TndB5cXOHA6K1QTNmSOi0rPdOBzPqsID2CrUKzuh
   6dV/hXK0ztWVexWg7Sp4WCPR3AITmTcmgzr7NcdvLw48G6DTxmBPVCxA4
   TkkYvBKoiLvyBrzfapPwiL18uJM5HVVKpVL5fny0SL3mDMtN6+m+DDQ99
   oaHk/iFya+TJmzx2PpDY697unXzIiIjQlv/AkAO9JJnNH96ZLTuBShxtP
   i7H+UH8IVOslBIf2QPtsvT6X6jy5fNV92ZxEamt2wD7UtTSKOCZIhY3Bo
   FkRQBz3TnCRm1/Zay7fYnewPWeoOTGORAz8GjkWy+JU0TqIsYcfpTaE96
   w==;
X-CSE-ConnectionGUID: nhNrh44ERW+UCxia+dN5Pw==
X-CSE-MsgGUID: /w0jho9RSpefd9OnDVuoQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="16652791"
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="16652791"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 16:00:42 -0700
X-CSE-ConnectionGUID: a32kIUurQHCzq+VY0Rxsqw==
X-CSE-MsgGUID: IL3M8t2ZTxuiKTxjvYN2zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="45290914"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.54.38.190])
  by orviesa008.jf.intel.com with ESMTP; 27 Jun 2024 16:00:43 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
	id 7A82C302A3B; Thu, 27 Jun 2024 16:00:41 -0700 (PDT)
From: Andi Kleen <ak@linux.intel.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,  brauner@kernel.org,
  viro@zeniv.linux.org.uk,  akpm@linux-foundation.org,
  linux-kernel@vger.kernel.org,  bpf@vger.kernel.org,
  gregkh@linuxfoundation.org,  linux-mm@kvack.org,
  liam.howlett@oracle.com,  surenb@google.com,  rppt@kernel.org,
  adobriyan@gmail.com
Subject: Re: [PATCH v6 3/6] fs/procfs: add build ID fetching to
 PROCMAP_QUERY API
In-Reply-To: <20240627170900.1672542-4-andrii@kernel.org> (Andrii Nakryiko's
	message of "Thu, 27 Jun 2024 10:08:55 -0700")
References: <20240627170900.1672542-1-andrii@kernel.org>
	<20240627170900.1672542-4-andrii@kernel.org>
Date: Thu, 27 Jun 2024 16:00:41 -0700
Message-ID: <878qyqyorq.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andrii Nakryiko <andrii@kernel.org> writes:

> The need to get ELF build ID reliably is an important aspect when
> dealing with profiling and stack trace symbolization, and
> /proc/<pid>/maps textual representation doesn't help with this.
>
> To get backing file's ELF build ID, application has to first resolve
> VMA, then use it's start/end address range to follow a special
> /proc/<pid>/map_files/<start>-<end> symlink to open the ELF file (this
> is necessary because backing file might have been removed from the disk
> or was already replaced with another binary in the same file path.
>
> Such approach, beyond just adding complexity of having to do a bunch of
> extra work, has extra security implications. Because application opens
> underlying ELF file and needs read access to its entire contents (as far
> as kernel is concerned), kernel puts additional capable() checks on
> following /proc/<pid>/map_files/<start>-<end> symlink. And that makes
> sense in general.

I was curious about this statement. It has still certainly potential
for side channels e.g. for files that are execute only, or with
some other special protection.

But actually just looking at the parsing code it seems to fail basic
TOCTTOU rules, and since you don't check if the VMA mapping is executable
(I think), so there's no EBUSY checking for writes, it likely is exploitable.


        /* only supports phdr that fits in one page */
                if (ehdr->e_phnum >
                   (PAGE_SIZE - sizeof(Elf64_Ehdr)) / sizeof(Elf64_Phdr))
                <---------- check in memory
                                return -EINVAL;

        phdr = (Elf64_Phdr *)(page_addr + sizeof(Elf64_Ehdr));

<---- but page is shared in the page cache. So if anybody manages to map
it for write 


        for (i = 0; i < ehdr->e_phnum; ++i) {   <----- this loop can go
                        off into the next page.
                        if (phdr[i].p_type == PT_NOTE &&
                                            !parse_build_id(page_addr, build_id, size,
                                                            page_addr + phdr[i].p_offset,
                                                            phdr[i].p_filesz))
                                                                                    return 0;

Here's an untested patch


diff --git a/lib/buildid.c b/lib/buildid.c
index 7954dd92e36c..6c022fcd03ec 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -72,19 +72,20 @@ static int get_build_id_32(const void *page_addr, unsigned char *build_id,
 	Elf32_Ehdr *ehdr = (Elf32_Ehdr *)page_addr;
 	Elf32_Phdr *phdr;
 	int i;
+	unsigned phnum = READ_ONCE(ehdr->e_phnum);
 
 	/* only supports phdr that fits in one page */
-	if (ehdr->e_phnum >
+	if (phnum >
 	    (PAGE_SIZE - sizeof(Elf32_Ehdr)) / sizeof(Elf32_Phdr))
 		return -EINVAL;
 
 	phdr = (Elf32_Phdr *)(page_addr + sizeof(Elf32_Ehdr));
 
-	for (i = 0; i < ehdr->e_phnum; ++i) {
+	for (i = 0; i < phnum; ++i) {
 		if (phdr[i].p_type == PT_NOTE &&
 		    !parse_build_id(page_addr, build_id, size,
 				    page_addr + phdr[i].p_offset,
-				    phdr[i].p_filesz))
+				    READ_ONCE(phdr[i].p_filesz)))
 			return 0;
 	}
 	return -EINVAL;
@@ -97,15 +98,16 @@ static int get_build_id_64(const void *page_addr, unsigned char *build_id,
 	Elf64_Ehdr *ehdr = (Elf64_Ehdr *)page_addr;
 	Elf64_Phdr *phdr;
 	int i;
+	unsigned phnum = READ_ONCE(ehdr->e_phnum);
 
 	/* only supports phdr that fits in one page */
-	if (ehdr->e_phnum >
+	if (phnum >
 	    (PAGE_SIZE - sizeof(Elf64_Ehdr)) / sizeof(Elf64_Phdr))
 		return -EINVAL;
 
 	phdr = (Elf64_Phdr *)(page_addr + sizeof(Elf64_Ehdr));
 
-	for (i = 0; i < ehdr->e_phnum; ++i) {
+	for (i = 0; i < phnum; ++i) {
 		if (phdr[i].p_type == PT_NOTE &&
 		    !parse_build_id(page_addr, build_id, size,
 				    page_addr + phdr[i].p_offset,

