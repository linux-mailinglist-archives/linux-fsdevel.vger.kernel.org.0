Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7143E84FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 23:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbhHJVJy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 17:09:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34932 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234070AbhHJVJx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 17:09:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628629770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nstjUO9S2JedgX/X63vf3JasoXS0I2O2tfkyfoDt5+M=;
        b=BCVOJiT/M/+ClTMIlp0HIqo2+VbnaRO9//WTrHX81P16en1+VW5HAdcTjuho31LCWOko6r
        WluZH288fmN1Dji2qxdIDV1tKgDMdpifzC33gZxA7JsIfiuID5X5d39/sBKu8Otr9rIfvW
        PxpgKdRHCgdS7fa2LGzBrnoP1+0NDhM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-kfEsoJj9Pa2UDihLNckHpg-1; Tue, 10 Aug 2021 17:09:28 -0400
X-MC-Unique: kfEsoJj9Pa2UDihLNckHpg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A868C34820;
        Tue, 10 Aug 2021 21:09:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC20E5C1A1;
        Tue, 10 Aug 2021 21:09:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210715033704.692967-62-willy@infradead.org>
References: <20210715033704.692967-62-willy@infradead.org> <20210715033704.692967-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 061/138] mm/migrate: Add folio_migrate_flags()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1812508.1628629765.1@warthog.procyon.org.uk>
Date:   Tue, 10 Aug 2021 22:09:25 +0100
Message-ID: <1812509.1628629765@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> +	if (folio_test_error(folio))
> +		folio_set_error(newfolio);
> +	if (folio_test_referenced(folio))
> +		folio_set_referenced(newfolio);
> +	if (folio_test_uptodate(folio))
> +		folio_mark_uptodate(newfolio);
> +	if (folio_test_clear_active(folio)) {
> +		VM_BUG_ON_FOLIO(folio_test_unevictable(folio), folio);
> +		folio_set_active(newfolio);
> +	} else if (folio_test_clear_unevictable(folio))
> +		folio_set_unevictable(newfolio);
> +	if (folio_test_workingset(folio))
> +		folio_set_workingset(newfolio);
> +	if (folio_test_checked(folio))
> +		folio_set_checked(newfolio);
> +	if (folio_test_mappedtodisk(folio))
> +		folio_set_mappedtodisk(newfolio);

Since a bunch of these are bits in folio->flags and newfolio->flags, I wonder
if it's better to do use a cmpxchg() loop or LL/SC construct to transfer all
the relevant flags in one go.

Apart from that:

Reviewed-by: David Howells <dhowells@redhat.com>

