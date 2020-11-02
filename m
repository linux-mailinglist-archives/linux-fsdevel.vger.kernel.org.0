Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF422A34A2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 20:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbgKBTyi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 14:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbgKBTxC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 14:53:02 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91700C0617A6
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 11:53:02 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id k9so12607380qki.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2020 11:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tRpHX6TuixqX0zoC3FShnM5nu7Jz3uomOWzNoAXQH0Y=;
        b=Le1CE8jdLUG7iH2ZbaDHr74iivpBlDqdM+jJpAEeibF8M/o/ALn3v0H3M2ivEevfD4
         pgziMhe+mjyPK+7g/Z0d2srOChwkVrS4klU2t75Hgbr2avNO7VBAOqsfCEphEB7V4gvI
         luAUQFz78zxhRIEDCFJXQzJFuHPt2y7qFmBXgy3HKTNkAoMXzabhUAN7NMGizA6mQBhl
         mJOoT1ovK2MRCeZPQYBA6zGN0JPasKxMg9khfGXZCnMpaO3PvFfY8VC3pkn5m+B+aFJF
         BXGcgv5R/ItEPmxo6FKS861u62wW+/VB2wN0srYv4iD2NXjJOOAUv/JfAyfRxLDC8llZ
         jcOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tRpHX6TuixqX0zoC3FShnM5nu7Jz3uomOWzNoAXQH0Y=;
        b=spDcfQ3UsFSY/ZBPQSXRQeK9AEZ6VFbFgLAZo5R4wqfBjFTLZgTq78F7jmYoQNlzCw
         zk2sJCeS+INHQKYa2h+8SjKJVpWzEK328fxgeiZtzUu9fvrmZA3ckPef0grN+8Ryq13E
         lR+F+8BGiiiY39bbMtvV/EpKRf+WsuEPjQaIu6uFT0lmW081NmHzB8RSU04oHOlzUgjH
         uPbkJ5PxuyMikt0XCG33o5Ka995cgIICb1YYRejN22XRudkmBK5p5mLwAWH33TQ9ZvNo
         ht5ofk7IQB60s+j3J21s7XPdvHM/Irft479TeUoYKH+GkPzfTP3B4sqjUkvUhcB+RD2M
         aYnA==
X-Gm-Message-State: AOAM531hC//U7YfA2GEZNcg1MPfTUmRlj1tlxvHqCTIm9Ncu/f1RNLgc
        5aPHWBdU08brMhBv5IDAMXEIILAmeDlV
X-Google-Smtp-Source: ABdhPJzlABJGg390TZxS9S36QWbx0jz90giUoM8ghPnU6In29O1IBpcGrCJ0Tc6Wqu0G2NYf08WU+Q==
X-Received: by 2002:a37:4c81:: with SMTP id z123mr13213882qka.249.1604346781894;
        Mon, 02 Nov 2020 11:53:01 -0800 (PST)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id m25sm8685425qki.105.2020.11.02.11.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 11:53:01 -0800 (PST)
Date:   Mon, 2 Nov 2020 14:52:59 -0500
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de
Subject: Re: [PATCH 13/17] mm/filemap: Remove parameters from
 filemap_update_page()
Message-ID: <20201102195259.GQ2123636@moria.home.lan>
References: <20201102184312.25926-1-willy@infradead.org>
 <20201102184312.25926-14-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102184312.25926-14-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 02, 2020 at 06:43:08PM +0000, Matthew Wilcox (Oracle) wrote:
> The 'pos' and 'count' params are no longer used in filemap_update_page()
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
