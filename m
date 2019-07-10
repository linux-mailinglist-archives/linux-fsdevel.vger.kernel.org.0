Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03C7064B9A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2019 19:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbfGJRoY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jul 2019 13:44:24 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33105 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727463AbfGJRoY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jul 2019 13:44:24 -0400
Received: by mail-pg1-f196.google.com with SMTP id m4so1597364pgk.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jul 2019 10:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iWMY9Ra6fhg6EXLcSiaO3PQbn2oiv74r4PYLZuZM2BU=;
        b=axQtLVlxBbG2rukB4uIEh3aDgpy4FVcpO0GP/piahI3Obgr+rZibgLCVElkJiFLY7w
         3JeU1pgGcUvAjJcRn1s0c75htzs2+FGj/9N0jRvMyrTOIrRKuoNx+MB+l7IkG8G+s71L
         89cqtxOCVpM5EfPFLvBjibAvHWJvgCpc2nVLRUGbBX0UKtG1lxR7l/ToMmPkdPDSn7So
         fZ9asLA/swzK89Ng61WiyMSN19TnEfEsP0wWxWd6vVTYQ59wz7HTFto7++v2UlC/wnZt
         XCH/XEdhlxPfFZJ0WwkBRJ1tgzdA8vKk19ExiwlatWdYZVOo1JH5BsmesMvm1aWejERz
         pSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iWMY9Ra6fhg6EXLcSiaO3PQbn2oiv74r4PYLZuZM2BU=;
        b=K314S9jyQFfXJWalkYI9hjZAzUUJc2buKF7GLIg/ChUIQZrl2IaMEh85iYJVN/uDpv
         DMBZjaYkj1ehHklbhGw98eBzuDPCbhdcVkp9sMA3P/y687Fa5evMLXLmDziAQKepgOjy
         U12PQC9pCsZ6YNF3EP02wtOcNzwHOkMQrZGdJxkbS7eozo7FPFGSwXPsN5ns5dX1/pRZ
         gvFsfFHsG3dTerUyAjxg4K7LNw4bj1F+BZIa+PW7N6C/UoKVmFbAv3NBl+bAI2puZpm4
         pluE0lXcrucUOrqJp9iDRAqq07wx7140ZyYjddwp1leEOSLhzNKW2opzmh6JJSWl8C07
         ZIyg==
X-Gm-Message-State: APjAAAW/F+UB3czu1dK+WqYSI5AMfoAxiVHhMUs42IvODT92NrENDVLe
        RPYQ1khD0z08DmHrWsTlNyBP6g==
X-Google-Smtp-Source: APXvYqzEHvJg5Hy2iDWq+GUuLPTBgqSstjUxb2RpWlYFGd98AAweC/ipWaTWFhYqPANU2G6KTh+dcQ==
X-Received: by 2002:a63:2606:: with SMTP id m6mr38342826pgm.436.1562780663359;
        Wed, 10 Jul 2019 10:44:23 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:5b9d])
        by smtp.gmail.com with ESMTPSA id l189sm2874023pfl.7.2019.07.10.10.44.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 10:44:22 -0700 (PDT)
Date:   Wed, 10 Jul 2019 13:44:18 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, matthew.wilcox@oracle.com,
        kirill.shutemov@linux.intel.com, kernel-team@fb.com,
        william.kucharski@oracle.com, akpm@linux-foundation.org,
        hdanton@sina.com
Subject: Re: [PATCH v9 1/6] filemap: check compound_head(page)->mapping in
 filemap_fault()
Message-ID: <20190710174418.GA11197@cmpxchg.org>
References: <20190625001246.685563-1-songliubraving@fb.com>
 <20190625001246.685563-2-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625001246.685563-2-songliubraving@fb.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 24, 2019 at 05:12:41PM -0700, Song Liu wrote:
> Currently, filemap_fault() avoids trace condition with truncate by

                                   -t

> checking page->mapping == mapping. This does not work for compound
> pages. This patch let it check compound_head(page)->mapping instead.
>
> Acked-by: Rik van Riel <riel@surriel.com>
> Signed-off-by: Song Liu <songliubraving@fb.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
