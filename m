Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C078462C59
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 06:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbhK3FzM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 00:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbhK3FzL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 00:55:11 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20353C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Nov 2021 21:51:53 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id w4so19916734ilv.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Nov 2021 21:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OaAD21NyQUzNrnLeRgRpRXQ+MNlJX/axF/9iRa7TKM0=;
        b=iCCpFGIkdwngxczuCYXibUfPQj2ECj6er9BCsFaXkqZfetRkb3cHxTBS20KWzJcqZj
         n6ebVddSnyXmbHPx937KRXFGaBLl//6aPxv6+Y0rFQUVDL6SrX1QSAi7CJg5nrb47QLS
         CC44j5xDPcjBjRNfc+w7SMMxSTGGsZIfLZEYFlAPfE58F1LFh2YtFYEBrnEoZ6UcDrJp
         pX3rV+OehZg3z6xGOw85KmbpVwsyPzfmzCowZD++9GMKU1mwUwyyGDQOHlq33at3WXFB
         lY87K2vrlWouSuCzoODRMXEBOrRMsIhrFOW5ulnOGp0wqwsPHESe2ie27UUD8F8c03IX
         PtkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OaAD21NyQUzNrnLeRgRpRXQ+MNlJX/axF/9iRa7TKM0=;
        b=XzsxigjgWVmSJXYHHnMU7I98ZEmEtJr1378P1SZDGnyYf1uo2W3kra6Y6U81rpizH9
         F8I5aOAF3sccBW4GyKTmC4hI/NpV7sKJaGbcV2M99n/6Zqw7GJNzU+KvwDyfJes5K3rY
         RnUpUEgclhR121wEN/yz9T4lsRg5X0Vyu50aBCYwimzbrRVJtdNeNWabAJqb7TayEuOU
         Uk2WwlEz741RAArP6QGesTTcOpphDVZH9h8ZcvkXcwQEEfG+EMORUIvc+qMQyM43CiS4
         Z+zm2g8Zs62GxYDwiINAgawCKf4eY+pUnx34Gzbb7mYSij6+20nOqha4I5rEfHrmcWOy
         UR5Q==
X-Gm-Message-State: AOAM532DtjlF7kupsvCf7T5S1Vs+9PGqLQHM1HPhP3YFISY/bVyz1q4Z
        QXXkxvBkjWwfLcFL/f55SvajJqt32Bb0PrNjMDaUcIO4lX4=
X-Google-Smtp-Source: ABdhPJzBSHoO4kUqhAhMcn/54n5wn8iLzdASFxM4ySLwKcfDK1XpGk57YwyADykAOO4t/js2QVpZGopaBXxS2FOdXGY=
X-Received: by 2002:a92:c88e:: with SMTP id w14mr50915222ilo.24.1638251512533;
 Mon, 29 Nov 2021 21:51:52 -0800 (PST)
