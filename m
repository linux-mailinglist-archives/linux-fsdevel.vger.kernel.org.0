Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D776440F85D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 14:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238001AbhIQMxz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 08:53:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48257 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232924AbhIQMxy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 08:53:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631883152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jR5xb37JDnFFhDky//xp2bDnTHSPKVCP1Sl4yhtd0FM=;
        b=I8Ik/VaqtnsFqsoaIETfwovgyyAq0nf8+rvjgKKmLlj+QE7b0TeTEsw6ppL62QvccZT6YU
        TRSYfdaw9/SHwaBZdMmEO98EUoX/4d3SNNyQv1rWG3G6d098FU0nVB+FK2WigjvVuejuyr
        dJ1hwqiS7Wtjl828nzBbxSfoudpt37I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-QrMC5_JxP-uP1elKEnE5ew-1; Fri, 17 Sep 2021 08:52:31 -0400
X-MC-Unique: QrMC5_JxP-uP1elKEnE5ew-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9CA61084681;
        Fri, 17 Sep 2021 12:52:29 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.32.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ED9BB5C1D1;
        Fri, 17 Sep 2021 12:52:28 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 80954220C99; Fri, 17 Sep 2021 08:52:28 -0400 (EDT)
Date:   Fri, 17 Sep 2021 08:52:28 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        viro@zeniv.linux.org.uk,
        Linux fsdevel mailing list <linux-fsdevel@vger.kernel.org>,
        linux kernel mailing list <linux-kernel@vger.kernel.org>,
        xu.xin16@zte.com.cn
Subject: Re: [PATCH v2] init/do_mounts.c: Harden split_fs_names() against
 buffer overflow
Message-ID: <YUSPjGnGu79Djxc7@redhat.com>
References: <YUNn4k1FCgQmOpuw@redhat.com>
 <20210917080730.GA5284@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917080730.GA5284@quack2.suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 17, 2021 at 10:07:30AM +0200, Jan Kara wrote:
> On Thu 16-09-21 11:50:58, Vivek Goyal wrote:
> > split_fs_names() currently takes comma separate list of filesystems
> > and converts it into individual filesystem strings. Pleaces these
> > strings in the input buffer passed by caller and returns number of
> > strings.
> > 
> > If caller manages to pass input string bigger than buffer, then we
> > can write beyond the buffer. Or if string just fits buffer, we will
> > still write beyond the buffer as we append a '\0' byte at the end.
> > 
> > Pass size of input buffer to split_fs_names() and put enough checks
> > in place so such buffer overrun possibilities do not occur.
> > 
> > This patch does few things.
> > 
> > - Add a parameter "size" to split_fs_names(). This specifies size
> >   of input buffer.
> > 
> > - Use strlcpy() (instead of strcpy()) so that we can't go beyond
> >   buffer size. If input string "names" is larger than passed in
> >   buffer, input string will be truncated to fit in buffer.
> > 
> > - Stop appending extra '\0' character at the end and avoid one
> >   possibility of going beyond the input buffer size.
> > 
> > - Do not use extra loop to count number of strings.
> > 
> > - Previously if one passed "rootfstype=foo,,bar", split_fs_names()
> >   will return only 1 string "foo" (and "bar" will be truncated
> >   due to extra ,). After this patch, now split_fs_names() will
> >   return 3 strings ("foo", zero-sized-string, and "bar").
> > 
> >   Callers of split_fs_names() have been modified to check for
> >   zero sized string and skip to next one.
> > 
> > Reported-by: xu xin <xu.xin16@zte.com.cn>
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > ---
> >  init/do_mounts.c |   28 ++++++++++++++++++++--------
> >  1 file changed, 20 insertions(+), 8 deletions(-)
> 
> Just one nit below:
> 
> > Index: redhat-linux/init/do_mounts.c
> > ===================================================================
> > --- redhat-linux.orig/init/do_mounts.c	2021-09-15 08:46:33.801689806 -0400
> > +++ redhat-linux/init/do_mounts.c	2021-09-16 11:28:36.753625037 -0400
> > @@ -338,19 +338,25 @@ __setup("rootflags=", root_data_setup);
> >  __setup("rootfstype=", fs_names_setup);
> >  __setup("rootdelay=", root_delay_setup);
> >  
> > -static int __init split_fs_names(char *page, char *names)
> > +static int __init split_fs_names(char *page, size_t size, char *names)
> >  {
> >  	int count = 0;
> >  	char *p = page;
> > +	bool str_start = false;
> >  
> > -	strcpy(p, root_fs_names);
> > +	strlcpy(p, root_fs_names, size);
> >  	while (*p++) {
> > -		if (p[-1] == ',')
> > +		if (p[-1] == ',') {
> >  			p[-1] = '\0';
> > +			count++;
> > +			str_start = false;
> > +		} else {
> > +			str_start = true;
> > +		}
> >  	}
> > -	*p = '\0';
> >  
> > -	for (p = page; *p; p += strlen(p)+1)
> > +	/* Last string which might not be comma terminated */
> > +	if (str_start)
> >  		count++;
> 
> You could avoid the whole str_start logic if you just initialize 'count' to
> 1 - in the worst case you'll have 0-length string at the end (for case like
> xfs,) but you deal with 0-length strings in the callers anyway. Otherwise
> the patch looks good so feel free to add:

Hi Jan,

This sounds good. I will get rid of str_start. V3 of the patch is on
the way.

Vivek
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 

