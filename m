Return-Path: <linux-fsdevel+bounces-38130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9A59FC777
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2024 02:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61CEB162927
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2024 01:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F25A12B71;
	Thu, 26 Dec 2024 01:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Us5mEt8A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583EB360
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Dec 2024 01:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735177872; cv=none; b=n5+J7PUIaSaZ4Wh2kEvI46qQ+bIr1b/S4/wA3YIgvMSovRG9Yvk+ZHIFckHxBgxrChfmMs2t323JqtpG+zPHhh3Lm6N4+1ivdHX7JuOb56BAOzae8Y9WzrCk1q3E6V27+Smk7yAwsr651IqfkgktiTCwY58CVt6NPXTVj+Bb3dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735177872; c=relaxed/simple;
	bh=p+/HCp4uytKHS4RRtVR5mZ4RNjZ6losOFjkOEUasiEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTBLn2biGthp2RhLhu9HR3FPGJAnHoxRcPBj1jrXiOuDyfFiOg6xaNWAKw3+VfwlJosj2Vd7YIYTNT0Om1zTn9F20Ua9066hyuUpxLIMNxsjzUUqI6EBkbZNep6Ny2oND0JzZAhz58qRqPxMCRr5XFgF5U0aqaFCjVKwy2WWXII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Us5mEt8A; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2efd81c7ca4so5549285a91.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Dec 2024 17:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1735177868; x=1735782668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=366DNgTZXC3bkjUlhSBobSEILOlddeFbJWISVWcfjbY=;
        b=Us5mEt8AFNJBb2dBCu2mWc/IhI1G8Ok5vIlt5SFGobBjecL+UfQlazOVBi+rlVyHmr
         xi30rPp/u+UYfyE+PYbbJeuHOH8KOPmR2Ke5gK3fnPBNRmGbQcWHZjV8gYon/JEtGgEK
         3q6tF4Cx8+FcIdaegxnmSKoz3QwlDIsddmI8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735177868; x=1735782668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=366DNgTZXC3bkjUlhSBobSEILOlddeFbJWISVWcfjbY=;
        b=Ut9wBhI48tDjWyQRArGxnU84EBXHbsvs7K5TIphPjzMNbd7Ys1q8687IzSFU5vyraa
         t7AsilyqBI5Yy7Iq5ldP1+22R6DEF/kByraOo1YhEvuEPQHeZl5MDiMv/NwdlmIx8sDR
         NgFnqynpRW/Z9foIreNxbF3OFtDzDIXsAfACpi3FtxyC3/CH5eA5thhyj42rERxPOwtp
         p6vijnpIP2bRKS11xhE8jr0vrD4AWx8sY5VGJ27ZTJi19WCIBn6A+IS5IncOwbDOCgZW
         jeFQYcPMdYmyNpqjJO0vnbGvCKmO2w5XFmemVJ0nF+W3baU8QE7HcD8h5MqeMWLkt3D+
         j2Xw==
X-Forwarded-Encrypted: i=1; AJvYcCWKnKwyw31rTRbk3bROngCPDBXw+/HrSAAUNHU/jvD3TGw31S6zsIt3su5RJmLA9vJ1d636scHTZ6feQzcs@vger.kernel.org
X-Gm-Message-State: AOJu0YzGVQc3w+g30xgzjoPcnAWwXZVM1vWpanGv1IljetdOL2A+Vc0i
	u2ZgnIarBIIfOjmRK7WIpaVt3vVx8RhZjhniQDu2LvF54/+C95ha8wuWTmUFXg==
X-Gm-Gg: ASbGnctqjFYkLnKOUUSBZl0LaNU2yRJpp20vQLTXfX09rf9LiNptASqC4UQlU0FXVjT
	x7CDw5BasBDuBjr0l+hNuxls66O5BkrgyHw2Fv2xwLRWBMMrm2QM8wnycZ3WtPMYBlTlRrCD+hO
	bydw0lmboIIAOcMfzI0aN6X59aPgzy/XodTvYnhhTztIaGtdgrjPSyQENijTBOAs2jJ3NfZospm
	9wBWWIF/s9uiIH4mU2ssrXQBMb3tchW+iqfuPP17qKXcH4g6z0Hug0G088=
X-Google-Smtp-Source: AGHT+IEuWmpC8lz7gW+a6/J76GEfa5wyqAD8/U7hOOSkVJgKvWlIKdFSa+cz0051BXwvodpsmB0XTw==
X-Received: by 2002:a17:90b:2745:b0:2ee:d824:b559 with SMTP id 98e67ed59e1d1-2f452ec7001mr29538962a91.28.1735177868722;
        Wed, 25 Dec 2024 17:51:08 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:e8a3:a0d:e1e8:eb51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9d444csm109646745ad.137.2024.12.25.17.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Dec 2024 17:51:08 -0800 (PST)
Date: Thu, 26 Dec 2024 10:51:03 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, laoar.shao@gmail.com, 
	jlayton@kernel.org, senozhatsky@chromium.org, tfiga@chromium.org, bgeffon@google.com, 
	etmartin4313@gmail.com, kernel-team@meta.com
Subject: Re: [PATCH v11 1/2] fuse: add kernel-enforced timeout option for
 requests
Message-ID: <fmyclqwgnmiem2bfbzfu53bkoivivltxdw2q63amczzzfanw6p@6dbpifizrx56>
References: <20241218222630.99920-1-joannelkoong@gmail.com>
 <20241218222630.99920-2-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218222630.99920-2-joannelkoong@gmail.com>

On (24/12/18 14:26), Joanne Koong wrote:
> There are situations where fuse servers can become unresponsive or
> stuck, for example if the server is deadlocked. Currently, there's no
> good way to detect if a server is stuck and needs to be killed manually.
> 
> This commit adds an option for enforcing a timeout (in seconds) for
> requests where if the timeout elapses without the server responding to
> the request, the connection will be automatically aborted.
> 
> Please note that these timeouts are not 100% precise. For example, the
> request may take roughly an extra FUSE_TIMEOUT_TIMER_FREQ seconds beyond
> the requested timeout due to internal implementation, in order to
> mitigate overhead.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

FWIW
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

