Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78257133BF7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 08:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgAHHDj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 02:03:39 -0500
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:16283 "EHLO
        cloud1-vm154.de-nserver.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725944AbgAHHDj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 02:03:39 -0500
X-Greylist: delayed 324 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Jan 2020 02:03:38 EST
Received: (qmail 1578 invoked from network); 8 Jan 2020 07:58:13 +0100
X-Fcrdns: No
Received: from phoffice.de-nserver.de (HELO [10.11.11.182]) (185.39.223.5)
  (smtp-auth username hostmaster@profihost.com, mechanism plain)
  by cloud1-vm154.de-nserver.de (qpsmtpd/0.92) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) ESMTPSA; Wed, 08 Jan 2020 07:58:13 +0100
X-GeoIP-Country: DE
From:   Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: slow sync performance on LSI / Broadcom MegaRaid performance with
 battery cache
To:     Ric Wheeler <rwheeler@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chinmay V S <cvs268@gmail.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Theodore Ts'o <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <matthew@wil.cx>
References: <528CA73B.9070604@profihost.ag>
 <20131120125446.GA6284@infradead.org>
 <CAK-9PRAManphkxT3ub0DfW8hx=xbq+ZeqUB0E0CEnFTfF7AQuw@mail.gmail.com>
 <528CC36A.7080003@profihost.ag>
 <CAK-9PRDyGhXPef-Vbt83Os-oowFZ2HzSZVY9PH3rSdnTwNmf2w@mail.gmail.com>
 <20131120153703.GA23160@thunk.org> <20131120155507.GA5380@fieldses.org>
 <CAK-9PRCQ6qWvzpdvK8BswpS+TfgM7NeoRaVdChFHhyDjwtUGTw@mail.gmail.com>
 <20131120175807.GC5380@fieldses.org>
 <CAK-9PRDNxHAX70cN88kRt03FkYbDB_x1cFQQYmVzqiCX=aZD6w@mail.gmail.com>
 <20131121101101.GA18404@infradead.org> <528FB828.5000301@profihost.ag>
 <528FC09E.5090004@redhat.com> <5290F386.5040806@profihost.ag>
 <5291038E.4000908@redhat.com>
Message-ID: <acf161f8-2d78-544c-7c5b-8f92be74ab50@profihost.ag>
Date:   Wed, 8 Jan 2020 07:58:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <5291038E.4000908@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-User-Auth: Auth by hostmaster@profihost.com through 185.39.223.5
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello list,

while we used adaptec controller with battery cache for years we
recently switched to dell hw using the perc controllers which are
rebranded lsi/broadcom controllers.

We're running btrfs subvolume / snapshot workloads and while those are
very fast on btrfs using a btrfs raid 0 on top of several raid 5 running
on adaptec (battery backed up) in write back mode.

The performance really sucks on those LSI controllers even the one i
have has 8GB cache instead of just 1GB at adaptec.

Especially sync / fsync are awfully slow taking sometimes 30-45 minutes
while btrfs is doing snapshots. The workload on all machines is the same
and the disks are ok.

Is there a way to disable FLUSH / sync at all for those devices? Just to
test?

I'm already using nobarrier mount option on btrfs but this does not help
either.

Thanks!

Greets,
Stefan
