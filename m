Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D6A37315A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 May 2021 22:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbhEDU0K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 May 2021 16:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbhEDU0J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 May 2021 16:26:09 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CB4C061574
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 May 2021 13:25:14 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id w15so11456056ljo.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 May 2021 13:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bxco5XoKdkkQdeuPPA2d1qMEQi2F/pAHKDhVnxntoq8=;
        b=cCqLP/YWXo1MfYZTZ0KgnIYEoCm2iKmH41ZPUffIW/VLUp3TNXlvKDf1CWCEret5aF
         zMs1mD6iNLQG5QMbGipCRIULfZTyU3SIK2+/oaPd5N/vfhP67uQDyQ+NT03CcP2VrOHX
         qmyiAbKRkT9KGEWIN8V6nwv23PME5WgB/jd+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bxco5XoKdkkQdeuPPA2d1qMEQi2F/pAHKDhVnxntoq8=;
        b=i40fczBVcm2YIux2KB2fNlIVwGul70Wzxq0ddyxE7CTiP2D8MK0o7t+9mYLqsI04vw
         gEMLBbIYtEBeL6aBm+Q0OpGyQE8VpmNHvoja9DomrhEsKS6GiFkaGrqwOoxJsAxYEfZ6
         Sv4NxQMVVTuoBTApo6V6A/tICNa2Gw7nFIZr0XdHyRHxUaFF7pUiAfMpBVmuRW38RAdL
         HAHXlZa/CIIUf39e6mx6zJGh4QDSk0KBaUTisd+sc2Oc/Qg+syv2KTCeejhdyYvGxvNn
         TazNQKP5ScqBl8tRlAiUNa5Wdmzd6aMhtFmzRoB5zeZMCQHCCwpuPA7d7KcnlZ1IMCNG
         QmVQ==
X-Gm-Message-State: AOAM532twdJHC960kHihyc2BWLvcGYR3cPOF4uduZLl8PqRRTtUCEMOE
        2Rm2qD0UEl36fJQvaRrerKKzrkaVEFDbsVa4iGU=
X-Google-Smtp-Source: ABdhPJyJKDN5mcm7TAIL0jivd7K/uR3qEvpFfmb+4MtW3g+O3g5SW7RLZfaOJFuBbDpVOk6Qv1kP2A==
X-Received: by 2002:a2e:b8ce:: with SMTP id s14mr19435279ljp.475.1620159912403;
        Tue, 04 May 2021 13:25:12 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id z41sm351813lfu.88.2021.05.04.13.25.11
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 13:25:11 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id o16so12841264ljp.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 May 2021 13:25:11 -0700 (PDT)
X-Received: by 2002:a05:651c:33a:: with SMTP id b26mr18849537ljp.220.1620159911294;
 Tue, 04 May 2021 13:25:11 -0700 (PDT)
MIME-Version: 1.0
References: <YIqFcHj3O2t+JJak@kroah.com> <20210504115358.20741-1-arek_koz@o2.pl>
 <CAHk-=whEjY7eOqPg2Ndw=iM2Mih0BC9LVyX9c6Uc_W=wmwnkkA@mail.gmail.com> <1777114.atdPhlSkOF@swift.dev.arusekk.pl>
In-Reply-To: <1777114.atdPhlSkOF@swift.dev.arusekk.pl>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 May 2021 13:24:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=whCMLJB4FafaqHOrpE0UOLkq5Wc4EyNSJLzq3NZAwN0-w@mail.gmail.com>
Message-ID: <CAHk-=whCMLJB4FafaqHOrpE0UOLkq5Wc4EyNSJLzq3NZAwN0-w@mail.gmail.com>
Subject: Re: [PATCH v3] proc: Use seq_read_iter for /proc/*/maps
To:     Arusekk <arek_koz@o2.pl>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 4, 2021 at 1:21 PM Arusekk <arek_koz@o2.pl> wrote:
>
> Keeping it the way it is for the sake of security of userspace applications
> looks more like security through obscurity to me.

No, it's simply "no valid use" and "why expose interfaces that don't
need to be exposed".

splice() _has_ been a security issue before. It's why I want to limit
it now. I want to enable it only for cases that seem to be worth
enabling for.

Have we fixed all the splice security issues? I certainly hope so. Are
you correct in stating that there are probably other places that might
be more interesting to attackers? Sure. But none of that changes the
basic issue: why expose this?

                Linus
