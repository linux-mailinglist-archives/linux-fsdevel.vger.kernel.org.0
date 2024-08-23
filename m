Return-Path: <linux-fsdevel+bounces-26983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2216D95D5A9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 21:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A481AB22FBF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 19:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036FE191F8F;
	Fri, 23 Aug 2024 18:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="cJ4gal7G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7587E191F7E
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 18:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724439598; cv=none; b=maTWcv7U41dKvMrFu6fShDa1kP/STsUorQZpx1bJYnTQ96UJEuvOR5+0DMxPKGglAXCz+OhERC2g2X/cqSeMyKje2Z1qskopWCznJjJoQqaQY6bOQaXErAQc3rbWA4G3+sYFfGZ+BkXdm+htP7Jb5z0HogMWSMYWnWhX4ksJVag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724439598; c=relaxed/simple;
	bh=UgAEHb+ebP0qM6znvad7G7LOp4QV1oMYjp0DNy5GyKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CfF4qv5aC2+J05J8xbkMed1Sz7hMkKnc0I1GZW6XMcbHFqrBZXxE1KaNHP/oywrxCm/11vv4K09ZbJOSU5OKGVrHt5waDebAsQX/83Oyj59d8zle2f9DpAs91H+mL+oTtRHpHCG5kx42UE1IizOFUywPJdKHyhh2CWxplvluMZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=cJ4gal7G; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6b59a67ba12so22234677b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 11:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724439595; x=1725044395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wwskh2uEmBGcXGkfO/th/OAK+Lp3JeknT5m2w3ogFCY=;
        b=cJ4gal7G7YOjjMiXH61eAgwWSDnsqDvHhQxpd/V7MRESLl92SoK53S3xFonfAvjgW3
         poxwV3Y2K0s4a3Hc4YkbSA0Z7qMwELS27wqqzlIvusw1aBvxp7yjkUj/sY10f8IjBnDj
         XatDR17a+lk1pMwnZxYboIeLkJXQxWo3CmUZsE17tABgFtrqgNDVpz0bVw/woUS49axp
         NPVEH5LEwLbCjcSZQVtX8d5ec7JkkkHnEHYwzL7Tnl/mxXs2/pcg4Oa3aG3LEalUSOd7
         9Hm3tNdnqDMHNe94ov9I8MBhtLkPQAnXbxcuj+afSMVNPMwqmoM1TJEtUss+TnCLvkf5
         VcBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724439595; x=1725044395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwskh2uEmBGcXGkfO/th/OAK+Lp3JeknT5m2w3ogFCY=;
        b=qr7gOqsfddAJk/hCZujYMrfdHoKeT87XgKPCQt3Sc5R3Bb34QiQlklAzetwoOBwaqQ
         P7dCFVzNEjAmuerkKpsOL5wQYynPq381/OeovSM5IoO0rRnrQF9J+BeSwnSmbDSbuXYG
         d1As0weMha6rdIvf/SSWhFzCC5vgI9Ncr2rNTHKIbB/YTB6z7DSlO6vmjdh43n4JdJrh
         cZkY4CZWicRmHPS5pwLD04T9Uk5hLt3bRnxSXzMAlVdKqjGK28pgxprnSDDUMw02O3sX
         3ahpjzC4Kn7MJqwp78HqaMzUp8DUYHe2X8AgGjzv/ZeQYfz/Mr18O21QsnvIOINGGD1+
         gOwg==
X-Forwarded-Encrypted: i=1; AJvYcCXyaq+1wkmbFzfTru6S+e7n2O8VMpi8z+sMRgVCBarFCV+UDiefhdQhT5eKrej4upJv3Q2LTME1vB2V9+DN@vger.kernel.org
X-Gm-Message-State: AOJu0YzwbelBr2CCrSN4AQwiYaFeOKpJucOls0WiS4SCY8l0znjkk2J4
	Qz9E1TnofZjTirKLV7+gQQT5BWzeOlP4d1Rv17n8PnbL4Qeua2vrlORFwEtKw5g=
X-Google-Smtp-Source: AGHT+IHx8bKGp8hPPGrFgTmfCMzcvDsV2wzPVRUJeUNoxzph7mdGMjYwKxGdAcFBSnnukflYDe+/kw==
X-Received: by 2002:a05:690c:f01:b0:6b1:1c30:7ea1 with SMTP id 00721157ae682-6c62538d722mr38340737b3.8.1724439595304;
        Fri, 23 Aug 2024 11:59:55 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c39a753839sm6386057b3.50.2024.08.23.11.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 11:59:54 -0700 (PDT)
Date: Fri, 23 Aug 2024 14:59:53 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com,
	kernel-team@meta.com
Subject: Re: [PATCH v3 5/9] fuse: move initialization of fuse_file to
 fuse_writepages() instead of in callback
Message-ID: <20240823185953.GA2237731@perftesting>
References: <20240823162730.521499-1-joannelkoong@gmail.com>
 <20240823162730.521499-6-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823162730.521499-6-joannelkoong@gmail.com>

On Fri, Aug 23, 2024 at 09:27:26AM -0700, Joanne Koong wrote:
> Prior to this change, data->ff is checked and if not initialized then
> initialized in the fuse_writepages_fill() callback, which gets called
> for every dirty page in the address space mapping.
> 
> This logic is better placed in the main fuse_writepages() caller where
> data.ff is initialized before walking the dirty pages.
> 
> No functional changes added.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

You remove the out label in the previous patch, and then add it back here, you
can probably merge the previous patch and this patch into one patch and it would
look fine, and reduce the churn a bit.  Thanks,

Josef

