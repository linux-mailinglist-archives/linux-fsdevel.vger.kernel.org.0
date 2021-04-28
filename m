Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05ECC36E0B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Apr 2021 23:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbhD1VJR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 17:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbhD1VJR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 17:09:17 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87713C06138B
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Apr 2021 14:08:31 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id h10so75963681edt.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Apr 2021 14:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oVM+iCdaFxsIfPwq2nMLDZ6TqTYet379ZeoHbJGRbTQ=;
        b=xgecX1li+vZtq3cln0N6XPWA+P7KKlGO+QkJHeToGBYOk+pJGm7UzU6xHUtWnxUoUd
         k4SObdNEzxatSE1/axJ3GHwN9LyypcfNVyIiyyduihy/LYRAlkQ9kK09QkqhmtGDaquq
         ZKT8sZz/ERBbzZ8USiHw1BsnjPcRwSD8s47+G+R1CHXkx+Rnu6EWxm5pZre87qVZZdME
         Lg4qoLDGAKY2bs87DtmBn1Vghi97JwG+cuMHs7QBI4q6aynW9zyBY9rxnZ3NmxOujD5U
         Zr1x1W0WpgejANg2Szdhoe0QlIDP2pmNTJNK9HBrZA+0u0xsEWoPK/FMGt4Mzc0kx1Wm
         FvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oVM+iCdaFxsIfPwq2nMLDZ6TqTYet379ZeoHbJGRbTQ=;
        b=O9b3o3NkrtxX82glf7iKwK8nU2VPf3s/IMjWBsVnbtCUisGy1ab1Rict5me2w8M1kW
         BPYy3DgWhjmqEU6q/EtFo3CE/I+nER4otldPZgKKW8ErTmbNP+yT/VDVi0wux8DqcR9D
         4LHeUB5XvBT9bP4Z3yiIreIhmYIJ5kW+9q14oVNzBWU8ULdWZcu2ybM6DaVgAgX8xmO6
         szRFeEXJvu0205I6tAqzdZvBl+1JGx5JBuIVxqqNLvDNG9P1IqzbPaNYi9yzxjsp+zny
         FfwilPaXJCay+GqScT+Tlfxt74RevaX1z90tO8nPN2WQtowYc0N55LgIXAw7qEmXj/lE
         VS6g==
X-Gm-Message-State: AOAM532sdDs6otzGpf3tkMZ6Tkjb5x0maFY2TQPbUbYWSM5+7C1wR02b
        df5F5F4/oziSRU459NRZydfqKjU+ZvMKSVujdIxWig==
X-Google-Smtp-Source: ABdhPJxstAbCjBnNHZqdoBSMGGEklrAQj49GAceBkw0Svq0mJzmb0vA0NIyg451Fm4fflP37wNtdmIBaLeg1Zk8giQc=
X-Received: by 2002:a05:6402:12d3:: with SMTP id k19mr2830019edx.52.1619644110204;
 Wed, 28 Apr 2021 14:08:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210428190314.1865312-1-vgoyal@redhat.com>
In-Reply-To: <20210428190314.1865312-1-vgoyal@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 28 Apr 2021 14:08:28 -0700
Message-ID: <CAPcyv4jYyYOXyZLv1Pz3Vy1U7B7BzNrp4TO1MzANkYOMA0u_4A@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] dax: Fix missed wakeup in put_unlocked_entry()
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com,
        willy@infradead.org, jack@suse.cz, groug@kaod.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 28, 2021 at 12:03 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> Hi,
>
> This is V6. Only change since V5 is that I changed order of WAKE_NEXT
> and WAKE_ALL in comments too.
>
> Vivek
>
> Vivek Goyal (3):
>   dax: Add an enum for specifying dax wakup mode
>   dax: Add a wakeup mode parameter to put_unlocked_entry()
>   dax: Wake up all waiters after invalidating dax entry

Thanks Vivek, looks good.
