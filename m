Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7402E1BA7A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 17:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgD0PPi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 11:15:38 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46804 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728139AbgD0PPh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 11:15:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588000536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eSpYzJ8vruskzw1ixWuPTFKODIOCb1DdC0Y5Ypx1fB0=;
        b=Ixjl1U9ZxAd7CT3hUfVBj4OC3cNpxodUZOfnDT/R+PiEaqt/AILrKzUj5Eo/rzHioy9Oln
        cvJLzIAKJ6wHxC5CCF4L4yKtPq/EaBFl8TJ9vWTotACZe3HuIK/3lALMrWYOMCjppl2WFY
        7T3/PCaVB0U3AZ/R1FovAdsEF10h418=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-P4rvn9g2OtiK9m9chvogUA-1; Mon, 27 Apr 2020 11:15:34 -0400
X-MC-Unique: P4rvn9g2OtiK9m9chvogUA-1
Received: by mail-wm1-f72.google.com with SMTP id t62so35303wma.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2020 08:15:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eSpYzJ8vruskzw1ixWuPTFKODIOCb1DdC0Y5Ypx1fB0=;
        b=pTELLwFAlpGiSUKL+or37kA9ioH2qx75K1nqAP6FPfVsAtqrl0Y5TA2ykHcp0PiRa3
         S5I+9KJoyLj2at4nb/VOBn4dc6cbNLGHUXRRO7msKQT9O0fCLAFg/X5NjKjn5QFp7DXC
         3yJWE3/jCs5T09BlUEj2OVvjoKuLJI+ZCIzTbE/4Ey3y97vvFIpxByFd1h63P+hck8gp
         un3nkiY6RVV1JzD55lnoYqIZw1VPgnYH9+Wq6RNy7mwiizRg1ysHsiO/LKL6SdClWTTl
         v+TiE2j/ipoNVubBk0ZMxgVMAdAcOQefcPawtXMAhu7iTmuTrU4uoiT4XQP8sFW+tsxG
         ngqw==
X-Gm-Message-State: AGi0PuadoL9fNbQCPTdKE2mh409HnucO9QYolTrRAaisJF2cIaJmMtQt
        XGPBcgZ0KkuB+8Dlv1d3cmiV+KOYmMC+B6k18lWptCxcj3dkGm6Y2WSkAo3C/QshrNx6eahqMbx
        mk2CrYS7Cuf96/4JvIBYa02BYrQ==
X-Received: by 2002:a5d:670d:: with SMTP id o13mr29924463wru.29.1588000533359;
        Mon, 27 Apr 2020 08:15:33 -0700 (PDT)
X-Google-Smtp-Source: APiQypK+T+6Aj+dLlxq4HhKDwXzdqmOqUdriVVov3jgAPiPujwYcHZ4fNtTJwlwzd9NWqPh44afp5Q==
X-Received: by 2002:a5d:670d:: with SMTP id o13mr29924444wru.29.1588000533150;
        Mon, 27 Apr 2020 08:15:33 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ac19:d1fb:3f5f:d54f? ([2001:b07:6468:f312:ac19:d1fb:3f5f:d54f])
        by smtp.gmail.com with ESMTPSA id n6sm23226378wrs.81.2020.04.27.08.15.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 08:15:32 -0700 (PDT)
Subject: Re: [PATCH v2 6/7] debugfs: switch to simplefs inode creation API
To:     Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        linux-fsdevel@vger.kernel.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Manoj N. Kumar" <manoj@linux.ibm.com>,
        "Matthew R. Ochs" <mrochs@linux.ibm.com>,
        Uma Krishnan <ukrishn@linux.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-scsi@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20200421135119.30007-1-eesposit@redhat.com>
 <20200421135741.30657-4-eesposit@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <167ebece-2e50-5186-3a42-2fa491fcb8a5@redhat.com>
Date:   Mon, 27 Apr 2020 17:15:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200421135741.30657-4-eesposit@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 21/04/20 15:57, Emanuele Giuseppe Esposito wrote:
> -	inode = debugfs_get_inode(dentry->d_sb);

You're not removing debugfs_get_inode so I think you're going to get a
warning (same in tracefs)?

You can wait a few more days for reviews and/or Acked-bys (especially
for patches 6 and 7) and then post v3.

Since the touch-everything patch (#2) has already been reviewed, and
it's mechanical and not introducing any semantic change, you can
probably reduce the To/Cc list to filesystem, debugfs and tracefs
maintainers.

Thanks,

Paolo

