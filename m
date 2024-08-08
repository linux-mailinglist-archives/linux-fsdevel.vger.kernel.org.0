Return-Path: <linux-fsdevel+bounces-25473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4D294C5F6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 22:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 912131C21D33
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 20:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866131553B7;
	Thu,  8 Aug 2024 20:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="GOSpd7XY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41ADB1442E8
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Aug 2024 20:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723150233; cv=none; b=Hym0CjE6gku83CIyQlIFTiNZ5L60IP8r4t4llmRkeU7B84+Zey2ao5YuSpbHcHAahMavi7c5epwO/VFX9v8ZCLXF2cSkuZAkE8uMRkNLzMD2Gcnv3G1Coz+W/YN3O/OI6ZsTsfcQFRND/9ugbarsyjddke3+Mkeul1Gf1Vzxh9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723150233; c=relaxed/simple;
	bh=NF6KyH3UsAmN4LWReHK2pTpLs/p9ZMxJErloaNEhvMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QL5k6IkzKgiLOceFfsWc5z5IoJhbrEAxDE6lWIaA43p6kuV9kq4QD1HT8m2XFEfvt3T1Rfw/pdcacsqDXuc2zC8Ds4CPF9GyzyG4igJ7eVj58xj3yRj7BcE0YGGgHI8af6s0CuXoNo6ashcs5B3Y/piyPLjDhGi9ZA/Ed9eGTiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=GOSpd7XY; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7a1d3959ad5so124347885a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Aug 2024 13:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723150231; x=1723755031; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3NUCc5ybKrwsGXUqn+cVvFn+SP4JHoG5BO1R5KQLL9w=;
        b=GOSpd7XYGrlJki3OTFDSA/jzyoltdbWcQpD9RvTJH67LNweigz3aOLFXdVCu0tRbc8
         EKIOUrRh3T9yH26EFfjFcVMSOjxER0M0HW9DewKgDX4udwAZlS6ztu1In3j3XedNq8EN
         /pm7vU/LfkKctqYhg8LZhPdP1SHxOL8XYpcVnqgpQvMiRGuICco85lTEu1BLuSnRtNpm
         vEJ/rqrC30q8RqQSIlJLp09UyCIhjnWDH1GeVL1426W+N+z9dfKmYH9BzHGTMlaKAtyh
         Qenfz9e19L1zXTHVjIK6AjEGs+qXLDu/fG9rmgadHcz09B7Z+KB77qISYkrWxGmBUUl8
         Dltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723150231; x=1723755031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3NUCc5ybKrwsGXUqn+cVvFn+SP4JHoG5BO1R5KQLL9w=;
        b=Cn9PI1X6Jziamqv3Wf13bYsDQC8ci+ciT22fcQOXsEMOJuRp52fMiZcO9KWYL7GAfm
         UzbkHToh8pBHggvaYd5PX4AcQ3lEIY3d0mHYQxmXsQzfGA+93UErQcCa3Z8ppcsHGK+I
         MuULUqddhI/LldCZJ2TSVkvxYvnrNuDzL/4mky5PfHVKYeiGwU/DHCJ+qMFntfL8AIpB
         NIE747Peck4ghe8ZvQ5x8G0vKTZq1A5Ox5s+eI6mb1tynZ0HCigs8JsuP0WsWxOWRWHx
         ESqYa9uY1aCTrqL/5autYLdIizPC89OgYHzTCiEB6A808iucjH3gceVy7rbNFmHnc46x
         iZVA==
X-Forwarded-Encrypted: i=1; AJvYcCWpB77gAjejOxHsszs40NTQMuSZ1siPid+CTiC4eq6JswZSEMUH3qKmZVgjQRpvTak03EAJLm6mAYdRCmNiDCPU4ia/wSI8LjHj51uAZQ==
X-Gm-Message-State: AOJu0YziDEgL9AmZJT1S4/+EaZl3bSmaxk5iBVj/c4k7v/ORR2MClfu1
	hGTqzlmagW0z+Zc5mXGAHY54XyqN1DZhB8FFey61Lg/QpPkVRDOFLX91P4cxd8U=
X-Google-Smtp-Source: AGHT+IHKOV/4hlpNHk4cod3ihgLc0qmUgInJrNvpD3BPboiZ6KdfQKtlo5lZ6Lpcy0qVyTUvOX70nw==
X-Received: by 2002:a05:620a:bc4:b0:79f:399:332 with SMTP id af79cd13be357-7a38278b535mr496133385a.33.1723150231144;
        Thu, 08 Aug 2024 13:50:31 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3785e56dasm195395185a.43.2024.08.08.13.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 13:50:30 -0700 (PDT)
Date: Thu, 8 Aug 2024 16:50:30 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com,
	laoar.shao@gmail.com, kernel-team@meta.com
Subject: Re: [PATCH v3 2/2] fuse: add default_request_timeout and
 max_request_timeout sysctls
Message-ID: <20240808205030.GB625513@perftesting>
References: <20240808190110.3188039-1-joannelkoong@gmail.com>
 <20240808190110.3188039-3-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808190110.3188039-3-joannelkoong@gmail.com>

On Thu, Aug 08, 2024 at 12:01:10PM -0700, Joanne Koong wrote:
> Introduce two new sysctls, "default_request_timeout" and
> "max_request_timeout". These control timeouts on replies by the
> server to kernel-issued fuse requests.
> 
> "default_request_timeout" sets a timeout if no timeout is specified by
> the fuse server on mount. 0 (default) indicates no timeout should be enforced.
> 
> "max_request_timeout" sets a maximum timeout for fuse requests. If the
> fuse server attempts to set a timeout greater than max_request_timeout,
> the system will default to max_request_timeout. Similarly, if the max
> default timeout is greater than the max request timeout, the system will
> default to the max request timeout. 0 (default) indicates no timeout should
> be enforced.
> 
> $ sysctl -a | grep fuse
> fs.fuse.default_request_timeout = 0
> fs.fuse.max_request_timeout = 0
> 
> $ echo 0x100000000 | sudo tee /proc/sys/fs/fuse/default_request_timeout
> tee: /proc/sys/fs/fuse/default_request_timeout: Invalid argument
> 
> $ echo 0xFFFFFFFF | sudo tee /proc/sys/fs/fuse/default_request_timeout
> 0xFFFFFFFF
> 
> $ sysctl -a | grep fuse
> fs.fuse.default_request_timeout = 4294967295
> fs.fuse.max_request_timeout = 0
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

