Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399FC1BC54C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 18:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgD1Qer (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 12:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728420AbgD1Qeq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 12:34:46 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CA5C03C1AC
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2020 09:34:46 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id g19so33671230otk.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2020 09:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X1mxB9/IGko7NMD61SzKMJ6N+5CrxseMyS9QSJMcFa8=;
        b=P2gmUuJe0DstX2vgN0Ni/w0KtohF47LJu+m1YD6o2MhJph3OhDGfCMX3kfeuPbTe6s
         +Yx0QUbqeydOQ7R9iA0uzl5gRF2b46ZUrZE1tz5dUwhCkrn6Wp65KngYgrgw9k2qoKUw
         4obGgXJ1hfdWjXXkqPhUc4iVmGZxStY0gNQW4KHPmLkDJlbIjwZ3EhBTRWL+sFFAN+Rs
         ZBByFIr1qhZi1+pPihwU9diWqs6QNuinXSD2vV5/DGmcbo0Zu25+jRTDpN2P5m9mhnvY
         XdwSXghIW/jo0xnd2AUb2IRHi853sVeYids/nMK3z0Opm82c3EuBnpHHJT1418slgMnI
         EuNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X1mxB9/IGko7NMD61SzKMJ6N+5CrxseMyS9QSJMcFa8=;
        b=CYcGyx7bQtKET+eN6Y9n4VyYGKMs0e5dQx+Mg14ufKxi3frqQGgP/dY4hCTcNvyxyL
         /JxBT1BrqHrbUzyIlp//PKFvKOiAw5t1HbchnULC7BecRBC9zPBYAeET2L+ZqQp7xXJ1
         tVUDHyLbZn2wqIyEq3pjHQZjQbOy+hAumCwbrWsgzeg9D+9icxZM0NwJ8Qz4ToXx0bVh
         MZ4pRAo4DQ2t2LeZ7lI2oZyEEG9Lt8SeALNxu/yXlQ5+PJwgq5tdbjyUHawN4W9wT/fi
         kJ+EBYfgLal8rhishH6qmUsdlsDL+zi7N58j0ibsESDKX3Enr2OJrvjwHRjPrRIGK5p+
         W0PQ==
X-Gm-Message-State: AGi0PuaPF1Atvs1fjIdDhyNaWUIblT/oX7t8tDyisekw9x19fDjogTTw
        no9YszxaQxmDMJ04wjPb9753Rg==
X-Google-Smtp-Source: APiQypK7FGUPYjGAbHu5QdczGaQL/SoEhm4DO+FUVP6o2Q54EXAlIjTFWetkuIZfSnB6op9lww1WyQ==
X-Received: by 2002:a05:6830:108b:: with SMTP id y11mr22380696oto.88.1588091685653;
        Tue, 28 Apr 2020 09:34:45 -0700 (PDT)
Received: from [192.168.86.21] ([136.62.4.88])
        by smtp.gmail.com with ESMTPSA id t5sm5171612oor.36.2020.04.28.09.34.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2020 09:34:45 -0700 (PDT)
Subject: Re: [PATCH 2/5] coredump: Fix handling of partial writes in
 dump_emit()
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
References: <20200428032745.133556-1-jannh@google.com>
 <20200428032745.133556-3-jannh@google.com>
 <CAHk-=wjSYTpTH0X8EcGGJD84tsJS62BN3tC6NfzmjvXdSkFVxg@mail.gmail.com>
From:   Rob Landley <rob@landley.net>
Message-ID: <94141fbb-9559-1851-54c1-cdc5fc529a1a@landley.net>
Date:   Tue, 28 Apr 2020 11:40:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjSYTpTH0X8EcGGJD84tsJS62BN3tC6NfzmjvXdSkFVxg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/27/20 10:35 PM, Linus Torvalds wrote:
> On Mon, Apr 27, 2020 at 8:28 PM Jann Horn <jannh@google.com> wrote:
>>
>> After a partial write, we have to update the input buffer pointer.
> 
> Interesting. It seems this partial write case never triggers (except
> for actually killing the core-dump).
> 
> Or did you find a case where it actually matters?
> 
> Your fix is obviously correct, but it also makes me go "that function
> clearly never actually worked for partial writes, maybe we shouldn't
> even bother?"

Writes to a local filesystem should never be short unless disk full/error.

Once upon a time this was yet another thing that NFS could break that no other
filesystem would break, but I dunno about now? (I think the page cache collates
it and defers the flush until the error can't be reported back anyway?)

Rob
