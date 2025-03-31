Return-Path: <linux-fsdevel+bounces-45318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC7FA76171
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 10:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE888166BA4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 08:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBA81DB546;
	Mon, 31 Mar 2025 08:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QBIqNIle"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E6A1D63F7
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Mar 2025 08:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743409422; cv=none; b=mladzl6Gr7LsO8jbuMS/0xqyWhisN7hdpLB7CNx+QpfYj/42zi+wpejYb1IFBpwfYP+As+IEw8RXKxoFKl3jrsEfovLULQvE8CRy8yiFspOZMDbaamiC6YBmPN9hMxwVB5gC+RdLcS/5CTC64jVufIZLSBcQVVPCMkObDs/Ey4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743409422; c=relaxed/simple;
	bh=tydjkUm1MWoPcJbw9LlS45LEZRiPM3MfaIlva5bJBN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AR/RMsfy2zkUpQsFqS8nvV5l98NsilXOQuZTwHhfU9Yha4fhhuod455ac0Rqfkhbey+R1Bh57axVwzpE9nnv9/LQ2ybFriPB3SVq9tUPFW/4XG2DU+PFSZETxZPGpZknwXS4mTwDSslM9hx6gsWjOeBdn9IcbPeQyuuzfXGmxEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QBIqNIle; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cfe574976so28105455e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Mar 2025 01:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743409418; x=1744014218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7XzAbMJKsyqCvYLFOVx+4nb8BpQlUBvuCN2BfbgjctA=;
        b=QBIqNIleMAn4b5Z0pt6iZaXLwwBR5vcel7Y+3XutIHugOziNDALMcZ6MxoQS/GOJfn
         W8FbSBfcCku4MrLYkWi8JhdfGPED3ul5BrJypCpNQa87GjL8pw/QGez+iu9JrZRyNg5g
         l6PcMj8JtZsU0vupoJwWm2+zFwkZhuKKryxD2tlDhkx2K2agkFwyG/qfQlGXEkS7dEIZ
         aGrp0qtAuSy7PLfQJTwpGbspkPA55ypxbJ6nbWnEZXkDISxl6TzQNIAbCanGnW7kYJ+c
         tbQcmQsVpymKjWF+6Y/sIXgCODq3IrXtOkWVaFPauuAJ+LW69BBzD0lITuG0gUn2e00y
         +zUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743409418; x=1744014218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7XzAbMJKsyqCvYLFOVx+4nb8BpQlUBvuCN2BfbgjctA=;
        b=P1gM7hxkoT1v4V808CopabCv4bEa1z6qlgGCNdeJEKDBLFTZ+3DX17Ye/KsmdGQ4ME
         rTUJ8uIfsPT3QMb7TSqSrOK5z3yDokwrKL55ULxXkAZG+tF7WxUr3HPCjHLD9zbXhxFD
         DbVA6sDXb41v+H3N+ecpLYbN51DfxKwU3tfURRl9NgkEC7fxnDYtEhAGjDypxGNjGLYc
         Gizm+9fD7wFqsajHAISoKMKf1NIx2tG6fUgw3x03o8lgG6lpjMt8i82qFWpOzpUVavGb
         Jnzr0hCn+lmrn6sGIMrhb6DG7nETquk4uLjBRlfu/wZb0Sps4U/yVRpGnAbFOu69FA+6
         oHTw==
X-Forwarded-Encrypted: i=1; AJvYcCX/DRbt69zdI7PVShTEYOK3wu0ybKUsRYZbXd4MEcncBS/851Ff/pc+7hgfYRbsv/56tshr/bo8xHGx0q3k@vger.kernel.org
X-Gm-Message-State: AOJu0YwdXH3wlsBoBArOgqijMFHHYU6c7ID6ftA8G1uKPGzyo60Ah2P+
	NpSA9OFU7Nk/h7DuZLY+xrXWi5mrw/RZ9Tqj85PIhMLiPZxIyUT+TNGQKaPbDTg=
X-Gm-Gg: ASbGncsmhL8m5PFzhQRpRlYvs9zErEGqE/25DJ5dlCpUNYxz7JfmIhILvywVebwmlvc
	7P2PYW5Y6sVXM/Ast+5SBHWFO1XASO5dXWZvy358K5fPnsx6cGMYMvNZF2M4DjRY+BFpur/wNlF
	VFZ5+SfahJiyc5WZMx4Ij4EBVj/NCRNdujtvHMtQpCclHEsZPZj3s9zm7xnhxNghNFlsq170q5p
	I2pllZzCIane8jqQZQw39nAGf8ErLjkijoe/AC8EE9jyYBuB+PdN/PRBnKZ9TuIcCNtNjAoaWtg
	wg01jPeFKPksD5vDGSLGCWkx07luoxsWhj7kbYp7mqlgbuPE8vBRO5AAj4tb
X-Google-Smtp-Source: AGHT+IFgpeNUpBNYq+DGAF/behYR3kaDePcRPqnxNTpDQLiUg5Abgd7en5WRr361G/zWw5nYs6ivdA==
X-Received: by 2002:a05:600c:3d13:b0:43c:fa24:8721 with SMTP id 5b1f17b1804b1-43db61ff059mr77133175e9.17.1743409417894;
        Mon, 31 Mar 2025 01:23:37 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39c0b7a4294sm10400966f8f.89.2025.03.31.01.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 01:23:37 -0700 (PDT)
Date: Mon, 31 Mar 2025 11:23:35 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org,
	dhowells@redhat.com, idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com,
	amarkuze@redhat.com, Slava.Dubeyko@ibm.com,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] ceph: fix variable dereferenced before check in
 ceph_umount_begin()
Message-ID: <d6d2f186-3156-41bc-88ef-c18ef8836bdd@stanley.mountain>
References: <20250328183359.1101617-1-slava@dubeyko.com>
 <Z-bt2HBqyVPqA5b-@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-bt2HBqyVPqA5b-@casper.infradead.org>

On Fri, Mar 28, 2025 at 06:43:36PM +0000, Matthew Wilcox wrote:
> On Fri, Mar 28, 2025 at 11:33:59AM -0700, Viacheslav Dubeyko wrote:
> > This patch moves pointer check before the first
> > dereference of the pointer.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Closes: https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_r_202503280852.YDB3pxUY-2Dlkp-40intel.com_&d=DwIBAg&c=BSDicqBQBDjDI9RkVyTcHQ&r=q5bIm4AXMzc8NJu1_RGmnQ2fMWKq4Y4RAkElvUgSs00&m=Ud7uNdqBY_Z7LJ_oI4fwdhvxOYt_5Q58tpkMQgDWhV3199_TCnINFU28Esc0BaAH&s=QOKWZ9HKLyd6XCxW-AUoKiFFg9roId6LOM01202zAk0&e=
> 
> Ooh, that's not good.  Need to figure out a way to defeat the proofpoint
> garbage.

Option 1 for procmail users:
https://github.com/wjshamblin/proofpoint_rewrite

Option 2: Copy the tag from lore.
https://lore.kernel.org/all/?q=ceph_umount_begin

regards,
dan carpenter


