Return-Path: <linux-fsdevel+bounces-18927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C2C8BE96C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 18:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA9F31C2406A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 16:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05B853E16;
	Tue,  7 May 2024 16:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fq1KdaqB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B13524AD;
	Tue,  7 May 2024 16:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715099782; cv=none; b=SSFitXLG9+3A3JZMLXAh+ib5DLFPGzmlb+rOcC6irLKB78TwuvmllVegRq3rnHc7+Cp5818Miq2a+u8UDX4sRKQdXZU3oVUuZ1Y+Jb65xpfjQCmGOp07QW860XnVJIHRv04SVKpuUXt9AXhN0MhT/URmWynPw/LxRRq9D/kN5HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715099782; c=relaxed/simple;
	bh=2Bajx+l3ITU8XWvxfqEXTZnzcts3/3BYXAtY2w1Z04M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cYzb0PJHn8WJ8D/XJH1vi+FyKVOGp4v83f+M8h6VsV7DK1I7cYcFyMTtoRtzGUpDCZ4rwSsURJyA8untHKtPRD+kkogrOCQ9uls0lKXNOlmhkonFBK4HpUFAt5u1mazKNARebNyU1XJpd0vr3QSze/5dwVWsbOD6Ov3o5MYBsew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fq1KdaqB; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-47f00074f54so648861137.0;
        Tue, 07 May 2024 09:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715099779; x=1715704579; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OIH6aQmwwJHXxsNaL1gpFbq6JK/4rTlX3KH1VdDetm8=;
        b=fq1KdaqBRjaz9vMuqxsu8ngutoVW6UxM4O9qQtv51vW4H50H4kOciokC8a4PK4h99y
         z1DakCkF7HHb+L/5ivh/vQQjGsyr8GT8zqZ31PG+dMezqSYkI0yJC0spjNCK2G65JXlj
         AUXUJmsm13Exb9ngIKf6Q227Ww1xtQsk6XJ+h5Qn9uTmP4OmZ/Cyfb3s+X2jw082xfZw
         fqmM9+zZWxyShvsh2hvLpAU8h9+Xw99NZfE5GDy3cPLWLw99HAaZVFN9LmkQbRSMm8Ux
         zDDdCltgdK2QeQMYBKveHNh+C4jkdS5wXROk5fCY+ubnHmJK3FE7kSA23f2UYHTaBfa5
         OG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715099779; x=1715704579;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OIH6aQmwwJHXxsNaL1gpFbq6JK/4rTlX3KH1VdDetm8=;
        b=dfd9ZhaSOUR0YgeRlcwj9HVKdLlqw+YohE8i0vXoWCkXTAczu9t92RBVW6gWDsGWtM
         QCpZXxSpH8YxBNIW1MejGWk3lv+r6b8LMHIfdMQEtAukwts5NMHo+b6CtNE1KLWLTVsw
         BSoYPZfI/2VAijQM3YsGJtVXN36FmkgTy+2XvQ4jE14dVkT5QjjTc1Q40xeDOhT4GmRr
         /VOBusaIRrZWXYHo01M3TvnJNcSbKhVuVf4vfS2EH1sxwYGCGeeglznWr5r7SXYbw2MY
         ybdnaqCq9f4VSLAfHmq00Wlr+dxuHSIm3zvzYXuOJf8EtDR3FFQ3JjCu1ueKcDfQA8PX
         z3gg==
X-Forwarded-Encrypted: i=1; AJvYcCXtshix/qbkZ+1DPHhJpSO8WyCI3amJrhbcAOWMtM0wXRWw5sRdfikE3CcixQ4Tg39GI3ty5ckIZaMdwnH/cXYaiTw6/NhhGot6ppSecS8Xg+kk4KSKZziHrT/hlrDaxFIhkM4LkNgdQmBJ+A==
X-Gm-Message-State: AOJu0YyGDUdcSkvEkzUaqZOR4ejCKwO4hqZ7Y5K2bTugHkSThBr3FGwh
	BZB0PpNA22QoGsC8EElabayEZFvYX3gj5cyBFCLWNfPDU2uQ4feDh9dH99D8F4aQ3yRrOoYP8+K
	unMaWj3u4o2VmJDaoSymhz5Egeug=
X-Google-Smtp-Source: AGHT+IFLE7o1q4yIV5QIpQ2zwnryVHkBTr8cvfHOkMi+4EMADqYRYKPCAK7R+jI7/0heAa0+ZJFW6vFupgJDauVUo2c=
X-Received: by 2002:a67:f2ca:0:b0:47e:bd11:7e5e with SMTP id
 a10-20020a67f2ca000000b0047ebd117e5emr16136515vsn.7.1715099777915; Tue, 07
 May 2024 09:36:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506193700.7884-1-apais@linux.microsoft.com> <202405072249.fLkavX40-lkp@intel.com>
In-Reply-To: <202405072249.fLkavX40-lkp@intel.com>
From: Allen <allen.lkml@gmail.com>
Date: Tue, 7 May 2024 09:36:06 -0700
Message-ID: <CAOMdWSLsVXC8TNifYwXPE4O+saxBeG6Koa=MMH3ZUNutBkDVcQ@mail.gmail.com>
Subject: Re: [PATCH v4] fs/coredump: Enable dynamic configuration of max file
 note size
To: kernel test robot <lkp@intel.com>
Cc: Allen Pais <apais@linux.microsoft.com>, linux-fsdevel@vger.kernel.org, 
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	ebiederm@xmission.com, keescook@chromium.org, mcgrof@kernel.org, 
	j.granados@samsung.com
Content-Type: text/plain; charset="UTF-8"

