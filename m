Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17034C7CF6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 23:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiB1WIU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 17:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbiB1WIC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 17:08:02 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F98914D253;
        Mon, 28 Feb 2022 14:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=smrhNS/om6wsmPzXTvBoObd43qZCHpJfFuiId4/X0Rg=; b=5EMgu3rwQgRki9jxonbDijowLH
        22mSxYB/u8VANHl9NESg6iH0E1+h7RkUKlToDK4pZ8X9Ev4aQ24Ur3G/cOLxA4Pzs/amCFd94MtBe
        kPPSiNldsOiFQCltiLkVzd4q3aEICyMPdvohOBN1KdJ3Y9Sndp55JDyLfF7uADbJgT0k1SyywnRdq
        bWo9EC1evHdJ06hd2CW+UpcYV3nKBJqxV5FLtu093PcktSrkdCacbjnXZC3Zyw63ggq2/vhjAObv9
        uSCKGg27Tu4Kwm4HIwGxO6xhzIEOTscIpGtR1wWQcVQgeFEByRGvpX1ylUEf0JZ6Y+EuP/AgIi/DM
        be9rdhmQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOoAk-00EGaT-FF; Mon, 28 Feb 2022 22:07:14 +0000
Date:   Mon, 28 Feb 2022 14:07:14 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org,
        Steven Whitehouse <swhiteho@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        Samuel Cabrero <scabrero@suse.de>,
        David Teigland <teigland@redhat.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [LSF/MM/BPF TOPIC] are we going to use ioctls forever?
Message-ID: <Yh1HkqZHDtnSzm+d@bombadil.infradead.org>
References: <20220201013329.ofxhm4qingvddqhu@garbanzo>
 <4de2c701-6a83-cf7f-69ba-36a921997180@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4de2c701-6a83-cf7f-69ba-36a921997180@acm.org>
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

On Wed, Feb 02, 2022 at 12:36:12PM -0800, Bart Van Assche wrote:
> On 1/31/22 17:33, Luis Chamberlain wrote:
> > It would seem we keep tacking on things with ioctls for the block
> > layer and filesystems. Even for new trendy things like io_uring [0].
> > For a few years I have found this odd, and have slowly started
> > asking folks why we don't consider alternatives like a generic
> > netlink family. I've at least been told that this is desirable
> > but no one has worked on it. *If* we do want this I think we just
> > not only need to commit to do this, but also provide a target. LSFMM
> > seems like a good place to do this.
> 
> Do we need a new netlink family for this purpose? The RDMA subsystem uses
> netlink since considerable time for configuration purposes instead of
> ioctls, sysfs or configfs. The user space tool 'rdma' supports that
> interface. That tool is used by e.g. blktests to configure the soft-RoCE and
> soft-iWARP interfaces.
> 
> See also rdma(8), available at e.g.
> https://man7.org/linux/man-pages/man8/rdma.8.html.

RDMA is netork'ish though.

But my point is not just to consider generic netlink, it's just an
example. I'm just flabbergasted we're still adding ioctls for new
random filesystem or block features.

  Luis
