Return-Path: <linux-fsdevel+bounces-53086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C609CAE9EA6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 15:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 864491C43C92
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 13:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8623928C847;
	Thu, 26 Jun 2025 13:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K4zMmK/P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537DE28CF5E
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jun 2025 13:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750944287; cv=none; b=IZyV2/5x2f/EGJ/gfW7Ygoi6wG/JONnBtQcY6SadgxmkpzWW3/OOImWrl5zQou42YXtDQDDZ1HSCVb6YByZgEqZPcIdY6C/q6bs7CesriALOFXlg/YYku3D9WkNZtNxCHoZWVaDfcdKX4WFMlZWhrjcoXx2TCfAb5X3nC94PDZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750944287; c=relaxed/simple;
	bh=10uMTxglxknsiw2t3ZQh4FroAAiQNW+3m4lfHYqa4NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8odV48hIJsSvAZ4qjRElmRdmwNQsNGatF172RQbIZ+sRIFdrang+yAJWetnSox01HaHNxfnzqIEtxm83IPt1wETx2mhPgre352VeLZZaFJ7cDUs9mXR2Jc7qzBMQ6CEsY9pHDUiywOfPAHSJK2Nnr8NZ9EGG6X2HSu4vp06fCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K4zMmK/P; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2ebb468cbb4so841681fac.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jun 2025 06:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750944285; x=1751549085; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QZlXkSD04zlKolE5r+OxRCc3dIBq/n6l6fhQYaRGqmU=;
        b=K4zMmK/PpZJ4azhGeAaQBhjgVEqJqamRoMRpcyeRytdXTenaRYYzv3MYjqNjcr9AkG
         NRY9t97mD2jozLp+7XfaliZhhNdEvrA+zncMd/AM/6SrUrUIuJLS00ttSIa08WUv2wLE
         FbdXpDWZ+g4qdLQtoYmot1LKdMCbG2raltHnUnfQ9cEPSFA9m3+CXLdGdq5pCj5k6BsV
         qr9u2//c4d0CtnnmI5ZQnCNMdkXj/ZDoHuHbGyxPxTnvHFI6u77a/0kTk9I90C49Ok1X
         v3ZmzulW/dpXsYoOlI87JX7J7mfT23QqxYjdxJPyfxhYi9go1YIjg+sn03Z2TIUd3XJf
         AWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750944285; x=1751549085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZlXkSD04zlKolE5r+OxRCc3dIBq/n6l6fhQYaRGqmU=;
        b=ZNRbLAeq5pFMrwTf7GTPIJj6XJeYEl3Jaq1UoytmSZX2ksdLNoQZLUhUObbo2VkI+L
         oe3hsjE604aNbz6AHAewAzAa0+V9hVoUGmKRRhiy2PPkHfuofPAvgAyWhgVeCw4frNp3
         QGJxlm23D5hRV87MEXurJGNawfQdoebbzVd6Ji3kBgL9xyPZ7htPTt+XJxLpUWfj3CyL
         hxRez+2D0timFtTuAfHupWaLgwetDvTw88HNT4kvICVjl4F91Mo+N2efGxtYjgO/bow3
         HUW2NP6FpmYgLmCLZOgXzHueD9Wud5TVTGcB2mdovUAvrwltCaU15wioEUZO8YCWG0UZ
         oQAw==
X-Forwarded-Encrypted: i=1; AJvYcCUbsxS5noVQoeNH4P03ubuTI0D6J/Nvv44QmHGLi4LoeahRt6mHiBxyCIO009LqwfPfEX899ks2mcbTWcp9@vger.kernel.org
X-Gm-Message-State: AOJu0YzocfNZHABY3cA+ADefI3WjFRh2/mOknDnF8ZtpWcaiCED6Vt2c
	vcolTIY+u7oUssb806/PYLIhDaQ6jIiGu7/VEy5h54hObbqI8z/0uArHtyQxZeESskcW3igtI3v
	NX4jd
X-Gm-Gg: ASbGncvgfRFEsHXhIGoVnxWCIj3zzZAzFzakoOtjs+VoF/GdHmJDolNKRoULQrpYGXF
	lS99KwuyyaXMyRzhVnJlsnO1RmpPYMZpD4Ss+louKMKR2htugybl1b9tNxMGnlN9SNklAQL3Sbz
	xbMBpr3C3bYg2GbZ3s2cEE2PcCn60wXW+BlgHwKl2idf54ZmDaRfpPKHHCd5oR9LmXROzKzNM2U
	NneV2Lvy3Jf4mw41o//4tz8iQ0ovCA2ibMIZqAnOjzeMLZOdnfJpE34dWXXkf7WycqrKOU8vU/w
	u19L+SAp3x3IRhQeKcQWlEYKBXFFShILVSeit55zjCD9Qt4lGXybwM9F8Ac+I9TuYxY=
X-Google-Smtp-Source: AGHT+IGHmrXQmGgiM1O4FMJI4ioJnomDeQhk1q4uAMvdGJQNa+bA3kRfvZeSRk6fLbxwCVrLnDbVRA==
X-Received: by 2002:a05:6870:898e:b0:2e9:11c9:1093 with SMTP id 586e51a60fabf-2efb27ce26dmr4871522fac.31.1750944285390;
        Thu, 26 Jun 2025 06:24:45 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:3ee4:904:206f:ad8])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73a90c92150sm2575206a34.39.2025.06.26.06.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 06:24:44 -0700 (PDT)
Date: Thu, 26 Jun 2025 16:24:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Su Hui <suhui@nfschina.com>
Cc: akpm@linux-foundation.org, bhe@redhat.com, vgoyal@redhat.com,
	dyoung@redhat.com, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] fs/proc/vmcore: a few cleanups for
 vmcore_add_device_dump
Message-ID: <e891bba8-9f67-47c6-8f84-a62abe35f837@suswa.mountain>
References: <20250626105440.1053139-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626105440.1053139-1-suhui@nfschina.com>

On Thu, Jun 26, 2025 at 06:54:41PM +0800, Su Hui wrote:
> There are two cleanups for vmcore_add_device_dump(). Return -ENOMEM
> directly rather than goto the label to simplify the code. Using
> scoped_guard() to simplify the lock/unlock code.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


