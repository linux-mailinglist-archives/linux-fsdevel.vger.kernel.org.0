Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9EBF163C79
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 06:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgBSFXf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 00:23:35 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:36886 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgBSFXf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 00:23:35 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4HpZ-00F4vo-LP; Wed, 19 Feb 2020 05:23:29 +0000
Date:   Wed, 19 Feb 2020 05:23:29 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Qian Cai <cai@lca.pw>
Cc:     hch@infradead.org, darrick.wong@oracle.com, elver@google.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: fix a data race in i_size_write/i_size_read
Message-ID: <20200219052329.GP23230@ZenIV.linux.org.uk>
References: <20200219045228.GO23230@ZenIV.linux.org.uk>
 <EDCBB5B9-DEE4-4D4B-B2F4-F63179977D6C@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EDCBB5B9-DEE4-4D4B-B2F4-F63179977D6C@lca.pw>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 19, 2020 at 12:08:40AM -0500, Qian Cai wrote:
> 
> 
> > On Feb 18, 2020, at 11:52 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > 
> > If aligned 64bit stores on 64bit host (note the BITS_PER_LONG ifdefs) end up
> > being split, the kernel is FUBAR anyway.  Details, please - how could that
> > end up happening?
> 
> My understanding is the compiler might decide to split the load into saying two 4-byte loads. Then, we might have,
> 
> Load1
> Store
> Load2
> 
> where the load value could be a garbage. Also, Marco (the KCSAN maintainer) who knew more of compiler than me mentioned that there is no guarantee that the store will not be split either. Thus, the WRITE_ONCE().
> 

	I would suggest
* if some compiler does that, ask the persons responsible for that
"optimization" which flags should be used to disable it.
* if they fail to provide such, educate them regarding the
usefulness of their idea
* if that does not help, don't use the bloody piece of garbage.

	Again, is that pure theory (because I can't come up with
any reason why splitting a 32bit load would be any less legitimate
than doing the same to a 64bit one on a 64bit architecture),
or is there anything that really would pull that off?
