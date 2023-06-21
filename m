Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16AE3737EA3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 11:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbjFUJMW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 05:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjFUJL2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:11:28 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D61211D;
        Wed, 21 Jun 2023 02:10:40 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230621091038euoutp01e123bf7eae2cf2239ff74cab5dc393bb~qoY0vfCZa1411914119euoutp01Y;
        Wed, 21 Jun 2023 09:10:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230621091038euoutp01e123bf7eae2cf2239ff74cab5dc393bb~qoY0vfCZa1411914119euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1687338638;
        bh=QatUAmwjfSE5CpygwEgoo8d+plIGyvB6WfjKfmq8pF4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=WBbh3ysmBwasQEKtTmaoGsleQTqlgmC4R8U/+mJGvSWtNFexng/wooaURelQr0+Ix
         8bW/6HMQT73Ttuk4jBTTZ0Ql7yFJyGuRmdDguixw0HvwHLYcsOK8JUwaCs1YNo80PM
         2YVN8Dq1QLsiAczxi+aWjbg8pywEOsXt/1a01AMI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230621091037eucas1p17e649ac102168b47064feeb1a5d9d0d7~qoY0XqSpU2864928649eucas1p1t;
        Wed, 21 Jun 2023 09:10:37 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id B0.AE.11320.D8EB2946; Wed, 21
        Jun 2023 10:10:37 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230621091037eucas1p188e11d8064526a5a0549217d5a419647~qoYzsEdLT3017130171eucas1p10;
        Wed, 21 Jun 2023 09:10:37 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230621091036eusmtrp23053e0e91e9e88b462059cc6e116b0c7~qoYzpFHdu2207922079eusmtrp2g;
        Wed, 21 Jun 2023 09:10:36 +0000 (GMT)
X-AuditID: cbfec7f4-97dff70000022c38-fb-6492be8d52ed
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 7D.1F.10549.C8EB2946; Wed, 21
        Jun 2023 10:10:36 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230621091036eusmtip1064192b2f7098b941992ae887d268647~qoYzRi0Su1210112101eusmtip1N;
        Wed, 21 Jun 2023 09:10:36 +0000 (GMT)
Received: from localhost (106.210.248.248) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 21 Jun 2023 10:10:35 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
CC:     Joel Granados <j.granados@samsung.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Amir Goldstein <amir73il@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        <linux-kernel@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
        <linux-aio@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>, <bpf@vger.kernel.org>,
        <kexec@lists.infradead.org>, <linux-trace-kernel@vger.kernel.org>,
        <keyrings@vger.kernel.org>, <linux-security-module@vger.kernel.org>
