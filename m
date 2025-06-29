Return-Path: <linux-fsdevel+bounces-53231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F01AECC1D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Jun 2025 12:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC95318949AE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Jun 2025 10:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5260521CC7F;
	Sun, 29 Jun 2025 10:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZCgyCrx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061CF1F4169;
	Sun, 29 Jun 2025 10:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751192112; cv=none; b=O0HEOIVtcHcLPhsQsJlgLXFyOjWbBRab+eQlCUPxfL1U0cp9c95IyoHlOvzi17KhcK5OmD5/F5HQftzhqL4OQt5OwELNZwGhRRpZXMxk00px7e8WwmwP+MKWWT4vtelTsUsptPLd+Eg6RTsPSsmkZqQ6t5YwMpv6vpgnsnjGvtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751192112; c=relaxed/simple;
	bh=W2Sj0FqzFPGvWpO0mkRbXNUzJ8KD1W3cwBit7XUJxzA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NSPEF065vMMY5r4iuw7PkMPFEcOOS1cOLrmpmI8cyshlgISDkvvDjbuHRShecnD1mdzWnO4hY/TP2htC6fEEH+CmXBwboxAuLrXOm+2IKEU0SwNSuLnl9quyGvEqAlkM/Ql/mlP5l7DvR69/OhdFgvAsld1Cd4O9X97Fqbokfp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZCgyCrx; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so22796615e9.1;
        Sun, 29 Jun 2025 03:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751192108; x=1751796908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rv+KlWL8/gXlHieXHmmWXTDlacHPWEYy4YGQvjbJEp0=;
        b=TZCgyCrxhKi9TTVqngok+s7B7wiQyshDBz3MS9kFqfLGy2Bi7Y+UqMlhpm79Vmi6eu
         RJhx755DISyryVJlcOhDrCK45Af9PI1kx8io8+4oGXR0rMKDqirsZiCoZNrGGdP5NXWZ
         ElxMOBYyWobQEXBLmOa0YzWBUTpAGDLZNzvDd6kOi8fXcO2epH3A/apjT4v/4C/U4Ajq
         PXEVm4RjeN9rogVuZc4yUqAxMrNGH57P56Fh4Ar6Lm/36yC0ieHGhqnK2RtP6kQN0dow
         z9RtCJgVkJh+IoHlUVNvVdbSavMVF+nsDjDmcizY5/NfwcbGmXTywgfleSwq81qDhKaT
         VcKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751192108; x=1751796908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rv+KlWL8/gXlHieXHmmWXTDlacHPWEYy4YGQvjbJEp0=;
        b=Az6Yrm2G3twPyYoSfR9gwUA5v39bZANNU/SL89atdZ/dCZaTr0CmOycR4zbJGN56RB
         YhqK33+31Kua49sJmYt+6EtDEOZCpHgZPXYMY6XVtLa54Xb8OsLnBtUdRNmNzQu9amCV
         hweFWUXVLU5dTa7o//KylHBB4Rgmxpy9/9DenQwhJgaD1wdK0jhIgH/Tv0Tpz/kh0h2y
         9YUbcip5LfgQyY4EBNQYKYUVV2dG5eIgQwUsWxJADcMpeu7wgrH7WAIhkIYyZ4QAsdtB
         3E0PfB5lAGYKpkllA8oRAwTi4qWbR0NyK1EHl8C0+ztwhdAfYdOjnbsJrnMrtSFCHCEV
         eqcg==
X-Forwarded-Encrypted: i=1; AJvYcCV/2qY5ym4bZKao1EiH5mZ785Ci698chCikl9gHt0m5ujMMrGaZEWLXFSa/y4J4kgV+qAjdljWaeiHPpEWP@vger.kernel.org, AJvYcCWuf9XqE9OnoEjgMHsKvUGRxnzb7iwgprCfxVyxKMShqcLRMmahIvmMyfyB0cmumOAY5TJsJ4fgc4OAR9nv@vger.kernel.org
X-Gm-Message-State: AOJu0Yy28WRDh5UetJ1uiWkvNCTwbcaFjrTWutACgjmBq8MIyrRSbqp+
	mb7PksvvL+lERDvO4NGaCHulU7T3EKBQoNtacboDPx7cQMc3dyuXnz0k
