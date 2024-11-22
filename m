Return-Path: <linux-fsdevel+bounces-35584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 545E29D60AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 15:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC2ECB27584
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 14:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A0A13B5A9;
	Fri, 22 Nov 2024 14:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="AB7z6xZg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4662F69959
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 14:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732286586; cv=none; b=Jf9mO9pmKUHrStyUqICSiQlczdJa5Rzcw17wuPvnqZbb8cNQixTigHhn685JbiA8H6DGvr1ePba9J3agCXs8VCLouZGiTxZQm1zkL4VaC3Vt+Eq3G0Nmkg1F7VXjyzQaypS+zaDfW0NEjNksC17FI8/pwAxIjv4+vVHzLS11698=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732286586; c=relaxed/simple;
	bh=9NP3VVmXTZu+dbjvUVtQKj9rQpcyUl+mGmBnII9S5II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jNJao5JwVvMDo66bmEj0IN+4Uw7lji7e7Isal/DIjveY0ZzdNubQ5U1Rr/Me+IbTPLqCGlGE3/3t1jvtSLAV4sFNlKpQBbaILDbRe9q+plDXVnV31mITndD+AtV4F+LnWFnxWrX2VACOxtA3XqJmJNmeIJD4ai5WjtcVwIVaM7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=AB7z6xZg; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7180e07185bso883719a34.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 06:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1732286583; x=1732891383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DTy1Jg2PRAiFGX3DfSuzLOfdwOHGtfEnGirhJwt3IDg=;
        b=AB7z6xZgFahbAOiwnRBS9jG9JnZhIrNQA/rQZx52RXDq5YJMoDsPRosHzIc/0FzwnY
         QlLRu6/ykB+iketoxVjsmg1fGtO6CY5K6S+IjoiATdMajgAQfpjPawKpPUROjTlSxAMj
         F46Mtk4sD5XSwCEpMeKrQdfzE/0J60vZwnNykD4+Tm19f6Cjuxrdfp24Z9R+/XFke1TV
         csXUTwqfhTwSUXFEBGymTjSJNafsrVIOTZ+hAilwArs7CAEHV0GzvWaxcr4pMHUv7NMl
         sGbmML86Ol4IW7nvE1tFzIeS6LjlLUdAlA3NedqDIRnMdE58bxuWeWLjvtGl1CfeHk6M
         AEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732286583; x=1732891383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTy1Jg2PRAiFGX3DfSuzLOfdwOHGtfEnGirhJwt3IDg=;
        b=sGyWNf8dBxkzWmv4J3knPd4PhTuQ5Imrb3A4U8zT0yFIi8GJ41NYjKOI+YXCnJd56p
         0xMHcUYsgc1K7PsP4NkkqkfRVc1CxlkmkuPGyetEHySfPfwUDvCCuPnw9ZdYk4sF/5wt
         di9q8DxBsgvMzzxEChLCJeBmtPtysWzcCVLsX5jcH+smzKepsrWnkTZq0cRHU9FQ9vje
         okHgQON2UbflgkX8L1H/GaEgqnYcwqoRuOXgFFjZHEPLDneizHYxye+O9LB52wSvf2iw
         zAJsGHbN4AIbp8g1dY+jnw0zW7+LlTY8zyVmFDe47SWSePJungzSHSNi+iaUVj7TgfT/
         sgRw==
X-Forwarded-Encrypted: i=1; AJvYcCUO/96vbxouGGaDcKh5ov23Uw6i1H6almzVZDpjsZwA9IR3GfvARfKAHIq2BH6pDih74YnfE9F51gNKRjjT@vger.kernel.org
X-Gm-Message-State: AOJu0YwAQx1NB0HfA8GqivhioCl/UuuZcHKOqMaLFDtQWcHQ4riO1MEL
	2f330IHzRALLKSJXHNdOyAMgJeTdh7+OaAiZVIuR/HXh8Ki6/zPM+Qbbchwut9Q=
X-Gm-Gg: ASbGncuLG2Miq+b1JRgZ/5GHHv+HrhAJn+O6HoD+IyQ7dR9mGW2Yuuej6B0hz0ETpY4
	KN6jVYdrbs9u5XSQ43+qiirKOjEYIN3k3AStZntdYiWavhE/LQa46LUugrTg6tNT3M3i936u8eY
	KCgNWPZvc36nQR3Z1wqddsecDE1qwgKq2s064qrG3eGOWnxLH22xhe75yKIYdxBT5wZchLNEgOf
	HLwMKgx4GwKnNKFAloNyWMLo3d9emnNmgbx5I8y/SN1sBXwGEwJMOzw7efIoys/sZd3dtI3w2e6
	ZPAqHJhxEMo=
X-Google-Smtp-Source: AGHT+IHn0EocC3qAP21lGMz0/qsLcGUa7AaO/oBZDucWjeImganLR5/kQ8GSqevalErgB7BM4QdrkQ==
X-Received: by 2002:a05:6358:9209:b0:1c3:c45c:f67a with SMTP id e5c5f4694b2df-1ca79727975mr271557755d.13.1732286583359;
        Fri, 22 Nov 2024 06:43:03 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4653c47d18esm12084351cf.57.2024.11.22.06.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 06:43:02 -0800 (PST)
Date: Fri, 22 Nov 2024 09:43:01 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com,
	willy@infradead.org, shakeel.butt@linux.dev, kernel-team@meta.com
Subject: Re: [PATCH 06/12] fuse: support large folios for symlinks
Message-ID: <20241122144301.GB2001301@perftesting>
References: <20241109001258.2216604-1-joannelkoong@gmail.com>
 <20241109001258.2216604-7-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241109001258.2216604-7-joannelkoong@gmail.com>

On Fri, Nov 08, 2024 at 04:12:52PM -0800, Joanne Koong wrote:
> Support large folios for symlinks and change the name from
> fuse_getlink_page() to fuse_getlink_folio().
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

