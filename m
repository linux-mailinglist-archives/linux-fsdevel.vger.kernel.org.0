Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B50FE37A66E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 14:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbhEKMUv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 08:20:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48760 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231383AbhEKMUv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 08:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620735584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K/62AUSUpA5njWt/mxRQr2h5AShldbfQBaL6AXdA5Jc=;
        b=C8wYULg2lrKT2hHKTYsa4Lah6EQvXZyD9zGvTH2h776JoVHuH9ZN2KQsSW+o5fkcHXq59d
        jpJi8UmcBt11ZFJveyCuiG1OM2uIvCnLFuq8jMeXy35Fp4NixxH2UzPYIvRQIzNAAmk5Ne
        IDrk1lxEaCUbURtaVUHlbE71elouuaA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-I-6271slPRKpjOsvKJ8G7A-1; Tue, 11 May 2021 08:19:40 -0400
X-MC-Unique: I-6271slPRKpjOsvKJ8G7A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DE42106BB2D;
        Tue, 11 May 2021 12:19:39 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3364510190AA;
        Tue, 11 May 2021 12:19:39 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 0DAD34BB40;
        Tue, 11 May 2021 12:19:39 +0000 (UTC)
Date:   Tue, 11 May 2021 08:19:38 -0400 (EDT)
From:   Bob Peterson <rpeterso@redhat.com>
To:     Junxiao Bi <junxiao.bi@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        ocfs2-devel@oss.oracle.com, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Andreas Gruenbacher <agruenba@redhat.com>
Message-ID: <1750769001.24809997.1620735578939.JavaMail.zimbra@redhat.com>
In-Reply-To: <4d120e2e-5eb4-1bbb-cc63-8c3b7c62dac0@oracle.com>
References: <20210426220552.45413-1-junxiao.bi@oracle.com> <20210509162306.9de66b1656f04994f3cb5730@linux-foundation.org> <4d120e2e-5eb4-1bbb-cc63-8c3b7c62dac0@oracle.com>
Subject: Re: [Ocfs2-devel] [PATCH 1/3] fs/buffer.c: add new api to allow eof
 writeback
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.3.112.114, 10.4.195.1]
Thread-Topic: fs/buffer.c: add new api to allow eof writeback
Thread-Index: aQPKcUwGH5yqUlPghB6gr17JLe3JLQ==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

----- Original Message -----
> On 5/9/21 4:23 PM, Andrew Morton wrote:
> 
> > On Mon, 26 Apr 2021 15:05:50 -0700 Junxiao Bi <junxiao.bi@oracle.com>
> > wrote:
> >
> >> When doing truncate/fallocate for some filesytem like ocfs2, it
> >> will zero some pages that are out of inode size and then later
> >> update the inode size, so it needs this api to writeback eof
> >> pages.
> > Seems reasonable.  But can we please update the
> > __block_write_full_page_eof() comment?  It now uses the wrong function
> > name and doesn't document the new `eof' argument.
> 
> Jan suggested using sb_issue_zeroout to zero eof pages in
> ocfs2_fallocate, that can
> 
> also fix the issue for ocfs2. For gfs2, i though it had the same issue,
> but i didn't get
> 
> a confirm from gfs2 maintainer, if gfs2 is ok, then maybe this new api
> is not necessary?
> 
> Thanks,
> 
> Junxiao.

Hi,

Sorry. I was on holiday/vacation for the past week and a half without
Internet access except for my phone. I'll try to find the time to read
the thread and look into it soon.

Bob Peterson

