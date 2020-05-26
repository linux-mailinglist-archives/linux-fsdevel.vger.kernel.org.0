Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338F91E31F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 May 2020 00:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391769AbgEZWCD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 May 2020 18:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391750AbgEZWB7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 May 2020 18:01:59 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E6DC03E96E
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2020 15:01:58 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id n11so16939586qkn.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2020 15:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wFyf2LBGYvGusFP43rIvmvMj6csrO70L2r6mtlSO9dc=;
        b=rYoyg9+Je2ZBkMoBWH+yfXZTkMNPG3iZ7HGEW4+JjsmhEjNiDpAe1ETwdFHs+wTTlv
         4yhWBvRVkVch6Vej6DUgMlS4Jc42HJEtgEQUjSxP9gTpcltSad7v0TEUXW13sdqFE2PJ
         KEXFT7oict3RSbVycqpeCDDhp/h0RuzDMF9/Bmo9CeoypDDxe6T3c/OMAYLoNQm9lJPA
         AnSJKjEMcLEQAXln/0ZWFX+/zbrpqpHb2PaqRGpRXME10WwcP6cdnVtE/J3zJH+hFXZU
         eb8NHqLdWN174rh02bYHFO16mvHbBjThrty93MBSnpbbcsI/o+CNCLTH3SYehDygMlov
         Xo+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wFyf2LBGYvGusFP43rIvmvMj6csrO70L2r6mtlSO9dc=;
        b=ssnap0gwWw046kB1l4bovYLQhRIgUXmUqunrIbiRaAIbFG3YVVkIaaoyK67S286pHz
         fa/vIbL4gdFX86CnxXe+GNk3W9/1Oyj4EZROSAzE3l0RR+98FIHOwLYRIeAbI5JZmbc4
         dOKEcEMVUoaVboIcNlHltvsxgtzpEKJh0Swblc9NHAZkp5bdcHY6sy7DZAlD1OVm50dU
         olFiM7o52U2wg4S9TYKF6yO/tdHH/tP7M4btS9HOV5h2XkgDvlDA1yQGXC99TzcDa6PU
         qhmk1W/Q/uas6SrILl80gx661HbrI+X7nOPXPp/3Ew3gcFDawbG/rLf03VB/2ofZpS6t
         R7cg==
X-Gm-Message-State: AOAM5319BOTu6sfFQbCkBUO9Of6UmLNRHN5Ut7ezQQpECGjwGTpDmDxB
        BBOlBWUShSa/aw5dT/L3hkjYpQ==
X-Google-Smtp-Source: ABdhPJzYfNSECc3ExsPyOFv3thSrOj31TioNh+sxpB0emnK2SYr5mr5i6LVkpZtDvB3rkXw+/mjL8g==
X-Received: by 2002:a37:e101:: with SMTP id c1mr942846qkm.433.1590530517442;
        Tue, 26 May 2020 15:01:57 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2921])
        by smtp.gmail.com with ESMTPSA id n68sm700264qkb.58.2020.05.26.15.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 15:01:56 -0700 (PDT)
Date:   Tue, 26 May 2020 18:01:33 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH 11/12] mm: add kiocb_wait_page_queue_init() helper
Message-ID: <20200526220133.GE6781@cmpxchg.org>
References: <20200526195123.29053-1-axboe@kernel.dk>
 <20200526195123.29053-12-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526195123.29053-12-axboe@kernel.dk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 26, 2020 at 01:51:22PM -0600, Jens Axboe wrote:
> Checks if the file supports it, and initializes the values that we need.
> Caller passes in 'data' pointer, if any, and the callback function to
> be used.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
