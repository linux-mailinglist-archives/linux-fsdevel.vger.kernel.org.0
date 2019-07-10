Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4E5864BC5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2019 19:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfGJR7J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jul 2019 13:59:09 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45854 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbfGJR7J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jul 2019 13:59:09 -0400
Received: by mail-pg1-f194.google.com with SMTP id o13so1584836pgp.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jul 2019 10:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ES97aFmR5L44lLqRIVOCJ8hUxBvKgXhJbYiu6/Q0/Fc=;
        b=G2Jp6Kw0GGV35fsgDKNHqJfaM2heLRlNcrWhIIyjt3IJlC+NnRqCSKz3hZP4Fu887z
         dLBsxgJdCYEXhvDJAp3WncuhblsZDmYVCC2kQkS4he/c15xnvz5aiyCqSdp9VDsJmtyl
         X4Xfx4ip5r0bjXUypnNqrUjDim4ROXbrVkV+AZoYurquMpsbvjV3UGR3mvY59J4Erd/Q
         HfxhW7ZRcsJPApUQIYhWqYnFzemVB04iMIOfP8a0p1Z57U4tObOxvtzDBBNj4fUP3H9H
         YllCevWMv7u9kprPq+Y6qJSXms6qEKoWNmdB8ooErkpLpmr/kzmE0sWEDfpRKKj3QL55
         8WVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ES97aFmR5L44lLqRIVOCJ8hUxBvKgXhJbYiu6/Q0/Fc=;
        b=W9q5Ey9FsN0MCBfQEr9eBAxB/mJQ9XUhU3I58NN6w6VbBWGXRZotOE4FpI1GQMb4Uk
         2n3hWVeHHW782H0JzM/CVGVC88bZbHzlpzroUj12P6o8GAj0R/Ptz3kDVfoh6xnVP1aM
         I442oktql4AaeyUdR7hjhnEEGAgPhD8OiSLCq0jeuOuc17EZNqfzeXAvp8Axb1hxEFvr
         tRmewiyWfOyE+VMjeGix/cwzsoMLEOZTFBL15oCicn8n3nAS2Z7OwDI9y65VR2XNKDnF
         L19M4IRXzNwTpQDGfDSgJnMus1j8pprIgwK2vuzUUqzoH3iMD7oT67avuz5/gA1esQp3
         ICQQ==
X-Gm-Message-State: APjAAAWQGTi7O83HuaNZUpFLBhX7m43TurOnHRFiLeHRO8Oo9MY5JHjC
        8E8EL/iWDl0f0OCnuo9/CdSQ6g==
X-Google-Smtp-Source: APXvYqyO4Vg3ye0b1RbrpmbLDKJYF/6XJJtpfFq/5KqsBldN0dxT158xtqFfP0Z4CzvYy6JnEEB0wQ==
X-Received: by 2002:a63:eb56:: with SMTP id b22mr38678975pgk.355.1562781548877;
        Wed, 10 Jul 2019 10:59:08 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:5b9d])
        by smtp.gmail.com with ESMTPSA id m5sm3325435pfa.116.2019.07.10.10.59.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 10:59:08 -0700 (PDT)
Date:   Wed, 10 Jul 2019 13:59:05 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, matthew.wilcox@oracle.com,
        kirill.shutemov@linux.intel.com, kernel-team@fb.com,
        william.kucharski@oracle.com, akpm@linux-foundation.org,
        hdanton@sina.com
Subject: Re: [PATCH v9 3/6] mm,thp: stats for file backed THP
Message-ID: <20190710175905.GD11197@cmpxchg.org>
References: <20190625001246.685563-1-songliubraving@fb.com>
 <20190625001246.685563-4-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625001246.685563-4-songliubraving@fb.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 24, 2019 at 05:12:43PM -0700, Song Liu wrote:
> @@ -413,6 +413,7 @@ struct mem_size_stats {
>  	unsigned long lazyfree;
>  	unsigned long anonymous_thp;
>  	unsigned long shmem_thp;
> +	unsigned long file_thp;

This appears to be unused.

Other than that, this looks good to me. It's a bit of a shame that
it's not symmetrical with the anon THP stats, but that already
diverged on shmem pages, so not your fault... Ah well.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
