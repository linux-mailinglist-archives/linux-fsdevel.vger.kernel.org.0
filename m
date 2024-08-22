Return-Path: <linux-fsdevel+bounces-26834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F184295BF93
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 22:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32883282D0D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 20:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D4B1D0DF2;
	Thu, 22 Aug 2024 20:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjN0tf6g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC365684;
	Thu, 22 Aug 2024 20:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724358745; cv=none; b=SmFBSZXR8DeGOQEYFQIWI8cS0f/4pSf6iD+HeG1RezPWFyG1SqZRZbtPgQ0mHosU/DkXIasurR+nM2jTzAE5F+eQ4b8Yh6JJOfbNdovjILdfkJBPI6A7pMFV3gbmS4LUuiL4rBEXxX2F+3NsJMEdDS0IuuuiWb25ejMWYjxzjj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724358745; c=relaxed/simple;
	bh=lV8Eo6UwqF+GKu5fxiduTababosxWKgjFhM40Rmf9HA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K0Ja4o5s3NJo0voztgWvafhB1ioyrwInysZc19blShIW8BqO3sBhn5vfZEhT1BNoIqPJSzgCCBMpmW4Zh/KWAw8FvhTvYCNS3In5yo9nowMSxf8GKLkxgkSVSXNXMbjgOAL5u4+IzQqX9JPB2m4ZpR0jAJuj5TbR0CJo+lNcJk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjN0tf6g; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-202146e9538so11925195ad.3;
        Thu, 22 Aug 2024 13:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724358744; x=1724963544; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lV8Eo6UwqF+GKu5fxiduTababosxWKgjFhM40Rmf9HA=;
        b=WjN0tf6g5gNvuaXnEMJn0cASd/RXRnbKhvWwgczGoP+o/WeWGdm3NE/jh7ig0oiRn6
         zGmh8TCTSJPCN18I+82WKOp2eLHmFhROfRUhHlelDu8CpykVOnf6YvAUy2+JS15aYvoQ
         lVPyqrE/18QrGg8kywLC4q8Du1bWpCW7ITlT9nlD7Avzfv+wyHFIwn5Yuu2nb0rxHDBo
         VupRdrWVSEncpEUY+TmmsM4sHJqme2fwu541FJj6Mtyl13wrrDWmYGjlzbJuvlr9E/Ob
         QRGOVuTMly70hDh8AMDJXMhVpuStmFW0jaY2c0KsW1NHZQmMRyPxnl+FT7VAreiCCgfW
         zQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724358744; x=1724963544;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lV8Eo6UwqF+GKu5fxiduTababosxWKgjFhM40Rmf9HA=;
        b=pa4IwJTGqDSW5WzEg00ieSBxX6MEuN1jFfdpkVmI2dsdGMAwQ2wGIvPQNBx55pD8zh
         Vfx5cJnF5EFmxREsIQEKkys3jACTNJRKB+mrbwQKhrpzqKwkuPG1yNM7Vaqq72PjdtGF
         +qYRlmSPzOcfS5ATm+rNpij6oE6ToDGImO/Dbqtq1VXy/NIXtOtIcVAkYoHu8xOOHi+n
         n3O8sUUga8Kyt8uqCz+pbrHX6rkSMOTAWFluzDoIsgfSshIbIse8uEXquFwAexdyqjU9
         rLPnLhnFUlsUAEHavyIl7E8rfUU4rP6uL5JjpVYFvvmpfn7OpER6fo13JJxz5azviJ8n
         l4Ug==
X-Forwarded-Encrypted: i=1; AJvYcCXLlgrbWGW2MHbD5UC9TIjwAmYRQ4qvh6ZSXdvKbP+IzUwdTjNPyKjHzU4tn5OcuvKjGgkuab4SQN128WcN/g==@vger.kernel.org, AJvYcCXka5qB3cp/updYQC0xf806pFI/n51eELnImXiYxyjcGZhVXKax2Ks6IRXi8nj5mnC3ym0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3JOQW/fyuR8+3nBCvG73qMLu9xeD3u7SL43nHQ+Set02PYBtj
	UB0p8ds1v1R+J5w2HKrhDaJ8Yfi3VpWAWpfirBevG7E6BUV2t8iI
X-Google-Smtp-Source: AGHT+IF3OyMgY8OGJSfC4mLTwniC/1oH5kO2QXdCXHmoiS2p6bRARWFrO351wm/xA9Bcu8AErkf0+A==
X-Received: by 2002:a17:903:41cc:b0:201:f052:d3e with SMTP id d9443c01a7336-203882426f6mr38489955ad.24.1724358743490;
        Thu, 22 Aug 2024 13:32:23 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385fcf6b3sm16545655ad.302.2024.08.22.13.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 13:32:22 -0700 (PDT)
Message-ID: <ba3c59b71cc3f9260ed3373975972d560a511258.camel@gmail.com>
Subject: Re: [PATCH v6 bpf-next 08/10] bpf: decouple
 stack_map_get_build_id_offset() from perf_callchain_entry
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, adobriyan@gmail.com, 
	shakeel.butt@linux.dev, hannes@cmpxchg.org, ak@linux.intel.com, 
	osandov@osandov.com, song@kernel.org, jannh@google.com, 
	linux-fsdevel@vger.kernel.org, willy@infradead.org
Date: Thu, 22 Aug 2024 13:32:17 -0700
In-Reply-To: <20240814185417.1171430-9-andrii@kernel.org>
References: <20240814185417.1171430-1-andrii@kernel.org>
	 <20240814185417.1171430-9-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-08-14 at 11:54 -0700, Andrii Nakryiko wrote:
> Change stack_map_get_build_id_offset() which is used to convert stack
> trace IP addresses into build ID+offset pairs. Right now this function
> accepts an array of u64s as an input, and uses array of
> struct bpf_stack_build_id as an output.
>=20
> This is problematic because u64 array is coming from
> perf_callchain_entry, which is (non-sleepable) RCU protected, so once we
> allows sleepable build ID fetching, this all breaks down.
>=20
> But its actually pretty easy to make stack_map_get_build_id_offset()
> works with array of struct bpf_stack_build_id as both input and output.
> Which is what this patch is doing, eliminating the dependency on
> perf_callchain_entry. We require caller to fill out
> bpf_stack_build_id.ip fields (all other can be left uninitialized), and
> update in place as we do build ID resolution.
>=20
> We make sure to READ_ONCE() and cache locally current IP value as we
> used it in a few places to find matching VMA and so on. Given this data
> is directly accessible and modifiable by user's BPF code, we should make
> sure to have a consistent view of it.
>=20
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


