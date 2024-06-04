Return-Path: <linux-fsdevel+bounces-20904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D10928FAACB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 08:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 853D61F21CB8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 06:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFB2140E58;
	Tue,  4 Jun 2024 06:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFlC/ZS3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050DA13DDC2;
	Tue,  4 Jun 2024 06:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717482600; cv=none; b=osh6ykqNEgSQ3/RsJ+/RoJpskwKTZe92C//XZJflq97G830dgyvMgYADCRf9ejm21WehEJ4B9R52yl83lubBvm/FZPVYCKfpS4RYvDCey34p/1IJIFt7D+rZqVBdPAYXSjUSbwmrZP1v+hBvhOmYVTjEe0dNFyMgzV3k56ECOOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717482600; c=relaxed/simple;
	bh=T+INzTDE9Vj+7m+fiSwp436wQ7Ya1GzvcaOJ2zGRMJM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ns3rvFO4mo3KYB+AF3bu/FnM7nFPxUdSUCY6APwEk3RV1oJiK1p8516ZR3R17wEQyq/4NpnvJ/3tsg1tAWGnDQZHXEuLopdsRDMiUoh17nJV5opQkGZoP0qEhXkgnsQsd8geCKBq7VAjJXVZqjbwPv1symDJ3fFD9lmMtF1C32w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFlC/ZS3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 889F1C2BBFC;
	Tue,  4 Jun 2024 06:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717482599;
	bh=T+INzTDE9Vj+7m+fiSwp436wQ7Ya1GzvcaOJ2zGRMJM=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=TFlC/ZS30LUnRDy+uM1Lmyz7SgI8vziMwa1ZlXiYVsqCK5GmlTG6FI4LB3Uyei1Px
	 610UkX6nXJ6F1h00uRP/y6X8h3I3SLe6na/TRUuE1MgD5M9GGxs1HeMQWqEH+Los8Z
	 hIreDOKIeG2O5eItfhXlVbS1CWzA/SRPMrgos8OhUnoFhjBfgc/E2k0T4Vx5AGsMgh
	 W3FZBSdwpt7wSVBLuaonLJ6w2WaeY/fHTEhJfAvyd4L5CP5FL43kASovUciNSwDKke
	 HwJoIz5T0mHyRyLC1BNzBq4QUNTOp/sjh7ANRDSVYLGTSrBIiUT3JngVuoe6AsAnhn
	 kUEQfnFuUqZQg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C49C25B7E;
	Tue,  4 Jun 2024 06:29:59 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Subject: [PATCH 0/8] sysctl: Remove sentinel check from sysctl internals
Date: Tue, 04 Jun 2024 08:29:18 +0200
Message-Id: <20240604-jag-sysctl_remset-v1-0-2df7ecdba0bd@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD60XmYC/x3M3QpAQBBA4VfRXNsau0JeRdJag5G/diSSd7e5/
 C7OeUDIMwmU0QOeThbe1oAkjsCNdh1IcRcMGnWKGRo12UHJLe6YG0+L0KFS27eFy7VBNBC63VP
 P1/+s6vf9APoicb1jAAAA
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Suren Baghdasaryan <surenb@google.com>, 
 Kent Overstreet <kent.overstreet@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, 
 Joel Granados <j.granados@samsung.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5454;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=hO67nruGWcLOvW84X+XKeZd/ahfbOIwca7ow3jpSfbc=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGZetGFfrIgm0qAxkXBF8akY86Nh4/uz1S+jh
 vDn/e1k+HsfMIkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJmXrRhAAoJELqXzVK3
 lkFPt5sMAIsGofTYusm1CrCNXBQ8FpJMaCfdZ4UfdUIi3/ZLCPDNmCDoJm9vvlGQSV5bxlrlxZB
 o4Gaj/xdCAe2XnUhynhzIWLcQrkHobHo0KnUZhVywFyPNtavexf6xkOKyZRina7iWbXlm9ojSPn
 vms2DlunREdloZHGeEp+ItfVVcMOnbsarrNh3u69QSIZ6tebBcdhGDWRqrCdXAcO/8hf5P+73FZ
 jL33BEgFQ/pNXlsr8kF1SI7eV1Z+rN2BO2auzybO+/hdWHbpWFySxukUegl34wkHws4yM5xC3hi
 BI7wPT03k+iYsntOOwVhW4pmiRPjd8RDvWgmHFCI+ts7sOoi2Hviyv5DenscGsGPEgZhh8vL7bt
 OiMWxQy9cv5RteMcTQI+152cOBxb4SCdHZD4JRCmKShqPxRkzJhr6fY+HfrOnKpfn8F1O9p+oOt
 gwpHJONzKL4EjWL+TtxY7uGwA503oA7l6bKvvd11zAWkFX4G/5Hm4vnMcH+sDtIwllg1vVr2V56
 +U=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with
 auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
Reply-To: j.granados@samsung.com

From: Joel Granados <j.granados@samsung.com>

What?
Remove the loop stopping criteria check for ->procname == NULL, the
array size calculation based on sentinels and the superfluous sentinels
created within the sysctl infrastructure. None are needed as they are
now solely based on ctl_table ARRAY_SIZE. Finally, sentinels that have
been added in recent releases (not present for the original patchsets)
were removed.

