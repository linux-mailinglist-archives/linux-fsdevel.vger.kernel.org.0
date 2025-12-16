Return-Path: <linux-fsdevel+bounces-71476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EFECC3042
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 14:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50C43304FE92
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 12:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C208734F250;
	Tue, 16 Dec 2025 12:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXH+YHC5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5478834C83C
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Dec 2025 12:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765889468; cv=none; b=lYWg136a0Je6wYpcwJZLKBBq0KQwyfDJkkEWNHSlrZDtdoYdzc+YEToJgI8L9zQ/rdep/K8bEDSg8LxvGrfTzXS1cMk5oONqFTRobGdbbcOLTR1dul5yoXBjB4hf0oBzaX6+EjhhLmNZpujBQbNIVeTFEhrm5tUAPEpidU24wg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765889468; c=relaxed/simple;
	bh=fjySlG+wDGqoUAaOpS7wlXqPSCjoePl0tLAR0GFeyAw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tOyfnJQrKfpi31DpfLcQqBYzLk2ElEhqZ115Lw4/UUIYltWiSXLLy6hsxGO8s9/+ObY9OLdElWruZYAMQZSGI2zXDcuQEqgZYiYlxdqVk7qcPClriQDGTCQT6LQTQqwiw6D22P1Qnjm1CQvwBA6151KNwxyAC6XhaE7dhg4VQcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XXH+YHC5; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-42fb2314eb0so3295793f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Dec 2025 04:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765889465; x=1766494265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4a6mOsfv3RnQ6962mCNsIiYlyvmUIvf225M/JZ00fuU=;
        b=XXH+YHC5VfWESOnmtd0o51oy46jw5UEGV9x6jUIYd/of5+BTx5brzAL79RHhSXZi2u
         BqgMyNPYMvKGq1O92NwAOECwDb/HEODxK9cyip4Frg7sfT0S33rEEofabXdyXvR4H7pB
         OabiqbR9P4afZCnZlsvwE3YT8XlLD0PFPw2icRYDtUmgSvjaW+NbkaSHCfPOwIZ4/iGl
         Cllx76SIStBugcGm/HXQ1xa6FyptucNp9oukkthhtmc3j2WWom8+vrgMdJa4sthJcRUA
         xGvhbs0IthzqdSU0eiPhylDzjx2qKmuKdFSsr8drQUprEnXxhP6oIv68x0BAfYDSSg0H
         xygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765889465; x=1766494265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4a6mOsfv3RnQ6962mCNsIiYlyvmUIvf225M/JZ00fuU=;
        b=QJxdzGPDfVtBBCxEclx4M6w2Vrds01JZHaMmS6OqNL3TIZGexLXvgeMSKBmbwrOFi8
         8jujUgceiPgCNCYzbS+BHKkO/I3mU9OXOz2jp+QESF3vWDLKY1rpIF9UKz2yqaI+puI3
         hMOH8iXDuxaYdyj/JmZTnPFvVCIetuuPjcJ0JhnpL/zLgfyCCbkgFbnZIBGBFuS4u7MT
         OtT4dfQ3t1oZXm+XcHuN5v+b1n/5oIxXp14mXSiSQxZQjWbhrCgxMxoiJan64ThX97Em
         T8r/bQDScD2xRQJh+IOAhoRDVVbEsDMWN+zFCaksc8rNhwcx4XiXB5J8Ul10eHnF2ont
         XdFw==
X-Forwarded-Encrypted: i=1; AJvYcCXfB6w0iYwRTJp2bkLOii1Qh8WvDd2h8B+EQUwutd/3aEXWn2ekR+Dihl/+D/ZTH8HnYvjSNpeGg9/N1zqq@vger.kernel.org
X-Gm-Message-State: AOJu0YymONOa3LN1awp/TvSbErYGgYix1jh/ODqonUs5wDptwPPaS6F4
	oWOSYPWiD1pqE6ETkmkAqXgMTyouOt8QE4B4YgkKspk8MFzRgyAWFV1wayL8fHXZ
