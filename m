Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35061778902
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 10:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjHKIep (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 04:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjHKIeo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 04:34:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E9E2737
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Aug 2023 01:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JVWgnKh9+PXhqWIsKH0WcgkkAiSjgJBKNee5LXODlP0=; b=n67q8ndCcHmWMXWtLy+yiqP8MH
        T1KwhVdwlh3l5Fyp7R2VXqWKd8deo/iZWipLbjcPjPis3UGXkqrbxkv/WVckSP9bBur1ONhXJgU3O
        Q7MekWwG+9vOUYS3h91VWc13KROlnY61aAikWWZfsRA3VNcuu9FIi9Ni3ivGXcuXHnWx0ndPkdaPp
        0ZKDK6BzwbmRcVABNmWqqXlEXuyqnEJoJkaHF6dwLnSyj3EjHsw20Ls6LNZN3ktXRLQnbl8TvIegB
        94LQZeZtytT/5QShnfNe7XSv+3fFzg97bxHa2a/pr4SIrwzq4RThQAT4NOzRCg+tKI/pSMbyT0V1z
        iBTr19AA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qUNbI-009rUj-1f;
        Fri, 11 Aug 2023 08:34:28 +0000
Date:   Fri, 11 Aug 2023 01:34:28 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleksandr Tymoshenko <ovt@google.com>,
        Carlos Maiolino <cem@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Miklos Szeredi <miklos@szeredi.hu>, Daniel Xu <dxu@dxuuu.xyz>,
        Chris Down <chris@chrisdown.name>, Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Pete Zaitcev <zaitcev@redhat.com>,
        Helge Deller <deller@gmx.de>,
        Topi Miettinen <toiwoton@gmail.com>,
        Yu Kuai <yukuai3@huawei.com>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH vfs.tmpfs 4/5] tmpfs: trivial support for direct IO
Message-ID: <ZNXylMdgmOuTbU1z@infradead.org>
References: <e92a4d33-f97-7c84-95ad-4fed8e84608c@google.com>
 <7c12819-9b94-d56-ff88-35623aa34180@google.com>
 <ZNOXfanlsgTrAsny@infradead.org>
 <20230810234124.GH11336@frogsfrogsfrogs>
 <5d913a4-a118-1218-25f2-32709b3e618@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d913a4-a118-1218-25f2-32709b3e618@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 10, 2023 at 11:16:20PM -0700, Hugh Dickins wrote:
> Helpful support, thanks.  But I didn't read Christoph as unhappy with
> the granularity issue: just giving me directIOn to FMODE_CAN_ODIRECT,
> and rightly wondering why we ever fail O_DIRECTs.

Exactly.

