Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C20D4B723C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 17:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241426AbiBOQRZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 11:17:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237417AbiBOQRY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:17:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8712C13DE7;
        Tue, 15 Feb 2022 08:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2Lprp52OYxepbSFWJWu9G4qQ16JCwsFWMwDdfpQfDWo=; b=GDoqi2bvTnrkNXE6SOTTJ/OkCK
        rrtJaF7L2h1xPJEE8T8ku9fDVIE3vjXQQgOtUElx/2bdCYFM9RpMt10eLJ1Slw336YCKIwO9W8iOq
        zmdtOn8duw+3ollys6tEMBFWJA60j2MpzR2QA6PH4Y0zwVM+i+J4FZZvZ2k2ty6YgnPXuBkCfKTgt
        TpBiMmk7AIQXsZaQaMPhILosPTV+P3QGJrnv3NEcKUOQOjK01S1rU6FljnCFAjgjUzZ95YsBfZ7jd
        5XdOeFnQ2QLXaADuOSyzXtPuyUkjN8C0RJ6+3IGjYt7hog6HMsQBdVN2fNVntk2oaDrtmLeGLDmnt
        R72y3muw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nK0Vr-00DzF3-4F; Tue, 15 Feb 2022 16:17:11 +0000
Date:   Tue, 15 Feb 2022 16:17:11 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Xavier Roche <xavier.roche@algolia.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: race between vfs_rename and do_linkat (mv and link)
Message-ID: <YgvSB6CKAhF5IXFj@casper.infradead.org>
References: <20220214210708.GA2167841@xavier-xps>
 <CAJfpegvVKWHhhXwOi9jDUOJi2BnYSDxZQrp1_RRrpVjjZ3Rs2w@mail.gmail.com>
 <YguspMvu6M6NJ1hL@zeniv-ca.linux.org.uk>
 <YgvPbljmJXsR7ESt@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgvPbljmJXsR7ESt@zeniv-ca.linux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 15, 2022 at 04:06:06PM +0000, Al Viro wrote:
> On Tue, Feb 15, 2022 at 01:37:40PM +0000, Al Viro wrote:
> > On Tue, Feb 15, 2022 at 10:56:29AM +0100, Miklos Szeredi wrote:
> > 
> > > Doing "lock_rename() + lookup last components" would fix this race.
>
> "Fucking ugly" is inadequate for the likely results of that approach.
> It's guaranteed to be a source of headache for pretty much ever after.
> 
> Does POSIX actually make any promises in that area?  That would affect
> how high a cost we ought to pay for that - I agree that it would be nicer
> to have atomicity from userland point of view, but there's a difference
> between hard bug and QoI issue.

As I understand the original report, it relies on us hitting the nlink ==
0 at exactly the wrong moment.  Can't we just restart the entire path
resolution if we find a target with nlink == 0?  Sure, it's a lot of
extra work, but you've got to be trying hard to hit it in the first place.
