Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783666A78BC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 02:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjCBBNQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Mar 2023 20:13:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjCBBNO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Mar 2023 20:13:14 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6AA6E8D;
        Wed,  1 Mar 2023 17:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1zLLJNUSIPfrita6qBmhQbtBT9F7jhfSipHpHTTdjA0=; b=IARImd/855rty/UA31tNFB+wlM
        iOU+MlhzUC7XMLUfZcwU9hNmVWghqCoa4QMLocT2rO64ptdyJal83s+7fZJmhZQylpGGR1Zi6csfq
        CRuuDbEmu8cRC3CpgOwUG/b02a2rcrR36V2qxLp9urX8q/GuR/no6PRaLmyhHk+s4HWDN0wd87t8S
        5i5Fy0cHfcJBhvOF3Sx8oE33XKtn3GbkVXno9KcpShMK26SuH5UMCt6kUq1WlW532NYenkeG5sS6c
        vrrI2SfQgNUMFjVdvjIHp8DmOINwc2FsDAIQdcNCx/TAya6yVDAhyisCzt4cTWrZFq6OrICTnxFHF
        2NWQzMMQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXXUt-000QuI-7u; Thu, 02 Mar 2023 01:12:39 +0000
Date:   Wed, 1 Mar 2023 17:12:39 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Meng Tang <tangmeng@uniontech.com>,
        Peng Zhang <zhangpeng362@huawei.com>,
        Joel Granados <j.granados@samsung.com>
Cc:     keescook@chromium.org, yzaikin@google.com, ebiederm@xmission.com,
        willy@infradead.org, kbuild-all@lists.01.org,
        nixiaoming@huawei.com, nizhen@uniontech.com,
        zhanglianjie@uniontech.com, sujiaxun@uniontech.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] fs/proc: optimize register ctl_tables
Message-ID: <Y//4B2Bw4O2umKgW@bombadil.infradead.org>
References: <20220304112341.19528-1-tangmeng@uniontech.com>
 <202203081905.IbWENTfU-lkp@intel.com>
 <Y7xWUQQIJYLMk5fO@bombadil.infradead.org>
 <Y8iKjJYMFRSthxzn@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8iKjJYMFRSthxzn@bombadil.infradead.org>
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

On Wed, Jan 18, 2023 at 04:10:52PM -0800, Luis Chamberlain wrote:
> On Mon, Jan 09, 2023 at 10:00:49AM -0800, Luis Chamberlain wrote:
> > On Tue, Mar 08, 2022 at 07:22:51PM +0800, kernel test robot wrote:
> > > Hi Meng,
> > > 
> > > Thank you for the patch! Perhaps something to improve:
> > 
> > Meng, can you re-send with a fix? We're early in the merge window to
> > help test stuff now.
> 
> *re-poke* if you can't work on this please let me know!

I've taken the time to rebase this but I'm not a big fan of how fragile
it is, you can easily forget to do the proper accounting or bailing out.

Upon looking at all this it reminded me tons of times Eric has
said a few calls are just compatibility wrappers, and otherwise they are
deprecated. Ie, they exist just to old users but we should have new
users move on to the new helpers. When / if we can move the older ones
away that'd be great. Knowing that simplifies the use-cases we have to
address for this case too.

So I phased out completely register_sysctl_paths() and then started to
work on register_sysctl_table(). I didn't complete phasing out
register_sysctl_table() but with a bit of patience and looking at the
few last examples I did I think we can quickly phase it out with coccinelle.
Here's where I'm at:

https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=sysctl-testing

On top of that I've rebased your patches but I'm not confident in them
so I just put this out here in case others want to work on it:

https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=sysctl-testing-opt

What I think we should do first instead is do a non-functional change
which transforms all loops to list_for_each_table_entry() and then 
we can consider using the bail out *within* the list_for_each_table_entry()
macro itself.

That would solve the first part -- the fragile odd checks to bail out
early.  But not the odd accounting we have to do at times. So it begs
the question if we can instead deprecate register_sysctl_table() and
then have a counter for us at all times. Also maybe an even simpler
alternative may just be to see to have the nr_entries be inferred with
ARRAY_SIZE() if count_subheaders() == 1? I haven't looked into that yet.

  Luis
