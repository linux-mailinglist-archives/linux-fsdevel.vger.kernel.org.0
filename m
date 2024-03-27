Return-Path: <linux-fsdevel+bounces-15470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E64B888EED6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 20:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23A4A1C2D487
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 19:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A3614A631;
	Wed, 27 Mar 2024 19:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmkKlSVv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B611879
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Mar 2024 19:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711566255; cv=none; b=gOXyhBIOfdNudacWrISBncMdRmH8DbVrMWl5NrpPQ8rABdzAwB+QIB2uPvLuuqnKuJuTMPBtaf3Kx2J/oTDboIo8jDZ0/kD986mx4Xv9i9/9RhJR9QQiIlYUqm7AbGO/xbIHR0CyYFerUIx8I9SclyNCcCTGNb8M7+Yidi6XEzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711566255; c=relaxed/simple;
	bh=ecVxOKAQOolSrbOrr/s3HhJgo6bANxQyJkuBA47+08o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pvZ9IgCAduuRWhWz7TM7hGHHuzAfHDbLGZEZyfm6k3k/2T0qe7aPeLIeVKjxbRe5D/qp6ElA7xP2CNSKo9mHVsUBSSyySBvn+2GyO1BayR9MnlvmV01vHFduA/EtDpoteW1g5EqccuenqeE0PK6B1+UkYk6gujYunkSDNQqNo4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DmkKlSVv; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e0d82c529fso1686225ad.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Mar 2024 12:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711566253; x=1712171053; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NuQdidlNYSnPluD7foxKQgUqq+Vutn8Nd5TL7swXZ0M=;
        b=DmkKlSVvyp7Wfzu2ARuCKydKbGRjW0QKW/F48s8jhj36kMtJsEmOi9t5Z/YgVLvYwT
         8VRTAaXkqBByiAsNnII+sqH3N+RdM+VtTmajq97H/B2U6A3hFXNLcUByETL0u5f7EydL
         6hJYrrLt3Hxci6y6soyuwCdRggEdcS/EhkekB7ijvn47hpZo7zGTCfKvba0qgkFIYZJW
         7+qm8zJipcwgffAycnR7yJIKUUZaDuG98b0Io9IftvjMC7iXOwCM+LL7q5bcbP1lEqlD
         f0XdN+2AVE3IHmALAXpG8lW1CpFOvmIo1bmw7G6dYuG/5ACK+8HkfTq18GMWBy53ANyJ
         H/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711566253; x=1712171053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NuQdidlNYSnPluD7foxKQgUqq+Vutn8Nd5TL7swXZ0M=;
        b=Er6YVn2Y/o4D8NAHLVW49+s79QnFZT76OgD1jUt7F9WxnGc+gJbca2hpPXDLlfl7Gs
         omivVP+S7qIIck+E+7HYip4jVs9yEPoHFpXVMzdTd+TTT6f7Y6HRs9P91nno0vOVx8Qz
         KfebpPizBYUYt4qwjqyf33koX+lQPBmFX5IPX9nzgmKy2Yi278ZzL+onu7CPuPbSJVl7
         ltd3kjAWhS3THSd1fQ9KVauxXi2VXpJGtD4qO9oDjnYyd1PeTyUWGgpWDAFZaBKTFONZ
         KbjVktorQOePjXRC9gt0IP/IHBe4oRTlTUt/1IS7c0iW0/W2L60vHg4S0x8T3K/0k1k0
         dXBw==
X-Forwarded-Encrypted: i=1; AJvYcCUXBdwEw1elpOpWtkO4RcLxfZYW+7mdaEbT3fgQZMX/cTI8psJvPRRJ+vM7QUNaNpILztt3mvcCGBIUjPZyCecyy6cLpcSFXkJinSPceg==
X-Gm-Message-State: AOJu0Ywht2Vr4z7uhGFNwwAJ4QAVlBtA1PDtlI3RVbr2aBVNB7pk/WDc
	CG1TeqsQCRIukLBWUQuaaBihOQZ/33uoVuiQEQ7dOLA+e1dTAVIm
X-Google-Smtp-Source: AGHT+IFMYMr6/H4uN6oN+xUQGeMwBBAOp4bBsYUx7MOIV4K7OFKu+mQq3/kZ383xbmvkmXgEfZ8l7g==
X-Received: by 2002:a17:902:b08d:b0:1e2:578:2c15 with SMTP id p13-20020a170902b08d00b001e205782c15mr496975plr.52.1711566253265;
        Wed, 27 Mar 2024 12:04:13 -0700 (PDT)
Received: from fedora (c-73-170-51-167.hsd1.ca.comcast.net. [73.170.51.167])
        by smtp.gmail.com with ESMTPSA id p16-20020a1709027ed000b001e0b60dfe1bsm7467880plb.197.2024.03.27.12.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 12:04:12 -0700 (PDT)
Date: Wed, 27 Mar 2024 12:04:10 -0700
From: Vishal Moola <vishal.moola@gmail.com>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: willy@infradead.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: remove __set_page_dirty_nobuffers()
Message-ID: <ZgRtqn8la-1wRgQp@fedora>
References: <20240327143008.3739435-1-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327143008.3739435-1-wangkefeng.wang@huawei.com>

On Wed, Mar 27, 2024 at 10:30:08PM +0800, Kefeng Wang wrote:
> There are no more callers of __set_page_dirty_nobuffers(), remove it.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

