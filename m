Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15FF14551C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Nov 2021 01:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241995AbhKRAi7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Nov 2021 19:38:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36830 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232441AbhKRAi6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Nov 2021 19:38:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637195758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H2M4Gb3cmHoSrafJN3mnHsisz7WttR12tk9W7yfyJiE=;
        b=JTzue36Ckqk+cDK7s/7VC8wb+0XqPnME3bDcbjy9nBjzqBVks91rIyEs1+E54IM12smEpx
        KbLgGvAXelKgqyTiObgR+6DeBTA2bZJl46uUzIUb6u4BOGLtReBFVSogyzthWQb1xUyeaq
        L/XNVszWy/gfrAftep2s+oHFoXJqWfQ=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-FG8QX_2INVGe0r4MbXtuJQ-1; Wed, 17 Nov 2021 19:35:55 -0500
X-MC-Unique: FG8QX_2INVGe0r4MbXtuJQ-1
Received: by mail-pl1-f197.google.com with SMTP id f16-20020a170902ce9000b001436ba39b2bso2039038plg.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Nov 2021 16:35:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H2M4Gb3cmHoSrafJN3mnHsisz7WttR12tk9W7yfyJiE=;
        b=4PZgpVqUpsW0/0Pv82J+RYruPxmiNFxfyXKBAPuD0Kwk7FOcgDeT6sfXydCVmBLUC1
         6au43WMlJe+HaDWQ28PckOCIk5bGnIqMPLA1zX36fzAmXyj7G9H7ln4DUf0x8InW4n9G
         j0JrHhtu092tk2iFcDim2UkyhkPsZ0xalKhvasyuu8MxgkECWkrDLGE7CirbutduJqjl
         h0a8ZIpG8EWRW+s/lG8MkZF0/YxJANi1muY1nP8nVsBMM9lz1rBMnYqZR3lOKmS0bqJG
         AJsmVSzLxRYdd/kkulpMos1TEkrwv1jGWUEoJfQCd0vFIbNEbWfYzMq0OY9F4PErhoF2
         48lQ==
X-Gm-Message-State: AOAM530myDSI1yRtotplgHS7mbKreDLRZWAWuoKReqCP2ef19/k+XbgI
        WFaprdNvN263KW5Fy/LukSBg8x6tV6NbZH3G0z0zYAqoBIMS9s9SOjIigc5gDx5XYKRd2S3FSc4
        742FdiWD5NrfPXlI2mFwLW7z4Fg==
X-Received: by 2002:a17:90b:4c4f:: with SMTP id np15mr5059077pjb.65.1637195754465;
        Wed, 17 Nov 2021 16:35:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzcRORMJpC3aKxfkFfHsfxftNO67uoZZZxJhoO5F4dyLPPoH8H48jpWfr6Egtb1+uLIeGVrBw==
X-Received: by 2002:a17:90b:4c4f:: with SMTP id np15mr5059031pjb.65.1637195754166;
        Wed, 17 Nov 2021 16:35:54 -0800 (PST)
Received: from xz-m1.local ([191.101.132.73])
        by smtp.gmail.com with ESMTPSA id pi17sm7089247pjb.34.2021.11.17.16.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 16:35:53 -0800 (PST)
Date:   Thu, 18 Nov 2021 08:35:46 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Mina Almasry <almasrymina@google.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Paul E . McKenney" <paulmckrcu@fb.com>,
        Yu Zhao <yuzhao@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Florian Schmidt <florian.schmidt@nutanix.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v4] mm: Add PM_HUGE_THP_MAPPING to /proc/pid/pagemap
Message-ID: <YZWf4utHNPhUic7u@xz-m1.local>
References: <20211107235754.1395488-1-almasrymina@google.com>
 <YYtuqsnOSxA44AUX@t490s>
 <CAHS8izP9zJYfqmDouA1otnD-CsQtWJSta0KhOQq81qLSTOHB4Q@mail.gmail.com>
 <YY4bFPkfUhlpUqvo@xz-m1.local>
 <CAHS8izP7_BBH9NGz3XoL2=xVniH6REor=biqDSZ4wR=NaFS-8A@mail.gmail.com>
 <YZMQbiV9JQWd0EM+@xz-m1.local>
 <CAHS8izPwQidVLAEApJ4vnERwwK6iJ8phfedA0d4_NPwumzRFcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHS8izPwQidVLAEApJ4vnERwwK6iJ8phfedA0d4_NPwumzRFcw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 17, 2021 at 11:50:23AM -0800, Mina Almasry wrote:
> Awesome, thanks! PM_THP_MAPPED sounds good to me and I just sent v6
> with these changes.

Sorry I just noticed one paragraph of the new commit message that may need some
amending. I commented in the new version, please have a look.  Thanks,

-- 
Peter Xu

