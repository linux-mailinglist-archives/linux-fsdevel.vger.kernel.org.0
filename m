Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2B2C15A35D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 09:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgBLIbe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 03:31:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20062 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728192AbgBLIbe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:31:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581496293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oZOfuc0f9zTXdDLlba5WZgUvut3L8/MVnfbdrFnGVlk=;
        b=K06z10Ce+U5TuDmZi5bcR3foSr0S6Z2dUvNnlhZNyBR4dLDCDoxSO8HcADxKdNv8iPuj3T
        AXoJ0c6O9hKqkwwrKF+NUmOX+pXeSdXd0c9mre/aBzWsWOXe+xKxgwNgfD+jst3QxYLNQe
        K0Ex72VJ8m8HaSNTAK/usjtfkf7oB6k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-403AJZe-P8Kwds2ufkw0Bg-1; Wed, 12 Feb 2020 03:31:27 -0500
X-MC-Unique: 403AJZe-P8Kwds2ufkw0Bg-1
Received: by mail-wr1-f71.google.com with SMTP id o9so510893wrw.14
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2020 00:31:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oZOfuc0f9zTXdDLlba5WZgUvut3L8/MVnfbdrFnGVlk=;
        b=Z0ji6jFS/WzS9Mop4b+1YvRtFMTS1+dvxNtnQlPx2kRVC/UPbKXVRLGLcbS2sJnaYr
         d4nflym4P+hPk5Jh4AI8BnrYGVfJFaztV6FRQ541PUJBE+zC1bi6zNRYKf+8SM6VA3Eu
         6WCJAJiq3RvXdKg8+FTu38+9V23LhtbZuG72ewSAq6iJM8XRpEshdUDsokZLztbuYcIP
         enPjuaw1HPTINbc1YZhLa6i2pow/Q3WvHraQ1F8pindOzhGwQxDfGIk72iRMcsraGCGf
         8mlbxt6zyj46Mq5P2KnuKokjAujxbF1VSOTF5+g9P0EXVJ2OkbrK40Seuky8kQ3lUi4F
         LBuQ==
X-Gm-Message-State: APjAAAVUC3LIj1zkvsZSj1SN9lIR06Nq53Fl0cbg5cJ09cN1b4Gx5/lB
        rfLbb9h0Z0od2Qv31mr7RjkX0cB8L0n7m4L+rHnuu0c9VMacqVDZVgm9gMPHckXyLlQ9kVGrgKc
        pQmT7gykErCCdHmDdndBZgFIzXw==
X-Received: by 2002:a5d:534b:: with SMTP id t11mr13741809wrv.120.1581496286527;
        Wed, 12 Feb 2020 00:31:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqza9H25/6DFSL8gggVhZrtaOfNP+AdiOecReyyBui2YL/vcqKEAGwyfksGHrCPVHXAXdbPgkg==
X-Received: by 2002:a5d:534b:: with SMTP id t11mr13741777wrv.120.1581496286194;
        Wed, 12 Feb 2020 00:31:26 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:652c:29a6:517b:66d9? ([2001:b07:6468:f312:652c:29a6:517b:66d9])
        by smtp.gmail.com with ESMTPSA id g128sm7071124wme.47.2020.02.12.00.31.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 00:31:25 -0800 (PST)
Subject: Re: [RFC] eventfd: add EFD_AUTORESET flag
To:     Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Avi Kivity <avi@scylladb.com>,
        Davide Libenzi <davidel@xmailserver.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <20200129172010.162215-1-stefanha@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <66566792-58a4-bf65-6723-7d2887c84160@redhat.com>
Date:   Wed, 12 Feb 2020 09:31:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200129172010.162215-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 29/01/20 18:20, Stefan Hajnoczi wrote:
> +	/* Semaphore semantics don't make sense when autoreset is enabled */
> +	if ((flags & EFD_SEMAPHORE) && (flags & EFD_AUTORESET))
> +		return -EINVAL;
> +

I think they do, you just want to subtract 1 instead of setting the
count to 0.  This way, writing 1 would be the post operation on the
semaphore, while poll() would be the wait operation.

Paolo

