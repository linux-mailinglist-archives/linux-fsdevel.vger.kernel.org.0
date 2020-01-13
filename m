Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36390139C4E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2020 23:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbgAMWTe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jan 2020 17:19:34 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:41201 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgAMWTd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jan 2020 17:19:33 -0500
Received: by mail-il1-f194.google.com with SMTP id f10so9582268ils.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2020 14:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1bRlb8icLO9A3T9CUBl/y+fFvzY9LjvdXm5n3OeDKjc=;
        b=Dvw5S/ZKaOPQshFbiohKBvJWqhiCv2LLZFpqBW5hitEKxLq+JWKJlEphJEmAAsMOpQ
         pZlK2/LSYRsVrBkb2MhurRPVZxfP+ni2rbtQUGr3sHy1sKdoDmq2wxXtCqvMpxP2K16R
         q4AuF16H25ZEzKJuzbNWgBrzwlHSqpdcrVGJb6ZLEFX0CKaUawMW6UwPD6VbogPI5p1F
         Y2DVIzxrCUbRIEtDdDrXLxjN7kZtnuyljM4noA0ClQjmu3GWXIfA8H+e2oil7I3fRGHX
         /qm22hxKUFF2bxM/1tG0x+7Aez7n5nnBNMkXYfdwe9YFXkI87ET+2WSrdWwhh3DhtmCs
         Dh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1bRlb8icLO9A3T9CUBl/y+fFvzY9LjvdXm5n3OeDKjc=;
        b=sC5f/3m9A3ulQne9wYdlL2BNfE7hGHKjI17PU0qo2VttIhtx11OfFYcJDjfytAw+1z
         1U1Yejy5FSJOMwkcjLdxMagSdf/JMkJ5OnUxNgpSMpUr40TEgRQ+aGbrNL7IHwWNvDNx
         IfCwAOKmmwRiH1O23gJ85akBuFIGdyZNS182yRl6lyuEKjfFvGf+RlU+lfxj81UlARQG
         ArWSY8iEuveUgvfXKsfWAEPacmltrNRI8j3mTK2IzTkNTNcDlwnmbs7+wmYUkc0Ztu9d
         X/8Vf8BxRXxQ+Z/ztM3ukMlaP9rORj6Z4X7B3my8GwHd77gxodV21XBBsbG878F4kyZ0
         EJsA==
X-Gm-Message-State: APjAAAU+4PURQZsTZjTCXEyI66n1zR/b06GiYGeDrVnqTdEnhrgWyjEf
        oVhBOG2SEBFGwMwgTHEcD4pJrQ==
X-Google-Smtp-Source: APXvYqzO0GHbV0w/TmUPEhOW7PoX0tTib7NohzGu9yTqXinG8F1yldxNXPgqeMkVhNSZKFgvHTNGOw==
X-Received: by 2002:a92:8655:: with SMTP id g82mr656940ild.2.1578953973226;
        Mon, 13 Jan 2020 14:19:33 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f125sm4176309ilh.88.2020.01.13.14.19.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2020 14:19:32 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
Subject: Re: [RFC 0/8] Replacing the readpages a_op
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Chris Mason <clm@fb.com>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
References: <20200113153746.26654-1-willy@infradead.org>
 <6CA4CD96-0812-4261-8FF9-CD28AA2EC38A@fb.com>
 <20200113175436.GC332@bombadil.infradead.org>
Message-ID: <e1b7a95a-5d49-2053-a0b4-a26ea26ca798@kernel.dk>
Date:   Mon, 13 Jan 2020 15:19:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200113175436.GC332@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 13, 2020 at 10:54 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Jan 13, 2020 at 04:42:10PM +0000, Chris Mason wrote:
> > Btrfs basically does this now, honestly iomap isn't that far away.
> > Given how sensible iomap is for this, I'd rather see us pile into
> > that abstraction than try to pass pagevecs for large ranges.
> > Otherwise, if
>
> I completely misread this at first and thought you were proposing we
> pass a bio_vec to ->readahead.  Initially, this is a layering
> violation, completely unnecessary to have all these extra offset/size
> fields being allocated and passed around.  But ... the bio_vec and the
> skb_frag_t are now the same data structure, so both block and network
> use it.  It may make sense to have this as the common data structure
> for 'unit of IO'.  The bio supports having the bi_vec allocated
> externally to the data structure while the skbuff would need to copy
> the array.
>
> Maybe we need a more neutral name than bio_vec so as to not upset
> people.  page_frag, perhaps [1].
>
> [1] Yes, I know about the one in include/linux/mm_types_task.h

Note that bio_vecs support page merging, so page fragment isn't very
descriptive. Not sure what a good name would be, but fragment isn't it.
But any shared type would imply that others should support that as well
if you're passing it around (or by pointer).

-- 
Jens Axboe

