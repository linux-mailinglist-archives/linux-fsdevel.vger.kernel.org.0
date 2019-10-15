Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70BC8D6DED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 05:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbfJODqy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Oct 2019 23:46:54 -0400
Received: from ozlabs.org ([203.11.71.1]:39561 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727092AbfJODqy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Oct 2019 23:46:54 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46shDz4GQVz9sPF;
        Tue, 15 Oct 2019 14:46:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1571111212;
        bh=q/PUoHpaGQ1aMJQT/dQFNLxJ+BV9cLJUddGSgSiLYaM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=pRUkZIQuGKR4qqpg2naFZb9pf1kDpAldmuXM90b+cG9Xxuuz9KQmmkaXNfdQwHCKb
         dLk4krTPcyOj2QOqgd6em4j7kKBe0iegPbx6DIGkLvMcoolk8xlSrGVf7Dtfjh7iVm
         F0PNDcF3F/LfRN+VyQP2lhfylNRN6nSDJHNyTvcjrFP21TRSsTJlnkvBvCenxPY2Mv
         BPYd76Jv+RfChdkqucu4/wSad89kYsCJz9UnRLJ+MjCTGiy3k8mwFUAnn3vx5tEM/n
         52WSRet7RK0j48h9JP8baM5Zc08KopPvcVbTtA8IU/xtq6iFyMVcTjnykDp8OcRB1h
         oOWDHbwR8Gojg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to unsafe_put_user()
In-Reply-To: <CAHk-=wgO1EW5qVuy7=sc9Kua98-afMx75gaeX4FHKf3+wPLmkw@mail.gmail.com>
References: <CAHk-=wiAyZmsEp6oQQgHiuaDU0bLj=OVHSGV_OfvHRSXNPYABw@mail.gmail.com> <CAHk-=wgOWxqwqCFuP_Bw=Hxxf9njeHJs0OLNGNc63peNd=kRqw@mail.gmail.com> <20191010195504.GI26530@ZenIV.linux.org.uk> <CAHk-=wgWRQo0m7TUCK4T_J-3Vqte+p-FWzvT3CB1jJHgX-KctA@mail.gmail.com> <20191011001104.GJ26530@ZenIV.linux.org.uk> <CAHk-=wgg3jzkk-jObm1FLVYGS8JCTiKppEnA00_QX7Wsm5ieLQ@mail.gmail.com> <20191013181333.GK26530@ZenIV.linux.org.uk> <CAHk-=wgrWGyACBM8N8KP7Pu_2VopuzM4A12yQz6Eo=X2Jpwzcw@mail.gmail.com> <20191013191050.GL26530@ZenIV.linux.org.uk> <CAHk-=wjJNE9hOKuatqh6SFf4nd65LG4ZR3gQSgg+rjSpVxe89w@mail.gmail.com> <20191013195949.GM26530@ZenIV.linux.org.uk> <CAHk-=wgO1EW5qVuy7=sc9Kua98-afMx75gaeX4FHKf3+wPLmkw@mail.gmail.com>
Date:   Tue, 15 Oct 2019 14:46:41 +1100
Message-ID: <87h84avffi.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:
> On Sun, Oct 13, 2019 at 12:59 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>> Re plotting: how strongly would you object against passing the range to
>> user_access_end()?  Powerpc folks have a very close analogue of stac/clac,
>> currently buried inside their __get_user()/__put_user()/etc. - the same
>> places where x86 does, including futex.h and friends.
>>
>> And there it's even costlier than on x86.  It would obviously be nice
>> to lift it at least out of unsafe_get_user()/unsafe_put_user() and
>> move into user_access_begin()/user_access_end(); unfortunately, in
>> one subarchitecture they really want it the range on the user_access_end()
>> side as well.
>
> Hmm. I'm ok with that.
>
> Do they want the actual range, or would it prefer some kind of opaque
> cookie that user_access_begin() returns (where 0 would mean "failure"
> of course)?

The code does want the actual range, or at least the range rounded to a
segment boundary (256MB).

But it can get that already from a value it stashes in current->thread,
it was just more natural to pass the addr/size with the way the code is
currently structured.

It seems to generate slightly better code to pass addr/size vs loading
it from current->thread, but it's probably in the noise vs everything
else that's going on.

So a cookie would work fine, we could return the encoded addr/size in
the cookie and that might generate better code than loading it back from
current->thread. Equally we could just use the value in current->thread
and not have any cookie at all.

cheers
