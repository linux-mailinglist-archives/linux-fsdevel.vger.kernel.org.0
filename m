Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE7C558B00
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jun 2022 23:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiFWVz3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jun 2022 17:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiFWVz2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jun 2022 17:55:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE25D62717
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jun 2022 14:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656021326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WjISEGr+F5OTigLplgN4yLThM5YoZQeV/BJM6J7yR6U=;
        b=BmydsBaBhPwB4m7SpLYTuzqxpYt1o8qnCHbdaakKOCc7fXGl3mkSyCe3CRaJIqKVhaz6Fd
        vM7K1LoXRf9aCq5VjaJwxgnQJv3Dj5OPQgLmdBpv0ZRT45fchU+XYYJ3i6Yz4CAIj8uS/1
        g9qXSyJlXL6tPloc9FV5ZPgCz7MiXIE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-kb7whQ3BNziCvJghUI0Qwg-1; Thu, 23 Jun 2022 17:55:21 -0400
X-MC-Unique: kb7whQ3BNziCvJghUI0Qwg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D525829AA3B0;
        Thu, 23 Jun 2022 21:55:20 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.18.106])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8643240C141F;
        Thu, 23 Jun 2022 21:55:20 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 419C62209F9; Thu, 23 Jun 2022 17:55:20 -0400 (EDT)
