Return-Path: <linux-fsdevel+bounces-18443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D35BF8B8EDF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 19:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 897681F21BF3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 17:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E744118654;
	Wed,  1 May 2024 17:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7uclbwB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067D118039;
	Wed,  1 May 2024 17:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714583722; cv=none; b=MK4qGGwkiht5ZViuc/4gDrGl3c9fYDgilKY+dJPst0QXHZ4DLlxJQYgh4NFEOkVQynRedFcukej6VdFlGI+G1aadLTfGBdJNXu3JD4Vp0KFLkhGT28MCS0dakUb1KIUPmDCspAaxVRPlrsZdxOlDrjOfAi8eWbmTEybfC74kKsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714583722; c=relaxed/simple;
	bh=ICW05E2U/Zg2RncpT9jvyC2HtZg9MVgRhGObpqa0WG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gO8ufz/3HUQG65Xi1jdPExkR5+4tQpySiJfY5dCXismU41BlLXPzTRlEZLVV5ytYY1LbzOBMnyR2vgZtA4JRvBh79+IaUEj2cp7N9wQ6n5QKJjwK/MPpozUEcRd/7Yp9VNrRcZVL0+9WHe/Xnc6468CP8qwGjUTg9HL7odjvWLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7uclbwB; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-60c49bdbcd3so2797502a12.0;
        Wed, 01 May 2024 10:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714583720; x=1715188520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y1sTmKUbY7Erj5o9iGRoOkNetvvPf7EoiqrNttYoous=;
        b=Z7uclbwBBVcb+0uAnPoq5m7S2e48YPRtPMOdrAnkyWVT1AMXAZpYhfXsmSqUQuEts5
         ne+ZdHhxRlPYg81UHsBaQEemrKWmaa1QLqCC7H1DyGsKu/eFH8sNtt7aY3uLCYlyioo9
         9Q3E8nvkXvZE+m18azx0Ru6azEmWVR7SKzS6jCGT1GyCIWHxIvUIKk09BfPWRFno2/aB
         6xPrAZApePaZhuXsigZXeRNtCINkXpPTSHrb1ATiT90NGZ6wYXRx9QGZ+WI89c1PiCfD
         ffJVsT6Yrvc3/fwS8ghslk8WhuGi+TOFDtOBLQeKht2O1svyXFsIzz9mUEftTcJYzKLE
         0yTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714583720; x=1715188520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y1sTmKUbY7Erj5o9iGRoOkNetvvPf7EoiqrNttYoous=;
        b=rC7jMKOn/AK3jTeKPWRRg1ntBPBMBJrYs+S7MpQoSRQAhk6cgL3P15SUyo+KSMRq0B
         hgGb+LZunccePLtAtShBCJNwzXyXZKagFO4VOpNCntBAy0N0CC50MBfeqBWNpiDHUimR
         91AFlZkwjL4w4VjM81EVUk5BEVDbTWwhqH2XERMAEY2EUjE4qkNwe7BU4XOg3KIOZHQL
         lb/i8SKHEgfu2udxhlxter5OdGvQ/c3XYh0x/DCGBvggMrto+K2VsfZwXpBhuIt3fyvy
         5NyL2fswQZxN7jTpyZBy25aoQLa0YNvCdx9MDe0KTsYy+yQs7NaeOS8z4XXnl1sd6KML
         cTGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDuObJf4dmmU0tA65lKa8gzUYdY2Ca9MyhvNUN/SryGb+gU8DvvaUk3FIp5jLeUeI1AJt9/+Z9VrcGWwCtwePw/VWhsyRhTwwJfEe1nuhlyLPmrvJAmiBXBS3SSbveWlHTBbU2aTI5XoSGjQ==
X-Gm-Message-State: AOJu0YwWPuOMQNsf+uzPd8Q8tc12UP5w7y0hJkyrEXs5npnqklvGHBY3
	DNw5ttyW8nGrpFhvey3yvPUZOJlzPIW6D0ojdLi0pXDcrynehwMhoLvADHLc
X-Google-Smtp-Source: AGHT+IHToyNU976i2/tu4fzc25QnAIFb7zURgJSBPg02WmcCuaOef8SkHUtdI0ud/W4lwlBRwqzu8w==
X-Received: by 2002:a17:90a:d48b:b0:2a2:1900:493 with SMTP id s11-20020a17090ad48b00b002a219000493mr2783537pju.40.1714583720163;
        Wed, 01 May 2024 10:15:20 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id c20-20020a17090ab29400b002b2927bf5b6sm1592177pjr.16.2024.05.01.10.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 10:15:19 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 1 May 2024 07:15:18 -1000
From: Tejun Heo <tj@kernel.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: willy@infradead.org, akpm@linux-foundation.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/10] writeback: Factor out code of freerun to remove
 repeated code
Message-ID: <ZjJ4pjm9073R-LH0@slm.duckdns.org>
References: <20240429034738.138609-1-shikemeng@huaweicloud.com>
 <20240429034738.138609-7-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429034738.138609-7-shikemeng@huaweicloud.com>

On Mon, Apr 29, 2024 at 11:47:34AM +0800, Kemeng Shi wrote:
> Factor out code of freerun into new helper functions domain_poll_intv and
> domain_dirty_freerun to remove repeated code.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Acked-by: Tejun Heo <tj@kernel.org>

with one nit:

> +/*
> + * Throttle it only when the background writeback cannot
> + * catch-up. This avoids (excessively) small writeouts
> + * when the wb limits are ramping up in case of !strictlimit.
> + *
> + * In strictlimit case make decision based on the wb counters
> + * and limits. Small writeouts when the wb limits are ramping
> + * up are the price we consciously pay for strictlimit-ing.
> + */

Can you please reflow the above to 80col or at least seventy something?

Thanks.

-- 
tejun

