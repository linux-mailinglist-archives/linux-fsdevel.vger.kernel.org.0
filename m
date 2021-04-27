Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05A436CDEC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 23:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237009AbhD0Vjm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 17:39:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:60066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235440AbhD0Vjl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 17:39:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 63925613F3;
        Tue, 27 Apr 2021 21:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619559537;
        bh=aUfr3GP9dA2zXaLKx1mJB3E43MKs8lwDI9xZH9AGtOk=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=iNyWAwMF+zHV/1KSrTJiOgzRwBnUGQDiJPF5ksQ3GcRJWuQ+5vxOCnbNE8+lrwpgr
         ItSJD84GIfVQ0yej/nzQ1xTS/KbOOrSabkUz7QXsFzirgOd+HiVlHHpZrpnXjMFy0X
         REd1FDKpQRndzfbjo+IS9A3167mrXuhU/UMr9do38CYhCmJ5xuR+ArVWMZBsCOQTIf
         2FGFsxT5Cu3P/fuX0uQzKKWLL9Y6zU5f2eIgR5En2SG/uTz6qEmLKycKm0DN0eNLiI
         5hN2cbEJ/+g+XFNoUAgpMmEOdDQ/TQLv0UrVj3GuBf5hVPCKDkmamR7uriDXrob5yi
         jYlkDTL96DxsQ==
Received: by mail-vs1-f44.google.com with SMTP id 2so30799712vsh.4;
        Tue, 27 Apr 2021 14:38:57 -0700 (PDT)
X-Gm-Message-State: AOAM532Q4RapeJUwdpJtWBAcgjdCKgOxLMn7TGN5Tv1qsny+QVPSDrYi
        z6X5+Yqeqznd40vbOSHlIwWfySo43hh3TaPJyM8=
X-Google-Smtp-Source: ABdhPJzQ4ENtGeleDcYiq/gYfFiW9VJR6G77IVNYipGjsDqoumQwQCAUOmEPPAPGuPklltV2fTybSKawAOl1GYpx86A=
X-Received: by 2002:a05:6102:2050:: with SMTP id q16mr20858559vsr.37.1619559536574;
 Tue, 27 Apr 2021 14:38:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6102:21b7:0:0:0:0 with HTTP; Tue, 27 Apr 2021 14:38:55
 -0700 (PDT)
In-Reply-To: <20210427205331.GA15168@fieldses.org>
References: <CGME20210422003835epcas1p246c40c6a6bbc0e9f5d4ccf9b69bef0d7@epcas1p2.samsung.com>
 <20210422002824.12677-1-namjae.jeon@samsung.com> <20210427205331.GA15168@fieldses.org>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Wed, 28 Apr 2021 06:38:55 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8p9tmEQ8uBz6YTUfBSWsSYWTnJc0iu7e5OGshMKoBbwQ@mail.gmail.com>
Message-ID: <CAKYAXd8p9tmEQ8uBz6YTUfBSWsSYWTnJc0iu7e5OGshMKoBbwQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] cifsd: introduce new SMB3 kernel server
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        smfrench@gmail.com, senozhatsky@chromium.org, hyc.lee@gmail.com,
        viro@zeniv.linux.org.uk, hch@lst.de, hch@infradead.org,
        ronniesahlberg@gmail.com, aurelien.aptel@gmail.com,
        aaptel@suse.com, sandeen@sandeen.net, dan.carpenter@oracle.com,
        colin.king@canonical.com, rdunlap@infradead.org,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2021-04-28 5:53 GMT+09:00, J. Bruce Fields <bfields@fieldses.org>:
> On Thu, Apr 22, 2021 at 09:28:14AM +0900, Namjae Jeon wrote:
>> This is the patch series for cifsd(ksmbd) kernel server.
>>
>> What is cifsd(ksmbd) ?
>> ======================
>>
>> The SMB family of protocols is the most widely deployed
>> network filesystem protocol, the default on Windows and Macs (and even
>> on many phones and tablets), with clients and servers on all major
>> operating systems, but lacked a kernel server for Linux. For many
>> cases the current userspace server choices were suboptimal
>> either due to memory footprint, performance or difficulty integrating
>> well with advanced Linux features.
>>
>> ksmbd is a new kernel module which implements the server-side of the SMB3
>> protocol.
>> The target is to provide optimized performance, GPLv2 SMB server, better
>> lease handling (distributed caching). The bigger goal is to add new
>> features more rapidly (e.g. RDMA aka "smbdirect", and recent encryption
>> and signing improvements to the protocol) which are easier to develop
>> on a smaller, more tightly optimized kernel server than for example
>> in Samba.  The Samba project is much broader in scope (tools, security
>> services,
>> LDAP, Active Directory Domain Controller, and a cross platform file
>> server
>> for a wider variety of purposes) but the user space file server portion
>> of Samba has proved hard to optimize for some Linux workloads, including
>> for smaller devices. This is not meant to replace Samba, but rather be
>> an extension to allow better optimizing for Linux, and will continue to
>> integrate well with Samba user space tools and libraries where
>> appropriate.
>> Working with the Samba team we have already made sure that the
>> configuration
>> files and xattrs are in a compatible format between the kernel and
>> user space server.
>>
>>
>> Architecture
>> ============
>>
>>                |--- ...
>>        --------|--- ksmbd/3 - Client 3
>>        |-------|--- ksmbd/2 - Client 2
>>        |       |
>> ____________________________________________________
>>        |       |        |- Client 1
>>   |
>> <--- Socket ---|--- ksmbd/1   <<= Authentication : NTLM/NTLM2, Kerberos
>>   |
>>        |       |      | |     <<= SMB engine : SMB2, SMB2.1, SMB3,
>> SMB3.0.2, |
>>        |       |      | |                SMB3.1.1
>>   |
>>        |       |      |
>> |____________________________________________________|
>>        |       |      |
>>        |       |      |--- VFS --- Local Filesystem
>>        |       |
>> KERNEL |--- ksmbd/0(forker kthread)
>> ---------------||---------------------------------------------------------------
>> USER           ||
>>                || communication using NETLINK
>>                ||  ______________________________________________
>>                || |                                              |
>>         ksmbd.mountd <<= DCE/RPC(srvsvc, wkssvc, samr, lsarpc)   |
>>                ^  |  <<= configure shares setting, user accounts |
>>                |  |______________________________________________|
>>                |
>>                |------ smb.conf(config file)
>>                |
>>                |------ ksmbdpwd.db(user account/password file)
>>                             ^
>>   ksmbd.adduser ---------------|
>>
>> The subset of performance related operations(open/read/write/close etc.)
>> belong
>> in kernelspace(ksmbd) and the other subset which belong to
>> operations(DCE/RPC,
>> user account/share database) which are not really related with performance
>> are
>> handled in userspace(ksmbd.mountd).
>>
>> When the ksmbd.mountd is started, It starts up a forker thread at
>> initialization
>> time and opens a dedicated port 445 for listening to SMB requests.
>> Whenever new
>> clients make request, Forker thread will accept the client connection and
>> fork
>> a new thread for dedicated communication channel between the client and
>> the server.
>
> Judging from the diagram above, all those threads are kernel threads, is
> that right?  So a kernel thread gets each call first, then uses netlink
> to get help from ksmbd.mountd if necessary, is that right?
Yes, That's right.
>
> --b.
>
