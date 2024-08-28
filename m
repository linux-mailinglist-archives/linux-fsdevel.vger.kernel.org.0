Return-Path: <linux-fsdevel+bounces-27484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FEE961B9B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 03:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C1E91F247FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 01:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8814437A;
	Wed, 28 Aug 2024 01:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="lF1fxSlR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055D7433C5
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 01:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724809899; cv=none; b=aag8RFDqfADJsh65Z1sdwbkcckwy+uyQbfhMPwrpuC8Qa8LGJi7nbhp4Gu/hFoH4JTUe8btSiDGzRinsfW2lZl8XyBFrE9jPnHh0ojI6iHZxdLkuzmp/7LgLtf8kWhtvDb68fIGqYFw/qvqp8HjWk6jrSghaokHlFpz7T6KkU/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724809899; c=relaxed/simple;
	bh=0IABELUBrCoqtvyj6WsUbNrKASt2xt2Pz8zddR7BCKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LmqQNSDz8uSsnHVF3y3Ykzvy0Z2IJOzTluSWfp4AlNLqkAMbZXtEkaMAKlUXN+U23FXKW/r0GsKrq3Zm98PhhryPVPd5Ma+tvMIOpPFC35igpwCRsUkVnUFBOA9CQHenxU5j5q8zhJpz16/cIE32XSpd8+iZfr7xcLVzJpuzvA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=lF1fxSlR; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-201e52ca0caso43810675ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 18:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1724809897; x=1725414697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dg16HTJIuxUxeZFB6lANrVka5umay8oo1lrEFIAx4zY=;
        b=lF1fxSlRAdBggrgiUQGrvXoDV8ioSygAsejgjplFb7ElTPWHw2IVeKO1ek+mcJ12tM
         MQibssocrX1ce3xT8HXIvEmTBpFV2DGnEs41YU4nx46ne8CilL9Iu5dSD22FEav/i3xM
         QWqcKJCyKQZIldsW/8gutJJJ9mRSg2KIrq8YL9qY3N/tnT35xfA+DKqUN0BIPTr9j7/W
         ta8akICwPFv706MJgHSD7Th3NpJ2bOiQqsOQ+zoPico0UXRBD0KkmqGx0HHWMZ6qlRdp
         rzT3T4n6eFrpIkkmUrJW61MfrII0jnSANI2bztdY+W2D8dT/73gQEdcmFzHRSEkbh4vj
         J7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724809897; x=1725414697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dg16HTJIuxUxeZFB6lANrVka5umay8oo1lrEFIAx4zY=;
        b=RoDquyP5bK1Hw003e069n5ouoCuuXqmHIug7GFQqbecxfPNpygZYi/PomsxNrgAqtp
         +K6wNjGXlj/zDIx3gnrxw3vwNrvJKpuOPpmWvvaLKRQl5R8rJdDQNZNCTqpyQp7YN1a3
         BwpKB1FAhGY9X8T9EhS42vgwg8bj/PoMrxhX8yu786eqZP6e+2otu10Y2VnCGc4wdrt6
         sWcdcMwqCVLrH93yqTRRV/haGsEFHfRdRmdewkZIsdTGvArAznkkwOCLeSxofi1tQQdq
         x9U6BqmAfRn+jEVfqDoiw51cnbpcJ7L/4MRexm1Ykg6p5eliPirvlmzYsDewpur/EkmN
         lWqA==
X-Gm-Message-State: AOJu0Yxc4dt5GLjk/GQueGugfh6X6QAHOPkDoiwmMebvJR4Vyo0vb7tF
	wFH3bTheucwb3x7TCEqbG7Qgov88Rvi6dSD90lNG7u/Py+JUK2uXmSMJwHyYxbs=
X-Google-Smtp-Source: AGHT+IEfC193fqIMIitUEchQXs/RFwmGOV2MQoAepWV6XSF4FBDn4QTFrBw48RFtnUv8ZgSJjFjYHA==
X-Received: by 2002:a17:903:1d1:b0:1fc:6a13:a394 with SMTP id d9443c01a7336-2039e485a29mr173831215ad.23.1724809897040;
        Tue, 27 Aug 2024 18:51:37 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-65.pa.nsw.optusnet.com.au. [49.179.0.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385ae7b1bsm88565145ad.262.2024.08.27.18.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 18:51:36 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sj7qQ-00FCnG-05;
	Wed, 28 Aug 2024 11:51:34 +1000
Date: Wed, 28 Aug 2024 11:51:34 +1000
From: Dave Chinner <david@fromorbit.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 00/10] shrinker debugging, .to_text() report (resend)
Message-ID: <Zs6CpsYtsL4mtoSN@dread.disaster.area>
References: <20240824191020.3170516-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240824191020.3170516-1-kent.overstreet@linux.dev>

On Sat, Aug 24, 2024 at 03:10:07PM -0400, Kent Overstreet wrote:
> recently new OOMs have been cropping up, and reclaim is implicated, so
> I've had to dust off these patches.
> 
> nothing significant has changed since the last time I posted, and they
> have been valuable - Dave, think we can get them in?

You need to describe what this does. What does the output look like?
Where does it go (console, dmesg, etc). When is it called, etc.
Links to previous review threads so people can get back up to speed
on what was discussed last time and determine whether issues raised
were solved. A changelog since the last posting is helpful, too...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

