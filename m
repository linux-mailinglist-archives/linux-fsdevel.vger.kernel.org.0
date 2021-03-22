Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8082F343CBD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 10:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhCVJ1N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 05:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbhCVJ0m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 05:26:42 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D792C061756
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Mar 2021 02:26:41 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id mz6-20020a17090b3786b02900c16cb41d63so8194052pjb.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Mar 2021 02:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j6MQYdgV4+wrTyHhu2dfzLl8kL+VrmbYPGbkoPs/QS8=;
        b=diQyqW5ujUZUblbt4D/7jo9LBNUMguG/HQqovdtOTW5/q+hkldXGSyg+FkHbv01hyy
         pUndIPR3X/gJ3G/x8gM0LA/D2ePJo2eb3QW6+pkYkNCtdfxqQX7KuGb2YNsSJqf5x6sv
         21L0K+LjYZvr9lCqfiLvM0CYvifCgk+G4PIXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j6MQYdgV4+wrTyHhu2dfzLl8kL+VrmbYPGbkoPs/QS8=;
        b=Yk07/UYZPijolZyd11YWBxC/go8c3Xk8bB6Lz9zO4nbikDjtuXYV2wPPfEVTlKABY6
         Xv7JAgu8L2Is2TdkyaoIZRF9DNCNHEBz/TjtJdJB+9y3colBtKc4gMe0gr+kyosaUdoE
         4oGFapI/twl2VHlk/qERmULpBMjEbC3JNBL5FH21ouKwXPULS++QQ8Rxe9SL1KtHheoQ
         RBsez7cgvFzGfpGP2NAUrg4sd5SedF//Rj4Jc17z5BJpBc6NJtmyUBR1I6AnWytot4jQ
         CrgCbf3GfHb4nu514Bn3g1PJmQHUAMYu0hkloIYc1T1GAWYUP+nYbsxVX/UF3223BMan
         p67A==
X-Gm-Message-State: AOAM5308F6tMUSgNs5utljftn2+sUw4WL8j02y4nhjFQjvoD8RTTqEje
        8MQ8pNj0SFzPmqMZ67cNtw2OEQ==
X-Google-Smtp-Source: ABdhPJy+c1RRte8KJzydWERQtlrVDreSmQJ8y8cuu6lFGFvXDdmgRUBmxUwiwQ0qSUtwvjRUqfv/1A==
X-Received: by 2002:a17:90a:5898:: with SMTP id j24mr12508922pji.103.1616405200556;
        Mon, 22 Mar 2021 02:26:40 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:b1b5:270:5df6:6d6e])
        by smtp.gmail.com with ESMTPSA id v25sm13197661pfn.51.2021.03.22.02.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 02:26:40 -0700 (PDT)
Date:   Mon, 22 Mar 2021 18:26:33 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org,
        linux-cifsd-devel@lists.sourceforge.net, smfrench@gmail.com,
        senozhatsky@chromium.org, hyc.lee@gmail.com, hch@lst.de,
        hch@infradead.org, ronniesahlberg@gmail.com,
        aurelien.aptel@gmail.com, aaptel@suse.com, sandeen@sandeen.net,
        dan.carpenter@oracle.com, colin.king@canonical.com,
        rdunlap@infradead.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steve French <stfrench@microsoft.com>
Subject: Re: [PATCH 3/5] cifsd: add file operations
Message-ID: <YFhiySJYbWW8bq6C@google.com>
References: <20210322051344.1706-1-namjae.jeon@samsung.com>
 <CGME20210322052207epcas1p3f0a5bdfd2c994a849a67b465479d0721@epcas1p3.samsung.com>
 <20210322051344.1706-4-namjae.jeon@samsung.com>
 <YFhBHScj4QxLl/Ef@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFhBHScj4QxLl/Ef@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On (21/03/22 07:02), Al Viro wrote:
> On Mon, Mar 22, 2021 at 02:13:42PM +0900, Namjae Jeon wrote:
> > +static struct ksmbd_file *__ksmbd_lookup_fd(struct ksmbd_file_table *ft,
> > +					    unsigned int id)
> > +{
> > +	bool unclaimed = true;
> > +	struct ksmbd_file *fp;
> > +
> > +	read_lock(&ft->lock);
> > +	fp = idr_find(ft->idr, id);
> > +	if (fp)
> > +		fp = ksmbd_fp_get(fp);
> > +
> > +	if (fp && fp->f_ci) {
> > +		read_lock(&fp->f_ci->m_lock);
> > +		unclaimed = list_empty(&fp->node);
> > +		read_unlock(&fp->f_ci->m_lock);
> > +	}
> > +	read_unlock(&ft->lock);
> > +
> > +	if (fp && unclaimed) {
> > +		atomic_dec(&fp->refcount);
> > +		return NULL;
> > +	}
>
> Can that atomic_dec() end up dropping the last remaining reference?

Yes, I think it should increment refcount only for "claimed" fp.
