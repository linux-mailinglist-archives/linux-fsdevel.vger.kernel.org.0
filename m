Return-Path: <linux-fsdevel+bounces-26716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F2A95B463
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 13:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C62201C20983
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 11:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1541C9428;
	Thu, 22 Aug 2024 11:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="gqlYIkhG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FA613A244
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 11:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724327923; cv=none; b=P80Pw+AgcbOgmQaXtUyPhDpFYxvsbEkUU26j4fSookEtLpbJgfomjPSI+ECdSHoRk0uW6fYfE//WZi+IL0YfqQF+pikDoGxEiTmZNbXRRcy2d89t4sdoQ3n18R6z/W8IOIHui72nmPcPKc0BO1PE2eHmUfVosdrr9P0deex51X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724327923; c=relaxed/simple;
	bh=8QOSVQfhI4ghqzZ+0/BoKgeZXy0qO0h1sc+F1bSMlh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FACofWEZ/kXuXWlzrrAFSTt07L2KJSeeD0rlvtmw6OFv2XdHow4Vz3wazN5xRmpYzFML29zbZ/F6dXY12k0wSZxJc4f3XcQXu3ZafMbPD3BX9MUgqTiuPoAnwaUqa/I4KSyUkFIk39EkZf2Q2xUAw84HB02PRvuqAbZkNYG+uSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=gqlYIkhG; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7a9cf7d3f3so108696266b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 04:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724327920; x=1724932720; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f+x/sMb5R5w3S0A0GZNua6/EwG+VnrzQkBOlWTvRJf8=;
        b=gqlYIkhGTuGE4rb4UzrWjhrxXpIV1FATie37z5pVdNaIty1DcEFm6LcCVDiMF/yDUg
         8ZZj4OYspC7kMPblI4MsJM5LzZAqreZK8sVqf5nUN5pKG5xjephU5jY0IN/1PvYq1F0N
         SGm91YQQ3tsNvO+mAjypzsvMVE+Aa+xMuCQ4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724327920; x=1724932720;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f+x/sMb5R5w3S0A0GZNua6/EwG+VnrzQkBOlWTvRJf8=;
        b=O0ZOhhUusEBtHpoUUXqn0idhKZhb2wxAXPIv5uFrywLcvijcSBphWGvBSWl7pSTpwB
         BpY6oBVGLuwKl7Q8hX5rB0OZbQg277KHVu4EUJmMJyQ/hHrxlCCb3bU3EVa7Z0I+7A15
         9FISYkbN3k7qG+qXKtbBNGysg3A/MV1QrwRhUwIRrxa8wUxqj7/OiQYeSK49aBjX6EZp
         qJZd0KuybvNCIppU/4qMzN43n9t5HCc113papRrsGi/f86kq8t1o9RAR6RDZLmzdQTXQ
         ojLJqNaIKU+rtPcL5L8rrLhhXqPKHCH08Whmwd4dXZKhZKipnX3C2yb+1N0IHGoVAYza
         Dl0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVlpIhaLRnCzfzk3v8IYrN1ZQbV9FnHjo5VtruoTAIlvboXTEHnQclYHDq4oKHDGshtQFmfX50tdy2tHdc6@vger.kernel.org
X-Gm-Message-State: AOJu0YyV2CuAZJxldKo6HVSBSy1zzxnmU2pWTSnTEUKp72CxLzwAiJ/S
	nF0uEgXo6qOkFCE2fu1mtDWmbnP/vsLDlbHDgduRa9TdAYsJLdiuTkBVMaoE2XJoAWdWWUjxq9s
	QQSfaEOHS6PswAal5eMaxYy+EXPPHIGdUmPxAUg==
X-Google-Smtp-Source: AGHT+IH1ZjV+4N1cMdL2Z+NBLD6gvi5LhpxntgZq4C+TBlvsnLZVvigl5bqMT8dgUNGkxC1jmVa+/42PEtucVch/eNM=
X-Received: by 2002:a17:906:6a1c:b0:a7a:acae:3415 with SMTP id
 a640c23a62f3a-a866f11db61mr391225766b.10.1724327919985; Thu, 22 Aug 2024
 04:58:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZrY97Pq9xM-fFhU2@casper.infradead.org> <20240809162221.2582364-3-willy@infradead.org>
 <d0844e7465a12eef0e2998b5f44b350ee9e185be.camel@bitron.ch>
 <2aeca29ce9b17f67e1fac32b49c3c6ec19fdb035.camel@bitron.ch> <ZsSfEJA5omArfbQV@casper.infradead.org>
In-Reply-To: <ZsSfEJA5omArfbQV@casper.infradead.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 22 Aug 2024 13:58:28 +0200
Message-ID: <CAJfpegvFpADCWYwBdeAK3uofXL-cwmXr=WfRir7PP7hjkAr0Wg@mail.gmail.com>
Subject: Re: [PATCH 3/3] fuse: use folio_end_read
To: Matthew Wilcox <willy@infradead.org>
Cc: =?UTF-8?Q?J=C3=BCrg_Billeter?= <j@bitron.ch>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Aug 2024 at 15:50, Matthew Wilcox <willy@infradead.org> wrote:

> > Would it make sense to get a revert of this part (or a full revert of
> > commit 413e8f014c8b) into mainline and also 6.10 stable if a proper fix
> > will take more time?
>
> As far as I'm concerned, I've found the fix.  It's just that Miklos
> isn't responding.  On holiday, perhaps?

I was, but not anymore.

I'm trying to dig though the unread pile, but haven't seen your fix.

Can you please point me in the right direction?

Thanks,
Miklos

