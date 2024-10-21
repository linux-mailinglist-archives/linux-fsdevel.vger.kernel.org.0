Return-Path: <linux-fsdevel+bounces-32520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB9B9A91B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 23:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FD1FB22E0E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 21:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A0E1E230B;
	Mon, 21 Oct 2024 21:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="CpnQpSrB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DB51FEFD0
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2024 21:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729544404; cv=none; b=gEoQLf5jvZ5wpQo8gXcN2fXHNBqoi+aOcxgmoZBZypxc5lCW16PquFu+bvtj2a105Z4hRGgi3v31QP96Kyuw1MfdQsKkxOLeyXgTB0rM2qaRFV2FvgRPdGY0FImADLlpIcAJQtvF1eDjb3YY0nJnxaS0VNfih12q0maL3bVnPz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729544404; c=relaxed/simple;
	bh=eRTGi9a6Sv3vu+lXJcenWIWVMpv6YjjepcvbeHQpmB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMDgumnHjocbzIa0N0vwkN0ilAMvE6RUVwpDGqMWlbXoET62/KqL1ynmnxvwRaGfoeNHRbBPz+7fhoJKyUs+7yGYx0GKOktgllEgMamoXUwq+RU04Zh53m+MyjiZN15G/RiUX5F5Hlt7lv0owoDFaKOzjsxYzVKYqqIT2b8QO8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=CpnQpSrB; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5ebc0dbc566so829261eaf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2024 14:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1729544401; x=1730149201; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I/JhqoMr3xoBLhKxrDtRkiy+pRopPWWzIczRczK9VzE=;
        b=CpnQpSrBZvj39oY1kRX9EVpwFRQKRBKD7Y8i+OJ0Bju0YcDyrdY1YdM+zS9LOUhJ//
         WmwNNmaMXUh7BI1XPiR9vq94F0tfzPy+xpiJVF816xRGXWWFiaXDlWi8pD3IxPy6zbaN
         Hd/1SdqSU8NQ5rgM85dBDlW9QgPLKmKw6Mbaui5xY+3b2d9cGz9vonLgvZKARtwLgly5
         FDirP+EHjp9EAA85gwV7PLt6baP6YkbCOVODm0L2PJAKzHRRj+vXmq4X9UNkxntvber2
         HxB66bhiV961h/wHLviYDoKveVJDrAyImGPFPxwrJMZWVLSrp74xk2H4iLm+TCbDDIUL
         EmhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729544401; x=1730149201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/JhqoMr3xoBLhKxrDtRkiy+pRopPWWzIczRczK9VzE=;
        b=A946r22iBI2n+Pi8z71XLrzX9KkQjk+p8V5ZHLrol265QGWTkZFnbhCfvL+upz+GoH
         8YdYii5fZK6IVw5mqYpgRwDqszTOI9eNjk4IJuX/Ti7QlGGGGECROLlEErUXZIq01Y78
         bnl37WuUg2ECqNN+OlrMUnLA0oLlRH2pdXQjd7NnBa3xq0U9TXQyZnucnzVQqKFykzgV
         8H8zw/QNr05jCYUg6kd+bv9EmfBVFQCvzbJUnoSrDCC5Z7m8o/2UmCy2oa0NK24vzANw
         XtLZHkbgo41KYDJpyE+BkFU44AFreF9RbkVqKdZJTaulzm9OntChlamKvt2fNwkKtceI
         Nz/Q==
X-Gm-Message-State: AOJu0YwR5s1LojQnGLBLPiLEyAyr5WEtMqaMk7dkCeOXdeVb+lSM/oqj
	Ihw1u8eDDwmpO4WiORT1DobMsourWY7W2HQYKIMeOsPvNZhg03z0HOlR3u3xy5A=
X-Google-Smtp-Source: AGHT+IFpWmh1/AIk7Nn2cnPoq4vVfS0zH3srCfG0HQhaKxBCdKArJ0e8yR3KHsngErh/d7XH6wyH8w==
X-Received: by 2002:a05:6358:63a8:b0:1b8:6074:b53 with SMTP id e5c5f4694b2df-1c39df4e3d7mr490664555d.10.1729544401532;
        Mon, 21 Oct 2024 14:00:01 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b165a5c9bcsm212184385a.82.2024.10.21.14.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 14:00:00 -0700 (PDT)
Date: Mon, 21 Oct 2024 16:59:59 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	linux-kernel@vger.kernel.org, houtao1@huawei.com
Subject: Re: [PATCH] fuse: zero folio correctly in fuse_notify_store()
Message-ID: <20241021205959.GA2689703@perftesting>
References: <20241021125955.2443353-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021125955.2443353-1-houtao@huaweicloud.com>

On Mon, Oct 21, 2024 at 08:59:55PM +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> The third argument of folio_zero_range() should be the length to be
> zeroed, not the total length. Fix it by using folio_zero_segment()
> instead in fuse_notify_store().
> 
> Reported-by: syzbot+65d101735df4bb19d2a3@syzkaller.appspotmail.com
> Fixes: 5d9e1455630d ("fuse: convert fuse_notify_store to use folios")
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Oops, that's my bad, thanks for fixing it Hou!

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

