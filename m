Return-Path: <linux-fsdevel+bounces-30384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2632498A8EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 17:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 107DA2843B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 15:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FF9192D7F;
	Mon, 30 Sep 2024 15:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="KW3C3oAD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480F9192B66
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 15:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727711021; cv=none; b=Xppj942rPNUqwSL/ABJ5PZNdYxJNIoEsPM9TVGdCUW/l9xFFvWtUhn70uyrjYgJaizO80fczipXpqf6ywyIEGmgWMdgPqtRZzhk7pjfb1+lotlKuCsAYhfYXmlAvUOeZv09MgaUciT/fKkNVamw4Yget6m6dZzfn0q2wSG2p3V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727711021; c=relaxed/simple;
	bh=otBdflaCnmxHVe/TDBKM4WdqZXLJ76lk7Gsd3iSj1K4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=euLV+LhriF5yPu3dNYZUYjugmw+n6hGBfWRwT3X6lud+oE7WIL5aHLq3kcGbJPYmoy8fwlypJzMaaJH2Yu7mLkLN6OG4iWGF5aPWmMuHTqOX/bSiWZjWWtJNjVrmT5nzn755kes1mLOV0T8JrNcL3UtWnIvKsq9+5/IpKXWc7AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=KW3C3oAD; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a910860e4dcso789910266b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 08:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1727711016; x=1728315816; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uhEUJBsmAIUw//du/cGBd2La2CFixOo5tmolhLkgn3s=;
        b=KW3C3oADOom5+93xH3gWO/upeGQjOWcAiwqvosGzSwgPQL1HbaonhxvhX5aT8EzLXB
         oFFotnHcbRIjZ3u0MI9TsHkFI3JJBxTiSAQMVshFOfTrcX/AhzGXPhUJVNWz8zWpuYOx
         bW8DP5GVHqDXZzg6WTUk3chY0cHQDFttdsAxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727711016; x=1728315816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uhEUJBsmAIUw//du/cGBd2La2CFixOo5tmolhLkgn3s=;
        b=p/ZXW85X2fKzhIbCp/EiR7pudPLAAzyoMsfK89/jRLnGokj0asArYNfnXJBsc6yel3
         0jquU29OtCntw1aENAI/YEBNijUozeBxMtXO4juHK4fNh0HP1W15MgjIk6s+eYizB/mj
         7QZ9n960NBDM/vD/7VLFeB7E1T4QP1zBFltezzSTYwfpcYkNZqO3YpqmZCAn7GYyLMVz
         Zwlm8kIC3/Lofl5TsV4eUJVc2/uFa5zxBHqfCpKefws9/tCC/fxtVJ1RIVyFcHj7wr+7
         umPXAQohP0D5wKxp87p2pXGL6vH4DKVkCsV7r+MZ7AdwU2LbmTI36JdTOcxfTVgEm2Ir
         RiMw==
X-Forwarded-Encrypted: i=1; AJvYcCW9wfpUxziOnXiZCgnCxswYeBhWIvMUFU/BeyFCJFPMFhVoXTy/hUJ2EVxa6oVkqodrn/TWNc3wgxqZ+hAh@vger.kernel.org
X-Gm-Message-State: AOJu0YxWf+WpWZuZzpLyA8unmW64SoMyWoAM5LQRAVozZSNOQZpxJksN
	oFDhjERfaZNqYMqBGxSgHPNQVbx4tuuYLljsQ+5gZdhgC3bInoUrWwSC76IOsywXK4AI1xMjqde
	RH8KgvQLg5qi8Ck0QuQfhu5zn8auvUEPjekCM0w==
X-Google-Smtp-Source: AGHT+IGKi9m9s5jPTqewrhRtIrGLsqWg9xtj7zylxnntCbOH0tetAjfT6QHS+oM0edZlZCzxQCQuAudkV0Rm5se6zFA=
X-Received: by 2002:a17:907:3f18:b0:a8d:2c3e:7ed3 with SMTP id
 a640c23a62f3a-a93c492a738mr1448387866b.35.1727711016271; Mon, 30 Sep 2024
 08:43:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegsmxdUwKWqeofn9-DYvqmPWafwxQfy4nLgfvosvhXfjOA@mail.gmail.com>
 <CAOQ4uxji-2L-W2+e==NgmhS7i9mMjR4rW9A1_Bkx3aSzB5roAA@mail.gmail.com>
In-Reply-To: <CAOQ4uxji-2L-W2+e==NgmhS7i9mMjR4rW9A1_Bkx3aSzB5roAA@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 30 Sep 2024 17:43:24 +0200
Message-ID: <CAJfpegv2vVpzZysQrQs5dKv7eN_sTMq-=p-x1d-LC41CFOCzpg@mail.gmail.com>
Subject: Re: optimizing backing file setup
To: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Jakob Blomer <jakob.blomer@cern.ch>, 
	Jann Horn <jannh@google.com>, Laura Promberger <laura.promberger@cern.ch>, 
	Valentin Volkl <valentin.volkl@cern.ch>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Sept 2024 at 14:24, Amir Goldstein <amir73il@gmail.com> wrote:

> Daniel took a different approach for averting the security issue
> in the FUSE BPF patches.
> The OPEN response itself was converted to use an ioctl instead of write:
> https://lore.kernel.org/linux-fsdevel/20240329015351.624249-6-drosen@google.com/
> as well as the LOOKUP response.
>
> Are there any negative performance or other implications in this approach?

It would work, but I'd try to avoid adding more ioctls if possible.
Hence the io-uring suggestion.

OTOH I'm not sure io_uring is the best interface for all cases, so it
might make sense to cherry pick some features from the io-uring API
(like COMMIT_AND_FETCH) to the regular synchronous API.  And that
would need new ioctl commands anyway.

Thanks,
Miklos

