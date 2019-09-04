Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCD3A8406
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 15:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbfIDM6o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Sep 2019 08:58:44 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36366 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727900AbfIDM6o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Sep 2019 08:58:44 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-96.corp.google.com [104.133.0.96] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x84CwYVZ022125
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 4 Sep 2019 08:58:35 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id C62D042049E; Wed,  4 Sep 2019 08:58:34 -0400 (EDT)
Date:   Wed, 4 Sep 2019 08:58:34 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Qian Cai <cai@lca.pw>,
        Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: "beyond 2038" warnings from loopback mount is noisy
Message-ID: <20190904125834.GA3044@mit.edu>
References: <1567523922.5576.57.camel@lca.pw>
 <CABeXuvoPdAbDr-ELxNqUPg5n84fubZJZKiryERrXdHeuLhBQjQ@mail.gmail.com>
 <20190903211747.GD2899@mit.edu>
 <CABeXuvoYh0mhg049+pXbMqh-eM=rw+Ui1=rDree4Yb=7H7mQRg@mail.gmail.com>
 <CAK8P3a0AcPzuGeNFMW=ymO0wH_cmgnynLGYXGjqyrQb65o6aOw@mail.gmail.com>
 <CABeXuvq0_YsyuFY509XmwFsX6tX5EVHmWGuzHnSyOEX=9X6TFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABeXuvq0_YsyuFY509XmwFsX6tX5EVHmWGuzHnSyOEX=9X6TFg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 03, 2019 at 09:50:09PM -0700, Deepa Dinamani wrote:
> If we don't care to warn about the timestamps that are clamped in
> memory, maybe we could just warn when they are being written out.
> Would something like this be more acceptable? I would also remove the
> warning in ext4.h. I think we don't have to check if the inode is 128
> bytes here (Please correct me if I am wrong). If this looks ok, I can
> post this.

That's better, but it's going to be misleading in many cases.  The
inode's extra size field is 16 or larger, there will be enough space
for the timestamps, so talking about "timestamps on this inode beyond
2038" when ext4 is unable to expand it from say, 24 to 32, won't be
true.  Certain certain features won't be available, yes --- such as
project-id-based quotas, since there won't be room to store the
project ID.  However, it's not going to impact the ability to store
timestamps beyond 2038.  The i_extra_isize field is not just about
timestamps!

Again, the likelihood that there will be file systems that have this
problem in 2038 is... extremely low in my judgement.  Storage media
just doesn't last that long; and distributions such as Red Hat and
SuSE very strongly encourage people to reformat file systems and do
*not* support upgrades from ext3 to ext4 by using tune2fs.  If you do
this, their help desk will laugh at you and refuse to help you.

Companies like Google will do this kind of upgrades[1], sure.  But
that's because backing up and reformatting vast numbers of file
systems are not practical at scale.  (And even Google doesn't maintain
the file system image when the servers are old enough to be TCO
negative and it's time to replace them.)

In contrast, most companies / users don't do this sort of thing at
all.  It's not an issue for Cell Phones, for example, or most consumer
devices, which are lucky if the last more than 3 years before they get
desupported and stop getting security updates, and then the lithium
ion batttery dies and the device end up in a landfill.  Those that
might live 20 years (although good luck with that for something like,
say, a smart thermostat) aren't going to have a console and no one
will be paying attention to the kernel messages anyway.  So is it
really worth it?  For whom are these messages meant?

[1] https://www.youtube.com/watch?v=Wp5Ehw7ByuU

Cheers,

					- Ted
