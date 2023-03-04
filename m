Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2036AAB37
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Mar 2023 17:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjCDQri (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Mar 2023 11:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCDQrh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Mar 2023 11:47:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFAE1D91D;
        Sat,  4 Mar 2023 08:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LhoupYTBTqhNMehhFdXz/ehBXFuYtg+7HM1T8ayiyDA=; b=Vh+9EUwykwSYU0et0b9yjnFoNO
        3ytJOYHrsVUqNjGm4n7LbJg4RYJlZjzGkws+fFo/5J6xrNbeJBLruxzZSLq1hSDA/SHfUEYPnLqPf
        z0t2Jvbjcjjd+rMitbNjWrF+2AiqqHvuBWlmo/f1a5AoYuRL203hzKyaSwkNiJ8/SNczCU8tpPs0h
        mXJJo5FwLrov2rucArIQh1jhHOWsFLvFKejZ/m8f6Qd6l0rBF8bUiE5CIK3gcoxefn+X87xjo309z
        /8s9CTjp0luhyuyfb3+S0xO7jJheXrBrYHDpT0PR7vXYiFEsg9c9+uAoCOLX3z1pSog9RXY9Fi2Ia
        6qKyJrmQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pYV2b-003wXb-1X; Sat, 04 Mar 2023 16:47:25 +0000
Date:   Sat, 4 Mar 2023 16:47:25 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Keith Busch <kbusch@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Daniel Gomez <da.gomez@samsung.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
Message-ID: <ZAN2HYXDI+hIsf6W@casper.infradead.org>
References: <Y/7L74P6jSWwOvWt@mit.edu>
 <ZAFUYqAcPmRPLjET@kbusch-mbp.dhcp.thefacebook.com>
 <ZAFuSSZ5vZN7/UAa@casper.infradead.org>
 <ZAJqjM6qLrraFrrn@bombadil.infradead.org>
 <c9f6544d-1731-4a73-a926-0e85ae9da9df@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9f6544d-1731-4a73-a926-0e85ae9da9df@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 04, 2023 at 12:08:36PM +0100, Hannes Reinecke wrote:
> We could implement a (virtual) zoned device, and expose each zone as a
> block. That gives us the required large block characteristics, and with
> a bit of luck we might be able to dial up to really large block sizes
> like the 256M sizes on current SMR drives.
> ublk might be a good starting point.

Ummmm.  Is supporting 256MB block sizes really a desired goal?  I suggest
that is far past the knee of the curve; if we can only write 256MB chunks
as a single entity, we're looking more at a filesystem redesign than we
are at making filesystems and the MM support 256MB size blocks.

The current work is all going towards tracking memory in larger chunks,
so writing back, eg, 64kB chunks of the file.  But if 256MB is where
we're going, we need to be thinking more like a RAID device and
accumulating writes into a log that we can then blast out in a single
giant write.

fsync() and O_SYNC is going to be painful for that kind of device.
