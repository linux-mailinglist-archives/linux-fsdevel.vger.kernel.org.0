Return-Path: <linux-fsdevel+bounces-53100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E007CAEA21B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 17:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89A693B0411
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 15:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07FB2EE285;
	Thu, 26 Jun 2025 15:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dMb1yLMn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EFC2EE27F
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jun 2025 15:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750950002; cv=none; b=RpwyM6pj0hhjLpKVNTYOoxsxKtY2nf8L+3oqmDY4wzo72gLO8VSIZvXYF8xqGsKpj/WZl4bbbhy/2fzMuHkGOkDpTrmQSACuaP3/LeTYHvneqoMAnUMrISwU71sQX4RxlIOzZy5RiqDVNDOJySmMJqqLvA90owDpmkKXYcAAR6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750950002; c=relaxed/simple;
	bh=Rd9MfG2wYsIuZWNKGti3XIqY5TapE2MeUv/fqmZbSYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dsk0yfwqHnERoajT+YUKaeLYJa3MwvqkuXXsha2awdeZU9eCSSffcY4YB/7QJMAA2s63V9U6ADfH57TKAPWqEZcGTxHrO3N2HKs9M8kEh7ueulmzmF0ctC+tMCDIg4NbCBw+4/3W1WuRmBSPFDSJH2xXHS1ze91tcN2Pq2RD528=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dMb1yLMn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750949999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=66pjXQOOoZM9w58+iyhucNXBgUjwx6ikLbfG097QrC4=;
	b=dMb1yLMncHwG5X1rxETKMdqR9IqZcwxwctxC7PH8FyR90q/O1hbZANo0E+SkaK3rYHpzHj
	nWfSu79V661MN6F14LmaKQG4FLUD7WKR8b4d0OKGRXoLQ/q5tw8NaNMUw2XRu87Cr1LEjS
	EY2F9ufBG3MqXfNyAwnGKaGrxcmxnJw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-fbhBcBdCOzyllV8hGXuHNg-1; Thu, 26 Jun 2025 10:59:57 -0400
X-MC-Unique: fbhBcBdCOzyllV8hGXuHNg-1
X-Mimecast-MFC-AGG-ID: fbhBcBdCOzyllV8hGXuHNg_1750949997
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4538e8c79d9so443485e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jun 2025 07:59:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750949997; x=1751554797;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=66pjXQOOoZM9w58+iyhucNXBgUjwx6ikLbfG097QrC4=;
        b=POpcaEWzIsAkmqq8cRde2k5PPiI+0oT6/+d9Lki8MA8WheVAUo7h/jF3uDbiyIcUmO
         SNffKWGV5xkWP05uR5J/z6Ooevq0943a0Vodnc8lEqrn0hJowhqpuW/uLUnpEn2lZvNB
         h+8jjgxDIYzW0qBznKfxfK1kHX0X6vHm10GepNomvS1lc1c1sdvO7fxq9EVefRIPOq4R
         1Pl/kpP2PzK8rJj/QMGN1QX1HVZvCqsVlmgRkj1tENV+35LtMXmGYMxNU9hjyKo9vNQK
         dhgFJUXbWqOpX/yJndGNLFQGQhRnzoCIUiYo1DTNd2mysPc352PmUmL38VRzaoGA7Ytj
         ylfw==
X-Gm-Message-State: AOJu0YzvB3uGlzSgH7Z0dNKUJgJoIT5eqg1j1xirgtr7iMv9XAmR9thh
	RWVbRhMmStRdzyjjYi3n1kZvn9ui6yAEwZVYR07fwCvBbjZIYL/hISB8SXHmw3+l8IBgTR11IlJ
	dMynUGR6zvIDodMN/9CGW+/8hO/1PTkprc/QAXdtzhdo4kUDvtuP76Alp0nMwTLxw9CbxXhls1k
	s=
