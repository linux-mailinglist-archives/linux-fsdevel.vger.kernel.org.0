Return-Path: <linux-fsdevel+bounces-27848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3231D964719
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 15:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 658FC1C22269
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 13:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137BF1A76BE;
	Thu, 29 Aug 2024 13:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="HPV+tIF/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC8B26AE6
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 13:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724939162; cv=none; b=s3Of+tY77j3XlM93SDtBMXVPHA5dxl488xEY50bVhnwQF1lI0fq1zcoNO20xqYQ47VlJBx252R1mKYwlL8E3t/Dd/Q8pNnqiIlBdhveNVm07BIaQq0Fh8c3Ili27PYxIErfEk1+MdLQ+yggoRBiYdbBGzpkESK4ha2+eMm9yDpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724939162; c=relaxed/simple;
	bh=+Qss7E/Bu7u+P07CEhPlug1RJOM506FxTYXE9Mx1mFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f63+HM+VI/wn9hmk58I/lhRI0ah2pBRBcuIXu/c2iiKe1mDe4BrEaMTU8+TRo6vgVPAaYc/s7Mz4jy9ZMmqSJm6ppqKh8AKc9fyijnwOxDjoXAbslRzR3P2E/jz/XstjaJD/08ZXvQuSIjngl+ON4hPXINJ9gX1kkKUrtoUNT6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=HPV+tIF/; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e165ab430e7so679721276.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 06:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724939160; x=1725543960; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vs/frRJFvx0QkwarmN20g3DHjKmgkAbYOBjf95Cqk4s=;
        b=HPV+tIF/jVIL6gQsZA9f/HD0UgEEKfEH4MEBeUqeRrrWg92uhJvA+7k9togA+87kkL
         4c7/HTcd0Bhx0C2Gws8iKHKG5z/svT+y+8IYBLU3PiKewoV0zMplqPPo8YFCmEeAlBqf
         u0AF8by9764n9z31lUrorop4+P5opNko2gOew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724939160; x=1725543960;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vs/frRJFvx0QkwarmN20g3DHjKmgkAbYOBjf95Cqk4s=;
        b=t2UyFIyWsCMLlPxN4THzNQmy/PMnHpRrDK03DWPqvLTJWUqA8JRluryN8wbtSczKen
         Alf/58HAw8/L1pFOOZXH8RZBtYm4yizb340vA+lxpNeAtX4dAaTr2cHbdRA8Ebn60K1b
         jAMGIsito9DtN7gYjgpJHHFtj4xc9VzH6GPG9vcFgVeQS/B8SuScs4hhigeIawCUw5gp
         SaGmVlM5go8vVerL0Ujao1+vSbcqbOEMwytWbi8q2mqGMRl58/HEtE+yrxPFS2zivEXU
         PG6fakkTeWsjroNQV73zblA1kypYQ8wJfX4pcR516fRo/SZElBJuWT3Duu7AQWkwo3BB
         CPoA==
X-Forwarded-Encrypted: i=1; AJvYcCUQHaZSO8fQsXK9fqE2L4lj27VUAODcvM5p+20Yx8c7QsT22mBuVXOUJrZ/cqmIe7Er1eNiBr1bnJTJ5cSo@vger.kernel.org
X-Gm-Message-State: AOJu0YwsGgbazNH3QjSSrldelJuwFbTl3UG5MTe1tlQ0sMzUwTIujzR+
	yyTyk5gvDkcVdEdKr7QrKWGx1uqlHrQbscuWMnMqJXZVLcvEUvTvq+T3rGr3u/E9GT8zfe1Iqnn
	LxkbNfKgYQIEQoarN4KkNOaHZZcQs610jtu+TDA==
X-Google-Smtp-Source: AGHT+IGJA9+DUHsX5sbPd03se8m8mjMROlbhgZlQz0Q91XW92UDepc4BR5CQSiiLa8kUJ/+8J45QDbuzxf+nPesBTqw=
X-Received: by 2002:a05:6902:722:b0:e0e:cef6:5265 with SMTP id
 3f1490d57ef6-e1a5adfcd57mr3228966276.41.1724939160081; Thu, 29 Aug 2024
 06:46:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812161839.1961311-1-bschubert@ddn.com> <a71d9bc4-fa6f-4cfd-bd96-e1001c3061fe@fastmail.fm>
 <CAJfpegt1yY+mHWan6h_B20-i-pbmNSLEu7Fg_MsMo-cB_hFe_w@mail.gmail.com>
 <b3b64839-edab-4253-9300-7a12151815a5@ddn.com> <06c60268-9f35-432d-9fec-0a73fe96ddbb@ddn.com>
In-Reply-To: <06c60268-9f35-432d-9fec-0a73fe96ddbb@ddn.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 29 Aug 2024 15:45:48 +0200
Message-ID: <CAJfpeguuPQ-8RfwY1DQWgtz7poLrRtNrL4CrM8zYH5FLY40Orw@mail.gmail.com>
Subject: Re: [PATCH v3] fuse: Allow page aligned writes
To: Bernd Schubert <bschubert@ddn.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"josef@toxicpanda.com" <josef@toxicpanda.com>, "joannelkoong@gmail.com" <joannelkoong@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 Aug 2024 at 15:07, Bernd Schubert <bschubert@ddn.com> wrote:

> Sorry forgot, additionally we (at DDN) will probably also need aligned
> setxattr.

Hmm, that's trickier.

I'm thinking that with the uring interface it would be possible to
e.g. give a separate buffer for the header and the payload.  But
that's just handwaving, would need to flesh out the details.

Thanks,
Miklos

