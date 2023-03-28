Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99106CCD46
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 00:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjC1WfC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 18:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjC1WfC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 18:35:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9FF1FF3
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 15:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680042845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vkpdjubpMQjiQrtoGJ7oK57t1Yfgq8+XT8+ZZ9ZSzy4=;
        b=UiWHKJJ6ICsP19TzoZ0Hg9Dpc643ubm3785YrpgSvXM+oQfLs00vtfnl0euY8vn7UoGmXv
        D2flF0HuDlbpBwSBeNkiVf7h6PfNhq8cr9CBv50j7UvCw9AwEIF87pdECBB4TnJdFwQngy
        h0OlFh97Fk3XFhX2x19UzFy5RuXHsMU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-uAtcAMphPtStZVPLwQ3WAw-1; Tue, 28 Mar 2023 18:34:04 -0400
X-MC-Unique: uAtcAMphPtStZVPLwQ3WAw-1
Received: by mail-qk1-f198.google.com with SMTP id 198-20020a370bcf000000b007468cffa4e2so6406933qkl.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 15:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680042844; x=1682634844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vkpdjubpMQjiQrtoGJ7oK57t1Yfgq8+XT8+ZZ9ZSzy4=;
        b=w9x6Y/93a9LPTJquhPsU3rtPTMTOJ8R9bdt7j9dr30mMXJeuAM38VLpZkZIsk1jhhO
         dtwDfSuBsFtYP4q41Kepkom6nXN7w8vtQsO91Vv15QMs6Ipp+NuE01PkN4NKUWp4HA6r
         5x9ej4O85OFetoT/7rU4IEGdhv6eK/PUbFkzSG2F9rNI4uFj7rsUcInWQwcfO+MxclwF
         lqgIPj4v135ahDW80x68Zr7AP6/xJ6vBjY76qVHHI1RcvFeKjOcboJhOFxJKG7BkyK3l
         zJ2QpifGmZwbfJU6ImvPjQVtKGPlAfcu1DHnsi6nhTe7Fw7jep2qr7LzI7vWxcMSQFy8
         c5Og==
X-Gm-Message-State: AAQBX9cJcDljIXLU7vLTNWjjJtLioUWgHtimmhjuF2wHTONFP2/8Sx6S
        FqTtDGDWQBWjNm6aN5CG0hmjZn9Uz+MWQeaTLIc337iarhk9WO0Ys17beu3rbQF/+AccOE8J+tn
        tGBrGkDvWzl5B7cr2KllqOKXkyg==
X-Received: by 2002:a05:6214:5193:b0:5de:5da:b873 with SMTP id kl19-20020a056214519300b005de05dab873mr18587370qvb.3.1680042843876;
        Tue, 28 Mar 2023 15:34:03 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZlkAe0JI1+oDavIAHK0xd280kRJjj3GuPG2q8zblgmaz2X3JUxxxw5dA5sSDbyGlM93yJtow==
X-Received: by 2002:a05:6214:5193:b0:5de:5da:b873 with SMTP id kl19-20020a056214519300b005de05dab873mr18587348qvb.3.1680042843586;
        Tue, 28 Mar 2023 15:34:03 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id 11-20020a37030b000000b00745a55db5a3sm12310243qkd.24.2023.03.28.15.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 15:34:02 -0700 (PDT)
Date:   Tue, 28 Mar 2023 18:34:01 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] userfaultfd: don't fail on unrecognized features
Message-ID: <ZCNrWRKl4nCJX3pg@x1n>
References: <20220722201513.1624158-1-axelrasmussen@google.com>
 <ZCIEGblnsWHKF8RD@x1n>
 <CAJHvVcj5ysY-xqKLL8f48-vFhpAB+qf4cN0AesQEd7Kvsi9r_A@mail.gmail.com>
 <ZCNDxhANoQmgcufM@x1n>
 <CAJHvVcjU8QRLqFmk5GXbmOJgKp+XyVHMCS0hABtWmHTDuCusLA@mail.gmail.com>
 <ZCNPFDK0vmzyGIHb@x1n>
 <CAJHvVciwT0xw3Nu2Fpi-7H9iR92xK7VB31dYLfmJF5K3vQxvFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVciwT0xw3Nu2Fpi-7H9iR92xK7VB31dYLfmJF5K3vQxvFQ@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 28, 2023 at 02:52:35PM -0700, Axel Rasmussen wrote:
> I don't see being very strict here as useful. Another example might be
> madvise() - for example trying to MADV_PAGEOUT on a kernel that
> doesn't support it. There is no way the kernel can proceed here, since
> it simply doesn't know how to do what you're asking for. In this case
> an error makes sense.

IMHO, PAGEOUT is not a great example.  I wished we can have a way to probe
what madvise() the system supports, and I know many people wanted that too.
I even had a feeling that we'll have it some day.

So now I'm going back to look at this patch assuming I'm reviewing it, I'm
still not convinced the old API needs changing.

Userfaultfd allows probing with features=0 with/without this patch, so I
see this patch as something that doesn't bring a direct functional benefit,
but some kind of api change due to subjective preferences which I cannot
say right or wrong.  Now the patch is already merged.  If we need to change
either this patch or the man page to make them match again, again I'd
prefer we simply revert it to keep everything like before and copy stable.

Thanks,

-- 
Peter Xu

