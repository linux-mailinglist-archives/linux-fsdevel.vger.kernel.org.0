Return-Path: <linux-fsdevel+bounces-18438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A42DA8B8E7E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 18:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 448461F23391
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 16:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CF513ADA;
	Wed,  1 May 2024 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vx6+N4bh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F183234;
	Wed,  1 May 2024 16:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714582197; cv=none; b=Mr8UQK0oHS7Cb4EzdyIsQQVX628Lo+1f+QushIOjIfL7GnBMmh9s1pvj8CVU0b6HdBocOpIfJSjHqkh0o+HHplq4eOJpK1N8BFZ8umJkYXt2gTf+7afIRXwmX6PSEtiW9N2ORGWpUn0JbT5FaA9YAiYD3QQB8b5036n2vGB1d3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714582197; c=relaxed/simple;
	bh=qEQMOBGeajh5F7O3MTnyDC0h9E+JxR1fgloWaLwCiHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+MTLLSM1DzYsBknmAvl+YGQlgTG/4iHVoVYYGdAeYePgK7vNQ6qBSsP2p/7et0q5vaSMTAMErPKAJK/yGP3T63khvpT4Mfs3W6YB6xwbDXPzDvLETAiQEoh/Z5WNpD/Nu+/VbFqkzn81dpCqR1lPqBR4eedtQ4RhbD75ISwyyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vx6+N4bh; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ed04c91c46so6676472b3a.0;
        Wed, 01 May 2024 09:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714582195; x=1715186995; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jaeP7dJuldn1Q7npduL4hZfs1TrHxUU/CG5Z08/gr9Y=;
        b=Vx6+N4bhRHP+tGU6DHWnH+/w4P8DN7NnPlhT0VEaIWXBQ2CHrND0kgD/wanfQt18DI
         8Tm8OPiv8vJE2Q+Z41kvVps68AyDE5PqqxFzv95xxWJrLi76BuUjIQpwg5jn9YQD8WkW
         5KYAN6knAmUzChxtmGo6GKaynugsR5GBY2zAdc3jjYdrhQ4QiRYheo8hblD/nMQO7Lna
         btEGrgO/GVJ9aWWswPYzDYdGKLUp13N2ZbPYOe4FX6U6X/drAeaBnMQsY3GE8qbd0PEA
         ehZ0FAQY3qmCe7wYDnf3h9vn9VffNCvicSmYRF4w6XHL/fJ7R6Sgj2H+u+CFA0WjBuQX
         275Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714582195; x=1715186995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jaeP7dJuldn1Q7npduL4hZfs1TrHxUU/CG5Z08/gr9Y=;
        b=jy8AZIGDzdSrS/UqBkY8H8YJOznIZtv1jEVGIKroeiaLwW4UbHWJK3wTPFUpg67QD6
         KrpAzcq+FEdo7Z3j1lDpLF8yBeZr2qfPRx9TDhpoI5pP3yD1uGSnwj3mbAuByNB+1tkV
         ZlDowC4yJV4Um1+0UeU929ZEhBSCxOOEP5xSLtth8kOyVRGsUx1qhKdjLhUIkaz9p/bw
         05/K9lq5vzrzqTggH8yXhmb7Evx0dFFNZSL65KMaYG7N56f1AKXEPBvS9UFYL5sHRhAH
         tCBqxZC/AvOJ/Ql9YUuFmjmtQp7KAj4bCusWfJLU+zSE5rduIsqJvqHeIcVHdZUgkiGr
         F7cw==
X-Forwarded-Encrypted: i=1; AJvYcCVfaBfLrKDz6Nn+3O4a7CsW7MpZQr7Kkt150J248EOkAV+XmRkh+rHxMeNT8BNvRDmLq+h2tCA49x0giZY18hlU2RGip0gXUinCcF/ivWG/18nuvoX532TnRVq6sDC1c49fp5s0XGG48CtDIA==
X-Gm-Message-State: AOJu0Yxi/wm8/MP5WQSoitI11ixEzoSdNdZFSuMo2c4hlIYWJFB4mjnV
	6zkLY3mRECEaKia/jqu1VTPcAuCxqPJOl6XMTPSeUTtif7mr/C0i
X-Google-Smtp-Source: AGHT+IGeDYT2DJYIbJAa2HO9tmetQM+2yTUtEUc+vob+dYymJ2xDChd7qWmrjrkinux1yJOf1Iyc4w==
X-Received: by 2002:a05:6a20:1013:b0:1a7:a86a:113a with SMTP id gs19-20020a056a20101300b001a7a86a113amr2732660pzc.6.1714582195362;
        Wed, 01 May 2024 09:49:55 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id r23-20020a632057000000b005f41617d80csm22381650pgm.10.2024.05.01.09.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 09:49:55 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 1 May 2024 06:49:53 -1000
From: Tejun Heo <tj@kernel.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: willy@infradead.org, akpm@linux-foundation.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] writeback: add general function domain_dirty_avail
 to calculate dirty and avail of domain
Message-ID: <ZjJysTZO6IOpe4BT@slm.duckdns.org>
References: <20240429034738.138609-1-shikemeng@huaweicloud.com>
 <20240429034738.138609-3-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429034738.138609-3-shikemeng@huaweicloud.com>

Hello,

On Mon, Apr 29, 2024 at 11:47:30AM +0800, Kemeng Shi wrote:
> +/*
> + * Dirty background will ignore pages being written as we're trying to
> + * decide whether to put more under writeback.
> + */
> +static void domain_dirty_avail(struct dirty_throttle_control *dtc, bool bg)

I wonder whether it'd be better if the bool arg is flipped to something like
`bool include_writeback` so that it's clear what the difference is between
the two. Also, do global_domain_dirty_avail() and wb_domain_dirty_avail()
have to be separate functions? They seem trivial enough to include into the
body of domain_dirty_avail(). Are they used directly elsewhere?

> +{
> +	struct dirty_throttle_control *gdtc = mdtc_gdtc(dtc);
> +
> +	if (gdtc)

I know this test is used elsewhere but it isn't the most intuitive. Would it
make sense to add dtc_is_global() (or dtc_is_gdtc()) helper instead?

> +		wb_domain_dirty_avail(dtc, bg);
> +	else
> +		global_domain_dirty_avail(dtc, bg);
> +}

Thanks.

-- 
tejun

