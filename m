Return-Path: <linux-fsdevel+bounces-44508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B83C7A69F6D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 06:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 460D13BD47F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 05:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754FC1D5CDD;
	Thu, 20 Mar 2025 05:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mH/nYgnZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AEC1CB337
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 05:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742449171; cv=none; b=LjV8Nqj2RMjCKM2cnX3ZjyQIcwj4fKrROtCIeZtaJUNjWNzqHE4Q1os4ZgF1WuIze7ah6QvkjTDrNdkxI19LZW8Dx5Sb2KbLj0faR5y1Spc+yUF90LVmmvXuF+kbKApq9QIuVvojykJXSEagCVuo8DkAc4vigl8M1PJw/BDm6jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742449171; c=relaxed/simple;
	bh=HSCSKfhfDD7I1zTxBolH/tzZ9w0jNV+XNDv1/LCD76o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OaXoBejeTS+SiYxgbHunHr309KqNRtoOdSAaG5buTkoRyn5qrvF1b76QvNa/SH278jKOtxTUI1U6zQNi0iZcGpv6aNPk1Ks2JfTrTH7pXgpo4wOoM9PvZjyPCAbtiF02Doq8LmbDOrNxEejwcPv7ioU83vNvu37DNw5Z66OEJ5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mH/nYgnZ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39727fe912cso76843f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Mar 2025 22:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742449168; x=1743053968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T1xfmCIlDCLZv6ta1QqTTHp5D0zhqGln1AOW6eZ+4nQ=;
        b=mH/nYgnZW/DbN1VRYVvFwzepXqzkrut4fgO2GX5Lsf6Nk2+Ixby17BeC8gr1cftnDi
         jKfx26DnI4yq82lZXLi/i20RUM+sxeWxLWyp9D8Gx5tIGGfhN2rLsvSEQElg79EOyPUC
         1rnQD/4ermbWGgOFNJ2WRBGR2lf9zUJng/gQGzuHyPQN+qqcgSkJVUla+GHN7rq2bd4A
         Bgo6Wy8nMkfhREskXKc5Ily/bZsuv9858HvUcXuIuP8yWXi9aeGeOwtOO9kHukpmWbBu
         Mwy33St28bzsb6HlIpPoqOA5i9Zfnevv0OxA4QIuqZ15wZzO5ELhR3DtbpNwPbbofuu3
         v7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742449168; x=1743053968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1xfmCIlDCLZv6ta1QqTTHp5D0zhqGln1AOW6eZ+4nQ=;
        b=vCmqGm2JqA3rHu47ADev2nJH0DmQTGRHBwhZqzFwf2h3V95CxfZ3osCUCi/+uOx0VJ
         NDQNJ21wI7Ycrg0Tkec9TQEvFY1tcz/2ezc9ONpfLBj5HQqwlQOLaPGTtNGHtZ2jv9+G
         GON/lGCFx+B93Gs2R+t8RkRPJ1AexpyBcoDITaylBGskbt4Xl8Ij565mroBAIhixHEmO
         u0joaPXq6GRLVZOv5jPe7LBD6U4jxw7XVjJ9YXiMJxKCiRKvDz9eQcGlyPpy739N5Zsb
         LDhC0jK+64umndU8fIGawfcDhEJpYYhoanWlBrEKEXybhtdRGY4tmKOw+rtB3G+rUd+z
         LpQg==
X-Forwarded-Encrypted: i=1; AJvYcCVHN7yLN4csMpZSpDaUfJ68vdHvFjyAW7yjhgHFlH4DXMQVbC0IvT/AOx4aAAbCUgL7Im6xJ+1Sq5BR2uk8@vger.kernel.org
X-Gm-Message-State: AOJu0Yy59V3XWtS10di1u7rfp12VyIwofA+qK/ljBw4WXMY4Q9YBSOGL
	vaTZRojo6AqhcwnjRRtftG3WycfbmJJUwV03EyIf47apaF2tRUmVlheX7wvL/Q8=
X-Gm-Gg: ASbGncsDxDi2nNM/taMvI86J+FlATTRKd2L4MYuroCK509GUCfQIptX0AQuEwpHzz7o
	uqwMqy6qDxtC17KZETwkQT7/xvAtpbIHzDB9vuDkcO1S0XaEDPMfa9FjKyOZhQehq48TeKItoaB
	pSKt0tG2y9NYqRx9L/nmnae/1WCcs70ob3H63hot7X/03BzSmXZJHz8kxkEFexy2zMKxgeOsiLr
	ZEp3rb4ocrsW1H0oKASL34YJ8xwQJeMueY9ux0MPDep8jqgA2Ju58vblGhIFaS3sEo4RrQWKyoD
	tdanSy7H85taxXSHTAo3b7xtvLRuW6IbS4RnLvWEUuO5Rp0YeQ==
X-Google-Smtp-Source: AGHT+IGQzpC9EimzyS/t+4sa9m1WxjhJGJdtlCwpcWgQVOt2GkYCyDGik+tts44dUuzfVSiwyZSIYA==
X-Received: by 2002:a5d:5888:0:b0:391:231b:8e0d with SMTP id ffacd0b85a97d-39973b32bb3mr6150923f8f.39.1742449168214;
        Wed, 19 Mar 2025 22:39:28 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-395c83b6a10sm22976809f8f.36.2025.03.19.22.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 22:39:27 -0700 (PDT)
Date: Thu, 20 Mar 2025 08:39:24 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: brauner@kernel.org, tytso@mit.edu, jack@suse.cz,
	viro@zeniv.linux.org.uk,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	ernesto.mnd.fernandez@gmail.com, sven@svenpeter.dev,
	ernesto@corellium.com, gargaditya08@live.com, willy@infradead.org,
	asahi@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [RFC PATCH v2 0/8] staging: apfs: init APFS filesystem support
Message-ID: <541236f7-adb5-4514-a888-19fef74c14f0@stanley.mountain>
References: <20250319-apfs-v2-0-475de2e25782@ethancedwards.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319-apfs-v2-0-475de2e25782@ethancedwards.com>

I don't think this filesystem should be merged.  The real upstream
is out of tree.

regards,
dan carpenter


