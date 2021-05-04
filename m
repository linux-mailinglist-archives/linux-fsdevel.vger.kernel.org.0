Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B4D372D7A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 May 2021 18:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbhEDQCt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 May 2021 12:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbhEDQCs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 May 2021 12:02:48 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D52C061574
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 May 2021 09:01:52 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id b21so11768017ljf.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 May 2021 09:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=no60eDnpfNleIZIVM2PSWGEJXhTZf1BPjAHhf33fLWw=;
        b=WAtHHtFdlNK0dHhR7WnzAGrSC2T8+LbSppqHZk9dwSH91MQIfIl2zAmMz4k9EsIJAg
         HUh8r2P+JQ5esL4VsT5P1+K7HziSM/E5GS4AIlyAvcQ++alrUMCk3ZbsnmBrMQ0xSq0/
         OPToIUNgRx5UqBo1pub8p4h2Yhf0zTWh4/oac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=no60eDnpfNleIZIVM2PSWGEJXhTZf1BPjAHhf33fLWw=;
        b=QumoJnHESvMBeAgBRT4eZx468l0ljpSOc/QJrNxQE0Kf4x5MbxbUELwbYF/EM1bjqa
         hK7civ5tCMBHhs1HcCCIWD0mwcm5U64p/i+tn/wVQuvklAlL9i06hMLCTozL6EhkUikn
         AOemQTqVdHPhg4ZvIKli21qevOq1MYE2NSIUQ/oIfp00ziP2lbHa9ETzmZn9EJn316Cg
         U3natMNcx4hbjFt21UoFG1tJL1WqSUJrCOFdEc7eq5OJC792nzuDB6dVKIMyqArM/2iA
         EuRerRjjHSY/XR1mDgyG8EfBuLR3xQ0ZO89bte1H/evyDawGSfZcJ3MwNBECVFRNmbGi
         eeuw==
X-Gm-Message-State: AOAM532h9I1d68zW56qav2VcRiwUf00gSckMzM7MLaVEQf056glT8tHN
        3lLu0AzfGHfu95/Ero2DxUrElQmbL6fxd2zC
X-Google-Smtp-Source: ABdhPJwKraXW+7Pqd0oAvLEeJ63JsBpoh8AFgGFEYywaPHfMfomXJ1PXdc5D8vAiP3kih4KNpjHY6g==
X-Received: by 2002:a2e:8799:: with SMTP id n25mr13550273lji.139.1620144110616;
        Tue, 04 May 2021 09:01:50 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id t17sm299749lff.25.2021.05.04.09.01.49
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 09:01:50 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id a36so11795555ljq.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 May 2021 09:01:49 -0700 (PDT)
X-Received: by 2002:a2e:954a:: with SMTP id t10mr17512244ljh.411.1620144109697;
 Tue, 04 May 2021 09:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <YIqFcHj3O2t+JJak@kroah.com> <20210504115358.20741-1-arek_koz@o2.pl>
In-Reply-To: <20210504115358.20741-1-arek_koz@o2.pl>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 May 2021 09:01:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=whEjY7eOqPg2Ndw=iM2Mih0BC9LVyX9c6Uc_W=wmwnkkA@mail.gmail.com>
Message-ID: <CAHk-=whEjY7eOqPg2Ndw=iM2Mih0BC9LVyX9c6Uc_W=wmwnkkA@mail.gmail.com>
Subject: Re: [PATCH v3] proc: Use seq_read_iter for /proc/*/maps
To:     "Arkadiusz Kozdra (Arusekk)" <arek_koz@o2.pl>
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

On Tue, May 4, 2021 at 4:56 AM Arkadiusz Kozdra (Arusekk)
<arek_koz@o2.pl> wrote:
>
> Some executable-inspecting tools (e.g. pwntools) rely on patching entry
> point instructions with minimal machine code that uses sendfile to read
> /proc/self/maps to stdout.  The sendfile call allows them to do it
> without excessive allocations, which would change the mappings, and
> therefore distort the information.

So this was kind of what I was expecting.

The only reason to do this is basically for nefarious purposes, and
it's one of the reasons I didn't feel like doing splice() on
everything should be encouraged.

Yes, yes, I'm sure pwntools can be used by white hats, but honestly,
that seems to be an almost secondary purpose.

Why should the kernel _encourage_ and make it easy to do things like
this? What are the actual advantages for us to do this?

                 Linus
