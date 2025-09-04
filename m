Return-Path: <linux-fsdevel+bounces-60281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E30DB44049
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 17:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4B4A7BF9B9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 15:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97B520CCCC;
	Thu,  4 Sep 2025 15:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="W835C6SL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A321EE019
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Sep 2025 15:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756999048; cv=none; b=h8vcI0WtWpu/IWSctV86GHMSxbeV0a6DKaQlc9bUfMshC7uelucnuM4aMg19LdzEfbbAu7BWeSdToGZ8haJPuY5jhF7zctP6tkvnkIi7rcB3/IuTbgSYh0H8uWD4vGBELHAne1AgrFM0HZRpHkxC68eTpIBizGKbJHv3RDdktYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756999048; c=relaxed/simple;
	bh=W5b16d+KjKV5Dwhr+aQah8kpOVnwnUyCYre6ehKOjS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sW5dN9sYEPULd8Cq8yILiXyEwDDYmc07T9OAKM/adzvgT1Yfo7ipOlLz43hHVNxtdRV5Noxfy2Zl3cz8A43/Wdv1++PXLV2yBo+5JqluYHiWhK9S2QxE5tvcuGnQ9BmBGHYuegqN0EaWacI0fwYQgoR/XW9zG5WcVXgEB8ehERY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=W835C6SL; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-809f849bdd6so119066085a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Sep 2025 08:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1756999045; x=1757603845; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W5b16d+KjKV5Dwhr+aQah8kpOVnwnUyCYre6ehKOjS0=;
        b=W835C6SLFSBmAt/Uv8x3pUhsv+uMo2AcUw2doArisbpymFymBdjwmiYnOGRdo5dHoc
         /sJ8+kG5RElLSZTelY5Kly90th4Q3TkLoJxmR1pKoyVy6R+uEltumXvl8QHqBH1t+k7f
         iriGci5YgVS6Wt6/q4RlbgurKsVLlZxE+KK0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756999045; x=1757603845;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W5b16d+KjKV5Dwhr+aQah8kpOVnwnUyCYre6ehKOjS0=;
        b=S5l+tsfQrNi+fj2zZBr57P5IJOVETFrksePLXk1xBPEWLl+qUWk+Zo3Ka6R9+IrusL
         APyRg2YjKdLUsJeRDj8sKFYJQ1MYZpO5yKgBCNRLJHOP/FEEIrjg9DFaAkTS41S0JMpU
         W5TEfWtV4XRZRLbuTFe0eNsmZPmo/V7PZUpAMi/K0hW4C2AWuoWFdHW3FlMChrYNg01d
         OOdBjDhOCA0woWsc7guZMUQwcoUseWe88HNiBJGpAvqa1dbTv90yX2dhyrdME6lPvNRS
         W2svH6cQeuB48+/sOeBQzwFT7dOKbs2s8BcfCLFxK6gsQ8kvfVAEPHEX0wRv+bmWmHRn
         W/qw==
X-Forwarded-Encrypted: i=1; AJvYcCX3GjuUsHeK/mwHDWHtpMqQNjNntD5vqBobsUj3d+hSuonG255EA5aCvLthePCEskzSAngpsBCChRf18Our@vger.kernel.org
X-Gm-Message-State: AOJu0YyureZNAdkA+Ee4F08cVORF+0n0uRL2RdQeT1cO0cDmO4Dmd9iP
	+gnH0MFX+ExxyiIK/hEK5qai2vc4vlZ5L1YMJ9ejvkOUo+7uZe1NP1bDfaMpGMwvYO4PNfuTIZS
	mfDYIOA5k/Vcu2+5o9N3C1x0GajW4CjIcVc0IhoYLRwVjJRsWCayb
X-Gm-Gg: ASbGncv67SBz/HXL+ShYi/PJVupwoGeKGufTtXxsUa0PGs2LarKcdPm8ADAH3gjGZSW
	q15kzpFo8mAUpFvJVUl1wIbmj0jphxBZItz5upM3rBQx09u5ZWRCaDCTh51eTqYnTbuhy8+o0ph
	tUu4eoFvj+Cw8rD5B0nZkldf4kSMTAqVMHnMEP1u4MU6gwxLUfFSTuHSEtzYRBVsN3kYa1/kYP8
	HpO26Uu1QzTcUnyw+cNv6ru1e4UgWl9D7zBgR11IA==
X-Google-Smtp-Source: AGHT+IHNRUj4Zd4BNbp3k/7Lu81auM3s7GYW+7Fv7xdQnf8+A/D//yScqvAMTpSwPEqSqjkBeF1VhSdwpI2FZ1l3EXs=
X-Received: by 2002:a05:620a:a018:b0:80d:6f37:ed3d with SMTP id
 af79cd13be357-80d6f37f091mr508974785a.42.1756999044796; Thu, 04 Sep 2025
 08:17:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175573708972.17510.972367243402147687.stgit@frogsfrogsfrogs>
 <175573709157.17510.2779775194786047472.stgit@frogsfrogsfrogs>
 <CAJfpegsUhKYLeWXML+V9G+QLVq3T+YbcwL-qrNDESnT4JzOmcg@mail.gmail.com> <20250904144521.GY1587915@frogsfrogsfrogs>
In-Reply-To: <20250904144521.GY1587915@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 4 Sep 2025 17:17:13 +0200
X-Gm-Features: Ac12FXxwF5Hg0j9glNqFfW5Wcu-UEvFR3W6W5-SOQ6gtsX6yY2mTUYx4SDwi92s
Message-ID: <CAJfpeguoMuRH3Q4QEiBLHkWPghFH+XVVUuRWBa3FCkORoFdXGQ@mail.gmail.com>
Subject: Re: [PATCH 02/23] fuse: implement the basic iomap mechanisms
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net, 
	linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Sept 2025 at 16:45, Darrick J. Wong <djwong@kernel.org> wrote:

> Or do you prefer the first N patches to include only code and no
> debugging stuff at all, with a megapatch at the end to add all that
> instrumentation?

It doesn't have to be a megapatch, could be a nicely broken up series.
But separate from the main patchset, if possible.

Thanks,
Miklos

