Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2976F2A34DC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 21:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgKBUGd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 15:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgKBUFR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 15:05:17 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB7FC0617A6
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 12:05:17 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id a64so9274216qkc.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2020 12:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ii/vX3wIfh9EjK8XSXKI6R+0Ea/Qhhx0+Dtik41yeE0=;
        b=CfvvfRsCkNvvfcv4S256A5gAwSpz3rjTXflyWH0B1pS2kCdhhUj+18/4vUTcPG064H
         VVZh4BFTKtqoUY5PmyODLjpu3E4knctxEMsoTidtE58ikRxGmYEcLy0PmBgHUzTEysWS
         KMHXoAeLjGS3C66MP2/21bb+NxXs7oMeADkhtEw8ruQ2FhjGci/D6O7vRJ+3TT049l9M
         xpI5P5dLSpkNol49tgydBSxEmuljqd8DRef/syETwZduoBkTl75uieLdXX+ODUtyikEg
         FnfMMBazkyDBPJhNTx+US8SmRSpccUZG7I7l8I83xMTlWIWZO/sTj1EKWQqAhodDx6YB
         lUpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ii/vX3wIfh9EjK8XSXKI6R+0Ea/Qhhx0+Dtik41yeE0=;
        b=dlTVjY6/liRfy6sQjpISlMMft/7WMA4WMDsd+yf+Y/cf03rujQCAxa9/xOW63hFecZ
         OnG890Godm08G0dYmDEyslhuGdwmjHF3C2vQM37YrPtgZRRDgwVUAY145eAjYAqa9ohi
         Hmurn5YcfBkzVbzCS3W2bYmX3PA/TJr4O+aA1/Sq/ZIKqF9na39XhYqTz9juttmWlxVy
         I28Xun6RV7ZqTT2otyxuooIg+YE6ZXGKXxhC9bmOLYUBZJWY8OQInzpX8oLDms2lAeRL
         fiiR32VfhudhQkc1HmaoDlhxytlcKHa5/vQkY0QIJge6ATVjvHTJ4aXqEX7ndeFWimH7
         Or+Q==
X-Gm-Message-State: AOAM533a4+cQ8i50604GyN+bkYixQaowvkasZrjnLC4mdIgtUAGibWFr
        nqabjLU8nhPONPc6nDFG6cOzP5jkSZSW
X-Google-Smtp-Source: ABdhPJx7oRaSUvjdMlIqg4AVU+/4Bnz/DMtcrZVIR6KasBpGNOkDwHmaAbbCmcbdGpb6PtJln4aHmQ==
X-Received: by 2002:a37:4692:: with SMTP id t140mr17138786qka.275.1604347516764;
        Mon, 02 Nov 2020 12:05:16 -0800 (PST)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id z134sm8917191qka.21.2020.11.02.12.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 12:05:16 -0800 (PST)
Date:   Mon, 2 Nov 2020 15:05:14 -0500
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de
Subject: Re: [PATCH 14/17] mm/filemap: Restructure filemap_get_pages
Message-ID: <20201102200514.GR2123636@moria.home.lan>
References: <20201102184312.25926-1-willy@infradead.org>
 <20201102184312.25926-15-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102184312.25926-15-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 02, 2020 at 06:43:09PM +0000, Matthew Wilcox (Oracle) wrote:
> Avoid a goto, and by the time we get to calling filemap_update_page(),
> we definitely have at least one page.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
