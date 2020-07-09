Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227F9219AC0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jul 2020 10:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgGII0j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jul 2020 04:26:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54896 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726319AbgGII0i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jul 2020 04:26:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594283197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lZzkV3MawPwjnH2A6+i/gZ/LnvMbuWxGQy5lTADJWpQ=;
        b=Bu84UwjNrpRCdTYt8kmlkY+70KZOF+yvmD7CNPIJxxSL+ctrZscMbaO0Yj+NcD6XY719Wt
        n4cGAnn2YgYlSeMsH21PUKrjlzYOlnGDEHz/UpOd38oVZcpX8KmX/wDY4T3X2xtcudhYDL
        y5aQvlsDba//jBe3EvlxJvVargiFScg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-VvhpeSOcMc-klcFzERo_4w-1; Thu, 09 Jul 2020 04:26:33 -0400
X-MC-Unique: VvhpeSOcMc-klcFzERo_4w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C93988C922;
        Thu,  9 Jul 2020 08:26:31 +0000 (UTC)
Received: from fogou.chygwyn.com (unknown [10.33.36.52])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CC38379815;
        Thu,  9 Jul 2020 08:26:24 +0000 (UTC)
Subject: Re: [Cluster-devel] always fall back to buffered I/O after
 invalidation failures, was: Re: [PATCH 2/6] iomap:
 IOMAP_DIO_RWF_NO_STALE_PAGECACHE return if page invalidation fails
To:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, fdmanana@gmail.com,
        darrick.wong@oracle.com, Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Dave Chinner <david@fromorbit.com>, dsterba@suse.cz,
        cluster-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20200629192353.20841-1-rgoldwyn@suse.de>
 <20200629192353.20841-3-rgoldwyn@suse.de> <20200701075310.GB29884@lst.de>
 <20200707124346.xnr5gtcysuzehejq@fiona>
 <20200707125705.GK25523@casper.infradead.org> <20200707130030.GA13870@lst.de>
 <20200708065127.GM2005@dread.disaster.area>
 <20200708135437.GP25523@casper.infradead.org> <20200708165412.GA637@lst.de>
From:   Steven Whitehouse <swhiteho@redhat.com>
Message-ID: <126c9e1b-145f-3725-fbde-92135f52a4a3@redhat.com>
Date:   Thu, 9 Jul 2020 09:26:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200708165412.GA637@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 08/07/2020 17:54, Christoph Hellwig wrote:
> On Wed, Jul 08, 2020 at 02:54:37PM +0100, Matthew Wilcox wrote:
>> Direct I/O isn't deterministic though.  If the file isn't shared, then
>> it works great, but as soon as you get mixed buffered and direct I/O,
>> everything is already terrible.  Direct I/Os perform pagecache lookups
>> already, but instead of using the data that we found in the cache, we
>> (if it's dirty) write it back, wait for the write to complete, remove
>> the page from the pagecache and then perform another I/O to get the data
>> that we just wrote out!  And then the app that's using buffered I/O has
>> to read it back in again.
> Mostly agreed.  That being said I suspect invalidating clean cache
> might still be a good idea.  The original idea was mostly on how
> to deal with invalidation failures of any kind, but falling back for
> any kind of dirty cache also makes at least some sense.
>
>> I have had an objection raised off-list.  In a scenario with a block
>> device shared between two systems and an application which does direct
>> I/O, everything is normally fine.  If one of the systems uses tar to
>> back up the contents of the block device then the application on that
>> system will no longer see the writes from the other system because
>> there's nothing to invalidate the pagecache on the first system.
> Err, WTF?  If someone access shared block devices with random
> applications all bets are off anyway.

On GFS2 the locking should take care of that. Not 100% sure about OCFS2 
without looking, but I'm fairly sure that they have a similar 
arrangement. So this shouldn't be a problem unless there is an 
additional cluster fs that I'm not aware of that they are using in this 
case. It would be good to confirm which fs they are using,

Steve.


