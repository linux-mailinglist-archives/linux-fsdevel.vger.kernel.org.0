Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10257613D31
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Oct 2022 19:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiJaSSk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Oct 2022 14:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiJaSSj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Oct 2022 14:18:39 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B6911C1C;
        Mon, 31 Oct 2022 11:18:38 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id z189so11212293vsb.4;
        Mon, 31 Oct 2022 11:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xd9F09Tc5953FDmAhIMnVAVjWEOicg+NegCZR3eZuX8=;
        b=pNQMnSeahCYnxAYJTOQLlmujySqfumMOioMVC0+SSj0ww4sdg/IeacLqXb8cjB+Rev
         ZreM+QYq2XGYfW8YWQUndpdFX7Xghm0+oo1GbSH0kG8KOO6QjlF0PGQMfjcdLmO4xvFg
         nOGH2lY6BOiEcdYwu3om77bFE3OLlTEqIGAceV2PC+q8mPgDQ3Y/IpJojtfUwIVFeoLS
         5eu/pszXI01mMxtIMbrdPcAHW2axw2mMLyyZtxRwGe5JSrtNPmqMBf11R0AfTFBZdZLG
         FCAfjvC07QfRgQI//jU015jZK82yBxsPEETEewKs4p5RhQTNKXiewA7tWghQ+OPr0uT1
         Ct0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xd9F09Tc5953FDmAhIMnVAVjWEOicg+NegCZR3eZuX8=;
        b=Kp1CV/EB4/+uVB/Ys7Jea0LbB/ocEznol03e7w4GZMyFQlUqE7+1ubk9EULJAM65kD
         rYDt43g/jkqBFe+2crxhPc9FNN6G6IcqFrXdhRXMgjsTkXF1sQTaGJQkUszpS01+TIqD
         SbFkZxqwm81dRBn8k5ofpS9EkhYokf3Sci7EBscPTs4TrxYWxhh7lqemOKIO8tPiB5vQ
         Ew2VBbgPDWevVvIRHU++IfNsEvfUftO1LRgxvPefmdh7O2jCycoIRF+73raGbYDCGKg7
         Iu+yPoqjVhayHmY4t+qlpmmdhQL/o6v9au35Oga4Y8z0EOgWsZNZPa7m67NetHdHUS1V
         JfuQ==
X-Gm-Message-State: ACrzQf1BwLGUAYG5vttPCESpSb3YkMVlYNDovVEL/56SJGEmTuhjCvbs
        WXfIswdJxKpEAl+2ONNuYdvG876pPqmM+kCeRjw=
X-Google-Smtp-Source: AMsMyM7k7elkLVc/gxPgAjJvvUxTfqOrw+6n1UX8x/PYNKGnyD5AbZBiEhAFyXEoJKxrip2VSx9MJLEamNR0sdhREL8=
X-Received: by 2002:a67:edc9:0:b0:3a9:ee9c:f9c4 with SMTP id
 e9-20020a67edc9000000b003a9ee9cf9c4mr5288346vsp.71.1667240317390; Mon, 31 Oct
 2022 11:18:37 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000008b529305ec20dacc@google.com> <20221031175050.xmhub66b6d4dvpcb@quack3>
In-Reply-To: <20221031175050.xmhub66b6d4dvpcb@quack3>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 31 Oct 2022 20:18:25 +0200
Message-ID: <CAOQ4uxiOLZ=symqS3VWiz35DrECGrGhBwUnqZV-1Y+wqNA-OOQ@mail.gmail.com>
Subject: Re: [syzbot] kernel BUG in dnotify_free_mark
To:     Jan Kara <jack@suse.cz>
Cc:     syzbot <syzbot+06cc05ddc896f12b7ec5@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, ntfs3@lists.linux.dev,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 31, 2022 at 7:50 PM Jan Kara <jack@suse.cz> wrote:
>
> Hello!
>
> [added some CCs to gather more ideas]
>
> On Fri 28-10-22 16:45:33, syzbot wrote:
> > syzbot found the following issue on:
> >
> > HEAD commit:    247f34f7b803 Linux 6.1-rc2
> > git tree:       upstream
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=157f594a880000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=1d3548a4365ba17d
> > dashboard link: https://syzkaller.appspot.com/bug?extid=06cc05ddc896f12b7ec5
> > compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15585936880000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ec85ba880000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/a5f39164dea4/disk-247f34f7.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/8d1b92f5a01f/vmlinux-247f34f7.xz
> > mounted in repro: https://storage.googleapis.com/syzbot-assets/1a4d2943796c/mount_0.gz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+06cc05ddc896f12b7ec5@syzkaller.appspotmail.com
> >
> > ------------[ cut here ]------------
> > kernel BUG at fs/notify/dnotify/dnotify.c:136!
>
> OK, I've tracked this down to the problem in ntfs3 driver or maybe more
> exactly in bad inode handling. What the reproducer does is that it mounts
> ntfs3 image, places dnotify mark on filesystem's /, then accesses something
> which finds that / is corrupted.  This calls ntfs_bad_inode() which calls
> make_bad_inode() which sets inode->i_mode to S_IFREG. So when the file
> descriptor is closed, dnotify doesn't get properly shutdown because it
> works only on directories. Now calling make_bad_inode() on live inode is
> problematic because it can change inode type (e.g. from directory to
> regular file) and that tends to confuse things - dnotify in this case.
>
> Now it is easy to blame filesystem driver for calling make_bad_inode() on
> live inode but given it seems to be relatively widespread maybe
> make_bad_inode() should be more careful not to screw VFS? What do other
> people think?

Do you know why make_bad_inode() sets inode->i_mode to S_IFREG?
If it did not do that, would it solve the dnotify issue?

Thanks,
Amir.
