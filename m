Return-Path: <linux-fsdevel+bounces-15534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3DC8903B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 16:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5282B23E51
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 15:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5439D131BA7;
	Thu, 28 Mar 2024 15:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOKf7imY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F79612A14A;
	Thu, 28 Mar 2024 15:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711640657; cv=none; b=FeAuaxAUjw80qxwflx4UnCXzwi7rW+1z/LT7QXO3tKX9P6Juqgix2VjJAgMBYyvxwbLofPjcTPK+NkmvqpBxCnGwcJ2OuSfbmK1EIRycKrjcZJbWl53yDRmhoY+aYtVzUGvHT86oSUB2kDjzLQSY9nzXhEDN75KXQvjL6YAJgR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711640657; c=relaxed/simple;
	bh=qYG1LxutZbe5G+N9vijukhEiMclWEcESiwYYQHumlOs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=thftdyJn1iPFQy6Pn/3EU5qxE/eLBAAG+Imd6urpDfMClrH5i9bAZXGkqBavWHr+BO2ZTwcD7NPteCBpBdIaJQum8s/Q9hc7/h/Rd6/LArDQbmKoXZzVImYZbY3uNBKzlTrYyYoxe5tiLRjBja63uumSezO5CymJxwhn2DBmLbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOKf7imY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 047D3C433F1;
	Thu, 28 Mar 2024 15:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711640657;
	bh=qYG1LxutZbe5G+N9vijukhEiMclWEcESiwYYQHumlOs=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=oOKf7imYuDujEq+879+zr/VvxaJ/Ijxr538NSpXlq5SsREFnnUiv4vRFrrHLiASw2
	 usBDXqc5ay5VUzS+O2eVhJYAuCS7uhHNLjRraHdCQWqv4siI0F6+01L/AskBeAKHWy
	 i+AfyO7ubBsBPtlfZvpz4sKIMWPepKSLtzGsAmDjIz7DGfJ4E7Gj1nnlIPN0HzvaiT
	 DRT+WkN6qdvGKZ+1i3LJUwkOo1QeoNFfn5SiZdw4QjZf5B4h1+I3K+lsYhgw0iuYIg
	 AP8giprQf5mU4AnROcxmfCzeflWRW9KFLPhZGJQHYo+unNbUpIrI/U0i904xmQGBhF
	 3FxvVtYPTUPxw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB314CD1283;
	Thu, 28 Mar 2024 15:44:16 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Subject: [PATCH v3 00/10] sysctl: Remove sentinel elements from kernel dir
Date: Thu, 28 Mar 2024 16:44:01 +0100
Message-Id: <20240328-jag-sysctl_remove_empty_elem_kernel-v3-0-285d273912fe@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEGQBWYC/5XNQQ6CMBSE4auYrq15BaLoynsYQ5rHgFVKSYuNh
 HB3q4kLd7r8Z/HNLAK8QRCH1Sw8ognG9Sny9UrwRfctpKlTi4yyXCnayatuZZgCj13lYV1EBTu
 MU4UOtrrB9+jkrsaeuKmJSYskDR6NebxfTufUFxNG56f3aVSv9T8/KkkSBUPlZVk3mo5B23Dv2
 w07K14PMfuoBSkqflOzpJb5lpkKEIG/1WVZnsuAdrIuAQAA
