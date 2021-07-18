Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A69B73CC746
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jul 2021 05:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbhGRDjv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Jul 2021 23:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhGRDjv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Jul 2021 23:39:51 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB871C061762;
        Sat, 17 Jul 2021 20:36:52 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id u14so15047805pga.11;
        Sat, 17 Jul 2021 20:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UqspULE7Gruxz35tDs84/+gdhXNETD4hOwg9f63iBVA=;
        b=ZFNPnsOoUr28WsTsZG9AHEhK7vIrhso65KmkuMEDQteYISSH36Im+rDl/YICTXkHvU
         2JRLEObZ2TJ8X8wXE/xfJQ3ABBqcZia2CzuV4G9H6COqrn4XUAuFcrd70sQ1InZIUY0O
         Nv0Ju6MsYiKicIRImx1Rn/Hbl7g5f2/5sx+1fU9bwrJocEZ0ABawsGkwuWCp8qGAPffN
         nW8YRs+wOV3r6M1IvWkrjLDYUyTUF1IWCY84txdnmFEt7wlaKsAOZWyEJMG6AwjJh21s
         29iPA7l5SKrKLT6n8eN6P05vndP/ReagYp21l60XuhArkWTNq7GTw400sYgGDBW9uHQu
         2uaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UqspULE7Gruxz35tDs84/+gdhXNETD4hOwg9f63iBVA=;
        b=hYPMJjqv83eBS3QjWF57MNrL3hEm2aD2K18VEKy4NQKDhgbS9JUSQlMFHQOFMnrldL
         pfcAhMh6Je7u2iDg8MXop0Yq7wSLGVmg8vNkh5fxIFNzOeY1XHnOcutVJ0cLNWqZ7Ibr
         IpC0XUE8htO9F8yx2cfe5Bc2V5i7TXZzHZxswugjuawCORMX6n78pdIdtZdY+3MYHhcC
         nd+ZREKMpveAo8+GXYmj3LZOrbbzbfjsXXaZUiHp0GwiDwTfD7V3gyOffjKRKAnxNMJH
         VRTBziwx/n4nYjlTVyNI7b2CrC+qf5+ezW9+pvbbRgw0tdt7s/WpaofI9jykSps+6i2V
         J3Pg==
X-Gm-Message-State: AOAM532rzTJKPUoBjEFZUpHpbcxFGonRSJcrcuCKvpih26Wo8bbelPzy
        Zi7h82TRe6TVD1n7HiGzU08=
X-Google-Smtp-Source: ABdhPJzx+Bn6XaAoaIsSBrTf0Ya8H9XJK4nnLWZqM1KjRGsOEhBP7qYPQvZfEVkR2HDXXE8PnvDenQ==
X-Received: by 2002:a05:6a00:1582:b029:333:a366:fe47 with SMTP id u2-20020a056a001582b0290333a366fe47mr14280622pfk.0.1626579411994;
        Sat, 17 Jul 2021 20:36:51 -0700 (PDT)
Received: from gmail.com ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id s10sm4717431pga.28.2021.07.17.20.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 20:36:51 -0700 (PDT)
Date:   Sat, 17 Jul 2021 20:33:06 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mattias Nissler <mnissler@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] move_mount: allow to add a mount into an existing
 group
Message-ID: <YPOg8tl6Q6+d9Sa2@gmail.com>
References: <20210715100714.120228-1-ptikhomirov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20210715100714.120228-1-ptikhomirov@virtuozzo.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 01:07:13PM +0300, Pavel Tikhomirov wrote:
> Previously a sharing group (shared and master ids pair) can be only
> inherited when mount is created via bindmount. This patch adds an
> ability to add an existing private mount into an existing sharing group.
> 
> With this functionality one can first create the desired mount tree from
> only private mounts (without the need to care about undesired mount
> propagation or mount creation order implied by sharing group
> dependencies), and next then setup any desired mount sharing between
> those mounts in tree as needed.
> 
> This allows CRIU to restore any set of mount namespaces, mount trees and
> sharing group trees for a container.
> 
> We have many issues with restoring mounts in CRIU related to sharing
> groups and propagation:
> - reverse sharing groups vs mount tree order requires complex mounts
>   reordering which mostly implies also using some temporary mounts
> (please see https://lkml.org/lkml/2021/3/23/569 for more info)
> 
> - mount() syscall creates tons of mounts due to propagation
> - mount re-parenting due to propagation
> - "Mount Trap" due to propagation
> - "Non Uniform" propagation, meaning that with different tricks with
>   mount order and temporary children-"lock" mounts one can create mount
>   trees which can't be restored without those tricks
> (see https://www.linuxplumbersconf.org/event/7/contributions/640/)
> 
> With this new functionality we can resolve all the problems with
> propagation at once.
> 
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <christian.brauner@ubuntu.com>
> Cc: Mattias Nissler <mnissler@chromium.org>
> Cc: Aleksa Sarai <cyphar@cyphar.com>
> Cc: Andrei Vagin <avagin@gmail.com>

Looks good to me.

Co-developed-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>

> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-api@vger.kernel.org
> Cc: lkml <linux-kernel@vger.kernel.org>
> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>

Thanks,
Andrei 
