Return-Path: <linux-fsdevel+bounces-37418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0889F1D11
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 07:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A403E169560
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 06:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21E385931;
	Sat, 14 Dec 2024 06:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H+jXYdBX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5443A268
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Dec 2024 06:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734159199; cv=none; b=I+zeotaxPol827C1Fe8ArYzMEKvWIb9VUjcM8Df3WOY14rZLZYGho3YlC+fH25KI1MsjIOCc9r8X2A3eEiC+wQ26WaP3wPQD3SqDVtWwksXYHqmaM94pPL47Ia68APa2V2oQ2Z4TJ2W6Eyqe9GjiCaajkVGrcZkYcJf5osNw4Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734159199; c=relaxed/simple;
	bh=PvPm6jWwn9Q058OQ8WYvHUc8ituSl9JXqorJvvwUz6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mapTSP6mDiIwatEJ8wXKkkaMDjgxSBT/8iLd/X04o2YGbDEVtcchtlKoMKbXZ95nMFMzTltPZ4SusFA2V4Oh/niYVJ7LOaHfCeNtq3ZM2bopUi5xteZQrwtxGJXk/Nelbf2FINcRFT2Ndv4gbu2kZfXHLbAGc/vmSSm6Ci9dlhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H+jXYdBX; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21661be2c2dso19282165ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 22:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734159197; x=1734763997; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ovUtyss6q4fOarpWpGBAOFr3xsC+g23NNjOyM5MAPV8=;
        b=H+jXYdBXwwoTQkuaM8dHAcBIbL8cOvrcfJMlMSUGXsa+fO8MSzSVf7/1Of9cMb8tCV
         0CGQw9aunKVo98N9v4fMLy8lsnltX8vbEkzngDed1jIaItmBEUAEVctdv80g/DwUXJYn
         n8KuSFTh8y+hNEKtE0rLTVNHOW/DhCVx2cDAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734159197; x=1734763997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovUtyss6q4fOarpWpGBAOFr3xsC+g23NNjOyM5MAPV8=;
        b=qSYYz2OFOL73QTQ1Ne37kR2kfjZWkdiea26CiYI2dTJ01QlDGycPRsMM++zfqRSUbC
         hIgYeS6zZKpRGaXXLLpRMbzrxvLpkCyFwRSXDAb+dmVp4mmqgDf9+/sTFemxxzE7dyUl
         GhfCb50zIYHnFydMNg9ws9s4gz33gJlumsUTqAMtM4TKTBWbaRa/DihNGZcB+TAE264o
         S44TuHWMzsv/VAJd+MeodyVNBfCYk9CnL6hcu6VpJqqh+6jtKouvAj1ZkX4BhdwSKT+a
         SfUU0esHuW4uJjQYmqs70mPBZr8FAWf4hGapU3IvMXQ8PHA7RJRdeoEAXTQCR0MH3DOk
         Zn2A==
X-Forwarded-Encrypted: i=1; AJvYcCXG0udQU3FdnodfUNXdJNEiWI4338AxR/JS+Q91Zb9Bp7tlCFWbaYf1OyGzEANHs4zCgS2lrs6jd28JTtls@vger.kernel.org
X-Gm-Message-State: AOJu0YzOFDxj5bLLr0KU/lFyCpZg0js3qEQVj+c6YF9NgdXbRH8dIow9
	t7uHYx0hdOUJdZQq2AjcDtdvA1WEqVT9B2sobZ0CH+r0KW//+7o0ko8Fiy93nQ==
X-Gm-Gg: ASbGncsr6X+dzMeFi2JIzVP3eSRuYZj6/RIOKYk0Frk0hZ3Q4TSBKaUkMVzTy9wT4R8
	wArHGtQusk4ooGv0kD0ojVfTxqvxCOkiqNpfDWIcj21SB8WYJDAq2Tb+WSrLkkJqZlThSyKyyKy
	QUyBuoGXhhfH9VUvjQg7BmC6DT3q/9y/iWD7LFLr68PjdzrkEFDKIUoQ1Y8ul+TBOWm3UlNNP5m
	fj8M0KHYJtxsAhM8uCgy6ptbl+hQ7E0KXGCxOC1jHeUsWHE4bbm8xCL/FLI
X-Google-Smtp-Source: AGHT+IGEM+QbCAosbY+6eEKDmO1MQQwfruQWLaA9Hn8aVaRgnioqRc5OrzpV4ZQsP6pjfyRDsUijGg==
X-Received: by 2002:a17:902:ebce:b0:215:9d29:b440 with SMTP id d9443c01a7336-218929a2156mr73178465ad.17.1734159196883;
        Fri, 13 Dec 2024 22:53:16 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:c0b3:7d31:f643:dd61])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e728c1sm7165935ad.278.2024.12.13.22.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 22:53:16 -0800 (PST)
Date: Sat, 14 Dec 2024 15:53:11 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, laoar.shao@gmail.com, 
	jlayton@kernel.org, senozhatsky@chromium.org, tfiga@chromium.org, bgeffon@google.com, 
	etmartin4313@gmail.com, kernel-team@meta.com
Subject: Re: [PATCH v10 1/2] fuse: add kernel-enforced timeout option for
 requests
Message-ID: <qmxxocm2vazh7uu374t7hcgf5dxt4757fdcer7d2wxffgtp64t@o3s4icrss5f4>
References: <20241214022827.1773071-1-joannelkoong@gmail.com>
 <20241214022827.1773071-2-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241214022827.1773071-2-joannelkoong@gmail.com>

On (24/12/13 18:28), Joanne Koong wrote:
> +void fuse_check_timeout(struct work_struct *work)
> +{
> +	struct delayed_work *dwork = to_delayed_work(work);
> +	struct fuse_conn *fc = container_of(dwork, struct fuse_conn,
> +					    timeout.work);
> +	struct fuse_iqueue *fiq = &fc->iq;
> +	struct fuse_req *req;
> +	struct fuse_dev *fud;
> +	struct fuse_pqueue *fpq;
> +	bool expired = false;
> +	int i;
> +
> +	spin_lock(&fiq->lock);
> +	req = list_first_entry_or_null(&fiq->pending, struct fuse_req, list);
> +	if (req)
> +		expired = request_expired(fc, req);

A nit: you can factor these out into a small helper

static bool request_expired(struct fuse_conn *fc, struct list_head *list)
{
       struct fuse_req *req;

       req = list_first_entry_or_null(list, struct fuse_req, list);
       if (!req)
               return false;
       return time_after(jiffies, req->create_time + fuse_watchdog_timeout());
}

and just call it passing the corresponding list pointer

	abort = request_expired(fc, &fiq->pending);

kinda makes the function look less busy.

[..]
> @@ -2308,6 +2388,9 @@ void fuse_abort_conn(struct fuse_conn *fc)
>  		spin_unlock(&fc->lock);
>  
>  		end_requests(&to_end);
> +
> +		if (fc->timeout.req_timeout)
> +			cancel_delayed_work(&fc->timeout.work);

When fuse_abort_conn() is called not from fuse_check_timeout(), but from
somewhere else, should this use cancel_delayed_work_sync()?

