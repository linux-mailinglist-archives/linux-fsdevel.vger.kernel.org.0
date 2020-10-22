Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D84295C27
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Oct 2020 11:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896062AbgJVJn0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Oct 2020 05:43:26 -0400
Received: from mx2.veeam.com ([64.129.123.6]:60718 "EHLO mx2.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2895914AbgJVJn0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Oct 2020 05:43:26 -0400
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id 2AB83413F2;
        Thu, 22 Oct 2020 05:43:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx2;
        t=1603359801; bh=URjUPvv4BF0KAk65rVnV3rB7ijtCMnz1I7O/6wLzuXQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To:From;
        b=oQQKDYEmamFH8Ys0kCLf7ywAyZM/wz8lHMKZxHCl8WudkvvaT2RFL89vccmfn1BCh
         BQIIafd7dyM1Xj67jFQVOk0/701HowZTS335k21tL80eefEELrNesD2rDmQIVVBM0H
         VNfsPHYwKyMOGvUNgJCnpwjvMSeRh8DnllIA7/To=
Received: from veeam.com (172.24.14.5) by prgmbx01.amust.local (172.24.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2; Thu, 22 Oct 2020
 11:43:19 +0200
Date:   Thu, 22 Oct 2020 12:44:02 +0300
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     Hannes Reinecke <hare@suse.de>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "hch@infradead.org" <hch@infradead.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "jack@suse.cz" <jack@suse.cz>, "tj@kernel.org" <tj@kernel.org>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "osandov@fb.com" <osandov@fb.com>,
        "koct9i@gmail.com" <koct9i@gmail.com>,
        "damien.lemoal@wdc.com" <damien.lemoal@wdc.com>,
        "steve@sk2.org" <steve@sk2.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 0/2] block layer filter and block device snapshot module
Message-ID: <20201022094402.GA21466@veeam.com>
References: <1603271049-20681-1-git-send-email-sergei.shtepa@veeam.com>
 <71926887-5707-04a5-78a2-ffa2ee32bd68@suse.de>
 <20201021141044.GF20749@veeam.com>
 <ca8eaa40-b422-2272-1fd9-1d0a354c42bf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca8eaa40-b422-2272-1fd9-1d0a354c42bf@suse.de>
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx01.amust.local (172.24.0.171) To prgmbx01.amust.local
 (172.24.0.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A29C604D26A677460
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The 10/22/2020 08:58, Hannes Reinecke wrote:
> On 10/21/20 4:10 PM, Sergei Shtepa wrote:
> > The 10/21/2020 16:31, Hannes Reinecke wrote:
> >> I do understand where you are coming from, but then we already have a
> >> dm-snap which does exactly what you want to achieve.
> >> Of course, that would require a reconfiguration of the storage stack on
> >> the machine, which is not always possible (or desired).
> > 
> > Yes, reconfiguring the storage stack on a machine is almost impossible.
> > 
> >>
> >> What I _could_ imagine would be a 'dm-intercept' thingie, which
> >> redirects the current submit_bio() function for any block device, and
> >> re-routes that to a linear device-mapper device pointing back to the
> >> original block device.
> >>
> >> That way you could attach it to basically any block device, _and_ can
> >> use the existing device-mapper functionality to do fancy stuff once the
> >> submit_io() callback has been re-routed.
> >>
> >> And it also would help in other scenarios, too; with such a
> >> functionality we could seamlessly clone devices without having to move
> >> the whole setup to device-mapper first.
> > 
> > Hm...
> > Did I understand correctly that the filter itself can be left approximately
> > as it is, but the blk-snap module can be replaced with 'dm-intercept',
> > which would use the re-route mechanism from the dm?
> > I think I may be able to implement it, if you describe your idea in more
> > detail.
> > 
> > 
> Actually, once we have an dm-intercept, why do you need the block-layer 
> filter at all?
>  From you initial description the block-layer filter was implemented 
> such that blk-snap could work; but if we have dm-intercept (and with it 
> the ability to use device-mapper functionality even for normal block 
> devices) there wouldn't be any need for the block-layer filter, no?

Maybe, but the problem is that I can't imagine how to implement
dm-intercept yet. 
How to use dm to implement interception without changing the stack
of block devices. We'll have to make a hook somewhere, isn`t it?

> 
> Cheers,
> 
> Hannes
> -- 
> Dr. Hannes Reinecke                Kernel Storage Architect
> hare@suse.de                              +49 911 74053 688
> SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
> HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

-- 
Sergei Shtepa
Veeam Software developer.
