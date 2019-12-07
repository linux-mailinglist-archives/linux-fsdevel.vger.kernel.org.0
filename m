Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7583A115DFB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Dec 2019 19:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfLGSaE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Dec 2019 13:30:04 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38347 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbfLGSaD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Dec 2019 13:30:03 -0500
Received: by mail-lj1-f193.google.com with SMTP id k8so11133345ljh.5;
        Sat, 07 Dec 2019 10:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=P7fIBBJlmA/AwChRfE7OrSku3z8NNsbPGKswxqW3gW0=;
        b=L5Xe5p5q2h17yXfTZD0ky9rrDssmCJh4tnXwqLdqoZx49PeGZjHJ5QFcPIkWANC7ci
         pETzza3hVBu2E+tf3IRrKC3ZhYTSHQLBF35jJxmYUvxdQyQOZk26CsBdjRFOVpbD5I/v
         47v1LN7QJE9cGm/81ZKpAqph0gNbAZBxTIMTU7/xx8XGwObKfWsSAU9q0UAHP757a50n
         AFTMc2nUDerytNn2veDpaA7RlTEk/mesWfnA0fwT2wWgslAGFFg5qZEfZ75z6fzByLpf
         PNQnrnOqQ5qg06e79udv9/rbTnC3+zWtT2fb+eYZv+vk2PTzmslbkUU4+pSYyvOcRq7g
         hFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=P7fIBBJlmA/AwChRfE7OrSku3z8NNsbPGKswxqW3gW0=;
        b=Gyc9BZl3RrPWb6JSpoMBneWPDRxKO4unYVspSdrT7o8n4PGgSZjIDKxZPj3xazsOe0
         qXNQJ9RsIVescDUK1+JcAsbdwCtEBbVjgyV3neOlUuAvvT4kSZQChkbrNijKdkLBnRG5
         tZ72Wq78sBRmChnnXznIqtng55Ug7zwiK81acPpeacwRHlaY51FrW812f2IwXW8nDcqU
         N1I/vEMgTqZSQJ9cIgPfDLouvvV30ebrFZ4dL7pAsakzoHv6NbG4XNTVKs1Te9atpXd8
         JpfWh4esZ6wKkgPpjTmJ5dnKXSHGEHKuuR6HlwfUIx/Stg1Ayi258ddDPIgV8pP47Lib
         hvTg==
X-Gm-Message-State: APjAAAWgPPDi50G+YUm+OuOz1vOJRUwFvOnkjv/ISJWwI6FW1RxJq0AW
        aKDdRfzCD2t+xt//+6ukK/Sv7m8Zz68W0jGUr2U=
X-Google-Smtp-Source: APXvYqzC8K56M+GHqLyG+tyDOMaaaZ3Fcfd7AdOQqbFMA3np2o48RwXIDJZkUs73UZq9UPdhGXMoHRIIV09pvykFI0I=
X-Received: by 2002:a2e:9041:: with SMTP id n1mr12331450ljg.133.1575743400834;
 Sat, 07 Dec 2019 10:30:00 -0800 (PST)
MIME-Version: 1.0
References: <157566809107.17007.16619855857308884231.stgit@warthog.procyon.org.uk>
In-Reply-To: <157566809107.17007.16619855857308884231.stgit@warthog.procyon.org.uk>
Reply-To: mceier@gmail.com
From:   Mariusz Ceier <mceier@gmail.com>
Date:   Sat, 7 Dec 2019 18:29:49 +0000
Message-ID: <CAJTyqKNuv+5x7zUTT_O56h7cGOVSEergF+QDXGHCpxXygVG_CA@mail.gmail.com>
Subject: Re: [PATCH] pipe: Fix iteration end check in fuse_dev_splice_write()
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, miklos@szeredi.hu,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I believe it's still not complete fix for 8cefc107ca54. Loading videos
(or streams) on youtube, twitch in firefox (71 or nightly) on kernel
eea2d5da29e396b6cc1fb35e36bcbf5f57731015 still results in page
rendering getting stuck (switching between tabs shows spinner instead
of page content).

Today I spent whole day bisecting that issue, here's the log:

