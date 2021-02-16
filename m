Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA5531C955
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 12:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhBPLFL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 06:05:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43869 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230232AbhBPLDH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 06:03:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613473282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UjPevUc/f1h27YC/iWCBse0mv72F3ucIKOdIwEX5LG8=;
        b=AvkgOPp+DBPc0FrKWJwDubOtuTW7N7QZR8zo7kgmXnXHIMctpATd5nCqJxHvmK79+qP+s2
        P2dvCOwOuspzHa8D9x+3Z2BShEWiivzSmv4nj2i+hOXHyXL4DuFXTaDgfZ1qTrAhE669IH
        yYZhIxt6TEZ6qc+Gby+0O1WX0NUh1rg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-i0K3DmJAPH6KYOj7Vu-dsA-1; Tue, 16 Feb 2021 06:01:21 -0500
X-MC-Unique: i0K3DmJAPH6KYOj7Vu-dsA-1
Received: by mail-qt1-f200.google.com with SMTP id o90so7457647qtd.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Feb 2021 03:01:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=UjPevUc/f1h27YC/iWCBse0mv72F3ucIKOdIwEX5LG8=;
        b=Fh+F+zASuIeHpVc4K1eVFMOIs8a3GDne1l4h6ZhwrQ0f73FIbdGMiv8MdNYhJdVLEX
         s7MyErxLqkKHGzClfYGA/QdC0+/9VLtM42kx2wndcxKQh0IVuvNuyDCwUa0vbLs8igvh
         bptQtbODippO2ahV6awDBSZ2LmT8l4IHvmisTihYK4dzH1/pNu4nwghhsmtGF9rQs19w
         O5QWnLVqcm3rEqPAVoN2XdYXc/6zwhm+TwSs0Wb0knkB7Du7Odi+JPQtj1165utxC+dd
         DsG89PyimLwWEWYYMUBgafKXWunyMqFONloGpbn1fceQcppspnh+IwrSVvsXFTS4SIGI
         C6fg==
X-Gm-Message-State: AOAM531tiDSakngAfxKuMgQ6m/RpklE51Q7A1pXd8AJUt4jY19OcZICE
        ZXfqFNuv6st+py3UkMt0IFVDpdvA+9pB6J0gMXK5wTTVx/E1h43S5u2pYMO/LLWSxtQOpINTjX7
        1UGhY3Tjrmrvn3AzNchaBGrj7YA==
X-Received: by 2002:a05:6214:292:: with SMTP id l18mr19206680qvv.5.1613473277870;
        Tue, 16 Feb 2021 03:01:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwfxkMdLP8GICFrYv5qcHZzcwXchEHaGAgSDG1h4XsMOzzlGSXOw3kqQRk/cyROnYM/B9O9Vw==
X-Received: by 2002:a05:6214:292:: with SMTP id l18mr19206653qvv.5.1613473277670;
        Tue, 16 Feb 2021 03:01:17 -0800 (PST)
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id n5sm13100571qtd.5.2021.02.16.03.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 03:01:17 -0800 (PST)
Message-ID: <752a8c91b7a418fa52cb8a8f28cb30155a574904.camel@redhat.com>
Subject: Re: [PATCH 00/33] Network fs helper library & fscache kiocb API
 [ver #3]
From:   Jeff Layton <jlayton@redhat.com>
To:     Steve French <smfrench@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        CIFS <linux-cifs@vger.kernel.org>, ceph-devel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>, linux-cachefs@redhat.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-mm <linux-mm@kvack.org>, linux-afs@lists.infradead.org,
        v9fs-developer@lists.sourceforge.net,
        Christoph Hellwig <hch@lst.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Wysochanski <dwysocha@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 16 Feb 2021 06:01:16 -0500
In-Reply-To: <CAH2r5mvPLivjuE=cbijzGSHOvx-hkWSWbcxpoBnJX-BR9pBskQ@mail.gmail.com>
References: <161340385320.1303470.2392622971006879777.stgit@warthog.procyon.org.uk>
         <9e49f96cd80eaf9c8ed267a7fbbcb4c6467ee790.camel@redhat.com>
         <CAH2r5mvPLivjuE=cbijzGSHOvx-hkWSWbcxpoBnJX-BR9pBskQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2021-02-15 at 18:40 -0600, Steve French wrote:
> Jeff,
> What are the performance differences you are seeing (positive or
> negative) with ceph and netfs, especially with simple examples like
> file copy or grep of large files?
> 
> It could be good if netfs simplifies the problem experienced by
> network filesystems on Linux with readahead on large sequential reads
> - where we don't get as much parallelism due to only having one
> readahead request at a time (thus in many cases there is 'dead time'
> on either the network or the file server while waiting for the next
> readpages request to be issued).   This can be a significant
> performance problem for current readpages when network latency is long
> (or e.g. in cases when network encryption is enabled, and hardware
> offload not available so time consuming on the server or client to
> encrypt the packet).
> 
> Do you see netfs much faster than currentreadpages for ceph?
> 
> Have you been able to get much benefit from throttling readahead with
> ceph from the current netfs approach for clamping i/o?
> 

I haven't seen big performance differences at all with this set. It's
pretty much a wash, and it doesn't seem to change how the I/Os are
ultimately driven on the wire. For instance, the clamp_length op
basically just mirrors what ceph does today -- it ensures that the
length of the I/O can't go past the end of the current object.

The main benefits are that we get a large swath of readpage, readpages
amd write_begin code out of ceph altogether. All of the netfs's need to
gather and vet pages for I/O, etc. Most of that doesn't have anything to
do with the filesystem itself. By offloading that into the netfs lib,
most of that is taken care of for us and we don't need to bother with
doing that ourselves.

-- 
Jeff Layton <jlayton@redhat.com>

