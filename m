Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 715D5144801
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 00:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgAUXFY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jan 2020 18:05:24 -0500
Received: from mail-pl1-f177.google.com ([209.85.214.177]:38047 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgAUXFY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jan 2020 18:05:24 -0500
Received: by mail-pl1-f177.google.com with SMTP id f20so2008494plj.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jan 2020 15:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lamr1gyKANnv6K4/FkXRqREnDVgO1Y5q+wFOl0vX0sc=;
        b=GcuaJ+BRTifO2JTFe45+sM+2vZlEhg5cgM7/LbQE0iVTTTeqgk025C+00qVUBvyowW
         zZp4ThrEFcNEU5MtCqQoHrBDgnX+022F3Z8ResmQq2sZglWgJ+BIPOZn/VEwtT+On/KQ
         /HeIozK9UUZ+U2rrDIqoUhbia/ELgrxIYMZUlibzIm0aevSzxwNXFH/2aysHoWVIHKlE
         +nH9JiyiGDB7ub5NGK048N0kVSqXkZaEibCCZEa68f2JrrElbzlP+AmOZC0hJEkAYfZp
         PBY30MUcmzOY/ejwTKMZu8FYpgAhQ8BorDwO82XFNUYxPdzGrXKMaFnMFDtz6NC/wzEw
         d9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lamr1gyKANnv6K4/FkXRqREnDVgO1Y5q+wFOl0vX0sc=;
        b=kAbiivPNQGQaMkt8UKN+H43ybeeyE08VMqvwnaSWKXwHJn4BH/nNB44KA1/hOhZCJK
         uFARtDqeKfG1a5u/4zeajGT+6fTLpKnkDMSoKUtLrUOQxbkgV9f3ckelEEtD7YMXuWC0
         ddcqk43TA1yzvFiHC8Tb1Cea6ADZAh2qRUWORowe1u5nYw6DAxl/4ma3gCftYvZyi2uW
         QyIwsdImFXlOrMm5PwuA+WYs/YkkclKhvItNrUiXnC7U47F6a3lsJXWCJof9BIYL1VA5
         s4XtPD+pIj24E+GHqAXK3lyXeode2n6M6oavbTocJe6o/kgFe/nmWhYvVyon2AYRsDM5
         gVVg==
X-Gm-Message-State: APjAAAWmZHvabrCZ7ahj7UhJ/rzfuYSZTQFPYTdhijUtQP+6F4TzgtoQ
        kRnqp3bDJUhXzsPloUQwy8P3YNyhSEg=
X-Google-Smtp-Source: APXvYqzHuYR6TbWlqoEybEBZEicLmHobDjV6Ss/jRzvFJOZT7YJeOyT4agpva4fS+Xly39s12MZRMg==
X-Received: by 2002:a17:90a:e28e:: with SMTP id d14mr979088pjz.56.1579647923174;
        Tue, 21 Jan 2020 15:05:23 -0800 (PST)
Received: from vader ([2620:10d:c090:200::d9ad])
        by smtp.gmail.com with ESMTPSA id i23sm43490023pfo.11.2020.01.21.15.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 15:05:22 -0800 (PST)
Date:   Tue, 21 Jan 2020 15:05:21 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>, "hch@lst.de" <hch@lst.de>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] Allowing linkat() to replace the destination
Message-ID: <20200121230521.GA394361@vader>
References: <20200117163616.GA282555@vader>
 <20200117165904.GN8904@ZenIV.linux.org.uk>
 <20200117172855.GA295250@vader>
 <20200117181730.GO8904@ZenIV.linux.org.uk>
 <20200117202219.GB295250@vader>
 <20200117222212.GP8904@ZenIV.linux.org.uk>
 <20200117235444.GC295250@vader>
 <20200118004738.GQ8904@ZenIV.linux.org.uk>
 <20200118011734.GD295250@vader>
 <20200118022032.GR8904@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200118022032.GR8904@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 18, 2020 at 02:20:32AM +0000, Al Viro wrote:
> On Fri, Jan 17, 2020 at 05:17:34PM -0800, Omar Sandoval wrote:
> > > No.  This is completely wrong; just make it ->link_replace() and be done
> > > with that; no extra arguments and *always* the same conditions wrt
> > > positive/negative.  One of the reasons why ->rename() tends to be
> > > ugly (and a source of quite a few bugs over years) are those "if
> > > target is positive/if target is negative" scattered over the instances.
> > > 
> > > Make the choice conditional upon the positivity of target.
> > 
> > Yup, you already convinced me that ->link_replace() is better in your
> > last email.
> 
> FWIW, that might be not so simple ;-/  Reason: NFS-like stuff.  Client
> sees a negative in cache; the problem is how to decide whether to
> tell the server "OK, I want normal link()" vs. "if it turns out that
> someone has created it by the time you see the request, give do
> a replacing link".  Sure, if could treat ->link() telling you -EEXIST
> as "OK, repeat it with ->link_replace(), then", but that's an extra
> roundtrip...

So that's a point in favor of ->link(). But then if we overload ->link()
instead of adding ->link_replace() and we want EOPNOTSUPP to fail fast,
we need to add something like FMODE_SUPPORTS_AT_REPLACE.

Some options I see are:

1. Go with ->link_replace() until network filesystem specs support
   AT_REPLACE. That would be a bit of a mess down the line, though.
2. Stick with ->link(), let the filesystem implementations deal with the
   positive targets, and add FMODE_SUPPORTS_AT_REPLACE so that feature
   detection remains easy for userspace.
3. Option 2, but don't bother with FMODE_SUPPORTS_AT_REPLACE.

FWIW, there is precendent for option 3: RENAME_EXCHANGE. That has the
same "files are the same" noop condition, and we don't know whether
RENAME_EXCHANGE is supported until ->rename(). A cursory search shows
that applications using RENAME_EXCHANGE try it and fall back to a
non-atomic exchange on EINVAL. They could do the exact same thing for
AT_REPLACE.

None of it is elegant, but which approach would you hate the least?
