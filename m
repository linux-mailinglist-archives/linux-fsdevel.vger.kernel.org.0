Return-Path: <linux-fsdevel+bounces-20560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2623F8D51D9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 20:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7FF128460D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 18:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D6D4D9E8;
	Thu, 30 May 2024 18:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPCETaQh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4097C4595D;
	Thu, 30 May 2024 18:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717094109; cv=none; b=HNMDbnicsA2W5TaeYMllU8HJjTg/G/Rj9DAkMCkCr6N6xwOrJzmQlTK28tNLqf31aDuEw4upyFJwiEEWGaTwsbA5rc4pXCyoT02tgMeaficfCOhhxlkU/m6betRPivayJ58Ez05vus3i9pNiTikkk4NlbvjGeQFmBWFYxps7ddA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717094109; c=relaxed/simple;
	bh=4TiDmPOLEbJEcrhZHfzzVXFD8y8dHptEpxx3sNT9xKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNdepiByBTZkeuT3ltGjwXnrbXq5K4HgCJYNiz0vikoGZkw55/0+eybFuKZ6p2F/7eO4SW+VRoz6trI1kJgVNWC1cs0E4ax59K6582v63a62CXQ7w60HBK47DGzsbMpHw9QpMy85OhDVvxnFFePJwOpnN4EIxhDMHi5h0gnsq1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EPCETaQh; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f44b594deeso9139855ad.2;
        Thu, 30 May 2024 11:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717094107; x=1717698907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UQyclnjydiTSU7cNN94QLETZqPnCeDkTako/wYgboZc=;
        b=EPCETaQhgHge9c7B/L+668LS+G1EjhFdVWbenWG3dg1j67AEs3m59IkGi1XcsFZZrm
         39QDfut80pQqEfZpDeDvTy25XvkcPQq+QUz1+Fq8OYKP69ux455lH14CuJw80PbfRcYP
         SujrQ0Dqx2Z+Gf8+a+B0Whh4N6CqlFMEtD+6W+jP+8FZEDbB250+2/GkithWVUFwhtuP
         MPwEcrV7la/29fDeUgSOQbrEkNoucpoUt8R9pYDhri8IO/RJDW7h+1XdPNYCm1+oPODY
         i91BNFDt/WlTnblLtWoRIjfE1crrGqm3V7zHBGN/DzstmqhFFq0x5PPD17qAS79vbVjM
         WARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717094107; x=1717698907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQyclnjydiTSU7cNN94QLETZqPnCeDkTako/wYgboZc=;
        b=LdVK0Bc9GLU1FjWtYGesKUoyVgW7BmgivvUv/OwoDSUH6R7LOPsJL//qjEC/yE9crK
         u/+GtetfkU2DuegjcU1nfPfrEM4hU3uT30oaCsegitW6JIzXWIbRcG/2jZa+kybYMOcV
         wk1JijYwm8jIh4B4sI/WQHZqDkpTLmefx4gkJHQEmZfVcdmJfXrlW9kxlVnG2+paxjL7
         BSIVM+bGzpYuHwMPsEqkNogEm7NSvUxVYOQTpWRHDQLjVtfXIbERpLJ4Qt5cMvS25J1S
         6Nhrzznhcpd6bh5ANYjxAJQilazQIWZCjiuUKVvMo3PZrEBo2UysI7Q22OImFQAq0znJ
         IThw==
X-Forwarded-Encrypted: i=1; AJvYcCUjAYlZjD4fRL5nS34WcHttiLKzSutVMED2Wc68LWYIp8ZPvj6llqBPrNl4Q1WaAg56j7oSflNWDECx1WZ4si/n3QmYS6u1mt4IXZ+gSXfBzSlCfi44Lx0t4Qi3BfwXpYBUk/GQJVD23Pf8xA==
X-Gm-Message-State: AOJu0Yy9Wq9++8PsEV6F8ns60qg1aVD8AfFpe6Bl5e9EeaQajabJBNVj
	sf0C3+yqRaqLd3o5ZSOVHW9mKbVpVtLnYUSTShUUTlmqPv6WZ8lJ
X-Google-Smtp-Source: AGHT+IHDEfOGq7HNxJoku45iJzrQaZAIUNA329dViSCdnrDOwypFw2GaCt1T0+oOV3lhFHrRqTg2Mg==
X-Received: by 2002:a17:902:d4c2:b0:1f4:bcef:e940 with SMTP id d9443c01a7336-1f619b2cae4mr35438925ad.45.1717094107448;
        Thu, 30 May 2024 11:35:07 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f632338afbsm1052635ad.47.2024.05.30.11.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 11:35:07 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 30 May 2024 08:35:05 -1000
From: Tejun Heo <tj@kernel.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: willy@infradead.org, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] Add helper functions to remove repeated code and
 improve readability of cgroup writeback
Message-ID: <ZljG2aq2jRM86BbA@slm.duckdns.org>
References: <20240514125254.142203-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514125254.142203-1-shikemeng@huaweicloud.com>

Hello,

Sorry about the long delay. The first seven patches look fine to me and
improve code readability quite a bit. Andrew, would you mind applying the
first seven?

Thanks.

-- 
tejun

