Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C798E29D283
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Oct 2020 22:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbgJ1VdH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 17:33:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60199 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725881AbgJ1VdD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:33:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603920782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qKV3BUcS3jjFHa57753EjDZ8T+HztztTJ0FZVWC9e8E=;
        b=ZAIEa2deLvheXwAKbuysxamiBuOMbiYdfWtBPCAiXLy+3QgDjB15rV7RDT3XNTVOKEvj/J
        HeETRewdaKLLQwOSiTX9XK27h48AyhFVxahCR6t6qv8BFoxeJKZH3P9EYUySq6htBmzP+K
        gn3Sr490rZue9uKrB9VooNeLk3xCENU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-526-Qw7WSSMEP-CAqS6fw_Z_EQ-1; Wed, 28 Oct 2020 07:31:27 -0400
X-MC-Unique: Qw7WSSMEP-CAqS6fw_Z_EQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC5368015B1;
        Wed, 28 Oct 2020 11:31:25 +0000 (UTC)
Received: from bfoster (ovpn-113-186.rdu2.redhat.com [10.10.113.186])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7CFF7196FE;
        Wed, 28 Oct 2020 11:31:25 +0000 (UTC)
Date:   Wed, 28 Oct 2020 07:31:23 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/2] iomap: use page dirty state to seek data over
 unwritten extents
Message-ID: <20201028113123.GA1610972@bfoster>
References: <20201012140350.950064-1-bfoster@redhat.com>
 <20201012140350.950064-2-bfoster@redhat.com>
 <20201015094700.GB21420@infradead.org>
 <20201019165501.GA1232435@bfoster>
 <20201027180731.GA32577@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027180731.GA32577@infradead.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 27, 2020 at 06:07:31PM +0000, Christoph Hellwig wrote:
> On Mon, Oct 19, 2020 at 12:55:01PM -0400, Brian Foster wrote:
> > On Thu, Oct 15, 2020 at 10:47:00AM +0100, Christoph Hellwig wrote:
> > > I don't think we can solve this properly.  Due to the racyness we can
> > > always err one side.  The beauty of treating all the uptodate pages
> > > as present data is that we err on the safe side, as applications
> > > expect holes to never have data, while "data" could always be zeroed.
> > > 
> > 
> > I don't think that's quite accurate. Nothing prevents a dirty page from
> > being written back and reclaimed between acquiring the (unwritten)
> > mapping and doing the pagecache scan, so it's possible to present valid
> > data (written to the kernel prior to a seek) as a hole with the current
> > code.
> 
> True.  I guess we need to go back and do another lookup to fully
> solve this problem.  That doesn't change my opinion that this patch
> makes the problem worse.
> 

Yeah. I think it's possible to at least have some internal consistency
(i.e. while we're under locks) if we check the page state first or
somehow or another jump back out of the iomap_apply() sequence to do so.
I hadn't thought about it a ton since the goal of these patches was to
address the post-eof zeroing problem vs. fix seek data/hole.

Brian

