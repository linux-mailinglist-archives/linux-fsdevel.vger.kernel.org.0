Return-Path: <linux-fsdevel+bounces-57416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5CBB21424
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 20:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9AE71A20E00
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 18:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B707F2E1C57;
	Mon, 11 Aug 2025 18:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OxLkVp6s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6FC2E0B59
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 18:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754936312; cv=none; b=oesZrOu68lvLOpG5SVcu/T6bWMHLrr7AHy1fX4G0JVsewIpDbz+W1IrA25tp8uK398UfPvmUtwOdPdvPU3JTX9gt5Y62QhJQ8lFrt5cVX9Vf9apY0Pi25c4kFgVVO7eKp4vEEKUo84sODVxC1mL6gtBoRdQd0nS/hCZSIPrdF0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754936312; c=relaxed/simple;
	bh=278LB+F/JpYWyp3Scr9ING3NFA9Kzch6L8LJO3c2y5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HEXtGnlCz5beisB+IbZdUYJpWHfcMuG5E+h0CNz161LbzyjWJ89nUpT+mH0g1McWvit41V4AAeGTZyIZSJ4sHcg6tCll5vZJJR0Un1Q4T38F2RcL+wUQ4U5PPoz4mkmQYg2Cg/fQKd+YDZ2xC2/6MIvCCuRnmRo2bN/ic8uO2Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OxLkVp6s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754936309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lAD+rf/CTMK9ZczcWk4uX22kkA50cFqnLejY2P0NP4k=;
	b=OxLkVp6svFYTvn/BPtYe1GoA1L7n4dNWpPNgz9ncJgJsklSOZGPZ+4ZC3DFuJjUXbW4dy5
	QoEw4z+kpJ8poy1g0AXiUUvw3wN8yYyhZpFYj0VHzuhPCssqt82uHD+JLohUknR+j/GXoP
	hbQc18soZOz6Cys+N8iFO0J19GUgyG4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-f6BCHOtUNEWjA1u8RumtbA-1; Mon, 11 Aug 2025 14:18:28 -0400
X-MC-Unique: f6BCHOtUNEWjA1u8RumtbA-1
X-Mimecast-MFC-AGG-ID: f6BCHOtUNEWjA1u8RumtbA_1754936307
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-459d8020b7bso23758165e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 11:18:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754936306; x=1755541106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAD+rf/CTMK9ZczcWk4uX22kkA50cFqnLejY2P0NP4k=;
        b=ZYZ1Loz6aLthIJL2EWNDpSRgVFN+Abj/xcSf+oDvU/pVgUcqIgEoiXdEcgW2mpjiIC
         YZ5XJxyjQm+wn0iuRnW4fjloz4l1GXMWWSR+PonS6LbLd7+45lWmwoMY4CRhfZTvIC11
         V7/s+pTVQbHCfEum6ZecWexFejzqw/+6Rdfu84rcb0lVMP/CmfBejFdprI3nrXILIhbg
         WyFz7GynMDYVTj0VaMS/X1eLPU7EX3AWDeXmNowNv7PE9raz0RsJGXyc+VnFuJiBTK6U
         aYplj7S2XYpbvnYkF6pyVoIUuhDiLtx1m7LJ8ey9uW3FAOzMC0/MYz9j31+fc6yfUxwK
         j0oA==
X-Forwarded-Encrypted: i=1; AJvYcCVWFv8H6d5hZaO0+630YzqXKe/QUJo9o34zIcgMFTKojLNuD/6E050irO25Ey60fXwMOGnoVPX2//7up9xH@vger.kernel.org
X-Gm-Message-State: AOJu0YxIgt/e888ZK7Z2aZqfJHmbbWC0YasPtHUxauJ3uU4Pdn4X4OpI
	bDKSy14HmRW6KKg4CbEJGOWCDyhX1xEmUQ1/D7kkfTjDX9yNIUvmufozvhbwZb+kkJvU3LnXcLn
	MSykEBrQijwMBYNuWFz5z7LqrP/mpqxN4YPBZwhm7jFP5w5smqWa4mDWWPgSa4kIefeJHzGg7pQ
	==
