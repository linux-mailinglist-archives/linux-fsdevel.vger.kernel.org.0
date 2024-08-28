Return-Path: <linux-fsdevel+bounces-27638-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DD39632DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 22:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D97A2859BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 20:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E4C1B012B;
	Wed, 28 Aug 2024 20:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="A5OPOK3u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA081A76B5
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 20:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724877859; cv=none; b=kqSM5c+SLdCkD/BbzSWshFIgBHcASt5Ij2wXPGubdthVVLA+ElmjfJ3USf67wO/sO3EPIDipMWZyOzQYIbp5Yk7a/cx7/20xqaPk7qsR8re7YnZNck3zUOu0tmv3WL6AZyx2OXds86au0THU3b3HCnyB7VHq4aCV+TcbjbbGvd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724877859; c=relaxed/simple;
	bh=NOTT8tmQkGjOLEJiU0mtzQPp7eM+TLxM5wbO/HWBxA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXwYAlX4Ph1QNJUrZrGF53C228nca8g1RgvJPgFhl9pOLEK5EkiD7iyvoj/z4rzp9F2wKlOskYwm6R4HZjCv+rxjPvi8j63prFfhJ+YO2jIdCqw2nf5Unm/WTqO8ZnWAsvLIybd1WHNcuG2VWIpqJCDP9Wh3Qo6UJWNKYA3SKQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=A5OPOK3u; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a7d7ec7395so198652485a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 13:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724877856; x=1725482656; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TTmq2Kjl3J1CBYIG7oCGRuwVGDfx+TeLm+Z7747lKq0=;
        b=A5OPOK3uWZJji1nYhTVUq6MhrfEFjwx/4OZfTRcOxbAlkTSEuTOY0weXtIrCH+ymCC
         0yEpD87jVynaA4ZkdbkQuc+lc5FPhDasqDjMa8v12rUjxZ8bwZRz/YHrotiN8ZSamAX/
         8wGBsvtpyhlJQho+NnUJosJFXlIl87VRKIilr5+aNnGOrpTr6piFhMJSP0l+vagv7DOq
         0UXyhph7ELab792wF3wrXdTYdtNYvB3YdfO+5S2qcyyV5CydlrXOjBaKJR1UNSVyGgnq
         B8DV4TBrMg497g8XyKoNJLJ9nZsYyLj7IeQelV1fxu1FLDr9I4WgjBCuwg7EhQ1t1S4A
         fKvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724877856; x=1725482656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTmq2Kjl3J1CBYIG7oCGRuwVGDfx+TeLm+Z7747lKq0=;
        b=gpPCIQnRvyW9pI3eupdf+M1X0xtB6PBsBhCXYE1z95293vrC9yksJaFegihDEPKHBF
         JFmCv+Pjx7N/hvK3dP1HKrcVo5D68/zg8C1sEUUAvQ0+j+rNqr4RoyZQg3xx7olf0ZqM
         flCZr2EDvVXvHcdYQMZczSv1tn4AYGR5vA7OABOkQaY+otpKx05wPLd97dZzmgWw/D9w
         D3Ey+VjMTbNeYUr4vyXIIEs2Pf0sH5ZqL3ZjQ+3S8yU27YbayshArwS1O/4HtgUAe3Q0
         5TdSJiOVPq3ImLQSo3WiL1BMLh1Tf+GPSj5M4StCdb5mtoHQWUUvkFbkUA7Nwj/6SyFs
         x3sw==
X-Gm-Message-State: AOJu0Yzgxpl2Gj/i4/7k0nEMpFrnP7I5yGdEZ11bW5Wb8VuCOgbY4cw+
	H/RT4y9eX1LTf94zP6xV8PwNLtHk9fC80p2ywwiduZbUr3gncuXu1iXPBuz7+pg=
X-Google-Smtp-Source: AGHT+IFLbeNbhXPkGYOfWhqGJaAZwCh1ltke2SjMTXGvB0pfIrWn+ukMPp0XnCOt6dd9J9BRi0Sj4Q==
X-Received: by 2002:a05:620a:371b:b0:7a7:f8aa:4837 with SMTP id af79cd13be357-7a8041b53d8mr63206685a.22.1724877856333;
        Wed, 28 Aug 2024 13:44:16 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f34233csm669769485a.35.2024.08.28.13.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:44:15 -0700 (PDT)
Date: Wed, 28 Aug 2024 16:44:14 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	djwong@kernel.org, david@fromorbit.com
Subject: Re: [PATCH v2 0/2] iomap: flush dirty cache over unwritten mappings
 on zero range
Message-ID: <20240828204414.GB2974106@perftesting>
References: <20240828181912.41517-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828181912.41517-1-bfoster@redhat.com>

On Wed, Aug 28, 2024 at 02:19:09PM -0400, Brian Foster wrote:
> Hi all,
> 
> Here's v2 of the iomap zero range flush fixes. No real changes here
> other than a comment update to better explain a subtle corner case. The
> latest version of corresponding test support is posted here [1].
> Thoughts, reviews, flames appreciated.
> 
> Brian
> 

Took me a second to grok what you were doing in the second patch, mostly because
I'm not as familiar with the iomap code, so with that caveat you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

