Return-Path: <linux-fsdevel+bounces-73084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD0ED0BD84
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 19:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3042305CD25
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 18:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4282C369208;
	Fri,  9 Jan 2026 18:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMLkvn9i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06128366DCE
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jan 2026 18:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767983392; cv=none; b=X9+hEYqRT/Rmp+JOgwwR78vdhkKYpJbXPpvsg/sZedSfiEqmhAB/0ffaqMRTxHuzi0WwYUjk/tlYviiiiDe7FGYQZ5oRqevfMCkBaQzGwr+bfFagrdJKaKXU8XlItG2vZMICUA09l4PhreUUrjRj3wQ8Nkpfp8ZP68nZPW0gygE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767983392; c=relaxed/simple;
	bh=00yYLGXhb42qUhp3Bu+hEI0Ws2wuU/ekKjA7ZDTW8ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YUGrKC5B+9cfFOOPH9XsHzulz34VTKD6nFwulrFpzhK7htM72anNaPJT4hwIPEkyWKz4TGJ1Ja2tsbdbk1YdnVwtABtWPJCZ1JP0mTtJdIQlok7cdlGGXRKX+ewERqk9VmJ+gpZah0nBba9S6gDYB30lXlbOq5d+ibTn4lVbEZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMLkvn9i; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-88fca7bce90so46716006d6.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jan 2026 10:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767983390; x=1768588190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cAxsMd9qfhbaF/uFu/ONsXnhJzDpN/ZmkW3TT/4ib5s=;
        b=DMLkvn9i0zKrtfl3buWjSpr1Dd3UkSVxtv0lcl4RFWqfv9XUAjteb3RreFgBUkGN+n
         3iTiW0WeIroU3eMMfKD6QtOjdJpENTY0M5jN38ScYaf9hBw1Sp8fPyODWDHJIUPSMKNf
         sTm+QUuXTBVWtxLJ27IdDpG4XZusd8nfmgOviVhCpnVZHK+avVruXZbtI9+Bn5XdIfjI
         XLf+3NtoL6fbaIsdBK3Rz4/4ekeE13+IwrNAEnABB/8AgtMVgR7XEBwOZztjPUFnsby2
         LVQXS4ANBnLX5w/4KnL84RWfrTiMDGCxSfKCbKdfTdKDhAfVIB/SftzVs9CgwUSHjfeP
         AaSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767983390; x=1768588190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cAxsMd9qfhbaF/uFu/ONsXnhJzDpN/ZmkW3TT/4ib5s=;
        b=Of//MTJbwZguchfb5CyN9wkS328FwxHHkkBfZ/5VyjUcDlFjybXKnv7aUzmqUoRm/S
         MomnH9v6zh6Z3JdqljyV3elMiGvB3/00lXLKOzjo9l1jYWOxMVpBFwlFb7Tm5lkkkEo3
         yUdfJ2q3NGMS8kRfzqu+fANZL10qtRviPrIL5tktgEMii+vHNK56deZ9KHKp+OT85jfk
         cp/iaTgUE0sR72zu5e6onCwMm00IFHvgQVd8vdKnhjy9isFgHW2cF3MtFojJ5fibmB/R
         DONLNlXEJmMX3Eg8M1gyCRkuLJChBFMDztA57CCffA/wgOMEFx6abIiQk2I31cIDcyAs
         c6Hw==
X-Forwarded-Encrypted: i=1; AJvYcCUf1bGzYNiIKwJS3wzYblfjDCwtm+WEGPLq+GUww91SdGIJRrchl9drweDLRqrnl6fsWEuBDyja4k5cUPsH@vger.kernel.org
X-Gm-Message-State: AOJu0YxwwGfxfXrdDH8tbRJZpek+nOZ7Ow8npNdXfJBpMb5Lcp49SQCn
	4bzmTQc+4nQTmCocZ0WPI+W6F6RXwz15PxysSMA8Ly4Ij4f1+QWKK43kfR2HvC9Hsn/3kAc3DWQ
	uE7H7gcU05mr2yXI13DEgdkPL6VvHPZ4=
X-Gm-Gg: AY/fxX7WqcnzRGylRRuaExlb3CFdT1yOokC92AASKx4I6Dw2HoFtKhVmfA9gayNb8gX
	VkkveR8NMuBCuV9SnoO2rSL/7DA8wk6M0Z2wRgDkmqoygJDO+njOODeVshrM9SnzL1//ALn9KFf
	YCcwuHn7GBR6Jt2mqYA/hFjfxXGH5VPURIeSSeClYI39D7jmoJEzCfYP7emjRTdhy+F96Au9rh4
	V/9eV9zUWvvc2cEQf8VaeEH9JQ7O/Y0veIcjM13Gb9iZ8/4SwDfpQT4rWBoqnkFSQnOuw==
X-Google-Smtp-Source: AGHT+IHlq/k6aGt3slZY7iNfrk9m2XRGsaHa25Bso2IebEcIgjfLBSdbUtZ1fL6PzKuJnwZWbWVzCQE+c2rsB6YWIcY=
X-Received: by 2002:a05:6214:268f:b0:882:437d:282d with SMTP id
 6a1803df08f44-890841ae54amr151687936d6.30.1767983389887; Fri, 09 Jan 2026
 10:29:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107153244.64703-1-john@groves.net> <20260107153332.64727-1-john@groves.net>
 <20260107153332.64727-13-john@groves.net>
In-Reply-To: <20260107153332.64727-13-john@groves.net>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 9 Jan 2026 10:29:38 -0800
X-Gm-Features: AQt7F2ol_drdQ3iXi69XhhLUyZBWJiqqNDBNu77Lc8heqKjvvqfcHiuhasXh1Zo
Message-ID: <CAJnrk1ZcY3R-iL2jNU3CYsrWBDY4phHM3ujtZybpYH2hZGpxCA@mail.gmail.com>
Subject: Re: [PATCH V3 12/21] famfs_fuse: Basic fuse kernel ABI enablement for famfs
To: John Groves <John@groves.net>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Dan Williams <dan.j.williams@intel.com>, 
	Bernd Schubert <bschubert@ddn.com>, Alison Schofield <alison.schofield@intel.com>, 
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Josef Bacik <josef@toxicpanda.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Chen Linxuan <chenlinxuan@uniontech.com>, 
	James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, venkataravis@micron.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 7:34=E2=80=AFAM John Groves <John@groves.net> wrote:
>
> * FUSE_DAX_FMAP flag in INIT request/reply
>
> * fuse_conn->famfs_iomap (enable famfs-mapped files) to denote a
>   famfs-enabled connection
>
> Signed-off-by: John Groves <john@groves.net>
> ---
>  fs/fuse/fuse_i.h          | 3 +++
>  fs/fuse/inode.c           | 6 ++++++
>  include/uapi/linux/fuse.h | 5 +++++
>  3 files changed, 14 insertions(+)
>
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index c13e1f9a2f12..5e2c93433823 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -240,6 +240,9 @@
>   *  - add FUSE_COPY_FILE_RANGE_64
>   *  - add struct fuse_copy_file_range_out
>   *  - add FUSE_NOTIFY_PRUNE
> + *
> + *  7.46
> + *    - Add FUSE_DAX_FMAP capability - ability to handle in-kernel fsdax=
 maps

very minor nit: the extra spacing before this line (and subsequent
lines in later patches) should be removed

>   */
>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

