Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956B72C8DF1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 20:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729928AbgK3TVM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 14:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729921AbgK3TVF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 14:21:05 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000ACC0613CF
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Nov 2020 11:20:19 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id v21so7008219plo.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Nov 2020 11:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YPx6KAaJQYZ9LMgvuman8b1Zu51OwsYSMrhXlN/pSyo=;
        b=1ZYQ1Sj10JfNbvLVfhXcfbMu8dNtj3dcCtQWpB63cbeklmhlKJ0tjF3j5QDQjsflkW
         TqnuMAr7QJUnwRAqWOeLl3VGdiPNWH1Oux6wywgBh/f5yrPElz5PzS2FnxNprTJgtruH
         fCPthmg/AQzAvWJ4exQyMwwLU1nlM+NGy1VA9lpN4oM7AFqZ8EKVi3jC7gP4GyvhPKGH
         qUzCmTmJKtbBPlxrR8OV7m3HI+WkyFmIqC8I3t+Jqy5uIbGP1OJaASCQ+rRrjocGbTbr
         z5a4a7aP/jfXritiE6FQG42lzThw07ozaMJY2e6DdCumMSoLSlE+OGCCIa3be4CxZKCq
         6LVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YPx6KAaJQYZ9LMgvuman8b1Zu51OwsYSMrhXlN/pSyo=;
        b=kbsJEbQ12ngQinbam5btAVXFLyfnJZyhIUgtBYgQpU8x9ogb+eR1fYtj7ZpK7gc73e
         Y27CeOFcZSmrHOA2Vm7Y2XwMs4P45T5CXbKX3EeMia4wmH7iRnJc42Yp6IVGdHBPmi1i
         u8pDK9npe7iUbqvaqVqiALgrZ633qTHf8pdfhevhIHyjzkp/OhJAlNhtlbYs5/3WPszV
         XIlWrkG+fjUSImxGWOKOUNQ7jdkW6IGyt+Egud2hFNrPVSj4iTd02Ym2QCtOMIxucBmU
         GdpJrsE5mq9drBYImJksGonBlPyrW+pec0XyW1EjjieWEddyDoJZTxMqVKABZGMuFulS
         fNzg==
X-Gm-Message-State: AOAM5321Xla4UXykvf2iY6yYcArE1w6+aPNHmLgmxtfPYf6i3wCikXj0
        TSz8xKO36AojC7zAeJGFrvKdhg==
X-Google-Smtp-Source: ABdhPJwxmco5rDsraLzW/o1UM1b39rwGCsqNTj9Ovi3eTPRfSZLWiAeOXhOQs592Lg3/Fk+ksE9sGg==
X-Received: by 2002:a17:902:9a4c:b029:d6:a250:ab9f with SMTP id x12-20020a1709029a4cb02900d6a250ab9fmr20349781plv.20.1606764019470;
        Mon, 30 Nov 2020 11:20:19 -0800 (PST)
Received: from relinquished.localdomain ([2601:602:8b80:8e0::b2be])
        by smtp.gmail.com with ESMTPSA id u1sm17363448pfn.181.2020.11.30.11.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 11:20:18 -0800 (PST)
Date:   Mon, 30 Nov 2020 11:20:17 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     dsterba@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v6 05/11] btrfs: fix check_data_csum() error message for
 direct I/O
Message-ID: <X8VF8SzQOc7gPMxb@relinquished.localdomain>
References: <cover.1605723568.git.osandov@fb.com>
 <e33db7a6a4f56d0caedfe6a1aad131edca56b340.1605723568.git.osandov@fb.com>
 <20201123170956.GI8669@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123170956.GI8669@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 23, 2020 at 06:09:56PM +0100, David Sterba wrote:
> On Wed, Nov 18, 2020 at 11:18:12AM -0800, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > Commit 1dae796aabf6 ("btrfs: inode: sink parameter start and len to
> > check_data_csum()") replaced the start parameter to check_data_csum()
> > with page_offset(), but page_offset() is not meaningful for direct I/O
> > pages. Bring back the start parameter.
> > 
> > Fixes: 1dae796aabf6 ("btrfs: inode: sink parameter start and len to check_data_csum()")
> 
> This is part of the subpage preparatory patches still in misc-next , I
> can drop the part that removes the start parameter if you're going to
> use it.

To be clear, the original patch is buggy. It causes check_data_csum() to
print nonsense for checksum errors encountered during direct I/O. So,
this should be probably be folded in to the original patch.
