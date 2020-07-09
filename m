Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5237D21ABAC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jul 2020 01:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgGIXc0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jul 2020 19:32:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46673 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgGIXcZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jul 2020 19:32:25 -0400
Received: from [IPv6:2601:646:8600:3281:15d7:78bf:601:72ae] ([IPv6:2601:646:8600:3281:15d7:78bf:601:72ae])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 069NWG9N3221493
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Thu, 9 Jul 2020 16:32:16 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 069NWG9N3221493
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2020062301; t=1594337537;
        bh=oXsYICFMXhGENZtZmdlMkqG6Rn4Z2UvAaWI5+fym16E=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=CBFBcQTX5k1YefW41Mb36KEg44CtFwDnMESw0KBv9wZQXmlAUidQXe7yk3SM9sk7v
         IXa9ysD9QxYCRgVkGoqjpVTyVuTmpMCroUMScfvyTS18F6tEt8VO+hFpCchZoiAi5d
         pEr6t3Kw9LRe+syoFEOiYNKC1zpIIuYZH2Oc0rUyAtEQqBz90GyK8BskPSoFsoN+HX
         4NZ6dPIDCY+hzWkQz4mm3VxU5W+h3zyk5HjbJg1j7AY3xNWiBCenb56IHH/fY0SSf5
         lfX2z2+qj9gd++0z32ehwfRX2ajclngioN8FPp2N5rvn/rwu9kzvDHitDdjlPCdIOL
         xhnVwn8RNifIw==
Date:   Thu, 09 Jul 2020 16:32:07 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20200709151814.110422-1-hch@lst.de>
References: <20200709151814.110422-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: decruft the early init / initrd / initramfs code v2
To:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
CC:     Song Liu <song@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
From:   hpa@zytor.com
Message-ID: <31944685-7627-43BA-B9A2-A4743AFF0AB7@zytor.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On July 9, 2020 8:17:57 AM PDT, Christoph Hellwig <hch@lst=2Ede> wrote:
>Hi all,
>
>this series starts to move the early init code away from requiring
>KERNEL_DS to be implicitly set during early startup=2E  It does so by
>first removing legacy unused cruft, and the switches away the code
>from struct file based APIs to our more usual in-kernel APIs=2E
>
>There is no really good tree for this, so if there are no objections
>I'd like to set up a new one for linux-next=2E
>
>
>Git tree:
>
>    git://git=2Einfradead=2Eorg/users/hch/misc=2Egit init-user-pointers
>
>Gitweb:
>
>http://git=2Einfradead=2Eorg/users/hch/misc=2Egit/shortlog/refs/heads/ini=
t-user-pointers
>
>
>Changes since v1:
> - add a patch to deprecated "classic" initrd support
>
>Diffstat:
> b/arch/arm/kernel/atags_parse=2Ec |    2=20
> b/arch/sh/kernel/setup=2Ec        |    2=20
> b/arch/sparc/kernel/setup_32=2Ec  |    2=20
> b/arch/sparc/kernel/setup_64=2Ec  |    2=20
> b/arch/x86/kernel/setup=2Ec       |    2=20
> b/drivers/md/Makefile           |    3=20
>b/drivers/md/md-autodetect=2Ec    |  239
>++++++++++++++++++----------------------
> b/drivers/md/md=2Ec               |   34 +----
> b/drivers/md/md=2Eh               |   10 +
> b/fs/file=2Ec                     |    7 -
> b/fs/open=2Ec                     |   18 +--
> b/fs/read_write=2Ec               |    2=20
> b/fs/readdir=2Ec                  |   11 -
> b/include/linux/initrd=2Eh        |    6 -
> b/include/linux/raid/detect=2Eh   |    8 +
> b/include/linux/syscalls=2Eh      |   16 --
> b/init/Makefile                 |    1=20
> b/init/do_mounts=2Ec              |   70 +----------
> b/init/do_mounts=2Eh              |   21 ---
> b/init/do_mounts_initrd=2Ec       |   13 --
> b/init/do_mounts_rd=2Ec           |  102 +++++++----------
> b/init/initramfs=2Ec              |  103 +++++------------
> b/init/main=2Ec                   |   16 +-
> include/linux/raid/md_u=2Eh       |   13 --
> 24 files changed, 251 insertions(+), 452 deletions(-)

I guess I could say something here=2E=2E=2E ;)
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
