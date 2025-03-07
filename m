Return-Path: <linux-fsdevel+bounces-43470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED51A56E5B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 17:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C18CA189A479
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 16:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C547C2417D4;
	Fri,  7 Mar 2025 16:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRYfCV0o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD2A24169B;
	Fri,  7 Mar 2025 16:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741366263; cv=none; b=rjpWYbJK/xAe2YyhreT9kjCBKnsveof1O1vmiNmNfpx6oVJWGGT5KvAGFAtNL4ixE846NPArgxHSYNr5enI7toFAmiMkpaGQQRI0oR8DnV7Ttv4tcp7hQhpDo+F1Ss0rf8NkYVztsYzIcmMwyhlKDgn2Edp+xJFnqDb1pfaX3Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741366263; c=relaxed/simple;
	bh=cS9Zb1GU4eE3BvyFwVLVC0TTxdlswEgP6RUyYFegNdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B47PrP+5neCrI7H2Ltg1ePnvDMGD5KSowMTT4SARnvbk6VRFZvZtFfFMUS4fHYiAcb1UIgeJbl80MTGHKc6jStLHtb8HTkRRuVqGNR+jEsrUSiG8+4kyFRQH5o9MNA+yM+DofK3m6uxoR5tTcpIvJanyWxK8bD42P274Vx/wUHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRYfCV0o; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22113560c57so40200475ad.2;
        Fri, 07 Mar 2025 08:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741366261; x=1741971061; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cS9Zb1GU4eE3BvyFwVLVC0TTxdlswEgP6RUyYFegNdc=;
        b=YRYfCV0owSuxVz8qWAE/QYlb9d89C7CftaRqZGyWGf9AIwn5BO8wAGES5IOX1iMe+C
         ddvw9wgTb/T9ApqI92MiJQvk4byx3s2qlNgZloiz/2+4/unnUb2AWlD8aUPUaA02kkV3
         Um6ePEdet97ccOe0gNQb25gJw67BzlDLi+jcgbJaQbmg1I3cqncy+dLvoSgLoTwd4fJP
         QzgT7QQ9kA+TgMj7Z6vIF5JVgdFQiMUPrajVfQZKCXSi3q9cMnCw2CUh1ykC4CH8xn6K
         n+yKp50/VRALj52XWZuyOeoggJFFqogWv/u4btJl58KtSnhE46cWVJJn0/PMY0m+zVq2
         W3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741366261; x=1741971061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cS9Zb1GU4eE3BvyFwVLVC0TTxdlswEgP6RUyYFegNdc=;
        b=M9sBS686pF+4DwqUTKeoJU6CToPyPby5OBs/WTY14onh9CY02DE6MptdBhUDEcOAg1
         SASUqCHGfRiMAr68Rfv4xhNXVjFBmSjKqohCCZGwvuVSzqZ9sgtXQNco/lcwe5bIeS34
         1BaJr4aNMVzrEu70afrcYafgQiWPu3KMjtdlp/lKmmT+7NILMHRHs7iT+Ca1pI3yTAUi
         BarCY2VRHQyUvx755prMY23SYFr92wC6AZmVS7cuQEJ8OZ/nvsxuI2+b5KhFC0eLNgQA
         UL5YtEjrl/9bMkX3TwBU9oOFn3+pWhmkALxnu4jcZAaqZsY4VbgxJVaIzYCjAedeka8f
         yxLg==
X-Forwarded-Encrypted: i=1; AJvYcCUoax8p5BaqfkVhwFS3WIyp+BrEvEWiIWjwwOe8T/G12owXftd+2qq9QdnpBUF9BvpaXpMGO7QhDGvg3ag2@vger.kernel.org, AJvYcCVGE0rdqB/Q1zVCxTzThJ755K+lK4gB7x6Me6ccI7LWjbtYa1b3okYyluoR/fX8GoZ7Syc88InkvhA25z+V@vger.kernel.org
X-Gm-Message-State: AOJu0YxPCWoQt4J0x1CFnh12V7f1IepN4mWNnxyj8zg7w0z8NvMs4/pw
	xCVy3kRCiKCZ7mkqmArHzEXMu0Dy6wiM9hFf3nTlH9GkPUhI5GbF
