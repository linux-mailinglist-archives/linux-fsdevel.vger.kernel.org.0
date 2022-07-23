Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB15157EF6F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Jul 2022 16:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237470AbiGWORy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Jul 2022 10:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237449AbiGWORx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Jul 2022 10:17:53 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B818D186CB
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Jul 2022 07:17:50 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id a82so6924090ybb.12
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Jul 2022 07:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mEoPEbeOyWxlrBYzTjx3/LLOWXpb1CcPOZICGC0v96M=;
        b=jr/xvpvbVmNf+xIG0dbLCrMyluMNU3l3gZeFwLtkhnYy/4UleXz2aomwnjH+3TbMKl
         11dBUhnttUE/J/yKFXfQN03yrN4WFewxF/+VJ/kcL6pFsFUOYhgePHT7kQM1GWHE4cnj
         J0HF2vx93jhldzsXpN3975BnFyYHwrHhHDTW6S28Y1Bp+thJmDbF88XkOqYjLcRbtVMz
         EymXnwDWc6excfS/Vg36Y6KXmCjFyN9Fy9ta6W1R+MsF1Y9qT+ckV60hFtIARmjwjo36
         hhkKLiL31tekMRZqBQY+Ta4faait4JFH08LLjUBAqpKD/CnXK6iHsPwk/7J98gJf2WT9
         7zEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mEoPEbeOyWxlrBYzTjx3/LLOWXpb1CcPOZICGC0v96M=;
        b=I0g0UEw0NDcNER4DGy9HDnIO+Q15RIOzdVjbGrvzpd2HFSVkPiI6Tyw7hHjQom0fEg
         aXAdnqgHG47ou2+SvhEdjpQq71yzs4sYgAGDLcA9+guTWMa6F8IWnIOBAoNv3fFCw5lg
         aMY3ObpB9IBvh2PqlJTm+EDH0IY0bYeTVOovWIq22icliWkHYsNvR0nz96FqhNstjg2o
         lnmA8eB6o8O+AF/OHKGqBCxtDM/4gAT79+8f8wc99VuY1JpDySHH3gP07YJ4UVvZhj9J
         hxV5HFE8N8rbnz8z890RHRp0XkhWtWcCrfzPC5lvOPoTxQBm9xIuwQCEreZ85xPnm6MB
         L9IA==
X-Gm-Message-State: AJIora8daDDj6Wg1bv1J6xpDBydGktEpp4ukZUFyyweFxui3D6E5LMvo
        PPuc3n55kfXbd2QjCfQNr94QMe2fOrRYEzGUzki2jg==
X-Google-Smtp-Source: AGRyM1vMVZvJKOP7aWWuKyr1n74NN+gmMGpp4/ODkk6r1z+KdpVQo9OtmmE4byGdqk74TpSHifmeukWE0kzdATNgfP0=
X-Received: by 2002:a25:2f4a:0:b0:670:ea89:72b2 with SMTP id
 v71-20020a252f4a000000b00670ea8972b2mr3546504ybv.427.1658585869576; Sat, 23
 Jul 2022 07:17:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220722162934.1888835-1-mcgrof@kernel.org> <20220722162934.1888835-3-mcgrof@kernel.org>
In-Reply-To: <20220722162934.1888835-3-mcgrof@kernel.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 23 Jul 2022 22:17:12 +0800
Message-ID: <CAMZfGtV4wC-8uT47v-nYhEi82cqNVNf1CFMM8qRU7Nd3SMyv5w@mail.gmail.com>
Subject: Re: [PATCH 2/2] Documentation/filesystems/proc.rst: document procfs
 inode timestamps
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Zhang Yuchen <zhangyuchen.lcr@bytedance.com>,
        David Howells <dhowells@redhat.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-api@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 23, 2022 at 12:29 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> The timestamps for procfs files are not well understood and can
> confuse users and developers [0] in particular for the timestamp
> for the start time or a process. Clarify what they mean and that
> they are a reflection of the ephemeral nature of the filesystem
> inodes.
>
> The procfs inodes are created when you first read them and then
> stuffed in the page cache. If the page cache and indodes are
> reclaimed they can be removed, and re-created with a new timestamp
> after read again. Document this little bit of tribal knowledge.
>
> [0] https://lkml.kernel.org/r/20220721081617.36103-1-zhangyuchen.lcr@bytedance.com
> Reported-by: Zhang Yuchen <zhangyuchen.lcr@bytedance.com>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  Documentation/filesystems/proc.rst | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 9fd5249f1a5f..9defe9af683a 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -59,6 +59,15 @@ The proc  file  system acts as an interface to internal data structures in the
>  kernel. It  can  be  used to obtain information about the system and to change
>  certain kernel parameters at runtime (sysctl).
>
> +The proc files are dynamic in nature and allow for developers to make the
> +content to be changed each time a file is read. The proc files and directories
> +inodes are created when someone first reads a respective proc file or directory,
> +as such the timestamps of the proc files reflect this time. As with other
> +filesystems, these proc inodes can be removed through reclaim under memory
> +pressure and so the timestamps of the proc files can change if the proc files
> +are destroyed and re-created (echo 3 > /proc/sys/vm/drop_caches forces and
> +illustrate the reclaim of inodes and page cache).

Thanks for fixing this.

> +
>  First, we'll  take  a  look  at the read-only parts of /proc. In Chapter 2, we
>  show you how you can use /proc/sys to change settings.
>
> @@ -328,6 +337,13 @@ It's slow but very precise.
>                 system call
>    ============= ===============================================================
>
> +Note that the start_time inside the stat file is different than the timestamp
> +of the stat file itself. The timestamp of the stat file simply reflects the
> +first time the stat file was read. The proc inode for this file can be reclaimed
> +under memory pressure and be recreated after this and so the timestamp can
> +change. Userspace should rely on the start_time entry in the the stat file to
> +get a process start time.
> +

I'm not sure the value of those comments since the above description
is already enough to tell people the timestamp of /proc files or directories
can be changed in some cases, which already includes the case of
/proc/PID/stat.

If we really want to take /proc/PID/stat as an example to show the
timestamp is unstable, I think it is better to move those comments to the
above section where you explain why the timestamp can be changed .

Thanks.

>  The /proc/PID/maps file contains the currently mapped memory regions and
>  their access permissions.
>
> --
> 2.35.1
>
