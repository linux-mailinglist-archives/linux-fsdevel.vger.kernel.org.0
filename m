Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8DB325DEE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Feb 2021 08:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhBZHEL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Feb 2021 02:04:11 -0500
Received: from mout.gmx.net ([212.227.17.21]:44109 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229586AbhBZHEC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Feb 2021 02:04:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614322950;
        bh=mq4f2WMmO9nRks/+TzMI0/5rSX6H2Hodz5h3z3gFsRE=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=QMKGImFKUwSGlpRPXdUgOIqz8KmEmOzZc5wv/JojvSGF08yYyNj5CaFhT2FfHQwcH
         xPL4VS06EDtlEOcDCyNqi5USmsx5oiE6g0GxsLBEubLGDapYh3Sn+j1xgtOPGdeuhl
         MWSDMBdCSe1XK23D5y/66OSsxw/c3Fk1rcLPpoSI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M4axq-1lHBIp1jcc-001hBf; Fri, 26
 Feb 2021 08:02:30 +0100
To:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Bio read race with different ranges inside the same page?
Message-ID: <d38d7a97-b413-a5cd-1c86-193453c4b51e@gmx.com>
Date:   Fri, 26 Feb 2021 15:02:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xw3YALjJ0+SsejEjxI1TzuLmgPI42Lj1VSQoEG3Ay0bVPxWdUMv
 fXB73spmb0xwJylN+AnE79CptDQImFQCq9O6ddMD4OtNWTqCDLPUo+GEilTgcfTq8AKk9u0
 whjhY3hW/c5NlfLsZfh/O2yQxKVUeggbbCrx2/c2uFVspy+37bQ2RX28Xp4ESExMqE9M3ux
 MfxZp8lHP9SqVqGbLpzmA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZmTRRvQyIRI=:zdYuihDC2owAqa5NvBi5JN
 3tUyw4GvqLke/nwGbz9iaw6E2SCyomRRx5mbvLQhjMRPd8etBQyX1I9kZuXFAC0hv6oMcgI9D
 tSbsXng1XkFJwBYlmFCSS3eFps9HxzicIcFUS53GyV0ZrWc6UlLJyhaJAm3UGyJFxBETqggMx
 c7C+ITnsCVXn+qpd1RNlSH97ZM6DLeghtTVZDtDCNfMsiW1t45Q7pYXqs/fx1GdSbiPCyjeAC
 Y3W4P8LCwxB0CQbMVjsoCOtjY/H8b2u7AliULNaUovThFR8yz/hpU4fSw2MwAFB/vkIyFhRLN
 grbJ32Da/uf5EYrtaOwY042B5YtNYw0XtLYHu9/qAu3MJ2xKDNKDQIC/Xxub5uX1xJczC/FA3
 HGbIkLy2aTrmfU0Cpd2/Y8AejYu1DpIyLdgGRCUkadLFtU7rvHmzOabmFxXnSY9FgfxTLflnA
 4c8ELSsy/oSL1i4KS++HgkY1Xa/s0NJ5gUtzsyFNzNq6csgoiNO9/i1WQjOaIBObsSREuwbRT
 uMF57mLTTQmgiHG6gF6Pz/eemI3cMe8aFb07wc9Fh8Cs07y8ZvhRSEHaQY+3SP2lMt+2Xb1IV
 RaQpHM5QS2G7MpgrTp/MmaZ9gdRbDIflgVHWRlzfsnKUTUJhwEp3IuiSk0RUHX2z45mbNOiBW
 dwaZvPvR43PTRyH+MB3fW9L69wajjmMcQrgwIItpt/JSGYN4Fh0M4iWAfY8Jk1/vsk0N9zPS4
 1GOYNX+qPpbe3haGU8B0Y0CEjEJR46d9SWEbnhM/YOD2Q2UJDDxdNmB6gwFfY6KtTfWkx2O+4
 0zjyqXDX/VqMW9lw6nVwP6lKq5LYD0rrelA7EFHWRG3vrSg6yxpBt20BUp8EVRhkBbJCmdgiX
 8hOP1n6twT+DcqGCun7g==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Is it possible that multiple ranges of the same page are submitted to
one or more bios, and such ranges race with each other and cause data
corruption.

Recently I'm trying to add subpage read/write support for btrfs, and
notice one strange false data corruption.

E.g, there is a 64K page to be read from disk:

0	16K	32K	48K	64K
|///////|       |///////|       |

Where |///| means data which needs to be read from disk.
And |   | means hole, we just zeroing the range.

Currently the code will:

- Submit bio for [0, 16K)
- Zero [16K, 32K)
- Submit bio for [32K, 48K)
- Zero [48K, 64k)

Between bio submission and zero, there is no need to wait for submitted
bio to finish, as I assume the submitted bio won't touch any range of
the page, except the one specified.

But randomly (not reliable), btrfs csum verification at the endio time
reports errors for the data read from disk mismatch from csum.

However the following things show it's read path has something wrong:
- On-disk data matches with csum

- If fully serialized the read path, the error just disappera
   If I changed the read path to be fully serialized, e.g:
   - Submit bio for [0, 16K)
   - Wait bio for [0, 16K) to finish
   - Zero [16K, 32K)
   - Submit bio for [32K, 48K)
   - Wait bio for [32K, 48K) to finish
   - Zero [48K, 64k)
   Then the problem just completely disappears.

So this looks like that, the read path hole zeroing and bio submission
is racing with each other?

Shouldn't bios only touch the range specified and not touching anything
else?

Or is there something I missed like off-by-one bug?

Thanks,
Qu
