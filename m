Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD7B02A8B04
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 00:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731965AbgKEXtT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Nov 2020 18:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgKEXtT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Nov 2020 18:49:19 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C47C0613CF
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2020 15:49:19 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id ed14so1616678qvb.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2020 15:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DgoUim0RE7VTsBQkLODxQAwVVEN9jPOMsmq/urN5h1E=;
        b=iNRh/yc9uT4ydg+RmJQG5qK52zw+7ZSfW/zgRk8lB/8B5p6xN9PMLIwTFOW//sZ4fn
         Jhs+VtK2428HW9x+CzbIwA1D4Hd7qEiJf9tOgYMYFQ5N4p0pL05Yq/BT2KnAEZtL2hw9
         izP/lI3s+bCyfx12i0/bcKF2lNccwjyxEzgaQqcFMOLSGc++k9d2nbahKVmISQXbTT40
         4m5ME50Rnut7y0J1jpPo8bErpn1ALM3qjWxp11e0cECHVMIxfUxSCtbHo2RVAewce2rO
         KTdIi9mHYtkcNBc0ToYCCw4YizYYl9BAOqpOj817TI7wgGCzJgVLjLTXPuA+xYEfLfkp
         wzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DgoUim0RE7VTsBQkLODxQAwVVEN9jPOMsmq/urN5h1E=;
        b=cq/s1Hlu3LxHzV5RKTtouH4f9KRwrwAlEqbEU2FbaWJOdGM6YdEo5yQb5OHsi3F0eK
         bqlagKSZE5hmS5fjd3S2hCSlRAHZ0nYOL1xUrTgQDC13XWX4Hvcp++Qav3FyUnV/fOzg
         moxRxSiJtC4/reRq+QryruE3M7woD5cKnutYDNyDXEuL1tH0c4mlx2MihZPjUoSrSGln
         m6PbC3RO2Rl+i7km83NHBKcMwgqfQ3CoEGxz+PO5S8H09vveGP7uoIIp5EF48xZg/wBJ
         c03LX2KZysiXD2itOiLKQambQhlcT1a4fMiEfE9KS0JzOYLHUdFCijzBBRAC2ySve9p8
         zeKg==
X-Gm-Message-State: AOAM531wrr7pMLJt6KTsylj9+tAN/P5FWs8dn6CMYLR/HtpKLpvVJfpO
        pf1lC3hKLDGsPd55TgEqiQ==
X-Google-Smtp-Source: ABdhPJyeAMvJkFh50vMnXayDBR6yNOZTMAsb9BhGoLa4qcWzo554sQa6xeq2bqFl/0w9No2YUE6v3g==
X-Received: by 2002:a0c:b525:: with SMTP id d37mr4704602qve.31.1604620158685;
        Thu, 05 Nov 2020 15:49:18 -0800 (PST)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id o20sm1877106qtw.30.2020.11.05.15.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 15:49:18 -0800 (PST)
Date:   Thu, 5 Nov 2020 18:49:16 -0500
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] bcachefs: Convert to readahead
Message-ID: <20201105234916.GC3365678@moria.home.lan>
References: <20201105232839.23100-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105232839.23100-1-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 05, 2020 at 11:28:36PM +0000, Matthew Wilcox (Oracle) wrote:
> This version actually passes xfstests as opposed to freezing on
> the first time you use readahead like v1 did.  I think there are
> further simplifications that can be made, but this works.
> 
> Matthew Wilcox (Oracle) (3):
>   bcachefs: Convert to readahead
>   bcachefs: Remove page_state_init_for_read
>   bcachefs: Use attach_page_private and detach_page_private
> 
>  fs/bcachefs/fs-io.c | 112 +++++++++-----------------------------------
>  fs/bcachefs/fs-io.h |   3 +-
>  fs/bcachefs/fs.c    |   2 +-
>  3 files changed, 23 insertions(+), 94 deletions(-)

Thanks! Applied.
