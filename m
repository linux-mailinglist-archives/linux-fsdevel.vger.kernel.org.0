Return-Path: <linux-fsdevel+bounces-23139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD919279A2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 17:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12C5D1F25833
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 15:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C80D1B11E1;
	Thu,  4 Jul 2024 15:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="O9PEs0+f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047DE1B0117
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jul 2024 15:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720105782; cv=none; b=WY6YOZhYFFia+Mbb/Q6uHfop7R8F1nB86IX8yGfF0zkRcP0Vcpkwz1NM4I71P/hQ9H7ptwNZreDG7FCwYb+FJiM8DLlyzJAiuPvgsoTC9U5yTUS5YJA8sYmZQ2YMZ2GagOb1X/L07OhvT64jDwSPwMsBQucuEpQEJnYde+I9IoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720105782; c=relaxed/simple;
	bh=tpQZ0R+qOwFBgorkzT2NuGeke6uMa5km4mOeaG5TiU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWxyQ54QQZCsdldURB6xFkfnxtna33fn3MQIOLtjzgqg5lxC3cz5ni7RyfYy2He/U8vMPz65ocy0RielvKnmHpuXi6S2ABbxWSD6foV3PI7/269+IkskdkcFkgy16+szbZqUCA7o2YTLYzIxcLeIXB/giDvLO7OdUcInup2w1pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=O9PEs0+f; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4468ac3c579so3381371cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jul 2024 08:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1720105780; x=1720710580; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vm7BB0wtH1oBRmebSCG0wYutnQP9eHQd6GHGIH+yb/k=;
        b=O9PEs0+folwAgdoDyEVRT0iuAeVZQXMjwM6P7En+oqryiUC7C6aAl+sz5/8MkijBg2
         n86ZwDfRxDpf0yBgHquKUQRQKVIQlbXIeCFLC9VQNd0n880fkGtOB5k3WBw/t34/zg70
         Yc+QTcb9czJzitQVUItCbPFrgxVfq9vGs5AGFNyNgDvHdd+87x2jj11iD3Vy1d1Wjkmo
         zg420vqmhGJ53QI+SvhGmGP9jKj/x7PmRiF7FRe4C38wBr151eiL5/U69KtprDcpfGuO
         WrxdZ4Z7IcjbwrChAAY8tZUqmtiqUm6zIc6bWKKKqc/AIm/InD2vvRyCdQYh6vW9G2GN
         G2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720105780; x=1720710580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vm7BB0wtH1oBRmebSCG0wYutnQP9eHQd6GHGIH+yb/k=;
        b=Na87krATJ4/gPlD8/9CfSq5qIxY8L/T/Xhwo2ZAIHlybk4STmmXJOrLCB1TkPq5Q+S
         hqfl974fHXTm83C40uGydVbltYkVSVvaHgcOAZ4Ilx3qMoiHRCpG1YWs7g+ahTLspfCX
         XC2PV5JL91IgFW2/wGC483D3sxqCYSbhLaoNfCywwrLBjgNO0wewBc8KaCFizUGsqV4j
         2CcvU5/2cZt/M1keAiEiHHaqf65PN9FU0nW9OALfdt3+EZZ+MQPI0alWMYZjin2EIEce
         lBBRdE0PAwKUmNCDeTzExCviEjEiz+YiqPTwHchZe6XWg8r4K1OSMWGUxi65kXTxSfKi
         QdJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcMUlMkMjMHBj6+45CjAvlADgtl3FiokdlRaYMMvQ8cKvWaky+stQuVdKbB1cen3TvbmQ0oL6mEQSeCrKDRDDk+2vwXpxW6uMovNIElg==
X-Gm-Message-State: AOJu0YxUOInMBn5+oMm+x4bg8yZwF+Sxk48Zx9kgzIVPRqpHf/cjLP65
	dxI74KtTqWmv2PFmkAlwVbqmVanglzaX4FL5ZuxCtwA6D7NnfWGvPCiGgJs0PN+unc9GGRoo8N4
	4
X-Google-Smtp-Source: AGHT+IFZpBcGd1s/uI9yCk/TcLLFxpJtJ9xcRoEx/JEt9xB0WKrBPSJGZatlFQz99Qn4NNw6/n8UCg==
X-Received: by 2002:a05:622a:1aaa:b0:446:67ad:ed5e with SMTP id d75a77b69052e-447cbeea5a0mr20999311cf.30.1720105779938;
        Thu, 04 Jul 2024 08:09:39 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-446514b3a00sm60965781cf.86.2024.07.04.08.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 08:09:39 -0700 (PDT)
Date: Thu, 4 Jul 2024 11:09:38 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Bernd Schubert <bschubert@ddn.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm, amir73il@gmail.com, drosen@google.com,
	stable@kernel.org
Subject: Re: [PATCH] fuse: Disable the combination of passthrough and
 writeback cache
Message-ID: <20240704150938.GA865828@perftesting>
References: <20240703173020.623069-1-bschubert@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703173020.623069-1-bschubert@ddn.com>

On Wed, Jul 03, 2024 at 07:30:20PM +0200, Bernd Schubert wrote:
> Current design and handling of passthrough is without fuse
> caching and with that FUSE_WRITEBACK_CACHE is conflicting.
> 
> Fixes: 7dc4e97a4f9a ("fuse: introduce FUSE_PASSTHROUGH capability")
> Cc: stable@kernel.org
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

