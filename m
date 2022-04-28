Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265655134A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Apr 2022 15:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346881AbiD1NQG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Apr 2022 09:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346887AbiD1NQB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:16:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0120C1E3D8
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Apr 2022 06:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651151558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RZeU/He+6khomoWAT8bo7Pq7shtJeaFymOMgng/v7Ac=;
        b=Qpn4TW1EsuoZ0J1jpXYh9Rug3xZz2BWIBAvJGQQnllHCO6znR1406xGIEQsV+LEwOsDoik
        1GPqJv7/UepXY/ucC6yuOZrAJKxzx3LvbgYLGrJXgnK8wWY42PL/I9g6W5gANsv/9EIehz
        nliUca0+1Oc+46s9gM1COu1WtlFb5UI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-NLLXHeG6MX-ehRkIix6H5g-1; Thu, 28 Apr 2022 09:12:23 -0400
X-MC-Unique: NLLXHeG6MX-ehRkIix6H5g-1
Received: by mail-qt1-f200.google.com with SMTP id e8-20020a05622a110800b002f380dd879eso3277501qty.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Apr 2022 06:12:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=RZeU/He+6khomoWAT8bo7Pq7shtJeaFymOMgng/v7Ac=;
        b=Eb5Z2c328PQU+HANPEGz/xhNDfYKgb+WIdtHnK2U/UMfamsFWHErAJYL5Q33ywDeIf
         27e9VMjetWyPp3COwvCrtdsrdycb3pnp73uXhFBlhIEtIE0TgOq6ulaCGvuYfXEO8QAP
         QWa23IubUt8Vli+gtR0frFXqvFDwwibGHuVT9IT5UTFCAG6S07x1l4/Gdt5etr7SN3df
         hO3VExqMQPLdXQDCkUkAWjRbCdGteVYyV04kQP+LjQlh2jBv4sFIPL0W6W0imf6XFND6
         5+4tqGlKG2+daJeSO7Ouuwu/HDbppRpwf5iUviqj9WIG9lsqGppBLzlV3DixBZkQ27m3
         YwRg==
X-Gm-Message-State: AOAM533rNGsOK9ZNZ/aZGiy5offP2FWtGrTFv+JW+NPtQcwluyU83DhF
        WcN09siRhjjTTJYJPEv2pOwNzqmuXz/P/d2gXhfB6PxQ3mIKqhu5iLdlcrTFp2TcoJmnjpUPkn/
        rxH38LIbkJBqxIZoVQrTbUmRK7Q==
X-Received: by 2002:a37:9f14:0:b0:69f:9b05:cc81 with SMTP id i20-20020a379f14000000b0069f9b05cc81mr3834547qke.697.1651151543183;
        Thu, 28 Apr 2022 06:12:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwclu7EAK2/mxyXFVpKaxBff3R40ELe9mhnqEe6rK0Ij+NdFcfcxKZjuAeW0OVNqLZCq92GlQ==
X-Received: by 2002:a37:9f14:0:b0:69f:9b05:cc81 with SMTP id i20-20020a379f14000000b0069f9b05cc81mr3834518qke.697.1651151542901;
        Thu, 28 Apr 2022 06:12:22 -0700 (PDT)
Received: from m8.users.ipa.redhat.com (cpe-158-222-141-151.nyc.res.rr.com. [158.222.141.151])
        by smtp.gmail.com with ESMTPSA id o21-20020a05620a0d5500b0069c59fae1a5sm9282786qkl.96.2022.04.28.06.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 06:12:22 -0700 (PDT)
Message-ID: <089628513e1cadc0d711874d9ed2e70bb689e3f1.camel@redhat.com>
Subject: Re: [PATCH RFC 4/5] net/tls: Add support for PF_TLSH (a TLS
 handshake listener)
From:   Simo Sorce <simo@redhat.com>
To:     Boris Pismenny <borispismenny@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     ak@tempesta-tech.com, linux-fsdevel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Date:   Thu, 28 Apr 2022 09:12:20 -0400
In-Reply-To: <068945db-f29e-8586-0487-bb5be68c7ba8@gmail.com>
References: <165030051838.5073.8699008789153780301.stgit@oracle-102.nfsv4.dev>
         <165030059051.5073.16723746870370826608.stgit@oracle-102.nfsv4.dev>
         <068945db-f29e-8586-0487-bb5be68c7ba8@gmail.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-3.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2022-04-28 at 11:49 +0300, Boris Pismenny wrote:
> On 18/04/2022 19:49, Chuck Lever wrote:
> > In-kernel TLS consumers need a way to perform a TLS handshake. In
> > the absence of a handshake implementation in the kernel itself, a
> > mechanism to perform the handshake in user space, using an existing
> > TLS handshake library, is necessary.
> > 
> > I've designed a way to pass a connected kernel socket endpoint to
> > user space using the traditional listen/accept mechanism. accept(2)
> > gives us a well-understood way to materialize a socket endpoint as a
> > normal file descriptor in a specific user space process. Like any
> > open socket descriptor, the accepted FD can then be passed to a
> > library such as openSSL to perform a TLS handshake.
> > 
> > This prototype currently handles only initiating client-side TLS
> > handshakes. Server-side handshakes and key renegotiation are left
> > to do.
> > 
> > Security Considerations
> > ~~~~~~~~ ~~~~~~~~~~~~~~
> > 
> > This prototype is net-namespace aware.
> > 
> > The kernel has no mechanism to attest that the listening user space
> > agent is trustworthy.
> > 
> > Currently the prototype does not handle multiple listeners that
> > overlap -- multiple listeners in the same net namespace that have
> > overlapping bind addresses.
> > 
> 
> Thanks for posting this. As we discussed offline, I think this approach
> is more manageable compared to a full in-kernel TLS handshake. A while
> ago, I've hacked around TLS to implement the data-path for NVMe-TLS and
> the data-path is indeed very simple provided an infrastructure such as
> this one.
> 
> Making this more generic is desirable, and this obviously requires
> supporting multiple listeners for multiple protocols (TLS, DTLS, QUIC,
> PSP, etc.), which suggests that it will reside somewhere outside of net/tls.
> Moreover, there is a need to support (TLS) control messages here too.
> These will occasionally require going back to the userspace daemon
> during kernel packet processing. A few examples are handling: TLS rekey,
> TLS close_notify, and TLS keepalives. I'm not saying that we need to
> support everything from day-1, but there needs to be a way to support these.
> 
> A related kernel interface is the XFRM netlink where the kernel asks a
> userspace daemon to perform an IKE handshake for establishing IPsec SAs.
> This works well when the handshake runs on a different socket, perhaps
> that interface can be extended to do handshakes on a given socket that
> lives in the kernel without actually passing the fd to userespace. If we
> avoid instantiating a full socket fd in userspace, then the need for an
> accept(2) interface is reduced, right?

JFYI:
For in kernel NFSD hadnshakes we also use the gssproxy unix socket in
the kernel, which allows GSSAPI handshakes to be relayed from the
kernel to a user space listening daemon.

The infrastructure is technically already available and could be
reasonably simply extended to do TLS negotiations as well.

Not saying it is the best interface, but it is already available, and
already used by NFS code.

Simo.

-- 
Simo Sorce
RHEL Crypto Team
Red Hat, Inc




