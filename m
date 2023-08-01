Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F76376B36C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 13:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbjHALj2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 07:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbjHALj1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:39:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5454B1B0;
        Tue,  1 Aug 2023 04:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=o7u7m5r6JCNVNgDwFw+iFAnr6RWeRgrboJ3NOrZzzYE=; b=xU0dreYCSJMm4RPW9+uXO9/tEB
        9lTx/NrAXpzGdN6tsjiAUayzJvQKTVoo0Zcy0kKFQ1b+/gLicXA1QmooHDDVziHEgRCv5/Q52vIFF
        YtkqKMraAbULAldTSnOAKPuzJCwe7Sd/FEYKkf8Q+jXno9eonmPKnW/4e7I1eLXIvO+NZbi603isH
        aAsd/vJD1Vix2MIFBJf07BbQtWru1RiEWrtiWgG0WSjImNitoINiSXkMZpBGEdS/n1SdM5OJWPiKT
        kfq6/nh5utIWgjHvQbLsNGndvHBZatc3sxmhEUK6x6Q71GiXSsGJRYmCKXuVvi7MXLwiO/nEt3/Wb
        fBm8xuCQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qQnii-0027DR-0N;
        Tue, 01 Aug 2023 11:39:20 +0000
Date:   Tue, 1 Aug 2023 04:39:20 -0700
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
Message-ID: <ZMju6PMnJ6tnMgfy@infradead.org>
References: <000000000000a3d67705ff730522@google.com>
 <000000000000f2ca8f0601bef9ca@google.com>
 <20230731073707.GA31980@lst.de>
 <358fab94-4eaa-4977-dd69-fc39810f18e0@gmx.com>
 <ZMeC6BPCBT/5NR+S@infradead.org>
 <f294c55b-3855-9ec3-c66c-a698747f22e0@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f294c55b-3855-9ec3-c66c-a698747f22e0@gmx.com>
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

With misc-next and your debug patch I first ran into another assert:

[  250.848976][T35903] assertion failed: 0, in fs/btrfs/relocation.c:2042
[  250.849963][T35903] ------------[ cut here ]------------
[  250.850472][T35903] kernel BUG at fs/btrfs/relocation.c:2042!

and here is the output from your assert:

[ 1378.272143][T189001] BTRFS error (device loop1): reloc tree mismatch, root 8 has no reloc root, expect reloc root key (-8, 132, 8) gen 17
[ 1378.274019][T189001] ------------[ cut here ]------------
[ 1378.274540][T189001] BTRFS: Transaction aborted (error -117)
[ 1378.277110][T189001] WARNING: CPU: 3 PID: 189001 at fs/btrfs/relocation.c:1946 prepare_to_merge+0x10e0/0x1460

