Return-Path: <linux-fsdevel+bounces-3303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1191B7F2BDD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 12:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D7A6B21C77
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 11:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D503495C8;
	Tue, 21 Nov 2023 11:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JuwTgTPp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08851A5B7;
	Tue, 21 Nov 2023 11:35:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5ED4FC433C7;
	Tue, 21 Nov 2023 11:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700566534;
	bh=67+DSJqXxA2UA336zXwDJ/QssykzMEvCiGED8qs+5oo=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=JuwTgTPpdtMpveppX5TgUAmP4Ks+/fq1j6Fpd1vV0apmSN+YFJ46W3lni/f05H3Iu
	 qd68cMxx5keE8z74jB+tK5oePbRJAH4RgZ4FR2uZzLtWla9LJEzR4jFkyu7QRGbick
	 cEkyMJ+YizC8zMU1pmzuPRw24vEcTOZcXe3KSjiUySI9WNuk8qOSPxWLfpo0q8ysBu
	 9WmCjl9uzmvd3UCdQprj9PSIohzfFmdMzsKV822bJ7i2Nzu/R0WsBu0VaROFhUvEtr
	 cOgg0lbhtX5i51nTt6O3cEpdHqd92fXnK2x0uQ3NdXrqF5o/fnq1QCur+P83wJYK75
	 lJsOX7JOG4M5g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B10BC54FB9;
	Tue, 21 Nov 2023 11:35:34 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Subject: [PATCH v2 0/4] sysctl: Remove sentinel elements from fs dir
Date: Tue, 21 Nov 2023 12:35:10 +0100
Message-Id:
 <20231121-jag-sysctl_remove_empty_elem_fs-v2-0-39eab723a034@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO6VXGUC/42NQQ6DIBAAv2L2XBrBVNue+o/GEMRFaQQMa0mN8
 e+lvqDHmcPMBoTRIsG92CBismSDzyBOBehR+QGZ7TODKEXFedmwlxoYraSXSUZ0IaFENy+rxAm
 dNMT6rtemvly56RByZY5o7Oc4PNvMo6UlxPUYJv6z/7cTZyVreFPXlTCobuZBytHbD2cdHLT7v
 n8BFJmDm9AAAAA=
To: Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org, 
 josh@joshtriplett.org, Kees Cook <keescook@chromium.org>, 
 David Howells <dhowells@redhat.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Benjamin LaHaise <bcrl@kvack.org>, 
 Eric Biederman <ebiederm@xmission.com>, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Jan Kara <jack@suse.cz>, 
 Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>, 
 Anton Altaparmakov <anton@tuxera.com>, Namjae Jeon <linkinjeon@kernel.org>, 
 Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
 Joseph Qi <joseph.qi@linux.alibaba.com>, Iurii Zaikin <yzaikin@google.com>, 
 Eric Biggers <ebiggers@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, 
 Chandan Babu R <chandan.babu@oracle.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Jan Harkes <jaharkes@cs.cmu.edu>, 
 coda@cs.cmu.edu
Cc: linux-cachefs@redhat.com, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-mm@kvack.org, 
 linux-nfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net, 
 ocfs2-devel@lists.linux.dev, fsverity@lists.linux.dev, 
 linux-xfs@vger.kernel.org, codalist@coda.cs.cmu.edu, 
 Joel Granados <j.granados@samsung.com>
X-Mailer: b4 0.13-dev-86aa5
X-Developer-Signature: v=1; a=openpgp-sha256; l=11974;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=RgpU80zlwXRyPTcs9gNHkDrh5022I2wJtp3ZI7/hHhA=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBlXJYDgW3DTViMxHmZA5TpZABdyD+uwRpu7xH28
 6jLZDKLLz+JAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZVyWAwAKCRC6l81St5ZB
 T0adC/wIGmSaf3rE0+DRrmLRTJ19zKO7UuwcMEVz/sEENR0KZo7GjSEpEkm81VTqfjNSpPhOHfK
 QmhMHX0QWFlIlF1Ot0S1gLD0q2l3/FCGrZ0Pfj9RaUGA/GL7lqyoX5gpBYZh7Ut9LOxLWzWSZhf
 V/9JPSzZXhpQeaPO1R0wABfHqHnFNPA1IO7unVa/XlEaXZSmgiD7tmpxRKc+thnjvF/z2Xf5obi
 ZHj66xGko55jJJ5FDsQ+S/GZIcjW5DfFOq3HR1X4l1WIfp0yp81qwfWylD3YgbtxiFSmaOiRr/k
 urnhTjtJh9yh2k1htKhucXCg7GnjEjWqhUWC8aI2nZYOgtfaA1Pqy5fizRtMH9lE9heXZwlXOzj
 jxsK8o2AbY6RAML3NhSzZX18x9uy+l4/zCgBxlb7S3QrK2+/La07iI0bA2rtJOcNRRRz/S48DMM
 VjhyT8ceub8b2x/oRM6XxG6VekSHmTZLtSE1shfy+fsuUkgzAVCAZkae2sT4e/NRbDIeM=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received:
 by B4 Relay for j.granados@samsung.com/default with auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
