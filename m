Return-Path: <linux-fsdevel+bounces-21930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7E890F35C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 17:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE21F1C20F04
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 15:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6A4156985;
	Wed, 19 Jun 2024 15:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gUNd32TU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84E7150984
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jun 2024 15:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718812129; cv=none; b=CIugEjg0fBpd8jkqjKfUl+YOtuklvdj87JokxU7m81ou8Of6+sn9krNG1Il0oSh6pDW8K9ISdn1cTOJQdtuVYfZk6cdb69UdkIazQRq9lUuy1Ugf9cTrZosIG4jcGa5gEGYZMkkVBOKGhXvcu0YDzS2ONEoA67MCqjZLvIYq34M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718812129; c=relaxed/simple;
	bh=44tfr9Q/yxzd5k0GS5X2bOuf4cl/wNWn1fVz/zaqgb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IxRxKEIDXiira9/J9JCxL2RWtsZhgBIjmNyT/+iIncTM2mFmJU9RXdvKoqdv58fZ8shAFhBrEIUMqCtFA/c4Jh0Z4czfDjReDqWTD9Qu7yIZ8kb/dc7jtr3pB6j58otbYLslnB4DnB7rnUVPhyLxJr3CuL7skK5t1yhCJV0IqUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gUNd32TU; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57d044aa5beso2140168a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jun 2024 08:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718812126; x=1719416926; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8dIFFBUj8uYaau0DmFweJKWuC0Ps3w+y7afUQaxxWc=;
        b=gUNd32TUMs1vPxcXbKaFocojq6B/mAuj7iXzO4b5V9FpOqF9P74fYSjQm8O5sWP1nf
         fFlqgzv2VxoAzu1PxZ8K7+Qh+vFdphYBGXt8XwdrSqYmFOjOGyrMD43aygO3ENicP85z
         fvioXxIT/nXYJl50SzmuVTd2+25ISzbL8cZw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718812126; x=1719416926;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z8dIFFBUj8uYaau0DmFweJKWuC0Ps3w+y7afUQaxxWc=;
        b=PyXbbqj27d8gzy3YC9ajlBSLwuPFZYTtkoLQD2IJE6sRTV7cnDoZ3kfvdOK4OLSR7A
         WMwNSqIszK1C6H1A242TUuVzMUptMjTSW+ebM/9+WjC95q69boKXuYKIqPEWf1WtMtpD
         6ggxXGmiqMxAZOGYhDe2k/tRZINuE/kUC0YvAFmRiX0ANcXo0Tszhwlw5HJWpqdLfhEU
         9WTHMla2IA1eEpBoGyKaoGelX6cf+55UsKfXSvzicdhisXXCuIkbiOU60onjKuJ3F4M1
         GA5XBYboO6euEE40s/Mn8pT27f2/j3IU3xkCMxuyxnBMs1ZRvbg0rWjvGo/kfpUM0a7x
         Rmwg==
X-Forwarded-Encrypted: i=1; AJvYcCVeY30P7uPNxMcF+ULmxE8SK2bKjqH1WsHoUmMKMChms2bvVBGHQRPTDUaaaNJv73dS49K3sZICSIT1a9I89TIBCd1BzfwPsaDcGPFA2g==
X-Gm-Message-State: AOJu0YxNypZDUqUi7GyuRBuGEtjnSk0lm4U+CTLXVlIF0COwbc1wvklx
	Zp2LSehFdBIbG8FGauY04pp7se6Wz0XTV7jU6PDKksm/04aaYegLQQOAIsZXpaiwu8LYKWrGBJW
	pcTU=
X-Google-Smtp-Source: AGHT+IE06bWzVWJYjCEtWaytkah39AvoiMX8sxYOTzxOmOMwCi7fj8nfqZsNPvcaDZcgyMmKp+udoA==
X-Received: by 2002:a50:8d50:0:b0:57c:6e94:a1a9 with SMTP id 4fb4d7f45d1cf-57d07e45773mr1567762a12.17.1718812125903;
        Wed, 19 Jun 2024 08:48:45 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72cdf2bsm8523191a12.17.2024.06.19.08.48.44
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 08:48:45 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a6efae34c83so816024766b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jun 2024 08:48:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVu/O8maMRnS9HJU9Nc9C8NJNCjedSKYAYqxG6Ue/fUFbmTSiLpiZvRaD27gwN8Fq+PciAGNK0zbunnYa8e5Ryj9U3To/soO8aJN9kQIg==
X-Received: by 2002:a17:906:5590:b0:a6f:5562:167 with SMTP id
 a640c23a62f3a-a6fab648adcmr149389966b.38.1718812124564; Wed, 19 Jun 2024
 08:48:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJFLiB+J4mKGDOppp=1moMe2aNqeJhM9F2cD4KPTXoM6nzb5RA@mail.gmail.com>
 <ZRFbIJH47RkQuDid@debian.me> <ZRci1L6qneuZA4mo@casper.infradead.org>
 <91bceeda-7964-2509-a1f1-4a2be49ebc60@redhat.com> <6d3687fd-e11b-4d78-9944-536bb1d731de@redhat.com>
 <ZnLrq4vJnfSNZ0wg@casper.infradead.org>
In-Reply-To: <ZnLrq4vJnfSNZ0wg@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 19 Jun 2024 08:48:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=who82OKiXyTiCG3rUaiicO_OB9prVvZQBzg6GDGhdp+Ew@mail.gmail.com>
Message-ID: <CAHk-=who82OKiXyTiCG3rUaiicO_OB9prVvZQBzg6GDGhdp+Ew@mail.gmail.com>
Subject: Re: Endless calls to xas_split_alloc() due to corrupted xarray entry
To: Matthew Wilcox <willy@infradead.org>
Cc: David Hildenbrand <david@redhat.com>, Gavin Shan <gshan@redhat.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Zhenyu Zhang <zhenyzha@redhat.com>, 
	Linux XFS <linux-xfs@vger.kernel.org>, 
	Linux Filesystems Development <linux-fsdevel@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Shaoqin Huang <shahuang@redhat.com>, 
	Chandan Babu R <chandan.babu@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Jun 2024 at 07:31, Matthew Wilcox <willy@infradead.org> wrote:
>
> Actually, it's 11.  We can't split an order-12 folio because we'd have
> to allocate two levels of radix tree, and I decided that was too much
> work.  Also, I didn't know that ARM used order-13 PMD size at the time.
>
> I think this is the best fix (modulo s/12/11/).

Can we use some more descriptive thing than the magic constant 11 that
is clearly very subtle.

Is it "XA_CHUNK_SHIFT * 2 - 1"

IOW, something like

   #define MAX_XAS_ORDER (XA_CHUNK_SHIFT * 2 - 1)
   #define MAX_PAGECACHE_ORDER min(HPAGE_PMD_ORDER,12)

except for the non-TRANSPARENT_HUGEPAGE case where it currently does

  #define MAX_PAGECACHE_ORDER    8

and I assume that "8" is just "random round value, smaller than 11"?

             Linus

