Return-Path: <linux-fsdevel+bounces-3785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A127F858B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 22:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BEF228159A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 21:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2133BB3B;
	Fri, 24 Nov 2023 21:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hw8/Lzju"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D47B199A
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 13:41:57 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9fd0059a967so654695766b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 13:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700862115; x=1701466915; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DnKDKbUOd1WxbpDbxgYGPaEFH1QtfgYmXWR7clpWkts=;
        b=hw8/Lzju34oPqCwtW9K+Ik359I2sQBTHXMjwvM1VpVG3tnmd7irO9ywXrdv/8toqDb
         auG+QAhSieej4w97kyz7RDQz3exhMSaboVWx9jTyOK9+aPNzlAqW2CfieOPUnjX6rdl2
         BCzVUvHFmVG5U21bv06mEiaK5RGr8LuV6yid8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700862115; x=1701466915;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DnKDKbUOd1WxbpDbxgYGPaEFH1QtfgYmXWR7clpWkts=;
        b=TAVCVmeTcRVbjnhi1qjBq5cKgqntWZfDcQ/LdAHJbc/JIJv+JjZsiKiXuNpXrVQTZj
         gX1Z4wGfknnyX0nvYX60dKmBk0UeT75ld7KsTbwjhiDBgjHS16h6g8p6tunO9AOB3ff+
         jSlwNh5Gd2ygS/qwGe9Z3eRF9gghnPatA+Rx8rerfATgPX/9HY472CPqCb+2kPRoyLOF
         PC8ERTn1F03EaHPVPlx7QkP/290s4Dc4krXeY8+qbPzloQp+r108c2G8ubUqRWn/WIo+
         F0Z60aubJgLRVuxTIr+/3w1NNA6hgxZ9B7LQJUTpL8jSFXwxb97DOLLCAHjWZYuofbP5
         H2dQ==
X-Gm-Message-State: AOJu0Yy24JDwT+HsZJjZxQwveZfZvdAXZ82Lm2rQvsGKMI4XKmbGKESk
	A2LmYf+TP9wMIrz+1Arj/0wBcezdbdzorp9MWHB4RGlX
X-Google-Smtp-Source: AGHT+IFoaGGx9CURvTAXbSmBWjIVox/4ZzDTToWRXzW+zjZwUYh7y+QkxhBWp0kt0GW12X+faWN9kg==
X-Received: by 2002:a17:907:da3:b0:9fa:d1df:c2c4 with SMTP id go35-20020a1709070da300b009fad1dfc2c4mr7525928ejc.36.1700862115382;
        Fri, 24 Nov 2023 13:41:55 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id sa20-20020a1709076d1400b00a0a5a794575sm630803ejc.216.2023.11.24.13.41.54
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 13:41:55 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a002562bd8bso449764166b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 13:41:54 -0800 (PST)
X-Received: by 2002:a17:906:518c:b0:9ee:29fe:9499 with SMTP id
 y12-20020a170906518c00b009ee29fe9499mr7818143ejk.4.1700862114559; Fri, 24 Nov
 2023 13:41:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231124060553.GA575483@ZenIV>
In-Reply-To: <20231124060553.GA575483@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 24 Nov 2023 13:41:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgZNitYwL0kC4GWxWo9zfNXX-8Nhe=D6VtAhP9CAG_xcw@mail.gmail.com>
Message-ID: <CAHk-=wgZNitYwL0kC4GWxWo9zfNXX-8Nhe=D6VtAhP9CAG_xcw@mail.gmail.com>
Subject: Re: [PATCHES] assorted dcache stuff
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Nov 2023 at 22:05, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         Assorted dcache cleanups.

Looks obvious enough to me.

Famous last words.

                  Linus

