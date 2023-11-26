Return-Path: <linux-fsdevel+bounces-3837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EBC7F9165
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Nov 2023 06:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED8CD28141F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Nov 2023 05:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CF33C32;
	Sun, 26 Nov 2023 05:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HJytjOxr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E5F118
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Nov 2023 21:17:56 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507c5249d55so4862200e87.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Nov 2023 21:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700975874; x=1701580674; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zJOkkIVWwG3UjgibaWiYVnnDnM0U0wZMoXscpOX+mzk=;
        b=HJytjOxrbai/SstDgRqWYARlBcW/3fU1Gr+pixRxRyzQp0tj4+8JyM3oRtaZHsAT60
         723IbFdWvidzS5mpMWtVLoyXNZiJHTr3BATkQH+INN3Y2b82j7pwZCnFz32J+zpBlBnb
         +ArePoJOlt24xyyrYLz+UOiX0K1DVHxDKyBwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700975874; x=1701580674;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zJOkkIVWwG3UjgibaWiYVnnDnM0U0wZMoXscpOX+mzk=;
        b=o0iOoVTOxB0yUDfWLeMdlS1u9zlZ6z6qtBi9oa7uKZh/RC02ZavKt+Dtf68wO+8Jpb
         L8jhCRA6BPse5fzru6PqL1RmFhWz7PdZ7ce9BBLfavvBVGwv3Qa4rRNkxB/8gmsHUqvi
         LU+CgM7PLyZ2ueYm5BVkwa2evLZlkXJDOeI4alsvFcbOkZD24Gz6TViruPzxwf8fCBPt
         +q/yEFRJZLIbb04+kEKn5PBjR845snGWjnjVOWjUW9AMV83p6u39y7yvgtQYfvC21gLK
         gF8RBtK2tQR6Gjj6WrHRqh41ePLvN7BhkqnaEmTNyls7TPZz2noCqzFYnit99G44JCdi
         Hwvg==
X-Gm-Message-State: AOJu0YzJiXC3ylEYQv+lRK4vqVdivl6Z/PPeqlYIixesW+p7b/+Y59tR
	AOd+cW0w5MK/DpEfetDIgJXsODadY020tXo75Ko8sA0j
X-Google-Smtp-Source: AGHT+IHdcbFGXOs3/MUGUoqJxUBeaCfipiXq7hFB/SvH1kkl9J9M76bKx94dVAmXVsuKpTLjtSnd/g==
X-Received: by 2002:a05:6512:32a7:b0:507:a5e2:7c57 with SMTP id q7-20020a05651232a700b00507a5e27c57mr4937542lfe.18.1700975874260;
        Sat, 25 Nov 2023 21:17:54 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id l5-20020a056512110500b0050ab2d4d7cbsm1073531lfg.19.2023.11.25.21.17.53
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Nov 2023 21:17:53 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50aaaf6e58fso4875423e87.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Nov 2023 21:17:53 -0800 (PST)
X-Received: by 2002:a05:6512:10ce:b0:50b:ab30:ba11 with SMTP id
 k14-20020a05651210ce00b0050bab30ba11mr2068842lfg.32.1700975873276; Sat, 25
 Nov 2023 21:17:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231126020834.GC38156@ZenIV> <CAHk-=wg=Jo14tKCpvZRd=L-3LUqZnBJfaDk1ur+XumGxvems4A@mail.gmail.com>
 <20231126050824.GE38156@ZenIV>
In-Reply-To: <20231126050824.GE38156@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 25 Nov 2023 21:17:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=whPy8Dt3OtiW3STVUVKhsAZ2Ca2rHeyNtMpGG-xhSp24w@mail.gmail.com>
Message-ID: <CAHk-=whPy8Dt3OtiW3STVUVKhsAZ2Ca2rHeyNtMpGG-xhSp24w@mail.gmail.com>
Subject: Re: [RFC][PATCH] simpler way to get benefits of "vfs: shave work on
 failed file open"
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Mateusz Guzik <mjguzik@gmail.com>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 25 Nov 2023 at 21:08, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sat, Nov 25, 2023 at 08:59:54PM -0800, Linus Torvalds wrote:
> >
> >       because I for some reason (probably looking
> > at Mateusz' original patch too much) re-implemented file_free() as
> > fput_immediate()..
>
> file_free() was with RCU delay at that time, IIRC.

Ahh, indeed. So it was the SLAB_TYPESAFE_BY_RCU changes that basically
made my fput_immediate() and file_free() be the same, and thus it all
simplifies to your nice version.

>  I don't think that
> cost of one test and (rarely) branch on each final fput() is going to
> be measurable.

Nope. Me likey.

             Linus