X-Gm-Gg: ASbGncsARbwoBo+KHlGO0vEdDAmpc3usG8Gt4E28ufAaBhXf0GByH8QWWQTzTYZ2Uuf
	RafKYOzM/X9yqJO6bE50CnOLjv3yI6WAPYbndMlwLChWAQGlpD/e9y10kNH97ZSNijvXAHE5v+l
	F26GWeHJ33FB+FxwJr8fQ9vT9DF6suKB5Fpx2r47P44KUHqXvpc8BNXeUaK4p/VT5e8lk66tFz7
	mx01fl49n1oNecy5SGkV8qDRoZGDfqAtQJJ2NIefhjypq3GY3DwkvCtRrxgDFYUM8CrD9zedoOK
	DrFi+nTP8ZLoZb7DvmDeJjTMR7ZnCmdypPNHMudZ2pNknbCR5S404l6IFQUOmyVNNj1wjZlx09m
	X7J8OYpkWshKnjfdzKpsMi5/Kq42S
X-Google-Smtp-Source: AGHT+IEHSBTOuNU4gIJluwTcmrh+62LZDnnH7HDcmBH7HEYrjf3Wks9oCzUt76AUoKgLXxQD5c/hUA==
X-Received: by 2002:a05:600c:8b69:b0:43b:ca39:6c75 with SMTP id 5b1f17b1804b1-4539ff478a7mr1146925e9.16.1751192108049;
        Sun, 29 Jun 2025 03:15:08 -0700 (PDT)
Received: from pumpkin (host-92-21-58-28.as13285.net. [92.21.58.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538f88efffsm72765615e9.17.2025.06.29.03.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 03:15:07 -0700 (PDT)
Date: Sun, 29 Jun 2025 11:15:06 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Baokun Li <libaokun1@huawei.com>
Cc: Pankaj Raghav <p.raghav@samsung.com>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, <mcgrof@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, <linux-kernel@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <kernel@pankajraghav.com>,
 <gost.dev@samsung.com>, Matthew Wilcox <willy@infradead.org>, Zhang Yi
 <yi.zhang@huawei.com>, Yang Erkun <yangerkun@huawei.com>
Subject: Re: [PATCH v4] fs/buffer: remove the min and max limit checks in
 __getblk_slow()
Message-ID: <20250629111506.7c58ccd7@pumpkin>
In-Reply-To: <3398cb62-3666-4a79-84c1-3b967059cd77@huawei.com>
References: <20250626113223.181399-1-p.raghav@samsung.com>
	<3398cb62-3666-4a79-84c1-3b967059cd77@huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Jun 2025 10:02:30 +0800
Baokun Li <libaokun1@huawei.com> wrote:

> On 2025/6/26 19:32, Pankaj Raghav wrote:
> > All filesystems will already check the max and min value of their block
> > size during their initialization. __getblk_slow() is a very low-level
> > function to have these checks. Remove them and only check for logical
> > block size alignment.
> >
> > As this check with logical block size alignment might never trigger, add
> > WARN_ON_ONCE() to the check. As WARN_ON_ONCE() will already print the
> > stack, remove the call to dump_stack().
> >
> > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>  
> 
> Makes sense. Feel free to add:
> 
> Reviewed-by: Baokun Li <libaokun1@huawei.com>
> 
> > ---
> > Changes since v3:
> > - Use WARN_ON_ONCE on the logical block size check and remove the call
> >    to dump_stack.
> > - Use IS_ALIGNED() to check for aligned instead of open coding the
> >    check.
> >
> >   fs/buffer.c | 11 +++--------
> >   1 file changed, 3 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/buffer.c b/fs/buffer.c
> > index d61073143127..565fe88773c2 100644
> > --- a/fs/buffer.c
> > +++ b/fs/buffer.c
> > @@ -1122,14 +1122,9 @@ __getblk_slow(struct block_device *bdev, sector_t block,
> >   {
> >   	bool blocking = gfpflags_allow_blocking(gfp);
> >   
> > -	if (unlikely(size & (bdev_logical_block_size(bdev) - 1) ||
> > -		     (size < 512 || size > PAGE_SIZE))) {
> > -		printk(KERN_ERR "getblk(): invalid block size %d requested\n",
> > -					size);
> > -		printk(KERN_ERR "logical block size: %d\n",
> > -					bdev_logical_block_size(bdev));
> > -
> > -		dump_stack();
> > +	if (WARN_ON_ONCE(!IS_ALIGNED(size, bdev_logical_block_size(bdev)))) {
> > +		printk(KERN_ERR "getblk(): block size %d not aligned to logical block size %d\n",
> > +		       size, bdev_logical_block_size(bdev));
> >   		return NULL;

Shouldn't that use WARN_ONCE(condition, fmt, ...)

	David
 
> >   	}
> >   
> >
> > base-commit: b39f7d75dc41b5f5d028192cd5d66cff71179f35  
> 
> 
> 


