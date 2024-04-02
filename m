Return-Path: <linux-fsdevel+bounces-15902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A27895975
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 18:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62D1A1F23F9D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 16:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB66414B065;
	Tue,  2 Apr 2024 16:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dGAA4XJy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2D97A724
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Apr 2024 16:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712074595; cv=none; b=EOZFcXQ9X7TwzkKtBacjL+1bEZJEqAQVX4NCAkRlB00pMTjk1PcSiPPx9NrEXZ0eKbo6ndonysDehhuHjSYeTi7oNAZhIK4dsN4h7shEcZQHIxtBRzul5apDPmMAlO2qJAjBgIPUBYRHSr8hLB1VQ02SncuJXCFAMnRPvONRhNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712074595; c=relaxed/simple;
	bh=OxlWVdxTEdD893sBNtktZlp9W+CSobIQEK3xYRBJ0BU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBJ5MTLwiNrV3R/J0YIbLwM4cMI/68wr9tW9CtNVWzz67FDPDuRAfJGd2n2S992+yqpvqB20naoermWlshbEi6Hs78KxHodf8yHKVrf1lKfohplzitW5pha6pcm8d1sKtJJwiS8h2Jlni3kuKRVLq2xHvaqCY8gl4WUskfUw3cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dGAA4XJy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712074593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=poSTIC0rG2YkQpDe1N+vUApeRhMh2mNxpVONRYNd57c=;
	b=dGAA4XJy57mmpWU8/mDkaIMTWws9Szb2loSrnB1f/CounrxWCJyxqldUsAYrNkidvn/Hzj
	TGvM0dZlh5gm7vPEOV8OHSHiBD/cJbJxF6mZFUxRwio2oKC0++3W+Duyfib7cR4PbcvTXZ
	fEPwJDJHRaCHxt7dpM1hxubu8gMTGuQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-9vfH-5RGM9SDtQl8t6VuIA-1; Tue, 02 Apr 2024 12:16:30 -0400
X-MC-Unique: 9vfH-5RGM9SDtQl8t6VuIA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a466c7b0587so374545566b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Apr 2024 09:16:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712074589; x=1712679389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=poSTIC0rG2YkQpDe1N+vUApeRhMh2mNxpVONRYNd57c=;
        b=vYqiq6mGq0SjHmELjNhqUX/ivwzqAi1I1Lt5qbIGH/FQasK8QGWYWVN/9iezVt2BmB
         cTjKPYkD0dINdeMwPT8+pIrppOFlOyTnUCx4JHvCXXWeFmGkK+FWf5mZwnVJkqs4Z5ah
         5WNvOvERENWjBe6d/ALzm1xp9qINQ96DcDuTbFUX3kVTZ9v9GOYeJ+JwG2ySxv5H3L2v
         eSSMVZOpa3XNV8eCm5SVE4LBS6CKyWPEQPnHg1CyZyKzPIeQs6LhNWy5xzJvjuKW1tCh
         QKWp9vfHEqhIcdpjVpkvBIDdLJAuFFcI+A64Cw70iTAYUObx4g+rHz8pSiGBPBdXUQV4
         0lZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9xUSQJn0bzZ4Zhux6w9DfLWRItmFEfD1MyE/wSVamx8c841RFhWlXYh6405ypWDfZSDobp5Il+WYBWuJ0Mev3HgSbITYxBRmI9OutYA==
X-Gm-Message-State: AOJu0YyT6rYGjtKLBtJ7LvR215JX8qXGx/t7Gd2/4mWjUjIKNs/JC9Z8
	YQzEy6/4tRgzUYxj+b0i5CT+HoKkIDGPkv5k7Rj/w7shu8cQBEELEbDwboBnufK45FR/hOHOUAc
	/PkPxPS5Fjk6hgckjKHBOBnZo8+68c94Q3pZzI0Z6iSs0KPoOAxdOHiqO2yUHnA==
X-Received: by 2002:a17:906:2b5b:b0:a4e:60c0:6a98 with SMTP id b27-20020a1709062b5b00b00a4e60c06a98mr156980ejg.55.1712074589256;
        Tue, 02 Apr 2024 09:16:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF05AJXgDG172NMmyUH7ahWdx/rKSi/SG4rJfk01sHORjq/CrxsWQtDEe/ffiuLuuhSZJWGTw==
X-Received: by 2002:a17:906:2b5b:b0:a4e:60c0:6a98 with SMTP id b27-20020a1709062b5b00b00a4e60c06a98mr156961ejg.55.1712074588781;
        Tue, 02 Apr 2024 09:16:28 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id la1-20020a170907780100b00a4e8e080869sm774247ejc.176.2024.04.02.09.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 09:16:28 -0700 (PDT)
Date: Tue, 2 Apr 2024 18:16:27 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: ebiggers@kernel.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH 25/29] xfs: report verity failures through the health
 system
Message-ID: <ruqr5tdxmmnwdb2kd6t4jsxzdtrurwiyovoguv4nf5suxfpx5s@ypic544cgqt7>
References: <171175868489.1988170.9803938936906955260.stgit@frogsfrogsfrogs>
 <171175868973.1988170.8154641065699724886.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171175868973.1988170.8154641065699724886.stgit@frogsfrogsfrogs>

On 2024-03-29 17:42:35, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Record verity failures and report them through the health system.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  fs/xfs/libxfs/xfs_fs.h     |    1 +
>  fs/xfs/libxfs/xfs_health.h |    4 +++-
>  fs/xfs/xfs_fsverity.c      |   11 +++++++++++
>  fs/xfs/xfs_health.c        |    1 +
>  4 files changed, 16 insertions(+), 1 deletion(-)
> 
> 

Looks good to me:
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>

-- 
- Andrey


