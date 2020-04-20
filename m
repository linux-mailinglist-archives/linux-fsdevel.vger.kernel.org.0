Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845961B126C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 19:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgDTRBr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 13:01:47 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50135 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725784AbgDTRBr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 13:01:47 -0400
Received: from callcc.thunk.org (pool-100-0-195-244.bstnma.fios.verizon.net [100.0.195.244])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 03KH1WTK016582
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Apr 2020 13:01:33 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id CF88242013B; Mon, 20 Apr 2020 13:01:31 -0400 (EDT)
Date:   Mon, 20 Apr 2020 13:01:31 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Peter Maydell <peter.maydell@linaro.org>
Cc:     Eric Blake <eblake@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux API <linux-api@vger.kernel.org>,
        QEMU Developers <qemu-devel@nongnu.org>,
        Florian Weimer <fw@deneb.enyo.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Andy Lutomirski <luto@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] fcntl: Add 32bit filesystem mode
Message-ID: <20200420170131.GD1080594@mit.edu>
References: <20200331133536.3328-1-linus.walleij@linaro.org>
 <20200420151344.GC1080594@mit.edu>
 <d3fb73a3-ecf6-6371-783f-24a94eb66c59@redhat.com>
 <CAFEAcA9BQQah2vVfnwO4-3m4eHv9QtfvjvDpTdw+SmqicsDOMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9BQQah2vVfnwO4-3m4eHv9QtfvjvDpTdw+SmqicsDOMA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 20, 2020 at 04:29:32PM +0100, Peter Maydell wrote:
> On Mon, 20 Apr 2020 at 16:24, Eric Blake <eblake@redhat.com> wrote:
> > It will be interesting to find how much code (wrongly) assumes it can
> > use a blind assignment of fcntl(fd, F_SETFD, 1) and thereby accidentally
> > wipes out other existing flags, when it should have instead been doing a
> > read-modify-write to protect flags other than FD_CLOEXEC.
> 
> For instance, a quick grep shows 4 instances of this in QEMU :-)

Fortunately, most applications aren't going to be interested in
forcing 32-bit mode for 64-bit applications, QEMU being the notable
exception.  We do need to make sure that for 32-bit applications, we
either make FD_32BIT_MODE a no-op (don't set the bit, and ignore the
bit).  We could allow the bit to be visible for 32-bit applications,
but we would want to disallow clearing the the bit for 32-bit
applications if it was visible.

If we did that, then blind assignments of fcntl(fd, F_SETFD, 1) should
be mostly harmless with respect to the FD_32BIT_MODE bit.

   	      	 	  	       - Ted
