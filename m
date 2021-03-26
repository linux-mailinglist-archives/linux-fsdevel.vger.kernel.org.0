Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 817DB34AB26
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Mar 2021 16:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhCZPNG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Mar 2021 11:13:06 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:52275 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbhCZPMs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Mar 2021 11:12:48 -0400
Received: from mail-oo1-f51.google.com ([209.85.161.51]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M5PyX-1lOR5s46jd-001NmF; Fri, 26 Mar 2021 16:12:46 +0100
Received: by mail-oo1-f51.google.com with SMTP id r17-20020a4acb110000b02901b657f28cdcso1368258ooq.6;
        Fri, 26 Mar 2021 08:12:44 -0700 (PDT)
X-Gm-Message-State: AOAM532SvFfxIrCEisxWXX+Ozd33FCU4BCIpQs7SePVuPvXBg+gayZpv
        cjlayYDFxo0bzFA9lhfMH6wOYCi5wa87tUVNLoI=
X-Google-Smtp-Source: ABdhPJyncRM6kyqeo61SxrePQvXeSUHXpMpeR3setGvzuR1f3RkPXPWDzfhUQ5b18mmh4AOwFayrXC4U1BBAx3fFL7s=
X-Received: by 2002:a4a:304a:: with SMTP id z10mr11801529ooz.26.1616771563972;
 Fri, 26 Mar 2021 08:12:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210326143831.1550030-1-hch@lst.de> <20210326143831.1550030-5-hch@lst.de>
In-Reply-To: <20210326143831.1550030-5-hch@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 26 Mar 2021 16:12:28 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3jQHHwxFw4DV5+c0Nu61TsxqL9vRoAga+yjz_U-iXxvw@mail.gmail.com>
Message-ID: <CAK8P3a3jQHHwxFw4DV5+c0Nu61TsxqL9vRoAga+yjz_U-iXxvw@mail.gmail.com>
Subject: Re: [PATCH 4/4] exec: move the call to getname_flags into do_execveat
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Brian Gerst <brgerst@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:JFSoIXNDgPVqai0uJIGyEtX++CbK81zP0tl3O99Irgxjs3BNGsH
 qdBXNeBV4k3pVqi9Yl0VtJDsM27pLyJEI3I66GZBKVvIlE6hC9UMZ6LA+xlszD2HJCxqDIG
 WU/bTpwDvYQofMkiH2GZxW64d3rUvEoSBCHGQObRh56+EXsstH5+MqNX83lOQ9gDU0P2DEI
 uXGa/ihCuXCrWwCuFSvfA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wxB7Pwj9fHM=:E0KvirLEND3WNArHZXgAZ0
 bfByIk2nPSQfg8w6G5scsAtcO+sgLA5uea/1WOn9zWhSP+xqHcA49c/7pNDoLjJKZIpNeZYaN
 15clOZgYBrHuIEYno96boaL4z21SQcjdiw6FDNdwNN+1+Hn+L3KFV78TjvejimoAkXumrYMc9
 +GbxMVICIe6vpd0Dk87fkN3v+8Mykh7LlPZoeDJCNJPoPaZlipHtxqaHeLpGgD3GImm26e6pX
 XyiUpkz+TwkwVJx5pZjTMsQdznn/sX0qLbZZqMIyXkfW2vztXtEGTyPdeWg6Lp/lH0OqjBuJk
 k2g4o808bK7Y1IHK70WpsN/csJDjwAXMdhrweY8rmMRTvtJ+O8rJRVz892QdtKEMAiqw2I98b
 0ielCd+iEbw7qhiXhyoPSkwPqPzyODDMWQj7uXdlcBTY73XVuqT0K89T4jn8mJi/oz9xSO7ah
 7hNRweBWwQ2l+9Ocii5qANY7gvXOEKCPUspupsHGueggra6ry3e1JoxGacaX0zE2hYNIfrGWK
 s+Ja0Tl5IZOdSNyAuk36W5SOtuJdfAJ0Rjumn0xI1BJgQ2nPe03wLhhN/kzq5014+OgTI+bqt
 KaXqW51b7pyHGaqVMxvJcFjKTU5aYWLrWh
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 26, 2021 at 3:38 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Remove the duplicated copying of the pathname into the common helper.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks correct, but

> -static int do_execveat(int fd, struct filename *filename,
> +static int do_execveat(int fd, const char __user *pathname,
>                 const char __user *const __user *argv,
>                 const char __user *const __user *envp, int flags)

Maybe rename this to ksys_execveat() for consistency now? I think that
is the current trend for functions that are essentially just the syscall.

With or without that change

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
