Return-Path: <linux-fsdevel+bounces-36505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9826B9E4B02
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 01:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66D0A161F7E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 00:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD1763CB;
	Thu,  5 Dec 2024 00:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FrRFyyx0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECCB391;
	Thu,  5 Dec 2024 00:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733357905; cv=none; b=kq4sT4eRbJOCHm06XSmxX/MEBYipIU2s4QpFXaUBkPpnkVSwTP2KJJb3su23eLMKydULyTgTPZF/MXWLFEpx+m4PsE++pNIS/nwaIi0aYE3Te6F8pDuZEy99yQOYACwAYc1Aj5OWqD62gj/pYm+Qn+7y7zrFmVmosFVgIGk0ZPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733357905; c=relaxed/simple;
	bh=/U8qXy1M4Q4S9yJGPJ32y/rKMzq/gUFbI6KKXJEp9f4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFpRDPEiUnV9Hr4RndWGh5SeGB9EmsQiwDYu16Sd5hURKh92osz5ns/kJ43Outj7luWhHrJE3BZcRpY83tdNKA8e7s6XO9sejGaj0zVkUjB/dYZRm3DuR9uJ54jVjbYDXTRIcZXN/MWHwbekC0p3t0lzs1dafdMCKOn6TKjpdLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FrRFyyx0; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d0cd67766aso305262a12.2;
        Wed, 04 Dec 2024 16:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733357902; x=1733962702; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UTarhtG6QhsBczFzHEEIraRnC7fwbRetkRpuFiI3llM=;
        b=FrRFyyx0DnRJumDEBfuJz4sHK27Qj7Bezw2pmRm1pxmFFEod9h1ZbNy4jR9erf9ois
         QUJRLn6PWBbLmWqrVe4sf0ttSKltHNFkbPekuR/0iae1Xq7y7+6dG1Yc/GCSAnyMhRe7
         YLWFBCa32NaRS6WinLpBRfZSaTTBhbmaM5M2K0dGfGhO9yn4iZuc6ZeMyszpfdM8DgyA
         INbR5ap9AZVFCIMFhme7ui/Kh1a42sVSHKEyRKnFMtJ7dShZTCePRibDDNquWwIWBm3v
         Tf4//6DlmCiQlI/c1lMlh5aqlViEioWFoBkrFyHMKnvSAxzjD4Zh6CLpJ2329YeuLUxN
         150g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733357902; x=1733962702;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UTarhtG6QhsBczFzHEEIraRnC7fwbRetkRpuFiI3llM=;
        b=f5Ic4HIc+n9U+S944PpEIg89iFXpq5I+i6daFSlr68MF2FBaHQeo9wc+YIewlpArfp
         NuAC5ZIyA4o2GugDK9ju3++6lee8HbAZZ8d01lYeL3RXtAlNHspxO8h1+9+E3iyhheMq
         nLVTFflehyoRgxLTcaOuZMuP+ntcmkR5QVDHwZG0RaIT3dHFBYoOg8ThpqCmL1emPCBB
         UTYmayOVfJTwCwza4fPykBPYoimsSeCkEZ4hmLXEboQjByHE/AVdDY/67pWJvoax6S0N
         RyEyB6Yj3NSLSea+q9uCe0CBiO9okmaY/wOaHL+NkLIM/cmT1oEF3DLEKMm4nRW2fAkw
         /k3A==
X-Forwarded-Encrypted: i=1; AJvYcCV9b9+1Nx1e4oV14FhLV/diAjiOHMfqfYm4o73DpdFYauGj3+xKCwY1TsYucxBY22y4aCOXag9bO6ut4//p@vger.kernel.org, AJvYcCVcQLSd6aUP4mx5rWN9rsD/kkeVn8z5ulQ8mVbGtm6uKmym2H1Ipfl5hBhTWFyRgyXvXeeTJmoJ7wlfl7fI@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn+oXmJAzBmI9AnllHASIlXZu9Vq+EDGT/CRODb+CArx6KhfJh
	H3eOGbriijuYwQNhUMvuDHYCVxTIVry5rl/UuI3EmQiTWxBtyWC1
