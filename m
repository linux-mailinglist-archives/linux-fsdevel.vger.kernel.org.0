Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7B32C9E4C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 10:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbgLAJrE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 04:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727892AbgLAJrD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 04:47:03 -0500
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82303C0613CF;
        Tue,  1 Dec 2020 01:46:23 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4ClcgJ1NLgz9sVq;
        Tue,  1 Dec 2020 20:46:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1606815981;
        bh=fD4i2kWXYM+NtcZwGi7GTAphrjHdrxgTeHlMHf91pa0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=lOWjBLMUC9WIwnhRiztyWkKagDwj6VM4DtUDLlX9dsYxaM0KfRpzIwn2NEsGwyAHI
         JWChlSyQwEaZDEJY2iznV9TMCvsKQn/lj3dEatn4CSDhv4TFH6D6SRc/T575MrOwUt
         6XJM1OgLF8NzenHXp4v9k1GTrHq4XOrW7HZcJCWoBDuseDL33J6FUUjMFzkYSACsKy
         Vu+wLorwjC+DHzqxv9DTHlxQSnxSTN04hEZtH2uI3Q0mh5gCPhaw52+aafk16VteWW
         y8JumwPf965YkB4gV7wf8I/DCZM+duKMrfajQssf1KKsqrWj3PYevBAaq9lqq1tZzS
         HmveDfLK7KJNQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Arnd Bergmann <arnd@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Geoff Levand <geoff@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 02/24] exec: Simplify unshare_files
In-Reply-To: <CAK8P3a0hPG1cTxksTBCJHkAV_=TLZLCi2pZYMk2Dc2-kLzD3rg@mail.gmail.com>
References: <87r1on1v62.fsf@x220.int.ebiederm.org> <20201120231441.29911-2-ebiederm@xmission.com> <20201123175052.GA20279@redhat.com> <CAHk-=wj2OnjWr696z4yzDO9_mF44ND60qBHPvi1i9DBrjdLvUw@mail.gmail.com> <87im9vx08i.fsf@x220.int.ebiederm.org> <87pn42r0n7.fsf@x220.int.ebiederm.org> <CAHk-=wi-h8y5MK83DA6Vz2TDSQf4eEadddhWLTT_94bP996=Ug@mail.gmail.com> <CAK8P3a3z1tZSSSyK=tZOkUTqXvewJgd6ntHMysY0gGQ7hPWwfw@mail.gmail.com> <ed83033f-80af-5be0-ecbe-f2bf5c2075e9@infradead.org> <877dqap76p.fsf@x220.int.ebiederm.org> <CAK8P3a0hPG1cTxksTBCJHkAV_=TLZLCi2pZYMk2Dc2-kLzD3rg@mail.gmail.com>
Date:   Tue, 01 Dec 2020 20:46:19 +1100
Message-ID: <87lfehx3is.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> writes:
...
>
> If there are no objections, I can also send a patch to remove
> CONFIG_PPC_CELL_NATIVE, PPC_IBM_CELL_BLADE and
> everything that depends on those symbols, leaving only the
> bits needed by ps3 in the arch/powerpc/platforms/cell directory.

I'm not sure I'd merge it.

The only way I am able to (easily) test Cell code is by using one of
those blades, a QS22 to be precise.

So if the blade support is removed then the rest of the Cell code is
likely to bitrot quickly. Which may be the goal.

I'd be more inclined to support removal of the core dump code. That
seems highly unlikely to be in active use, I don't have the impression
there are many folks doing active development on Cell.

cheers
