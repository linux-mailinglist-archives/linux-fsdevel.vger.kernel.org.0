Return-Path: <linux-fsdevel+bounces-57422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2443B214DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 20:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6C267BA1A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 18:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448512E2EEE;
	Mon, 11 Aug 2025 18:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GITHwwDb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17A12E2DFC
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 18:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754937813; cv=none; b=LhcREZ3W2S8bEQHq/XJ8F6568pgsn/eNvJPg/2ZqiiMBEDnCVSyWdHB7FYwY7q5BdSjT7HnuOujVelqDzxc+Z8As9nVjaeKYIZHprWJgcnQDko0MoWHUg+A+ATMJqZoljPmpy5s8S+wAs5M57ClZNwt6nLFYjExWHgl5aDSkGLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754937813; c=relaxed/simple;
	bh=SqhdOnIF7QxUtEixPp9BXh1H/128h/L0jgTrJEJihww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3ZNBgDN4h4rEACdg8A3gbV3o4bqoSoLm2rCqjvhl+EQtgSH6WXHBQ40WNDqOZ6KH8k8YfUARSlR4dKvT9TrJIVfb8urIJVv6Y/3UAESfxjSEB2bkT1T4LlCO/cM1/1u5GK+jzmrbS1bNhWNkElH0Nhr/edZ2kzSHs3UWtnEKFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GITHwwDb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754937811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wIo57RPl/YXM2GjIrmDZTWpdW2C1u6bkxhIh8YLOef4=;
	b=GITHwwDbRsqSwtBCLyovbbI2AtlCXv8pKS/i3PZWqmkTVKl1IzxsUEjqZgkDGcUGWlJWcJ
	ZF+AiZ+fkHRwzndQZLUNDdOSblTNTObgGrxyGBty1dqdShZEXUJ9CYwqP+7hdwvl+KwlIa
	PlfYkGjFhk6eKWcF3kxfxhDTUWIYHEM=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-HeWpK1nkNledTkuUCAQ0wQ-1; Mon, 11 Aug 2025 14:43:29 -0400
X-MC-Unique: HeWpK1nkNledTkuUCAQ0wQ-1
X-Mimecast-MFC-AGG-ID: HeWpK1nkNledTkuUCAQ0wQ_1754937808
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b2c36951518so1744605a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 11:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754937808; x=1755542608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wIo57RPl/YXM2GjIrmDZTWpdW2C1u6bkxhIh8YLOef4=;
        b=JNP9xKFUyghR016042XiVtWoCn5KT5NlE1JxU4I5+o93t7e9jdsYVBHjgZIf7pJqjf
         s95X6mWnMJI8LlRkLhh4aIJjo6SVBIM/Yx4FGjhjl8Z4E/f8g8O+ecHGA4XnyfksZ7VT
         dnKK3XIuX8sWeOs29XfQ+UQyQixRBgtge9H4WKy/yF22RDNfFjTwPMswoN0RLJMclBBD
         qCIndxzenfEcIcLl5L+QUhcfDIKCowP8PbJ53w/qxckgVhVT7RGuVQuClXuo7ryTZXsp
         bMBYx5HmT3LPG3BBk3g1lMt5i4aEt/wbQQCKe7RMx51gg0uZ3bFEYa98r2zfO0vwI8YT
         gNig==
X-Forwarded-Encrypted: i=1; AJvYcCWX4Eofhdf5wOfkWsEGDFU+oL+Zd2TyuzoKDSUkzHm6Um4dtP0jlh14lISHiG0bD7H0ZceTXchZ9rKM0jka@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0XtE0RN0yhutsxVn0to9cq/3/xGEbz0JO0CJmrOTQdNNTo5YC
	WC8WJEOIRfadR07/izId4ihEnd6goLl8AH5SHXWxiIP9RwLscetDHuafgFsMQTIee+4tiPZjwST
	uRkPzIZJZYmJPXfjL3PwzWW8NUV/ZjUp6jww7/A3r2fmLeJ339z+Zw6A8/eVXTF05UhI=
