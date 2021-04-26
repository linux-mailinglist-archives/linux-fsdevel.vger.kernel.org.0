Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577B436B32C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 14:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbhDZMi2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 08:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbhDZMi2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 08:38:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5253C061574;
        Mon, 26 Apr 2021 05:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kUo++F4hwkkwY/749xSffG2WnD4gDjqWm7WhdYLsTyI=; b=ew/6BNXCyWCJmFwqXt8cRe2QyA
        1PJ3O4t+37zVM+8mTtaeBdhkL8thLSbd3MfQDy4hmi9S2NRC5ttO6M/bqboQmPSoY8pYUFa2srKDZ
        iOX2WFHrwys8wJeh4jEjqR0MwiJ0tRekjulLjI+0sZZ0IjjLsQO9XFZaOM2/68EtLW31gWWw9qT99
        QG6jn2Spoq0xCFIm6oHv92u7HWa2J1NW443HoMm5wkl1wFHCw9Tb3aqAwaiRD09BLLYKqixRThN+Q
        eHGCqI1TgMPaGhlSemnH0JJkdbOeFzYzyg6ye+ZPGUXN6JD2u7m3NvhiiVxFB5rGfmrYJv1tQoPnq
        7K7MoXGA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lb0UY-005bnt-Jl; Mon, 26 Apr 2021 12:37:41 +0000
Date:   Mon, 26 Apr 2021 13:37:34 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        krisman@collabora.com, preichl@redhat.com, kernel@collabora.com
Subject: Re: [PATCH] generic/453: Exclude filenames that are not supported by
 exfat
Message-ID: <20210426123734.GK235567@casper.infradead.org>
References: <20210425223105.1855098-1-shreeya.patel@collabora.com>
 <20210426003430.GH235567@casper.infradead.org>
 <a49ecbfb-2011-0c7c-4405-b4548d22389d@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a49ecbfb-2011-0c7c-4405-b4548d22389d@collabora.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 26, 2021 at 05:27:51PM +0530, Shreeya Patel wrote:
> On 26/04/21 6:04 am, Matthew Wilcox wrote:
> > On Mon, Apr 26, 2021 at 04:01:05AM +0530, Shreeya Patel wrote:
> > > exFAT filesystem does not support the following character codes
> > > 0x0000 - 0x001F ( Control Codes ), /, ?, :, ", \, *, <, |, >
> > ummm ...
> > 
> > > -# Fake slash?
> > > -setf "urk\xc0\xafmoo" "FAKESLASH"
> > That doesn't use any of the explained banned characters.  It uses 0xc0,
> > 0xaf.
> > 
> > Now, in utf-8, that's an nonconforming sequence.  "The Unicode and UCS
> > standards require that producers of UTF-8 shall use the shortest form
> > possible, for example, producing a two-byte sequence with first byte 0xc0
> > is nonconforming.  Unicode 3.1 has added the requirement that conforming
> > programs must not accept non-shortest forms in their input."
> > 
> > So is it that exfat is rejecting nonconforming sequences?  Or is it
> > converting the nonconforming sequence from 0xc0 0xaf to the conforming
> > sequence 0x2f, and then rejecting it (because it's '/')?
> > 
> 
> No, I don't think exfat is not converting nonconforming sequence from 0xc0
> 0xaf
> to the conforming sequence 0x2f.
> Because I get different outputs when tried with both ways.
> When I create a file with "urk\xc0\xafmoo", I get output as "Operation not
> permitted"
> and when I create it as "urk\x2fmoo", it gives "No such file or directory
> error" or
> you can consider this error as "Invalid argument"
> ( because that's what I get when I try for other characters like |, :, ?,
> etc )

I think we need to understand this before skipping the test.  Does it
also fail, eg, on cifs, vfat, jfs or udf?

> Box filename also fails with "Invalid argument" error.
> 
> 
