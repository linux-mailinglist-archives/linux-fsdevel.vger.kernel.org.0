Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D023335FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 07:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbhCJGoL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 01:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhCJGoJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 01:44:09 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAFFC06174A;
        Tue,  9 Mar 2021 22:44:09 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id p21so10739559pgl.12;
        Tue, 09 Mar 2021 22:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/L+QoKkOaRmU+ASvLNzwIcYpCDJy7YDyKr/EVlNlog0=;
        b=hxg4SSMV7xEVGPAW+t4tjP+JM78kHwcrNk681W1WE7+p1kZ+xj/MAPeulJrQLfQ1gy
         MY78f9vcxT4ACEKQGyIeTjycuHdQ+upNs2h+l9ApfTQMwjzeo4xnXbO/yblNUCKz5aZx
         uED3zpD38W8XSVH3qz/7bY0vwOBbwEphFHXZ18/jS+mMFhAJD61ZEKe9OLlY1tIoLbzx
         Hm4FOHEJG1JyndZauPZufaRXdfPMrANl50bTCqfPxEwJVDso5EgwcoE1PKQ7NJ3gcWV8
         HL/+SHNCGzQD/5Kr1tBefd59ZIOJrtnWoY+1pz4BVbPDMk6q+AkjYCS7yvPX5a8RPezL
         f9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=/L+QoKkOaRmU+ASvLNzwIcYpCDJy7YDyKr/EVlNlog0=;
        b=R9/MvjXW6fvUii9POIk6liBw7XTTzjN9SurLQW2zpj0r6cY38C0rXdec+gDHmQXRgI
         9ZMNflfW/6EVGdH3iBQ+XO3tEL9DO/gmDJWsjrgKVdQO4mHZIF8WvHNPmUT3OialrJMV
         RrXBwx5B7UqcNRf+w366h21FR2DhEF2gWQAbOkPI5qW2OoggSHCQTXue/v+9xyeYnAou
         qBtpOmyK2YKzA1Ck7HPxS+V7McUFt/vfAMxayQ24RVbNmFM89pfy6Y4mxFts1pHVx1BM
         v+VY9Jvt0AgTvuOQ/xRcjQvyRnUUSIPYZCTCjpw5RTv5Vp7Pu9d9JlLLSSX+d0AABcWs
         4ZEQ==
X-Gm-Message-State: AOAM5332xDOuiLYRLh+QMTG0MuasyVQgmZrabF/ul/Gn2szStzyUHZrD
        l+i9PN+J/+QWqp+flAxbRHQ=
X-Google-Smtp-Source: ABdhPJyE9h1PLlojbu2FEG7rbWy4ivd0UsQWUfjnGqJufCi7a81cp7kJM+Xb8r/K5gK+wLcal7iYSA==
X-Received: by 2002:a63:4850:: with SMTP id x16mr1517211pgk.176.1615358648951;
        Tue, 09 Mar 2021 22:44:08 -0800 (PST)
Received: from google.com ([2620:15c:211:201:f896:d6be:86d4:a59b])
        by smtp.gmail.com with ESMTPSA id o1sm4933251pjp.4.2021.03.09.22.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 22:44:08 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 9 Mar 2021 22:44:05 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Vetter <daniel@ffwll.ch>, Nadav Amit <namit@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Nitin Gupta <ngupta@vflare.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 9/9] zsmalloc: remove the zsmalloc file system
Message-ID: <YEhqtTEhm3BnJ7hH@google.com>
References: <20210309155348.974875-1-hch@lst.de>
 <20210309155348.974875-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309155348.974875-10-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 09, 2021 at 04:53:48PM +0100, Christoph Hellwig wrote:
> Just use the generic anon_inode file system.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Minchan Kim <minchan@kernel.org>
