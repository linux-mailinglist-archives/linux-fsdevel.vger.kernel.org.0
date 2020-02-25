Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D14716EF24
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2020 20:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730671AbgBYTh1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Feb 2020 14:37:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45138 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728555AbgBYThW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Feb 2020 14:37:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582659441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3454YjUXRoDS+24Lzxnu4Pv0NqG7YV73o/VGu7/5u2E=;
        b=MmFIV2bCFfKsScL4zbRKXb9IbJaKNNlhasHYPnSW6EodaAzOvlGhIFBPFqnHN2hU2xfdmc
        6IZuIE8eXvoviUr+/7eQLNDd9ekMwTwuGpgD/oH4iQg2jCOn2fAejJX50YRRR0sEn1RQZh
        WXBCorgyRMvo86IbzlBo0yzLQoCcLLI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-9ulGlCEBOoewJwoiFtQzDg-1; Tue, 25 Feb 2020 14:37:17 -0500
X-MC-Unique: 9ulGlCEBOoewJwoiFtQzDg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2852C8017CC;
        Tue, 25 Feb 2020 19:37:15 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C0FC65C296;
        Tue, 25 Feb 2020 19:37:13 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>, jhallida@redhat.com
Cc:     Dave Chinner <david@fromorbit.com>, ira.weiny@intel.com,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V4 07/13] fs: Add locking for a dynamic address space operations state
References: <20200221004134.30599-1-ira.weiny@intel.com>
        <20200221004134.30599-8-ira.weiny@intel.com>
        <20200221174449.GB11378@lst.de>
        <20200221224419.GW10776@dread.disaster.area>
        <20200224175603.GE7771@lst.de>
        <20200225000937.GA10776@dread.disaster.area>
        <20200225173633.GA30843@lst.de>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Tue, 25 Feb 2020 14:37:12 -0500
In-Reply-To: <20200225173633.GA30843@lst.de> (Christoph Hellwig's message of
        "Tue, 25 Feb 2020 18:36:33 +0100")
Message-ID: <x49fteyh313.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> And my point is that if we ensure S_DAX can only be checked if there
> are no blocks on the file, is is fairly easy to provide the same
> guarantee.  And I've not heard any argument that we really need more
> flexibility than that.  In fact I think just being able to change it
> on the parent directory and inheriting the flag might be more than
> plenty, which would lead to a very simple implementation without any
> of the crazy overhead in this series.

I know of one user who had at least mentioned it to me, so I cc'd him.
Jonathan, can you describe your use case for being able to change a
file between dax and non-dax modes?  Or, if I'm misremembering, just
correct me?

Thanks!
Jeff

