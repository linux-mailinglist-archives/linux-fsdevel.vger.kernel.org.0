Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B2854268F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 08:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbiFHE3k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 00:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbiFHE2J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 00:28:09 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC843835BA
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jun 2022 18:58:01 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 257NtE9b022611
        for <linux-fsdevel@vger.kernel.org>; Tue, 7 Jun 2022 17:44:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=mN2w1Mw8T1gj8MghJ6bggafHvQVRo1kwqVFlNfUTqKU=;
 b=TOcIQXP9Xco71XEbczHC6WOqE7RuFeLyNrEKe3aH5qTFYPUkdeCqJB+JGt9tnLRW4sMD
 vwfW9EN5EwEaQ7ty/nA2VhLBloj4spFWgFtbJ1ybHOuHfUK945Er5j1T7oNlZIRxfFpo
 +mnk/sngxtXtbD34ATWO9pH1tKlnV7KCc1U= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gjadujwdy-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jun 2022 17:44:20 -0700
Received: from twshared25107.07.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 7 Jun 2022 17:44:19 -0700
Received: by devbig003.nao1.facebook.com (Postfix, from userid 8731)
        id 5834A4EC4229; Tue,  7 Jun 2022 17:44:08 -0700 (PDT)
From:   Chris Mason <clm@fb.com>
To:     <djwong@kernel.org>, <hch@infradead.org>,
        <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <hannes@cmpxchg.org>, <david@fromorbit.com>
Subject: [PATCH v2] iomap: skip pages past eof in iomap_do_writepage()
Date:   Tue, 7 Jun 2022 17:42:29 -0700
Message-ID: <20220608004228.3658429-1-clm@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 4suVCpUsoabSMxmHBp8akwrmiaYX8hV4
X-Proofpoint-ORIG-GUID: 4suVCpUsoabSMxmHBp8akwrmiaYX8hV4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-07_11,2022-06-07_02,2022-02-23_01
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

iomap_do_writepage() sends pages past i_size through
folio_redirty_for_writepage(), which normally isn't a problem because
truncate and friends clean them very quickly.

When the system has cgroups configured, we can end up in situations
where one cgroup has almost no dirty pages at all, and other cgroups
consume the entire background dirty limit.  This is especially common in
our XFS workloads in production because they have cgroups using O_DIRECT
for almost all of the IO mixed in with cgroups that do more traditional
buffered IO work.

We've hit storms where the redirty path hits millions of times in a few
seconds, on all a single file that's only ~40 pages long.  This leads to
long tail latencies for file writes because the pdflush workers are
hogging the CPU from some kworkers bound to the same CPU.

Reproducing this on 5.18 was tricky because 869ae85dae ("xfs: flush new
eof page on truncate...") ends up writing/waiting most of these dirty pag=
es
before truncate gets a chance to wait on them.

The actual repro looks like this:

/*
 * run me in a cgroup all alone.  Start a second cgroup with dd
 * streaming IO into the block device.
 */
int main(int ac, char **av) {
	int fd;
	int ret;
	char buf[BUFFER_SIZE];
	char *filename =3D av[1];

	memset(buf, 0, BUFFER_SIZE);

	if (ac !=3D 2) {
		fprintf(stderr, "usage: looper filename\n");
		exit(1);
	}
	fd =3D open(filename, O_WRONLY | O_CREAT, 0600);
	if (fd < 0) {
		err(errno, "failed to open");
	}
	fprintf(stderr, "looping on %s\n", filename);
	while(1) {
		/*
		 * skip past page 0 so truncate doesn't write and wait
		 * on our extent before changing i_size
		 */
		ret =3D lseek(fd, 8192, SEEK_SET);
		if (ret < 0)
			err(errno, "lseek");
		ret =3D write(fd, buf, BUFFER_SIZE);
		if (ret !=3D BUFFER_SIZE)
			err(errno, "write failed");
		/* start IO so truncate has to wait after i_size is 0 */
		ret =3D sync_file_range(fd, 16384, 4095, SYNC_FILE_RANGE_WRITE);
		if (ret < 0)
			err(errno, "sync_file_range");
		ret =3D ftruncate(fd, 0);
		if (ret < 0)
			err(errno, "truncate");
		usleep(1000);
	}
}

And this bpftrace script will show when you've hit a redirty storm:

kretprobe:xfs_vm_writepages {
    delete(@dirty[pid]);
}

kprobe:xfs_vm_writepages {
    @dirty[pid] =3D 1;
}

kprobe:folio_redirty_for_writepage /@dirty[pid] > 0/ {
    $inode =3D ((struct folio *)arg1)->mapping->host->i_ino;
    @inodes[$inode] =3D count();
    @redirty++;
    if (@redirty > 90000) {
        printf("inode %d redirty was %d", $inode, @redirty);
        exit();
    }
}

This patch has the same number of failures on xfstests as unpatched 5.18:
Failures: generic/648 xfs/019 xfs/050 xfs/168 xfs/299 xfs/348 xfs/506
xfs/543

I also ran it through a long stress of multiple fsx processes hammering.

(Johannes Weiner did significant tracing and debugging on this as well)

Signed-off-by: Chris Mason <clm@fb.com>
Co-authored-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Johannes Weiner <hannes@cmpxchg.org>
Reported-by: Domas Mituzas <domas@fb.com>
---
 fs/iomap/buffered-io.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 8ce8720093b9..64d1476c457d 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1482,10 +1482,10 @@ iomap_do_writepage(struct page *page, struct writ=
eback_control *wbc, void *data)
 		pgoff_t end_index =3D isize >> PAGE_SHIFT;
=20
 		/*
-		 * Skip the page if it's fully outside i_size, e.g. due to a
-		 * truncate operation that's in progress. We must redirty the
-		 * page so that reclaim stops reclaiming it. Otherwise
-		 * iomap_vm_releasepage() is called on it and gets confused.
+		 * Skip the page if it's fully outside i_size, e.g.
+		 * due to a truncate operation that's in progress.  We've
+		 * cleaned this page and truncate will finish things off for
+		 * us.
 		 *
 		 * Note that the end_index is unsigned long.  If the given
 		 * offset is greater than 16TB on a 32-bit system then if we
@@ -1500,7 +1500,7 @@ iomap_do_writepage(struct page *page, struct writeb=
ack_control *wbc, void *data)
 		 */
 		if (folio->index > end_index ||
 		    (folio->index =3D=3D end_index && poff =3D=3D 0))
-			goto redirty;
+			goto unlock;
=20
 		/*
 		 * The page straddles i_size.  It must be zeroed out on each
@@ -1518,6 +1518,7 @@ iomap_do_writepage(struct page *page, struct writeb=
ack_control *wbc, void *data)
=20
 redirty:
 	folio_redirty_for_writepage(wbc, folio);
+unlock:
 	folio_unlock(folio);
 	return 0;
 }
--=20
2.30.2

