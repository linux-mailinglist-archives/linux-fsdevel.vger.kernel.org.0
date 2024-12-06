Return-Path: <linux-fsdevel+bounces-36604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5AA9E6565
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 05:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E44C1884555
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 04:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E87192B71;
	Fri,  6 Dec 2024 04:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NeKEhiVP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622B3190063
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 04:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733459306; cv=none; b=IbEb4luVatz1zhPahocwObGWD8w+m5tRbnpI1OiQc6KTolt0LZ7ZRua3vCrKyGq2YOeDQe6cqUhe1/RojdsDHcpunCu+OgcGuomNUAEa0eY9LTfFY+fhrJqip+xh4RFJe5EV3adkwDcSI8XcVtXFDQBqI1t91Rv+SsrhWr5f27o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733459306; c=relaxed/simple;
	bh=nTqsfAkvYb3wYzxpU877FEhHNpnmONQjZwimww8Xw/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2BujW5Z8YzGhODQpg+oV9XeG3t5YKeTcomDuo/uzPr73RzC3SsvKgG3bYU6QVD5gF6BZHnHFn5kFkScB6IU38Hq6pTnicmM6ZcAkt81h1lIacPK/y+5gepG6MwTf2z6c+YxQFPt2k12sW3zTwt6Ry/SmqymQaanQUslAytY4gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NeKEhiVP; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-215da73e256so14371055ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Dec 2024 20:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733459304; x=1734064104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SY8v+4PLeh8zjowoGoALe3qdJUrtZNI4n2BzHNfcYOw=;
        b=NeKEhiVP7cCcb3wHldcJNFPfh/nibwo8BnbnC3Nul2z5yoKDJ78Db0iWjhwYeWk9mw
         G8l86Em+yQFjAWUHyecNnWDB+3mtYLeNNJgLPwWNl+o1clXLxzrm0kWKzkyw8hj8jSdP
         0LlkO09zpD91kdXSuCFMzgfP1gBvqeOmGCtEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733459304; x=1734064104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SY8v+4PLeh8zjowoGoALe3qdJUrtZNI4n2BzHNfcYOw=;
        b=IT3JNmbbBLeEggKp1G+1AiT5ykn4IwdXsKP8njkRN/riNDD5MmATbRtKsEo2eF4tG6
         FN/+tDHEjvnS4DQNZvck/82NZggNKmb8PSwgP68eTTvsTQ6WxY4UKJV4hwpKxDf4xruq
         i2o1+Q39tGPJSwhc47JUCK8OgGzke78FWRbxMklCgk2FF3EHulOatp1dwaYm3sqSeH2D
         WqSyICD4qkgqmAP7g3kC78UQe4qq0qlZZTaYlcqKMoUVVe8mg1o2y58JaenWuc/5E6iO
         A2qUmFvFPxXiuKD37X+RadacirhcTapyQ5Wj6ZGGMKHjfRAmr7X741N3WtfBX6pFQTZk
         OX6g==
X-Forwarded-Encrypted: i=1; AJvYcCWtEljFq0oGi++SGAHKgZ6e7pWkeOtJn9XgaNxzmh1S+53jT+UTsEv2XJAHP2yj+iC4kXrr6HH5xoHvWTpL@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm9l4NGqIUTTRS98L3/c3jTnmkw1J4rvNZNEUWRgAdAlF6kB/p
	n2XQGLN8LfYoRWJ5TLap/cHWdlzsif18T8/pI601nzgIKTJvBRGtKx0O+5HLtw==
X-Gm-Gg: ASbGncvKQF0e/x9gFI+4X9pX9kGFj1tNqlUooold501pIAhFQ1tjEDX735iv1vqZNe/
	h8nvPZiF9/edB9QmQMW8qPjPwBfXn280PmHMtbIgv3HH6qiGDixCiPw2xhdzFywNs8bpQVKPTV5
	ypKiRFww3ICP9UckEd5YdwqTpPNBfEroESAJLvJjMegy2pLQbw9yVGI1OrMq2qBSaj67q7PODTc
	RTQpknSXwIZ5sqHdNRSaoif8j7CtunwfqHnxES7Dube3tYnvALtyg==
X-Google-Smtp-Source: AGHT+IHwTZ7nT1w0biaBWwBO2Nb0l9by5dP158AgNDOftgypxlwINxQ8XRoong2MDb1EAGpNlf6O1w==
X-Received: by 2002:a17:902:cec7:b0:211:f674:9d60 with SMTP id d9443c01a7336-21614dcc0ecmr20388485ad.50.1733459304641;
        Thu, 05 Dec 2024 20:28:24 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:5e1c:4838:6521:8cfb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f31a28sm20237835ad.269.2024.12.05.20.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 20:28:24 -0800 (PST)
Date: Fri, 6 Dec 2024 13:28:18 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com,
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com,
	laoar.shao@gmail.com, kernel-team@meta.com,
	Bernd Schubert <bschubert@ddn.com>,
	Tomasz Figa <tfiga@chromium.org>
Subject: Re: [PATCH RESEND v9 2/3] fuse: add optional kernel-enforced timeout
 for requests
Message-ID: <20241206042818.GH16709@google.com>
References: <20241114191332.669127-1-joannelkoong@gmail.com>
 <20241114191332.669127-3-joannelkoong@gmail.com>
 <20241203110147.GD886051@google.com>
 <CAJnrk1bwYjHGGNsPwjsd5Kp3iL6ua_hmyN3kFZo1b8OVV9bOpw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1bwYjHGGNsPwjsd5Kp3iL6ua_hmyN3kFZo1b8OVV9bOpw@mail.gmail.com>

On (24/12/05 16:06), Joanne Koong wrote:
> Interesting! Thanks for noting this.
> 
> It looks like the choices we have here then are to either:
> 
> * have this run in a kthread like hung-task watchdog, as you mentioned above

Works for me.