X-Gm-Gg: ASbGncuJSH25tZ3zqFWWAXKV6H/wrQha89Im5c1ttFbd19TkkO/O4H5BEHR8ZrSpajd
	7s2zroMqUAcfiZxKoQjcluhkVEQ5Gc1RBm1lO/8SxLEE7bCDq94MYlgbhJLSlB/E9M8o/jMT8Zn
	A3ozz0rqiajdmenKCwW0xlb8Pv3LWIDdPBgK4cukhMEkFKQXDzaM7DbDylxV2YVmuM8/FLLFgsA
	BdAMfEf0Q2jpCd92giyQFTg0keDUIb1lpnVLOKkljuiu6LosB24NL1MWoQflp5b1bzeFd2TGVvo
	CjKxh03CYuE8H7fNagYKFLdLia1gar8KlkpkUYCi8ou1dZVzIkUQyYjem/w02yMf0AUKusQipio
	cVVIw
X-Received: by 2002:a05:6a20:7d9a:b0:240:15d2:aa7c with SMTP id adf61e73a8af0-2409a9714f5mr708649637.36.1754937808513;
        Mon, 11 Aug 2025 11:43:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgfevIUInZJv6WvEhFsjhLINeXTt8yC+nI2ofBCEUPjRblEgI2+ESpuTZJgu3DvteP+hHh/w==
X-Received: by 2002:a05:6a20:7d9a:b0:240:15d2:aa7c with SMTP id adf61e73a8af0-2409a9714f5mr708626637.36.1754937808128;
        Mon, 11 Aug 2025 11:43:28 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b42b93391e0sm7185239a12.11.2025.08.11.11.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 11:43:27 -0700 (PDT)
Date: Tue, 12 Aug 2025 02:43:23 +0800
From: Zorro Lang <zlang@redhat.com>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH 2/3] generic: introduce test to test
 file_getattr/file_setattr syscalls
Message-ID: <20250811184323.fibycyccfh4qpzpp@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250808-xattrat-syscall-v1-0-6a09c4f37f10@kernel.org>
 <20250808-xattrat-syscall-v1-2-6a09c4f37f10@kernel.org>
 <20250811175541.nbvwyy76zulslgnq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <ydu5kha77suh2sn4jmyh4xxj2eiw3g72qvf3b7hy2k5xoh33eu@2vconk3marrs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ydu5kha77suh2sn4jmyh4xxj2eiw3g72qvf3b7hy2k5xoh33eu@2vconk3marrs>

On Mon, Aug 11, 2025 at 08:18:24PM +0200, Andrey Albershteyn wrote:
> On 2025-08-12 01:55:41, Zorro Lang wrote:
> > On Fri, Aug 08, 2025 at 09:31:57PM +0200, Andrey Albershteyn wrote:
> > > Add a test to test basic functionality of file_getattr() and
> > > file_setattr() syscalls. Most of the work is done in file_attr
> > > utility.
> > > 
> > > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > > ---
> > >  tests/generic/2000     | 113 +++++++++++++++++++++++++++++++++++++++++++++++++
> > >  tests/generic/2000.out |  37 ++++++++++++++++
> > >  2 files changed, 150 insertions(+)
> > > 
> > > diff --git a/tests/generic/2000 b/tests/generic/2000
> > > new file mode 100755
> > > index 000000000000..b4410628c241
> > > --- /dev/null
> > > +++ b/tests/generic/2000
> > > @@ -0,0 +1,113 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) 2025 Red Hat Inc.  All Rights Reserved.
> > > +#
> > > +# FS QA Test No. 2000
> > > +#
> > > +# Test file_getattr/file_setattr syscalls
> > > +#
> > > +. ./common/preamble
> > > +_begin_fstest auto
> > > +
> > > +# Import common functions.
> > > +# . ./common/filter
> > > +
> > > +_wants_kernel_commit xxxxxxxxxxx \
> > > +	"fs: introduce file_getattr and file_setattr syscalls"
> > 
> > As this's a new feature test, I'm wondering if we should use a _require_
> > function to check if current kernel and FSTYP supports file_set/getattr
> > syscalls, and _notrun if it's not supported, rather than fail the test.
> 
> hmm, I don't see where _require_function is defined

There's not that _require_ function, you need to write a new one to check
if current kernel and FSTYP supports file_set/getattr syscalls:) e.g. name
as _require_file_setattr.

You can use your src/file_attr to check that, or update src/feature.c for that.
refer to _require_aio or _require_scratch_shutdown.

> 
> Anyway, the _notrun makes more sense, I will look into what to check
> for to skip this one if it's not supported
> 
> -- 
> - Andrey
> 


