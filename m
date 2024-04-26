Return-Path: <linux-fsdevel+bounces-17876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D32308B335E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 10:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D163285BF6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 08:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E918B13D601;
	Fri, 26 Apr 2024 08:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3lg3lIE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8BC13C838;
	Fri, 26 Apr 2024 08:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714121553; cv=none; b=g0zsaARrDMDOql1+maRw9anCt+W0WyYjBdbJLB5bo6XhkqFnDVNKqSgwIzvmmTTiCgEDbRipWbgN3vE1MAN0VF9RYNJ8jGd3kWj+h+LohVMg7YrxQkBFdoz3v1xMGFBXPU21aU0wMfQtvdvWCPl5YwKn26IWgBdRv56vu06fqPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714121553; c=relaxed/simple;
	bh=yLCiVH/bKuinl6izRxfxxNSURtlqZzTFG7b5YuQhMT8=;
	h=Date:Message-Id:From:To:Cc:Subject:In-Reply-To; b=r1i1t2LidghL1jsdQLuqhemY9QZCGveIUjOvt6+sj0pBubH/y9V4VMWMol4hYwURvLNnLEMEm3f2lIyP3282C7NWMuT9hDXAne1XraNTIUPbHI8G7UUtpnuLstPPFTzpFMrmPq0DjvGUNlPCkbaRqArKUD0U/TD2UBzUgZvsVXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3lg3lIE; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ed627829e6so2232318b3a.1;
        Fri, 26 Apr 2024 01:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714121551; x=1714726351; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NkH2LOuzP9VBrs2iZ/5ie59uWLP3/LNP8BoBQzx8edk=;
        b=Q3lg3lIEr6Qu2T7by0EiM6DCpMeGD8MAR4qKnnXgdt3WJ1ULt/ZjsmjqJBre8yM0He
         D1cJcTBONE1v1vy+bkudBucKPaxpIDDv55Cz92stdrMBKhwhvEzRH3JKhkL8h6aYy8tg
         WXPBHK+cnxJQYCcT0UBRyv4PoYJ7KFIltoO7mcPjbZinu+FlxtiSfRUEE6Nf+/zuIBN4
         NiniDGzwlHvNMiKtwnSP75AInTBnlWm2kN8siX5EbK/WhcosMo6BH/BQPtgdEjzBpXil
         HVo9kDEsNVZl62+6c+ODsnMulHp7mMSoGxEzYUDw0xsYJkE4OilJ5N1LMT/IlKzjruqu
         HfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714121551; x=1714726351;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NkH2LOuzP9VBrs2iZ/5ie59uWLP3/LNP8BoBQzx8edk=;
        b=Plp1takprm9SAQZvgqWoGwH4ilrusq+Zc38m7kPzkGLiA5Ta7R4itPAVxurg+Wnkh0
         tIsDQZ6uUi0qJKkvDFx/QKBdUnr9ammToLssvEzX+Xp8PoI2VDNMXVWMUUWaoK2UGlY2
         1vbUEKqb9tpmMTFplL83Z91meZRqTNHOd7iw6qM+H7n/XFgTp5EXdexiZ0rii2Lk5chj
         lQymNIA7t+aCPOcUouTLbCrusMpLzcmZxo9w8nJqSqOr72W3HUBC8w4Wmmm5oMuE/jiC
         I4EdmTUfS78bY/VWxGraoTyXi/VLeQ9Xo53efLZFllE6D1HrFs33HhCgbRJ7DtyjSNUZ
         WQcw==
X-Forwarded-Encrypted: i=1; AJvYcCU/8mMgDvobLpDxsGAZsHsC8CY48wnXsVU0ZTwT045kTgGg18S56P4pN0ilX+F/Mg140esNIJMTnFe3Kbb1oV9cQ/k7lZif6CjmNXxORS6EJsqtfio6cAJ2VBWGe6GohUQRrSZ6ecmp9Q==
X-Gm-Message-State: AOJu0YxNtZj1zzw8Qske7vgSsALyaqmsp2S0ghYwRJlL3iEbfsBqejud
	qrAV84H34s4baqgwqBeRySKhyoZ7+3MVQVsW71fKRMGTbeZ1C6Dq
X-Google-Smtp-Source: AGHT+IH+evr3TGWciCfLL71ftTuj+ywPmxl+AHQrxmi7SKa1RC22Htox+rkziYr4eEdLrr+C5z7RzQ==
X-Received: by 2002:a05:6a00:22ca:b0:6ec:f097:1987 with SMTP id f10-20020a056a0022ca00b006ecf0971987mr2609579pfj.31.1714121550222;
        Fri, 26 Apr 2024 01:52:30 -0700 (PDT)
Received: from dw-tp ([171.76.87.172])
        by smtp.gmail.com with ESMTPSA id kr3-20020a056a004b4300b006ed26aa0ae6sm14356559pfb.54.2024.04.26.01.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 01:52:29 -0700 (PDT)
Date: Fri, 26 Apr 2024 14:22:25 +0530
Message-Id: <87ttjoijzq.fsf@gmail.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, "Darrick J . Wong" <djwong@kernel.org>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>
Subject: Re: [RFCv3 5/7] iomap: Fix iomap_adjust_read_range for plen calculation
In-Reply-To: <ZitOlbeIO4_XVw8r@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Christoph Hellwig <hch@infradead.org> writes:

> On Thu, Apr 25, 2024 at 06:58:49PM +0530, Ritesh Harjani (IBM) wrote:
>> If the extent spans the block that contains the i_size, we need to
>
> s/the i_size/i_size/.
>
>> handle both halves separately
>
> .. so that we properly zero data in the page cache for blocks that are
> entirely outside of i_size.

Sure. 

>
> Otherwise looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks for the review.

-ritesh

