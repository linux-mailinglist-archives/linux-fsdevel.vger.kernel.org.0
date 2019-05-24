Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B54702A1CA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 May 2019 01:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfEXXup (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 May 2019 19:50:45 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44180 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfEXXup (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 May 2019 19:50:45 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1hUJxS-0005Qi-8g; Sat, 25 May 2019 01:50:42 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Jan Luebbe <jlu@pengutronix.de>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc: report eip and esp for all threads when coredumping
References: <20190522161614.628-1-jlu@pengutronix.de>
Date:   Sat, 25 May 2019 01:50:40 +0200
In-Reply-To: <20190522161614.628-1-jlu@pengutronix.de> (Jan Luebbe's message
        of "Wed, 22 May 2019 18:16:14 +0200")
Message-ID: <875zpzif8v.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019-05-22, Jan Luebbe <jlu@pengutronix.de> wrote:
> Commit 0a1eb2d474ed ("fs/proc: Stop reporting eip and esp in
> /proc/PID/stat") stopped reporting eip/esp and commit fd7d56270b52
> ("fs/proc: Report eip/esp in /prod/PID/stat for coredumping")
> reintroduced the feature to fix a regression with userspace core dump
> handlers (such as minicoredumper).
>
> Because PF_DUMPCORE is only set for the primary thread, this didn't fix
> the original problem for secondary threads. This commit checks
> mm->core_state instead, as already done for /proc/<pid>/status in
> task_core_dumping(). As we have a mm_struct available here anyway, this
> seems to be a clean solution.
>
> Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
> ---
>  fs/proc/array.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/proc/array.c b/fs/proc/array.c
> index 2edbb657f859..b76b1e29fc36 100644
> --- a/fs/proc/array.c
> +++ b/fs/proc/array.c
> @@ -462,7 +462,7 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
>  		 * a program is not able to use ptrace(2) in that case. It is
>  		 * safe because the task has stopped executing permanently.
>  		 */
> -		if (permitted && (task->flags & PF_DUMPCORE)) {
> +		if (permitted && (!!mm->core_state)) {

This is not entirely safe. mm->core_state is set _before_ zap_process()
is called. Therefore tasks can be executing on a CPU with mm->core_state
set.

With the following additional change, I was able to close the window.

diff --git a/fs/coredump.c b/fs/coredump.c
index e42e17e55bfd..93f55563e2c1 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -340,10 +340,10 @@ static int zap_threads(struct task_struct *tsk, struct mm_struct *mm,
 
 	spin_lock_irq(&tsk->sighand->siglock);
 	if (!signal_group_exit(tsk->signal)) {
-		mm->core_state = core_state;
 		tsk->signal->group_exit_task = tsk;
 		nr = zap_process(tsk, exit_code, 0);
 		clear_tsk_thread_flag(tsk, TIF_SIGPENDING);
+		mm->core_state = core_state;
 	}
 	spin_unlock_irq(&tsk->sighand->siglock);
 	if (unlikely(nr < 0))

AFAICT core_state does not need to be set before the other lines. But
there may be some side effects that I overlooked!

John Ogness
