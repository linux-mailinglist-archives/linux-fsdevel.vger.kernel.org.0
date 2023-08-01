Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68EB76B88F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 17:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbjHAP0Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 11:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbjHAP0Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 11:26:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA0B2683;
        Tue,  1 Aug 2023 08:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XlwSl0KJ11sjJgplqG1VOMn72Ax8pkSOEXXg7F7nV9c=; b=1+EjHCZSdNt7AQcbUEB+fPS3is
        H9Jy3H0jo4moONZrFHW3pHDrTib81y8wbuiQjkLzd8Y8WbhRIBbQbYQEo4YnnJA21xC6+RC75Axbl
        q3t1uWqJtQ0iz0tPRCeoN1b/IG30UeHLksQQtWmS6An9XQ6A/+Y1xSvxvBtb0OW8ftsYIaXslMvy+
        quEpNsPJknNaImNWEsCOPuPK5yqRTHSzbAmwt3gFeKQYh4/oYS1J3zREXUFhQd2991AbagvQEy9Kz
        Bcqs0/M6i4D76bFhpDSArFOHFbc6j2mFiOD3MrepOeFAy/MycJy7uY3clupfgmVOSQP4NRLKnJFtX
        HtQRT5kQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qQrGC-002ing-0W;
        Tue, 01 Aug 2023 15:26:08 +0000
Date:   Tue, 1 Aug 2023 08:26:08 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        syzbot <syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com>,
        clm@fb.com, dsterba@suse.com, johannes.thumshirn@wdc.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] kernel BUG in prepare_to_merge
Message-ID: <ZMkkEEQVr1T/p/vJ@infradead.org>
References: <000000000000a3d67705ff730522@google.com>
 <000000000000f2ca8f0601bef9ca@google.com>
 <20230731073707.GA31980@lst.de>
 <358fab94-4eaa-4977-dd69-fc39810f18e0@gmx.com>
 <ZMeC6BPCBT/5NR+S@infradead.org>
 <f294c55b-3855-9ec3-c66c-a698747f22e0@gmx.com>
 <ZMju6PMnJ6tnMgfy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMju6PMnJ6tnMgfy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In the meantime I've also reproduced it with just
"btrfs: fix the btrfs_get_global_root return value", but it took
a rather long time.

After wading through the code my suspicion is that before this fix
the ERR_PTR return made that for those cases btrfs_get_root_ref and
btrfs_get_fs_root_commit_root don't actually do the
btrfs_lookup_fs_root.  Although that seemed unintentional as far
as I can tell it might have prevented some additional problems
with whatever syzcaller is fuzzing here.  Not sure if anyone who
knows this code has any good idea where to start looking?

