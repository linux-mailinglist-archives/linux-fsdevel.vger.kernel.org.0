Return-Path: <linux-fsdevel+bounces-25034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE339481DE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 20:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDAA7B22CD9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 18:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9188A165F18;
	Mon,  5 Aug 2024 18:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="Tph/erhd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09417165EEF
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Aug 2024 18:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722883290; cv=none; b=T4BI+Gjwmol76hlTUZTsv69i3RZnmnGf8vjpQjDDwVt+JdeMaJKRU2jQ5QDPoivXp5xp3iYsTUbV1cIK28LswJJJCd/r+xI9hHOCGopLXd+ARvFGbaqhtnU2SJxjJSiTbAefV+r7ibEKnzdmvx4cbSOX5VukRM3h9CWDKbCWk10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722883290; c=relaxed/simple;
	bh=Ys/t/CdNVJJmv2lzAuDmT1M/s6j0A9XtgN3oc62Jk5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KSYz1qX+cyl84lVbc9cM6ALJWmQGfzlXwPyx90qQepCsBgu+qjpDvpuX7F3GjlKb872qZpiJq6lBT6PcZsWxyq3/wHuKUbZd8k9C41rw97v6LpnIddS8zjXsEoJTAuqNc7OcfsAjo5QAe1tATz63bcNfBpjs5+DceJ5oZMAmU+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=Tph/erhd; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3db16129143so6333178b6e.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Aug 2024 11:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1722883285; x=1723488085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXDR7qiLrGhxm4QaBcXkbXKBNxx4m/1amTQ3OxtKpcA=;
        b=Tph/erhdRxbaDcA9Hk7B6yaxgFNtP0dQEEL0icsRDcawCDeE5cVUz5zPmVb0y6uo5P
         WzBFcTTNTWY1yT5Y+EBI/+l4PIH2+XalMy/sWOKvoMzn5UJvFI0VED6IBAdcjtVUVenX
         B8E1puC7TFwcVz54Vmi73lOZjDB6VZZQ1Qvp5qzDCn9ofz6xJH5PKrQjbllHnY9InlAN
         x9/a6CEv5h8UtH9lw2AQBxg6lSwb4Hbd9AMcjJLe0t27k7Te7qn4ug9OKAHZDGQ5/fDT
         DtzrKCtgQEltlGCpVfEh73NgOpAwd+EQIihgd0Ma3RcgUcLILaBU56pMnAQmnbGqeUzS
         7jww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722883285; x=1723488085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nXDR7qiLrGhxm4QaBcXkbXKBNxx4m/1amTQ3OxtKpcA=;
        b=Z5GfFRf3NJqkzJtGxObMW+JVn8RAQb7ytEks3KOljqEoTf6oY4ojdxtPsW5/FFf9Gs
         CoxmhyTHpCplRz6eqHNktjPmAlwnIqtub+MtBsDKRfF9qX8JgBnypv3xaSr1hyJZLS8e
         R0HM4jlxAopnvP4T3AycjfmeoIBxbDurn7Y/zWUzymYk9QMUAHeRqVgnarKISXziWntL
         yqAyjclsOhagrqIVyKEYBo2lA0Ou+F5JIMoRfyfbrVFw1Q0PZbZUr/t5mtxXXrb6BK6R
         MvZCAlAIgMGx4dDciMFQuq5Fa/cD7ci2tVBtgowLiVz5jisP7pVfg/rv5r3fIBzozhqr
         qBpQ==
X-Forwarded-Encrypted: i=1; AJvYcCX18twUPjw5h7OuwvOQL07GJqwXbYsYxxqiIr0uGoD5h6B6B9jv9d3SbPhrm+IdHEGSCBarpvHsBYfWFIc/l2rN8cW1jVZS89/IhYAZAw==
X-Gm-Message-State: AOJu0Yw3fN6joy0Dh59uQjzbXIz6eTbLKxZ3vE1xPYzN2+0sKDdhw+Hp
	BcXsC4Db2O9S3KeUA0ZidoLUZGQRdWgrqOM0iFPUDIkpJCxyyU+HBqlfL/guVgyQfybdAWlmKzk
	ingE0C9MGuPB3L8oGBd8a7QVUHzO4hMZPh4Ra7Q==
