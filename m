Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F26F64400D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 18:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbhJ2RBH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Oct 2021 13:01:07 -0400
Received: from mout.gmx.net ([212.227.17.20]:33695 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229837AbhJ2RBH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Oct 2021 13:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635526680;
        bh=PQSF2kwc9XvAbcPw1umV4sRijG9uQxe85svQW+ye6D8=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=A6fMe1SD/QfY/u7RUeUTIQShp8S2JAOReGKF6lgJ661TeynVAvxrDUPzD3WFFQWJt
         GvWNJbOPAPjRWbMLc9SILU4h5OaWJQChMPrbLieqmEHBFcx8EFgoJjW8oNiKMaO6iI
         kks4QrU3CGGtKORiyfgN6n6SQ/EdB7V2LlpEAcno=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from titan ([79.150.72.99]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MDQeU-1mX7ok0ucI-00AUNu; Fri, 29
 Oct 2021 18:58:00 +0200
Date:   Fri, 29 Oct 2021 18:57:47 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Len Baker <len.baker@gmx.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2][next] sysctl: Avoid open coded arithmetic in memory
 allocator functions
Message-ID: <20211029165723.GA2124@titan>
References: <20211023105414.7316-1-len.baker@gmx.com>
 <YXQbxSSw9qan87cm@casper.infradead.org>
 <20211024091328.GA2912@titan>
 <YXWeAdsMRcR5tInN@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXWeAdsMRcR5tInN@casper.infradead.org>
X-Provags-ID: V03:K1:uhxsTK0y1/L3ecQyfEpCS0Dknh7g0VfMMUnqrACWVyGnY3LDzWz
 9mG41Orf2n8PelbSEivjj+1X0kRaRw3AINkibV51cpEB4ke7B6xKgrpKap806ZtV4ukT5qw
 tvf4pNzzyg/Tp14fDbrEftJPoyCpeoWdW9wIbL5IccxVU0pdL5dg3dAZTx9YMbrUiFBnp8p
 vPQ4vN3yp5Mq4FYoPIQ9Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/1VxPLEeB00=:1T9BStBiezKzzXnnRRImlx
 LC1bLzUKmCbrfCvHxY6i+Mm9FpHnhntPz0nFTkW+JPpoQ6MjJI4dTVH7STLshzB28ampH8hhr
 ILgeTv9ylXsaS8sA6MLCDErb1lNFMnq9qft64W5PUi47XadYmiIkq975Kcr/T+NiK8VPUbonb
 qEu8TD3CmChx1vBilnXWrrONUjtpu0H3rFRDAenf5rjEhSh4zTLlebAC0up2ojYHOvNxQjXV3
 85hByIiLvEnyZ8s63u4PTfvT0cwSAUyCX/yQEP6PPvJGdTNQ8N1jaB2L6QbzFrG6YgQlpvKr1
 JIf5yKf0f4/X/Jo6ZHxy30te58sHDh29FyFnZrNT40UWUmy15qJD9LpkUI/Bnr9sycYM1XPwx
 a4J3D7eYuKHWoysy+eJUPTBN7TE1cXoSlH2RM6qC0/sorU2aUq6iaYSMvZJDCIU91pM8aCsff
 3N4+foHo/1MHpZxYIyognia6RaPcpQtUZKapo54sO6w/u7gn/e1Xl5yDTlbqwdWPYpGrw5xU/
 Amf57ZBeSS9GGPpBeMRSp8tbQnaHUSu3j5ThuwjMMZwOLgSIPSr5HHXxuI2ijPmffxOUPqrt+
 UlnMIOawWp20+e3VyaIu0REjIl7TX4AiNBQZ9znBwx+FF5qxIuhCfDzm2p2vmFLSrULfrseVc
 is3B9kBgJrSU4ohO9JcRsofO0yE1qYznu31T8GCSESlUrZkabNW0O6pKaYOEoodnsQlGnllgA
 HQVu1vxgwJWX0PcDJTctxRXYsEfU6Rfl6Eqt6zCydLB/z3KM2hY9LcO6weHsS7qsGNzxazEWt
 Z5klipWv85BG/u9+Oi1UwvJGAWQOa8o1cOqnxK4L/5lkcoJVq8uPumAEpE07brwtNuUCUsdwa
 22acGEEetMAVvv08degDwKGri897zPk9MBJCYx7/FYd8ihzVWC38xlfOO2cmzkrj6F+driaU9
 OydBS48s0Oq+Qoj3A6H0yeWJyX70ocxAkNMDdxxrPnVceozO58d4OoHp+tqUvcipBIczlzDNZ
 8TwqOCi37kTbDvpbC4PedsB9sIvPU2aSMrTnivbnCwvLlUP1cO+mT3Eu8rIcV2sVqseVU15J5
 QoHxZm9looDrmE=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Matthew,

On Sun, Oct 24, 2021 at 06:55:13PM +0100, Matthew Wilcox wrote:
> On Sun, Oct 24, 2021 at 11:13:28AM +0200, Len Baker wrote:
>
> > As a last point I would like to know the opinion of Kees and
> > Gustavo since they are also working on this task.
> >
> > Kees and Gustavo, what do you think?
>
> You might want to check who was co-author on 610b15c50e86 before
> discarding my opinion.

That was not my intention. I apologize if you have been offended. My
intention was to involve Kees and Gustavo (who are working actively
on this task) to add new points of view (if possible). I'm so sorry.

Again apologies,
Len
