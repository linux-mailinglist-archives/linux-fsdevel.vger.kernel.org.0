Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6714257AB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 18:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242693AbhJGQUh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 12:20:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43268 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242622AbhJGQUh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 12:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633623523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g2BhWp9ye5wWG2ktl9BRS9ejL5FqZFg78PPEny8VjKw=;
        b=hLmCdAqEvZWZzAQngalY8cNIQJJYQ6eIS37ZFPh70EluAbj2vj4EcAG7g5ppfzLULFtt5k
        ZGtGwIeM9hdFLeJsimRz2lThYDTikIbppX+/pqMJG5vlwYX3Hmqz9krB01kmED4pdyC/tg
        j+j4mSFca7tcKrG7treJSWBktNGN6CY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-jmhxungZPPeZXSOLcNfpSQ-1; Thu, 07 Oct 2021 12:18:41 -0400
X-MC-Unique: jmhxungZPPeZXSOLcNfpSQ-1
Received: by mail-qt1-f200.google.com with SMTP id e5-20020ac84905000000b002a69dc43859so5555720qtq.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Oct 2021 09:18:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g2BhWp9ye5wWG2ktl9BRS9ejL5FqZFg78PPEny8VjKw=;
        b=GmsRUJ6POZlYej6jqXba0TDvheTUPasi98UACE9UqPWYfHmML7PaGEqZG2UkmDR1nr
         XZnZ1hjsWtBnRyPWP5BCIXDXT0jHHSNa/Y82/O5NvGTarMN37FlDVIKLmx4cyBSx8lPT
         VZwA3mnDS0fnx/xhslVsoKrOU3MvJ+FJ/28R+EZH0S5BloNMKKUxIVpJuqHnItaZz9kH
         GrY3vf7FdKffcYB5fUYju9LcyQ9k8snomlmfAwHX4oSYJmHinp9qQIJe7KC/Us13r3CZ
         jsdgvRpWlWEUCR4ZPm0Ip7+JxgTpSmilQxGuCnlE+Q3Xd1eK1zo5oaVsjASmNItYd5Ao
         YfEg==
X-Gm-Message-State: AOAM531D60X4iIUVgl32aMxNCQ8muXKE9mfejnJ3oGDKz19c7sghvbXq
        kzol//GW9IrRjYtWz+dVVDfrHWWfkcTWuRSEDyK2sGKNQxT72bC+UMDKORDVwbsqq1sZ7U8GQRM
        CjV6xoC4UWs4Vhy3cXgJaif4u7g==
X-Received: by 2002:ae9:d604:: with SMTP id r4mr3995156qkk.401.1633623521166;
        Thu, 07 Oct 2021 09:18:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzISNgoyX8ThhELtimobeSv0obTz8WwchRnJ53hCvPdL8MPEoqR1UNazjrmPhIn7tsohgi8HA==
X-Received: by 2002:ae9:d604:: with SMTP id r4mr3995128qkk.401.1633623520953;
        Thu, 07 Oct 2021 09:18:40 -0700 (PDT)
Received: from t490s ([2607:fea8:56a2:9100::bed8])
        by smtp.gmail.com with ESMTPSA id h66sm13982024qkc.5.2021.10.07.09.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 09:18:40 -0700 (PDT)
Date:   Thu, 7 Oct 2021 12:18:39 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>, Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [v3 PATCH 3/5] mm: hwpoison: refactor refcount check handling
Message-ID: <YV8d3ydgMcTkLwrG@t490s>
References: <20210930215311.240774-1-shy828301@gmail.com>
 <20210930215311.240774-4-shy828301@gmail.com>
 <YV4c1dOfctEMnH2s@t490s>
 <CAHbLzkqtaF2iFwg0TmMm_1q+o+-O=CXAAPY2izxL6N=8umX_Cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHbLzkqtaF2iFwg0TmMm_1q+o+-O=CXAAPY2izxL6N=8umX_Cg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 06, 2021 at 07:47:20PM -0700, Yang Shi wrote:
> Yeah, it is intentional. Before this change all me_* handlers did
> check refcount even though it was not necessary, for example,
> me_kernel() and me_unknown().

Would you mind add some explanation into the commit message on what kind of
pages dropped the refcount check, and why they can be dropped, when you respin?
Thanks a lot.

-- 
Peter Xu

