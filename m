Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC104D3910
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Mar 2022 19:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234895AbiCISnB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 13:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbiCISnB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 13:43:01 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAF6187E3C
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Mar 2022 10:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=s9yiD72QAE15KXlvJQBHo4L3O/HD7k5O8TzXBMjD8UU=; b=HmnkQa5M2hVLVRzlnUz2LCrnFb
        trqAqpEwKKE0BxbIQjQRrpqgqjygV0C/NF8h3jmAwIsWxiVHVQ05Pop7ICmLTk2kNoedDRAGPO/Lj
        zKCdR9i2HjhSLC5VpX4CFszDBe4+EslhT89f7+92ym/AmJ5wzyyDh4s1CnN36ZB0xBjAgcYUk35RE
        WlMHuGSRPVFmxcUaBeMrwMXSMkei2FjQ550sl/VHh/pTfs8mgu2WMxt0tMBAGUSdo0YXBegyoby8o
        c7NkUxUwu3eV6S2vopwH9R/Bi58dzIwhDD8f6vh9pOAdTU75B64qGTnp6KeP9sjlFQD7AjmrydDz0
        9q9cZOiQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nS1Fx-00A88Z-UO; Wed, 09 Mar 2022 18:41:53 +0000
Date:   Wed, 9 Mar 2022 10:41:53 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        lsf-pc <lsf-pc@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [LSF/MM TOPIC] FS, MM, and stable trees
Message-ID: <Yij08f7ee4pDZ2AC@bombadil.infradead.org>
References: <20190212170012.GF69686@sasha-vm>
 <CAOQ4uxjysufPUtwepPGNZDhoC_HdsnkHx7--kso_OXWPyPkw_A@mail.gmail.com>
 <YicrMCidylefTC3n@kroah.com>
 <YieG8rZkgnfwygyu@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YieG8rZkgnfwygyu@mit.edu>
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

On Tue, Mar 08, 2022 at 11:40:18AM -0500, Theodore Ts'o wrote:
> One of my team members has been working with Darrick to set up a set
> of xfs configs[1] recommended by Darrick, and she's stood up an
> automated test spinner using gce-xfstests which can watch a git branch
> and automatically kick off a set of tests whenever it is updated.

I think its important to note, as we would all know, that contrary to
most other subsystems, in so far as blktests and fstests is concerned,
simply passing a test once does not mean there is no issue given that
some test can fail with a failure rate of 1/1,000 for instance.

How many times you want to run a full set of fstests against a
filesystem varies depending on your filesystem, requirements and also
what resources you have. It also varies depending on how long you want
to dedicate time towards this.

To help with these concepts I ended up calling this a kernel-ci steady state
goal on kdevops:

  │ CONFIG_KERNEL_CI_STEADY_STATE_GOAL:
  │  
  │ The maximum number of possitive successes to have before bailing out
  │ a kernel-ci loop and report success. This value is currently used for
  │ all workflows. A value of 100 means 100 tests will run before we
  │ bail out and report we have achieved steady state for the workflow
  │ being tested. 

For fstests for XFS and btrfs, when testing for enterprise, I ended up going
with a steady state test goal of 500. That is, 500 consecutive runs of fstests
without any failure. This takes about 1 full week to run and one of my
eventual goals is to reduce this time. Perhaps it makes more sense to
talk generally how to optimize these sorts of tests, or share
information on experiences like these.

Do we want to define a steady state goal for stable for XFS?

  Luis
