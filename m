Return-Path: <linux-fsdevel+bounces-26480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB61959FC7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 16:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 484491C20C50
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 14:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E261B3B0A;
	Wed, 21 Aug 2024 14:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="qBeNyar0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFEA1B1D72
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 14:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724250365; cv=none; b=K+518eddJCK4Zl+hSFTO74rL8Co1i1VRWuuWGeBbnJJwgsGzYLFbzOAISf09j5XBmG2MkqLzCjiWfsmbFsJJCiMxpe4+SxSog4bolW4LqWoIDN2KS8H2p24yPEM5uHZxL259ZCD4/hUQfdyiyIT1T27dnHybCNNUoNEruTPctrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724250365; c=relaxed/simple;
	bh=BnEWoqcFFaFLFvELE2aTEtE2cMD3oOPw1ofnA9zaAGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bz+WJsqy6T0Wc2gCq8sHVYWmL0/1sGLTA5gmoZDx7okbURByakCJMPFFUiUZM187/JjTgHHquloVKbFJX9j8fXyQQi89t3uT91U/S1aMARW55AWWX8PGK0wdiX6sfZ7pasATWX4KbDQ5l7fQXxtI6Hl1EJuis/DKgAJGj7E7sHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=qBeNyar0; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3718eaf4046so4477218f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 07:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724250361; x=1724855161; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BoHo6bNou5yG70NSetesVheBdzkIHfkjGg4oHtI0TR4=;
        b=qBeNyar0IfsZB88buJ1C0vnyicmCG4ZoxJDRrGNwWJoACeFt8XeGmrA/FYCtt+ks7p
         Nl7Bl+psMSDgh0C4LDLcXEpLP3l4Q50RsrW2Hdvq8hde5wMkUyTUUH1pLhy6ULpxCu07
         hJiSyOjy0VIYzlN+NproDozmOy0hqSwQcjksA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724250361; x=1724855161;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BoHo6bNou5yG70NSetesVheBdzkIHfkjGg4oHtI0TR4=;
        b=UV8oRBPiQLQ+50RQc2XifRJmIUYMhcgKJvdxHvKKHvwDFnt0psrkNgn7FI7UhFgA/A
         1sJ+sxX2hJJnfkLlCTTP7z0l0gDN7RgM101NsHdsvfJ63d6uncPEaLeEX/g2xpzegpLw
         sdku09QR6BCS/MMac5cwPxCthdJTd40CbRraXQt3X4squX5FMDKHZzxwPQXJ21C45c9u
         Eyc+ERs38n7DZg8QOHLKlJl3e7BVRIvWnjosM4X2+MPPDKEdhvyCM4epvVwqV5TuCrMt
         lpDMKmdQ9H8bKU9xFqPtTa53scvQG4t4WsF8Yz0Y+Hwagu9MSVhsaaOM2OdtiBFV1x6z
         hICQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEDvOuMbgl8srqDhZYgIvdWlNaWaaJAmPtIRFRiD2GWvDU8NFFTimKX0xLGG+17pUYnjbCRE08J0r5hbd4@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv+6Hr2Jy9CozJw55nQ1LIbI++1y9Crpp6PkcChAuw9NlffLnh
	U0wY/66DE0sf32HjESmYPGewC9b2bjdkioqE+y77IGlj5Mb4uLh0K5rAiN1VIyqdogMGem7am5B
	r16Hf27pi7ujz5NBZdt37BGQnx9lFnl6KxZKW7Kx1Sk94ZFno
X-Google-Smtp-Source: AGHT+IGREPHACbRnu8TMGvxx5NjHLhTTcpoTMHdne4PUrPxn8rBFt4Cz7KfaolWenWkU5tTZoZVrMTXoIpP2WjCB6LA=
X-Received: by 2002:a5d:4a52:0:b0:36b:c305:5902 with SMTP id
 ffacd0b85a97d-372fd592561mr2220312f8f.17.1724250361089; Wed, 21 Aug 2024
 07:26:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813232241.2369855-1-joannelkoong@gmail.com>
 <CAJfpegvPMEsHFUCzV6rZ9C3hE7zyhMmCnhO6bUZk7BtG8Jt70w@mail.gmail.com> <aad61081-524e-4c67-a6b7-441cca5003ab@fastmail.fm>
In-Reply-To: <aad61081-524e-4c67-a6b7-441cca5003ab@fastmail.fm>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 21 Aug 2024 16:25:49 +0200
Message-ID: <CAJfpegvVNgXBa9faue_A+KGc3paezMFqJN5EF-_pjLsGpOW6Hg@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] fuse: add timeout option for requests
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
	josef@toxicpanda.com, jefflexu@linux.alibaba.com, laoar.shao@gmail.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Aug 2024 at 16:15, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:

> - You suggested yourself that timeouts might be a (non-ideal)
> solution to avoid page copies on writeback
> https://lore.kernel.org/linux-mm/CAJfpegt_mEYOeeTo2bWS3iJfC38t5bf29mzrxK68dhMptrgamg@mail.gmail.com/raw

What I suggested is to copy the original writeback page to a tmp page
after a timeout.  That's not the same as aborting the request, though
the mechanism might be similar.

> - Would probably be a solution for this LXCFS issue
> https://lore.kernel.org/lkml/a8d0c5da-6935-4d28-9380-68b84b8e6e72@shopee.com/
> (although I don't fully understand the issue there yet)

Yeah, we first need to understand what's going on.

Thanks,
Miklos

