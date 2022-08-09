Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593C058DE39
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Aug 2022 20:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345169AbiHISM3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Aug 2022 14:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345643AbiHISL2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Aug 2022 14:11:28 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB182AE02
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Aug 2022 11:04:40 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id mk9so9123856qvb.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Aug 2022 11:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=AGXlveyh5TLpsrDgf8RwaOkmL4JauFlDvuGk+n+yw40=;
        b=Bw5aCbEXfvJbtihUxgvA3VyPTiPCtS3n8zgsMDd9uCfu7TNSH5TyVFJLlMCD1+yk8n
         5e8mcqNs+ATfCB+Nt+MNMvjp6fMpNQMMr+o2g7R0ZsSozhdefGedt8eenTES6RvTlQTp
         T7++BbXSFQ6spJ9M3g6qez9fv9k2/k4Qh6uDaUtpMQy4PDPOX/WdKMLiTHnryo+o0QYS
         8oe+svkvRqorNF6hfoSX1xvAFvv4LBG0CvTbTfQnR6UlnIfO2nOwEo0jZ1k5vywST/zi
         fRpdqir9BRi38kGfnfRyYxEIIWhEv8PbJ9oPfNnirAzmeer8CrR/5YYYRCyiuJTX/pWE
         irIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=AGXlveyh5TLpsrDgf8RwaOkmL4JauFlDvuGk+n+yw40=;
        b=Cf7aUaBOkae29QS5+LlyHH9EtmNtvlmH3YQ/wLImD84ZVT4/d5j/CDVigL8AUv5lbm
         CbdrngfvUZWFhG3p7oOYPMCpjDlhkkdjayQwomq07NhssGN853FGO9T7qFFl8gLYTSi3
         98ukew3LdxDZR7qKxbn+kl3XjYnK0//wXQmHJkNgMnO/oLE7M6MA6REKO/WJd+O8hERG
         SImitWuu3QOaPB/bE2N9/06GeB70ys3mCRW+qqIWucRVuJ6o/5QYPsg07Pj/N+T5sKhZ
         FhPJZsEJmqLy7qeoGIG8AJCKiR0VahUyp15dpIm7gpyJ5mkasWbtl2rKz5N/tV7Dsnrl
         O29Q==
X-Gm-Message-State: ACgBeo3YPO2uPN9vn/xbY1xMnOdVJuU/kiGCm8Vm6+Qm+Ma+cBHVUNrx
        O2lcwSeYvjXw6h6oueX2FAUBk8nOvq5mtvdA
X-Google-Smtp-Source: AA6agR6Hz1qYBNR87pLiH9uIpKO/emczZkshOWvGgEmkbFeSNzCHE2/R4I+N+SVf07F3M4mrQaf9og==
X-Received: by 2002:ad4:5de6:0:b0:47b:2c2c:95a with SMTP id jn6-20020ad45de6000000b0047b2c2c095amr12755282qvb.8.1660068278154;
        Tue, 09 Aug 2022 11:04:38 -0700 (PDT)
Received: from smtpclient.apple ([2600:1700:42f0:6600:b19b:cbb5:a678:767c])
        by smtp.gmail.com with ESMTPSA id u33-20020a05622a19a100b00342e86b3bdasm8905881qtc.12.2022.08.09.11.04.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Aug 2022 11:04:36 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 2/3] hfs: Replace kmap() with kmap_local_page() in bnode.c
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <20220809152004.9223-3-fmdefrancesco@gmail.com>
Date:   Tue, 9 Aug 2022 11:04:34 -0700
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jeff Layton <jlayton@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Muchun Song <songmuchun@bytedance.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <001D72B9-CB6A-4025-99CA-B3C02E1D5E0A@dubeyko.com>
References: <20220809152004.9223-1-fmdefrancesco@gmail.com>
 <20220809152004.9223-3-fmdefrancesco@gmail.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Aug 9, 2022, at 8:20 AM, Fabio M. De Francesco =
<fmdefrancesco@gmail.com> wrote:
>=20
> kmap() is being deprecated in favor of kmap_local_page().
>=20
> Two main problems with kmap(): (1) It comes with an overhead as =
mapping
> space is restricted and protected by a global lock for synchronization =
and
> (2) it also requires global TLB invalidation when the kmap=E2=80=99s =
pool wraps
> and it might block when the mapping space is fully utilized until a =
slot
> becomes available.
>=20
> With kmap_local_page() the mappings are per thread, CPU local, can =
take
> page faults, and can be called from any context (including =
interrupts).
> It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
> the tasks can be preempted and, when they are scheduled to run again, =
the
> kernel virtual addresses are restored and still valid.
>=20
> Since its use in bnode.c is safe everywhere, it should be preferred.
>=20
> Therefore, replace kmap() with kmap_local_page() in bnode.c. Where
> possible, use the suited standard helpers (memzero_page(), =
memcpy_page())
> instead of open coding kmap_local_page() plus memset() or memcpy().
>=20
> Tested in a QEMU/KVM x86_32 VM, 6GB RAM, booting a kernel with
> HIGHMEM64GB enabled.
>=20
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---

Looks good.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.