Reply-To: <j.granados@samsung.com>

From: Joel Granados <j.granados@samsung.com>

What?
These commits remove the sentinel element (last empty element) from the
sysctl arrays of all the files under the "fs/" directory that use a
sysctl array for registration. The merging of the preparation patches
(in https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)
to mainline allows us to just remove sentinel elements without changing
behavior (more info here [1]).

These commits are part of a bigger set (here
https://github.com/Joelgranados/linux/tree/tag/sysctl_remove_empty_elem_V5)
that remove the ctl_table sentinel. We make the review process easier by
chunking the commits into manageable pieces. Each chunk can be reviewed
separately without noise from parallel sets.

Sending the "fs/*" chunk now that the "drivers/" has been mostly
reviewed [6]. After this and the "kernel/*" are reviewed we only have 2 more
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
        - The "yesall" config saves 1920 bytes [4]
        - The "tiny" config saves 576 bytes [5]
    * If you want to know how many bytes are saved after all the chunks
      are merged see [3]

Base commit:
tag: sysctl-6.7-rc1 (8b793bcda61f)

Comments/feedback greatly appreciated

Best

Joel

---
Changes in v2:
- changed commit message from "aio: *" to "fs: *"
- We now register fsverity_sysctl_table with one call instead of
  selecting a call based CONFIG_FS_VERITY_BUILTIN_SIGNATURES
- Link to v1: https://lore.kernel.org/r/20231107-jag-sysctl_remove_empty_elem_fs-v1-0-7176632fea9f@samsung.com

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
add/remove: 0/0 grow/shrink: 0/30 up/down: 0/-1920 (-1920)
Function                                     old     new   delta
xfs_table                                   1024     960     -64
vm_userfaultfd_table                         128      64     -64
test_table_unregister                        128      64     -64
test_table                                   576     512     -64
root_table                                   128      64     -64
pty_table                                    256     192     -64
ocfs2_nm_table                               128      64     -64
ntfs_sysctls                                 128      64     -64
nlm_sysctls                                  448     384     -64
nfs_cb_sysctls                               192     128     -64
nfs4_cb_sysctls                              192     128     -64
namei_sysctls                                320     256     -64
locks_sysctls                                192     128     -64
inotify_table                                256     192     -64
inodes_sysctls                               192     128     -64
fsverity_sysctl_table                        128      64     -64
fs_stat_sysctls                              256     192     -64
fs_shared_sysctls                            192     128     -64
fs_pipe_sysctls                              256     192     -64
fs_namespace_sysctls                         128      64     -64
fs_exec_sysctls                              128      64     -64
fs_dqstats_table                             576     512     -64
fs_dcache_sysctls                            128      64     -64
fanotify_table                               256     192     -64
epoll_table                                  128      64     -64
dnotify_sysctls                              128      64     -64
coredump_sysctls                             256     192     -64
coda_table                                   256     192     -64
cachefiles_sysctls                           128      64     -64
aio_sysctls                                  192     128     -64
Total: Before=429912331, After=429910411, chg -0.00%

[5]
add/remove: 0/0 grow/shrink: 0/9 up/down: 0/-576 (-576)
Function                                     old     new   delta
root_table                                   128      64     -64
namei_sysctls                                320     256     -64
inodes_sysctls                               192     128     -64
fs_stat_sysctls                              256     192     -64
fs_shared_sysctls                            192     128     -64
fs_pipe_sysctls                              256     192     -64
fs_namespace_sysctls                         128      64     -64
fs_exec_sysctls                              128      64     -64
fs_dcache_sysctls                            128      64     -64
Total: Before=1886645, After=1886069, chg -0.03%

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

To: Luis Chamberlain <mcgrof@kernel.org>
To: willy@infradead.org
To: josh@joshtriplett.org
To: Kees Cook <keescook@chromium.org>
To: David Howells <dhowells@redhat.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
To: Benjamin LaHaise <bcrl@kvack.org>
To: Eric Biederman <ebiederm@xmission.com>
To: Trond Myklebust <trond.myklebust@hammerspace.com>
To: Anna Schumaker <anna@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
To: Neil Brown <neilb@suse.de>
To: Olga Kornievskaia <kolga@netapp.com>
To: Dai Ngo <Dai.Ngo@oracle.com>
To: Tom Talpey <tom@talpey.com>
To: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
To: Matthew Bobrowski <repnop@google.com>
To: Anton Altaparmakov <anton@tuxera.com>
To: Namjae Jeon <linkinjeon@kernel.org>
To: Mark Fasheh <mark@fasheh.com>
To: Joel Becker <jlbec@evilplan.org>
To: Joseph Qi <joseph.qi@linux.alibaba.com>
To: Iurii Zaikin <yzaikin@google.com>
To: Eric Biggers <ebiggers@kernel.org>
To: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Chandan Babu R <chandan.babu@oracle.com>
To: "Darrick J. Wong" <djwong@kernel.org>
To: Jan Harkes <jaharkes@cs.cmu.edu>
To: coda@cs.cmu.edu
Cc: linux-cachefs@redhat.com
Cc: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-aio@kvack.org
Cc: linux-mm@kvack.org
Cc: linux-nfs@vger.kernel.org
Cc: linux-ntfs-dev@lists.sourceforge.net
Cc: ocfs2-devel@lists.linux.dev
Cc: fsverity@lists.linux.dev
Cc: linux-xfs@vger.kernel.org
Cc: codalist@coda.cs.cmu.edu
---

Signed-off-by: Joel Granados <j.granados@samsung.com>

---
Joel Granados (4):
      cachefiles: Remove the now superfluous sentinel element from ctl_table array
      fs: Remove the now superfluous sentinel elements from ctl_table array
      sysctl:  Remove the now superfluous sentinel elements from ctl_table array
      coda:  Remove the now superfluous sentinel elements from ctl_table array

 fs/aio.c                           | 1 -
 fs/cachefiles/error_inject.c       | 1 -
 fs/coda/sysctl.c                   | 1 -
 fs/coredump.c                      | 1 -
 fs/dcache.c                        | 1 -
 fs/devpts/inode.c                  | 1 -
 fs/eventpoll.c                     | 1 -
 fs/exec.c                          | 1 -
 fs/file_table.c                    | 1 -
 fs/inode.c                         | 1 -
 fs/lockd/svc.c                     | 1 -
 fs/locks.c                         | 1 -
 fs/namei.c                         | 1 -
 fs/namespace.c                     | 1 -
 fs/nfs/nfs4sysctl.c                | 1 -
 fs/nfs/sysctl.c                    | 1 -
 fs/notify/dnotify/dnotify.c        | 1 -
 fs/notify/fanotify/fanotify_user.c | 1 -
 fs/notify/inotify/inotify_user.c   | 1 -
 fs/ntfs/sysctl.c                   | 1 -
 fs/ocfs2/stackglue.c               | 1 -
 fs/pipe.c                          | 1 -
 fs/proc/proc_sysctl.c              | 1 -
 fs/quota/dquot.c                   | 1 -
 fs/sysctls.c                       | 1 -
 fs/userfaultfd.c                   | 1 -
 fs/verity/init.c                   | 1 -
 fs/xfs/xfs_sysctl.c                | 2 --
 lib/test_sysctl.c                  | 2 --
 29 files changed, 31 deletions(-)
---
base-commit: 8b793bcda61f6c3ed4f5b2ded7530ef6749580cb
change-id: 20231107-jag-sysctl_remove_empty_elem_fs-dbdcf6581fbe

Best regards,
-- 
Joel Granados <j.granados@samsung.com>


