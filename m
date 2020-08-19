Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C757024970B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Aug 2020 09:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgHSHWR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Aug 2020 03:22:17 -0400
Received: from verein.lst.de ([213.95.11.211]:36479 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbgHSHWQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Aug 2020 03:22:16 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 60E246736F; Wed, 19 Aug 2020 09:22:13 +0200 (CEST)
Date:   Wed, 19 Aug 2020 09:22:13 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: iter and normal ops on /dev/zero & co, was Re: remove the last
 set_fs() in common code, and remove it for x86 and powerpc
Message-ID: <20200819072213.GA21832@lst.de>
References: <20200817073212.830069-1-hch@lst.de> <319d15b1-cb4a-a7b4-3082-12bb30eb5143@csgroup.eu> <20200818180555.GA29185@lst.de> <e3781661-2e13-4f46-d892-181907a2e768@csgroup.eu> <f2e31c89-dd9e-f0f8-ef5c-e930d01a3b65@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2e31c89-dd9e-f0f8-ef5c-e930d01a3b65@csgroup.eu>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 19, 2020 at 09:16:59AM +0200, Christophe Leroy wrote:
> I made a test with only the first patch of your series: That's definitely 
> the culprit. With only that patch applies, the duration is 6.64 seconds, 
> that's a 25% degradation.

For the record: the first patch is:

     mem: remove duplicate ops for /dev/zero and /dev/null

So these micro-optimizations matter at least for some popular
benchmarks.  It would be easy to drop, but that means we either:

 - can't support kernel_read/write on these files, which should not
   matter

or
 
 - have to drop the check for both ops being present

Al, what do you think?
