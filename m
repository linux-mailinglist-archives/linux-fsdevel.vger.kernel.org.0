Return-Path: <linux-fsdevel+bounces-14906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE84881453
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 16:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C497B21536
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 15:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA20C4F88A;
	Wed, 20 Mar 2024 15:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmOVp/gq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C9D4D9E4;
	Wed, 20 Mar 2024 15:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710947743; cv=none; b=du+7itM64xOifn8xtX5ALosLWLU/4J9baH7iKRQBpa/VRIm0rxKuy7o/6BaS0lEHwJ7dZOrDxUOMWNhqXSn/1yUxQaroZBN9vZKQR2FFdaGaRaBmYN3Qrgh8WhhoZdjKMf43yA1oa3R5j3wWk7iVL8LMJg6aRT/h2bjzdv9IT5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710947743; c=relaxed/simple;
	bh=bKpePcqzlga3/wYp4D1m1QXBs0CVLRHWadIpbuFQsog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejTmV24k8c8GDCSXXLa+3cCP5zm14wEqePhownjseapK+7cfDupZp1nR3/TUW8TneSdQhhtrci+Mbqs3kxeO5L3NPfW+pV8A8bnY8ZGM7Ok/cDpBB/gmXLSC8c9q4uF84V0NPsgZ4CV5LFcsTxS8BwZVSfDlpLutfRa+65q6hpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gmOVp/gq; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-60a0579a955so82012267b3.3;
        Wed, 20 Mar 2024 08:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710947740; x=1711552540; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FOA1OkHSqNDNi7l6mSUoWp1Vti+dK8LMbsievLGAJJ0=;
        b=gmOVp/gqb6UicLHmCIJOJxvsD766VQBc/cOlCBfLgEoYOTBXJ0A1qIdec28b9Pn96U
         1YZTOM0eTtUUz4P1LfQtAdrdfQ1O6FcI4tGYlKy9PMXM1fB4M9oIjdTLDqx+PoRdCUnb
         iRTJ/ljbxPsXYHe+8KPA20ufZ4WwHzbU9AyhRqL1gQqQHO8VljIl2OgpEihBSTQTtw9f
         oM4ES/Tm/WlzBIXNl/PIHlGFRXsmYTxCQWi50ge4Kum78OPPRUj/ym/QlrLLFvc5/lT1
         aFP4UIDT09HwzXeRwt5lJg+SM2nfh71q2//HjBnZTRaY7cjFbHWCsQ00ousbhai2D2k7
         6gWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710947740; x=1711552540;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FOA1OkHSqNDNi7l6mSUoWp1Vti+dK8LMbsievLGAJJ0=;
        b=OIDrzfG8lhAxsNio1umuWAoDBCcwjwHOyo/zna5t43W1PMiB3O8d5buhBT3P/q6vVJ
         tYxVBqzdD/qM2WqVzx3DtqP26Bf3NIJ/32efW2fNNFs9C32CSswEfViK4jHeQUeb0kAY
         /Q2GqfaO84mpNhhWjdGXCae/WioUCxs3iqawwUivMt1EbZ8mCYkifyNuAd5jA7lhm2kB
         rhyAkvBWW2KVMTm3g2ClCjDo88KS21ILdqK5OrJPJwrOTMSaWSkTEeNrWqJhJ0VewmCQ
         QLrkKZ3JxPItVJ/Jz6Ii39jy4KY6NgLsZVPdTSfTkfeEXnTw6zgWRHyIMEtjQ4yX7Uml
         eofw==
X-Forwarded-Encrypted: i=1; AJvYcCUZstXej4hfmu9biZCrNjal63R+bSNidyTxJjFiT9EqUaFiqyofQw9B4JtMR4Nv47um5FYjOBaNPsyo9ZXgOKJjgiJGSUNFG9FkT2P+8Tgt3uFvBaCLLudYgE72P7PIj/8KScToXX0wCuEuYQ==
X-Gm-Message-State: AOJu0YzsSsOZn2/sN7Otja61pUEJk/XH13ZCpexhm+oELGrsw5phCV4J
	ZGthd3PAqbrZk5oCNsKwuCuaU0V5L34qxTchfwuUre8rLYM34Vqy
X-Google-Smtp-Source: AGHT+IGEIYVb+JrL1n5CezttcE9gCGyXAR4HdzsHEKu6QmAj4f10FkRx3+A/wujjQICo15f4K9DKnQ==
X-Received: by 2002:a81:ab50:0:b0:60f:ed06:bee7 with SMTP id d16-20020a81ab50000000b0060fed06bee7mr6001464ywk.50.1710947740634;
        Wed, 20 Mar 2024 08:15:40 -0700 (PDT)
Received: from localhost ([2600:1700:2ec0:58c0::44])
        by smtp.gmail.com with ESMTPSA id s3-20020a81c443000000b00610b532f8cbsm1798449ywj.36.2024.03.20.08.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 08:15:40 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 20 Mar 2024 08:15:39 -0700
From: Tejun Heo <tj@kernel.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	willy@infradead.org, bfoster@redhat.com, jack@suse.cz,
	dsterba@suse.com, mjguzik@gmail.com, dhowells@redhat.com,
	peterz@infradead.org
Subject: Re: [PATCH 6/6] writeback: remove unneeded GDTC_INIT_NO_WB
Message-ID: <Zfr9my_tfxO-N6HS@mtj.duckdns.org>
References: <20240320110222.6564-1-shikemeng@huaweicloud.com>
 <20240320110222.6564-7-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320110222.6564-7-shikemeng@huaweicloud.com>

Hello,

On Wed, Mar 20, 2024 at 07:02:22PM +0800, Kemeng Shi wrote:
> We never use gdtc->dom set with GDTC_INIT_NO_WB, just remove unneeded
> GDTC_INIT_NO_WB
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
...
>  void global_dirty_limits(unsigned long *pbackground, unsigned long *pdirty)
>  {
> -	struct dirty_throttle_control gdtc = { GDTC_INIT_NO_WB };
> +	struct dirty_throttle_control gdtc = { };

Even if it's currently not referenced, wouldn't it still be better to always
guarantee that a dtc's dom is always initialized? I'm not sure what we get
by removing this.

Thanks.

-- 
tejun