X-Gm-Gg: ASbGncsdHshiiia4jgP8oODBI+QxD/iP/Jf7nY449js285enfHdiNWLfss35fRikjij
	u5kOn2U6ahWMl//y14Ht35afDRn30dFeiFXL4DGlsHXrVpCOGushCI5vmtjYOogOrfh1dbau5EH
	TqIEE6Zz7ZieY0/co3Urt5Yw903aVtY9HIaTc0iEdxXAkISP6rouGOdeiunhoqZBJ+lbrT8dNB/
	ZN04N3EjMkpz/5q+2sJ5rpfbVKzfT2KNU73RR4zjHeIR85ihA==
X-Google-Smtp-Source: AGHT+IGOxY0n5S9c6n6c0AB0cBoetyxBwtV/KCtKq2kw2LsDGbLYSOjIytcCwsKgi4Po9m/7Ngarhw==
X-Received: by 2002:a05:6402:510e:b0:5d0:8606:9ba1 with SMTP id 4fb4d7f45d1cf-5d10cb82718mr7579671a12.24.1733357901839;
        Wed, 04 Dec 2024 16:18:21 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d14b608c8dsm118497a12.48.2024.12.04.16.18.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Dec 2024 16:18:20 -0800 (PST)
Date: Thu, 5 Dec 2024 00:18:19 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] mm: abstract get_arg_page() stack expansion and mmap
 read lock
Message-ID: <20241205001819.derfguaft7oummr6@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <cover.1733248985.git.lorenzo.stoakes@oracle.com>
 <5295d1c70c58e6aa63d14be68d4e1de9fa1c8e6d.1733248985.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5295d1c70c58e6aa63d14be68d4e1de9fa1c8e6d.1733248985.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, Dec 03, 2024 at 06:05:10PM +0000, Lorenzo Stoakes wrote:
>Right now fs/exec.c invokes expand_downwards(), an otherwise internal
>implementation detail of the VMA logic in order to ensure that an arg page
>can be obtained by get_user_pages_remote().
>
>In order to be able to move the stack expansion logic into mm/vma.c in
>order to make it available to userland testing we need to find an

Looks the second "in order" is not necessary.

Not a native speaker, just my personal feeling.

