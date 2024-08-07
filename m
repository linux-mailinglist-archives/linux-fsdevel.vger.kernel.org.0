Return-Path: <linux-fsdevel+bounces-25299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC5494A826
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 14:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A07061F21982
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 12:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8EE1E6755;
	Wed,  7 Aug 2024 12:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LBRvgArY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD821E6747
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Aug 2024 12:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723035474; cv=none; b=tjjZUFvAa0fH20ZanM/oK20ordIqH3u/XDHqObwvHBYB8iG5O/A+GZt3QoXMIJZvLabjNqFZdZ41k9cIJHFbIJSVhNCSSsI+ImfB/cYzGBzfX51LwjxdnGJdH4bnigpY13TkyrueJXR5NVbrpmpXNNLZBekqPY7N+IOreQSsonY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723035474; c=relaxed/simple;
	bh=/P12avlELoAnmeKYyR7lb8YFhV1itf6ofxKiFjh29iE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gb56q0xzpuaTRSTWZ7j/rFCeAwlMK25iKxZXmT2oAol65/TbtM3PeRkDWs4eCZ41YLvvtQKM8afQ5PHyVi6KhYm5f4gLjyEPs/M03rAJEQi7jsu97L+3mktSA3MIRgJiYv6svseTyZaU0dGUgNIl+zpcbAD0DOAbzrtQtrsmNVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LBRvgArY; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3686b554cfcso991236f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Aug 2024 05:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723035470; x=1723640270; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=upBTovYLTSLt9PmBzvvo1SLOl10UeXbfEGJHZrAuBGk=;
        b=LBRvgArY1LcT/818gMwkkzgIA6A/CmeSJwVc5c3JgFa/oaHXTQAvxr/R1AYRszCvZ3
         EREPGDR51f6IWbgthBTafuc0DYAw5WrDZomFES3l9NSfG8GMwzDw3/P/J+Z5jsvYwYQX
         El30mK0wo3qzrbetUyq3EDZQcqvhnai3I5qUwcWK4EzeWQ0K1Avylown/XodS09kE8I3
         tBDQHLEmehNU26fGvte8lu+FNHrfMSrc8HAv12XM4sBMh6ztT1wzWWEx4Z7xenV9UV6b
         Z3YtkVy/7Qscp3UqrzBgzOoPCx9laczovqOvwXD1qwG7LOdFm6rYTgeMHgjlGJOmDxJU
         zykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723035470; x=1723640270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=upBTovYLTSLt9PmBzvvo1SLOl10UeXbfEGJHZrAuBGk=;
        b=K/xZYpX7HZe+OyBENXiR8CV5y4m7KqxnXip3A8nPYxBdRAAlgIsBUNyt41YLwwXXBH
         78TRCMxJmKvUjpUMdu0cn+Kd/Nu+mMZKHaIHSxqLBjuHZ6y0GS0lOodTCv4ylwqOQGAX
         iWdYypnorKynL2I2F6PtU7iYWJkBG5gcA38Wxp3Qq9ku4KXhbww5cJVMw0/CPvSmWdg4
         FBh+dwc4xkAaL8/9KbW6lqYjJ12KXNRfbUN+qQIrYLIh6DwM74scfyd2Djbt0B8FFSNW
         EaxAEkI1kDz1Pigp1i2xHrYE02A7XrllfaFVnU/FBdT8WUymdGk05CcwRmQXnsxLqc23
         wLVA==
X-Forwarded-Encrypted: i=1; AJvYcCVPLVZaHn5v8oM/obt8Ko6VC3eHtiUN9///bvyAgHC7Nv6YZ4NxSAYPFXG4Co3aEgthuKPWk0oEzyhrRH2jpuyMhb/QbNfQPDPgsGHavg==
X-Gm-Message-State: AOJu0Yzaek3RC2lByvFHWdYxhO+hkbrpwkTK2IJL4Hg3uKnjO6gAc9rz
	WKKCZJQW5TWM13bPApcvw2i56qUmhOKg2ziZBTWrjuydORqKlY5/oCJU5i7oWro=
X-Google-Smtp-Source: AGHT+IEXCPBxskdc7xhLEWtu0Cahqx5SyI1yo58U8XJgoPCwXbriMJ41jBv68bBujcy87mECBIFxog==
X-Received: by 2002:a5d:5f85:0:b0:367:998a:87b3 with SMTP id ffacd0b85a97d-36bbc11bb33mr15758703f8f.28.1723035470377;
        Wed, 07 Aug 2024 05:57:50 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbcf0cc8esm15818874f8f.19.2024.08.07.05.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 05:57:49 -0700 (PDT)
Date: Wed, 7 Aug 2024 07:57:45 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: willy@infradead.org, srinivas.kandagatla@linaro.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2 0/3] ida: Remove the ida_simple_xxx() API
Message-ID: <01487902-4dcf-455e-9530-c04157aa8090@suswa.mountain>
References: <cover.1722853349.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1722853349.git.christophe.jaillet@wanadoo.fr>

On Mon, Aug 05, 2024 at 12:29:46PM +0200, Christophe JAILLET wrote:
> This is the final steps to remove the ida_simple_xxx() API.
> 
> Patch 1 updates the test suite. This is the last users of the API.
> 
> Patch 2 removes the old API.
> 
> Patch 3 is just a minor clean-up that still speak about the old API.
> 
> Christophe JAILLET (3):
>   idr test suite: Remove usage of the deprecated ida_simple_xx() API
>   ida: Remove the ida_simple_xxx() API
>   nvmem: Update a comment related to struct nvmem_config

Congrats.  :)

regards,
dan carpenter


