Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13710262829
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 09:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgIIHLd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 03:11:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59516 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725897AbgIIHJk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 03:09:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599635377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sbNdgPGbXHtzNZzICD+kjhviJAeGSAESo3O2fIQqjns=;
        b=iO84z27jpCNN3zPraC61ysbcmhTtf53E1Yp5lQiJ17aCOk91qHX0Bk1WwPAyFdYtUt3jXK
        QQxpzyYOBZS/dgKy8EFyKEFOifVQ6HKU0MLFeW0aosxam2YUxCi/Wh26TljJK4QR1N7wXn
        VdUY6dFj9hlCAVSro41EAHGMByww/L4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-kznVOHTNOEegMpQe3z10EA-1; Wed, 09 Sep 2020 03:09:34 -0400
X-MC-Unique: kznVOHTNOEegMpQe3z10EA-1
Received: by mail-wr1-f71.google.com with SMTP id b7so619495wrn.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2020 00:09:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sbNdgPGbXHtzNZzICD+kjhviJAeGSAESo3O2fIQqjns=;
        b=OR5u28oyu/r8ctn6axnokD2Wy/SD9w9fKjPDgf6fcKN+z0PkNX7VYNGBiSE7Rfyde7
         nasUyaJJQAb9mW6ZGvlw2NAnzsfus9uEZ6MGp747Q8bJZLDD+h7nrzMdyajUW8Jt/Q9K
         lGpj+R+JfRw/lQXX40h6/KrU7T8xGJ7VUyYUkYIW8d5mNx1YE4/T48sUAZ1eQynZRxmL
         /wNbfZu5f6bh1OvxdK4/bwvN2Sdm86j9sGl9oFOgP5MpDL9md7HvY+Q7rlpmbiHKdrsN
         uGFZK8Rz4q12TdXq7PN1xfmZdhwu9g6+eS4NRrJGICrEL6L0QbyKGO64frBybjKdjjgH
         /Mnw==
X-Gm-Message-State: AOAM532Eoa3MphBykKUDZfIOnAVN1Zbw8NQk0XFGUb5j1g9KlFvli2B2
        UJLdTCyA8G7a6+CY9fK3RWJyQMsHuiBpDg7lJE4T3O8YfO5a+C3HNpRsUQ+3Cb0z/vCIEZqUQf8
        2/QMTsnrY9yKp0TJowokc1Ol0jQ==
X-Received: by 2002:a7b:c015:: with SMTP id c21mr2067385wmb.87.1599635373596;
        Wed, 09 Sep 2020 00:09:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJLuHsYjEO/DZDcJ9fpG8m8GGKEsIJck/ZRUcpgnZH8FyK9x7ubj3A2yaHiurY8F0uZqsI3w==
X-Received: by 2002:a7b:c015:: with SMTP id c21mr2067369wmb.87.1599635373328;
        Wed, 09 Sep 2020 00:09:33 -0700 (PDT)
Received: from steredhat (host-79-53-225-185.retail.telecomitalia.it. [79.53.225.185])
        by smtp.gmail.com with ESMTPSA id t4sm2631177wrr.26.2020.09.09.00.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 00:09:32 -0700 (PDT)
Date:   Wed, 9 Sep 2020 09:09:30 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next] io_uring: return EBADFD when ring isn't in the
 right state
Message-ID: <20200909070930.mdbm7aeh7z5ckwhq@steredhat>
References: <20200908165242.124957-1-sgarzare@redhat.com>
 <6e119be3-d9a3-06ea-1c76-4201816dde46@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e119be3-d9a3-06ea-1c76-4201816dde46@kernel.dk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 08, 2020 at 11:02:48AM -0600, Jens Axboe wrote:
> On 9/8/20 10:52 AM, Stefano Garzarella wrote:
> > This patch uniforms the returned error (EBADFD) when the ring state
> > (enabled/disabled) is not the expected one.
> > 
> > The changes affect io_uring_enter() and io_uring_register() syscalls.
> 
> I added a Fixes line:
> 
> Fixes: 7ec3d1dd9378 ("io_uring: allow disabling rings during the creation")

Oh right, I forgot!

> 
> and applied it, thanks!
> 
> > https://github.com/stefano-garzarella/liburing (branch: fix-disabled-ring-error)
> 
> I'll check and pull that one too.
> 

Thanks,
Stefano

