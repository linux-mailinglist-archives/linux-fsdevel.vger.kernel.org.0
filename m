Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 983A74AA01
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2019 20:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbfFRSfv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jun 2019 14:35:51 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50400 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729900AbfFRSfv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jun 2019 14:35:51 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hdIxQ-0000rs-JD; Tue, 18 Jun 2019 18:35:48 +0000
Date:   Tue, 18 Jun 2019 19:35:48 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Vicente Bergas <vicencb@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: d_lookup: Unable to handle kernel paging request
Message-ID: <20190618183548.GB17978@ZenIV.linux.org.uk>
References: <23950bcb-81b0-4e07-8dc8-8740eb53d7fd@gmail.com>
 <20190522135331.GM17978@ZenIV.linux.org.uk>
 <bdc8b245-afca-4662-99e2-a082f25fc927@gmail.com>
 <20190522162945.GN17978@ZenIV.linux.org.uk>
 <10192e43-c21d-44e4-915d-bf77a50c22c4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10192e43-c21d-44e4-915d-bf77a50c22c4@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 28, 2019 at 11:38:43AM +0200, Vicente Bergas wrote:
> On Wednesday, May 22, 2019 6:29:46 PM CEST, Al Viro wrote:
> > ...
> > IOW, here we have also run into bogus hlist forward pointer or head -
> > same 0x1000000 in one case and 0x0000880001000000 in two others.
> > 
> > Have you tried to see if KASAN catches anything on those loads?
> > Use-after-free, for example...  Another thing to try: slap
> > 	WARN_ON(entry->d_flags & DCACHE_NORCU);
> > in __d_rehash() and see if it triggers.
> 
> Hi Al,
> after 5 days with v5.2-rc1 + KASAN + WARN_ON could not reproduce the issue.
> Neither the first day running v5.3-rc2 + WARN_ON. But today 6 times.
> So, there is no KASAN and also the WARN_ON, being there, did not trigger.
> The first trace hapenned while untaring a big file into tmpfs. The other
> five while "git pull -r" severeal repos on f2fs.
> 
> Regards,
>  Vicenç.
> 

__d_lookup() running into &dentry->d_hash == 0x01000000 at some point in hash chain
and trying to look at ->d_name.hash:

> pc : __d_lookup+0x58/0x198
> lr : d_lookup+0x38/0x68
> sp : ffff000012663b90
> x29: ffff000012663b90 x28: ffff000012663d58 x27: 0000000000000000 x26:
> ffff8000ae7cc900 x25: 0000000000000001 x24: ffffffffffffffff x23:
> 00000000ce9c8f81 x22: 0000000000000000 x21: 0000000000000001 x20:
> ffff000012663d58 x19: 0000000001000000 x18: 0000000000000000 x17:
> 0000000000000000 x16: 0000000000000000 x15: 0000000000000000 x14:
> 0000000000000000 x13: 0000000000000000 x12: 0000000000000000 x11:
> fefefefefefefeff x10: b4fea3d0a3a4b4fe x9 : d237122a91454b69 x8 :
> a0591ae4450bed6a x7 : 5845a2c80f79d4e7 x6 : 0000000000000004 x5 :
> 0000000000000000 x4 : ffff000012663d58 x3 : ffff000010828a68 x2 :
> ffff000010828000 x1 : ffff8000f3000000 x0 : 00000000000674e4 Call trace:

__d_lookup_rcu() running into &dentry->d_hash == 0x01000000 at some point in hash
chain and trying to look at ->d_seq:

> pc : __d_lookup_rcu+0x68/0x198
> lr : lookup_fast+0x44/0x2e8
> sp : ffff0000130b3b60
> x29: ffff0000130b3b60 x28: 00000000ce99d070 x27: ffffffffffffffff x26:
> 0000000000000026 x25: ffff8000ecec6030 x24: ffff0000130b3c2c x23:
> 0000000000000006 x22: 00000026ce99d070 x21: ffff8000811f3d80 x20:
> 0000000000020000 x19: 0000000001000000 x18: 0000000000000000 x17:
> 0000000000000000 x16: 0000000000000000 x15: 0000000000000000 x14:
> 0000000000000000 x13: 0000000000000000 x12: 0000000000000000 x11:
> fefefefefefefeff x10: e4d0b2e6e2b4b6e9 x9 : 5096e90463dfacb0 x8 :
> 2b4f8961c30ebc93 x7 : aec349fb204a7256 x6 : 4fd9025392b5761a x5 :
> 02ff010101030100 x4 : ffff8000f3000000 x3 : ffff0000130b3d58 x2 :
> ffff0000130b3c2c x1 : 00000000000674ce x0 : ffff8000811f3d80 Call trace:

