Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71839257B79
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Aug 2020 16:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgHaOqX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 10:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgHaOqC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 10:46:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA33C061575
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2020 07:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uN9Ii7LwRnIVqWqYpXM2y6R/htpHOxiLuPI7LAVAu9I=; b=HPY3lwom0COfnDdfEVj3T2j18G
        28fjOZ7uanwOWWtfZjC+485PQmb/AFejhJUQRSoe5PaRIt9xJI1VDN4SXhK3vYfPbnsekK8Pzjgti
        ZEUjIKarX6RAn6Y7IImUiUiii+Eh/Yx73V+dd9NjMxKYX/Af9EFQXaw3co7HD4rS8rm/HmeBEoVpT
        Bfj/l44EdBJjlSwanec3FiU9g1UCnbPTBs8Y29PGgmN72imu+BW7VROLG1L3KWcQ8cMPp8ERFIQyZ
        YzNOvun0fjf2kRYRc+hhwzyL59IsnaNRw50VzboV40U5TDOrXFkxBITXj1EVsZzVRruXrzjsrDK8g
        83ZYs6og==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCl4F-0005Dv-1P; Mon, 31 Aug 2020 14:45:55 +0000
Date:   Mon, 31 Aug 2020 15:45:54 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Greg Kurz <groug@kaod.org>, linux-fsdevel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: xattr names for unprivileged stacking?
Message-ID: <20200831144554.GF14765@casper.infradead.org>
References: <20200829180448.GQ1236603@ZenIV.linux.org.uk>
 <CAJfpegsn-BKVkMv4pQHG7tER31m5RSXrJyhDZ-Uzst1CMBEbEw@mail.gmail.com>
 <20200829192522.GS1236603@ZenIV.linux.org.uk>
 <CAJfpegt7a_YHd0iBjb=8hST973dQQ9czHUSNvnh-9LR_fqktTA@mail.gmail.com>
 <20200830191016.GZ14765@casper.infradead.org>
 <CAJfpegv9+o8QjQmg8EpMCm09tPy4WX1gbJiT=s15Lz8r3HQXJQ@mail.gmail.com>
 <20200831113705.GA14765@casper.infradead.org>
 <CAJfpegvqvns+PULwyaN2oaZAJZKA_SgKxqgpP=nvab2tuyX4NA@mail.gmail.com>
 <20200831132339.GD14765@casper.infradead.org>
 <20200831142532.GC4267@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831142532.GC4267@mit.edu>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 31, 2020 at 10:25:32AM -0400, Theodore Y. Ts'o wrote:
> Oh, one other question about ADS; if a file system supports reflink,
> what is supposed to happen when you reflink a file?  You have to
> consider all of the ADS's to be reflinked as well?  In some ways, this
> is good, because the overhead and complexity will probably cause most
> file system maintainers to throw up their had, say this is madness,
> and refuse to implement it.  :-)

Why is it so much harder than reflinking all the xattrs on a file?

If one thinks that Miklos' crazypants infinite hierarchy is the way to
go, then yes, this is absurdly complex.  If these are closer in spirit
to being seekable xattrs, then it looks a lot more managable.
