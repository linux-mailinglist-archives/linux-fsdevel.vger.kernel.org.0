Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5B7214875
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jul 2020 21:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgGDTl0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Jul 2020 15:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbgGDTlW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Jul 2020 15:41:22 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1885C08C5DE
        for <linux-fsdevel@vger.kernel.org>; Sat,  4 Jul 2020 12:41:21 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id rk21so37921192ejb.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 Jul 2020 12:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oYoqd/CUPo684lZ33nBT5H+rI2BWES+cDScLFKGmu2Y=;
        b=ANB3jbE5Aespe1bV8GUSrufR+UgUOcLLAce0mIM6RWiw6ddEBfK4M4umN+gDfubuLQ
         Nkv6ZOnUULIggH34MXijLri4E67UdDtVYgNoi6Xp6EHGQgwkj0MrpFEGNmKuMCE7oaXy
         sVM/9FM1+ZIbdrCOCvBtEzrAS0Mh9st+EXtgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oYoqd/CUPo684lZ33nBT5H+rI2BWES+cDScLFKGmu2Y=;
        b=pAJrbydy2Mx+vZpK0O5SYbemxiJfVqlWW6gQAYSKl8UjhySL5yRMU+LiZ+407jYuGd
         deV+NXKO1n4N7Z9lrkUJgAaL/WFZM1GxBPNk0zfA7FYdNcZf7g+ZhGtXVFenN7W7oPZR
         oy6BgZQZZAPu9vDoKaW7qMvj5eY0I9X4fpLu5P22ZwaRolTsybHgxEK1rd7FoLY39ZWj
         Kop4gwZ4jiaC8djPNJMKEKIIhTt3tKJ7A9X8CW4hDfoeeggUfnQ4huQgoYcsh/lDZ8T0
         qkx6BIfohU6NlEZcj0JYLX2LmfTJT7RQN+YEF5ZBoTAXHiojy2TOdskcI0yU+Pc4GnBd
         1CMw==
X-Gm-Message-State: AOAM533uLPFq1g+JHlytZgweYdJbOqLdz2B/eW4Wq9plbqIvG2Uvagu3
        UPlltqWz1vnC/svD2oumMIVGPafAmdK9MYzPSZ3M4w==
X-Google-Smtp-Source: ABdhPJyBxGUwYEhvhTUGxE8h2XDZCFFswvZ1ByHXCuGt9UuHeYQFizfvUsknnM+fvByRLxVRrSZ1+AkntCkhvZDN10Q=
X-Received: by 2002:a17:906:1c05:: with SMTP id k5mr36355926ejg.320.1593891680498;
 Sat, 04 Jul 2020 12:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200704140250.423345-1-gregkh@linuxfoundation.org> <20200704140250.423345-2-gregkh@linuxfoundation.org>
In-Reply-To: <20200704140250.423345-2-gregkh@linuxfoundation.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Sat, 4 Jul 2020 21:41:09 +0200
Message-ID: <CAJfpegusi8BjWFzEi05926d4RsEQvPnRW-w7My=ibBHQ8NgCuw@mail.gmail.com>
Subject: Re: [PATCH 1/3] readfile: implement readfile syscall
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Kerrisk <mtk.manpages@gmail.com>, shuah@kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-man <linux-man@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 4, 2020 at 4:03 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> It's a tiny syscall, meant to allow a user to do a single "open this
> file, read into this buffer, and close the file" all in a single shot.
>
> Should be good for reading "tiny" files like sysfs, procfs, and other
> "small" files.
>
> There is no restarting the syscall, this is a "simple" syscall, with the
> attempt to make reading "simple" files easier with less syscall
> overhead.
>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  fs/open.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>
> diff --git a/fs/open.c b/fs/open.c
> index 6cd48a61cda3..4469faa9379c 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -1370,3 +1370,53 @@ int stream_open(struct inode *inode, struct file *filp)
>  }
>
>  EXPORT_SYMBOL(stream_open);
> +
> +static struct file *readfile_open(int dfd, const char __user *filename,
> +                                 struct open_flags *op)
> +{
> +       struct filename *tmp;
> +       struct file *f;
> +
> +       tmp = getname(filename);
> +       if (IS_ERR(tmp))
> +               return (struct file *)tmp;
> +
> +       f = do_filp_open(dfd, tmp, op);
> +       if (!IS_ERR(f))
> +               fsnotify_open(f);
> +
> +       putname(tmp);
> +       return f;
> +}
> +
> +SYSCALL_DEFINE5(readfile, int, dfd, const char __user *, filename,
> +               char __user *, buffer, size_t, bufsize, int, flags)
> +{
> +       struct open_flags op;
> +       struct open_how how;
> +       struct file *file;
> +       loff_t pos = 0;
> +       int retval;
> +
> +       /* only accept a small subset of O_ flags that make sense */
> +       if ((flags & (O_NOFOLLOW | O_NOATIME)) != flags)
> +               return -EINVAL;
> +
> +       /* add some needed flags to be able to open the file properly */
> +       flags |= O_RDONLY | O_LARGEFILE;
> +
> +       how = build_open_how(flags, 0000);
> +       retval = build_open_flags(&how, &op);
> +       if (retval)
> +               return retval;
> +
> +       file = readfile_open(dfd, filename, &op);
> +       if (IS_ERR(file))
> +               return PTR_ERR(file);
> +
> +       retval = vfs_read(file, buffer, bufsize, &pos);
> +
> +       filp_close(file, NULL);
> +
> +       return retval;

Manpage says: "doing the sequence of open() and then read() and then
close()", which is exactly what it does.

But then it goes on to say: "If the file is larger than the value
provided in count then only count number of bytes will be copied into
buf", which is only half true, it should be: "If the file is larger
than the value provided in count then at most count number of bytes
will be copied into buf", which is not a lot of information.

And "If the size of file is smaller than the value provided in count
then the whole file will be copied into buf", which is simply a lie;
for example seq_file will happily return a smaller-than-PAGE_SIZE
chunk if at least one record fits in there.  You'll have a very hard
time explaining that in the man page.  So I think there are two
possible ways forward:

 1) just leave the first explanation (it's an open + read + close
equivalent) and leave out the rest

 2) add a loop around the vfs_read() in the code.

I'd strongly prefer #2 because with the non-looping read it's
impossible to detect whether the file was completely read or not, and
that's just going to lead to surprises and bugs in userspace code.

Thanks,
Miklos
