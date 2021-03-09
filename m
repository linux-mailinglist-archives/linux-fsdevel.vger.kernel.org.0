Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D944332F15
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Mar 2021 20:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbhCITfd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Mar 2021 14:35:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23875 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230266AbhCITfB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Mar 2021 14:35:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615318501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0Efq/XdZADcIcPCwsZh2URVLR5lQJ44Ni5hT8xLHIW0=;
        b=Wypd68V7AleSSrKxH0YkNACj65PtGhNaWuye/yh/NUIT5DBd7FDoijItCwLqmceboTxBNl
        fZvs2JEUnuBf5mL0Y2aMwvx3OUOr6SR/Se529VVu6l9oCn6HEG55dGJb6/WdYl0ILeMSru
        8Rbbvb8rh6nI8r2jAqU3IVIOzsZ8I1U=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-jcL3BiIlNq6YGEKc3i2czQ-1; Tue, 09 Mar 2021 14:34:57 -0500
X-MC-Unique: jcL3BiIlNq6YGEKc3i2czQ-1
Received: by mail-pf1-f200.google.com with SMTP id t13so9055954pfg.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Mar 2021 11:34:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0Efq/XdZADcIcPCwsZh2URVLR5lQJ44Ni5hT8xLHIW0=;
        b=GBaphSRcJ5DOkw+vRuoQystpFSigRfypeRRLHG8px25DIWd6lmiMkN0PaFKH0Aor6q
         C5RwFTZP5HvYuY7UAh2Wpnu5gzGteIZ6Js1E0VEz54LuD195YlYRTlzyblGl+Bjmqn6J
         ezztprclmbQYGDa6meCofTFirsmm+oG0wWdS1LAIvBvgj/vRmvwBB8+5JTLjRAcJFILI
         GvoazSlA5P5Csv3K8vBawd/ELwHvjRg6jt8K7kMSU8REskIqZOxnlGr404rVH9N4kN+e
         d2ym9LPEvdb6+FKJohLFd3dmrtDZisrU95XyGqtgWaNGlJLxJ/P7O5z+S/HFvUZRd+3r
         ynyA==
X-Gm-Message-State: AOAM533PxLrg+6vsPNwiWIUbi8egtO/q2oo4MLxEwlbmWeGBvEtB0Utg
        jo5oJHiEnPSYST6j/rLg3T530n0UIDg/9Eklbo266FRIlqwSj5NUFBzo8HazFoAocYlj3gY7Rv7
        g/471chMbJMRDkacvVwlfOwI2uA==
X-Received: by 2002:aa7:9910:0:b029:1f1:b41b:f95c with SMTP id z16-20020aa799100000b02901f1b41bf95cmr16633068pff.5.1615318496366;
        Tue, 09 Mar 2021 11:34:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzEm2SCLdiAFQWg7SaJuVodSLt/bg3Ucx4zEwtP8tgO/rpA7knG+uMEuOT6zr7D47BEOpBgZw==
X-Received: by 2002:aa7:9910:0:b029:1f1:b41b:f95c with SMTP id z16-20020aa799100000b02901f1b41bf95cmr16633059pff.5.1615318496200;
        Tue, 09 Mar 2021 11:34:56 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id gw20sm3591571pjb.3.2021.03.09.11.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 11:34:55 -0800 (PST)
Date:   Wed, 10 Mar 2021 03:34:41 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Vetter <daniel@ffwll.ch>, Nadav Amit <namit@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/9] fs: add an argument-less alloc_anon_inode
Message-ID: <20210309193441.GB3958006@xiangao.remote.csb>
References: <20210309155348.974875-1-hch@lst.de>
 <20210309155348.974875-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210309155348.974875-3-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 09, 2021 at 04:53:41PM +0100, Christoph Hellwig wrote:
> Add a new alloc_anon_inode helper that allocates an inode on
> the anon_inode file system.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Gao Xiang <hsiangkao@redhat.com>

Thanks,
Gao Xiang

