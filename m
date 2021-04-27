Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2EE636CD3A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 22:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239353AbhD0UyV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 16:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239274AbhD0UyQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 16:54:16 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94878C061574;
        Tue, 27 Apr 2021 13:53:32 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 517BF728D; Tue, 27 Apr 2021 16:53:31 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 517BF728D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1619556811;
        bh=5ZQPQuFxsL8p1/4VGoLL6WsBT7fTywQ1GIUgUVF5lec=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=z3cr0vjp/pv7UrKkb/9QmeUT/9blZGZODaNPAChaxG+CDObuj+ishlur6hK/qxwbC
         SqS0MqNzAWgcan9EQmGtzfjtU9ejxGVL+7cHdv5KrqPR/luCQ9NSDqmBGCo7HgCEBp
         DqCWgdpAe4DrYSJERm9sp/UbCbumPSOtVuxmHwRU=
Date:   Tue, 27 Apr 2021 16:53:31 -0400
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        smfrench@gmail.com, senozhatsky@chromium.org, hyc.lee@gmail.com,
        viro@zeniv.linux.org.uk, hch@lst.de, hch@infradead.org,
        ronniesahlberg@gmail.com, aurelien.aptel@gmail.com,
        aaptel@suse.com, sandeen@sandeen.net, dan.carpenter@oracle.com,
        colin.king@canonical.com, rdunlap@infradead.org,
        willy@infradead.org
Subject: Re: [PATCH v2 00/10] cifsd: introduce new SMB3 kernel server
Message-ID: <20210427205331.GA15168@fieldses.org>
References: <CGME20210422003835epcas1p246c40c6a6bbc0e9f5d4ccf9b69bef0d7@epcas1p2.samsung.com>
 <20210422002824.12677-1-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422002824.12677-1-namjae.jeon@samsung.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 22, 2021 at 09:28:14AM +0900, Namjae Jeon wrote:
> This is the patch series for cifsd(ksmbd) kernel server.
> 
> What is cifsd(ksmbd) ?
> ======================
> 
> The SMB family of protocols is the most widely deployed
> network filesystem protocol, the default on Windows and Macs (and even
> on many phones and tablets), with clients and servers on all major
> operating systems, but lacked a kernel server for Linux. For many
> cases the current userspace server choices were suboptimal
> either due to memory footprint, performance or difficulty integrating
> well with advanced Linux features.
> 
> ksmbd is a new kernel module which implements the server-side of the SMB3 protocol.
> The target is to provide optimized performance, GPLv2 SMB server, better
> lease handling (distributed caching). The bigger goal is to add new
> features more rapidly (e.g. RDMA aka "smbdirect", and recent encryption
> and signing improvements to the protocol) which are easier to develop
> on a smaller, more tightly optimized kernel server than for example
> in Samba.  The Samba project is much broader in scope (tools, security services,
> LDAP, Active Directory Domain Controller, and a cross platform file server
> for a wider variety of purposes) but the user space file server portion
> of Samba has proved hard to optimize for some Linux workloads, including
> for smaller devices. This is not meant to replace Samba, but rather be
> an extension to allow better optimizing for Linux, and will continue to
> integrate well with Samba user space tools and libraries where appropriate.
> Working with the Samba team we have already made sure that the configuration
> files and xattrs are in a compatible format between the kernel and
> user space server.
> 
> 
> Architecture
> ============
> 
>                |--- ...
>        --------|--- ksmbd/3 - Client 3
>        |-------|--- ksmbd/2 - Client 2
>        |       |         ____________________________________________________
>        |       |        |- Client 1                                          |
> <--- Socket ---|--- ksmbd/1   <<= Authentication : NTLM/NTLM2, Kerberos      |
>        |       |      | |     <<= SMB engine : SMB2, SMB2.1, SMB3, SMB3.0.2, |
>        |       |      | |                SMB3.1.1                            |
>        |       |      | |____________________________________________________|
>        |       |      |
>        |       |      |--- VFS --- Local Filesystem
>        |       |
> KERNEL |--- ksmbd/0(forker kthread)
> ---------------||---------------------------------------------------------------
> USER           ||
>                || communication using NETLINK
>                ||  ______________________________________________
>                || |                                              |
>         ksmbd.mountd <<= DCE/RPC(srvsvc, wkssvc, samr, lsarpc)   |
>                ^  |  <<= configure shares setting, user accounts |
>                |  |______________________________________________|
>                |
>                |------ smb.conf(config file)
>                |
>                |------ ksmbdpwd.db(user account/password file)
>                             ^
>   ksmbd.adduser ---------------|
> 
> The subset of performance related operations(open/read/write/close etc.) belong
> in kernelspace(ksmbd) and the other subset which belong to operations(DCE/RPC,
> user account/share database) which are not really related with performance are
> handled in userspace(ksmbd.mountd).
> 
> When the ksmbd.mountd is started, It starts up a forker thread at initialization
> time and opens a dedicated port 445 for listening to SMB requests. Whenever new
> clients make request, Forker thread will accept the client connection and fork
> a new thread for dedicated communication channel between the client and
> the server.

Judging from the diagram above, all those threads are kernel threads, is
that right?  So a kernel thread gets each call first, then uses netlink
to get help from ksmbd.mountd if necessary, is that right?

--b.
