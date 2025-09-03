Return-Path: <linux-fsdevel+bounces-60158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD980B423FA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 16:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64F1E1BA3E68
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 14:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE9B285CB6;
	Wed,  3 Sep 2025 14:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="F9zpkQlF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A031F4E57
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 14:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756910860; cv=none; b=cBVtD9lnHE1N6xb79yFfgr9Lyrabl29A/zACmg/nUj4KxrSh1qRZtwdsgQRRszLd2zP1nGc5CgbU1Y6KTcxDzeDtaye2ja97vo/IpOtFxVCqReqsMNQvy3XP45GYOzT0xa2H3wzIRcqjTcgMXH//S3pEf1xOoP3yjkDDynbrVuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756910860; c=relaxed/simple;
	bh=AlDQMoS/Juj614dJaVFAJzPFY1AaItZCmNckL1rHJrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bxckM/dgD0P7kfemTnUfgjd61pPi5MF2Qlgb+/k5SRy9XygkT802WxADbBD8oRCz872IFPAaHdlDxLmC54UjNiXyw2LNZMPDUBY1uNg6/VDnzXnunL7ImYPkhhmgebl0rMfDcgHkihfKWZCARcITNL78ACngdeYTs02sKUsfUJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=F9zpkQlF; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-61e425434bbso5808957a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Sep 2025 07:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756910856; x=1757515656; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1ycIN+3dgOO3X2VNZGNKIoUIYTQ5uvMWC0TtHNOt+E8=;
        b=F9zpkQlF5MYYNNaxn6ogfQdsTpFJaydN1Vok4om7LSGQJvT3ikOzB7MQyQDk9gpxk/
         3p/fr9hMp9+YtvZbdXLT02zomJjucCCl2ilvFv9tQnK8dzugjM22eutrg+eCyFZZUIyL
         pAbNKI8rwe2ifPffBbxlrGgHgKFOz75dYDY+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756910856; x=1757515656;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ycIN+3dgOO3X2VNZGNKIoUIYTQ5uvMWC0TtHNOt+E8=;
        b=PRRWBQNeQwfQnBSoepxm9nAaFMaNSC665KxBbnFnnAHr49yqfiFHeCrU9odpUaqrvz
         c8Lh/AHCW/pyCIiii1mBTuk/py6y6Vb+PwGwSlDCk40fUBFfGUkYc7R/Jz9iFHvwpzEY
         2jqf0pH9vJa4HvYI/h6jRNGV67b7XbrzwdqIL5sqCUn8L+4dxPuhkcYf6RT1iWqowHd+
         S8ulqjkZNtBTmiJyy+TynvrvoqOQTCimVC1LhHHTakT/Mcr5WNOwZYyoJaDD0fzRp4Zy
         DxhJrdtmsMBZIgWCy23obgRzxRQSuMruBoUcjkGdaOlwXkq8YCc/GLPamTXUyUYb6Zu+
         dLtQ==
X-Gm-Message-State: AOJu0YxamtcL0ps6e6CoSB89iPksT9l7oNnDsGPbEZd0OH7D4vjXX9B5
	MlYrG6dH7+QLDI20dw3gX18RW+aUR6YqPqxLfK5P2labbzaQXtNlrvV2iwLVt4CppCXHxhJOmf+
	ofJEr51Y=
X-Gm-Gg: ASbGnctR1YJ+xh3ybVd2PU7RWi6k4hFbF0dt/MfI7p5QAI9D2qv1IyA/ctkqVyCfcjE
	uFJJn0VQsTL3n8eJ44zHlfNGVLyujve86u5CECwrslMMVH4+6x+pUMKcZGnYXVMaAZGR4OliCyR
	Eq7D+XcRFUBj3x5/YCeT8YHstRZLyPzbbBdcvnIMmRNK2Cawkw61WLv/PFzqONkS6yydxcUdIGZ
	DrNAvP/PXeOv1pHUqAyhynYH/wJ2l20fbX6LgchijXAuTvqOuf/z/Bzxfmesi9uXmiJj+xate/Y
	JeCPzEAY0qqgLGuuQWXEoSwuz/aB8V1Z57twiU4IGIITsJti+cgBonymnQ/ZsZyaqD2XnXMWMvl
	KE25Lh1TC7//ivdrO0gBPj5SfHszEpcVbVCxdAElr9BU+ROMCEXKr/Y3+8iMsnd2Qk8bAN92P
X-Google-Smtp-Source: AGHT+IFcVcE8qh4n9WuqElarAHTQzvf/f/43GkxKl8bG3AIy54bMlf6UL7jDsBvuOXx9y9nG9lNtjA==
X-Received: by 2002:a05:6402:34c1:b0:61c:d457:e559 with SMTP id 4fb4d7f45d1cf-61d26c3fb81mr15211109a12.23.1756910856560;
        Wed, 03 Sep 2025 07:47:36 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc1c7ed1sm12358119a12.1.2025.09.03.07.47.35
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 07:47:35 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b0418f6fc27so523062966b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Sep 2025 07:47:35 -0700 (PDT)
X-Received: by 2002:a17:906:eec3:b0:afd:c31c:2488 with SMTP id
 a640c23a62f3a-b01d97307b1mr1696648766b.39.1756910855022; Wed, 03 Sep 2025
 07:47:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825044046.GI39973@ZenIV> <20250828230706.GA3340273@ZenIV> <20250903045432.GH39973@ZenIV>
In-Reply-To: <20250903045432.GH39973@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Sep 2025 07:47:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgXnEyXQ4ENAbMNyFxTfJ=bo4wawdx8s0dBBHVxhfZDCQ@mail.gmail.com>
X-Gm-Features: Ac12FXysWEq4oT8b14Pt2wesWEi9edJP9ViNuy12B08xGg9ep5NG9irddi_ka_0
Message-ID: <CAHk-=wgXnEyXQ4ENAbMNyFxTfJ=bo4wawdx8s0dBBHVxhfZDCQ@mail.gmail.com>
Subject: Re: [PATCHES v3][RFC][CFT] mount-related stuff
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Sept 2025 at 21:54, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> If nobody objects, this goes into #for-next.

Looks all sane to me.

What was the issue with generic/475? I have missed that context..

           Linus

