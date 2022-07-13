Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C139573CC5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 20:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236851AbiGMSv6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 14:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiGMSv6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 14:51:58 -0400
Received: from mail-relay152.hrz.tu-darmstadt.de (mail-relay152.hrz.tu-darmstadt.de [IPv6:2001:41b8:83f:1611::152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8599727161
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jul 2022 11:51:55 -0700 (PDT)
Received: from smtp.tu-darmstadt.de (mail-relay158.hrz.tu-darmstadt.de [130.83.252.158])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mail-relay158.hrz.tu-darmstadt.de", Issuer "DFN-Verein Global Issuing CA" (not verified))
        by mail-relay152.hrz.tu-darmstadt.de (Postfix) with ESMTPS id 4Ljmtw57Dcz43r7;
        Wed, 13 Jul 2022 20:51:52 +0200 (CEST)
Received: from [IPV6:2001:41b8:810:20:4cb5:2882:c195:9a55] (unknown [IPv6:2001:41b8:810:20:4cb5:2882:c195:9a55])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by smtp.tu-darmstadt.de (Postfix) with ESMTPSA id 4Ljmtr1Wsqz43VZ;
        Wed, 13 Jul 2022 20:51:48 +0200 (CEST)
Message-ID: <b5805118-7e56-3d43-28e9-9e0198ee43f3@tu-darmstadt.de>
Date:   Wed, 13 Jul 2022 20:51:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Reply-To: ansgar.loesser@kom.tu-darmstadt.de
Subject: [PATCH] vf/remap: return the amount of bytes actually deduplicated
To:     Linus Torvalds <torvalds@linuxfoundation.org>,
        ansgar.loesser@kom.tu-darmstadt.de
Cc:     Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>,
        Amir Goldstein <amir73il@gmail.com>,
        Mark Fasheh <mark@fasheh.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Security Officers <security@kernel.org>,
        Max Schlecht <max.schlecht@informatik.hu-berlin.de>,
        =?UTF-8?Q?Bj=c3=b6rn_Scheuermann?= 
        <scheuermann@kom.tu-darmstadt.de>
References: <a7c93559-4ba1-df2f-7a85-55a143696405@tu-darmstadt.de>
 <CAHk-=wjrOgiWfN2uWf8Ajgr4SjeWMkEJ1Sd=H6pnS_JLjJwTcQ@mail.gmail.com>
 <CAEzrpqdweuZ2ufMKDJwSzP5W021F7mgS+7toSo6VDgvDzd0ZqA@mail.gmail.com>
 <CAHk-=wgEgAjX5gRntm0NutaNtjkzN+OaJVMaJAqved4dxPtAqw@mail.gmail.com>
 <Ys3TrAf95FpRgr+P@localhost.localdomain>
 <CAHk-=wi1-o-3iF09+PnNHq6_HLQhRn+32ow_f44to7_JuNCUoA@mail.gmail.com>
 <Ys4WdKSUTcvktuEl@magnolia>
 <CAHk-=wjUw11O60KuPBpsq1-hut9-Y76puzGqvgFJr5RwUPLS_A@mail.gmail.com>
 <20220713064631.GC3600936@dread.disaster.area>
 <20220713074915.GD3600936@dread.disaster.area>
 <5548ef63-62f9-4f46-5793-03165ceccacc@tu-darmstadt.de>
 <CAHk-=wgw3mWybD3E4236sGjNdnFsR60XHKhQNe0rJW5mbhqUAA@mail.gmail.com>
From:   =?UTF-8?B?QW5zZ2FyIEzDtsOfZXI=?= <ansgar.loesser@tu-darmstadt.de>
In-Reply-To: <CAHk-=wgw3mWybD3E4236sGjNdnFsR60XHKhQNe0rJW5mbhqUAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Header-TUDa: RM4UcbWDHV7MWgIZEZYUyFSUBNFe4+21x1yw/jr0o9N4aYi0SpR3gJjhQwgY0sGvPx63WHDSLDmIhZcdRG70iF3RUFeYfObr5dz6Ye
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When using the FIDEDUPRANGE ioctl, in case of success the requested size
is returned. In some cases this might not be the actual amount of bytes
deduplicated.

This change modifies vfs_dedupe_file_range() to report the actual amount
of bytes deduplicated, instead of the requested amount.

Link: 
https://lore.kernel.org/linux-fsdevel/5548ef63-62f9-4f46-5793-03165ceccacc@tu-darmstadt.de/

Reported-by: Ansgar Lößer (ansgar.loesser@kom.tu-darmstadt.de)
Reported-by: Max Schlecht (max.schlecht@informatik.hu-berlin.de)
Reported-by: Björn Scheuermann (scheuermann@kom.tu-darmstadt.de)
Signed-off-by: Ansgar Lößer <ansgar.loesser@kom.tu-darmstadt.de>
---

> Mind sending it with a sign-off and a short commit message?
> 
>               Linus
Sure, thank you!

This is my first commit, so I hope it is ok like this.


  fs/remap_range.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/remap_range.c b/fs/remap_range.c
index e112b5424cdb..072c2c48aeed 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -546,7 +546,7 @@ int vfs_dedupe_file_range(struct file *file, struct 
file_dedupe_range *same)
                 else if (deduped < 0)
                         info->status = deduped;
                 else
-                       info->bytes_deduped = len;
+                       info->bytes_deduped = deduped;

  next_fdput:
                 fdput(dst_fd);
--
2.35.1


-- 
M.Sc. Ansgar Lößer
Fachgebiet Kommunikationsnetze
Fachbereich für Elektrotechnik und Informationstechnik
Technische Universität Darmstadt

Rundeturmstraße 10
64283 Darmstadt

E-Mail: ansgar.loesser@kom.tu-darmstadt.de
http://www.kom.tu-darmstadt.de
