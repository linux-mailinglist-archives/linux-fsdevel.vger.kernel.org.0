Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139C37150E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 May 2023 23:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjE2VPA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 May 2023 17:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjE2VPA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 May 2023 17:15:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAC2C7;
        Mon, 29 May 2023 14:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kJG48zeglz+zwcfVe2MxktM9ZJFl5E0cwgaXV6z5xIM=; b=ONEhzj5JdZTyQJuynF2uQIevEf
        AnBiHFKUZN9UQWdny+k64gWn1mDGBDKjVw6yV0egQPK4KsnhmFnfTa7lt8oOoaqOxL98qYr4GiZYx
        7hhvQRyKyvY6nZtHNrlfv+RHw5A11TIIhP1uX48y1AgiEm6tTsBw2gznWPELEBEOM+b/eVUSeHLqQ
        fbwjaw7dFgXZ/2XiOWxOspMs/fwn+jIvif1yT5G5sNnRgNVrWk/+jPQdm3BxaxKyGRwnJsy6TFKaT
        fvVzzmeDD6ExByiDPxElSAw1F/fXHiUS3TiX/r3rUGsrvwbCW2cNefXac59+yWC0FWdM2TYed2PeY
        AM/wMkdw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q3kCZ-005htz-Do; Mon, 29 May 2023 21:14:51 +0000
Date:   Mon, 29 May 2023 22:14:51 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-bcachefs@vger.kernel.org, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: fuzzing bcachefs with dm-flakey
Message-ID: <ZHUVy7jut1Ex1IGJ@casper.infradead.org>
References: <alpine.LRH.2.21.2305260915400.12513@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.2305260915400.12513@file01.intranet.prod.int.rdu2.redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 29, 2023 at 04:59:40PM -0400, Mikulas Patocka wrote:
> Hi
> 
> I improved the dm-flakey device mapper target, so that it can do random 
> corruption of read and write bios - I uploaded it here: 
> https://people.redhat.com/~mpatocka/testcases/bcachefs/dm-flakey.c
> 
> I set up dm-flakey, so that it corrupts 10% of read bios and 10% of write 
> bios with this command:
> dmsetup create flakey --table "0 `blockdev --getsize /dev/ram0` flakey /dev/ram0 0 0 1 4 random_write_corrupt 100000000 random_read_corrupt 100000000"

I'm not suggesting that any of the bugs you've found are invalid, but 10%
seems really high.  Is it reasonable to expect any filesystem to cope
with that level of broken hardware?  Can any of our existing ones cope
with that level of flakiness?  I mean, I've got some pretty shoddy USB
cables, but ...

