Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34223729D27
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 16:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238562AbjFIOmp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 10:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjFIOmn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:42:43 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FC6E43;
        Fri,  9 Jun 2023 07:42:42 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-43dda815756so537113137.1;
        Fri, 09 Jun 2023 07:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686321761; x=1688913761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yr/FbWL7mCBbZAtZmef4VJGdUX+ZdqG2E9Lw0jND63w=;
        b=gcS1JLx1CRExaShD50abRjzOxoDTX6qngKh5uE/gLF0J6ME4qZP1SIMd4PnLx26jj9
         hkw7U57Jd26qpEKSu3KRdkCGMRpgBPiRv4QLl2ACTy2YGvo6zX9eUKFKQ2GI6oYtLU08
         cVN7VAZAuAGwiaBZyDggctVU3i7Qwk31QR3DX86tnUReIU/vhR1SP0DlVqH4Gk+MK6TH
         bvq5ThcQOzwzIJGf0rMahgIZIwVpIfhnFZ70x6nyVhLtFyhh/4ornwTY80pKVF5S3MKb
         gBBlOPe9FKEQAf5ebRb86C2fsalLh8JXHGfW3591quQ+oZX3qPki0K57xfGvzUJwGnKI
         d0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686321761; x=1688913761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yr/FbWL7mCBbZAtZmef4VJGdUX+ZdqG2E9Lw0jND63w=;
        b=kMa1uuISuGHxrfT0GzcjsLtytF+VnbHqBBXtGMAfENrsROVZ/l+GGYYvqBjDE2uce0
         nI9noqSbap4jcjSHk+OyTVVmlD/56To3C8QX9fNy/BXOeuEhDChEGSG+2r+gqvqC2fwN
         XW6yvhfmgrFGN21Z2yT4Fd3Wo1aOnxHV7K2YXUqENbTHyVhllJY3OHJyuAd2hqyfypUF
         Fna8zkbZ/gxB59wMrxDcFKi9Qk4NCvJFcz1R6s9Rgi3mVc5o7RayGfh26yg6VPuhXvQZ
         8ZRf/+85j7rRzH72XqBPjbtCQZ0mZ1lyLQgqbmt5a2M3QHUAsSBw8Ggk9DvjX66QphRi
         sIpw==
X-Gm-Message-State: AC+VfDyzm3gRodQ2tCPcdFWZ1GGfwhIHbu3UcIj/WWS4iBA49OtUC91r
        jFV28Rrw3tc1lUgreENyUD59izMWCni0FFb5IjE=
X-Google-Smtp-Source: ACHHUZ4EA6G1uAX6gGZd8QRd98R/4ioy13Fhnmeeai7tUOSSCwhD6ijPCNoqhvwJYalUWgoyTKb8sQZDjWYbZPnHc5o=
X-Received: by 2002:a05:6102:34d1:b0:43c:b0d:fff5 with SMTP id
 a17-20020a05610234d100b0043c0b0dfff5mr1211868vst.7.1686321761336; Fri, 09 Jun
 2023 07:42:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230609073239.957184-1-amir73il@gmail.com> <CAJfpegvDoSWPRaoa_i_Do3JDdaXrhohDtfQNObSJ7tNhhuHAKw@mail.gmail.com>
 <CAOQ4uxh=KfY2mNW1jQk6-wjoGWzi5LdCN=H9LzfCSx2o69K36A@mail.gmail.com>
In-Reply-To: <CAOQ4uxh=KfY2mNW1jQk6-wjoGWzi5LdCN=H9LzfCSx2o69K36A@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 9 Jun 2023 17:42:30 +0300
Message-ID: <CAOQ4uxgk3sAubfx84FKtNSowgT-aYj0DBX=hvAApre_3a8Cq=g@mail.gmail.com>
Subject: Re: [PATCH 0/3] Reduce impact of overlayfs fake path files
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Paul Moore <paul@paul-moore.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 9, 2023 at 5:28=E2=80=AFPM Amir Goldstein <amir73il@gmail.com> =
wrote:
>
> On Fri, Jun 9, 2023 at 4:15=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
> >
> > On Fri, 9 Jun 2023 at 09:32, Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > Miklos,
> > >
> > > This is the solution that we discussed for removing FMODE_NONOTIFY
> > > from overlayfs real files.
> > >
> > > My branch [1] has an extra patch for remove FMODE_NONOTIFY, but
> > > I am still testing the ovl-fsnotify interaction, so we can defer
> > > that step to later.
> > >
> > > I wanted to post this series earlier to give more time for fsdevel
> > > feedback and if these patches get your blessing and the blessing of
> > > vfs maintainers, it is probably better that they will go through the
> > > vfs tree.
> > >
> > > I've tested that overlay "fake" path are still shown in /proc/self/ma=
ps
> > > and in the /proc/self/exe and /proc/self/map_files/ symlinks.
> > >
> > > The audit and tomoyo use of file_fake_path() is not tested
> > > (CC maintainers), but they both look like user displayed paths,
> > > so I assumed they's want to preserve the existing behavior
> > > (i.e. displaying the fake overlayfs path).
> >
> > I did an audit of all ->vm_file  and found a couple of missing ones:
>
> Wait, but why only ->vm_file?
> We were under the assumption the fake path is only needed
> for mapped files, but the list below suggests that it matters
> to other file operations as well...
>
> >
> > dump_common_audit_data
> > ima_file_mprotect
> > common_file_perm (I don't understand the code enough to know whether
> > it needs fake dentry or not)
> > aa_file_perm
> > __file_path_perm
> > print_bad_pte
> > file_path
> > seq_print_user_ip
> > __mnt_want_write_file
> > __mnt_drop_write_file
> > file_dentry_name
> >
> > Didn't go into drivers/ and didn't follow indirect calls (e.g.
> > f_op->fsysnc).  I also may have missed something along the way, but my
> > guess is that I did catch most cases.
>
> Wow. So much for 3-4 special cases...
>
> Confused by some of the above.
>
> Why would we want __mnt_want_write_file on the fake path?
> We'd already taken __mnt_want_write on overlay and with
> real file we need __mnt_want_write on the real path.
>
> For IMA/LSMs, I'd imagine that like fanotify, they would rather get
> the real path where the real policy is stored.
> If some log files end with relative path instead of full fake path
> it's probably not the worst outcome.
>
> Thoughts?

Considering the results of your audit, I think I prefer to keep
f_path fake and store real_path in struct file_fake for code
that wants the real path.

This will keep all logic unchanged, which is better for my health.
and only fsnotify (for now) will start using f_real_path() to
generate events on real fs objects.

Thanks,
Amir.
