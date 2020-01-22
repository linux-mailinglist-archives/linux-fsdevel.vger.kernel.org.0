Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE147145E63
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 23:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgAVWKG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jan 2020 17:10:06 -0500
Received: from mail-pf1-f171.google.com ([209.85.210.171]:43755 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgAVWKF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jan 2020 17:10:05 -0500
Received: by mail-pf1-f171.google.com with SMTP id x6so476157pfo.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2020 14:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2/Oo+qwfItMX28d8Mao3ZPtfhkPjIBHNr1wFzuUb/fg=;
        b=qxEXeWDfYvPncBRkPeQKfHuCfZYTyjItvXCbbpxK5z57+KEusPuZtTFzvScEgWxsjZ
         TvBV09T0B6U8FX0U62mxfn12g/VlOsyNqJd+LGHb97pUGHRwm5pEJksI1H7VH5M8yBQR
         2cVvzC98NZx+Y6FcnjWhpG4iXk2XoyidvQyCDUm/glFi5o68yl3GV0t0qcB1G3ddTumq
         t1ZLNjvvubFJu93oguIpGCgwksAxONYFDKPAeEffP5VZaUhJ9xTADRe1ROIEo1scG52o
         1PNfnP8nQpKuEAugz434K1/W0nd2RG15otVJrlT6KOndPtb9OKa14OXkp+QCLyL+unX3
         iwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2/Oo+qwfItMX28d8Mao3ZPtfhkPjIBHNr1wFzuUb/fg=;
        b=MJ6yDjVzezGkjUKbu5roGmbNrMuWMByWmTBWCQ9jGKNUk01u1MjnKVNuiDSuLDLXTn
         DrDJFuk36E/Ib7PZluaJx9LrU8ZNyh9k2J0XO6jwMK1X2BjM6Xveexfqxazw+DVewsu9
         uy7gnSqkuBu5b4RTv58VZ/sesIzf1MXtklhT2UDHFbA/8DFhLA+VvINZ+VPdOgED687J
         UVp5nGwrXraddM0/W0rwpg8iGsYfRgTLGXZiiDs/fNAwEtzPBk7qkW3ElmWd3NcsdNh3
         UOG1A807yXzJXOFuFXL0b5CJdXSDfNM4DVc2XdorkNXFu8pv5Av/bac6gU827mSUhxZ0
         +XPw==
X-Gm-Message-State: APjAAAUX8xvL5wqpXtIEwTSFg+puj+sM7/xwidNLJ7vuSce7yGxllkxB
        WE7plBdiiNZyCJGMwzuTv7veqw==
X-Google-Smtp-Source: APXvYqxR4tCYJNcxS4LDEVKY0Uxqtvb4ceoTdZTVrtN6W/2mq/GJKPpuiqdQSpBBLWEWVhwjcIDeUA==
X-Received: by 2002:aa7:8749:: with SMTP id g9mr4685916pfo.40.1579731004789;
        Wed, 22 Jan 2020 14:10:04 -0800 (PST)
Received: from vader ([2601:602:8b80:8e0:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id o10sm48344pgq.68.2020.01.22.14.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 14:10:04 -0800 (PST)
Date:   Wed, 22 Jan 2020 14:10:03 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>, "hch@lst.de" <hch@lst.de>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [LSF/MM/BPF TOPIC] Allowing linkat() to replace the destination
Message-ID: <20200122221003.GB394361@vader>
References: <20200117172855.GA295250@vader>
 <20200117181730.GO8904@ZenIV.linux.org.uk>
 <20200117202219.GB295250@vader>
 <20200117222212.GP8904@ZenIV.linux.org.uk>
 <20200117235444.GC295250@vader>
 <20200118004738.GQ8904@ZenIV.linux.org.uk>
 <20200118011734.GD295250@vader>
 <20200118022032.GR8904@ZenIV.linux.org.uk>
 <20200121230521.GA394361@vader>
 <CAOQ4uxgsoGMsNxhmtzZPqb+NshpJ3_P8vDiKpJFO5ZK25jZr0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgsoGMsNxhmtzZPqb+NshpJ3_P8vDiKpJFO5ZK25jZr0w@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 22, 2020 at 08:57:01AM +0200, Amir Goldstein wrote:
> On Wed, Jan 22, 2020 at 1:05 AM Omar Sandoval <osandov@osandov.com> wrote:
> >
> > On Sat, Jan 18, 2020 at 02:20:32AM +0000, Al Viro wrote:
> > > On Fri, Jan 17, 2020 at 05:17:34PM -0800, Omar Sandoval wrote:
> > > > > No.  This is completely wrong; just make it ->link_replace() and be done
> > > > > with that; no extra arguments and *always* the same conditions wrt
> > > > > positive/negative.  One of the reasons why ->rename() tends to be
> > > > > ugly (and a source of quite a few bugs over years) are those "if
> > > > > target is positive/if target is negative" scattered over the instances.
> > > > >
> > > > > Make the choice conditional upon the positivity of target.
> > > >
> > > > Yup, you already convinced me that ->link_replace() is better in your
> > > > last email.
> > >
> > > FWIW, that might be not so simple ;-/  Reason: NFS-like stuff.  Client
> > > sees a negative in cache; the problem is how to decide whether to
> > > tell the server "OK, I want normal link()" vs. "if it turns out that
> > > someone has created it by the time you see the request, give do
> > > a replacing link".  Sure, if could treat ->link() telling you -EEXIST
> > > as "OK, repeat it with ->link_replace(), then", but that's an extra
> > > roundtrip...
> >
> > So that's a point in favor of ->link(). But then if we overload ->link()
> > instead of adding ->link_replace() and we want EOPNOTSUPP to fail fast,
> > we need to add something like FMODE_SUPPORTS_AT_REPLACE.
> >
> > Some options I see are:
> >
> > 1. Go with ->link_replace() until network filesystem specs support
> >    AT_REPLACE. That would be a bit of a mess down the line, though.
> > 2. Stick with ->link(), let the filesystem implementations deal with the
> >    positive targets, and add FMODE_SUPPORTS_AT_REPLACE so that feature
> >    detection remains easy for userspace.
> 
> "detection remains easy..." why is this important?

As I mentioned, I don't think it's necessary given the precedent.
However, Al voiced some concern over this earlier in the thread:

---
> > >        7) how do users tell if filesystem supports that?  And no,
> > >references to pathconf, Cthulhu and other equally delightful entities
> > >are not really welcome.
> >
> > EOPNOTSUPP is probably the most helpful.
> 
> Umm...  What would you feed it, though?  You need to get past your
> "links to the same file, do nothing" escape...
---

> Do you know of a userspace application that would have a problem checking
> if AT_REPLACE works, fall back to whatever and never try it ever again?
> 
> Besides, when said application tried to open an O_TMPFILE and fail, it
> will have already detected a lot of the unsupported cases.
> Sorry for not reading all the thread again, some API questions:
> - We intend to allow AT_REPLACE only with O_TMPFILE src. Right?

I wasn't planning on having that restriction. It's not too much effort
for filesystems to support it for normal files, so I wouldn't want to
place an artificial restriction on a useful primitive.

> - Does AT_REPLACE assert that destination is positive? and if so why?

No, it should work like a normal link() if the destination doesn't
exist.

> The functionality that is complement to atomic rename would be atomic
> link, destination could be positive or negative, but end results will be
> that destination is positive with new inode.
> With those semantics, ->link_replace() makes much less sense IMO.
> 
> > 3. Option 2, but don't bother with FMODE_SUPPORTS_AT_REPLACE.
> >
> > FWIW, there is precendent for option 3: RENAME_EXCHANGE. That has the
> > same "files are the same" noop condition, and we don't know whether
> > RENAME_EXCHANGE is supported until ->rename(). A cursory search shows
> > that applications using RENAME_EXCHANGE try it and fall back to a
> > non-atomic exchange on EINVAL. They could do the exact same thing for
> > AT_REPLACE.
> >
> 
> That sounds like the most reasonable approach to me. Let's not over complicate.
> If you find that creates too much generic logic in ->link(), you can take
> the approach Darrick employed with generic_remap_file_range_prep() for
> filesystems that want to support AT_REPLACE. All other fs just need to check
> for valid flags mask, like the ->rename() precedent.
> 
> Another side discussion about passing AT_ flags down to filesystems.
> Traditionally, that was never done, until AT_STATX_ mixed vfs flags
> with filesystem flags on the same AT_ namespace.
> Now we have linkat() syscall that can take only AT_ vfs flags and
> renameat2() syscall that can take only RENAME_ filesystem flags not
> from the AT_ namespace.
> I feel that the situation of having AT_REPLACE API along with
> RENAME_EXCHANGE and RENAME_NOREPLACE is a bit awkward
> and some standardization is in order.
> 
> According to include/uapi/linux/fcntl.h, there is no numeric collision
> between the RENAME_ flag namepsace and AT_ flags namespace,
> although I do find it suspicious that AT_ flags start at 0x100...
> Could we define AT_RENAME_xxx RENAME_xxx flags and name the
> new flag AT_LINK_REPLACE, so it is a bit more clear that the flag
> is specific to link(2) syscall and not vfs generic AT_ flag.

Sure, I'll rename it to AT_LINK_REPLACE. AT_RENAME_xxx is probably for a
separate series.
