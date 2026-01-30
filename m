Return-Path: <linux-fsdevel+bounces-75963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENk0I8cXfWkGQQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 21:42:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC74BE7B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 21:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8067930090A5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 20:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B9230B536;
	Fri, 30 Jan 2026 20:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Eq0Qcprm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3596E34EF0E;
	Fri, 30 Jan 2026 20:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769805764; cv=none; b=ID2zN1jX06QPD/YDml8z61lNc+LpEKCOk8ieFOPz633F8PI2K9IIfLcSZnHF0lm83NcFkfpbaNMCgoFHFgTES/VHUPrFFHRLKxUBLH32sifbd0ZS99Ndlca0nFmWay74WYvVTe45QAdrjKKrNoBAFHR9QAOsRTb6DrmwJ0TkAgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769805764; c=relaxed/simple;
	bh=5acVyiSSuCssIejlmfrh3fKAQZQppVE8lkLKa/y831c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FQU3W4JBtc8HEFJyXqNwZCrU3A02cl9+gwBRUacqnn+frxatyBuGpSK7kGvxHN00aTra3hLVdlPdh1GnyhVSu1gn5afzkhGbktdnnKBBm3TVE8PAh+csLIhB59PxnE+CM9ILjoisfTWdCf4dlGmmJnS76SwWyexmw2vycVa6NGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Eq0Qcprm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B72C19425;
	Fri, 30 Jan 2026 20:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1769805763;
	bh=5acVyiSSuCssIejlmfrh3fKAQZQppVE8lkLKa/y831c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Eq0Qcprms6/VkX+1256ZermHOg9SVd9qJhZc/I2iSMGx1+gw4cDc1F1K5Yosp7q/H
	 3m0Myxl9bT91huvQKHOGjXcEtB6kFJsn9/9j1XulQEgeE4iTWFtr3rpIkSD5TqVZvO
	 u8rU/YevMArmLiQrUcLmlqxZflJ8N289o4xipYK4=
Date: Fri, 30 Jan 2026 12:42:42 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: kernel test robot <lkp@intel.com>, Andrii Nakryiko <andrii@kernel.org>,
 linux-mm@kvack.org, oe-kbuild-all@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, surenb@google.com,
 shakeel.butt@linux.dev,
 syzbot+4e70c8e0a2017b432f7a@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 mm-stable] procfs: avoid fetching build ID while
 holding VMA lock
Message-Id: <20260130124242.dbb7946b3592ffddac7c316a@linux-foundation.org>
In-Reply-To: <CAEf4BzZthAONGByqvk3pHRT3GaA8=fNbz+d1V1CY1N8sHEcsjA@mail.gmail.com>
References: <20260129215340.3742283-1-andrii@kernel.org>
	<202601301121.zr5U6ixA-lkp@intel.com>
	<CAEf4BzZthAONGByqvk3pHRT3GaA8=fNbz+d1V1CY1N8sHEcsjA@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75963-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,4e70c8e0a2017b432f7a];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 2CC74BE7B0
X-Rspamd-Action: no action

On Fri, 30 Jan 2026 12:11:31 -0800 Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202601301121.zr5U6ixA-lkp@intel.com/
> >
> > All warnings (new ones prefixed by >>):
> >
> > >> Warning: lib/buildid.c:348 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
> >     * Parse build ID of ELF file
> 
> So AI tells me to be a proper kernel-doc comment this should have been:
> 
> * build_id_parse_file() - Parse build ID of ELF file
> 
> Andrew, should I send v3 or you can just patch it up in-place? Thanks!

No probs.

The preceding two functions are trying to be kerneldoc but failed.  How
about this?


--- a/lib/buildid.c~procfs-avoid-fetching-build-id-while-holding-vma-lock-fix
+++ a/lib/buildid.c
@@ -315,8 +315,8 @@ out:
 	return ret;
 }
 
-/*
- * Parse build ID of ELF file mapped to vma
+/**
+ * build_id_parse_nofault() - Parse build ID of ELF file mapped to vma
  * @vma:      vma object
  * @build_id: buffer to store build id, at least BUILD_ID_SIZE long
  * @size:     returns actual build id size in case of success
@@ -334,8 +334,8 @@ int build_id_parse_nofault(struct vm_are
 	return __build_id_parse(vma->vm_file, build_id, size, false /* !may_fault */);
 }
 
-/*
- * Parse build ID of ELF file mapped to VMA
+/**
+ * build_id_parse() - Parse build ID of ELF file mapped to VMA
  * @vma:      vma object
  * @build_id: buffer to store build id, at least BUILD_ID_SIZE long
  * @size:     returns actual build id size in case of success
@@ -354,7 +354,7 @@ int build_id_parse(struct vm_area_struct
 }
 
 /**
- * Parse build ID of ELF file
+ * build_id_parse_file() - Parse build ID of ELF file
  * @file:      file object
  * @build_id: buffer to store build id, at least BUILD_ID_SIZE long
  * @size:     returns actual build id size in case of success
_


