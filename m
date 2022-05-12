Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4813F5254A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 May 2022 20:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357584AbiELSW0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 May 2022 14:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357594AbiELSWU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 May 2022 14:22:20 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608F860B86;
        Thu, 12 May 2022 11:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652379732; x=1683915732;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gKX1PGO+dptTOabwhDDmbl7BBre5vJXGH8K4d83YX8E=;
  b=TzoB19gd4P6Hh0YJNn4nRgFSA80K6pIBw1/WOKUsa/SPgfJ4xLECcLSh
   7DwU4Q+z3+KSOAGAfj5pdGp71tlh9BRx2g6N93FuBg4MJAXrJGtyi8PIA
   Qp9TSlZXfLAa3KzNhpk5ej45qDkrD5CEEwJWGJUkPt1cfNcy1MvlULszS
   5b435MrU+3J+NYd7s8tzgtqRYv8u0rbM9J+fDmTv/AR5phbMYhmssxXfG
   vXbkdPcbZwE3eyiGupaWTf+2RHYpykmQI0t91dc/TxO5BEzd8xljoW864
   3mNoGWuSFaNxGyQG9bJkb/DkUflrZbxFP/sNGSCSbWoRN7gi6dw3Xp3l+
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="267690652"
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="267690652"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 11:22:11 -0700
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="624521577"
Received: from josdenl-mobl1.amr.corp.intel.com (HELO ldmartin-desk2) ([10.251.19.41])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 11:22:11 -0700
Date:   Thu, 12 May 2022 11:22:09 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] sysctl: read() must consume poll events, not poll()
Message-ID: <20220512182209.7uiy3pt4chctqhg4@ldmartin-desk2>
X-Patchwork-Hint: comment
References: <20220502140602.130373-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220502140602.130373-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 02, 2022 at 04:06:01PM +0200, Jason A. Donenfeld wrote:
>Events that poll() responds to are supposed to be consumed when the file
>is read(), not by the poll() itself. By putting it on the poll() itself,
>it makes it impossible to poll() on a epoll file descriptor, since the
>event gets consumed too early. Jann wrote a PoC, available in the link
>below.
>
>Reported-by: Jann Horn <jannh@google.com>
>Cc: Kees Cook <keescook@chromium.org>
>Cc: Luis Chamberlain <mcgrof@kernel.org>
>Cc: linux-fsdevel@vger.kernel.org
>Link: https://lore.kernel.org/lkml/CAG48ez1F0P7Wnp=PGhiUej=u=8CSF6gpD9J=Oxxg0buFRqV1tA@mail.gmail.com/
>Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

It seems to be my bug. This is indeed better. Also, I don't think it's unsafe
to fix it like this neither. If my memory serves (it's what, 10+ years?), this
was only tested and used with poll(), which will continue to work.

There were plans to use it in one of systemd's tools, in which case we'd
probably notice the misbehavior with epoll().... humn, checking now systemd's
codebase:

static int on_hostname_change(sd_event_source *es, int fd, uint32_t revents, void *userdata) {
	...
	log_info("System hostname changed to '%s'.", full_hostname);
	...
}

static int manager_watch_hostname(Manager *m) {
         int r;

         assert(m);

         m->hostname_fd = open("/proc/sys/kernel/hostname",
                               O_RDONLY|O_CLOEXEC|O_NONBLOCK|O_NOCTTY);
         if (m->hostname_fd < 0) {
                 log_warning_errno(errno, "Failed to watch hostname: %m");
                 return 0;
         }

         r = sd_event_add_io(m->event, &m->hostname_event_source, m->hostname_fd, 0, on_hostname_change, m);
         if (r < 0) {
                 if (r == -EPERM)
                         /* kernels prior to 3.2 don't support polling this file. Ignore the failure. */
                         m->hostname_fd = safe_close(m->hostname_fd);
                 else
                         return log_error_errno(r, "Failed to add hostname event source: %m");
         }
	....
}

and sd_event library uses epoll. So, it's apparently not working and it doesn't
seem to be their intention to rely on the misbehavior. This makes me think it
even deserves a Cc to stable.

Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>


Lucas De Marchi

>---
> fs/proc/proc_sysctl.c | 12 +++++++++---
> 1 file changed, 9 insertions(+), 3 deletions(-)
>
>diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
>index 7d9cfc730bd4..1aa145794207 100644
>--- a/fs/proc/proc_sysctl.c
>+++ b/fs/proc/proc_sysctl.c
>@@ -622,6 +622,14 @@ static ssize_t proc_sys_call_handler(struct kiocb *iocb, struct iov_iter *iter,
>
> static ssize_t proc_sys_read(struct kiocb *iocb, struct iov_iter *iter)
> {
>+	struct inode *inode = file_inode(iocb->ki_filp);
>+	struct ctl_table_header *head = grab_header(inode);
>+	struct ctl_table *table = PROC_I(inode)->sysctl_entry;
>+
>+	if (!IS_ERR(head) && table->poll)
>+		iocb->ki_filp->private_data = proc_sys_poll_event(table->poll);
>+	sysctl_head_finish(head);
>+
> 	return proc_sys_call_handler(iocb, iter, 0);
> }
>
>@@ -668,10 +676,8 @@ static __poll_t proc_sys_poll(struct file *filp, poll_table *wait)
> 	event = (unsigned long)filp->private_data;
> 	poll_wait(filp, &table->poll->wait, wait);
>
>-	if (event != atomic_read(&table->poll->event)) {
>-		filp->private_data = proc_sys_poll_event(table->poll);
>+	if (event != atomic_read(&table->poll->event))
> 		ret = EPOLLIN | EPOLLRDNORM | EPOLLERR | EPOLLPRI;
>-	}
>
> out:
> 	sysctl_head_finish(head);
>-- 
>2.35.1
>
