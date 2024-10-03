Return-Path: <linux-fsdevel+bounces-30904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7851898F4D9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 19:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F4771C21A2B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 17:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FFC1A76B7;
	Thu,  3 Oct 2024 17:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="eQ0ANPeT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C8D1A4F12
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Oct 2024 17:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727975364; cv=none; b=nTwrRo0r65oBWUjD/I3KlAiLecuJZaSrKoVQHcRA029Rw0mF2WA9aRMHEWnM+SU3E8kWsbXbpzZQdWWQlbQ/GHeDZhNvYRXNsVBPmyB7nVo1l5Gb6j0Mr1HIHwmaqA3OMcj3MIoNVVUhGaGWonSVlEJyLErVik84CdKScIgZCoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727975364; c=relaxed/simple;
	bh=veZob2f6f+jF2aoHyYukXoVPX5HhWe0/4HygDAWChU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fACPns2rLnShOYb8V1eGO188v63phUUU1vVoghpxUpv70q5f3HCokJI0+H8nOyEr1HwyDhRDSkATflmQTnigDYJ/khP5KZS9bMVCy/YXHvT31BI3znlWQTm9I+98K1IFT2uSGVofD2OlnD/EH57QfEAME16guaYyZPdv8HecUPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=eQ0ANPeT; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6cb7f5f9fb7so11124166d6.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Oct 2024 10:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1727975362; x=1728580162; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lv6+V5DD1q+EbvJERytZupM7GavIklndcKQm84ak25U=;
        b=eQ0ANPeTYr8J7l35leuTWmevYYkn3K9uaDc2xiHwiHkiLe3SJ+5kibIXt7agq4PFDA
         JQeUfRsW08ZF3ba3BvlcmILg9PRosdgOwcoWZ610B9g29P9PX8fWgVVh9fqSJrT88H/P
         JqNHnzjsVMK8ESNdiSz1gSOgah2yixAcfEi5aXNaUFOBKEKyBJwaFtjtZCoSuHMHpLoY
         dzU2ZZ0ItUGWtzbdHoDRBlvR8C0YHbuhPLB81Is+wNq9pgJ08W/T017eQLZ7VGm3fG8z
         wuUzmqxV6scwPswbdeJUiaSFdUZYanVxkelJwG+RVL3CIF/01tKvZL0HKohFo0pr2syG
         wg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727975362; x=1728580162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lv6+V5DD1q+EbvJERytZupM7GavIklndcKQm84ak25U=;
        b=vJ/pcnrljzaiCcDTZoyI2VNdvPcnvhZNhUEyLhUly0Qt+UKpw2963KSy6ZLf8uHLjJ
         ApIGFTd2IyyrP+itRUZGYNEtLKjIFeyKwPZl6bFT2DRPORUuyerYaSJg+3gqeNi17h1j
         KRWu4uZrN99bwdVTlm9bQauC2Z5tf2ApA1VPJFEryz9SQybtdSa5+WFjwuLVLk4X78FE
         FF8Mg8799xN6pK/xwt4YoDiUYk4DJXr1Iq9+Mn2lK6Y/yEPRNJDCUOsTlT4oNBQ+Dcqd
         8GjkPU8NhO1StcXPJKfFfqTCvlv5ydnF9YHnV9U0SAYwmQWTyfZYJ5TwokVuf1dCAnSd
         dXcA==
X-Forwarded-Encrypted: i=1; AJvYcCWMs0TuyKCBSNKGENjDdgGW7rIr49LZlrkJ6a66Cn6wSK7cAkNvLTah+WQLNCXRSA+D9nOyyIFGr5Jh1FOj@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn7DBLfAWLv+vm4Mt4s+DHtTtp2xpiQ+nZ/salOPtlxhqcCnMv
	gsX4rmx69zCZbEcM3b9dv0QuFYjR6AeNZQLaYCB+V+NAnd1BrVHIxk1/QTxmC7s=
X-Google-Smtp-Source: AGHT+IEkPpCAXCAtA9gfAP3eyJpKVnJ4NiXCYXXWlVAcJ8PH9XCm1z/O2+YTyJX5Rf/ppniNPbZCyg==
X-Received: by 2002:a05:6214:5547:b0:6cb:3d8c:994a with SMTP id 6a1803df08f44-6cb81a955femr111164996d6.32.1727975361783;
        Thu, 03 Oct 2024 10:09:21 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb937f478fsm8082636d6.121.2024.10.03.10.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 10:09:20 -0700 (PDT)
Date: Thu, 3 Oct 2024 13:09:19 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-nilfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 4/6] btrfs: Switch from using the private_2 flag to
 owner_2
Message-ID: <20241003170919.GA1652670@perftesting>
References: <20241002040111.1023018-1-willy@infradead.org>
 <20241002040111.1023018-5-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002040111.1023018-5-willy@infradead.org>

On Wed, Oct 02, 2024 at 05:01:06AM +0100, Matthew Wilcox (Oracle) wrote:
> We are close to removing the private_2 flag, so switch btrfs to using
> owner_2 for its ordered flag.  This is mostly used by buffer head
> filesystems, so btrfs can use it because it doesn't use buffer heads.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

