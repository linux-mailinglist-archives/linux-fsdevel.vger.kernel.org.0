Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54B21EFC0C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 17:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbgFEPBJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 11:01:09 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55500 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgFEPBH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 11:01:07 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6AE7ED27C6;
        Fri,  5 Jun 2020 11:01:04 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=RQ5UuhFDdm6pYUURqgzo84j9G7A=; b=Sxoay7
        F4gA4GZdu5Zg9uUlmAkW1Zt5FcDuXuyxgJg0J1/2YOTh+oGVFPS2XCXNhnKxruau
        MDtfSlY0eXyRJHtGFbaGy1GRIGwT91daJ30IGzYPPomdVWXXQA2tHr5SlWDA734m
        bZRjhWd3q6ijPU6K2wBSKxViPDDqydIEEmReM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 61111D27C5;
        Fri,  5 Jun 2020 11:01:04 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=kGSNSFs79QpTCdEy/syIPtk8e7qpRSOVx3t4YYHSTPo=; b=Zz/eImY/hca3rOTLiCqOYWoaV6plgEo+kdFnlRPQFzRcUQoLXjJn0FtfTD7ckQtTqowgcbv/qHCqzK+ScMEpsSblxLiajcMT9GhFudy2osyOw0c/0yOkmdHSrAU5J6sKLf0oVK0xHwQO8Q2r0bmcLvvl02K0jlrhpKiphQGd6bE=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 263D0D27C0;
        Fri,  5 Jun 2020 11:01:01 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 25E392DA01E9;
        Fri,  5 Jun 2020 11:00:59 -0400 (EDT)
Date:   Fri, 5 Jun 2020 11:00:59 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Laight <David.Laight@aculab.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>,
        Joe Perches <joe@perches.com>
Subject: Re: clean up kernel_{read,write} & friends v2
In-Reply-To: <d67deb88-73a8-4c57-6b37-c62190422d65@amsat.org>
Message-ID: <nycvar.YSQ.7.77.849.2006051039350.1353413@knanqh.ubzr>
References: <CAHk-=wj3iGQqjpvc+gf6+C29Jo4COj6OQQFzdY0h5qvYKTdCow@mail.gmail.com> <20200528054043.621510-1-hch@lst.de> <22778.1590697055@warthog.procyon.org.uk> <f89f0f7f-83b4-72c6-7d08-cb6eaeccd443@schaufler-ca.com> <3aea7a1c10e94ea2964fa837ae7d8fe2@AcuMS.aculab.com>
 <CAHk-=wjR0H3+2ba0UUWwoYzYBH0GX9yTf5dj2MZyo0xvyzvJnA@mail.gmail.com> <d67deb88-73a8-4c57-6b37-c62190422d65@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1427214125-1591369259=:1353413"
X-Pobox-Relay-ID: 5EB18F9E-A73D-11EA-B614-B0405B776F7B-78420484!pb-smtp20.pobox.com
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1427214125-1591369259=:1353413
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, 5 Jun 2020, Philippe Mathieu-Daud=C3=A9 wrote:

> Unfortunately refreshable braille displays have that "hardware
> limitations". 80 cells displays are very expensive.
> Visual impairments is rarely a "choice".
> Relaxing the 80-char limit make it harder for blind developers
> to contribute.

Well, not really.

It is true that 80-cells displays are awfully expensive. IMHO they are=20
also unwieldy due to their size: they are hardly portable, and they=20
require your hands to move twice as far which may sometimes impair=20
reading efficiency. So I never liked them.

My braille display has 40 cells only. So even with a 80-cells limit I=20
always had to pan the display to see the whole line anyway.

My text console is set to 160x128. The trick here is to have the number=20
of columns be a multiple of the braille display's width to avoid dead=20
areas when panning to the right.

So if you ask me, I'm not against relaxing the 80 columns limit for=20
code. What really matters to me is that I can stay clear of any GUI.


Nicolas
--8323328-1427214125-1591369259=:1353413--
