Return-Path: <linux-fsdevel+bounces-20556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5E48D51AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 20:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEAF71C22F13
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 18:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A113E4D131;
	Thu, 30 May 2024 18:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4LVQ85w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB8521A04;
	Thu, 30 May 2024 18:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717093157; cv=none; b=IvgfU62bjMu1Sw7/LDm73Zyp2lITzucZHwf7u6l6O6szF/FLwEAg8B9Avt3wKcpmS212MV6KAgftf+cQ4CxocoRvZ1VzZbMmu3wYEFh2Zd47hefloi9pkaswNjmQm2EuAEpu7nokzL/9g/Q+ORvpCiavf8p7EXij6UC/hRCslYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717093157; c=relaxed/simple;
	bh=YNEusj57cou/PLs/Cy/fI6joc+1Pl/KrclmhzP1UCeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NvWBYqcboMTQBHLoLLhMwPHfc/PtZCq58qsT+loJharhIkzqGYlfglzVnYgNryeCM9Tr1ekIvGJ5nuE/uBfU/UZuHmYKD7VD3PXAezcyOdumzwhJ277yFNks+++6P3T3ZlytFHW93O1yxLOfT4DGfbmUvjD+xeZrdGeX5B8nr2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4LVQ85w; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f612d7b0f5so7645245ad.0;
        Thu, 30 May 2024 11:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717093155; x=1717697955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mQ2Je4JqR18N/OiakuDUOcLwxs4GD6sO7cJTgQDYdqg=;
        b=e4LVQ85wHtT4PfgDIGhwSZBKRhHegceOAuBR9V6lU3DaJ91bq2t/gFH0mx7WR7UY9q
         Be/kjU2qKjoD1WtemTkIJrQ+L5m9nx8wvgqp3sMjYOU1yq3Qn59JxmmkWfTMJs1rkOtD
         F5Mbav2obVvexyIwII6ntNqv46cfsog1AfhhI3Nz9bPb/1dssLHo5OwUr8eHjx/B785b
         A4pcMws567LVEk8FPF2l1w9T262hrELKSc85l0CjUYJc6w5xJB+lnHfgO05y6v3XtEDX
         AcROiPWvJTweCagk74VL/U3zD/FCnEf5fiRvPugLq6WJQrB9cYJQv6eLiPvfTtJOKjd3
         3u1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717093155; x=1717697955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mQ2Je4JqR18N/OiakuDUOcLwxs4GD6sO7cJTgQDYdqg=;
        b=RPQcveJDfNO1uH/tRM5j2yUqToqQf3GqKIlVdK7aAxYcoXvWdVOXC5ff1SfpyhBmkS
         Z4sbnUC18uI3xM4gN3h8fRF5sM2vWutDzqiuayJY5piEN6NNWn2mlPMa2UoU6o1ylE/g
         oUETW5LTl8WRqw+cH3SgO1v6Ni6q3ghiyIzZ8X54qGGdyt2ro8SynXR5NNQQ0BwjZxco
         cCCh3fKkipA3YMbIENFx+leClmjAB6I6A9js89C1QZ6yfxetOM70SZxCMhcpkCVJoBFj
         +bPm9g3pDnFAyT/jpGKRb4ThgtT25sajI+mQCPmjDqWXCQ56i00DsJFuNLhovZv7ei5x
         84XA==
X-Forwarded-Encrypted: i=1; AJvYcCVKNkpW07GvpNPwEGhiBDUkO6kSVccdCEEAudhDqfOVDdkquLkIy//yzgjDBmBFc3VPsm/9JJknZJ89FJm5crKCPSYX7a3b++dVPTUvNsBzRurzyOYyJF3rk9y+kCNZS6isDE+qXzW9KYPOsg==
X-Gm-Message-State: AOJu0YzJ/wA0yOBkCpehlWmRALBDKZDIXD8wXjyfUgqNphiRL9ee8DoV
	5zW+RHh2kp7poT33Fp3xXcj++3jISs9UsnDlwxdoTOxx6RJsaBb/
X-Google-Smtp-Source: AGHT+IFQhCTGJwq9+mK/5uWbTrxFnaH8vizuLnDkXTunTiXD/TQlcE6PU904k7Q5b44wWkTN27NLKw==
X-Received: by 2002:a17:903:64f:b0:1f2:f4e7:f880 with SMTP id d9443c01a7336-1f61be47951mr28970715ad.13.1717093155044;
        Thu, 30 May 2024 11:19:15 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323e3d41sm811605ad.181.2024.05.30.11.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 11:19:14 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 30 May 2024 08:19:13 -1000
From: Tejun Heo <tj@kernel.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: willy@infradead.org, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/8] writeback: add general function
 domain_dirty_avail to calculate dirty and avail of domain
Message-ID: <ZljDIZVcOuwvPW6j@slm.duckdns.org>
References: <20240514125254.142203-1-shikemeng@huaweicloud.com>
 <20240514125254.142203-3-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514125254.142203-3-shikemeng@huaweicloud.com>

Sorry about the long delay.

On Tue, May 14, 2024 at 08:52:48PM +0800, Kemeng Shi wrote:
> Add general function domain_dirty_avail to calculate dirty and avail for
> either dirty limit or background writeback in either global domain or wb
> domain.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

