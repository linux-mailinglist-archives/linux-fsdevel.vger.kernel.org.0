Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88647751FF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 06:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjHIEgV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 00:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjHIEgS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 00:36:18 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D911BC3
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Aug 2023 21:36:17 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-57026f4bccaso69126367b3.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Aug 2023 21:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691555776; x=1692160576;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dHla0CWZ0WHqYi4zECfU9k4rSR5m4RPnWM7U84PXzs4=;
        b=jfYt/KAwov5gjcGl3FcNqvOk5TKV42theXc90cj7+enViQ6fF9qu+PQj5ASY8WE7W3
         v+iyUH0Txp5OMV/jluSYyP1REsaSFfUc3faZnlHJsEaHZ1LpsFH4+b/KfbKvn+MrdBoq
         kQMtsan3i4QOMU14zUeISfohUjToi6NDWoUpq3tXnu5co9QbSNtkHBPD3ON2J3UHbcBS
         bfpt+qB9NthEFbsYKt5nPgUflp+NCiswQhhQSLWM0EjAHFkf0HEZphqYfnT4rpIcffWK
         LDOe8CrxbjPWtBmEx1RJW6yZPSAVfVu+TU5K0iBt3PkGu3mAS21fnhljpCNCtAifpm+j
         umcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691555776; x=1692160576;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dHla0CWZ0WHqYi4zECfU9k4rSR5m4RPnWM7U84PXzs4=;
        b=UIC6b8v1eAeJQNpi7HO9eNrNbAAPW/P2sb8uTaYQ0nT6kp291adS1wu8EPHvghGyLT
         +7AFoYG8NDzw2P5sy69t3DSrwuGAyjKTJ7qcWiwQHNldCQq/4Z0Z3i0cMFqw3iey4tDj
         cRUg35HSrdPFZYPSN2p/MZ+sQ5QeYjd8YSziYOvhNFcWRlZFnzrdsTJtPrRmjiiYjuYS
         hoMUz0f7j2w+P01dT9nqyAfBreTVT3sMw6e6jsNv6XamzUjfTAQdapq1Al96Oh6sL3nH
         lAJ+aKBy4IhAN/UmCNImr9kD3ifU0i/MP5BnSeNzItoJLKpvhcOgI5VPz8vdLAv87DxK
         GdTA==
X-Gm-Message-State: AOJu0YyPnt0BteNq5hthqNHdSbjugN1zdlBx9l64/YvtaZqckutYUQD4
        /dV8gP7/6Dx5Cx23tAuvsiLEeA==
X-Google-Smtp-Source: AGHT+IETKivu9DrTnaNoT4T/s8DpkVlW+OXa1kLEZyP5WGJw/nJ4J6ztHKF9wuaAq6Z7ieKEERVmcg==
X-Received: by 2002:a81:81c5:0:b0:583:42d3:8a18 with SMTP id r188-20020a8181c5000000b0058342d38a18mr1283732ywf.52.1691555776457;
        Tue, 08 Aug 2023 21:36:16 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id z186-20020a8189c3000000b0058390181d16sm3788417ywf.30.2023.08.08.21.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 21:36:16 -0700 (PDT)
Date:   Tue, 8 Aug 2023 21:36:12 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Christian Brauner <brauner@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oleksandr Tymoshenko <ovt@google.com>,
        Carlos Maiolino <cem@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Miklos Szeredi <miklos@szeredi.hu>, Daniel Xu <dxu@dxuuu.xyz>,
        Chris Down <chris@chrisdown.name>, Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Pete Zaitcev <zaitcev@redhat.com>,
        Helge Deller <deller@gmx.de>,
        Topi Miettinen <toiwoton@gmail.com>,
        Yu Kuai <yukuai3@huawei.com>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH vfs.tmpfs 5/5] mm: invalidation check mapping before
 folio_contains
In-Reply-To: <e92a4d33-f97-7c84-95ad-4fed8e84608c@google.com>
Message-ID: <f0b31772-78d7-f198-6482-9f25aab8c13f@google.com>
References: <e92a4d33-f97-7c84-95ad-4fed8e84608c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Enabling tmpfs "direct IO" exposes it to invalidate_inode_pages2_range(),
which when swapping can hit the VM_BUG_ON_FOLIO(!folio_contains()): the
folio has been moved from page cache to swap cache (with folio->mapping
reset to NULL), but the folio_index() embedded in folio_contains() sees
swapcache, and so returns the swapcache_index() - whereas folio->index
would be the right one to check against the index from mapping's xarray.

There are different ways to fix this, but my preference is just to order
the checks in invalidate_inode_pages2_range() the same way that they are
in __filemap_get_folio() and find_lock_entries() and filemap_fault():
check folio->mapping before folio_contains().

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/truncate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/truncate.c b/mm/truncate.c
index 95d1291d269b..c3320e66d6ea 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -657,11 +657,11 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 			}
 
 			folio_lock(folio);
-			VM_BUG_ON_FOLIO(!folio_contains(folio, indices[i]), folio);
-			if (folio->mapping != mapping) {
+			if (unlikely(folio->mapping != mapping)) {
 				folio_unlock(folio);
 				continue;
 			}
+			VM_BUG_ON_FOLIO(!folio_contains(folio, indices[i]), folio);
 			folio_wait_writeback(folio);
 
 			if (folio_mapped(folio))
-- 
2.35.3

