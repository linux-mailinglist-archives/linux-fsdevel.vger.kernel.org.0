Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A4D6A88A2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 19:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjCBSlt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 13:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCBSls (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 13:41:48 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722DE474E3;
        Thu,  2 Mar 2023 10:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=hPiLfsJViMkvPigBa+c5R5GSBBB8VqxwiwGlvfErL8E=; b=oVxsmRHMJOSccxsvEIq51VxFe8
        KgwXQDxvTMUvEoFZzdiLz8gPVCxCN5xEoDP3C4KhxyLLHRF2GCGL2YNcxxCse3ycgSGGJDgxEmTk0
        ulX4u7eeMvZigKvQOtYYkrhf8qXqeQ8wl0lw6A/LuhfH0RMRy1W2QSGowTPpdj83J/yPBXtiSn9jV
        3zyYFFi6cELpLM/wXKLk1m9tRcvn69tv0JkVGw9QCiyUE1BGd5Y2/hoDCb5NHUsl1U3EFCNx0qHG1
        GK58nrQ+QPGGvo+KcbY1q7gO1f29PMn5hnxSTiY2FUs+hEej3d55JMSwHuDF8TrFtsj3M/FwMBaFh
        QMcn1cAA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pXns5-00DNDu-17;
        Thu, 02 Mar 2023 18:41:41 +0000
Date:   Thu, 2 Mar 2023 18:41:41 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>, serge@hallyn.com,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if
 possible
Message-ID: <ZADt5XXXxjCRNThv@ZenIV>
References: <20230125155557.37816-1-mjguzik@gmail.com>
 <20230125155557.37816-2-mjguzik@gmail.com>
 <CAHk-=wgbm1rjkSs0w+dVJJzzK2M1No=j419c+i7T4V4ky2skOw@mail.gmail.com>
 <20230302083025.khqdizrnjkzs2lt6@wittgenstein>
 <CAHk-=wivxuLSE4ESRYv_=e8wXrD0GEjFQmUYnHKyR1iTDTeDwg@mail.gmail.com>
 <CAGudoHF9WKoKhKRHOH_yMsPnX+8Lh0fXe+y-K26mVR0gajEhaQ@mail.gmail.com>
 <ZADoeOiJs6BRLUSd@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZADoeOiJs6BRLUSd@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 02, 2023 at 06:18:32PM +0000, Al Viro wrote:
> On Thu, Mar 02, 2023 at 07:14:24PM +0100, Mateusz Guzik wrote:
> > On 3/2/23, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > > On Thu, Mar 2, 2023 at 12:30 AM Christian Brauner <brauner@kernel.org>
> > > wrote:
> > >>
> > >> Fwiw, as long as you, Al, and others are fine with it and I'm aware of
> > >> it I'm happy to pick up more stuff like this. I've done it before and
> > >> have worked in this area so I'm happy to help with some of the load.
> > >
> > > Yeah, that would work. We've actually had discussions of vfs
> > > maintenance in general.
> > >
> > > In this case it really wasn't an issue, with this being just two
> > > fairly straightforward patches for code that I was familiar with.
> > >
> > 
> > Well on that note I intend to write a patch which would add a flag to
> > the dentry cache.
> > 
> > There is this thing named CONFIG_INIT_ON_ALLOC_DEFAULT_ON which is
> > enabled at least on debian, ubuntu and arch. It results in mandatory
> > memset on the obj before it gets returned from kmalloc, for hardening
> > purposes.
> > 
> > Now the problem is that dentry cache allocates bufs 4096 bytes in
> > size, so this is an equivalent of a clear_page call and it happens
> > *every time* there is a path lookup.
> 
> Huh?  Quite a few path lookups don't end up allocating any dentries;
> what exactly are you talking about?
> 
> > Given how dentry cache is used, I'm confident there is 0 hardening
> > benefit for it.
> > 
> > So the plan would be to add a flag on cache creation to exempt it from
> > the mandatory memset treatment and use it with dentry.
> > 
> > I don't have numbers handy but as you can imagine it gave me a nice bump :)

Hmm...  Let's see what __d_alloc() will explicitly store into:
[*]	unsigned int d_flags;
[*]	seqcount_spinlock_t d_seq;
[*]	struct hlist_bl_node d_hash;
[*]	struct dentry *d_parent;
[*]	struct qstr d_name;
[*]	struct inode *d_inode;
	unsigned char d_iname[DNAME_INLINE_LEN];
[*]	struct lockref d_lockref;
[*]	const struct dentry_operations *d_op;
[*]	struct super_block *d_sb;
	unsigned long d_time;
[*]	void *d_fsdata;
	union {
[*]		struct list_head d_lru;
		wait_queue_head_t *d_wait;
	};
[*]	struct list_head d_child;
[*]	struct list_head d_subdirs;
	union {
		struct hlist_node d_alias;
		struct hlist_bl_node d_in_lookup_hash;
		struct rcu_head d_rcu;
	} d_u;

These are straightforward "overwrite no matter what".  ->d_time is not
initialized at all - it's fs-private, and unused for the majority
of filesystems (kernfs, nfs and vboxsf are the only users).
->d_alias/->d_in_lookup_hash/->d_rcu are also uninitialized - those
are valid only on some stages of dentry lifecycle (which is why
they can share space) and initialization is responsibility of
the places that do the corresponding state transitions.

->d_iname is the only somewhat delicate one.  I think we are OK as
it is (i.e. that having all of it zeroed out won't buy anything), but
that's not trivial.  Note that the last byte does need to be
initialized, despite the
        memcpy(dname, name->name, name->len);
        dname[name->len] = 0;
following it.

I'm not saying that getting rid of pre-zeroing the entire underlying
page is the wrong thing to do; it's just that it needs some analysis in
commit message.
