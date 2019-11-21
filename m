Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80D84104FEB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 11:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfKUKDb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 05:03:31 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:38030 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbfKUKDb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 05:03:31 -0500
Received: by mail-io1-f66.google.com with SMTP id u24so983882iob.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2019 02:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=azm6258Y/h1Yi1v25/cgX4nZQFn/wXyDk4OUzPAogIw=;
        b=VIxmx3lBXUc/OsjeFNHkalvySAflAWkvsgeR9sJSmDV3UMExPqRNneJibNAVZx0ORP
         TNOoZyXyQ0AHvM5PmbjOyt50zoipblJXoCN9Cp925i1ScOTrpzzHGB9QnW8rvvZR9eVN
         ogW18j8FBdeFL19T3L64w40J70OFSxaWsJUuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=azm6258Y/h1Yi1v25/cgX4nZQFn/wXyDk4OUzPAogIw=;
        b=Q/9/kt3bX2JfwGYm8jiStF4pTQnTquPlRosUU0viwxn28SswDFXcNdv8+rsejeeB/7
         CzxdXONqMtGlRYwnFLil/u4nx3PkF4jkY/SsmTXaxpzWHTwNMtgljFSwR80Ig7VA2jF+
         IBfonIoMEbiHsg35o22bKnbDVsFe0Xy8WMiSNd6wtpc5/3tFoGXA8WO7QAr2s/k3Q2mq
         LPK9e8BcJ+oD7MPoT3GhFfkZmEB3rQbRJdyMO3mMOlasyTBbT+nPU/cRAIOkqyxWOM6J
         lA4QKExHud8dc7EPPrTCwjAN7my9ESyNgGN7vlw7ZlbUlZIUmrgzqwq1HPAfKHvOezGY
         O7Zw==
X-Gm-Message-State: APjAAAVcGpF2TzsquE2Vd8Z/yO/VF15/gQq/oIliwWTedduJdQRW7Ipg
        whv3KicuGVRNvV8eBvp2vJQw248kwtAmOGdJeV2FAQ==
X-Google-Smtp-Source: APXvYqws6nCsGqtiQ5vj9FfGy8eiccfE7OIokaC4SxeEjLC2HogWwLfVUDZczbVj8ubWEH2ncp7v39SVWv6PXJFH4UY=
X-Received: by 2002:a02:c05a:: with SMTP id u26mr8022037jam.58.1574330609772;
 Thu, 21 Nov 2019 02:03:29 -0800 (PST)
MIME-Version: 1.0
References: <20191121070613.4286-1-hu1.chen@intel.com>
In-Reply-To: <20191121070613.4286-1-hu1.chen@intel.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 21 Nov 2019 11:03:18 +0100
Message-ID: <CAJfpegtK_S3K0j_qP6x3+qKBPdLag+ayCWHAakJvMtVXMdmXtw@mail.gmail.com>
Subject: Re: [PATCH] proc: align mnt_id in /proc/pid/fdinfo and /proc/pid/mountinfo
To:     "Chen, Hu" <hu1.chen@intel.com>
Cc:     Andrey Vagin <avagin@openvz.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 21, 2019 at 8:28 AM Chen, Hu <hu1.chen@intel.com> wrote:
>
> For Android application process, we found that the mnt_id read from
> /proc/pid/fdinfo doesn't exist in /proc/pid/mountinfo. Thus CRIU fails
> to dump such process and it complains
>
> "(00.019206) Error (criu/files-reg.c:1299): Can't lookup mount=42 for
> fd=-3 path=/data/dalvik-cache/x86_64/system@framework@boot.art"
>
> This is due to how Android application is launched. In Android, there is
> a special process called Zygote which handles the forking of each new
> application process:
> 0. Zygote opens and maps some files, for example
>    "/data/dalvik-cache/x86_64/system@framework@boot.art" in its current
>    mount namespace, say "old mnt ns".
> 1. Zygote waits for the request to fork a new application.
> 2. Zygote gets a request, it forks and run the new process in a new
>    mount namespace, say "new mnt ns".
>
> The file opened in step 0 ties to the mount point in "old mnt ns". The
> mnt_id of that mount is listed in /proc/pid/fdinfo. However,
> /proc/pid/mountinfo points to current ns, i.e., "new mnt ns".
>
> Althgouh this issue is exposed in Android, we believe it's generic.
> Prcoess may open files and enter new mnt ns.
>
> To address it, this patch searches the mirror mount in current ns with
> MAJOR and MINOR and shows the mirror's mnt_id.

This is a hack.   I suggest instead to add a new line to fdinfo with
the MAJOR:MINOR number of the device.

Thanks,
Miklos