# bad: [3f1266ec704d3efcfc8179c71bed9a75963b6344] Merge tag
'gfs2-for-5.5' of
git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2
# good: [219d54332a09e8d8741c1e1982f5eae56099de85] Linux 5.4
git bisect start '3f1266ec704d' 'v5.4'
# good: [0dd09bc02c1bad55e92306ca83b38b3cf48b9f40] Merge tag
'staging-5.5-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
git bisect good 0dd09bc02c1bad55e92306ca83b38b3cf48b9f40
# bad: [d004701d1cc5a036b1f2dec34dd5973064c72eab] Merge branch
'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid
git bisect bad d004701d1cc5a036b1f2dec34dd5973064c72eab
# good: [904ce198dd7bcf6eaa1735e9c0b06959351d4126] Merge tag
'drm/tegra/for-5.5-rc1' of git://anongit.freedesktop.org/tegra/linux
into drm-next
git bisect good 904ce198dd7bcf6eaa1735e9c0b06959351d4126
# good: [8f45533e9db917147066b24903a0d03a5adb50e1] Merge tag
'f2fs-for-5.5' of
git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs
git bisect good 8f45533e9db917147066b24903a0d03a5adb50e1
# bad: [ceb307474506f888e8f16dab183405ff01dffa08] Merge tag
'y2038-cleanups-5.5' of
git://git.kernel.org:/pub/scm/linux/kernel/git/arnd/playground
git bisect bad ceb307474506f888e8f16dab183405ff01dffa08
# good: [2807273f5e88ed086d7d5d838fdee71e11e5085f] powerpc/fixmap: fix
crash with HIGHMEM
git bisect good 2807273f5e88ed086d7d5d838fdee71e11e5085f
# bad: [9dd0013824fc29e618db7a5b0bac5545285b946a] Merge tag
'for-linus' of git://git.armlinux.org.uk/~rmk/linux-arm
git bisect bad 9dd0013824fc29e618db7a5b0bac5545285b946a
# good: [e2d73c302b6b0a8379a679120590073b813d5e7f] Merge tag
'erofs-for-5.5-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs
git bisect good e2d73c302b6b0a8379a679120590073b813d5e7f
# good: [32ef9553635ab1236c33951a8bd9b5af1c3b1646] Merge tag
'fsnotify_for_v5.5-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs
git bisect good 32ef9553635ab1236c33951a8bd9b5af1c3b1646
# good: [790756c7e0229dedc83bf058ac69633045b1000e] ARM: 8933/1:
replace Sun/Solaris style flag on section directive
git bisect good 790756c7e0229dedc83bf058ac69633045b1000e
# bad: [cefa80ced57a29179313da7ab3cbb26afb040b6f] pipe: Increase the
writer-wakeup threshold to reduce context-switch count
git bisect bad cefa80ced57a29179313da7ab3cbb26afb040b6f
# bad: [6718b6f855a0b4962d54bd625be2718cb820cec6] pipe: Allow pipes to
have kernel-reserved slots
git bisect bad 6718b6f855a0b4962d54bd625be2718cb820cec6
# good: [ce4dd4429b3c7e4506870796f3b8b06d707d2928] Remove the
nr_exclusive argument from __wake_up_sync_key()
git bisect good ce4dd4429b3c7e4506870796f3b8b06d707d2928
# bad: [8cefc107ca54c8b06438b7dc9cc08bc0a11d5b98] pipe: Use head and
tail pointers for the ring, not cursor and length
git bisect bad 8cefc107ca54c8b06438b7dc9cc08bc0a11d5b98
# good: [f94df9890e98f2090c6a8d70c795134863b70201] Add
wake_up_interruptible_sync_poll_locked()
git bisect good f94df9890e98f2090c6a8d70c795134863b70201
# first bad commit: [8cefc107ca54c8b06438b7dc9cc08bc0a11d5b98] pipe:
Use head and tail pointers for the ring, not cursor and length


Then I tried master (eea2d5da29e396b6cc1fb35e36bcbf5f57731015) since I
noticed there were some commits allegedly fixing
8cefc107ca54c8b06438b7dc9cc08bc0a11d5b98, but I was still able to
reproduce it.

My test looked like this:
1. Run firefox (nightly but also I verified in 71 not built by me)
2. Open youtube, click on random video
3. Wait about minute and see if firefox is still responsive, if it's
not, git bisect bad and try another kernel version
4. Open 1 or 2 more tabs (youtube, gmail, twitch, reddit etc.) and
wait a bit more - usually it triggered the issue
5. After about 5 minutes of playing youtube and opening/closing tabs I
ran git bisect good

Hope this helps pinpoint the issue.

Best regards,
Mariusz Ceier


On Fri, 6 Dec 2019 at 21:37, David Howells <dhowells@redhat.com> wrote:
>
> Fix the iteration end check in fuse_dev_splice_write().  The iterator
> position can only be compared with == or != since wrappage may be involved.
>
> Fixes: 8cefc107ca54 ("pipe: Use head and tail pointers for the ring, not cursor and length")
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
>
>  fs/fuse/dev.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index d4e6691d2d92..8e02d76fe104 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1965,7 +1965,7 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
>
>         nbuf = 0;
>         rem = 0;
> -       for (idx = tail; idx < head && rem < len; idx++)
> +       for (idx = tail; idx != head && rem < len; idx++)
>                 rem += pipe->bufs[idx & mask].len;
>
>         ret = -EINVAL;
>
