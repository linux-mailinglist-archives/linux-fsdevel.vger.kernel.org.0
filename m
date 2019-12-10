Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B71D91184D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 11:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfLJKTv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 05:19:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59088 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727032AbfLJKTu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 05:19:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575973189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Y/w2qhmNAwfkY23Bzoz2XeeZ7eRtN89B7DbfBPq1VRk=;
        b=gJLm7tpOmnYUWnK+phaCS+ZilSNAeqL6pAT1Z6ZOf9ZuIgNjHMkrWIz14Y2L5FEKqly+6+
        fM1NsAC9RcTc2LVIePffYg67KRi+XHjfrZZjK4MI+WZzFIHTofQk3JwmLxW2lBIlt6Ads1
        UGzs6f7x0dHTGH6g88rShpXH+Ev6DC8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-MdVMg5dBOOa6bR0IITRhKA-1; Tue, 10 Dec 2019 05:19:48 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60407800EC0;
        Tue, 10 Dec 2019 10:19:45 +0000 (UTC)
Received: from max.com (ovpn-205-78.brq.redhat.com [10.40.205.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6A0CA5D6D4;
        Tue, 10 Dec 2019 10:19:41 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        cluster-devel <cluster-devel@redhat.com>
Subject: Re: [PATCH 15/15] gfs2: use iomap for buffered I/O in ordered and writeback mode
Date:   Tue, 10 Dec 2019 11:19:38 +0100
Message-Id: <20191210101938.495-1-agruenba@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: MdVMg5dBOOa6bR0IITRhKA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph,

On Mon, Sep 30, 2019 at 10:49 PM Andreas Gruenbacher <agruenba@redhat.com> =
wrote:
> On Tue, Aug 6, 2019 at 7:30 AM Christoph Hellwig <hch@lst.de> wrote:
> > On Mon, Aug 05, 2019 at 02:27:21PM +0200, Andreas Gruenbacher wrote:
> here are the changes we currently need on top of what you've posted on
> July 1.  [...]

again, thank you for this patch.  After fixing some related bugs around thi=
s
change, it seems I've finally got this to work properly.  Below are the min=
or
changes I needed to make on top of your version.

This requires functions iomap_page_create and iomap_set_range_uptodate to b=
e
exported; i'll post a patch for that sepatately.

The result can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git for-next.=
iomap

Thanks,
Andreas

---
 fs/gfs2/bmap.c | 6 ++++--
 fs/gfs2/file.c | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 168ac5147dd0..fcd2043fc466 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -75,13 +75,12 @@ static int gfs2_unstuffer_page(struct gfs2_inode *ip, s=
truct buffer_head *dibh,
 =09=09memcpy(kaddr, dibh->b_data + sizeof(struct gfs2_dinode), dsize);
 =09=09memset(kaddr + dsize, 0, PAGE_SIZE - dsize);
 =09=09kunmap(page);
-
-=09=09SetPageUptodate(page);
 =09}
=20
 =09if (gfs2_is_jdata(ip)) {
 =09=09struct buffer_head *bh;
=20
+=09=09SetPageUptodate(page);
 =09=09if (!page_has_buffers(page))
 =09=09=09create_empty_buffers(page, BIT(inode->i_blkbits),
 =09=09=09=09=09     BIT(BH_Uptodate));
@@ -93,6 +92,9 @@ static int gfs2_unstuffer_page(struct gfs2_inode *ip, str=
uct buffer_head *dibh,
 =09=09set_buffer_uptodate(bh);
 =09=09gfs2_trans_add_data(ip->i_gl, bh);
 =09} else {
+=09=09iomap_page_create(inode, page);
+=09=09iomap_set_range_uptodate(page, 0, i_blocksize(inode));
+=09=09set_page_dirty(page);
 =09=09gfs2_ordered_add_inode(ip);
 =09}
=20
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 9d58295ccf7a..9af352ebc904 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -555,6 +555,8 @@ static vm_fault_t gfs2_page_mkwrite(struct vm_fault *vm=
f)
 out_uninit:
 =09gfs2_holder_uninit(&gh);
 =09if (ret =3D=3D 0) {
+=09=09if (!gfs2_is_jdata(ip))
+=09=09=09iomap_page_create(inode, page);
 =09=09set_page_dirty(page);
 =09=09wait_for_stable_page(page);
 =09}
--=20
2.20.1

