Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05D3B1B0FAC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 17:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgDTPOA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 11:14:00 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:60696 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727053AbgDTPOA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 11:14:00 -0400
Received: from callcc.thunk.org (pool-100-0-195-244.bstnma.fios.verizon.net [100.0.195.244])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 03KFDigW013296
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Apr 2020 11:13:46 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 6BF1342013B; Mon, 20 Apr 2020 11:13:44 -0400 (EDT)
Date:   Mon, 20 Apr 2020 11:13:44 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, qemu-devel@nongnu.org,
        Florian Weimer <fw@deneb.enyo.de>,
        Peter Maydell <peter.maydell@linaro.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH] fcntl: Add 32bit filesystem mode
Message-ID: <20200420151344.GC1080594@mit.edu>
References: <20200331133536.3328-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331133536.3328-1-linus.walleij@linaro.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 31, 2020 at 03:35:36PM +0200, Linus Walleij wrote:
> It was brought to my attention that this bug from 2018 was
> still unresolved: 32 bit emulators like QEMU were given
> 64 bit hashes when running 32 bit emulation on 64 bit systems.
> 
> This adds a fcntl() operation to set the underlying filesystem
> into 32bit mode even if the file hanle was opened using 64bit
> mode without the compat syscalls.

s/hanle/handle/

The API that you've proposed as a way to set the 32-bit mode, but
there is no way to clear the 32-bit mode, nor there is a way to get
the current status mode.

My suggestion is to add a flag bit for F_GETFD and F_SETFD (set and
get file descriptor flags).  Currently the only file descriptor flag
is FD_CLOEXEC, so why not add a FD_32BIT_MODE bit?

Cheers,

						- Ted
