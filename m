Return-Path: <linux-fsdevel+bounces-13897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2A68753E5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 17:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3997D2884D0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 16:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBED212F5A5;
	Thu,  7 Mar 2024 16:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="eJ6adZkU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D49112F591
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Mar 2024 16:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709827747; cv=none; b=aQipWelHFngGumWkNdDNTOBFGxPhfPKnFV83Tv1Tc/cxrTzthO143PQuw1XcHJXrSRNrHzHkBiel1OM9sBJT0mCEy8TbcFZI21OMrb4cV55hcYd9yPQkYeIhP7a7ED3nwMSrZrTHos/laV42evtid3/pH6kBnDE2v2Fk6m9kFSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709827747; c=relaxed/simple;
	bh=VShIXT73MAXgeFss65aUSNVG53DbXImxcP4suiSCc5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qK6uc5qFpV8rCL7iWD5O4KBwX6DUkjVBDyGXYaI/XK96Nom/X50X2evIvGjHfHztHFv7YiIYtMy/ZX3rKbDPB4cKMyl2bsvkWJ52vs7QNEicNdY3Kr3yDoL6O4kZvwZixi1/JAEdny4otYhaL6mdLjdPOACqE9wDNWiOJdIAFQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=eJ6adZkU; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-609a773ec44so11626687b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Mar 2024 08:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1709827743; x=1710432543; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hHm8nGgROAcOqxTDPPtoKylfSrTXxBIq6ORy1vurVQo=;
        b=eJ6adZkU3TVy0huxAbIARDErx5kFfKoy10+4+73zrvozDh3tqkO2OK3CZHsmIv4BoS
         9Xp1JlBj2MCTX0JzKvB8hqGIoa8yytWiPlRMqvRfNbT30ScUBSVK2W3tzmv44+bPTNhe
         38K32z95CcdCYT/R2Fff+NGw7BCywWNVlazvMnpjoj26jxK4kaSYvlGcJaSqlWa51X/z
         ePns5pSrPHYRBPG6bNdparccTMsIGnKdiUMvJGpI78gKfHUbiEFE8mmOYWvbY1Vb5MZD
         jKjmULK2jCCPZ4xP2scrRH3VNewhyPIRLwKaSUz2RgXsvMJvysMgIqs6hfbfKtGWbIml
         cT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709827743; x=1710432543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHm8nGgROAcOqxTDPPtoKylfSrTXxBIq6ORy1vurVQo=;
        b=VJlI4pZI3TksHk6Cfx3rECKgrK0YxIKEEHOGd1v4fZLaoT/gt+NC4rp5m0BnOBITLS
         +ZQPbGJPpRbA1IWQUwEled/7U7hJ3rV8Yna2bdZq0llSWS37IPARn730ES2PnCV7ttXV
         DQUU2nu8lSufnZDmA3gsdmqcUiY6bVMlw50afVKvWCxzsRu83Tw3OTWktZpFzsO0fVql
         A32WrO9ylMmF3k4poUfOgWeZsL8rMFTFpAgGbg3jz3GwaAIgWFp2nqZv3SFLTbgYTxoO
         0Xlnxl4SXF+JcWemU/whSgWIYzuJQlY8WV0kDuvVoXAxem6+aJNN6cw7ijNi50SGuota
         xySQ==
X-Forwarded-Encrypted: i=1; AJvYcCW53vvErtNpRYTI11iBq71V5kzk9uHhzxTPsHPyfjtLxWq6rJ/6mATKGkKypNE5B5LnLtQaB0hNHqCLDcIQJU/P4409J0noWIZq/3ZKiw==
X-Gm-Message-State: AOJu0YzE1obXKCfrESP5D8RfL7VnU1+bcnrI4p7+HZgLMDX4no5pvgj0
	xR9/ON9yG2nCgK8XowuFUXs/xSx7MF3VGZG/Ts4ebeKK2QscG9MM5u0Y1c/1IwAjZ85oI6+dSBv
	E
X-Google-Smtp-Source: AGHT+IEp7P47eTldxQ/lB0t2ehOQnt4BhgQ4DyPGY/xvEh/nAnBGpcBbfi3zTS3EXwYKXYXSc/AMPw==
X-Received: by 2002:a81:7b57:0:b0:609:21b9:4187 with SMTP id w84-20020a817b57000000b0060921b94187mr18407561ywc.32.1709827743266;
        Thu, 07 Mar 2024 08:09:03 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id l205-20020a8157d6000000b00607ff905ed3sm4285717ywb.58.2024.03.07.08.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 08:09:02 -0800 (PST)
Date: Thu, 7 Mar 2024 11:09:02 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	amir73il@gmail.com
Subject: Re: [PATCH] fuse: update size attr before doing IO
Message-ID: <20240307160902.GA2433926@perftesting>
References: <9d71a4fd1f1d8d4cfc28480f01e5fe3dc5a7e3f0.1709821568.git.sweettea-kernel@dorminy.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d71a4fd1f1d8d4cfc28480f01e5fe3dc5a7e3f0.1709821568.git.sweettea-kernel@dorminy.me>

On Thu, Mar 07, 2024 at 10:08:13AM -0500, Sweet Tea Dorminy wrote:
> All calls into generic vfs functions need to make sure that the inode
> attributes used by those functions are up to date, by calling
> fuse_update_attributes() as appropriate.
> 
> generic_write_checks() accesses inode size in order to get the
> appropriate file offset for files opened with O_APPEND. Currently, in
> some cases, fuse_update_attributes() is not called before
> generic_write_checks(), potentially resulting in corruption/overwrite of
> previously appended data if i_size is out of date in the cached inode.
> 
> Therefore,  make sure fuse_update_attributes() is always
> called before generic_write_checks(), and add a note about why it's not
> necessary for some llseek calls.
> 
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

I had to ask questions and go look at the code, mostly because I'm not a FUSE
developer.  fuse_update_attributes() doesn't actually do anything if the stats
aren't invalidated, I was concerned we were suddenly adding a lot of overhead
for every write call.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

I have a question for the normal FUSE developers, how would one test this?
There doesn't appear to be a mechanism for writing stub FUSE fs's to exercise a
case like this in fstests.  Is there some other way you guys would test this or
is this something we need to build out ourselves?  Thanks,

Josef

