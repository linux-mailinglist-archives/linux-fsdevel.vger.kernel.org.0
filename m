Return-Path: <linux-fsdevel+bounces-20646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C49E8D65F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 17:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3780A28E592
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 15:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0267115623B;
	Fri, 31 May 2024 15:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fFVDWs68"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BA61420DD
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 May 2024 15:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717170083; cv=none; b=DrsJSM/B4TH1jzo0FDhXZw6Z7locdFL8dXjtyGIITGzLpTv7fseAuXqsuUbJRpB9QAgL9CVZnRZyyg1J9iv+nnVJZGW8FRF3rScxsBFXS3X174Lheu9e44gZ5+AlIZnPNc2uSiIsjMB9IAx9gM2ZuoEnnGpUQxYBq8P14aI0tFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717170083; c=relaxed/simple;
	bh=1icxBW0WAWJeXDtfB/JbuFKk4yBPN0MPn8Pz67afWN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XKcjSKe8CchTTvwae7CicV41kvjsGBKLuaRoNt7W8S1Sk+ZBh68GfYgQNZcQklch3JwM2e+2r9LpzOlzdIBlL4TGOaLiZrMyXKVGEWRZqAOdN7ie7XMUYtdFEG3a6pv6G9WWZLM797nF1WfQgbcORGKetCG36KkpU5kgQUUx8pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fFVDWs68; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a6269885572so418007566b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 May 2024 08:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1717170076; x=1717774876; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qcmzRn+ubTFkXBWgfueZrQ+F49rcq2x9ogw10pQnjNg=;
        b=fFVDWs68Qzuc1nTVqWs4evm64E6f3jH46YtcYrwQLS3Nf1rlzY4aJ3e1Ai540IQthL
         nJCOzCZw7PNZpZXpqRTtItPXzggwAFHLVfKN+v5MfhxqWolwKyNhACT5TXb1rxhk4lMI
         tgMk60MHqvoylkki9cv5TB3SDNrIOEptb8oi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717170076; x=1717774876;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qcmzRn+ubTFkXBWgfueZrQ+F49rcq2x9ogw10pQnjNg=;
        b=MZR5n2Ds8iVlyCoyEOXLpHNTfSC2CSA0a23C/4TDb5H/gsHJaGZhZihOqYH09nRKyx
         sC2NK++BlpFMQPM92oasoxYItqR0tQNvo284xLw/x42eXyara6DiOdrkmvh73GlfOhuw
         rlw/KWCMqStE31uMXaOkWhOpiqmPv0Hj9AqqyjmsskAEesV1RcZ1Et6PNP6PY7jtDEae
         oNj8hmZb2/SNasEXrghWVH51WkN8E0wJe2yrk90RwtRJbIyuWMH7uYjYfUknImBn9Wkv
         yLKyrGMDRb16oF3xpgOnso8pdih6n8M8lv9GoDT5a0vGc+CmDkyTCstmODBh6JB8U/F9
         KAXg==
X-Forwarded-Encrypted: i=1; AJvYcCUvQWVrgVvd/PCwTz6Y4z0bH5WwkgGk3CnUFaUEj0QzGijRkuVYfrb52Tv4FGxpDHZPAqQ3ZXz1qDAPQnExOjCMRN1nIr19UFqRTstemg==
X-Gm-Message-State: AOJu0Yx8qR64xOHY+ebxOnOc3dDqRhvyHWY+tRvvG5XUNZV8p0WR4/0f
	y1yTjtt7WYxT4tafnwY1rTBjAvkOPpTS/J7hZ3sgSCX4iMosQJF/pmYE3g6dAOjcmDHQE/eKuCW
	K3m5f5A==
X-Google-Smtp-Source: AGHT+IEJgLV+NthbX9rqRMyaKDN+MTBOltzkwS/C8EM+m0UPrDUegruwpnMR+N5rZNH+bugP2B5QAA==
X-Received: by 2002:a17:906:16c8:b0:a66:cf86:8f62 with SMTP id a640c23a62f3a-a6818c46d58mr207732666b.14.1717170075679;
        Fri, 31 May 2024 08:41:15 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67eb3443f6sm97722166b.208.2024.05.31.08.41.14
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 08:41:15 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6762109c06so233079366b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 May 2024 08:41:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUs6wEg2CQ88xUdGhgLpz2kGtUvgrccCwGqTF9fovQ4GZ7PU0T0EqEatQiviEV4DzGx1pwFqkgjwCC0dg4aClWXyqqtty6jGOFOdN5pNg==
X-Received: by 2002:a17:907:20a5:b0:a68:7212:7184 with SMTP id
 a640c23a62f3a-a68721271d8mr144630766b.14.1717170074617; Fri, 31 May 2024
 08:41:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531-beheben-panzerglas-5ba2472a3330@brauner> <20240531-vfs-i_writecount-v1-1-a17bea7ee36b@kernel.org>
In-Reply-To: <20240531-vfs-i_writecount-v1-1-a17bea7ee36b@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 31 May 2024 08:40:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wibjzPz+PQiBpbonJgcuMCUWj2hYtwNCdUF-D7+zSwLag@mail.gmail.com>
Message-ID: <CAHk-=wibjzPz+PQiBpbonJgcuMCUWj2hYtwNCdUF-D7+zSwLag@mail.gmail.com>
Subject: Re: [PATCH] fs: don't block i_writecount during exec
To: Christian Brauner <brauner@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, amir73il@gmail.com, linux-fsdevel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, jack@suse.cz, david@fromorbit.com, hch@lst.de
Content-Type: text/plain; charset="UTF-8"

On Fri, 31 May 2024 at 06:05, Christian Brauner <brauner@kernel.org> wrote:
>
> Back in 2021 we already discussed removing deny_write_access() for
> executables. Back then I was hesistant because I thought that this might
> cause issues in userspace. But even back then I had started taking some
> notes on what could potentially depend on this and I didn't come up with
> a lot so I've changed my mind and I would like to try this.

Ack. Let's try it and see if anybody notices. Judging by past
performance, nobody will, but...

I still think we should strive to remove the underlying i_writecount
entirely, but yes, even if we're eventually able to do that, it should
be done in small steps, and this is the obvious first one.

            Linus

