Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69BDA1B078E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 13:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgDTLi5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 07:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725886AbgDTLi4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:38:56 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48974C061A0F
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2020 04:38:56 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id c3so7736886otp.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2020 04:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DS+SwsiiAa2IC1Of+N2xMxxQ2Qn8OB6+yF3JDFdmUGw=;
        b=LbETIOvYzs18kn6+m0ic3svL2kvhfMXbxm1qMe2vEGt8OHLOrYNVoOwsPuWgg4CsEE
         A8el+FMXMV/XtEtPGn+tQ1aP0cH4rGdrv630f1UeTl/AkMPBkxD6aPck93ucdsf3wnWi
         9yudlhuklmM+m6OOvDu+phCj/Wf54YUcLAmJzVoCgrmRvxzrI6md1wsdYhfo/wVytYu/
         /l6e+DaDbmIvST2a/+i1wiQtKF3W3h0OTCebZPJMuNVzyqGP+b9kxvau7dxTFV1va5NB
         RxRbYbYxI/Q/Heip8U6dWfx90Q7OyVoJYUg/b6/N33nMFAWgAJgZYYppzcAsVQS9re+/
         lxYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DS+SwsiiAa2IC1Of+N2xMxxQ2Qn8OB6+yF3JDFdmUGw=;
        b=XXAa9h3/7D6cdU3XiEoRx6KRYoM8itKy3O22+LkHjVKOEBuTRVE3npNHm4Li+2/Ltl
         OEnvjF8dQonGrdigMiZfwHIoj8gU4399cCXtw7oujIzW7kJHIGHMs9Es+8YhZiKXHBjo
         IDrr02C44ECbyv3qIVN/4atiK9yijR1JhazbqsvVcGA0XgLN+XU45LiM4ywqQ1Cd3qGI
         t9fMrBjqI+MBGn4jNuMQTlhZ/hzfbSQfo2PaAcTNYPm1UpVQGrAMwzP5lVMUyLeaKtkm
         CHD6AMro1ZyXJW1FnzoqfeXIEumDnWYaRf2jzZROn5m7WdUhCL8f23ZZovxabQc3mWEY
         R1xg==
X-Gm-Message-State: AGi0PuZP6PkOJvVbV0PfOQp7gcpYFTnJk+J2tF69wT9yDUizDBpO/47n
        LkTbmdqvKJOG7g8ZfgdHI7WwMkI1EDDfjzSdvNb0Hg==
X-Google-Smtp-Source: APiQypKCWHdZZ2bi+3PbMfM+AZS/gcAmMukvJoqNM4nAXsIul0EznVN8ABNh29yiOVOiUZ8ejQuoJJgLhE64swOJMYs=
X-Received: by 2002:a05:6830:22dc:: with SMTP id q28mr8717028otc.221.1587382735551;
 Mon, 20 Apr 2020 04:38:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200331133536.3328-1-linus.walleij@linaro.org>
 <CAFEAcA9Gep1HN+7WJHencp9g2uUBLhagxdgjHf-16AOdP5oOjg@mail.gmail.com> <87v9luwgc6.fsf@mid.deneb.enyo.de>
