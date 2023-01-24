Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED106790FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 07:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjAXGcx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 01:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjAXGci (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 01:32:38 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACB83CE3D;
        Mon, 23 Jan 2023 22:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XKdXlmSYDmempiGKW+Fre8ropeI07AGnaxczrHww3+E=; b=ymc2h8TYMWI4IVsGMLYcmQ3a+E
        u/2soMhkYOrgeW0pJl+jN7J9HR4FkhWG9jj9J4XgFQ2IJsN4gUApVyVjqflL5UED13RznQiP1NI+a
        jgZxsGUlmXcPhpNzHnCm/rVRhGNR3hlqO2H7TEjLL/YF2hRsalD7crTZN/b1rM4OnNgwkXlIFkz+T
        w2s3dHlgMkzXhVb0cWg0InSMG/fgNyjbr43XDVCI1XdWz8pgVgOXHTcju+dbW+1vrqaMljJkt9Q6v
        k4B7MHxnB4VDdtEqp7CnoOrg8AxBxDMeC/6fKnT/ZJus+5UwQJb8q2kOH8XA0R83QD8GreAlRjcHl
        9LY5Nm8Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKCqk-002Vte-KD; Tue, 24 Jan 2023 06:32:06 +0000
Date:   Mon, 23 Jan 2023 22:32:06 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Keith Busch <kbusch@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: What would happen if the block device driver/firmware found some
 block of a bio is corrupted?
Message-ID: <Y897ZrBFdfLcHFma@infradead.org>
References: <5be2cd86-e535-a4ae-b989-887bf9c2c36d@gmx.com>
 <Y89iSQJEpMFBSd2G@kbusch-mbp.dhcp.thefacebook.com>
 <08def3ca-ccbd-88c7-acda-f155c1359c3b@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08def3ca-ccbd-88c7-acda-f155c1359c3b@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 24, 2023 at 01:38:41PM +0800, Qu Wenruo wrote:
> The retry for file read is indeed triggered inside VFS, not fs/block/dm
> layer itself.

Well, it's really MM code.  If ->readahead fails, we eventually fall
back to a single-page ->radpage.  That might still be more than one
sector in some cases, but at least nicely narrows down the range.
