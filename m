Return-Path: <linux-fsdevel+bounces-50473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C31ACC807
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 15:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B9053A4A9D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 13:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D491223536A;
	Tue,  3 Jun 2025 13:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QdRqef0e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E27235043
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Jun 2025 13:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748957824; cv=none; b=lAlttmIfzBu0d3lpkM5csWeZicUsbzvKYEkEi7EiMDhGl8LeL3Xcfw8j92xfzeWG020rqdnaxpUVYKxOaVqGy48m4xeGrDd8QpEm3JbkFj8l/EDAJzx2hE9VUeSacjXaYYYickTA/d9hWXlyHcDFGHLlm0GBR1+YsuFq46QmrDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748957824; c=relaxed/simple;
	bh=MfnZO5lFJA5kphVhQXFmjyYwzPaWj6A9QLg5HcsjC6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lY373iiMNys/XRazFCYZvHzL60H7iweYFqQX57V/cY1B9Fjihea6XBdqCzonPssam1MiE3dhsXTdAeeWpi8UGG00EqYCKZHTcbT+KvBm0StKcc4Y3UBVfa9UmsGp0kss4wMuh4ZbAa/njFT8/sbhRDttekrzxw2QESppO0nCIHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=QdRqef0e; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7d0a47f6692so416882085a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Jun 2025 06:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1748957821; x=1749562621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M2tOvYIRYhJ3zgazeT9iy9SxHIfkqCxujQJZWAlLZ4g=;
        b=QdRqef0eufvBDPsFNSKgItk8ioK5rW0bITD7h/gaJVlsLti5kJbkAWQoNEmZWRe68Y
         Q4oF4tefxOI7cERsX4wsVaBuaHz22hTf4BcC/yjkMVx+8DuPCBDLYZ3A+RWTRvaraqNs
         e7pqxu3qqrej8RwTwZermIn33SpopTq52Y2nm/rfb3Wh5IxZqh6cLkWQPdwWIBjD+YoN
         aiioFJ+ghZ9yPVDMy/MALzaSX/kPFwincvLa9cv4TcSSylFCgKj10d+Rbd3GZwiNMEHs
         ubZ2U/8vLM8FJ3hFzQB993FiXCNvO+ks/3rtygYKqSmy9D7l/904PPCBEYVreULiWIuI
         rFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748957821; x=1749562621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2tOvYIRYhJ3zgazeT9iy9SxHIfkqCxujQJZWAlLZ4g=;
        b=KT5ZPOFWzJCsBqib4JhwXPrfRGZO8v8uv2QQO0NZMGAzLKT8Af7BO9cU9rKrv3nFI6
         v6p7WIQ/PkeDwlPQm8XQXHSq7KsJ+ZXEW4Pm4frpLVzSAk1d8/Ka1PUthbaBY+aFQYQX
         Dr8PdZCLSFzB7bWI6ti/nUpoWFO+tgwK92TfG/G8XAXPMH9DlvTZjYQ/CHfaRCclp9JO
         CC7vHMjQMdMZAe41UXtQVRB1A9utP7UI47DVmm1NOdknypqVSpPtn5oInyX1y5I+Bwc4
         2BkNjBmRFZ/0V20DcVxMDilbiR7da7HS8+J5/p5s/hSl11cnT8dm1UW6B5g9uT8dxhHP
         uC2g==
X-Forwarded-Encrypted: i=1; AJvYcCUZkwh+d++WKyI8CrbeOhurtKxgnO3nPl29U3thzErG0BVu1VNae5amtZPiKB+z5aGZT3aLkEnRc1X3mX4X@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2jty9qVW78ZhUFCCEiVjz/LVk08x2t4jJEX2IZ4bAnSraVSIh
	02DKRQFDeqibhvOtGJHArwEpqArlmYzvq68VSpCYXMrlCTaBfONug8Y58xiLQ6FLQGo=
X-Gm-Gg: ASbGncvZwIVdq23yRKgM+reIqQ/khgRH6+CSKK1NsbxRXDUjhsezC0RudYsw7yGpsD2
	5bUbKz6GnjzwKAFc3s+r4DMeYLTDVGwvXHDrVsC6974e/BVkn8xKOT9W/LUH8bQVItlcthppTS8
	DpBW8qLYFVftplsx0tL6NKCJvoP/gLVsR+mS0xRCCvWNzQQSiE78WPsrMDFGMrj/OZc5BkUGVRA
	AwoTB526jTh+qHPCRoRY3GzWg8PEbG3l9Zz/lcFbV/KM7ziwSM341f9cFygZqVrThhW3Z80AhW+
	36IPRYYidZTVhf3IMXW7RT5gjqxxpwK9oqw1nsq+HpB16Wk4ybmMjZ29NP6XJMeuKxU3nzNrWGE
	xu0pISO0qiOusM2vBkBmB9/Eb4uI=
X-Google-Smtp-Source: AGHT+IF/1nQKKWghBymIv6kapapYp3T/T+mDb2uBcjAQYD1rkFwd/p2CMx7wy82AG8RXeUKzw729SQ==
X-Received: by 2002:a05:620a:4408:b0:7c5:3d60:7f8d with SMTP id af79cd13be357-7d0a1fb91a0mr2626422385a.19.1748957820692;
        Tue, 03 Jun 2025 06:37:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d09a0fa38fsm842635185a.35.2025.06.03.06.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 06:37:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uMRp5-00000001h5Y-2rWO;
	Tue, 03 Jun 2025 10:36:59 -0300
Date: Tue, 3 Jun 2025 10:36:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alistair Popple <apopple@nvidia.com>
Cc: linux-mm@kvack.org, gerald.schaefer@linux.ibm.com,
	dan.j.williams@intel.com, willy@infradead.org, david@redhat.com,
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
	zhang.lyra@gmail.com, debug@rivosinc.com, bjorn@kernel.org,
	balbirs@nvidia.com, lorenzo.stoakes@oracle.com,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-cxl@vger.kernel.org, dri-devel@lists.freedesktop.org,
	John@groves.net
Subject: Re: [PATCH 03/12] mm/pagewalk: Skip dax pages in pagewalk
Message-ID: <20250603133659.GD386142@ziepe.ca>
References: <cover.541c2702181b7461b84f1a6967a3f0e823023fcc.1748500293.git-series.apopple@nvidia.com>
 <1799c6772825e1401e7ccad81a10646118201953.1748500293.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1799c6772825e1401e7ccad81a10646118201953.1748500293.git-series.apopple@nvidia.com>

On Thu, May 29, 2025 at 04:32:04PM +1000, Alistair Popple wrote:
> Previously dax pages were skipped by the pagewalk code as pud_special() or
> vm_normal_page{_pmd}() would be false for DAX pages. Now that dax pages are
> refcounted normally that is no longer the case, so add explicit checks to
> skip them.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>  include/linux/memremap.h | 11 +++++++++++
>  mm/pagewalk.c            | 12 ++++++++++--
>  2 files changed, 21 insertions(+), 2 deletions(-)

But why do we want to skip them?

Like hmm uses pagewalk and it would like to see DAX pages?

I guess it makes sense from the perspective of not changing things,
but it seems like a comment should be left behind explaining that this
is just for legacy reasons until someone audits the callers.

Jason