>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on kees/for-next/execve]
> [also build test ERROR on brauner-vfs/vfs.all linus/master v6.9-rc7 next-20240507]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Allen-Pais/fs-coredump-Enable-dynamic-configuration-of-max-file-note-size/20240507-033907
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/execve
> patch link:    https://lore.kernel.org/r/20240506193700.7884-1-apais%40linux.microsoft.com
> patch subject: [PATCH v4] fs/coredump: Enable dynamic configuration of max file note size
> config: loongarch-randconfig-001-20240507 (https://download.01.org/0day-ci/archive/20240507/202405072249.fLkavX40-lkp@intel.com/config)
> compiler: loongarch64-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240507/202405072249.fLkavX40-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202405072249.fLkavX40-lkp@intel.com/
>

 Thanks for reporting. The kernel builds fine with
https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
for-next/execve.
The issue is with loongarch-randconfig, which has CONFIG_SYSCTL set to
"n". It is needed for this patch.


Thanks,
Allen

> All errors (new ones prefixed by >>):
>
>    fs/binfmt_elf.c: In function 'fill_files_note':
> >> fs/binfmt_elf.c:1598:21: error: 'core_file_note_size_min' undeclared (first use in this function)
>     1598 |         if (size >= core_file_note_size_min) {
>          |                     ^~~~~~~~~~~~~~~~~~~~~~~
>    fs/binfmt_elf.c:1598:21: note: each undeclared identifier is reported only once for each function it appears in
>
>
> vim +/core_file_note_size_min +1598 fs/binfmt_elf.c
>
>   1569
>   1570  /*
>   1571   * Format of NT_FILE note:
>   1572   *
>   1573   * long count     -- how many files are mapped
>   1574   * long page_size -- units for file_ofs
>   1575   * array of [COUNT] elements of
>   1576   *   long start
>   1577   *   long end
>   1578   *   long file_ofs
>   1579   * followed by COUNT filenames in ASCII: "FILE1" NUL "FILE2" NUL...
>   1580   */
>   1581  static int fill_files_note(struct memelfnote *note, struct coredump_params *cprm)
>   1582  {
>   1583          unsigned count, size, names_ofs, remaining, n;
>   1584          user_long_t *data;
>   1585          user_long_t *start_end_ofs;
>   1586          char *name_base, *name_curpos;
>   1587          int i;
>   1588
>   1589          /* *Estimated* file count and total data size needed */
>   1590          count = cprm->vma_count;
>   1591          if (count > UINT_MAX / 64)
>   1592                  return -EINVAL;
>   1593          size = count * 64;
>   1594
>   1595          names_ofs = (2 + 3 * count) * sizeof(data[0]);
>   1596   alloc:
>   1597          /* paranoia check */
> > 1598          if (size >= core_file_note_size_min) {
>   1599                  pr_warn_once("coredump Note size too large: %u (does kernel.core_file_note_size_min sysctl need adjustment?\n",
>   1600                                size);
>   1601                  return -EINVAL;
>   1602          }
>   1603          size = round_up(size, PAGE_SIZE);
>   1604          /*
>   1605           * "size" can be 0 here legitimately.
>   1606           * Let it ENOMEM and omit NT_FILE section which will be empty anyway.
>   1607           */
>   1608          data = kvmalloc(size, GFP_KERNEL);
>   1609          if (ZERO_OR_NULL_PTR(data))
>   1610                  return -ENOMEM;
>   1611
>   1612          start_end_ofs = data + 2;
>   1613          name_base = name_curpos = ((char *)data) + names_ofs;
>   1614          remaining = size - names_ofs;
>   1615          count = 0;
>   1616          for (i = 0; i < cprm->vma_count; i++) {
>   1617                  struct core_vma_metadata *m = &cprm->vma_meta[i];
>   1618                  struct file *file;
>   1619                  const char *filename;
>   1620
>   1621                  file = m->file;
>   1622                  if (!file)
>   1623                          continue;
>   1624                  filename = file_path(file, name_curpos, remaining);
>   1625                  if (IS_ERR(filename)) {
>   1626                          if (PTR_ERR(filename) == -ENAMETOOLONG) {
>   1627                                  kvfree(data);
>   1628                                  size = size * 5 / 4;
>   1629                                  goto alloc;
>   1630                          }
>   1631                          continue;
>   1632                  }
>   1633
>   1634                  /* file_path() fills at the end, move name down */
>   1635                  /* n = strlen(filename) + 1: */
>   1636                  n = (name_curpos + remaining) - filename;
>   1637                  remaining = filename - name_curpos;
>   1638                  memmove(name_curpos, filename, n);
>   1639                  name_curpos += n;
>   1640
>   1641                  *start_end_ofs++ = m->start;
>   1642                  *start_end_ofs++ = m->end;
>   1643                  *start_end_ofs++ = m->pgoff;
>   1644                  count++;
>   1645          }
>   1646
>   1647          /* Now we know exact count of files, can store it */
>   1648          data[0] = count;
>   1649          data[1] = PAGE_SIZE;
>   1650          /*
>   1651           * Count usually is less than mm->map_count,
>   1652           * we need to move filenames down.
>   1653           */
>   1654          n = cprm->vma_count - count;
>   1655          if (n != 0) {
>   1656                  unsigned shift_bytes = n * 3 * sizeof(data[0]);
>   1657                  memmove(name_base - shift_bytes, name_base,
>   1658                          name_curpos - name_base);
>   1659                  name_curpos -= shift_bytes;
>   1660          }
>   1661
>   1662          size = name_curpos - (char *)data;
>   1663          fill_note(note, "CORE", NT_FILE, size, data);
>   1664          return 0;
>   1665  }
>   1666
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki



-- 
       - Allen

