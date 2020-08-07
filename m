Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5551123EE68
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Aug 2020 15:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgHGNn3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Aug 2020 09:43:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57023 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726198AbgHGNl7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Aug 2020 09:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596807711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u54r45ompdFXC1u4rhBBkec2eDw3it8Mdnq7sfxp85I=;
        b=HY+3ABIafsUJ7PvBXhapaqQ3l4KVg2F5piUbEnIbWGZaIjfleOgp/zptOoZA1FMhvZCrfk
        TmRkRo+4yE4znw4ef1mqbHUgw/ISOU5NlAxnrM7nlZKR8lDfuoNGzEwKd/OuZDQPsmoV+D
        NSb5Swq8Wafz9kB0IKtjTCT5iUyChK4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368--gHwb_pwPJCEf2HvDpuu3Q-1; Fri, 07 Aug 2020 09:41:28 -0400
X-MC-Unique: -gHwb_pwPJCEf2HvDpuu3Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1313058;
        Fri,  7 Aug 2020 13:41:27 +0000 (UTC)
Received: from T590 (ovpn-12-80.pek2.redhat.com [10.72.12.80])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D76AA6FEF4;
        Fri,  7 Aug 2020 13:41:19 +0000 (UTC)
Date:   Fri, 7 Aug 2020 21:41:14 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+61acc40a49a3e46e25ea@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: splice: infinite busy loop lockup bug
Message-ID: <20200807134114.GA2114050@T590>
References: <00000000000084b59f05abe928ee@google.com>
 <29de15ff-15e9-5c52-cf87-e0ebdfa1a001@I-love.SAKURA.ne.jp>
 <20200807122727.GR1236603@ZenIV.linux.org.uk>
 <20200807123854.GS1236603@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807123854.GS1236603@ZenIV.linux.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 07, 2020 at 01:38:54PM +0100, Al Viro wrote:
> On Fri, Aug 07, 2020 at 01:27:27PM +0100, Al Viro wrote:
> > On Fri, Aug 07, 2020 at 07:35:08PM +0900, Tetsuo Handa wrote:
> > > syzbot is reporting hung task at pipe_release() [1], for for_each_bvec() from
> > > iterate_bvec() from iterate_all_kinds() from iov_iter_alignment() from
> > > ext4_unaligned_io() from ext4_dio_write_iter() from ext4_file_write_iter() from
> > > call_write_iter() from do_iter_readv_writev() from do_iter_write() from
> > > vfs_iter_write() from iter_file_splice_write() falls into infinite busy loop
> > > with pipe->mutex held.
> > > 
> > > The reason of falling into infinite busy loop is that iter_file_splice_write()
> > > for some reason generates "struct bio_vec" entry with .bv_len=0 and .bv_offset=0
> > > while for_each_bvec() cannot handle .bv_len == 0.
> > 
> > broken in 1bdc76aea115 "iov_iter: use bvec iterator to implement iterate_bvec()",
> > unless I'm misreading it...
> > 
> > Zero-length segments are not disallowed; it's not all that hard to filter them
> > out in iter_file_splice_write(), but the intent had always been to have
> > iterate_all_kinds() et.al. able to cope with those.
> > 
> > How are these pipe_buffers with ->len == 0 generated in that reproducer, BTW?
> > There might be something else fishy going on...
> 
> FWIW, my preference would be to have for_each_bvec() advance past zero-length
> segments; I'll need to go through its uses elsewhere in the tree first, though
> (after I grab some sleep),

Usually block layer doesn't allow/support zero bvec, however we can make
for_each_bvec() to support it only.

Tetsuo, can you try the following patch?

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index ac0c7299d5b8..b03c793dd28d 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -117,11 +117,19 @@ static inline bool bvec_iter_advance(const struct bio_vec *bv,
 	return true;
 }
 
+static inline void bvec_iter_skip_zero_vec(const struct bio_vec *bv,
+		struct bvec_iter *iter)
+{
+	iter->bi_idx++;
+	iter->bi_bvec_done = 0;
+}
+
 #define for_each_bvec(bvl, bio_vec, iter, start)			\
 	for (iter = (start);						\
 	     (iter).bi_size &&						\
-		((bvl = bvec_iter_bvec((bio_vec), (iter))), 1);	\
-	     bvec_iter_advance((bio_vec), &(iter), (bvl).bv_len))
+		((bvl = bvec_iter_bvec((bio_vec), (iter))), 1);		\
+	  (bvl).bv_len ? bvec_iter_advance((bio_vec), &(iter), (bvl).bv_len) : \
+			bvec_iter_skip_zero_vec((bio_vec), &(iter)))
 
 /* for iterating one bio from start to end */
 #define BVEC_ITER_ALL_INIT (struct bvec_iter)				\

Thanks,
Ming