Why?
By removing the sysctl sentinel elements we avoid kernel bloat as
ctl_table arrays get moved out of kernel/sysctl.c into their own
respective subsystems. This move was started long ago to avoid merge
conflicts; the sentinel removal bit is to avoid bloating the kernel by
one element as arrays moved out. It includes work in /arch [1], /dirver
[2], fs/ [3], kernel [4], net/ [5], mm/ [6], security/ [6], io_uring [6]
and other misc directories [6]. It will reduce the overall build time
size of the kernel and run time memory bloat by about ~64 bytes per
declared ctl_table array (more info here [0]).

Testing:
* Ran sysctl selftests (./tools/testing/selftests/sysctl/sysctl.sh)
* Ran this through 0-day with no errors or warnings

Savings in vmlinux:
  A total of 64 bytes per sentinel is saved after removal. Here is the
  aggregated savings for all the removal patchsets ([1,2,3,4,5,6]) for
  the x86_64 arch (actual savings will depend on kernel conf):
 |------|---------|-----------|-------|-----------|--------|---------|----------------|
 |dir   | arch[1] | driver[2] | fs[3] | kernel[4] | net[5] | misc[6] | Total(approx.) |
 |------|---------|-----------|-------|-----------|--------|---------|----------------|
 |Bytes | 192     | 2432      | 1920  | 1984      | 3976   | 963     |    11467       |
 |------|---------|-----------|-------|-----------|--------|---------|----------------|

Savings in allocated memory:
  The estimated savings during boot for config [3] are 6272 bytes. See
  [7] for how to measure it.

Comments/feedback greatly appreciated

Best
Joel

[0] Links Related to the ctl_table sentinel removal:
    * Good summaries from Luis:
      https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/
      https://lore.kernel.org/all/ZMFizKFkVxUFtSqa@bombadil.infradead.org/
    * Patches adjusting sysctl register calls:
      https://lore.kernel.org/all/20230302204612.782387-1-mcgrof@kernel.org/
      https://lore.kernel.org/all/20230302202826.776286-1-mcgrof@kernel.org/
    * Discussions about expectations and approach
      https://lore.kernel.org/all/20230321130908.6972-1-frank.li@vivo.com
      https://lore.kernel.org/all/20220220060626.15885-1-tangmeng@uniontech.com

[1] https://lore.kernel.org/20231002-jag-sysctl_remove_empty_elem_arch-v3-0-606da2840a7a@samsung.com
[2] https://lore.kernel.org/20231002-jag-sysctl_remove_empty_elem_drivers-v2-0-02dd0d46f71e@samsung.com
[3] https://lore.kernel.org/20231121-jag-sysctl_remove_empty_elem_fs-v2-0-39eab723a034@samsung.com
[4] https://lore.kernel.org/20240328-jag-sysctl_remove_empty_elem_kernel-v3-0-285d273912fe@samsung.com
[5] https://lore.kernel.org/20240501-jag-sysctl_remset_net-v6-0-370b702b6b4a@samsung.com
[6] https://lore.kernel.org/20240328-jag-sysctl_remset_misc-v1-0-47c1463b3af2@samsung.com

[7]
To measure the in memory savings apply this on top of this patchset.
"
diff --git i/fs/proc/proc_sysctl.c w/fs/proc/proc_sysctl.c
index a6aeaa928dd2..6ca5341bcddf 100644
--- i/fs/proc/proc_sysctl.c
+++ w/fs/proc/proc_sysctl.c
@@ -963,6 +963,7 @@ static struct ctl_dir *new_dir(struct ctl_table_set *set,
        table[0].procname = new_name;
        table[0].mode = S_IFDIR|S_IRUGO|S_IXUGO;
        init_header(&new->header, set->dir.header.root, set, node, table, 1);
+       printk("%ld sysctl saved mem kzalloc\n", sizeof(struct ctl_table));

        return new;
 }
@@ -1186,6 +1187,7 @@ static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table_
                link_name += len;
                link++;
        }
+       printk("%ld sysctl saved mem kzalloc\n", sizeof(struct ctl_table));
        init_header(links, dir->header.root, dir->header.set, node, link_table,
                    head->ctl_table_size);
        links->nreg = head->ctl_table_size;
"
and then run the following bash script in the kernel:

accum=0
for n in $(dmesg | grep kzalloc | awk '{print $3}') ; do
    accum=$(calc "$accum + $n")
done
echo $accum

Signed-off-by: Joel Granados <j.granados@samsung.com>

---
Joel Granados (8):
      locking: Remove superfluous sentinel element from kern_lockdep_table
      mm profiling: Remove superfluous sentinel element from ctl_table
      sysctl: Remove check for sentinel element in ctl_table arrays
      sysctl: Replace nr_entries with ctl_table_size in new_links
      sysctl: Remove superfluous empty allocations from sysctl internals
      sysctl: Remove "child" sysctl code comments
      sysctl: Remove ctl_table sentinel code comments
      sysctl: Warn on an empty procname element

 fs/proc/proc_sysctl.c    | 50 +++++++++++++++++++++---------------------------
 kernel/locking/lockdep.c |  1 -
 lib/alloc_tag.c          |  1 -
 net/sysctl_net.c         | 11 ++---------
 4 files changed, 24 insertions(+), 39 deletions(-)
---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240603-jag-sysctl_remset-4afb8c723003

Best regards,
-- 
Joel Granados <j.granados@samsung.com>



