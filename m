Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C721DF2B1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 May 2020 01:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731261AbgEVXE6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 May 2020 19:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731342AbgEVXE6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 May 2020 19:04:58 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE30C08C5C0
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 16:04:58 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id cx22so5645212pjb.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 16:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pUaPVMC09hl06qSXUpE1EvRthGMUA9KIdvTwa/SNtao=;
        b=XIvrI1Age+qLhwfNd+lbSvQYGl4k+WJqvjNvrzTSDg0QHiALujGIk2KrgxJzZyOseb
         JekLWAP02WMFggjTtERAE/1CkVDaU8/NFvKT1QXQT6CgoSAh1H3XHPnfqdrXD1qYNHVV
         WG676jBogc7z1fZC/YRuTSzPBENYiLXZWtFlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pUaPVMC09hl06qSXUpE1EvRthGMUA9KIdvTwa/SNtao=;
        b=DkJW5+1P1/UbjN9cmGc+DCrsTtnU/CcXN/v8+lArrrbNveMd5DQXXePpQ0dx9R+j4j
         Ru7+tDsbkB+u3wr46hLzSvMpNbGDAG4M+KZFGxccvHsE9INCCuC1d5Fij5i6YWJIf90Q
         8Hm6qVbJigNuoSisdKB8y/eqF4bqGYA+8WoOvyyZ4AzJPD2tK2TFik/TE3y/vVdSawwf
         NUW9VZeSlvyq12ByAEO1C4dBtLNH5ilMEom2cfnuH5/ksy9G4Utyp3dHY12hL4M2VvIw
         ayW/sTuuX/cK/znlOGwHfpsz1CrisbFkDS6YYVbdbz2PTxZrCSZvX1vFImyuxhJuhiBp
         eLlg==
X-Gm-Message-State: AOAM530hOvslNicgA339J+2jVn8487pk3dAcuWqMpFHvOiz4EypI6EJI
        CO+k6g+HczvL8B5l02PvSoSfWw==
X-Google-Smtp-Source: ABdhPJyHbPJWn77LlmiUvns1tpgeNo5nU5pwSjXvY1wZUGSR98Pt3PhFX+KS7CqLzK9zvYsLOV5LZg==
X-Received: by 2002:a17:902:b787:: with SMTP id e7mr16308030pls.272.1590188697497;
        Fri, 22 May 2020 16:04:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id bu7sm6592929pjb.41.2020.05.22.16.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 16:04:56 -0700 (PDT)
Date:   Fri, 22 May 2020 16:04:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>, viro@zeniv.linux.org.uk,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        ebiederm@xmission.com, jeyu@kernel.org, jmorris@namei.org,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, nayna@linux.ibm.com,
        dan.carpenter@oracle.com, skhan@linuxfoundation.org,
        geert@linux-m68k.org, tglx@linutronix.de, bauerman@linux.ibm.com,
        dhowells@redhat.com, linux-integrity@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kexec@lists.infradead.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] fs: reduce export usage of kerne_read*() calls
Message-ID: <202005221551.5CA1372@keescook>
References: <20200513152108.25669-1-mcgrof@kernel.org>
 <20200513181736.GA24342@infradead.org>
 <20200515212933.GD11244@42.do-not-panic.com>
 <20200518062255.GB15641@infradead.org>
 <1589805462.5111.107.camel@linux.ibm.com>
 <7525ca03-def7-dfe2-80a9-25270cb0ae05@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7525ca03-def7-dfe2-80a9-25270cb0ae05@broadcom.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 22, 2020 at 03:24:32PM -0700, Scott Branden wrote:
> On 2020-05-18 5:37 a.m., Mimi Zohar wrote:
> > On Sun, 2020-05-17 at 23:22 -0700, Christoph Hellwig wrote:
> > > On Fri, May 15, 2020 at 09:29:33PM +0000, Luis Chamberlain wrote:
> > > > On Wed, May 13, 2020 at 11:17:36AM -0700, Christoph Hellwig wrote:
> > > > > Can you also move kernel_read_* out of fs.h?  That header gets pulled
> > > > > in just about everywhere and doesn't really need function not related
> > > > > to the general fs interface.
> > > > Sure, where should I dump these?
> > > Maybe a new linux/kernel_read_file.h?  Bonus points for a small top
> > > of the file comment explaining the point of the interface, which I
> > > still don't get :)
> > Instead of rolling your own method of having the kernel read a file,
> > which requires call specific security hooks, this interface provides a
> > single generic set of pre and post security hooks.  The
> > kernel_read_file_id enumeration permits the security hook to
> > differentiate between callers.
> > 
> > To comply with secure and trusted boot concepts, a file cannot be
> > accessible to the caller until after it has been measured and/or the
> > integrity (hash/signature) appraised.
> > 
> > In some cases, the file was previously read twice, first to measure
> > and/or appraise the file and then read again into a buffer for
> > use.  This interface reads the file into a buffer once, calls the
> > generic post security hook, before providing the buffer to the caller.
> >   (Note using firmware pre-allocated memory might be an issue.)
> > 
> > Partial reading firmware will result in needing to pre-read the entire
> > file, most likely on the security pre hook.
> The entire file may be very large and not fit into a buffer.
> Hence one of the reasons for a partial read of the file.
> For security purposes, you need to change your code to limit the amount
> of data it reads into a buffer at one time to not consume or run out of much
> memory.

Hm? That's not how whole-file hashing works. :)

These hooks need to finish their hashing and policy checking before they
can allow the rest of the code to move forward. (That's why it's a
security hook.) If kernel memory utilization is the primary concern,
then sure, things could be rearranged to do partial read and update the
hash incrementally, but the entire file still needs to be locked,
entirely hashed by hook, then read by the caller, then unlocked and
released.

So, if you want to have partial file reads work, you'll need to
rearchitect the way this works to avoid regressing the security coverage
of these operations.

So, probably, the code will look something like:


file = kernel_open_file_for_reading(...)
	file = open...
	disallow_writes(file);
	while (processed < size-of-file) {
		buf = read(file, size...)
		security_file_read_partial(buf)
	}
	ret = security_file_read_finished(file);
	if (ret < 0) {
		allow_writes(file);
		return PTR_ERR(ret);
	}
	return file;

while (processed < size-of-file) {
	buf = read(file, size...)
	firmware_send_partial(buf);
}

kernel_close_file_for_reading(file)
	allow_writes(file);


-- 
Kees Cook
