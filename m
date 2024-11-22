Return-Path: <linux-fsdevel+bounces-35592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F71D9D60DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 15:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 274AE1F21430
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 14:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B5213AA4E;
	Fri, 22 Nov 2024 14:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="0RrjnRNM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F3A13CA81
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 14:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732287067; cv=none; b=rfo7Ba1ZfhLpmYgSOfPzRR6uNvCFPsTksuyn9qzU7cgzM4Hfg4FvJy/L7cdn78xfmk28bd4LQgFXSn+iWyONSeOD8t6TxkwZ6ZON6UmFgN0M7WkCZmSvZpxDu5GDtSR8xVJkk11KULFPICwiP2Ybrlmo73BLvQPL/+4OciMLw4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732287067; c=relaxed/simple;
	bh=WzABIpS3YkyaOUPzSSxljR0qRK2qqHtUq3hBCj4M12w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WoEJ+gdhnQ8LU5rxFaQsrOIjRpPul1SDKVhIQhVk4oCrBOT4EVjvGad7euJiRNpODpJJBQjPOlVqarryhUezwou0bt5YUPZTeNpYuVTbayVIQmkj94m+DLYeIjjbdv/V+WBJhKELFybcW3uixBtpiVtsEOGb3/rrZqP+4XZp1LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=0RrjnRNM; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6d41edfac53so14211176d6.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 06:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1732287064; x=1732891864; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ra81TKtE4rjMlBdqZqeoBAv2jzdX/LSTtjmoPaNm28Q=;
        b=0RrjnRNMSI1hRr/X8fa4mhDUvZfcYFC8oTG48zWL8GZtEgeGhMe5j1OGoFYT5VFiH6
         IDdsX+h83CEJo9P8t+9/3bcj++YP3BHusyOqhJ8kLjR9va1aif6sxmCu+WdwHSfcti68
         jLSFl0BoLvF4Xws4OwnKB9umjIP95EC1griM32sWmmOWH34NOqoJVLxiQn2Fbxmh2CVj
         qi7nqG5SaWwjRPb6Fd8Lk3sase6a+oIrPo8EPJKNPeU06hj2N0bf7U4SydTziQ8DGrFe
         GHT5B+u5P08Ur0Ym5mfkEYY1UIploUBxjtssHIFb+OuxNs4gFAQxOTFPAzCJFQMN8jJY
         /xkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732287064; x=1732891864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ra81TKtE4rjMlBdqZqeoBAv2jzdX/LSTtjmoPaNm28Q=;
        b=ctrKW6d+iJRXme0jkDRGzWrjYnYXp3Znunzg9OODkgw2TDPyWYuvHL6CGQ96oAR6eK
         /b77YVn/MCbgEMg9q8+qYg7ua0obZKFsgxQdtSF9XeMEQzYgR+sGHN0FrLT5b+Z/w+mJ
         wqin5zOdZ1SzPm7P4bJPfPYjKyu34rTz8SIW2s8Y4V3v2sUMmNgwj1inhLQ3RXfYyi67
         UTQo+V6w/tNh9xLrDKoRNRhq5b1xodQlcta/jkO2V/TWp3KRg6edVY9SwZaYGmo9uW0k
         I2NJTti2LShQeY4WvHo1hadN0CtyTuhV1QGtcVhcOiGf2ax9ptesjP8FDb7VaOF1OkZY
         zZhA==
X-Forwarded-Encrypted: i=1; AJvYcCWwkFz34UfJQ98pgcC2eO1BE8zm4RstBrpj/qGFlDL3x/sec6f4vA5hYdcqHjrUYZtTDM+QHErjNiZBvdRE@vger.kernel.org
X-Gm-Message-State: AOJu0YzUUb4lTOuz6zQcg19+fRIKasYBWnrbzYYEdqyrciUj3xA16dRC
	etXGOshYOKW8ep7B6POpJzuj0WruSwmg8Z97BGN0oUll5QSM3NpcFMVz2hi+4U2WYFv1vJbSZdK
	I
X-Gm-Gg: ASbGncs07czQeNMoHy9flVtJW+gwmbkLieohvVffV1eU4b8QmREvqie7lFAAjc+e+ie
	n45kDIbmoEOwnbGIl+VAsj/K3IhbRX0jxXLmk4+XinDzsC0ryXHz+sEra6emzJYfQsr6S9onKQ8
	QHQ2PFVRjs8EI6eWMP2/PshonPsPsRS7QVXM+qg0j5G8R84I/bxdCBtrCuNZyrrI3YBk0Nvx6U5
	OCHjVu1xZ1TNkGOJzI8O+VHNgLB+0Fiu3JNHvE7ClFe4ghLt1HtVZlIrer9WdfjDonslDkrqOC1
	rpcWL6lLzAg=
X-Google-Smtp-Source: AGHT+IHq/eJ7ZK2G3QwTUf8hYrpMJPqzosu1Shbxyw9noT51dkkB3QitU0Adzac2gcMgStEq8lQvIw==
X-Received: by 2002:ad4:5d67:0:b0:6d1:7433:3670 with SMTP id 6a1803df08f44-6d450e8332dmr46165686d6.4.1732287064151;
        Fri, 22 Nov 2024 06:51:04 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451b23e3dsm10480586d6.76.2024.11.22.06.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 06:51:03 -0800 (PST)
Date: Fri, 22 Nov 2024 09:51:02 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com,
	willy@infradead.org, shakeel.butt@linux.dev, kernel-team@meta.com
Subject: Re: [PATCH 12/12] fuse: enable large folios
Message-ID: <20241122145102.GH2001301@perftesting>
References: <20241109001258.2216604-1-joannelkoong@gmail.com>
 <20241109001258.2216604-13-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241109001258.2216604-13-joannelkoong@gmail.com>

On Fri, Nov 08, 2024 at 04:12:58PM -0800, Joanne Koong wrote:
> Enable folios larger than one page size.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

