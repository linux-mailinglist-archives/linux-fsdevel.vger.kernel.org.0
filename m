Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9DC73DB89A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 14:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238736AbhG3M26 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 08:28:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59122 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230127AbhG3M26 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 08:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627648133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KoGVkv7H3/+ygZF2TyDEKy9CxxMUqYhhWlGnltJvuyM=;
        b=KkQG5D1TCYO2nTrgr9Y4lXY96IA+n+fF5suLjuEYaG3Y0b2PLQm0ler3exNreJLHXanUjB
        MsfjN0aiG6M1VVRXCLHsMKzUDWh73lnyClNdytPGMJ0kVlQ9ngQ1z1PbccQcm6bqGuFoJy
        MbhEXqVF6qmFjAwq1jWQmPoTz1vp2Xs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-pZHFfejSPfasBYxYWzJMww-1; Fri, 30 Jul 2021 08:28:50 -0400
X-MC-Unique: pZHFfejSPfasBYxYWzJMww-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B47E6190A7A5;
        Fri, 30 Jul 2021 12:28:48 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.32.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E6465779D0;
        Fri, 30 Jul 2021 12:28:47 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 8652D22037A; Fri, 30 Jul 2021 08:24:18 -0400 (EDT)
Date:   Fri, 30 Jul 2021 08:24:18 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@lst.de, virtio-fs@redhat.com,
        v9fs-developer@lists.sourceforge.net, stefanha@redhat.com,
        miklos@szeredi.hu
Subject: Re: [PATCH v3 3/3] fs: simplify get_filesystem_list /
 get_all_fs_names
Message-ID: <YQPvcilZ09yByXb5@redhat.com>
References: <20210714202321.59729-1-vgoyal@redhat.com>
 <20210714202321.59729-4-vgoyal@redhat.com>
 <YQNOY9H/6mJMWRNN@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQNOY9H/6mJMWRNN@zeniv-ca.linux.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 30, 2021 at 12:57:07AM +0000, Al Viro wrote:
> On Wed, Jul 14, 2021 at 04:23:21PM -0400, Vivek Goyal wrote:
> 
> > +static int __init split_fs_names(char *page, char *names)
> >  {
> > +	int count = 0;
> > +	char *p = page;
> >  
> > +	strcpy(p, root_fs_names);
> > +	while (*p++) {
> > +		if (p[-1] == ',')
> > +			p[-1] = '\0';
> >  	}
> > +	*p = '\0';
> > +
> > +	for (p = page; *p; p += strlen(p)+1)
> > +		count++;
> >  
> > +	return count;
> >  }
> 
> Ummm....  The last part makes no sense - it counts '\0' in the array
> pointed to be page, until the first double '\0' in there.  All of
> which had been put there by the loop immediately prior to that one...

I want split_fs_names() to replace ',' with space as well as return
number of null terminated strings found. So first loop just replaces
',' with '\0' and second loop counts number of strings.

Previously split_fs_names() was only replacing ',' with '\0'. Now
we are changing the semantics and returning number of strings
left in the buffer after the replacement.

I initilaly thought that if I can manage it with single loop but
there were quite a few corner cases. So I decided to use two
loops instead. One for replacement and one for counting.

> 
> Incidentally, it treats stray ,, in root_fs_names as termination;
> is that intentional?

Just trying to keep the existing behavior. Existing get_fs_names(), also
replaces all instances of ',' with '\0'. So if there are two consecutive,
',', that will result in two consecutive '\0' and caller will view
it as end of buffer. 

IOW, rootfsnames=foo,,bar will effectively be treated as "rootfsname=foo".

That's the current behavior and I did not try to improve on it just
keeps on increasing the size of patches. That's probably an improvement
for some other day if somebody cares.

Thanks
Vivek

