Return-Path: <linux-fsdevel+bounces-58829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1913FB31C94
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 16:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFBD464787F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 14:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2753128D2;
	Fri, 22 Aug 2025 14:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="lZQvjLYh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E027D30AAC2
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 14:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755873641; cv=none; b=P81ddO2+s7FhUpkvE9UA+HAUI4RMEC0JK4e5+63hAdiRk2DkElXUbsheJlVQPcxMjdIr7JuJc36FZetAdRw3d3I5y9YO97nbnFUJBJhHnYo76IwfVUiA9Gq32wIm0mWuWHFDfCmUrssAYxQaEP4MpNcc3XwEpewiHB36L9JBMSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755873641; c=relaxed/simple;
	bh=fEOMn/md0OE1QvUICBnX8O+3a7PgQ6vANjZfZQ8gxr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TiiiCf9ZTE7ZBnPqdJEV0NzSXXPT1NQ4ClriuhjlmmM9P5gsJxJFVorGXKR43iAMYGANM/PvE6mlH7Ui29zI11VAQkA5bL2LMX6D6jUQxdEBfcZwiUE1SZ2Zuq3N/yzWyXFlwgI49f/15uQgWsOYRGZIxAp+5Yq0FspCSPasAVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=lZQvjLYh; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71fb85c4b59so33975747b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 07:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755873638; x=1756478438; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v3OogfFXdkMqRNtpkZ1fUtnIz6uf3uzEeX+PeKEs10Q=;
        b=lZQvjLYheqIp9V2Ez+RTb2JAres8DKTut5o8p2IJo57s0eCDZm9/podHwP91jEwTQv
         p9qJJ3sDzFkUDpL1Z1ai1PRQeVKLy32Z1zJxWbfeTKAvzfENO3UUc72tdg+C5A2L9G+4
         w6YFH9XDGVNJguysAG/VCQ7iWmZ0GkmFHI2uoX+SzK50/hxA0DZpBCcg4xnTJsUZCokR
         9PQ6+V8d60M46pMHmBPcH8xzmcnpLNGPkuAPlgiCpgEX/EJzBSv94g4AdX4DRymLbFhc
         cx08V5P4Nc2DsD774SFP96FPUus8q24pA77zbLJlAppusUSHqxzzQ2vh3WX3qSoYuCkO
         1iTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755873638; x=1756478438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3OogfFXdkMqRNtpkZ1fUtnIz6uf3uzEeX+PeKEs10Q=;
        b=tYgPVppuuZaHRDg24+l5wYlnxnygorrZkucsWATykjOK6BuZBry+BwkiFd6pH2iIJK
         IMXncY9SyIpNpgpJR0QXIpqse5ByZOL6ZdGNQLGvSjJA9uO49SvbgV0DMUgV29Z23QWs
         tZW9tUEA8a4+tLrMH1VFafoCd0+XRd7wV17ViO2kUSIcWKZgoG21Y5atRNfdDUNKFX27
         xdVVPi+07oJXNGS9Bk57QyLfCxqYLxW1COJ5pbmhqJtmkkV+0kWI344dlpU969BLBXUg
         VONjrZW5C+m5Z+p553biT7b/sZXKlLzaPMw9B10bOSxpJS2KqMQ3c+QaVutfVSzICggu
         j7Rw==
X-Forwarded-Encrypted: i=1; AJvYcCWEFhV2PT6j1u0HUgi2vW43d8WNjBLpVFWPOXhRUww7NYqtv/puIqZGTy9rjdowI/1+2XwB19tZBCLvP6Nd@vger.kernel.org
X-Gm-Message-State: AOJu0YzLVKLMutKD5rI/+EPKNigjWsFIrNwC1D9Tsip7ckoXy+wOD0Al
	IXFepEGsvHz8DUm6xpCX80mOduL9UWE54s64rhiuhtsdGfmGUwkvKJyBVG9g6FWmEWY=
X-Gm-Gg: ASbGncvvqJZ13IKlMyCYuMwbkUPA7uPhN1SYO/m0JNDs+56varZUXHWSzBZugYwR3Y+
	F0/otbhRdCdpENIM23LbGhWN326QzIx9476vXrEu7LQgTEVzYcTrtlPIFYYvA+l2LYjqMxMGv60
	buKsrTXUR6kZy8K8fUYFq7YAx+Czj+h0JnGl/e8z3VEsXulyYSHjYlQA8Eu2BXRolK8qgn9GA2v
	PoWASjl1WPfw0fVNxZRrZTmzqat9hWyfXvCEP4NaHVN3+Pn9x0v8DIjExwc3FNczQaLgRIBRGvX
	R91/+wn7YKzlJK1InLCACQ4QT6FUR1l1izGUl+BkOmssIOObR1DdKUQuxEkQoEAb4UD+V/kjlMk
	wtU/ompD5aDK7E7jFq1k7aTMPfZlI4uu1K2x4s8WlRF3riwJ9G+yueLfxUp4=
X-Google-Smtp-Source: AGHT+IHOy5Mb0Jt/cJA6ywQp6sLORvyAzia/tx+cqSm3UKE5FfWzv+W3sub+zG2wAFxqmQLGUh57tw==
X-Received: by 2002:a05:690c:6bc6:b0:71c:1754:26d0 with SMTP id 00721157ae682-71fc9c664f6mr55261597b3.6.1755873638329;
        Fri, 22 Aug 2025 07:40:38 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71fd92b885fsm6937457b3.10.2025.08.22.07.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 07:40:37 -0700 (PDT)
Date: Fri, 22 Aug 2025 10:40:36 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Sun YangKai <sunk67188@gmail.com>
Cc: brauner@kernel.org, kernel-team@fb.com, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH 02/50] fs: make the i_state flags an enum
Message-ID: <20250822144036.GC927384@perftesting>
References: <02211105388c53dc68b7f4332f9b5649d5b66b71.1755806649.git.josef@toxicpanda.com>
 <3307530.5fSG56mABF@saltykitkat>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3307530.5fSG56mABF@saltykitkat>

On Fri, Aug 22, 2025 at 07:18:26PM +0800, Sun YangKai wrote:
> Hi Josef,
> 
> Sorry for the bothering, and I hope this isn't too far off-topic for the 
> current patch series discussion.
> 
> I recently learned about the x-macro trick and was wondering if it might be 
> suitable for use in this context since we are rewriting this. I'd appreciate 
> any thoughts or feedback on whether this approach could be applied here.
> 
> Thanks in advance for your insights!

That's super useful, thanks for that! Christian wants me to do it a different
way so I'm going to do that. But I'll definitely keep this in mind for code he
can't see ;).  Thanks,

Josef

