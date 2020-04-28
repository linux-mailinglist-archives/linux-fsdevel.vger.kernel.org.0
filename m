Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93BAF1BC453
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 18:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgD1QAp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 12:00:45 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:38497 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727919AbgD1QAp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 12:00:45 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N1x6X-1j1FWX08Nt-012FSO; Tue, 28 Apr 2020 18:00:44 +0200
Received: by mail-lj1-f174.google.com with SMTP id h4so8489311ljg.12;
        Tue, 28 Apr 2020 09:00:43 -0700 (PDT)
X-Gm-Message-State: AGi0PuaH9CWbz6VDvkF8muVwdaa93/5Y8Ep2vWRe8LCHk0gxiaWtpbnj
        avnntef5bf1S/FshHUQzZ6GAs7c3qNR2SmsGExo=
X-Google-Smtp-Source: APiQypJThOW83qdHGHzyhkH4sJ6U4sXcXcn5825s0jldl8o9a+uRjS1sadwzmhdc0oXB7iboieBolhXuuMdbgRNNgT8=
X-Received: by 2002:a2e:6a08:: with SMTP id f8mr18875369ljc.8.1588089643465;
 Tue, 28 Apr 2020 09:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200427200626.1622060-2-hch@lst.de> <20200428120207.15728-1-jk@ozlabs.org>
In-Reply-To: <20200428120207.15728-1-jk@ozlabs.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 28 Apr 2020 18:00:27 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3ytp2eLa8sfC0se5fR-DFxMjqEh8_Y2N4PeH-yo1nhxw@mail.gmail.com>
Message-ID: <CAK8P3a3ytp2eLa8sfC0se5fR-DFxMjqEh8_Y2N4PeH-yo1nhxw@mail.gmail.com>
Subject: Re: [RFC PATCH] powerpc/spufs: fix copy_to_user while atomic
To:     Jeremy Kerr <jk@ozlabs.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:pFw3rJORyrPqFTHFaQJ8Sw41Bi/fLRuFXG0fbN/Sc/C3c66FBtN
 1SppYFg6Rl4UsuO+8o8Du5mxZYxNiLjcaMyq6+mCPOMf4GFwCONWjHLtnLTXee3NYID+T0c
 b8q+TaRl58sY89E5RcafEg9sPglybvCdggMzLnDM8WkBnKTG/5orPnt5w2ru/VeiI8AUvrD
 f8hnUtlryIhNy7N6kgaVg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:55D9+ZEbbbQ=:sXPmdQr5w/o721XUrsUrSC
 p0eHd5r6e9a/XD71rhQoRocJUepfNo2Z7PQe7CiXFgqammPLYDzKOemEF55m7Tl8ySu1FmWr7
 81/nfVnI84bKGXiAi/tlnmbkRaifAQ6576RY+pjquHjxk7dzJabMa2CW3NWVb/QCsFPt3RU+H
 pbpvbC/Nka9J9VjUnWnJrlex8/NQM3quvzrcgxDn0NDT3RPUM86H7tFhsmZJXzgd1YvLb3nkw
 Gatmfm8As9qjYwLLbqPS1MUd4sbeVqvfHnQF+HhiwmdUORW0ImY2fSxn7n98/JAMg0LIx07hI
 ZE5ZShTWbjpIEMEBmOge7OA42/4jyd9BdCuDJfPOPeILXp0IiRb7uEIELnKL7OSAjLr0hPbkB
 bzsiRfLg/ozrcL6b2IsCavTO+lXSE2CQXUtA7RAT08xOyGYWDv+oBKkBhVwLpewVKmglGffif
 eJizjKb5JBgSVAYCSbd4iPVje0Q5ejaujFTctRa6M9BoK1YRQyMZP1IaP+kXLM59vYI+E3cFY
 cHtpQJKDE6r4wIVHIexc5sN1u52uF0f40i74WstDxztbQo6XcndypyTqnBqWaAT//2JZr6dcH
 oo4XqsQ+srx0Ie2vri2eOHhEe8zaCY/QPLeiLXR6FPt2x0C5XnrEhvJlXnRBKGXA4KLu4nceA
 KhHuGaMD+0EOmIkMmFNoRRoQd1QmO61XYAlqpPY/WA2tysn9sJjAcsy2A+ox+2PlKWkOfw1Kk
 RRW983OdyTFHs4oWmvWRuNB3MImmV8khMIDb7v/8j/Zb+OJjbY25H92iKUKwg5CUokTE6qmfL
 KCMwm1fiJesVKIyJ8hntfFdCyyip5wUIPC7ZbaFSoDY3JAi/BM=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 28, 2020 at 2:05 PM Jeremy Kerr <jk@ozlabs.org> wrote:
>
> Currently, we may perform a copy_to_user (through
> simple_read_from_buffer()) while holding a context's register_lock,
> while accessing the context save area.
>
> This change uses a temporary buffers for the context save area data,
> which we then pass to simple_read_from_buffer.
>
> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
> ---

Thanks for fixing this!

I wonder how far it should be backported, given that this has been broken for
14 years now.

Fixes: bf1ab978be23 ("[POWERPC] coredump: Add SPU elf notes to coredump.")
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
