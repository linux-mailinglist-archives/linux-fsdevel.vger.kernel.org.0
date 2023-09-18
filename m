Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF437A525D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 20:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjIRSwj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 14:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjIRSwi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 14:52:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87876F7
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 11:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S7YuexQXA6krhknWnYtAivbkGd0Z1JIRSNmryGVSgJs=; b=kWdjBJL7xTHvtDJDkZY23QAl0C
        jxeUL8xxLnUBiUd7sETx3RPykKEMe6yChZraAOMmzH9L6QmgElJwhjtIySQzP2xb11Qoc2v0CDTk0
        Q0jzvg4CFZsNpSof4ZAcv2Go1sR13zBFvOXJ3/xTKHBcdFPJjmkSMymWfWWzIiVhaaRJKa2kQ0zPa
        E37sZS+qImXIUv2WNBxmgMNwaqm81GlXgpFo/+o/3qln1El5nDAOD5clr6tlWAozLEI/NS3z8bZi0
        rJ1oiIqghu1QpZgb4vMQjBwCszidTC9S2O4bGmy6IWBkdYg24uBD8AhFuO3I/JN8HA2dlwRPhldQK
        tjEikLnQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qiJMF-00G6t2-36;
        Mon, 18 Sep 2023 18:52:31 +0000
Date:   Mon, 18 Sep 2023 11:52:31 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Frederick Lawler <fred@cloudflare.com>, kdevops@lists.linux.dev,
        kernel-team@cloudflare.com, linux-fsdevel@vger.kernel.org,
        Chandan Babu R <chandan.babu@oracle.com>,
        Leah Rumancik <leah.rumancik@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [RFC PATCH kdevops 0/2] augment expunge list for v6.1.53
Message-ID: <ZQicb1SyQGxlxJeL@bombadil.infradead.org>
References: <20230915234857.1613994-1-fred@cloudflare.com>
 <CAOQ4uxiGYF8EhqxM91_vrGSVYoX7dAf154btVobbsj=RUQNWAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiGYF8EhqxM91_vrGSVYoX7dAf154btVobbsj=RUQNWAQ@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 16, 2023 at 12:23:54PM +0300, Amir Goldstein wrote:
> AFAIK, we never bothered to create two different baselines from scratch in
> two different envs (e.g. libvirt and GCE/OCI) and compare them.

The experience so far has been that sparse files help find more issues
than using real drives and it is why its a default. And even if you use
a cloud solution you can use sparse files too. Only recently did I add
support to use real NVMe drive support and so to create partitions. That
should find less issues, however I did the work so to be able to test
LBS devices.

> But as it is, you already have my baseline from libvirt/kvm -
> I don't think that it makes sense to add to 6.1.y expunge lists
> failures due to test env change, unless you were able to prove that either:
> 1. Those tests did not run in my env
> 2. You env manages to expose a bug that my env did not expose
> 
> I can help with #1 by committing results from a run in my env.
> #2 is harder - you will need to analyse the failures in your env
> and understand them.

My guess so far is that the older expunges used an older version of
fstests.

  Luis
