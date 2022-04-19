Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496FA5071A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 17:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353804AbiDSP1M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 11:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353800AbiDSP1I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 11:27:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EBC3B38BFF
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 08:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650381865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cp3erbdHIxI8pbHHBBO/snHJsYK0Yd+hp7YCIMU9Eq0=;
        b=Xy0GW3KsRwmiIRISsOAcCStG8n80y6s6zIXjTIZ49mvBa9OaPnRB6Ag2QPXZ0Tzl13z66e
        YkeCXn+eeomq4cLEouXR0dUWuuc9tMPdPGKE/fwHRF7z21oRBzuwMUE++ozgv7XDWvCQmF
        ijYE1r/sa3uhzTGydJLUBIoxGUEjL+g=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-675-erH0eytgOp6GgGWHRapaQA-1; Tue, 19 Apr 2022 11:24:20 -0400
X-MC-Unique: erH0eytgOp6GgGWHRapaQA-1
Received: by mail-ej1-f69.google.com with SMTP id qa31-20020a170907869f00b006ef7a20fdc6so2696406ejc.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 08:24:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cp3erbdHIxI8pbHHBBO/snHJsYK0Yd+hp7YCIMU9Eq0=;
        b=dQzCBZ3sEzKlR4/S/+Eeigy+t16Vp1gn1UZGKeOiH2rUxWHaD+D6KM80DYIQS6TeRn
         Pee15SIigfx4ja7P3mWcfaTTOo6gv8ShSXaD4LiUFgRfoF4e2y9V4dGFuR8rIHYGT6KD
         vn2Aw1G9ytG/H9ptb93NMZnWWsC7WwrRwbOWrfittjaOCE1mGCZjlTqJCOjWfivKUagB
         HPkH5nTlh7GpecKEBfnyrE1EsDS+j7fhXIIOuUgQLTIOHqRuIrdCtNVO3x24jgdPB/kP
         XSKGM/fGyzfo/CqwhfO15VpemSN39YVKsb5uRT39yKPfBP6m3OYh8cd8oplipMHXTRqW
         yBVg==
X-Gm-Message-State: AOAM5304j+0YH//O6vcbGvyIC+0X/bMSL/wefQRtj5Uwj7jT0dI74CKS
        CkZs7LfcSg11qVd/rYTDnAAGUNyWBh5xldNrVNWhon+cFmKM+e+/M0YJdHNQK9Pu8S0KDq8Mxe2
        aGvatSSSu3ODsV66Hry04XGTVQpTym+uX2Cml08nBZQ==
X-Received: by 2002:a17:907:8a03:b0:6ec:8197:e8ac with SMTP id sc3-20020a1709078a0300b006ec8197e8acmr13305416ejc.379.1650381859447;
        Tue, 19 Apr 2022 08:24:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEV2IgUHFtehd7uHS7lnxS/tYG3PBuNMrvIeNlWN6+XHPGaya3+IKBxGf3ipbReX5cmQisNirCElxQhR5nhVo=
X-Received: by 2002:a17:907:8a03:b0:6ec:8197:e8ac with SMTP id
 sc3-20020a1709078a0300b006ec8197e8acmr13305391ejc.379.1650381859157; Tue, 19
 Apr 2022 08:24:19 -0700 (PDT)
MIME-Version: 1.0
References: <YlWWbpW5Foynjllo@rabbit.intern.cm-ag> <454834.1650373340@warthog.procyon.org.uk>
 <Yl7EyMLnqqDv63yW@rabbit.intern.cm-ag>
In-Reply-To: <Yl7EyMLnqqDv63yW@rabbit.intern.cm-ag>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Tue, 19 Apr 2022 11:23:42 -0400
Message-ID: <CALF+zOnxxvDPd6L=W6N0WnS_jbYLBDfENKTousT36jQ37h_Vnw@mail.gmail.com>
Subject: Re: [Linux-cachefs] fscache corruption in Linux 5.17?
To:     Max Kellermann <mk@cm4all.com>
Cc:     David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-cachefs <linux-cachefs@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 19, 2022 at 10:19 AM Max Kellermann <mk@cm4all.com> wrote:
>
> On 2022/04/19 15:02, David Howells <dhowells@redhat.com> wrote:
> > I presume you are actually using a cache?
>
> Yes, see:
>
> On 2022/04/12 17:10, Max Kellermann <max@rabbit.intern.cm-ag> wrote:
> > All web servers mount a storage via NFSv3 with fscache.
>
> At least one web server is still in this broken state right now.  So
> if you need anything from that server, tell me, and I'll get it.
>
> I will need to downgrade to 5.16 tomorrow to get rid of the corruption
> bug (I've delayed this for a week, waiting for your reply).  After
> tomorrow, I can no longer help debugging this.
>
> Max
>

FWIW, I just noticed one of my unit tests is failing with data
corruption with NFSv3 only (NFS4.x does not fail) on 5.18.0-rc3 - not
sure how repeatable it is.
I'll see what I can find out.

