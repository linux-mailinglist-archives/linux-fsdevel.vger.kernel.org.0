Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9626498F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Dec 2022 07:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbiLLGab (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Dec 2022 01:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiLLGaa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Dec 2022 01:30:30 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E07B1EA;
        Sun, 11 Dec 2022 22:30:28 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 70C1268AA6; Mon, 12 Dec 2022 07:30:18 +0100 (CET)
Date:   Mon, 12 Dec 2022 07:30:17 +0100
From:   "hch@lst.de" <hch@lst.de>
To:     Carlos Carvalho <carlos@fisica.ufpr.br>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Clay Mayers <Clay.Mayers@kioxia.com>,
        Keith Busch <kbusch@kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "djwong@kernel.org" <djwong@kernel.org>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
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
Subject: Re: [PATCH 0/6] block: add support for REQ_OP_VERIFY
Message-ID: <20221212063017.GA9290@lst.de>
References: <20220630091406.19624-1-kch@nvidia.com> <YsXJdXnXsMtaC8DJ@casper.infradead.org> <d14fe396-b39b-6b3e-ae74-eb6a8b64e379@nvidia.com> <Y4kC9NIXevPlji+j@casper.infradead.org> <72a51a83-c25a-ef52-55fb-2b73aec70305@suse.de> <Y4oSiPH0ENFktioQ@kbusch-mbp.dhcp.thefacebook.com> <f68009b7cc744c02ad69d68fd7e61751@kioxia.com> <yq14ju5gvfh.fsf@ca-mkp.ca.oracle.com> <Y5SEWnNUpgKxOB/W@fisica.ufpr.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5SEWnNUpgKxOB/W@fisica.ufpr.br>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 10, 2022 at 10:06:34AM -0300, Carlos Carvalho wrote:
> Certainly we have. Currently admins have to periodically run full block range
> checks in redundant arrays to detect bad blocks and correct them while
> redundancy is available. Otherwise when a disk fails and you try to reconstruct
> the replacement you hit another block in the remaining disks that's bad and you
> cannot complete the reconstruction and have data loss. These checks are a
> burden because they have HIGH overhead, significantly reducing bandwidth for
> the normal use of the array.
> 
> If there was a standard interface for getting the list of bad blocks that the
> firmware secretly knows the kernel could implement the repair continuosly, with
> logs etc. That'd really be a relief for admins and, specially, users.

Both SCSI and NVMe can do this through the GET LBA STATUS command -
in SCSI this was a later addition abusing the command, and in NVMe
only the abuse survived.  NVMe also has a log page an AEN associated
for it, I'd have to spend more time reading SBC to remember if SCSI
also has a notification mechanism of some sort.
