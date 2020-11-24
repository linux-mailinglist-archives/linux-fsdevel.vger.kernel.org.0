Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9DD2C3183
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 20:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729771AbgKXT66 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 14:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729752AbgKXT66 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 14:58:58 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F32DC0613D6
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 11:58:56 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id z1so5111715ljn.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 11:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZnTZSzBIyjU9PpIl1apgb/bDzJCEsK97HPAlhzqIwxU=;
        b=GPWJ31WhJ4LVRmSqiU+JVKe78pq6ZXde7uLsZ0plweQCmRERXzSvr+si4jmurmXs9H
         u43k37FLkfk9mPwY0rxF2DUa4bs8nxwvWddk6+Xpkmpot4unWdte/W6+GSgtzMXF7XOw
         o3RVW9BHUWPoV3Ek5GQtOs+NRrueTsDhOyj5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZnTZSzBIyjU9PpIl1apgb/bDzJCEsK97HPAlhzqIwxU=;
        b=ia9GZprXQzBeD+/jkrV3C7tdEwXiGRpxbw7IaLfB4MnDHlN9ae+Fgjudpr0aKQgL4r
         pGaOmXAg6U6HOsSwm0VzS8N/Po7ippDF6ZsJ5C/L6cvZ/30ebhajINPm6bEG/Qn5ATzU
         EgH+CJOUq1e3++j1ikDoUbI4VpQDsRTneBZhdCiJGLSqMLTYSK5YwJfztf7jTgUETefs
         oprClkbmokEmqjONmT51zZHDi+4xti9JgkYLnjyqn9C+VTMSt16sMQ5c2XhP4YS4ins0
         eqtI4gLE7CLI0XpUWc7YE5S48lQQKyJvy1b9BYKssCPay0QUqGhHmTrLtyLFduwwaLKD
         t3nA==
X-Gm-Message-State: AOAM530pzNbHHsfHQlp9CfZllvm5iQ8oo7zSpPUgP1874uiHj7yvGdId
        8qJYVdJsI3P0UFc/yoHE1xxuKjJ6MidoBw==
X-Google-Smtp-Source: ABdhPJxJTai5DhRdbIq7kl1XFH8WJXIM7Hr6LivGGnLkbc3CBYNo6y1x4juwiiKsLNh8v/YtWjdtiA==
X-Received: by 2002:a2e:9657:: with SMTP id z23mr2336947ljh.108.1606247934545;
        Tue, 24 Nov 2020 11:58:54 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id v4sm6040ljg.84.2020.11.24.11.58.53
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2020 11:58:53 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id y16so23486484ljk.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 11:58:53 -0800 (PST)
X-Received: by 2002:a05:651c:339:: with SMTP id b25mr2663178ljp.285.1606247932705;
 Tue, 24 Nov 2020 11:58:52 -0800 (PST)
MIME-Version: 1.0
References: <87r1on1v62.fsf@x220.int.ebiederm.org> <20201120231441.29911-2-ebiederm@xmission.com>
 <20201123175052.GA20279@redhat.com> <CAHk-=wj2OnjWr696z4yzDO9_mF44ND60qBHPvi1i9DBrjdLvUw@mail.gmail.com>
 <87im9vx08i.fsf@x220.int.ebiederm.org> <87pn42r0n7.fsf@x220.int.ebiederm.org>
In-Reply-To: <87pn42r0n7.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Nov 2020 11:58:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi-h8y5MK83DA6Vz2TDSQf4eEadddhWLTT_94bP996=Ug@mail.gmail.com>
Message-ID: <CAHk-=wi-h8y5MK83DA6Vz2TDSQf4eEadddhWLTT_94bP996=Ug@mail.gmail.com>
Subject: Re: [PATCH v2 02/24] exec: Simplify unshare_files
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 24, 2020 at 11:55 AM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> If cell happens to be dead we can remove a fair amount of generic kernel
> code that only exists to support cell.

Even if some people might still use cell (which sounds unlikely), I
think we can remove the spu core dumping code.

       Linus
