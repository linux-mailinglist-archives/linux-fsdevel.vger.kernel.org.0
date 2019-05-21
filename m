Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0CC424A49
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2019 10:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfEUIZb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 May 2019 04:25:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:50394 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726767AbfEUIZb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 May 2019 04:25:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AA0DAAD94;
        Tue, 21 May 2019 08:25:29 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id EF1FD1E3C72; Tue, 21 May 2019 10:25:28 +0200 (CEST)
Date:   Tue, 21 May 2019 10:25:28 +0200
From:   Jan Kara <jack@suse.cz>
To:     'Christoph Hellwig' <hch@infradead.org>
Cc:     kanchan <joshi.k@samsung.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        prakash.v@samsung.com, anshul@samsung.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v5 0/7] Extend write-hint framework, and add write-hint
 for Ext4 journal
Message-ID: <20190521082528.GA17709@quack2.suse.cz>
References: <CGME20190425112347epcas2p1f7be48b8f0d2203252b8c9dd510c1b61@epcas2p1.samsung.com>
 <1556191202-3245-1-git-send-email-joshi.k@samsung.com>
 <20190510170249.GA26907@infradead.org>
 <00fb01d50c71$dd358e50$97a0aaf0$@samsung.com>
 <20190520142719.GA15705@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520142719.GA15705@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 20-05-19 07:27:19, 'Christoph Hellwig' wrote:
> On Fri, May 17, 2019 at 11:01:55AM +0530, kanchan wrote:
> > Sorry but can you please elaborate the issue? I do not get what is being
> > statically allocated which was globally available earlier.
> > If you are referring to nvme driver,  available streams at subsystem level
> > are being reflected for all namespaces. This is same as earlier. 
> > There is no attempt to explicitly allocate (using dir-receive) or reserve
> > streams for any namespace.  
> > Streams will continue to get allocated/released implicitly as and when
> > writes (with stream id) arrive.
> 
> We have made a concious decision that we do not want to expose streams
> as an awkward not fish not flesh interface, but instead life time hints.
> 
> I see no reason to change from and burden the whole streams complexity
> on other in-kernel callers.

I'm not following the "streams complexity" you talk about. At least the
usecase Kanchan speaks about here is pretty simple for the filesystem -
tagging journal writes with special stream id. I agree that something like
dynamically allocating available stream ids to different purposes is
complex and has uncertain value but this "static stream id for particular
purpose" looks simple and sensible to me and Kanchan has shown significant
performance benefits for some drives. After all you can just think about it
like RWH_WRITE_LIFE_JOURNAL type of hint available for the kernel...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
