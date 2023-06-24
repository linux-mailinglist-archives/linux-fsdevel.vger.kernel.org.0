Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8BE73C5E2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jun 2023 03:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjFXBiA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jun 2023 21:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjFXBh6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jun 2023 21:37:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A20E45
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jun 2023 18:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687570630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SWrf17db78ezE6/aH1TL74NU60boy/nUbrBlOEfT/sU=;
        b=hMclPX1M8U+zpt+kUJc30oAJaKRydBzPfTNyaZQ32GCqNSON1J5iSfRPSJlAnFW6qkY2la
        87VYSk5gIRhtRj6Z4VxvTcTFj2CTi8I76mjutifaKDaDxTDQ+bXowQJo3aXo9zcuoFRu5/
        ryW/qDFqsoiL6EiHrhGN/v4Ml+TiDLA=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-B4OXAR6TNWuTfApHYVUMvw-1; Fri, 23 Jun 2023 21:37:09 -0400
X-MC-Unique: B4OXAR6TNWuTfApHYVUMvw-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1b5381523bcso8872885ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jun 2023 18:37:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687570628; x=1690162628;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SWrf17db78ezE6/aH1TL74NU60boy/nUbrBlOEfT/sU=;
        b=CRlqZVZVvDzzUYAZfWxhGtJeWA9o4dcRR3Ph2HgD2w3WWAEig2jeSZUXLx9tJ0JXgu
         1OGD2wjYnRBbJBEIQ3z1RNO90g47DlfoOc7QEcoguPheesNqf4fvVOd1g5cm+7anC/Hm
         9luvJqyCrHHk32vimWS5etxJVmdmj2EGbGt2sso+KwWCd2vmtM3Dg4P/bLRNmFJQVad8
         ASqU0HG8LA2qQmuLebXtgxKYuq+bAqVGc/nd+VMcrlMXkbGMDmpWoWNYl9kfPtBVMmxb
         d62kmjMaR4NL2a1YIUs/NVI0M7X+KzWdMmfrOxpbNtkLFqagV3TnPLcpqyudam0sOd9z
         TXFg==
X-Gm-Message-State: AC+VfDwbD8k64nCOIDqEAvarr3+SmpyejDUhhN2Ya4Gxxv4cZewblJMb
        cLPz0e8ALNoN1nx8q0/mM2Oz7WqtyLsTLFATP5/KoddiJW7emDJjo2fxjlDj4lYPoQba/3HmTKm
        WwOnSa7EJu49wY0N9jSLVQe1fuKYQbF1uE/t/
X-Received: by 2002:a17:903:24d:b0:1ae:8595:153 with SMTP id j13-20020a170903024d00b001ae85950153mr1087399plh.20.1687570628101;
        Fri, 23 Jun 2023 18:37:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ70F87Rbv/R9XMaSzZcQtw3TRpiFahOhZs33X4KSJY20FL+t3G4c1wHrNU4qH+U5MgkwpyEHA==
X-Received: by 2002:a17:903:24d:b0:1ae:8595:153 with SMTP id j13-20020a170903024d00b001ae85950153mr1087385plh.20.1687570627829;
        Fri, 23 Jun 2023 18:37:07 -0700 (PDT)
Received: from [10.72.12.106] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id gf4-20020a17090ac7c400b00256dff5f8e3sm259169pjb.49.2023.06.23.18.37.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 18:37:07 -0700 (PDT)
Message-ID: <64241ff0-9af3-6817-478f-c24a0b9de9b3@redhat.com>
Date:   Sat, 24 Jun 2023 09:36:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Xiubo Li <xiubli@redhat.com>
Subject: Re: [PATCH v5 00/14] ceph: support idmapped mounts
To:     Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     Gregory Farnum <gfarnum@redhat.com>,
        Christian Brauner <brauner@kernel.org>, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230608154256.562906-1-aleksandr.mikhalitsyn@canonical.com>
 <f3864ed6-8c97-8a7a-f268-dab29eb2fb21@redhat.com>
 <CAEivzxcRsHveuW3nrPnSBK6_2-eT4XPvza3kN2oogvnbVXBKvQ@mail.gmail.com>
 <20230609-alufolie-gezaubert-f18ef17cda12@brauner>
 <CAEivzxc_LW6mTKjk46WivrisnnmVQs0UnRrh6p0KxhqyXrErBQ@mail.gmail.com>
 <ac1c6817-9838-fcf3-edc8-224ff85691e0@redhat.com>
 <CAJ4mKGby71qfb3gd696XH3AazeR0Qc_VGYupMznRH3Piky+VGA@mail.gmail.com>
 <977d8133-a55f-0667-dc12-aa6fd7d8c3e4@redhat.com>
 <CAEivzxcr99sERxZX17rZ5jW9YSzAWYvAjOOhBH+FqRoso2=yng@mail.gmail.com>
 <626175e2-ee91-0f1a-9e5d-e506aea366fa@redhat.com>
Content-Language: en-US
In-Reply-To: <626175e2-ee91-0f1a-9e5d-e506aea366fa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[...]

 > > >
 > > > I thought about this too and came to the same conclusion, that 
UID/GID
 > > > based
 > > > restriction can be applied dynamically, so detecting it on mount-time
 > > > helps not so much.
 > > >
 > > For this you please raise one PR to ceph first to support this, and in
 > > the PR we can discuss more for the MDS auth caps. And after the PR
 > > getting merged then in this patch series you need to check the
 > > corresponding option or flag to determine whether could the idmap
 > > mounting succeed.
 >
 > I'm sorry but I don't understand what we want to support here. Do we 
want to
 > add some new ceph request that allows to check if UID/GID-based
 > permissions are applied for
 > a particular ceph client user?

IMO we should prevent user to set UID/GID-based permisions caps from 
ceph side.

As I know currently there is no way to prevent users to set MDS auth 
caps, IMO in ceph side at least we need one flag or option to disable 
this once users want this fs cluster sever for idmap mounts use case.

Thanks

- Xiubo