To: Luis Chamberlain <mcgrof@kernel.org>, josh@joshtriplett.org, 
 Kees Cook <keescook@chromium.org>, Eric Biederman <ebiederm@xmission.com>, 
 Iurii Zaikin <yzaikin@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
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
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=openpgp-sha256; l=10789;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=WUTQDpfZgZClvygT4HGPLJcUbPNO7wR07Jx0+KFw53U=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGYFkEnQF6PJsgI7eC1YBuxJbg5WY4lcHUDna
 UUkMAaquYCjeokBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJmBZBJAAoJELqXzVK3
 lkFPp/QL+gLcDkTlgpnG3tU6FQCIyBxVmVf7smmcFn+p+oiVPHzfavDSm0fReAcsvVNaRSPZVHz
 SHga0gGAqDAyPkKcigAHHeGwKdIDOBmeKKjqiopEV4TKhCXmJQJXONiXaJFGZpnM+ddn2E3xgA2
 /Ou9/B4pUvGR1EKZF/L9YtPa+HmrG0SgNCM5kxW3+gWsqgKlJwdn7e+SpCeuQZAhHseoGgCrWsT
 +ulHQBI6SZbnu3EcYxakfyTqnasMvGyJ9lXMUinfh7fY0U5NmQxRY5WDoiA+yx5PrPuMdW1E/wQ
 uZe+JmQK9Lv98WV44XpCHCjl3MJDQl98PHhxtcfCT2NTLhf4i78S9+iIXxlhL+Ho0vLoS6IMF60
 BhfNo2e/Ud1evvW+21VYAFFLDBbTxc+7hdXBc2V0G5sgpU4f39lfsEUxepCV4CHRTNBHjcyDAhe
 5j1O8DfGyzmQNnTeXnJCjEEnnUW1SkVcsZCu5wEtZ6NRa+LPmKXL/9qX/z3WUL3Z8WJo5TSm5H4
 PA=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with
 auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
Reply-To: j.granados@samsung.com

From: Joel Granados <j.granados@samsung.com>

What?
These commits remove the sentinel element (last empty element) from the
sysctl arrays of all the files under the "kernel/" directory that use a
sysctl array for registration. The merging of the preparation patches
[1] to mainline allows us to remove sentinel elements without changing
behavior. This is safe because the sysctl registration code
(register_sysctl() and friends) use the array size in addition to
checking for a sentinel [2].

Why?
By removing the sysctl sentinel elements we avoid kernel bloat as
ctl_table arrays get moved out of kernel/sysctl.c into their own
respective subsystems. This move was started long ago to avoid merge
conflicts; the sentinel removal bit came after Mathew Wilcox suggested
it to avoid bloating the kernel by one element as arrays moved out. This
patchset will reduce the overall build time size of the kernel and run
time memory bloat by about ~64 bytes per declared ctl_table array (more
info here [5]).

When are we done?
There are 4 patchests (25 commits [3]) that are still outstanding to
completely remove the sentinels: files under "net/", files under
"kernel/" (this patchset) dir, misc dirs (files under mm/ security/ and
others) and the final set that removes the unneeded check for ->procname
== NULL.

Testing:
* Ran sysctl selftests (./tools/testing/selftests/sysctl/sysctl.sh)
* Ran this through 0-day with no errors or warnings

Savings in vmlinux:
  A total of 64 bytes per sentinel is saved after removal; I measured in
  x86_64 to give an idea of the aggregated savings. The actual savings
  will depend on individual kernel configuration.
    * bloat-o-meter
        - The "yesall" config saves 1984 bytes [6]
        - A reduced config [4] saves 1027 bytes [7]

Savings in allocated memory:
  None in this set but will occur when the superfluous allocations are
  removed from proc_sysctl.c. I include it here for context. The
  estimated savings during boot for config [3] are 6272 bytes. See [8]
  for how to measure it.

Comments/feedback greatly appreciated

Changes in v3:
- Rebased to v6.9-rc1
- wrote a shorter cover letter
- Removed willy@infradead.org from cc
- Link to v2: https://lore.kernel.org/r/20240104-jag-sysctl_remove_empty_elem_kernel-v2-0-836cc04e00ec@samsung.com

Changes in v2:
- No functional changes; I resent it as I did not see it in the latest
  sysctl-next. It might be a bit too late to include it in 6.7 version,
  but this v2 can be used for 6.8 when it comes out.
- Rebased on top of v6.7-rc6
- Added trailers to the relevant commits.
- Link to v1: https://lore.kernel.org/r/20231107-jag-sysctl_remove_empty_elem_kernel-v1-0-e4ce1388dfa0@samsung.com
Best

Joel

[1] https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/
[2] https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/
[3] https://git.kernel.org/pub/scm/linux/kernel/git/joel.granados/linux.git/tag/?h=sysctl_remove_empty_elem_v5
[4] https://gist.github.com/Joelgranados/feaca7af5537156ca9b73aeaec093171

