Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B5D6AE4A5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 16:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjCGP15 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Mar 2023 10:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjCGP1e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Mar 2023 10:27:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B911F8534C
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Mar 2023 07:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678202676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=49sjefw2FKulo5Vz5tQGPSxZQZKzbcJ05HQTQwuGmNA=;
        b=D1eyxs9bAARFNRvgXvwnib4Q/hCRT+6m4k5Ic32ilu0A9egPnA5crsKOrmiH08zr+9Dses
        iqDUwJ/pMRvd/VV5cWoxfzSSptgfFIhP2Ovx8gPUj/MszKKnU63vV+sby2Ju3J6ellN/Of
        6LVOs+HQxkY9uC9DCuRmNTlOguirVYA=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-qG3iF_FCNdaTlVF7GNU3-w-1; Tue, 07 Mar 2023 10:24:19 -0500
X-MC-Unique: qG3iF_FCNdaTlVF7GNU3-w-1
Received: by mail-pl1-f200.google.com with SMTP id t24-20020a1709028c9800b0019eaa064a51so5742285plo.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Mar 2023 07:24:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678202643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=49sjefw2FKulo5Vz5tQGPSxZQZKzbcJ05HQTQwuGmNA=;
        b=dCwULs+0qWoD87KAjs5aPk3Ju2mra9CxLGnBFni0JXi2ivzH+vF4hq9ucsQCQwvJK+
         9eldc2nrbl1Zrig8HH2pMxq4CF1IFbbHMYVrkDInWQJVl1Sl1fGZgcY5cy7flNDejMhu
         ffoYGUl5g/9f40qXfOR0LCelcK27gtyv+DJr00XV/BC8ceYoJU9xuHpCiPSZzUEl7JWu
         +Uy2u2TDGBhkjFRTHNs3HHKjtvB1AwArabVyOGuXEu3S4KB5ZGY8pbta1vGWw/UbbLSb
         U6XIrkSVe64AHGkr638ShKS8EuaPwZdhFwwdeWdcepGf9wQZ/HdiZlgze9Y0QYj+TkBp
         x9+w==
X-Gm-Message-State: AO0yUKX3gAyZKIIJaAuLEtL7Pxe9LcRKK1YHYjh8DwzST7k5LGduqAZC
        rP9TXS1Gsgi9QXv3HxkSCYkxu3gWYluWLfaeItwSJi5zDoj7BUPSvgrs//SHh0L6mmtsP+AB2ut
        wvbb4jsHU5ZQzCX6cgofLcXDC0TS6Bxz7te6dtpzi2A==
X-Received: by 2002:a17:902:f812:b0:19a:f153:b73e with SMTP id ix18-20020a170902f81200b0019af153b73emr5668635plb.4.1678202642957;
        Tue, 07 Mar 2023 07:24:02 -0800 (PST)
X-Google-Smtp-Source: AK7set9SWy5O05m3x1Ey9TSLMznr1jfUxFnvxAX39KEBXqqmaUx44UhyFFrhNGEtwClSqvzd8jjgUVc0X6h/fPAWheE=
X-Received: by 2002:a17:902:f812:b0:19a:f153:b73e with SMTP id
 ix18-20020a170902f81200b0019af153b73emr5668618plb.4.1678202642668; Tue, 07
 Mar 2023 07:24:02 -0800 (PST)
MIME-Version: 1.0
References: <20230307143410.28031-1-hch@lst.de>
In-Reply-To: <20230307143410.28031-1-hch@lst.de>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Tue, 7 Mar 2023 16:23:50 +0100
Message-ID: <CAHc6FU4G5S+5S+1OdatY3apQvmDcvzOQSPPPQdQZTwMNjSq5tw@mail.gmail.com>
Subject: Re: [Cluster-devel] return an ERR_PTR from __filemap_get_folio v3
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>, linux-xfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, cluster-devel@redhat.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 7, 2023 at 4:07=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrote=
:
> __filemap_get_folio and its wrappers can return NULL for three different
> conditions, which in some cases requires the caller to reverse engineer
> the decision making.  This is fixed by returning an ERR_PTR instead of
> NULL and thus transporting the reason for the failure.  But to make
> that work we first need to ensure that no xa_value special case is
> returned and thus return the FGP_ENTRY flag.  It turns out that flag
> is barely used and can usually be deal with in a better way.

Thanks for working on this cleanup; looking good at a first glance.

Andreas

