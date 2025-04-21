Return-Path: <linux-fsdevel+bounces-46776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 248E0A94B04
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 04:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA3B7188EDF1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 02:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BDC2566EC;
	Mon, 21 Apr 2025 02:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXZTgKZs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D30D2905;
	Mon, 21 Apr 2025 02:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745202684; cv=none; b=mqy5tlsSXgf+jJkb6OF64m6e8N1Nn40TDjCP5T7/LGlMmeFv3DVjxs4R0+8A/7cWTYNdgUnLSMrwe9NvZGSooXUnC+qhKrgRnoY11DG0eqafSMSTWDgMRcb1IREoGD44Eu/tLUvWVL6d1YC2sq4rMDvO7J8QA3yeUOIYPHxkngI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745202684; c=relaxed/simple;
	bh=tEaK+Oom7ijrJ8AxlZ52ZDEbivL7nUBLG7vUvGwGyjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d5GlXBg9bxqNuJN9+0HiQzdSH7rbFaKRRdMW6zg3/S4G+kBhYcbZeD2snzIpUB5+++MwB/6SwVnuSMuM7yfoISkwTaTOm1xcQh9cnsdkMMK2C3ATtJ+kCv4HbD09lYdHp/J9oyB2Whe3ZQ1DJ9NgJFJePLXD6wKxSnl0zCQJ12k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXZTgKZs; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac3eb3fdd2eso640408666b.0;
        Sun, 20 Apr 2025 19:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745202681; x=1745807481; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tEaK+Oom7ijrJ8AxlZ52ZDEbivL7nUBLG7vUvGwGyjw=;
        b=dXZTgKZs49Y2tbmlIBZO/yr6xlWZJJwKV6BecM/Jmtj4Aveeum+S6YlGCPa+IESgbA
         8k1r/XjyyHQ00mzT+fSczBL6PT4VJBkLAiq1VOkZCLE3HI7mM5i+i+V8ztBJdpgBWUz2
         0HUDBSJ870iYm9JbMJIqNlw786HJW/SneM6N2W7CoD6Ferp3S1B6uTKL5lQEmIcUaFq5
         rOkZCWz5RDJttxsYFgKHQ/FCB6YB/vF37xfcIoQis3ZaptQrpL2lXZTQ+A8XYqFoP1z5
         Vj4ngX32xTcaPzZpSV6MwBDjbLy05BP/FFLrxXW+u6Fl7mBquS1chjotdnuwjVBhQg+f
         7Aug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745202681; x=1745807481;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tEaK+Oom7ijrJ8AxlZ52ZDEbivL7nUBLG7vUvGwGyjw=;
        b=suHEpXBwLogv5YHH3SWqDmqz5MyEhWZgb9glXJVW3kB0JGV6Ba0DZr/8N9fFQyskjc
         PdD/XPE/x8vtkD5GkEgdtt1m4XsPovhEaiA0KAbMAJaEKsuajgjn64CubYyofdLIGvrG
         iMwbIl2Oeqyt5kzVOCzJM4/Vsz/yyAeO4ciF++yq6//fiTc+dH1XBB8348V1T5y46rt5
         BBVs5VBiMD59spY06dj8OoHlrDSQduK8ogjIL2aeAiuGbLhFBrDMRs1J671rRI9BdIB9
         nHGR9KXd3PBAIm5SD7aNID4ynljCZhrHajRkPWDOPBnvJOh5054TTV6wY+buuoqpr+Vy
         byzA==
X-Forwarded-Encrypted: i=1; AJvYcCUZSK8NtYUMhVBpYmi0fCtpio+UJvye6Dr+rO0sqWUc6qE0lLD6mIELVS/pAXWUQezL3JHJzjNo2A6eTg==@vger.kernel.org, AJvYcCXWHbQUIC1aOQUcFtNSf2E5rjK8ac9amPpsyEGsghgGEygluDi5HUA0I4fnEY0ctlS5gJXdOBYtBv3p@vger.kernel.org, AJvYcCXtpO1Dpzx7mP1IdkHWIqdP8T1zjZLJQNP3VqOJNyfdmG0bGzk4kgRVztE5QGOx1KWfuY2gB9XyRb1jQxrBpg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSxZ2jUA3oSMRyoRh8qGS6GjzsK/2uQLrfc4D9Dx8XmZsZ/20z
	GWqEeLTD1ZploxJIBJXBcvC39QwO5q2UVxetN1Z8+CkGyliSPWysKhUSzB7dB52ikSmq0YnNLpi
	cB+pKOA300vFmKurAaSWdu95kzQ==
X-Gm-Gg: ASbGncsw1PH8j+w6wdaBuCleVl71XFRUIRIVMHfv+npN0oRJLH7znQbXXtiQbXqaIrV
	KmtxeOtEeLFbOGGSpJ5m1XcXVCPGxcxm5uRMg/Tfn9khjwliPXAUP0+WYHbUWWT7j+EjQxmGHd7
	qJcv3dOio+NI/hsJWPOAuo0jB2D9AV85HIwGBYVVrs/WEbTFTAeapA
X-Google-Smtp-Source: AGHT+IFvk3OKeedfObHR+haZPpeL8y9MDwyTIqTlWTgGbpVt44OarajVHfHqt0LQycSpL/yiyPZAhmpl2XzURePHNaU=
X-Received: by 2002:a17:907:da3:b0:ac1:dd6f:f26c with SMTP id
 a640c23a62f3a-acb74db8e8cmr899622366b.46.1745202681153; Sun, 20 Apr 2025
 19:31:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203094322.1809766-1-hch@lst.de> <20250203094322.1809766-2-hch@lst.de>
In-Reply-To: <20250203094322.1809766-2-hch@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Mon, 21 Apr 2025 08:00:43 +0530
X-Gm-Features: ATxdqUGhqh8b93TrZx53x60-M6ftN16MSQWs4BvCu2RxwTrDV5bCDV50pF-D4-g
Message-ID: <CACzX3AtXC0rvjjjbpTwwuNM0nqRz4UpmsL5F11S8oFzS5Le5RA@mail.gmail.com>
Subject: Re: [PATCH 1/7] block: support integrity generation and verification
 from file systems
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, 
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Qu Wenruo <wqu@suse.com>, 
	Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> +EXPORT_SYMBOL_GPL(blk_integrity_generate);

Since this is now exported, it should have a kernel-doc style comment.
Otherwise looks good to me:
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>

