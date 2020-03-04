Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9922178C95
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 09:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgCDIeP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 03:34:15 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55898 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728301AbgCDIeO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 03:34:14 -0500
Received: by mail-wm1-f65.google.com with SMTP id 6so918895wmi.5;
        Wed, 04 Mar 2020 00:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nayxdGYrrbMcrJKKUbiZVGz59/2NTLulIF1ZtrT47ek=;
        b=cA910Sct3AMljocPVycm3ISQnbULt2Dp+2t4oFbXMzpoCb+1ao26K70iGqKD+FitKL
         /2nZ7tcj36mMW2mPY6Em4FDY4RrodpTwHOcxTICDOeB2aML7yK8Mgdi1ViKJSd4NqNUP
         Nu6LH0bFO5TyeYKkL8KS8I0WwBz+i3srnfYET7saaRhPFh5DKT6RjqbXcXc5TsboBem3
         wPMlEkYa/bjdcd2V3Ww5j+AvmrMrD1SvIs7ZmRyZ0mG3x/X7sSYQg8Z7K1cMbgfOTmUQ
         Ko2jRDVflT4LeXsZemovrNYMqBa3fgBL2i8zxAMR4zvWeilQcdgGLuucGuSDxEGI5GrR
         rPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=nayxdGYrrbMcrJKKUbiZVGz59/2NTLulIF1ZtrT47ek=;
        b=LA2qQFOLHBhWGP0G8QvnZdtgQAZ9C6btWHJDFkD+C4KdARyoibCQwbQhyPhPVm09GG
         YJIGBhhlYw1zM73VmJY1OCn2Zgrhcpy9UmG0P33yaXjrRLwVDgGEjlcjR3U9u7DzD7Dq
         0iYDrfGrQQuSjE+kEUMvUjQg8BGUyOsFO/uzqW0MBkttq0nAlNsb+cD7/Ku3bzSm0eVU
         3cZclwBxzkvVJHp+1tEIVrTBvSTH5zMJbF0L0O6q1HVZ0gNIrCwXQh3XjIYq39xAwPUE
         r74vNbDvwzZNRqLH604m1vEgk/K9GWZJkQtGjgjdcC030nLcHpaAsVSysast41j+govF
         Otzg==
X-Gm-Message-State: ANhLgQ1kNIqHqzdJP23LdNSPk0J/nWnZsKrzNEF89PAw5dHTIaTGSBEb
        rtFAKNYN5K8XWw/+w8fUpEI=
X-Google-Smtp-Source: ADFU+vsXmm1DvvLyrlqHs80fl4XcTC+zghUs61AIKoiW7wsI1tA9IZuzEY5ZKMXvbLStbZ+Dj59Dlg==
X-Received: by 2002:a05:600c:3ce:: with SMTP id z14mr2566093wmd.106.1583310851550;
        Wed, 04 Mar 2020 00:34:11 -0800 (PST)
Received: from dumbo ([83.137.6.114])
        by smtp.gmail.com with ESMTPSA id z16sm37081963wrp.33.2020.03.04.00.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 00:34:10 -0800 (PST)
Date:   Wed, 4 Mar 2020 09:34:08 +0100
From:   Domenico Andreoli <domenico.andreoli.it@gmail.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel@vger.kernel.org, mkleinsoft@gmail.com,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] hibernate: unlock swap bdev for writing when uswsusp is
 active
Message-ID: <20200304083408.GA14584@dumbo>
References: <20200229170825.GX8045@magnolia>
 <20200229180716.GA31323@dumbo>
 <20200229183820.GA8037@magnolia>
 <20200229200200.GA10970@dumbo>
 <CAJZ5v0iHaZyfuTnqJyM6u=UU=+W6yRuM_Q6iUvB2UudANuwfgA@mail.gmail.com>
 <20200303190212.GC8037@magnolia>
 <9E4A0457-39B1-45E2-AEA2-22C730BF2C4F@gmail.com>
 <20200304011840.GD1752567@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304011840.GD1752567@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 03, 2020 at 05:18:40PM -0800, Darrick J. Wong wrote:
> On Tue, Mar 03, 2020 at 10:51:22PM +0000, Domenico Andreoli wrote:
> > 
> > I don't see the need of reverting anything, I can deal with these
> > issues if you are busy on something else.
> 
> If you want to work on the patch, please do!  Starting from the revert
> patch I sent earlier, I /think/ only the first chunk (the one that
> touches blkdev_write_iter) of that patch actually has to be applied to
> re-enable uswsusp.  That could probably be turned into:
> 
> 	if (IS_SWAPFILE(...) && !IS_ENABLED(HIBERNATION))
> 		return -ETXTBSY;

I've just sent such patch, I don't know how it will play with the whole
revert of yesterday and that akpm has already taken in his tree.

Ideally this should go in 5.6-rc and also in stable kernels > 5.2.

> 
> Though perhaps a better thing to check here rather than the Kconfig
> option is whether or not the system is locked out against hibernation?
> e.g.,
> 
> 	if (IS_SWAPFILE(...) && !hibernation_available())
> 		return -EXTBSY;

This is the kind of improved fix I'm going to prepare for a coming
merge window.

Regards,
Domenico

-- 
rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05
