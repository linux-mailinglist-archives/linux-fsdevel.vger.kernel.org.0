Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8E84A7389
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Feb 2022 15:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345075AbiBBOrl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 09:47:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42766 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345092AbiBBOrj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:47:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643813259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VGlmPh+lpFCFUzwkF/NTnSbC4pQ69+yQaOHVbCiVAdo=;
        b=M4LJGVoPFEKajv5MHlrmlox+Z8Ld75moyfZl2VW/+dftKBEdFDiAUE2xCM5ps2sIg4IPyh
        6efapO/FS2fbjazFAAA3dJrH0qFFBW4ZtKCbdyprWMAHOvb06miVtF6m4POdbFa+MGOgfX
        B9u+2xEHHGQpr2AdcEuuSCOPYr0jX/E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-w-xX1KEaMoiBIYAFgBKfgA-1; Wed, 02 Feb 2022 09:47:36 -0500
X-MC-Unique: w-xX1KEaMoiBIYAFgBKfgA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C363318B9ECC;
        Wed,  2 Feb 2022 14:47:34 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 10C83747B3;
        Wed,  2 Feb 2022 14:47:33 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Hannes Reinecke" <hare@suse.de>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        "Chuck Lever III" <chuck.lever@oracle.com>
Subject: Re: [LSF/MM/BPF TOPIC] [LSF/MM/BPF ATTEND] TLS handshake for
 in-kernel consumers
Date:   Wed, 02 Feb 2022 09:47:32 -0500
Message-ID: <1AF72276-E808-48E5-9824-6355129E58BE@redhat.com>
In-Reply-To: <3a066f81-a53d-4d39-5efb-bd957443e7e2@suse.de>
References: <3a066f81-a53d-4d39-5efb-bd957443e7e2@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2 Feb 2022, at 9:12, Hannes Reinecke wrote:

> Hi all,
>
> nvme-over-tcp has the option to utilize TLS for encrypted traffic, but 
> due to the internal design of the nvme-over-fabrics stack we cannot 
> initiate the TLS connection from userspace (as the current in-kernel 
> TLS implementation is designed).
>
> This leaves us with two options:
> 1) Put TLS handshake into the kernel (which will be quite some
>   discussion as it's arguably a userspace configuration)
> 2) Pass an in-kernel socket to userspace and have a userspace
>   application to run the TLS handshake.
>
> None of these options are quiet clear cut, as we will be have to put
> quite some complexity into the kernel to do full TLS handshake (if we
> were to go with option 1) or will have to design a mechanism to pass
> an in-kernel socket to userspace as we don't do that currently (if we 
> were going with option 2).
>
> We have been discussing some ideas on how to implement option 2 
> (together with Chuck Lever and the NFS crowd), but so far haven't been 
> able to come up with a decent design.
>
> So I would like to discuss with interested parties on how TLS 
> handshake could be facilitated, and what would be the best design 
> options here.
>
> The proposed configd would be an option, but then we don't have that, 
> either :-)
>
> Required attendees:
>
> Chuck Lever
> James Bottomley
> Sagi Grimberg
> Keith Busch
> Christoph Hellwig
> David Howells

I'm interested in this as well, and have gone down quite a rabbit-hole 
of
experimental implementation for NFS.  I've found the keys API to be 
useful
to implement a tls_session keytype that allows kernel subsystems to 
request
that userspace do the heavy lifting of establishing a TLS session and
installing the kTLS bits on the socket by passing an existing socket fd 
to
userspace.

However, something more persistent than call_usermode_helper is needed,
since userspace helpers may not be able to be looked up from a 
filesystem
when establishing or re-keying (or doing a number of other things) on a 
TLS
session for NFS or NVMe-over-tcp.

I've got a rough idea to create a thing called a "keyagent" which would 
be
an alternative to using call_usermode_helper to service request-key.
Keyagents would be persistent processes in userspace themselves 
represented
by keys, and if a keyagent key is linked into a process' keyrings and
matches the requested type it is consulted to service request-key and 
update
for those keys.

Ben

