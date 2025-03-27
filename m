Return-Path: <linux-fsdevel+bounces-45139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29ED1A7346C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 15:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DC351762F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 14:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2546217F30;
	Thu, 27 Mar 2025 14:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzJOo3sq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F112342AA1;
	Thu, 27 Mar 2025 14:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743085750; cv=none; b=lJF2Y0KFzsiJZRX1pkXlPp9FkaEXiQKN69MZbScmJiivIvKZ5S8AjhMtXg4wipdONkvtvnimkxJuGBM1VToHkXChH8PgDpxAgRdvFmmkFVnIBYqIBPx8x4dc5ZVCHJhk6TzsrFU6qPEkfZ1pvtnbW3Zm6966szKZqklu0tqhF7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743085750; c=relaxed/simple;
	bh=NiNtawr9A+v8YCmvyfEAy8wjPDxpKpRJsTNG3j+fQ28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KeRvlt22uNJsmBsarQe/Gk7JIQjff3wAn+qpiCcykp0tywFPtw2KHVNXzgut4G+2O3pJKOekeqk/J9UE4WoNxhhrE9bzO2aSC7udgAypgwyRprEv/6dp9FXBUgSdZgRJp+ZbGVsZJDiEWkIMonU7AkiyP0Ir/ld3V6FNBuhWqvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UzJOo3sq; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-224100e9a5cso21406515ad.2;
        Thu, 27 Mar 2025 07:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743085748; x=1743690548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rDAG6v2LHjM6KDlx2nFQi5f53vc0tn2ixt91kpIk98k=;
        b=UzJOo3sqZVZYYYbNP1lO5+Bp+4JyCpRir4i5Oij6hkQd32VEu8GyB65DHhlIw/38lU
         HJkWsVjBzPaVACWAeUhS6aET161UZ13x/WKq65gUoVb8bFumT96zP8bqLCSc2RNrv6pF
         ljJxOzAcbmWIPmV8otCZbzNzqKe13xgjJpZDqL7hPgxtEqQeccSRCGZNc/xXR9NL/E+U
         ZLpYKaIQ/meDUrMzjE3AgLJNDxh5mz3NmItHedXlthG3g08cF/NntDVIrw+vTFmEF15u
         MyXiLyDUfpi/IAA3leKyp6UnYteuJp+TYEY8lOt4yeE8OzQBdl/mLVYnsISH29EN2Dbn
         wOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743085748; x=1743690548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDAG6v2LHjM6KDlx2nFQi5f53vc0tn2ixt91kpIk98k=;
        b=XOHT5ITTGKTnhhcQTdMHgeQCoKclLmRwMBHGbXCsRo+6++yJD50yMPrILXYfExgGs6
         SjRyb9kMzjVxCCnKelN2sde3kYpfnlio3yeJFCUsffing67Z8qcb8w0O/1vI1ch7eNwz
         J2+dt4s9+J7uMZ9RMDUghXP3NrSJXBvqD22a4Fe0hOJ6VpE39IqAYfkiHGegc5oTiNOd
         cwvZLVfv7MZaLTHF47EDOBVjQYeg/PgWCtk7ymfzCRZa4/Jyl0i6e0QrU3Aa+v1ZmyIZ
         o9jJgo8rF9washaAC4lZu873QKAAbtYE807Z21ATON01FapkFGxZm5jHDVA7dDNiH2t8
         /r3g==
X-Forwarded-Encrypted: i=1; AJvYcCVuxtzQj9gCHQnAAMNJ7J4Z9epSDps4EW/VPRZebhNkfTPpjv7xl5kNt5EOLtvVQrPAbORxTz1WFUwfxZcP@vger.kernel.org, AJvYcCW0PGLIMoFSJm0DOv0g7bhGTZ1Vf6mZNGFEHcBKPoUnW7tWV4XBHl8M9r1UoKWQm5qlVU+PF9dzdUVmMRGbVw==@vger.kernel.org, AJvYcCXJ08FJJtnhVyz2ZA5wHbfIphR40StAqv1kJxKjwzR/Tz8DstMyX+JyVVR8j0wAdBP1b9pqXbn0wCk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu3fZViEp7C1NAzoGcYa/DdbwvqDPfUROsaYHuYernCOw+eErR
	O169azGwAaEai7F+4wlDnDGJ5GwSRBKrnJ7PpStb+cLOVRjmdufZSgaOtFR/
