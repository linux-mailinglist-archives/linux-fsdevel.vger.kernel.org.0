Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5A6418E42F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Mar 2020 21:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbgCUURj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Mar 2020 16:17:39 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39795 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgCUURj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Mar 2020 16:17:39 -0400
Received: by mail-qk1-f194.google.com with SMTP id b62so1706213qkf.6
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Mar 2020 13:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vyr8gxN0w1ShmFP1sTYpm+au2ajz+OpuJyfSkXy/P7w=;
        b=YRqQ7xkPuMFsxEapQ0sM1iVI2qSY9/nOw8PwuxAay73ruKMQhsv0HSvLu/AIIrtK0T
         4uGMaIFUJRhwExS6AgDUG1fIoMbfxt6MG5bOv1i08wQVTyP5Lf0iEjDEXRNAiHTgYFl2
         JhpXsybrThsaz29snRd/sR4y6C8/G+CnYmbQEEMXl43LLAdhtxIp1Pz2lmxSxky5upn/
         oeRhwWeM2nMS23Un9w3pbIwticYbMPUkmiTgNpfz0iSpzTOgX6t0e+EDHug6dW5NXuIh
         N+vn0G2SR5F9gAZxv/UPFypuB/dEnWWzp2071/o86fwXavB/f9tIIPyIh/MVxyzI9G5F
         4FWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vyr8gxN0w1ShmFP1sTYpm+au2ajz+OpuJyfSkXy/P7w=;
        b=Ex6t1uu8zYxwyFiurb/80T5fenJaYuh2FKobSN6UZOkT2uN6piqZtuzXYWrMsvNw25
         4DNO3dT/Dcud9IUGsBMYFsHcxvUCiqiO5DKvP1IEn1CQjEoMQTqdc8IDUcvID38igW1c
         CbKTBRJsF/092OLtYd777bJ/7cTitZqOmMjyksB6HYtJGaFYSv5usdDI7R9G46faDNhi
         JbAsdf5jFOokuIqIicMgPT2elwLhtj3l8Zo/fXKMxbQWdKRsq8y6yg+IfnLkXa3u5pyo
         +gCBnA+0qMGuwAI1sxqguPhDrJNcLffXD2uEuRKlUYVKOCcKbPSPXVzsEPrErvUx6BMc
         4wXg==
X-Gm-Message-State: ANhLgQ1xOSntK/zjJhPNXrkOCIbAKqfQibBYiULKGhDpVkV23qO5Fhs0
        oGf9lN4PiM9or2DgcjUR/oUJVFqo0mR0xFNWO2b/Lw==
X-Google-Smtp-Source: ADFU+vt+TCw5k9b8Hudr9YiI+1sJogFi9HrUvqg03s7m553evJPFngWeXjQc9rmkQs77MyForXRj5MJW19pGzKvtZzQ=
X-Received: by 2002:a37:7c47:: with SMTP id x68mr14502440qkc.8.1584821857246;
 Sat, 21 Mar 2020 13:17:37 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000f0373505a162d972@google.com> <20200321130716.c1da54e6e5b9897ae5dfde38@linux-foundation.org>
In-Reply-To: <20200321130716.c1da54e6e5b9897ae5dfde38@linux-foundation.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 21 Mar 2020 21:17:26 +0100
Message-ID: <CACT4Y+YNRv_yZTp0b-8rsPEAN4We_P-0Rx+sHvu95mpQUBf57Q@mail.gmail.com>
Subject: Re: WARNING in alloc_page_buffers
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     syzbot <syzbot+0985c7ea18137bf0c4ca@syzkaller.appspotmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, schatzberg.dan@gmail.com,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 21, 2020 at 9:07 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Sat, 21 Mar 2020 13:00:18 -0700 syzbot <syzbot+0985c7ea18137bf0c4ca@syzkaller.appspotmail.com> wrote:
>
> > syzbot found the following crash on:
> >
> > HEAD commit:    770fbb32 Add linux-next specific files for 20200228
>
> That's nearly four weeks ago?

Yes, syzbot did not get any kernel build that boots on linux-next for
the past 3 weeks at least, it either does not build or does not boot:
https://syzkaller.appspot.com/bug?id=0b5a478272f2f91e39199ea606c13f2bc945ac1e
https://syzkaller.appspot.com/bug?id=738c77b954cc37a5b9749c248b33e5d383a1c949
https://syzkaller.appspot.com/bug?id=d085d2f9d904d7e8f4f6f4ec2762d817f58f448d
https://syzkaller.appspot.com/bug?id=ba5d229611dfff6ce6f7470d7548cd0487292104
https://syzkaller.appspot.com/bug?id=f13120b0dfe367862cd8de7bcca9d43a566e5543
The current breakage was reported more than a week ago. Maybe there
are more breakages piled up before behind that one now...
It tries on every commit now.




> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=13507489e00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=576314276bce4ad5
> > dashboard link: https://syzkaller.appspot.com/bug?extid=0985c7ea18137bf0c4ca
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b970e5e00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=178e99f9e00000
> >
> > The bug was bisected to:
> >
> > commit c9e1feb96bd90a4b51d440a015ba2f1c0562de59
> > Author: Dan Schatzberg <schatzberg.dan@gmail.com>
> > Date:   Tue Feb 25 04:14:08 2020 +0000
> >
> >     loop: charge i/o to mem and blk cg
>
> That commit was dropped on March 3.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20200321130716.c1da54e6e5b9897ae5dfde38%40linux-foundation.org.
