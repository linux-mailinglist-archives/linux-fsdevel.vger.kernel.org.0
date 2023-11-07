Return-Path: <linux-fsdevel+bounces-2237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A93A87E40A7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 14:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89234B20842
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 13:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C4A3158E;
	Tue,  7 Nov 2023 13:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KsQ8uQ4w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0ED30CF7;
	Tue,  7 Nov 2023 13:45:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 419ECC433C7;
	Tue,  7 Nov 2023 13:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699364713;
	bh=AwAIos4Sf5lM4/VuEZbuV5/dEG9ZQKe0S0UcvNhou5k=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=KsQ8uQ4wetEv4j049E6gi4R4i15c/OOxVV3VEEJdB+trdNMoxOit3N7g3hQDYjXXO
	 BisGNfJfMUN153BI0nuG8L6QtAfWxbnmwEeO+2XKCYYBoKdwlItiL3Jw1+GrWQnnv/
	 8jSzxUfNy+SJ6gvnOBn+V0/7adI6bOxqIFpPs4GjkfVqc+rgsoCQ7bJW5cx965boMA
	 Ev4A+MoqSr8behzmSzoqC3QzDAP7IRjD6sgNJh94rxoNUqSDTFc6AuWPkFI+pYkspW
	 /LzxVMkw3/bvInB2I2L3oswtt4CuLyqFA9aPWHjGpCmmrmrgf3YebPKTCjgAPjXtcz
	 u1q7VdAXpim4g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FD0C4332F;
	Tue,  7 Nov 2023 13:45:13 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Subject: [PATCH 00/10] sysctl: Remove sentinel elements from kernel dir
Date: Tue, 07 Nov 2023 14:45:00 +0100
Message-Id:
 <20231107-jag-sysctl_remove_empty_elem_kernel-v1-0-e4ce1388dfa0@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFw/SmUC/x3NQQrCMBBG4auUWRuY1EXRq4iEkPyt0SQtM6VYS
 u9ucPlt3jtIIQlK9+4gwZY0zbXBXjoKL18nmBSbqef+ai0P5u0no7uGNTtBmTc4lGXdHTKK+0A
 qshkibhzGyIE9tdIiGNP3f3k8z/MH6UifCXUAAAA=
To: Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org, 
 josh@joshtriplett.org, Kees Cook <keescook@chromium.org>, 
 Eric Biederman <ebiederm@xmission.com>, Iurii Zaikin <yzaikin@google.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>, 
 Stephen Boyd <sboyd@kernel.org>, Andy Lutomirski <luto@amacapital.net>, 
 Will Drewry <wad@chromium.org>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
 Daniel Bristot de Oliveira <bristot@redhat.com>, 
 Valentin Schneider <vschneid@redhat.com>, Petr Mladek <pmladek@suse.com>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
 Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Balbir Singh <bsingharora@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Joel Granados <j.granados@samsung.com>
X-Mailer: b4 0.13-dev-86aa5
X-Developer-Signature: v=1; a=openpgp-sha256; l=10919;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=xWU4r/E9Gpw/khnI1HixMAzviaIfjsfKgtH5v99wl+0=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBlSj9kLrHGpvjjY+JW0cTidHvDgKUOSvfOEx0Kv
 v10h7qMjmuJAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZUo/ZAAKCRC6l81St5ZB
 TyAIC/0RjVATmr8NI2emzi9ckxqduN7win50jTNyPG1arCL4HCQs6GvB9Qptd7R/Uz9UKeqbDhp
 K2XX9De2OttZetQJOG0jY3B9O+1+xIQiVKEfHGuFrnhZUWF+0jiTnRwXSEijSX+WfK6vlI75WyA
 5ziwNZq4McR/YPT7SdEX79tvcUkuJq49b0azo9Vhafsshq+4uShOcuOgkhkNldRCvbDIGMRp9Fc
 aanseeDimXxHZeG1gwZfa8C/3DmDjq7XGvxHhYn/pc4Q6CKZB11fxwSkbSBSkjgmrZaO0vIO9gJ
 xA3EwqqVOWb5nSA6gDzC9g+sxzXlcQoGg5p9rf70gLz3kVIDWO0jUgsUO1FfOXDDNxfyphbt07D
 TtCgXh5hK1feM2KXRhVEaX0gFDzkyINhPe7B/vg4VcCkfu4YIFrVvh99EI654hVu3QyMy6O/0rf
 4QqihPndtQveTOBlncWfA+KI0HVa1iqP8q5zQFeHPhLW6pK74qpg2SuUWRVE9l9xuPbfk=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received:
 by B4 Relay for j.granados@samsung.com/default with auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
Reply-To: <j.granados@samsung.com>

From: Joel Granados <j.granados@samsung.com>

