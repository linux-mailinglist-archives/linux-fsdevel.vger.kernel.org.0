Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E12467FCCA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Jan 2023 06:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjA2FE3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Jan 2023 00:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjA2FE2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Jan 2023 00:04:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490092311A
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Jan 2023 21:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=EIeb3tYigQdQQu2QAN1E4TK1fEpNoz1lwF4gQOrE3/M=; b=OVyI2nha5AZ+cpYJ/hDd9Sg1+g
        X+nseqpOR0yBlcCzkuuwMSVEXkS+A9YrtgYEppXgSdXzHUbixE08QwH//0RZ14CFrV30+tTIIz/GQ
        s1cDLM/DWIp+pV6uJ3aQzgvPJL1E+rVdbgc0/V1COxu8egGfNy23OkiyWKN9mEhdq8vtSZHBHCYlh
        AcOF6OTt1vLiaIZ0LQGQI02bKVa/HfynWuAnOjWO8ZwgBMGE1sdWw+SXOWv5f8kShPHpTxEnMnWKY
        bKa5I6Ll3IcudDne1cREd2zrka8FgJJ7Y6YdWw7sdK4AuAB5K5+fx10PhFhEVpPCaxtd6sU4Qzf9R
        i5/Bb74w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pLzrQ-0013lK-Ke; Sun, 29 Jan 2023 05:04:12 +0000
Date:   Sat, 28 Jan 2023 21:04:12 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     lsf-pc@lists.linux-foundation.org,
        Christoph Hellwig <hch@infradead.org>, djwong@kernel.org,
        song@kernel.org, rafael@kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, jack@suse.cz
Cc:     linux-fsdevel@vger.kernel.org
Subject: LSF/MM/BPF 2023 BoF: removing kthread freezer next steps
Message-ID: <Y9X+TI8Clz/hUT7r@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Probably best as a BoF:

Based on feedback from the v3 RFC it would seem we *may* be on the final stretch
from s/RFC/PATCH in removing the kthread freezer APIs from filesystems [0]. To
be clear that's not to say this is done, but just that it seems we have
some agreement towards what to do and this just needs to get baked now,
and the last part -- obviously tested.

Kthread freezing was added to *help* with the lack of the VFS layer dealing with
freezing / thawing for us. But if you look, a few subsystems make use of the
kthread freezer API now. So after we complete removal on the filesystems side of
things, does anyone see issues with just doing similar removal from other
subsystems? Or has the kthread freezer API now been embraced for other reasons
other than the original one?

[0] https://lkml.kernel.org/r/20230114003409.1168311-1-mcgrof@kernel.org

  Luis