[5]
Links Related to the ctl_table sentinel removal:
* Good summaries from Luis:
  https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/
  https://lore.kernel.org/all/ZMFizKFkVxUFtSqa@bombadil.infradead.org/
* Patches adjusting sysctl register calls:
  https://lore.kernel.org/all/20230302204612.782387-1-mcgrof@kernel.org/
  https://lore.kernel.org/all/20230302202826.776286-1-mcgrof@kernel.org/
* Discussions about expectations and approach
  https://lore.kernel.org/all/20230321130908.6972-1-frank.li@vivo.com
  https://lore.kernel.org/all/20220220060626.15885-1-tangmeng@uniontech.com

[6]
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

[7]
add/remove: 0/1 grow/shrink: 0/16 up/down: 0/-1027 (-1027)
Function                                     old     new   delta
sched_core_sysctl_init                        39      36      -3
vm_table                                    1024     960     -64
uts_kern_table                               448     384     -64
usermodehelper_table                         192     128     -64
user_table                                   704     640     -64
signal_debug_table                           128      64     -64
seccomp_sysctl_table                         192     128     -64
sched_rt_sysctls                             256     192     -64
sched_fair_sysctls                           128      64     -64
sched_dl_sysctls                             192     128     -64
sched_core_sysctls                            64       -     -64
printk_sysctls                               512     448     -64
pid_ns_ctl_table_vm                          128      64     -64
kern_table                                  1920    1856     -64
kern_reboot_table                            192     128     -64
kern_panic_table                             128      64     -64
kern_exit_table                              128      64     -64
Total: Before=8522228, After=8521201, chg -0.01%

[8]
To measure the in memory savings apply this on top of this patchset.

"
"
diff --git i/fs/proc/proc_sysctl.c w/fs/proc/proc_sysctl.c
index 37cde0efee57..896c498600e8 100644
--- i/fs/proc/proc_sysctl.c
+++ w/fs/proc/proc_sysctl.c
@@ -966,6 +966,7 @@ static struct ctl_dir *new_dir(struct ctl_table_set *set,
        table[0].procname = new_name;
        table[0].mode = S_IFDIR|S_IRUGO|S_IXUGO;
        init_header(&new->header, set->dir.header.root, set, node, table, 1);
+       printk("%ld sysctl saved mem kzalloc\n", sizeof(struct ctl_table));

        return new;
 }
@@ -1189,6 +1190,7 @@ static struct ctl_table_header *new_links(struct ctl_dir *dir, s>
                link_name += len;
                link++;
        }
+       printk("%ld sysctl saved mem kzalloc\n", sizeof(struct ctl_table));
        init_header(links, dir->header.root, dir->header.set, node, link_table,
                    head->ctl_table_size);
        links->nreg = nr_entries;
"
and then run the following bash script in the kernel:

accum=0
for n in $(dmesg | grep kzalloc | awk '{print $3}') ; do
    accum=$(calc "$accum + $n")
done
echo $accum

---
Signed-off-by: Joel Granados <j.granados@samsung.com>

---
Joel Granados (10):
      kernel misc:  Remove the now superfluous sentinel elements from ctl_table array
      umh:  Remove the now superfluous sentinel elements from ctl_table array
      ftrace: Remove the now superfluous sentinel elements from ctl_table array
      timekeeping:  Remove the now superfluous sentinel elements from ctl_table array
      seccomp: Remove the now superfluous sentinel elements from ctl_table array
      scheduler: Remove the now superfluous sentinel elements from ctl_table array
      printk: Remove the now superfluous sentinel elements from ctl_table array
      kprobes: Remove the now superfluous sentinel elements from ctl_table array
      delayacct:  Remove the now superfluous sentinel elements from ctl_table array
      bpf: Remove the now superfluous sentinel elements from ctl_table array

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
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20231107-jag-sysctl_remove_empty_elem_kernel-7de90cfd0c0a

Best regards,
-- 
Joel Granados <j.granados@samsung.com>



