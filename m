Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457993B09AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 17:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbhFVQAv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 12:00:51 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:44741 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbhFVQAv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 12:00:51 -0400
Received: from [192.168.1.155] ([95.117.21.172]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MAfpQ-1m6kL42Oim-00B6o7 for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jun
 2021 17:58:34 +0200
To:     linux-fsdevel@vger.kernel.org
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: understanding do_dup2() vs fd_install()
Message-ID: <674f31a9-eee7-4e4a-29c2-86ff43cd6b76@metux.net>
Date:   Tue, 22 Jun 2021 17:58:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ms99ijOPQPGG2t55TXsjwFXxr74K9Goo+W2S7pXMeSv45RI+wpK
 xNxUG4zZ77y7rlJcz36FrcHrDyn1JLjl06eJB1fxyi+1dvRaTEaULWkVhKQxoDMV9zs/5t1
 vqja0l79l7cJlNMWgV98FpBjPcTQtY0gi53xcbzEwu78ljjXM+9xTcPtSf2iHZsZ+AMwX6N
 ujHBuGENbdfPlgZM1mI6A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:unlf1G+LdXw=:m0qPQOeV+geEWselUba6CP
 w11Uon3uL4bVUBSTJT2Mx7TYq83mpr9dpCGSl5SCYcF7ZRrVKXfUu6rsBk3CkfMbjLPsufQN/
 lwUGIvxhraXSO+1fu2E/VpQgtxa2PTV2KJMID2lb2LCejw/gqYrC5YvAod2PCLRNHnmBj5h/N
 kIzHvgg0zi3nRv9ZjBQqw4RpM15Y2IafkA95zaE9x8BRSTdl/Y9qL4D/UYTIh4eYh+ZrKIs2b
 5kh8FW1Wt1eV8w6SUagDDPLG8KIzE4sidRuEUf/33phHs6UFRO6LWbE0ZLnzseWfHdFg9wzUX
 WaNMfjwQq10eBbM50xdZfFmud4QCnR16+Ubspi63kshSOiN4+dZtckBGY9eYnvBLqaA8wRfeF
 wlk1MS26ub+FfRtzWQiBcxOt6xyGh+E2ywIbnuQpn0e+59tJuSrvi6g2r7jyzME4jq3g3W7/a
 y9DFfRrrUkoXdrvqZDd17cA/wn6pFNYP9qEzVVZHrgAdM7inBU7+7pl5Od2Bn/ffACU8MIWaP
 n/4KBgXroLOisN030Zzegs=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello folks,


while digging deeper into the fs internals, I began to wonder whether
there might be some overlap between do_dup2() and fd_install(), that
might go into a common function.

If I understood that correctly, both link a struct file* into some
process' fd table, the difference seems to be:

* fd_install() doesn't need to deref the old file, since callers
  allocated a fresh fdnum - while dup2() has to (if the fd was used)
* fd_install() picks the fdtable from the current process, while
  do_dup2() directly works on a given fdtable.

Oh, and there's also replace_fd(), which calls do_dup2()


Just phantasizing: can we put it into something like that ?

int do_assign_fd(struct fdtable *fdtable, int newfd, struct file *fp)

  --> put or replace fp into the fdtable
  --> if newfd == -1, pick a new slot, otherwise take newfd
  --> checks (eg. rlimit, etc)
  --> unref/close the old entry (if non-null)

int fd_install(unsigned int fd, struct file *f)
{
    do_assign_fd(current->files, fd, f)
}

Am I missing something vital here ?

By the way: do_dup2() is always called with "files" parameter being
current->files -- why do we need that parameter at all ?


thanks,

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
