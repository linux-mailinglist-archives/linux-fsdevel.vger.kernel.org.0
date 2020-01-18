Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 357A0141563
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2020 02:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730516AbgARBRh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 20:17:37 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39557 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbgARBRg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 20:17:36 -0500
Received: by mail-pf1-f193.google.com with SMTP id q10so12727998pfs.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2020 17:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YAgSJpQdAUBX1ky7BTzIx+JJtsejycZLSS0usOix50Q=;
        b=wxpI6oZeELRGf8ky2OX64IK7ol/rEARwFCeq3bb6LUnpSjhG1H/3xNJj4kWs1YKa6Q
         pSICuz0yTvTr8cU16fEr55n4CCT5JDcmEUjuwoZLqmRy6l6xs8+WZU/g+hMz+xNF9pqw
         cwvcyfswmXvIZfGN0yfoi0ltEFpw3PO1bcGZFt7DbuQRDEhCCBRThkSzbQdpvdz2ooxy
         LIyIV3/kRNXBAyMExzNsLFQE4RPCWpoZnGSK2hgAwg5ckrkoipPaJ6YNjLzBO8HZrUKV
         l9tUnInMefjWGTJbZ/LbzKKk6qbOcQARvMUjcaWG3malP2LWY2GDQ3exkn5TZMCLNJX8
         2/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YAgSJpQdAUBX1ky7BTzIx+JJtsejycZLSS0usOix50Q=;
        b=lSiamYMMN4lov8HE/A2geGJgCdXmE4vdPKt17FXiXXk3teB3HQ5hnALUcSMoo17emd
         c8Nvzwm+q7GHCAoqV2OcE3Qh34lLUyxfpya4T4T9O4rfn2NtYuuwIoDzLbD3KR6BqWbt
         hn/a+x/TUkT6oGbZSMBdU7EYSr7g0vJKeBZt/vkwvGtEsf8Z3nZnnCwUR0eTd4wz9fvN
         NciIGoWBtyu4LuQrMEwhv5dEhHTnbJriqptshf7EMLyqXUaRRULlreX5eyxGW9zBOCkc
         S3fSnWYSCRMi3D5V/l1AiyThZ2iX1A2mAjGdpgariWGqHiBK3FmyoABpx4DivrLjRcok
         b0pA==
X-Gm-Message-State: APjAAAUtbhlKb2m9fsqAYNmIHAy/FlXvSijFQhvHxLcElgmVVwpK27mY
        Ft8dsinjRuY8bdpGomIv2fmgPA==
X-Google-Smtp-Source: APXvYqx8I2EECJPunfkxUP3yAH0N9M0bEcYHFGLMvdtCANCO3/3kYaDs3AqiKhIq1rjyAEEx/uxZ4w==
X-Received: by 2002:a63:6d8d:: with SMTP id i135mr48428716pgc.90.1579310256101;
        Fri, 17 Jan 2020 17:17:36 -0800 (PST)
Received: from vader ([2620:10d:c090:200::c6e6])
        by smtp.gmail.com with ESMTPSA id a15sm31559668pfh.169.2020.01.17.17.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 17:17:35 -0800 (PST)
Date:   Fri, 17 Jan 2020 17:17:34 -0800
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
Message-ID: <20200118011734.GD295250@vader>
References: <d2730b78cf0eac685c3719909df34d8d1b0bc347.camel@hammerspace.com>
 <20200117154657.GK8904@ZenIV.linux.org.uk>
 <20200117163616.GA282555@vader>
 <20200117165904.GN8904@ZenIV.linux.org.uk>
 <20200117172855.GA295250@vader>
 <20200117181730.GO8904@ZenIV.linux.org.uk>
 <20200117202219.GB295250@vader>
 <20200117222212.GP8904@ZenIV.linux.org.uk>
 <20200117235444.GC295250@vader>
 <20200118004738.GQ8904@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200118004738.GQ8904@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 18, 2020 at 12:47:38AM +0000, Al Viro wrote:
> On Fri, Jan 17, 2020 at 03:54:44PM -0800, Omar Sandoval wrote:
>  
> > > 	3) permission checks need to be specified
> > 
> > I believe the only difference here vs standard linkat is that newpath
> > must not be immutable or append-only?
> 
> I would bloody hope not - at the very least you want sticky bit on parent
> to have effect, same as with rename()/rmdir()/unlink()...

Right, I should've reread may_delete(). I'll document that, too.

> > > references to pathconf, Cthulhu and other equally delightful entities
> > > are not really welcome.
> > 
> > EOPNOTSUPP is probably the most helpful.
> 
> Umm...  What would you feed it, though?  You need to get past your
> "links to the same file, do nothing" escape...

I think what you're getting at is that we can make this easier by
failing linkat AT_REPLACE very early if the filesystem doesn't have a
->link_replace(). Namely, if the filesystem doesn't support AT_REPLACE
but we still allow the "same file" or "newpath doesn't exist" cases to
succeed, then feature detection gets annoying.

As long as that's right, then applications can do the usual "try the new
feature or fall back" pattern that they do for fallocate modes and such.

> > Based on my previous attempt at it [1], it's not too bad.
> 
> +                       error = may_delete(dir, new_dentry, d_is_dir(old_dentry));                                       
> 
> Why bother with d_is_dir(), when you are going to reject directories
> anyway?
> 
> +       if (dir->i_op->link)                                                                                             
> +               error = dir->i_op->link(old_dentry, dir, new_dentry);                                                    
> +       else                                                                                                             
> +               error = dir->i_op->link2(old_dentry, dir, new_dentry, flags);                                            
> +       if (error)                                                                                                       
> +               goto out;                                                                                                
> +                                                                                                                        
> 
> No.  This is completely wrong; just make it ->link_replace() and be done
> with that; no extra arguments and *always* the same conditions wrt
> positive/negative.  One of the reasons why ->rename() tends to be
> ugly (and a source of quite a few bugs over years) are those "if
> target is positive/if target is negative" scattered over the instances.
> 
> Make the choice conditional upon the positivity of target.

Yup, you already convinced me that ->link_replace() is better in your
last email.

> And you don't need to reproduce every quirk of rename() error values.
> Really.  Unless you really intend to have userland do a loop of
> linkat(2) attempts (a-la mkstemp(3)), followed by rename(2) for
> fallback...

Understood, thanks. I'll get this all cleaned up and resent next week.
