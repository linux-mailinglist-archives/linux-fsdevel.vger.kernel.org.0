Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406D669EFA2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Feb 2023 08:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjBVHx7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Feb 2023 02:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbjBVHx6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Feb 2023 02:53:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C680E29425
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Feb 2023 23:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677052388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ljX43G0wEY8L63/ppMMsMkg7cRFEwM1I5WynBYgGF5o=;
        b=ZF0OSg9qYp3eGXbcDfltZ5+Yz5QHm2ahcT9lBgfVdeX5s1jzCITNZiUfmdWR9yT01+aIOE
        Wgs2DLVvpfM+HxgGtpDcBEWbJTH+zPfWmGaJSh2FUoA0WCGGZiNUE21nXjzN053RzRqlpm
        OLnwwFlHvSSd2L1/nOM9mwPnOz7wc0w=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-220-TS5PW8-_P-2z39tm3I421w-1; Wed, 22 Feb 2023 02:53:06 -0500
X-MC-Unique: TS5PW8-_P-2z39tm3I421w-1
Received: by mail-pl1-f198.google.com with SMTP id q5-20020a170902788500b0019b0c60afa8so4405089pll.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Feb 2023 23:53:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677052385;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ljX43G0wEY8L63/ppMMsMkg7cRFEwM1I5WynBYgGF5o=;
        b=vU+iYM1sOjW3HeTS6aFlxnPebspK17HqVOlDovMTMzgSEWqw2eUcYU08iyMqgwg94u
         eL1mtPWjt/VPKGLue0bWF/uVPVcP9mZuok4bfCX3aSCXClef1brzXtylZ1Vr7duNRrcw
         2H8TywiAHajwykeUIEUsWggqFA4TYjUxk/DMXoCYFvKzEsrvpYt6afK8ktttFf4ojPxW
         7WFx5Y+q4osrNa4MXTmJyn90rek+JwXeMmrF0Fp2ZaxzN6TZP+KToh6LOnx0HDlv2Up6
         q3O7bhA/aO4xMM7q71W6EKDmZU1EmAaVujWpHPHwEBahFEN1iIpS6t+32MnPEyvV1Uze
         Qltg==
X-Gm-Message-State: AO0yUKWJ3rHPkeKf13eMBkZHukqtCWemBIgOrDrHA+apgzIRNJccM/uu
        YYx2u4xwMDohwGqhR8zThicXFppKzNUWpHZqgU3QXs6UIv2I7WW16tMUT0pDxzoCO1kfkpkC3po
        /hxhMHSmYnSc7O6R8KFbDfR8dK5225+oS2+8CTUCo+g==
X-Received: by 2002:a62:e906:0:b0:5a8:c0e0:3b2 with SMTP id j6-20020a62e906000000b005a8c0e003b2mr1331077pfh.45.1677052385599;
        Tue, 21 Feb 2023 23:53:05 -0800 (PST)
X-Google-Smtp-Source: AK7set/h+aPFUm4SbrYbWk3iTTUpShGxZ6VUSjD4ik+PIQ2xgY3zYr2/zd6r5vbnkirTo15iRgIAj/K7nLMGyrknNUw=
X-Received: by 2002:a62:e906:0:b0:5a8:c0e0:3b2 with SMTP id
 j6-20020a62e906000000b005a8c0e003b2mr1331073pfh.45.1677052385289; Tue, 21 Feb
 2023 23:53:05 -0800 (PST)
MIME-Version: 1.0
References: <20230210145823.756906-1-omosnace@redhat.com> <63f500ba.170a0220.c76fc.1642@mx.google.com>
 <Y/U5X5F0iFcpLwRK@bombadil.infradead.org>
In-Reply-To: <Y/U5X5F0iFcpLwRK@bombadil.infradead.org>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 22 Feb 2023 08:52:53 +0100
Message-ID: <CAFqZXNtK=y=V9_R0PWh1svkKzkotEtUiH-o2whWy=TdYiqfLCg@mail.gmail.com>
Subject: Re: [PATCH] sysctl: fix proc_dobool() usability
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 21, 2023 at 11:04 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> On Tue, Feb 21, 2023 at 09:34:49AM -0800, Kees Cook wrote:
> > On Fri, Feb 10, 2023 at 03:58:23PM +0100, Ondrej Mosnacek wrote:
> > > Currently proc_dobool expects a (bool *) in table->data, but sizeof(int)
> > > in table->maxsize, because it uses do_proc_dointvec() directly.
> > >
> > > This is unsafe for at least two reasons:
> > > 1. A sysctl table definition may use { .data = &variable, .maxsize =
> > >    sizeof(variable) }, not realizing that this makes the sysctl unusable
> > >    (see the Fixes: tag) and that they need to use the completely
> > >    counterintuitive sizeof(int) instead.
> > > 2. proc_dobool() will currently try to parse an array of values if given
> > >    .maxsize >= 2*sizeof(int), but will try to write values of type bool
> > >    by offsets of sizeof(int), so it will not work correctly with neither
> > >    an (int *) nor a (bool *). There is no .maxsize validation to prevent
> > >    this.
> > >
> > > Fix this by:
> > > 1. Constraining proc_dobool() to allow only one value and .maxsize ==
> > >    sizeof(bool).
> > > 2. Wrapping the original struct ctl_table in a temporary one with .data
> > >    pointing to a local int variable and .maxsize set to sizeof(int) and
> > >    passing this one to proc_dointvec(), converting the value to/from
> > >    bool as needed (using proc_dou8vec_minmax() as an example).
> > > 3. Extending sysctl_check_table() to enforce proc_dobool() expectations.
> > > 4. Fixing the proc_dobool() docstring (it was just copy-pasted from
> > >    proc_douintvec, apparently...).
> > > 5. Converting all existing proc_dobool() users to set .maxsize to
> > >    sizeof(bool) instead of sizeof(int).
> > >
> > > Fixes: 83efeeeb3d04 ("tty: Allow TIOCSTI to be disabled")
> > > Fixes: a2071573d634 ("sysctl: introduce new proc handler proc_dobool")
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> >
> > Ah nice, thanks for tracking this down.
> >
> > Acked-by: Kees Cook <keescook@chromium.org>
>
> Queued onto sysctl-next, will send to Linus as this is a fix too.

Thanks, Luis!

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