X-Gm-Gg: ASbGnctPgIso7EX2mN/xUD0Xa+vebsjZIhnm3RsJi/PggzesGUuqwmfixDdwmTkqgoV
	RSgAnaGsVxnbBgrfb/m/GCPHWRz0/2asdTKUDkU+V4I8/zBgA9OqMG6+0cwMhX9LJnJ5coABptf
	EfylFMVDTTejtiqcRB04AcFAZHsN8Ow22S8zL38nok4Gok2U+5WrbmDjmjvxDGSt89AOHS6eDjJ
	apXsGPZgFw+XbqAnsCtTdcpyJVGa+9157ayWdKX24Jg7XLPo0IQ4Q3hHC4tCKKq1AMmIMyOPg7R
	5x3tqd2IEKMu5bIYjc/fFMqYO1E+NqGtGzd1A/RLu/W8qXG9CoMAgzKDQFxMw62eiuPJ1wD5
X-Google-Smtp-Source: AGHT+IGNWcsPx7tNMqqWJOiOb+NqlelcQPXCaG5itHSGXRVxKNM4Et0vtqGeM2qGNRiqHZhvKiWapw==
X-Received: by 2002:a17:903:2f85:b0:220:d601:a704 with SMTP id d9443c01a7336-22804858faamr37358655ad.18.1743085747950;
        Thu, 27 Mar 2025 07:29:07 -0700 (PDT)
Received: from vaxr-BM6660-BM6360 ([2001:288:7001:2703:ccef:3c67:33df:4a11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811bc272sm128939295ad.146.2025.03.27.07.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 07:29:07 -0700 (PDT)
Date: Thu, 27 Mar 2025 22:29:03 +0800
From: I Hsin Cheng <richard120310@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: corbet@lwn.net, linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] docs: vfs: Update struct file_system_type
Message-ID: <Z-Vgrx0XSDASGnpg@vaxr-BM6660-BM6360>
References: <20250323034725.32329-1-richard120310@gmail.com>
 <Z-AZiYwkE9PsST90@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-AZiYwkE9PsST90@casper.infradead.org>

On Sun, Mar 23, 2025 at 02:24:09PM +0000, Matthew Wilcox wrote:
> On Sun, Mar 23, 2025 at 11:47:25AM +0800, I Hsin Cheng wrote:
> > The structure definition now in the kernel adds macros defining the
> > value of "fs_flags", and the value "FS_NO_DCACHE" no longer exists,
> > update it to an existing flag value.
> 
> What value does it add to duplicate these flag definitions in the
> documentation?  I would not do this.
> 
> > @@ -140,7 +148,7 @@ members are defined:
> >  	"msdos" and so on
> >  
> >  ``fs_flags``
> > -	various flags (i.e. FS_REQUIRES_DEV, FS_NO_DCACHE, etc.)
> > +	various flags (i.e. FS_REQUIRES_DEV, FS_BINARY_MOUNTDATA, etc.)
> 
> This should be "eg.", not "i.e."

Hi Matthew,

Thanks for your kindly reply!

> What value does it add to duplicate these flag definitions in the
> documentation?  I would not do this.

I thought the documentation should follow the exact code as in the
kernel, if it only serves as a roughly example, I agree with you then.

> This should be "eg.", not "i.e."

Sure, I'll change it and send v2.

Let me know if anything more is needed to be correct, thanks!

Best regards,
I Hsin Cheng