X-Gm-Gg: ASbGncsj/GzEHIYlNYxxcAGiOPyy9v9YpUoYtGzeFTNQFHdQWwsNrqRS3cRd3VWSAbb
	u9KStw/GFERTinode4pPEoeQzC7tFvg4Xajjazftxc7VTdtay4u72bmNvVfQjSDSP9J/hhrhirx
	wQbZUfySVaZ1A79I5irMJVLs98/Y2A2BzZLNvlm6MZR078qCUEv6idrLjoYHwCxrbOtqxL7S3gH
	CxP0s6RRxm1rR7/OEIrDvtSeklI9aUTq45q1+na96gCOOvLCrEqFQM90NKQY208S8G42AlCzgU0
	SyCTXG+aKuHAQMFwacVdxEvtbmayofDMCHvSUbaA+M4c1WJ9zBKC4g==
X-Google-Smtp-Source: AGHT+IH6wTdVSrkEWzxPXeMMRaiQrPUn2JENVyXLqhw3Yh4hYsLuRU+w3/MgwsrvFwKD90HG2+mNGA==
X-Received: by 2002:a17:902:eb81:b0:224:1935:d9a3 with SMTP id d9443c01a7336-2242888ab01mr74689915ad.21.1741366260807;
        Fri, 07 Mar 2025 08:51:00 -0800 (PST)
Received: from eaf ([2802:8010:d51a:1300:38a4:5444:b138:8488])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109ea390sm32354895ad.69.2025.03.07.08.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 08:51:00 -0800 (PST)
Date: Fri, 7 Mar 2025 13:50:54 -0300
From: Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?= <ernesto.mnd.fernandez@gmail.com>
To: Sven Peter <sven@svenpeter.dev>
Cc: Theodore Ts'o <tytso@mit.edu>, Aditya Garg <gargaditya08@live.com>,
	Ethan Carter Edwards <ethan@ethancedwards.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
	"asahi@lists.linux.dev" <asahi@lists.linux.dev>,
	"ernesto@corellium.com" <ernesto@corellium.com>
Subject: Re: [RFC] apfs: thoughts on upstreaming an out-of-tree module
Message-ID: <20250307165054.GA9774@eaf>
References: <rxefeexzo2lol3qph7xo5tgnykp5c6wcepqewrze6cqfk22leu@wwkiu7yzkpvp>
 <d0be518b-3abf-497a-b342-ff862dd985a7@app.fastmail.com>
 <upqd7zp2cwg2nzfuc7spttzf44yr3ylkmti46d5udutme4cpgv@nbi3tpjsbx5e>
 <795A00D4-503C-4DCB-A84F-FACFB28FA159@live.com>
 <20250306180427.GB279274@mit.edu>
 <4e41ef2b-7bc3-439c-9260-8a0ae835ca02@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e41ef2b-7bc3-439c-9260-8a0ae835ca02@app.fastmail.com>

Hi everyone,

I don't mind putting in the work to prepare my driver for upstream. I just
can't make a case for it myself, since it sounds like a lot of work for the
reviewers and I suspect it won't be all that useful in practice.

I think the driver is reliable enough under linux-only use; the subset of
xfstests that I managed to get to run stopped finding intermittent bugs last
year. I'm less confident about our compatibility with the official driver,
since I recently fixed a terrible corruption bug for all shared containers
above 1.32 TiB in size. There is an official reference for the layout, but
it's incomplete and has a few errors.

> > (Although I suspect many external SSD's would end
> > up using some other file system that might be more portable like VFS.)

That's what I would expect too. The driver does get cloned a lot, and it's
been packaged for debian for years, so I guess some people must be using it,
but I don't really know for sure.

> > In terms of making it work with the internal SSD, it sounds like Linux
> > would need to talk to the secure enclave on the T2 Security Chip and
> > convince it to upload the encryption key into the hardware in-line
> > encryption engine.

I don't know much about the hardware side, but I think my driver will also
need some changes to get this to work. Right now we don't support any form
of encryption. It's the biggest missing feature I believe.

Ernesto

