Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5D3248987
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 17:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgHRPR1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 11:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727992AbgHRPRX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 11:17:23 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03EFC061389;
        Tue, 18 Aug 2020 08:17:22 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k83MJ-000Ma4-5q; Tue, 18 Aug 2020 15:17:07 +0000
Date:   Tue, 18 Aug 2020 16:17:07 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v3 2/5] coredump: Let dump_emit() bail out on short writes
Message-ID: <20200818151707.GD1236603@ZenIV.linux.org.uk>
References: <20200818061239.29091-1-jannh@google.com>
 <20200818061239.29091-3-jannh@google.com>
 <20200818134027.GF29865@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818134027.GF29865@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 18, 2020 at 03:40:28PM +0200, Oleg Nesterov wrote:
> On 08/18, Jann Horn wrote:
> >
> > +	if (dump_interrupted())
> > +		return 0;
> > +	n = __kernel_write(file, addr, nr, &pos);
> > +	if (n != nr)
> > +		return 0;
> > +	file->f_pos = pos;
> 
> Just curious, can't we simply do
> 
> 	__kernel_write(file, addr, nr, &file->f_pos);
> 
> and avoid "loff_t pos" ?

	Bloody bad pattern; it would be (probably) safe in this case,
but in general ->f_pos is shared data.  Exposing it to fuckloads of
->write() instances is a bad idea - we had bugs like that.

	General rule: never pass an address of ->f_pos to anything,
and limit access to it as much as possible.
