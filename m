Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10A323153B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 23:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729556AbgG1Vzz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 17:55:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:60856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728149AbgG1Vzz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 17:55:55 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6375B206D4;
        Tue, 28 Jul 2020 21:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595973354;
        bh=iHwgETSwMYC9wiqhA4AumxvqL8yv08TTtqWNcMzlamY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l5YXwP19L5ctPXEi1iX/s1kox20cdAYURxF6KpqQbK6OL8B3WbykWVyTkErlUU2Vo
         Ubvm25JXVritJ23Cwg+aAHPIOva1RDwH5kFTi3I0c+gkJxvEbm1HFOntpi/yyyMdLZ
         JMAs8GZQKyw/ozzB/WKOqJ+pHwkHkw/uHnTzNqV8=
Date:   Tue, 28 Jul 2020 14:55:53 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
Subject: Re: mmotm 2020-07-27-18-18 uploaded (mm/page_alloc.c)
Message-Id: <20200728145553.2a69fa2080de01922b3a74e0@linux-foundation.org>
In-Reply-To: <ae87385b-f830-dbdf-ebc7-1afb82a7fed0@infradead.org>
References: <20200728011914.S-8vAYUK0%akpm@linux-foundation.org>
        <ae87385b-f830-dbdf-ebc7-1afb82a7fed0@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 28 Jul 2020 05:33:58 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:

> On 7/27/20 6:19 PM, Andrew Morton wrote:
> > The mm-of-the-moment snapshot 2020-07-27-18-18 has been uploaded to
> > 
> >    http://www.ozlabs.org/~akpm/mmotm/
> > 
> > mmotm-readme.txt says
> > 
> > README for mm-of-the-moment:
> > 
> > http://www.ozlabs.org/~akpm/mmotm/
> > 
> > This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> > more than once a week.
> > 
> > You will need quilt to apply these patches to the latest Linus release (5.x
> > or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> > http://ozlabs.org/~akpm/mmotm/series
> > 
> 
> on x86_64:
> 
> ../mm/page_alloc.c:8355:48: warning: ‘struct compact_control’ declared inside parameter list will not be visible outside of this definition or declaration
>  static int __alloc_contig_migrate_range(struct compact_control *cc,
>                                                 ^~~~~~~~~~~~~~~

As is usually the case with your reports, I can't figure out how to
reproduce it.  I copy then .config, run `make oldconfig' (need to hit
enter a zillion times because the .config is whacky) then the build
succeeds.  What's the secret?

Anyway,

#ifdef CONFIG_CONTIG_ALLOC

...

/* [start, end) must belong to a single zone. */
static int __alloc_contig_migrate_range(struct compact_control *cc,
					unsigned long start, unsigned long end)


and

#if defined CONFIG_COMPACTION || defined CONFIG_CMA

...

struct compact_control {


so we presumably have
	CONFIG_CONTIG_ALLOC=y
	CONFIG_COMPACTION=n
	CONFIG_CMA=n

which is indeed what's in your config file.

But

config CONTIG_ALLOC
        def_bool (MEMORY_ISOLATION && COMPACTION) || CMA

says this is an improper combination.  And `make oldconfig' fixes it up.

What's happening here?


