Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A9737BDF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 15:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhELNUl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 09:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhELNUk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 09:20:40 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2095EC061574;
        Wed, 12 May 2021 06:19:30 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id a4so23612124wrr.2;
        Wed, 12 May 2021 06:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=50s22QAFIe8Pgp5SC5xJu65yAnW54h9Wui8ifLw1Ctk=;
        b=FG/cft1gz7AGT8Ob/5BaAtTR6JqzvPxU04ZcAbFc+2GIA6JXxOMiUNvlG3ax3x8LfT
         A6PhHFM3omwjV2mzmpbiRYBuX2CFianIVYx+EffLzokUWDcmdYJf7YfnX7mT/wpKmkQz
         oE4m8JBeTGtTppPzLrlAbiTHfnhaAaUGsV/hmegZS2FK8Kj1hLqj5+fuMHufp3tZrnr2
         pf65d44hzFMV0Kfhrm1cmIvE+asgz8wkAzxAA/iLSpn3Z2U4wdxjALHOZo6qJsSYcxOA
         +OzQ5z+Iw+Q2zytlO/STm0ddPqGqT1Qv9t+BDgx+bZvmJSMK/wliT6NYEF0tUhkDoayi
         hUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=50s22QAFIe8Pgp5SC5xJu65yAnW54h9Wui8ifLw1Ctk=;
        b=reze5+2wXWUOviEUDaqZsc5F7QKKdMwSyO6zz5a52qInytvI+hin37T+neM73U6mZN
         grUGdqi4u9J6HE5QrpuSod9Tt+HiFNDLipbKV7EzB8pABX81acIKpbpagQGdl/koYfc9
         UwOQwDogD9Y2mjMYmvz/7LpEGrGYV/6L80k/Cd1k2SXaA2GaaYSk0SP7l+WJlj8NL+jN
         CzAAosBVQqC990VSLclZ6WYyPJ9ZnlH0db/RLV3ePID8U2/lTF91juYvTwr1q2jA0ivp
         vWVeM3dZFk0yA0tzY3bPx92py0zwD82l54koz9qeqBSM+Cnz5WbYzwIHaMZx+mEVPzvL
         ZtVA==
X-Gm-Message-State: AOAM531+/pVPSXCRAhs60qcKPsSU921PET79LJBk8jhX1NZCEauTmDYe
        zC6wQthS0PXwYS3JPjYn6Q==
X-Google-Smtp-Source: ABdhPJxcdyYrKcu9Mgjt4Emzl9xKlLaTbn2JleyHQWz2V4oYOxZ2rTS8LE3uP5EkdkQum6xL+3LEeA==
X-Received: by 2002:adf:a4c4:: with SMTP id h4mr2897902wrb.330.1620825568910;
        Wed, 12 May 2021 06:19:28 -0700 (PDT)
Received: from localhost.localdomain ([46.53.248.42])
        by smtp.gmail.com with ESMTPSA id m11sm30480029wri.44.2021.05.12.06.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 06:19:28 -0700 (PDT)
Date:   Wed, 12 May 2021 16:19:26 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
Cc:     linux-fsdevel@vger.kernel.org, David Disseldorp <ddiss@suse.de>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Michel Lespinasse <walken@google.com>,
        Helge Deller <deller@gmx.de>, Oleg Nesterov <oleg@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: Avoid mixing integer types in mem_rw()
Message-ID: <YJvV3jsotDj5COKe@localhost.localdomain>
References: <20210512125215.3348316-1-marcelo.cerri@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210512125215.3348316-1-marcelo.cerri@canonical.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 12, 2021 at 09:52:12AM -0300, Marcelo Henrique Cerri wrote:
> Use size_t when capping the count argument received by mem_rw(). Since
> count is size_t, using min_t(int, ...) can lead to a negative value
> that will later be passed to access_remote_vm(), which can cause
> unexpected behavior.
> 
> Since we are capping the value to at maximum PAGE_SIZE, the conversion
> from size_t to int when passing it to access_remote_vm() as "len"
> shouldn't be a problem.

> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -854,7 +854,7 @@ static ssize_t mem_rw(struct file *file, char __user *buf,
>  	flags = FOLL_FORCE | (write ? FOLL_WRITE : 0);
>  
>  	while (count > 0) {
> -		int this_len = min_t(int, count, PAGE_SIZE);
> +		size_t this_len = min_t(size_t, count, PAGE_SIZE);

As much as I don't like signed integers, VFS caps read/write lengths
at INT_MAX & PAGE_MASK, so casting doesn't change values.
