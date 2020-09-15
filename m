Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204DB26AC71
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 20:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgIOSqJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 14:46:09 -0400
Received: from mout.gmx.net ([212.227.17.20]:52619 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727872AbgIOSpn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 14:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600195470;
        bh=B31pD7D2sccJgZjLSpQrpxyG+i1b3lP7zRQ7GgeJ0Ig=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=EsuZ9KONYBvLuz1orfuvnb/zRCqBqa/mXqJIWVfBiMWs0Jk0xokvTM2/RzzN+mdiy
         l/hztbBJckUE5aZK3raUkSJ7ZucSYhvlt707gaN+no6MwVKEpkxYWWL5QKtoe8SL74
         FDrftWHjo348TLOzXJ7Ztow/mOWgXJQZNbZTjX6o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([79.150.73.70]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MMGNC-1k2NVz2rpe-00JJl0; Tue, 15
 Sep 2020 20:44:29 +0200
Date:   Tue, 15 Sep 2020 20:44:19 +0200
From:   John Wood <john.wood@gmx.com>
To:     Jann Horn <jannh@google.com>
Cc:     John Wood <john.wood@gmx.com>, Kees Cook <keescook@chromium.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-doc@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Subject: Re: [RFC PATCH 5/6] security/fbfam: Detect a fork brute force attack
Message-ID: <20200915175831.GB2900@ubuntu>
References: <20200910202107.3799376-1-keescook@chromium.org>
 <20200910202107.3799376-6-keescook@chromium.org>
 <CAG48ez1gbu+eBA_PthLemcVVR+AU7Xa1zzbJ8tLMLBDCe_a+fQ@mail.gmail.com>
 <20200913172415.GA2880@ubuntu>
 <CAG48ez0BcSY0is2LzdkizcOQYkaOJwfa=5ZSwjKb+faRwG9QCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0BcSY0is2LzdkizcOQYkaOJwfa=5ZSwjKb+faRwG9QCA@mail.gmail.com>
X-Provags-ID: V03:K1:HFDnSb2MWhINTQ+V1WFfxA497qE6aAUEa/2kIVw6n9wfon3ph1l
 1qX2pXf4G8fZlf1vXI5CUUJ0xAowRC3vdgBEc2p6hocs7C1ts73hYxVw1HwXQxFef+GxdK8
 zqMWid9SgMcrL+CYGopt594fxmc+sEKZYRTg4JNnf71Kf1Ob6hpSAxueSdYfR+sOjZQPrms
 edQ8vMbuZcbovLlFEvsyQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xx2DZ+0hWyI=:nvyTRQBte31zC0s60s8C+M
 kOGSY2G49n+xtijXKjcz/mq3JhxmKX0l3Z8m4go9IvN5zXRHrY0nlqpzQLCVHRTcfxIFjYw/G
 JwVTyeHsRwnIwyYeY8j8WTHGisSariEVK/UcNGio5yD6cUfqEioz+S0WOGfE4Klh+0Szf3wqv
 +IH8doSThUkx7Fd97LddLDl+KO7uZ6o4mMwOwbcOOr9oA2HXGv7UEPvob8SSf8XiG9y9HCWOr
 4L+ecdZU95mq21cIZ8CUVbUpxVN3x2gHVOIk2GwjtqEJct2XZNDtMmnqrZoDJyiMAgjS3d0b/
 gF9vsPAz7MGQXwmIB/6F5d/pK9zhiTKwrrHsaj2aN0dVQ+7k3j4eTNoMUMMomIAVxzRZrFdW4
 3RtJHMTItTuQ+q+ME0hmpy07hTHbo74C7OJqkuPctK8Qu2BfGT2cVTZ5X4IkJpLiKDQPxZtwh
 S0wJBasnev76pI6n6dSh1rw15g+PGdvMXhWs+07UFOrDlT5s8KVhyI2xEAKOq3oaGvm/VYcoF
 twHcwUHfTeBwHNdz0CkqPSm0fFs2ploxanxppsXMHZvHU0Ktjvu6krX6+ctZxxK1a5b0gqv6k
 fm5bNISVkH36XSelod+TA+S4Ir8ebVm8zI7+04BXpIWIpHC3d985CVAndn3WJLg/2eiP8WjnR
 k9EqGZCT/lIq1zyEE/8SOU0xrJyUExgWqnhC4i1zWkm9kKpvdzXdDcCMwLZ1ewXC7oAFFj80V
 r4hY+cl3mRdHAlAy4JgkEIZoQVulOc5eqMLf/0mSnM5Qgd+7DL64vAg2xcqBZQzlXuJ89M1Qg
 6aV5gGH9YLeHMW82/F4d443Vx43f5bQung3/I0hUfV+bRg2Me50xt2AH3uC7Bnsv58+nMSuPG
 yN1YtjDYsCwO4enn+wLzGjQbHHQ7eWYFtKPD0jSoQnM9fAnCSWzLcolztviAnaRBiEXIFA0ZS
 K1VJ2DenRCbTHJ0nTi0FGy4TLXkUcKoIDcAPud3eqcbDkW9X5OcudSoACAqfYz9nthbwMBwGw
 a5kaGMAGxoeNm1xFuZULgnM/yjddeYmH1kVZZES8UziLJXIWstV4z4MgEcPJ0v96YEdI46go+
 V5XBeBXn1IYQS/lE1ZMfj99NqbqGMv0g7beOt3mHy2Ulyq06VPPB3QZn2GJUSsjAl7Y0/4CrB
 2qxAUhOLpobD5nwrQYVzYcQmUM8Vh2kSPQrqezetYanOKsBLqD5unw7gxvcEA017Zo/iErihG
 B3bwnEwSe/MFCUXchIhdJgKStou1HNct+WoL6FQ==
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 14, 2020 at 09:42:37PM +0200, Jann Horn wrote:
> On Sun, Sep 13, 2020 at 7:55 PM John Wood <john.wood@gmx.com> wrote:
> > On Thu, Sep 10, 2020 at 11:10:38PM +0200, Jann Horn wrote:
> > > > +       delta_jiffies =3D get_jiffies_64() - stats->jiffies;
> > > > +       delta_time =3D jiffies64_to_msecs(delta_jiffies);
> > > > +       crashing_rate =3D delta_time / (u64)stats->faults;
> > >
> > > Do I see this correctly, is this computing the total runtime of this
> > > process hierarchy divided by the total number of faults seen in this
> > > process hierarchy? If so, you may want to reconsider whether that's
> > > really the behavior you want. For example, if I configure the minimu=
m
> > > period between crashes to be 30s (as is the default in the sysctl
> > > patch), and I try to attack a server that has been running without a=
ny
> > > crashes for a month, I'd instantly be able to crash around
> > > 30*24*60*60/30 =3D 86400 times before the detection kicks in. That s=
eems
> > > suboptimal.
> >
> > You are right. This is not the behaviour we want. So, for the next
> > version it would be better to compute the crashing period as the time
> > between two faults, or the time between the execve call and the first
> > fault (first fault case).
> >
> > However, I am afraid of a premature detection if a child process fails
> > twice in a short period.
> >
> > So, I think it would be a good idea add a new sysctl to setup a
> > minimum number of faults before the time between faults starts to be
> > computed. And so, the attack detection only will be triggered if the
> > application crashes quickly but after a number of crashes.
> >
> > What do you think?
>
> You could keep a list of the timestamps of the last five crashes or
> so, and then take action if the last five crashes happened within
> (5-1)*crash_period_limit time.

Ok, your proposed solution seems a more clever one. Anyway I think that a
new sysctl for fine tuning the number of timestamps would be needed.

Thanks,
John Wood