What?
These commits remove the sentinel element (last empty element) from the
sysctl arrays of all the files under the "kernel/" directory that use a
sysctl array for registration. The merging of the preparation patches
(in https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)
to mainline allows us to just remove sentinel elements without changing
behavior (more info here [1]).

These commits are part of a bigger set (here
https://github.com/Joelgranados/linux/tree/tag/sysctl_remove_empty_elem_V5)
that remove the ctl_table sentinel. Make the review process easier by
chunking the commits into manageable pieces. Each chunk can be reviewed
separately without noise from parallel sets.

Sending the "kernel/*" chunk now that the "drivers/" has been mostly
reviewed [6]. After this and the "fs/*" are reviewed we only miss 2 more
chunks ("net/*" and miscellaneous) to complete the sentinel removal.
Hurray!!!

Why?
By removing the sysctl sentinel elements we avoid kernel bloat as
ctl_table arrays get moved out of kernel/sysctl.c into their own
respective subsystems. This move was started long ago to avoid merge
conflicts; the sentinel removal bit came after Mathew Wilcox suggested
it to avoid bloating the kernel by one element as arrays moved out. This
patchset will reduce the overall build time size of the kernel and run
time memory bloat by about ~64 bytes per declared ctl_table array. I
have consolidated some links that shed light on the history of this
effort [2].

Testing:
* Ran sysctl selftests (./tools/testing/selftests/sysctl/sysctl.sh)
* Ran this through 0-day with no errors or warnings

Size saving after this patchset:
    * bloat-o-meter
        - The "yesall" config saves 1984 bytes [4]
        - The "tiny" config saves 771 bytes [5]
    * If you want to know how many bytes are saved after all the chunks
      are merged see [3]

Base commit:
tag: sysctl-6.7-rc1 (8b793bcda61f)

Comments/feedback greatly appreciated

Best

Joel

[1]
We are able to remove a sentinel table without behavioral change by
introducing a table_size argument in the same place where procname is
checked for NULL. The idea is for it to keep stopping when it hits
->procname == NULL, while the sentinel is still present. And when the
sentinel is removed, it will stop on the table_size. You can go to 
(https://lore.kernel.org/all/20230809105006.1198165-1-j.granados@samsung.com/)
for more information.

[2]
Links Related to the ctl_table sentinel removal:
* E-mail threads that summarize the sentinel effort
  https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/
  https://lore.kernel.org/all/ZMFizKFkVxUFtSqa@bombadil.infradead.org/
* Replacing the register functions:
  https://lore.kernel.org/all/20230302204612.782387-1-mcgrof@kernel.org/
  https://lore.kernel.org/all/20230302202826.776286-1-mcgrof@kernel.org/
* E-mail threads discussing prposal
  https://lore.kernel.org/all/20230321130908.6972-1-frank.li@vivo.com
  https://lore.kernel.org/all/20220220060626.15885-1-tangmeng@uniontech.com

[3]
Size saving after removing all sentinels:
  These are the bytes that we save after removing all the sentinels
  (this plus all the other chunks). I included them to get an idea of
  how much memory we are talking about.
    * bloat-o-meter:
        - The "yesall" configuration results save 9158 bytes
          https://lore.kernel.org/all/20230621091000.424843-1-j.granados@samsung.com/
        - The "tiny" config + CONFIG_SYSCTL save 1215 bytes
          https://lore.kernel.org/all/20230809105006.1198165-1-j.granados@samsung.com/
    * memory usage:
        In memory savings are measured to be 7296 bytes. (here is how to
        measure [7])

[4]
add/remove: 0/0 grow/shrink: 0/31 up/down: 0/-1984 (-1984)
Function                                     old     new   delta
watchdog_sysctls                             576     512     -64
watchdog_hardlockup_sysctl                   128      64     -64
vm_table                                    1344    1280     -64
uts_kern_table                               448     384     -64
usermodehelper_table                         192     128     -64
user_table                                   832     768     -64
user_event_sysctls                           128      64     -64
timer_sysctl                                 128      64     -64
signal_debug_table                           128      64     -64
seccomp_sysctl_table                         192     128     -64
sched_rt_sysctls                             256     192     -64
sched_fair_sysctls                           256     192     -64
sched_energy_aware_sysctls                   128      64     -64
sched_dl_sysctls                             192     128     -64
sched_core_sysctls                           384     320     -64
sched_autogroup_sysctls                      128      64     -64
printk_sysctls                               512     448     -64
pid_ns_ctl_table_vm                          128      64     -64
pid_ns_ctl_table                             128      64     -64
latencytop_sysctl                            128      64     -64
kprobe_sysctls                               128      64     -64
kexec_core_sysctls                           256     192     -64
kern_table                                  2560    2496     -64
kern_reboot_table                            192     128     -64
kern_panic_table                             192     128     -64
kern_exit_table                              128      64     -64
kern_delayacct_table                         128      64     -64
kern_acct_table                              128      64     -64
hung_task_sysctls                            448     384     -64
ftrace_sysctls                               128      64     -64
bpf_syscall_table                            192     128     -64
Total: Before=429912331, After=429910347, chg -0.00%

[5]
add/remove: 0/1 grow/shrink: 0/12 up/down: 0/-771 (-771)
Function                                     old     new   delta
sched_core_sysctl_init                        43      40      -3
vm_table                                    1024     960     -64
uts_kern_table                               448     384     -64
usermodehelper_table                         192     128     -64
user_table                                   576     512     -64
signal_debug_table                           128      64     -64
sched_rt_sysctls                             256     192     -64
sched_fair_sysctls                           128      64     -64
sched_dl_sysctls                             192     128     -64
sched_core_sysctls                            64       -     -64
kern_table                                  1792    1728     -64
kern_panic_table                             128      64     -64
kern_exit_table                              128      64     -64
Total: Before=1886645, After=1885874, chg -0.04%

[6]
https://lore.kernel.org/all/20231002-jag-sysctl_remove_empty_elem_drivers-v2-0-02dd0d46f71e@samsung.com

[7]
To measure the in memory savings apply this on top of this patchset.

"
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index c88854df0b62..e0073a627bac 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -976,6 +976,8 @@ static struct ctl_dir *new_dir(struct ctl_table_set *set,
        table[0].procname = new_name;
        table[0].mode = S_IFDIR|S_IRUGO|S_IXUGO;
        init_header(&new->header, set->dir.header.root, set, node, table, 1);
+       // Counts additional sentinel used for each new dir.
+       printk("%ld sysctl saved mem kzalloc \n", sizeof(struct ctl_table));

        return new;
 }
@@ -1199,6 +1201,9 @@ static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table_
                link_name += len;
                link++;
        }
+       // Counts additional sentinel used for each new registration
+       //
+               printk("%ld sysctl saved mem kzalloc \n", sizeof(struct ctl_table));
        init_header(links, dir->header.root, dir->header.set, node, link_table,
                    head->ctl_table_size);
        links->nreg = nr_entries;
"
and then run the following bash script in the kernel:

accum=0
for n in $(dmesg | grep kzalloc | awk '{print $3}') ; do
    echo $n
    accum=$(calc "$accum + $n")
done
echo $accum

---

Signed-off-by: Joel Granados <j.granados@samsung.com>

---
Joel Granados (10):
      kernel misc:  Remove the now superfluous sentinel elements from ctl_table array
      umh:  Remove the now superfluous sentinel elements from ctl_table array
      ftrace:  Remove the now superfluous sentinel elements from ctl_table array
      timekeeping:  Remove the now superfluous sentinel elements from ctl_table array
      seccomp:  Remove the now superfluous sentinel elements from ctl_table array
      scheduler:  Remove the now superfluous sentinel elements from ctl_table array
      printk:  Remove the now superfluous sentinel elements from ctl_table array
      kprobes:  Remove the now superfluous sentinel elements from ctl_table array
      delayacct:  Remove the now superfluous sentinel elements from ctl_table array
      bpf:  Remove the now superfluous sentinel elements from ctl_table array

 kernel/acct.c                    | 1 -
 kernel/bpf/syscall.c             | 1 -
 kernel/delayacct.c               | 1 -
 kernel/exit.c                    | 1 -
 kernel/hung_task.c               | 1 -
 kernel/kexec_core.c              | 1 -
 kernel/kprobes.c                 | 1 -
 kernel/latencytop.c              | 1 -
 kernel/panic.c                   | 1 -
 kernel/pid_namespace.c           | 1 -
 kernel/pid_sysctl.h              | 1 -
 kernel/printk/sysctl.c           | 1 -
 kernel/reboot.c                  | 1 -
 kernel/sched/autogroup.c         | 1 -
 kernel/sched/core.c              | 1 -
 kernel/sched/deadline.c          | 1 -
 kernel/sched/fair.c              | 1 -
 kernel/sched/rt.c                | 1 -
 kernel/sched/topology.c          | 1 -
 kernel/seccomp.c                 | 1 -
 kernel/signal.c                  | 1 -
 kernel/stackleak.c               | 1 -
 kernel/sysctl.c                  | 2 --
 kernel/time/timer.c              | 1 -
 kernel/trace/ftrace.c            | 1 -
 kernel/trace/trace_events_user.c | 1 -
 kernel/ucount.c                  | 3 +--
 kernel/umh.c                     | 1 -
 kernel/utsname_sysctl.c          | 1 -
 kernel/watchdog.c                | 2 --
 30 files changed, 1 insertion(+), 33 deletions(-)
---
base-commit: 8b793bcda61f6c3ed4f5b2ded7530ef6749580cb
change-id: 20231107-jag-sysctl_remove_empty_elem_kernel-7de90cfd0c0a

Best regards,
-- 
Joel Granados <j.granados@samsung.com>


