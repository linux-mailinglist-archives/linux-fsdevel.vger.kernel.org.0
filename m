Return-Path: <linux-fsdevel+bounces-47306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F10A9BA1A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 23:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 185431BA52FA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 21:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68EC27CB0D;
	Thu, 24 Apr 2025 21:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DZzsXQ3I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA1F4438B
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 21:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745531146; cv=none; b=ua49C1NwQijQWr5DsKFlY6wyVgLRHCnHfmFPmO+fXo6GNc9TserN+NHga5ZPyds6XT9Ye89rZV4Qg2RCpQEJSTrfiRCelsUNALCRDcNl4N5iBNAStXqWyQZ2qX2yyk93ALaJX+1oP9imHhM8fSAoZVU6BqZen6uPSYE6Qx0w01Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745531146; c=relaxed/simple;
	bh=MY96iHf08c1cTSa2cmf/zfh7+5n8dQ2ggXrhOiqdE1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdjtOqe52qzQopAHqWqkH/a3Jf4bbr6A6tuyZOYI15Gpyqec9WvIfLzQxAxO/ArSI9gG83mVBmDIuqkhNISKnwis+3GLvoHuGGx1FHbIiahjBznI+kDTgIRKXogk6wnwP6VwPEyh9cUFZX0VzXk3ItDNFUyYfraJ0TlrOX2Ek9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DZzsXQ3I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745531143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aYwLoKnMKoWSEqiIqU5arhOmzuZTtbWGDUsBWXG25uI=;
	b=DZzsXQ3IWx+vu/rV2ZDRpZFXQ2c4xCmuZkXFbDDwuxtYCLmBKXtsBwW1UQAFOJx1RcWSHw
	36fIC+J+88uSF9B4xTvPg+jlxKZS3axrNmjlq5Suzjwxks4dZtYPVEaYEE0Yc3bXsFqdsb
	wkuxfIWvY28VJfDxuCFUKIH/N8rKQwo=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-qiYzE2n8PviLvE93F6elGw-1; Thu, 24 Apr 2025 17:45:41 -0400
X-MC-Unique: qiYzE2n8PviLvE93F6elGw-1
X-Mimecast-MFC-AGG-ID: qiYzE2n8PviLvE93F6elGw_1745531141
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6eeffdba0e2so29895286d6.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 14:45:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745531141; x=1746135941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aYwLoKnMKoWSEqiIqU5arhOmzuZTtbWGDUsBWXG25uI=;
        b=A7pSfO9MRUQ/1G+HgJWos5D39T+OvJZFgd1378BXa6jxGaZd1PTvv5ZBykIwltoE1Q
         xs8zFaH895vetIIpGq1KIz148RmYROGx2fjnvq3Q2uiM3zM9cszh+Zyg8MDtmfNdrHRJ
         kR8uvfCNfw8aS+zVRov6kXTb/hV60ZeQISBTiBpWKLNXqNbEzy9NB6g80SDaCG/0eouV
         HoXEqUHzpbc6TcdJ0gtLY5b6gzFSt6BvDURCl59bqmcjum2RtdXiwTBmxurtE7U54ALs
         0xE54AQIUsCmws4JpzL/NNi/kIQM8leAo8uOJk7LxWbIzRw55hA2ljHndCgyLa1Rn9GZ
         3fZw==
X-Forwarded-Encrypted: i=1; AJvYcCXwFP+CeAVeluoe6V00csGYaj7Tgh2U4ZjgFjhtMKWTsflSNEjI5AvMQd2jgNXZcM4fn7kVQzU3fWtD3x+a@vger.kernel.org
X-Gm-Message-State: AOJu0YwYYoYY1xlyjGaR5gT3lbSznijbrqGV4AacR/XDzXxOpwakOkP2
	Uh6gpMsyvJNgEbXnGTjcKJhmV0w7LQswiQVSjtWpCdANlugl2mqSqe0HMovZxTx6RQ7cmLMT//m
	vS7Or6Ds8YyeUK9jngmUFLXJRmoEyk69qmOljMhNmxe1sR/C7MMHW/O6ItM11Vps=
X-Gm-Gg: ASbGncu5xo7rRoem4uSHus62rccE91i6dS2IfYRLKp2/XH/tLx+0q3hZK/AiDbJug6I
	9gthFj21KQfwKRqJu+8+iAQtcX+nSvzSsLb2P+U0yDl79jiavrLLYSKkwwIidvh6rNHnODasgPV
	ijR+RzC2A0V3aHAuDId7eqa43rva037jRcpYzFQwiLJQAgaLqdewjF4sY+TmsoxKhtzok75kjOK
	PjeMLLx2NIm4LBr47Rha/SPePsJDX3nVW113HmLyFI+1B6gQ6Ot8jmXrz3/ZJ9sIr5AJTzd2WXO
	zKs=
X-Received: by 2002:a05:6214:d06:b0:6f0:e2d4:5936 with SMTP id 6a1803df08f44-6f4cb9e51b5mr1010616d6.22.1745531141352;
        Thu, 24 Apr 2025 14:45:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmWJQRNoeRYiwWhaf29I2g4K6mBLzf4Gyinz6SrGVsyt1zGLLxKhI16GxMUwLvAlbE6TQkXw==
X-Received: by 2002:a05:6214:d06:b0:6f0:e2d4:5936 with SMTP id 6a1803df08f44-6f4cb9e51b5mr1010306d6.22.1745531141091;
        Thu, 24 Apr 2025 14:45:41 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4c0933f01sm14461846d6.28.2025.04.24.14.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 14:45:40 -0700 (PDT)
Date: Thu, 24 Apr 2025 17:45:37 -0400
From: Peter Xu <peterx@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH] mm/userfaultfd: prevent busy looping for tasks with
 signals pending
Message-ID: <aAqxAX2PimC2uZds@x1.local>
References: <27c3a7f5-aad8-4f2a-a66e-ff5ae98f31eb@kernel.dk>
 <20250424140344.GA840@cmpxchg.org>
 <aAqCXfPirHqWMlb4@x1.local>
 <aAqUCK6V1I08cPpj@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aAqUCK6V1I08cPpj@casper.infradead.org>

On Thu, Apr 24, 2025 at 08:42:00PM +0100, Matthew Wilcox wrote:
> On Thu, Apr 24, 2025 at 02:26:37PM -0400, Peter Xu wrote:
> > Secondly, userfaultfd is indeed the only consumer of
> > FAULT_FLAG_INTERRUPTIBLE but not necessary always in the future.  While
> > this patch resolves it for userfaultfd, it might get caught again later if
> > something else in the kernel starts to respects the _INTERRUPTIBLE flag
> > request.  For example, __folio_lock_or_retry() ignores that flag so far,
> > but logically it should obey too (with a folio_wait_locked_interruptible)..
> 
> No.  Hell, no.  We don't want non-fatal signals being able to interrupt
> that.  There's a reason we introduced killable as a concept in the first
> place.

Not really proposing that as I don't have a use caes.  Just curious, could
you explain a bit why having it interruptible is against the killable
concept if (IIUC) it is still killable?

Thanks,

-- 
Peter Xu


