Return-Path: <linux-fsdevel+bounces-3334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6D27F36DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 20:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 989EAB21A86
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 19:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDFE42040;
	Tue, 21 Nov 2023 19:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="dX221CSA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5481191
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Nov 2023 11:42:30 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507cee17b00so7795535e87.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Nov 2023 11:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1700595749; x=1701200549; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u5gMxb63ruOzqkdGBrjCpQ8F8R9L2QN3EVjL6IBzyr4=;
        b=dX221CSAIpwKHDJo0OfEg90V8/50LlSveJ8cxvoI/VCSKvhQrlQD/FZlNztEiWZng2
         9celHcSCCkJMIZ2HxK/9SVY27SSKc4W/WQou5b1S578u19w3f3X+fEa7fs/EkPOBGPcU
         3QkynLD5PltyKH2gF45D4+BsX8EuWz5IJhWHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700595749; x=1701200549;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u5gMxb63ruOzqkdGBrjCpQ8F8R9L2QN3EVjL6IBzyr4=;
        b=mZpXeKXAeTyhoOmB8T0BQOBOSntIuRuqTWZxSbcQk0dZ8S+V2inkhYj8LiJvmUuEoM
         NgvTIfuiJV5QTgtXGoySZSovuLYaSZ94ifij4gs8DiXlNZLMWnOxNpgJ6/cOpFOI9+q5
         VwKzqUfBsEsSTYEI126nqw2YGOwZG6LcXXCnXMYEU8k3L+9Ds8+vHRkPikvRGGgLkSiz
         VZc5O4sjZg8FWxTS6fCLg4ax5M/FEeUvU/CVzcNYVkm95w0lFCdinFyJlOVc9h8mr5eg
         tp9Y83PAhKh4DwlnmW+R+jCywQR7oPqFstWSDq3E1mDYBzHSLkha1ACf60/L5eQ7IWGT
         XkWA==
X-Gm-Message-State: AOJu0YwhK7NsZkvzjIpQWnRhqqomDtHqbrmyn6DGsNktyB7qn5+1+VZK
	gdb8ZNr8p9wEZJ0rNeSyLfcoxySQfD7cBmykOE3SHg==
X-Google-Smtp-Source: AGHT+IEJL4ipbgWK4F1CoL2fM+DZcNaXfaqzuDHJuv8ptW7VE197EZ9eHg7VHiISx06Rw316+Sjkm125QBtNfN1rxr0=
X-Received: by 2002:a05:6512:51a:b0:509:4599:12d9 with SMTP id
 o26-20020a056512051a00b00509459912d9mr162500lfb.6.1700595748995; Tue, 21 Nov
 2023 11:42:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegsMahRZBk2d2vRLgO8ao9QUP28BwtfV1HXp5hoTOH6Rvw@mail.gmail.com>
 <87fs15qvu4.fsf@oldenburg.str.redhat.com> <CAJfpegvqBtePer8HRuShe3PAHLbCg9YNUpOWzPg-+=gGwQJWpw@mail.gmail.com>
 <87leawphcj.fsf@oldenburg.str.redhat.com> <CAJfpegsCfuPuhtD+wfM3mUphqk9AxWrBZDa9-NxcdnsdAEizaw@mail.gmail.com>
 <CAJfpegsBqbx5+VMHVHbYx2CdxxhtKHYD4V-nN5J3YCtXTdv=TQ@mail.gmail.com>
 <ZVtEkeTuqAGG8Yxy@maszat.piliscsaba.szeredi.hu> <878r6soc13.fsf@oldenburg.str.redhat.com>
 <ZVtScPlr-bkXeHPz@maszat.piliscsaba.szeredi.hu> <15b01137-6ed4-0cd8-4f61-4ee870236639@redhat.com>
 <6aa721ad-6d62-d1e8-0e65-5ddde61ce281@themaw.net> <c3209598-c8bc-5cc9-cec5-441f87c2042b@themaw.net>
 <bcbc0c84-0937-c47a-982c-446ab52160a2@themaw.net>
In-Reply-To: <bcbc0c84-0937-c47a-982c-446ab52160a2@themaw.net>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 21 Nov 2023 20:42:17 +0100
Message-ID: <CAJfpegt-rNHdH1OdZHoNu86W6m-OHjWn8yT6LezFzPNxymWLzw@mail.gmail.com>
Subject: Re: proposed libc interface and man page for statmount(2)
To: Ian Kent <raven@themaw.net>
Cc: Ian Kent <ikent@redhat.com>, Florian Weimer <fweimer@redhat.com>, libc-alpha@sourceware.org, 
	linux-man <linux-man@vger.kernel.org>, Alejandro Colomar <alx@kernel.org>, 
	Linux API <linux-api@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	Karel Zak <kzak@redhat.com>, David Howells <dhowells@redhat.com>, 
	Christian Brauner <christian@brauner.io>, Amir Goldstein <amir73il@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 Nov 2023 at 02:33, Ian Kent <raven@themaw.net> wrote:

> I've completely lost what we are talking about.

I started thinking about a good userspace API, and I'm skeptical about
the proposed kernel API being good for userspace as well.

Maybe something like this would be the simplest and least likely to be
misused (and also very similar to opendir/readdir/closedir):

handle = listmount_open(mnt_id, flags);
for (;;) {
    child_id = listmount_next(handle);
    if (child_id == 0)
        break;
    /* do something with child_id */
}
listmount_close(handle)

Thanks,
Miklos

