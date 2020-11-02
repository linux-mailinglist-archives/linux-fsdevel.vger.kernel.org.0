Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90512A347B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 20:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbgKBTpE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 14:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgKBTpE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 14:45:04 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0858DC0617A6
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 11:45:04 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id o205so5792356qke.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2020 11:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zoHRaC+q1DguR6osPtLp37nru+Ah4gIJ8FvwwtNiSoA=;
        b=JQIuOTsybW8pV5GAecS4UnX2d0D6KftM4kWyi8TXAknhPrXJNWVG95NwoahiXigX38
         PHcxowg7vEe/Dxts2Wf1i/kzvCflXaWHS3c5XLHBTWOLom3PZn0l0jflhrjHfMKD24l3
         Rm201RmtxDXXN3uTjJUHIvV3D2ulNy+Au7hxy3dQEA747yK+6dGnCa5ytqq+GhM0Qlu0
         vnqLK1jwN0EWipQn520FmhW7Hnw074zAXTo5rzf44T84vJd36R7HUsxVxSTGnm+OrdC1
         G/M2O8wiLX0i6316QDFk9o01fmLJV9wqjhKmVfqHZrdNIRSQX1Kv9tqeKXLhM3CqlRH3
         bW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zoHRaC+q1DguR6osPtLp37nru+Ah4gIJ8FvwwtNiSoA=;
        b=lpAW4iD/Sv5vDyRouLsVDJYZYbRVb1orCFSJSot9eki/uyvGEPORgqoNZS0JqRV4j+
         /a0p2WMN6S3jvhhbX2CaSw6oGLHi8tZA0BMGIz31+6v0LoWLV54kv2TdWXgsrgmWW7o1
         S3sg/2f6EjxXHg9JVeTL3zKpVEW+t+9uQ44ai/lf63b5jaQV7wVJORV1eR1ZKLb5Nc5h
         XUHPsMv/+jAnRGeGYNrMHKZCc7112x9v/omvhWTg0l/ePi6kfCkuRvKqcr8Mr97etY1B
         SXNhop5YSvpMk95jjbiJ3hYfd2v9QYVRjYo3SgNmz+vX2Pmiw7pLD4fEu82gCapUwIrF
         qjAA==
X-Gm-Message-State: AOAM530hDXtU+K6/JubZn53lmoZpW/naqkBd6ueKOgjmP4Ve+ROGmoJV
        mis0RSLIDxUyvnTwLSl1BIAy5zxonOSk
X-Google-Smtp-Source: ABdhPJyT/jeQmelYDuivBnYqCh+8j2EkOgNesXQqurJQnIlCp5c698O49YFZU5vWEFIXq9wsiFsm0Q==
X-Received: by 2002:a37:64d5:: with SMTP id y204mr11999066qkb.474.1604346303362;
        Mon, 02 Nov 2020 11:45:03 -0800 (PST)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id t18sm4418651qtr.1.2020.11.02.11.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 11:45:02 -0800 (PST)
Date:   Mon, 2 Nov 2020 14:45:01 -0500
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de
Subject: Re: [PATCH 10/17] mm/filemap: Move the iocb checks into
 filemap_update_page
Message-ID: <20201102194501.GN2123636@moria.home.lan>
References: <20201102184312.25926-1-willy@infradead.org>
 <20201102184312.25926-11-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102184312.25926-11-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 02, 2020 at 06:43:05PM +0000, Matthew Wilcox (Oracle) wrote:
> We don't need to give up when a special request sees a !Uptodate page.
> We may be able to satisfy the read from a partially-uptodate page.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
