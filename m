Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211DA6A89C6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 20:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjCBTwe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 14:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCBTwe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:52:34 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEE530B11;
        Thu,  2 Mar 2023 11:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9rkbBGcTOZSGthlsZfNwLzZTlKqZ5d5oAGtqyHXmTgs=; b=Zd76kEN1ty0OKus/3hTd2y0IG4
        cWuYqOo5k5Uwk97TL7KplHDnSGUYabwS2nyyxCanBxKxVmc8eX0C3r/pDKX2Jq+bdRlyWcKtr4prX
        0kNUzgN90mQG7Ou/E0bL/IFf22sMja1GC9aVRu+DQb59dPEmEKzml367ySKYCQTr/MUnpWQpUkzwd
        CevrVFvbmobvkRRKNRiCgLPJIe6hujbpCnG4HdpAeade89I55Hhi5A0ABmIwxUC7xSfbWcIRXhAJZ
        yz5MNezj7TygzSObOMRTTSL18fnkb2qt750eSRka7rC2hyDXzOdNbUFcj2QVDmEQLllbbSoAWKAmC
        13NeRsVA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXoyQ-003CGY-1t; Thu, 02 Mar 2023 19:52:18 +0000
Date:   Thu, 2 Mar 2023 11:52:18 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Meng Tang <tangmeng@uniontech.com>
Cc:     Peng Zhang <zhangpeng362@huawei.com>,
        Joel Granados <j.granados@samsung.com>, keescook@chromium.org,
        yzaikin@google.com, ebiederm@xmission.com, willy@infradead.org,
        kbuild-all@lists.01.org, nixiaoming@huawei.com,
        sujiaxun@uniontech.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] fs/proc: optimize register ctl_tables
Message-ID: <ZAD+cpbrqlc5vmry@bombadil.infradead.org>
References: <20220304112341.19528-1-tangmeng@uniontech.com>
 <202203081905.IbWENTfU-lkp@intel.com>
 <Y7xWUQQIJYLMk5fO@bombadil.infradead.org>
 <Y8iKjJYMFRSthxzn@bombadil.infradead.org>
 <Y//4B2Bw4O2umKgW@bombadil.infradead.org>
 <541B117370C84093+1a6c9c3b-20a0-cbb5-56e4-5ab0f5e42f03@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <541B117370C84093+1a6c9c3b-20a0-cbb5-56e4-5ab0f5e42f03@uniontech.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 02, 2023 at 10:45:32AM +0800, Meng Tang wrote:
> 
> On 2023/3/2 09:12, Luis Chamberlain wrot
> > 
> > I've taken the time to rebase this but I'm not a big fan of how fragile
> > it is, you can easily forget to do the proper accounting or bailing out.
> > 
> > Upon looking at all this it reminded me tons of times Eric has
> > said a few calls are just compatibility wrappers, and otherwise they are
> > deprecated. Ie, they exist just to old users but we should have new
> > users move on to the new helpers. When / if we can move the older ones
> 
> When a user registers sysctl, the entry is register_sysctl. In order to be
> compatible with the previous method, I added the following statement:
> 
> +#define register_sysctl(path, table) register_sysctl_with_num(path, table,
> ARRAY_SIZE(table))
> 
> On this basis, we can provide both register_sysctl and
> register_sysctl_with_num.

Yes, I get that, but *how* the code uses the number argument is what
gives me concern. There's just too many changes.

> > away that'd be great. Knowing that simplifies the use-cases we have to
> > address for this case too.
> 
> We need to modify the helper description information, but this does not
> affect the compatible use of the current old method and the new method now.

Yes I get that. But it can easily regress for new users if you did miss
out on doing proper accounting in a few places.

> > So I phased out completely register_sysctl_paths() and then started to
> > work on register_sysctl_table(). I didn't complete phasing out
> > register_sysctl_table() but with a bit of patience and looking at the
> > few last examples I did I think we can quickly phase it out with coccinelle.
> > Here's where I'm at:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=sysctl-testing
> > 
> > On top of that I've rebased your patches but I'm not confident in them
> > so I just put this out here in case others want to work on it:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=sysctl-testing-opt
> > 
> > What I think we should do first instead is do a non-functional change
> > which transforms all loops to list_for_each_table_entry() and then
> > we can consider using the bail out *within* the list_for_each_table_entry()
> > macro itself.
> > 
> > That would solve the first part -- the fragile odd checks to bail out
> > early.  But not the odd accounting we have to do at times. So it begs
> > the question if we can instead deprecate register_sysctl_table() and
> > then have a counter for us at all times. Also maybe an even simpler
> > alternative may just be to see to have the nr_entries be inferred with
> > ARRAY_SIZE() if count_subheaders() == 1? I haven't looked into that yet.
> > 
> 
> Do you want to know here is whether it is possible to accurately calculate
> nr_entries if entry->child is established?

Not really, if you see, when count_subheaders() == 1 it means there are
no subdirectories and just only file entries exist and so
__register_sysctl_table() is used. That code path does not recurse.

The code path with a child already is supposed to do the right thing.

The *new* code path we're dealing with is in the world where count_subheaders() == 1
but we don't even use count_subheaders() in the new code path. register_sysctl()
calls the simple path of __register_sysctl_table() too as it is implied
count_subheaders() == 1.

My point then was that for *that* case, of __register_sysctl_table(),
it already does its own accounting for number of entries with an initial
list_for_each_table_entry(). Since the list_for_each_table_entry()
always only moves forwards if its not dealing with an empty entry,
it effectively does proper accounting for the old cases.

In the new use cases we want to strive to get to a point of not having
to add an extra entry, and as you have pointed out ARRAY_SIZE() must be
used prior to having the pointer passed.

My point was rather that by deprecating the world with
count_subheaders() != 1 makes *all* code paths what we want, where we
could then just replace the first part of __register_sysctl_table()
which gets num_entries with the passed number of entries. Deprecating
the old users will take time. But it means we should keep in mind that
is the goal. Most / all code should go through these paths eventually
and we should tidy things up for it.

I was hoping we could leverage the existing use of nr_entries
computation early __register_sysctl_table() and just go with that by
modifying the list_for_each_table_entry().

The odd accounting needed today where you set 'num = register_by_num'
tons of times, perhaps just split the routine up ? Would that help
so to not have to do that?

We want to make as changes first which are non-functional, and keeping
in midn long term we *will* always use the num_entries passed as you
have done.

  Luis
