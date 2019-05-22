Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0244626842
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2019 18:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729986AbfEVQ3s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 May 2019 12:29:48 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53266 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729475AbfEVQ3s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 May 2019 12:29:48 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hTU7e-0002Ad-40; Wed, 22 May 2019 16:29:46 +0000
Date:   Wed, 22 May 2019 17:29:46 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Vicente Bergas <vicencb@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: d_lookup: Unable to handle kernel paging request
Message-ID: <20190522162945.GN17978@ZenIV.linux.org.uk>
References: <23950bcb-81b0-4e07-8dc8-8740eb53d7fd@gmail.com>
 <20190522135331.GM17978@ZenIV.linux.org.uk>
 <bdc8b245-afca-4662-99e2-a082f25fc927@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdc8b245-afca-4662-99e2-a082f25fc927@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 22, 2019 at 05:44:30PM +0200, Vicente Bergas wrote:

>    2d30:	f8617893 	ldr	x19, [x4, x1, lsl #3]
>    2d34:	f27ffa73 	ands	x19, x19, #0xfffffffffffffffe
>    2d38:	54000920 	b.eq	2e5c <__d_lookup_rcu+0x15c>  // b.none
>    2d3c:	aa0003f5 	mov	x21, x0
>    2d40:	d360feda 	lsr	x26, x22, #32
>    2d44:	a90363f7 	stp	x23, x24, [sp, #48]
>    2d48:	aa0203f8 	mov	x24, x2
>    2d4c:	d3608ad7 	ubfx	x23, x22, #32, #3
>    2d50:	a90573fb 	stp	x27, x28, [sp, #80]
>    2d54:	2a1603fc 	mov	w28, w22
>    2d58:	9280001b 	mov	x27, #0xffffffffffffffff    	// #-1
>    2d5c:	14000003 	b	2d68 <__d_lookup_rcu+0x68>
>    2d60:	f9400273 	ldr	x19, [x19]
>    2d64:	b4000793 	cbz	x19, 2e54 <__d_lookup_rcu+0x154>

OK, that looks like
	hlist_bl_for_each_entry_rcu(dentry, node, b, d_hash)
in there, x19 being 'node'.

>    2d68:	b85fc265 	ldur	w5, [x19, #-4]
>    2d6c:	d50339bf 	dmb	ishld

... and that's seq = raw_seqcount_begin(&dentry->d_seq), with
->d_seq being 4 bytes before ->d_hash.  So that one has stepped into
0x1000000 (i.e. 1<<24) in hlist forward pointer (or head - either is
possible).

> 0000000000002e98 <__d_lookup>:

>    2ed0:	f8607833 	ldr	x19, [x1, x0, lsl #3]
>    2ed4:	f27ffa73 	ands	x19, x19, #0xfffffffffffffffe
>    2ed8:	54000320 	b.eq	2f3c <__d_lookup+0xa4>  // b.none
>    2edc:	5280001b 	mov	w27, #0x0                   	// #0
>    2ee0:	92800018 	mov	x24, #0xffffffffffffffff    	// #-1
>    2ee4:	a9025bf5 	stp	x21, x22, [sp, #32]
>    2ee8:	d2800016 	mov	x22, #0x0                   	// #0
>    2eec:	52800035 	mov	w21, #0x1                   	// #1

That's
        hlist_bl_for_each_entry_rcu(dentry, node, b, d_hash) {

>    2ef0:	b9401a62 	ldr	w2, [x19, #24]

... and fetching dentry->d_name.hash for subsequent
                if (dentry->d_name.hash != hash)
                        continue;

>    2ef4:	d1002274 	sub	x20, x19, #0x8
>    2ef8:	6b17005f 	cmp	w2, w23
>    2efc:	540001a1 	b.ne	2f30 <__d_lookup+0x98>  // b.any

IOW, here we have also run into bogus hlist forward pointer or head -
same 0x1000000 in one case and 0x0000880001000000 in two others.

Have you tried to see if KASAN catches anything on those loads?
Use-after-free, for example...  Another thing to try: slap
	WARN_ON(entry->d_flags & DCACHE_NORCU);
in __d_rehash() and see if it triggers.
