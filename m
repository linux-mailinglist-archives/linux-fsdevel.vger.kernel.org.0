Return-Path: <linux-fsdevel+bounces-20558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6D88D51CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 20:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8BF428691F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 18:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5A64D8DC;
	Thu, 30 May 2024 18:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQOOc7g0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C982C18756B;
	Thu, 30 May 2024 18:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717093884; cv=none; b=aaog1cqA+LEYB5v+ktBsvB19NAbqCEhS1tzeBR5Vboy6iIJiAhOMpn7RatvMzdZvaqm7LHTg5+IKRXost3oVZcP/w0V3TpZpgQsM2yITig44GJ88enmYAd14+0h8QpnxFJ5oTPKI39o662LU6VNU32dvxFkLLXbPEEnX8e4eqG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717093884; c=relaxed/simple;
	bh=jw+/1omh9aija+/3PTa3hhBC/RMuLVVyV6nh2oe1lU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oj5c3/T1l0ZkTxbard0BzLa7GL98IqocY/TVFIm2RHGS/WgUgAJ6LPhfYl5THBkz8HK4Fc10mLDfWWZ0/joARLVH1XDEY7UdAh74zQRcUzsW42i4fMkxnsWlz9tnNMjBeNQTp+2hPCezlNlOU6CeKR/aMvfo2jQDPIh+XoO+GVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQOOc7g0; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f44b42e9a6so9989765ad.0;
        Thu, 30 May 2024 11:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717093882; x=1717698682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I8qugGotj3ZZLtSERra+hK/Mv9F36ldpUIYGeJNBrMQ=;
        b=NQOOc7g0MmB2IRejFxhZPKcxlhpusuBfur3LZ8piRa1AL9XzeBi98wnOV2BBTaOBVD
         mYPn22EhBxJ1+vZX0BhKfw0n21Ke1fc/+39yJ+h9FtMTJ4yzzooudOC9HXeY2eP20diP
         0k5w+UlGLwT22CXN5LWxaELhBCBSE4HqwHGk0E8QtnXzKHTRxN7JIrSEwOr1MecwjJA+
         bCbtBTC77IUpXchWU61R1+YPmXwVTwcbgyHJ2OEJvm4/19lekX9yCUHMB+yael8rPgLh
         lgWDsrrWBd0mSmBQoDCabdVGnVaUc1kiBnDtUs8KrA5Ge+WDJDz4SDNXwKfBYHV+9Ysx
         csBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717093882; x=1717698682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I8qugGotj3ZZLtSERra+hK/Mv9F36ldpUIYGeJNBrMQ=;
        b=BrAxMGk6Mol48A33XZpUaBaMpr5Q+SDTEDn077LCIcUBP3ZsgS0KIWW2zXjXv/lLV6
         tk1E/Jh1zSDM3VsJ1GC99uVanq0TtupyPgoIhNOvYGMNMqgQ+bhsn4q2iXiY4zgnFxsp
         KPHSchbDTWc1tCHlJVv1akXZEAEPAFYNFseBlDNtPYi97DnegnB9sIxqohHuB6xzNdcj
         FAG/XRP/8d4/zqv0u9pGGxM15v+oon6mMV6VHrPjOcdR9COjl2aRO0CLTYNizaqet56O
         znRjhZ4gJzvHM2lMIclu1ef5YVJWw1hXNK+m5WROIWr+ynBIgCbBqs51/fpMATjyVBeX
         +UmA==
X-Forwarded-Encrypted: i=1; AJvYcCVmpW4igVKd/vcLU1cr9RP0b6ANo5Gy/7tarr2jpW+VhJDkdR1xYbOK2BkeLoZWcBq6V1EoqhazrSnjLfhbj2vcMjlHJRPigqK+fZpv4NABiAAlCae52trXBMRJimzD0wWOZnamgGTFrTIhgw==
X-Gm-Message-State: AOJu0YxbzF0gCWyoq23NUqGSAO+gXXUhi4UcLS4K29XNfdPUd0T46zaH
	DSTv6UEgC8VLvoKKQBFNCQZYrJ7ZWZwQbHSGh3I6LWMtDgBio9sY0O801g==
X-Google-Smtp-Source: AGHT+IEsmGHzU7+6bVHVyy/d/YH911xaWUrmNif58TKuQitb7HqYKen2zbZwmoUnyCaURfIs2FM/iA==
X-Received: by 2002:a17:902:fc4b:b0:1f6:2269:1067 with SMTP id d9443c01a7336-1f6226914ffmr25443705ad.53.1717093882126;
        Thu, 30 May 2024 11:31:22 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323ddeecsm949995ad.160.2024.05.30.11.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 11:31:21 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 30 May 2024 08:31:20 -1000
From: Tejun Heo <tj@kernel.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: willy@infradead.org, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/8] writeback: factor out wb_dirty_exceeded to remove
 repeated code
Message-ID: <ZljF-CndHpAnPlQ8@slm.duckdns.org>
References: <20240514125254.142203-1-shikemeng@huaweicloud.com>
 <20240514125254.142203-8-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514125254.142203-8-shikemeng@huaweicloud.com>

On Tue, May 14, 2024 at 08:52:53PM +0800, Kemeng Shi wrote:
> Factor out wb_dirty_exceeded to remove repeated code
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

