Return-Path: <linux-fsdevel+bounces-35931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E72D59D9C52
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 18:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61F10B23007
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 17:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FC41DB522;
	Tue, 26 Nov 2024 17:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVqKCbRJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BF51AC8A6;
	Tue, 26 Nov 2024 17:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732641714; cv=none; b=WX5tgeWimZmQKjbpIFeeiqH85i6FVGpyZuemwPqylVpr43/x//lgwTwnrxunjTb1wRvgErUvpacn9CLEE8f2blCyYavZaP4mL/uHd/eALI5IT8/xRdNRpg7jc2Pqg1WtZoM4wp+iXNc0uqgq14IE3BKPm/+GeyJhhjek1paMJj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732641714; c=relaxed/simple;
	bh=gTqypcj+EFFG6uzzQzavl7F2GsO61n5vFJ3OynM84xQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hR01KjrKWdQlQ2NQdnGvexmNenbV1rWLqFITHz7qKoBHszrYhZIx9goUe4NNyMxZboX+qBjRyAZJ0WvoEFxTriybwJErLavds+VRdiHUkhVGLXLmCHzWU5qXge+MDWFCLEbt6CcwgIFsKyzYEn2m7V6Ku6sxgSMqEQGvxe8luUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVqKCbRJ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21269c8df64so60051345ad.2;
        Tue, 26 Nov 2024 09:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732641713; x=1733246513; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FrIkH1MB0v8Z6/W9Ggvj9owJF6rjo+GqVtj/jimhV98=;
        b=eVqKCbRJ9kosNacAgK/uya9aWmbiZJfzxGlYTtOxBQvzCTTe/uTXNTSQwBq7ucvW3N
         Oruk6FLgsshXiJkcswnifitlzcjwYgK9g4kmbiWLaPaiBUCWe6hJBxkzsg7enBlsCWVa
         RZW5RDtsbGKX2xb/EE4L+eBMLxYYvMx2kuFJw+oWGcTdmWZ4CpB4A3AdE1cCmuiaGSIl
         C5Xc5VRxWL+N4tRoCNXI3mtI/YHZt6rZNspb5DCxZcFOYb1wrNPlorjuY2gbx8211dIQ
         M2ELLW+cR8QQDud5K/RaZ89QxaGV5eQhxidwuhL3mcmYFWKRqBWkUvbgjYHUIU/O98PZ
         ha4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732641713; x=1733246513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FrIkH1MB0v8Z6/W9Ggvj9owJF6rjo+GqVtj/jimhV98=;
        b=Xthnq5LbGtW4w2y2MVUxKGpZYlZwH8UvWeChQz35H4j17B/tPXZZmsg95uxoPdJcpt
         QIZwcRCRaGNIV60Fphg1gr5ej4OSad3BxSteXEmUXRZ9bUW0bp9KXJ+OPLPJuQZdbHsY
         bYWDK1/adYrveYTlgueYLGHRP9fr+21ddeCzvFzs8CrZdKOUrGqlqOMEU69a+Nez7/Zx
         4ODqsCSQ8HlcjoCdBIsmAo4xrYndugsFgpZw4WcB67b7uQlMM7ZBXdyBZU0QdWecQCzY
         oCZVY8TJWh0pEWQD7N/XwrnsINUusJ7fgMm98GK7+qaAD1mP7Cmu9U6rQj8/kIc4EFpw
         gRpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVrt8GpIlY/7ca7IWgPucEiNw0TxGLOIYXGHFKrQk3kw1A3FpkiBeVkjvw91lIKo0GvOr0z3cSfcT6ZfoU@vger.kernel.org, AJvYcCXXTSF4ZUeMria8OQPOII0C1kSaKD2/iZ3p04QlvPXDNpaiM83nXi5R5ljvICH+/Hz5qSwjaiVsYW80MfjN@vger.kernel.org
X-Gm-Message-State: AOJu0YyRKVnISNGYBb/+NpGLNRJdcVf7VPIEuT3kMuO+5Dtvy9HxMnNb
	CA7dpuV91uUfVQJb8LlXtuPVET48cogrNfaFQcd9oKS0oiX5sB0s
X-Gm-Gg: ASbGnctsqX9wQHTkgZpWx3m4MY8pSUolj2qkFkjFyNa52J4do1l7XSaTe0lr+W5PB5S
	KrixDO3MBvBJzLnPdwitoSRDslzd+FsYGM19HdNCXtjO4MCpwYZOD2rEMcnTFkiOHU1+i8JzAop
	4msIqNindmt+0luNGsB5CeUKNMfvtvBUs+83moD6wEq+BIfuOa4kQLGrhQPXdBzG2x/RP7/7T35
	O69DEDJXVLs2ynB4avAiw0waDEwaetLw/g81dU=
X-Google-Smtp-Source: AGHT+IHDsecHndF7b5QQvziiPU8XMujZpFiJZlmKy8xy3DeBm0CZkoaKQrenwPUxLW7TY5QKxmJa3w==
X-Received: by 2002:a17:902:d490:b0:212:4582:37fa with SMTP id d9443c01a7336-2129f7c1863mr231606055ad.53.1732641712688;
        Tue, 26 Nov 2024 09:21:52 -0800 (PST)
Received: from tc ([2601:1c2:c104:170:3e9e:9bc4:e80c:2141])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc13f8bsm87243285ad.184.2024.11.26.09.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 09:21:52 -0800 (PST)
Date: Tue, 26 Nov 2024 09:21:50 -0800
From: Leo Stone <leocstone@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: syzbot+2db3c7526ba68f4ea776@syzkaller.appspotmail.com, 
	brauner@kernel.org, quic_jjohnson@quicinc.com, viro@zeniv.linux.org.uk, 
	sandeen@redhat.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, shuah@kernel.org, anupnewsmail@gmail.com, 
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] hfs: Sanity check the root record
Message-ID: <wzxs6mjqlpf2eszoaw2ozvocqg3lpaqx7mzog4tygxexugrbsu@3pxs2vthfagb>
References: <67400d16.050a0220.363a1b.0132.GAE@google.com>
 <20241123194949.9243-1-leocstone@gmail.com>
 <20241126093313.2t7nu67e6cjvbe7b@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126093313.2t7nu67e6cjvbe7b@quack3>

Hello,

On Tue, Nov 26, 2024 at 10:33:13AM +0100, Jan Kara wrote:
> 
> This certainly won't hurt but shouldn't we also add some stricter checks
> for entry length so that we know we've loaded enough data to have full info
> about the root dir?

Yes, that would be a good idea. Do we want to keep the existing checks
and just make sure we have at least enough to initialize the struct:

if (fd.entrylength > sizeof(rec) || fd.entrylength < 0 ||
    fd.entrylength < sizeof(rec.dir)) {
	res = -EIO;
	goto bail_hfs_find;
}

Or be even stricter and only accept the exact length:

if (fd.entrylength != sizeof(rec.dir)) {
	res = -EIO;
	goto bail_hfs_find;
}

Thanks for your feedback,
Leo

