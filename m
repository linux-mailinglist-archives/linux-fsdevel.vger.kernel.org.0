Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734AD2A3494
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 20:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbgKBTw2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 14:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgKBTu7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 14:50:59 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4244BC0617A6
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 11:50:59 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id l2so12647990qkf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2020 11:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gc894B4zoxADm5OprgejF9jDffPRWPrPePcZPiXs5dY=;
        b=Lk8ZJ4UEEBwRfY4lJaVhBBy0agEt9NQpIUYLoo2W5tDvyc5FLb8o5lu5XfFoAnTPC3
         X2CGlFK3bMGJsM75AiJWCvQuTT8rwFlKiSo/s4mzdAnRmxWqKV5WpPmpZx3yZbmo8Q5p
         JE5K4XgQn+sydA9c1CKPjaxioNM8W16B38GzSy5CEhi0kmbU2qP97MUVQDP5nEokhZWd
         hF9MBeNHMCxS7Adb6EJu60BEao3Xt4EO4oLpt68NLHsg4ygFsiH2byLwqJaDulKkN/LB
         XZ+z3MN06uLPR0+XHptA01KNTH876CVjmm3OSHYRIjymhihJVvtsgkHy50xs6DcQD1BX
         gyMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gc894B4zoxADm5OprgejF9jDffPRWPrPePcZPiXs5dY=;
        b=uHs/sUGcPE2QA7VXUzW2N0rg7gmyBCZV4gv5/TX0HtIcqNtv6Z2n/l6htMNlxueC/A
         kAKCdcBY3G+2bTznIcWT2cXtEQDHAau5912P0AOGtcnac9kQpuGtZUNtqz3gyHKzq0Ba
         vgR70VQ85o0qVZypLJtloNEGRGi90H/Hc1bzWQ7pcxiDQir9nwekbNueDEOlPr/439n6
         AILvHU+IqT3gnIvbLHU9LTCzhDxRPNMvB+Qy5O4fZQZ4p0e04RRSyUIPFELi6tSYpJgL
         by2PeJlE1/pZ6Hte7Zyq09Ws/vklkT4ozSoqoL/bwMfULC5vYOvOtKXvJnDiUC2O4hEG
         PdfA==
X-Gm-Message-State: AOAM530MxZX9/5zpo9Y43oCIufsgFbvTgXqh4YsHEbc4JIOoA8jZSE2d
        tOlysHhfQGFfdMqezUcW9zlfpZ+/8Dvb
X-Google-Smtp-Source: ABdhPJzdpYW7OjInoujEjF7ASVOXKF5+I81mZOkDPMvkfyGd6315+1IDRcNHkw3TSdlBHjtTdNmgoA==
X-Received: by 2002:ae9:e508:: with SMTP id w8mr16726122qkf.110.1604346658565;
        Mon, 02 Nov 2020 11:50:58 -0800 (PST)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id o63sm3967962qkd.96.2020.11.02.11.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 11:50:58 -0800 (PST)
Date:   Mon, 2 Nov 2020 14:50:56 -0500
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de
Subject: Re: [PATCH 11/17] mm/filemap: Add filemap_range_uptodate
Message-ID: <20201102195056.GO2123636@moria.home.lan>
References: <20201102184312.25926-1-willy@infradead.org>
 <20201102184312.25926-12-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102184312.25926-12-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 02, 2020 at 06:43:06PM +0000, Matthew Wilcox (Oracle) wrote:
> Move the complicated condition and the calculations out of
> filemap_update_page() into its own function.

You're missing a signed-off-by

Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
