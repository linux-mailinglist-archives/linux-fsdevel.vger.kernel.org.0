Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 069FA2A34E0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 21:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgKBUGd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 15:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgKBUGW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 15:06:22 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A809C0617A6
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 12:06:22 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id h12so10116558qtu.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2020 12:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IhFfXSIkOhUO5GsiKgFe6mbFiJFskGfANVrm7Fl4UcY=;
        b=c7oyqMZN3m3/OdJEJkXjKYZ/R5uxoI637ahr3XVstdTu2vGwLdxyWz8FJFW/j+sypR
         it/5UCdprGWYkUAsi4O9XTMb0+soNPtNVHj0BPZnsWgVDzr++7M1FWEBvkmAek8vA8Ft
         wDx5n666AOad1f1SJiNQxDd8eBQvEjGFjI8JETCKKQcXWWrE4sS/ZYeFSpaToWB/a465
         QGh4/xUcAFYd+Vw+YADiLylNpS/PTLPoxz8y2L0I54N93BdbT6QdksB/a+V6nAD8JlSx
         Yh3/gkK/OnXO4z8XG4dTY0WwvFt/AZ3sB1QyXeVbB+Ub59ZV/bqEiwMaMHo3yGT2gKX9
         Pg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IhFfXSIkOhUO5GsiKgFe6mbFiJFskGfANVrm7Fl4UcY=;
        b=bbJJ3l8NCtOvH33qUYjJScRp85U2vFpWZoKO49wqHT/Dnw9ADkSFjmYPa+F2N7Uvqs
         1TFRmgUiMy2osbcfK5/xHSHauFMnnkgLkuP5NQ5lAtjWgSCd+E9ructawhAwSGVAkHA8
         S2aTyDL34S+S2k0G4IqtnKWbXKWUXY0xoDMhk82lq/hA/vC7h5aavdUROZtN4WvKn981
         sh5N8S1pxqYkW8gcp9ub4eGpPX4JPrejdSCgsGCiIQ8ojL2EK40IpzDMMs2fWuQGuxJB
         8L9NU4nNTYLNwLGA+ivKTuI03WM2t8QrIgy6CA2zgE/pgR57faFsxa/TOgMslh+DQoBY
         8i/Q==
X-Gm-Message-State: AOAM5324g0s+pQJjYMeUdglzT3ZYf8VEspWgVJ7Wp+wxy1n4P0p2MtD+
        uNVx50IVcJIE5bT8Zo3ButJk20v6th0h
X-Google-Smtp-Source: ABdhPJzphEc3oUZrFC7IJ1Oo10vnHJVYjIZNaZa6tOgt47B6lfqEm1NfbfVt2Ag8pEIRQZc4TGyFDw==
X-Received: by 2002:ac8:5cc2:: with SMTP id s2mr15667004qta.314.1604347581500;
        Mon, 02 Nov 2020 12:06:21 -0800 (PST)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id q20sm8836491qtl.69.2020.11.02.12.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 12:06:21 -0800 (PST)
Date:   Mon, 2 Nov 2020 15:06:19 -0500
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de
Subject: Re: [PATCH 15/17] mm/filemap: Don't relock the page after calling
 readpage
Message-ID: <20201102200619.GS2123636@moria.home.lan>
References: <20201102184312.25926-1-willy@infradead.org>
 <20201102184312.25926-16-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102184312.25926-16-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 02, 2020 at 06:43:10PM +0000, Matthew Wilcox (Oracle) wrote:
> We don't need to get the page lock again; we just need to wait for
> the I/O to finish, so use wait_on_page_locked_killable() like the
> other callers of ->readpage.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
