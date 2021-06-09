Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2443A14F4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jun 2021 14:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhFIM4x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Jun 2021 08:56:53 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:50281 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbhFIM4w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Jun 2021 08:56:52 -0400
Received: from [192.168.1.155] ([77.9.120.3]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MdNLi-1lHcyo1ej2-00ZQyo; Wed, 09 Jun 2021 14:54:50 +0200
Subject: Re: [PATCH RFC] fuse: add generic file store
To:     Peng Tao <bergwolf@gmail.com>
Cc:     Alessio Balsini <balsini@android.com>,
        Peng Tao <tao.peng@linux.alibaba.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>
References: <1622537906-54361-1-git-send-email-tao.peng@linux.alibaba.com>
 <YLeoucLiMOSPwn4U@google.com>
 <244309bf-4f2e-342e-dd98-755862c643b8@metux.net>
 <CA+a=Yy5moy0Bv=mhsrC9FrY+cEYt8+YJL8TvXQ=N7pNyktccRQ@mail.gmail.com>
 <429fc51b-ece0-b5cb-9540-2e7f5b472d73@metux.net>
 <CA+a=Yy6k3k2iFb+tBMuBDMs8E8SsBKce9Q=3C2zXTrx3-B7Ztg@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <295cfc39-a820-3167-1096-d8758074452d@metux.net>
Date:   Wed, 9 Jun 2021 14:54:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CA+a=Yy6k3k2iFb+tBMuBDMs8E8SsBKce9Q=3C2zXTrx3-B7Ztg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8iQzEZshRlVeFdhrivWFvUfm+LbDY2TdSweMOmBNNDN6UntE5Rz
 2eW0JGSs7bAUG38J/BRW5MLhv+Tx3kGHh7SNVOtFJeR/wCWkBBbM4YW1vQFZnPfpZfSet/i
 cznf2S95K3tdwodTg/Kh8XtgnHqMxZ/BzF9ikhjM4PdQFdDoTrnBrvzLM5lW+QvsTOcoGmc
 mSJdxsXwi6ldDkUgD6oSA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/gZD5zg8qw8=:rkT+S2RGaUMWZApFHpugE+
 WJNEy9t9YbTB1Z9l2VL2492CTKviD874TuF5qzGNNKUBnF/HzbjdzkaMpWGBl8oOHWXKBUkuC
 iE5TmlPdL7Mok/A+c9TvMqOk4uWSUgCVG3ZTBO3sbhrVCjRTyUuJPudg5qi+MTJ2YPFF8BSv4
 TEk6mm1zr8wqOj90MJPCWJ/bxdhOT9xarVFHB8+t46WtwByh/OD/8tek/b+fcAMFtCM0hKlzg
 XECMHLJcJJwfE1OCMhzdkjs8tX/WjiEL19apoDgDuZywlAqhxBtQvxgHbfre/B9ERPt3iIptU
 Taq7fAnKmWjaVbY/ibsbcqSWKUxiuzvw0lb+DNLcsHp+RYTs3b481/S1+wC7iVT2QCySahWFl
 WiRbAnLfqwHQofp00YeGwcxOhyJFETEpQupFQQeUQxN3gbOENRW2ochGoHS8Kss6KBeNFRc6f
 6eogao6uI85Dc8dkDw7P5sSnziULDPqs7vuXg5EpkCGsC9XDfGTVln8q60DCnfH3I0SeBEVDI
 ivyjbhgJjLnJcIZDotL8M8=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 08.06.21 14:41, Peng Tao wrote:

Hi,

> The initial RFC mail in the thread has a userspace example code. Does
> it make sense to you?

Sorry, I had missed that, now found it.

There're some things I don't quite understand:

* it just stores fd's I don't see anything where it is actually returned
   to some open() operation.
* the store is machine wide global - everybody uses the same number
   space, dont see any kind of access conrol ... how about security ?

I don't believe that just storing the fd's somewhere is really helpful
for that purpose - the fuse server shall be able to reply the open()
request with an fd, which then is directly transferred to the client.

--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
