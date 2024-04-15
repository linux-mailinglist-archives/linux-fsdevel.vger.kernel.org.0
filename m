Return-Path: <linux-fsdevel+bounces-16960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C368A5712
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 18:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19FF31F229AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 16:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E43A7FBA6;
	Mon, 15 Apr 2024 16:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O8xv1am3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E09181752
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Apr 2024 16:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713197203; cv=none; b=tD/PbD3/027vixWA6onXOsOqruw+FyZNteTDiLiBIJ8vqNS+cvU2cuuplFqIptxUN0ZpY2HTWNOB9X4y5NL+3fE9411dMoVUDY0Kox4G7vfBVoAqg1XcjdEoMu22PWRj4yd0PI73pyoZyHbMvIndayWz3icmACVJUh3DXprGW/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713197203; c=relaxed/simple;
	bh=TbkoZcrC73ReILBlLCzDk8hBya5REumqV3/XGRD0RBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjUBuLajDNfRct5bt91ipaFyORcZ286du7hreCQnYxWxY63A/SOr85qGZ0ZP37f9+jQWTG9DIQvohY9SZ1BqjIkemiIUuCSzlW3a+3TLaCRI3O0iocDdsQ0jkJpUvA4pwOfxuBw8FEBFPfLco8ip3ok0gVoHP+ASHJsiS8/VpNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=O8xv1am3; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso2183029a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Apr 2024 09:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713197200; x=1713802000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W9YkT2PBxlsTiQpc9k80Xb2w2qGzzlQLFXvx15ENFSo=;
        b=O8xv1am3Lk+DQ59W9cNWa2OG2Fks5PZkZcv6Z6Pfi7Uv5Oy1Av7RnTmnxj3FUYOm5V
         yx4o1he5W90asuV36XyOe0antbXBxeK6gi/EVqhCphP56lqegAsztJrs5wGp912uqAFQ
         L131duRGarDG1vumEdOdHiU0czbOW9+JxRfTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713197200; x=1713802000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9YkT2PBxlsTiQpc9k80Xb2w2qGzzlQLFXvx15ENFSo=;
        b=whla/c7I5l2tUOAbA+rJ47fL1bOt0xRYkywz6xcKB2xJ9yJum0H2oCjjv2NA+vpwlE
         NQrcSFdnUoTrCVH9uUjOvzewJkaQq6CBqN1H0QEHx9IZhKlLSyPjcGwFzRE75Ofbp16S
         ctiF+kIZmJFE47SBydFSBRgJ88AY7Qio4BDQ3sGbbEizmyTQmy8DW4Lq9Td3RGXNxAEr
         mX4AN9LUz+eEovSjDXsAFGLxfPNqJPO1wM09ZaoJaZmI8MCkbr+UCLoYnHvjBLSD1X53
         OU59ajI/Uunl4MlkGsQbNJkYD55wFIIVICvkP2q6B8xJxOHX6NR8Q8tueligs98TszF5
         iG4Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6MHE/XoRZSzGqJKNKaAK4KGBoe1ytyBzqW2RmsCTfyy8Je5SgLhpzpmFv1Y8IxeNjr51v1bpi0Re7VD3g1Y4WmFKSoxti6d6NK/82tg==
X-Gm-Message-State: AOJu0Yz3VxuZD5wVfyFJn17+WBCIXWzgUP5fW2KYkN4VJ2seMMZD97Sj
	7WbirPQD1Eyhgy/vUOiFgyIuDAX3zCg8dFQHyeFu0TalQcVqn9LGZ8oTqiBnQw==
X-Google-Smtp-Source: AGHT+IEOd/x1N/CPtx25Nf+PUqf1rfZqa2mTy1XxaxcS7HXEzP+ucQDv/NhrafY/fDlqqKtbbV3LWA==
X-Received: by 2002:a17:90b:3d3:b0:2a5:ba9d:a06b with SMTP id go19-20020a17090b03d300b002a5ba9da06bmr10113697pjb.5.1713197200332;
        Mon, 15 Apr 2024 09:06:40 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l6-20020a17090a49c600b002a46b925e99sm8796108pjm.18.2024.04.15.09.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 09:06:39 -0700 (PDT)
Date: Mon, 15 Apr 2024 09:06:39 -0700
From: Kees Cook <keescook@chromium.org>
To: j.granados@samsung.com
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <naoya.horiguchi@nec.com>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Atish Patra <atishp@atishpatra.org>,
	Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Luis Chamberlain <mcgrof@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
	keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
	io-uring@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/7] security: Remove the now superfluous sentinel
 element from ctl_table array
Message-ID: <202404150906.C37D8D9DA1@keescook>
References: <20240328-jag-sysctl_remset_misc-v1-0-47c1463b3af2@samsung.com>
 <20240328-jag-sysctl_remset_misc-v1-2-47c1463b3af2@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328-jag-sysctl_remset_misc-v1-2-47c1463b3af2@samsung.com>

On Thu, Mar 28, 2024 at 04:57:49PM +0100, Joel Granados via B4 Relay wrote:
> From: Joel Granados <j.granados@samsung.com>
> 
> This commit comes at the tail end of a greater effort to remove the
> empty elements at the end of the ctl_table arrays (sentinels) which will
> reduce the overall build time size of the kernel and run time memory
> bloat by ~64 bytes per sentinel (further information Link :
> https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)
> 
> Remove the sentinel from all files under security/ that register a
> sysctl table.
> 
> Signed-off-by: Joel Granados <j.granados@samsung.com>

Acked-by: Kees Cook <keescook@chromium.org> # loadpin & yama

-- 
Kees Cook