Subject: [PATCH 08/11] sysctl: Add size to register_sysctl_init
Date:   Wed, 21 Jun 2023 11:09:57 +0200
Message-ID: <20230621091000.424843-9-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230621091000.424843-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.210.248.248]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0xTZxj2O+frOYUNUxDDF2Vh6TbH2NBpXPKqKC7Z5nFxUed0N5PJ5YQa
        BLQFNs3MoKDIVahIt4KjQigIKIiFwLgVZFYshtHJqHIHGSCIcrcDYcBhC/+e932e53uf58cn
        ph162HXi44HBvDzQ64SUscUld6yN7vFVKt/3TTEukFaQz8AfN/IQTM+k0lA+0IphwtrKQsyc
        HkO+PpyC8cI5BsbrjAwM3R5DYO5tZkA9GI4hbbCBhfn2fgoyr07RMFAYhSCtMRLDiHIGQ19i
        MQ3zJZEsRGQWMFBrrGYh5aYTpKojKFBZExF0Na+DtIdbYOSKM1h1uSzcKMikQFmaQ0HJg3QE
        dckaGtovXsbQEBsA5aZJCorblAz0V8VTED2dhSE5RYmgorIew5+/pTHQkT8vgudxPQzUFdzH
        YLpzF0Pe9TARZLU0UZAffU0ElsQ+BJdG/kaQmb0BRqsPgdmgpUBX1o2hKdyAIC/5JQsvZmZE
        0KpSYzDGGyiY750UQdWFLgrML4YwlN/MYHbv56bPJWCuc/gl5vJ/zUdcalgT5vTXHlJcW1YZ
        4pIiRliuTNPOcpFVj1hOWxTC/VX+NRdZ91TE3cpx4zIrBikuxmKmuaLcaOaA6ze2Hr78ieOh
        vHzTrmO2ssrcBnyydAD98Lt+FoUhswHFIBsxkWwl2p8Ll7CDJAeRMbM4Btku4IkFPGVghWEc
        EdWj3v8dk2VdWCCyEam6n0IL9gXVPaufQBQj0pkSiRcJRvIeaRxuoxcJR8msHTFZjUvv0hKj
        DTGrm5lF1RqJJ+nIK15wiMVY8hbJuX58cW0n8SDDqhosnHYh51vUSzFsJDtJY+8zLGjsSf0v
        j5cwvaCJKE6lBUxIzcAALXjfIC1VmYyAz5J7+kfUYgYi0b1KGq3Jy8RHJEHds3xsDXli1LMC
        dibzZenLhkuIVM89Z4UhDxFd+CQlqHaQyAePlx0fkhylCi22IZLVxPLUXki0mqhK1LSwtiMX
        zjskojc1KzpoVnTQrOigRXQucuJDFAF+vGJLIP/9RoVXgCIk0G+jT1BAEVr4hqY540Qpyn4y
        urEWUWJUi4iYljravVak8nWw8/U6fYaXB30nDznBK2rRejGWOtm9u7Pex0Hi5xXM+/P8SV7+
        H0uJbdaFUbn6n5QbZPZ3FY4TZ9xGj1ZezDBK92x6vV85VZkV7Z6UsX0+fQc+5hKuYS0qM3/E
        r8lj/IDsq+xPawy0q+9n3T2uctPYkPezVTJ3W84nblPs5Je3CkM6dqdIv7AapHv2BhSf3Bx6
        UPNBbPvattjDQxb1425NVu+5l9sOZkjNE24lI1crpp27Pg/q99zWMnGqK9F/X+gnSeGzb0ed
        vSF758p4c4xIg001HrvW6rz99yccLuK0h6Ks5R9/q9++XhdITk1VcLt9ivindY2jR/Yx/6zq
        3Xo4uLPccts7fhR7Vj+Ilb/C6zKaK93qtdd9f2z174vjhjosWs+G05dTmw1BpweOyqRYIfPa
        7EbLFV7/AndzzmT1BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02TezBcdxTH53fv3buLmm5E5dZQHR0dI7WsVw8VTf+oXmlm0qnMtNHppDts
        kbIru0RipINdDSqpCBFsRO2seKyIxxqveMX7UW+SICXeod7vZ7HtjP8+c873e77n/HFYuE4E
        U5/lLfDniwQ8H2NSk2jZaxgyj66I9bDcnrMAWa6ShI4n2QjWt5NxKJsaIGBlc4AJUXuFBCgL
        QzFYfrpHwnJtAwkzz5cQdI32kpAwHUqAbLqVCftDkxjI/1zDYerpLQSydikBc2HbBIzHqHDY
        L5IyQSLPJaGmoZIJ9/NOQXKCBIPYzRgEw736IHtpBXMPDWAzPYsJT3LlGIQVZ2BQ1PMIQW1c
        Eg5Df8QT0Pq7L5S1rGKgGgwjYbLiNgaR6woC4u6HISh/1kRAd6mMhNfKfQYsRL8hoTa3jYCW
        +kYCsnNCGKDo78RAGZnJgBcx4wjuzU0gkD/+GBYrXaGrKhWD9JIRAjpDqxBkx+0yYWN7mwED
        sQkENNyuwmB/dJUBFRHDGHRtzBBQlpdGnr1Ar4ffIei/Z3cJWpmiRHRySCdBF2a+xOhBRQmi
        70rmmHRJ0hCTlla8YtKp+QF0X9klWlr7D4MuyDCj5eXTGB31ogun87MiyW9M3TiOImGAP/9D
        L6HY/4zxD1yw4nDtgWNlY8/hWn/6o4OVrbGFk6MH38f7Gl9k4fQTx+tZVivhVzyFrtcV7qAQ
        1FWFopAGi2LbUKslw8Qh67AViFpaNFTXDai8lV6Gmk9SO31RpFqziKiZTosopHnAKkTNZo4e
        iUj2J1T77CB+2NBlb2lTOw/qjhJwdp0GVR9hecgn2Z9Tr7NVB2ksFsE2oTJyvA/L2mxHaja2
        mlCHGVG/9SccWTXYZ6j20fn/lnOkHi10I7X+BNWUOEaoxxtRElUyrmaKqp6awtVzPqL6K+Sk
        mm9Sy7sTKAbpJh2zJx2zJx2zpyI8C+nyA8S+nr5iLkfM8xUHCDw57kLffHTwEkX1mwXFKOXt
        IqcGYSxUgygWbqyrbZgf66Gj7cG7EcQXCS+LAnz44hpke3DmXVz/PXfhwU8J/C9z7SxtuTZ2
        9pa29nbWxqe0XfwieDpsT54//xc+348v+t+HsTT0QzDijXdB86ur31qcXq7tq68/Z63VF9j7
        VaukxzTeuslGuzbRRXrV69Z3oQXRk2560pCd/I79d8vmWTzJnZhKVVqbWXCv8wm/HHP9xPWc
        augbYwRn1T13ZK1VXbym6ftzH+/XuP63zela79iUCtyvTCC9v67Eht/UdVgsOSsvxYtce0iz
        DknQ0meuN9rSFRYmjzn3LgwYyBSB7l/EOz9UqJSyrY3z80aBzReVI+wPNLRM19JWBKEOZqYj
        kq3x71FRRWklVzqMOS1/3V3ODpb1LrQFXRfYCPnFC4aXzmeuMNJOW+vNN4Zvtntnj4+ZtLg5
        h5l/6SIcrBqs639gq0p5n3uu0ZgQe/G4ZrhIzPsXGRMQfZsEAAA=
X-CMS-MailID: 20230621091037eucas1p188e11d8064526a5a0549217d5a419647
X-Msg-Generator: CA
X-RootMTR: 20230621091037eucas1p188e11d8064526a5a0549217d5a419647
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230621091037eucas1p188e11d8064526a5a0549217d5a419647
References: <20230621091000.424843-1-j.granados@samsung.com>
        <CGME20230621091037eucas1p188e11d8064526a5a0549217d5a419647@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In order to remove the end element from the ctl_table struct arrays, we
