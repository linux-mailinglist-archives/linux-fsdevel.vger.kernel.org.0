Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1206C39DC0F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jun 2021 14:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbhFGMSS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Jun 2021 08:18:18 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38529 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbhFGMSR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Jun 2021 08:18:17 -0400
Received: by mail-pl1-f193.google.com with SMTP id 69so8538655plc.5;
        Mon, 07 Jun 2021 05:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vx1pcs2epGTMzOgIWnU9clE0OkImINI4Sa4acZm/FRM=;
        b=h6YRQsnAe0oAwfn7A89HG2MmLGRICufWkFAqMTOqcrE8nPqidCOwgW+lYr0wB5RZKI
         RfJQgVT9SF5gMz2W2r/1pSwznjxoNhKKsCHLwn4smSeW9kAQVfYMNRFppb3ZwpwBlJNe
         9of4SIPM5VXfLQc9N9nzBVRqOzHpjMHX4dmQ4hXY5Fz+09mq5YKJ35LrPoTmaClsiM2G
         YUjAKoO7ip9ziUlolrI5TdlQmjU6qeFDDWwQ1lFw4Yr2agPkJbuIPgW8aN1gYXX+rB7l
         CP6Xi6GcIpN8UdtedhBrsdZto3MFbmWVxG2aJGPdAEA5EsP2vpATVN/D4YIJFxJ8nnRQ
         ahoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vx1pcs2epGTMzOgIWnU9clE0OkImINI4Sa4acZm/FRM=;
        b=TN+VrsmbjLOUwv6nal50yziKNUTz1fmIRRrQJiBY+T/YXSKfD+EO8vL1iFQTqyAlZD
         gFi6UiYFyDgX+SdIQx24yQGsFAiw1A9Sd8hakMQM0eM7CPuxzTz7tQ8FiwcSLB6GmlRH
         boAqhff7h9lNiCbyTdsHTnTcqC2QA+3mxKUqJ/04iV+wXBU6c/lwJO3HqhXbftU1Sq6s
         SO6u7rGMX3w9ARWoWzhtxd7IyPAN5FUf7f0A9urkIbv/b0N5YtSwVN1N+qPvc2u/Whkb
         8Mie2mPHoP9TvZfFztji71/ov3rttK+/K75rrt03QZ3ZzC3utnB26P7gcGNm9ntlvMoA
         /pWg==
X-Gm-Message-State: AOAM532bddi5l4FxBWGoYysyw0XxYFlVj5V6ypO/VO35dO6DtI1DSEke
        asvgvPjG/hmJ5FRdhORFmZ25cFVdLflI9g==
X-Google-Smtp-Source: ABdhPJxCrmLRKP6PM/jdZ3u25tKQgohqnCJVq/Pqxk67lrtBCyTfSEJe3zSf75Vr1OB/fjJIPJCb2A==
X-Received: by 2002:a17:902:728d:b029:113:23:c65f with SMTP id d13-20020a170902728db02901130023c65fmr2998801pll.23.1623068126659;
        Mon, 07 Jun 2021 05:15:26 -0700 (PDT)
Received: from localhost ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id q18sm8461161pfj.5.2021.06.07.05.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 05:15:26 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: dong.menglong@zte.com.cn
Date:   Mon, 7 Jun 2021 05:15:24 -0700
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Menglong Dong <menglong8.dong@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>, johan@kernel.org,
        ojeda@kernel.org, jeyu@kernel.org, masahiroy@kernel.org,
        joe@perches.com, Jan Kara <jack@suse.cz>, hare@suse.de,
        Jens Axboe <axboe@kernel.dk>, tj@kernel.org,
        gregkh@linuxfoundation.org, song@kernel.org,
        NeilBrown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Barret Rhoden <brho@google.com>, f.fainelli@gmail.com,
        palmerdabbelt@google.com, wangkefeng.wang@huawei.com,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, vbabka@suse.cz,
        Alexander Potapenko <glider@google.com>, pmladek@suse.com,
        johannes.berg@intel.com,
        "Eric W. Biederman" <ebiederm@xmission.com>, jojing64@gmail.com,
        terrelln@fb.com, geert@linux-m68k.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>, arnd@arndb.de,
        Chris Down <chris@chrisdown.name>, mingo@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH v6 2/2] init/do_mounts.c: create second mount for
 initramfs
Message-ID: <20210607121524.GB3896@www>
References: <20210605034447.92917-1-dong.menglong@zte.com.cn>
 <20210605034447.92917-3-dong.menglong@zte.com.cn>
 <20210605115019.umjumoasiwrclcks@wittgenstein>
 <CADxym3bs1r_+aPk9Z_5Y7QBBV_RzUbW9PUqSLB7akbss_dJi_g@mail.gmail.com>
 <20210607103147.yhniqeulw4pmvjdr@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607103147.yhniqeulw4pmvjdr@wittgenstein>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 07, 2021 at 12:31:47PM +0200, Christian Brauner wrote:
> On Sat, Jun 05, 2021 at 10:47:07PM +0800, Menglong Dong wrote:
[...]
> > 
> > I think it's necessary, as I explained in the third patch. When the rootfs
> > is a block device, ramfs is used in init_mount_tree() unconditionally,
> > which can be seen from the enable of is_tmpfs.
> > 
> > That makes sense, because rootfs will not become the root if a block
> > device is specified by 'root' in boot cmd, so it makes no sense to use
> > tmpfs, because ramfs is more simple.
> > 
> > Here, I make rootfs as ramfs for the same reason: the first mount is not
> > used as the root, so make it ramfs which is more simple.
> 
> Ok. If you don't mind I'd like to pull and test this before moving
> further. (Btw, I talked about this at Plumbers before btw.)
> What did you use for testing this? Any way you can share it?

Ok, no problem definitely. I tested this function in 3 way mainly:

1. I debug the kernel with qemu and gdb, and trace the the whole
   process, to ensure that there is no abnormal situation.
2. I tested pivot_root() in initramfs and ensured that it can be
   used normally. What's more, I also tested docker and ensured
   container can run normally without 'DOCKER_RAMDISK=yes' set in
   initramfs.
3. I tried to enable and disable CONFIG_INITRAMFS_MOUNT, and
   ensured that the system can boot successfully from initramfs, initrd
   and sda.

What's more, our team is going to test it comprehensively, such as
ltp, etc.

Thanks!
Menglong Dong                                                                                                                                                         