__d_lookup_rcu() running into &dentry->d_hash == 0x0000880001000000 at some point
in hash chain and trying to look at ->d_seq:

> pc : __d_lookup_rcu+0x68/0x198
> lr : lookup_fast+0x44/0x2e8
> sp : ffff00001325ba90
> x29: ffff00001325ba90 x28: 00000000ce99f075 x27: ffffffffffffffff x26:
> 0000000000000007 x25: ffff8000ecec402a x24: ffff00001325bb5c x23:
> 0000000000000007 x22: 00000007ce99f075 x21: ffff80007a810c00 x20:
> 0000000000000000 x19: 0000880001000000 x18: 0000000000000000 x17:
> 0000000000000000 x16: 0000000000000000 x15: 0000000000000000 x14:
> 0000000000000000 x13: 0000000000000000 x12: 0000000000000000 x11:
> fefefefefefefeff x10: d0bbbcbfa6b2b9bc x9 : 0000000000000000 x8 :
> ffff80007a810c00 x7 : 6cad9ff29d8de19c x6 : ff94ec6f0ce3656c x5 :
> ffff8000ecec402a x4 : ffff8000f3000000 x3 : ffff00001325bc78 x2 :
> ffff00001325bb5c x1 : 00000000000674cf x0 : ffff80007a810c00 Call trace:

ditto

> pc : __d_lookup_rcu+0x68/0x198
> lr : lookup_fast+0x44/0x2e8
> sp : ffff000012a3ba90
> x29: ffff000012a3ba90 x28: 00000000ce99f075 x27: ffffffffffffffff x26:
> 0000000000000007 x25: ffff8000ecec702a x24: ffff000012a3bb5c x23:
> 0000000000000007 x22: 00000007ce99f075 x21: ffff80007a810c00 x20:
> 0000000000000000 x19: 0000880001000000 x18: 0000000000000000 x17:
> 0000000000000000 x16: 0000000000000000 x15: 0000000000000000 x14:
> 0000000000000000 x13: 0000000000000000 x12: 0000000000000000 x11:
> fefefefefefefeff x10: d0bbbcbfa6b2b9bc x9 : 0000000000000000 x8 :
> ffff80007a810c00 x7 : 6cad9ff29d8de19c x6 : ff94ec6f0ce3656c x5 :
> ffff8000ecec702a x4 : ffff8000f3000000 x3 : ffff000012a3bc78 x2 :
> ffff000012a3bb5c x1 : 00000000000674cf x0 : ffff80007a810c00 Call trace:

ditto

> pc : __d_lookup_rcu+0x68/0x198
> lr : lookup_fast+0x44/0x2e8
> sp : ffff0000132bba90
> x29: ffff0000132bba90 x28: 00000000ce99e1a6 x27: ffffffffffffffff x26:
> 000000000000000c x25: ffff8000f21dd036 x24: ffff0000132bbb5c x23:
> 0000000000000004 x22: 0000000cce99e1a6 x21: ffff800074dd8d80 x20:
> 0000000000000000 x19: 0000880001000000 x18: 0000000000000000 x17:
> 0000000000000000 x16: 0000000000000000 x15: 0000000000000000 x14:
> 0000000000000000 x13: 0000000000000000 x12: 0000000000000000 x11:
> fefefefefefefeff x10: d0d0d0d0b8fea4b3 x9 : 40bcd8645005512e x8 :
> c433ade89ebd10f9 x7 : c6b69091eeb194d2 x6 : 848f758ca69635b4 x5 :
> ffff8000f21dd036 x4 : ffff8000f3000000 x3 : ffff0000132bbc78 x2 :
> ffff0000132bbb5c x1 : 00000000000674cf x0 : ffff800074dd8d80 Call trace:

... and ditto:

