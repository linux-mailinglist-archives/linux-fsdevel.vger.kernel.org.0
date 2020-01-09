Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57A6E13513A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2020 03:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgAICFk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 21:05:40 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47082 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727837AbgAICFk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 21:05:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578535539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=39HTy+I9bsQga0QDeboxAcXZyuRivEM92MqxhtYaKTc=;
        b=PTYti7+beFkwXx3FawWd85Wp0Pv9tTYs0Uam1dskkfu2IBFuW7Ipvas8XqLi7G7UlALyHI
        WHeGk5A1Jig8dtUuo4ibRQDsPfLq9WfAuQxlBAbcpBKEEzzEssovbHFYvjeVK7HR++6yS4
        F5GSG6UIimMznnDxwA4y9N6yGgfEHIc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-E_WwN-hBNwalC6slI8-Dsw-1; Wed, 08 Jan 2020 21:05:38 -0500
X-MC-Unique: E_WwN-hBNwalC6slI8-Dsw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D7CD1005514;
        Thu,  9 Jan 2020 02:05:37 +0000 (UTC)
Received: from ming.t460p (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EC03D10027A6;
        Thu,  9 Jan 2020 02:05:28 +0000 (UTC)
Date:   Thu, 9 Jan 2020 10:05:24 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        syzbot+2b9e54155c8c25d8d165@syzkaller.appspotmail.com
Subject: Re: [PATCH V2] block: add bio_truncate to fix guard_bio_eod
Message-ID: <20200109020524.GD9655@ming.t460p>
References: <20191227230548.20079-1-ming.lei@redhat.com>
 <20200108133735.GB4455@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108133735.GB4455@infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 08, 2020 at 05:37:35AM -0800, Christoph Hellwig wrote:
> 
> > +void bio_truncate(struct bio *bio, unsigned new_size)
> 
> This function really needs a kerneldoc or similar comment describing
> what it does in detail.

OK, will do that.

> 
> > +	if (bio_data_dir(bio) != READ)
> > +		goto exit;
> 
> This really should check the passed in op for REQ_OP_READ directly instead
> of just the direction on the potentially not fully set up bio.

It has been addressed in:

https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=block-5.5&id=802ca0381befe29ba0783e08e3369f9e87ef9d0d


Thanks,
Ming

