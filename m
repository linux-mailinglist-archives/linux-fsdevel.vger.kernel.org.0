Return-Path: <linux-fsdevel+bounces-15861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE740894FA7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 12:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7705E28491F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 10:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA28659B5A;
	Tue,  2 Apr 2024 10:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JSQLUx/0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A920759172
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Apr 2024 10:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712052711; cv=none; b=FhSDrRodix/BX9pWCdoasGMeG9HZiQXIBNXAaaAxBI+EVOVTHlcLIvRDcIxDLf1CQGvNzS0q0qxxFVFh4baM8cug0DqtIirNaLH0NCGRY/Y/7j5g2yoYRapC0KpC/PXvOXYEAApFK2UlAtP0mmSSXhucWPoUc3oLnZ9k5QgDJGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712052711; c=relaxed/simple;
	bh=oZZKISQHCkrhZ3u+KHXv2WzzLIaOCG06G8lFEDVCZx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S26ThNwgiRaPY8ha3vs4OFpgm4N+wwlO78BnWafMKJaVZdvhyLsheAKlu1/mcpf2p3aCYVYjF6Z+mM5MZa5TDhcKf7a4b84eOdqArPnrXJn6eyjMp05YlNLvnNyxBB2zpbuR2zAYUN0ddMTOKrNDNdL/htl7XcBFWv23fim82AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JSQLUx/0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712052708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8orag78Onu0GAnEHG0xqHWizNVsLLZWgOVAfNSrOVdQ=;
	b=JSQLUx/0oyII5W4NhZefFS5gJO/4qteyCqJd3w27s+j4j51ixlngaPxTRscCDg4hKIjnbE
	TRfcEYO29r8pdASKxOoz3mRFU3Kj/RAfA67xsDIxOD7PNzV8m6vroIpUXadQhtjxRHPop5
	AZoea0u+HhApVjvmlowTT0mnChRbBqc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-K9YNsCnUOzOBWo9KLHCF7Q-1; Tue, 02 Apr 2024 06:11:47 -0400
X-MC-Unique: K9YNsCnUOzOBWo9KLHCF7Q-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a474ac232e9so228817166b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Apr 2024 03:11:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712052706; x=1712657506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8orag78Onu0GAnEHG0xqHWizNVsLLZWgOVAfNSrOVdQ=;
        b=wjqthTGJOU2Eie6qTBjGwLsgIczcyzzp/LZ3jWUxuY4sihRWDY3SsHW2JhfOuKRDI7
         /kgYV7yLXZmhelHyRgN5cXLB85PViqOP6fe4fNfj8JPqCQU39sfjUm8VDuApxtGYhoxo
         XGuOKjEmwyFITjOjq2VYA0cp0f3aKv3++vqWOCM6ojqUE3r7A7LKKRRIwzk51fkJiODL
         jdwEMTv0qcDx2c78IKdvUrPkxMf/41MFCBNqx3H6ZODYRt/QpMrSpLo3OoVBqsET23kC
         wpD5kyQS6FO/HFCcHlPOhrJw4zota1hhM98cmb/qETSeEhlcs8PA08Qac6d1IAgL2q1J
         Xw6A==
X-Forwarded-Encrypted: i=1; AJvYcCUxoYDGt0In5cROf5eAUff94jUdkT6r6c0ES+msgYZoo8yLZhPDbWJq7R/B4klcDIVb5/eTPcMf2ZDja+nA5mesVHG1Ulji7dn+WY0img==
X-Gm-Message-State: AOJu0Yyg1q587CHwxc5m8InGlKLjPzErvqiljlRwBeMiJRQoDxFaOY1X
	yiSG5WSeUK9oWdYSLvDPYfID8MEcbsk+NGfGCYvrA+xoe6e0M9kdYeb2OTGCvo1+BqoKvA4wVCt
	EGwKPHv41N9K+2WCTWY/LCkeVtvaoz0bHFXOC+kjBs2xUuzn5yTqZG2zDZqC/8Q==
X-Received: by 2002:a17:907:97c9:b0:a4e:5088:a959 with SMTP id js9-20020a17090797c900b00a4e5088a959mr7941032ejc.17.1712052705927;
        Tue, 02 Apr 2024 03:11:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE41BTVXEvs87C4g9qG9R7fbvM19lrF8k4VutiO9eGKUH1kUl1mTLBx9qRMEitVDjuOVUJp8g==
X-Received: by 2002:a17:907:97c9:b0:a4e:5088:a959 with SMTP id js9-20020a17090797c900b00a4e5088a959mr7940989ejc.17.1712052705312;
        Tue, 02 Apr 2024 03:11:45 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id dp12-20020a170906c14c00b00a473a1fe089sm6354140ejc.1.2024.04.02.03.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 03:11:45 -0700 (PDT)
Date: Tue, 2 Apr 2024 12:11:44 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: ebiggers@kernel.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH 04/29] xfs: minor cleanups of xfs_attr3_rmt_blocks
Message-ID: <uevz4uxzbgos2zgffvqgjfxyycbwddyq26wli7l2ufvq33qqic@rpy5vxr2nuqn>
References: <171175868489.1988170.9803938936906955260.stgit@frogsfrogsfrogs>
 <171175868626.1988170.3178382336043313130.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171175868626.1988170.3178382336043313130.stgit@frogsfrogsfrogs>

On 2024-03-29 17:37:06, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Clean up the type signature of this function since we don't have
> negative attr lengths or block counts.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  fs/xfs/libxfs/xfs_attr_remote.c |   16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> 

Looks good to me:
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>

-- 
- Andrey


