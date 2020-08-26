Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F682535DF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Aug 2020 19:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgHZRQG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Aug 2020 13:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbgHZRQC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Aug 2020 13:16:02 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E08C061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2020 10:16:02 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id 185so3243949ljj.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2020 10:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OYDNjsWuANyuBcj1SPsmNo6ddbFkMTYQnNwN8I83N48=;
        b=JGeqnKz66cr/PGvxK95byYWGqp6m3jFBDNw2exQc8Tiv2/3rV7oeitqRF49c0TPmWt
         PfYOAUYDCFroSYr73H96pWaoUr7kushnS2cp61vwd6oqVPJ6ijM/SJNcl+K99LhgYPeW
         UrUvVlTKWW3lYTcZZ3AV3q2bwaalwx4rI+U2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OYDNjsWuANyuBcj1SPsmNo6ddbFkMTYQnNwN8I83N48=;
        b=eaAxORLANTsl2bVBJWU/5zqXrmM5w4vpfCJm1rt4+gc5CNbVhMHfChqr8E6nHxyT76
         c+E7lV7LPHgiGkyuVoW2aVlk44553TCa1WSWctx1rRjowuFREPWqNt+InvU6AGpSRpiX
         1282hq0uholdr4xQ0juDhBjDIMsbV26RxMe2m/DXAQyJTn6mJDmgZge3cCOs/7Ahki4j
         gqEgQ+VTCZosxccBlXjwWh5Iy8eUelpc56FmcQmiPlIw+I08+JPC4CJjOBTwko4n2EqK
         B7/hSJ6ENoaOxogA4h3QSCuYMzbJOhypkl47FxV83HJVkQnVjAAtE3GGl1bHfWf7LYV3
         Ogiw==
X-Gm-Message-State: AOAM532O9ZbC8VRzElhPzZAFbqBy4U5wtfrXukCrnO68piqmEtSrgW2U
        LgQnMP8dP/MCiGm7NmnUv7TDQpC0Fv1KTw==
X-Google-Smtp-Source: ABdhPJxU+6Ltw+e0Pp6M5QQWO9Qi22g3gRCT39X0c3frN8QNN8y3JI994B9MTijROWevOT/u7nTaag==
X-Received: by 2002:a2e:3615:: with SMTP id d21mr7907359lja.333.1598462160182;
        Wed, 26 Aug 2020 10:16:00 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id k12sm701063lfe.68.2020.08.26.10.15.59
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2020 10:15:59 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id j15so1401802lfg.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2020 10:15:59 -0700 (PDT)
X-Received: by 2002:ac2:522b:: with SMTP id i11mr7933692lfl.30.1598462158792;
 Wed, 26 Aug 2020 10:15:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200826151448.3404695-1-jannh@google.com>
In-Reply-To: <20200826151448.3404695-1-jannh@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 26 Aug 2020 10:15:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgedMxgfNPccK9Fgm0JQ=UX91HCndOnO1qAiUOoCOJi5w@mail.gmail.com>
Message-ID: <CAHk-=wgedMxgfNPccK9Fgm0JQ=UX91HCndOnO1qAiUOoCOJi5w@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] Fix ELF / FDPIC ELF core dumping, and use
 mmap_lock properly in there
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 26, 2020 at 8:15 AM Jann Horn <jannh@google.com> wrote:
>
> After this series has landed, we should be able to rip out
> mmget_still_valid().

I think you should just add that to the series, since it's kind of the
point of it all.

But ack on this, it now looks saner than what we used to have regardless.

I do wonder if we should possibly just limit the number of vma's we
dump based on core size ulimit too, but that, I think, might be a
"further improvement" rather than base cleanup.

                 Linus
