Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A169D441DCA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Nov 2021 17:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbhKAQPb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Nov 2021 12:15:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58528 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232478AbhKAQPa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Nov 2021 12:15:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635783176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+G6SzjVTR+LCyYNlG0zbcp2+gduPxDNU+2Zc+nwBRpo=;
        b=OSGCzH7a9iwXipiTHXUGo0ViW4DQj+HOpxAD9jdj6SQT3OMsIMINUJqLIoxrv37CEdPivy
        BBYalGl+Hf/j1rPWI5ToSbwXQmb4zIXtemJC726Rt+HykiFddlTIctqsfIt08KH+Wtk5NW
        nmF8FM6EQKMZHFJ7vPOmuIz1BuWLhjk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-QwIbFUFHPvK-rEVlCGY7TA-1; Mon, 01 Nov 2021 12:12:55 -0400
X-MC-Unique: QwIbFUFHPvK-rEVlCGY7TA-1
Received: by mail-qv1-f71.google.com with SMTP id o15-20020a0cc38f000000b0038455e36f89so16724278qvi.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Nov 2021 09:12:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+G6SzjVTR+LCyYNlG0zbcp2+gduPxDNU+2Zc+nwBRpo=;
        b=vNDVVyaEpAugWR6q9tfAHcWg2zCLvKp+tgzJGNcT5In1dDl0nqQ3a4Ium/+8XEtQZX
         D31DlrVnQpG/1RPXVhd9nxV36fmVm1nQDU+imlgl8yAYo1gEJmevZgX7j0wAvnUTNZUC
         A2qFR4cSdTCwKmgGB28f1OfILGIGU8MxfonK9so2odM2XYQ4k06DrUKf9qlJNW3I5WKF
         rdKBNnwgHCnPSNdXTXMssxtPtbkcTCYCPBh4MHm8Hv0/kGwbN2H+pi3+XJBOnETqca1t
         AdAe3OQeKQSjtEEL+/vxVNjmXZm19HO4AHtAxgbqRbVnDZdsIiuHstwdiz87xplVG//T
         kQpw==
X-Gm-Message-State: AOAM532Gl06VGzOZjV4pPN/C9PZt/DOXehk6vNTwRG54aIUxlPR12Cgr
        D+H1AsSp156SGK/c1Hg8csN/UGTC2Uokkh2/4ZOCrQ0nWTDnqOddtZbfvtePtA67ZWhAx7+9gOi
        U9H7KtB3J64MTRVdEBRQQgTy4
X-Received: by 2002:a0c:e708:: with SMTP id d8mr23264796qvn.62.1635783175420;
        Mon, 01 Nov 2021 09:12:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/H7B1fdn7PP13//AwKmpta1av9FRTtOajPRoBskVHgoJcCnXd+0D44u/s4udzcALoTqA+Rw==
X-Received: by 2002:a0c:e708:: with SMTP id d8mr23264758qvn.62.1635783175189;
        Mon, 01 Nov 2021 09:12:55 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id v16sm167031qtw.90.2021.11.01.09.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 09:12:54 -0700 (PDT)
Date:   Mon, 1 Nov 2021 12:12:53 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, Ira Weiny <ira.weiny@intel.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 01/11] dm: make the DAX support dependend on CONFIG_FS_DAX
Message-ID: <YYASBVuorCedsnRL@redhat.com>
References: <20211018044054.1779424-1-hch@lst.de>
 <20211018044054.1779424-2-hch@lst.de>
 <CAPcyv4hrEPizMOH-XhCqh=23EJDG=W6VwvQ1pVstfe-Jm-AsiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hrEPizMOH-XhCqh=23EJDG=W6VwvQ1pVstfe-Jm-AsiQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 27 2021 at  4:53P -0400,
Dan Williams <dan.j.williams@intel.com> wrote:

> On Sun, Oct 17, 2021 at 9:41 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > The device mapper DAX support is all hanging off a block device and thus
> > can't be used with device dax.  Make it depend on CONFIG_FS_DAX instead
> > of CONFIG_DAX_DRIVER.  This also means that bdev_dax_pgoff only needs to
> > be built under CONFIG_FS_DAX now.
> 
> Looks good.
> 
> Mike, can I get an ack to take this through nvdimm.git? (you'll likely
> see me repeat this question on subsequent patches in this series).

Sorry for late reply, but I see you punted on pushing for 5.16 merge
anyway (I'm sure my lack of response didn't help, sorry about that).

Acked-by: Mike Snitzer <snitzer@redhat.com>

Thanks!

