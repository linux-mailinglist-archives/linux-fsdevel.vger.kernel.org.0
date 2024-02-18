Return-Path: <linux-fsdevel+bounces-11964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF01D859A30
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 00:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 653A21F212AA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 23:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDC2745D1;
	Sun, 18 Feb 2024 23:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="If5NomJm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C352AF10
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Feb 2024 23:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708299036; cv=none; b=N83GwyWuoL135VfQgoZQ+Y73ZGItTD0Z0yrDFT7fEs+jvHP90kmDSbUJwoKJzo2KE87D4sEjC6u5eDUL0u2xk0YBIrG2sg6mQKNamQ0xgJhwDMK0KpmtZ4OT9sMiOojO5ZA/nxlW1HU5zxGrDDcpHMoq9KuoIbpOGpHgqmaUiV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708299036; c=relaxed/simple;
	bh=TuVWi+Ehsj9xPISLhs8P01YHD8tA8993uH/4fhapOuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hc1fpnWwUahOkZrGYLyzbiHBHYIRYD7a8yPf0qfIbvNYuXxh5YsdoAVmU55x9xLm955ArbVKfl29YGnLDQTKLDO2sYPi3JLJr4nRQuAY2hNwfhkDxwXclAC8KvRb5PinIfGShGG6HdubKXlXhyua+eM5fjcg/jInk9/7YkA5er4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=If5NomJm; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5cedfc32250so3074465a12.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Feb 2024 15:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1708299034; x=1708903834; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4WH8LTQvKwKieb8zhWVOVP+dVrquGfFVkSlC1ATGzZk=;
        b=If5NomJmvJ1T//Qy27UU6Zc/29UAaXb5BfcbtdL8qf1MezL8ff0eCEhoObT0u8IcfW
         C1rcKGs//yJCzdeFvTdR1zToAYAGQn2BsVGx1P+OioEE45bzfr3N1oLvrckzh4FPZYfR
         dUkKD4k5xggjiSMFWiC4o1S1ICWM5ZCeOAdOZr0dGSGFvXsMCxo70on9o/wuOz7CUNv4
         2S++RZ9zsb0VTd3GzO/sZfEi7aANMckTyQaCpqYSA2Q00CGIp/L58fgydzoHiiRllMMA
         kwprOYkuMdDc+wYfr3nhc6lJQ6HemoGVoADKnIjZ/ZIX/3Qsjn6MaHKfFn1Ehob8Fol0
         kHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708299034; x=1708903834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4WH8LTQvKwKieb8zhWVOVP+dVrquGfFVkSlC1ATGzZk=;
        b=Oy2s2DOwRstyf3cN9z2dOLDcLIm0wn0kvNpwsOlskjpQUgX/6fKIDtER117UfY9gb5
         kjhRgRf9MYtvK3FNm5fHBlUCZN7LbrAJ/XNV3lkYTABO6G0Y9uD4eA0MFLOP4Lo0rYnH
         /nXy5zezb5VuAEf7G/FsbhxpqNTzJglfzapwNpc29JRRxsbDCyNabujWKtGzJxYfO3ZW
         rOAA6Z96+mDS2PcRnHRAdUnGdG3z6KSusr0kpoT8EVwhzLDUO9sElm8mGVe2spCE/1kE
         5f6zXZ9T5FmQWJUQdzUpYlz//14yAqR1c9Mj3DNG7Bbts1tAacxdxh66H3eR8Fo5nTC9
         62vA==
X-Forwarded-Encrypted: i=1; AJvYcCV4AJ7sA3p8r/aXxnIKig31pa6EeJFgxzbxjOfZy4b58y6Pnt3IgzjMiGUSPMKsrxsoLGHSzeT7PKCOmAaFNcbRZatFAYwYHhSKXvxrMQ==
X-Gm-Message-State: AOJu0YwWtYoMbGY3vkybJpQHdal6aTEgtOWPe9EDbW49oN89ok21p1Sm
	EW1dSMWX23/4rRMezhvqFW5YfcYn/bHj+MpBJmewdMf0pvO21iLy18JwtRG5Y1I=
X-Google-Smtp-Source: AGHT+IE1cqk+0d4mXMYCmEGKsEpcy/Mfx41JRPf1UIXJLPObtkL4d/xQS6Q3CT+ceON8NCgFjf6sgA==
X-Received: by 2002:a05:6a00:4b56:b0:6e4:5e48:178e with SMTP id kr22-20020a056a004b5600b006e45e48178emr1758218pfb.21.1708299034112;
        Sun, 18 Feb 2024 15:30:34 -0800 (PST)
Received: from dread.disaster.area (pa49-181-247-196.pa.nsw.optusnet.com.au. [49.181.247.196])
        by smtp.gmail.com with ESMTPSA id p4-20020aa78604000000b006e363ca24dcsm2735011pfn.67.2024.02.18.15.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 15:30:33 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rbqcA-008NTC-07;
	Mon, 19 Feb 2024 10:30:30 +1100
Date: Mon, 19 Feb 2024 10:30:30 +1100
From: Dave Chinner <david@fromorbit.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	djwong@kernel.org, willy@infradead.org, zokeefe@google.com,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
	wangkefeng.wang@huawei.com
Subject: Re: [RFC PATCH v3 07/26] iomap: don't increase i_size if it's not a
 write operation
Message-ID: <ZdKTFp4v1kQuLg9e@dread.disaster.area>
References: <20240127015825.1608160-1-yi.zhang@huaweicloud.com>
 <20240127015825.1608160-8-yi.zhang@huaweicloud.com>
 <ZcsCP4h-ExNOcdD6@infradead.org>
 <74ab3c3e-3daf-5374-75e5-bcb25ffdb527@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74ab3c3e-3daf-5374-75e5-bcb25ffdb527@huaweicloud.com>

On Sat, Feb 17, 2024 at 04:55:51PM +0800, Zhang Yi wrote:
> On 2024/2/13 13:46, Christoph Hellwig wrote:
> > Wouldn't it make more sense to just move the size manipulation to the
> > write-only code?  An untested version of that is below.  With this
> 
> Sorry for the late reply and thanks for your suggestion, The reason why
> I introduced this new helper iomap_write_end_simple() is I don't want to
> open code __iomap_put_folio() in each caller since corresponding to
> iomap_write_begin(), it's the responsibility for iomap_write_end_*() to
> put and unlock folio, so I'd like to keep it in iomap_write_end_*().

Just because we currently put the folio in iomap_write_end_*(), it
doesn't mean we must always do it that way.

> But I don't feel strongly about it, it's also fine by me to just move
> the size manipulation to the write-only code if you think it's better.

I agree with Christoph that it's better to move the i_size update
into iomap_write_iter() than it is to implement a separate write_end
function that does not update the i_size. The iter functions already
do work directly on the folio that iomap_write_begin() returns, so
having them drop the folio when everything is done isn't a huge
deal...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

