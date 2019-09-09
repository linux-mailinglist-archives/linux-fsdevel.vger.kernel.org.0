Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97F6CAD8A6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 14:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387536AbfIIMOl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Sep 2019 08:14:41 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46502 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387486AbfIIMOl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Sep 2019 08:14:41 -0400
Received: by mail-lj1-f195.google.com with SMTP id e17so12434369ljf.13;
        Mon, 09 Sep 2019 05:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pFxxPSGzQ82HZys0kjMWLu4nLMt5F1OM+dYrK3t5KUE=;
        b=cT6yqph1WHqVo4BHlHeHqAFIMjTp3Acp1uVHcbqgwoGOlIqlovKxe503zA/8WoErXn
         BsWhEeubNs5SBKrX8zemTpTQpyKf8aURKe0eusDLzbJEENZEzm6PLiW7MfyRmJb9iEGy
         Leso6x2MVJCDmsDCySr6Fk9QaENJKtSycGQWa6kfr8C39QyA5ldbGwlHBTOR1tDsdWd0
         P+rXYyvw3PbqWdOBOoxAr1hANjCQCVJnAL9q9WHrrS84jvSXz6kkIRt4UvcNpYSV9ZbK
         aCTAcUs1drW3WqJy+mZdDwDKVRS/0p0q7xHOxWc3NbKica2BqUH7trc0iekrUEknEvsu
         32eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pFxxPSGzQ82HZys0kjMWLu4nLMt5F1OM+dYrK3t5KUE=;
        b=ebvpi8iS2U9OPqTuy1658fqExJz46P7FRqMjOHKiTjEpvOxJbEsbSBFhSWTNUOEeTa
         1w/ioCNKiv66eCPb8VOh2rE/mkf4zhCBBrBCaGmQ1mlz4sH6LvHQjF/uoeXH9IfVAAhc
         9lPu/VAR3Gnctm39x55b/ZxjSuVgNq9iVzmn3ZuX77x4iwnO3/gSRhdz1Ikhl7ZNikvd
         qekbf1HR606CB7mwBUg0XV0xD4tP8jDW9OKSm5r59iAbRAhDeBgefCK/Wlsi5l698mxG
         sWfM5tsq8KFT4mUhH/BX7xgHv9/MvTr8hc+mqmrsMMaO/eX3TGe69acZwCj/gCfP0QJ5
         4fhA==
X-Gm-Message-State: APjAAAUaI656Bdci6pHZJdLM59Wacb3vrCmg+3Reycl6gJWm3jrq6Stg
        M1N8hhB0Ux5QNG11zm5eY88=
X-Google-Smtp-Source: APXvYqwVLHKAjKXgmeV9NavO0mi2f/oJuinAaLJ4bnqdtte2ZZ4wLTD/k1MwfPEpTbw4bERFkaDxrg==
X-Received: by 2002:a2e:9dd5:: with SMTP id x21mr15547930ljj.182.1568031278902;
        Mon, 09 Sep 2019 05:14:38 -0700 (PDT)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id k28sm3212244lfj.33.2019.09.09.05.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 05:14:37 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id D81D7460667; Mon,  9 Sep 2019 15:14:36 +0300 (MSK)
Date:   Mon, 9 Sep 2019 15:14:36 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Dmitry Safonov <0x7f454c46@gmail.com>
Cc:     Dmitry Safonov <dima@arista.com>,
        open list <linux-kernel@vger.kernel.org>,
        Adrian Reber <adrian@lisas.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/9] select: Micro-optimise __estimate_accuracy()
Message-ID: <20190909121436.GC1508@uranus>
References: <20190909102340.8592-1-dima@arista.com>
 <20190909102340.8592-5-dima@arista.com>
 <20190909111812.GB1508@uranus>
 <CAJwJo6YX2qQit9aTbMhg8L5+JE1EsLzKyNt0a3X97zvJ-O9dNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJwJo6YX2qQit9aTbMhg8L5+JE1EsLzKyNt0a3X97zvJ-O9dNQ@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 09, 2019 at 12:50:27PM +0100, Dmitry Safonov wrote:
> Hi Cyrill,
> 
> On Mon, 9 Sep 2019 at 12:18, Cyrill Gorcunov <gorcunov@gmail.com> wrote:
> > Compiler precompute constants so it doesn't do division here.
> > But I didn't read the series yet so I might be missing
> > something obvious.
> 
> Heh, like a division is in ktime_divns()?

Ah, you meant the ktime_divns you've dropped out. I thought
you were talking about the constant value we've had here before
your patch. Seems I didn't got the changelog right. Anyway
need to take more precise look on the series. Hopefully soon.
