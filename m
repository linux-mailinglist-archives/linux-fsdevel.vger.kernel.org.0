Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49D27A50B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 19:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjIRRMW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 13:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjIRRMV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:12:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37AA93;
        Mon, 18 Sep 2023 10:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PSu733GoRVslMPSzrldgnW4DQMtvUqIFfdE6Ea7KZtw=; b=QqaOJE1v345bmLMIpNweBLn/oH
        6f2sZbZH4foXRRJpd1Zf7LnAzLpRH/IzhInYD+6NtcYsrz1QzAItN0ai8Kp/WQxNg/WWUgr42msSB
        VgtN+BZ7yUpY2eg1lxZA/nLvmd/nq3863BAiukLuaooCsrOhZcYC3P3oeJcJmHCWu6Mcj06TEwquV
        UNGOtgGoI2pNpX/b+fGYXjsL7Mr9yU/X2lwBARt0Me3S1gSS+eW8JyBpNt5/PWSJDeq5trmO1oJoI
        TMe0klFsS09bnRvKTgLllar6aE1dZDo86LPFK7KFPn6VyukqQ7xQnqXknbPM7FAOqLosyUF/yUgEo
        7vqUojPw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qiHn2-00Fxbi-2x;
        Mon, 18 Sep 2023 17:12:04 +0000
Date:   Mon, 18 Sep 2023 10:12:04 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     hch@infradead.org, djwong@kernel.org, dchinner@redhat.com,
        kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        brauner@kernel.org, hare@suse.de, ritesh.list@gmail.com,
        rgoldwyn@suse.com, jack@suse.cz, ziy@nvidia.com,
        ryan.roberts@arm.com, patches@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, p.raghav@samsung.com,
        da.gomez@samsung.com, dan.helmick@samsung.com
Subject: Re: [RFC v2 00/10] bdev: LBS devices support to coexist with
 buffer-heads
Message-ID: <ZQiE5HHTLdJOsVPq@bombadil.infradead.org>
References: <20230915213254.2724586-1-mcgrof@kernel.org>
 <ZQTR0NorkxJlcNBW@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQTR0NorkxJlcNBW@casper.infradead.org>
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

On Fri, Sep 15, 2023 at 10:51:12PM +0100, Matthew Wilcox wrote:
> On Fri, Sep 15, 2023 at 02:32:44PM -0700, Luis Chamberlain wrote:
> > However, an issue is that disabling CONFIG_BUFFER_HEAD in practice is not viable
> > for many Linux distributions since it also means disabling support for most
> > filesystems other than btrfs and XFS. So we either support larger order folios
> > on buffer-heads, or we draw up a solution to enable co-existence. Since at LSFMM
> > 2023 it was decided we would not support larger order folios on buffer-heads,
> 
> Um, I didn't agree to that.

Coverage on sunsetting buffer-heads talk by LWN:

https://lwn.net/Articles/931809/

"the apparent conclusion from the session: the buffer-head layer will be
converted to use folios internally while minimizing changes visible to
the filesystems using it. Only single-page folios will be used within
this new buffer-head layer. Any other desires, he said, can be addressed
later after this problem has been solved."

And so I think we're at the later part of this. I'm happy to see efforts
for buffer-heads support with large order folio support, and so at this
point I think it would be wise to look for commonalities and colalborate
on what things could / should be shared.

  Luis
