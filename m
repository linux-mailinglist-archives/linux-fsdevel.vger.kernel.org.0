Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F57F306359
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 19:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236712AbhA0Sb2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 13:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236079AbhA0Sb0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 13:31:26 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6316C061573;
        Wed, 27 Jan 2021 10:30:45 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l4paM-006izX-MG; Wed, 27 Jan 2021 18:30:35 +0000
Date:   Wed, 27 Jan 2021 18:30:34 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Pavel Begunkov' <asml.silence@gmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iov_iter: optimise iter type checking
Message-ID: <20210127183034.GO740243@zeniv-ca>
References: <a8cdb781384791c30e30036aced4c027c5dfea86.1605969341.git.asml.silence@gmail.com>
 <6e795064-fdbd-d354-4b01-a4f7409debf5@gmail.com>
 <54cd4d1b-d7ec-a74c-8be0-e48780609d56@gmail.com>
 <20210109170359.GT3579531@ZenIV.linux.org.uk>
 <b04df39d77114547811d7bfc2c0d4c8c@AcuMS.aculab.com>
 <1783c58f-1016-0c6b-be7f-a93bc2f8f2a4@gmail.com>
 <20210116051818.GF3579531@ZenIV.linux.org.uk>
 <ed385c4d-99ca-d7aa-8874-96e3c6b743bb@gmail.com>
 <6f7ba1dbbc4749f09ae44aafc6ada284@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f7ba1dbbc4749f09ae44aafc6ada284@AcuMS.aculab.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 27, 2021 at 04:28:38PM +0000, David Laight wrote:

> I'd definitely leave the type as a bitmap.

What the hell for?  Microoptimizations in places where we have
much heavier stuff to be done are bloody pointless.

It's already overcomplicated.  And compiler is _not_ going to
be able to prove that we'll only ever have one bit set, so
you would be making it harder to optimize, not to mention
reason about.