explicitly define the size when registering the targes. We add a size
argument to the register_sysctl_init call and pass an ARRAY_SIZE for all
the callers.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 arch/x86/kernel/cpu/intel.c      |  2 +-
 drivers/char/random.c            |  3 ++-
 drivers/tty/tty_io.c             |  2 +-
 drivers/xen/balloon.c            |  3 ++-
 fs/aio.c                         |  2 +-
 fs/coredump.c                    |  3 ++-
 fs/dcache.c                      |  3 ++-
 fs/exec.c                        |  3 ++-
 fs/file_table.c                  |  3 ++-
 fs/inode.c                       |  2 +-
 fs/locks.c                       |  2 +-
 fs/namei.c                       |  2 +-
 fs/namespace.c                   |  3 ++-
 fs/notify/dnotify/dnotify.c      |  3 ++-
 fs/pipe.c                        |  3 ++-
 fs/proc/proc_sysctl.c            | 11 ++---------
 fs/quota/dquot.c                 |  3 ++-
 fs/sysctls.c                     |  3 ++-
 fs/userfaultfd.c                 |  3 ++-
 include/linux/sysctl.h           |  8 +++++---
 init/do_mounts_initrd.c          |  3 ++-
 kernel/acct.c                    |  3 ++-
 kernel/bpf/syscall.c             |  3 ++-
 kernel/delayacct.c               |  3 ++-
 kernel/exit.c                    |  3 ++-
 kernel/hung_task.c               |  3 ++-
 kernel/kexec_core.c              |  3 ++-
 kernel/kprobes.c                 |  3 ++-
 kernel/latencytop.c              |  3 ++-
 kernel/locking/lockdep.c         |  3 ++-
 kernel/panic.c                   |  3 ++-
 kernel/pid_namespace.c           |  3 ++-
 kernel/printk/sysctl.c           |  3 ++-
 kernel/reboot.c                  |  3 ++-
 kernel/sched/autogroup.c         |  3 ++-
 kernel/sched/core.c              |  3 ++-
 kernel/sched/deadline.c          |  3 ++-
 kernel/sched/fair.c              |  3 ++-
 kernel/sched/rt.c                |  3 ++-
 kernel/sched/topology.c          |  3 ++-
 kernel/seccomp.c                 |  3 ++-
 kernel/signal.c                  |  3 ++-
 kernel/stackleak.c               |  3 ++-
 kernel/sysctl.c                  |  4 ++--
 kernel/trace/ftrace.c            |  3 ++-
 kernel/trace/trace_events_user.c |  3 ++-
 kernel/umh.c                     |  3 ++-
 kernel/watchdog.c                |  3 ++-
 mm/compaction.c                  |  2 +-
 mm/hugetlb.c                     |  2 +-
 mm/hugetlb_vmemmap.c             |  3 ++-
 mm/memory-failure.c              |  3 ++-
 mm/oom_kill.c                    |  3 ++-
 mm/page-writeback.c              |  3 ++-
 security/keys/sysctl.c           |  2 +-
 55 files changed, 104 insertions(+), 66 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 1c4639588ff9..c77a3961443d 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1195,7 +1195,7 @@ static struct ctl_table sld_sysctls[] = {
 
 static int __init sld_mitigate_sysctl_init(void)
 {
-	register_sysctl_init("kernel", sld_sysctls);
+	register_sysctl_init("kernel", sld_sysctls, ARRAY_SIZE(sld_sysctls));
 	return 0;
 }
 
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 253f2ddb8913..8db2ea9e3d66 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1692,7 +1692,8 @@ static struct ctl_table random_table[] = {
  */
 static int __init random_sysctls_init(void)
 {
-	register_sysctl_init("kernel/random", random_table);
+	register_sysctl_init("kernel/random", random_table,
+			     ARRAY_SIZE(random_table));
 	return 0;
 }
 device_initcall(random_sysctls_init);
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index c84be40fb8df..63fb3c543b94 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3618,7 +3618,7 @@ static struct ctl_table tty_table[] = {
  */
 int __init tty_init(void)
 {
-	register_sysctl_init("dev/tty", tty_table);
+	register_sysctl_init("dev/tty", tty_table, ARRAY_SIZE(tty_table));
 	cdev_init(&tty_cdev, &tty_fops);
 	if (cdev_add(&tty_cdev, MKDEV(TTYAUX_MAJOR, 0), 1) ||
 	    register_chrdev_region(MKDEV(TTYAUX_MAJOR, 0), 1, "/dev/tty") < 0)
diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index 586a1673459e..e4544262a429 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -729,7 +729,8 @@ static int __init balloon_init(void)
 #ifdef CONFIG_XEN_BALLOON_MEMORY_HOTPLUG
 	set_online_page_callback(&xen_online_page);
 	register_memory_notifier(&xen_memory_nb);
-	register_sysctl_init("xen/balloon", balloon_table);
+	register_sysctl_init("xen/balloon", balloon_table,
+			     ARRAY_SIZE(balloon_table));
 #endif
 
 	balloon_add_regions();
diff --git a/fs/aio.c b/fs/aio.c
index b0b17bd098bb..b09abe7a14d3 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -244,7 +244,7 @@ static struct ctl_table aio_sysctls[] = {
 
 static void __init aio_sysctl_init(void)
 {
-	register_sysctl_init("fs", aio_sysctls);
+	register_sysctl_init("fs", aio_sysctls, ARRAY_SIZE(aio_sysctls));
 }
 #else
 #define aio_sysctl_init() do { } while (0)
diff --git a/fs/coredump.c b/fs/coredump.c
index ece7badf701b..7e55428dce13 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -984,7 +984,8 @@ static struct ctl_table coredump_sysctls[] = {
 
 static int __init init_fs_coredump_sysctls(void)
 {
-	register_sysctl_init("kernel", coredump_sysctls);
+	register_sysctl_init("kernel", coredump_sysctls,
+			     ARRAY_SIZE(coredump_sysctls));
 	return 0;
 }
 fs_initcall(init_fs_coredump_sysctls);
diff --git a/fs/dcache.c b/fs/dcache.c
index 52e6d5fdab6b..f02bfd383e66 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -196,7 +196,8 @@ static struct ctl_table fs_dcache_sysctls[] = {
 
 static int __init init_fs_dcache_sysctls(void)
 {
-	register_sysctl_init("fs", fs_dcache_sysctls);
+	register_sysctl_init("fs", fs_dcache_sysctls,
+			     ARRAY_SIZE(fs_dcache_sysctls));
 	return 0;
 }
 fs_initcall(init_fs_dcache_sysctls);
diff --git a/fs/exec.c b/fs/exec.c
index a466e797c8e2..5572d148738b 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -2170,7 +2170,8 @@ static struct ctl_table fs_exec_sysctls[] = {
 
 static int __init init_fs_exec_sysctls(void)
 {
-	register_sysctl_init("fs", fs_exec_sysctls);
+	register_sysctl_init("fs", fs_exec_sysctls,
+			     ARRAY_SIZE(fs_exec_sysctls));
 	return 0;
 }
 
diff --git a/fs/file_table.c b/fs/file_table.c
index 372653b92617..23a645521960 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -120,7 +120,8 @@ static struct ctl_table fs_stat_sysctls[] = {
 
 static int __init init_fs_stat_sysctls(void)
 {
-	register_sysctl_init("fs", fs_stat_sysctls);
+	register_sysctl_init("fs", fs_stat_sysctls,
+			     ARRAY_SIZE(fs_stat_sysctls));
 	if (IS_ENABLED(CONFIG_BINFMT_MISC)) {
 		struct ctl_table_header *hdr;
 		hdr = register_sysctl_mount_point("fs/binfmt_misc");
diff --git a/fs/inode.c b/fs/inode.c
index 577799b7855f..0a0ad1a2a5d2 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -135,7 +135,7 @@ static struct ctl_table inodes_sysctls[] = {
 
 static int __init init_fs_inode_sysctls(void)
 {
-	register_sysctl_init("fs", inodes_sysctls);
+	register_sysctl_init("fs", inodes_sysctls, ARRAY_SIZE(inodes_sysctls));
 	return 0;
 }
 early_initcall(init_fs_inode_sysctls);
diff --git a/fs/locks.c b/fs/locks.c
index df8b26a42524..ce5733480aa6 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -116,7 +116,7 @@ static struct ctl_table locks_sysctls[] = {
 
 static int __init init_fs_locks_sysctls(void)
 {
-	register_sysctl_init("fs", locks_sysctls);
+	register_sysctl_init("fs", locks_sysctls, ARRAY_SIZE(locks_sysctls));
 	return 0;
 }
 early_initcall(init_fs_locks_sysctls);
diff --git a/fs/namei.c b/fs/namei.c
index e4fe0879ae55..9b567af081af 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1073,7 +1073,7 @@ static struct ctl_table namei_sysctls[] = {
 
 static int __init init_fs_namei_sysctls(void)
 {
-	register_sysctl_init("fs", namei_sysctls);
+	register_sysctl_init("fs", namei_sysctls, ARRAY_SIZE(namei_sysctls));
 	return 0;
 }
 fs_initcall(init_fs_namei_sysctls);
diff --git a/fs/namespace.c b/fs/namespace.c
index 54847db5b819..e7f251e40485 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4715,7 +4715,8 @@ static struct ctl_table fs_namespace_sysctls[] = {
 
 static int __init init_fs_namespace_sysctls(void)
 {
-	register_sysctl_init("fs", fs_namespace_sysctls);
+	register_sysctl_init("fs", fs_namespace_sysctls,
+			     ARRAY_SIZE(fs_namespace_sysctls));
 	return 0;
 }
 fs_initcall(init_fs_namespace_sysctls);
diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
index 190aa717fa32..2c6fe98d6fe1 100644
--- a/fs/notify/dnotify/dnotify.c
+++ b/fs/notify/dnotify/dnotify.c
@@ -33,7 +33,8 @@ static struct ctl_table dnotify_sysctls[] = {
 };
 static void __init dnotify_sysctl_init(void)
 {
-	register_sysctl_init("fs", dnotify_sysctls);
+	register_sysctl_init("fs", dnotify_sysctls,
+			     ARRAY_SIZE(dnotify_sysctls));
 }
 #else
 #define dnotify_sysctl_init() do { } while (0)
diff --git a/fs/pipe.c b/fs/pipe.c
index 2d88f73f585a..8a808fc25552 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -1508,7 +1508,8 @@ static int __init init_pipe_fs(void)
 		}
 	}
 #ifdef CONFIG_SYSCTL
-	register_sysctl_init("fs", fs_pipe_sysctls);
+	register_sysctl_init("fs", fs_pipe_sysctls,
+			     ARRAY_SIZE(fs_pipe_sysctls));
 #endif
 	return err;
 }
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 66c9d7a07d2e..9670c5b7b5b2 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1443,16 +1443,9 @@ EXPORT_SYMBOL(register_sysctl);
  * Context: if your base directory does not exist it will be created for you.
  */
 void __init __register_sysctl_init(const char *path, struct ctl_table *table,
-				 const char *table_name)
+				 const char *table_name, size_t table_size)
 {
-	int count = 0;
-	struct ctl_table *entry;
-	struct ctl_table_header t_hdr, *hdr;
-
-	t_hdr.ctl_table = table;
-	list_for_each_table_entry(entry, (&t_hdr))
-		count++;
-	hdr = register_sysctl(path, table, count);
+	struct ctl_table_header *hdr = register_sysctl(path, table, table_size);
 
 	if (unlikely(!hdr)) {
 		pr_err("failed when register_sysctl %s to %s\n", table_name, path);
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index ffd40dc3e4e9..7c07654e4253 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2953,7 +2953,8 @@ static int __init dquot_init(void)
 
 	printk(KERN_NOTICE "VFS: Disk quotas %s\n", __DQUOT_VERSION__);
 
-	register_sysctl_init("fs/quota", fs_dqstats_table);
+	register_sysctl_init("fs/quota", fs_dqstats_table,
+			     ARRAY_SIZE(fs_dqstats_table));
 
 	dquot_cachep = kmem_cache_create("dquot",
 			sizeof(struct dquot), sizeof(unsigned long) * 4,
diff --git a/fs/sysctls.c b/fs/sysctls.c
index 76a0aee8c229..944254dd92c0 100644
--- a/fs/sysctls.c
+++ b/fs/sysctls.c
@@ -31,7 +31,8 @@ static struct ctl_table fs_shared_sysctls[] = {
 
 static int __init init_fs_sysctls(void)
 {
-	register_sysctl_init("fs", fs_shared_sysctls);
+	register_sysctl_init("fs", fs_shared_sysctls,
+			     ARRAY_SIZE(fs_shared_sysctls));
 	return 0;
 }
 
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 0fd96d6e39ce..4c3858769226 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -2219,7 +2219,8 @@ static int __init userfaultfd_init(void)
 						SLAB_HWCACHE_ALIGN|SLAB_PANIC,
 						init_once_userfaultfd_ctx);
 #ifdef CONFIG_SYSCTL
-	register_sysctl_init("vm", vm_userfaultfd_table);
+	register_sysctl_init("vm", vm_userfaultfd_table,
+			     ARRAY_SIZE(vm_userfaultfd_table));
 #endif
 	return 0;
 }
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 71d7935e50f0..3074a506592d 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -233,8 +233,9 @@ void unregister_sysctl_table(struct ctl_table_header * table);
 
 extern int sysctl_init_bases(void);
 extern void __register_sysctl_init(const char *path, struct ctl_table *table,
-				 const char *table_name);
-#define register_sysctl_init(path, table) __register_sysctl_init(path, table, #table)
+				 const char *table_name, size_t table_size);
+#define register_sysctl_init(path, table, size)	\
+	__register_sysctl_init(path, table, #table, size)
 extern struct ctl_table_header *register_sysctl_mount_point(const char *path);
 
 void do_sysctl_args(void);
@@ -254,7 +255,8 @@ extern int no_unaligned_warning;
 
 #else /* CONFIG_SYSCTL */
 
-static inline void register_sysctl_init(const char *path, struct ctl_table *table)
+static inline void register_sysctl_init(const char *path, struct ctl_table *table,
+					size_t table_size)
 {
 }
 
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 34731241377d..2b10abb8c80e 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -34,7 +34,8 @@ static struct ctl_table kern_do_mounts_initrd_table[] = {
 
 static __init int kernel_do_mounts_initrd_sysctls_init(void)
 {
-	register_sysctl_init("kernel", kern_do_mounts_initrd_table);
+	register_sysctl_init("kernel", kern_do_mounts_initrd_table,
+			     ARRAY_SIZE(kern_do_mounts_initrd_table));
 	return 0;
 }
 late_initcall(kernel_do_mounts_initrd_sysctls_init);
diff --git a/kernel/acct.c b/kernel/acct.c
index 010667ce6080..67125b7c5ca2 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -89,7 +89,8 @@ static struct ctl_table kern_acct_table[] = {
 
 static __init int kernel_acct_sysctls_init(void)
 {
-	register_sysctl_init("kernel", kern_acct_table);
+	register_sysctl_init("kernel", kern_acct_table,
+			     ARRAY_SIZE(kern_acct_table));
 	return 0;
 }
 late_initcall(kernel_acct_sysctls_init);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 14f39c1e573e..a81b5122b16b 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5406,7 +5406,8 @@ static struct ctl_table bpf_syscall_table[] = {
 
 static int __init bpf_syscall_sysctl_init(void)
 {
-	register_sysctl_init("kernel", bpf_syscall_table);
+	register_sysctl_init("kernel", bpf_syscall_table,
+			     ARRAY_SIZE(bpf_syscall_table));
 	return 0;
 }
 late_initcall(bpf_syscall_sysctl_init);
diff --git a/kernel/delayacct.c b/kernel/delayacct.c
index 6f0c358e73d8..4ef14cb5b5a0 100644
--- a/kernel/delayacct.c
+++ b/kernel/delayacct.c
@@ -79,7 +79,8 @@ static struct ctl_table kern_delayacct_table[] = {
 
 static __init int kernel_delayacct_sysctls_init(void)
 {
-	register_sysctl_init("kernel", kern_delayacct_table);
+	register_sysctl_init("kernel", kern_delayacct_table,
+			     ARRAY_SIZE(kern_delayacct_table));
 	return 0;
 }
 late_initcall(kernel_delayacct_sysctls_init);
diff --git a/kernel/exit.c b/kernel/exit.c
index 34b90e2e7cf7..633c7a52ef80 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -95,7 +95,8 @@ static struct ctl_table kern_exit_table[] = {
 
 static __init int kernel_exit_sysctls_init(void)
 {
-	register_sysctl_init("kernel", kern_exit_table);
+	register_sysctl_init("kernel", kern_exit_table,
+			     ARRAY_SIZE(kern_exit_table));
 	return 0;
 }
 late_initcall(kernel_exit_sysctls_init);
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 9a24574988d2..816f133266c4 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -318,7 +318,8 @@ static struct ctl_table hung_task_sysctls[] = {
 
 static void __init hung_task_sysctl_init(void)
 {
-	register_sysctl_init("kernel", hung_task_sysctls);
+	register_sysctl_init("kernel", hung_task_sysctls,
+			     ARRAY_SIZE(hung_task_sysctls));
 }
 #else
 #define hung_task_sysctl_init() do { } while (0)
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 3d578c6fefee..63b04e710890 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1007,7 +1007,8 @@ static struct ctl_table kexec_core_sysctls[] = {
 
 static int __init kexec_core_sysctl_init(void)
 {
-	register_sysctl_init("kernel", kexec_core_sysctls);
+	register_sysctl_init("kernel", kexec_core_sysctls,
+			     ARRAY_SIZE(kexec_core_sysctls));
 	return 0;
 }
 late_initcall(kexec_core_sysctl_init);
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 00e177de91cc..06a3ac7993f0 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -973,7 +973,8 @@ static struct ctl_table kprobe_sysctls[] = {
 
 static void __init kprobe_sysctls_init(void)
 {
-	register_sysctl_init("debug", kprobe_sysctls);
+	register_sysctl_init("debug", kprobe_sysctls,
+			     ARRAY_SIZE(kprobe_sysctls));
 }
 #endif /* CONFIG_SYSCTL */
 
diff --git a/kernel/latencytop.c b/kernel/latencytop.c
index 781249098cb6..55050ae0e197 100644
--- a/kernel/latencytop.c
+++ b/kernel/latencytop.c
@@ -293,7 +293,8 @@ static int __init init_lstats_procfs(void)
 {
 	proc_create("latency_stats", 0644, NULL, &lstats_proc_ops);
 #ifdef CONFIG_SYSCTL
-	register_sysctl_init("kernel", latencytop_sysctl);
+	register_sysctl_init("kernel", latencytop_sysctl,
+			     ARRAY_SIZE(latencytop_sysctl));
 #endif
 	return 0;
 }
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index dcd1d5bfc1e0..1e29cec7e00c 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -102,7 +102,8 @@ static struct ctl_table kern_lockdep_table[] = {
 
 static __init int kernel_lockdep_sysctls_init(void)
 {
-	register_sysctl_init("kernel", kern_lockdep_table);
+	register_sysctl_init("kernel", kern_lockdep_table,
+			     ARRAY_SIZE(kern_lockdep_table));
 	return 0;
 }
 late_initcall(kernel_lockdep_sysctls_init);
diff --git a/kernel/panic.c b/kernel/panic.c
index 886d2ebd0a0d..0008273d23fd 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -104,7 +104,8 @@ static struct ctl_table kern_panic_table[] = {
 
 static __init int kernel_panic_sysctls_init(void)
 {
-	register_sysctl_init("kernel", kern_panic_table);
+	register_sysctl_init("kernel", kern_panic_table,
+			     ARRAY_SIZE(kern_panic_table));
 	return 0;
 }
 late_initcall(kernel_panic_sysctls_init);
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index b43eee07b00c..7fd5e8adc2e8 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -472,7 +472,8 @@ static __init int pid_namespaces_init(void)
 	pid_ns_cachep = KMEM_CACHE(pid_namespace, SLAB_PANIC | SLAB_ACCOUNT);
 
 #ifdef CONFIG_CHECKPOINT_RESTORE
-	register_sysctl_init("kernel", pid_ns_ctl_table);
+	register_sysctl_init("kernel", pid_ns_ctl_table,
+			     ARRAY_SIZE(pid_ns_ctl_table));
 #endif
 
 	register_pid_ns_sysctl_table_vm();
diff --git a/kernel/printk/sysctl.c b/kernel/printk/sysctl.c
index c228343eeb97..28f37b86414e 100644
--- a/kernel/printk/sysctl.c
+++ b/kernel/printk/sysctl.c
@@ -81,5 +81,6 @@ static struct ctl_table printk_sysctls[] = {
 
 void __init printk_sysctl_init(void)
 {
-	register_sysctl_init("kernel", printk_sysctls);
+	register_sysctl_init("kernel", printk_sysctls,
+			     ARRAY_SIZE(printk_sysctls));
 }
diff --git a/kernel/reboot.c b/kernel/reboot.c
index 3bba88c7ffc6..cf81d8bfb523 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -1277,7 +1277,8 @@ static struct ctl_table kern_reboot_table[] = {
 
 static void __init kernel_reboot_sysctls_init(void)
 {
-	register_sysctl_init("kernel", kern_reboot_table);
+	register_sysctl_init("kernel", kern_reboot_table,
+			     ARRAY_SIZE(kern_reboot_table));
 }
 #else
 #define kernel_reboot_sysctls_init() do { } while (0)
diff --git a/kernel/sched/autogroup.c b/kernel/sched/autogroup.c
index 991fc9002535..2b9ce82279a5 100644
--- a/kernel/sched/autogroup.c
+++ b/kernel/sched/autogroup.c
@@ -24,7 +24,8 @@ static struct ctl_table sched_autogroup_sysctls[] = {
 
 static void __init sched_autogroup_sysctl_init(void)
 {
-	register_sysctl_init("kernel", sched_autogroup_sysctls);
+	register_sysctl_init("kernel", sched_autogroup_sysctls,
+			     ARRAY_SIZE(sched_autogroup_sysctls));
 }
 #else
 #define sched_autogroup_sysctl_init() do { } while (0)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a68d1276bab0..b8c7e01dd78a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4677,7 +4677,8 @@ static struct ctl_table sched_core_sysctls[] = {
 };
 static int __init sched_core_sysctl_init(void)
 {
-	register_sysctl_init("kernel", sched_core_sysctls);
+	register_sysctl_init("kernel", sched_core_sysctls,
+			     ARRAY_SIZE(sched_core_sysctls));
 	return 0;
 }
 late_initcall(sched_core_sysctl_init);
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 5a9a4b81c972..2aacf5ea2ff3 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -46,7 +46,8 @@ static struct ctl_table sched_dl_sysctls[] = {
 
 static int __init sched_dl_sysctl_init(void)
 {
-	register_sysctl_init("kernel", sched_dl_sysctls);
+	register_sysctl_init("kernel", sched_dl_sysctls,
+			     ARRAY_SIZE(sched_dl_sysctls));
 	return 0;
 }
 late_initcall(sched_dl_sysctl_init);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 373ff5f55884..db09e56c2dd3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -217,7 +217,8 @@ static struct ctl_table sched_fair_sysctls[] = {
 
 static int __init sched_fair_sysctl_init(void)
 {
-	register_sysctl_init("kernel", sched_fair_sysctls);
+	register_sysctl_init("kernel", sched_fair_sysctls,
+			     ARRAY_SIZE(sched_fair_sysctls));
 	return 0;
 }
 late_initcall(sched_fair_sysctl_init);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 00e0e5074115..aab9b900ed6f 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -57,7 +57,8 @@ static struct ctl_table sched_rt_sysctls[] = {
 
 static int __init sched_rt_sysctl_init(void)
 {
-	register_sysctl_init("kernel", sched_rt_sysctls);
+	register_sysctl_init("kernel", sched_rt_sysctls,
+			     ARRAY_SIZE(sched_rt_sysctls));
 	return 0;
 }
 late_initcall(sched_rt_sysctl_init);
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 6682535e37c8..46d7c3f3e830 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -255,7 +255,8 @@ static struct ctl_table sched_energy_aware_sysctls[] = {
 
 static int __init sched_energy_aware_sysctl_init(void)
 {
-	register_sysctl_init("kernel", sched_energy_aware_sysctls);
+	register_sysctl_init("kernel", sched_energy_aware_sysctls,
+			     ARRAY_SIZE(sched_energy_aware_sysctls));
 	return 0;
 }
 
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index d3e584065c7f..9683a9a4709d 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -2386,7 +2386,8 @@ static struct ctl_table seccomp_sysctl_table[] = {
 
 static int __init seccomp_sysctl_init(void)
 {
-	register_sysctl_init("kernel/seccomp", seccomp_sysctl_table);
+	register_sysctl_init("kernel/seccomp", seccomp_sysctl_table,
+			     ARRAY_SIZE(seccomp_sysctl_table));
 	return 0;
 }
 
diff --git a/kernel/signal.c b/kernel/signal.c
index 5ba4150c01a7..19791930f12a 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -4788,7 +4788,8 @@ static struct ctl_table signal_debug_table[] = {
 
 static int __init init_signal_sysctls(void)
 {
-	register_sysctl_init("debug", signal_debug_table);
+	register_sysctl_init("debug", signal_debug_table,
+			     ARRAY_SIZE(signal_debug_table));
 	return 0;
 }
 early_initcall(init_signal_sysctls);
diff --git a/kernel/stackleak.c b/kernel/stackleak.c
index 34c9d81eea94..123844341148 100644
--- a/kernel/stackleak.c
+++ b/kernel/stackleak.c
@@ -59,7 +59,8 @@ static struct ctl_table stackleak_sysctls[] = {
 
 static int __init stackleak_sysctls_init(void)
 {
-	register_sysctl_init("kernel", stackleak_sysctls);
+	register_sysctl_init("kernel", stackleak_sysctls,
+			     ARRAY_SIZE(stackleak_sysctls));
 	return 0;
 }
 late_initcall(stackleak_sysctls_init);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 48046932d573..2b9b0c8569ba 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2321,8 +2321,8 @@ static struct ctl_table vm_table[] = {
 
 int __init sysctl_init_bases(void)
 {
-	register_sysctl_init("kernel", kern_table);
-	register_sysctl_init("vm", vm_table);
+	register_sysctl_init("kernel", kern_table, ARRAY_SIZE(kern_table));
+	register_sysctl_init("vm", vm_table, ARRAY_SIZE(vm_table));
 
 	return 0;
 }
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 764668467155..84ef42111f78 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -8219,7 +8219,8 @@ static struct ctl_table ftrace_sysctls[] = {
 
 static int __init ftrace_sysctl_init(void)
 {
-	register_sysctl_init("kernel", ftrace_sysctls);
+	register_sysctl_init("kernel", ftrace_sysctls,
+			     ARRAY_SIZE(ftrace_sysctls));
 	return 0;
 }
 late_initcall(ftrace_sysctl_init);
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index b1ecd7677642..ac019cb21b18 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -2563,7 +2563,8 @@ static int __init trace_events_user_init(void)
 	if (dyn_event_register(&user_event_dops))
 		pr_warn("user_events could not register with dyn_events\n");
 
-	register_sysctl_init("kernel", user_event_sysctls);
+	register_sysctl_init("kernel", user_event_sysctls,
+			     ARRAY_SIZE(user_event_sysctls));
 
 	return 0;
 }
diff --git a/kernel/umh.c b/kernel/umh.c
index 41088c5c39fd..187a30ff8541 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -565,7 +565,8 @@ static struct ctl_table usermodehelper_table[] = {
 
 static int __init init_umh_sysctls(void)
 {
-	register_sysctl_init("kernel/usermodehelper", usermodehelper_table);
+	register_sysctl_init("kernel/usermodehelper", usermodehelper_table,
+			     ARRAY_SIZE(usermodehelper_table));
 	return 0;
 }
 early_initcall(init_umh_sysctls);
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 8e61f21e7e33..dd5a343fadde 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -847,7 +847,8 @@ static struct ctl_table watchdog_sysctls[] = {
 
 static void __init watchdog_sysctl_init(void)
 {
-	register_sysctl_init("kernel", watchdog_sysctls);
+	register_sysctl_init("kernel", watchdog_sysctls,
+			     ARRAY_SIZE(watchdog_sysctls));
 }
 #else
 #define watchdog_sysctl_init() do { } while (0)
diff --git a/mm/compaction.c b/mm/compaction.c
index c8bcdea15f5f..ca09cdd72bf3 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -3145,7 +3145,7 @@ static int __init kcompactd_init(void)
 
 	for_each_node_state(nid, N_MEMORY)
 		kcompactd_run(nid);
-	register_sysctl_init("vm", vm_compaction);
+	register_sysctl_init("vm", vm_compaction, ARRAY_SIZE(vm_compaction));
 	return 0;
 }
 subsys_initcall(kcompactd_init)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f154019e6b84..7838b0c0b82b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4681,7 +4681,7 @@ static struct ctl_table hugetlb_table[] = {
 
 static void hugetlb_sysctl_init(void)
 {
-	register_sysctl_init("vm", hugetlb_table);
+	register_sysctl_init("vm", hugetlb_table, ARRAY_SIZE(hugetlb_table));
 }
 #endif /* CONFIG_SYSCTL */
 
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 27f001e0f0a2..65885a06269b 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -597,7 +597,8 @@ static int __init hugetlb_vmemmap_init(void)
 
 	for_each_hstate(h) {
 		if (hugetlb_vmemmap_optimizable(h)) {
-			register_sysctl_init("vm", hugetlb_vmemmap_sysctls);
+			register_sysctl_init("vm", hugetlb_vmemmap_sysctls,
+					     ARRAY_SIZE(hugetlb_vmemmap_sysctls));
 			break;
 		}
 	}
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 5b663eca1f29..46aef76d8e91 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -148,7 +148,8 @@ static struct ctl_table memory_failure_table[] = {
 
 static int __init memory_failure_sysctl_init(void)
 {
-	register_sysctl_init("vm", memory_failure_table);
+	register_sysctl_init("vm", memory_failure_table,
+			     ARRAY_SIZE(memory_failure_table));
 	return 0;
 }
 late_initcall(memory_failure_sysctl_init);
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 044e1eed720e..500cf2ef9faa 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -734,7 +734,8 @@ static int __init oom_init(void)
 {
 	oom_reaper_th = kthread_run(oom_reaper, NULL, "oom_reaper");
 #ifdef CONFIG_SYSCTL
-	register_sysctl_init("vm", vm_oom_kill_table);
+	register_sysctl_init("vm", vm_oom_kill_table,
+			     ARRAY_SIZE(vm_oom_kill_table));
 #endif
 	return 0;
 }
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index db7943999007..9f997de8d12f 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2320,7 +2320,8 @@ void __init page_writeback_init(void)
 	cpuhp_setup_state(CPUHP_MM_WRITEBACK_DEAD, "mm/writeback:dead", NULL,
 			  page_writeback_cpu_online);
 #ifdef CONFIG_SYSCTL
-	register_sysctl_init("vm", vm_page_writeback_sysctls);
+	register_sysctl_init("vm", vm_page_writeback_sysctls,
+			     ARRAY_SIZE(vm_page_writeback_sysctls));
 #endif
 }
 
diff --git a/security/keys/sysctl.c b/security/keys/sysctl.c
index b72b82bb20c6..fa305f74f658 100644
--- a/security/keys/sysctl.c
+++ b/security/keys/sysctl.c
@@ -71,7 +71,7 @@ struct ctl_table key_sysctls[] = {
 
 static int __init init_security_keys_sysctls(void)
 {
-	register_sysctl_init("kernel/keys", key_sysctls);
+	register_sysctl_init("kernel/keys", key_sysctls, ARRAY_SIZE(key_sysctls));
 	return 0;
 }
 early_initcall(init_security_keys_sysctls);
-- 
2.30.2

