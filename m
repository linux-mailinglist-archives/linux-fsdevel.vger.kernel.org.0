Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833DF598615
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 16:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343608AbiHROgA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 10:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343766AbiHROff (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 10:35:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978A48993B;
        Thu, 18 Aug 2022 07:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2AZvmHGmUWYRtU8m5E0Y2FaQ3RYx/t9Os+yxzS89zbE=; b=YYpNzkhXYjdFiNTAIrlJmpzhKN
        JcxrksfNkLVtWmxo0N7RP87fpxhFhmBWzqCGl5mTAE0vsM52rWb9WSKoULQ85A4os9R+TiOCNV87X
        dx+pCYenv4Vr2ecM2PrItSsmKhzZTCBx1ei8ZLfQ4lQjMQzlSexiV5osR/7dx/CRM3a66aB7tL2Q2
        7PUISYNqrkUoiTEC43ypjVhhkrOd6soKsf9VM44E7CEUS91i+m84oBOtJ8+BwbjidVFChlJy5Q/PE
        F1eID9xWyilIo7RkkhOXGwkHG+VLYTjd7hFqTaWn4B5/yzC/IvCatAl1QJ6r9Z0Xt5mstMYq4oypG
        B0GPw+xA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oOgcA-009t9W-K8; Thu, 18 Aug 2022 14:35:18 +0000
Date:   Thu, 18 Aug 2022 15:35:18 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        ceph-devel@vger.kernel.org, coda@cs.cmu.edu,
        codalist@coda.cs.cmu.edu, Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        jfs-discussion@lists.sourceforge.net, ocfs2-devel@oss.oracle.com,
        devel@lists.orangefs.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, apparmor@lists.ubuntu.com,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: Switching to iterate_shared
Message-ID: <Yv5OJuwJq17bQDXo@casper.infradead.org>
References: <YvvBs+7YUcrzwV1a@ZenIV>
 <CAHk-=wgkNwDikLfEkqLxCWR=pLi1rbPZ5eyE8FbfmXP2=r3qcw@mail.gmail.com>
 <Yvvr447B+mqbZAoe@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yvvr447B+mqbZAoe@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 16, 2022 at 08:11:31PM +0100, Matthew Wilcox wrote:
> fs/adfs/dir_f.c:        .iterate        = adfs_f_iterate,
> fs/adfs/dir_fplus.c:    .iterate        = adfs_fplus_iterate,
> 
> ADFS is read-only, so must be safe?

I just checked ADFS.  This isn't a f_ops ->iterate, this is a special
adfs_dir_ops.  ADFS already uses f_ops->iterate_shared.

