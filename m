Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9382525666C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Aug 2020 11:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgH2JXw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Aug 2020 05:23:52 -0400
Received: from verein.lst.de ([213.95.11.211]:44181 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbgH2JXv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Aug 2020 05:23:51 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2BE3968C4E; Sat, 29 Aug 2020 11:23:48 +0200 (CEST)
Date:   Sat, 29 Aug 2020 11:23:47 +0200
From:   'Christoph Hellwig' <hch@lst.de>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Christoph Hellwig' <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/10] fs: don't allow kernel reads and writes without
 iter ops
Message-ID: <20200829092347.GA8833@lst.de>
References: <20200827150030.282762-1-hch@lst.de> <20200827150030.282762-2-hch@lst.de> <e5cb22d53c7c4ebea92443b8b6d86e88@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5cb22d53c7c4ebea92443b8b6d86e88@AcuMS.aculab.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 27, 2020 at 03:58:02PM +0000, David Laight wrote:
> Is there a real justification for that?
> For system calls supplying both methods makes sense to avoid
> the extra code paths for a simple read/write.

Al asked for it as two of our four in-tree instances do have weird
semantics, and we can't change that any more.  And the other two
don't make sense to be used with kernel_read and kernel_write (
(/dev/null and /dev/zero).