X-Gm-Gg: AY/fxX71wDr/nqnj9T801cNRERgyLoys/ReZs8o3ceoqLDLsjxleknxQaYFf31OV+3d
	+ErZ1Wenh0SJEFu6fM/T6ZNGE8cuAALoC34P6SF7OuwNwwX7bOz/tMMvgoWnA87/XT4yzOLEUWU
	kuCwf63ELzXV6saDQT2rLwvvrAJRskpIO2LFKrYODshsAkmv69q7c4EtDQRh+s4cv3vqLzyuCqr
	2tNEUg9gpfUjIWEu9LTXgdB3H8eXUIsW5O2nBO+0CZBUt6/EIGqPiMHf1lFYZjjIiJjBicdTxMz
	Wd4Hp/6TYJJSV1sd7c2zUVvwttYr895YF1xLqNrhzxPJzN81xij/Glia0DznqsbImhsgQwa5tyt
	qH1qXo8gt4MJkjycIT/BmMcJBTCfFezIxepp0paj+S4acKL4XtiBNmqQvshOC87LEq18VlUdMP+
	GARvU26nH/zoFUf4uz5tUC7NU6u6HhIW/GDIodshVM9QB+MIS798Ma
X-Google-Smtp-Source: AGHT+IFPgi7TTcjcdd99eLNcHo7wpcpOi8USD2GLgaobtq004FVNQnOS5KgbJ3i0Qdom2oLbozNUGQ==
X-Received: by 2002:a05:6000:228a:b0:431:9b2:61c8 with SMTP id ffacd0b85a97d-43109b263f4mr556895f8f.10.1765882981024;
        Tue, 16 Dec 2025 03:03:01 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8b9b750sm34285532f8f.42.2025.12.16.03.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 03:03:00 -0800 (PST)
Date: Tue, 16 Dec 2025 11:02:59 +0000
From: David Laight <david.laight.linux@gmail.com>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, Christian Brauner <brauner@kernel.org>,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Subject: Re: [linux-next:master 1617/1848]
 include/linux/compiler_types.h:630:45: error: call to
 '__compiletime_assert_612' declared with attribute error: min(((pos + len -
 1) >> 12) - (pos >> 12) + 1, max_pages) signedness error
Message-ID: <20251216110259.60c84f61@pumpkin>
In-Reply-To: <202512160948.O7QqxHj2-lkp@intel.com>
References: <202512160948.O7QqxHj2-lkp@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Dec 2025 09:05:42 +0100
kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> head:   563c8dd425b59e44470e28519107b1efc99f4c7b
> commit: 0f5bb0cfb0b40a31d2fe146ecbef5727690fa547 [1617/1848] fs: use min() or umin() instead of min_t()
> config: i386-randconfig-2006-20250825 (https://download.01.org/0day-ci/archive/20251216/202512160948.O7QqxHj2-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251216/202512160948.O7QqxHj2-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202512160948.O7QqxHj2-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from <command-line>:
>    In function 'fuse_wr_pages',
>        inlined from 'fuse_perform_write' at fs/fuse/file.c:1347:27:
> >> include/linux/compiler_types.h:630:45: error: call to '__compiletime_assert_612' declared with attribute error: min(((pos + len - 1) >> 12) - (pos >> 12) + 1, max_pages) signedness error  
...

The definitions are:

loff_t pos  - 64bit signed.
size_t len  - unsigned long, 32bit for this i386 build.
unsigned int max_pages - 32 bit unsigned.

On a 64bit build 'len' is 64bits unsigned which promotes the LHS to
   unsigned and min() is happy.
On a 32bit build this doesn't happen, the LHS remains signed and
   min() is unhappy.

I'm not sure why file offsets are signed (apart from relative lseek()),
causes signedness issues in a few places.

In any case there are a few ways to fix this.
Clearly a cast could be used somewhere, the most subtle would be changing
the prototype to 'u64 len'.

Perhaps better is rewriting the conditional as:
	min(((len + (pos & (PAGE_SIZE - 1)) - 1) >> PAGE_SHIFT) + 1,
		max_pages);
Although the LHS is still signed 64bit, the compiler knows it can't
be negative.

This still contains a lot of 64bit maths, adding a cast:
	min(((len + (size_t)(pos & (PAGE_SIZE - 1)) - 1) >> PAGE_SHIFT) + 1,
makes it 32bit and the generated code much, much better.

In theory the expression can overflow (fixable by masking off the high bit
of 'len' (eg (len << 1 >> 1)), but normal IO are limited to MAX_RW_COUNT
(INT_MAX & PAGE_MASK) even on 64bit.
I'm not sure io_uring enforces that limit (it should, a lot of drivers are
broken if the requested size exceeds 4G).

	David