MIME-Version: 1.0
References: <20211123114227.3124056-1-brauner@kernel.org>
In-Reply-To: <20211123114227.3124056-1-brauner@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 30 Nov 2021 07:51:41 +0200
Message-ID: <CAOQ4uxhV=s4+cYiFOurZgwb6Oukmyq0UOW4ir_d-K1V9LKK6Ug@mail.gmail.com>
Subject: Re: [PATCH 00/10] Extend and tweak mapping support
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@digitalocean.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 23, 2021 at 2:16 PM Christian Brauner <brauner@kernel.org> wrote:
>
> From: Christian Brauner <christian.brauner@ubuntu.com>
>
> Hey,
>
> This series extend the mapping infrastructure in order to support mapped
> mounts of mapped filesystems in the future.
>
> Currently we only support mapped mounts of filesystems mounted without an
> idmapping. This was a consicous decision mentioned in multiple places. For
> example, see [1].
>
> In our mapping documentation in [3] we explained in detail that it is
> perfectly fine to extend support for mapped mounts to filesystem's mounted
> with an idmapping should the need arise. The need has been there for some
> time now (cf. [2]).
>
> Before we can port any such filesystem we need to first extend the mapping
> helpers to account for the filesystem's idmapping in the remapping helpers.
> This again, is explained at length in our documentation at [3].
>
> Currently, the low-level mapping helpers implement the remapping algorithms
> described in [3] in a simplified manner. Because we could rely on the fact
> that all filesystems supporting mapped mounts are mounted without an
> idmapping the translation step from or into the filesystem idmapping could
> be skipped.
>
> In order to support mapped mounts of filesystem's mountable with an
> idmapping the translation step we were able to skip before cannot be
> skipped anymore. A filesystem mounted with an idmapping is very likely to
> not use an identity mapping and will instead use a non-identity mapping. So
> the translation step from or into the filesystem's idmapping in the
> remapping algorithm cannot be skipped for such filesystems. More details
> with examples can be found in [3].
>
> This series adds a few new as well as prepares and tweaks some already
> existing low-level mapping helpers to perform the full translation
> algorithm explained in [3]. The low-level helpers can be written in a way
> that they only perform the additional translation step when the filesystem
> is indeed mounted with an idmapping.
>
> Since we don't yet support such a filesystem yet a kernel was compiled
> carrying a trivial patch making ext4 mountable with an idmapping:
>
> # We're located on the host with the initial idmapping.
> ubuntu@f2-vm:~$ cat /proc/self/uid_map
>          0          0 4294967295
>
> # Mount an ext4 filesystem with the initial idmapping.
> ubuntu@f2-vm:~$ sudo mount -t ext4 /dev/loop0 /mnt
>
> # The filesystem contains two files. One owned by id 0 and another one owned by
> # id 1000 in the initial idmapping.
> ubuntu@f2-vm:~$ ls -al /mnt/
> total 8
> drwxrwxrwx  2 root   root   4096 Nov 22 17:04 .
> drwxr-xr-x 24 root   root   4096 Nov 20 11:24 ..
> -rw-r--r--  1 root   root      0 Nov 22 17:04 file_init_mapping_0
> -rw-r--r--  1 ubuntu ubuntu    0 Nov 22 17:04 file_init_mapping_1000
>
> # Umount it again so we we can mount it in another namespace later.
> ubuntu@f2-vm:~$ sudo umount  /mnt
>
> # Use the lxc-usernsexec binary to run a shell in a user and mount namespace
> # with an idmapping of 0:10000:100000000.
> #
> # This idmapping will have the effect that files which are owned by i_{g,u}id
> # 10000 and files that are owned by i_{g,u}id 11000 will be owned by {g,u}id
> # 0 and {g,u}id 1000 with that namespace respectively.
> ubuntu@f2-vm:~$ sudo lxc-usernsexec -m b:0:10000:100000000 -- bash
>
> # Verify that we're really running with the expected idmapping.
> root@f2-vm:/home/ubuntu# cat /proc/self/uid_map
>          0      10000  100000000
>
> # Mount the ext4 filesystem in the user and mountns with the idmapping
> # 0:10000:100000000.
> #
> # Note, that this requires a test kernel that makes ext4 mountable in a
> # non-initial userns. The patch is simply:
> #
> # diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> # index 4e33b5eca694..0221e8211e5b 100644
> # --- a/fs/ext4/super.c
> # +++ b/fs/ext4/super.c
> # @@ -6584,7 +6584,7 @@ static struct file_system_type ext4_fs_type = {
> #         .name           = "ext4",
> #         .mount          = ext4_mount,
> #         .kill_sb        = kill_block_super,
> # -       .fs_flags       = FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
> # +       .fs_flags       = FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_USERNS_MOUNT,
> #  };
> #  MODULE_ALIAS_FS("ext4");
> root@f2-vm:/home/ubuntu# mount -t ext4 /dev/loop0 /mnt
>

Hi Christian,

I have a question not directly related to the patches, but to the test
hack above.
I may be wrong, but it looks like an idmapped sb would be desired for some
use cases(?).

My question is - could we use fsconfig() to allow CAP_SYS_ADMIN to attach
a newly mounted sb (e.g. ext4) to user ns without allowing mount of ext4 from
within userns? Wouldn't that add usability to some users without adding any
new risks over the risks already subjected with idmapped mounts?

Thanks,
Amir.
