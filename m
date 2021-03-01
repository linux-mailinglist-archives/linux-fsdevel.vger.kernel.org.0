Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA4D3278BD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Mar 2021 08:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbhCAH5S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Mar 2021 02:57:18 -0500
Received: from mout.gmx.net ([212.227.17.22]:59333 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232676AbhCAH5F (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Mar 2021 02:57:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614585331;
        bh=XFHC5ac0afiwN0pQnK766BXUmPRnF49/Wtqs8//J58Y=;
        h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
        b=bBZaGgjk1ir7vzVljTSijS49xv1dBsF0fygubfDbRNhZiePlRofHwWKeUU+ydjREk
         xxFUwQCAOU1DetwSk6jxYfZFxWnRZFOJJag3byOmqBHVk/csgTgdsebjpsKFU5tsKm
         VyvvPR/BCHgGl9SJoY+yW+EXMAqm8s5baV/nbCdA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N49hB-1lys1D2pH7-0106Vo; Mon, 01
 Mar 2021 08:55:31 +0100
Subject: Re: Bio read race with different ranges inside the same page?
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <d38d7a97-b413-a5cd-1c86-193453c4b51e@gmx.com>
Message-ID: <bb189a2f-e419-c4f1-3b2b-90c5a401d81f@gmx.com>
Date:   Mon, 1 Mar 2021 15:55:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <d38d7a97-b413-a5cd-1c86-193453c4b51e@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XwNEUF4niBnVchOqI0g04ORLCU6AvCrehJz4d56IOGkLGQAc8F/
 KpF6xzpJag5UtBaP9eSqM5b5V3ebtcenrb3fmS1NuxPAjFPs/lex5v8+eUujWyv5jmYruQ5
 4g3VGGecBWGeIlOZzqneXMkX6AQGW7S4Uv1er3Ip2XjNmLWQyNQyVQbVZvVAWXv7Y9o7tup
 tuOnf68sxuIV+1h7XY4AQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:B2H8Rnftp1I=:uspYPD5ev2CB9kmOVyaC3h
 g0vVHxuUqodQr+f6nmLvdoNZ7gsxFnr0uEwXoqUFBpzSmI0kiW5DpE9Idts/OR0LxnzgGoytN
 Kjht5BrndP2ecWiwQhHBCG8peoZoa6xdzBt82uPQtTBAqtPaWcSLUpATUD8u4DdsaSrInA457
 prWidvHkzSQ3GwjAC2OW13lS8GFtBR7pYguZMdgN95sbeFffERAC7eqrDAQOeKUp/j0ip90qW
 9iiWZZMw41oKUcT9S6taxEezcJH4ct12VYjAdGl68MedneXXWjmDQNMeg6z3va4ChzhC1b7fQ
 +ymFlyJDaGB9MNAAPqNm59p91mHEyynCxK4C9UEFUJ1jQ3ixwSCv5mZtMPQRtyc3VnNdx3Qch
 odabRsoomuyaSm19CHzW3nahNES5PgBx6tKf9P4jyDA5HEPGkju04UBRK4JjCLJPeFiWTjHVN
 5mF6xuRB59mt+bk2KiSR+a4oQzhqjgluUoUlB+Apbi6LhdPtyP0h2BdKI4FQPbUJVjGuuzKIP
 mY96bOXJxA4KLznN8Vyp3NKLQJsBbzorGruJIkCTiFy9NeWsr7pU57anVnjI12nB+lx41vqWl
 3bJ9ews62HvtKoobFypCS2hYFkWF14sfHpyQIHQw0WGVOj35cc0XFlUu7xLYYnHpE2Rdk9YNM
 50p5q7wAL1JpGK1a4Xb8RaI0awAiwya6g+hi/t6jp+vcx5VANz+FuRs9ADmHPhQ90jrsDAYOV
 c8vtr4Fx9zL0ZopytoyWpZZmozCnuJZCKmkXNefwHqqqlkO2jSdELUHLDnYhhmXROZa6aFHiM
 JbIH0FW1miKbEZVqWqf8R9bJe23TR1tNs8p+hZl9Ja36BaTSfyuU6lxX5WEzEXX7miwIIgxiC
 PzldvLz2KHhU8DJ9u9CQ==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/2/26 =E4=B8=8B=E5=8D=883:02, Qu Wenruo wrote:
> Hi,
>
> Is it possible that multiple ranges of the same page are submitted to
> one or more bios, and such ranges race with each other and cause data
> corruption.
>
> Recently I'm trying to add subpage read/write support for btrfs, and
> notice one strange false data corruption.
>
> E.g, there is a 64K page to be read from disk:
>
> 0=C2=A0=C2=A0=C2=A0 16K=C2=A0=C2=A0=C2=A0 32K=C2=A0=C2=A0=C2=A0 48K=C2=
=A0=C2=A0=C2=A0 64K
> |///////|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |///////|=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |
>
> Where |///| means data which needs to be read from disk.
> And |=C2=A0=C2=A0 | means hole, we just zeroing the range.
>
> Currently the code will:
>
> - Submit bio for [0, 16K)
> - Zero [16K, 32K)
> - Submit bio for [32K, 48K)
> - Zero [48K, 64k)
>
> Between bio submission and zero, there is no need to wait for submitted
> bio to finish, as I assume the submitted bio won't touch any range of
> the page, except the one specified.
>
> But randomly (not reliable), btrfs csum verification at the endio time
> reports errors for the data read from disk mismatch from csum.
>
> However the following things show it's read path has something wrong:
> - On-disk data matches with csum
>
> - If fully serialized the read path, the error just disappera
>  =C2=A0 If I changed the read path to be fully serialized, e.g:
>  =C2=A0 - Submit bio for [0, 16K)
>  =C2=A0 - Wait bio for [0, 16K) to finish
>  =C2=A0 - Zero [16K, 32K)
>  =C2=A0 - Submit bio for [32K, 48K)
>  =C2=A0 - Wait bio for [32K, 48K) to finish
>  =C2=A0 - Zero [48K, 64k)
>  =C2=A0 Then the problem just completely disappears.

Never mind, the bio read part is doing what we expect, they won't really
touch any thing beyond the range specified.

It's the endio of btrfs end_bio_extent_readpage() doing zeroing which is
always to page end causing the problem.

Thanks,
Qu

>
> So this looks like that, the read path hole zeroing and bio submission
> is racing with each other?
>
> Shouldn't bios only touch the range specified and not touching anything
> else?
>
> Or is there something I missed like off-by-one bug?
>
> Thanks,
> Qu
