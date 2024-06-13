Return-Path: <linux-fsdevel+bounces-21651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8139907644
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 17:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9D261C23630
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 15:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CB61494B1;
	Thu, 13 Jun 2024 15:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yx6Le4s4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1681494B2
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2024 15:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718291607; cv=none; b=ro+/bo+JMgdQ0LEiAkx8W6sBAl/zZsZIPXLk7dCCr+8ILcYGBRN5NOqp2PH1In7Te2pTLJi/JQWL1SgxJ4DKTXLN8VjoVqH47Ehnzv2Ee11kMxv1e2F+m0ify5hAHHLH+lSeR3BDkUxLOXTZCQRaAy9ysjRQJTfJti7p4NlId90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718291607; c=relaxed/simple;
	bh=MRLorm5dT0yrhPD6Zg2GHk7D02pLQWXOMSZO/zNhNW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MwRfy8tv0IZyjdc43BQ2RRLPvvrhBVD+YO3ZNdUuv/8zISoAAQgqY9A/soG0Ag7B8XC54V4f2newPUWbi0nDXeLbipAUojPArvy3/4AhVgitzIecIa2Y59C7HT22pfsRBkHtxSU5WWux5eDxrY/Ke3SOpmd1swE+VG56nOjxPX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yx6Le4s4; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-421cd1e5f93so8908385e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2024 08:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718291604; x=1718896404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R65OusWKx0dwBMqQhrrsKrto+TvW16AkPUtwQVoox2Q=;
        b=Yx6Le4s46i6tYvKc3HGKc6uYR72kwVZ3eKJQZVEWXWPVxgT+o2HBLbacPnIFHp5Sb8
         xvgvF6G6piONyUqvsIiMQzwd8Feu2fGjHZjaovPJJQS7oDvjFQVSvRh/ZOHTKaFZpdcN
         9VPNRdNI56PSx2cjKMqOL4Qph2qiwgTPBhZVsNgzV90ANl1LRNuRFzqheeY03ns/vV/P
         jShHyR7yizbHpHvmVVlmrPzPpMmwmF099n64uCRLeDOFSBe+Ul/tCKfMRqN0FXEM5xlY
         fyf29+Z2gI7ap5eOt2JoqdHsi6GgYXQEx1svIsfE23Kwt0aBC3vR2CWA+HzWSvT15zzu
         YsSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718291604; x=1718896404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R65OusWKx0dwBMqQhrrsKrto+TvW16AkPUtwQVoox2Q=;
        b=DSbwi+lXyUS0deo2q5xf5zuxcU8/3K2iGh6bBtTVLn0avc8vsTu8QnDGNNX4/HCKLb
         DUpyWMrQ0kX4HPUM5QCMHBmS4JFjfpi//g+INjHJBX588nAvOwikMWlMHR+f1j21NHv5
         8qefD14Eis9u505t6hcIhOhck36qLb4YJAVds5hf5EB1EUEwhi+wrtx3sw1bt3JJS823
         Pw/XlyhxeS+tVkFBctY1vL0cJMO4F8GjCteI5/RBg+jqU92lu92bsNvAVg76+qP8U5F4
         VUwhawfrof1PrZgrTnE/b4npqs6AHLH4cijZcW6YgpjqXJGQgB6WynsVF7Wmckvy9uf/
         /pgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjqOWhr0+S0TdbybdFdS61TBmLg4ugIzT2kXHTt2SH+m9lV7g2hocCkCSngtQk9ApkjtTEGmjJAzMTZml7gN1V/ONX7zIhop/FjOHPLQ==
X-Gm-Message-State: AOJu0YybJkUjyqr8uZC04v1Y69FVDtmra2XuaYWxaNLMtLQebyFMuaFJ
	CRjbSYEpbdPXulzEyvCP4WTlPIAdJw0zlT1NxziZ586mtxO3RMxHW42PUkWmUEU=
X-Google-Smtp-Source: AGHT+IH+y5X78XErjPGrxoAu6Ah+ExEgfa+ffSsyssT2c5oaOJhQdypTijdzJkbJhVD+3kmRIngeqQ==
X-Received: by 2002:a05:600c:450d:b0:421:802a:f43c with SMTP id 5b1f17b1804b1-42304824286mr1038135e9.15.1718291604051;
        Thu, 13 Jun 2024 08:13:24 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750f224esm1977952f8f.66.2024.06.13.08.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 08:13:23 -0700 (PDT)
Date: Thu, 13 Jun 2024 18:13:19 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [bug report] mm: Provide a means of invalidation without using
 launder_folio
Message-ID: <d0615dd0-1321-4e32-a71f-e1de2921ca7f@moroto.mountain>
References: <8b6bd8e0-04a2-4b51-9b29-74804ba11564@moroto.mountain>
 <ZmsIl5y3-RKtlxVZ@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmsIl5y3-RKtlxVZ@casper.infradead.org>

On Thu, Jun 13, 2024 at 03:56:23PM +0100, Matthew Wilcox wrote:
> On Thu, Jun 13, 2024 at 04:55:30PM +0300, Dan Carpenter wrote:
> > Hello David Howells,
> > 
> > Commit 74e797d79cf1 ("mm: Provide a means of invalidation without
> > using launder_folio") from Mar 27, 2024 (linux-next), leads to the
> > following Smatch static checker warning:
> > 
> > 	mm/filemap.c:4229 filemap_invalidate_inode()
> > 	error: we previously assumed 'mapping' could be null (see line 4200)
> 
> I think David has been overly cautious here.  I don't think i_mapping
> can ever be NULL.  inode_init_always() sets i_mapping to be
> &inode->i_data and I don't see anywhere that changes i_mapping to be
> NULL.
> 

I don't really understand the errors from this function, though...  I
would have expected it to return -EINVAL on this path but it instead
looks up if any error flags as set in the mapping, otherwise it returns
success.

regards,
dan carpenter


