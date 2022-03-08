Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1E54D1C13
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Mar 2022 16:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347932AbiCHPn4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 10:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347917AbiCHPnx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:43:53 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097E2B02
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Mar 2022 07:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=76FEX8qUtLRkl7lxqw4J0imzfgnmrqEXTiC33Rmzfi8=; b=StSBb3tj7LxqSNgN9cXMEh6jhG
        cDd1oFwYlTdOQZNdGkxbI/JQhahWTfLfOc2TeoAw7v7dK96KbZM3C+EQfzGzc/2sbpINxFnbYLuXT
        IJ4M+cR6Yp20ISzgAaVPWoSzt3lJdpFR3CF3FeebixB+bCyI7c1Ra1oAUq2TSnMaHKdGZUAat317e
        dim346gf/bb1fCDLBVx/tBN2mk7xs4ZYYm821V/cnjkhxppFwdHdfvCGhxQbU7eU8H+y1JW5VhZKt
        o8newGtAe4hGXivNdv91l+2uoOcYmHy2AnaG/pzM6nChqitCuxiKkPY2faXaLgXgOdnXl07ii8LlA
        xXj83Zqw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRbz7-0050rx-RG; Tue, 08 Mar 2022 15:42:49 +0000
Date:   Tue, 8 Mar 2022 07:42:49 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        lsf-pc <lsf-pc@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Theodore Tso <tytso@mit.edu>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [LSF/MM TOPIC] FS, MM, and stable trees
Message-ID: <Yid5eU6Qas2WImGT@bombadil.infradead.org>
References: <20190212170012.GF69686@sasha-vm>
 <CAOQ4uxjysufPUtwepPGNZDhoC_HdsnkHx7--kso_OXWPyPkw_A@mail.gmail.com>
 <YicrMCidylefTC3n@kroah.com>
 <CAOQ4uxjjdFgdMxEOq7aW-nLZFf-S99CC93Ycg1CcMUBiRAYTQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjjdFgdMxEOq7aW-nLZFf-S99CC93Ycg1CcMUBiRAYTQQ@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 08, 2022 at 01:04:05PM +0200, Amir Goldstein wrote:
> On Tue, Mar 8, 2022 at 12:08 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > so go take this up with the fs developers :)
> 
> It is easy to blame the "fs developers", but is it also very hard on an
> overloaded maintainer to ALSO take care of GOOD stable tree updates.
> 
> Here is a model that seems to be working well for some subsystems:
> When a tester/developer finds a bug they write an LTP test.
> That LTP test gets run by stable kernel test bots and prompts action
> from distros who now know of this issue and may invest resources
> in backporting patches.
> 
> If I am seeing random developers reporting bugs from running xfstests
> on stable kernels and I am not seeing the stable kernel test bots reporting
> those bugs, then there may be room for improvement in the stable kernel
> testing process??

I have been investing huge amounts of time to improve this process, to
the point you can get fstests going and test against a known baseline
on kdevops [0] today with just the following 6 commands (and works with
different cloud providers, or local virtualized solutions):

make menuconfig
make
make bringup
make linux
make fstest
make fstest-baseline

The baseline is what still takes time to create, and so with that it
should in theory be possible to get the average Joe to at least help
start testing a filesystem easily. Patches welcomed.

In so far as actually getting more patches into stable for XFS, it
is just about doing the actual work of thorough review and then ensuring
it doesn't break the baseline. It does require time and effort,
but hopefully the above will help.

Do you have a series of stable candidates you'd like to review?

[0] https://github.com/mcgrof/kdevops

  Luis
