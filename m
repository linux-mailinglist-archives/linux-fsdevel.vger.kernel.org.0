Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE3940DE4B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 17:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238827AbhIPPna (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 11:43:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60421 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229523AbhIPPna (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 11:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631806929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FVdU8EmOh/2b0GizTX/ZQQuKdsu7q9/FJbV1mrZGOtw=;
        b=X0H2AVKOzRWRXXLwYlFk1MBiI2uFjBmo+0XcjagiBzR++9I6FWfTEY2l4uIEFVYoR+uF7Q
        o6ENbwgtIHHrHieSmBU9qx/JqZ6uErzFfzjB3xKdjZuhUWGGeEUw5kuf7QfTMEh7eukKVM
        m/ZLO3gPUzbNAy3SwwYzjN0iF4fq9Mc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-UzdWZfhJOi6BbvqF1OKNCg-1; Thu, 16 Sep 2021 11:42:07 -0400
X-MC-Unique: UzdWZfhJOi6BbvqF1OKNCg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A88561081B81;
        Thu, 16 Sep 2021 15:41:54 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.32.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 51201100164C;
        Thu, 16 Sep 2021 15:41:54 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id E7EF4220C99; Thu, 16 Sep 2021 11:41:53 -0400 (EDT)
Date:   Thu, 16 Sep 2021 11:41:53 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     viro@zeniv.linux.org.uk,
        Linux fsdevel mailing list <linux-fsdevel@vger.kernel.org>,
        linux kernel mailing list <linux-kernel@vger.kernel.org>,
        xu.xin16@zte.com.cn, Christoph Hellwig <hch@infradead.org>,
        zhang.yunkai@zte.com.cn
Subject: Re: [PATCH] init/do_mounts.c: Harden split_fs_names() against buffer
 overflow
Message-ID: <YUNlwdCf53HqRhKd@redhat.com>
References: <YUIPnPV2ttOHNIcX@redhat.com>
 <20210916110016.GG10610@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916110016.GG10610@quack2.suse.cz>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 16, 2021 at 01:00:16PM +0200, Jan Kara wrote:
> On Wed 15-09-21 11:22:04, Vivek Goyal wrote:
> > split_fs_names() currently takes comma separated list of filesystems
> > and converts it into individual filesystem strings. Pleaces these
> > strings in the input buffer passed by caller and returns number of
> > strings.
> > 
> > If caller manages to pass input string bigger than buffer, then we
> > can write beyond the buffer. Or if string just fits buffer, we will
> > still write beyond the buffer as we append a '\0' byte at the end.
> > 
> > Will be nice to pass size of input buffer to split_fs_names() and
> > put enough checks in place so such buffer overrun possibilities
> > do not occur.
> > 
> > Hence this patch adds "size" parameter to split_fs_names() and makes
> > sure we do not access memory beyond size. If input string "names"
> > is larger than passed in buffer, input string will be truncated to
> > fit in buffer.
> > 
> > Reported-by: xu xin <xu.xin16@zte.com.cn>
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> 
> The patch looks correct but IMO is more complicated than it needs to be...
> See below.
> 
> > Index: redhat-linux/init/do_mounts.c
> > ===================================================================
> > --- redhat-linux.orig/init/do_mounts.c	2021-09-15 08:46:33.801689806 -0400
> > +++ redhat-linux/init/do_mounts.c	2021-09-15 09:52:09.884449718 -0400
> > @@ -338,19 +338,20 @@ __setup("rootflags=", root_data_setup);
> >  __setup("rootfstype=", fs_names_setup);
> >  __setup("rootdelay=", root_delay_setup);
> >  
> > -static int __init split_fs_names(char *page, char *names)
> > +static int __init split_fs_names(char *page, size_t size, char *names)
> >  {
> >  	int count = 0;
> > -	char *p = page;
> > +	char *p = page, *end = page + size - 1;
> > +
> > +	strncpy(p, root_fs_names, size);
> 
> Why not strlcpy()? That way you don't have to explicitely terminate the
> string...

Sure, will use strlcpy().

> 
> > +	*end = '\0';
> >  
> > -	strcpy(p, root_fs_names);
> >  	while (*p++) {
> >  		if (p[-1] == ',')
> >  			p[-1] = '\0';
> >  	}
> > -	*p = '\0';
> >  
> > -	for (p = page; *p; p += strlen(p)+1)
> > +	for (p = page; p < end && *p; p += strlen(p)+1)
> >  		count++;
> 
> And I kind of fail to see why you have a separate loop for counting number
> of elements when you could count them directly when changing ',' to '\0'.
> There's this small subtlety that e.g. string 'foo,,bar' will report to have
> only 1 element with the above code while direct computation would return 3
> but that's hardly problem IMHO.

Ok, will make this change. One side affect of this change will be that now
split_fs_names() can return zero sized strings and caller will have
to check for those and skip to next string.

Vivek

