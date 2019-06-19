Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEFB4BE10
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2019 18:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730029AbfFSQ2F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jun 2019 12:28:05 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:38566 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfFSQ2F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jun 2019 12:28:05 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hddRK-0005y4-90; Wed, 19 Jun 2019 16:28:02 +0000
Date:   Wed, 19 Jun 2019 17:28:02 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Vicente Bergas <vicencb@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: d_lookup: Unable to handle kernel paging request
Message-ID: <20190619162802.GF17978@ZenIV.linux.org.uk>
References: <23950bcb-81b0-4e07-8dc8-8740eb53d7fd@gmail.com>
 <20190522135331.GM17978@ZenIV.linux.org.uk>
 <bdc8b245-afca-4662-99e2-a082f25fc927@gmail.com>
 <20190522162945.GN17978@ZenIV.linux.org.uk>
 <10192e43-c21d-44e4-915d-bf77a50c22c4@gmail.com>
 <20190618183548.GB17978@ZenIV.linux.org.uk>
 <bf2b3aa6-bda1-43f1-9a01-e4ad3df81c0b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf2b3aa6-bda1-43f1-9a01-e4ad3df81c0b@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[arm64 maintainers Cc'd; I'm not adding a Cc to moderated list,
sorry]

On Wed, Jun 19, 2019 at 02:42:16PM +0200, Vicente Bergas wrote:

> Hi Al,
> i have been running the distro-provided kernel the last few weeks
> and had no issues at all.
> https://archlinuxarm.org/packages/aarch64/linux-aarch64
> It is from the v5.1 branch and is compiled with gcc 8.3.
> 
> IIRC, i also tested
> https://archlinuxarm.org/packages/aarch64/linux-aarch64-rc
> v5.2-rc1 and v5.2-rc2 (which at that time where compiled with
> gcc 8.2) with no issues.
> 
> This week tested v5.2-rc4 and v5.2-rc5 from archlinuxarm but
> there are regressions unrelated to d_lookup.
> 
> At this point i was convinced it was a gcc 9.1 issue and had
> nothing to do with the kernel, but anyways i gave your patch a try.
> The tested kernel is v5.2-rc5-224-gbed3c0d84e7e and
> it has been compiled with gcc 8.3.
> The sentinel you put there has triggered!
> So, it is not a gcc 9.1 issue.
> 
> In any case, i have no idea if those addresses are arm64-specific
> in any way.

Cute...  So *all* of those are in dentry_hashtable itself.  IOW, we have
these two values (1<<24 and (1<<24)|(0x88L<<40)) cropping up in
dentry_hashtable[...].first on that config.

That, at least, removes the possibility of corrupted forward pointer in
the middle of a chain, with several pointers traversed before we run
into something unmapped - the crap is in the very beginning.

I don't get it.  The only things modifying these pointers should be:

static void ___d_drop(struct dentry *dentry)
{
        struct hlist_bl_head *b;
        /*
         * Hashed dentries are normally on the dentry hashtable,
         * with the exception of those newly allocated by
         * d_obtain_root, which are always IS_ROOT:
         */
        if (unlikely(IS_ROOT(dentry)))
                b = &dentry->d_sb->s_roots;
        else   
                b = d_hash(dentry->d_name.hash);

        hlist_bl_lock(b);
        __hlist_bl_del(&dentry->d_hash);
        hlist_bl_unlock(b);
}

and

static void __d_rehash(struct dentry *entry)
{
        struct hlist_bl_head *b = d_hash(entry->d_name.hash);

        hlist_bl_lock(b);
        hlist_bl_add_head_rcu(&entry->d_hash, b);
        hlist_bl_unlock(b);
}

The latter sets that pointer to (unsigned long)&entry->d_hash | LIST_BL_LOCKMASK),
having dereferenced entry->d_hash prior to that.  It can't be the source of those
values, or we would've oopsed right there.

The former...  __hlist_bl_del() does
        /* pprev may be `first`, so be careful not to lose the lock bit */
        WRITE_ONCE(*pprev,
                   (struct hlist_bl_node *)
                        ((unsigned long)next |
                         ((unsigned long)*pprev & LIST_BL_LOCKMASK)));
        if (next)
                next->pprev = pprev;
so to end up with that garbage in the list head we'd have to had next
the same bogus pointer (modulo bit 0, possibly).  And since it's non-NULL,
we would've immediately oopsed on trying to set next->pprev.

There shouldn't be any pointers to hashtable elements other than ->d_hash.pprev
of various dentries.  And ->d_hash is not a part of anon unions in struct
dentry, so it can't be mistaken access through the aliasing member.

Of course, there's always a possibility of something stomping on random places
in memory and shitting those values all over, with the hashtable being the
hottest place on the loads where it happens...  Hell knows...

What's your config, BTW?  SMP and DEBUG_SPINLOCK, specifically...
