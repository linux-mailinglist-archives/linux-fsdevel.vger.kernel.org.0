Return-Path: <linux-fsdevel+bounces-35487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E919D5577
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 23:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0923DB22336
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 22:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367271DC1BA;
	Thu, 21 Nov 2024 22:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="XI+HSmAK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DC21CEAB8
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2024 22:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732228110; cv=none; b=KFn5BSlCC8vHIDXsu4GkPqVkNmCcE7P62qcDt5Tp6Ofswk5eyzgMQdbAf7bXbz0rdcZ6+LFXizpV6JRviKmMwf+2qUcCCQvXKT4vYX7J0COpk7Dn0PrzlK1FGEXm49HP6/PI8lE2FTG5tX+ErUnxtN4IRUWALitg245dWsvVH5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732228110; c=relaxed/simple;
	bh=3j2Pwqay2cGjiQyXcz7YEkT4S8UT74CSBmPrFr6UJQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLtb17cf6+PcKww0tCKKcKW4kpyL6r1SHBw3AgjVnnbh4hwtCwdWJ+64KTqLftPw7mY5hlHTe87mWA6OoQJKw7ghti573f8TIKni3I0LyBoX6fyCi6vMcD+vzez/8/F+8hB5MHKYc6LWNiukv2KrduLgQgdkryqzPpkDD3bTNBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=XI+HSmAK; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6eb0c2dda3cso18253677b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2024 14:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1732228108; x=1732832908; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zox/2t8uEzaQBl0xEQAzmL/Et+AmR9I2KXeA+YK0FIE=;
        b=XI+HSmAKAS8g3Vwu/aJs2YMta00VmlG33/tecxz2GPqdafVupiRxMhUnAPFo7IlkwZ
         puLBhIFOA3/FCeaSlsVltgK4wHIoo3SZZrSA6lALHDMSG3nHjo+l9K3Kt+iLegDK858/
         NSpwOLVZPSnJBIL7RNaEvsCUnYKkJCsEfKU4kHhMNhC/4A9RM8wWPOtg+UlX7716gPP3
         Au5H45W1NO+2/rCv+yy5b9QRGTw8SXKhlg8Sx8MvApecJlCeMEV0ZcrORtVREeEW0Q4/
         yTIL0B/7f15wH/3dQZc23NM6VKcEUYWCbg7y1meFSVHbyQSTB8cD+uzjsHJx0BdD9Ow9
         zW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732228108; x=1732832908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zox/2t8uEzaQBl0xEQAzmL/Et+AmR9I2KXeA+YK0FIE=;
        b=AEzFBOaPYrCOIKUqYt/cyNcWqatPYvMn395OGO2oiZQeI/7BbeCO5/e3qHg/0IiAKb
         nG5JWg+Q4ap8mpXOpYCFlUozLAqnp9/riEOASBjBmHUwLdJLzLsLtwC81i2lsMvTSuV9
         wHa+N7FhTHDmeKDJdb7PEcCTsyKDm8XztfN/yWPUj+nLCDPVcEdHXXv3jBwHZUKGnu4p
         i13kjn+LnyX9Ig951TMtaUgH34vOxngSOj+YOq8byDfaZIVhdmjTnWs+6CP+WSPD8tcp
         SpGKvwShSF4tPc5hNbk8EDs1KGCA+7oq8hQnL1a8T8BErYN5QU1fUOAhycX4vw+g4wEg
         jYIg==
X-Forwarded-Encrypted: i=1; AJvYcCUy1kHd6jStUgLn8T9ljIbXy10t3Ys4uAUcLSVhC1R4jhig7OzUBMqPZKVwZRFbAChVwpZc6zKm7bosReSB@vger.kernel.org
X-Gm-Message-State: AOJu0YzhkDln264Nl4J0j7VolJETX3u4VljwoDzB0c7/myPR8NBasgm/
	tMzQ4G8paqdd2N0GE4r3blGVIYPvoYPvhizg0ClxH7bikQrbY9+yratrImx3W18=
X-Gm-Gg: ASbGnct4FHYTiDzNE6y2L4s7GTr4eki3068n6HntSX+8Q32NQWVRTDCZ//ClRP6wyfa
	TAe+datTxfQ+GLDI2ofvT7Osw7/TqQCFmvyxmijkkvDite9BvIoSsckvF07Jiz6uT6wbmlcG0Ay
	MfKUC1H6lbpIoqe8GXO89bsXzjFXnqn5tVr1qqp3nbhP1kGjlZcycujlkM5RLeJJksCKDwyu9FH
	249oleOYngsZiInl9aqkV0aoBv4AZgmxv/t3YN3D5EDQR06fk8e5Cx3LAj3Cqvu43kDSOsPc54b
	a75EaYsXCVw=
X-Google-Smtp-Source: AGHT+IHEm2yajuVRtJomWQGz6rScMG/LDDwCW1maURqdwDJ3+K4Cqz5255UlB6SJAnk0h470BJGQoA==
X-Received: by 2002:a05:690c:6906:b0:6db:d572:aa7d with SMTP id 00721157ae682-6eee09e6706mr10559657b3.19.1732228107756;
        Thu, 21 Nov 2024 14:28:27 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eee0095d56sm1639197b3.101.2024.11.21.14.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 14:28:27 -0800 (PST)
Date: Thu, 21 Nov 2024 17:28:26 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com,
	willy@infradead.org, shakeel.butt@linux.dev, kernel-team@meta.com
Subject: Re: [PATCH 02/12] fuse: support large folios for retrieves
Message-ID: <20241121222826.GC1974911@perftesting>
References: <20241109001258.2216604-1-joannelkoong@gmail.com>
 <20241109001258.2216604-3-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241109001258.2216604-3-joannelkoong@gmail.com>

On Fri, Nov 08, 2024 at 04:12:48PM -0800, Joanne Koong wrote:
> Add support for folios larger than one page size for retrieves.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

