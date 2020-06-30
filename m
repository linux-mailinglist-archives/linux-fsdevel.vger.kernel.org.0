Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD61020F9DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jun 2020 18:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389767AbgF3QxA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jun 2020 12:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389637AbgF3QxA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jun 2020 12:53:00 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AC5C061755;
        Tue, 30 Jun 2020 09:53:00 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e18so10213142pgn.7;
        Tue, 30 Jun 2020 09:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7m7BWKf9NH63+N5h5/gDSmYkD28Bo1dCGyGDwrhMPes=;
        b=rJsvB1h/D9oEezvMx1P4beLY1ixZ/SQlPDAKD5yc76QgEA8ooNxvlPuahEYOi2GIw8
         F5w0a+e+zyLuaXugwkzXDzywfBvOLJJuOk/ynrdK3ghg+QmvF0yHxLcPPtC2L+cc4a4Q
         sk8Vbc7YrfyDS7CYMk70M3O4Xh6Wjwud5PY7z3X1PEW2ApudEAs0GSGklikDiVRFylSe
         PWcTP7YWrFG1K5W8iT0p0NwGdcacNzmYMWkCoiSCFQa138ppevpsO0VTZR9gA93xZyCe
         bO0/vy8f5qc+EVBVFTkhHp357HJ6kMlwMb5fo74bjHg4BsDh7wL2ZTqiJi3LHwQsngWE
         rsCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7m7BWKf9NH63+N5h5/gDSmYkD28Bo1dCGyGDwrhMPes=;
        b=TXL6SOPFHIUjyJ18PVowQltepCdK45/LmN4LdW2cGJHJ4B9vSJGOMDokGd5wOcY9jG
         9CcST5OFpquAf9Uby19FnNSUZNjVLPSs15kV6El1askJZMBr31s97s74GhjF5GSOyktv
         HgRvxHvrsuRF2s6xoPvR5I/FZKTrVYY7Numwrh83jpw5euti63B97RmqwWAj0KXfjdLU
         Q+en70tR3sBVEJkEPbsni2sy+uxkpB6eWssulqaSdYu8+FXSjWNAYipkKOW9h9PALsQu
         GfUq8m/HssCiT3LZt0qNBYcS+YJ8+XChw1zaYT8PsaSC9l6Xq6LIpW76FjFgXvxwxZ9h
         kkTQ==
X-Gm-Message-State: AOAM533tkd/FgNwV5z+xYD6+H08+qPE1jTEUDVlRe9Xudn8adEYKyDCg
        Y2wHdbUErMdz2uyUqrI5XQg=
X-Google-Smtp-Source: ABdhPJyaNE57OnczyCfGWK8wGKBCOXLKYElCtMBWWJs+8LEIpVJpM9nCH0vBWlDH4gjRoyz1llNIqw==
X-Received: by 2002:a62:1b04:: with SMTP id b4mr1266896pfb.145.1593535979744;
        Tue, 30 Jun 2020 09:52:59 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:e083])
        by smtp.gmail.com with ESMTPSA id w22sm3225840pfn.5.2020.06.30.09.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 09:52:58 -0700 (PDT)
Date:   Tue, 30 Jun 2020 09:52:56 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 00/15] Make the user mode driver code a better citizen
Message-ID: <20200630165256.i7wdfjxmqu73fewc@ast-mbp.dhcp.thefacebook.com>
References: <20200625095725.GA3303921@kroah.com>
 <778297d2-512a-8361-cf05-42d9379e6977@i-love.sakura.ne.jp>
 <20200625120725.GA3493334@kroah.com>
 <20200625.123437.2219826613137938086.davem@davemloft.net>
 <CAHk-=whuTwGHEPjvtbBvneHHXeqJC=q5S09mbPnqb=Q+MSPMag@mail.gmail.com>
 <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org>
 <87y2oac50p.fsf@x220.int.ebiederm.org>
 <87bll17ili.fsf_-_@x220.int.ebiederm.org>
 <20200629221231.jjc2czk3ul2roxkw@ast-mbp.dhcp.thefacebook.com>
 <87eepwzqhd.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eepwzqhd.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 30, 2020 at 07:29:34AM -0500, Eric W. Biederman wrote:
> 
> diff --git a/net/bpfilter/bpfilter_kern.c b/net/bpfilter/bpfilter_kern.c
> index 91474884ddb7..3e1874030daa 100644
> --- a/net/bpfilter/bpfilter_kern.c
> +++ b/net/bpfilter/bpfilter_kern.c
> @@ -19,8 +19,8 @@ static void shutdown_umh(void)
>         struct pid *tgid = info->tgid;
>  
>         if (tgid) {
> -               kill_pid_info(SIGKILL, SEND_SIG_PRIV, tgid);
> -               wait_event(tgid->wait_pidfd, !pid_task(tgid, PIDTYPE_TGID));
> +               kill_pid(tgid, SIGKILL, 1);
> +               wait_event(tgid->wait_pidfd, !pid_has_task(tgid, PIDTYPE_TGID));
>                 bpfilter_umh_cleanup(info);
>         }
>  }
> 
> > And then did:
> > while true; do iptables -L;rmmod bpfilter; done
> >  
> > Unfortunately sometimes 'rmmod bpfilter' hangs in wait_event().
> 
> Hmm.  The wake up happens just of tgid->wait_pidfd happens just before
> release_task is called so there is a race.  As it is possible to wake
> up and then go back to sleep before pid_has_task becomes false.
> 
> So I think I need a friendly helper that does:
> 
> bool task_has_exited(struct pid *tgid)
> {
> 	bool exited = false;
> 
> 	rcu_read_lock();
>         tsk = pid_task(tgid, PIDTYPE_TGID);
>         exited = !!tsk;
>         if (tsk) {
>         	exited = !!tsk->exit_state;
> out:
> 	rcu_unlock();
> 	return exited;
> }

All makes sense to me.
If I understood the race condition such helper should indeed solve it.
Are you going to add such patch to your series?
I'll proceed with my work on top of your series and will ignore this
race for now, but I think it should be fixed before we land this set
into multiple trees.
