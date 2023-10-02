Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459047B4AE5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 05:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235399AbjJBDWu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Oct 2023 23:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjJBDWt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Oct 2023 23:22:49 -0400
Received: from out-191.mta0.migadu.com (out-191.mta0.migadu.com [IPv6:2001:41d0:1004:224b::bf])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBBEC9
        for <linux-fsdevel@vger.kernel.org>; Sun,  1 Oct 2023 20:22:46 -0700 (PDT)
Date:   Sun, 1 Oct 2023 23:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696216963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JklXW6Z7ajflSgg9Kh9ih47eyxtCv9eOtR0Gj32NGWI=;
        b=fFCaLqAAMWQH/QRpOQ9JxdRKCdWSnR0t7DWuPHFx8mbxDlr7/dAk1mrNvBTjYQM7HMs+FQ
        Q0Jj7htwUxRj0iB46vCoQPvdomL2lLVdPkoYS2xix3IwFtRDbdbtqNEZco+V+UxChHzKRN
        a2/2B6psnFUXzoYq6y1jxtvPv25XD58=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Brian Foster <bfoster@redhat.com>,
        kernel test robot <lkp@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [linux-next:master] BUILD REGRESSION
 df964ce9ef9fea10cf131bf6bad8658fde7956f6
Message-ID: <20231002032239.t7ghpigbq5jy3ng7@moria.home.lan>
References: <202309301308.d22sJdaF-lkp@intel.com>
 <202309301403.82201B0A@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202309301403.82201B0A@keescook>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 30, 2023 at 02:56:01PM -0700, Kees Cook wrote:
> Hi Kent,
> 
> Andrew pointed this out to me, and it's a FORTIFY issue under a W=1 build:
> 
> On Sat, Sep 30, 2023 at 01:25:34PM +0800, kernel test robot wrote:
> > tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> > branch HEAD: df964ce9ef9fea10cf131bf6bad8658fde7956f6  Add linux-next specific files for 20230929
> > 
> > Error/Warning reports:
> > 
> > [...]
> > https://lore.kernel.org/oe-kbuild-all/202309192314.VBsjiIm5-lkp@intel.com
> 
>    fs/bcachefs/extents.c: In function 'bch2_bkey_append_ptr':
>    include/linux/fortify-string.h:57:33: warning: writing 8 bytes into a region of size 0 [-Wstringop-overflow=]
>       57 | #define __underlying_memcpy     __builtin_memcpy
>          |                                 ^
>    include/linux/fortify-string.h:648:9: note: in expansion of macro '__underlying_memcpy'
>      648 |         __underlying_##op(p, q, __fortify_size);                        \
>          |         ^~~~~~~~~~~~~
>    include/linux/fortify-string.h:693:26: note: in expansion of macro '__fortify_memcpy_chk'
>      693 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
>          |                          ^~~~~~~~~~~~~~~~~~~~
>    fs/bcachefs/extents.c:235:17: note: in expansion of macro 'memcpy'
>      235 |                 memcpy((void *) &k->v + bkey_val_bytes(&k->k),
>          |                 ^~~~~~
>    fs/bcachefs/bcachefs_format.h:287:33: note: destination object 'v' of size 0
>      287 |                 struct bch_val  v;
>          |                                 ^
> 
> The problem here is the struct bch_val is explicitly declared as a
> zero-sized array, so the compiler becomes unhappy. :) Converting bch_val
> to a flexible array will just kick the can down the road, since this is
> going to run into -Wflex-array-member-not-at-end soon too since bch_val
> overlaps with other structures:
> 
> struct bch_inode_v3 {
>         struct bch_val          v;
> 
>         __le64                  bi_journal_seq;
> ...
> };
> 
> As a container_of() target, this is fine -- leave it a zero-sized
> array. The problem is using it as a destination for memcpy, etc, since
> the compiler will believe it to be 0 sized. Instead, we need to impart
> a type of some kind so that the compiler can actually unambiguously
> reason about sizes. The memcpy() in the warning is targeting bch_val,
> so I think the best fix is to correctly handle the different types.
> 
> So just to have everything in front of me, here's a summary of what I'm
> seeing in the code:
> 
> struct bkey {
>         /* Size of combined key and value, in u64s */
>         __u8            u64s;
> ...
> };
> 
> /* Empty placeholder struct, for container_of() */
> struct bch_val {
>         __u64           __nothing[0];
> };
> 
> struct bkey_i {
>         __u64                   _data[0];
> 
>         struct bkey     k;
>         struct bch_val  v;
> };
> 
> static inline void bch2_bkey_append_ptr(struct bkey_i *k, struct bch_extent_ptr ptr)
> {
>         EBUG_ON(bch2_bkey_has_device(bkey_i_to_s(k), ptr.dev));
> 
>         switch (k->k.type) {
>         case KEY_TYPE_btree_ptr:
>         case KEY_TYPE_btree_ptr_v2:
>         case KEY_TYPE_extent:
>                 EBUG_ON(bkey_val_u64s(&k->k) >= BKEY_EXTENT_VAL_U64s_MAX);
> 
>                 ptr.type = 1 << BCH_EXTENT_ENTRY_ptr;
> 
>                 memcpy((void *) &k->v + bkey_val_bytes(&k->k),
>                        &ptr,
>                        sizeof(ptr));
>                 k->k.u64s++;
>                 break;
>         default:
>                 BUG();
>         }
> }
> 
> So this is appending u64s into the region that start with bkey_i. Could
> this gain a u64 flexible array?
> 
> struct bkey_i {
>         __u64                   _data[0];
> 
>         struct bkey     k;
>         struct bch_val  v;
> 	__u64		ptrs[];
> };
> 
> Then the memcpy() could be just a direct assignment:
> 
> 		k->ptrs[bkey_val_u64s(&k->k)] = (u64)ptr;
>                 k->k.u64s++;

No, that's not going to work. You're adding a field that's specific to
bch_extent (and not even correct for that) to bkey_i, the generic key;
there are many other different types of values.

> Alternatively, perhaps struct bkey could be the one to grow this flexible
> array, and then it could eventually be tracked with __counted_by (but
> not today since it expects to count the array element count, not a whole
> struct size):
> 
> struct bkey {
>         /* Size of combined key and value, in u64s */
>         __u8            u64s;
> ...
> 	__u64		data[] __counted_by(.u64s - BKEY_U64s);
> };
> 
> And bch_val could be dropped...

bch_val can't be dropped. bkey_i is different from bkey; bkey_i is a
bkey with an inline value, we also have bkey_s and bkey_s_c for a bkey
with a split value (and const variation); bch_val is in bkey_i and not
bkey because container_of to get to the value is correct for bkey_i, but
not bkey.

> Then the memcpy becomes:
> 
>                 k->k.u64s++;
>                 k->k.data[bkey_val_u64s(&k->k)] = (u64)ptr;
> 
> It just seems like there is a lot of work happening that could really
> just type casting or unions...

Honestly, I think we really just need an escape hatch. Casting to a void
pointer clearly isn't it - and this isn't the only issue I'm still
seeing with all the recent FORTIFY_SOURCE stuff, and honestly it's been
making me tear my hair out.

I'm not leaping at the chance to reorganize my fundamental data
structures for this. Can we get such an escape hatch?
