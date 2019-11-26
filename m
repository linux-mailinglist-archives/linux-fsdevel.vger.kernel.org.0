Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAA5C10A46A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2019 20:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbfKZTXI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Nov 2019 14:23:08 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40821 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfKZTXI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Nov 2019 14:23:08 -0500
Received: by mail-lj1-f193.google.com with SMTP id s22so2557247ljs.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Nov 2019 11:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gVU8aUvCwunnwvZoc9ZhH3ujI7aR4VD5kE4pYV1Vkas=;
        b=EgkRn4Q7NHQ5QIKE0czhFgPREUU/56yr7pVF4OoQfwq+lrhdqpgMhqNobcCo9dDvJA
         Mf/9k3DSG/qijMMbyy6EjYTwCX7FjQ0RQAqPLLnbcFmIdtnuq7K8zYk98PhbYlX4EwGy
         UpB2mwuSWKZUITnmLFz/zHqMols2HefF4AAs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gVU8aUvCwunnwvZoc9ZhH3ujI7aR4VD5kE4pYV1Vkas=;
        b=LxE9R4Nt/ecGen7brO23nAYwlV3pY9h1BM2BD07zYBKVTsTZgf5XEvOasxElY/L1CT
         3DksMtG0BlIwYg6pDjrKb61fAc+9nvynmw0Qz6RH6+FMzMgZ++Z3AvQ3LLACqQqmvE66
         5pVSxMQZglKJTOYQJdUN/HP+73Bf4ycQV9AppAbc6g1apQ4CcJbuaJ+tSn010AV13Qpd
         M9HReLsymK/HbRQavpQ922yCfFmd+kOtR10DmBUcpSEb0CJt+xy6OT3vuu7sZVNVdmLN
         5nEgh0oljDAuOwbfslUQcCtGbS27VkHvrwQFNio56Kn/OJ6qbPm2FTX+pqcq6xLXJnUt
         jvcQ==
X-Gm-Message-State: APjAAAV9w4ZxGkjLYL7aN4qBJk3xEw7aIqhjcMLxgRuXAPx+4OWIJFhI
        EMAjnFcd1ScApjqvMhZ7DcWJ7cNH9mM=
X-Google-Smtp-Source: APXvYqzaOIJu/BnU8/pRkNWrdx7wODLyb1sPGst3k/8B38gpBFJ9R+0jrslnDjucxrcF+UNZT/3mjQ==
X-Received: by 2002:a2e:7c10:: with SMTP id x16mr28065531ljc.120.1574796183101;
        Tue, 26 Nov 2019 11:23:03 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id i8sm5684696lfl.80.2019.11.26.11.23.01
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2019 11:23:02 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id l14so15034588lfh.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Nov 2019 11:23:01 -0800 (PST)
X-Received: by 2002:a19:4bd4:: with SMTP id y203mr23590528lfa.61.1574796181641;
 Tue, 26 Nov 2019 11:23:01 -0800 (PST)
MIME-Version: 1.0
References: <20191126185018.8283-1-hubcap@kernel.org>
In-Reply-To: <20191126185018.8283-1-hubcap@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 26 Nov 2019 11:22:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgbKoRHsbLGDBAA7c6frAtO7GVQt4nxx5kPsixCpTLCDg@mail.gmail.com>
Message-ID: <CAHk-=wgbKoRHsbLGDBAA7c6frAtO7GVQt4nxx5kPsixCpTLCDg@mail.gmail.com>
Subject: Re: [PATCH V3] orangefs: posix open permission checking...
To:     hubcap@kernel.org
Cc:     Mike Marshall <hubcap@omnibond.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 26, 2019 at 10:50 AM <hubcap@kernel.org> wrote:
>
> Here's another version that is hopefully closer to
> usable...

This looks like it should work.

I don't know what side effects that "new_op->upcall.uid = 0;" will
have on the server side, and it still looks a bit hacky to me, but at
least it doesn't have the obvious problems on the client side.

Arguably, if you trust the client, you might as well just *always* do
that upcall.uid clearing.

And if you don't trust the client, then you'd have to do some NFS-like
root squash anyway, at which point the uid clearing will actually
remove permissions and break this situation again.

So I do think this shows a deeper issue still, but at least it is an
understandable workaround for a non-posix filesystem.

               Linus