> pc : __d_lookup_rcu+0x68/0x198
> lr : lookup_fast+0x44/0x2e8
> sp : ffff000013263a90
> x29: ffff000013263a90 x28: 00000000ce99e1a6 x27: ffffffffffffffff x26:
> 000000000000000c x25: ffff8000f0a6f036 x24: ffff000013263b5c x23:
> 0000000000000004 x22: 0000000cce99e1a6 x21: ffff800074dd8d80 x20:
> 0000000000000000 x19: 0000880001000000 x18: 0000000000000000 x17:
> 0000000000000000 x16: 0000000000000000 x15: 0000000000000000 x14:
> 0000000000000000 x13: 0000000000000000 x12: 0000000000000000 x11:
> fefefefefefefeff x10: d0d0d0d0b8fea4b3 x9 : 40bcd8645005512e x8 :
> c433ade89ebd10f9 x7 : c6b69091eeb194d2 x6 : 848f758ca69635b4 x5 :
> ffff8000f0a6f036 x4 : ffff8000f3000000 x3 : ffff000013263c78 x2 :
> ffff000013263b5c x1 : 00000000000674cf x0 : ffff800074dd8d80 Call trace:


All of those run under rcu_read_lock() and no dentry with DCACHE_NORCU has
ever been inserted into a hash chain, so it doesn't look like a plain
use-after-free.  Could you try something like the following to see a bit
more about where it comes from?  

So far it looks like something is buggering a forward reference
in hash chain in a fairly specific way - the values seen had been
00000000010000000 and
00008800010000000.  Does that smell like anything from arm64-specific
data structures (PTE, etc.)?

Alternatively, we might've gone off rails a step (or more) before,
with the previous iteration going through bogus, but at least mapped
address - the one that has never been a dentry in the first place.


diff --git a/fs/dcache.c b/fs/dcache.c
index c435398f2c81..cb555edb5b55 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2114,6 +2114,22 @@ static inline bool d_same_name(const struct dentry *dentry,
 				       name) == 0;
 }
 
+static void dump(struct dentry *dentry)
+{
+	int i;
+	if (!dentry) {
+		printk(KERN_ERR "list fucked in head");
+		return;
+	}
+	printk(KERN_ERR "fucked dentry[%p]: d_hash.next = %p, flags = %x, count = %d",
+			dentry, dentry->d_hash.next, dentry->d_flags,
+			dentry->d_lockref.count
+			);
+	for (i = 0; i < sizeof(struct dentry); i++)
+		printk(KERN_CONT "%c%02x", i & 31 ? ' ' : '\n',
+			((unsigned char *)dentry)[i]);
+}
+
 /**
  * __d_lookup_rcu - search for a dentry (racy, store-free)
  * @parent: parent dentry
@@ -2151,7 +2167,7 @@ struct dentry *__d_lookup_rcu(const struct dentry *parent,
 	const unsigned char *str = name->name;
 	struct hlist_bl_head *b = d_hash(hashlen_hash(hashlen));
 	struct hlist_bl_node *node;
-	struct dentry *dentry;
+	struct dentry *dentry, *last = NULL;
 
 	/*
 	 * Note: There is significant duplication with __d_lookup_rcu which is
@@ -2176,6 +2192,10 @@ struct dentry *__d_lookup_rcu(const struct dentry *parent,
 	hlist_bl_for_each_entry_rcu(dentry, node, b, d_hash) {
 		unsigned seq;
 
+		if (unlikely((u32)(unsigned long)&dentry->d_hash == 0x01000000))
+			dump(last);
+		last = dentry;
+
 seqretry:
 		/*
 		 * The dentry sequence count protects us from concurrent
@@ -2274,7 +2294,7 @@ struct dentry *__d_lookup(const struct dentry *parent, const struct qstr *name)
 	struct hlist_bl_head *b = d_hash(hash);
 	struct hlist_bl_node *node;
 	struct dentry *found = NULL;
-	struct dentry *dentry;
+	struct dentry *dentry, *last = NULL;
 
 	/*
 	 * Note: There is significant duplication with __d_lookup_rcu which is
@@ -2300,6 +2320,10 @@ struct dentry *__d_lookup(const struct dentry *parent, const struct qstr *name)
 	
 	hlist_bl_for_each_entry_rcu(dentry, node, b, d_hash) {
 
+		if (unlikely((u32)(unsigned long)&dentry->d_hash == 0x01000000))
+			dump(last);
+		last = dentry;
+
 		if (dentry->d_name.hash != hash)
 			continue;
 