X-Google-Smtp-Source: AGHT+IELiX1V707IcRryP1iDqdmXzsN+eMp7QFXOkdeEr9fYlKlUd987VH8uQ7e08ycHl28xM7Hu7WLB3uBVe3WBGzg=
X-Received: by 2002:a05:6808:191a:b0:3da:e02f:eb8e with SMTP id
 5614622812f47-3db5583e3e9mr18020289b6e.43.1722883285128; Mon, 05 Aug 2024
 11:41:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605222751.1406125-1-souravpanda@google.com> <Zq0tPd2h6alFz8XF@aschofie-mobl2>
In-Reply-To: <Zq0tPd2h6alFz8XF@aschofie-mobl2>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 5 Aug 2024 14:40:48 -0400
Message-ID: <CA+CK2bAfgamzFos1M-6AtozEDwRPJzARJOmccfZ=uzKyJ7w=kQ@mail.gmail.com>
Subject: Re: [PATCH v13] mm: report per-page metadata information
To: Alison Schofield <alison.schofield@intel.com>
Cc: Sourav Panda <souravpanda@google.com>, corbet@lwn.net, gregkh@linuxfoundation.org, 
	rafael@kernel.org, akpm@linux-foundation.org, mike.kravetz@oracle.com, 
	muchun.song@linux.dev, rppt@kernel.org, david@redhat.com, 
	rdunlap@infradead.org, chenlinxuan@uniontech.com, yang.yang29@zte.com.cn, 
	tomas.mudrunka@gmail.com, bhelgaas@google.com, ivan@cloudflare.com, 
	yosryahmed@google.com, hannes@cmpxchg.org, shakeelb@google.com, 
	kirill.shutemov@linux.intel.com, wangkefeng.wang@huawei.com, 
	adobriyan@gmail.com, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	surenb@google.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	willy@infradead.org, weixugc@google.com, David Rientjes <rientjes@google.com>, 
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, yi.zhang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 3:02=E2=80=AFPM Alison Schofield
<alison.schofield@intel.com> wrote:
>
> ++ nvdimm, linux-cxl, Yu Zhang
>
> On Wed, Jun 05, 2024 at 10:27:51PM +0000, Sourav Panda wrote:
> > Today, we do not have any observability of per-page metadata
> > and how much it takes away from the machine capacity. Thus,
> > we want to describe the amount of memory that is going towards
> > per-page metadata, which can vary depending on build
> > configuration, machine architecture, and system use.
> >
> > This patch adds 2 fields to /proc/vmstat that can used as shown
> > below:
> >
> > Accounting per-page metadata allocated by boot-allocator:
> >       /proc/vmstat:nr_memmap_boot * PAGE_SIZE
> >
> > Accounting per-page metadata allocated by buddy-allocator:
> >       /proc/vmstat:nr_memmap * PAGE_SIZE
> >
> > Accounting total Perpage metadata allocated on the machine:
> >       (/proc/vmstat:nr_memmap_boot +
> >        /proc/vmstat:nr_memmap) * PAGE_SIZE
> >
> > Utility for userspace:
> >
> > Observability: Describe the amount of memory overhead that is
> > going to per-page metadata on the system at any given time since
> > this overhead is not currently observable.
> >
> > Debugging: Tracking the changes or absolute value in struct pages
> > can help detect anomalies as they can be correlated with other
> > metrics in the machine (e.g., memtotal, number of huge pages,
> > etc).
> >
> > page_ext overheads: Some kernel features such as page_owner
> > page_table_check that use page_ext can be optionally enabled via
> > kernel parameters. Having the total per-page metadata information
> > helps users precisely measure impact. Furthermore, page-metadata
> > metrics will reflect the amount of struct pages reliquished
> > (or overhead reduced) when hugetlbfs pages are reserved which
> > will vary depending on whether hugetlb vmemmap optimization is
> > enabled or not.
> >
> > For background and results see:
> > lore.kernel.org/all/20240220214558.3377482-1-souravpanda@google.com
> >
> > Acked-by: David Rientjes <rientjes@google.com>
> > Signed-off-by: Sourav Panda <souravpanda@google.com>
> > Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>
> This patch is leading to Oops in 6.11-rc1 when CONFIG_MEMORY_HOTPLUG
> is enabled. Folks hitting it have had success with reverting this patch.
> Disabling CONFIG_MEMORY_HOTPLUG is not a long term solution.
>
> Reported here:
> https://lore.kernel.org/linux-cxl/CAHj4cs9Ax1=3DCoJkgBGP_+sNu6-6=3D6v=3D_=
L-ZBZY0bVLD3wUWZQg@mail.gmail.com/

Thank you for the heads up. Can you please attach a full config file,
also was anyone able to reproduce this problem in qemu with emulated
nvdimm?

Pasha

