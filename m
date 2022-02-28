Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B2F4C7CB3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 23:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbiB1WCm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 17:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiB1WCl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 17:02:41 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B1EB1531;
        Mon, 28 Feb 2022 14:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l4KJCUkg1Yjaj06HRh6VufiqyjMcXsZRpHWku+HIF3Q=; b=StWT/pgYcxAEnRl+H/blc9Rn7G
        cEtFTNvDE/p9E1Td835GJzQ08k53KnSwiSzm3Dg/asCE33l+jDMC1R1YZrxlMBh4NbGuv228uR+bo
        tSQQqBBsaw2WpVcP18otoUGOYt0wyx2HCp9J7CoTYaMUkoN5UcvwXL5DQEsRJl8Hqxc6f0orbuCTM
        inTcL/2rW3LUjn8UOzaMtEqBd+24XzY+rmp6Km23v71zgB3K51+unv3nkdID6RI/FVLmrkX/5OaA6
        8t0Zirepkb693cbCu/43WqgocNKoG2poEVwzufLRDhoCYfYjFSIxFQu/YiUmjFcTiSWvqnbOPVi33
        X7iBzfZg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOo5g-00EFXc-Vv; Mon, 28 Feb 2022 22:02:00 +0000
Date:   Mon, 28 Feb 2022 14:02:00 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org,
        Steven Whitehouse <swhiteho@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        Samuel Cabrero <scabrero@suse.de>,
        David Teigland <teigland@redhat.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [LSF/MM/BPF TOPIC] are we going to use ioctls forever?
Message-ID: <Yh1GWE4aOjjkiEcC@bombadil.infradead.org>
References: <20220201013329.ofxhm4qingvddqhu@garbanzo>
 <20220201132048.i2o7quedbked7t3f@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201132048.i2o7quedbked7t3f@wittgenstein>
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

On Tue, Feb 01, 2022 at 02:20:48PM +0100, Christian Brauner wrote:
> On Mon, Jan 31, 2022 at 05:33:29PM -0800, Luis Chamberlain wrote:
> > It would seem we keep tacking on things with ioctls for the block
> > layer and filesystems. Even for new trendy things like io_uring [0].
> > For a few years I have found this odd, and have slowly started
> > asking folks why we don't consider alternatives like a generic
> > netlink family. I've at least been told that this is desirable
> > but no one has worked on it. *If* we do want this I think we just
> > not only need to commit to do this, but also provide a target. LSFMM
> > seems like a good place to do this.
> > 
> > Possible issues? Kernels without CONFIG_NET. Is that a deal breaker?
> > We already have a few filesystems with their own generic netlink
> > families, so not sure if this is a good argument against this.
> > 
> > mcgrof@fulton ~/linux-next (git::master)$ git grep genl_register_family fs
> > fs/cifs/netlink.c:      ret = genl_register_family(&cifs_genl_family);
> > fs/dlm/netlink.c:       return genl_register_family(&family);
> > fs/ksmbd/transport_ipc.c:       ret = genl_register_family(&ksmbd_genl_family);
> > fs/quota/netlink.c:     if (genl_register_family(&quota_genl_family) != 0)
> > mcgrof@fulton ~/linux-next (git::master)$ git grep genl_register_family drivers/block
> > drivers/block/nbd.c:    if (genl_register_family(&nbd_genl_family)) {
> > 
> > Are there other reasons to *not* use generic netlink for new features?
> > For folks with experience using generic netlink on the block layer and
> > their own fs, any issues or pain points observed so far?
> 
> Netlink is a giant pain to use for userspace tbh. ioctl()s aren't great
> but they are way easier to add and use.

We trade ease-of use for sloppiness. We must accept that at least.

  Luis
