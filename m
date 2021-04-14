Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2313735F61E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 16:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbhDNOZq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Apr 2021 10:25:46 -0400
Received: from 3.mo51.mail-out.ovh.net ([188.165.32.156]:46046 "EHLO
        3.mo51.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbhDNOZp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Apr 2021 10:25:45 -0400
X-Greylist: delayed 8937 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Apr 2021 10:25:44 EDT
Received: from mxplan5.mail.ovh.net (unknown [10.109.143.25])
        by mo51.mail-out.ovh.net (Postfix) with ESMTPS id EA05627E9DE;
        Wed, 14 Apr 2021 13:56:24 +0200 (CEST)
Received: from kaod.org (37.59.142.95) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 14 Apr
 2021 13:56:23 +0200
Authentication-Results: garm.ovh; auth=pass (GARM-95G0016c48b003-a9bb-4283-a696-378d1672d9bf,
                    27A2EAB91443B59947E9A6799839B739A3DEC47D) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 78.197.208.248
Date:   Wed, 14 Apr 2021 13:56:22 +0200
From:   Greg Kurz <groug@kaod.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
CC:     Vivek Goyal <vgoyal@redhat.com>,
        virtio-fs-list <virtio-fs@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Linux fsdevel mailing list <linux-fsdevel@vger.kernel.org>,
        Robert Krawitz <rkrawitz@redhat.com>
Subject: Re: Query about fuse ->sync_fs and virtiofs
Message-ID: <20210414135622.4d677fd7@bahia.lan>
In-Reply-To: <CAJfpegsaY05jSRNFTcquNFyMr+GMpPBMgoEO0YZcXxfqBi3g2A@mail.gmail.com>
References: <20210412145919.GE1184147@redhat.com>
        <CAJfpegsaY05jSRNFTcquNFyMr+GMpPBMgoEO0YZcXxfqBi3g2A@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.95]
X-ClientProxiedBy: DAG4EX1.mxp5.local (172.16.2.31) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 4820488d-0e12-4f10-b72a-d7c46fce6b16
X-Ovh-Tracer-Id: 15593713713998633254
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrudeluddggeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefuddtieejjeevheekieeltefgleetkeetheettdeifeffvefhffelffdtfeeljeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddrleehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehrkhhrrgifihhtiiesrhgvughhrghtrdgtohhm
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 12 Apr 2021 17:08:26 +0200
Miklos Szeredi <miklos@szeredi.hu> wrote:

> On Mon, Apr 12, 2021 at 4:59 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > Hi Miklos,
> >
> > Robert Krawitz drew attention to the fact that fuse does not seem to
> > have a ->sync_fs implementation. That probably means that in case of
> > virtiofs, upon sync()/syncfs(), host cache will not be written back
> > to disk. And that's not something people expect.
> >
> > I read somewhere that fuse did not implement ->sync_fs because file
> > server might not be trusted and it could block sync().
> >
> > In case of virtiofs, file server is trusted entity (w.r.t guest kernel),
> > so it probably should be ok to implement ->sync_fs atleast for virtiofs?
> 
> Yes, that looks like a good idea.
> 

I've started looking into this. First observation is that implementing
->sync_fs() is file server agnostic, so if we want this to only be used
by a trusted file server, we need to introduce such a notion in FUSE.
Not sure where though... in struct fuse_fs_context maybe ?

> Thanks,
> Miklos