X-Gm-Gg: ASbGnctVwAe49llOISdMx3Rn9OdRWwY8Vecr7kxEFyPyon0iqm6oo8O66dam8Uuqi1V
	unHpUWJcONuqNZP4bsiX55/nQ15UakcZ8QiJ08IaUV/NBdmvF9XlpNq+3yCdUTcE/pRtjJOes/D
	v7sjeUKDVclIDtGEsAq7jfoYbeIzMNLKIAVjYRaaMKRLhC2E7IiatKzApMjHUweRhOb6uvHS4+z
	SW0MJ3octLsH2dYLnYgYOtsHZVZh7ayFkT8RiVzscE6zQKVd4aax3HH8cXx0ekMWA8Si++1bojp
	Ms7JeCkP/EytQQJ7H/dQrBB1Xnrs+JsxQqr3IN6fmwlr7/9Zq4TOD73bKhYXIRRuLTZwBG4Lxda
	MnHKUOA==
X-Received: by 2002:a05:600c:3e86:b0:43c:ed61:2c26 with SMTP id 5b1f17b1804b1-4538ea96e0dmr203705e9.17.1750949996525;
        Thu, 26 Jun 2025 07:59:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZrdudCYO4vZ84TfNYGyCpPy5SlZtMrr64Qy5kZRI78irHoQkU46UWTcPsRtqX+quq7nWPLg==
X-Received: by 2002:a05:600c:3e86:b0:43c:ed61:2c26 with SMTP id 5b1f17b1804b1-4538ea96e0dmr203335e9.17.1750949996055;
        Thu, 26 Jun 2025 07:59:56 -0700 (PDT)
Received: from [192.168.1.167] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7fab6esm137284f8f.31.2025.06.26.07.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 07:59:55 -0700 (PDT)
Message-ID: <07ef2fd5-d4cb-4fc3-8917-4bd6f06501d0@redhat.com>
Date: Thu, 26 Jun 2025 15:59:54 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: refactor the iomap writeback code v2
To: Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
 Andreas Gruenbacher <agruenba@redhat.com>
References: <20250617105514.3393938-1-hch@lst.de>
Content-Language: en-US
From: Andrew Price <anprice@redhat.com>
In-Reply-To: <20250617105514.3393938-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/06/2025 11:54, Christoph Hellwig wrote:
> Hi all,
> 
> this is an alternative approach to the writeback part of the
> "fuse: use iomap for buffered writes + writeback" series from Joanne.
> It doesn't try to make the code build without CONFIG_BLOCK yet.
> 
> The big difference compared to Joanne's version is that I hope the
> split between the generic and ioend/bio based writeback code is a bit
> cleaner here.  We have two methods that define the split between the
> generic writeback code, and the implemementation of it, and all knowledge
> of ioends and bios now sits below that layer.
> 
> This version passes basic testing on xfs, and gets as far as mainline
> for gfs2 (crashes in generic/361).

I can't get generic/361 to crash per se, but it does fail as it detects the new warning about the missing ->migrate_folio for the gfs2_{rgrp,meta}_aops, which I'm looking at now.

If you have different results to this, please let me know more about the crash and your test environment.

Thanks,
Andy

> 
> Changes since v1:
>   - fix iomap reuse in block/zonefs/gfs2
>   - catch too large return value from ->writeback_range
>   - mention the correct file name in a commit log
>   - add patches for folio laundering
>   - add patches for read/modify write in the generic write helpers
> 
> Diffstat:
>   Documentation/filesystems/iomap/design.rst     |    3
>   Documentation/filesystems/iomap/operations.rst |   51 --
>   block/fops.c                                   |   37 +-
>   fs/gfs2/aops.c                                 |    8
>   fs/gfs2/bmap.c                                 |   48 +-
>   fs/gfs2/bmap.h                                 |    1
>   fs/gfs2/file.c                                 |    3
>   fs/iomap/buffered-io.c                         |  438 ++++++-------------------
>   fs/iomap/internal.h                            |    1
>   fs/iomap/ioend.c                               |  220 ++++++++++++
>   fs/iomap/trace.h                               |    2
>   fs/xfs/xfs_aops.c                              |  238 +++++++------
>   fs/xfs/xfs_file.c                              |    6
>   fs/xfs/xfs_iomap.c                             |   12
>   fs/xfs/xfs_iomap.h                             |    1
>   fs/xfs/xfs_reflink.c                           |    3
>   fs/zonefs/file.c                               |   40 +-
>   include/linux/iomap.h                          |   81 ++--
>   18 files changed, 630 insertions(+), 563 deletions(-)
> 


