Return-Path: <linux-fsdevel+bounces-22168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94438912F82
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 23:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5027E2834DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 21:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044AE17C220;
	Fri, 21 Jun 2024 21:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PLC/wd+X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF85416D311
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jun 2024 21:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719005163; cv=none; b=lrVpq82IgXRoToxK6C5HTHKuTr8uHSi1DsLz3QcC1s4cT2QqVKYDisZcw33biwM5K20ZCSj4DirTtkdox1v2x/KlNhxs45gdVURl7GDvRI/LzPKWQt7waFlNUobOqplTu7QHcJVlWgTDocGLfaB7lXvyIwUIYWHKJCldY7uRN6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719005163; c=relaxed/simple;
	bh=YDYCA8wJOBA3X8vhr3CVeTIV+J8Ha3LSgJFg76UCzXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cdUMgHmpEEceFsPnWIYTCyo0x+kycIMaozX0Q47ysaBGBIDckRck82owzxfCL1RtXTy3YMLSbtAzmhOv6ZiJcDN6ERXkfNzHnBazGmNarBThBpI+LwIutiuDd4D3FPd9wm25W/YR64f+IKeNP8/D0o1aVFy2dyoyi8z+8TzN+sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PLC/wd+X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719005160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u/T8Pvz9LshbiBtj6Z7y3S1f+nrkLBzQalMGcdL981Y=;
	b=PLC/wd+XLbH4Ji4dplFxzpmJGCvWm9Jyk2/m5vpin4vxADvDZ8w9SMBUQaINRX8gBTROaB
	ZJvhU/4c5Kegu0jlADmWRkdzqwBmbfmjAysNb2xNUTsBKFgNks0l2pgOJwUv9Rr/Vu3F1/
	cO8r4HNnXNmd5d43brW4hKmcDoBnle4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-23eo2rkKMt-RjT7mLINT5w-1; Fri, 21 Jun 2024 17:25:59 -0400
X-MC-Unique: 23eo2rkKMt-RjT7mLINT5w-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-43e2c5354f9so4320301cf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jun 2024 14:25:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719005158; x=1719609958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/T8Pvz9LshbiBtj6Z7y3S1f+nrkLBzQalMGcdL981Y=;
        b=ttBYQkC9tu5AI9JTjVaiO1hVnYHyqkbOkQVF58FIoAvFIrT0vbdiHT/AwrSKp14qtz
         fVARyY1ZcSBg5zESN4YQb/0dbRzs1MwECfGszskdyWPrXgOvj4HXRELLrsfESbQ8sfli
         gDq89Abjx4OGlq6VACB6zJFfrKwwDyZ5MKswZ11mmugkUhPwW+iejEs6zQgRvD0SaL6c
         q9xjqDIuewgqPTfX6XGmjZYs6SQKbeDpFbfvaiWfV3HMycDMiP4x8kh0h8e0GtaWSDKv
         4gYWqZNqqiOUwTKbWYwsQ8Sb9S/nUQx1fXpWLa8A+11mh6DZxIgnGcj1ucbuL5HDE+v/
         TBXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrxrVS+tMo/w9lCtawrxyCsQJlrSxUJ31t1kx3H/v53GpvsVDIK7tLgcCmdOTB6krAVCH+yVq/kg9/oihgFz+8vZ6byCUy9yIoTACqnQ==
X-Gm-Message-State: AOJu0YwwSovlr4jKOtHVcO5GiPb8P9yEOy2kmS6T1NlhKNMuTIyQx7+1
	LWfMwqeXiryMTrQRQxA1PDASqakBwBSQxTQQOEzI9cK/VzmHMMAFL7t96WbHvKRFr+vIFwd1n0C
	N0k2c5kL39zqwRxN0H7gLUMblM2W22j2OAJqJ+/OgPJK48WMa8qkLkRYz2T05OTU=
X-Received: by 2002:a05:6214:529a:b0:6b0:6a38:e01d with SMTP id 6a1803df08f44-6b52fc416dfmr680746d6.0.1719005158443;
        Fri, 21 Jun 2024 14:25:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaMaAMcHEU0045p1ZpCQKXUo66j+A2d+/nXH5cYrtdn67byrEdkgmV5fsdBs5DMdo8eDr18A==
X-Received: by 2002:a05:6214:529a:b0:6b0:6a38:e01d with SMTP id 6a1803df08f44-6b52fc416dfmr680436d6.0.1719005157881;
        Fri, 21 Jun 2024 14:25:57 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ed181fcsm12172526d6.39.2024.06.21.14.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 14:25:57 -0700 (PDT)
Date: Fri, 21 Jun 2024 17:25:54 -0400
From: Peter Xu <peterx@redhat.com>
To: Audra Mitchell <audra@redhat.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	aarcange@redhat.com, akpm@linux-foundation.org,
	rppt@linux.vnet.ibm.com, shli@fb.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, raquini@redhat.com
Subject: Re: [PATCH v2 1/3] Fix userfaultfd_api to return EINVAL as expected
Message-ID: <ZnXv4rsk11KLS1xF@x1n>
References: <20240621181224.3881179-1-audra@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240621181224.3881179-1-audra@redhat.com>

On Fri, Jun 21, 2024 at 02:12:22PM -0400, Audra Mitchell wrote:
> Currently if we request a feature that is not set in the Kernel
> config we fail silently and return all the available features. However,
> the man page indicates we should return an EINVAL.
> 
> We need to fix this issue since we can end up with a Kernel warning
> should a program request the feature UFFD_FEATURE_WP_UNPOPULATED on
> a kernel with the config not set with this feature.
> 
>  [  200.812896] WARNING: CPU: 91 PID: 13634 at mm/memory.c:1660 zap_pte_range+0x43d/0x660
>  [  200.820738] Modules linked in:
>  [  200.869387] CPU: 91 PID: 13634 Comm: userfaultfd Kdump: loaded Not tainted 6.9.0-rc5+ #8
>  [  200.877477] Hardware name: Dell Inc. PowerEdge R6525/0N7YGH, BIOS 2.7.3 03/30/2022
>  [  200.885052] RIP: 0010:zap_pte_range+0x43d/0x660
> 
> Fixes: e06f1e1dd499 ("userfaultfd: wp: enabled write protection in userfaultfd API")
> Signed-off-by: Audra Mitchell <audra@redhat.com>

Please prefix the subject with "mm/uffd:" or "mm/userfault:" if there's a
repost.

Acked-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu


