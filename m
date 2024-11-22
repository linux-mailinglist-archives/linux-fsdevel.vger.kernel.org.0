Return-Path: <linux-fsdevel+bounces-35583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40ED49D60AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 15:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED8A31F23D25
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 14:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AFE13A878;
	Fri, 22 Nov 2024 14:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="RrqjeEwX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B0680604
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 14:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732286565; cv=none; b=Nixj7/vq/94/DhaZB30h6fVqn8bXcY3vCm8vpZw/ycgwBtd5YB2uQwlXjYHCWLeIaZYErQCZ97zlVcjpcdiLJmoF65EmCDIGYUMw0Abb1WVxUxDmPi1Z73bl5mjOs3pVkavIJZoenodNY2yr1DczLo+80RNA0Q+bLLDp1l7/qxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732286565; c=relaxed/simple;
	bh=b0iTCPy6drpg8kevhbR6cxPeVxYNs7G9YoxvPN2eTV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4dhU8lE4I6cOkm4PNiIMs3xQW0boZn+W4haHYjoG2JHHiPMhegvISNgEghiKVFqsg+1c/GG1FxIuGK7zTnB7xNXxKq31TCfvFCoLlxnV3SATjcgW6n07kdGF2RVodOQkUEvfqrKdIUewn0z2VIpJsD0BpfPTSRtUR9IQaFOpk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=RrqjeEwX; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4609c96b2e5so14310271cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 06:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1732286563; x=1732891363; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ILW4B8YNhNK76/MDksJ45t1Xa12tM+uwWF5sapI3Ny8=;
        b=RrqjeEwX+A8/5PWv3wUrDljag7Clm1Mo482TJPvSEAL60W5GOem+p5uadAI8tvarXA
         sYT5JDcZtgIukXn58FCIVOKppr3sdjGK/mupcZSkUG2qU6Oc0x0E0mcNaDsafSPcAi51
         kN6vD+cRg11tWQIB/Lef68LBON32xXUpsIqzqcJ/UMOU1yPT5Nx8fwe0xLeagSkzGdTJ
         91v1C9b3Nxef6O6qoU6F3S5mO58531cL+UoeGNjxCiFDGyKcwkrcj/FolAQn29Cb/wrD
         qh5Sq+sK7Jtc4Gw1yrvSgeDHlYGcuKH3Vzm8sF154R0J7V3bQH3yojQcUXrVU4NvJBUJ
         p6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732286563; x=1732891363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILW4B8YNhNK76/MDksJ45t1Xa12tM+uwWF5sapI3Ny8=;
        b=fOFV9UDhTRjsnKrXbQgW4Wj+TouGZ2+K89khrwppY2+KJZvJ8+JUhy5jpf34BKu4TO
         0VnA5E3df0Icq+KOmgebh5FgcIOC9baHUM/iMaJt6086MaZRhkxs2+dIj4GdUmMJtUIp
         5s87ZwIIhiSRse2wCpbiD6sM1vAPRu/VGjhoawg/TvaSJuUp2PHjsFutevyi88hzpwWs
         zIK9lB7of9caD9zBJ50rESvsY8nVigfQ+smli7hx5zNN4fMh+rDHy1ol44BXVcWQNRsr
         FIAaYokRJQnInlTnhTUeKqWM3pXQtrJJAlM6qmjEhkHZaUPqNhvg6DU3IXDn62rBomJ6
         38OQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDV9o0PG29orQUpTdUnBYeoLk/5e/aQNh0JCtMR15k1qlVUmFLdcGUozyxYPmMHhUr5IykhKZhy8H3QYj9@vger.kernel.org
X-Gm-Message-State: AOJu0YxYzGqzQkRO8tEPLoePdzIyKuD/ZZkKPvMt/5lHrMGEvrn4W0zT
	ulItZgTNTRhS7CB0NVW0oVXyjCwPK95WSkyOV79BIQukV2jaity2iA9eEec2cbw=
X-Gm-Gg: ASbGnctfAXeZKjbhkZ2vQYvlE3MXcaO52VgqCCz7KhMmkXU3JZCLXjuzfLBe+MQXu9F
	3ua1RSI6ABVjira5uQY2dd3UFWYsNpn4avs0xMWDBqU1eWUlN2Zv1au7d0olrpPLa2soNPq+4fk
	Ue2pTB3LV5v+HXlRazlu2RR4buJgarrm+dUit9NurLUiPqkOJYIXXWDxp11ntetSag7DqbJDJYV
	bY9Kdz9GVvg3U0GY/nhvONU/PVliL3xaxjSce+y7YFdSR0FF539adYP79d35rY9/jHU34TeQpjX
	R9OiZGw0ey4=
X-Google-Smtp-Source: AGHT+IFLTJHiWbauQYRCC7Mw8DWR2zWOaD3ibvZY4WhtnwjtmARcWdeajjUg8OOSw7ZmIfP4RMN2MQ==
X-Received: by 2002:ad4:5bc4:0:b0:6d4:1a42:8efa with SMTP id 6a1803df08f44-6d450adcb6emr50578166d6.0.1732286562757;
        Fri, 22 Nov 2024 06:42:42 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451a97b5fsm10500106d6.41.2024.11.22.06.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 06:42:41 -0800 (PST)
Date: Fri, 22 Nov 2024 09:42:41 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com,
	willy@infradead.org, shakeel.butt@linux.dev, kernel-team@meta.com
Subject: Re: [PATCH 05/12] fuse: support large folios for folio reads
Message-ID: <20241122144241.GA2001301@perftesting>
References: <20241109001258.2216604-1-joannelkoong@gmail.com>
 <20241109001258.2216604-6-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241109001258.2216604-6-joannelkoong@gmail.com>

On Fri, Nov 08, 2024 at 04:12:51PM -0800, Joanne Koong wrote:
> Add support for folios larger than one page size for folio reads into
> the page cache.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

