Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67F33EC3D5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Aug 2021 18:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235567AbhHNQ2K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Aug 2021 12:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234875AbhHNQ2K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Aug 2021 12:28:10 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EC3C061764
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Aug 2021 09:27:41 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id c12so7393797ljr.5
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Aug 2021 09:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ortWZphuXKFhjpOhthwIn3N+WyaFpzYFJ+AvGHbJUDQ=;
        b=cEB9iQ/ARK3yzJQnjgrabwC9VKujOH+Tl0AjsL2eQ9xl3auLSIojiuRRElQZkWEz+h
         xJF/IQcjKQScPAAJiScE6Bp+ElFvbyGy3MtPsTDCDzYwENHk2+Dj0lsoH/eHs7sjFMCt
         PIzqaqF6AqUQ2q1haG3pE3mnJ0pBbpJRJBKaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ortWZphuXKFhjpOhthwIn3N+WyaFpzYFJ+AvGHbJUDQ=;
        b=lRgc2zTaIiOS+wUK37u1LJ7nmnyRvZMFea0+xIb6Tz6MNSdFoYCsO33aDvL5pHTjhW
         Fi7JmBRB4kuczFhJuSRGqHpBehrXSvZuiFB6D0DNS24HXK8NVmModyrwA8wfRrAjHBb1
         C7GWA0SOLy/X/+SdEe4inDv1Tu+dsvE/M6OOtmLHYX+xflsIXzwEQOqSTy/rXpBklq+i
         c6mpmOXajTAUo9wR7JtuVl+km4vsqqjPQrxEQRH5XqE480KFxnVGq6/muc0HvPXluUqX
         9NsOFI26HC/9lfRBfSPS/Z4MA9Nh0d8mxNYVeF7aKygEsJNJrjqK6PFdLGDwVPdRwd7N
         S83g==
X-Gm-Message-State: AOAM531ObhoquKeauMJlmu/81IkNzt3Lmn6j1C09hdfbUCn3xAcLAE2j
        1XVB+WYpvIaej555M/tgSs58izZ6eWlx3fJWZpw=
X-Google-Smtp-Source: ABdhPJwoHkvRmFhVSHhYnXBIKhv+GsCcyjIZaXTNq7VLAG4+RKkDvylI9bnc/TGyEiXavcJhT9s9Wg==
X-Received: by 2002:a2e:a40a:: with SMTP id p10mr5898630ljn.264.1628958459160;
        Sat, 14 Aug 2021 09:27:39 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id y11sm452414lfh.185.2021.08.14.09.27.38
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Aug 2021 09:27:38 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id h9so20434609ljq.8
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Aug 2021 09:27:38 -0700 (PDT)
X-Received: by 2002:a2e:84c7:: with SMTP id q7mr5844285ljh.61.1628958458159;
 Sat, 14 Aug 2021 09:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <YRdp2yz+4Oo2/zHy@infradead.org>
In-Reply-To: <YRdp2yz+4Oo2/zHy@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 14 Aug 2021 06:27:22 -1000
X-Gmail-Original-Message-ID: <CAHk-=whh8F-9Q=h=V=bKczqfRPbUN_A3h21aVfkk2HNhCWF+Pw@mail.gmail.com>
Message-ID: <CAHk-=whh8F-9Q=h=V=bKczqfRPbUN_A3h21aVfkk2HNhCWF+Pw@mail.gmail.com>
Subject: Re: [GIT PULL] configfs fix for Linux 5.14
To:     Christoph Hellwig <hch@infradead.org>,
        Bodo Stroesser <bostroesser@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joel Becker <jlbec@evilplan.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 13, 2021 at 9:00 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> configfs fix for Linux 5.14
>
>  - fix to revert to the historic write behavior (Bart Van Assche)

It would have been lovely to see what the problem was, but the commit
doesn't actually explain that.

I suspect it's this

    https://lkml.org/lkml/2021/7/26/581

but there might have been more.

            Linus
