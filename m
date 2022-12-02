Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1BB640C95
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Dec 2022 18:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbiLBRui convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Fri, 2 Dec 2022 12:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbiLBRuh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:50:37 -0500
X-Greylist: delayed 901 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 02 Dec 2022 09:50:36 PST
Received: from SJSMAIL01.us.kioxia.com (usmailhost21.kioxia.com [12.0.68.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12167DEA79;
        Fri,  2 Dec 2022 09:50:36 -0800 (PST)
Received: from SJSMAIL01.us.kioxia.com (10.90.133.90) by
 SJSMAIL01.us.kioxia.com (10.90.133.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 2 Dec 2022 09:33:33 -0800
Received: from SJSMAIL01.us.kioxia.com ([::1]) by SJSMAIL01.us.kioxia.com
 ([fe80::f5ad:7ba5:d6cc:6f21%3]) with mapi id 15.01.2375.034; Fri, 2 Dec 2022
 09:33:33 -0800
From:   Clay Mayers <Clay.Mayers@kioxia.com>
To:     Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
CC:     Matthew Wilcox <willy@infradead.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "djwong@kernel.org" <djwong@kernel.org>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "javier@javigon.com" <javier@javigon.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
        "jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "jack@suse.com" <jack@suse.com>, "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "danil.kipnis@cloud.ionos.com" <danil.kipnis@cloud.ionos.com>,
        "ebiggers@google.com" <ebiggers@google.com>,
        "jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>
Subject: RE: [PATCH 0/6] block: add support for REQ_OP_VERIFY
Thread-Topic: [PATCH 0/6] block: add support for REQ_OP_VERIFY
Thread-Index: AQHYjGHN/dRfjWV95kG4kItzDx62xa1xpq+AgOihlACAAJ5aAIAAwrsAgACBBAD//5Rf8A==
Date:   Fri, 2 Dec 2022 17:33:33 +0000
Message-ID: <f68009b7cc744c02ad69d68fd7e61751@kioxia.com>
References: <20220630091406.19624-1-kch@nvidia.com>
 <YsXJdXnXsMtaC8DJ@casper.infradead.org>
 <d14fe396-b39b-6b3e-ae74-eb6a8b64e379@nvidia.com>
 <Y4kC9NIXevPlji+j@casper.infradead.org>
 <72a51a83-c25a-ef52-55fb-2b73aec70305@suse.de>
 <Y4oSiPH0ENFktioQ@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <Y4oSiPH0ENFktioQ@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.93.77.43]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> From: Keith Busch
> On Fri, Dec 02, 2022 at 08:16:30AM +0100, Hannes Reinecke wrote:
> > On 12/1/22 20:39, Matthew Wilcox wrote:
> > > On Thu, Dec 01, 2022 at 06:12:46PM +0000, Chaitanya Kulkarni wrote:
> > > > So nobody can get away with a lie.
> > >
> > > And yet devices do exist which lie.  I'm not surprised that vendors
> > > vehemently claim that they don't, or "nobody would get away with it".
> > > But, of course, they do.  And there's no way for us to find out if
> > > they're lying!

My guess, if true, is it's rationalized with the device is already
doing patrols in the background - why verify when it's already
been recently patrolled?
 
> > >
> > But we'll never be able to figure that out unless we try.
> >
> > Once we've tried we will have proof either way.
> 
> As long as the protocols don't provide proof-of-work, trying this
> doesn't really prove anything with respect to this concern.

I'm out of my depth here, but isn't VERIFY tightly related to PI and
at the heart of detecting SAN bit-rot? The proof of work can be via
end-to-end data protection. VERIFY has to actually read to detect bad
host generated PI guard/tags.  I'm assuming the PI checks can be
disabled for WRITE and enabled for VERIFY as the test.