In-Reply-To: <87v9luwgc6.fsf@mid.deneb.enyo.de>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Mon, 20 Apr 2020 12:38:44 +0100
Message-ID: <CAFEAcA-No3Z95+UQJZWTxDesd-z_Y5XnyHs6NMpzDo3RVOHQ4w@mail.gmail.com>
Subject: Re: [PATCH] fcntl: Add 32bit filesystem mode
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        QEMU Developers <qemu-devel@nongnu.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 20 Apr 2020 at 12:23, Florian Weimer <fw@deneb.enyo.de> wrote:
>
> * Peter Maydell:
>
> > We open fd 3 to read '.'; we issue the new fcntl, which
> > succeeds. Then there's some unrelated stuff operating on
> > stdout. Then we do a getdents64(), but the d_off values
> > we get back are still 64 bits. The guest binary doesn't
> > like those, so it fails. My expectation was that we would
> > get back d_off values here that were in the 32 bit range.
>
> What's your file system?
>
> I think not all of them have 32-bit hashes (some of them probably
> can't, particularly in the network-based file system case).

Whoops, good point. I was testing this via lkvm, so it's
actually using a 9p filesystem... I'll see if I can figure
out how to test with an ext3 fs, which I think is the one
we most care about. It would be nice if the flag was
supported by other fses too, of course.

Appended is the QEMU patch I tested with.

thanks
-- PMM

From 73471e01733dd1d998ff3cd41edebb4c78793193 Mon Sep 17 00:00:00 2001
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Apr 2020 11:54:22 +0100
Subject: [RFC] linux-user: Use new F_SET_FILE_32BIT_FS fcntl for 32-bit guests

If the guest is 32 bit then there is a potential problem if the
host gives us back a 64-bit sized value that we can't fit into
the ABI the guest requires. This is a theoretical issue for many
syscalls, but a real issue for directory reads where the host
is using ext3 or ext4. There the 'offset' values retured via
the getdents syscall are hashes, and on a 64-bit system they
will always fill the full 64 bits.

Use the F_SET_FILE_32BIT_FS fcntl to tell the kernel to stick
to 32-bit sized hashes for fds used by the guest.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
RFC patch because it depends on the kernel patch to provide
F_SET_FILE_32BIT_FS, which is still under discussion. All this
patch does is call the fcntl for every fd the guest opens.

 linux-user/syscall.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 674f70e70a5..8966d4881bd 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -884,6 +884,28 @@ static inline int host_to_target_sock_type(int host_type)
     return target_type;
 }

+/*
+ * If the guest is using a 32 bit ABI then we should try to ask the kernel
+ * to provide 32-bit offsets in getdents syscalls, as otherwise some
+ * filesystems will return 64-bit hash values which we can't fit into
+ * the field sizes the guest ABI mandates.
+ */
+#ifndef F_SET_FILE_32BIT_FS
+#define F_SET_FILE_32BIT_FS (1024 + 15)
+#endif
+
+static inline void request_32bit_fs(int fd)
+{
+#if HOST_LONG_BITS > TARGET_ABI_BITS
+    /*
+     * Ignore errors, which are likely due to the host kernel being too
+     * old to support this fcntl. We'll try anyway, which might or might
+     * not work, depending on the guest code and on the host filesystem.
+     */
+    fcntl(fd, F_SET_FILE_32BIT_FS);
+#endif
+}
+
 static abi_ulong target_brk;
 static abi_ulong target_original_brk;
 static abi_ulong brk_page;
@@ -7704,6 +7726,7 @@ static abi_long do_syscall1(void *cpu_env, int
num, abi_long arg1,
                                   target_to_host_bitmask(arg2,
fcntl_flags_tbl),
                                   arg3));
         fd_trans_unregister(ret);
+        request_32bit_fs(ret);
         unlock_user(p, arg1, 0);
         return ret;
 #endif
@@ -7714,6 +7737,7 @@ static abi_long do_syscall1(void *cpu_env, int
num, abi_long arg1,
                                   target_to_host_bitmask(arg3,
fcntl_flags_tbl),
                                   arg4));
         fd_trans_unregister(ret);
+        request_32bit_fs(ret);
         unlock_user(p, arg2, 0);
         return ret;
 #if defined(TARGET_NR_name_to_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
@@ -7725,6 +7749,7 @@ static abi_long do_syscall1(void *cpu_env, int
num, abi_long arg1,
     case TARGET_NR_open_by_handle_at:
         ret = do_open_by_handle_at(arg1, arg2, arg3);
         fd_trans_unregister(ret);
+        request_32bit_fs(ret);
         return ret;
 #endif
     case TARGET_NR_close:
@@ -7769,6 +7794,7 @@ static abi_long do_syscall1(void *cpu_env, int
num, abi_long arg1,
             return -TARGET_EFAULT;
         ret = get_errno(creat(p, arg2));
         fd_trans_unregister(ret);
+        request_32bit_fs(ret);
         unlock_user(p, arg1, 0);
         return ret;
 #endif
@@ -12393,6 +12419,7 @@ static abi_long do_syscall1(void *cpu_env, int
num, abi_long arg1,
         }
         ret = get_errno(memfd_create(p, arg2));
         fd_trans_unregister(ret);
+        request_32bit_fs(ret);
         unlock_user(p, arg1, 0);
         return ret;
 #endif
-- 
2.20.1
