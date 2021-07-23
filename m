Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72F43D3C0F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jul 2021 16:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235481AbhGWONo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jul 2021 10:13:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35122 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235470AbhGWONc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jul 2021 10:13:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627052045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KzcnGLaacDgNN8JHkByoexh8GLTQOigyRJDFx1KyDyI=;
        b=cLGn6t96y/GZD1xD2++H+fLMBZ0Z/u1v5M99I38FazqwIEBa11+k03u5kyFOo7QhTdkE5p
        9FJfJ2y9tgYQRyGbJ+Z0436HhKvA6UpzDl10UIEJD4CnpEByqcbXs+Tktj+C4lc3m4py/b
        /mnzMQHDBxXSOfQocu596DInaDDOCVE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-3TQ6KJQ1MTi3It6GACdKBQ-1; Fri, 23 Jul 2021 10:54:02 -0400
X-MC-Unique: 3TQ6KJQ1MTi3It6GACdKBQ-1
Received: by mail-wr1-f69.google.com with SMTP id f2-20020a5d50c20000b0290138092aea94so1044151wrt.20
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jul 2021 07:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KzcnGLaacDgNN8JHkByoexh8GLTQOigyRJDFx1KyDyI=;
        b=npmgC3ERorwNny3kFPX/+tGnrjA0U2WCmwhuFJ2/K4HZq7Cz16zzZFPviM/L0ITa4d
         hhI07NiMAkNmrPHj6/NflPC7O6LgrC9hj8GfoULy+U2DBUQvB/jDZELeD/lGSbI4ohkN
         ADhCWCYejxWh3xnPm+U0Y3OEEpokB7gKadndlslzX4jDJaMvja69/KHEOtXWoYfoFcMk
         Hv5v7MQZ01rnYkfD/CtaDzs4dFnLg+b34LpspibWMADRDiBwlKrW5hRvivyug9PfMLRe
         C83AtTjmrDIyrXnzztuRGrbz3AgBN4luvdMwLfuZHdEVSrGR/Gv8NIXbnrxVa3k6M38T
         GrmA==
X-Gm-Message-State: AOAM5301GKESl1bKoKY/Hp0uMs7RozGpO2m+HCk+c9i3Xz58l+InMXMD
        TXLhY8kIX2ng5T5q3A9wL4C/cbc+sRQXTDrJVNtXV1y/a5Ln9XkvZGluOv9IcmFRLn6fkM/sIsL
        5MsNaO2w4giUW6bNnRoeiqDcVhg==
X-Received: by 2002:a7b:cb4d:: with SMTP id v13mr3594838wmj.68.1627052041371;
        Fri, 23 Jul 2021 07:54:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzg3/rHxC6b3F9kv0Z/oQV6K4OuNHE8KmjmwppyGJt73QDUzut6gjIGYOsMCZq0dX32zZczvQ==
X-Received: by 2002:a7b:cb4d:: with SMTP id v13mr3594830wmj.68.1627052041247;
        Fri, 23 Jul 2021 07:54:01 -0700 (PDT)
Received: from vian.redhat.com ([79.116.5.179])
        by smtp.gmail.com with ESMTPSA id w18sm35594863wrg.68.2021.07.23.07.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 07:54:01 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     bristot@kernel.org
Cc:     axboe@kernel.dk, bigeasy@linutronix.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, stable@vger.kernel.org, tglx@linutronix.de,
        viro@zeniv.linux.org.uk, zhe.he@windriver.com,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: Re: [PATCH] eventfd: protect eventfd_wake_count with a local_lock
Date:   Fri, 23 Jul 2021 16:53:04 +0200
Message-Id: <20210723145303.272822-1-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <523c91c4a30f21295508004c81cd2e46ccc37dc2.1626680553.git.bristot@kernel.org>
References: <523c91c4a30f21295508004c81cd2e46ccc37dc2.1626680553.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 19 Jul 2021 09:54:52 +0200, Daniel Bristot de Oliveira wrote:
> eventfd_signal assumes that spin_lock_irqsave/spin_unlock_irqrestore is
> non-preemptable and therefore increments and decrements the percpu
> variable inside the critical section.
> 
> This obviously does not fly with PREEMPT_RT. If eventfd_signal is
> preempted and an unrelated thread calls eventfd_signal, the result is
> a spurious WARN. To avoid this, protect the percpu variable with a
> local_lock.
> 
> Reported-by: Daniel Bristot de Oliveira <bristot@kernel.org>
> Fixes: b5e683d5cab8 ("eventfd: track eventfd_signal() recursion depth")
> Cc: He Zhe <zhe.he@windriver.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: stable@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Co-developed-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
> ---

Tested-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>

Thanks!

--
Nicolás Sáenz

