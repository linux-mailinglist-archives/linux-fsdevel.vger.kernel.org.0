Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3B718DBD6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Mar 2020 00:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbgCTXYV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Mar 2020 19:24:21 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42040 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgCTXYV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Mar 2020 19:24:21 -0400
Received: by mail-ot1-f65.google.com with SMTP id f66so2246553otf.9;
        Fri, 20 Mar 2020 16:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=r1RjSBup4MWDnxcSCK94McxMdoDpG8eO0JDhY4wpKR0=;
        b=vN1/Ute8SimVqT3y3hab78UyOf4VVJ7VRiHOmD/0YEw4RVsLYf+I9I+znQgoZJ4gdB
         ictTZbD1FHachCP/sbEN+nf5NkPQ3zRL8Ac1BelFOIse/g9g6UpeoAfXXPC7J0vE8auY
         ePcveIYKTMSHJgWhosQIxl0CCrkGF9pmyNFPTwd0v+oVmX5riIDdzQ03F5K6zEp+Yorg
         xUhrv1K+sA6wqpG3J43WbuJGu1I6tO2+B7xlqRuhBhDVQUlM25cT94sYTuO+2rNTPHR+
         wUJD/jin1TicQd15MZDDptDmvyxFQ3GYs+b1BI3MQaatUfXjIV8IMG9GTl9ZI1NYxiQ/
         JVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=r1RjSBup4MWDnxcSCK94McxMdoDpG8eO0JDhY4wpKR0=;
        b=QZL1jtNh8XPVs7unt5QmsDE91zm2o+d6HscepsjM8qz3umFWJHFut6LIFLnr/+O+26
         ajJ0TQEeL4kOtITohA1I/2eHwsLraFrkh3u18ik3AWrKLZMGhpqgrvXNzW9rtpxAuVCc
         v0kGmtCJ8uEDMl5p18lPn2lQi20cPNbAPHurVBCpLuBDe8lH7fkGWzpHbSAIJRqL2EEA
         6cUraD5laSLsO5X8GoBSj/CirYRexbb4A/GnnRL20QI+vLe05lXEaUxcWT/24LU1OffJ
         bHn9w/xyadmMpSpWtrOZE1GRBXYG0RKyU+TnHt1ftBxy/TeWL30Savdx/gCL52LAqqeN
         LwNQ==
X-Gm-Message-State: ANhLgQ0L4NL6VJTLyfkHNa6bBh093xQ8sQK+HFBaSBG27aQkVGUqkY2C
        ns3S3c+jYPPpV6vE+jXVoyv1i1rwigix0DJl5LE=
X-Google-Smtp-Source: ADFU+vvk42JpEDDDlDUp6QEGUIHSuidkoO4gJ/JVIxwHCPUSqqRu1OBVOgg9ZhRrthX3kgHdC2yuDHRY3AYH9iDgANA=
X-Received: by 2002:a05:6830:1608:: with SMTP id g8mr9414965otr.282.1584746659261;
 Fri, 20 Mar 2020 16:24:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:8e:0:0:0:0:0 with HTTP; Fri, 20 Mar 2020 16:24:18 -0700 (PDT)
In-Reply-To: <20200320142231.2402-17-willy@infradead.org>
References: <20200320142231.2402-1-willy@infradead.org> <20200320142231.2402-17-willy@infradead.org>
From:   Namjae Jeon <linkinjeon@gmail.com>
Date:   Sat, 21 Mar 2020 08:24:18 +0900
Message-ID: <CAKYAXd-NGQvMoYg=TV1T=8OZdQcYwcncK_Hix8OkF0GqmYr9Wg@mail.gmail.com>
Subject: Re: [PATCH v9 16/25] fs: Convert mpage_readpages to mpage_readahead
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Dave Chinner <dchinner@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        William Kucharski <william.kucharski@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> diff --git a/drivers/staging/exfat/exfat_super.c
> b/drivers/staging/exfat/exfat_super.c
> index b81d2a87b82e..96aad9b16d31 100644
> --- a/drivers/staging/exfat/exfat_super.c
> +++ b/drivers/staging/exfat/exfat_super.c
Maybe, You should change fs/exfat instead of staging/exfat that is
gone from -next ?

> @@ -3002,10 +3002,9 @@ static int exfat_readpage(struct file *file, struct
> page *page)
>  	return  mpage_readpage(page, exfat_get_block);
>  }
>
> -static int exfat_readpages(struct file *file, struct address_space
> *mapping,
> -			   struct list_head *pages, unsigned int nr_pages)
> +static void exfat_readahead(struct readahead_control *rac)
>  {
> -	return  mpage_readpages(mapping, pages, nr_pages, exfat_get_block);
> +	mpage_readahead(rac, exfat_get_block);
>  }
>
>  static int exfat_writepage(struct page *page, struct writeback_control
> *wbc)
> @@ -3104,7 +3103,7 @@ static sector_t _exfat_bmap(struct address_space
> *mapping, sector_t block)
>
>  static const struct address_space_operations exfat_aops = {
>  	.readpage    = exfat_readpage,
> -	.readpages   = exfat_readpages,
> +	.readahead   = exfat_readahead,
>  	.writepage   = exfat_writepage,
>  	.writepages  = exfat_writepages,
>  	.write_begin = exfat_write_begin,
