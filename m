Return-Path: <linux-fsdevel+bounces-40232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B23A20B5D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 14:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B33A3A66DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 13:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602661A83EF;
	Tue, 28 Jan 2025 13:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nl5I/2nW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343151A23B6;
	Tue, 28 Jan 2025 13:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738071549; cv=none; b=JNaF/GIrEzdHbIQVaT/EPDoB6hXifZyyunJmtbmszBvaYCExtsegC+OV+NWdi7423DGMLECEA4pB2pUChadQGsxibU6pFKa0/s18ECxkjWygnIcS2swLLdf/DmKPl6EnSzhnZ6a/DEm0jGnV3duydBbHLoz20otGid6OoyjW3/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738071549; c=relaxed/simple;
	bh=H0gmNTrTx7YtG/f4y5i6XlfQ0gWJCDAignL3fROT1yM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFDIEzUkiVAjuSL7mKPyq+oXouW6dAaOBEmkPfSbPPnkRFB5iBM+XHfRBgQ0uhQrjnHhUhJd26cZar62lYpPHD9GNoy81EKpekMgkstot2N+qOtlqFGID/5qdA0NXULtJq5xXU8ElkeL3HLrY/rQHyPnXlsN/IQzyy0ui3ggNIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nl5I/2nW; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa684b6d9c7so139588966b.2;
        Tue, 28 Jan 2025 05:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738071546; x=1738676346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TzaDT6E8ldXsPjOp4GLG1ShZZeCtmJHlgKtEwqC9QvM=;
        b=Nl5I/2nW9tbPn3Xofy9rVwIKCXdQMUzPSHc6EWhpZslaRlnhF1BWp3RuIgZ8GPwCLL
         jp17Gr+LaGZOL729I8ivk2tH9I6mOO1zO4ZPxpwTUzgbkGRPm1EVW51577qUpm4pmV2u
         sEXQU3uaBO1UWJHgRZqrJeALNYvd2YLqfv9Vbj+SYFgDBNPltP2ofMTcS5jNvotBsMWu
         qAsS6TRFVOLryAUrytGQaRasQS1AgAqwjjXEga2y+BLCy3l45YIVKcoEMzlYcWPV8r3a
         Qpz2rCULhRsSnHMjO3tSEvUUbRjSJUSaexZyW5YJ6v1q6b84oMfR3cPnssPtwobEjni1
         Y+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738071546; x=1738676346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TzaDT6E8ldXsPjOp4GLG1ShZZeCtmJHlgKtEwqC9QvM=;
        b=cZPuDdC+Hh1+W+v0Yw+Jogiol1pTVTjGBCPc8Uqy1wnXl6REVRVe8sz/Z56xSF1O5q
         pxMLFQtCh4xjGg4PVXA879wfEcNWrn4QUu9dJYBDbysvYonkwdsq8jThjHmjwtZ7RqWF
         U+h8BQye0yYMkgjMawdSAeaHDktpfLX7RHNEGOTyP6AOo0k9kffE71DO5UkbUPuooADv
         ycQpxDGSOPvXe1gY5P2kSY0uM0b6IPbBwQ0WLdZagvJ/FUGC/FkuePaPn4LbzwA4fm+5
         6Mkuj17nStTxs/3qlUNSB/3KuTJ76RLG8GJ/N070ny9tykJ8lOeNC9nrafVPAJj1xktP
         5wnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUph6945OwppsDb1M25STUjOKPcPW0hHkblJLRZx9akJMav7nk4IDnQeZZjDO/DSuQhD9sOiX65Kq5Jb3Ev@vger.kernel.org, AJvYcCVKaQriLysgbW4obeu1NFONyEahReeGv1YfuvGISBHY0NGEH/DIH1AH0QLYSm22PcjuEOySwo9XyWwDnaaH@vger.kernel.org
X-Gm-Message-State: AOJu0YzSECNwLdKQ0pQRCZtDnX6DQpot6xduSbjNUtXFbWUUl4sfLAc6
	qAiAx7CQbfS7Kg+RmoPJh/93LzdjKiQ9a1MV17vKhoTyYA9DaFr2Iy01xg==
X-Gm-Gg: ASbGnctDlkERqL0pic2eBgvnOJysh3MkczWjv+YS8jD+2ovP43V0IZ1aDrLvBwh6tzv
	OT45WS8WMerU83jUsscqIfk3DNmQkQOAAKuM15YMjkm3+1rOL3LY1ethuckdnizuARGhsgGDnDm
	ZgWXlmhGfz7+f5tMYrzFziCJCjpCxAHD304vump3HUxRckX6U8nLPTYc5DBmcv4kfUaSPy5g5tV
	u2/rvERnnavUR0Mx3uigtmETxahPUMOA4c47j572kT7jOMslp1Y97s9/ZmsFHs5TG+DwSCJ/LD5
	lTy+rdEPQK9Np9h9X6VjjvPw4CJQ
X-Google-Smtp-Source: AGHT+IHo+zkHKoDYgw5qXmmn54Y2fsEOyqbvIazuQC8g8pTWN30QWn/GP1YEgVNWZmTa5ehq0AlGzg==
X-Received: by 2002:a17:907:9802:b0:ab6:949f:c52f with SMTP id a640c23a62f3a-ab6949fccf2mr935422666b.28.1738071546128;
        Tue, 28 Jan 2025 05:39:06 -0800 (PST)
Received: from f (cst-prg-69-60.cust.vodafone.cz. [46.135.69.60])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6c7366dd0sm81505966b.8.2025.01.28.05.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 05:39:05 -0800 (PST)
Date: Tue, 28 Jan 2025 14:38:57 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [linus:master] [pidfs]  16ecd47cb0:  stress-ng.fstat.ops_per_sec
 12.6% regression
Message-ID: <ea7fq465sidc3gonlqcd33s64tzjogdo2lhnye5tau22pbs4d5@426xzgsios3q>
References: <202501272257.a95372bc-lkp@intel.com>
 <20250128-machart-bemessen-edd873223e02@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250128-machart-bemessen-edd873223e02@brauner>

On Tue, Jan 28, 2025 at 11:51:49AM +0100, Christian Brauner wrote:
> On Mon, Jan 27, 2025 at 10:32:11PM +0800, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed a 12.6% regression of stress-ng.fstat.ops_per_sec on:
> 
> I'm confused about how this would affect stat performance given that it
> has absolutely nothing to do with stat. Is this stating pidfds at least?
> 
> 

stress-ng is issuing the "claimed" syscall in some capacity, but it also
mixes in other stuff.

In this particular case the test continuously creates and destroys
threads.

This in turn runs into pid alloc/dealloc code you modified.

I verified with bpftrace that contention around pid alloc *is seen*.

one-liner: bpftrace -e 'kprobe:__pv_queued_spin_lock_slowpath { @[kstack()] = count(); }'

@[
    __pv_queued_spin_lock_slowpath+5
    _raw_spin_lock_irqsave+49
    free_pid+44
    release_task+609
    do_exit+1717
    __x64_sys_exit+27
    x64_sys_call+4654
    do_syscall_64+82
    entry_SYSCALL_64_after_hwframe+118
]: 472350
@[
    __pv_queued_spin_lock_slowpath+5
    _raw_spin_lock_irq+42
    alloc_pid+390
    copy_process+6112
    kernel_clone+155
    __do_sys_clone3+194
    do_syscall_64+82
    entry_SYSCALL_64_after_hwframe+118
]: 568447

there is of course tons more

So the new code is plausibly slower to alloc/dealloc and is lowering
throughput as a result.

I'll note though that thread creation/destruction has pretty horrid
scalability as is.