>alternative approach here.
>
>We do so by providing the mmap_read_lock_maybe_expand() function which also
>helpfully documents what get_arg_page() is doing here and adds an
>additional check against VM_GROWSDOWN to make explicit that the stack
>expansion logic is only invoked when the VMA is indeed a downward-growing
>stack.
>
>This allows expand_downwards() to become a static function.
>
>Importantly, the VMA referenced by mmap_read_maybe_expand() must NOT be
>currently user-visible in any way, that is place within an rmap or VMA
>tree. It must be a newly allocated VMA.
>
>This is the case when exec invokes this function.
>
>Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>---
> fs/exec.c          | 14 +++---------
> include/linux/mm.h |  5 ++---
> mm/mmap.c          | 54 +++++++++++++++++++++++++++++++++++++++++++++-
> 3 files changed, 58 insertions(+), 15 deletions(-)
>
>diff --git a/fs/exec.c b/fs/exec.c
>index 98cb7ba9983c..1e1f79c514de 100644
>--- a/fs/exec.c
>+++ b/fs/exec.c
>@@ -205,18 +205,10 @@ static struct page *get_arg_page(struct linux_binprm *bprm, unsigned long pos,
> 	/*
> 	 * Avoid relying on expanding the stack down in GUP (which
> 	 * does not work for STACK_GROWSUP anyway), and just do it
>-	 * by hand ahead of time.
>+	 * ahead of time.
> 	 */
>-	if (write && pos < vma->vm_start) {
>-		mmap_write_lock(mm);
>-		ret = expand_downwards(vma, pos);
>-		if (unlikely(ret < 0)) {
>-			mmap_write_unlock(mm);
>-			return NULL;
>-		}
>-		mmap_write_downgrade(mm);
>-	} else
>-		mmap_read_lock(mm);
>+	if (!mmap_read_lock_maybe_expand(mm, vma, pos, write))
>+		return NULL;
> 
> 	/*
> 	 * We are doing an exec().  'current' is the process
>diff --git a/include/linux/mm.h b/include/linux/mm.h
>index 4eb8e62d5c67..48312a934454 100644
>--- a/include/linux/mm.h
>+++ b/include/linux/mm.h
>@@ -3313,6 +3313,8 @@ extern int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admi
> extern int insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
> extern void exit_mmap(struct mm_struct *);
> int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift);
>+bool mmap_read_lock_maybe_expand(struct mm_struct *mm, struct vm_area_struct *vma,
>+				 unsigned long addr, bool write);
> 
> static inline int check_data_rlimit(unsigned long rlim,
> 				    unsigned long new,
>@@ -3426,9 +3428,6 @@ extern unsigned long stack_guard_gap;
> int expand_stack_locked(struct vm_area_struct *vma, unsigned long address);
> struct vm_area_struct *expand_stack(struct mm_struct * mm, unsigned long addr);
> 
>-/* CONFIG_STACK_GROWSUP still needs to grow downwards at some places */
>-int expand_downwards(struct vm_area_struct *vma, unsigned long address);
>-
> /* Look up the first VMA which satisfies  addr < vm_end,  NULL if none. */
> extern struct vm_area_struct * find_vma(struct mm_struct * mm, unsigned long addr);
> extern struct vm_area_struct * find_vma_prev(struct mm_struct * mm, unsigned long addr,
>diff --git a/mm/mmap.c b/mm/mmap.c
>index f053de1d6fae..4df38d3717ff 100644
>--- a/mm/mmap.c
>+++ b/mm/mmap.c
>@@ -1009,7 +1009,7 @@ static int expand_upwards(struct vm_area_struct *vma, unsigned long address)
>  * vma is the first one with address < vma->vm_start.  Have to extend vma.
>  * mmap_lock held for writing.
>  */
>-int expand_downwards(struct vm_area_struct *vma, unsigned long address)
>+static int expand_downwards(struct vm_area_struct *vma, unsigned long address)
> {
> 	struct mm_struct *mm = vma->vm_mm;
> 	struct vm_area_struct *prev;
>@@ -1940,3 +1940,55 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
> 	/* Shrink the vma to just the new range */
> 	return vma_shrink(&vmi, vma, new_start, new_end, vma->vm_pgoff);
> }
>+
>+#ifdef CONFIG_MMU
>+/*
>+ * Obtain a read lock on mm->mmap_lock, if the specified address is below the
>+ * start of the VMA, the intent is to perform a write, and it is a
>+ * downward-growing stack, then attempt to expand the stack to contain it.
>+ *
>+ * This function is intended only for obtaining an argument page from an ELF
>+ * image, and is almost certainly NOT what you want to use for any other
>+ * purpose.
>+ *
>+ * IMPORTANT - VMA fields are accessed without an mmap lock being held, so the
>+ * VMA referenced must not be linked in any user-visible tree, i.e. it must be a
>+ * new VMA being mapped.
>+ *
>+ * The function assumes that addr is either contained within the VMA or below
>+ * it, and makes no attempt to validate this value beyond that.
>+ *
>+ * Returns true if the read lock was obtained and a stack was perhaps expanded,
>+ * false if the stack expansion failed.
>+ *
>+ * On stack expansion the function temporarily acquires an mmap write lock
>+ * before downgrading it.
>+ */
>+bool mmap_read_lock_maybe_expand(struct mm_struct *mm,
>+				 struct vm_area_struct *new_vma,
>+				 unsigned long addr, bool write)
>+{
>+	if (!write || addr >= new_vma->vm_start) {
>+		mmap_read_lock(mm);
>+		return true;
>+	}
>+
>+	if (!(new_vma->vm_flags & VM_GROWSDOWN))
>+		return false;
>+

In expand_downwards() we have this checked.

Maybe we just leave this done in one place is enough?

>+	mmap_write_lock(mm);
>+	if (expand_downwards(new_vma, addr)) {
>+		mmap_write_unlock(mm);
>+		return false;
>+	}
>+
>+	mmap_write_downgrade(mm);
>+	return true;
>+}
>+#else
>+bool mmap_read_lock_maybe_expand(struct mm_struct *mm, struct vm_area_struct *vma,
>+				 unsigned long addr, bool write)
>+{
>+	return false;
>+}
>+#endif
>-- 
>2.47.1
>

-- 
Wei Yang
Help you, Help me

