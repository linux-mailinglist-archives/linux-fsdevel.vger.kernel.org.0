Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D991A261B7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2019 12:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbfEVKZd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 May 2019 06:25:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:60474 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727464AbfEVKZc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 May 2019 06:25:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 35A53AEB6;
        Wed, 22 May 2019 10:25:31 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 804F91E3C5F; Wed, 22 May 2019 12:25:30 +0200 (CEST)
Date:   Wed, 22 May 2019 12:25:30 +0200
From:   Jan Kara <jack@suse.cz>
To:     'Christoph Hellwig' <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, kanchan <joshi.k@samsung.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, prakash.v@samsung.com,
        anshul@samsung.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v5 0/7] Extend write-hint framework, and add write-hint
 for Ext4 journal
Message-ID: <20190522102530.GK17019@quack2.suse.cz>
References: <CGME20190425112347epcas2p1f7be48b8f0d2203252b8c9dd510c1b61@epcas2p1.samsung.com>
 <1556191202-3245-1-git-send-email-joshi.k@samsung.com>
 <20190510170249.GA26907@infradead.org>
 <00fb01d50c71$dd358e50$97a0aaf0$@samsung.com>
 <20190520142719.GA15705@infradead.org>
 <20190521082528.GA17709@quack2.suse.cz>
 <20190521082846.GA11024@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521082846.GA11024@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 21-05-19 01:28:46, 'Christoph Hellwig' wrote:
> On Tue, May 21, 2019 at 10:25:28AM +0200, Jan Kara wrote:
> > performance benefits for some drives. After all you can just think about it
> > like RWH_WRITE_LIFE_JOURNAL type of hint available for the kernel...
> 
> Except that it actuallys adds a parallel insfrastructure.  A
> RWH_WRITE_LIFE_JOURNAL would be much more palatable, but someone needs
> to explain how that is:
> 
>  a) different from RWH_WRITE_LIFE_SHORT

The problem I have with this is: What does "short" mean? What if
userspace's notion of short differs from the kernel notion? Also the
journal block lifetime is somewhat hard to predict. It depends on the size
of the journal and metadata load on the filesystem so there's big variance.
So all we really know is that all journal blocks are the same.

>  b) would not apply to a log/journal maintained in userspace that works
>     exactly the same

Lifetime of userspace journal/log may be significantly different from the
lifetime of the filesystem journal. So using the same hint for them does
not look like a great idea?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
