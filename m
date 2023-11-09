Return-Path: <linux-fsdevel+bounces-2617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A4F7E713F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 19:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38B1F281157
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 18:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D552E341BF;
	Thu,  9 Nov 2023 18:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bhSZeMsZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C2934183
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 18:12:07 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828B03AB2
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 10:12:06 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-54366784377so1826023a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Nov 2023 10:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1699553525; x=1700158325; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uuevmYRRIdKxNZNfuKSveHcyymGTQi0WWKC3jfrfV2g=;
        b=bhSZeMsZ9D+YmvK+nLhR1simIZefrAcAL7ilYiysUSonrjqz2ZUNM5GpezH8t0HHLQ
         UAEtetl6X3tjGqQAoi0kElbSmGFPaGfAMMMsLmPzdaYL/x/6ZBUA5aFQpr0aMLfawmWL
         H4iDsQ1FNRWvwu+b4dEVlP9Qhja5xdWhYm0l8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699553525; x=1700158325;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uuevmYRRIdKxNZNfuKSveHcyymGTQi0WWKC3jfrfV2g=;
        b=ckbe2RnZ2IPb2ap3HPcp9N/L6Ap6noEsItBjM7MEJKQigTFVbaVbGwQaKny1IghF95
         OAvb2paS+SgRrPZLRBECvQ3afJYnw6kwphHG44bsyaHkVYk9k4NxINSpKAP7Egvf2Yq8
         Y+GQNmYrInha8ge4VaJeZhJoTVjnUMOSRrIVGfufEv/2cBr1n06bhATqi0XNBghZcKRB
         hECLhVmC5mcUFizw/EwC4TS7sPUPny90JIJFuNVQ3tyCN61QkG/JXvZnxdIfNJfA7UbE
         cOB2iZbWvuIZ/Fp8A6KTLnOxjkgPiESu8SozjxyaORyaLqSOoEbHRkutSG67c25FBZtd
         7IcQ==
X-Gm-Message-State: AOJu0YzXoee0HpLzBbxC93Bk62Ww4IWk/IQF1RScDmTrjCctMdwd33h2
	r6RLHXtRlx90SQBoxoCGlRzR7VqvHL+RY5ucnnSA2Q==
X-Google-Smtp-Source: AGHT+IGFbuG6NT1uKm9mcmOJF9gXS61cw9gq3O9cOKn3Eo1YgMa3zutvcdII7d9BjjAc5WPOzxmelg==
X-Received: by 2002:a17:906:d553:b0:9dd:30c8:6f2f with SMTP id cr19-20020a170906d55300b009dd30c86f2fmr5488136ejc.27.1699553524820;
        Thu, 09 Nov 2023 10:12:04 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id g2-20020a1709064e4200b009b2c9476726sm2826440ejw.21.2023.11.09.10.12.04
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 10:12:04 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-9e2838bcb5eso202166166b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Nov 2023 10:12:04 -0800 (PST)
X-Received: by 2002:a17:906:ef03:b0:9dd:7574:5da9 with SMTP id
 f3-20020a170906ef0300b009dd75745da9mr5609054ejs.30.1699553524101; Thu, 09 Nov
 2023 10:12:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231109061932.GA3181489@ZenIV> <20231109062056.3181775-1-viro@zeniv.linux.org.uk>
 <20231109062056.3181775-17-viro@zeniv.linux.org.uk> <CAHk-=wgapOW-HfnpE-UEfROxMB6ec84bDUDHcKWxyxp1v1o2Uw@mail.gmail.com>
In-Reply-To: <CAHk-=wgapOW-HfnpE-UEfROxMB6ec84bDUDHcKWxyxp1v1o2Uw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 9 Nov 2023 10:11:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjN_=wV2QKUNS7bXr-Xx9QfWO_L8o1sZy2EMuwVxzneuw@mail.gmail.com>
Message-ID: <CAHk-=wjN_=wV2QKUNS7bXr-Xx9QfWO_L8o1sZy2EMuwVxzneuw@mail.gmail.com>
Subject: Re: [PATCH 17/22] don't try to cut corners in shrink_lock_dentry()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Nov 2023 at 09:39, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Can we rename this while at it?

Never mind. I didn't notice that the thing disappears entirely in 22/22.

Just ignore my blind ass.

                Linus

