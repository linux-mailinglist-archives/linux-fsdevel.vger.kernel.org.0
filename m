Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEEB943C8E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Oct 2021 13:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240076AbhJ0Lz2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Oct 2021 07:55:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53299 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240055AbhJ0Lz0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Oct 2021 07:55:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635335580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7cn8cimWbBWXEPvwtBHTbmJpS9FVs5pGnENY25bd5UU=;
        b=FniXKDNxX6CCCUGm5ucunbBltALcT6w/dqwuruIW3EljTsHK2VcUnrNarl9HiGW1CvqwWb
        9VkGx8PMijLRjtduDfOMmaQrU8KcboeC3QWzJ7J8tc+O+v37JMPJKIxfjehOUc4S5ksbAm
        lCnirHjrI8eLK6EVmIzmQNX/MzyxmfM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-QxUfaWElNQ-0d0ON8Tmilg-1; Wed, 27 Oct 2021 07:52:56 -0400
X-MC-Unique: QxUfaWElNQ-0d0ON8Tmilg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5C0515875AF;
        Wed, 27 Oct 2021 11:52:51 +0000 (UTC)
Received: from work (unknown [10.40.194.65])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8AAF51ACBB;
        Wed, 27 Oct 2021 11:52:50 +0000 (UTC)
Date:   Wed, 27 Oct 2021 13:52:46 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        linux-fsdevel@vger.kernel.org, cmaiolino@redhat.com
Subject: Re: [PATCH v3 11/13] ext4: change token2str() to use ext4_param_specs
Message-ID: <20211027115246.bewgpt35szs7ppda@work>
References: <20211021114508.21407-1-lczerner@redhat.com>
 <20211021114508.21407-12-lczerner@redhat.com>
 <20211026114043.q5kwobv7vlnv2uej@andromeda.lan>
 <20211026120953.mropvelvr4id7mej@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026120953.mropvelvr4id7mej@work>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 26, 2021 at 02:09:53PM +0200, Lukas Czerner wrote:
> On Tue, Oct 26, 2021 at 01:40:43PM +0200, Carlos Maiolino wrote:
> > On Thu, Oct 21, 2021 at 01:45:06PM +0200, Lukas Czerner wrote:
> > > Chage token2str() to use ext4_param_specs instead of tokens so that we
> > 
> > ^ Change.
> > 
> > > can get rid of tokens entirely.
> > 
> > If you're removing tokens entirely, maybe the name token2str() doesn't make
> > sense anymore?
> 
> True, I guess it's no longer called "token" so maybe option2str() ?

Actually it's still called token in the struct mount_opts which is what
we're passing down to the token2str() anyway. Since this really is
inconsequential stuff I'll leave it as it is.

-Lukas

> 
> -Lukas
> 
> > 
> > > 
> > > Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> > > ---
> > >  fs/ext4/super.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > > index bdcaa158eab8..0ccd47f3fa91 100644
> > > --- a/fs/ext4/super.c
> > > +++ b/fs/ext4/super.c
> > > @@ -3037,12 +3037,12 @@ static inline void ext4_show_quota_options(struct seq_file *seq,
> > >  
> > >  static const char *token2str(int token)
> > >  {
> > > -	const struct match_token *t;
> > > +	const struct fs_parameter_spec *spec;
> > >  
> > > -	for (t = tokens; t->token != Opt_err; t++)
> > > -		if (t->token == token && !strchr(t->pattern, '='))
> > > +	for (spec = ext4_param_specs; spec->name != NULL; spec++)
> > > +		if (spec->opt == token && !spec->type)
> > >  			break;
> > > -	return t->pattern;
> > > +	return spec->name;
> > >  }
> > >  
> > >  /*
> > > -- 
> > > 2.31.1
> > > 
> > 
> > -- 
> > Carlos
> > 
> 