Date:   Thu, 23 Jun 2022 17:55:20 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: strange interaction between fuse + pidns
Message-ID: <YrThSLvG8JSLHG4j@redhat.com>
References: <YrShFXRLtRt6T/j+@risky>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrShFXRLtRt6T/j+@risky>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 23, 2022 at 11:21:25AM -0600, Tycho Andersen wrote:
> Hi all,
> 
> I'm seeing some weird interactions with fuse and the pid namespace. I have a
> small reproducer here: https://github.com/tych0/kernel-utils/tree/master/fuse2
> 
> fuse has the concept of "forcing" a request, which means (among other
> things) that it does an unkillable wait in request_wait_answer(). fuse
> flushes files when they are closed with this unkillable wait:
> 
> $ sudo cat /proc/1544574/stack
> [<0>] request_wait_answer+0x12f/0x210
> [<0>] fuse_simple_request+0x109/0x2c0
> [<0>] fuse_flush+0x16f/0x1b0
> [<0>] filp_close+0x27/0x70
> [<0>] put_files_struct+0x6b/0xc0
> [<0>] do_exit+0x360/0xb80
> [<0>] do_group_exit+0x3a/0xa0
> [<0>] get_signal+0x140/0x870
> [<0>] arch_do_signal_or_restart+0xae/0x7c0
> [<0>] exit_to_user_mode_prepare+0x10f/0x1c0
> [<0>] syscall_exit_to_user_mode+0x26/0x40
> [<0>] do_syscall_64+0x46/0xb0
> [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> Generally, this is OK, since the fuse_dev_release() -> fuse_abort_conn()
> wakes up this code when a fuse dev goes away (i.e. a fuse daemon is killed
> or unmounted or whatever). However, there's a problem when the fuse daemon
> itself spawns a thread that does a flush:

So in this case single process is client as well as server. IOW, one
thread is fuse server servicing fuse requests and other thread is fuse
client accessing fuse filesystem?

> since the thread has a copy of
> the fd table with an fd pointing to the same fuse device, the reference
> count isn't decremented to zero in fuse_dev_release(), and the task hangs
> forever.

So why did fuse server thread stop responding to fuse messages. Why
did it not complete flush.

Is it something to do with this init process dying in pid namespace
and it killed that fuse server thread. But it could not kill another
thread because it is in unkillable wait.

> 
> Tasks can be aborted via fusectl's abort file, so all is not lost. However,
> this does wreak havoc in containers which mounted a fuse filesystem with
> this state. If the init pid exits (or crashes), the kernel tries to clean
> up the pidns:
> 
> $ sudo cat /proc/1528591/stack
> [<0>] do_wait+0x156/0x2f0
> [<0>] kernel_wait4+0x8d/0x140
> [<0>] zap_pid_ns_processes+0x104/0x180
> [<0>] do_exit+0xa41/0xb80
> [<0>] do_group_exit+0x3a/0xa0
> [<0>] __x64_sys_exit_group+0x14/0x20
> [<0>] do_syscall_64+0x37/0xb0
> [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> but hangs forever. This unkillable wait seems unfortunate, so I tried the
> obvious thing of changing it to a killable wait:

BTW, unkillable wait happens on ly fc->no_interrupt = 1. And this seems
to be set only if server probably some previous interrupt request
returned -ENOSYS.

fuse_dev_do_write() {
                else if (oh.error == -ENOSYS)
                        fc->no_interrupt = 1;
}

So a simple workaround might be for server to implement support for
interrupting requests.

Having said that, this does sounds like a problem and probably should
be fixed at kernel level.

> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 0e537e580dc1..c604dfcaec26 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -297,7 +297,6 @@ void fuse_request_end(struct fuse_req *req)
>  		spin_unlock(&fiq->lock);
>  	}
>  	WARN_ON(test_bit(FR_PENDING, &req->flags));
> -	WARN_ON(test_bit(FR_SENT, &req->flags));
>  	if (test_bit(FR_BACKGROUND, &req->flags)) {
>  		spin_lock(&fc->bg_lock);
>  		clear_bit(FR_BACKGROUND, &req->flags);
> @@ -381,30 +380,33 @@ static void request_wait_answer(struct fuse_req *req)
>  			queue_interrupt(req);
>  	}
>  
> -	if (!test_bit(FR_FORCE, &req->flags)) {
> -		/* Only fatal signals may interrupt this */
> -		err = wait_event_killable(req->waitq,
> -					test_bit(FR_FINISHED, &req->flags));
> -		if (!err)
> -			return;
> +	/* Only fatal signals may interrupt this */
> +	err = wait_event_killable(req->waitq,
> +				test_bit(FR_FINISHED, &req->flags));

Trying to do a fatal signal killable wait sounds reasonable. But I am
not sure about the history.

- Why FORCE requests can't do killable wait.
- Why flush needs to have FORCE flag set.

> +	if (!err)
> +		return;
>  
> -		spin_lock(&fiq->lock);
> -		/* Request is not yet in userspace, bail out */
> -		if (test_bit(FR_PENDING, &req->flags)) {
> -			list_del(&req->list);
> -			spin_unlock(&fiq->lock);
> -			__fuse_put_request(req);
> -			req->out.h.error = -EINTR;
> -			return;
> -		}
> +	spin_lock(&fiq->lock);
> +	/* Request is not yet in userspace, bail out */
> +	if (test_bit(FR_PENDING, &req->flags)) {
> +		list_del(&req->list);
>  		spin_unlock(&fiq->lock);
> +		__fuse_put_request(req);
> +		req->out.h.error = -EINTR;
> +		return;
>  	}
> +	spin_unlock(&fiq->lock);
>  
>  	/*
> -	 * Either request is already in userspace, or it was forced.
> -	 * Wait it out.
> +	 * Womp womp. We sent a request to userspace and now we're getting
> +	 * killed.
>  	 */
> -	wait_event(req->waitq, test_bit(FR_FINISHED, &req->flags));
> +	set_bit(FR_INTERRUPTED, &req->flags);
> +	/* matches barrier in fuse_dev_do_read() */
> +	smp_mb__after_atomic();
> +	/* request *must* be FR_SENT here, because we ignored FR_PENDING before */
> +	WARN_ON(!test_bit(FR_SENT, &req->flags));
> +	queue_interrupt(req);
>  }
>  
>  static void __fuse_request_send(struct fuse_req *req)
> 
> avaialble as a full patch here:
> https://github.com/tych0/linux/commit/81b9ff4c8c1af24f6544945da808dbf69a1293f7
> 
> but now things are even weirder. Tasks are stuck at the killable wait, but with
> a SIGKILL pending for the thread group.

That's strange. No idea what's going on.

Thanks
Vivek
> 
> root@(none):/# cat /proc/187/stack
> [<0>] fuse_simple_request+0x8d9/0x10f0 [fuse]
> [<0>] fuse_flush+0x42f/0x630 [fuse]
> [<0>] filp_close+0x96/0x120
> [<0>] put_files_struct+0x15c/0x2c0
> [<0>] do_exit+0xa00/0x2450
> [<0>] do_group_exit+0xb2/0x2a0
> [<0>] __x64_sys_exit_group+0x35/0x40
> [<0>] do_syscall_64+0x40/0x90
> [<0>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
> root@(none):/# cat /proc/187/status
> Name:   main
> Umask:  0022
> State:  S (sleeping)
> Tgid:   187
> Ngid:   0
> Pid:    187
> PPid:   185
> TracerPid:      0
> Uid:    0       0       0       0
> Gid:    0       0       0       0
> FDSize: 0
> Groups:
> NStgid: 187     3
> NSpid:  187     3
> NSpgid: 171     0
> NSsid:  160     0
> Threads:        1
> SigQ:   0/6706
> SigPnd: 0000000000000000
> ShdPnd: 0000000000000100
> SigBlk: 0000000000000000
> SigIgn: 0000000180004002
> SigCgt: 0000000000000000
> CapInh: 0000000000000000
> CapPrm: 000001ffffffffff
> CapEff: 000001ffffffffff
> CapBnd: 000001ffffffffff
> CapAmb: 0000000000000000
> NoNewPrivs:     0
> Seccomp:        0
> Seccomp_filters:        0
> Speculation_Store_Bypass:       thread vulnerable
> SpeculationIndirectBranch:      conditional enabled
> Cpus_allowed:   f
> Cpus_allowed_list:      0-3
> Mems_allowed:   00000000,00000001
> Mems_allowed_list:      0
> voluntary_ctxt_switches:        6
> nonvoluntary_ctxt_switches:     1
> 
> Any ideas what's going on here? It also seems I'm not the first person to
> wonder about this:
> https://sourceforge.net/p/fuse/mailman/fuse-devel/thread/CAMp4zn9zTA_A2GJiYo5AD9V5HpeXbzzMP%3DnF0WtwbxRbV3koNA%40mail.gmail.com/#msg36598753
> 
> Thanks,
> 
> Tycho
> 

