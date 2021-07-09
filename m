Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4D53C2290
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jul 2021 13:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbhGILKb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jul 2021 07:10:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29118 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230180AbhGILKb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jul 2021 07:10:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625828867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xYve4Fb1ntFTWux0G1qTIZ2JxizD+hkq0PRHg0flbPs=;
        b=ZCZWZCrWv1yAxCY9bHdyE8f85aLrt7cKyRoouPa1p0QuV0G+mATcgWkrLrPgQN0jODZwUk
        ygV0ir5i2mFkpfshXQ6b/hSanmMiac6e2zm6deJnjPJ2EreWRPxjNtyvokLc37FhgVASOR
        pldTzBME05yvBORKGlfBBVBVw2lco0U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-GyF4vTlZPwWtCC76Rag3hg-1; Fri, 09 Jul 2021 07:07:46 -0400
X-MC-Unique: GyF4vTlZPwWtCC76Rag3hg-1
Received: by mail-wr1-f70.google.com with SMTP id i10-20020a5d55ca0000b029013b976502b6so1323099wrw.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jul 2021 04:07:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xYve4Fb1ntFTWux0G1qTIZ2JxizD+hkq0PRHg0flbPs=;
        b=I5FiiblteoSudhAFrKYPY7E+qKNroAKaW30Q1Ltu9HlKpw7AKJUB2F7SeYrU8qVYxN
         G5SvI+FWtob/avgLSftPW/Q552N7mlF24MfXJBmwSEkO4I45CuHksw4Pq0BD3Xx+umzA
         mFAQOb7Og0d9lcRXHuaZQtwOWvi/Y5/Oihan4o9ObCUxTlZB9dDiLVZEXzDeMW25LEps
         rr7f3dJyXcSlzlPTZWDpoByjuaaWBc4+xpy35rJs7rCewc7Etyong56uDabODTFAVibg
         9pvplmGWUpZNZEz8+WSZfdMsDeV1w1OTV4jfPCw+HofYAgFJVvTSY5bMlG4osaSUp/f5
         PMTA==
X-Gm-Message-State: AOAM530FFFAQoX3ydCTjBP2hmvlySVZmJIsW8qq7Se0w1GJxTmou9Nwn
        urRrRzAd6yCFHe79lNKlQUthwY3G5AoqBaLAiVov9RNzrV2L3NJQ0k2xk+W88zn0I1Lv1UVpWfQ
        xQHuzXIQSwIiBW0XmngYLpNgEgNRbRV2VTa34B4HSrg==
X-Received: by 2002:a5d:64e4:: with SMTP id g4mr34081966wri.377.1625828865437;
        Fri, 09 Jul 2021 04:07:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzZtBvY49sytJNLAgopkmB9OwR4IxiUX+hELjXilJXJ1NRRzW3Ct/VhrnDt5ViyteCotEe0E+oTQmh13qeHuc=
X-Received: by 2002:a5d:64e4:: with SMTP id g4mr34081948wri.377.1625828865289;
 Fri, 09 Jul 2021 04:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210707115524.2242151-1-agruenba@redhat.com> <20210707115524.2242151-4-agruenba@redhat.com>
 <20210709042934.GV11588@locust>
In-Reply-To: <20210709042934.GV11588@locust>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Fri, 9 Jul 2021 13:07:34 +0200
Message-ID: <CAHc6FU5xLZvZ94XTxGeobZ7qebG+tsGd7qkJxnfpvF17YTUSbA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] iomap: Don't create iomap_page objects in iomap_page_mkwrite_actor
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        cluster-devel <cluster-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 9, 2021 at 6:29 AM Darrick J. Wong <djwong@kernel.org> wrote:
> On Wed, Jul 07, 2021 at 01:55:24PM +0200, Andreas Gruenbacher wrote:
> > Now that we create those objects in iomap_writepage_map when needed,
> > there's no need to pre-create them in iomap_page_mkwrite_actor anymore.
> >
> > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
>
> I'd like to stage this series as a bugfix branch against -rc1 next week,
> if there are no other objections?

Yes, that would help a lot, thanks.

Andreas