> fs/hfs/bnode.c | 32 ++++++++++++--------------------
> 1 file changed, 12 insertions(+), 20 deletions(-)
>=20
> diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
> index c83fd0e8404d..2015e42e752a 100644
> --- a/fs/hfs/bnode.c
> +++ b/fs/hfs/bnode.c
> @@ -21,7 +21,6 @@ void hfs_bnode_read(struct hfs_bnode *node, void =
*buf, int off, int len)
> 	int pagenum;
> 	int bytes_read;
> 	int bytes_to_read;
> -	void *vaddr;
>=20
> 	off +=3D node->page_offset;
> 	pagenum =3D off >> PAGE_SHIFT;
> @@ -33,9 +32,7 @@ void hfs_bnode_read(struct hfs_bnode *node, void =
*buf, int off, int len)
> 		page =3D node->page[pagenum];
> 		bytes_to_read =3D min_t(int, len - bytes_read, PAGE_SIZE =
- off);
>=20
> -		vaddr =3D kmap_atomic(page);
> -		memcpy(buf + bytes_read, vaddr + off, bytes_to_read);
> -		kunmap_atomic(vaddr);
> +		memcpy_from_page(buf + bytes_read, page, off, =
bytes_to_read);
>=20
> 		pagenum++;
> 		off =3D 0; /* page offset only applies to the first page =
*/
> @@ -80,8 +77,7 @@ void hfs_bnode_write(struct hfs_bnode *node, void =
*buf, int off, int len)
> 	off +=3D node->page_offset;
> 	page =3D node->page[0];
>=20
> -	memcpy(kmap(page) + off, buf, len);
> -	kunmap(page);
> +	memcpy_to_page(page, off, buf, len);
> 	set_page_dirty(page);
> }
>=20
> @@ -105,8 +101,7 @@ void hfs_bnode_clear(struct hfs_bnode *node, int =
off, int len)
> 	off +=3D node->page_offset;
> 	page =3D node->page[0];
>=20
> -	memset(kmap(page) + off, 0, len);
> -	kunmap(page);
> +	memzero_page(page, off, len);
> 	set_page_dirty(page);
> }
>=20
> @@ -123,9 +118,7 @@ void hfs_bnode_copy(struct hfs_bnode *dst_node, =
int dst,
> 	src_page =3D src_node->page[0];
> 	dst_page =3D dst_node->page[0];
>=20
> -	memcpy(kmap(dst_page) + dst, kmap(src_page) + src, len);
> -	kunmap(src_page);
> -	kunmap(dst_page);
> +	memcpy_page(dst_page, dst, src_page, src, len);
> 	set_page_dirty(dst_page);
> }
>=20
> @@ -140,9 +133,9 @@ void hfs_bnode_move(struct hfs_bnode *node, int =
dst, int src, int len)
> 	src +=3D node->page_offset;
> 	dst +=3D node->page_offset;
> 	page =3D node->page[0];
> -	ptr =3D kmap(page);
> +	ptr =3D kmap_local_page(page);
> 	memmove(ptr + dst, ptr + src, len);
> -	kunmap(page);
> +	kunmap_local(ptr);
> 	set_page_dirty(page);
> }
>=20
> @@ -346,13 +339,14 @@ struct hfs_bnode *hfs_bnode_find(struct =
hfs_btree *tree, u32 num)
> 	if (!test_bit(HFS_BNODE_NEW, &node->flags))
> 		return node;
>=20
> -	desc =3D (struct hfs_bnode_desc *)(kmap(node->page[0]) + =
node->page_offset);
> +	desc =3D (struct hfs_bnode_desc =
*)(kmap_local_page(node->page[0]) +
> +					 node->page_offset);
> 	node->prev =3D be32_to_cpu(desc->prev);
> 	node->next =3D be32_to_cpu(desc->next);
> 	node->num_recs =3D be16_to_cpu(desc->num_recs);
> 	node->type =3D desc->type;
> 	node->height =3D desc->height;
> -	kunmap(node->page[0]);
> +	kunmap_local(desc);
>=20
> 	switch (node->type) {
> 	case HFS_NODE_HEADER:
> @@ -436,14 +430,12 @@ struct hfs_bnode *hfs_bnode_create(struct =
hfs_btree *tree, u32 num)
> 	}
>=20
> 	pagep =3D node->page;
> -	memset(kmap(*pagep) + node->page_offset, 0,
> -	       min((int)PAGE_SIZE, (int)tree->node_size));
> +	memzero_page(*pagep, node->page_offset,
> +		     min((int)PAGE_SIZE, (int)tree->node_size));
> 	set_page_dirty(*pagep);
> -	kunmap(*pagep);
> 	for (i =3D 1; i < tree->pages_per_bnode; i++) {
> -		memset(kmap(*++pagep), 0, PAGE_SIZE);
> +		memzero_page(*++pagep, 0, PAGE_SIZE);
> 		set_page_dirty(*pagep);
> -		kunmap(*pagep);
> 	}
> 	clear_bit(HFS_BNODE_NEW, &node->flags);
> 	wake_up(&node->lock_wq);
> --=20
> 2.37.1
>=20

