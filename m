Return-Path: <linux-fsdevel+bounces-39964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CE0A1A6F2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 16:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCA041608C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 15:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B849D211A1E;
	Thu, 23 Jan 2025 15:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sUKmQvYB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3042A20E039
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 15:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737645841; cv=none; b=LU7reXbBCM4EZ1lhn4tiTaW2s8XdaXmilxJCUrB1XBAfp8+10FnWzOmayC5H/clMXsThWFVPdqDdr10WRvwQ/n9N1XR1UXKsAgtNKFezWzmrtDktkI6xUdmqtEOgVAdKWwHMOLcFEVDYgXqXHVmOPBkT6ZwsDy/I0iV+A47EBos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737645841; c=relaxed/simple;
	bh=c2fNK3tGER3qNhwDbUeHYhv+eMJQEhCNc1fw2ZluoOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kx2ZYKoEPE6OH4jY/YJURTRBkRJE8RUZB4A98vqitJ/+GE0ux36fsqnXwQtCj5W9KPHoBE/hlbS+a5CIWAdUaKOPM1sMm2nDMsuVdw/Dd/eSojKV443tUp+V3goaEXvbX5Xa164vRg9IllUbt/GNIYefTpkpX2hpUsAddhYSK/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sUKmQvYB; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385df53e559so782149f8f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 07:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737645837; x=1738250637; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lIutBhUHADZ4sojJSG6XmgLOEuL0N+K2xm6ISDZdV8U=;
        b=sUKmQvYBOJux0Mbj8l/Ujw0ife6SypvU94Sp9fX8mnrm90GPyCjQevbIYh3Q+ncU8C
         0HXiWpp6rEZZV8TR4B/bqL9TGcUskM7VV1vwHnB2YXmZbQvd66z73S3Zuc22PBhCFRL1
         lsIOirMn4jz6qsViVO5sbvM2gPYU1CpTUWtPvv72c0q/CXSTN9ROGyHDW3tsPyfWmI97
         ees8s5n32M9bTHqi/SNXpLj7DXs5H/KG+R/WsnmbnxjkkG9S94l53XMwVbI6hsRCLbMs
         3kk+VzFswKv+H3QxhkDvktvZe5qsh9auSr/qCt0iIRdCm7CvBYmIxwOEvjwDfU9271Jh
         Uopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737645837; x=1738250637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lIutBhUHADZ4sojJSG6XmgLOEuL0N+K2xm6ISDZdV8U=;
        b=wnaX5kbO6+YwEWzg1MX8LDEMaBoLUuIfuRMEdbxdFgoNVi/6YsnnbfubTu4KRHiUnl
         pveriAiiuyg6dhd/o1Qc5pjxdLUw43v2ZD7Ynmz+rzF+VMvZj04G+9NXGNLPkMWg7hpq
         84gmXoQnwc8AY9a1D9m608LVJFfKI+7WFg0OfcrYq2lqixs+cCuSDF+GCVcMqox9pxfo
         0AfOJz9xEk0GHdJutasUet3WUTI4hHB/IulxAgMrM6cNgyHL9NFFtJ2XJ7yFddjR4bGh
         wEZgwg7ZF95OYoVvOCZPIFsorWnbDjzmZQyLeu6GccUHE52ob1LIkSJ6GwSWQN6smYQb
         5IEA==
X-Gm-Message-State: AOJu0YyaCaAfmGLegZ0GM8iJ4kGunhbNyQrjrPw2ghV1qCKhoJZUiTFK
	BCc6jrYyTtfszAZYZE9GoOyntbYTl0SMuJJ3n7I8vsPYXhwRawkunlVddBztUAg=
X-Gm-Gg: ASbGnctDWcvrWR9NFs6PXp49c+ay5jEHOTNxwRg4QMiB1G8eB3lHEZ4x9s8XwkCa6i8
	8e6sDZ1/sHeB4c06gktCpVBSvfrz+CQCYZHuy7xvpIOgE1czfVdANeWYfOstFz32wSA/nkx4a1e
	bvYPEKBluJ3/N296JriKAxswCJbFa1NSJgiDCV2+0JgrC+eXN5G1OXePmsAM9sFXU8MTSrojT5Q
	DsHpFBDCg3EFGsoSgK0oTmbYfBebYKUCdFreweSezgHOAiA1dFOEOu8Q0CZif+qgvpCRlwWX6M5
	Pq+222Mziw==
X-Google-Smtp-Source: AGHT+IEfHSkeQ9hn2ne/rKPNShSyQF2vspKU2EO4h2TqrwizMJbC0EPcOF0VCB3owJ/zk9qwAlpTxA==
X-Received: by 2002:a5d:5f54:0:b0:385:fa33:29ed with SMTP id ffacd0b85a97d-38bf57d2cc4mr23180088f8f.47.1737645837461;
        Thu, 23 Jan 2025 07:23:57 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf327dd34sm19204578f8f.83.2025.01.23.07.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 07:23:56 -0800 (PST)
Date: Thu, 23 Jan 2025 18:23:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Bernd Schubert <bschubert@ddn.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [bug report] fuse: make args->in_args[0] to be always the header
Message-ID: <91d43019-bdef-4a37-847d-d1fdb5c73e6f@stanley.mountain>
References: <63469478-559b-4bad-9b0f-82b8d094a428@stanley.mountain>
 <4043cf99-7c8d-4790-badd-d3732536c504@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4043cf99-7c8d-4790-badd-d3732536c504@ddn.com>

On Thu, Jan 23, 2025 at 03:38:55PM +0100, Bernd Schubert wrote:
> 
> 
> On 1/23/25 14:34, Dan Carpenter wrote:
> > Hello Bernd Schubert,
> > 
> > Commit e24b7a3b70ae ("fuse: make args->in_args[0] to be always the
> > header") from Jan 20, 2025 (linux-next), leads to the following
> > Smatch static checker warning:
> > 
> > 	fs/fuse/dir.c:596 get_create_ext()
> > 	error: buffer overflow 'args->in_args' 3 <= 3
> > 
> 
> Oh no, right. I just wonder why I don't get the same report
> 

The data is set two functions away from where it's used so you need to
rebuild the cross function database twice.  The cross function database
isn't complicated but it takes hours and hours to build.

smatch_scripts/build_kernel_data.sh

I rebuild my cross function database once a day so eventually the
whole call tree gets built.

regards,
dan carpenter


