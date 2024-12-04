Return-Path: <linux-fsdevel+bounces-36458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB389E3BA4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 14:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 319FA164667
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 13:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2731EB2F;
	Wed,  4 Dec 2024 13:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eApxICY/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E3C1E3796
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Dec 2024 13:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733320067; cv=none; b=g07dZHlZQKG9M7Uxav1f4XISfR+CwSeS8jIbAkwZDOlQeGjmBGkC+ABARYZj7L3U/CJDeN7i7abpMpb30rgYIV82XP+7R/f2Jk3TXXnv4RERdJ2EH336qi1KSokwYRU9pMwkUrpDD0YdyDtCL8ZE2hIg4qeBCzQ9Cxviqbl2ut4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733320067; c=relaxed/simple;
	bh=ib4ZYhNME2h4KsLa4ic3G4V9/qS8Z9aV7KvXlNY/sg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AyfTq5zbkVOLdFMPahL0lZVJ9YYQk46cmkPda28XT0WmahkZu4UHlnX5qfqPw7UXiJa3LZGljTOVHsHnKvSEo50Dzag67Q0vLjo8Jn+PGyeWIYOEsTWgZNNEc/wLnHbEh6cniqWoDXMvK1TJhj1CyxTGuQok8789l1INjLZkbnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eApxICY/; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-215a0390925so35055035ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Dec 2024 05:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733320065; x=1733924865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kzUoMr5e723kQpTrozPu/A/+hIuPBVn34wkrGl4v8Oc=;
        b=eApxICY/RPhR0G/5dfxQk7bxAFDOcnto+o1aYtxVzRo4P9WnrbAtpaA+8O44UnAZyO
         M4gZdYDPQySu8MfLIm1lfMZLIX6zBiXElLR9du7Dcz3dSTMyuLdmIV2Y/wE4hxRt2sCo
         JNEBkRHnd8uCB30vaLyvF2XAsEDLmZlm1VhIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733320065; x=1733924865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzUoMr5e723kQpTrozPu/A/+hIuPBVn34wkrGl4v8Oc=;
        b=EN9TGLE1Gzw2rYlbKhcr0qdJMCyWGVKwaL/Wz1qQy8WORpxEkAoHQCMQlqQIR/9dxP
         qgj+oXK5IMYkB9uF5rStF+dE+ReizMbDyDzxOGcIhfqTMUb1Khv38wFI6UpvR1EDGRDw
         2Jt3jt5Au9VZW5jP8XT0T0qeUBWAsoZ5MTYRyNWtDddyX0zMsL3QyCGF1StTsfJ6RO27
         UK5ceEi6GNNyLlztg9khmRisnkGxI+sRGL4aP56Xi294mUKROs3znCafK0MFlB8xoH7J
         Ye/ies6VC7WqZGrTm9u2oR9Z4KKN39KLy5RdQ6qwZIl4SDor9CYl4JDH+ioDuj38lxcW
         odMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwz/kkAVDv/Z3derz5CKXTnoPaen3LPfzFgyvl7WVf5WfCWmpeW+EnPj98W+CwZyJRxoMJu39vsvBYg2s3@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1cp1chHLKAhnp4GfuWcZvFcmg29g+uK6AgPxfNNDcvjlr0zsD
	RDbsOWontwWuGw8I8mZKYPa8a6ON42mmj4RFgw00AFCIkWoleZZ/gmpXkd0Aiw==
X-Gm-Gg: ASbGncs03y7TR3gzY5+MgrPqDSShVh6MMcG3WLnUwo7ESuO3760SQcP6k6YsmamQxFS
	05lVyZ1dYZv/ioyb1tNZJSYm126heUrhwtO0Hy1eRLrbCgSE2wqeCrm9VaUB5Ej1Lb4cubqLDLh
	kUqnDU9dzyHIM8ttX7iMwiY5B1WyAjEv91bBCafIz8Zv65KDCltqZhUpg+Vt/wF0Sh0myvCrP+q
	GHRvI8BSDGA8uJFLvcooEIJjCg2vAHiJwcMSrJxThMl8EpgbHuO
X-Google-Smtp-Source: AGHT+IHve0tQ1dTe8O41UsxAhcN9OWT71r93ua8O6+GaRqxIqfeAXw/xOXxboXDMcxymPyor71wHeA==
X-Received: by 2002:a17:903:1c1:b0:215:6e28:8260 with SMTP id d9443c01a7336-215bd266031mr77835375ad.50.1733320065581;
        Wed, 04 Dec 2024 05:47:45 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:84f:5a2a:8b5d:f44f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215dcce51a7sm11483055ad.217.2024.12.04.05.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 05:47:45 -0800 (PST)
Date: Wed, 4 Dec 2024 22:47:40 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com,
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com,
	laoar.shao@gmail.com, kernel-team@meta.com,
	Bernd Schubert <bschubert@ddn.com>,
	Tomasz Figa <tfiga@chromium.org>
Subject: Re: [PATCH RESEND v9 2/3] fuse: add optional kernel-enforced timeout
 for requests
Message-ID: <20241204134740.GB16709@google.com>
References: <20241114191332.669127-1-joannelkoong@gmail.com>
 <20241114191332.669127-3-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114191332.669127-3-joannelkoong@gmail.com>

On (24/11/14 11:13), Joanne Koong wrote:
>  
> +static bool request_expired(struct fuse_conn *fc, struct fuse_req *req)
> +{
> +	return jiffies > req->create_time + fc->timeout.req_timeout;
> +}

With jiffies we need to use time_after() and such, so we'd deal
with jiffies wrap-around.

