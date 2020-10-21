Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89EB6294BAA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Oct 2020 13:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441927AbgJULPM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Oct 2020 07:15:12 -0400
Received: from mx4.veeam.com ([104.41.138.86]:43548 "EHLO mx4.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410622AbgJULPJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Oct 2020 07:15:09 -0400
Received: from mail.veeam.com (spbmbx01.amust.local [172.17.17.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id EABE6897F6;
        Wed, 21 Oct 2020 14:15:04 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx4;
        t=1603278905; bh=N8h1eQSrAq99HPEtyM6BB2zVpJlELnewpRvhCbmIWg8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To:From;
        b=J7l2nPmPgQ3+NtzyjsDswFT4EL2ccUF1DN0D2J1KfzxygUgBbVhHcK0KiRQ8Q+V/6
         KC/Pd96uBtdio9IQNueanRxv1rESVaecIkV8l8ImrZxq+xWWmB4broU3y45Ul5S82q
         K2EBYYbfSJz43xB9cYDQtHeEo0RBMQiavsVAv00Q=
Received: from veeam.com (172.24.14.5) by spbmbx01.amust.local (172.17.17.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.595.3; Wed, 21 Oct 2020
 14:15:02 +0300
Date:   Wed, 21 Oct 2020 14:15:51 +0300
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
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
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "jack@suse.cz" <jack@suse.cz>, "tj@kernel.org" <tj@kernel.org>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "osandov@fb.com" <osandov@fb.com>,
        "koct9i@gmail.com" <koct9i@gmail.com>,
        "steve@sk2.org" <steve@sk2.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 2/2] blk-snap - snapshots and change-tracking for block
 devices
Message-ID: <20201021111551.GD20749@veeam.com>
References: <1603271049-20681-1-git-send-email-sergei.shtepa@veeam.com>
 <1603271049-20681-3-git-send-email-sergei.shtepa@veeam.com>
 <BL0PR04MB65142D9F391FE8777F096EF5E71C0@BL0PR04MB6514.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <BL0PR04MB65142D9F391FE8777F096EF5E71C0@BL0PR04MB6514.namprd04.prod.outlook.com>
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: spbmbx02.amust.local (172.17.17.172) To
 spbmbx01.amust.local (172.17.17.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A295605D26A677560
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> And this is a 8600+ lines patch.
> Can you split this into manageable pieces ?

Yes, the module was quite large. But I think it's not good to show
the elephant in parts. 
https://en.wikipedia.org/wiki/Blind_men_and_an_elephant

> I do not think anybody will review such a huge patch.

Yes, it will be a lot of work. But I hope that the code architecture
and splitting entities into separate files will help.

If someone can advise how to divide a module into a chain of patches,
I will be happy. I do not dare to divide it without losing meaning.

-- 
Sergei Shtepa
Veeam Software developer.
