Return-Path: <linux-fsdevel+bounces-3835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE12D7F915D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Nov 2023 06:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D680B20F31
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Nov 2023 05:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CD923CE;
	Sun, 26 Nov 2023 05:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="h4HZfp52"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62093111
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Nov 2023 21:00:14 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-507962561adso4882272e87.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Nov 2023 21:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700974812; x=1701579612; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4x4zbUPyly5MvFDszMmntOFi2rLKqwsJFaK9L1H7HNw=;
        b=h4HZfp52xvY1TPIVi224CvpwJZOB2wl5JV8CYwWmmgrL/Vqz3A7nUV/XtrvxqfIb82
         1Fn4oTsRuLexzA8r+6T/ItjDSbANcpmwemhGYPTwo9upVLIlCSsQ+xaOjqF1Dksd2Dcp
         n3pXjD5ART5xJQHCnq6emzYoSbU1kZ5MydL0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700974812; x=1701579612;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4x4zbUPyly5MvFDszMmntOFi2rLKqwsJFaK9L1H7HNw=;
        b=uZGARc6yHIvNWeoNshupVUjmcklJU/mHIVT8bVXBKI+pI1RqFdIo3VMGe5w8mH59Sq
         6bmOBY6Kq8pcAt06NmMGRBu9ivjFsjLi2liifnQIPBUSOfoMRKOATRo7QMDUoYAzFAAn
         rStOu4p0tK9iZNR9mb0Mu9EQ1yo4FefAYbPzYymp0b18XQw3DJAxPqjpVZDnApAvcv+8
         kb7At8fXCmowjLW/dlakEQWXOdpLExl3S4B6Pc0bAoVtlqTAtEyBOz4CWwkoj9tSNnoG
         kwFBqMwE+JJ4Z4Mp9hdaS/Z8qd3pFsSaL2pxCrW0LpRTh/jUidD9qoDnB9lhqhaXAXsE
         qd4Q==
X-Gm-Message-State: AOJu0Yzinp9GqobOtOmscXgCMXP2Di0R2SN3HKrQVjTxmsjU5ozOlzyT
	KesrLXtfRU5htZkCJvlSkvoHmkNuSN++BKPr9tEsWg==
X-Google-Smtp-Source: AGHT+IF7/JH+ZBWx3DMU2EMHZurVn7lOVI5036/B02Tir3QjFsmmasqf+0UwssiBV/C7YfjHlXiZcg==
X-Received: by 2002:ac2:4283:0:b0:50a:a9ec:1897 with SMTP id m3-20020ac24283000000b0050aa9ec1897mr5401093lfh.35.1700974812419;
        Sat, 25 Nov 2023 21:00:12 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id y26-20020ac2447a000000b0050aaaa33204sm1076688lfl.64.2023.11.25.21.00.11
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Nov 2023 21:00:11 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50aaaf6e58fso4866775e87.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Nov 2023 21:00:11 -0800 (PST)
X-Received: by 2002:ac2:58c5:0:b0:50a:a5fb:92ba with SMTP id
 u5-20020ac258c5000000b0050aa5fb92bamr4427694lfo.66.1700974811435; Sat, 25 Nov
 2023 21:00:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231126020834.GC38156@ZenIV>
In-Reply-To: <20231126020834.GC38156@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 25 Nov 2023 20:59:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg=Jo14tKCpvZRd=L-3LUqZnBJfaDk1ur+XumGxvems4A@mail.gmail.com>
Message-ID: <CAHk-=wg=Jo14tKCpvZRd=L-3LUqZnBJfaDk1ur+XumGxvems4A@mail.gmail.com>
Subject: Re: [RFC][PATCH] simpler way to get benefits of "vfs: shave work on
 failed file open"
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Mateusz Guzik <mjguzik@gmail.com>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 25 Nov 2023 at 18:08, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> However, all of that can be achieved easier - all it takes is fput()
> recognizing that case and calling file_free() directly.
> No need to introduce a special primitive for that - and things like
> failing dentry_open() could benefit from that as well.
>
> Objections?

Ack, looks fine.

In fact, I did suggest something along the lines at the time:

   https://lore.kernel.org/all/CAHk-=whLadznjNKZPYUjxVzAyCH-rRhb24_KaGegKT9E6A86Kg@mail.gmail.com/

although yours is simpler, because I for some reason (probably looking
at Mateusz' original patch too much) re-implemented file_free() as
fput_immediate()..

              Linus

