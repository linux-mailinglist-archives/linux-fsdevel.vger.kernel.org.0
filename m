Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2A1294AFF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Oct 2020 12:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441643AbgJUKAq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Oct 2020 06:00:46 -0400
Received: from mx4.veeam.com ([104.41.138.86]:42144 "EHLO mx4.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409323AbgJUKAq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Oct 2020 06:00:46 -0400
Received: from mail.veeam.com (spbmbx01.amust.local [172.17.17.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id 181608A785;
        Wed, 21 Oct 2020 13:00:43 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx4;
        t=1603274443; bh=mUDQL7MG1scyFSQ0a9pyxTVI6LvdRs8mu9vhMjIp5BA=;
        h=Date:From:To:CC:Subject:References:In-Reply-To:From;
        b=C23hn96+ZA4EBt3/VYBOTpzXQzD8tcwqS6E0abaBi/XPXMnly4pog8QybPaBZRItI
         IkAlomgIGuw5ehdil8CcHH54yyHHMyf4tHWdhoRP1oEmTn9Vm3IlcOgOT7K7o+lWSl
         RilRxDz8BpJahoGW4BtThhWSXLO1v31QNnpmnRhs=
Received: from veeam.com (172.24.14.5) by spbmbx01.amust.local (172.17.17.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.595.3; Wed, 21 Oct 2020
 13:00:39 +0300
Date:   Wed, 21 Oct 2020 13:01:26 +0300
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
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
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "jack@suse.cz" <jack@suse.cz>, "tj@kernel.org" <tj@kernel.org>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "osandov@fb.com" <osandov@fb.com>,
        "koct9i@gmail.com" <koct9i@gmail.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "steve@sk2.org" <steve@sk2.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 1/2] Block layer filter - second version
Message-ID: <20201021100126.GB20749@veeam.com>
References: <1603271049-20681-1-git-send-email-sergei.shtepa@veeam.com>
 <1603271049-20681-2-git-send-email-sergei.shtepa@veeam.com>
 <SN4PR0401MB3598185077055334ADE1BB159B1C0@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB3598185077055334ADE1BB159B1C0@SN4PR0401MB3598.namprd04.prod.outlook.com>
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: spbmbx02.amust.local (172.17.17.172) To
 spbmbx01.amust.local (172.17.17.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A295605D26A677560
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The 10/21/2020 12:14, Johannes Thumshirn wrote:
> On 21/10/2020 11:04, Sergei Shtepa wrote:
> > +	help
> > +	  Enabling this lets third-party kernel modules intercept
> > +	  bio requests for any block device. This allows them to implement
> 
> The "third-party kernel modules" part sounds a bit worrisome to me. Especially
> as this functionality is based on EXPORT_SYMBOL()s without the GPL suffix.
> 
> I read it as a "allow a proprietary module to mess with bios", which is a big 
> no-no to me.
> 
> Not providing any sort of changelog doesn't help much either.
> 
> Thanks,
> 	Johannes
> 

I think the words "third-party" are is not necessary.
In my opinion, creating proprietary kernel modules for Linux is an empty idea.

EXPORT_SYMBOL() -> EXPORT_SYMBOL_GPL() - no problem.

-- 
Sergei Shtepa
Veeam Software developer.
