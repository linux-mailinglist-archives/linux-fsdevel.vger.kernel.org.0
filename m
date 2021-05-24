Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA3E38E5F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 May 2021 13:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbhEXL7V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 May 2021 07:59:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24072 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232110AbhEXL7U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 May 2021 07:59:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621857472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gBjUa2nRpQaREb20KJBh+QSbceI06cH7v6nabFDej5s=;
        b=StK7uUhurmzdLvQmg8abBkZQXL6P7w4FBezyaRhNlW/tPsAPZCSWHUdjW9bd1nc/crzGTV
        uzufzjQq7DeBEI9ILhXX2gkCeHIJWawS1N5rhWnZJH3gx7PNUr+LvvkEPmhbfEa908eBY6
        wOWjLGFsoznNKxJiSBngW1NUbtVCGtg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-dtULvetwPPSQPIAdmJGr4g-1; Mon, 24 May 2021 07:57:50 -0400
X-MC-Unique: dtULvetwPPSQPIAdmJGr4g-1
Received: by mail-qt1-f199.google.com with SMTP id j12-20020ac8550c0000b02901dae492d1f2so23761940qtq.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 May 2021 04:57:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gBjUa2nRpQaREb20KJBh+QSbceI06cH7v6nabFDej5s=;
        b=EWYHpdTp/WFhEWHskPWju1I+0PJa4rXiaMaqyLi5x5hcIuVg1BXzd3bv9ZipW+cKGK
         HaA9LKO/MexYn1qzQ9levpMnOiGJCm1tk4g/k08hYayAK6uTQ2ctPXUAftAT+ctwKWlS
         jpE9vbzO4u60lYK2O/yN4QR9mqCzsMiEw9mtp9BiiRUOoni+bs7tkAiUYR6V/zCpTRHM
         ebepKWDUzzWLWqlikJ3YjJa5JHtSLmn8ZeJMuX/Cp7cS4gUL4b2rpEr1Bj39mYL5p1yi
         XjwczOk3qcDlhJE56LyizDB7qmiK3918T88z/GsujhmMWG4AcggbCBCHJothJzCdmHds
         EtzA==
X-Gm-Message-State: AOAM5302SiprHdfjkRZiciLy5IPPdOHevdHlfkFH7V3BqI5jq+iTzD3R
        iPtk88GViTFfywKkhcOK6Lewnsa9wWB9zFpsaHaBaU+5lePW180Z5RpSwum1xbEzdv/+bOeNQ5r
        tmAY5mC2zshOxOXl/0VUITsCF6A==
X-Received: by 2002:ac8:4b65:: with SMTP id g5mr26923004qts.99.1621857470374;
        Mon, 24 May 2021 04:57:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBCBqseIt59+zUqt1o7nZHyGZvBbkwn5pbUOW6+M5xCIus8gENm21ONFHmm0JTEzJubX+y6A==
X-Received: by 2002:ac8:4b65:: with SMTP id g5mr26922994qts.99.1621857470212;
        Mon, 24 May 2021 04:57:50 -0700 (PDT)
Received: from bfoster ([98.216.211.229])
        by smtp.gmail.com with ESMTPSA id l10sm10482883qtn.28.2021.05.24.04.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 04:57:49 -0700 (PDT)
Date:   Mon, 24 May 2021 07:57:48 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] iomap: resched ioend completion when in
 non-atomic context
Message-ID: <YKuUvHB6HUyQ6TWD@bfoster>
References: <20210517171722.1266878-1-bfoster@redhat.com>
 <20210517171722.1266878-2-bfoster@redhat.com>
 <YKi2hwnJMbLYtkmb@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKi2hwnJMbLYtkmb@T590>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 22, 2021 at 03:45:11PM +0800, Ming Lei wrote:
> On Mon, May 17, 2021 at 01:17:20PM -0400, Brian Foster wrote:
> > The iomap ioend mechanism has the ability to construct very large,
> > contiguous bios and/or bio chains. This has been reported to lead to
> 
> BTW, it is actually wrong to complete a large bio chains in
> iomap_finish_ioend(), which may risk in bio allocation deadlock, cause
> bio_alloc_bioset() relies on bio submission to make forward progress. But
> it becomes not true when all chained bios are freed just after the whole
> ioend is done since all chained bios(except for the one embedded in ioend)
> are allocated from same bioset(fs_bio_set).
> 

Interesting. Do you have a reproducer (or error report) for this? Is it
addressed by the next patch, or are further changes required?

Brian

> 
> Thanks,
> Ming
> 