X-Gm-Gg: ASbGncsgByTWdDQG/fxNQKXYLMUmmVSatkgT8AZpWKjASvU8jUbxgbi2XjHXAnJoRgJ
	ZvhuK6UbsLZ64Pf4tVK08a3QWQ9sTmVCj7YR+1eC2NbffCYdC3kAFgx48QUcJXUuyFcY5GJYI+9
	/JG2GKz66/RgWc5fjgxCKG1ocKgR0YDX1A7C2yL2w5v9lwUOHIFxNWwTTEY3a53E736ZEHmCSxz
	89LT/EaYsq1blhQITfc5fwZFu1yqLvuAVgkN/12FWJZLSxbE8wU3RsPKZ6me2qo45t4Jx/l/n4x
	n10xK6eLr7GNr9pUBydiozEaAqrPsmjvwpKy5WuUXCVYnIxlXfCADuZDJUQ=
X-Received: by 2002:a05:600c:1c90:b0:456:2a9:f815 with SMTP id 5b1f17b1804b1-45a10b941ddmr7145935e9.4.1754936306147;
        Mon, 11 Aug 2025 11:18:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6y7tsIn2G/sy6tsYCOF6OgvujdY/Mg5JcoMXvxNskFgP3OG39fmK1x2ARU5f0kEII7yPZbg==
X-Received: by 2002:a05:600c:1c90:b0:456:2a9:f815 with SMTP id 5b1f17b1804b1-45a10b941ddmr7145785e9.4.1754936305759;
        Mon, 11 Aug 2025 11:18:25 -0700 (PDT)
Received: from thinky (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453aeasm43024090f8f.40.2025.08.11.11.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 11:18:25 -0700 (PDT)
Date: Mon, 11 Aug 2025 20:18:24 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH 2/3] generic: introduce test to test
 file_getattr/file_setattr syscalls
Message-ID: <ydu5kha77suh2sn4jmyh4xxj2eiw3g72qvf3b7hy2k5xoh33eu@2vconk3marrs>
References: <20250808-xattrat-syscall-v1-0-6a09c4f37f10@kernel.org>
 <20250808-xattrat-syscall-v1-2-6a09c4f37f10@kernel.org>
 <20250811175541.nbvwyy76zulslgnq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811175541.nbvwyy76zulslgnq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On 2025-08-12 01:55:41, Zorro Lang wrote:
> On Fri, Aug 08, 2025 at 09:31:57PM +0200, Andrey Albershteyn wrote:
> > Add a test to test basic functionality of file_getattr() and
> > file_setattr() syscalls. Most of the work is done in file_attr
> > utility.
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > ---
> >  tests/generic/2000     | 113 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/2000.out |  37 ++++++++++++++++
> >  2 files changed, 150 insertions(+)
> > 
> > diff --git a/tests/generic/2000 b/tests/generic/2000
> > new file mode 100755
> > index 000000000000..b4410628c241
> > --- /dev/null
> > +++ b/tests/generic/2000
> > @@ -0,0 +1,113 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2025 Red Hat Inc.  All Rights Reserved.
> > +#
> > +# FS QA Test No. 2000
> > +#
> > +# Test file_getattr/file_setattr syscalls
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto
> > +
> > +# Import common functions.
> > +# . ./common/filter
> > +
> > +_wants_kernel_commit xxxxxxxxxxx \
> > +	"fs: introduce file_getattr and file_setattr syscalls"
> 
> As this's a new feature test, I'm wondering if we should use a _require_
> function to check if current kernel and FSTYP supports file_set/getattr
> syscalls, and _notrun if it's not supported, rather than fail the test.

hmm, I don't see where _require_function is defined

Anyway, the _notrun makes more sense, I will look into what to check
for to skip this one if it's not supported

-- 
- Andrey


