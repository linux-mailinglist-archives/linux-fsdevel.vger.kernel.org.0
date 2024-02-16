Return-Path: <linux-fsdevel+bounces-11860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 348B1858246
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 17:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6BCE1F25145
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 16:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27AD12FB3C;
	Fri, 16 Feb 2024 16:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GvrH7GrH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5EF12FB05
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Feb 2024 16:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708100332; cv=none; b=d8SzqWDXq02PpY0gs6/vmceVJLpah0I0IVNMXer/XQqqzKbBbw62mtXiIl27SEq8zuk5h0MscwOukTvI5XFPToJclHcr7mWNhF5kgZCzlwAVa1glPNQr9AcmFeVDttktCb4HbLCjMbJCKnxUOW5tX+24gijqBzR11DOV5Xy35iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708100332; c=relaxed/simple;
	bh=oAIAF9jWPO0acrS2NbTV0zUQvpgImhp11qMZffcY4E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDP7BBoobeuwxXt6RwkcQK3WFXsG6gJLDm33fCDf7kKKyDz9o2ZesARENjyFDfTLU9Q+UpjVpAmzz9mi2IsLaVtm+9ZGrHBRbjfrYgP+rLXs2AB7pUKhTR5PAs6g+6Qi3WUC+HqzAZLn9O3i95D8V5qZ29Ji2HLcYDlZvCCSAL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GvrH7GrH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708100326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A2YIpXUrLBVFDjCdRtbxFdnmZBsfcrvCwPfrXnzyGhY=;
	b=GvrH7GrHimgsGw1gdGTgOsy57/zrh+bDrUBkohCQT4s+26P6b+3XXidvKRTMndfuh9pKBi
	qSE0TcOL6A9Mx5/2fXFU6EqDcGmZroe2yUBNzPF15DCG60Wn9VXx53gd/zgTH/u6p2CB+q
	TmNq0AQO95LJSLmvD+x+Izt7NDqbJd4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-Hk1fEu__Np2K-XmUqS3UXw-1; Fri, 16 Feb 2024 11:18:44 -0500
X-MC-Unique: Hk1fEu__Np2K-XmUqS3UXw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33cf6266c82so533127f8f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Feb 2024 08:18:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708100323; x=1708705123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2YIpXUrLBVFDjCdRtbxFdnmZBsfcrvCwPfrXnzyGhY=;
        b=L14rOuPvq+0jBZdOM+oTjKWJI5kvHNuOMPCi8Y+Tud5MoX6ER5XyzjzoGvXkuR6dP/
         /6VCDcNY4xeyUTm3yF3TUlEflhb/DBXZb+pd02Hrod+0z8T+nRIIUoWUoJKfy4phshty
         qgePpi1zQttnokkE28mdQxLNzQ7OXUMmDTytfrnnvIGt7ZMG8cRpDkDzHDTkr3yk+nX9
         hIPnCkUnIiMbVmKoR4JS7UXZr1Sd9PHCgSGSn+NjKiLhSPfRbk+eHlI7+b9UWoWoH1s7
         kvVJbiYbOQaM9OP2uocEEIPwxPNqwnOiD0ULb5NNPJMg3gKxrlTURu3mw8EybrWu79P6
         nUKg==
X-Forwarded-Encrypted: i=1; AJvYcCX6nqWENp9KdmBkzTJRaiYuct09CUDPSDjEgbG717xwacPNIPYPQoAiss/4A3z2oH63e05kKiR9IFB+OJnnDKHZVOJchqBM305woH4FZw==
X-Gm-Message-State: AOJu0Yz7wknDBgCWOzXko3u7uYKnm5jb1rsna8R7HqD5T8Q8o28IQRTM
	LvClT/qTwhKZ3RK+PacK+cLDyFh7JoH74PWS6LD8bc+fdSko3sggSsfJgfoR69+noOoPbxMikvG
	HiUsKR1kl+LN7yqL8n7MYRbyXjp5L16aHBpwoWJcRvhYWEmWwXzOBEU9gljZLnA==
X-Received: by 2002:a5d:598e:0:b0:33d:f35:d2b0 with SMTP id n14-20020a5d598e000000b0033d0f35d2b0mr4485883wri.60.1708100323276;
        Fri, 16 Feb 2024 08:18:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG24xD/qEQngS320sUxhv3KFD9tZJkUH2ncwvgXi9rTVBThj3r4tNaTBSA4BLAcsH8YxzEfbg==
X-Received: by 2002:a5d:598e:0:b0:33d:f35:d2b0 with SMTP id n14-20020a5d598e000000b0033d0f35d2b0mr4485868wri.60.1708100322935;
        Fri, 16 Feb 2024 08:18:42 -0800 (PST)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id bs28-20020a056000071c00b0033d247309a9sm1079418wrb.12.2024.02.16.08.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 08:18:42 -0800 (PST)
Date: Fri, 16 Feb 2024 17:18:41 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Dave Chinner <david@fromorbit.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, chandan.babu@oracle.com, djwong@kernel.org, ebiggers@kernel.org
Subject: Re: [PATCH v4 06/25] fsverity: pass log_blocksize to
 end_enable_verity()
Message-ID: <sh4gfd5ajjuryg2yqu6u6mpqlpuyjsas2axvzs3xli5gc6xb5f@b5r7urrxxn7b>
References: <20240212165821.1901300-1-aalbersh@redhat.com>
 <20240212165821.1901300-7-aalbersh@redhat.com>
 <Zc6GDNMj3gAk20nc@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zc6GDNMj3gAk20nc@dread.disaster.area>

On 2024-02-16 08:45:48, Dave Chinner wrote:
> On Mon, Feb 12, 2024 at 05:58:03PM +0100, Andrey Albershteyn wrote:
> > XFS will need to know log_blocksize to remove the tree in case of an
>                         ^^^^^^^^^^^^^
> tree blocksize?

Thanks, yes tree

-- 
- Andrey


