Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFBE3D966F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 22:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbhG1UMS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jul 2021 16:12:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57478 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231392AbhG1UMS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jul 2021 16:12:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627503136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SQoUhTYek/sbmmfvELcZcV2xU/1jF0ea9DMZkLH8lxw=;
        b=eG2523b4k2P18JslqaiYjcRVkNWxA+L/pdhd7YCqj9RSJV52xthmipLipDkiwfn5ukAiJ0
        P7I0pTqnUn97NM6pH/QJznLZ8SjWZ1YLhmcUZ6s2zXYaLS40xm1ZZAYPV+zYL412+pDmRC
        zdjZ3gfN6AugzfyC08aberQkoSRKDSk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-537-F5N4kZpbNSCSzsHcWb0JKg-1; Wed, 28 Jul 2021 16:12:14 -0400
X-MC-Unique: F5N4kZpbNSCSzsHcWb0JKg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0AAE9107ACF5;
        Wed, 28 Jul 2021 20:12:13 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-112-7.ams2.redhat.com [10.36.112.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A9435D9FC;
        Wed, 28 Jul 2021 20:12:11 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com
Subject: Re: [PATCH] lib/string: Bring optimized memcmp from glibc
References: <20210721135926.602840-1-nborisov@suse.com>
Date:   Wed, 28 Jul 2021 22:12:09 +0200
In-Reply-To: <20210721135926.602840-1-nborisov@suse.com> (Nikolay Borisov's
        message of "Wed, 21 Jul 2021 16:59:26 +0300")
Message-ID: <877dha6vvq.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Nikolay Borisov:

> +/*
> + * Compare A and B bytewise in the byte order of the machine.
> + * A and B are known to be different. This is needed only on little-endian
> + * machines.
> + */
> +static inline int memcmp_bytes(unsigned long a, unsigned long b)
> +{
> +	long srcp1 = (long) &a;
> +	long srcp2 = (long) &b;
> +	unsigned long a0, b0;
> +
> +	do {
> +		a0 = ((uint8_t *) srcp1)[0];
> +		b0 = ((uint8_t *) srcp2)[0];
> +		srcp1 += 1;
> +		srcp2 += 1;
> +	} while (a0 == b0);
> +	return a0 - b0;
> +}

Should this be this?

static inline int memcmp_bytes(unsigned long a, unsigned long b)
{
	if (sizeof(a) == 4)
		return __builtin_bswap32(a) < __builtin_bswap32(b) ? -1 : 0;
	else
		return __builtin_bswap64(a) < __builtin_bswap64(b) ? -1 : 0;
}

(Or whatever macro versions the kernel has for this.)

Or is the expectation that targets that don't have an assembler
implementation for memcmp have also bad bswap built-ins?

Thanks,
Florian

