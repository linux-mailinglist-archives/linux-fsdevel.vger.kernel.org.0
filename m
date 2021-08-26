Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E073F876F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Aug 2021 14:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240767AbhHZMaF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Aug 2021 08:30:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38729 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234301AbhHZMaE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Aug 2021 08:30:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629980957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2oWfEHZasK8WDnq3QkCch7k26tHiNbpBfPYTJ9GVpp4=;
        b=OqoUbia6TgX4+FLsRojrtXjFekoHqbfsDNRBTQ5npJS06OC4ACsbYg2B4ef3qVJAwqRFYC
        vIm0dNxoudaiChIWY0eVgVGrEn+TUvWfzzsqc5dWCUGwvs65/5iPwT6cfEQGsPo3sen6fk
        7AZWTsfAiKNfNdvenEs1ciD9t6AYTSw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-MDt6MFAnNNKPKnp0cyDpWQ-1; Thu, 26 Aug 2021 08:29:16 -0400
X-MC-Unique: MDt6MFAnNNKPKnp0cyDpWQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11A47800493;
        Thu, 26 Aug 2021 12:29:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1875B60C04;
        Thu, 26 Aug 2021 12:29:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210721113057.993344-1-rbergant@redhat.com>
References: <20210721113057.993344-1-rbergant@redhat.com>
To:     Roberto Bergantinos Corpas <rbergant@redhat.com>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: parse sloppy mount option in correct order
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2117191.1629980953.1@warthog.procyon.org.uk>
Date:   Thu, 26 Aug 2021 13:29:13 +0100
Message-ID: <2117192.1629980953@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Roberto Bergantinos Corpas <rbergant@redhat.com> wrote:

> With addition of fs_context support, options string is parsed
> sequentially, if 'sloppy' option is not leftmost one, we may
> return ENOPARAM to userland if a non-valid option preceeds sloopy
> and mount will fail :
> 
> host# mount -o quota,sloppy 172.23.1.225:/share /mnt
> mount.nfs: an incorrect mount option was specified
> host# mount -o sloppy,quota 172.23.1.225:/share /mnt
> host#
> 
> This patch correct that behaviour so that sloppy takes precedence
> if specified anywhere on the string

It's slightly overcorrected, but that probably doesn't matter.

I wonder if we should put a "bool sloppy" in struct fs_context, put the
handling in vfs_parse_fs_param() (ie. skip the error message).

David

